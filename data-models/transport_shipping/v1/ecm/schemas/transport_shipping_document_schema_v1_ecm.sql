-- Schema for Domain: document | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:11

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`document` COMMENT 'Enterprise document management domain serving as SSOT for all transport documents, trade documents, certificates, and digital records across the logistics lifecycle. Manages document templates, versioning, digital signatures, and regulatory document retention policies.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`transport_document` (
    `transport_document_id` BIGINT COMMENT 'Unique identifier for the transport document. Primary key. Inferred role: MASTER_RESOURCE (document as managed resource).',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Transport documents are frequently issued by freight forwarding agents acting on behalf of shippers or carriers. Agent identification is required for regulatory compliance and operational accountabili',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Every transport document (AWB, BOL, manifest) must identify the carrier executing the transport. Core operational requirement for shipping documentation—carrier is mandatory field on all transport doc',
    `consignment_id` BIGINT COMMENT 'Reference to the associated shipment that this transport document covers. Links the document to the physical movement of goods.',
    `freight_order_id` BIGINT COMMENT 'Reference to the freight order or booking that this transport document is associated with. Nullable if document is not tied to a specific freight order.',
    `parent_document_transport_document_id` BIGINT COMMENT 'Reference to the parent transport document if this is a house document under a master document (e.g., HAWB under MAWB, HBL under MBL). Nullable for master documents.',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: 3PL providers manage documentation for shipments under their control. Linking transport documents to 3PL providers enables operational visibility into which provider is responsible for document accura',
    `superseded_transport_document_id` BIGINT COMMENT 'Self-referencing FK on transport_document (superseded_transport_document_id)',
    `consignee_address` STRING COMMENT 'The full address of the consignee (receiver). Classified as confidential organizational contact data.',
    `consignee_name` STRING COMMENT 'The name of the party receiving the goods (consignee). Business-confidential as it reveals commercial relationships.',
    `container_number` STRING COMMENT 'The unique container number if the shipment is containerized (e.g., for FCL ocean freight). Nullable for non-containerized shipments.',
    `created_by_user` STRING COMMENT 'The user ID or name of the person who created this transport document record. Audit trail for accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this transport document record was first created in the system. Audit trail for record creation.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains dangerous goods (hazmat) requiring special handling and documentation.',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'The declared value of the goods for insurance and liability purposes. Confidential commercial information.',
    `declared_value_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the declared value amount.',
    `destination_location` STRING COMMENT 'The location or port where the shipment is destined (e.g., airport code, seaport name, city). Recorded as stated on the transport document.',
    `digital_signature_applied` BOOLEAN COMMENT 'Indicates whether a digital signature has been applied to the document for authenticity and non-repudiation.',
    `document_format` STRING COMMENT 'Indicates whether the document is maintained in digital format only, physical paper format only, or both (hybrid). Critical for regulatory compliance and operational handling.. Valid values are `Digital|Physical|Hybrid`',
    `document_number` STRING COMMENT 'The externally-known unique business identifier for this transport document (e.g., AWB number, BOL number, CMR number). Used for customer communication, regulatory filing, and cross-system reference.',
    `document_status` STRING COMMENT 'Current lifecycle status of the transport document. Tracks progression from draft creation through issuance, transit, delivery, and archival or cancellation. [ENUM-REF-CANDIDATE: Draft|Issued|In Transit|Delivered|Cancelled|Voided|Archived — 7 candidates stripped; promote to reference product]',
    `document_type` STRING COMMENT 'Classification of the transport document type. AWB = Air Waybill, BOL = Bill of Lading, CMR = Convention Marchandise Routiere (road consignment note), HAWB = House Air Waybill, MAWB = Master Air Waybill, MBL = Master Bill of Lading, HBL = House Bill of Lading. [ENUM-REF-CANDIDATE: AWB|BOL|CMR|HAWB|MAWB|MBL|HBL|Consignment Note|Delivery Order|Cargo Manifest — 10 candidates stripped; promote to reference product]',
    `document_version` STRING COMMENT 'Version number of the transport document. Incremented when amendments or corrections are issued.',
    `expiry_date` DATE COMMENT 'The date on which the transport document expires or is no longer valid for use. Nullable for documents without expiration (e.g., archival BOLs).',
    `filing_reference_number` STRING COMMENT 'The reference number assigned by the regulatory authority upon successful filing (e.g., AMS filing number, ENS MRN). Nullable if not yet filed.',
    `freight_charges_prepaid` BOOLEAN COMMENT 'Indicates whether freight charges are prepaid (true) or collect (false). Determines payment responsibility.',
    `goods_description` STRING COMMENT 'Textual description of the goods being transported as declared on the transport document. Used for customs, regulatory, and operational purposes.',
    `hs_code` STRING COMMENT 'The Harmonized System tariff classification code for the goods. Used for customs clearance and duty calculation.',
    `incoterm` STRING COMMENT 'The Incoterm governing the delivery and risk transfer for this shipment. Defines responsibilities between buyer and seller. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `issue_date` DATE COMMENT 'The date on which the transport document was officially issued to the shipper or consignee. Represents the principal business event timestamp for this document.',
    `issuing_party_code` STRING COMMENT 'The standardized code or identifier for the issuing party (e.g., IATA airline code, SCAC code for ocean carriers).',
    `issuing_party_name` STRING COMMENT 'The name of the organization or entity that issued the transport document (e.g., carrier, freight forwarder, NVOCC).',
    `modified_by_user` STRING COMMENT 'The user ID or name of the person who last modified this transport document record. Audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this transport document record was last modified. Audit trail for record updates.',
    `notify_party_name` STRING COMMENT 'The name of the party to be notified upon arrival of goods. Common in ocean freight BOLs. Nullable if not applicable.',
    `number_of_packages` STRING COMMENT 'The total count of packages, pieces, or handling units covered by this transport document.',
    `origin_location` STRING COMMENT 'The location or port where the shipment originates (e.g., airport code, seaport name, city). Recorded as stated on the transport document.',
    `package_type` STRING COMMENT 'The type of packaging used for the shipment (e.g., pallet, carton, container). Standardized for operational handling. [ENUM-REF-CANDIDATE: Pallet|Carton|Crate|Drum|Container|Bag|Bundle — 7 candidates stripped; promote to reference product]',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this document requires regulatory filing with customs or other authorities (e.g., AMS, ISF, ENS).',
    `retention_expiry_date` DATE COMMENT 'The date after which the document may be purged or archived per regulatory retention policies. Calculated based on issue date and applicable retention period.',
    `seal_number` STRING COMMENT 'The seal number applied to the container or shipment for security and tamper-evidence. Nullable if no seal is applied.',
    `shipper_address` STRING COMMENT 'The full address of the shipper (consignor). Classified as confidential organizational contact data.',
    `shipper_name` STRING COMMENT 'The name of the party shipping the goods (consignor). Business-confidential as it reveals commercial relationships.',
    `signature_timestamp` TIMESTAMP COMMENT 'The timestamp when the digital signature was applied. Nullable if no digital signature exists.',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling requirements or instructions for the shipment (e.g., temperature control, fragile, keep upright).',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'The total volume of the shipment in cubic meters (CBM) as declared on the transport document.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'The total gross weight of the shipment in kilograms as declared on the transport document.',
    `un_number` STRING COMMENT 'The UN number identifying the dangerous goods substance if dangerous_goods_flag is true. Nullable otherwise.',
    CONSTRAINT pk_transport_document PRIMARY KEY(`transport_document_id`)
) COMMENT 'Core master entity representing every transport document issued or managed by Transport Shipping across all logistics service lines. Serves as the SSOT for document identity, type classification (AWB, BOL, CMR, consignment note, delivery order, cargo manifest), document status lifecycle, issuing party, associated shipment or freight order reference, document date, expiry, and digital/physical format. Acts as the central registry from which all other document domain entities hang.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`template` (
    `template_id` BIGINT COMMENT 'Unique identifier for the document template record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Carriers require carrier-specific document templates (branded AWB forms, carrier-specific manifest formats, carrier EDI message specifications). Real operational requirement—major carriers mandate use',
    `predecessor_template_id` BIGINT COMMENT 'Reference to the previous version of this template in the version history chain. Nullable for initial versions.',
    `derived_from_template_id` BIGINT COMMENT 'Self-referencing FK on template (derived_from_template_id)',
    `applicable_mode` STRING COMMENT 'Transport mode(s) for which this template is applicable (air, ocean, road, rail, multimodal, parcel).. Valid values are `air|ocean|road|rail|multimodal|parcel`',
    `approval_authority` STRING COMMENT 'Role or position authorized to approve this template or its changes (e.g., Compliance Director, Operations Manager, Legal Counsel).',
    `approval_required` BOOLEAN COMMENT 'Indicates whether template changes require formal approval workflow before activation (True/False).',
    `archival_required` BOOLEAN COMMENT 'Indicates whether documents generated from this template must be archived in long-term storage after active use (True/False).',
    `audit_trail_enabled` BOOLEAN COMMENT 'Indicates whether documents generated from this template maintain a full audit trail of all changes and access (True/False).',
    `change_description` STRING COMMENT 'Description of changes made in this version compared to the predecessor version. Used for version control and audit trail.',
    `compliance_certification` STRING COMMENT 'Certification or attestation that this template meets regulatory requirements (e.g., C-TPAT Certified, AEO Compliant, ISO 9001 Certified).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this template record was first created in the system.',
    `digital_signature_required` BOOLEAN COMMENT 'Indicates whether documents generated from this template require digital signature for legal validity (True/False).',
    `document_subtype` STRING COMMENT 'Detailed subtype classification within the document type category (e.g., MAWB, HAWB, MBL, HBL, Packing List, Certificate of Origin, Dangerous Goods Declaration). [ENUM-REF-CANDIDATE: MAWB|HAWB|MBL|HBL|Packing_List|Certificate_of_Origin|Dangerous_Goods_Declaration|Commercial_Invoice|Customs_Declaration|AMS_Filing|ISF_Filing|ePOD|Delivery_Receipt — promote to reference product]',
    `document_type_category` STRING COMMENT 'High-level classification of the document template by business purpose (transport document, trade document, customs document, compliance certificate, proof of delivery, commercial invoice).. Valid values are `transport_document|trade_document|customs_document|compliance_certificate|proof_of_delivery|commercial_invoice`',
    `edi_message_type` STRING COMMENT 'EDI message type code if the template generates EDI documents (e.g., IFTMIN, IFTMBC, CUSCAR, CUSRES). Nullable for non-EDI templates.',
    `file_hash` STRING COMMENT 'SHA-256 hash of the template file content for integrity verification and change detection.. Valid values are `^[a-fA-F0-9]{64}$`',
    `file_path` STRING COMMENT 'Storage location or URI of the physical template file in the document management system or content repository.',
    `jurisdiction_scope` STRING COMMENT 'Geographic or regulatory jurisdiction scope for which this template is designed (e.g., USA, EU, APAC, Global, specific country ISO codes). Pipe-separated list for multiple jurisdictions.',
    `language_code` STRING COMMENT 'Primary language code for the template content following ISO 639-1 (e.g., en, fr, de, zh, es). May include region code (e.g., en-US, fr-CA).. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_used_date` DATE COMMENT 'Date when this template was last used to generate a document. Used to identify inactive templates for retirement.',
    `layout_format` STRING COMMENT 'Primary output format for documents generated from this template (PDF, XML, EDI, JSON, HTML, DOCX).. Valid values are `PDF|XML|EDI|JSON|HTML|DOCX`',
    `mandatory_field_definitions` STRING COMMENT 'JSON or structured text defining the mandatory fields required in documents generated from this template, including field names, data types, and validation rules.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified this template record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this template record was last modified.',
    `multilingual_support` BOOLEAN COMMENT 'Indicates whether this template supports multiple languages or has localized variants (True/False).',
    `optional_field_definitions` STRING COMMENT 'JSON or structured text defining the optional fields that may be included in documents generated from this template.',
    `owner` STRING COMMENT 'Business unit, department, or role responsible for maintaining and approving changes to this template (e.g., Customs Compliance, Air Freight Operations, Legal Department).',
    `page_size_standard` STRING COMMENT 'Standard page size for documents generated from this template (A4, Letter, Legal, A3, Custom).. Valid values are `A4|Letter|Legal|A3|Custom`',
    `print_layout_orientation` STRING COMMENT 'Page orientation for printed documents generated from this template (portrait, landscape).. Valid values are `portrait|landscape`',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or authority that mandates or governs this document template (e.g., IATA, IMO, WCO, US CBP, EU Customs, FMC).',
    `regulatory_reference` STRING COMMENT 'Specific regulation, resolution, or legal reference that defines the requirements for this template (e.g., IATA Resolution 600b, IMO FAL Convention Annex 6, EU Regulation 952/2013).',
    `retention_period_years` STRING COMMENT 'Mandatory document retention period in years as required by regulatory or business policy (e.g., 7 years for customs documents, 5 years for transport documents).',
    `retention_trigger_event` STRING COMMENT 'Business event that triggers the start of the retention period (document creation, shipment completion, customs clearance, contract expiry, claim settlement).. Valid values are `document_creation|shipment_completion|customs_clearance|contract_expiry|claim_settlement`',
    `service_line` STRING COMMENT 'Primary service line or business unit for which this template is designed (express, air freight, ocean freight, road freight, rail freight, customs brokerage, warehousing, e-commerce, contract logistics). [ENUM-REF-CANDIDATE: express|air_freight|ocean_freight|road_freight|rail_freight|customs_brokerage|warehousing|ecommerce|contract_logistics — 9 candidates stripped; promote to reference product]',
    `signature_standard` STRING COMMENT 'Digital signature standard or technology used for documents generated from this template (PKI, eIDAS, ESIGN, DocuSign, AdobeSign, None).. Valid values are `PKI|eIDAS|ESIGN|DocuSign|AdobeSign|None`',
    `template_code` STRING COMMENT 'Unique business identifier code for the document template used across systems (e.g., AWB_STD_V3, BOL_OCEAN_FCL, POD_EXPRESS).. Valid values are `^[A-Z0-9_-]{4,20}$`',
    `template_name` STRING COMMENT 'Human-readable name of the document template (e.g., Standard Air Waybill, Ocean Bill of Lading, Electronic Proof of Delivery).',
    `template_status` STRING COMMENT 'Current lifecycle status of the template (draft, pending approval, active, deprecated, retired, suspended).. Valid values are `draft|pending_approval|active|deprecated|retired|suspended`',
    `usage_count` BIGINT COMMENT 'Total number of documents generated from this template since activation. Used for analytics and template optimization.',
    `version_effective_date` DATE COMMENT 'Date from which this template version becomes active and available for document generation.',
    `version_expiry_date` DATE COMMENT 'Date after which this template version is no longer valid for new document generation. Nullable for templates without planned expiration.',
    `version_number` STRING COMMENT 'Semantic version number of the template (e.g., 1.0, 2.1, 3.0.1) following major.minor.patch convention.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `watermark_required` BOOLEAN COMMENT 'Indicates whether documents generated from this template must include a watermark (e.g., DRAFT, CONFIDENTIAL, COPY) (True/False).',
    `watermark_text` STRING COMMENT 'Text to be displayed as watermark on documents generated from this template. Nullable if watermark is not required.',
    `xml_schema_version` STRING COMMENT 'Version of the XML schema used for XML-based templates (e.g., Cargo-XML 3.0, Cargo-IMP 1.2). Nullable for non-XML templates.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this template record.',
    CONSTRAINT pk_template PRIMARY KEY(`template_id`)
) COMMENT 'Master record defining reusable document templates used to generate transport, trade, and compliance documents. Captures template name, document type category, version number, applicable service line (express, freight, customs), jurisdiction scope, layout format (PDF, XML, EDI), mandatory field definitions, regulatory authority alignment, and active/inactive lifecycle status. Enables standardized document generation across all operational systems.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`version` (
    `version_id` BIGINT COMMENT 'Unique identifier for the document version record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or user who approved this document version for publication or use.',
    `declaration_id` BIGINT COMMENT 'Reference to the customs declaration this document version supports. Applicable for customs and trade compliance documents.',
    `superseded_version_id` BIGINT COMMENT 'Reference to the previous document version that this version replaces or supersedes. Null for the first version. Enables version chain traversal.',
    `template_id` BIGINT COMMENT 'Reference to the document template used to generate this version. Null if the document was not generated from a template.',
    `transport_document_id` BIGINT COMMENT 'Reference to the parent document entity for which this version record exists. Links to the master document record.',
    `version_employee_id` BIGINT COMMENT 'Reference to the employee or user who created or authored this document version.',
    `version_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this document version record. Audit trail field for accountability.',
    `access_control_level` STRING COMMENT 'The data classification level governing who may access this document version. Aligns with organizational information security policies.. Valid values are `public|internal|confidential|restricted`',
    `approval_date` DATE COMMENT 'The date this document version was formally approved for use. Null if version is not yet approved.',
    `approver_name` STRING COMMENT 'Full name of the person who approved this document version. Captured for audit trail and compliance verification.',
    `author_name` STRING COMMENT 'Full name of the person who created or authored this document version. Captured for audit trail and accountability.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the business reason for creating this version. Used for categorizing version changes for compliance and audit purposes.. Valid values are `amendment|correction|regulatory_update|customer_request|internal_review|system_migration`',
    `change_summary` STRING COMMENT 'Brief textual summary describing the changes made in this version compared to the previous version. Provides context for version history and audit trail.',
    `checksum_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA-256) of the document artifact for integrity verification. Ensures the document has not been tampered with or corrupted.',
    `compliance_classification` STRING COMMENT 'The regulatory or compliance domain this document version supports. Used to apply appropriate retention and handling rules. [ENUM-REF-CANDIDATE: customs|trade|safety|environmental|financial|contractual|operational — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this document version record was first created in the system. Audit trail field for record creation.',
    `digital_signature` STRING COMMENT 'Digital signature applied to this document version for authenticity and non-repudiation. Supports regulatory compliance for legally binding documents.',
    `document_artifact_uri` STRING COMMENT 'The storage location URI or path reference to the physical document artifact (PDF, DOCX, XML, etc.) for this version. Points to the binary file in the document repository.',
    `document_format` STRING COMMENT 'The file format or MIME type of the document artifact for this version. Indicates the technical format of the stored document. [ENUM-REF-CANDIDATE: PDF|DOCX|XML|JSON|EDI|CSV|XLSX|TXT — 8 candidates stripped; promote to reference product]',
    `document_size_bytes` BIGINT COMMENT 'The file size of the document artifact in bytes. Used for storage management and transmission planning.',
    `effective_from_date` DATE COMMENT 'The date from which this document version becomes effective and should be used for business operations. May differ from version_date for planned future releases.',
    `effective_until_date` DATE COMMENT 'The date until which this document version remains effective. Null for currently active versions with no planned end date.',
    `is_master_version` BOOLEAN COMMENT 'Indicates whether this version is designated as the master or authoritative version of the document. True if master, false otherwise.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the primary language of this document version (e.g., en, es, fr, de, zh).. Valid values are `^[a-z]{2}$`',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether this document version is subject to a legal hold and must not be destroyed regardless of retention policy. True if under legal hold, false otherwise.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this document version record was last modified. Audit trail field for record updates.',
    `notes` STRING COMMENT 'Free-text field for additional comments, instructions, or context related to this document version. Used for operational notes and special handling instructions.',
    `page_count` STRING COMMENT 'The number of pages in this document version. Applicable for paginated document formats such as PDF or DOCX.',
    `retention_expiry_date` DATE COMMENT 'The date after which this document version may be eligible for destruction per retention policy. Calculated from effective date plus retention period.',
    `retention_period_years` STRING COMMENT 'The number of years this document version must be retained per regulatory or business policy requirements. Used to calculate retention expiry date.',
    `signature_timestamp` TIMESTAMP COMMENT 'The timestamp when the digital signature was applied to this document version. Provides temporal proof for legal and compliance purposes.',
    `version_date` DATE COMMENT 'The date this version was created or published. Represents the business event timestamp for this version iteration.',
    `version_number` STRING COMMENT 'Semantic version identifier for this document iteration (e.g., 1.0, 1.1, 2.0). Follows semantic versioning convention where major.minor.patch indicates the level of change.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `version_status` STRING COMMENT 'Current lifecycle status of this document version. Indicates whether the version is in draft, under review, approved for use, currently active, superseded by a newer version, or archived.. Valid values are `draft|pending_review|approved|active|superseded|archived`',
    CONSTRAINT pk_version PRIMARY KEY(`version_id`)
) COMMENT 'Transactional record capturing every version iteration of a transport or trade document throughout its lifecycle. Tracks version number, version date, change summary, author, approval status, superseded version reference, change reason code (amendment, correction, regulatory update), and the binary or URI reference to the versioned document artifact. Supports full document amendment history and audit trail for regulatory retention compliance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`trade_document` (
    `trade_document_id` BIGINT COMMENT 'Unique identifier for the trade document record. Primary key for the trade document entity.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Trade documents (commercial invoices, packing lists, certificates of origin) reference the carrier for customs clearance and regulatory compliance. Customs authorities require carrier identification o',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Trade documents (commercial invoice, packing list) are mandatory supporting documents for customs declarations - every declaration filing requires linking to specific trade documents for valuation and',
    `previous_version_trade_document_id` BIGINT COMMENT 'Foreign key reference to the previous version of this trade document. Enables version history tracking and change audit.',
    `template_id` BIGINT COMMENT 'Foreign key reference to the document template used to generate this trade document. Ensures standardization and compliance with regulatory formats.',
    `superseded_trade_document_id` BIGINT COMMENT 'Self-referencing FK on trade_document (superseded_trade_document_id)',
    `archival_date` DATE COMMENT 'Date when this trade document was moved to archival storage. Nullable for active documents.',
    `authentication_method` STRING COMMENT 'Method used to authenticate and validate the trade document. Determines legal acceptance across jurisdictions.. Valid values are `digital_signature|notarized|apostille|embassy_legalization|chamber_stamp|none`',
    `authentication_status` STRING COMMENT 'Current status of the document authentication process. Indicates whether the document has been successfully verified by the required authority.. Valid values are `pending|verified|failed|not_required`',
    `awb_number` STRING COMMENT 'Air Waybill number associated with this trade document for air freight shipments. Format follows IATA standard (3-digit airline prefix + 8-digit serial number).. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with this trade document for ocean or ground freight shipments. Serves as receipt, contract of carriage, and document of title.',
    `commodity_description` STRING COMMENT 'Detailed description of the goods or commodities documented in this trade document. Must be sufficient for customs classification and inspection.',
    `consignee_name` STRING COMMENT 'Name of the party to whom the goods are consigned. May differ from importer in cases of third-party logistics or freight forwarding.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade document record was first created in the system. Audit trail field.',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'Total declared value of goods documented in this trade document. Used for customs duty assessment, insurance, and liability determination.',
    `declared_value_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the declared value amount.. Valid values are `^[A-Z]{3}$`',
    `denied_party_screening_status` STRING COMMENT 'Status of denied party screening for all parties named in this trade document. Ensures compliance with export control and sanctions regulations.. Valid values are `not_screened|cleared|flagged|under_review`',
    `destination_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the final destination country for goods documented in this trade document.. Valid values are `^[A-Z]{3}$`',
    `digital_signature` STRING COMMENT 'Cryptographic digital signature hash for electronically signed trade documents. Ensures document integrity and non-repudiation.',
    `document_number` STRING COMMENT 'Externally-known unique business identifier for the trade document. Used for cross-border reference and customs clearance tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `document_status` STRING COMMENT 'Current lifecycle status of the trade document in the document management workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|issued|submitted|accepted|rejected|expired|cancelled — 9 candidates stripped; promote to reference product]',
    `document_type` STRING COMMENT 'Classification of the trade document indicating its purpose in international trade. Determines regulatory requirements and customs processing rules.. Valid values are `commercial_invoice|packing_list|certificate_of_origin|phytosanitary_certificate|fumigation_certificate|inspection_certificate`',
    `expiry_date` DATE COMMENT 'Date when the trade document validity expires. Nullable for documents without expiration. Critical for certificates and time-sensitive trade documents.',
    `exporter_name` STRING COMMENT 'Legal name of the exporting party as declared on the trade document. Must match customs and trade compliance records.',
    `exporter_tax_number` STRING COMMENT 'Tax identification number or business registration number of the exporter. Used for customs clearance and trade compliance verification.',
    `freight_charges_amount` DECIMAL(18,2) COMMENT 'Total freight charges amount documented in this trade document. Used for cost allocation and duty calculation under CIF/CFR terms.',
    `hs_code` STRING COMMENT 'Harmonized System tariff classification code for goods documented in this trade document. Used for customs duty calculation and trade statistics.. Valid values are `^[0-9]{6,10}$`',
    `importer_name` STRING COMMENT 'Legal name of the importing party as declared on the trade document. Must match customs entry and import license records.',
    `importer_tax_number` STRING COMMENT 'Tax identification number or business registration number of the importer. Required for customs clearance and duty assessment.',
    `incoterm_code` STRING COMMENT 'International Commercial Terms code defining the responsibilities, costs, and risks between buyer and seller. Follows ICC Incoterms 2020 standard. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_amount` DECIMAL(18,2) COMMENT 'Insurance coverage amount for goods documented in this trade document. Nullable if no insurance is declared.',
    `issue_date` DATE COMMENT 'Date when the trade document was officially issued by the issuing authority or organization.',
    `issuing_authority` STRING COMMENT 'Name of the organization, government agency, or authorized body that issued the trade document. Examples include chambers of commerce, customs authorities, inspection agencies.',
    `issuing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the document was issued.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade document record was last modified. Audit trail field for change tracking.',
    `letter_of_credit_number` STRING COMMENT 'Letter of credit reference number if this trade document is part of a documentary credit transaction. Nullable for non-LC shipments.',
    `notify_party_name` STRING COMMENT 'Name of the party to be notified upon arrival of goods. Typically used in ocean freight and international shipments.',
    `origin_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country of origin for goods documented in this trade document. Used for tariff classification and preferential trade agreement determination.. Valid values are `^[A-Z]{3}$`',
    `package_type` STRING COMMENT 'Type of packaging used for goods documented in this trade document. Follows UN/CEFACT packaging type codes. [ENUM-REF-CANDIDATE: carton|pallet|crate|drum|bag|bundle|container — 7 candidates stripped; promote to reference product]',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this trade document has passed all required regulatory compliance checks (C-TPAT, AEO, denied party screening, export control).',
    `retention_period_years` STRING COMMENT 'Number of years this trade document must be retained per regulatory requirements. Varies by document type and jurisdiction.',
    `total_gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of goods documented in this trade document, measured in kilograms. Includes packaging and container weight.',
    `total_net_weight_kg` DECIMAL(18,2) COMMENT 'Total net weight of goods documented in this trade document, measured in kilograms. Excludes packaging weight.',
    `total_package_count` STRING COMMENT 'Total number of packages, cartons, pallets, or shipping units documented in this trade document.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of goods documented in this trade document, measured in cubic meters. Used for freight rating and capacity planning.',
    `version_number` STRING COMMENT 'Sequential version number for the trade document. Increments with each revision to maintain document history and audit trail.',
    CONSTRAINT pk_trade_document PRIMARY KEY(`trade_document_id`)
) COMMENT 'Master record for all international trade documents managed by Transport Shipping in support of cross-border logistics operations. Covers commercial invoices, packing lists, certificates of origin, phytosanitary certificates, fumigation certificates, inspection certificates, and letters of credit documentation. Captures document type, issuing authority, country of origin, country of destination, associated customs declaration reference, validity period, and authentication status.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`digital_signature` (
    `digital_signature_id` BIGINT COMMENT 'Unique identifier for the digital signature record. Primary key.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment associated with the signed document, enabling linkage between signature events and freight movements.',
    `employee_id` BIGINT COMMENT 'Reference to the individual or party who applied the digital signature (driver, customs officer, customer representative, warehouse manager).',
    `transport_document_id` BIGINT COMMENT 'Reference to the transport or trade document that was digitally signed (AWB, BOL, POD, customs declaration, etc.).',
    `countersigned_digital_signature_id` BIGINT COMMENT 'Self-referencing FK on digital_signature (countersigned_digital_signature_id)',
    `awb_number` STRING COMMENT 'Air Waybill number associated with the signed document, if applicable (IATA standard 11-digit AWB format).',
    `biometric_data_captured_flag` BOOLEAN COMMENT 'Indicates whether biometric data (fingerprint, facial recognition, signature dynamics) was captured as part of the signature process for enhanced authentication.',
    `biometric_data_type` STRING COMMENT 'Type of biometric data captured during the signature process, if applicable (fingerprint, facial recognition, signature dynamics).. Valid values are `fingerprint|facial_recognition|signature_dynamics|iris_scan|voice_recognition`',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with the signed document, if applicable (ocean or inland BOL).',
    `certificate_authority` STRING COMMENT 'Name of the trusted certificate authority or trust service provider that issued the digital certificate used for the signature (e.g., DigiCert, GlobalSign, national CA).',
    `certificate_serial_number` STRING COMMENT 'Unique serial number of the digital certificate used to create the signature, enabling certificate validation and revocation checking.',
    `consent_accepted_flag` BOOLEAN COMMENT 'Indicates whether the signatory explicitly accepted the consent statement or terms and conditions before applying the signature.',
    `consent_statement` STRING COMMENT 'Text of the consent or acknowledgment statement presented to the signatory at the time of signing (e.g., I acknowledge receipt of goods in good condition).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this digital signature record was first created in the database, supporting audit trail and data lineage.',
    `document_type` STRING COMMENT 'Type or category of the document that was signed (AWB, BOL, POD, customs declaration, delivery receipt, contract, invoice).',
    `document_version_number` STRING COMMENT 'Version identifier of the document at the time of signature application, ensuring signature is tied to a specific immutable version.',
    `hash_algorithm` STRING COMMENT 'Cryptographic hash algorithm used to generate the signature hash (SHA-256, SHA-512, etc.), critical for security and compliance validation.. Valid values are `SHA-256|SHA-384|SHA-512|SHA3-256|SHA3-512`',
    `ip_address` STRING COMMENT 'IP address of the device or network from which the signature was applied, used for audit trail and fraud detection.',
    `legal_jurisdiction` STRING COMMENT 'Country or legal jurisdiction under which the digital signature is considered legally binding (ISO 3166 country code or jurisdiction name).',
    `legal_validity_flag` BOOLEAN COMMENT 'Indicates whether the signature meets the legal requirements for enforceability in the applicable jurisdiction at the time of signing.',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by the signatory or system at the time of signing (e.g., delivery conditions, exceptions, special instructions).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the digital signature meets all applicable regulatory requirements for the document type and jurisdiction (eIDAS, ESIGN, customs regulations).',
    `retention_expiry_date` DATE COMMENT 'Date when the digital signature record becomes eligible for deletion or archival per document retention policy.',
    `retention_period_years` STRING COMMENT 'Number of years the digital signature record and associated document must be retained per regulatory or contractual requirements.',
    `signatory_email` STRING COMMENT 'Email address of the signatory used for signature verification and notification purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `signatory_name` STRING COMMENT 'Full legal name of the individual who applied the digital signature, captured at the time of signing for legal validity.',
    `signatory_role` STRING COMMENT 'Business role or capacity in which the signatory applied the signature (driver for POD, customs officer for clearance, customer for acceptance). [ENUM-REF-CANDIDATE: driver|warehouse_manager|customs_officer|customer_representative|freight_forwarder|carrier_agent|authorized_signatory|consignee|shipper — 9 candidates stripped; promote to reference product]',
    `signature_hash` STRING COMMENT 'Cryptographic hash value of the signed document content, ensuring document integrity and detecting any post-signature tampering.',
    `signature_image_url` STRING COMMENT 'URL or storage path to the visual image of the captured signature (handwritten signature image, scanned signature), stored in secure document repository.',
    `signature_method` STRING COMMENT 'Technical method or platform used to capture and apply the digital signature (PKI certificate, biometric ePOD device, DocuSign, Adobe Sign, mobile app). [ENUM-REF-CANDIDATE: pki_certificate|biometric_epod|docusign|adobe_sign|qualified_electronic_signature|advanced_electronic_signature|simple_electronic_signature|handwritten_digital_capture|mobile_app_signature — 9 candidates stripped; promote to reference product]',
    `signature_purpose` STRING COMMENT 'Business purpose or intent of the signature (proof of delivery, customs clearance, contract acceptance, goods receipt acknowledgment). [ENUM-REF-CANDIDATE: proof_of_delivery|customs_clearance|contract_acceptance|goods_receipt|damage_acknowledgment|authorization|approval|witness — 8 candidates stripped; promote to reference product]',
    `signature_reference_number` STRING COMMENT 'Externally-known unique reference number or transaction ID for this digital signature event, used for audit trails and legal verification.',
    `signature_status` STRING COMMENT 'Current validation status of the digital signature indicating whether it remains legally valid and cryptographically intact.. Valid values are `valid|invalid|revoked|expired|pending_verification|verification_failed`',
    `signature_timestamp` TIMESTAMP COMMENT 'Precise date and time when the digital signature was applied to the document, in UTC. Critical for legal validity and audit compliance.',
    `signature_type` STRING COMMENT 'Legal classification of the electronic signature per eIDAS or equivalent framework: qualified (highest assurance), advanced (medium assurance), or simple (basic).. Valid values are `qualified|advanced|simple`',
    `signing_device_code` STRING COMMENT 'Unique identifier of the device used to capture the signature (device serial number, IMEI, MAC address), used for audit and fraud detection.',
    `signing_device_type` STRING COMMENT 'Type of device or platform used to capture the signature (mobile device, tablet, handheld ePOD scanner, biometric pad, web browser). [ENUM-REF-CANDIDATE: mobile_device|tablet|desktop|handheld_scanner|biometric_pad|web_browser|kiosk — 7 candidates stripped; promote to reference product]',
    `signing_location_address` STRING COMMENT 'Physical address or location description where the signature was captured (delivery address, warehouse location, customs office).',
    `signing_location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate where the signature was captured, supporting proof of delivery and location-based compliance verification.',
    `signing_location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate where the signature was captured, supporting proof of delivery and location-based compliance verification.',
    `signing_platform` STRING COMMENT 'Name of the software platform or application used to apply the signature (DocuSign, Adobe Sign, proprietary TMS/WMS module, mobile app name).',
    `timestamp_authority` STRING COMMENT 'Name of the trusted timestamp authority (TSA) that provided the cryptographic timestamp for the signature, ensuring non-repudiation of signing time.',
    `timestamp_token` STRING COMMENT 'Cryptographic timestamp token issued by the timestamp authority, binding the signature to a specific point in time for legal and audit purposes.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this digital signature record was last modified, supporting audit trail and change tracking.',
    `verification_result` STRING COMMENT 'Outcome of the most recent signature verification check, indicating whether the signature remains cryptographically valid and legally binding.. Valid values are `verified|failed|certificate_revoked|certificate_expired|hash_mismatch|not_verified`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the digital signature was last verified or validated against the certificate authority and document integrity checks.',
    CONSTRAINT pk_digital_signature PRIMARY KEY(`digital_signature_id`)
) COMMENT 'Transactional record capturing electronic and digital signature events applied to transport and trade documents. Records signatory identity, signature timestamp, signature method (PKI, biometric ePOD, DocuSign, Adobe Sign), certificate authority, signature hash, document version signed, signing device or platform, and legal validity jurisdiction. Supports ePOD (electronic proof of delivery), e-AWB adoption, and regulatory e-signature compliance across jurisdictions.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`retention_policy` (
    `retention_policy_id` BIGINT COMMENT 'Unique identifier for the document retention policy record. Primary key.',
    `superseded_by_policy_retention_policy_id` BIGINT COMMENT 'Reference to the retention policy that replaces this policy when status is superseded. Null if policy is active or not superseded.',
    `superseded_retention_policy_id` BIGINT COMMENT 'Self-referencing FK on retention_policy (superseded_retention_policy_id)',
    `applies_to_digital` BOOLEAN COMMENT 'Indicates whether this retention policy applies to digital/electronic documents. True if policy governs electronic records.',
    `applies_to_physical` BOOLEAN COMMENT 'Indicates whether this retention policy applies to physical/paper documents. True if policy governs hard-copy records.',
    `approval_authority` STRING COMMENT 'Role or individual who approved this retention policy (e.g., Chief Compliance Officer, General Counsel, Data Protection Officer). Used for governance and accountability.',
    `approval_date` DATE COMMENT 'Date when this retention policy was formally approved by the designated authority. Establishes policy legitimacy and audit trail.',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether an audit trail of document access, modifications, and destruction must be maintained. True for regulatory and compliance-driven policies.',
    `automated_purge_enabled` BOOLEAN COMMENT 'Indicates whether automated document purge/destruction is enabled for this policy. True if system can automatically delete documents at end of retention period (subject to legal hold checks).',
    `business_owner` STRING COMMENT 'Business unit or department responsible for maintaining and enforcing this retention policy (e.g., Legal Department, Compliance, Finance, Operations).',
    `contact_email` STRING COMMENT 'Email address of the policy owner or responsible party for questions and clarifications regarding this retention policy.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention policy record was first created in the system. Used for audit trail and policy lifecycle tracking.',
    `destruction_authorization_required` BOOLEAN COMMENT 'Indicates whether formal authorization (e.g., legal counsel approval, compliance officer sign-off) is required before document destruction. True if authorization is mandatory.',
    `destruction_method` STRING COMMENT 'Approved method for document destruction at end of retention period (e.g., secure_shred for paper, digital_purge for electronic records, incineration for sensitive materials, archive_transfer for permanent records).. Valid values are `secure_shred|digital_purge|incineration|degaussing|overwrite|archive_transfer`',
    `document_category` STRING COMMENT 'Broad category of documents governed by this policy (e.g., Transport Documents, Customs and Trade, Financial Records, Employee Records, Contracts and Agreements, Insurance and Claims). [ENUM-REF-CANDIDATE: Transport Documents|Customs and Trade|Financial Records|Employee Records|Contracts and Agreements|Insurance and Claims|Operational Logs|Safety and Compliance|Customer Communications — promote to reference product]',
    `document_type` STRING COMMENT 'Specific document type(s) covered by this policy (e.g., Air Waybill (AWB), Bill of Lading (BOL), Customs Declaration, Commercial Invoice, Proof of Delivery (POD), Tax Invoice). Multiple types may be comma-separated if policy applies broadly.',
    `effective_end_date` DATE COMMENT 'Date when this retention policy ceases to be active. Null if policy is currently active and has no planned end date. Used when policy is superseded or retired.',
    `effective_start_date` DATE COMMENT 'Date when this retention policy becomes active and enforceable. Documents created or received on or after this date are governed by this policy.',
    `encryption_required` BOOLEAN COMMENT 'Indicates whether documents governed by this policy must be encrypted at rest and in transit. True for policies covering sensitive or regulated data (e.g., PII, financial records).',
    `exception_criteria` STRING COMMENT 'Conditions under which documents may be retained longer or shorter than the standard policy (e.g., Retain indefinitely if involved in litigation, Early destruction allowed with legal counsel approval).',
    `governing_body` STRING COMMENT 'Regulatory authority or standards organization mandating this retention policy (e.g., IATA, US CBP, HMRC, EU Customs, DOT, IMO, IRS, SOX, GDPR). Multiple bodies may be comma-separated.',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction where this policy applies (e.g., USA, GBR, DEU, European Union, Global). Use ISO 3166-1 alpha-3 country codes where applicable.',
    `last_review_date` DATE COMMENT 'Date when this retention policy was last reviewed and validated by compliance or legal teams. Used to track review currency and trigger next review.',
    `legal_citation` STRING COMMENT 'Specific legal statute, regulation, or standard reference mandating the retention requirement (e.g., 19 CFR 163.4, IATA Resolution 600a, SOX Section 802, GDPR Article 5(1)(e)).',
    `legal_hold_override_allowed` BOOLEAN COMMENT 'Indicates whether this retention policy can be overridden by a legal hold (litigation hold, regulatory investigation). False means documents must be retained indefinitely if legal hold is active.',
    `maximum_retention_years` DECIMAL(18,2) COMMENT 'Maximum number of years the document may be retained before mandatory destruction, if applicable. Null if no maximum is defined. Used for privacy compliance (e.g., GDPR data minimization).',
    `minimum_retention_years` DECIMAL(18,2) COMMENT 'Minimum number of years the document must be retained from the trigger date (e.g., 7.00 years for IATA air waybills, 5.00 years for US customs records). Supports fractional years for precise compliance.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this retention policy record. Used for accountability and audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this retention policy record was last modified. Updated whenever policy attributes are changed. Used for change tracking and audit.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory policy review. Calculated from last_review_date plus review_frequency_months.',
    `notification_before_destruction_days` STRING COMMENT 'Number of days before scheduled destruction that stakeholders should be notified (e.g., 30 days advance notice). Allows final review before permanent deletion.',
    `policy_code` STRING COMMENT 'Unique alphanumeric code identifying the retention policy for system reference and integration (e.g., AWB-7Y-IATA, BOL-5Y-FMC).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `policy_description` STRING COMMENT 'Detailed narrative description of the retention policy, including business rationale, regulatory drivers, scope, and special handling instructions.',
    `policy_name` STRING COMMENT 'Business-friendly name of the retention policy (e.g., Air Waybill 7-Year Retention, Customs Declaration EU Retention).',
    `policy_status` STRING COMMENT 'Current lifecycle status of the retention policy. Active policies are enforced; superseded policies have been replaced by newer versions; suspended policies are temporarily not enforced.. Valid values are `active|inactive|draft|superseded|suspended|archived`',
    `policy_type` STRING COMMENT 'Classification of the retention policy driver: regulatory (mandated by law), legal (litigation hold), operational (business need), contractual (agreement requirement), tax (fiscal authority), or audit (compliance verification).. Valid values are `regulatory|legal|operational|contractual|tax|audit`',
    `privacy_classification` STRING COMMENT 'Data classification level of documents governed by this policy. Determines access controls and destruction rigor (e.g., restricted for documents containing PII, confidential for business-sensitive records).. Valid values are `public|internal|confidential|restricted|pii|phi`',
    `retention_trigger_event` STRING COMMENT 'Business event that starts the retention clock (e.g., document_creation, shipment_completion, invoice_payment, contract_expiry). Determines when the retention period begins counting. [ENUM-REF-CANDIDATE: document_creation|shipment_completion|invoice_payment|contract_expiry|claim_closure|fiscal_year_end|employee_termination — 7 candidates stripped; promote to reference product]',
    `review_frequency_months` STRING COMMENT 'Number of months between mandatory policy reviews to ensure continued regulatory alignment and business relevance (e.g., 12 for annual review, 24 for biennial review).',
    `storage_location_requirement` STRING COMMENT 'Mandated or preferred storage location type for documents under this policy (e.g., on_premise for regulated records, cloud for operational documents, secure_archive for long-term retention).. Valid values are `on_premise|cloud|hybrid|secure_archive|offsite_vault`',
    `version_number` STRING COMMENT 'Version identifier for this retention policy (e.g., 1.0, 2.1). Incremented when policy is revised. Supports policy change tracking and audit.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_retention_policy PRIMARY KEY(`retention_policy_id`)
) COMMENT 'Master reference record defining regulatory document retention policies applicable to Transport Shippings document portfolio. Captures policy name, applicable document type categories, minimum retention period (years), maximum retention period, governing regulatory body (IATA, CBP, HMRC, EU Customs, DOT), jurisdiction scope, destruction authorization requirements, legal hold override rules, and policy effective date. Drives automated document lifecycle management and purge scheduling.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`issuance` (
    `issuance_id` BIGINT COMMENT 'Unique identifier for the document issuance event. Primary key for the document issuance record.',
    `broker_assignment_id` BIGINT COMMENT 'Foreign key linking to customs.customs_broker_assignment. Business justification: Document issuance events (Power of Attorney, filing confirmations, release notices) are tied to specific broker assignments - operational tracking of broker-issued documents and authorization manageme',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Document issuance events track which carrier received or issued the document. Critical for operational handoffs—e.g., tracking when carrier received manifest, when AWB was issued to carrier operations',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment record associated with this document issuance, if applicable. Links the document to the physical movement of goods.',
    `certificate_id` BIGINT COMMENT 'Identifier of the digital certificate used to sign the document, if digital signature was applied.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or system user who executed the document issuance action.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the customer order or freight order associated with this document issuance, if applicable.',
    `issuing_entity_trade_party_id` BIGINT COMMENT 'Reference to the Transport Shipping office, branch, agent, or organizational unit that issued the document.',
    `original_issuance_id` BIGINT COMMENT 'Reference to the original document issuance record if this is a duplicate, copy, amendment, or reissue. Null for original issuances.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Network partners (hubs, gateways, customs brokers) issue documents as part of their operational role. Tracking which partner issued a document is required for accountability and operational audit trai',
    `trade_party_id` BIGINT COMMENT 'Reference to the counterparty (customer, shipper, consignee, customs broker, carrier, agent) to whom the document was issued.',
    `transport_document_id` BIGINT COMMENT 'Reference to the master document record that was issued. Links to the document product in the document domain.',
    `type_id` BIGINT COMMENT 'FK to document.document_type',
    `reissued_issuance_id` BIGINT COMMENT 'Self-referencing FK on issuance (reissued_issuance_id)',
    `acknowledgement_reference` STRING COMMENT 'Reference number or confirmation code provided by the recipient or delivery system confirming successful receipt.',
    `acknowledgement_status` STRING COMMENT 'Status indicating whether the recipient has acknowledged receipt of the issued document. Tracks delivery confirmation and recipient acceptance.. Valid values are `pending|acknowledged|not_acknowledged|failed`',
    `acknowledgement_timestamp` TIMESTAMP COMMENT 'Date and time when the recipient acknowledged receipt of the document. Null if not yet acknowledged.',
    `cancellation_reason` STRING COMMENT 'Business reason or explanation for why this document issuance was cancelled, if applicable.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when this document issuance was cancelled, if applicable. Null if not cancelled.',
    `checksum_hash` STRING COMMENT 'SHA-256 cryptographic hash of the issued document file for integrity verification and tamper detection.. Valid values are `^[a-fA-F0-9]{64}$`',
    `compliance_validation_timestamp` TIMESTAMP COMMENT 'Date and time when regulatory compliance validation was performed for this issuance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this document issuance record was first created in the system. Audit trail timestamp for record creation.',
    `delivery_channel` STRING COMMENT 'Channel or method through which the document was delivered to the recipient. Email (electronic mail), EDI (Electronic Data Interchange), portal (web portal), API (Application Programming Interface), physical (printed/courier), fax (facsimile).. Valid values are `email|edi|portal|api|physical|fax`',
    `delivery_method_detail` STRING COMMENT 'Additional technical details about the delivery method, such as EDI message type, API endpoint, courier service name, or portal URL.',
    `digital_signature_applied` BOOLEAN COMMENT 'Boolean flag indicating whether a digital signature was applied to the document for authentication and non-repudiation purposes.',
    `document_storage_path` STRING COMMENT 'File system path or cloud storage location where the issued document is stored. Confidential for security purposes.',
    `document_version_number` STRING COMMENT 'Version number of the document template or content that was issued. Supports document versioning and change tracking.',
    `expiry_date` DATE COMMENT 'Date when this document issuance expires or becomes invalid, if applicable. Null for documents without expiration.',
    `file_format` STRING COMMENT 'Digital file format in which the document was issued. PDF (Portable Document Format), XML (Extensible Markup Language), EDI (Electronic Data Interchange), JSON (JavaScript Object Notation), TIFF (Tagged Image File Format), DOCX (Microsoft Word).. Valid values are `PDF|XML|EDI|JSON|TIFF|DOCX`',
    `file_size_bytes` BIGINT COMMENT 'Size of the issued document file in bytes. Used for storage management and transmission monitoring.',
    `issuance_status` STRING COMMENT 'Current lifecycle status of the document issuance. Tracks whether the issuance is pending, successfully issued, acknowledged by recipient, rejected, cancelled, or expired.. Valid values are `pending|issued|acknowledged|rejected|cancelled|expired`',
    `issuance_timestamp` TIMESTAMP COMMENT 'Date and time when the document was officially issued to the recipient party. Represents the authoritative issuance event time in the business process.',
    `issuing_location_code` STRING COMMENT 'Three-letter IATA or UN/LOCODE code representing the geographic location where the document was issued.. Valid values are `^[A-Z]{3}$`',
    `issuing_system_code` STRING COMMENT 'Code identifying the operational system or channel that generated the issuance. SAP_TM (SAP Transportation Management), ORACLE_TMS (Oracle TMS), DESCARTES (Descartes Customs), MANUAL (manual issuance), EDI (Electronic Data Interchange), API (Application Programming Interface).. Valid values are `SAP_TM|ORACLE_TMS|DESCARTES|MANUAL|EDI|API`',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the document was issued.. Valid values are `^[a-z]{2}$`',
    `last_transmission_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent transmission attempt, whether successful or failed.',
    `notes` STRING COMMENT 'Free-text notes or comments about this document issuance event. Used for special instructions, exceptions, or additional context.',
    `purpose` STRING COMMENT 'Purpose or reason for this specific issuance event. Original (first issuance), duplicate (additional copy), copy (informational copy), amendment (revised version), correction (error correction), reissue (replacement).. Valid values are `original|duplicate|copy|amendment|correction|reissue`',
    `recipient_contact_name` STRING COMMENT 'Full name of the individual contact person at the recipient organization who received the document.',
    `recipient_email_address` STRING COMMENT 'Email address to which the document was sent if delivered electronically via email channel.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_party_type` STRING COMMENT 'Classification of the recipient party role in the logistics transaction. Identifies whether the recipient is the shipper, consignee, customs broker, carrier, freight forwarder, or agent.. Valid values are `shipper|consignee|customs_broker|carrier|freight_forwarder|agent`',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this specific issuance event. Used for tracking and audit purposes.. Valid values are `^[A-Z0-9]{8,20}$`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this document issuance meets all applicable regulatory and compliance requirements for the jurisdiction and document type.',
    `retention_period_days` STRING COMMENT 'Number of days this document issuance record must be retained per regulatory and business retention policies.',
    `transmission_attempt_count` STRING COMMENT 'Number of attempts made to transmit the document to the recipient. Used for tracking delivery reliability and troubleshooting.',
    `transmission_error_message` STRING COMMENT 'Technical error message or description if the document transmission failed. Used for troubleshooting and support.',
    `transmission_status` STRING COMMENT 'Technical status of the document transmission process. Tracks whether the document is queued for delivery, currently being transmitted, successfully transmitted, failed, or retrying after failure.. Valid values are `queued|in_progress|transmitted|failed|retrying`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this document issuance record was last modified. Audit trail timestamp for record updates.',
    CONSTRAINT pk_issuance PRIMARY KEY(`issuance_id`)
) COMMENT 'Transactional record capturing the formal issuance event of a transport or trade document to a counterparty. Records issuance date and time, issuing entity (Transport Shipping office, agent, or system), recipient party type (shipper, consignee, customs broker, carrier), delivery channel (email, EDI, portal, physical), acknowledgement status, and issuance reference number. Provides the authoritative audit trail of when and to whom each document was officially issued.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`document_package` (
    `document_package_id` BIGINT COMMENT 'Unique identifier for the document package. Primary key.',
    `agreement_id` BIGINT COMMENT 'Reference to the contract or agreement associated with this document package, if applicable.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Document packages are assembled for specific carriers as part of shipment documentation requirements. Carriers have specific documentation requirements (e.g., airline-specific cargo documentation pack',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment associated with this document package, if applicable.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer or party who owns or is the primary stakeholder of this document package.',
    `employee_id` BIGINT COMMENT 'Reference to the user or employee who reviewed or approved the document package.',
    `template_id` BIGINT COMMENT 'Reference to the document template used to define the required documents and structure for this package.',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: 3PL providers assemble and manage document packages for shipments they control. Linking packages to 3PL providers enables tracking of documentation completeness and compliance responsibility.',
    `parent_document_package_id` BIGINT COMMENT 'Self-referencing FK on document_package (parent_document_package_id)',
    `approval_date` DATE COMMENT 'Date when the document package was approved by the relevant authority or internal reviewer.',
    `archive_date` DATE COMMENT 'Date when the document package was archived.',
    `archive_flag` BOOLEAN COMMENT 'Indicates whether the document package has been archived and is no longer actively used.',
    `awb_number` STRING COMMENT 'Air Waybill number associated with this document package for air freight shipments.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with this document package for ocean or ground freight shipments.. Valid values are `^BOL-[A-Z0-9]{8,15}$`',
    `completeness_status` STRING COMMENT 'Indicator of whether all required documents in the package are present and validated.. Valid values are `complete|incomplete|pending_review|missing_critical`',
    `compliance_review_required_flag` BOOLEAN COMMENT 'Indicates whether the document package requires a compliance or regulatory review before submission or release.',
    `compliance_review_status` STRING COMMENT 'Current status of the compliance review process for the document package.. Valid values are `not_required|pending|in_review|approved|rejected`',
    `creation_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the document package record was first created in the system.',
    `customs_entry_number` STRING COMMENT 'Official customs entry or declaration number assigned by customs authorities for clearance processing.. Valid values are `^[A-Z0-9]{10,20}$`',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code representing the destination country for the shipment or goods.. Valid values are `^[A-Z]{3}$`',
    `digital_signature_flag` BOOLEAN COMMENT 'Indicates whether the document package includes digitally signed documents for authenticity and non-repudiation.',
    `encryption_flag` BOOLEAN COMMENT 'Indicates whether the documents in the package are encrypted for security and confidentiality.',
    `expiry_date` DATE COMMENT 'Date when the document package or its associated documents expire and are no longer valid for use.',
    `hawb_number` STRING COMMENT 'House Air Waybill number issued by freight forwarders for individual consignments within a consolidated shipment.. Valid values are `^[A-Z0-9]{8,15}$`',
    `hbl_number` STRING COMMENT 'House Bill of Lading number issued by freight forwarders for individual consignments within a consolidated ocean shipment.. Valid values are `^HBL-[A-Z0-9]{8,15}$`',
    `incoterm` STRING COMMENT 'Incoterm code defining the responsibilities and risks between buyer and seller in the shipment transaction. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update or modification to the document package record.',
    `mawb_number` STRING COMMENT 'Master Air Waybill number for consolidated air freight shipments.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `mbl_number` STRING COMMENT 'Master Bill of Lading number for consolidated ocean freight shipments.. Valid values are `^MBL-[A-Z0-9]{8,15}$`',
    `missing_document_count` STRING COMMENT 'Number of required documents that are still missing from the package.',
    `missing_document_list` STRING COMMENT 'Comma-separated list of document types or names that are required but not yet received.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the document package, including special instructions or exceptions.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO country code representing the country of origin for the shipment or goods.. Valid values are `^[A-Z]{3}$`',
    `package_status` STRING COMMENT 'Current lifecycle status of the document package indicating its readiness and approval state.. Valid values are `draft|in_progress|complete|submitted|approved|rejected`',
    `package_type` STRING COMMENT 'Classification of the document package based on the business transaction it supports (e.g., shipment, freight order, customs declaration).. Valid values are `shipment|freight_order|customs_declaration|contract|claim|compliance`',
    `received_document_count` STRING COMMENT 'Number of documents currently received and attached to this package.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the document package for tracking and identification purposes.. Valid values are `^PKG-[A-Z0-9]{8,12}$`',
    `required_document_count` STRING COMMENT 'Total number of documents required for this package based on the business transaction type and regulatory requirements.',
    `retention_expiry_date` DATE COMMENT 'Date when the document package retention period expires and the package may be archived or destroyed.',
    `retention_period_days` STRING COMMENT 'Number of days the document package must be retained per regulatory or business policy requirements.',
    `source_system` STRING COMMENT 'Name of the source system or application from which the document package was created or imported.. Valid values are `SAP_TM|Oracle_TMS|Manhattan_WMS|Descartes_Customs|Manual|API`',
    `submission_date` DATE COMMENT 'Date when the document package was submitted to authorities, customers, or for cargo release.',
    `submission_ready_flag` BOOLEAN COMMENT 'Boolean indicator showing whether the document package is complete and ready for submission to authorities or release for cargo operations.',
    `version_number` STRING COMMENT 'Version number of the document package, incremented with each significant update or revision.',
    `creation_date` DATE COMMENT 'Date when the document package was initially created in the system.',
    CONSTRAINT pk_document_package PRIMARY KEY(`document_package_id`)
) COMMENT 'Master record representing a logical grouping of related transport and trade documents assembled for a specific shipment, freight order, or customs declaration. Captures package reference, associated business transaction (shipment, freight order, customs declaration), completeness status, required document checklist, missing document flags, package creation date, and submission-ready indicator. Used by operations teams to ensure all required documentation is present before cargo release or customs clearance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`amendment` (
    `amendment_id` BIGINT COMMENT 'Unique identifier for the document amendment record. Primary key for the document amendment entity.',
    `employee_id` BIGINT COMMENT 'Reference to the system user who created the amendment record. Supports audit trail and accountability requirements.',
    `amendment_employee_id` BIGINT COMMENT 'Reference to the organization or individual authorized to approve the amendment. Typically the document issuer or regulatory authority.',
    `amendment_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the system user who last updated the amendment record. Tracks responsibility for changes throughout the amendment lifecycle.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Amendments to transport documents (AWB corrections, BOL changes) often require carrier notification and approval. Carriers must be informed of document changes affecting their operational or liability',
    `certificate_of_origin_id` BIGINT COMMENT 'Foreign key linking to customs.certificate_of_origin. Business justification: Certificate of Origin amendments are tracked separately from the certificate itself - audit trail for origin claim changes and preferential tariff adjustments after initial declaration.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment associated with the document being amended. Links the amendment to the physical movement of goods.',
    `contract_party_id` BIGINT COMMENT 'Reference to the organization or individual who initiated the amendment request. May be shipper, consignee, carrier, freight forwarder, or customs broker.',
    `superseded_amendment_id` BIGINT COMMENT 'Reference to a previous amendment that this amendment replaces or supersedes. Maintains amendment lineage for complex correction scenarios.',
    `transport_document_id` BIGINT COMMENT 'Reference to the original transport or trade document being amended. Links to the source document that requires correction or modification.',
    `amended_field_name` STRING COMMENT 'Name of the specific document field or data element being amended. Identifies the exact attribute on the original document that requires correction or update.',
    `amended_value` DECIMAL(18,2) COMMENT 'The new corrected or updated value for the amended field. Represents the target state after amendment approval and implementation.',
    `amendment_number` STRING COMMENT 'Unique business identifier for the amendment request. Externally visible amendment tracking number used for audit and compliance purposes.. Valid values are `^AMD-[A-Z0-9]{8,20}$`',
    `amendment_status` STRING COMMENT 'Current state of the amendment request in its approval workflow. Tracks progression from submission through review, approval, and implementation.. Valid values are `pending|under_review|approved|rejected|withdrawn|completed`',
    `amendment_type` STRING COMMENT 'Classification of the amendment action being performed. Correction fixes errors, endorsement adds parties, substitution replaces documents, cancellation voids documents, addendum appends information, revision updates terms.. Valid values are `correction|endorsement|substitution|cancellation|addendum|revision`',
    `approval_date` DATE COMMENT 'Date when the amendment was officially approved by the authorizing authority. Marks the transition from pending to approved status.',
    `approving_authority_name` STRING COMMENT 'Name of the organization or individual who approved or rejected the amendment. Captured for compliance and audit trail.',
    `awb_number` STRING COMMENT 'Air Waybill number if the amendment relates to air freight documentation. Follows IATA standard 3-digit airline prefix and 8-digit serial number format.. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `bol_number` STRING COMMENT 'Bill of Lading number if the amendment relates to ocean or ground freight documentation. Unique identifier for the contract of carriage.',
    `completion_date` DATE COMMENT 'Date when the amendment was fully implemented and all affected systems and parties were notified. Represents the end of the amendment lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the amendment record was first created in the database. Used for audit trail and data lineage tracking.',
    `customs_declaration_number` STRING COMMENT 'Customs entry or declaration number if the amendment relates to customs documentation. Required for post-clearance amendments.',
    `digital_signature` STRING COMMENT 'Cryptographic signature hash for the amendment record. Ensures non-repudiation and integrity of the amendment approval for legal and regulatory purposes.',
    `document_number` STRING COMMENT 'The business identifier of the original document being amended. Captured for cross-reference and audit purposes.',
    `document_type` STRING COMMENT 'Type of transport or trade document being amended. Determines applicable regulatory requirements and approval workflows for amendments. [ENUM-REF-CANDIDATE: AWB|MAWB|HAWB|BOL|MBL|HBL|commercial_invoice|packing_list|certificate_of_origin|customs_declaration|delivery_order|manifest — 12 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date from which the amendment becomes legally binding and operational. May differ from approval date based on regulatory or contractual requirements.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Monetary value of the financial impact resulting from the amendment. Positive values indicate additional charges, negative values indicate refunds or credits.',
    `financial_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount. Ensures proper currency handling in multi-currency operations.. Valid values are `^[A-Z]{3}$`',
    `financial_impact_flag` BOOLEAN COMMENT 'Indicates whether the amendment has financial implications requiring billing adjustments, refunds, or additional charges. Triggers downstream financial reconciliation processes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the amendment record was last updated. Enables change tracking and audit compliance.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether notification of the amendment has been sent to all affected parties. Ensures communication compliance for document changes.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when amendment notifications were dispatched to affected parties. Used for audit trail and SLA compliance tracking.',
    `original_value` DECIMAL(18,2) COMMENT 'The original value of the field before amendment. Preserved for audit trail and regulatory compliance to demonstrate what was changed.',
    `priority` STRING COMMENT 'Priority classification for processing the amendment request. Urgent amendments may require expedited approval for time-sensitive shipments or regulatory deadlines.. Valid values are `urgent|high|normal|low`',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason for the amendment. Used for root cause analysis and process improvement. [ENUM-REF-CANDIDATE: data_entry_error|shipper_request|consignee_request|customs_requirement|regulatory_compliance|rate_correction|weight_correction|description_correction|party_change|routing_change|other — 11 candidates stripped; promote to reference product]',
    `reason_description` STRING COMMENT 'Detailed free-text explanation of why the amendment was necessary. Provides context beyond the standardized reason code for audit and dispute resolution.',
    `regulatory_authority` STRING COMMENT 'Name of the government or regulatory body that must be notified of the amendment. Applicable for customs declarations, dangerous goods documents, and trade compliance filings.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number assigned by the regulatory authority for the amendment filing. Used to track compliance with post-clearance amendment requirements.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether the amendment must be filed with a regulatory authority. True for customs amendments, dangerous goods corrections, and trade compliance updates.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the approving authority when an amendment request is rejected. Informs the requesting party of deficiencies or policy violations.',
    `request_date` DATE COMMENT 'Date when the amendment request was formally submitted. Represents the business event timestamp for initiating the amendment process.',
    `request_timestamp` TIMESTAMP COMMENT 'Precise date and time when the amendment request was submitted to the system. Used for audit trail and SLA tracking.',
    `requesting_party_name` STRING COMMENT 'Name of the organization or individual who submitted the amendment request. Captured for audit and communication purposes.',
    `requesting_party_role` STRING COMMENT 'Business role of the party requesting the amendment in the context of the original document. Determines authorization level and approval requirements. [ENUM-REF-CANDIDATE: shipper|consignee|carrier|freight_forwarder|customs_broker|notify_party|agent — 7 candidates stripped; promote to reference product]',
    `version` STRING COMMENT 'Sequential version number for amendments to the same document. Tracks multiple amendment iterations and ensures proper version control.',
    CONSTRAINT pk_amendment PRIMARY KEY(`amendment_id`)
) COMMENT 'Transactional record managing formal amendments and corrections to issued transport and trade documents. Captures amendment request date, amendment type (correction, endorsement, substitution, cancellation), original document reference, amended fields, amendment reason, requesting party, approving authority, amendment status (pending, approved, rejected), and effective date. Critical for managing AWB corrections, BOL amendments, and customs declaration revisions post-issuance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`certificate` (
    `certificate_id` BIGINT COMMENT 'Unique identifier for the certificate record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Certificates (phytosanitary, fumigation, origin) reference the carrier transporting certified goods for traceability and regulatory compliance. Required for dangerous goods, perishables, and controlle',
    `consignee_id` BIGINT COMMENT 'Identifier of the consignee or importer associated with this certificate.',
    `hs_classification_id` BIGINT COMMENT 'Foreign key linking to customs.hs_classification. Business justification: Regulatory certificates (phytosanitary, health, CITES) often drive or validate HS classification decisions - business links certificates to classification records for restricted goods compliance and t',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Certificates are often issued by network partners acting as inspection agencies, customs brokers, or certification authorities. Tracking the issuing partner is required for certificate validation and ',
    `shipper_profile_id` BIGINT COMMENT 'Identifier of the shipper or exporter associated with this certificate.',
    `superseded_certificate_id` BIGINT COMMENT 'Self-referencing FK on certificate (superseded_certificate_id)',
    `attachment_count` STRING COMMENT 'Number of supporting documents or attachments associated with this certificate (e.g., test reports, inspection photos, lab results).',
    `authentication_method` STRING COMMENT 'Method used to authenticate and verify the legitimacy of the certificate (e.g., digital signature, physical seal, QR code, blockchain).. Valid values are `digital_signature|physical_seal|watermark|qr_code|blockchain|manual_verification`',
    `certificate_number` STRING COMMENT 'Official certificate number assigned by the issuing authority. This is the externally-known unique identifier for the certificate.',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the certificate indicating its validity and usability for shipment compliance. [ENUM-REF-CANDIDATE: draft|pending_approval|active|expired|suspended|revoked|cancelled — 7 candidates stripped; promote to reference product]',
    `certificate_type` STRING COMMENT 'Classification of the certificate based on its regulatory purpose and scope. [ENUM-REF-CANDIDATE: dangerous_goods|phytosanitary|fumigation|cites_permit|health|quality_inspection|origin|veterinary|export_license|import_permit|radiation|organic|halal|kosher|gmp|haccp|iso|other — promote to reference product]',
    `chemical_used` STRING COMMENT 'Name of the chemical or substance used in the treatment process (e.g., methyl bromide for fumigation).',
    `commodity_description` STRING COMMENT 'Detailed description of the goods, materials, or commodities covered by this certificate.',
    `compliance_standard` STRING COMMENT 'Specific regulatory standard, protocol, or convention that the certificate demonstrates compliance with (e.g., ISPM 15, CITES, IMO regulations).',
    `concentration_level` STRING COMMENT 'Concentration level or dosage of the chemical used in the treatment, including unit of measure.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this certificate record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certificate record was first created in the system.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the destination country for the goods covered by the certificate.. Valid values are `^[A-Z]{3}$`',
    `digital_signature` STRING COMMENT 'Cryptographic digital signature or hash used to verify the authenticity and integrity of the electronic certificate.',
    `effective_date` DATE COMMENT 'Date from which the certificate becomes valid and can be used for compliance purposes.',
    `expiry_date` DATE COMMENT 'Date when the certificate expires and is no longer valid for compliance purposes. Nullable for certificates without expiration.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the commodities covered by the certificate, measured in kilograms.',
    `hs_code` STRING COMMENT 'International standardized system of names and numbers to classify traded products covered by the certificate.. Valid values are `^[0-9]{6,10}$`',
    `inspection_date` DATE COMMENT 'Date when the physical inspection or assessment was conducted by the issuing authority prior to certificate issuance.',
    `inspector_license_number` STRING COMMENT 'Professional license or certification number of the inspector who validated the certificate requirements.',
    `inspector_name` STRING COMMENT 'Name of the authorized inspector or surveyor who conducted the inspection and validated the certificate requirements.',
    `issue_date` DATE COMMENT 'Date when the certificate was officially issued by the authority. This is the principal business event timestamp for the certificate.',
    `issuing_authority_code` STRING COMMENT 'Standardized code or identifier for the issuing authority used in electronic data interchange and customs declarations.',
    `issuing_authority_name` STRING COMMENT 'Name of the government agency, regulatory body, or authorized organization that issued the certificate.',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the country where the certificate was issued.. Valid values are `^[A-Z]{3}$`',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this certificate record in the system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certificate record was last modified in the system.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the commodities covered by the certificate, excluding packaging, measured in kilograms.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country of origin for the goods covered by the certificate.. Valid values are `^[A-Z]{3}$`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of goods or commodities covered by the certificate.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the quantity field (e.g., kilograms, cubic meters, pieces, Twenty-foot Equivalent Unit). [ENUM-REF-CANDIDATE: kg|ton|lbs|cbm|pcs|liters|gallons|teu|feu — 9 candidates stripped; promote to reference product]',
    `remarks` STRING COMMENT 'Additional notes, special conditions, or remarks provided by the issuing authority regarding the certificate.',
    `renewal_frequency_days` STRING COMMENT 'Number of days between required renewals for certificates that require periodic renewal.',
    `renewal_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this certificate requires periodic renewal (True) or is a one-time issuance (False).',
    `revocation_date` DATE COMMENT 'Date when the certificate was revoked by the issuing authority, if applicable.',
    `revocation_reason` STRING COMMENT 'Reason provided by the issuing authority for revoking the certificate.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for which the certificate is applicable (air, ocean, road, rail, or multimodal).. Valid values are `air|ocean|road|rail|multimodal`',
    `treatment_date` DATE COMMENT 'Date when the treatment (fumigation, heat treatment, etc.) was applied to the goods.',
    `treatment_duration_hours` DECIMAL(18,2) COMMENT 'Duration of the treatment process in hours, as required for compliance documentation.',
    `treatment_type` STRING COMMENT 'Type of treatment applied to the goods (e.g., fumigation, heat treatment, irradiation) as documented in the certificate. Applicable to phytosanitary and fumigation certificates.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying dangerous goods or hazardous substances covered by the certificate. Applicable primarily to dangerous goods certificates.. Valid values are `^UN[0-9]{4}$`',
    `verification_url` STRING COMMENT 'Web URL where the certificate can be verified online with the issuing authority.',
    CONSTRAINT pk_certificate PRIMARY KEY(`certificate_id`)
) COMMENT 'Master record for all regulatory and compliance certificates managed by Transport Shipping, including dangerous goods certificates, phytosanitary certificates, fumigation certificates, CITES permits, health certificates, and quality inspection certificates. Captures certificate type, issuing authority, certificate number, issue date, expiry date, scope of coverage (commodity, route, shipment), issuing country, and authentication method. Distinct from trade_document in that certificates are authority-issued compliance instruments rather than commercial documents.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`access_log` (
    `access_log_id` BIGINT COMMENT 'Unique identifier for the document access log entry. Primary key for the document access log product.',
    `certificate_of_origin_id` BIGINT COMMENT 'Foreign key linking to customs.certificate_of_origin. Business justification: Access to Certificate of Origin documents is logged for audit purposes - compliance tracking for who viewed/downloaded origin certificates and when for FTA program audits.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with the document access. Populated when a customer or customer representative accesses their own documents.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the user or system account that accessed the document. May reference internal employee, external partner, or system service account.',
    `transport_document_id` BIGINT COMMENT 'Reference to the document that was accessed. Links to the document master record in the document management system.',
    `related_access_log_id` BIGINT COMMENT 'Self-referencing FK on access_log (related_access_log_id)',
    `access_channel` STRING COMMENT 'Channel or interface through which the document was accessed. Identifies whether access was via user-facing portal, programmatic API, or internal system integration.. Valid values are `web_portal|mobile_app|api|internal_system|email|ftp`',
    `access_duration_seconds` STRING COMMENT 'Duration in seconds that the document was actively accessed or viewed. Measured from initial access to session close or timeout. Null for instantaneous operations like download.',
    `access_expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the granted access permission expires. Applicable for temporary access grants or time-limited document sharing. Null for permanent access rights.',
    `access_granted_by` STRING COMMENT 'Name or identifier of the person or system that granted access permissions to the accessor. Populated for documents requiring explicit approval or temporary access grants.',
    `access_location_city` STRING COMMENT 'City from which the document was accessed. Derived from IP address geolocation. Used for regional access pattern analysis and compliance with data residency requirements.',
    `access_location_country` STRING COMMENT 'Three-letter ISO country code representing the geographic location from which the document was accessed. Derived from IP address geolocation or user profile.. Valid values are `^[A-Z]{3}$`',
    `access_outcome` STRING COMMENT 'Result of the access attempt. Success indicates document was accessed as requested; denied indicates insufficient permissions; failed indicates technical error; partial indicates incomplete retrieval.. Valid values are `success|denied|failed|partial`',
    `access_purpose` STRING COMMENT 'Business reason or purpose for accessing the document. May be user-provided or system-inferred. Examples include customs inspection, customer inquiry, audit review, operational reference.',
    `access_timestamp` TIMESTAMP COMMENT 'Precise date and time when the document access event occurred. Recorded in UTC for global consistency across time zones.',
    `access_type` STRING COMMENT 'Type of access operation performed on the document. Distinguishes between read-only operations (view, download) and modification operations (edit, delete). [ENUM-REF-CANDIDATE: view|download|print|share|edit|delete|api_retrieval — 7 candidates stripped; promote to reference product]',
    `accessor_email` STRING COMMENT 'Email address of the user who accessed the document. Used for audit notifications and compliance investigations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `accessor_name` STRING COMMENT 'Full name of the person or system that accessed the document. Captured for audit trail and compliance reporting.',
    `api_client_code` STRING COMMENT 'Unique identifier of the API client application that retrieved the document. Populated only for api_retrieval access type. Used for API usage monitoring and third-party integration auditing.',
    `authentication_method` STRING COMMENT 'Method used to authenticate the user before granting document access. SSO is Single Sign-On, MFA is Multi-Factor Authentication. Critical for security audit and compliance verification.. Valid values are `password|sso|mfa|api_key|certificate|biometric`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this access log record was created in the document management system. Typically identical or very close to access_timestamp but represents system record creation time.',
    `data_classification` STRING COMMENT 'Classification level of the document that was accessed. Reflects the sensitivity of the document content at the time of access. Used for security monitoring and compliance reporting.. Valid values are `public|internal|confidential|restricted`',
    `denial_reason` STRING COMMENT 'Explanation for why document access was denied. Populated only when access_outcome is denied. Common reasons include insufficient permissions, expired credentials, or document retention policy restrictions.',
    `device_identifier` STRING COMMENT 'Unique identifier of the device used to access the document. May be device UUID, MAC address, or browser fingerprint depending on access channel.',
    `document_version` STRING COMMENT 'Version number or identifier of the document that was accessed. Critical for audit trails when documents undergo revisions.',
    `download_size_bytes` BIGINT COMMENT 'Size of the document file in bytes that was downloaded. Populated only for download and api_retrieval access types. Used for bandwidth analysis and storage auditing.',
    `incident_severity` STRING COMMENT 'Severity level of the security incident if security_incident_flag is true. Null for non-incident access events. Used for prioritizing security response and compliance escalation.. Valid values are `low|medium|high|critical`',
    `ip_address` STRING COMMENT 'IP address of the device or system from which the document was accessed. Supports geolocation analysis and security threat detection. May be IPv4 or IPv6 format.. Valid values are `^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$`',
    `notes` STRING COMMENT 'Free-text notes or comments about the document access event. May include user-provided justification, system-generated alerts, or investigator annotations for compliance reviews.',
    `organization_unit` STRING COMMENT 'Business unit, department, or division of the accessor. Examples include Customs Brokerage, Freight Operations, Customer Service, Finance, Legal. Used for internal access pattern analysis.',
    `page_count_accessed` STRING COMMENT 'Number of pages viewed or accessed within a multi-page document. Applicable for PDF, Word, and other paginated document formats. Null for non-paginated documents.',
    `regulatory_flag` BOOLEAN COMMENT 'Indicates whether this access event is subject to regulatory reporting or audit requirements. True for documents accessed under customs inspection, trade compliance review, or regulatory investigation.',
    `retention_hold_flag` BOOLEAN COMMENT 'Indicates whether this access log entry is under legal hold or extended retention due to litigation, investigation, or regulatory inquiry. When true, the log entry cannot be purged per standard retention policy.',
    `security_incident_flag` BOOLEAN COMMENT 'Indicates whether this access event was flagged as a potential security incident. True for suspicious access patterns, unauthorized access attempts, or anomalous behavior detected by security monitoring systems.',
    `session_code` STRING COMMENT 'Unique identifier for the user session during which the document was accessed. Enables correlation of multiple access events within a single user session.',
    `share_recipient_email` STRING COMMENT 'Email address of the recipient when the document was shared via the share access type. Populated only for share operations. Used for tracking document distribution and external sharing compliance.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `shipment_reference` STRING COMMENT 'Reference to the shipment associated with the document access event. Populated when document access is related to a specific shipment (e.g., accessing AWB, BOL, or POD for a shipment).',
    `user_role` STRING COMMENT 'Role or permission level of the user at the time of access. Examples include Administrator, Customs Officer, Customer Service Representative, External Partner, Customer. Used for role-based access control (RBAC) auditing.',
    CONSTRAINT pk_access_log PRIMARY KEY(`access_log_id`)
) COMMENT 'Transactional record capturing every access, view, download, and print event for documents managed within the document domain. Records accessor identity, access timestamp, access type (view, download, print, share, API retrieval), document reference, access channel (portal, API, internal system), IP address or device identifier, and access outcome. Supports GDPR data access audit requirements, document security monitoring, and regulatory inspection readiness.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`workflow` (
    `workflow_id` BIGINT COMMENT 'Unique identifier for the document workflow configuration. Primary key.',
    `org_unit_id` BIGINT COMMENT 'Reference to the business unit or division that owns and manages this workflow configuration.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Document workflows may be carrier-specific—e.g., carrier-mandated approval processes for dangerous goods documentation, carrier-specific customs clearance workflows. Real operational requirement for c',
    `parent_workflow_id` BIGINT COMMENT 'Reference to the parent workflow if this configuration was cloned from a template or is a version of another workflow. Null for original workflows.',
    `type_id` BIGINT COMMENT 'Reference to the document type that this workflow applies to (e.g., Air Waybill, Bill of Lading, Customs Declaration, Commercial Invoice, Dangerous Goods Declaration).',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this workflow configuration for production use.',
    `workflow_employee_id` BIGINT COMMENT 'Reference to the user who created this workflow configuration.',
    `workflow_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this workflow configuration.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this workflow configuration was approved and authorized for use.',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether a complete audit trail of all workflow actions, approvals, and state changes must be maintained for compliance and investigation purposes.',
    `auto_approval_enabled` BOOLEAN COMMENT 'Indicates whether automatic approval is enabled for documents meeting predefined threshold criteria without manual intervention.',
    `auto_approval_threshold` STRING COMMENT 'Business rule or criteria defining when documents can be auto-approved (e.g., shipment value < 1000 USD, non-hazardous goods only, domestic shipments within same country).',
    `compliance_framework` STRING COMMENT 'Comma-separated list of regulatory frameworks or standards this workflow must comply with (e.g., IATA_DGR,IMO_IMDG,C-TPAT,AEO,GDPR).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this workflow configuration record was first created in the system.',
    `digital_signature_required` BOOLEAN COMMENT 'Indicates whether digital signatures are required from approvers for regulatory compliance and non-repudiation.',
    `effective_from_date` DATE COMMENT 'Date when this workflow configuration becomes active and can be used for document processing.',
    `effective_to_date` DATE COMMENT 'Date when this workflow configuration expires or is superseded by a new version. Null indicates no expiration.',
    `escalation_enabled` BOOLEAN COMMENT 'Indicates whether automatic escalation rules are enabled for this workflow when Service Level Agreement (SLA) thresholds are breached.',
    `escalation_hierarchy` STRING COMMENT 'Comma-separated list of role codes or user groups defining the escalation path in order (e.g., SUPERVISOR,MANAGER,DIRECTOR,VP_OPERATIONS).',
    `escalation_rule` STRING COMMENT 'Business rule defining escalation logic when SLA is breached (e.g., escalate to manager after 24 hours, notify senior compliance officer if not approved within 48 hours).',
    `geographic_scope` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes or region codes defining where this workflow is applicable (e.g., USA,CAN,MEX or GLOBAL).',
    `is_template` BOOLEAN COMMENT 'Indicates whether this workflow configuration serves as a template that can be cloned to create new workflows (True) or is a production workflow instance (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this workflow configuration record was last updated.',
    `max_revision_cycles` STRING COMMENT 'Maximum number of revision cycles allowed before the document must be either approved or rejected to prevent infinite loops.',
    `minimum_approvers` STRING COMMENT 'Minimum number of approvers required to authorize the document before it can proceed to the next stage or be issued.',
    `notification_channels` STRING COMMENT 'Comma-separated list of notification channels used to alert approvers and stakeholders (e.g., email,sms,push).. Valid values are `email|sms|push|portal|all`',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether automatic notifications are sent to approvers and stakeholders at each workflow stage transition.',
    `parallel_approval_allowed` BOOLEAN COMMENT 'Indicates whether multiple approvers can review and approve simultaneously (True) or approvals must be sequential (False).',
    `priority_level` STRING COMMENT 'Default priority level assigned to documents processed through this workflow affecting SLA enforcement and escalation urgency.. Valid values are `low|normal|high|urgent|critical`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this workflow is subject to specific regulatory compliance requirements (True) such as customs regulations, dangerous goods regulations, or trade compliance.',
    `rejection_allowed` BOOLEAN COMMENT 'Indicates whether approvers are allowed to reject documents in this workflow (True) or can only approve or request revisions (False).',
    `required_approver_roles` STRING COMMENT 'Comma-separated list of role codes or role names that are required to approve documents in this workflow (e.g., CUSTOMS_OFFICER,COMPLIANCE_MANAGER,OPERATIONS_SUPERVISOR).',
    `requires_multi_party_approval` BOOLEAN COMMENT 'Indicates whether this workflow requires approval from multiple parties or roles before document issuance (True) or can be approved by a single party (False).',
    `retention_period_years` STRING COMMENT 'Number of years that workflow execution records and associated documents must be retained to meet regulatory and legal requirements.',
    `revision_allowed` BOOLEAN COMMENT 'Indicates whether documents can be sent back for revision during the workflow (True) or must be approved or rejected without revision cycles (False).',
    `signature_type` STRING COMMENT 'Type of signature required for approval in this workflow (electronic for basic e-signature, digital_certificate for PKI-based signatures, biometric for advanced authentication).. Valid values are `electronic|digital_certificate|biometric|none`',
    `sla_duration_hours` STRING COMMENT 'Total Service Level Agreement duration in hours for the entire workflow from initiation to final approval and issuance.',
    `stage_sequence` STRING COMMENT 'Ordered list of workflow stages that documents must pass through (e.g., draft,review,approve,issue or submit,customs_review,compliance_check,release). Comma-separated stage codes in execution order.',
    `stage_sla_config` STRING COMMENT 'JSON or structured string defining SLA duration for each workflow stage (e.g., draft:4h,review:8h,approve:12h,issue:2h) to enable stage-level monitoring.',
    `total_stages` STRING COMMENT 'Total number of stages in the workflow sequence for quick reference and validation.',
    `version` STRING COMMENT 'Version number of the workflow configuration following semantic versioning (e.g., 1.0.0, 2.1.3) to track changes over time.. Valid values are `^[0-9]+.[0-9]+.[0-9]+$`',
    `workflow_code` STRING COMMENT 'Unique business code for the workflow configuration used for system integration and reference (e.g., DG_DECL_APPR, CUST_ENTRY_REV).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `workflow_description` STRING COMMENT 'Detailed business description of the workflow purpose, scope, and applicability including when and why this workflow should be triggered.',
    `workflow_name` STRING COMMENT 'Business name of the workflow configuration (e.g., Dangerous Goods Declaration Approval, Customs Entry Review, Letter of Credit Authorization).',
    `workflow_status` STRING COMMENT 'Current lifecycle status of the workflow configuration indicating whether it is currently in use or not.. Valid values are `active|inactive|draft|suspended|archived`',
    CONSTRAINT pk_workflow PRIMARY KEY(`workflow_id`)
) COMMENT 'Master record defining the approval and review workflow configuration for document types requiring multi-party authorization before issuance or release. Captures workflow name, applicable document type, workflow stages (draft, review, approve, issue), stage sequence, required approver roles, escalation rules, SLA per stage, and auto-approval thresholds. Governs the controlled document lifecycle for regulated document types such as dangerous goods declarations, customs entries, and letters of credit.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`workflow_task` (
    `workflow_task_id` BIGINT COMMENT 'Unique identifier for the workflow task. Primary key for the workflow task entity.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Workflow tasks may be assigned to carrier personnel for document review or approval (e.g., carrier approval of hazmat documentation, carrier verification of cargo details). Required for multi-party do',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Individual workflow tasks (classify goods, calculate duty, review valuation, file declaration) are executed against specific declarations - task assignment and completion tracking for customs clearanc',
    `digital_signature_id` BIGINT COMMENT 'Reference to the digital signature record applied when completing this task. Null if no signature was required or task is incomplete.',
    `job_profile_id` BIGINT COMMENT 'Reference to the organizational role assigned to complete this task. Used for role-based task routing when specific user assignment is not required.',
    `org_unit_id` BIGINT COMMENT 'Reference to the work group or team assigned to complete this task. Enables shared task pools for collaborative processing.',
    `employee_id` BIGINT COMMENT 'Reference to the individual user assigned to complete this task. Null if assigned to a role or group rather than a specific person.',
    `quaternary_workflow_delegated_from_user_employee_id` BIGINT COMMENT 'Reference to the original assignee who delegated this task. Null if task was not delegated.',
    `tertiary_workflow_escalated_to_user_employee_id` BIGINT COMMENT 'Reference to the user to whom the task was escalated. Typically a manager or senior approver with override authority.',
    `transport_document_id` BIGINT COMMENT 'Reference to the document being processed through this workflow task. Enables direct traceability from task to source document.',
    `workflow_id` BIGINT COMMENT 'Reference to the parent workflow instance that contains this task. Links the task to its governing document approval workflow.',
    `predecessor_workflow_task_id` BIGINT COMMENT 'Self-referencing FK on workflow_task (predecessor_workflow_task_id)',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the task was assigned to the current assignee. Used for workload tracking and SLA calculation baseline.',
    `attachment_count` STRING COMMENT 'Number of supporting documents or files attached to this task by the assignee. Indicates additional evidence or documentation provided during review.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether the assignee must hold specific professional certifications or authorizations to complete this task. Used for compliance validation.',
    `certification_type` STRING COMMENT 'Type of professional certification or authorization required to complete this task. Examples: customs_broker_license, dangerous_goods_certification, quality_auditor. [ENUM-REF-CANDIDATE: customs_broker|dangerous_goods_handler|quality_auditor|security_clearance|trade_compliance_officer|financial_controller|legal_counsel — promote to reference product]',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the task was completed by the assignee. Used for SLA compliance measurement and workflow progression.',
    `conditional_routing_expression` STRING COMMENT 'Business rule expression that determines the next workflow step based on this tasks outcome. Enables dynamic workflow routing logic.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this workflow task record was first created in the system. Audit field for data lineage and compliance.',
    `decision_comments` STRING COMMENT 'Free-text comments or justification provided by the assignee explaining their decision. Captures business rationale for audit and compliance purposes.',
    `delegation_allowed_flag` BOOLEAN COMMENT 'Indicates whether the assignee is permitted to delegate this task to another user. False for tasks requiring specific authority or certification.',
    `delegation_reason` STRING COMMENT 'Free-text explanation provided by the delegating user for why the task was delegated. Supports audit trail and workload management analysis.',
    `delegation_timestamp` TIMESTAMP COMMENT 'Date and time when the task was delegated to the current assignee. Null if task was not delegated.',
    `digital_signature_required_flag` BOOLEAN COMMENT 'Indicates whether the task requires a legally binding digital signature upon completion. True for regulatory-critical approvals.',
    `due_date` DATE COMMENT 'Target date by which the task must be completed to meet Service Level Agreement (SLA) commitments. Used for escalation and priority management.',
    `due_timestamp` TIMESTAMP COMMENT 'Precise date and time when the task must be completed. Provides hour-level SLA enforcement for time-critical document approvals.',
    `escalated_timestamp` TIMESTAMP COMMENT 'Date and time when the task was most recently escalated. Null if task has never been escalated.',
    `escalation_level` STRING COMMENT 'Number of times this task has been escalated due to SLA breach or non-response. Zero indicates no escalation has occurred.',
    `last_reminder_timestamp` TIMESTAMP COMMENT 'Date and time when the most recent reminder notification was sent to the assignee. Null if no reminders have been sent.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this workflow task record was last modified. Audit field for change tracking and data quality monitoring.',
    `outcome_decision` STRING COMMENT 'Final decision or action taken by the assignee upon task completion. Determines the next routing step in the workflow.. Valid values are `approved|rejected|returned|escalated|cancelled|no_action_required`',
    `parallel_task_group_code` STRING COMMENT 'Identifier grouping tasks that execute in parallel within the workflow. All tasks in the same group must complete before workflow proceeds to next stage.',
    `priority_level` STRING COMMENT 'Business priority assigned to the task. Influences queue ordering and escalation thresholds for time-sensitive document processing.. Valid values are `critical|high|normal|low`',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the category of rejection when outcome_decision is rejected. Enables structured analysis of rejection patterns. [ENUM-REF-CANDIDATE: incomplete_information|regulatory_noncompliance|incorrect_classification|missing_signatures|expired_documents|unauthorized_requester|policy_violation — promote to reference product]',
    `reminder_sent_count` STRING COMMENT 'Number of automated reminder notifications sent to the assignee for this task. Used to track engagement and escalation triggers.',
    `sequence_number` STRING COMMENT 'Ordinal position of this task within the workflow instance. Determines the execution order and routing logic for sequential approval processes.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the task exceeded its SLA target hours. True if completed late or currently overdue.',
    `sla_elapsed_hours` DECIMAL(18,2) COMMENT 'Actual business hours elapsed from assignment to completion or current time if still open. Used for SLA compliance reporting.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Number of business hours allocated for task completion per the applicable SLA. Used to calculate due_timestamp and measure compliance.',
    `started_timestamp` TIMESTAMP COMMENT 'Date and time when the assignee began actively working on the task. Distinguishes assignment time from actual work commencement for productivity analysis.',
    `task_number` STRING COMMENT 'Human-readable business identifier for the workflow task. Format: WFT-XXXXXXXXXX where X is a digit. Used for operational tracking and user communication.. Valid values are `^WFT-[0-9]{10}$`',
    `task_status` STRING COMMENT 'Current lifecycle state of the workflow task. Tracks progression from assignment through completion or termination. [ENUM-REF-CANDIDATE: pending|assigned|in_progress|completed|escalated|cancelled|expired — 7 candidates stripped; promote to reference product]',
    `task_type` STRING COMMENT 'Classification of the action required for this task. Determines the business logic and user interface presented to the assignee.. Valid values are `review|approve|sign|reject|acknowledge|validate`',
    CONSTRAINT pk_workflow_task PRIMARY KEY(`workflow_task_id`)
) COMMENT 'Transactional record capturing individual task assignments within a document approval workflow. Records task sequence number, assigned reviewer or approver, task type (review, approve, sign, reject), task status (pending, in-progress, completed, escalated), due date, completion timestamp, comments, and outcome decision. Provides the operational execution trail for document workflow processing and SLA compliance tracking.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`storage` (
    `storage_id` BIGINT COMMENT 'Unique identifier for the document storage configuration record. Primary key.',
    `transport_document_id` BIGINT COMMENT 'Reference to the parent document record that this storage configuration belongs to. Links to the master document entity.',
    `version_id` BIGINT COMMENT 'Unique identifier for this specific version of the document within the storage system. Null if versioning is not enabled.',
    `parent_storage_id` BIGINT COMMENT 'Self-referencing FK on storage (parent_storage_id)',
    `access_control_policy` STRING COMMENT 'Name or identifier of the access control policy governing who can read, write, or delete this document. May reference IAM policies, ACLs, or RBAC rules.',
    `backup_frequency` STRING COMMENT 'Frequency at which the document is backed up to secondary storage. Critical for disaster recovery planning and Recovery Point Objective (RPO) compliance.. Valid values are `real_time|hourly|daily|weekly|monthly|none`',
    `checksum_algorithm` STRING COMMENT 'Algorithm used to generate the checksum value. SHA-256 or SHA-512 recommended for security-critical documents.. Valid values are `md5|sha1|sha256|sha512|crc32`',
    `checksum_value` DECIMAL(18,2) COMMENT 'Hash or checksum of the document content used to verify data integrity and detect corruption or tampering. Typically MD5, SHA-256, or SHA-512.',
    `class_transition_date` DATE COMMENT 'Date when the document is scheduled to transition to a different storage tier (e.g., from hot to warm, or warm to archive) based on lifecycle policies.',
    `compression_format` STRING COMMENT 'Compression algorithm applied to the document to reduce storage footprint and transfer bandwidth. None indicates uncompressed storage. [ENUM-REF-CANDIDATE: none|gzip|zip|bzip2|lz4|snappy|zstd — 7 candidates stripped; promote to reference product]',
    `cost_per_gb_usd` DECIMAL(18,2) COMMENT 'Unit cost of storage per gigabyte per month in USD for this storage tier and provider. Used for cost allocation and chargeback to business units.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage configuration record was first created in the document management system. Audit trail for storage lifecycle.',
    `data_residency_compliant` BOOLEAN COMMENT 'Indicates whether the document storage location complies with data residency and sovereignty requirements for the documents jurisdiction. True when compliant.',
    `encryption_algorithm` STRING COMMENT 'Cryptographic algorithm used to encrypt the document (e.g., AES-256, RSA-2048). Required for security audits and compliance verification.',
    `encryption_key_reference` STRING COMMENT 'Reference to the encryption key used to secure the document. May point to a key management service (KMS) key ID. Highly sensitive.',
    `encryption_status` STRING COMMENT 'Indicates whether the document is encrypted at rest, in transit, both, or unencrypted. Critical for security compliance and data protection audits.. Valid values are `encrypted_at_rest|encrypted_in_transit|encrypted_both|unencrypted`',
    `file_size_bytes` BIGINT COMMENT 'Size of the stored document file in bytes. Used for storage capacity planning, cost allocation, and transfer time estimation.',
    `last_accessed_timestamp` TIMESTAMP COMMENT 'Timestamp when the document was last retrieved or accessed from storage. Used for lifecycle tiering decisions and access pattern analysis.',
    `last_backup_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful backup of this document. Used to monitor backup health and compliance with backup policies.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the document storage record or the document itself was last modified. Critical for audit trails and change tracking.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether the document is under legal hold and must not be deleted or modified regardless of retention policy. True when litigation, audit, or investigation is active.',
    `location_type` STRING COMMENT 'Classification of the storage infrastructure where the document is physically or digitally stored. Determines retrieval protocols and access patterns.. Valid values are `cloud_object_store|on_premise_dms|physical_archive|hybrid_storage|edge_storage|backup_vault`',
    `mime_type` STRING COMMENT 'MIME type of the stored document (e.g., application/pdf, image/jpeg, application/xml). Used for content type validation and rendering.',
    `path` STRING COMMENT 'Full path, URI, or object key identifying the exact location of the document within the storage system. May include bucket name, folder hierarchy, or file system path.',
    `provider` STRING COMMENT 'Cloud or infrastructure provider hosting the document storage. Critical for vendor management, cost allocation, and disaster recovery planning.. Valid values are `aws_s3|azure_blob|google_cloud_storage|ibm_cloud|oracle_cloud|on_premise`',
    `region` STRING COMMENT 'Geographic region or data center location where the document is physically stored. Required for data sovereignty compliance, GDPR territorial scope, and cross-border data transfer regulations.',
    `replication_status` STRING COMMENT 'Current status of document replication to secondary or disaster recovery storage locations. Critical for business continuity and data durability.. Valid values are `not_replicated|replication_pending|replicated|replication_failed`',
    `replication_target_region` STRING COMMENT 'Geographic region where the document replica is stored for disaster recovery or data redundancy. Null if not replicated.',
    `retention_class` STRING COMMENT 'Retention policy classification determining how long the document must be retained before eligible for deletion. Aligned with legal, regulatory, and business retention schedules.',
    `retention_expiry_date` DATE COMMENT 'Date on which the document retention period expires and the document becomes eligible for archival or destruction per retention policy.',
    `retrieval_sla_seconds` STRING COMMENT 'Maximum time in seconds guaranteed for document retrieval from this storage tier. Hot tier typically seconds, archive tier may be hours.',
    `storage_status` STRING COMMENT 'Current lifecycle status of the document in storage. Active for operational documents, archived for long-term retention, pending_deletion for documents awaiting purge.. Valid values are `active|archived|pending_deletion|deleted|corrupted|quarantined`',
    `storage_tier` STRING COMMENT 'Performance and cost tier of the storage layer. Hot for frequently accessed documents, archive for long-term retention. Drives retrieval SLA and storage cost.. Valid values are `hot|warm|cool|cold|archive|glacier`',
    `updated_by` STRING COMMENT 'User ID or system account that last updated this storage configuration record. Required for audit trails and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage configuration record was last updated. Critical for change tracking and audit compliance.',
    `versioning_enabled` BOOLEAN COMMENT 'Indicates whether version control is enabled for this document storage location. When true, all updates create new versions rather than overwriting.',
    `created_by` STRING COMMENT 'User ID or system account that created this storage configuration record. Required for audit trails and accountability.',
    CONSTRAINT pk_storage PRIMARY KEY(`storage_id`)
) COMMENT 'Master record managing the physical and digital storage configuration for documents within the document management system. Captures storage location type (cloud object store, on-premise DMS, physical archive), storage path or URI, encryption status, compression format, storage tier (hot, warm, cold, archive), retention class, geographic storage region (for data sovereignty compliance), and storage provider. Enables document retrieval, lifecycle tiering, and regulatory data residency compliance.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`legal_hold` (
    `legal_hold_id` BIGINT COMMENT 'Unique identifier for the legal hold record. Primary key.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Customs declarations may be subject to legal holds during audits, investigations, or litigation - compliance requirement for preserving declaration records beyond standard retention periods.',
    `retention_policy_id` BIGINT COMMENT 'Reference to the document retention policy that is suspended or overridden by this legal hold.',
    `extended_legal_hold_id` BIGINT COMMENT 'Self-referencing FK on legal_hold (extended_legal_hold_id)',
    `acknowledgment_received_date` DATE COMMENT 'Date when custodian acknowledgment of the legal hold was received.',
    `acknowledgment_required` BOOLEAN COMMENT 'Indicates whether custodians are required to formally acknowledge receipt and understanding of the legal hold order.',
    `affected_document_count` STRING COMMENT 'Estimated or actual count of documents subject to this legal hold order.',
    `business_unit_scope` STRING COMMENT 'Business units, divisions, or departments whose documents are subject to the legal hold.',
    `case_name` STRING COMMENT 'Descriptive name or title of the litigation, investigation, or audit matter that triggered the legal hold.',
    `case_number` STRING COMMENT 'Court case number, regulatory investigation identifier, or audit reference number associated with the legal hold.',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance review to verify that the legal hold is being properly enforced.',
    `compliance_status` STRING COMMENT 'Current compliance status of the legal hold indicating whether all affected documents are properly preserved.. Valid values are `compliant|non_compliant|under_review|remediation_required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the legal hold record was first created in the system.',
    `custodian_department` STRING COMMENT 'Department or business unit to which the legal hold custodian belongs.',
    `custodian_email` STRING COMMENT 'Email address of the custodian responsible for the legal hold for communication and compliance tracking.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `custodian_name` STRING COMMENT 'Name of the individual or role responsible for ensuring compliance with the legal hold order and preserving affected documents.',
    `date_range_end` DATE COMMENT 'End date of the document creation or transaction date range covered by the legal hold. Null indicates open-ended scope.',
    `date_range_start` DATE COMMENT 'Start date of the document creation or transaction date range covered by the legal hold.',
    `document_types_covered` STRING COMMENT 'Comma-separated list or description of document types subject to the legal hold (e.g., AWB, BOL, customs declarations, contracts, emails, invoices).',
    `geographic_scope` STRING COMMENT 'Geographic regions, countries, or facilities whose documents fall under the legal hold order.',
    `hold_actual_end_date` DATE COMMENT 'Actual date when the legal hold was officially released and normal retention policies resumed.',
    `hold_expected_end_date` DATE COMMENT 'Anticipated or scheduled date when the legal hold is expected to be released, subject to case resolution or regulatory closure.',
    `hold_priority` STRING COMMENT 'Priority level assigned to the legal hold indicating urgency and compliance criticality.. Valid values are `critical|high|medium|low`',
    `hold_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to the legal hold order for tracking and communication purposes.. Valid values are `^LH-[0-9]{8}$`',
    `hold_scope_description` STRING COMMENT 'Detailed description of the scope of the legal hold including document types, subject matter, business units, geographic regions, and date ranges covered.',
    `hold_start_date` DATE COMMENT 'Date when the legal hold order became effective and document retention suspension began.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the legal hold order indicating whether it is actively enforced or has been concluded.. Valid values are `active|released|expired|suspended|pending`',
    `hold_type` STRING COMMENT 'Classification of the legal hold based on the triggering event or authority requirement.. Valid values are `litigation|regulatory|audit|tax|investigation|compliance`',
    `issuing_authority` STRING COMMENT 'Name of the legal counsel, regulatory body, court, or internal compliance officer who issued the legal hold order.',
    `issuing_authority_contact` STRING COMMENT 'Contact email or phone number of the issuing authority for hold-related inquiries and communications.',
    `modified_by` STRING COMMENT 'User ID or name of the individual who last modified the legal hold record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the legal hold record was last modified.',
    `non_compliance_notes` STRING COMMENT 'Detailed notes describing any non-compliance issues, remediation actions taken, or risks identified during compliance reviews.',
    `notes` STRING COMMENT 'Additional notes, instructions, or context related to the legal hold order for internal reference.',
    `notification_sent_date` DATE COMMENT 'Date when legal hold notification was sent to custodians and affected parties.',
    `override_retention_policy` BOOLEAN COMMENT 'Indicates whether this legal hold overrides normal document retention and destruction schedules for affected documents.',
    `release_authorization` STRING COMMENT 'Name and title of the legal counsel or authority who authorized the release of the legal hold.',
    `release_reason` STRING COMMENT 'Reason for releasing the legal hold such as case settlement, investigation closure, or audit completion.',
    `created_by` STRING COMMENT 'User ID or name of the individual who created the legal hold record.',
    CONSTRAINT pk_legal_hold PRIMARY KEY(`legal_hold_id`)
) COMMENT 'Master record managing legal hold orders placed on documents to suspend normal retention and destruction schedules during litigation, regulatory investigation, or audit proceedings. Captures hold reference number, hold type (litigation, regulatory, audit, tax), issuing authority or legal counsel, hold scope (document types, date range, business unit), hold start date, expected end date, custodian responsible, and hold status (active, released, expired). Overrides retention_policy destruction rules for affected documents.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`type` (
    `type_id` BIGINT COMMENT 'Unique identifier for the document type. Primary key for the document type reference master.',
    `parent_type_id` BIGINT COMMENT 'Self-referencing FK on type (parent_type_id)',
    `access_control_level` STRING COMMENT 'Default access control classification for documents of this type. Determines who can view, edit, or share the document. Values: public (no restrictions), internal (company employees only), confidential (authorized personnel only), restricted (highly sensitive, need-to-know basis).. Valid values are `public|internal|confidential|restricted`',
    `archival_required` BOOLEAN COMMENT 'Indicates whether documents of this type must be archived to long-term storage after the active retention period. True if archival is required, false if documents can be destroyed after retention period.',
    `audit_trail_required` BOOLEAN COMMENT 'Indicates whether a complete audit trail of all access, modifications, and transmissions must be maintained for this document type. True if audit logging is mandatory for compliance and governance, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this document type record was first created in the system.',
    `customs_declaration_type` STRING COMMENT 'The customs declaration type code if this document is used for customs clearance (e.g., IM for import, EX for export, T1 for transit, ATA for carnet). Null if not a customs document.',
    `dangerous_goods_indicator` BOOLEAN COMMENT 'Indicates whether this document type is specifically used for dangerous goods shipments and must comply with IMDG, IATA DGR, or ADR regulations. True if dangerous goods specific, false otherwise.',
    `default_language` STRING COMMENT 'The default language for this document type, specified as a two-letter ISO 639-1 language code (e.g., en for English, es for Spanish, fr for French, de for German, zh for Chinese).. Valid values are `^[a-z]{2}$`',
    `destruction_method` STRING COMMENT 'The approved method for destroying documents of this type after retention period expiry. Values: secure_delete (digital secure deletion), shred (physical shredding), incinerate (physical incineration), not_applicable (documents are archived indefinitely).. Valid values are `secure_delete|shred|incinerate|not_applicable`',
    `digital_signature_required` BOOLEAN COMMENT 'Indicates whether a digital signature is required for this document type to ensure authenticity, integrity, and non-repudiation. True if digital signature is mandatory, false otherwise.',
    `edi_message_type` STRING COMMENT 'The EDI message type code associated with this document type for electronic transmission (e.g., IFTMIN for booking, IFTSTA for status, INVOIC for invoice, CUSCAR for customs cargo report). Null if not applicable to EDI.',
    `effective_date` DATE COMMENT 'The date from which this document type definition becomes effective and can be used for document creation and classification.',
    `encryption_required` BOOLEAN COMMENT 'Indicates whether encryption is required for documents of this type during storage and transmission. True if encryption is mandatory for data protection and compliance, false otherwise.',
    `expiry_date` DATE COMMENT 'The date after which this document type definition is no longer valid and should not be used for new documents. Null indicates no expiry (indefinite validity).',
    `file_format_allowed` STRING COMMENT 'Comma-separated list of file formats permitted for this document type (e.g., PDF, XML, JSON, EDIFACT, CSV, TIFF, JPEG). Used to enforce format standards during document upload and validation.',
    `issuance_party_type` STRING COMMENT 'The type of party authorized or responsible for issuing this document type. Values: carrier (transport operator), shipper (sender), consignee (receiver), authority (government/regulatory body), broker (customs broker), forwarder (freight forwarder), warehouse (warehouse operator), internal (internal company document). [ENUM-REF-CANDIDATE: carrier|shipper|consignee|authority|broker|forwarder|warehouse|internal — 8 candidates stripped; promote to reference product]',
    `legal_hold_eligible` BOOLEAN COMMENT 'Indicates whether documents of this type are eligible for legal hold (preservation order) in case of litigation, investigation, or regulatory inquiry. True if legal hold can be applied, false otherwise.',
    `max_file_size_mb` DECIMAL(18,2) COMMENT 'Maximum allowed file size in megabytes for documents of this type. Used to enforce storage and transmission limits. Null indicates no size restriction.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this document type record was last modified or updated.',
    `multilingual_support` BOOLEAN COMMENT 'Indicates whether this document type supports multiple language versions for international operations. True if multilingual templates and content are maintained, false otherwise.',
    `regulatory_authority` STRING COMMENT 'The governing body or regulatory authority that mandates or standardizes this document type (e.g., IATA for AWB/HAWB, IMO for BOL/MBL, WCO for customs declarations, national customs authorities).',
    `required_fields_schema_reference` STRING COMMENT 'Reference to the schema definition or template that specifies the mandatory data fields for this document type. May reference an internal schema registry, EDI message standard (e.g., EDIFACT, X12), or regulatory specification.',
    `retention_period_years` STRING COMMENT 'The number of years this document type must be retained to comply with regulatory, legal, and business requirements. Null indicates indefinite retention or retention determined by other factors.',
    `retention_trigger` STRING COMMENT 'The event that triggers the start of the retention period countdown. Values: creation_date (document creation), completion_date (transaction completion), expiry_date (document expiry), last_activity_date (last modification or access), fiscal_year_end (end of fiscal year).. Valid values are `creation_date|completion_date|expiry_date|last_activity_date|fiscal_year_end`',
    `subcategory` STRING COMMENT 'Secondary classification providing finer granularity within the category (e.g., within transport: waybill, manifest, delivery receipt; within trade: invoice, packing list, certificate of origin).',
    `template_available` BOOLEAN COMMENT 'Indicates whether a standardized template is available for this document type. True if a template exists in the document management system, false otherwise.',
    `template_reference` STRING COMMENT 'Reference identifier or URI pointing to the document template in the template repository or document management system. Null if no template is available.',
    `transport_mode` STRING COMMENT 'The transport mode(s) for which this document type is applicable. Values: air (air freight), ocean (sea freight), road (trucking), rail (rail freight), multimodal (multiple modes), not_applicable (non-transport documents such as financial or compliance documents).. Valid values are `air|ocean|road|rail|multimodal|not_applicable`',
    `type_category` STRING COMMENT 'High-level classification of the document type into functional categories: transport (shipping documents), trade (commercial documents), compliance (regulatory filings), certificate (official certifications), financial (invoices and payment documents), operational (internal process documents).. Valid values are `transport|trade|compliance|certificate|financial|operational`',
    `type_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the document type. Used as the business key for system integration and document classification (e.g., AWB, BOL, CMR, POD, COO, INVOICE).. Valid values are `^[A-Z0-9_]{2,20}$`',
    `type_description` STRING COMMENT 'Detailed description of the document type, its purpose, usage context, and any special handling instructions or business rules.',
    `type_name` STRING COMMENT 'Full descriptive name of the document type (e.g., Air Waybill, Bill of Lading, Commercial Invoice, Certificate of Origin).',
    `type_status` STRING COMMENT 'Current lifecycle status of the document type definition. Values: active (currently in use), inactive (temporarily disabled), deprecated (phased out, legacy only), draft (under development), under_review (pending approval).. Valid values are `active|inactive|deprecated|draft|under_review`',
    `usage_notes` STRING COMMENT 'Additional operational notes, guidelines, or best practices for using this document type. May include references to training materials, process documentation, or system-specific instructions.',
    `version_control_enabled` BOOLEAN COMMENT 'Indicates whether version control and change tracking is enabled for this document type. True if versioning is required to maintain audit trail of document revisions, false otherwise.',
    CONSTRAINT pk_type PRIMARY KEY(`type_id`)
) COMMENT 'Reference master defining the classification taxonomy of all document types managed within the Transport Shipping document domain. Captures document type code, document type name, category (transport, trade, compliance, certificate, financial, operational), applicable transport mode (air, ocean, road, rail, multimodal), regulatory authority alignment, required fields schema reference, and issuance party type (carrier, shipper, authority, broker). Provides the authoritative classification standard for document categorization across all domains.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`distribution` (
    `distribution_id` BIGINT COMMENT 'Unique identifier for the document distribution record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Documents are distributed to carriers as primary recipients—e.g., manifest distribution to carrier operations, AWB distribution to carrier systems. Core operational process for document exchange with ',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment associated with this document distribution. Enables tracking of all document distributions related to a specific shipment.',
    `employee_id` BIGINT COMMENT 'Reference to the user who initiated the document distribution. Supports audit trail and accountability for distribution actions.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Documents are distributed to network partners (agents, hubs, customs brokers) as operational recipients. Required for tracking document delivery to partners for customs clearance, cargo handling, or r',
    `trade_party_id` BIGINT COMMENT 'Reference to the primary recipient party (typically the consignee or main customer). Used for prioritization and primary contact tracking.',
    `transport_document_id` BIGINT COMMENT 'Reference to the source document being distributed. Links to the master document record in the document management system.',
    `redistribution_distribution_id` BIGINT COMMENT 'Self-referencing FK on distribution (redistribution_distribution_id)',
    `acknowledgement_received_count` STRING COMMENT 'Number of recipients who have acknowledged receipt of the document. Used to track compliance with acknowledgement requirements.',
    `acknowledgement_required_flag` BOOLEAN COMMENT 'Indicates whether recipients are required to acknowledge receipt of the document. Supports compliance with IATA e-freight and customs requirements for confirmed delivery.',
    `actual_delivery_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when distribution was completed to all recipients (or marked as final after max retries). Used to calculate actual delivery time and SLA compliance.',
    `api_transmission_flag` BOOLEAN COMMENT 'Indicates whether any recipient in this distribution received the document via API integration. Supports digital integration monitoring and system-to-system delivery tracking.',
    `batch_reference` STRING COMMENT 'Business identifier for the distribution batch. Used to group multiple document distributions sent together in a single transmission event.',
    `channel_summary` STRING COMMENT 'Summary of distribution channels used in this batch (e.g., EDI, email, portal, API, physical). Provides quick overview of delivery methods without querying detail records.',
    `compliance_framework` STRING COMMENT 'The regulatory framework or standard this distribution must comply with (e.g., IATA e-freight, AMS, ISF, EU ICS). Supports compliance reporting and audit trail.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution record was first created in the system. Supports audit trail and data lineage tracking.',
    `digital_signature_applied_flag` BOOLEAN COMMENT 'Indicates whether the distributed document includes a digital signature for authenticity and non-repudiation. Required for certain trade documents and e-freight compliance.',
    `distribution_date` TIMESTAMP COMMENT 'The timestamp when the document distribution was initiated and sent to recipients. Represents the principal business event time for this transaction.',
    `distribution_status` STRING COMMENT 'Current lifecycle status of the document distribution process. Tracks whether the distribution to all recipients has been initiated, is in progress, completed successfully, partially failed, fully failed, or cancelled.. Valid values are `pending|in_progress|completed|partially_failed|failed|cancelled`',
    `document_version` STRING COMMENT 'Version number of the document being distributed. Ensures recipients receive the correct version and supports audit trail for document revisions.',
    `edi_transmission_flag` BOOLEAN COMMENT 'Indicates whether any recipient in this distribution received the document via EDI. Supports compliance reporting for electronic trade documentation.',
    `email_transmission_flag` BOOLEAN COMMENT 'Indicates whether any recipient in this distribution received the document via email. Used for channel analytics and delivery method tracking.',
    `encryption_applied_flag` BOOLEAN COMMENT 'Indicates whether the document was encrypted during transmission. Supports data security compliance and confidential document handling.',
    `error_message` STRING COMMENT 'Consolidated error message summarizing any failures encountered during distribution. Used for troubleshooting and root cause analysis.',
    `failed_delivery_count` STRING COMMENT 'Number of recipients for whom document delivery failed. Triggers retry logic and exception handling workflows.',
    `first_acknowledgement_timestamp` TIMESTAMP COMMENT 'Timestamp when the first recipient acknowledged receipt. Used for SLA tracking and time-to-acknowledgement analytics.',
    `initiated_by_system` STRING COMMENT 'Name of the system or automated process that initiated the distribution (e.g., SAP TM, Oracle TMS, automated workflow). Used when distribution is triggered by system events rather than manual user action.',
    `last_acknowledgement_timestamp` TIMESTAMP COMMENT 'Timestamp when the last recipient acknowledged receipt. Marks completion of the full acknowledgement cycle.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution record was last updated. Tracks changes to distribution status, retry attempts, and acknowledgements.',
    `last_retry_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent retry attempt for failed deliveries. Used to schedule next retry and track retry intervals.',
    `max_retry_attempts` STRING COMMENT 'Maximum number of retry attempts configured for this distribution. After exceeding this threshold, failed deliveries are escalated for manual intervention.',
    `next_retry_scheduled_timestamp` TIMESTAMP COMMENT 'Timestamp when the next retry attempt is scheduled for failed deliveries. Supports automated retry orchestration.',
    `notes` STRING COMMENT 'Free-text notes or comments about this distribution. Used to capture special instructions, escalation details, or manual intervention actions.',
    `pending_delivery_count` STRING COMMENT 'Number of recipients for whom document delivery is still in progress or queued. Used for real-time distribution monitoring.',
    `physical_transmission_flag` BOOLEAN COMMENT 'Indicates whether any recipient in this distribution received a physical printed copy. Supports legacy process tracking and regulatory compliance where physical documents are required.',
    `portal_transmission_flag` BOOLEAN COMMENT 'Indicates whether any recipient in this distribution accessed the document via customer portal or web interface. Supports self-service analytics.',
    `priority` STRING COMMENT 'Priority level for this document distribution. Urgent and high priority distributions are processed first and may use expedited delivery channels.. Valid values are `urgent|high|normal|low`',
    `recipient_count` STRING COMMENT 'Total number of recipients in this distribution. Used for progress tracking and completion validation.',
    `recipient_party_list` STRING COMMENT 'Comma-separated list of recipient party identifiers or names (e.g., shipper, consignee, airline, customs broker, freight forwarder). Provides quick visibility into all parties receiving the document.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this distribution is required for regulatory compliance (e.g., customs filing, IATA e-freight mandate). Ensures critical distributions are tracked and audited.',
    `retry_count` STRING COMMENT 'Total number of retry attempts made for failed deliveries in this distribution. Used to track delivery resilience and identify chronic delivery issues.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the distribution was completed within the SLA target time. Used for performance reporting and SLA breach tracking.',
    `sla_target_delivery_minutes` STRING COMMENT 'Target time in minutes for completing document distribution to all recipients. Used for SLA compliance monitoring and performance analytics.',
    `successful_delivery_count` STRING COMMENT 'Number of recipients who successfully received the document. Used to calculate distribution success rate and identify partial failures.',
    CONSTRAINT pk_distribution PRIMARY KEY(`distribution_id`)
) COMMENT 'Transactional record capturing the distribution of documents to multiple parties simultaneously, such as multi-party AWB distribution to shipper, consignee, airline, and customs broker. Records distribution batch reference, distribution date, document reference, recipient party list, delivery channel per recipient (EDI, email, portal, API, physical), delivery status per recipient, acknowledgement receipt, and failed delivery retry count. Supports IATA e-freight multi-party document distribution requirements.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`request` (
    `request_id` BIGINT COMMENT 'Unique identifier for the document request. Primary key for the document request entity.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Document requests often originate from carriers needing copies of transport documents for claims processing, audits, or regulatory inquiries. Common operational scenario—carriers request AWB copies, m',
    `consignment_id` BIGINT COMMENT 'Identifier of the shipment associated with the requested document, if applicable.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with the document request, if applicable.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Customers and customs authorities request copies of declaration documents (entry summary, duty receipt) - request tracking and fulfillment must link to the specific declaration being requested.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user or team member assigned to process and fulfill the document request.',
    `freight_order_id` BIGINT COMMENT 'Identifier of the freight order associated with the requested document, if applicable.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Network partners request documents for customs clearance, cargo handling, or regulatory compliance. Common scenario—customs brokers request commercial invoices, hubs request handling instructions, age',
    `transport_document_id` BIGINT COMMENT 'Identifier of the document that was generated or retrieved to fulfill this request, linking the request to the resulting document record.',
    `request_transport_document_id` BIGINT COMMENT 'Identifier of the original document for which reissuance, correction, or duplicate is being requested, if applicable.',
    `trade_transaction_id` BIGINT COMMENT 'Identifier of the trade or customs transaction associated with the requested document, if applicable.',
    `original_request_id` BIGINT COMMENT 'Self-referencing FK on request (original_request_id)',
    `assigned_to_department` STRING COMMENT 'Name or code of the internal department or business unit responsible for processing the document request, such as customer service, operations, trade compliance, or documentation team.',
    `cancellation_reason` STRING COMMENT 'Explanation provided when a document request is cancelled by the requesting party or system, describing the reason for cancellation.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the document request was cancelled.',
    `channel` STRING COMMENT 'Channel or interface through which the document request was submitted, such as web portal, mobile app, email, phone, Electronic Data Interchange (EDI), Application Programming Interface (API), in-person, or fax. [ENUM-REF-CANDIDATE: web_portal|mobile_app|email|phone|EDI|API|in_person|fax — 8 candidates stripped; promote to reference product]',
    `charge_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged to the requesting party for fulfilling the document request, if applicable.',
    `charge_applicable_flag` BOOLEAN COMMENT 'Boolean indicator of whether a fee or charge is applicable for fulfilling this document request. True indicates a charge applies, False indicates no charge.',
    `charge_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the charge amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the document request record was first created in the system. Used for audit trail and record lifecycle tracking.',
    `delivery_address` STRING COMMENT 'Physical or electronic address to which the fulfilled document should be delivered, if applicable.',
    `delivery_method` STRING COMMENT 'Preferred or required method for delivering the fulfilled document to the requesting party, such as electronic transmission, courier, postal mail, in-person pickup, EDI, API, fax, or email. [ENUM-REF-CANDIDATE: electronic|courier|postal_mail|pickup|EDI|API|fax|email — 8 candidates stripped; promote to reference product]',
    `fulfillment_timestamp` TIMESTAMP COMMENT 'Date and time when the document request was successfully fulfilled and the document was delivered or made available to the requesting party.',
    `internal_notes` STRING COMMENT 'Free-text field for internal operational notes, comments, or observations recorded by staff during the processing of the document request. Not visible to external parties.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the document request record was last updated or modified. Used for audit trail and change tracking.',
    `payment_status` STRING COMMENT 'Status of payment for the document request charge, if applicable. Values include not required (no charge), pending (awaiting payment), paid (payment received), waived (charge waived), or refunded (payment returned).. Valid values are `not_required|pending|paid|waived|refunded`',
    `processing_start_timestamp` TIMESTAMP COMMENT 'Date and time when processing of the document request was initiated by the assigned user or team.',
    `reason` STRING COMMENT 'Free-text explanation provided by the requesting party describing the reason or business justification for the document request.',
    `reference_number` STRING COMMENT 'Externally-visible unique reference number assigned to the document request for tracking and communication purposes. Format: DR-XXXXXXXXXX.. Valid values are `^DR-[0-9]{10}$`',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority or governing body requiring the document, if the request is regulatory-driven (e.g., US Customs and Border Protection, IATA, IMO, national customs authority).',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Boolean indicator of whether the document request is driven by a regulatory or compliance requirement from customs, trade authorities, or other governing bodies. True indicates regulatory requirement, False indicates voluntary or operational request.',
    `rejection_reason` STRING COMMENT 'Explanation provided when a document request is rejected, describing why the request could not be fulfilled (e.g., insufficient information, invalid shipment reference, regulatory restrictions, payment required).',
    `rejection_timestamp` TIMESTAMP COMMENT 'Date and time when the document request was rejected and the requesting party was notified.',
    `request_status` STRING COMMENT 'Current lifecycle status of the document request indicating its processing state.. Valid values are `open|in_progress|fulfilled|rejected|cancelled|on_hold`',
    `request_type` STRING COMMENT 'Classification of the document request indicating whether it is for new issuance, reissuance, retrieval, correction, certification, or duplicate copy.. Valid values are `new_issuance|reissuance|retrieval|correction|certification|duplicate`',
    `requested_document_type` STRING COMMENT 'Type of document being requested. Common types include Air Waybill (AWB), Bill of Lading (BOL), House Air Waybill (HAWB), Master Air Waybill (MAWB), Master Bill of Lading (MBL), House Bill of Lading (HBL), Certificate of Origin (COO), packing list, commercial invoice, customs declaration, insurance certificate, inspection certificate, phytosanitary certificate, dangerous goods declaration, electronic Proof of Delivery (ePOD), CMR (road), CIM (rail), or other. [ENUM-REF-CANDIDATE: AWB|BOL|HAWB|MAWB|MBL|HBL|COO|packing_list|commercial_invoice|customs_declaration|insurance_certificate|inspection_certificate|phytosanitary_certificate|dangerous_goods_declaration|ePOD|CMR|CIM|other — 18 candidates stripped; promote to reference product]',
    `requesting_party_contact_email` STRING COMMENT 'Primary email address of the requesting party for communication regarding the document request.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requesting_party_contact_phone` STRING COMMENT 'Primary phone number of the requesting party for communication regarding the document request.',
    `requesting_party_name` STRING COMMENT 'Full legal or business name of the party submitting the document request.',
    `requesting_party_type` STRING COMMENT 'Classification of the party submitting the document request, such as customer, carrier, customs authority, internal operations team, freight forwarder, broker, consignee, shipper, regulatory authority, insurance company, surveyor, or other. [ENUM-REF-CANDIDATE: customer|carrier|customs_authority|internal_operations|freight_forwarder|broker|consignee|shipper|regulatory_authority|insurance_company|surveyor|other — 12 candidates stripped; promote to reference product]',
    `required_by_date` DATE COMMENT 'Target date by which the requesting party requires the document to be fulfilled. Used for planning and SLA tracking.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator of whether the document request fulfillment exceeded the SLA target hours, resulting in a service level breach. True indicates breach, False indicates compliance.',
    `sla_target_hours` DECIMAL(18,2) COMMENT 'Target number of hours within which the document request should be fulfilled according to the applicable Service Level Agreement (SLA) based on urgency level and request type.',
    `special_instructions` STRING COMMENT 'Additional instructions or requirements specified by the requesting party for document preparation, format, delivery method, or other special handling.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the document request was originally submitted by the requesting party. Represents the business event timestamp for the request initiation.',
    `urgency_level` STRING COMMENT 'Priority level assigned to the document request indicating the speed of fulfillment required. Routine for non-time-sensitive requests, standard for normal processing, urgent for expedited handling, critical for immediate attention.. Valid values are `routine|standard|urgent|critical`',
    CONSTRAINT pk_request PRIMARY KEY(`request_id`)
) COMMENT 'Transactional record capturing formal requests for document issuance, reissuance, or retrieval submitted by internal teams, customers, carriers, or regulatory authorities. Records request reference, requesting party type, requested document type, associated shipment or trade transaction, urgency level, required by date, request status (open, in-progress, fulfilled, rejected), fulfillment timestamp, and rejection reason. Manages the demand-side of document production and retrieval workflows.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`destruction_record` (
    `destruction_record_id` BIGINT COMMENT 'Unique identifier for the document destruction record. Primary key.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Customs declarations have regulatory retention periods (typically 5-7 years) and eventual destruction - records management and compliance tracking for declaration lifecycle end.',
    `request_id` BIGINT COMMENT 'Reference to the data subject access or erasure request that triggered this destruction, if applicable.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or officer who authorized the destruction event, ensuring accountability and audit trail.',
    `retention_policy_id` BIGINT COMMENT 'Reference to the document retention policy that governed the retention period and triggered this destruction event.',
    `supplier_id` BIGINT COMMENT 'Reference to the third-party vendor or service provider that executed the physical destruction, if outsourced.',
    `tertiary_destruction_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user or system account that last modified this destruction record.',
    `related_destruction_record_id` BIGINT COMMENT 'Self-referencing FK on destruction_record (related_destruction_record_id)',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this destruction record to the broader audit trail or compliance log for end-to-end document lifecycle tracking.',
    `authorizing_officer_email` STRING COMMENT 'Email address of the authorizing officer for notification and audit trail purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `authorizing_officer_name` STRING COMMENT 'Full name of the officer who authorized the destruction, captured for regulatory audit and compliance verification.',
    `carbon_footprint_kg_co2e` DECIMAL(18,2) COMMENT 'Estimated carbon emissions in kilograms of CO2 equivalent associated with the destruction and disposal process, used for GHG reporting.',
    `compliance_certification_flag` BOOLEAN COMMENT 'Indicates whether a formal compliance certification was issued for this destruction event, required for certain regulated document types.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this destruction record was first created in the system, supporting audit trail and data lineage.',
    `data_subject_request_flag` BOOLEAN COMMENT 'Indicates whether this destruction was triggered by a data subject request under GDPR right to erasure (Article 17) or similar privacy regulation.',
    `destruction_certificate_number` STRING COMMENT 'Externally-known unique certificate number issued upon completion of document destruction, used for regulatory audit trail and compliance verification.. Valid values are `^DEST-[0-9]{8}-[A-Z0-9]{6}$`',
    `destruction_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for the destruction service, including vendor fees, labor, and disposal costs.',
    `destruction_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the destruction cost amount.. Valid values are `^[A-Z]{3}$`',
    `destruction_date` DATE COMMENT 'The date on which the physical or digital destruction of documents was executed. Principal business event timestamp for this transaction.',
    `destruction_location` STRING COMMENT 'Physical location or facility where the destruction was performed, including address or facility code.',
    `destruction_location_country_code` STRING COMMENT 'Three-letter ISO country code of the jurisdiction where destruction occurred, critical for cross-border compliance.. Valid values are `^[A-Z]{3}$`',
    `destruction_method` STRING COMMENT 'The method used to destroy the documents. Secure shred for paper, digital purge for electronic records, incineration for sensitive materials, degaussing for magnetic media, overwrite for digital storage.. Valid values are `secure_shred|digital_purge|incineration|pulping|degaussing|overwrite`',
    `destruction_reason` STRING COMMENT 'The business or regulatory reason that triggered the destruction event.. Valid values are `retention_expiry|legal_hold_release|business_request|data_subject_request|system_migration|policy_change`',
    `destruction_status` STRING COMMENT 'Current lifecycle status of the destruction event. Tracks progression from scheduling through completion and verification.. Valid values are `scheduled|in_progress|completed|verified|cancelled|failed`',
    `destruction_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the destruction process was completed, including time zone information for cross-border compliance.',
    `destruction_vendor_name` STRING COMMENT 'Name of the destruction vendor or service provider, captured for audit and vendor management purposes.',
    `digital_storage_size_gb` DECIMAL(18,2) COMMENT 'Total storage size in gigabytes of digital documents purged, used for IT capacity planning and compliance verification.',
    `document_count` STRING COMMENT 'Total number of individual documents or records destroyed in this destruction event.',
    `document_type_destroyed` STRING COMMENT 'The category or type of documents that were destroyed in this event (e.g., Air Waybill, Bill of Lading, Customs Declaration, Invoice, Proof of Delivery).',
    `document_volume_kg` DECIMAL(18,2) COMMENT 'Total weight in kilograms of physical documents destroyed, used for destruction vendor billing and environmental reporting.',
    `environmental_disposal_method` STRING COMMENT 'The environmentally-compliant disposal method used for physical document remnants after destruction, supporting sustainability reporting.. Valid values are `recycling|landfill|incineration_with_energy_recovery|composting|hazardous_waste_facility`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this destruction record was last updated, supporting audit trail and change tracking.',
    `legal_hold_clearance_date` DATE COMMENT 'The date on which the final legal hold was released, authorizing the documents for destruction.',
    `legal_hold_clearance_flag` BOOLEAN COMMENT 'Indicates whether all legal holds on the documents were cleared prior to destruction. True if cleared, False if any hold remains.',
    `notes` STRING COMMENT 'Free-text field for additional notes, exceptions, or special circumstances related to the destruction event.',
    `regulatory_authority` STRING COMMENT 'The governing body or regulatory authority whose requirements mandated the retention period and destruction protocol (e.g., IATA, WCO, national customs authority).',
    `regulatory_reference_number` STRING COMMENT 'Reference number or citation of the specific regulation or policy that governed the destruction (e.g., GDPR Article 17, SOX Section 802).',
    `retention_expiry_date` DATE COMMENT 'The date on which the retention period expired, making the documents eligible for destruction.',
    `retention_period_years` STRING COMMENT 'The number of years the documents were retained before destruction, as mandated by the applicable retention policy.',
    `verification_method` STRING COMMENT 'The method used to verify and confirm that destruction was completed according to policy and regulatory requirements.. Valid values are `visual_inspection|video_recording|digital_audit_log|certificate_of_destruction|third_party_audit`',
    `verification_timestamp` TIMESTAMP COMMENT 'Timestamp when the destruction was verified and confirmed as complete, distinct from the destruction execution timestamp.',
    `witness_name` STRING COMMENT 'Name of the individual who witnessed the destruction process, providing additional verification for high-sensitivity documents.',
    `witness_role` STRING COMMENT 'Job title or role of the witness who verified the destruction process.',
    CONSTRAINT pk_destruction_record PRIMARY KEY(`destruction_record_id`)
) COMMENT 'Transactional record capturing the formal destruction or purge of documents upon expiry of their retention period or upon legal hold release. Records destruction date, destruction method (secure shred, digital purge, incineration), document type and count destroyed, authorizing officer, retention policy applied, confirmation of legal hold clearance, and destruction certificate reference. Provides the regulatory audit trail required by GDPR, IATA, and customs authorities for document lifecycle closure.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`document_exception` (
    `document_exception_id` BIGINT COMMENT 'Unique identifier for the document exception record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Document exceptions (missing documents, incorrect data, late submission) are often attributed to specific carriers for resolution tracking. Required for carrier performance management and SLA complian',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment affected by this document exception, enabling impact analysis on cargo movement.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Document exceptions (missing documents, incorrect data, format errors) are raised against specific customs declarations - exception management and resolution tracking requires linking to the affected ',
    `employee_id` BIGINT COMMENT 'Reference to the internal user or employee who resolved the document exception.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Document exceptions may be attributed to network partners (agents, customs brokers) for resolution. Required for partner performance management and accountability—e.g., tracking customs broker documen',
    `trade_party_id` BIGINT COMMENT 'Reference to the customer, carrier, or partner entity responsible for addressing and resolving the document exception.',
    `transport_document_id` BIGINT COMMENT 'Reference to the transport document or trade document that is subject to this exception.',
    `related_document_exception_id` BIGINT COMMENT 'Self-referencing FK on document_exception (related_document_exception_id)',
    `actual_value` DECIMAL(18,2) COMMENT 'Actual data value or content found in the document that differs from the expected value, used for data mismatch exceptions.',
    `awb_number` STRING COMMENT 'Air Waybill number associated with the exception for air freight shipments, following IATA standard format (3-digit airline prefix and 8-digit serial number).. Valid values are `^[0-9]{3}-[0-9]{8}$`',
    `bol_number` STRING COMMENT 'Bill of Lading number associated with the exception for ocean or ground freight shipments.',
    `compliance_violation_code` STRING COMMENT 'Regulatory or compliance violation code associated with the document exception, if applicable.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicator whether corrective action is required to prevent recurrence of this type of exception (true/false).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the document exception record was first created in the system.',
    `destination_location_code` STRING COMMENT 'Three-letter IATA or UN/LOCODE for the shipment destination location associated with the exception.. Valid values are `^[A-Z]{3}$`',
    `detection_point` STRING COMMENT 'Stage in the logistics lifecycle where the document exception was identified (document upload, customs clearance, cargo release, quality review, audit, carrier acceptance, destination delivery). [ENUM-REF-CANDIDATE: document_upload|customs_clearance|cargo_release|quality_review|audit|carrier_acceptance|destination_delivery — 7 candidates stripped; promote to reference product]',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the document exception was first detected in the system, capturing the real-world event time of discovery.',
    `escalation_level` STRING COMMENT 'Level or authority to which the exception was escalated (supervisor, manager, director, compliance team, legal team).. Valid values are `supervisor|manager|director|compliance_team|legal_team`',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicator whether the exception requires escalation to management or specialized teams for resolution (true/false).',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was escalated to a higher authority or specialized team.',
    `exception_description` STRING COMMENT 'Detailed narrative description of the document exception, including specific discrepancies, missing information, or non-conformance details.',
    `exception_status` STRING COMMENT 'Current lifecycle status of the document exception indicating its resolution state (open, in progress, pending review, resolved, closed, escalated).. Valid values are `open|in_progress|pending_review|resolved|closed|escalated`',
    `exception_type` STRING COMMENT 'Classification of the document exception identifying the nature of the non-conformance (missing document, expired certificate, data mismatch, unauthorized amendment, signature failure, incomplete data).. Valid values are `missing_document|expired_certificate|data_mismatch|unauthorized_amendment|signature_failure|incomplete_data`',
    `expected_document_type` STRING COMMENT 'Type of document that was expected but missing or incorrect, used for missing document exceptions.',
    `expected_value` DECIMAL(18,2) COMMENT 'Expected data value or content that should have been present in the document, used for data mismatch exceptions.',
    `field_name` STRING COMMENT 'Specific document field or data element where the exception was identified, enabling precise error location.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the document exception in terms of penalties, delays, or additional costs.',
    `financial_impact_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the document exception record was last modified or updated.',
    `origin_location_code` STRING COMMENT 'Three-letter IATA or UN/LOCODE for the shipment origin location associated with the exception.. Valid values are `^[A-Z]{3}$`',
    `reference_number` STRING COMMENT 'Business-facing unique reference number for the document exception, used for tracking and communication with stakeholders.. Valid values are `^EXC-[A-Z0-9]{8,12}$`',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or customs authority impacted by or requiring notification of this document exception.',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicator whether the document exception has regulatory compliance implications requiring special handling (true/false).',
    `resolution_action` STRING COMMENT 'Action taken to resolve the document exception (document resubmitted, data corrected, waiver granted, shipment held, alternative document accepted, manual override).. Valid values are `document_resubmitted|data_corrected|waiver_granted|shipment_held|alternative_document_accepted|manual_override`',
    `resolution_notes` STRING COMMENT 'Detailed notes documenting the resolution process, actions taken, and any special circumstances or approvals obtained.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the document exception was successfully resolved and closed.',
    `resolved_by_user_name` STRING COMMENT 'Name of the internal user or employee who resolved the document exception, for audit trail purposes.',
    `responsible_party_contact_email` STRING COMMENT 'Email address of the responsible party contact for exception resolution communication and follow-up.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_party_contact_phone` STRING COMMENT 'Phone number of the responsible party contact for urgent exception resolution communication.',
    `responsible_party_name` STRING COMMENT 'Name of the organization or individual responsible for resolving the document exception, for quick reference and communication.',
    `responsible_party_type` STRING COMMENT 'Classification of the party responsible for resolving the document exception (shipper, consignee, carrier, customs broker, freight forwarder, warehouse, internal operations). [ENUM-REF-CANDIDATE: shipper|consignee|carrier|customs_broker|freight_forwarder|warehouse|internal_operations — 7 candidates stripped; promote to reference product]',
    `root_cause_category` STRING COMMENT 'Classification of the underlying root cause of the document exception (data entry error, system error, process gap, training gap, third party error, regulatory change).. Valid values are `data_entry_error|system_error|process_gap|training_gap|third_party_error|regulatory_change`',
    `severity_level` STRING COMMENT 'Business impact severity classification of the document exception indicating urgency and priority for resolution (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `shipment_delay_hours` STRING COMMENT 'Number of hours the shipment was delayed due to the document exception, impacting service level agreement performance.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicator whether the document exception caused a breach of service level agreement commitments (true/false).',
    CONSTRAINT pk_document_exception PRIMARY KEY(`document_exception_id`)
) COMMENT 'Transactional record capturing document-related exceptions, discrepancies, and non-conformances identified during document processing, customs clearance, or cargo release. Records exception type (missing document, expired certificate, data mismatch, unauthorized amendment, signature failure), severity level, affected document reference, detection point in the logistics lifecycle, responsible party, resolution action, and resolution timestamp. Drives document quality management and operational exception handling workflows.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`notarization_record` (
    `notarization_record_id` BIGINT COMMENT 'Unique identifier for the notarization record. Primary key for the notarization_record product.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Notarized documents may reference the carrier for international shipments requiring authenticated transport documents (e.g., notarized BOL for letter of credit transactions). Required for trade financ',
    `certificate_of_origin_id` BIGINT COMMENT 'Foreign key linking to customs.certificate_of_origin. Business justification: Certificate of Origin documents often require notarization/apostille for certain destination countries (Middle East, Latin America) - legalization tracking and Hague Convention compliance management.',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment associated with the notarized document. Links the notarization to the underlying logistics transaction.',
    `certificate_id` BIGINT COMMENT 'Unique identifier of the digital certificate used for electronic notarization. Links to the digital signature or certificate authority system.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Network partners may facilitate notarization services in destination countries (e.g., correspondent offices arranging local notarization, customs brokers coordinating document authentication). Require',
    `employee_id` BIGINT COMMENT 'User ID of the system user who created this notarization record. Used for audit trail purposes.',
    `transport_document_id` BIGINT COMMENT 'Reference to the transport or trade document that was notarized. Links to the document management system.',
    `superseded_notarization_record_id` BIGINT COMMENT 'Self-referencing FK on notarization_record (superseded_notarization_record_id)',
    `apostille_issuing_authority` STRING COMMENT 'Name of the competent authority designated by the country to issue apostilles under the Hague Convention (typically Secretary of State, Ministry of Foreign Affairs, or designated court).',
    `apostille_number` STRING COMMENT 'Unique apostille certificate number assigned by the competent authority under the Hague Convention. Only applicable when notarization_type is apostille.',
    `awb_number` STRING COMMENT 'Air Waybill number if the notarized document relates to air freight. Provides traceability to the air shipment.',
    `bol_number` STRING COMMENT 'Bill of Lading number if the notarized document relates to ocean or ground freight. Provides traceability to the shipment.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting compliance verification results, special requirements met, or exceptions granted for this notarization.',
    `country_of_notarization` STRING COMMENT 'Three-letter ISO country code of the country where the notarization was performed. Critical for determining applicable legal framework and cross-border recognition.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this notarization record was first created in the system. Used for audit trail and data lineage purposes.',
    `destination_country` STRING COMMENT 'Three-letter ISO country code of the destination country where the notarized document will be used. Determines recognition requirements under Hague Convention or bilateral treaties.. Valid values are `^[A-Z]{3}$`',
    `digital_certificate_applied` BOOLEAN COMMENT 'Indicates whether a digital certificate or electronic seal was applied to the notarization record in addition to or instead of a physical stamp or seal.',
    `expiry_date` DATE COMMENT 'Date on which the notarization expires and is no longer valid for its intended purpose. Calculated from notarization_date plus validity_period_days.',
    `hague_convention_applicable` BOOLEAN COMMENT 'Indicates whether the Hague Convention Abolishing the Requirement of Legalisation for Foreign Public Documents applies between the country of notarization and the destination country. True if apostille is sufficient; false if consular legalization is required.',
    `legalization_chain` STRING COMMENT 'Sequence of authentication steps performed for consular legalization (e.g., notary > county clerk > secretary of state > embassy > ministry of foreign affairs). Applicable for non-Hague Convention countries.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this notarization record was last modified in the system. Updated whenever any field changes.',
    `notarization_date` DATE COMMENT 'Date on which the notarization act was performed and the document was officially certified by the notarizing authority. This is the principal business event timestamp for the notarization.',
    `notarization_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the notarizing authority for performing the notarization or authentication service.',
    `notarization_fee_currency` STRING COMMENT 'Three-letter ISO currency code for the notarization fee amount.. Valid values are `^[A-Z]{3}$`',
    `notarization_location_address` STRING COMMENT 'Full street address of the location where the notarization was performed. May be a notary office, consulate, embassy, or chamber of commerce.',
    `notarization_location_city` STRING COMMENT 'City or municipality where the notarization act was performed.',
    `notarization_reference_number` STRING COMMENT 'Externally-known unique reference number assigned by the notarizing authority to this notarization act. Used for verification and audit purposes.',
    `notarization_status` STRING COMMENT 'Current lifecycle status of the notarization record. Tracks the notarization process from initiation through completion or rejection.. Valid values are `pending|in_progress|completed|rejected|expired|revoked`',
    `notarization_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the notarization act was completed, including time zone. Used for legal timestamping and audit trail purposes.',
    `notarization_type` STRING COMMENT 'Type of notarization or authentication applied to the document. Notarial act is a domestic notarization; apostille is for Hague Convention countries; consular legalization is for non-Hague countries; chamber authentication is by chamber of commerce; embassy certification and ministry attestation are diplomatic authentication methods.. Valid values are `notarial_act|apostille|consular_legalization|chamber_authentication|embassy_certification|ministry_attestation`',
    `notarizing_authority_code` STRING COMMENT 'Standardized code or registration number identifying the notarizing authority within its jurisdiction. Used for verification and lookup purposes.',
    `notarizing_authority_name` STRING COMMENT 'Full legal name of the authority, notary public, consulate, embassy, or chamber of commerce that performed the notarization or authentication.',
    `notary_jurisdiction` STRING COMMENT 'Legal jurisdiction (state, province, or country) in which the notary is authorized to perform notarial acts.',
    `notary_license_number` STRING COMMENT 'License or commission number of the notary public who performed the notarization. Used for verification of notary credentials.',
    `notary_name` STRING COMMENT 'Full name of the individual notary public or authorized officer who performed the notarization act.',
    `payment_method` STRING COMMENT 'Method used to pay the notarization fee (e.g., cash, check, credit card, bank transfer).. Valid values are `cash|check|credit_card|bank_transfer|money_order|digital_payment`',
    `payment_receipt_number` STRING COMMENT 'Receipt or transaction number issued for the notarization fee payment. Used for financial reconciliation and audit purposes.',
    `purpose_of_notarization` STRING COMMENT 'Business reason or legal requirement for the notarization. Examples include customs clearance, import/export compliance, legal proceedings, or contractual requirements.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the notarization meets all regulatory requirements for the intended destination country and document purpose. Set to true after compliance verification.',
    `rejection_reason` STRING COMMENT 'Reason why the notarization request was rejected by the notarizing authority. Only populated when notarization_status is rejected.',
    `revocation_date` DATE COMMENT 'Date on which the notarization was revoked by the issuing authority. Only populated when notarization_status is revoked.',
    `revocation_reason` STRING COMMENT 'Reason why the notarization was revoked (e.g., fraud detected, document error, notary misconduct). Only populated when notarization_status is revoked.',
    `seal_image_url` STRING COMMENT 'Storage location or URL of the digital image of the notary seal or apostille stamp impression.',
    `seal_impression_captured` BOOLEAN COMMENT 'Indicates whether a digital image of the notary seal or apostille stamp impression was captured and stored with the record.',
    `validity_period_days` STRING COMMENT 'Number of days for which the notarization is considered valid for its intended purpose. Varies by document type, destination country, and regulatory requirements.',
    `verification_code` STRING COMMENT 'Unique code or token that can be used to verify the authenticity of the notarization through the verification_url or with the issuing authority.',
    `verification_url` STRING COMMENT 'Web URL where the authenticity of the notarization can be verified online. Increasingly common for apostilles and digital notarizations.',
    `witness_count` STRING COMMENT 'Number of witnesses who signed the notarization document. Typically 0, 1, or 2 depending on jurisdiction and document type.',
    `witness_required` BOOLEAN COMMENT 'Indicates whether witness signatures were required for this notarization act under the applicable legal framework.',
    CONSTRAINT pk_notarization_record PRIMARY KEY(`notarization_record_id`)
) COMMENT 'Transactional record capturing notarization, apostille, legalization, and authentication events applied to transport and trade documents requiring official certification for cross-border acceptance. Records notarization type (notarial act, apostille, consular legalization, chamber of commerce authentication), notarizing authority, notarization date, country of notarization, notary reference number, fee paid, and validity period. Supports international trade document authentication requirements under the Hague Convention.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`document`.`compliance_check` (
    `compliance_check_id` BIGINT COMMENT 'Unique identifier for the document compliance check record. Primary key for the document compliance check entity.',
    `ams_filing_id` BIGINT COMMENT 'Foreign key linking to customs.ams_filing. Business justification: AMS filings undergo compliance validation (manifest accuracy, timing requirements, carrier SCAC verification) - regulatory requirement for advance manifest submission and CBP clearance.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved the compliance check outcome or authorized document release despite warnings. Links to employee record for accountability and audit trail.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Compliance checks validate documents against carrier-specific requirements and regulatory obligations (e.g., carrier-specific dangerous goods documentation rules, carrier customs clearance requirement',
    `certificate_of_origin_id` BIGINT COMMENT 'Foreign key linking to customs.certificate_of_origin. Business justification: Certificate of Origin documents undergo compliance validation (format correctness, issuing authority verification, signature authenticity) - audit trail requirement for preferential tariff program com',
    `consignment_id` BIGINT COMMENT 'Reference to the shipment associated with the document being checked. Enables linking compliance checks to operational shipment records for end-to-end visibility and exception management.',
    `declaration_id` BIGINT COMMENT 'Reference to the customs declaration record if the compliance check is part of pre-filing validation for customs authorities. Links to customs entry or export declaration entity.',
    `isf_filing_id` BIGINT COMMENT 'Foreign key linking to customs.isf_filing. Business justification: ISF filings are subject to compliance checks (timeliness validation, data completeness, accuracy verification) - CBP penalty avoidance and 10+2 rule compliance management.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Compliance checks validate documents against network partner requirements (e.g., hub-specific documentation rules, customs broker compliance standards). Required for partner-specific compliance valida',
    `primary_compliance_employee_id` BIGINT COMMENT 'Reference to the user who performed or initiated the compliance check. Applicable for manual or hybrid checks. Links to employee or contractor record for accountability and audit purposes.',
    `tertiary_compliance_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified the compliance check record. Links to employee or system account for change tracking and audit purposes.',
    `transport_document_id` BIGINT COMMENT 'Reference to the document being validated. Links to the transport_document or other document entity that underwent compliance checking.',
    `recheck_compliance_check_id` BIGINT COMMENT 'Self-referencing FK on compliance_check (recheck_compliance_check_id)',
    `actual_completion_minutes` STRING COMMENT 'Actual time in minutes taken to complete the compliance check, measured from check initiation to outcome recording. Used for SLA compliance reporting and process improvement analysis.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether the compliance check outcome requires supervisory or management approval before the document can be released. True for high-risk shipments, conditional passes, or manual overrides of automated failures.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance check outcome was approved by authorized personnel. Applicable when approval_required_flag is true. Critical for audit trails and regulatory compliance.',
    `awb_number` STRING COMMENT 'Air Waybill number if the document being checked is an AWB or relates to air freight. Denormalized for quick reference and reporting. Format typically follows IATA standards (3-digit airline prefix + 8-digit serial number).',
    `bol_number` STRING COMMENT 'Bill of Lading number if the document being checked is a BOL or relates to ocean/road freight. Denormalized for quick reference and reporting. Used for cross-referencing with carrier and customs systems.',
    `check_completion_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance check was finalized and outcome recorded. May differ from execution timestamp for manual checks or multi-stage validations.',
    `check_execution_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance check was executed. Represents the moment the validation logic was run against the document. Critical for audit trails and regulatory reporting.',
    `check_method` STRING COMMENT 'Mechanism by which the compliance check was performed. Automated indicates system-driven validation rules; manual indicates human review; hybrid indicates combination of automated pre-screening followed by manual verification.. Valid values are `automated|manual|hybrid`',
    `check_outcome` STRING COMMENT 'Result of the compliance validation. Pass indicates full compliance with no issues; fail indicates critical violations preventing document release; warning indicates minor issues requiring attention but not blocking release; conditional_pass indicates compliance subject to remediation of specified items.. Valid values are `pass|fail|warning|conditional_pass`',
    `check_priority` STRING COMMENT 'Priority assigned to the compliance check based on shipment urgency, customer SLA, or regulatory deadline. Urgent checks are processed immediately; high priority within hours; normal within standard SLA; low as capacity permits.. Valid values are `urgent|high|normal|low`',
    `check_reference_number` STRING COMMENT 'Business-readable unique reference number assigned to this compliance check for tracking and audit purposes. Used in communications with regulatory authorities and internal quality teams.',
    `check_status` STRING COMMENT 'Current lifecycle status of the compliance check execution. Tracks whether the check is pending initiation, actively running, successfully completed, cancelled before completion, or failed due to system error.. Valid values are `pending|in_progress|completed|cancelled|failed`',
    `check_type` STRING COMMENT 'Category of compliance validation performed. Defines the nature of the check: completeness (all required fields present), data accuracy (values within valid ranges), regulatory format (structure matches authority requirements), signature validity (digital signature verification), expiry validation (document within validity period), HS code validation (tariff classification correctness), party screening (denied party check), or dangerous goods (IMDG/IATA compliance). [ENUM-REF-CANDIDATE: completeness|data_accuracy|regulatory_format|signature_validity|expiry_validation|hs_code_validation|party_screening|dangerous_goods — 8 candidates stripped; promote to reference product]',
    `checker_name` STRING COMMENT 'Name of the individual or system component that executed the compliance check. For manual checks, the full name of the compliance officer or customs specialist. For automated checks, the name of the validation service or module.',
    `checker_role` STRING COMMENT 'Functional role or job title of the person who performed the check. Examples: Customs Compliance Officer, Trade Compliance Specialist, Quality Assurance Analyst, Dangerous Goods Specialist. Provides context for the level of expertise applied.',
    `checker_system_name` STRING COMMENT 'Name of the automated system or software module that performed the compliance validation. Examples: Descartes Customs Validation Engine, SAP TM Compliance Module, Internal Document QA Service. Used for system audit and troubleshooting.',
    `checker_type` STRING COMMENT 'Category of entity that performed the compliance check. System indicates automated validation engine; user indicates manual review by internal staff; third_party indicates external compliance service provider or customs broker.. Valid values are `system|user|third_party`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this compliance check record was first created in the system. Represents the moment the check was initiated or queued. Part of standard audit trail.',
    `document_type` STRING COMMENT 'Type of document that was checked. Examples: AWB (Air Waybill), BOL (Bill of Lading), Commercial Invoice, Packing List, Certificate of Origin, Dangerous Goods Declaration, Customs Declaration. Denormalized for query performance and reporting.',
    `document_version_number` STRING COMMENT 'Version number of the document at the time the compliance check was performed. Ensures traceability when documents are revised and re-checked. Links to document version history.',
    `error_code` STRING COMMENT 'Standardized error code assigned to the compliance failure. Enables categorization and trending of common compliance issues. May align with regulatory authority error code schemes or internal quality management codes.',
    `error_severity` STRING COMMENT 'Severity classification of the compliance issue. Critical errors block document submission; high errors require immediate remediation; medium errors should be addressed before release; low errors are minor quality issues; informational items are advisory only.. Valid values are `critical|high|medium|low|informational`',
    `failed_validation_rules` STRING COMMENT 'Comma-separated list or structured text of specific validation rule identifiers that failed during this check. Provides detailed breakdown of which compliance criteria were not met. Used for remediation guidance and root cause analysis.',
    `failure_reason` STRING COMMENT 'Detailed explanation of why the compliance check failed or generated warnings. Includes specific field names, missing data elements, format violations, or regulatory requirement breaches. Used by document preparers to understand and correct issues.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this compliance check record was last updated. Tracks changes to check status, outcome, or associated metadata. Part of standard audit trail for data governance.',
    `notes` STRING COMMENT 'Free-text notes or comments added by checkers, approvers, or system administrators regarding the compliance check. May include additional context, special handling instructions, or follow-up actions required.',
    `override_reason` STRING COMMENT 'Explanation provided when a compliance check failure is overridden and the document is released despite not passing all validations. Requires management authorization and is subject to audit review. Documents business justification for exception.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body or customs authority for which this compliance check was performed. Examples: US CBP, UK HMRC, EU Commission, IATA, IMO. Identifies the jurisdiction and enforcement agency.',
    `regulatory_framework` STRING COMMENT 'Governing regulatory standard or framework against which compliance was validated. Examples include WCO Data Model, IATA Cargo-IMP, US AMS, EU ICS2, C-TPAT, AEO, IMDG Code, ICAO Technical Instructions. Identifies the authority and rule set applied.',
    `remediation_action` STRING COMMENT 'Specific corrective action recommended to resolve the compliance issue. Provides guidance to document preparers on how to fix the identified problems. May include field-level instructions or references to regulatory guidance.',
    `remediation_deadline` TIMESTAMP COMMENT 'Date and time by which remediation must be completed to meet shipment or regulatory filing deadlines. Calculated based on shipment ETD, customs filing cutoff, or other time-sensitive milestones.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required before the document can be submitted to regulatory authorities or released to counterparties. True if document must be corrected and re-checked; false if check outcome allows proceeding.',
    `retry_count` STRING COMMENT 'Number of times the compliance check was retried due to system errors, timeouts, or inconclusive results. Tracks reliability of automated validation processes and identifies problematic documents or rule sets.',
    `sla_target_completion_minutes` STRING COMMENT 'Target time in minutes within which the compliance check should be completed, based on service level agreements or operational standards. Used to measure check processing performance and identify delays.',
    `validation_rule_set_code` STRING COMMENT 'Identifier of the specific rule set or validation profile applied during this check. Links to the configuration of business rules, field validations, and compliance criteria used. Enables traceability of which version of rules was applied.',
    `validation_rule_version` STRING COMMENT 'Version number of the validation rule set applied. Critical for audit trails when rule sets are updated to reflect regulatory changes. Ensures reproducibility of compliance decisions.',
    CONSTRAINT pk_compliance_check PRIMARY KEY(`compliance_check_id`)
) COMMENT 'Transactional record capturing automated and manual compliance validation checks performed against documents prior to submission to regulatory authorities or release to counterparties. Records check type (completeness, data accuracy, regulatory format, signature validity, expiry validation), check execution timestamp, check outcome (pass, fail, warning), failed validation rules, remediation required flag, and checker identity (system or user). Supports pre-submission document quality gates for customs, IATA, and trade compliance.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ADD CONSTRAINT `fk_document_transport_document_parent_document_transport_document_id` FOREIGN KEY (`parent_document_transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ADD CONSTRAINT `fk_document_transport_document_superseded_transport_document_id` FOREIGN KEY (`superseded_transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ADD CONSTRAINT `fk_document_template_predecessor_template_id` FOREIGN KEY (`predecessor_template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ADD CONSTRAINT `fk_document_template_derived_from_template_id` FOREIGN KEY (`derived_from_template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ADD CONSTRAINT `fk_document_version_superseded_version_id` FOREIGN KEY (`superseded_version_id`) REFERENCES `transport_shipping_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ADD CONSTRAINT `fk_document_version_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ADD CONSTRAINT `fk_document_version_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ADD CONSTRAINT `fk_document_trade_document_previous_version_trade_document_id` FOREIGN KEY (`previous_version_trade_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`trade_document`(`trade_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ADD CONSTRAINT `fk_document_trade_document_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ADD CONSTRAINT `fk_document_trade_document_superseded_trade_document_id` FOREIGN KEY (`superseded_trade_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`trade_document`(`trade_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ADD CONSTRAINT `fk_document_digital_signature_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ADD CONSTRAINT `fk_document_digital_signature_countersigned_digital_signature_id` FOREIGN KEY (`countersigned_digital_signature_id`) REFERENCES `transport_shipping_ecm`.`document`.`digital_signature`(`digital_signature_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ADD CONSTRAINT `fk_document_retention_policy_superseded_by_policy_retention_policy_id` FOREIGN KEY (`superseded_by_policy_retention_policy_id`) REFERENCES `transport_shipping_ecm`.`document`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ADD CONSTRAINT `fk_document_retention_policy_superseded_retention_policy_id` FOREIGN KEY (`superseded_retention_policy_id`) REFERENCES `transport_shipping_ecm`.`document`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ADD CONSTRAINT `fk_document_issuance_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ADD CONSTRAINT `fk_document_issuance_original_issuance_id` FOREIGN KEY (`original_issuance_id`) REFERENCES `transport_shipping_ecm`.`document`.`issuance`(`issuance_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ADD CONSTRAINT `fk_document_issuance_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ADD CONSTRAINT `fk_document_issuance_type_id` FOREIGN KEY (`type_id`) REFERENCES `transport_shipping_ecm`.`document`.`type`(`type_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ADD CONSTRAINT `fk_document_issuance_reissued_issuance_id` FOREIGN KEY (`reissued_issuance_id`) REFERENCES `transport_shipping_ecm`.`document`.`issuance`(`issuance_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ADD CONSTRAINT `fk_document_document_package_template_id` FOREIGN KEY (`template_id`) REFERENCES `transport_shipping_ecm`.`document`.`template`(`template_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ADD CONSTRAINT `fk_document_document_package_parent_document_package_id` FOREIGN KEY (`parent_document_package_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_package`(`document_package_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ADD CONSTRAINT `fk_document_amendment_superseded_amendment_id` FOREIGN KEY (`superseded_amendment_id`) REFERENCES `transport_shipping_ecm`.`document`.`amendment`(`amendment_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ADD CONSTRAINT `fk_document_amendment_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ADD CONSTRAINT `fk_document_certificate_superseded_certificate_id` FOREIGN KEY (`superseded_certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ADD CONSTRAINT `fk_document_access_log_related_access_log_id` FOREIGN KEY (`related_access_log_id`) REFERENCES `transport_shipping_ecm`.`document`.`access_log`(`access_log_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_parent_workflow_id` FOREIGN KEY (`parent_workflow_id`) REFERENCES `transport_shipping_ecm`.`document`.`workflow`(`workflow_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ADD CONSTRAINT `fk_document_workflow_type_id` FOREIGN KEY (`type_id`) REFERENCES `transport_shipping_ecm`.`document`.`type`(`type_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ADD CONSTRAINT `fk_document_workflow_task_digital_signature_id` FOREIGN KEY (`digital_signature_id`) REFERENCES `transport_shipping_ecm`.`document`.`digital_signature`(`digital_signature_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ADD CONSTRAINT `fk_document_workflow_task_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ADD CONSTRAINT `fk_document_workflow_task_workflow_id` FOREIGN KEY (`workflow_id`) REFERENCES `transport_shipping_ecm`.`document`.`workflow`(`workflow_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ADD CONSTRAINT `fk_document_workflow_task_predecessor_workflow_task_id` FOREIGN KEY (`predecessor_workflow_task_id`) REFERENCES `transport_shipping_ecm`.`document`.`workflow_task`(`workflow_task_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ADD CONSTRAINT `fk_document_storage_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ADD CONSTRAINT `fk_document_storage_version_id` FOREIGN KEY (`version_id`) REFERENCES `transport_shipping_ecm`.`document`.`version`(`version_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ADD CONSTRAINT `fk_document_storage_parent_storage_id` FOREIGN KEY (`parent_storage_id`) REFERENCES `transport_shipping_ecm`.`document`.`storage`(`storage_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `transport_shipping_ecm`.`document`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ADD CONSTRAINT `fk_document_legal_hold_extended_legal_hold_id` FOREIGN KEY (`extended_legal_hold_id`) REFERENCES `transport_shipping_ecm`.`document`.`legal_hold`(`legal_hold_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ADD CONSTRAINT `fk_document_type_parent_type_id` FOREIGN KEY (`parent_type_id`) REFERENCES `transport_shipping_ecm`.`document`.`type`(`type_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ADD CONSTRAINT `fk_document_distribution_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ADD CONSTRAINT `fk_document_distribution_redistribution_distribution_id` FOREIGN KEY (`redistribution_distribution_id`) REFERENCES `transport_shipping_ecm`.`document`.`distribution`(`distribution_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_request_transport_document_id` FOREIGN KEY (`request_transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ADD CONSTRAINT `fk_document_request_original_request_id` FOREIGN KEY (`original_request_id`) REFERENCES `transport_shipping_ecm`.`document`.`request`(`request_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ADD CONSTRAINT `fk_document_destruction_record_request_id` FOREIGN KEY (`request_id`) REFERENCES `transport_shipping_ecm`.`document`.`request`(`request_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ADD CONSTRAINT `fk_document_destruction_record_retention_policy_id` FOREIGN KEY (`retention_policy_id`) REFERENCES `transport_shipping_ecm`.`document`.`retention_policy`(`retention_policy_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ADD CONSTRAINT `fk_document_destruction_record_related_destruction_record_id` FOREIGN KEY (`related_destruction_record_id`) REFERENCES `transport_shipping_ecm`.`document`.`destruction_record`(`destruction_record_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ADD CONSTRAINT `fk_document_document_exception_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ADD CONSTRAINT `fk_document_document_exception_related_document_exception_id` FOREIGN KEY (`related_document_exception_id`) REFERENCES `transport_shipping_ecm`.`document`.`document_exception`(`document_exception_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ADD CONSTRAINT `fk_document_notarization_record_certificate_id` FOREIGN KEY (`certificate_id`) REFERENCES `transport_shipping_ecm`.`document`.`certificate`(`certificate_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ADD CONSTRAINT `fk_document_notarization_record_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ADD CONSTRAINT `fk_document_notarization_record_superseded_notarization_record_id` FOREIGN KEY (`superseded_notarization_record_id`) REFERENCES `transport_shipping_ecm`.`document`.`notarization_record`(`notarization_record_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ADD CONSTRAINT `fk_document_compliance_check_transport_document_id` FOREIGN KEY (`transport_document_id`) REFERENCES `transport_shipping_ecm`.`document`.`transport_document`(`transport_document_id`);
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ADD CONSTRAINT `fk_document_compliance_check_recheck_compliance_check_id` FOREIGN KEY (`recheck_compliance_check_id`) REFERENCES `transport_shipping_ecm`.`document`.`compliance_check`(`compliance_check_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`document` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `transport_shipping_ecm`.`document` SET TAGS ('dbx_domain' = 'document');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` SET TAGS ('dbx_subdomain' = 'record_management');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `parent_document_transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Document ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `superseded_transport_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `consignee_address` SET TAGS ('dbx_business_glossary_term' = 'Consignee Address');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `consignee_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `consignee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `declared_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `digital_signature_applied` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Applied');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'Digital|Physical|Hybrid');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `freight_charges_prepaid` SET TAGS ('dbx_business_glossary_term' = 'Freight Charges Prepaid');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `goods_description` SET TAGS ('dbx_business_glossary_term' = 'Goods Description');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `issuing_party_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Party Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `issuing_party_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Party Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `notify_party_name` SET TAGS ('dbx_business_glossary_term' = 'Notify Party Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `number_of_packages` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `shipper_address` SET TAGS ('dbx_business_glossary_term' = 'Shipper Address');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `shipper_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `shipper_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `shipper_name` SET TAGS ('dbx_business_glossary_term' = 'Shipper Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `shipper_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (Cubic Meters)');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `transport_shipping_ecm`.`document`.`transport_document` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` SET TAGS ('dbx_subdomain' = 'record_management');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Document Template Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `predecessor_template_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Template Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `derived_from_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `applicable_mode` SET TAGS ('dbx_business_glossary_term' = 'Applicable Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `applicable_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|parcel');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `archival_required` SET TAGS ('dbx_business_glossary_term' = 'Archival Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `audit_trail_enabled` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `compliance_certification` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `digital_signature_required` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `document_subtype` SET TAGS ('dbx_business_glossary_term' = 'Document Subtype');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `document_type_category` SET TAGS ('dbx_business_glossary_term' = 'Document Type Category');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `document_type_category` SET TAGS ('dbx_value_regex' = 'transport_document|trade_document|customs_document|compliance_certificate|proof_of_delivery|commercial_invoice');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `edi_message_type` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Message Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `file_hash` SET TAGS ('dbx_business_glossary_term' = 'Template File Hash');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `file_hash` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'Template File Path');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `jurisdiction_scope` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Scope');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `layout_format` SET TAGS ('dbx_business_glossary_term' = 'Layout Format');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `layout_format` SET TAGS ('dbx_value_regex' = 'PDF|XML|EDI|JSON|HTML|DOCX');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `mandatory_field_definitions` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Field Definitions');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `multilingual_support` SET TAGS ('dbx_business_glossary_term' = 'Multilingual Support Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `optional_field_definitions` SET TAGS ('dbx_business_glossary_term' = 'Optional Field Definitions');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Template Owner');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `page_size_standard` SET TAGS ('dbx_business_glossary_term' = 'Page Size Standard');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `page_size_standard` SET TAGS ('dbx_value_regex' = 'A4|Letter|Legal|A3|Custom');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `print_layout_orientation` SET TAGS ('dbx_business_glossary_term' = 'Print Layout Orientation');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `print_layout_orientation` SET TAGS ('dbx_value_regex' = 'portrait|landscape');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `retention_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Event');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `retention_trigger_event` SET TAGS ('dbx_value_regex' = 'document_creation|shipment_completion|customs_clearance|contract_expiry|claim_settlement');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `signature_standard` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Standard');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `signature_standard` SET TAGS ('dbx_value_regex' = 'PKI|eIDAS|ESIGN|DocuSign|AdobeSign|None');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{4,20}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Lifecycle Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `template_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|deprecated|retired|suspended');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `version_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `version_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Version Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `watermark_required` SET TAGS ('dbx_business_glossary_term' = 'Watermark Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `watermark_text` SET TAGS ('dbx_business_glossary_term' = 'Watermark Text');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `xml_schema_version` SET TAGS ('dbx_business_glossary_term' = 'Extensible Markup Language (XML) Schema Version');
ALTER TABLE `transport_shipping_ecm`.`document`.`template` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` SET TAGS ('dbx_subdomain' = 'lifecycle_processing');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Document Version Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Related Customs Declaration Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `superseded_version_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Version Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `version_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Author Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `version_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `version_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `version_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `version_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `version_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `access_control_level` SET TAGS ('dbx_business_glossary_term' = 'Access Control Level');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `access_control_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_value_regex' = 'amendment|correction|regulatory_update|customer_request|internal_review|system_migration');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `checksum_hash` SET TAGS ('dbx_business_glossary_term' = 'Checksum Hash');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `compliance_classification` SET TAGS ('dbx_business_glossary_term' = 'Compliance Classification');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `digital_signature` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `digital_signature` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `document_artifact_uri` SET TAGS ('dbx_business_glossary_term' = 'Document Artifact Uniform Resource Identifier (URI)');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `document_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Document Size in Bytes');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `is_master_version` SET TAGS ('dbx_business_glossary_term' = 'Is Master Version Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `version_date` SET TAGS ('dbx_business_glossary_term' = 'Version Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`version` ALTER COLUMN `version_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|active|superseded|archived');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` SET TAGS ('dbx_subdomain' = 'record_management');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `trade_document_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Document ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `previous_version_trade_document_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Version ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Document Template ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `superseded_trade_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `archival_date` SET TAGS ('dbx_business_glossary_term' = 'Document Archival Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Document Authentication Method');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'digital_signature|notarized|apostille|embassy_legalization|chamber_stamp|none');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `authentication_status` SET TAGS ('dbx_business_glossary_term' = 'Authentication Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `authentication_status` SET TAGS ('dbx_value_regex' = 'pending|verified|failed|not_required');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Consignee Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `denied_party_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Denied Party Screening Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `denied_party_screening_status` SET TAGS ('dbx_value_regex' = 'not_screened|cleared|flagged|under_review');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `digital_signature` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Hash');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `digital_signature` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Document Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Document Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Document Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'commercial_invoice|packing_list|certificate_of_origin|phytosanitary_certificate|fumigation_certificate|inspection_certificate');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `exporter_name` SET TAGS ('dbx_business_glossary_term' = 'Exporter Legal Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `exporter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `exporter_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Exporter Tax Identification Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `exporter_tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `freight_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Charges Amount');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `freight_charges_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `importer_name` SET TAGS ('dbx_business_glossary_term' = 'Importer Legal Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `importer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `importer_tax_number` SET TAGS ('dbx_business_glossary_term' = 'Importer Tax Identification Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `importer_tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `insurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Amount');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `insurance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Document Issue Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `letter_of_credit_number` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `letter_of_credit_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `notify_party_name` SET TAGS ('dbx_business_glossary_term' = 'Notify Party Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `notify_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Document Retention Period in Years');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `total_gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `total_net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Net Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `total_package_count` SET TAGS ('dbx_business_glossary_term' = 'Total Package Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (CBM)');
ALTER TABLE `transport_shipping_ecm`.`document`.`trade_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `digital_signature_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Signatory ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `countersigned_digital_signature_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `biometric_data_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Biometric Data Captured Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `biometric_data_captured_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `biometric_data_captured_flag` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `biometric_data_type` SET TAGS ('dbx_business_glossary_term' = 'Biometric Data Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `biometric_data_type` SET TAGS ('dbx_value_regex' = 'fingerprint|facial_recognition|signature_dynamics|iris_scan|voice_recognition');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `biometric_data_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `biometric_data_type` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `certificate_authority` SET TAGS ('dbx_business_glossary_term' = 'Certificate Authority (CA)');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `certificate_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Serial Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `consent_accepted_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Accepted Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `consent_statement` SET TAGS ('dbx_business_glossary_term' = 'Consent Statement');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `document_version_number` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Hash Algorithm');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `hash_algorithm` SET TAGS ('dbx_value_regex' = 'SHA-256|SHA-384|SHA-512|SHA3-256|SHA3-512');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `legal_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Legal Jurisdiction');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `legal_validity_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Validity Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Signature Notes');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signatory_email` SET TAGS ('dbx_business_glossary_term' = 'Signatory Email Address');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signatory_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signatory_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signatory_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Full Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signatory_role` SET TAGS ('dbx_business_glossary_term' = 'Signatory Role');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signature_hash` SET TAGS ('dbx_business_glossary_term' = 'Signature Hash Value');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signature_image_url` SET TAGS ('dbx_business_glossary_term' = 'Signature Image Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signature_method` SET TAGS ('dbx_business_glossary_term' = 'Signature Method');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signature_purpose` SET TAGS ('dbx_business_glossary_term' = 'Signature Purpose');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signature_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Signature Reference Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signature_status` SET TAGS ('dbx_business_glossary_term' = 'Signature Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signature_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|revoked|expired|pending_verification|verification_failed');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Signature Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signature_type` SET TAGS ('dbx_business_glossary_term' = 'Signature Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signature_type` SET TAGS ('dbx_value_regex' = 'qualified|advanced|simple');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signing_device_code` SET TAGS ('dbx_business_glossary_term' = 'Signing Device ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signing_device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signing_device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signing_device_type` SET TAGS ('dbx_business_glossary_term' = 'Signing Device Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signing_location_address` SET TAGS ('dbx_business_glossary_term' = 'Signing Location Address');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signing_location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signing_location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signing_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Signing Location Latitude');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signing_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signing_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signing_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Signing Location Longitude');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signing_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signing_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `signing_platform` SET TAGS ('dbx_business_glossary_term' = 'Signing Platform');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `timestamp_authority` SET TAGS ('dbx_business_glossary_term' = 'Timestamp Authority');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `timestamp_token` SET TAGS ('dbx_business_glossary_term' = 'Timestamp Token');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `verification_result` SET TAGS ('dbx_value_regex' = 'verified|failed|certificate_revoked|certificate_expired|hash_mismatch|not_verified');
ALTER TABLE `transport_shipping_ecm`.`document`.`digital_signature` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `superseded_by_policy_retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Policy ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `superseded_retention_policy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `applies_to_digital` SET TAGS ('dbx_business_glossary_term' = 'Applies to Digital Documents');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `applies_to_physical` SET TAGS ('dbx_business_glossary_term' = 'Applies to Physical Documents');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `automated_purge_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automated Purge Enabled');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `business_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Owner');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `destruction_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Destruction Authorization Required');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `destruction_method` SET TAGS ('dbx_business_glossary_term' = 'Destruction Method');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `destruction_method` SET TAGS ('dbx_value_regex' = 'secure_shred|digital_purge|incineration|degaussing|overwrite|archive_transfer');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `encryption_required` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `exception_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exception Criteria');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `legal_citation` SET TAGS ('dbx_business_glossary_term' = 'Legal Citation');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `legal_hold_override_allowed` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Override Allowed');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `maximum_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retention Period (Years)');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `minimum_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Retention Period (Years)');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `notification_before_destruction_days` SET TAGS ('dbx_business_glossary_term' = 'Notification Before Destruction (Days)');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|superseded|suspended|archived');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'regulatory|legal|operational|contractual|tax|audit');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `privacy_classification` SET TAGS ('dbx_business_glossary_term' = 'Privacy Classification');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `privacy_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted|pii|phi');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `retention_trigger_event` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Event');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `storage_location_requirement` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Requirement');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `storage_location_requirement` SET TAGS ('dbx_value_regex' = 'on_premise|cloud|hybrid|secure_archive|offsite_vault');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`retention_policy` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` SET TAGS ('dbx_subdomain' = 'lifecycle_processing');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Document Issuance ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `broker_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Broker Assignment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Certificate ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing User ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `issuing_entity_trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Entity ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `original_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Original Issuance ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Party ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `reissued_issuance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `acknowledgement_reference` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Reference');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|not_acknowledged|failed');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `checksum_hash` SET TAGS ('dbx_business_glossary_term' = 'Checksum Hash');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `checksum_hash` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `compliance_validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Validation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Delivery Channel');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'email|edi|portal|api|physical|fax');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `delivery_method_detail` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method Detail');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `digital_signature_applied` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Applied');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Path');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `document_version_number` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'PDF|XML|EDI|JSON|TIFF|DOCX');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size Bytes');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `issuance_status` SET TAGS ('dbx_business_glossary_term' = 'Issuance Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `issuance_status` SET TAGS ('dbx_value_regex' = 'pending|issued|acknowledged|rejected|cancelled|expired');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `issuance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issuance Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `issuing_location_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Location Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `issuing_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `issuing_system_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing System Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `issuing_system_code` SET TAGS ('dbx_value_regex' = 'SAP_TM|ORACLE_TMS|DESCARTES|MANUAL|EDI|API');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `last_transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Transmission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Issuance Notes');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Issuance Purpose');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `purpose` SET TAGS ('dbx_value_regex' = 'original|duplicate|copy|amendment|correction|reissue');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `recipient_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Contact Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `recipient_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `recipient_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `recipient_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `recipient_party_type` SET TAGS ('dbx_business_glossary_term' = 'Recipient Party Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `recipient_party_type` SET TAGS ('dbx_value_regex' = 'shipper|consignee|customs_broker|carrier|freight_forwarder|agent');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Issuance Reference Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Days');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `transmission_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Transmission Attempt Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `transmission_error_message` SET TAGS ('dbx_business_glossary_term' = 'Transmission Error Message');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Transmission Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `transmission_status` SET TAGS ('dbx_value_regex' = 'queued|in_progress|transmitted|failed|retrying');
ALTER TABLE `transport_shipping_ecm`.`document`.`issuance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` SET TAGS ('dbx_subdomain' = 'record_management');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `document_package_id` SET TAGS ('dbx_business_glossary_term' = 'Document Package ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `template_id` SET TAGS ('dbx_business_glossary_term' = 'Template ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `parent_document_package_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `archive_date` SET TAGS ('dbx_business_glossary_term' = 'Archive Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `archive_flag` SET TAGS ('dbx_business_glossary_term' = 'Archive Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `bol_number` SET TAGS ('dbx_value_regex' = '^BOL-[A-Z0-9]{8,15}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `completeness_status` SET TAGS ('dbx_business_glossary_term' = 'Completeness Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `completeness_status` SET TAGS ('dbx_value_regex' = 'complete|incomplete|pending_review|missing_critical');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `compliance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_review|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Package Creation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `customs_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `customs_entry_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `digital_signature_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `encryption_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `hawb_number` SET TAGS ('dbx_business_glossary_term' = 'House Air Waybill (HAWB) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `hawb_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `hbl_number` SET TAGS ('dbx_business_glossary_term' = 'House Bill of Lading (HBL) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `hbl_number` SET TAGS ('dbx_value_regex' = '^HBL-[A-Z0-9]{8,15}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `mawb_number` SET TAGS ('dbx_business_glossary_term' = 'Master Air Waybill (MAWB) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `mawb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `mbl_number` SET TAGS ('dbx_business_glossary_term' = 'Master Bill of Lading (MBL) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `mbl_number` SET TAGS ('dbx_value_regex' = '^MBL-[A-Z0-9]{8,15}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `missing_document_count` SET TAGS ('dbx_business_glossary_term' = 'Missing Document Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `missing_document_list` SET TAGS ('dbx_business_glossary_term' = 'Missing Document List');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Package Notes');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `package_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|complete|submitted|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'shipment|freight_order|customs_declaration|contract|claim|compliance');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `received_document_count` SET TAGS ('dbx_business_glossary_term' = 'Received Document Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Package Reference Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^PKG-[A-Z0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `required_document_count` SET TAGS ('dbx_business_glossary_term' = 'Required Document Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Days');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_TM|Oracle_TMS|Manhattan_WMS|Descartes_Customs|Manual|API');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `submission_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Submission Ready Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Package Version Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_package` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Package Creation Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` SET TAGS ('dbx_subdomain' = 'lifecycle_processing');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Document Amendment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amendment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amendment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amendment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amendment_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amendment_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amendment_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `certificate_of_origin_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Origin Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `contract_party_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `superseded_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Amendment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Original Document Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amended_field_name` SET TAGS ('dbx_business_glossary_term' = 'Amended Field Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amended_value` SET TAGS ('dbx_business_glossary_term' = 'Amended Field Value');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_value_regex' = '^AMD-[A-Z0-9]{8,20}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Lifecycle Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|approved|rejected|withdrawn|completed');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type Classification');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'correction|endorsement|substitution|cancellation|addendum|revision');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Approval Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `approving_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Completion Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `digital_signature` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Hash');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Original Document Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type Classification');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `financial_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `original_value` SET TAGS ('dbx_business_glossary_term' = 'Original Field Value');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Amendment Priority Level');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason Description');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Amendment Request Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `requesting_party_name` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `requesting_party_role` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party Role');
ALTER TABLE `transport_shipping_ecm`.`document`.`amendment` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Amendment Version Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` SET TAGS ('dbx_subdomain' = 'record_management');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `consignee_id` SET TAGS ('dbx_business_glossary_term' = 'Consignee ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `hs_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Hs Classification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `shipper_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Shipper ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `superseded_certificate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'digital_signature|physical_seal|watermark|qr_code|blockchain|manual_verification');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `chemical_used` SET TAGS ('dbx_business_glossary_term' = 'Chemical Used');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `concentration_level` SET TAGS ('dbx_business_glossary_term' = 'Concentration Level');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `digital_signature` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `digital_signature` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `inspector_license_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector License Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `issuing_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `issuing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight in Kilograms (KG)');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `renewal_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency in Days');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `treatment_date` SET TAGS ('dbx_business_glossary_term' = 'Treatment Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `treatment_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Treatment Duration in Hours');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `treatment_duration_hours` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `treatment_duration_hours` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `treatment_type` SET TAGS ('dbx_business_glossary_term' = 'Treatment Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`certificate` ALTER COLUMN `verification_url` SET TAGS ('dbx_business_glossary_term' = 'Verification Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` SET TAGS ('dbx_subdomain' = 'access_control');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `access_log_id` SET TAGS ('dbx_business_glossary_term' = 'Document Access Log ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `certificate_of_origin_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Origin Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Accessor User ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `related_access_log_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `access_channel` SET TAGS ('dbx_business_glossary_term' = 'Access Channel');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `access_channel` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|api|internal_system|email|ftp');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `access_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Access Duration in Seconds');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `access_expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Access Expiry Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `access_granted_by` SET TAGS ('dbx_business_glossary_term' = 'Access Granted By');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `access_location_city` SET TAGS ('dbx_business_glossary_term' = 'Access Location City');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `access_location_country` SET TAGS ('dbx_business_glossary_term' = 'Access Location Country Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `access_location_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `access_outcome` SET TAGS ('dbx_business_glossary_term' = 'Access Outcome');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `access_outcome` SET TAGS ('dbx_value_regex' = 'success|denied|failed|partial');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `access_purpose` SET TAGS ('dbx_business_glossary_term' = 'Access Purpose');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `access_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Access Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `access_type` SET TAGS ('dbx_business_glossary_term' = 'Access Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `accessor_email` SET TAGS ('dbx_business_glossary_term' = 'Accessor Email Address');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `accessor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `accessor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `accessor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `accessor_name` SET TAGS ('dbx_business_glossary_term' = 'Accessor Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `accessor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `accessor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `api_client_code` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Client ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'password|sso|mfa|api_key|certificate|biometric');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification Level');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `device_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `download_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Download Size in Bytes');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `incident_severity` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity Level');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `incident_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_value_regex' = '^(?:[0-9]{1,3}.){3}[0-9]{1,3}$|^([0-9a-fA-F]{1,4}:){7}[0-9a-fA-F]{1,4}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Access Notes');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `organization_unit` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `page_count_accessed` SET TAGS ('dbx_business_glossary_term' = 'Page Count Accessed');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `retention_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Hold Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `security_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `session_code` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `share_recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Share Recipient Email Address');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `share_recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `share_recipient_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `share_recipient_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `shipment_reference` SET TAGS ('dbx_business_glossary_term' = 'Shipment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`access_log` ALTER COLUMN `user_role` SET TAGS ('dbx_business_glossary_term' = 'User Role');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` SET TAGS ('dbx_subdomain' = 'access_control');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Document Workflow Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `parent_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Workflow Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `workflow_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `workflow_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `workflow_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `workflow_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `workflow_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `workflow_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `auto_approval_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Approval Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `auto_approval_threshold` SET TAGS ('dbx_business_glossary_term' = 'Auto-Approval Threshold');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `digital_signature_required` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `escalation_enabled` SET TAGS ('dbx_business_glossary_term' = 'Escalation Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `escalation_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Escalation Hierarchy');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `escalation_rule` SET TAGS ('dbx_business_glossary_term' = 'Escalation Rule');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `is_template` SET TAGS ('dbx_business_glossary_term' = 'Is Template Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `max_revision_cycles` SET TAGS ('dbx_business_glossary_term' = 'Maximum Revision Cycles');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `minimum_approvers` SET TAGS ('dbx_business_glossary_term' = 'Minimum Approvers');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `notification_channels` SET TAGS ('dbx_business_glossary_term' = 'Notification Channels');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `notification_channels` SET TAGS ('dbx_value_regex' = 'email|sms|push|portal|all');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Notification Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `parallel_approval_allowed` SET TAGS ('dbx_business_glossary_term' = 'Parallel Approval Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `rejection_allowed` SET TAGS ('dbx_business_glossary_term' = 'Rejection Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `required_approver_roles` SET TAGS ('dbx_business_glossary_term' = 'Required Approver Roles');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `requires_multi_party_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Multi-Party Approval Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `revision_allowed` SET TAGS ('dbx_business_glossary_term' = 'Revision Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `signature_type` SET TAGS ('dbx_business_glossary_term' = 'Signature Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `signature_type` SET TAGS ('dbx_value_regex' = 'electronic|digital_certificate|biometric|none');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `sla_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Duration Hours');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `stage_sequence` SET TAGS ('dbx_business_glossary_term' = 'Stage Sequence');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `stage_sla_config` SET TAGS ('dbx_business_glossary_term' = 'Stage Service Level Agreement (SLA) Configuration');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `total_stages` SET TAGS ('dbx_business_glossary_term' = 'Total Stages');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Workflow Version');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+.[0-9]+$');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `workflow_code` SET TAGS ('dbx_business_glossary_term' = 'Workflow Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `workflow_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `workflow_description` SET TAGS ('dbx_business_glossary_term' = 'Workflow Description');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `workflow_name` SET TAGS ('dbx_business_glossary_term' = 'Workflow Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow` ALTER COLUMN `workflow_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|suspended|archived');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` SET TAGS ('dbx_subdomain' = 'access_control');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `workflow_task_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Task Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `digital_signature_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Role Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Group Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `quaternary_workflow_delegated_from_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Delegated From User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `quaternary_workflow_delegated_from_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `quaternary_workflow_delegated_from_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `tertiary_workflow_escalated_to_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated To User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `tertiary_workflow_escalated_to_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `tertiary_workflow_escalated_to_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Workflow Instance Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `predecessor_workflow_task_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Assignment Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Task Attachment Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Required Certification Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `conditional_routing_expression` SET TAGS ('dbx_business_glossary_term' = 'Conditional Routing Expression');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `decision_comments` SET TAGS ('dbx_business_glossary_term' = 'Decision Comments');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `delegation_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Delegation Allowed Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `delegation_reason` SET TAGS ('dbx_business_glossary_term' = 'Delegation Reason');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `delegation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Delegation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `digital_signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Task Due Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `due_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Due Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `escalated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Escalation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `last_reminder_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `outcome_decision` SET TAGS ('dbx_business_glossary_term' = 'Task Outcome Decision');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `outcome_decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|returned|escalated|cancelled|no_action_required');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `parallel_task_group_code` SET TAGS ('dbx_business_glossary_term' = 'Parallel Task Group Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Task Priority Level');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `reminder_sent_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Sent Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Task Sequence Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `sla_elapsed_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Elapsed Hours');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Workflow Task Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `task_number` SET TAGS ('dbx_value_regex' = '^WFT-[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Task Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Workflow Task Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`workflow_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'review|approve|sign|reject|acknowledge|validate');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` SET TAGS ('dbx_subdomain' = 'access_control');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `storage_id` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Identifier');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Version Identifier');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `parent_storage_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `access_control_policy` SET TAGS ('dbx_business_glossary_term' = 'Access Control Policy');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_business_glossary_term' = 'Backup Frequency');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `backup_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly|monthly|none');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Checksum Algorithm');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `checksum_algorithm` SET TAGS ('dbx_value_regex' = 'md5|sha1|sha256|sha512|crc32');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Checksum Value');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `class_transition_date` SET TAGS ('dbx_business_glossary_term' = 'Storage Class Transition Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `compression_format` SET TAGS ('dbx_business_glossary_term' = 'Compression Format');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `cost_per_gb_usd` SET TAGS ('dbx_business_glossary_term' = 'Storage Cost per Gigabyte in United States Dollars (USD)');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Storage Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `data_residency_compliant` SET TAGS ('dbx_business_glossary_term' = 'Data Residency Compliant Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `encryption_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Encryption Algorithm');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `encryption_key_reference` SET TAGS ('dbx_business_glossary_term' = 'Encryption Key Identifier');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `encryption_key_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `encryption_status` SET TAGS ('dbx_business_glossary_term' = 'Encryption Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `encryption_status` SET TAGS ('dbx_value_regex' = 'encrypted_at_rest|encrypted_in_transit|encrypted_both|unencrypted');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `last_accessed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Accessed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `last_backup_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Backup Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'cloud_object_store|on_premise_dms|physical_archive|hybrid_storage|edge_storage|backup_vault');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `mime_type` SET TAGS ('dbx_business_glossary_term' = 'Multipurpose Internet Mail Extensions (MIME) Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `path` SET TAGS ('dbx_business_glossary_term' = 'Storage Path or Uniform Resource Identifier (URI)');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `provider` SET TAGS ('dbx_business_glossary_term' = 'Storage Provider');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `provider` SET TAGS ('dbx_value_regex' = 'aws_s3|azure_blob|google_cloud_storage|ibm_cloud|oracle_cloud|on_premise');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Storage Region');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `replication_status` SET TAGS ('dbx_business_glossary_term' = 'Replication Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `replication_status` SET TAGS ('dbx_value_regex' = 'not_replicated|replication_pending|replicated|replication_failed');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `replication_target_region` SET TAGS ('dbx_business_glossary_term' = 'Replication Target Region');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `retention_class` SET TAGS ('dbx_business_glossary_term' = 'Retention Class');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `retrieval_sla_seconds` SET TAGS ('dbx_business_glossary_term' = 'Retrieval Service Level Agreement (SLA) in Seconds');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `storage_status` SET TAGS ('dbx_business_glossary_term' = 'Storage Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `storage_status` SET TAGS ('dbx_value_regex' = 'active|archived|pending_deletion|deleted|corrupted|quarantined');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `storage_tier` SET TAGS ('dbx_business_glossary_term' = 'Storage Tier');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `storage_tier` SET TAGS ('dbx_value_regex' = 'hot|warm|cool|cold|archive|glacier');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Storage Record Updated By User');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Storage Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `versioning_enabled` SET TAGS ('dbx_business_glossary_term' = 'Versioning Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`storage` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Storage Record Created By User');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `legal_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `extended_legal_hold_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `acknowledgment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Received Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `acknowledgment_required` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `affected_document_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Document Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `business_unit_scope` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Scope');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `case_name` SET TAGS ('dbx_business_glossary_term' = 'Case Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `case_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|remediation_required');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `custodian_department` SET TAGS ('dbx_business_glossary_term' = 'Custodian Department');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `custodian_email` SET TAGS ('dbx_business_glossary_term' = 'Custodian Email Address');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `custodian_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `custodian_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `custodian_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Custodian Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `custodian_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Date Range End');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Date Range Start');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `document_types_covered` SET TAGS ('dbx_business_glossary_term' = 'Document Types Covered');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Actual End Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_expected_end_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Expected End Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_priority` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Priority');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Reference Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_reference_number` SET TAGS ('dbx_value_regex' = '^LH-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Scope Description');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_scope_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_start_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Start Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|expired|suspended|pending');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'litigation|regulatory|audit|tax|investigation|compliance');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `issuing_authority_contact` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Contact');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `issuing_authority_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `issuing_authority_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `non_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Notes');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `non_compliance_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Notes');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `override_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Override Retention Policy Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `release_authorization` SET TAGS ('dbx_business_glossary_term' = 'Release Authorization');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `release_authorization` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Release Reason');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `release_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`legal_hold` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` SET TAGS ('dbx_subdomain' = 'record_management');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `parent_type_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `access_control_level` SET TAGS ('dbx_business_glossary_term' = 'Access Control Level');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `access_control_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `archival_required` SET TAGS ('dbx_business_glossary_term' = 'Archival Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `audit_trail_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `customs_declaration_type` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `dangerous_goods_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Indicator');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `default_language` SET TAGS ('dbx_business_glossary_term' = 'Default Language Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `default_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `destruction_method` SET TAGS ('dbx_business_glossary_term' = 'Destruction Method');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `destruction_method` SET TAGS ('dbx_value_regex' = 'secure_delete|shred|incinerate|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `digital_signature_required` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `edi_message_type` SET TAGS ('dbx_business_glossary_term' = 'EDI (Electronic Data Interchange) Message Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `encryption_required` SET TAGS ('dbx_business_glossary_term' = 'Encryption Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `file_format_allowed` SET TAGS ('dbx_business_glossary_term' = 'Allowed File Formats');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `issuance_party_type` SET TAGS ('dbx_business_glossary_term' = 'Issuance Party Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `legal_hold_eligible` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Eligible Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `max_file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Maximum File Size (Megabytes)');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `multilingual_support` SET TAGS ('dbx_business_glossary_term' = 'Multilingual Support Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `required_fields_schema_reference` SET TAGS ('dbx_business_glossary_term' = 'Required Fields Schema Reference');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_business_glossary_term' = 'Retention Trigger Event');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `retention_trigger` SET TAGS ('dbx_value_regex' = 'creation_date|completion_date|expiry_date|last_activity_date|fiscal_year_end');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Document Subcategory');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `template_available` SET TAGS ('dbx_business_glossary_term' = 'Template Available Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `template_reference` SET TAGS ('dbx_business_glossary_term' = 'Template Reference');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Applicable Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal|not_applicable');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `type_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `type_category` SET TAGS ('dbx_value_regex' = 'transport|trade|compliance|certificate|financial|operational');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Document Type Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `type_description` SET TAGS ('dbx_business_glossary_term' = 'Document Type Description');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `type_name` SET TAGS ('dbx_business_glossary_term' = 'Document Type Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `type_status` SET TAGS ('dbx_business_glossary_term' = 'Document Type Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|draft|under_review');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `usage_notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `transport_shipping_ecm`.`document`.`type` ALTER COLUMN `version_control_enabled` SET TAGS ('dbx_business_glossary_term' = 'Version Control Enabled Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` SET TAGS ('dbx_subdomain' = 'lifecycle_processing');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `distribution_id` SET TAGS ('dbx_business_glossary_term' = 'Document Distribution ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Initiated By User ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Recipient Party ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `redistribution_distribution_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `acknowledgement_received_count` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Received Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `acknowledgement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `actual_delivery_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `api_transmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Transmission Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Distribution Batch Reference Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `channel_summary` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Summary');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `digital_signature_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Applied Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `distribution_date` SET TAGS ('dbx_business_glossary_term' = 'Distribution Date and Time');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `distribution_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `distribution_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|partially_failed|failed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `edi_transmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transmission Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `email_transmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Transmission Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `email_transmission_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `email_transmission_flag` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `encryption_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Applied Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `failed_delivery_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Delivery Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `first_acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Acknowledgement Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `initiated_by_system` SET TAGS ('dbx_business_glossary_term' = 'Distribution Initiated By System');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `last_acknowledgement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Acknowledgement Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `last_retry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Retry Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `max_retry_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Attempts');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `next_retry_scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Next Retry Scheduled Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Distribution Notes');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `pending_delivery_count` SET TAGS ('dbx_business_glossary_term' = 'Pending Delivery Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `physical_transmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Physical Transmission Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `portal_transmission_flag` SET TAGS ('dbx_business_glossary_term' = 'Portal Transmission Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Distribution Priority');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `recipient_count` SET TAGS ('dbx_business_glossary_term' = 'Recipient Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `recipient_party_list` SET TAGS ('dbx_business_glossary_term' = 'Recipient Party List');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `sla_target_delivery_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Minutes');
ALTER TABLE `transport_shipping_ecm`.`document`.`distribution` ALTER COLUMN `successful_delivery_count` SET TAGS ('dbx_business_glossary_term' = 'Successful Delivery Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` SET TAGS ('dbx_subdomain' = 'lifecycle_processing');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Document Request ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To User ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Document ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `request_transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Original Document ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `trade_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Transaction ID');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `original_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `assigned_to_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Department');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Request Channel');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `charge_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Charge Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `charge_currency` SET TAGS ('dbx_business_glossary_term' = 'Charge Currency');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `charge_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `fulfillment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|paid|waived|refunded');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `processing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Start Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Request Reason');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Request Reference Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^DR-[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `rejection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rejection Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|fulfilled|rejected|cancelled|on_hold');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'new_issuance|reissuance|retrieval|correction|certification|duplicate');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `requested_document_type` SET TAGS ('dbx_business_glossary_term' = 'Requested Document Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `requesting_party_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party Contact Email');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `requesting_party_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `requesting_party_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `requesting_party_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `requesting_party_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party Contact Phone');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `requesting_party_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `requesting_party_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `requesting_party_name` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `requesting_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `requesting_party_type` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `transport_shipping_ecm`.`document`.`request` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'routine|standard|urgent|critical');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_record_id` SET TAGS ('dbx_business_glossary_term' = 'Destruction Record Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Officer Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `retention_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Destruction Vendor Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `tertiary_destruction_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `tertiary_destruction_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `tertiary_destruction_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `related_destruction_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `authorizing_officer_email` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Officer Email Address');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `authorizing_officer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `authorizing_officer_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `authorizing_officer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `authorizing_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Officer Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `authorizing_officer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `authorizing_officer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `carbon_footprint_kg_co2e` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint in Kilograms Carbon Dioxide Equivalent (kg CO2e)');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `data_subject_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Destruction Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_certificate_number` SET TAGS ('dbx_value_regex' = '^DEST-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Destruction Cost Amount');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Destruction Cost Currency');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_date` SET TAGS ('dbx_business_glossary_term' = 'Destruction Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_location` SET TAGS ('dbx_business_glossary_term' = 'Destruction Location');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destruction Location Country Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_method` SET TAGS ('dbx_business_glossary_term' = 'Destruction Method');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_method` SET TAGS ('dbx_value_regex' = 'secure_shred|digital_purge|incineration|pulping|degaussing|overwrite');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_reason` SET TAGS ('dbx_business_glossary_term' = 'Destruction Reason');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_reason` SET TAGS ('dbx_value_regex' = 'retention_expiry|legal_hold_release|business_request|data_subject_request|system_migration|policy_change');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_status` SET TAGS ('dbx_business_glossary_term' = 'Destruction Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|verified|cancelled|failed');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Destruction Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `destruction_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Destruction Vendor Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `digital_storage_size_gb` SET TAGS ('dbx_business_glossary_term' = 'Digital Storage Size in Gigabytes (GB)');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `document_type_destroyed` SET TAGS ('dbx_business_glossary_term' = 'Document Type Destroyed');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `document_volume_kg` SET TAGS ('dbx_business_glossary_term' = 'Document Volume in Kilograms (kg)');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `environmental_disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Environmental Disposal Method');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `environmental_disposal_method` SET TAGS ('dbx_value_regex' = 'recycling|landfill|incineration_with_energy_recovery|composting|hazardous_waste_facility');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `legal_hold_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Clearance Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `legal_hold_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Clearance Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Destruction Notes');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period in Years');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'visual_inspection|video_recording|digital_audit_log|certificate_of_destruction|third_party_audit');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`destruction_record` ALTER COLUMN `witness_role` SET TAGS ('dbx_business_glossary_term' = 'Witness Role');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` SET TAGS ('dbx_subdomain' = 'lifecycle_processing');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `document_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Document Exception Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolved By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Document Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `related_document_exception_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `awb_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `compliance_violation_code` SET TAGS ('dbx_business_glossary_term' = 'Compliance Violation Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `detection_point` SET TAGS ('dbx_business_glossary_term' = 'Detection Point');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'supervisor|manager|director|compliance_team|legal_team');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_review|resolved|closed|escalated');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'missing_document|expired_certificate|data_mismatch|unauthorized_amendment|signature_failure|incomplete_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `expected_document_type` SET TAGS ('dbx_business_glossary_term' = 'Expected Document Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `expected_value` SET TAGS ('dbx_business_glossary_term' = 'Expected Value');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `field_name` SET TAGS ('dbx_business_glossary_term' = 'Field Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Reference Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^EXC-[A-Z0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'document_resubmitted|data_corrected|waiver_granted|shipment_held|alternative_document_accepted|manual_override');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `resolved_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Resolved By User Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `resolved_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `resolved_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `responsible_party_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Contact Email');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `responsible_party_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `responsible_party_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `responsible_party_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `responsible_party_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Contact Phone');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `responsible_party_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `responsible_party_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'data_entry_error|system_error|process_gap|training_gap|third_party_error|regulatory_change');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `shipment_delay_hours` SET TAGS ('dbx_business_glossary_term' = 'Shipment Delay Hours');
ALTER TABLE `transport_shipping_ecm`.`document`.`document_exception` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_record_id` SET TAGS ('dbx_business_glossary_term' = 'Notarization Record Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `certificate_of_origin_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Origin Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Certificate Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `superseded_notarization_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `apostille_issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Apostille Issuing Authority');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `apostille_number` SET TAGS ('dbx_business_glossary_term' = 'Apostille Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `country_of_notarization` SET TAGS ('dbx_business_glossary_term' = 'Country of Notarization');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `country_of_notarization` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `destination_country` SET TAGS ('dbx_business_glossary_term' = 'Destination Country');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `destination_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `digital_certificate_applied` SET TAGS ('dbx_business_glossary_term' = 'Digital Certificate Applied Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Notarization Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `hague_convention_applicable` SET TAGS ('dbx_business_glossary_term' = 'Hague Convention Applicable Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `legalization_chain` SET TAGS ('dbx_business_glossary_term' = 'Legalization Chain');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_date` SET TAGS ('dbx_business_glossary_term' = 'Notarization Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Notarization Fee Amount');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Notarization Fee Currency');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_location_address` SET TAGS ('dbx_business_glossary_term' = 'Notarization Location Address');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_location_city` SET TAGS ('dbx_business_glossary_term' = 'Notarization Location City');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Notarization Reference Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_status` SET TAGS ('dbx_business_glossary_term' = 'Notarization Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|rejected|expired|revoked');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notarization Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_type` SET TAGS ('dbx_business_glossary_term' = 'Notarization Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarization_type` SET TAGS ('dbx_value_regex' = 'notarial_act|apostille|consular_legalization|chamber_authentication|embassy_certification|ministry_attestation');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarizing_authority_code` SET TAGS ('dbx_business_glossary_term' = 'Notarizing Authority Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notarizing_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Notarizing Authority Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notary_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Notary Jurisdiction');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notary_license_number` SET TAGS ('dbx_business_glossary_term' = 'Notary License Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notary_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notary_name` SET TAGS ('dbx_business_glossary_term' = 'Notary Public Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `notary_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'cash|check|credit_card|bank_transfer|money_order|digital_payment');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `payment_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Receipt Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `purpose_of_notarization` SET TAGS ('dbx_business_glossary_term' = 'Purpose of Notarization');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `seal_image_url` SET TAGS ('dbx_business_glossary_term' = 'Seal Image Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `seal_impression_captured` SET TAGS ('dbx_business_glossary_term' = 'Seal Impression Captured Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `validity_period_days` SET TAGS ('dbx_business_glossary_term' = 'Validity Period in Days');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `verification_code` SET TAGS ('dbx_business_glossary_term' = 'Verification Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `verification_url` SET TAGS ('dbx_business_glossary_term' = 'Verification Uniform Resource Locator (URL)');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`notarization_record` ALTER COLUMN `witness_required` SET TAGS ('dbx_business_glossary_term' = 'Witness Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` SET TAGS ('dbx_subdomain' = 'compliance_governance');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `compliance_check_id` SET TAGS ('dbx_business_glossary_term' = 'Document Compliance Check Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `ams_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Ams Filing Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `certificate_of_origin_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Origin Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `isf_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Isf Filing Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Checker User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `primary_compliance_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `tertiary_compliance_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `tertiary_compliance_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `tertiary_compliance_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `recheck_compliance_check_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `actual_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Minutes');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `awb_number` SET TAGS ('dbx_business_glossary_term' = 'Air Waybill (AWB) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `check_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check Completion Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `check_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check Execution Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `check_method` SET TAGS ('dbx_business_glossary_term' = 'Check Execution Method');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `check_method` SET TAGS ('dbx_value_regex' = 'automated|manual|hybrid');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `check_outcome` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Outcome');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `check_outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|warning|conditional_pass');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `check_priority` SET TAGS ('dbx_business_glossary_term' = 'Check Priority Level');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `check_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `check_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Check Reference Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `check_status` SET TAGS ('dbx_business_glossary_term' = 'Check Execution Status');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `check_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled|failed');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `check_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `checker_name` SET TAGS ('dbx_business_glossary_term' = 'Checker Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `checker_role` SET TAGS ('dbx_business_glossary_term' = 'Checker Role');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `checker_system_name` SET TAGS ('dbx_business_glossary_term' = 'Checker System Name');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `checker_type` SET TAGS ('dbx_business_glossary_term' = 'Checker Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `checker_type` SET TAGS ('dbx_value_regex' = 'system|user|third_party');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `document_version_number` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Validation Error Code');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `error_severity` SET TAGS ('dbx_business_glossary_term' = 'Error Severity Level');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `error_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|informational');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `failed_validation_rules` SET TAGS ('dbx_business_glossary_term' = 'Failed Validation Rules');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Compliance Failure Reason');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Notes');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Remediation Action');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `remediation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Remediation Deadline');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `retry_count` SET TAGS ('dbx_business_glossary_term' = 'Retry Count');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `sla_target_completion_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Completion Minutes');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `validation_rule_set_code` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule Set Identifier (ID)');
ALTER TABLE `transport_shipping_ecm`.`document`.`compliance_check` ALTER COLUMN `validation_rule_version` SET TAGS ('dbx_business_glossary_term' = 'Validation Rule Version');
