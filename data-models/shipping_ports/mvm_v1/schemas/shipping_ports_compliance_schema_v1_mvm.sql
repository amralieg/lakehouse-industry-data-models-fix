-- Schema for Domain: compliance | Business: Shipping Ports | Version: v1_mvm
-- Generated on: 2026-05-10 06:53:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `shipping_ports_ecm`.`compliance` COMMENT 'Manages customs clearance, trade documentation, regulatory filings, ISPS security compliance, PSC (Port State Control) inspections, HS Code validation, sanctions screening, import/export controls, and EDI messaging (IFTMIN). Covers customs integration via Port Community System and regulatory reporting to WCO, IMO, and national maritime authorities. SSOT for trade compliance and regulatory adherence.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` (
    `customs_declaration_id` BIGINT COMMENT 'Unique identifier for the customs declaration record. Primary key.',
    `bill_of_lading_id` BIGINT COMMENT 'Reference to the Bill of Lading associated with this customs declaration. Links the declaration to the cargo shipment documentation.',
    `commodity_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.commodity_code. Business justification: Customs declarations must reference masterdata commodity codes to validate tariff rates, license requirements, and prohibited goods flags. Customs officers use commodity_code to determine applicable d',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to compliance.hs_code. Business justification: Every customs declaration must reference a Harmonized System commodity classification code. The hs_code string field should be normalized to FK to the hs_code reference master. This allows joining to ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Customs clearance operations incur processing costs (labor, systems, inspection) allocated to dedicated customs/trade compliance cost centers for operational budgeting and variance analysis in port op',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Country of origin determines duty rates, trade agreement applicability, sanctions screening, and certificate of origin requirements. Master country data provides sanctions_list_flag, trade_agreement_c',
    `customs_broker_id` BIGINT COMMENT 'Foreign key linking to compliance.customs_broker. Business justification: Customs declarations are submitted BY licensed customs brokers. The broker_license_number string field should be normalized to a proper FK relationship. This allows joining to get full broker details ',
    `port_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.port_location. Business justification: Port of discharge determines customs zone, inspection facility assignment, and clearance procedures. Master location data provides customs_zone_code, ISPS security level, and operational status. Repla',
    `call_id` BIGINT COMMENT 'Reference to the vessel call during which this cargo arrived or departed, linking the declaration to the specific vessel visit.',
    `vessel_master_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_master. Business justification: Customs declarations must reference vessel master data by IMO number for sanctions screening, flag state verification, and compliance history tracking. Enables direct access to vessel ownership, class',
    `amendment_reason` STRING COMMENT 'Explanation of why the declaration was amended after initial submission, documenting the nature of the correction or change.',
    `assessment_timestamp` TIMESTAMP COMMENT 'The date and time when customs authorities completed their assessment of the declaration.',
    `cargo_description` STRING COMMENT 'Detailed textual description of the goods being declared, including nature, composition, and characteristics.',
    `charges_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for all duty, tax, and charge amounts.. Valid values are `^[A-Z]{3}$`',
    `clearance_timestamp` TIMESTAMP COMMENT 'The date and time when the customs declaration was officially cleared and the cargo was authorized for release.',
    `consignee_address` STRING COMMENT 'The full postal address of the consignee where the goods will be delivered.',
    `consignee_identifier` STRING COMMENT 'The unique identifier or tax registration number of the consignee.',
    `consignee_name` STRING COMMENT 'The full legal name of the party receiving the goods (importer or buyer).',
    `consignor_address` STRING COMMENT 'The full postal address of the consignor from where the goods originated.',
    `consignor_identifier` STRING COMMENT 'The unique identifier or tax registration number of the consignor.',
    `consignor_name` STRING COMMENT 'The full legal name of the party sending the goods (exporter or seller).',
    `country_of_destination` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code identifying the final destination country for the goods.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this customs declaration record was first created in the system.',
    `customs_regime` STRING COMMENT 'The customs procedure or regime code under which the goods are being declared (e.g., normal clearance, bonded warehouse, free zone, temporary import).',
    `declarant_identifier` STRING COMMENT 'The unique identifier or registration number of the declarant with customs authorities (e.g., customs broker license number, tax ID, or business registration number).',
    `declarant_name` STRING COMMENT 'The full legal name of the person or organization submitting the customs declaration on behalf of the importer or exporter.',
    `declaration_reference_number` STRING COMMENT 'The externally-known unique reference number assigned by customs authorities to this declaration. Also known as customs reference number or declaration number.',
    `declaration_status` STRING COMMENT 'Current lifecycle status of the customs declaration: draft (being prepared), submitted (sent to customs), under_assessment (being reviewed by customs), cleared (approved and released), rejected (not accepted), cancelled (withdrawn), or amended (modified after submission). [ENUM-REF-CANDIDATE: draft|submitted|under_assessment|cleared|rejected|cancelled|amended — 7 candidates stripped; promote to reference product]',
    `declaration_type` STRING COMMENT 'The type of customs declaration indicating the nature of the movement: import (goods entering the country), export (goods leaving the country), transit (goods passing through), re-export (previously imported goods being exported), temporary admission, or inward processing.. Valid values are `import|export|transit|re-export|temporary_admission|inward_processing`',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'The monetary value of the goods as declared by the importer/exporter, used as the basis for calculating customs duties and taxes.',
    `declared_value_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the declared value amount.. Valid values are `^[A-Z]{3}$`',
    `duty_amount` DECIMAL(18,2) COMMENT 'The total amount of customs duty assessed and payable on this declaration.',
    `edi_message_type` STRING COMMENT 'The UN/EDIFACT message type code used for electronic transmission of this declaration (e.g., IFTMIN for instruction message, CUSDEC for customs declaration).. Valid values are `IFTMIN|CUSCAR|CUSDEC|CUSRES|CUSREP`',
    `fal_form_3_compliant` BOOLEAN COMMENT 'Boolean flag indicating whether this declaration meets the requirements of IMO FAL Convention Form 3 (Cargo Declaration) for international maritime reporting.',
    `freight_forwarder_identifier` STRING COMMENT 'The unique identifier or registration number of the freight forwarder.',
    `freight_forwarder_name` STRING COMMENT 'The name of the freight forwarding company handling the logistics and documentation for this shipment.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'The total gross weight of the cargo including packaging, measured in kilograms.',
    `incoterms` STRING COMMENT 'The Incoterms code defining the responsibilities, costs, and risks between buyer and seller for the delivery of goods (e.g., FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this customs declaration record was last modified.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'The net weight of the cargo excluding packaging, measured in kilograms.',
    `package_count` STRING COMMENT 'The total number of packages, containers, or units included in this declaration.',
    `package_type` STRING COMMENT 'The type or description of packaging used for the cargo (e.g., pallets, cartons, drums, containers).',
    `port_of_loading` STRING COMMENT 'The UN/LOCODE five-character code identifying the port where the cargo was loaded onto the vessel.. Valid values are `^[A-Z]{5}$`',
    `psc_inspection_required` BOOLEAN COMMENT 'Boolean flag indicating whether this declaration has been flagged for Port State Control inspection based on risk assessment criteria.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by customs authorities if the declaration was rejected, including error codes and corrective action required.',
    `sanctions_screening_status` STRING COMMENT 'The status of sanctions screening for parties and goods in this declaration: pending (not yet screened), cleared (no sanctions match), flagged (potential match requiring review), or blocked (confirmed sanctions violation).. Valid values are `pending|cleared|flagged|blocked`',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when the customs declaration was officially submitted to the customs authority via the Port Community System (PCS).',
    `total_charges_amount` DECIMAL(18,2) COMMENT 'The total amount payable including all duties, taxes, and other charges assessed on this declaration.',
    `vat_amount` DECIMAL(18,2) COMMENT 'The total amount of Value Added Tax (VAT) or Goods and Services Tax (GST) assessed and payable on this declaration.',
    `wco_message_version` STRING COMMENT 'The version of the WCO Data Model standard used for this declaration message (e.g., WCO Data Model 3.9).',
    CONSTRAINT pk_customs_declaration PRIMARY KEY(`customs_declaration_id`)
) COMMENT 'Core transactional record of import/export customs declarations submitted to national customs authorities via the Port Community System (PCS). Captures declaration type (import/export/transit), declarant details, HS codes, cargo description, declared value, duty amounts, VAT, customs regime, declaration status lifecycle (submitted/assessed/cleared/rejected/cancelled), customs reference number, BOL reference, vessel call reference, port of loading (POL), port of discharge (POD), country of origin, country of destination, incoterms, consignee, consignor, freight forwarder, broker license number, submission timestamp, assessment timestamp, clearance timestamp, and WCO message standard version (WCO Data Model 3.x). SSOT for all customs clearance events processed through the port. Supports IMO FAL Form 3 (Cargo Declaration) reporting obligations.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`compliance`.`hs_code` (
    `hs_code_id` BIGINT COMMENT 'Primary key for hs_code',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: HS codes with duty_rate_percentage and vat_rate_percentage must map to specific GL accounts for automated duty and tax posting in port customs systems. Customs finance controllers use this mapping for',
    `anti_dumping_duty_flag` BOOLEAN COMMENT 'Indicates whether anti-dumping duties are applicable to this commodity to protect domestic industry from unfairly priced imports.',
    `chapter` STRING COMMENT 'The first two digits of the HS code representing the chapter-level classification (e.g., Chapter 01 = Live Animals, Chapter 84 = Machinery). Highest level of HS hierarchy.. Valid values are `^[0-9]{2}$`',
    `cites_flag` BOOLEAN COMMENT 'Indicates whether this commodity is subject to CITES regulations governing international trade in endangered species of wild fauna and flora. True if CITES-controlled, False otherwise.',
    `commodity_description` STRING COMMENT 'Full textual description of the commodity or goods category represented by this HS code. Provides human-readable explanation of what goods fall under this classification.',
    `commodity_description_short` STRING COMMENT 'Abbreviated or short-form description of the commodity for display in space-constrained interfaces and reports.',
    `countervailing_duty_flag` BOOLEAN COMMENT 'Indicates whether countervailing duties are applicable to this commodity to offset foreign government subsidies.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the jurisdiction for which this HS code classification and tariff rates apply (e.g., USA, GBR, SGP, AUS).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this HS code record was first created in the system. Used for audit trail and data lineage tracking.',
    `dual_use_flag` BOOLEAN COMMENT 'Indicates whether this commodity is classified as dual-use goods (items that can be used for both civilian and military purposes), subject to export controls and licensing requirements.',
    `duty_rate_percentage` DECIMAL(18,2) COMMENT 'The standard customs duty rate applied to imports of this commodity, expressed as a percentage of the customs value. Used for duty calculation in customs clearance.',
    `effective_date` DATE COMMENT 'The date from which this HS code classification, duty rates, and associated rules become effective and applicable for customs declarations.',
    `excise_duty_rate_percentage` DECIMAL(18,2) COMMENT 'Additional excise duty rate applicable to specific commodity categories (e.g., alcohol, tobacco, fuel), expressed as a percentage.',
    `expiry_date` DATE COMMENT 'The date on which this HS code classification or associated rules cease to be valid. Null if the code is currently active with no planned expiry.',
    `heading` STRING COMMENT 'The first four digits of the HS code representing the heading-level classification. Provides intermediate granularity between chapter and subheading.. Valid values are `^[0-9]{4}$`',
    `hs_code` STRING COMMENT 'The full HS commodity classification code including 6-digit international standard code plus national extension digits (up to 10 digits total). Used for customs declaration, duty calculation, and trade compliance screening.. Valid values are `^[0-9]{6,10}$`',
    `hs_code_status` STRING COMMENT 'Current lifecycle status of this HS code record. Active = currently in use, Inactive = temporarily disabled, Superseded = replaced by a newer code, Pending = awaiting activation, Deprecated = phased out.. Valid values are `active|inactive|superseded|pending|deprecated`',
    `hs_version` STRING COMMENT 'The version year of the WCO Harmonized System nomenclature that this code is based on (e.g., HS2017, HS2022). The HS is updated every 5 years.. Valid values are `^HS[0-9]{4}$`',
    `imdg_class` STRING COMMENT 'The IMDG hazard class for dangerous goods (e.g., 1 = Explosives, 2.1 = Flammable Gases, 3 = Flammable Liquids, 4.1 = Flammable Solids, 5.1 = Oxidizing Substances, 6.1 = Toxic Substances, 7 = Radioactive Material, 8 = Corrosives, 9 = Miscellaneous). Null if not dangerous goods.. Valid values are `^[1-9](.[1-9])?$`',
    `imdg_dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether this commodity is classified as dangerous goods under the IMDG Code, requiring special handling, stowage, and documentation in maritime transport.',
    `issuing_authority` STRING COMMENT 'The national customs authority or regulatory body that issued and maintains this HS code classification and associated tariff rates (e.g., National Customs Authority, Ministry of Trade).',
    `license_required_flag` BOOLEAN COMMENT 'Indicates whether an import or export license is required for this commodity. True if licensing is mandatory, False if no license needed.',
    `license_type` STRING COMMENT 'The type or category of license required for this commodity (e.g., General License, Specific License, Open General License, Strategic Export License). Null if no license required.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this HS code record was last modified or updated. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Additional notes, clarifications, or special instructions related to the classification, duty calculation, or compliance requirements for this HS code.',
    `origin_certificate_required_flag` BOOLEAN COMMENT 'Indicates whether a certificate of origin is required for customs clearance of this commodity to verify the country of manufacture or production.',
    `phytosanitary_certificate_required_flag` BOOLEAN COMMENT 'Indicates whether a phytosanitary certificate is required for plant and plant product commodities to certify they are free from pests and diseases.',
    `preferential_tariff_flag` BOOLEAN COMMENT 'Indicates whether this commodity is eligible for preferential tariff treatment under free trade agreements or preferential trade arrangements.',
    `prohibited_flag` BOOLEAN COMMENT 'Indicates whether import or export of this commodity is prohibited under national or international law. True if prohibited, False if allowed.',
    `quota_flag` BOOLEAN COMMENT 'Indicates whether this commodity is subject to import or export quotas limiting the quantity that can be traded within a specific period.',
    `restricted_flag` BOOLEAN COMMENT 'Indicates whether import or export of this commodity is subject to restrictions, licensing requirements, or special permits. True if restricted, False if unrestricted.',
    `sanctions_screening_required_flag` BOOLEAN COMMENT 'Indicates whether shipments of this commodity require sanctions screening against restricted parties, countries, or entities (e.g., OFAC, UN, EU sanctions lists).',
    `statistical_suffix` STRING COMMENT 'Additional national statistical suffix digits appended to the 6-digit HS code for more granular trade statistics and reporting purposes. Length varies by country.. Valid values are `^[0-9]{0,4}$`',
    `subheading` STRING COMMENT 'The first six digits of the HS code representing the internationally standardized subheading-level classification. This is the core 6-digit HS code recognized globally.. Valid values are `^[0-9]{6}$`',
    `trade_agreement_code` STRING COMMENT 'Code identifying the applicable free trade agreement or preferential trade arrangement that may provide reduced duty rates for this commodity (e.g., USMCA, CPTPP, EU-FTA).',
    `un_number` STRING COMMENT 'The four-digit UN number assigned to dangerous goods for identification in international transport (e.g., UN1203 for gasoline). Null if not dangerous goods.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'The standard unit of measure used for duty calculation and statistical reporting for this commodity (e.g., KGM for kilograms, LTR for liters, MTR for meters, PCE for pieces).. Valid values are `^[A-Z]{2,3}$`',
    `vat_rate_percentage` DECIMAL(18,2) COMMENT 'The applicable VAT or sales tax rate for this commodity category, expressed as a percentage. Used for tax calculation on imported goods.',
    `veterinary_certificate_required_flag` BOOLEAN COMMENT 'Indicates whether a veterinary health certificate is required for animal and animal product commodities to certify they meet health and safety standards.',
    CONSTRAINT pk_hs_code PRIMARY KEY(`hs_code_id`)
) COMMENT 'Reference master for Harmonized System (HS) commodity classification codes as maintained by the World Customs Organization (WCO). Captures HS code (6-digit international + national extension), commodity description, chapter, heading, subheading, duty rate, VAT rate, prohibited/restricted flag, IMDG dangerous goods flag, CITES flag, dual-use flag, applicable trade controls, effective date, expiry date, and issuing authority. Used for customs declaration validation, duty calculation, and trade compliance screening across all cargo movements.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`compliance`.`trade_document` (
    `trade_document_id` BIGINT COMMENT 'Unique identifier for the trade document record. Primary key.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to cargo.bill_of_lading. Business justification: Trade documents (certificates of origin, inspection certificates, permits) reference bills of lading. Real business process: customs brokers attach trade documents to BoL for clearance; document manag',
    `commodity_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.commodity_code. Business justification: Trade documents must reference masterdata commodity codes to validate license requirements, quarantine conditions, and prohibited goods status. This supports the port community systems document valid',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to compliance.hs_code. Business justification: Trade documents (certificates of origin, phytosanitary certificates, etc.) reference HS commodity codes for classification. The hs_code string field should be normalized to FK to the hs_code reference',
    `container_id` BIGINT COMMENT 'Foreign key linking to cargo.container. Business justification: Trade documents may be container-specific (fumigation certificates, inspection certificates for specific containers). Real business process: document validation at container level for controlled goods',
    `customs_declaration_id` BIGINT COMMENT 'Reference to the customs declaration that this trade document supports. Links the document to the formal customs entry or clearance record.',
    `imdg_class_id` BIGINT COMMENT 'Foreign key linking to masterdata.imdg_class. Business justification: Trade documents for dangerous goods must reference the IMDG class for stowage, segregation, and emergency response validation. Normalizing the plain imdg_class attribute to masterdata.imdg_class ensur',
    `manifest_id` BIGINT COMMENT 'Reference to the cargo manifest that includes this trade document. Links the document to the overall cargo manifest submitted to customs and port authorities.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Trade documents require country of origin for preferential tariff determination, rules of origin verification, and sanctions screening. Normalizing country_of_origin plain attr to masterdata.country s',
    `port_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.port_location. Business justification: Port of discharge on trade documents determines customs clearance facility, quarantine inspection location, and document submission requirements. Master location data provides customs_zone_code and op',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: trade_document has sanctions_screening_date (DATE) and sanctions_screening_status (STRING) — denormalized references to a screening event performed on the trade documents parties or cargo. Normalizin',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment record associated with this trade document. Links the document to the specific cargo shipment moving through the port.',
    `shipping_line_id` BIGINT COMMENT 'Foreign key linking to masterdata.shipping_line. Business justification: Trade documents (bills of lading, certificates of origin) are issued by or on behalf of shipping lines. Linking to shipping_line supports EDI document routing, carrier compliance verification, and AEO',
    `call_id` BIGINT COMMENT 'Reference to the vessel call associated with this trade document. Links the document to the specific vessel voyage and port call for cargo movement tracking.',
    `vessel_master_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_master. Business justification: Trade documents (certificates of origin, phytosanitary certificates, bills of lading) reference vessels by IMO for cargo traceability and chain of custody. Master vessel data provides flag state, clas',
    `acceptance_timestamp` TIMESTAMP COMMENT 'The date and time when this trade document was accepted by the receiving authority (customs, port authority, or terminal operator). Nullable until accepted.',
    `commodity_description` STRING COMMENT 'Textual description of the goods or cargo covered by this trade document. Provides detailed information about the commodity for customs and regulatory purposes.',
    `consignee_name` STRING COMMENT 'The name of the consignee or receiver who will take delivery of the goods. The party responsible for the cargo at destination.',
    `country_of_destination` STRING COMMENT 'The ISO 3166-1 alpha-3 country code representing the final destination country for the goods. Used for export control and trade statistics.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this trade document record was first created in the Port Community System. Audit trail for record creation.',
    `customs_clearance_date` DATE COMMENT 'The date on which customs clearance was granted for the cargo covered by this trade document. Nullable until clearance is obtained.',
    `customs_clearance_status` STRING COMMENT 'The current status of customs clearance for the cargo covered by this trade document. Tracks the document through the customs clearance workflow.. Valid values are `pending|cleared|held|rejected`',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Flag indicating whether this trade document covers dangerous goods cargo subject to IMDG Code regulations (true) or non-hazardous cargo (false).',
    `document_number` STRING COMMENT 'The externally-known unique reference number assigned to this trade document (e.g., BOL number, invoice number, certificate number). This is the business identifier used by customs, shipping lines, and trade parties.',
    `document_status` STRING COMMENT 'Current lifecycle status of the trade document. Tracks the document through its workflow from draft creation through submission, acceptance, rejection, expiration, or cancellation.. Valid values are `draft|submitted|accepted|rejected|expired|cancelled`',
    `document_type` STRING COMMENT 'Classification of the trade document. Indicates the type of shipping or trade document (Bill of Lading, Sea Waybill, Certificate of Origin, Packing List, Commercial Invoice, Phytosanitary Certificate, Fumigation Certificate, Dangerous Goods Declaration, Delivery Order). [ENUM-REF-CANDIDATE: bill_of_lading|sea_waybill|certificate_of_origin|packing_list|commercial_invoice|phytosanitary_certificate|fumigation_certificate|dangerous_goods_declaration|delivery_order — promote to reference product]. Valid values are `bill_of_lading|sea_waybill|certificate_of_origin|packing_list|commercial_invoice|phytosanitary_certificate`',
    `edi_message_type` STRING COMMENT 'The EDIFACT or other EDI message type code used to transmit this document electronically (e.g., IFTMIN for instruction message, COPARN for container pre-announcement, CUSCAR for customs cargo report). Nullable for non-EDI documents.',
    `expiry_date` DATE COMMENT 'The date on which the trade document expires and is no longer valid for customs clearance or cargo release. Nullable for documents without expiration.',
    `file_reference` STRING COMMENT 'The file path, URI, or document management system reference for the electronic or scanned copy of this trade document. Used for document retrieval and audit trail.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'The total gross weight of the cargo covered by this trade document, measured in kilograms. Includes packaging and container tare weight.',
    `is_electronic` BOOLEAN COMMENT 'Flag indicating whether this trade document was submitted electronically (true) or as a paper document (false). Used to track digitalization of trade documentation.',
    `isps_compliance_flag` BOOLEAN COMMENT 'Flag indicating whether this trade document has been verified for ISPS Code security compliance (true) or requires additional security screening (false).',
    `issue_date` DATE COMMENT 'The date on which the trade document was officially issued by the issuing party. This is the principal business event timestamp for the document lifecycle.',
    `issuing_party_code` STRING COMMENT 'The standardized code or identifier for the issuing party (e.g., SCAC code for shipping lines, customs broker license number, chamber of commerce registration number).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this trade document record was last modified in the Port Community System. Audit trail for record updates.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'The net weight of the cargo covered by this trade document, measured in kilograms. Excludes packaging and container tare weight.',
    `notify_party_name` STRING COMMENT 'The name of the party to be notified upon arrival of the cargo. Often the consignee or their customs broker.',
    `package_count` STRING COMMENT 'The total number of packages, cartons, pallets, or handling units covered by this trade document.',
    `package_type` STRING COMMENT 'The type of packaging used for the cargo covered by this trade document (e.g., carton, pallet, crate, drum, bag, bale, roll).. Valid values are `carton|pallet|crate|drum|bag|bale`',
    `port_of_loading` STRING COMMENT 'The UN/LOCODE of the port where the cargo was loaded onto the vessel. Five-character code identifying the origin port.. Valid values are `^[A-Z]{5}$`',
    `rejection_reason` STRING COMMENT 'The reason provided by the receiving authority for rejecting this trade document. Nullable for non-rejected documents.',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when this trade document was submitted to the Port Community System or customs authority for processing.',
    `un_number` STRING COMMENT 'The four-digit UN number identifying the dangerous goods substance (e.g., UN1203 for gasoline). Nullable for non-hazardous cargo.. Valid values are `^UN[0-9]{4}$`',
    `volume_cbm` DECIMAL(18,2) COMMENT 'The total volume of the cargo covered by this trade document, measured in cubic meters (CBM). Used for freight calculation and stowage planning.',
    CONSTRAINT pk_trade_document PRIMARY KEY(`trade_document_id`)
) COMMENT 'Master record for trade and shipping documents associated with cargo movements through the port including Bill of Lading (BOL), Sea Waybill, Certificate of Origin, Packing List, Commercial Invoice, Phytosanitary Certificate, Fumigation Certificate, Dangerous Goods Declaration (IMDG), and Delivery Order. Captures document type, number, issuing party, dates, status lifecycle (draft/submitted/accepted/rejected/expired), vessel call and cargo references, customs declaration linkage, electronic/paper flag, EDI message type, and file reference. SSOT for trade documentation lifecycle managed via Port Community System.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` (
    `sanctions_screening_id` BIGINT COMMENT 'Unique identifier for the sanctions screening record. Primary key.',
    `commodity_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.commodity_code. Business justification: Sanctions screening for dual-use goods, arms, and controlled commodities requires commodity code lookup. Normalizing the plain hs_code attr to masterdata.commodity_code enables automated dual_use_flag',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Sanctions screening operations (software licenses, analyst labor, third-party screening services) are allocated to security/compliance cost centers for operational cost tracking and regulatory complia',
    `flag_state_id` BIGINT COMMENT 'Foreign key linking to masterdata.flag_state. Business justification: Vessel flag state is a primary sanctions risk factor; flag states on FATF grey/black lists or Paris MOU black lists trigger enhanced screening. Normalizing vessel_flag_state plain attr to masterdata.f',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Sanctions screening targets countries directly (OFAC, UN, EU country-level sanctions). Linking to masterdata.country enables automated lookup of sanctions_list_flag, fatf_status, and psc_targeting_fac',
    `shipping_line_id` BIGINT COMMENT 'Foreign key linking to masterdata.shipping_line. Business justification: Shipping lines are screened entities in OFAC, UN, and EU sanctions programs. When screened_entity_type is shipping_line, linking to masterdata.shipping_line enables carrier-level sanctions complianc',
    `security_incident_id` BIGINT COMMENT 'Foreign key linking to security.security_incident. Business justification: Positive sanctions screening matches trigger mandatory security incident creation for investigation and escalation to port authority and national agencies. Required for regulatory compliance and threa',
    `trade_restriction_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_restriction. Business justification: When a sanctions screening produces a match (match_status, matched_list_identifier, matched_list_name fields), it should reference the specific trade_restriction master record that was matched. trade_',
    `call_id` BIGINT COMMENT 'Foreign key reference to the vessel call that triggered this screening check. Null if screening was triggered by cargo or party declaration.',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to vessel.vessel. Business justification: Vessel-level sanctions screening (by IMO number, flag state, ownership) is a distinct regulatory process from call-level screening. Port authorities screen the vessel entity itself for OFAC/UN sanctio',
    `vessel_master_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_master. Business justification: Sanctions screening checks vessels by IMO number against OFAC, EU, and UN lists. Master vessel data provides registered owner, beneficial owner, flag state, and classification society for comprehensiv',
    `analyst_review_status` STRING COMMENT 'Status of manual analyst review for potential or confirmed matches. Tracks human oversight and decision-making in the compliance workflow.. Valid values are `not_required|pending_review|under_review|reviewed|approved|rejected`',
    `authority_reference_number` STRING COMMENT 'Reference or case number assigned by the external authority when the screening result was escalated. Null if no escalation or reference not yet assigned.',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with the cargo or shipment that triggered this screening. Null if screening was not cargo-related.',
    `cargo_description` STRING COMMENT 'Brief description of the cargo or goods associated with this screening check. Applicable when screening was triggered by cargo declaration.',
    `company_country_of_registration` STRING COMMENT 'Three-letter ISO country code where the company is legally registered. Applicable for company-type entities.. Valid values are `^[A-Z]{3}$`',
    `company_registration_number` STRING COMMENT 'Official business registration or tax identification number of the company being screened. Applicable when screened_entity_type is company, freight_forwarder, cargo_owner, consignee, shipper, or agent.',
    `country_of_destination` STRING COMMENT 'Three-letter ISO country code of the cargos final destination. Used for export control and sanctions compliance screening.. Valid values are `^[A-Z]{3}$`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code of the cargos country of origin. Used for sanctions screening and trade compliance risk assessment.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this sanctions screening record was first created in the database. Supports audit trails and data lineage.',
    `escalated_to_authority` STRING COMMENT 'Name of the external authority or regulatory body to which the screening result was escalated (e.g., national customs, port state control, OFAC). Null if no external escalation.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the screening result was escalated to senior compliance officers or external authorities. Null if no escalation occurred.',
    `individual_nationality` STRING COMMENT 'Three-letter ISO country code of the individuals nationality. Applicable only when screened_entity_type is individual.. Valid values are `^[A-Z]{3}$`',
    `individual_passport_number` STRING COMMENT 'Passport number of the individual being screened. Applicable only when screened_entity_type is individual.',
    `is_high_risk_cargo` BOOLEAN COMMENT 'Boolean flag indicating whether the cargo is classified as high-risk based on HS code, origin, or other risk factors. Drives enhanced screening protocols.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this sanctions screening record was last updated. Tracks changes throughout the screening lifecycle.',
    `match_score` DECIMAL(18,2) COMMENT 'Numerical confidence score (0.00 to 100.00) indicating the likelihood that the screened entity matches a sanctions list entry. Higher scores indicate stronger matches requiring analyst review.',
    `match_status` STRING COMMENT 'Result of the screening check indicating whether the entity matched any sanctions list entries. Drives compliance decision-making and escalation workflows.. Valid values are `clear|potential_match|confirmed_match|false_positive`',
    `matched_list_entry` STRING COMMENT 'Full text of the sanctions list entry that matched the screened entity, including name, aliases, and identifiers. Null if no match found.',
    `matched_list_identifier` STRING COMMENT 'Unique identifier or reference number of the matched entry within the sanctions list (e.g., OFAC UID, UN Reference Number). Null if no match.',
    `matched_list_name` STRING COMMENT 'Name of the specific sanctions list where the match was found (e.g., OFAC SDN, UN 1267, EU Consolidated). Null if no match.',
    `resolution_action` STRING COMMENT 'Final action taken based on the screening result. Documents compliance decision and operational response.. Valid values are `cleared|blocked|escalated_to_authorities|further_investigation|false_positive_confirmed`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the screening check was resolved and final action taken. Null if still pending resolution.',
    `reviewing_officer_name` STRING COMMENT 'Full name of the compliance officer or analyst who reviewed and resolved the screening check. Null if automated clearance or pending review.',
    `risk_level` STRING COMMENT 'Overall risk classification assigned to this screening result based on match score, entity type, and business context. Drives escalation and approval workflows.. Valid values are `low|medium|high|critical`',
    `sanctions_list_update_date` DATE COMMENT 'Date when the sanctions lists used for this screening were last updated. Ensures screening was performed against current regulatory data.',
    `screened_entity_type` STRING COMMENT 'Classification of the entity being screened. Determines which screening protocols and risk thresholds apply. [ENUM-REF-CANDIDATE: vessel|company|individual|freight_forwarder|cargo_owner|consignee|shipper|agent|other — 9 candidates stripped; promote to reference product]',
    `screening_lists_checked` STRING COMMENT 'Comma-separated list of sanctions and restricted party lists checked during this screening (e.g., OFAC SDN, UN Consolidated, EU Consolidated, national lists). Ensures comprehensive coverage of applicable regulatory lists.',
    `screening_notes` STRING COMMENT 'Free-text notes and comments added by compliance analysts during review and resolution. Documents decision rationale and supporting evidence.',
    `screening_reference_number` STRING COMMENT 'Business-facing unique reference number for the sanctions screening check, used for audit trails and compliance reporting.. Valid values are `^SCR-[0-9]{10}$`',
    `screening_status` STRING COMMENT 'Current lifecycle status of the sanctions screening check. Tracks progression from initiation through resolution. [ENUM-REF-CANDIDATE: pending|in_progress|clear|potential_match|confirmed_match|false_positive|escalated — 7 candidates stripped; promote to reference product]',
    `screening_system_name` STRING COMMENT 'Name or identifier of the automated sanctions screening system or service that performed the check (e.g., Dow Jones Risk & Compliance, Refinitiv World-Check, internal PCS module).',
    `screening_system_version` STRING COMMENT 'Version number of the screening system or sanctions list database used at the time of screening. Critical for audit trails and compliance verification.',
    `screening_timestamp` TIMESTAMP COMMENT 'Date and time when the sanctions screening check was initiated. Critical for compliance audit trails and regulatory reporting.',
    `screening_trigger_event` STRING COMMENT 'Business event or process that initiated this sanctions screening check. Supports root cause analysis and process optimization. [ENUM-REF-CANDIDATE: vessel_arrival|cargo_declaration|booking_request|gate_entry|customs_clearance|manual_check|periodic_review — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_sanctions_screening PRIMARY KEY(`sanctions_screening_id`)
) COMMENT 'Transactional record of sanctions and restricted party screening checks performed against vessels, cargo owners, consignees, shippers, freight forwarders, and other trade parties. Captures screened entity name, entity type (vessel/company/individual), screening date and time, screening list(s) checked (OFAC SDN, UN Consolidated, EU Consolidated, national lists), match status (clear/potential_match/confirmed_match/false_positive), match score, matched list entry, analyst review status, resolution action, resolution timestamp, reviewing officer, and associated customs declaration or vessel call reference. Mandatory for ISPS and trade compliance obligations.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` (
    `isps_facility_record_id` BIGINT COMMENT 'Unique identifier for the ISPS facility security record. Primary key for the ISPS facility compliance tracking system.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: ISPS facility security operations (PFSO staff, security equipment maintenance, training, audits) have dedicated security cost centers for tracking operational security expenditure against budgets in p',
    `vessel_master_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_master. Business justification: ISPS Declaration of Security (DOS) is executed between a specific vessel and port facility. The dos_vessel_imo_number plain attr identifies the vessel; normalizing to vessel_master_id enables DOS vali',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: ISPS Port Facility Security Plan (PFSP) implementation and security infrastructure upgrades are funded via internal orders. Port finance and security managers track pfsp_approval_date-driven CAPEX aga',
    `port_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.port_location. Business justification: ISPS facility security records are location-specific (berths, terminals, gates). Master location data enables security level coordination across facilities, PFSO assignment by zone, and Declaration of',
    `alert_affected_zone` STRING COMMENT 'Specific area or zone within the port facility affected by the security alert, such as berth number, cargo yard, gate, or perimeter section.',
    `alert_escalation_chain` STRING COMMENT 'Record of the escalation path followed for the security alert, listing the sequence of personnel and authorities notified (PFSO, CSO, port authority, national maritime security center, law enforcement).',
    `alert_issued_timestamp` TIMESTAMP COMMENT 'Date and time when the security alert was officially issued and communicated to facility security personnel and relevant stakeholders.',
    `alert_resolution_details` STRING COMMENT 'Comprehensive description of how the security alert was resolved, including investigation findings, corrective actions taken, and lessons learned for future prevention.',
    `alert_resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the security alert was resolved, threat neutralized, or incident closed, and normal security posture was restored.',
    `alert_response_actions` STRING COMMENT 'Detailed description of the security response actions taken in response to the alert, including personnel deployment, access restrictions, enhanced surveillance, or coordination with law enforcement.',
    `alert_severity` STRING COMMENT 'Assessed severity level of the security alert indicating the degree of threat and urgency of response required: low, medium, high, or critical.. Valid values are `low|medium|high|critical`',
    `alert_source` STRING COMMENT 'Origin or reporting entity of the security alert: national maritime security center, port state control, vessel, facility surveillance system, or external intelligence agency.',
    `alert_type` STRING COMMENT 'Classification of the security alert based on the nature of the threat or incident: security threat, suspicious activity, unauthorized access, cyber incident, vessel security alert system activation, or terrorism threat.. Valid values are `security_threat|suspicious_activity|unauthorized_access|cyber_incident|vessel_security_alert|terrorism_threat`',
    `compliance_status` STRING COMMENT 'Overall ISPS Code compliance status of the port facility: fully compliant (all requirements met), conditionally compliant (minor issues with action plan), non-compliant (major violations), or under review (pending inspection or corrective action verification).. Valid values are `fully_compliant|conditionally_compliant|non_compliant|under_review`',
    `cso_contact_email` STRING COMMENT 'Official email address of the Company Security Officer for security policy communication and corporate security reporting.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `cso_contact_phone` STRING COMMENT 'Primary contact phone number for the Company Security Officer for escalation and corporate-level security coordination.',
    `cso_name` STRING COMMENT 'Name of the Company Security Officer designated by the port operating company to coordinate security matters at the corporate level and liaise with facility-level security officers.',
    `current_security_level` STRING COMMENT 'Current MARSEC security level in effect at the port facility. Level 1 = normal operations, Level 2 = heightened risk, Level 3 = exceptional risk requiring special security measures.',
    `dos_activities_covered` STRING COMMENT 'Detailed description of the security-sensitive activities covered under the Declaration of Security agreement, such as cargo operations, bunkering, passenger embarkation, or ship-to-ship transfers.',
    `dos_port_signed_timestamp` TIMESTAMP COMMENT 'Date and time when the port facility representative signed the Declaration of Security, establishing the facilitys commitment to the security agreement.',
    `dos_port_signing_officer` STRING COMMENT 'Name of the authorized port facility representative (typically the PFSO or deputy) who signed the Declaration of Security on behalf of the facility.',
    `dos_reference_number` STRING COMMENT 'Unique reference number for the most recent Declaration of Security agreement between the port facility and a vessel. Format: DOS- followed by alphanumeric identifier.. Valid values are `^DOS-[A-Z0-9]{8,16}$`',
    `dos_ship_signed_timestamp` TIMESTAMP COMMENT 'Date and time when the vessel representative signed the Declaration of Security, completing the bilateral security agreement.',
    `dos_ship_signing_officer` STRING COMMENT 'Name of the authorized vessel representative (typically the Ship Security Officer or Master) who signed the Declaration of Security on behalf of the vessel.',
    `dos_type` STRING COMMENT 'Classification of the Declaration of Security based on the parties involved: ship-to-port (vessel and facility), ship-to-ship (two vessels at facility), or port-to-port (interfacility transfer).. Valid values are `ship_to_port|ship_to_ship|port_to_port`',
    `dos_valid_from` TIMESTAMP COMMENT 'Date and time when the Declaration of Security becomes effective and security coordination measures are activated.',
    `dos_valid_until` TIMESTAMP COMMENT 'Date and time when the Declaration of Security expires or when the covered activities are completed and security coordination is no longer required.',
    `facility_type` STRING COMMENT 'Classification of the port facility based on primary cargo handling operations and terminal specialization under ISPS jurisdiction.. Valid values are `container_terminal|bulk_cargo_terminal|ro_ro_terminal|passenger_terminal|oil_gas_terminal|general_cargo_terminal`',
    `isps_reference_number` STRING COMMENT 'Unique ISPS Code compliance reference number issued by the national maritime authority for this port facility. Format: country code (3 letters) followed by alphanumeric facility identifier.. Valid values are `^[A-Z]{3}-[A-Z0-9]{6,12}$`',
    `last_psc_inspection_date` DATE COMMENT 'Date of the most recent Port State Control inspection of the facilitys ISPS Code compliance, conducted by the national maritime authority or designated inspection body.',
    `last_psc_inspection_result` STRING COMMENT 'Outcome of the most recent PSC inspection: compliant (no issues), deficiency noted (minor issues requiring correction), major non-conformity (serious violations), or detention (operations suspended).. Valid values are `compliant|deficiency_noted|major_non_conformity|detention`',
    `national_authority_contact` STRING COMMENT 'Primary contact phone number or communication channel for the national maritime authority for ISPS compliance reporting, incident notification, and regulatory coordination.',
    `national_authority_name` STRING COMMENT 'Name of the national maritime authority or designated government agency responsible for ISPS Code enforcement and facility security oversight in the ports jurisdiction.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next mandatory ISPS Code compliance audit or Port Facility Security Plan review by the national maritime authority or recognized security organization.',
    `pfso_certification_expiry_date` DATE COMMENT 'Expiration date of the PFSO certification, after which recertification or renewal training is required to maintain ISPS compliance.',
    `pfso_certification_number` STRING COMMENT 'Official certification or license number issued to the PFSO by the national maritime authority or approved training institution, validating their qualification under ISPS Code requirements.',
    `pfso_contact_email` STRING COMMENT 'Official email address of the Port Facility Security Officer for security notifications, DoS documentation, and regulatory correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `pfso_contact_phone` STRING COMMENT 'Primary 24/7 contact phone number for the Port Facility Security Officer for emergency security coordination and Declaration of Security communications.',
    `pfsp_approval_date` DATE COMMENT 'Date on which the current Port Facility Security Plan was officially approved by the national maritime authority or designated security organization.',
    `pfsp_expiry_date` DATE COMMENT 'Date on which the current Port Facility Security Plan expires and requires renewal or revalidation by the competent authority.',
    `pfsp_version` STRING COMMENT 'Current approved version number of the Port Facility Security Plan as mandated by ISPS Code. Format: v[major].[minor] (e.g., v2.1).. Valid values are `^vd+.d+$`',
    `psc_deficiency_count` STRING COMMENT 'Total number of ISPS Code deficiencies identified during the most recent PSC inspection that require corrective action and follow-up verification.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this ISPS facility record was first created in the port security management system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this ISPS facility record was most recently updated, reflecting changes to security status, personnel, or compliance information.',
    `security_alert_reference` STRING COMMENT 'Unique reference number for the most recent security alert or threat notification issued for this facility. Format: ALERT- followed by alphanumeric identifier.. Valid values are `^ALERT-[A-Z0-9]{8,16}$`',
    `security_level_effective_date` TIMESTAMP COMMENT 'Date and time when the current MARSEC security level was activated at the facility. Critical for Declaration of Security (DoS) coordination and incident timeline reconstruction.',
    CONSTRAINT pk_isps_facility_record PRIMARY KEY(`isps_facility_record_id`)
) COMMENT 'Comprehensive ISPS Code compliance product for port facilities encompassing facility security master data, Declarations of Security (DoS) with vessels, security alerts, threat notifications, and incident records at full operational granularity. Facility master captures facility name, type, ISPS reference number, approved Port Facility Security Plan (PFSP) version and approval date, current security level (1/2/3), PFSO name and contact details, CSO coordination records, and audit history. DoS records capture DoS reference number, vessel IMO number, DoS type (ship-to-port/ship-to-ship), activities covered, validity periods, signing officers (ship and port side), and signing timestamps. Security alert records capture alert reference, type (security_threat/suspicious_activity/unauthorized_access/cyber_incident/vessel_security_alert), source, severity, affected zone, response actions, escalation chain, and resolution details. SSOT for all ISPS security compliance at the port facility level including DoS lifecycle management, security incident response, MARSEC level changes, and national maritime security centre reporting.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` (
    `import_export_permit_id` BIGINT COMMENT 'Unique identifier for the import/export permit record. Primary key for the permit entity.',
    `commodity_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.commodity_code. Business justification: Permits authorize specific commodities by HS code. Master commodity data provides IMDG classification, UN number, handling method, and storage requirements for permit validation, cargo acceptance, and',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to compliance.hs_code. Business justification: Import/export permits are issued for specific commodity codes (controlled goods, restricted items). The hs_code string field should be normalized to FK to the hs_code reference master. This allows joi',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Import/export permit application fees and processing costs must be allocated to cost centres for port authority revenue and cost tracking. Compliance managers and port finance controllers need permit ',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Permit origin country determines license requirements, dual-use controls, and CITES applicability. Master country data provides sanctions_list_flag, WCO membership, and trade agreement codes for autom',
    `trade_restriction_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_restriction. Business justification: Import/export permits are issued in response to active trade restrictions (embargoes, sanctions, import controls). This FK links permits to the specific restriction regime they address, enabling valid',
    `application_date` DATE COMMENT 'The date on which the permit application was submitted to the issuing authority. Used for processing time tracking and audit purposes.',
    `bill_of_lading_reference` STRING COMMENT 'Reference number of the Bill of Lading associated with the cargo movement covered by this permit. Links the permit to the specific shipment documentation.',
    `commodity_description` STRING COMMENT 'Detailed textual description of the goods covered by this permit. Includes product name, specifications, and any relevant characteristics required for regulatory classification.',
    `conditions_restrictions` STRING COMMENT 'Free-text field capturing any special conditions, restrictions, or requirements attached to the permit. May include usage limitations, handling requirements, inspection mandates, or reporting obligations.',
    `controlled_goods_flag` BOOLEAN COMMENT 'Boolean indicator of whether the goods covered by this permit are subject to strategic trade controls, dual-use export restrictions, or other special regulatory oversight. True indicates controlled goods requiring enhanced compliance procedures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was first created in the system. Used for audit trails and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the authorized value. Examples include USD (US Dollar), EUR (Euro), GBP (British Pound).. Valid values are `^[A-Z]{3}$`',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the final destination country for the goods. Used for export control compliance and trade statistics.. Valid values are `^[A-Z]{3}$`',
    `edi_message_reference` STRING COMMENT 'Reference identifier for the EDI message (IFTMIN, COPARN, or other UN/EDIFACT message) transmitted via the Port Community System (PCS) that communicated this permit information to customs and trade partners.',
    `end_use_statement` STRING COMMENT 'Declaration of the intended end use of the imported or exported goods. Required for certain controlled commodities to ensure compliance with export control regulations and prevent diversion to unauthorized uses.',
    `end_user_name` STRING COMMENT 'Name of the ultimate consignee or end user of the goods. May differ from the permit holder if the permit holder is an intermediary or freight forwarder.',
    `inspection_completion_date` DATE COMMENT 'The date on which the required inspection was completed. Nullable if inspection is not required or has not yet been performed.',
    `inspection_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether physical inspection of the goods is mandated as a condition of the permit. True indicates that Port State Control (PSC) or customs inspection must be completed before cargo release.',
    `inspection_result` STRING COMMENT 'Outcome of the physical inspection. Passed indicates compliance with permit conditions; failed indicates non-compliance requiring corrective action; conditional release indicates partial compliance with restrictions.. Valid values are `passed|failed|conditional_release|pending`',
    `issue_date` DATE COMMENT 'The date on which the permit was officially issued by the regulatory authority. Marks the transition from applied to issued status.',
    `issuing_authority` STRING COMMENT 'Name of the government agency, regulatory body, or customs authority that issued the permit. Examples include national customs agencies, agricultural departments, environmental protection agencies, or trade control authorities.',
    `issuing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction that issued the permit. Used for cross-border trade compliance and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was last updated. Used for change tracking and data quality monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or internal notes related to the permit. Used by port operations and compliance staff for case management and knowledge sharing.',
    `pcs_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the Port Community System when the permit data was exchanged with customs authorities and other stakeholders. Used for message tracking and reconciliation.',
    `permit_holder_identifier` STRING COMMENT 'Official business registration number, tax identification number, or customs trader identifier for the permit holder. Used for regulatory cross-referencing and compliance verification.',
    `permit_number` STRING COMMENT 'The official permit or license number issued by the regulatory authority. This is the externally-known unique identifier used in customs declarations and trade documentation.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the permit. Tracks the permit from application through issuance, active use, expiration, or revocation. Critical for compliance validation and operational decision-making. [ENUM-REF-CANDIDATE: applied|issued|active|expired|revoked|suspended|cancelled — 7 candidates stripped; promote to reference product]',
    `permit_type` STRING COMMENT 'Classification of the permit based on the nature of the authorization. Distinguishes between import permits, export licenses, re-export certificates, CITES (Convention on International Trade in Endangered Species) permits, dual-use export licenses, strategic goods permits, phytosanitary import permits, and quarantine clearances. [ENUM-REF-CANDIDATE: import_permit|export_license|re_export_certificate|cites_permit|dual_use_export_license|strategic_goods_permit|phytosanitary_permit|quarantine_clearance — 8 candidates stripped; promote to reference product]',
    `quantity_authorized` DECIMAL(18,2) COMMENT 'The maximum quantity of goods authorized for import or export under this permit. Measured in the unit specified in the quantity_unit field.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the authorized quantity. Examples include kilograms (KG), metric tons (MT), pieces (PCE), liters (LTR), cubic meters (CBM), or Twenty-foot Equivalent Units (TEU) for containerized cargo.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number for any regulatory filings or reports submitted to WCO, IMO, or national maritime authorities in connection with this permit. Used for compliance audit trails.',
    `revocation_date` DATE COMMENT 'The date on which the permit was revoked by the issuing authority. Nullable for permits that have not been revoked. Revocation may occur due to non-compliance, false declarations, or changes in regulatory requirements.',
    `revocation_reason` STRING COMMENT 'Explanation provided by the issuing authority for revoking the permit. Captures the regulatory or compliance basis for the revocation action.',
    `validity_end_date` DATE COMMENT 'The date on which the permit expires and can no longer be used for import or export transactions. Nullable for permits with indefinite validity subject to other conditions.',
    `validity_start_date` DATE COMMENT 'The date from which the permit becomes valid and can be used for import or export transactions. Permits cannot be used before this date.',
    `value_authorized` DECIMAL(18,2) COMMENT 'The maximum monetary value of goods authorized for import or export under this permit, expressed in the currency specified in the currency_code field.',
    CONSTRAINT pk_import_export_permit PRIMARY KEY(`import_export_permit_id`)
) COMMENT 'Master record for import and export permits, licenses, and authorizations issued or required for controlled cargo movements through the port. Covers import permits, export licenses, re-export certificates, CITES permits, dual-use export licenses, strategic goods permits, phytosanitary import permits, and quarantine clearances. Captures permit number, permit type, issuing authority, permit holder (company/individual), commodity description, HS code, quantity authorized, value authorized, country of origin, country of destination, validity period (start/end), permit status (applied/issued/active/expired/revoked/suspended), conditions/restrictions, and associated customs declaration reference.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` (
    `customs_hold_id` BIGINT COMMENT 'Unique identifier for the customs hold record. Primary key.',
    `accrual_id` BIGINT COMMENT 'Foreign key linking to finance.accrual. Business justification: Active customs holds with demurrage/detention flags generate cost accruals before invoicing. Port finance teams accrue demurrage liabilities against specific holds during month-end close; this link en',
    `commodity_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.commodity_code. Business justification: Customs holds are placed on specific commodity types (dangerous goods, controlled substances, prohibited items). Linking to masterdata.commodity_code enables hold reason analysis by commodity category',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to compliance.hs_code. Business justification: Customs holds may be placed due to issues with specific commodity codes (prohibited goods, restricted items, incorrect classification). The hs_code string field should be normalized to FK to the hs_co',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Customs hold inspection operations (physical examination, x-ray scanning, laboratory testing, officer time) are allocated to customs inspection cost centers for operational cost tracking and resource ',
    `customs_broker_id` BIGINT COMMENT 'Foreign key linking to compliance.customs_broker. Business justification: customs_hold.customs_broker_name (STRING) is a denormalized reference to the broker managing the held cargo. Normalizing this to customs_broker_id FK → compliance.customs_broker.customs_broker_id link',
    `customs_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.customs_declaration. Business justification: Customs holds are placed ON customs declarations (cargo detained for examination, documentation issues, sanctions screening). The customs_declaration_reference string field should be normalized to a p',
    `call_id` BIGINT COMMENT 'Foreign key linking to vessel.call. Business justification: Customs holds are placed on cargo during a specific port call, directly impacting berth scheduling, vessel departure clearance, and demurrage calculations. Port operations teams need to identify which',
    `port_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.port_location. Business justification: Customs holds specify inspection locations (examination sheds, container yards, berths). Master location data provides operational status, equipment availability, and customs zone for resource allocat',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: A customs hold is frequently placed as a direct result of a sanctions screening match. customs_hold.sanctions_screening_result (STRING) is a denormalized reference to the screening outcome. Replacing ',
    `security_incident_id` BIGINT COMMENT 'Foreign key linking to security.security_incident. Business justification: Customs holds placed due to security concerns (watchlist matches, suspicious cargo) must reference the security incident for coordinated response between customs and port security teams. Critical for ',
    `shipping_line_id` BIGINT COMMENT 'Foreign key linking to masterdata.shipping_line. Business justification: Customs holds trigger demurrage and detention charges billed to the shipping line, and require carrier notification under port community system workflows. Linking to masterdata.shipping_line supports ',
    `zone_id` BIGINT COMMENT 'Foreign key linking to security.zone. Business justification: Customs holds are physically executed in designated terminal security zones (examination bays, restricted cargo areas). Port operations and security teams coordinate physical access control for held c',
    `actual_delay_duration_hours` DECIMAL(18,2) COMMENT 'Actual duration in hours between hold placement and release. Calculated from hold_placement_timestamp and hold_release_timestamp. Null if hold is still active.',
    `bol_reference_number` STRING COMMENT 'Reference number of the Bill of Lading associated with the cargo under customs hold. Links the hold to the shipping documentation.',
    `cargo_description` STRING COMMENT 'Brief description of the cargo or goods subject to the customs hold. Provides context for the hold and aids in operational coordination.',
    `container_number` STRING COMMENT 'ISO 6346 standard container identification number for the container subject to the customs hold. Format: 4 letters (owner code) + 7 digits (serial number + check digit).. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this customs hold record was first created in the system. Used for audit trail and data lineage.',
    `demurrage_applicable_flag` BOOLEAN COMMENT 'Indicates whether demurrage charges will apply due to the customs hold delay. True if demurrage is applicable; False otherwise. Used for billing and dispute management.',
    `detention_applicable_flag` BOOLEAN COMMENT 'Indicates whether detention charges will apply due to the customs hold delay. True if detention is applicable; False otherwise. Used for billing and dispute management.',
    `edi_message_reference` STRING COMMENT 'Reference number of the EDI message (e.g., IFTMIN instruction message) sent to communicate the customs hold status to Port Community System or stakeholders.',
    `estimated_delay_duration_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that the customs hold will delay cargo release. Used for terminal operations planning and customer communication. Null if duration cannot be estimated.',
    `examination_findings` STRING COMMENT 'Detailed findings from physical examination, scanning, or laboratory testing conducted during the hold. May include discrepancies found, contraband detected, or compliance issues identified.',
    `hold_placement_timestamp` TIMESTAMP COMMENT 'Date and time when the customs hold was officially placed on the cargo or container. Critical for calculating delay duration and demurrage impact.',
    `hold_reason_code` STRING COMMENT 'Standardized code indicating the reason for the customs hold (e.g., random inspection, high-risk cargo, documentation discrepancy, sanctions screening hit, ISPS security concern).. Valid values are `^[A-Z0-9]{2,10}$`',
    `hold_reason_description` STRING COMMENT 'Detailed textual description of why the customs hold was placed. Provides context beyond the standardized hold_reason_code.',
    `hold_reference_number` STRING COMMENT 'Externally-known unique reference number assigned by customs authority to this hold. Used for tracking and communication with customs agencies.. Valid values are `^[A-Z0-9]{8,20}$`',
    `hold_release_timestamp` TIMESTAMP COMMENT 'Date and time when the customs hold was officially released or cleared. Null if hold is still active. Used to calculate total hold duration.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the customs hold. Active indicates hold is in effect; released indicates hold has been cleared; escalated indicates hold requires higher authority review; cancelled indicates hold was withdrawn; expired indicates hold lapsed without resolution.. Valid values are `active|released|escalated|cancelled|expired`',
    `hold_type` STRING COMMENT 'Classification of the customs hold indicating the nature of the examination or detention required. Documentary holds require paperwork review; physical examination requires container inspection; scanning requires X-ray or similar; laboratory requires sample testing; quarantine requires isolation; sanctions require compliance verification.. Valid values are `documentary|physical_examination|scanning|laboratory|quarantine|sanctions`',
    `importer_exporter_name` STRING COMMENT 'Name of the importer or exporter associated with the cargo under customs hold. Used for stakeholder communication and compliance tracking.',
    `inspection_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the physical inspection or examination was completed. Null if inspection has not been completed.',
    `inspection_scheduled_timestamp` TIMESTAMP COMMENT 'Date and time when the physical inspection or examination is scheduled to occur. Null if no inspection is scheduled or required.',
    `isps_security_level` STRING COMMENT 'ISPS security level in effect at the time the hold was placed. Level 1 is normal; Level 2 is heightened; Level 3 is exceptional. Influences hold processing procedures.. Valid values are `level_1|level_2|level_3`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this customs hold record was last updated. Used for audit trail and change tracking.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether notification of the customs hold has been sent to the cargo owner, shipping line, or freight forwarder. True if notification sent; False otherwise.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when notification of the customs hold was sent to relevant stakeholders. Null if notification has not been sent.',
    `placed_by_authority` STRING COMMENT 'Name of the customs authority or agency that placed the hold (e.g., U.S. Customs and Border Protection, Port State Control, National Maritime Safety Authority).',
    `priority_level` STRING COMMENT 'Priority classification assigned to the hold indicating urgency of resolution. Urgent holds require immediate attention; high priority holds impact critical cargo; medium and low priority follow standard processing.. Valid values are `low|medium|high|urgent`',
    `psc_inspection_flag` BOOLEAN COMMENT 'Indicates whether the customs hold is related to a Port State Control inspection. True if PSC-related; False otherwise.',
    `release_reason` STRING COMMENT 'Explanation or justification provided by customs for releasing the hold. May include reference to documentation provided, inspection results, or clearance conditions met.',
    `seizure_flag` BOOLEAN COMMENT 'Indicates whether the hold resulted in seizure of cargo or container by customs authorities. True if cargo was seized; False otherwise.',
    `seizure_reference_number` STRING COMMENT 'Official reference number assigned to the seizure case if cargo was confiscated. Null if no seizure occurred. Links to customs enforcement case management systems.',
    CONSTRAINT pk_customs_hold PRIMARY KEY(`customs_hold_id`)
) COMMENT 'Transactional record of customs holds, detentions, and examinations placed on cargo or containers by customs authorities. Captures hold reference number, hold type (documentary/physical_examination/scanning/laboratory/quarantine/sanctions), hold status (active/released/escalated), placed by authority, hold placement timestamp, hold release timestamp, release officer, release reason, examination findings, seizure flag, seizure reference, associated container number, BOL reference, customs declaration reference, and estimated delay duration (hours). Critical for terminal operations coordination and cargo release management.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`compliance`.`violation` (
    `violation_id` BIGINT COMMENT 'Primary key for violation',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.audit. Business justification: Compliance violations are often detected during audits (PSC inspections, facility audits, process audits). This FK links violations to the audit that identified them, enabling tracking of audit effect',
    `hs_code_id` BIGINT COMMENT 'Foreign key linking to compliance.hs_code. Business justification: Compliance violations may be related to specific commodity codes (prohibited goods, incorrect classification, restricted items declared without permits). The hs_code string field should be normalized ',
    `marpol_record_id` BIGINT COMMENT 'Foreign key linking to compliance.marpol_record. Business justification: Compliance violations can be detected from MARPOL records (emissions violations, illegal waste discharge, ballast water management non-compliance). This FK links violations to the specific MARPOL oper',
    `container_visit_id` BIGINT COMMENT 'Foreign key linking to terminal.container_visit. Business justification: Regulatory violations (IMDG misdeclaration, weight discrepancy, seal tampering) are raised against specific container visits at the terminal. violation already has customs_declaration_id but violation',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Compliance violation investigation, remediation, and penalty management costs are allocated to regulatory compliance cost centers for tracking enforcement-related expenditure and compliance program ef',
    `customs_declaration_id` BIGINT COMMENT 'Foreign key linking to compliance.customs_declaration. Business justification: Violations can be detected during customs processing — e.g., misdeclaration of goods, incorrect HS codes, undervaluation. Linking violation.customs_declaration_id → compliance.customs_declaration.cust',
    `customs_hold_id` BIGINT COMMENT 'Foreign key linking to compliance.customs_hold. Business justification: A violation is often detected during or as a result of a customs hold examination (examination_findings in customs_hold). Linking violation.customs_hold_id → compliance.customs_hold.customs_hold_id al',
    `flag_state_id` BIGINT COMMENT 'Foreign key linking to masterdata.flag_state. Business justification: Violations are reported to flag state administrations and aggregated for Paris MOU/Tokyo MOU flag state performance lists. Linking to masterdata.flag_state enables automated flag authority notificatio',
    `imdg_class_id` BIGINT COMMENT 'Foreign key linking to masterdata.imdg_class. Business justification: Dangerous goods violations reference IMDG class for penalty determination and corrective action requirements. Normalizing the plain imdg_class attr to masterdata.imdg_class enables IMDG-class-level vi',
    `import_export_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.import_export_permit. Business justification: A violation can represent a breach of import/export permit conditions — e.g., exceeding authorized quantities, trading in controlled goods without a valid permit, or permit expiry violations. Linking ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Violations requiring corrective actions (corrective_action_required, corrective_action_deadline) are funded via internal orders for CAPEX/OPEX tracking. Port operations finance needs this link to trac',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Violation penalties require journal entries for penalty revenue recognition and financial reporting. Port finance controllers post penalty charges (penalty_amount, penalty_reference) to the GL via jou',
    `marsec_level_change_id` BIGINT COMMENT 'Foreign key linking to security.marsec_level_change. Business justification: Violations of ISPS security measures (e.g., failure to implement MARSEC 2 access controls) must reference the active MARSEC level change at time of violation. Enforcement authorities and PSC inspector',
    `call_id` BIGINT COMMENT 'Foreign key linking to vessel.call. Business justification: Violations detected during a port call (PSC deficiencies, customs infractions, MARPOL breaches) must be linked to the specific call for port call performance reporting, regulatory authority notificati',
    `port_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.port_location. Business justification: Violations occur at specific facilities (berths, terminals, anchorages). Master location data enables zone-based enforcement, facility-specific corrective actions, and environmental compliance reporti',
    `security_incident_id` BIGINT COMMENT 'Foreign key linking to security.security_incident. Business justification: Compliance violations (ISPS breaches, security plan failures, unauthorized access) are recorded as security incidents for investigation and corrective action tracking. Essential for integrated complia',
    `shipping_line_id` BIGINT COMMENT 'Foreign key linking to masterdata.shipping_line. Business justification: Violations are issued against shipping lines as the responsible operator for vessel and cargo compliance. Linking to masterdata.shipping_line supports carrier compliance scorecards, PSC targeting fact',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to vessel.vessel. Business justification: Compliance violations (MARPOL breaches, SOLAS deficiencies, customs infractions) are recorded against specific vessels for risk profiling, detention decisions, and flag state notifications. PSC author',
    `vessel_master_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_master. Business justification: Compliance violations (MARPOL, SOLAS, ISPS) are recorded against vessels by IMO. Master vessel data provides compliance history, flag state authority contact, classification society, and P&I club for ',
    `zone_id` BIGINT COMMENT 'Foreign key linking to security.zone. Business justification: Compliance violations (ISPS breaches, unauthorized access, restricted cargo infractions) occur in specific security zones. Port security compliance officers filing violation reports must record the zo',
    `berth_code` STRING COMMENT 'Code identifying the berth or terminal location where the violation occurred, if applicable.',
    `case_closure_timestamp` TIMESTAMP COMMENT 'Date and time when the violation case was officially closed after all corrective actions and penalties were resolved.',
    `case_status` STRING COMMENT 'Overall lifecycle status of the violation case from detection through closure.. Valid values are `open|under_investigation|pending_remediation|closed|escalated`',
    `corrective_action_completion_date` DATE COMMENT 'Actual date when the corrective action was completed and verified.',
    `corrective_action_deadline` DATE COMMENT 'Date by which the corrective action must be completed to achieve compliance and avoid further penalties.',
    `corrective_action_required` STRING COMMENT 'Description of the corrective action, remediation, or compliance measure required to resolve the violation.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action implementation and completion.. Valid values are `pending|in_progress|completed|overdue|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this violation record was first created in the system.',
    `detected_by_officer` STRING COMMENT 'Name or identifier of the compliance officer, inspector, or authority who detected the violation.',
    `detected_by_system` STRING COMMENT 'Name of the automated system or screening tool that flagged the violation (e.g., PCS Sanctions Screening, TOS Gate Alert, VTMS Compliance Monitor).',
    `detection_method` STRING COMMENT 'Method by which the violation was identified (e.g., physical inspection, automated screening, system alert, audit finding).. Valid values are `inspection|audit|screening|system_alert|self_reported|third_party`',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the violation was first detected or identified. Principal business event timestamp for this violation record.',
    `edi_message_reference` STRING COMMENT 'Unique reference number of the EDI message sent regarding this violation.',
    `edi_message_type` STRING COMMENT 'Type of EDI message used to communicate the violation to external systems or authorities (e.g., IFTMIN for instruction messages).',
    `escalation_level` STRING COMMENT 'Level to which the violation case has been escalated for resolution or decision-making.. Valid values are `none|management|executive|regulatory_authority`',
    `inspector_notes` STRING COMMENT 'Internal notes and observations recorded by the inspector or compliance officer during the violation investigation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this violation record was last updated or modified.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty or fine amount assessed for the violation.',
    `penalty_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount.. Valid values are `^[A-Z]{3}$`',
    `penalty_payment_status` STRING COMMENT 'Current payment status of the assessed penalty.. Valid values are `unpaid|paid|waived|disputed|partially_paid`',
    `penalty_reference` STRING COMMENT 'Reference number or identifier for the penalty assessment or fine issued by the regulatory authority.',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this violation is a repeat occurrence for the same entity or party.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the violation for tracking and reporting purposes. Format: VIO-YYYYMMDD-XXX.. Valid values are `^VIO-[0-9]{8}-[A-Z]{3}$`',
    `regulatory_framework` STRING COMMENT 'Specific regulatory framework or convention that was breached (e.g., ISPS Code, SOLAS Chapter XI-2, MARPOL Annex VI, WCO SAFE Framework, national customs act).',
    `reporting_authority` STRING COMMENT 'Name of the regulatory authority or governing body to which the violation was reported (e.g., national customs, IMO, port state control authority).',
    `reporting_timestamp` TIMESTAMP COMMENT 'Date and time when the violation was formally reported to the regulatory authority.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assigned to the violation based on severity, frequency, and potential impact on port operations and security.',
    `severity_level` STRING COMMENT 'Severity classification of the violation indicating the level of risk and urgency for remediation.. Valid values are `minor|major|critical`',
    `supporting_document_reference` STRING COMMENT 'Reference identifier for supporting documentation, evidence, or attachments related to the violation (e.g., inspection reports, photos, certificates).',
    `violation_description` STRING COMMENT 'Detailed narrative description of the violation, including specific non-conformance details, circumstances, and evidence observed.',
    `violation_type` STRING COMMENT 'Category of compliance violation detected. Classifies the violation by regulatory domain.. Valid values are `customs|isps_security|psc_inspection|imdg|marpol|trade_control`',
    CONSTRAINT pk_violation PRIMARY KEY(`violation_id`)
) COMMENT 'Record of identified compliance violations, breaches, and non-conformances detected across all regulatory domains including customs, ISPS, PSC, IMDG, MARPOL, and trade controls. Captures violation reference number, violation type, regulatory framework breached, severity level (minor/major/critical), detection method (inspection/audit/screening/system_alert), detection timestamp, detected by (officer/system), associated entity type (vessel/cargo/facility/party), associated entity reference, violation description, corrective action required, corrective action deadline, corrective action status, penalty amount, penalty currency, penalty reference, and case closure timestamp. Enables enterprise-wide compliance risk management.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` (
    `marpol_record_id` BIGINT COMMENT 'Primary key for marpol_record',
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_audit. Business justification: MARPOL compliance records are reviewed and verified during compliance audits (compliance_audit covers environmental and MARPOL regulatory frameworks). marpol_record.psc_inspection_reference (STRING) r',
    `bunker_operation_id` BIGINT COMMENT 'Foreign key linking to vessel.bunker_operation. Business justification: Bunkering operations must be recorded in the Oil Record Book under MARPOL Annex I. Each bunker delivery note (BDN) generates a mandatory MARPOL record entry. Linking marpol_record to bunker_operation ',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: MARPOL environmental compliance operations (waste reception facilities, ballast water management, emissions monitoring, environmental officer staff) are allocated to environmental compliance cost cent',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: MARPOL records for port reception facilities reference specific fixed assets (waste reception equipment, ballast water treatment systems with IMO approval numbers). Environmental compliance officers a',
    `flag_state_id` BIGINT COMMENT 'Foreign key linking to masterdata.flag_state. Business justification: MARPOL records require flag state authority endorsement (port_authority_endorsement_flag attr). Flag state administrations receive MARPOL compliance notifications and conduct flag state inspections. L',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: MARPOL waste disposal and ballast water treatment operations incur costs funded via internal orders. Port environmental managers track disposal_contractor costs and reception facility operations again',
    `call_id` BIGINT COMMENT 'Foreign key linking to vessel.call. Business justification: MARPOL waste reception, bunker delivery recording, and ballast water operations occur during specific port calls. Port authorities associate MARPOL records with the port call for reception facility bi',
    `port_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.port_location. Business justification: Waste reception operations occur at specific berths and terminals. Master location data identifies reception facility operators, waste handling capabilities, and MARPOL annex coverage for facility ass',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to vessel.vessel. Business justification: MARPOL compliance records (oil record book, ballast water management, garbage records) are vessel-specific regulatory obligations under MARPOL 73/78. PSC inspectors and flag state auditors retrieve al',
    `vessel_master_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_master. Business justification: MARPOL waste operations are vessel-specific. Master vessel data provides EEDI/EEXI values, MARPOL annex compliance status, classification society, and ballast water management system type for verifica',
    `ballast_water_discharge_location` STRING COMMENT 'Geographic location (port name or coordinates) where the ballast water was discharged, required for BWM Convention compliance.',
    `ballast_water_exchange_location_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate (decimal degrees) where ballast water exchange was performed, typically at least 200 nautical miles from shore.',
    `ballast_water_exchange_location_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate (decimal degrees) where ballast water exchange was performed, typically at least 200 nautical miles from shore.',
    `ballast_water_management_method` STRING COMMENT 'Method used to manage ballast water: exchange (mid-ocean exchange), treatment (onboard treatment system), or retention (ballast water retained onboard without discharge).. Valid values are `exchange|treatment|retention`',
    `ballast_water_source_location` STRING COMMENT 'Geographic location (port name or coordinates) where the ballast water was originally taken onboard, required for BWM Convention compliance.',
    `ballast_water_treatment_system_imo_approval` STRING COMMENT 'IMO type approval number for the ballast water treatment system, certifying compliance with IMO standards.',
    `ballast_water_treatment_system_type` STRING COMMENT 'Type or model of the ballast water treatment system installed onboard (e.g., UV treatment, electrolysis, filtration), if applicable.',
    `cii_rating` STRING COMMENT 'Carbon Intensity Indicator (CII) rating for the vessel (A, B, C, D, or E), measuring operational carbon efficiency under MARPOL Annex VI.. Valid values are `A|B|C|D|E`',
    `compliance_status` STRING COMMENT 'Current compliance status of this MARPOL record: compliant (meets all requirements), non-compliant (violation detected), under review (being assessed), or pending verification (awaiting port authority endorsement).. Valid values are `compliant|non-compliant|under review|pending verification`',
    `corrective_action_completion_date` DATE COMMENT 'Target or actual date by which corrective actions must be or were completed to achieve MARPOL compliance.',
    `corrective_action_required` STRING COMMENT 'Description of corrective actions required to address non-compliance or deficiencies identified in this MARPOL record.',
    `disposal_certificate_reference` STRING COMMENT 'Reference number of the disposal certificate or waste treatment certificate issued by the disposal contractor confirming proper waste handling.',
    `disposal_contractor` STRING COMMENT 'Name of the licensed waste disposal contractor responsible for final disposal or treatment of the waste.',
    `disposal_method` STRING COMMENT 'Method by which the received waste was disposed of or processed: incineration, landfill, recycling, treatment, reuse, or export to another facility.. Valid values are `incineration|landfill|recycling|treatment|reuse|export`',
    `eedi_value` DECIMAL(18,2) COMMENT 'Energy Efficiency Design Index (EEDI) value for the vessel, measuring CO2 emissions per ton-mile, required for new ships under MARPOL Annex VI.',
    `eexi_value` DECIMAL(18,2) COMMENT 'Energy Efficiency Existing Ship Index (EEXI) value for the vessel, measuring technical energy efficiency for existing ships under MARPOL Annex VI.',
    `marpol_annex` STRING COMMENT 'The specific MARPOL annex or BWM Convention under which this compliance record is filed. Annex I: oil pollution; Annex II: noxious liquid substances; Annex IV: sewage; Annex V: garbage; Annex VI: air emissions; BWM Convention: ballast water management.. Valid values are `Annex I|Annex II|Annex IV|Annex V|Annex VI|BWM Convention`',
    `non_compliance_reason` STRING COMMENT 'Detailed explanation of the reason for non-compliance, if applicable, including specific MARPOL regulation violated and nature of the violation.',
    `nox_emissions_mt` DECIMAL(18,2) COMMENT 'Quantity of nitrogen oxides (NOx) emitted in metric tons during the reporting period, applicable to MARPOL Annex VI air emissions compliance.',
    `operation_location_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate (decimal degrees) where the MARPOL operation occurred, required for at-sea discharges and ballast water exchange.',
    `operation_location_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate (decimal degrees) where the MARPOL operation occurred, required for at-sea discharges and ballast water exchange.',
    `operation_timestamp` TIMESTAMP COMMENT 'Date and time when the MARPOL operation (discharge, reception, treatment, exchange) was performed, recorded in ISO 8601 format.',
    `operation_type` STRING COMMENT 'The type of operation recorded: discharge (waste released to sea or port facility), reception (waste received by port facility), transfer (waste moved between vessels or facilities), treatment (ballast water treatment), exchange (ballast water exchange at sea), retention (waste retained onboard).. Valid values are `discharge|reception|transfer|treatment|exchange|retention`',
    `particulate_matter_emissions_mt` DECIMAL(18,2) COMMENT 'Quantity of particulate matter (PM) emitted in metric tons during the reporting period, applicable to MARPOL Annex VI air emissions compliance.',
    `port_authority_endorsement_flag` BOOLEAN COMMENT 'Indicates whether the port authority has endorsed or verified this MARPOL record (True) or not (False).',
    `port_authority_endorsement_timestamp` TIMESTAMP COMMENT 'Date and time when the port authority endorsed or verified the MARPOL record, recorded in ISO 8601 format.',
    `port_authority_inspector_name` STRING COMMENT 'Name of the port authority inspector who endorsed or verified the MARPOL record.',
    `port_of_operation` STRING COMMENT 'Name or UN/LOCODE of the port where the waste reception or discharge operation took place, if applicable.',
    `psc_inspection_reference` STRING COMMENT 'Reference number of the associated Port State Control (PSC) inspection during which this MARPOL record was reviewed or a deficiency was identified.',
    `quantity_mass_mt` DECIMAL(18,2) COMMENT 'Mass of waste in metric tons (MT) involved in this operation, applicable to solid waste and sludge.',
    `quantity_volume_m3` DECIMAL(18,2) COMMENT 'Volume of waste or ballast water in cubic meters (m³) involved in this operation.',
    `reception_facility_operator` STRING COMMENT 'Name of the port waste reception facility operator or contractor that received the waste from the vessel.',
    `record_book_entry_number` STRING COMMENT 'Sequential entry number from the vessels Oil Record Book (ORB), Garbage Record Book (GRB), or Ballast Water Record Book (BWRB) corresponding to this operation.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this MARPOL compliance record was first created in the system, recorded in ISO 8601 format.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this MARPOL compliance record was last updated in the system, recorded in ISO 8601 format.',
    `remarks` STRING COMMENT 'Additional remarks, notes, or observations related to this MARPOL operation or compliance record, including special circumstances or clarifications.',
    `responsible_officer_rank` STRING COMMENT 'Rank or position of the responsible officer (e.g., Master, Chief Engineer, Chief Officer) who signed off on the MARPOL operation.',
    `responsible_officer_signature_timestamp` TIMESTAMP COMMENT 'Date and time when the responsible officer signed the MARPOL record book entry or waste manifest, recorded in ISO 8601 format.',
    `sox_emissions_mt` DECIMAL(18,2) COMMENT 'Quantity of sulfur oxides (SOx) emitted in metric tons during the reporting period, applicable to MARPOL Annex VI air emissions compliance.',
    `waste_manifest_number` STRING COMMENT 'Unique reference number of the waste manifest or transfer document issued by the reception facility upon waste receipt.',
    `waste_type` STRING COMMENT 'Detailed classification of the waste or substance: oily bilge water, sludge, noxious liquid substance cargo residue, sewage, plastics, food waste, domestic waste, cooking oil, incinerator ash, operational waste, cargo residue, ballast water, SOx emissions, NOx emissions, particulate matter, or other MARPOL-regulated material.',
    CONSTRAINT pk_marpol_record PRIMARY KEY(`marpol_record_id`)
) COMMENT 'Comprehensive MARPOL (Marine Pollution Convention) compliance record for vessels and port reception facilities, covering all six MARPOL Annexes and the BWM Convention at full operational granularity. Annex I: oil record book entries and oily bilge water/sludge reception. Annex II: noxious liquid substance cargo residue records. Annex IV: sewage discharge records. Annex V: garbage management plans and garbage record book entries. Annex VI: air emissions (SOx, NOx, PM), EEDI/EEXI compliance, and CII ratings. BWM Convention: ballast water management method (exchange/treatment/retention), treatment system type and IMO type approval number, ballast water volume, source coordinates, exchange/treatment location, discharge details, and compliance status. Port waste reception: waste type, quantity received (m³/MT), reception facility operator, reception timestamp, waste manifest number, disposal method, disposal contractor, disposal certificate reference, and port authority endorsement. Captures vessel IMO number, operation type, quantities, officer signatures, port authority endorsement, compliance status, and associated PSC inspection reference. SSOT for all MARPOL, BWM Convention, and port waste reception compliance documentation at the port.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` (
    `trade_restriction_id` BIGINT COMMENT 'Unique identifier for the trade restriction record. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Trade restrictions target specific countries (sanctions, embargoes, tariffs). Master country data provides sanctions_list_flag, effective dates, MOU membership, and flag state performance for automate',
    `commodity_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.commodity_code. Business justification: Restrictions apply to HS code ranges (dual-use goods, strategic materials, CITES). Master commodity data provides detailed classification, IMDG class, UN number, and handling requirements for automate',
    `affected_party_identifier` STRING COMMENT 'Unique identifier for the affected party such as IMO number for vessels, tax ID for companies, or passport number for individuals.',
    `affected_party_name` STRING COMMENT 'Name of the specific vessel, company, individual, or entity subject to the trade restriction.',
    `affected_party_type` STRING COMMENT 'Classification of the party type subject to the restriction, indicating whether it applies to vessels, companies, individuals, or other entities.. Valid values are `vessel|company|individual|entity|government|organization`',
    `affected_territory` STRING COMMENT 'Specific territory, region, or administrative area within a country that is subject to the restriction, if applicable.',
    `commodity_description` STRING COMMENT 'Textual description of the goods, products, or commodities subject to the trade restriction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the trade restriction record was first created in the lakehouse silver layer.',
    `declaration_required_flag` BOOLEAN COMMENT 'Indicates whether a formal customs declaration or compliance statement is required for goods or parties subject to this restriction.',
    `derogation_available_flag` BOOLEAN COMMENT 'Indicates whether exemptions or derogations from the restriction can be granted under specific conditions.',
    `derogation_conditions` STRING COMMENT 'Detailed conditions, criteria, and procedures under which an exemption or derogation from the restriction may be granted.',
    `edi_message_type` STRING COMMENT 'EDI message type code used for electronic communication of restriction information, such as IFTMIN (Instruction Message for Transport).',
    `effective_date` DATE COMMENT 'Date when the trade restriction becomes legally binding and enforceable.',
    `enforcement_level` STRING COMMENT 'Classification of the enforcement rigor and compliance obligation associated with the restriction.. Valid values are `mandatory|advisory|conditional|discretionary`',
    `expiry_date` DATE COMMENT 'Date when the trade restriction ceases to be enforceable. Null indicates an indefinite restriction.',
    `hs_code_from` STRING COMMENT 'Starting Harmonized System code defining the lower bound of the commodity range affected by the restriction.. Valid values are `^[0-9]{6,10}$`',
    `hs_code_to` STRING COMMENT 'Ending Harmonized System code defining the upper bound of the commodity range affected by the restriction.. Valid values are `^[0-9]{6,10}$`',
    `issuing_authority_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction where the issuing authority is based.. Valid values are `^[A-Z]{3}$`',
    `issuing_authority_name` STRING COMMENT 'Name of the government agency, international body, or regulatory authority that issued the trade restriction.',
    `last_review_date` DATE COMMENT 'Date when the trade restriction was last reviewed or updated by the issuing authority or compliance team.',
    `legal_basis` STRING COMMENT 'Reference to the legal instrument, resolution, regulation, act, or treaty that establishes the authority for the trade restriction.',
    `legal_reference_number` STRING COMMENT 'Official citation or reference number of the legal instrument establishing the restriction.',
    `license_requirement_type` STRING COMMENT 'Type of trade license or permit required to conduct transactions involving goods or parties subject to this restriction.. Valid values are `export_license|import_license|transit_license|dual_use_license|none`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or reassessment of the trade restriction.',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether stakeholders must be formally notified when this restriction is triggered or applied.',
    `penalty_description` STRING COMMENT 'Description of penalties, fines, or sanctions applicable for violations of the trade restriction.',
    `publication_date` DATE COMMENT 'Date when the trade restriction was officially published or announced by the issuing authority.',
    `remarks` STRING COMMENT 'Additional notes, comments, or contextual information regarding the trade restriction.',
    `restriction_authority` STRING COMMENT 'The governing body or jurisdiction that issued and enforces the trade restriction. [ENUM-REF-CANDIDATE: UN|EU|OFAC|national|IMO|bilateral|multilateral — 7 candidates stripped; promote to reference product]',
    `restriction_code` STRING COMMENT 'Unique business identifier code for the trade restriction, used for external reference and system integration.. Valid values are `^[A-Z0-9]{6,20}$`',
    `restriction_description` STRING COMMENT 'Detailed narrative description of the trade restriction including scope, conditions, and enforcement requirements.',
    `restriction_scope` STRING COMMENT 'Defines the trade flow direction and activities covered by the restriction.. Valid values are `import|export|transit|transshipment|all_trade`',
    `restriction_status` STRING COMMENT 'Current lifecycle status of the trade restriction indicating its enforceability and operational state.. Valid values are `active|suspended|expired|pending|revoked|under_review`',
    `restriction_type` STRING COMMENT 'Classification of the trade restriction mechanism applied to control or prohibit trade activities.. Valid values are `embargo|sanction|quota|prohibition|license_requirement|tariff_restriction`',
    `screening_required_flag` BOOLEAN COMMENT 'Indicates whether automated sanctions screening is required for transactions potentially affected by this restriction.',
    `source_reference_code` STRING COMMENT 'Unique identifier of the trade restriction record in the source operational system.',
    `source_system` STRING COMMENT 'Name of the operational system or data source from which the trade restriction record was ingested, typically the Port Community System (PCS) customs integration module.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the trade restriction record was last modified in the lakehouse silver layer.',
    CONSTRAINT pk_trade_restriction PRIMARY KEY(`trade_restriction_id`)
) COMMENT 'Reference master for active trade restrictions, embargoes, sanctions regimes, and import/export controls applicable to the ports trade lanes. Captures restriction type (embargo/sanction/quota/prohibition/license_requirement), restriction authority (UN/EU/OFAC/national), affected country or territory, affected commodity (HS code range), affected party type (vessel/company/individual), restriction description, effective date, expiry date, legal basis (resolution/regulation/act), derogation available flag, derogation conditions, and last review date. Used by sanctions screening and customs declaration validation processes to enforce applicable trade controls.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` (
    `customs_broker_id` BIGINT COMMENT 'Unique identifier for the customs broker record. Primary key.',
    `edi_partner_id` BIGINT COMMENT 'Unique identifier assigned to the broker for submitting EDI messages (IFTMIN, COPARN, BAPLIE) through the Port Community System.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Customs broker AEO certificates are issued by specific country customs authorities; AEO mutual recognition agreements (MRAs) between countries determine reciprocal benefits. Normalizing issuing_countr',
    `port_community_participant_id` BIGINT COMMENT 'Foreign key linking to customer.port_community_participant. Business justification: Customs brokers are port community participants with specific accreditation. This FK enables linking customs broker records to participant master data for contact information, sanctions screening, and',
    `port_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.port_location. Business justification: Customs brokers are authorized to operate at specific port locations (authorized_ports plain attr). Linking to masterdata.port_location supports port community system access control, broker authorizat',
    `aeo_audit_findings_summary` STRING COMMENT 'Summary of key findings, observations, and corrective actions from the most recent AEO compliance audit.',
    `aeo_benefits_applied` STRING COMMENT 'Description of specific customs simplifications and benefits the broker is entitled to under their AEO certification (e.g., reduced inspections, priority processing, deferred duty payment).',
    `aeo_certificate_number` STRING COMMENT 'Unique certificate number issued by the customs authority for the brokers AEO certification.',
    `aeo_certified_flag` BOOLEAN COMMENT 'Indicator of whether the broker holds at least one active AEO certification under the WCO SAFE Framework.',
    `aeo_country_of_issue` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction that issued the AEO certificate.. Valid values are `^[A-Z]{3}$`',
    `aeo_expiry_date` DATE COMMENT 'Date on which the AEO certificate expires and requires renewal or revalidation.',
    `aeo_issue_date` DATE COMMENT 'Date on which the AEO certificate was originally issued to the broker.',
    `aeo_issuing_authority` STRING COMMENT 'Name of the customs authority that issued the AEO certificate to the broker.',
    `aeo_last_audit_date` DATE COMMENT 'Date of the most recent compliance audit conducted by the customs authority to validate the brokers AEO status.',
    `aeo_mra_applicable` STRING COMMENT 'Comma-separated list of country codes or trade blocs with which the brokers AEO certificate has mutual recognition, enabling simplified customs procedures in those jurisdictions.',
    `aeo_next_audit_due_date` DATE COMMENT 'Scheduled date for the next compliance audit required to maintain the brokers AEO certification.',
    `aeo_status` STRING COMMENT 'Current operational status of the AEO certificate indicating whether the broker retains AEO benefits and privileges.. Valid values are `active|suspended|revoked|expired|not_applicable`',
    `aeo_type` STRING COMMENT 'Classification of the AEO certification: AEO-C (Customs Simplification), AEO-S (Security and Safety), AEO-F (Full - both customs and security).. Valid values are `AEO-C|AEO-S|AEO-F|not_applicable`',
    `authorized_ports` STRING COMMENT 'Comma-separated list of port codes or names where the broker is authorized to submit customs declarations and operate.',
    `bond_expiry_date` DATE COMMENT 'Expiration date of the customs bond or insurance policy, after which the broker must renew to maintain authorization.',
    `bond_insurance_reference` STRING COMMENT 'Reference number of the customs bond or insurance policy held by the broker to guarantee payment of duties and compliance with customs regulations.',
    `business_address_line1` STRING COMMENT 'Primary street address line of the customs brokerage firms registered office or operational headquarters.',
    `business_address_line2` STRING COMMENT 'Secondary address line for suite, floor, or building details of the brokerage firms registered office.',
    `business_city` STRING COMMENT 'City or municipality where the customs brokerage firms registered office is located.',
    `compliance_rating` STRING COMMENT 'Performance rating assigned by port or customs authorities based on the brokers compliance history, accuracy of declarations, and adherence to regulations.. Valid values are `excellent|good|satisfactory|needs_improvement|poor|not_rated`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this customs broker record was first created in the system.',
    `deactivation_date` DATE COMMENT 'Date on which the brokers authorization to operate at the port was suspended, revoked, or voluntarily terminated.',
    `deactivation_reason` STRING COMMENT 'Explanation or justification for the suspension, revocation, or termination of the brokers authorization to operate at the port.',
    `declarations_rejected_count` STRING COMMENT 'Total number of customs declarations submitted by the broker that were rejected or returned by customs authorities for errors or non-compliance.',
    `issuing_authority` STRING COMMENT 'Name of the government agency or customs authority that issued the broker license.',
    `last_declaration_date` DATE COMMENT 'Date of the most recent customs declaration submitted by the broker through the port.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this customs broker record was most recently updated or modified.',
    `license_expiry_date` DATE COMMENT 'Date on which the customs broker license expires and requires renewal to maintain authorization.',
    `license_issue_date` DATE COMMENT 'Date on which the customs broker license was originally issued by the authority.',
    `license_number` STRING COMMENT 'Official license or registration number issued by the national customs authority authorizing the broker to submit customs declarations.',
    `license_renewal_date` DATE COMMENT 'Most recent date on which the broker license was renewed or revalidated by the issuing authority.',
    `license_status` STRING COMMENT 'Current operational status of the customs broker license indicating whether the broker is authorized to submit declarations.. Valid values are `active|suspended|revoked|expired|pending_renewal|inactive`',
    `license_type` STRING COMMENT 'Classification of the broker license indicating the scope of authorized customs and trade activities.. Valid values are `customs_broker|freight_forwarder|combined|nvocc|customs_agent|trade_intermediary`',
    `notes` STRING COMMENT 'Free-text field for additional remarks, special conditions, operational notes, or historical context related to the brokers registration and performance.',
    `pcs_registration_reference` STRING COMMENT 'Registration or enrollment reference number assigned by the Port Community System for the brokers access and transaction tracking.',
    `registration_date` DATE COMMENT 'Date on which the broker was first registered in the ports customs broker registry and authorized to operate.',
    `sanctions_screening_date` DATE COMMENT 'Date on which the broker was last screened against international sanctions and denied party lists.',
    `sanctions_screening_status` STRING COMMENT 'Result of the most recent screening of the broker against international sanctions lists (OFAC, UN, EU) and denied party lists.. Valid values are `cleared|flagged|under_review|blocked|not_screened`',
    `total_declarations_submitted` STRING COMMENT 'Cumulative count of customs declarations submitted by the broker through the port since registration.',
    CONSTRAINT pk_customs_broker PRIMARY KEY(`customs_broker_id`)
) COMMENT 'Master record for licensed customs brokers and freight forwarders authorized to submit customs declarations through the port. Captures broker company name, license number and type, issuing authority, license validity period, license status (active/suspended/revoked/expired), authorized ports of operation, primary contact details, EDI sender ID, PCS registration reference, compliance rating, and performance metrics. Includes full Authorized Economic Operator (AEO) certification details at individual certificate granularity: AEO type (AEO-C customs simplification/AEO-S security and safety/AEO-F full), certificate number, issuing customs authority, country of issue, issue date, expiry date, certificate status (active/suspended/revoked/expired), mutual recognition agreements (MRA) applicable, last audit date, next audit due date, audit findings summary, and AEO benefits applied. SSOT for authorized customs intermediary registry and AEO certification within the port community. Supports WCO SAFE Framework AEO programme administration.';

CREATE OR REPLACE TABLE `shipping_ports_ecm`.`compliance`.`audit` (
    `audit_id` BIGINT COMMENT 'Unique identifier for the compliance audit record. Primary key for the audit entity.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Compliance audit costs (external auditor fees, internal audit staff, certification body charges, audit preparation) are allocated to quality/compliance cost centers for audit program budget tracking a',
    `facility_security_plan_id` BIGINT COMMENT 'Foreign key linking to security.facility_security_plan. Business justification: ISPS compliance audits are conducted against a specific version of the Facility Security Plan. Maritime auditors and flag state inspectors must reference the exact FSP version audited; this link suppo',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Port equipment compliance audits (crane safety, terminal tractor inspections, mooring equipment) are conducted against specific fixed assets. Asset managers and compliance officers need audit-to-asset',
    `flag_state_id` BIGINT COMMENT 'Foreign key linking to masterdata.flag_state. Business justification: Flag state administrations conduct and receive statutory audits (ISM Code, ISPS, STCW). Linking to masterdata.flag_state identifies the flag administration as auditing_body or audit recipient, support',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Specific audit and certification projects (ISO 28000 certification, AEO authorization, ISPS facility approval) are tracked as internal orders for project cost accumulation, budget control, and certifi',
    `isps_facility_record_id` BIGINT COMMENT 'Foreign key linking to compliance.isps_facility_record. Business justification: Compliance audits are conducted on ISPS-compliant port facilities (security audits, PFSP reviews, DoS validations). The facility_audited string field should be normalized to a proper FK to the isps_fa',
    `port_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.port_location. Business justification: Facility audits (ISPS, ISO, environmental) are location-specific. Master location data provides operational parameters, certification requirements, and facility type for audit scope definition, resour',
    `shipping_line_id` BIGINT COMMENT 'Foreign key linking to masterdata.shipping_line. Business justification: Compliance audits (ISM Code, AEO, ISPS) are conducted on shipping lines as the Document of Compliance holder. Linking to masterdata.shipping_line enables carrier-level audit history tracking, AEO cert',
    `terminal_id` BIGINT COMMENT 'Foreign key linking to terminal.terminal. Business justification: Compliance audits (ISPS, ISO 28000, customs bonded area, AEO) are conducted against specific terminal facilities. compliance_audit has port_location_id but no terminal_id, leaving the audited entity u',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to vessel.vessel. Business justification: ISM Code, ISPS Code, MLC 2006, and flag state audits are conducted on specific vessels. Classification societies and flag state administrations track audit history per vessel for certificate renewal a',
    `vessel_master_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_master. Business justification: PSC inspections, ISM audits, and ISPS verifications target specific vessels. Master vessel data provides compliance history, classification society, flag state authority, and previous deficiency count',
    `vessel_type_id` BIGINT COMMENT 'Foreign key linking to masterdata.vessel_type. Business justification: Compliance audits are scoped by vessel type (tanker audits under MARPOL Annex I, container ship ISM audits). Linking to masterdata.vessel_type enables audit scheduling by vessel category, supports SOL',
    `audit_scope` STRING COMMENT 'Primary regulatory framework or compliance domain being audited. ISPS (International Ship and Port Facility Security) covers security compliance, MARPOL (Marine Pollution Convention) covers environmental pollution prevention, customs covers trade and clearance processes, OHS (Occupational Health and Safety) covers workforce safety, environmental covers ISO 14001 and emissions, trade_compliance covers import/export controls and sanctions screening.. Valid values are `ISPS|MARPOL|customs|OHS|environmental|trade_compliance`',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit. Scheduled indicates audit is planned but not started, in_progress indicates audit fieldwork is underway, fieldwork_complete indicates on-site work is done but report is pending, report_draft indicates preliminary findings are documented, report_final indicates audit report is issued, closed indicates all corrective actions are verified, cancelled indicates audit was terminated before completion. [ENUM-REF-CANDIDATE: scheduled|in_progress|fieldwork_complete|report_draft|report_final|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `audit_type` STRING COMMENT 'Classification of the audit based on the auditing party and purpose. Internal audits are conducted by port staff, external audits by third parties, regulatory audits by government authorities, certification audits for ISO/ISPS compliance, surveillance audits for ongoing certification maintenance, and special audits triggered by incidents or complaints.. Valid values are `internal|external|regulatory|certification|surveillance|special`',
    `auditing_body_name` STRING COMMENT 'Name of the organization or authority conducting the audit. May be internal audit department, external certification body (e.g., Lloyds Register, DNV GL, Bureau Veritas), regulatory authority (e.g., National Maritime Safety Authority, Port State Control), or industry association.',
    `auditing_body_type` STRING COMMENT 'Classification of the auditing organization. Internal department refers to ports own audit team, certification body refers to accredited third-party auditors for ISO/ISPS certification, regulatory authority refers to government maritime or customs agencies, port state control refers to PSC inspection teams, industry association refers to IAPH or similar bodies.. Valid values are `internal_department|certification_body|regulatory_authority|port_state_control|industry_association`',
    `certificate_expiry_date` DATE COMMENT 'Expiration date of the certificate being audited. Used to schedule recertification audits and ensure continuous compliance. Null for non-certification audits.',
    `certificate_number` STRING COMMENT 'Number of the ISO or ISPS certificate that was the subject of the audit (for surveillance or recertification audits). Links the audit to the specific certification being maintained or renewed.',
    `certification_body_reference` STRING COMMENT 'Reference number or identifier assigned by the certification body for audits related to ISO or ISPS certification. Used to track certification status and link to certificate records. Null for non-certification audits.',
    `corrective_action_plan_reference` STRING COMMENT 'Reference number or identifier of the corrective action plan developed in response to audit findings. The CAP documents specific actions, responsible parties, and timelines to address non-conformities and observations.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for the audit, including auditor fees, travel expenses, and administrative costs. Applicable primarily for external and certification audits. Null for internal audits where costs are absorbed by internal departments.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost amount (e.g., USD, EUR, GBP). Null if audit cost is not tracked.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was first created in the system. Used for audit trail and data lineage tracking.',
    `criteria_reference` STRING COMMENT 'Reference to the standard, regulation, or policy against which the audit was conducted. Examples include ISO 28000:2022, ISO 14001:2015, ISO 45001:2018, ISPS Code Part A, MARPOL Annex VI, national maritime regulations, or internal port policies.',
    `detention_issued_flag` BOOLEAN COMMENT 'Indicates whether a detention order was issued as a result of the audit findings. True if detention was issued (typically for serious safety or security violations), False otherwise. Detention prevents vessel departure or facility operations until deficiencies are corrected.',
    `duration_days` DECIMAL(18,2) COMMENT 'Total duration of the audit fieldwork in days, calculated from audit start date to audit end date. Includes on-site inspection time but excludes report preparation time.',
    `end_date` DATE COMMENT 'Date when the audit fieldwork concluded. Represents the last day of on-site activities before report preparation. May differ from report issue date.',
    `follow_up_audit_due_date` DATE COMMENT 'Target date by which the follow-up audit must be conducted to verify corrective action completion. Typically set based on the severity of findings and regulatory requirements. Null if no follow-up audit is required.',
    `follow_up_audit_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up audit is required to verify implementation and effectiveness of corrective actions. True if follow-up is mandated (typically for major findings or conditional outcomes), False if no follow-up is required.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit record was last updated. Used for audit trail and change tracking.',
    `lead_auditor_certification` STRING COMMENT 'Professional certification or accreditation held by the lead auditor (e.g., ISO 9001 Lead Auditor, IRCA Certified Auditor, ISPS Auditor Certification). Demonstrates auditor qualifications and authority to conduct the audit.',
    `major_findings_count` STRING COMMENT 'Number of major non-conformities identified during the audit. Major findings represent significant deviations from requirements that could compromise safety, security, environmental protection, or regulatory compliance. Major findings typically require immediate corrective action and may result in certification suspension.',
    `management_response_date` DATE COMMENT 'Date when port management formally responded to the audit report. Null if no response has been received.',
    `management_response_received_flag` BOOLEAN COMMENT 'Indicates whether port management has formally responded to the audit findings and accepted the corrective action plan. True if response received, False if pending.',
    `minor_findings_count` STRING COMMENT 'Number of minor non-conformities identified during the audit. Minor findings represent isolated or less significant deviations from requirements that do not pose immediate risk but require corrective action within a defined timeframe.',
    `next_scheduled_audit_date` DATE COMMENT 'Planned date for the next audit of the same scope and facility. Used for surveillance audits (typically annual for ISO certifications) and periodic internal audits. Null if no future audit is scheduled.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the audit that do not fit in structured fields. May include special circumstances, auditor observations, or follow-up actions.',
    `observations_count` STRING COMMENT 'Number of observations or opportunities for improvement noted during the audit. Observations are not non-conformities but represent areas where processes could be enhanced or best practices could be adopted. No mandatory corrective action required.',
    `overall_audit_outcome` STRING COMMENT 'Summary conclusion of the audit. Satisfactory indicates full compliance with no major findings, satisfactory_with_observations indicates compliance with minor improvements recommended, conditional indicates compliance pending resolution of specific findings, unsatisfactory indicates significant non-compliance requiring major corrective action, certification_recommended indicates audit supports certification/recertification, certification_denied indicates audit does not support certification.. Valid values are `satisfactory|satisfactory_with_observations|conditional|unsatisfactory|certification_recommended|certification_denied`',
    `process_audited` STRING COMMENT 'Specific business process or operational procedure that was audited. Examples include vessel traffic management, cargo handling procedures, customs clearance workflow, security screening, environmental monitoring, maintenance planning, or billing processes.',
    `psc_deficiency_count` STRING COMMENT 'Number of deficiencies identified during a PSC inspection. Deficiencies are non-compliances with SOLAS, MARPOL, or other international maritime conventions. High deficiency counts can result in vessel detention or port facility sanctions.',
    `psc_inspection_flag` BOOLEAN COMMENT 'Indicates whether this audit was conducted as part of a Port State Control inspection. True if the audit was a PSC inspection, False otherwise. PSC inspections are regulatory audits of vessels and port facilities by national maritime authorities.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the audit for tracking and documentation purposes. Format typically includes audit type prefix, year, and sequence number.. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{4,6}$`',
    `regulatory_filing_reference` STRING COMMENT 'Reference number for any regulatory filing or submission made to authorities based on audit results. Applicable for audits conducted by or reported to IMO, WCO, national maritime authorities, or Port State Control.',
    `report_document_reference` STRING COMMENT 'Reference to the location or document management system identifier where the full audit report is stored. Enables retrieval of detailed findings, evidence, and recommendations.',
    `report_issue_date` DATE COMMENT 'Date when the final audit report was formally issued to the port management. Represents the official communication of audit findings and recommendations.',
    `start_date` DATE COMMENT 'Date when the audit fieldwork commenced. Represents the first day of on-site inspection, document review, or interviews. Used to calculate audit duration and schedule follow-up activities.',
    `team_size` STRING COMMENT 'Number of auditors in the audit team, including the lead auditor. Team size varies based on audit scope, facility complexity, and duration.',
    `trigger_reason` STRING COMMENT 'Reason or event that triggered the audit. Examples include scheduled surveillance audit, recertification due, incident investigation, customer complaint, regulatory requirement, management review, or process change. Provides context for why the audit was conducted.',
    CONSTRAINT pk_audit PRIMARY KEY(`audit_id`)
) COMMENT 'Compliance audit record for scheduled and ad-hoc audits conducted against port facilities, operational processes, and regulatory frameworks including ISPS, ISO 28000, ISO 14001, ISO 45001, and national maritime regulations. Captures audit reference number, audit type (internal/external/regulatory/certification), audit scope (ISPS/MARPOL/customs/OHS/environmental/trade_compliance), auditing body, lead auditor, audit start date, audit end date, facility or process audited, audit findings count (major/minor/observations), overall audit outcome (satisfactory/conditional/unsatisfactory), corrective action plan reference, follow-up audit required flag, follow-up audit due date, and certification body reference. SSOT for port compliance audit lifecycle.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ADD CONSTRAINT `fk_compliance_customs_declaration_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ADD CONSTRAINT `fk_compliance_trade_document_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ADD CONSTRAINT `fk_compliance_sanctions_screening_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ADD CONSTRAINT `fk_compliance_import_export_permit_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ADD CONSTRAINT `fk_compliance_import_export_permit_trade_restriction_id` FOREIGN KEY (`trade_restriction_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`trade_restriction`(`trade_restriction_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_customs_broker_id` FOREIGN KEY (`customs_broker_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_broker`(`customs_broker_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ADD CONSTRAINT `fk_compliance_customs_hold_sanctions_screening_id` FOREIGN KEY (`sanctions_screening_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`sanctions_screening`(`sanctions_screening_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_hs_code_id` FOREIGN KEY (`hs_code_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`hs_code`(`hs_code_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_marpol_record_id` FOREIGN KEY (`marpol_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`marpol_record`(`marpol_record_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_customs_declaration_id` FOREIGN KEY (`customs_declaration_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_declaration`(`customs_declaration_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_customs_hold_id` FOREIGN KEY (`customs_hold_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`customs_hold`(`customs_hold_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ADD CONSTRAINT `fk_compliance_violation_import_export_permit_id` FOREIGN KEY (`import_export_permit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`import_export_permit`(`import_export_permit_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ADD CONSTRAINT `fk_compliance_marpol_record_audit_id` FOREIGN KEY (`audit_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`audit`(`audit_id`);
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ADD CONSTRAINT `fk_compliance_audit_isps_facility_record_id` FOREIGN KEY (`isps_facility_record_id`) REFERENCES `shipping_ports_ecm`.`compliance`.`isps_facility_record`(`isps_facility_record_id`);

-- ========= TAGS =========
ALTER SCHEMA `shipping_ports_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `shipping_ports_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` SET TAGS ('dbx_subdomain' = 'customs_trade');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `customs_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `commodity_code_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hs Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Of Origin Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `customs_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `port_location_id` SET TAGS ('dbx_business_glossary_term' = 'Port Of Discharge Location Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Call ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `vessel_master_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Master Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `cargo_description` SET TAGS ('dbx_business_glossary_term' = 'Cargo Description');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `charges_currency` SET TAGS ('dbx_business_glossary_term' = 'Charges Currency');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `charges_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `clearance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clearance Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignee_address` SET TAGS ('dbx_business_glossary_term' = 'Consignee Address');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignee_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignee_identifier` SET TAGS ('dbx_business_glossary_term' = 'Consignee Identifier');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignee_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignee_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignee_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignee_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignor_address` SET TAGS ('dbx_business_glossary_term' = 'Consignor Address');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignor_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignor_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignor_identifier` SET TAGS ('dbx_business_glossary_term' = 'Consignor Identifier');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignor_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignor_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignor_name` SET TAGS ('dbx_business_glossary_term' = 'Consignor Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `consignor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `country_of_destination` SET TAGS ('dbx_business_glossary_term' = 'Country of Destination');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `country_of_destination` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `customs_regime` SET TAGS ('dbx_business_glossary_term' = 'Customs Regime');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `declarant_identifier` SET TAGS ('dbx_business_glossary_term' = 'Declarant Identifier');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `declarant_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `declarant_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `declarant_name` SET TAGS ('dbx_business_glossary_term' = 'Declarant Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `declarant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `declarant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `declaration_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Reference Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Declaration Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_business_glossary_term' = 'Declaration Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `declaration_type` SET TAGS ('dbx_value_regex' = 'import|export|transit|re-export|temporary_admission|inward_processing');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `duty_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Duty Amount');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `duty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `edi_message_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Message Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `edi_message_type` SET TAGS ('dbx_value_regex' = 'IFTMIN|CUSCAR|CUSDEC|CUSRES|CUSREP');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `fal_form_3_compliant` SET TAGS ('dbx_business_glossary_term' = 'IMO FAL Form 3 Compliant');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `freight_forwarder_identifier` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Identifier');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `freight_forwarder_name` SET TAGS ('dbx_business_glossary_term' = 'Freight Forwarder Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Kilograms)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `port_of_loading` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading (POL)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `port_of_loading` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `psc_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Port State Control (PSC) Inspection Required');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|flagged|blocked');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `total_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Charges Amount');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `total_charges_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `vat_amount` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Amount');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `vat_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_declaration` ALTER COLUMN `wco_message_version` SET TAGS ('dbx_business_glossary_term' = 'World Customs Organization (WCO) Message Version');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` SET TAGS ('dbx_subdomain' = 'customs_trade');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Code Identifier');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `anti_dumping_duty_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Dumping Duty Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `chapter` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code Chapter');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `cites_flag` SET TAGS ('dbx_business_glossary_term' = 'Convention on International Trade in Endangered Species (CITES) Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `commodity_description_short` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description Short');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `countervailing_duty_flag` SET TAGS ('dbx_business_glossary_term' = 'Countervailing Duty Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `dual_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Dual Use Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `duty_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Duty Rate Percentage');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `excise_duty_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Excise Duty Rate Percentage');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `heading` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code Heading');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `heading` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `hs_code_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `hs_code_status` SET TAGS ('dbx_value_regex' = 'active|inactive|superseded|pending|deprecated');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `hs_version` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Version');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `hs_version` SET TAGS ('dbx_value_regex' = '^HS[0-9]{4}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `imdg_class` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Dangerous Goods (IMDG) Class');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `imdg_class` SET TAGS ('dbx_value_regex' = '^[1-9](.[1-9])?$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `imdg_dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'International Maritime Dangerous Goods (IMDG) Dangerous Goods Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `license_required_flag` SET TAGS ('dbx_business_glossary_term' = 'License Required Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `origin_certificate_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Origin Certificate Required Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `phytosanitary_certificate_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Phytosanitary Certificate Required Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `preferential_tariff_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferential Tariff Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `prohibited_flag` SET TAGS ('dbx_business_glossary_term' = 'Prohibited Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `quota_flag` SET TAGS ('dbx_business_glossary_term' = 'Quota Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Restricted Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `sanctions_screening_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Required Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `statistical_suffix` SET TAGS ('dbx_business_glossary_term' = 'Statistical Suffix');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `statistical_suffix` SET TAGS ('dbx_value_regex' = '^[0-9]{0,4}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `subheading` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code Subheading');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `subheading` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `trade_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Code');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `vat_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Rate Percentage');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`hs_code` ALTER COLUMN `veterinary_certificate_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Veterinary Certificate Required Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` SET TAGS ('dbx_subdomain' = 'customs_trade');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `trade_document_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Document ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `commodity_code_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hs Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `container_id` SET TAGS ('dbx_business_glossary_term' = 'Container Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `customs_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `imdg_class_id` SET TAGS ('dbx_business_glossary_term' = 'Imdg Class Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Manifest ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `port_location_id` SET TAGS ('dbx_business_glossary_term' = 'Port Of Discharge Location Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `shipping_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Line Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Call ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `vessel_master_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Master Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `country_of_destination` SET TAGS ('dbx_business_glossary_term' = 'Country of Destination');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `country_of_destination` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `customs_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|held|rejected');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|expired|cancelled');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'bill_of_lading|sea_waybill|certificate_of_origin|packing_list|commercial_invoice|phytosanitary_certificate');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `edi_message_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Message Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `file_reference` SET TAGS ('dbx_business_glossary_term' = 'File Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `is_electronic` SET TAGS ('dbx_business_glossary_term' = 'Is Electronic Document');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `isps_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'International Ship and Port Facility Security (ISPS) Compliance Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `issuing_party_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Party Code');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Kilograms)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `notify_party_name` SET TAGS ('dbx_business_glossary_term' = 'Notify Party Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'carton|pallet|crate|drum|bag|bale');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `port_of_loading` SET TAGS ('dbx_business_glossary_term' = 'Port of Loading (POL)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `port_of_loading` SET TAGS ('dbx_value_regex' = '^[A-Z]{5}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_document` ALTER COLUMN `volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Meters)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` SET TAGS ('dbx_subdomain' = 'regulatory_screening');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `commodity_code_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `flag_state_id` SET TAGS ('dbx_business_glossary_term' = 'Flag State Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Screened Country Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `shipping_line_id` SET TAGS ('dbx_business_glossary_term' = 'Screened Shipping Line Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `security_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `trade_restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Restriction Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Call ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `vessel_master_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Master Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `analyst_review_status` SET TAGS ('dbx_business_glossary_term' = 'Analyst Review Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `analyst_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending_review|under_review|reviewed|approved|rejected');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `authority_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Authority Reference Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `cargo_description` SET TAGS ('dbx_business_glossary_term' = 'Cargo Description');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `company_country_of_registration` SET TAGS ('dbx_business_glossary_term' = 'Company Country of Registration');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `company_country_of_registration` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `company_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Company Registration Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `country_of_destination` SET TAGS ('dbx_business_glossary_term' = 'Country of Destination');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `country_of_destination` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `escalated_to_authority` SET TAGS ('dbx_business_glossary_term' = 'Escalated to Authority');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `individual_nationality` SET TAGS ('dbx_business_glossary_term' = 'Individual Nationality');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `individual_nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `individual_nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `individual_nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `individual_passport_number` SET TAGS ('dbx_business_glossary_term' = 'Individual Passport Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `individual_passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `individual_passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `is_high_risk_cargo` SET TAGS ('dbx_business_glossary_term' = 'Is High Risk Cargo');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `match_score` SET TAGS ('dbx_business_glossary_term' = 'Match Score');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'clear|potential_match|confirmed_match|false_positive');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `matched_list_entry` SET TAGS ('dbx_business_glossary_term' = 'Matched List Entry');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `matched_list_entry` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `matched_list_identifier` SET TAGS ('dbx_business_glossary_term' = 'Matched List Identifier');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `matched_list_name` SET TAGS ('dbx_business_glossary_term' = 'Matched List Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'cleared|blocked|escalated_to_authorities|further_investigation|false_positive_confirmed');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewing_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewing Officer Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `reviewing_officer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `sanctions_list_update_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions List Update Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `screened_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Screened Entity Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_lists_checked` SET TAGS ('dbx_business_glossary_term' = 'Screening Lists Checked');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_notes` SET TAGS ('dbx_business_glossary_term' = 'Screening Notes');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Screening Reference Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_reference_number` SET TAGS ('dbx_value_regex' = '^SCR-[0-9]{10}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_system_name` SET TAGS ('dbx_business_glossary_term' = 'Screening System Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_system_version` SET TAGS ('dbx_business_glossary_term' = 'Screening System Version');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`sanctions_screening` ALTER COLUMN `screening_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Screening Trigger Event');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` SET TAGS ('dbx_subdomain' = 'regulatory_screening');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `isps_facility_record_id` SET TAGS ('dbx_business_glossary_term' = 'International Ship and Port Facility Security (ISPS) Facility Record ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `vessel_master_id` SET TAGS ('dbx_business_glossary_term' = 'Dos Vessel Master Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `port_location_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Location Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_affected_zone` SET TAGS ('dbx_business_glossary_term' = 'Security Alert Affected Zone');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_affected_zone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_escalation_chain` SET TAGS ('dbx_business_glossary_term' = 'Security Alert Escalation Chain');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_escalation_chain` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Security Alert Issued Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_issued_timestamp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_resolution_details` SET TAGS ('dbx_business_glossary_term' = 'Security Alert Resolution Details');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_resolution_details` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Security Alert Resolution Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_resolution_timestamp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_response_actions` SET TAGS ('dbx_business_glossary_term' = 'Security Alert Response Actions');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_response_actions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_severity` SET TAGS ('dbx_business_glossary_term' = 'Security Alert Severity Level');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_severity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_source` SET TAGS ('dbx_business_glossary_term' = 'Security Alert Source');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_source` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_type` SET TAGS ('dbx_business_glossary_term' = 'Security Alert Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_type` SET TAGS ('dbx_value_regex' = 'security_threat|suspicious_activity|unauthorized_access|cyber_incident|vessel_security_alert|terrorism_threat');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `alert_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'ISPS Compliance Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'fully_compliant|conditionally_compliant|non_compliant|under_review');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `cso_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Company Security Officer (CSO) Contact Email');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `cso_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `cso_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `cso_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `cso_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Company Security Officer (CSO) Contact Phone');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `cso_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `cso_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `cso_name` SET TAGS ('dbx_business_glossary_term' = 'Company Security Officer (CSO) Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `cso_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `cso_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `current_security_level` SET TAGS ('dbx_business_glossary_term' = 'Maritime Security (MARSEC) Level');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `current_security_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_activities_covered` SET TAGS ('dbx_business_glossary_term' = 'Declaration of Security (DoS) Activities Covered');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_activities_covered` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_port_signed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Declaration of Security (DoS) Port Signed Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_port_signed_timestamp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_port_signing_officer` SET TAGS ('dbx_business_glossary_term' = 'Declaration of Security (DoS) Port Signing Officer Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_port_signing_officer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_port_signing_officer` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Declaration of Security (DoS) Reference Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_reference_number` SET TAGS ('dbx_value_regex' = '^DOS-[A-Z0-9]{8,16}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_ship_signed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Declaration of Security (DoS) Ship Signed Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_ship_signed_timestamp` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_ship_signing_officer` SET TAGS ('dbx_business_glossary_term' = 'Declaration of Security (DoS) Ship Signing Officer Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_ship_signing_officer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_ship_signing_officer` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_type` SET TAGS ('dbx_business_glossary_term' = 'Declaration of Security (DoS) Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_type` SET TAGS ('dbx_value_regex' = 'ship_to_port|ship_to_ship|port_to_port');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_valid_from` SET TAGS ('dbx_business_glossary_term' = 'Declaration of Security (DoS) Valid From Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_valid_from` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_valid_until` SET TAGS ('dbx_business_glossary_term' = 'Declaration of Security (DoS) Valid Until Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `dos_valid_until` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'container_terminal|bulk_cargo_terminal|ro_ro_terminal|passenger_terminal|oil_gas_terminal|general_cargo_terminal');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `isps_reference_number` SET TAGS ('dbx_business_glossary_term' = 'International Ship and Port Facility Security (ISPS) Reference Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `isps_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[A-Z0-9]{6,12}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `last_psc_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Port State Control (PSC) Inspection Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `last_psc_inspection_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `last_psc_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Last Port State Control (PSC) Inspection Result');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `last_psc_inspection_result` SET TAGS ('dbx_value_regex' = 'compliant|deficiency_noted|major_non_conformity|detention');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `last_psc_inspection_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `national_authority_contact` SET TAGS ('dbx_business_glossary_term' = 'National Maritime Authority Contact Information');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `national_authority_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `national_authority_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `national_authority_name` SET TAGS ('dbx_business_glossary_term' = 'National Maritime Authority Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next ISPS Audit Due Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfso_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Officer (PFSO) Certification Expiry Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfso_certification_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfso_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Officer (PFSO) Certification Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfso_certification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfso_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Officer (PFSO) Contact Email');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfso_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfso_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfso_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfso_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Officer (PFSO) Contact Phone');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfso_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfso_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfsp_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Plan (PFSP) Approval Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfsp_approval_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfsp_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Plan (PFSP) Expiry Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfsp_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfsp_version` SET TAGS ('dbx_business_glossary_term' = 'Port Facility Security Plan (PFSP) Version');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfsp_version` SET TAGS ('dbx_value_regex' = '^vd+.d+$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `pfsp_version` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `psc_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Port State Control (PSC) Deficiency Count');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `psc_deficiency_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `security_alert_reference` SET TAGS ('dbx_business_glossary_term' = 'Security Alert Reference Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `security_alert_reference` SET TAGS ('dbx_value_regex' = '^ALERT-[A-Z0-9]{8,16}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `security_alert_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `security_level_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Security Level Effective Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`isps_facility_record` ALTER COLUMN `security_level_effective_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` SET TAGS ('dbx_subdomain' = 'customs_trade');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `import_export_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Import Export Permit ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `commodity_code_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hs Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `trade_restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Restriction Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `bill_of_lading_reference` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `conditions_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Conditions and Restrictions');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `controlled_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Controlled Goods Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Destination Code');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `edi_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Message Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `end_use_statement` SET TAGS ('dbx_business_glossary_term' = 'End Use Statement');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `end_user_name` SET TAGS ('dbx_business_glossary_term' = 'End User Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `end_user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `inspection_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completion Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional_release|pending');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `pcs_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Port Community System (PCS) Transaction ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `permit_holder_identifier` SET TAGS ('dbx_business_glossary_term' = 'Permit Holder Identifier');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `permit_holder_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `quantity_authorized` SET TAGS ('dbx_business_glossary_term' = 'Quantity Authorized');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`import_export_permit` ALTER COLUMN `value_authorized` SET TAGS ('dbx_business_glossary_term' = 'Value Authorized');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` SET TAGS ('dbx_subdomain' = 'customs_trade');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `customs_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `accrual_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `commodity_code_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hs Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `customs_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `customs_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Port Call Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `port_location_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `security_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `shipping_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Line Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `actual_delay_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Delay Duration (Hours)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `bol_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Reference Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `cargo_description` SET TAGS ('dbx_business_glossary_term' = 'Cargo Description');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `demurrage_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Demurrage (DMG) Applicable Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `detention_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Detention (DET) Applicable Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `edi_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Message Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `estimated_delay_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delay Duration (Hours)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `examination_findings` SET TAGS ('dbx_business_glossary_term' = 'Examination Findings');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `examination_findings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `hold_placement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placement Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `hold_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `hold_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Reference Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `hold_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `hold_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|escalated|cancelled|expired');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'documentary|physical_examination|scanning|laboratory|quarantine|sanctions');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `importer_exporter_name` SET TAGS ('dbx_business_glossary_term' = 'Importer or Exporter Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `importer_exporter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `inspection_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completed Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `inspection_scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scheduled Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `isps_security_level` SET TAGS ('dbx_business_glossary_term' = 'International Ship and Port Facility Security (ISPS) Security Level');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `isps_security_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `placed_by_authority` SET TAGS ('dbx_business_glossary_term' = 'Placed By Authority');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `psc_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Port State Control (PSC) Inspection Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Release Reason');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `seizure_flag` SET TAGS ('dbx_business_glossary_term' = 'Seizure Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `seizure_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Seizure Reference Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_hold` ALTER COLUMN `seizure_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` SET TAGS ('dbx_subdomain' = 'regulatory_screening');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `violation_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Identifier');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `hs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Hs Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `marpol_record_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Marpol Record Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `container_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Container Visit Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `customs_declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `customs_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Hold Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `flag_state_id` SET TAGS ('dbx_business_glossary_term' = 'Flag State Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `imdg_class_id` SET TAGS ('dbx_business_glossary_term' = 'Imdg Class Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `import_export_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Import Export Permit Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `marsec_level_change_id` SET TAGS ('dbx_business_glossary_term' = 'Marsec Level Change Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Port Call Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `port_location_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Location Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `security_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `shipping_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Line Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `vessel_master_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Master Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `berth_code` SET TAGS ('dbx_business_glossary_term' = 'Berth Code');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `case_closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_remediation|closed|escalated');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|overdue|waived');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `detected_by_officer` SET TAGS ('dbx_business_glossary_term' = 'Detected By Officer');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `detected_by_officer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `detected_by_system` SET TAGS ('dbx_business_glossary_term' = 'Detected By System');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'inspection|audit|screening|system_alert|self_reported|third_party');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `edi_message_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Message Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `edi_message_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Message Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'none|management|executive|regulatory_authority');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `inspector_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspector Notes');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `inspector_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `penalty_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Penalty Payment Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `penalty_payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|waived|disputed|partially_paid');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `penalty_reference` SET TAGS ('dbx_business_glossary_term' = 'Penalty Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Violation Reference Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^VIO-[0-9]{8}-[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `reporting_authority` SET TAGS ('dbx_business_glossary_term' = 'Reporting Authority');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `reporting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reporting Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'minor|major|critical');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = 'customs|isps_security|psc_inspection|imdg|marpol|trade_control');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` SET TAGS ('dbx_subdomain' = 'regulatory_screening');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `marpol_record_id` SET TAGS ('dbx_business_glossary_term' = 'Marpol Record Identifier');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `bunker_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Bunker Operation Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `flag_state_id` SET TAGS ('dbx_business_glossary_term' = 'Flag State Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `call_id` SET TAGS ('dbx_business_glossary_term' = 'Port Call Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `port_location_id` SET TAGS ('dbx_business_glossary_term' = 'Reception Facility Location Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `vessel_master_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Master Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_discharge_location` SET TAGS ('dbx_business_glossary_term' = 'Ballast Water Discharge Location');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_exchange_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Ballast Water Exchange Location Latitude');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_exchange_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_exchange_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_exchange_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Ballast Water Exchange Location Longitude');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_exchange_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_exchange_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_management_method` SET TAGS ('dbx_business_glossary_term' = 'Ballast Water Management Method');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_management_method` SET TAGS ('dbx_value_regex' = 'exchange|treatment|retention');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_source_location` SET TAGS ('dbx_business_glossary_term' = 'Ballast Water Source Location');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_treatment_system_imo_approval` SET TAGS ('dbx_business_glossary_term' = 'Ballast Water Treatment System IMO (International Maritime Organization) Type Approval Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_treatment_system_imo_approval` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_treatment_system_imo_approval` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_treatment_system_type` SET TAGS ('dbx_business_glossary_term' = 'Ballast Water Treatment System Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_treatment_system_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `ballast_water_treatment_system_type` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `cii_rating` SET TAGS ('dbx_business_glossary_term' = 'CII (Carbon Intensity Indicator) Rating');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `cii_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|under review|pending verification');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `disposal_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Disposal Certificate Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `disposal_contractor` SET TAGS ('dbx_business_glossary_term' = 'Disposal Contractor');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'incineration|landfill|recycling|treatment|reuse|export');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `eedi_value` SET TAGS ('dbx_business_glossary_term' = 'EEDI (Energy Efficiency Design Index) Value');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `eexi_value` SET TAGS ('dbx_business_glossary_term' = 'EEXI (Energy Efficiency Existing Ship Index) Value');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `marpol_annex` SET TAGS ('dbx_business_glossary_term' = 'MARPOL (Marine Pollution Convention) Annex');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `marpol_annex` SET TAGS ('dbx_value_regex' = 'Annex I|Annex II|Annex IV|Annex V|Annex VI|BWM Convention');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Reason');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `nox_emissions_mt` SET TAGS ('dbx_business_glossary_term' = 'NOx (Nitrogen Oxides) Emissions (Metric Tons)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `operation_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Operation Location Latitude');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `operation_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `operation_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `operation_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Operation Location Longitude');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `operation_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `operation_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `operation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operation Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `operation_type` SET TAGS ('dbx_value_regex' = 'discharge|reception|transfer|treatment|exchange|retention');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `particulate_matter_emissions_mt` SET TAGS ('dbx_business_glossary_term' = 'Particulate Matter (PM) Emissions (Metric Tons)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `port_authority_endorsement_flag` SET TAGS ('dbx_business_glossary_term' = 'Port Authority Endorsement Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `port_authority_endorsement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Port Authority Endorsement Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `port_authority_inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Port Authority Inspector Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `port_authority_inspector_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `port_of_operation` SET TAGS ('dbx_business_glossary_term' = 'Port of Operation');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `psc_inspection_reference` SET TAGS ('dbx_business_glossary_term' = 'PSC (Port State Control) Inspection Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `quantity_mass_mt` SET TAGS ('dbx_business_glossary_term' = 'Quantity Mass (Metric Tons)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `quantity_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Quantity Volume (Cubic Meters)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `reception_facility_operator` SET TAGS ('dbx_business_glossary_term' = 'Reception Facility Operator');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `record_book_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Record Book Entry Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `responsible_officer_rank` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Rank');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `responsible_officer_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Responsible Officer Signature Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `sox_emissions_mt` SET TAGS ('dbx_business_glossary_term' = 'SOx (Sulfur Oxides) Emissions (Metric Tons)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `waste_manifest_number` SET TAGS ('dbx_business_glossary_term' = 'Waste Manifest Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`marpol_record` ALTER COLUMN `waste_type` SET TAGS ('dbx_business_glossary_term' = 'Waste Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` SET TAGS ('dbx_subdomain' = 'customs_trade');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `trade_restriction_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Restriction Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Country Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `commodity_code_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `affected_party_identifier` SET TAGS ('dbx_business_glossary_term' = 'Affected Party Identifier');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `affected_party_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `affected_party_name` SET TAGS ('dbx_business_glossary_term' = 'Affected Party Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `affected_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `affected_party_type` SET TAGS ('dbx_business_glossary_term' = 'Affected Party Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `affected_party_type` SET TAGS ('dbx_value_regex' = 'vessel|company|individual|entity|government|organization');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `affected_territory` SET TAGS ('dbx_business_glossary_term' = 'Affected Territory');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `declaration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Declaration Required Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `derogation_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Derogation Available Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `derogation_conditions` SET TAGS ('dbx_business_glossary_term' = 'Derogation Conditions');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `edi_message_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Message Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Level');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `enforcement_level` SET TAGS ('dbx_value_regex' = 'mandatory|advisory|conditional|discretionary');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `hs_code_from` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code From');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `hs_code_from` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `hs_code_to` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code To');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `hs_code_to` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `issuing_authority_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Country Code');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `issuing_authority_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `legal_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Reference Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `license_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'License Requirement Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `license_requirement_type` SET TAGS ('dbx_value_regex' = 'export_license|import_license|transit_license|dual_use_license|none');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `restriction_authority` SET TAGS ('dbx_business_glossary_term' = 'Restriction Authority');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `restriction_code` SET TAGS ('dbx_business_glossary_term' = 'Restriction Code');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `restriction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Restriction Description');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `restriction_scope` SET TAGS ('dbx_business_glossary_term' = 'Restriction Scope');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `restriction_scope` SET TAGS ('dbx_value_regex' = 'import|export|transit|transshipment|all_trade');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `restriction_status` SET TAGS ('dbx_business_glossary_term' = 'Restriction Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `restriction_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|pending|revoked|under_review');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'embargo|sanction|quota|prohibition|license_requirement|tariff_restriction');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `screening_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Screening Required Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `source_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Identifier (ID)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`trade_restriction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` SET TAGS ('dbx_subdomain' = 'customs_trade');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `customs_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `edi_partner_id` SET TAGS ('dbx_business_glossary_term' = 'EDI (Electronic Data Interchange) Sender ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `port_community_participant_id` SET TAGS ('dbx_business_glossary_term' = 'Port Community Participant Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `port_location_id` SET TAGS ('dbx_business_glossary_term' = 'Port Location Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_audit_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Audit Findings Summary');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_benefits_applied` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Benefits Applied');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Certificate Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Certified Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_country_of_issue` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Country of Issue');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_country_of_issue` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Expiry Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_issue_date` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Issue Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Issuing Authority');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Last Audit Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_mra_applicable` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) MRA (Mutual Recognition Agreement) Applicable');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Next Audit Due Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_status` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Certificate Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_status` SET TAGS ('dbx_value_regex' = 'active|suspended|revoked|expired|not_applicable');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_type` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `aeo_type` SET TAGS ('dbx_value_regex' = 'AEO-C|AEO-S|AEO-F|not_applicable');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `authorized_ports` SET TAGS ('dbx_business_glossary_term' = 'Authorized Ports of Operation');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `bond_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Bond Expiry Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `bond_insurance_reference` SET TAGS ('dbx_business_glossary_term' = 'Bond Insurance Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 1');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `business_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Business Address Line 2');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `business_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `business_city` SET TAGS ('dbx_business_glossary_term' = 'Business City');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `business_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `business_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rating');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `compliance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|poor|not_rated');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `deactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Reason');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `declarations_rejected_count` SET TAGS ('dbx_business_glossary_term' = 'Declarations Rejected Count');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `last_declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Declaration Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiry Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `license_issue_date` SET TAGS ('dbx_business_glossary_term' = 'License Issue Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker License Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `license_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'License Renewal Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'active|suspended|revoked|expired|pending_renewal|inactive');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'customs_broker|freight_forwarder|combined|nvocc|customs_agent|trade_intermediary');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `pcs_registration_reference` SET TAGS ('dbx_business_glossary_term' = 'PCS (Port Community System) Registration Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `sanctions_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `sanctions_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|under_review|blocked|not_screened');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`customs_broker` ALTER COLUMN `total_declarations_submitted` SET TAGS ('dbx_business_glossary_term' = 'Total Declarations Submitted');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` SET TAGS ('dbx_subdomain' = 'regulatory_screening');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit ID');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `facility_security_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Security Plan Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `flag_state_id` SET TAGS ('dbx_business_glossary_term' = 'Flag State Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `isps_facility_record_id` SET TAGS ('dbx_business_glossary_term' = 'Isps Facility Record Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `port_location_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Location Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `shipping_line_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Line Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `terminal_id` SET TAGS ('dbx_business_glossary_term' = 'Terminal Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `vessel_master_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Master Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `vessel_type_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Type Id (Foreign Key)');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_value_regex' = 'ISPS|MARPOL|customs|OHS|environmental|trade_compliance');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory|certification|surveillance|special');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `auditing_body_name` SET TAGS ('dbx_business_glossary_term' = 'Auditing Body Name');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `auditing_body_type` SET TAGS ('dbx_business_glossary_term' = 'Auditing Body Type');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `auditing_body_type` SET TAGS ('dbx_value_regex' = 'internal_department|certification_body|regulatory_authority|port_state_control|industry_association');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `certification_body_reference` SET TAGS ('dbx_business_glossary_term' = 'Certification Body Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `corrective_action_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Amount');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Currency Code');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `criteria_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Criteria Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `detention_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Detention Issued Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Audit Duration Days');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `follow_up_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Due Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `follow_up_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `lead_auditor_certification` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Certification');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `management_response_date` SET TAGS ('dbx_business_glossary_term' = 'Management Response Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `management_response_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Management Response Received Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `next_scheduled_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Audit Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `observations_count` SET TAGS ('dbx_business_glossary_term' = 'Observations Count');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `overall_audit_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Outcome');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `overall_audit_outcome` SET TAGS ('dbx_value_regex' = 'satisfactory|satisfactory_with_observations|conditional|unsatisfactory|certification_recommended|certification_denied');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `process_audited` SET TAGS ('dbx_business_glossary_term' = 'Process Audited');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `psc_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Port State Control (PSC) Deficiency Count');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `psc_inspection_flag` SET TAGS ('dbx_business_glossary_term' = 'Port State Control (PSC) Inspection Flag');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{4,6}$');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document Reference');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `report_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Issue Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `team_size` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Size');
ALTER TABLE `shipping_ports_ecm`.`compliance`.`audit` ALTER COLUMN `trigger_reason` SET TAGS ('dbx_business_glossary_term' = 'Audit Trigger Reason');
