-- Schema for Domain: regulatory | Business: Genomics Biotech | Version: v1_mvm
-- Generated on: 2026-05-06 15:33:28

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`regulatory` COMMENT 'Manages regulatory submissions, approvals, and post-market surveillance across global jurisdictions — including FDA 510(k)/PMA filings, CE-IVD/IVDR technical files, EMA submissions, ICH dossiers, adverse event reporting, regulatory intelligence, and labeling compliance. Tracks submission status, agency correspondence, and IVD registration lifecycles. Integrates Veeva Vault for controlled regulatory document management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`regulatory`.`submission` (
    `submission_id` BIGINT COMMENT 'Unique identifier for the regulatory submission record. Primary key for the submission entity.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Regulatory submissions are filed by registered establishments (FDA 510(k)/PMA filers must be registered establishments). Linking submission to the filing establishment_registration record enables trac',
    `acceptance_date` DATE COMMENT 'The date on which the regulatory authority formally accepted the submission for substantive review. Marks the start of the official review clock for submissions with defined review timelines.',
    `adverse_event_reporting_required` BOOLEAN COMMENT 'Boolean flag indicating whether post-market adverse event reporting obligations apply to this submission. True if MDR, vigilance, or adverse event reporting is required, False otherwise.',
    `approval_date` DATE COMMENT 'The date on which the regulatory authority granted approval, clearance, or market authorization for the submission. Null if the submission is not yet approved or was denied.',
    `clinical_data_required` BOOLEAN COMMENT 'Boolean flag indicating whether clinical performance data or clinical evidence is required as part of the submission. True if clinical studies or clinical performance evaluation is mandatory, False otherwise.',
    `clinical_study_reference` STRING COMMENT 'Reference identifier(s) for the clinical studies or clinical performance evaluations included in the submission. May include ClinicalTrials.gov NCT numbers, internal study codes, or published literature references.',
    `competent_authority` STRING COMMENT 'The specific competent authority or notified body responsible for reviewing and approving the submission within the target jurisdiction. For EU IVDR submissions, identifies the notified body number and name.',
    `correspondence_log_reference` STRING COMMENT 'Reference identifier or link to the log of all correspondence exchanged with the regulatory authority regarding this submission (e.g., information requests, deficiency letters, responses, meeting minutes). Typically managed in Veeva Vault or document control system.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this submission record was first created in the regulatory data system. Audit trail field for data lineage and compliance.',
    `device_classification` STRING COMMENT 'The regulatory risk classification assigned to the device or IVD under the target jurisdictions classification system (e.g., FDA Class I/II/III, IVDR Class A/B/C/D, GHTF/IMDRF risk class). Determines the level of regulatory control and submission pathway.',
    `dossier_reference` STRING COMMENT 'The internal or external reference number for the regulatory dossier or technical file associated with this submission. Links to the controlled document set in Veeva Vault or other document management system.',
    `expedited_review_granted` BOOLEAN COMMENT 'Boolean flag indicating whether the regulatory authority granted expedited, priority, or breakthrough designation review status. True if granted, False if denied or not applicable.',
    `expedited_review_requested` BOOLEAN COMMENT 'Boolean flag indicating whether expedited, priority, or breakthrough designation review was requested from the regulatory authority. True if expedited review was requested, False otherwise.',
    `fee_amount` DECIMAL(18,2) COMMENT 'The regulatory submission fee amount paid or payable to the regulatory authority for processing the submission. Expressed in the currency of the target jurisdiction.',
    `fee_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the submission fee amount (e.g., USD, EUR, GBP, JPY).',
    `gmp_certification_required` BOOLEAN COMMENT 'Boolean flag indicating whether GMP or ISO 13485 certification is required as part of the submission. True if quality system certification must be demonstrated, False otherwise.',
    `intended_use` STRING COMMENT 'The intended use or indications for use statement for the product as declared in the regulatory submission. Defines the clinical or research purpose, target population, and claims for the IVD or genomic product.',
    `iso_13485_certificate_number` STRING COMMENT 'The certificate number for the organizations ISO 13485 quality management system certification, if applicable and required for the submission. Null if not required or not yet obtained.',
    `labeling_compliance_verified` BOOLEAN COMMENT 'Boolean flag indicating whether product labeling (IFU, package insert, device labels) has been verified for compliance with target jurisdiction requirements. True if labeling review is complete and compliant, False otherwise.',
    `language` STRING COMMENT 'The primary language in which the regulatory submission dossier is prepared and submitted to the authority. Reflects jurisdiction-specific language requirements (e.g., English for FDA, local language for EU member states).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this submission record was last updated or modified. Audit trail field for tracking changes and data lineage.',
    `local_representative_name` STRING COMMENT 'The name of the authorized representative or legal manufacturer representative appointed in the target jurisdiction, if required. Null if no representative is required or not yet appointed.',
    `local_representative_required` BOOLEAN COMMENT 'Boolean flag indicating whether the target jurisdiction requires the appointment of a local authorized representative or legal manufacturer representative for the submission. True if required, False otherwise.',
    `modified_by_user` STRING COMMENT 'The username or identifier of the user who last modified this submission record. Audit trail field for accountability and compliance.',
    `notified_body_number` STRING COMMENT 'For EU CE-IVD and IVDR submissions, the four-digit identification number assigned to the notified body conducting conformity assessment. Null for non-EU submissions or self-declared conformity.',
    `post_market_surveillance_plan` STRING COMMENT 'Reference to the post-market surveillance plan or post-market clinical follow-up plan submitted as part of the regulatory dossier. Required for IVDR and certain FDA submissions.',
    `predicate_device` STRING COMMENT 'For FDA 510(k) submissions, the legally marketed device to which substantial equivalence is claimed. Includes the predicate device name and 510(k) number. Null for non-510(k) submissions.',
    `priority` STRING COMMENT 'The business priority level assigned to this regulatory submission. Reflects strategic importance, revenue impact, or time-to-market urgency (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `product_scope` STRING COMMENT 'A description of the product(s) or device(s) covered by this regulatory submission. Identifies the IVD assay, sequencing platform, reagent kit, instrument, or gene-editing tool that is the subject of the filing.',
    `registration_number` STRING COMMENT 'The device registration or listing number assigned by the regulatory authority upon approval or clearance (e.g., FDA establishment registration number, EUDAMED UDI-DI, Health Canada device license number). Null if not yet assigned.',
    `regulatory_framework` STRING COMMENT 'The primary regulatory framework or legislation under which the submission is made (e.g., FDA 21 CFR Part 807, IVDR 2017/746, IVDD 98/79/EC, Medical Device Regulation 2017/745, Health Canada MDEL). Defines the legal basis for the submission.',
    `regulatory_pathway` STRING COMMENT 'The specific regulatory pathway or route to market classification under which the submission is filed. Provides additional granularity beyond submission type (e.g., 510(k) Traditional, 510(k) Special, 510(k) Abbreviated, Class I exempt, Class II, Class III PMA, IVDR Class A/B/C/D).',
    `submission_date` DATE COMMENT 'The date on which the regulatory submission was officially filed with the target regulatory authority. Represents the principal business event timestamp for the submission lifecycle.',
    `submission_number` STRING COMMENT 'The externally-known regulatory submission number or dossier reference assigned by the submitting organization or regulatory authority (e.g., FDA 510(k) number K123456, PMA number P210001, CE-IVD technical file reference).',
    `submission_status` STRING COMMENT 'Current lifecycle status of the regulatory submission in the approval workflow. Tracks progression from initial draft through regulatory authority review to final decision (draft, submitted, under review, additional information requested, approved, cleared, denied, withdrawn). [ENUM-REF-CANDIDATE: draft|submitted|under_review|additional_info_requested|approved|cleared|denied|withdrawn — 8 candidates stripped; promote to reference product]',
    `submission_type` STRING COMMENT 'The regulatory pathway classification for the submission. Indicates the type of regulatory filing made to the health authority (e.g., FDA 510(k) premarket notification, PMA premarket approval, De Novo classification request, CE-IVD technical file, IVDR registration, EMA dossier, ICH CTD).. Valid values are `510(k)|PMA|De Novo|CE-IVD|IVDR|EMA Dossier`',
    `target_agency` STRING COMMENT 'The primary health authority or regulatory agency to which the submission is directed (e.g., FDA, EMA, Health Canada, TGA, PMDA, ANVISA, NMPA). Identifies the competent authority responsible for reviewing and approving the submission.',
    `target_decision_date` DATE COMMENT 'The planned or regulatory-mandated target date by which the authority is expected to issue a decision on the submission. Used for tracking review timelines and SLA compliance.',
    `target_jurisdiction` STRING COMMENT 'The country, region, or trading bloc for which regulatory approval is sought (e.g., USA, European Union, Canada, Australia, Japan, Brazil, China). Defines the geographic scope of the regulatory submission.',
    `udi_di` STRING COMMENT 'The Unique Device Identification Device Identifier (UDI-DI) assigned to the product covered by this submission. Required for FDA and EU IVDR submissions. Null if not yet assigned.',
    CONSTRAINT pk_submission PRIMARY KEY(`submission_id`)
) COMMENT 'Master record for every regulatory submission made to a health authority — FDA 510(k), PMA, De Novo, CE-IVD technical file, EMA dossier, ICH CTD, IVDR registration, and country-specific IVD filings. Captures submission type, target agency, target jurisdiction (country/region/trading bloc), submission date, dossier reference, regulatory pathway classification, product scope, predicate device (for 510(k)), lead regulatory affairs owner, and current lifecycle status. Includes jurisdiction-level metadata: applicable regulatory framework, competent authority, IVD classification system, language requirements, and local representative requirement. SSOT for all regulatory filing identities across global jurisdictions.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` (
    `submission_event_id` BIGINT COMMENT 'Unique identifier for each discrete regulatory submission event. Primary key for the submission event record.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Submission events capture decision outcomes including approval_number (STRING field on submission_event). When a submission event results in an approval decision (decision_outcome = APPROVED), it sh',
    `submission_id` BIGINT COMMENT 'Reference to the parent regulatory dossier package that this submission event belongs to. Links to the master dossier record containing all submission materials.',
    `document_id` BIGINT COMMENT 'Foreign key linking to regulatory.document. Business justification: Submission events reference submission packages (submission_package_reference STRING field) and decision letters (decision_letter_reference STRING field). The document table is the master record for c',
    `actual_decision_date` DATE COMMENT 'Actual date when the regulatory agency issued a final decision (approval, rejection, or other disposition) on this submission. Nullable if decision is pending.',
    `agency_receipt_confirmation_number` STRING COMMENT 'Unique confirmation or tracking number issued by the regulatory agency upon receipt of the submission. Provides proof of delivery and agency acknowledgment.',
    `agency_receipt_date` DATE COMMENT 'Date when the regulatory agency officially acknowledged receipt of the submission. Used to establish filing date and review clock start.',
    `approval_number` STRING COMMENT 'Official approval or clearance number issued by the regulatory agency upon successful submission (e.g., FDA 510(k) number, PMA number, CE certificate number). Nullable if not approved.',
    `created_by_user` STRING COMMENT 'User identifier or name of the person who created this submission event record in the system. Audit trail for accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this submission event record was first created in the system. Audit trail for data lineage.',
    `decision_letter_reference` STRING COMMENT 'Reference identifier or document link to the official agency decision letter or notification. Links to controlled document repository.',
    `decision_outcome` STRING COMMENT 'Final regulatory decision rendered by the agency on this submission (e.g., approved, approved with conditions, rejected, withdrawn, pending).. Valid values are `approved|approved_with_conditions|rejected|withdrawn|pending`',
    `deficiency_letter_date` DATE COMMENT 'Date when the regulatory agency issued a deficiency letter or additional information request for this submission. Nullable if no deficiency was issued.',
    `deficiency_letter_received_flag` BOOLEAN COMMENT 'Boolean indicator of whether a deficiency letter or additional information request was received from the agency in response to this submission.',
    `deficiency_response_due_date` DATE COMMENT 'Deadline date by which the sponsor must respond to the agency deficiency letter. Nullable if no deficiency was issued.',
    `ectd_sequence_number` STRING COMMENT 'Sequential number assigned to each eCTD submission within a regulatory application. Used to maintain chronological order of submissions per ICH eCTD specification.',
    `fee_payment_date` DATE COMMENT 'Date when the regulatory user fee was paid to the agency. Required for establishing submission acceptance and review clock start.',
    `fee_payment_status` STRING COMMENT 'Current status of the regulatory user fee payment associated with this submission event.. Valid values are `pending|paid|waived|refunded|overdue`',
    `modified_by_user` STRING COMMENT 'User identifier or name of the person who last modified this submission event record in the system. Audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this submission event record was last modified in the system. Audit trail for change tracking.',
    `regulatory_correspondent_name` STRING COMMENT 'Name of the official regulatory correspondent or authorized representative designated for agency communications regarding this submission.',
    `review_clock_days` STRING COMMENT 'Number of calendar days allocated by the agency for review of this submission under applicable regulatory timelines (e.g., 90 days for FDA 510(k), 180 days for PMA).',
    `submission_date` DATE COMMENT 'Date when the submission was officially transmitted to the regulatory agency. Represents the business event timestamp for the submission action.',
    `submission_fee_amount` DECIMAL(18,2) COMMENT 'Regulatory user fee amount charged by the agency for processing this submission. Amount in the currency specified by submission_fee_currency_code.',
    `submission_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the submission fee (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `submission_format` STRING COMMENT 'Technical format or standard used to structure the submission package (e.g., eCTD, NeeS-R, paper, PDF, XML).. Valid values are `ectd|neesr|paper|pdf|xml|proprietary`',
    `submission_method` STRING COMMENT 'Technical channel or mechanism used to transmit the submission to the regulatory agency (e.g., eCTD gateway, eSTAR, paper, electronic portal).. Valid values are `ectd_gateway|estar|paper|electronic_portal|email|courier`',
    `submission_notes` STRING COMMENT 'Free-text field for capturing additional context, special circumstances, or internal notes related to this submission event.',
    `submission_package_reference` STRING COMMENT 'Reference identifier or file path to the complete dossier package associated with this submission event. Links to the controlled document repository (e.g., Veeva Vault document ID).',
    `submission_version` STRING COMMENT 'Version identifier for this submission event within the dossier lifecycle. Tracks sequential revisions and amendments (e.g., v1.0, v1.1, v2.0).',
    `submission_volume_count` STRING COMMENT 'Number of physical or logical volumes comprising the submission package. Used for large submissions split across multiple files or binders.',
    `target_decision_date` DATE COMMENT 'Expected date by which the regulatory agency should issue a decision on this submission, based on statutory or performance goal timelines.',
    `total_document_count` STRING COMMENT 'Total number of individual documents included in this submission event. Provides a measure of submission complexity and completeness.',
    `total_page_count` STRING COMMENT 'Total number of pages across all documents in the submission package. Used for resource planning and review estimation.',
    CONSTRAINT pk_submission_event PRIMARY KEY(`submission_event_id`)
) COMMENT 'Transactional record capturing each discrete regulatory submission action — initial filing, amendment, supplement, response to deficiency letter, withdrawal, or resubmission. Tracks submission date, submission method (eCTD gateway, paper, eSTAR), agency receipt confirmation, submission version, and associated dossier package reference. Enables full audit trail of all submission activities per dossier.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`regulatory`.`approval` (
    `approval_id` BIGINT COMMENT 'Unique identifier for the regulatory approval record. Primary key for the regulatory approval entity.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Regulatory approvals are granted to specific registered establishments (holder_name, holder_address exist on approval but are denormalized strings). Linking approval to establishment_registration norm',
    `submission_id` BIGINT COMMENT 'Identifier of the regulatory submission dossier that resulted in this approval. Links to the submission record.',
    `annual_report_due_date` DATE COMMENT 'Date by which the next annual report, periodic safety update report (PSUR), or post-market surveillance report is due to the regulatory authority.',
    `approval_date` DATE COMMENT 'Date on which the regulatory approval, clearance, or registration was officially granted by the health authority.',
    `approval_number` STRING COMMENT 'Official approval, clearance, or registration number issued by the regulatory authority. Examples: FDA 510(k) number (K123456), PMA number (P123456), CE certificate number, IVDR certificate number, EMA authorization number.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the regulatory approval. Indicates whether the approval is currently valid and in force.. Valid values are `active|expired|suspended|withdrawn|pending_renewal|revoked`',
    `approval_type` STRING COMMENT 'Type of regulatory approval or clearance granted. Indicates the regulatory pathway used for market authorization. [ENUM-REF-CANDIDATE: 510k_clearance|pma_approval|ce_ivd_certificate|ivdr_certificate|ema_marketing_authorization|country_registration|de_novo_classification|humanitarian_device_exemption — 8 candidates stripped; promote to reference product]',
    `approved_indications` STRING COMMENT 'Specific clinical indications, disease states, or genetic markers that the product is approved to detect, diagnose, or analyze.',
    `clia_complexity` STRING COMMENT 'CLIA complexity categorization for the approved test: waived, moderate complexity, or high complexity. Determines laboratory requirements for performing the test.. Valid values are `waived|moderate|high`',
    `conditions_of_approval` STRING COMMENT 'Special conditions, restrictions, or post-market requirements imposed by the regulatory authority as part of the approval. Examples: post-market surveillance studies, labeling restrictions, distribution limitations.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this regulatory approval record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory approval record was first created in the system.',
    `device_classification` STRING COMMENT 'Risk-based classification of the medical device or IVD (In Vitro Diagnostic) according to regulatory framework. FDA uses Class I/II/III; EU IVDR uses Class A/B/C/D. [ENUM-REF-CANDIDATE: class_i|class_ii|class_iii|class_a|class_b|class_c|class_d — 7 candidates stripped; promote to reference product]',
    `document_reference` STRING COMMENT 'Reference identifier or document control number for the official approval letter or certificate stored in the document management system (Veeva Vault).',
    `effective_date` DATE COMMENT 'Date from which the regulatory approval becomes legally effective and the product may be marketed in the jurisdiction.',
    `expiry_date` DATE COMMENT 'Date on which the regulatory approval expires and requires renewal or re-certification. Null for approvals without expiration.',
    `holder_address` STRING COMMENT 'Registered business address of the approval holder as recorded with the regulatory authority.',
    `holder_name` STRING COMMENT 'Legal name of the organization or entity that holds the regulatory approval. The manufacturer or sponsor responsible for the product.',
    `intended_use` STRING COMMENT 'Official intended use or indications for use statement as approved by the regulatory authority. Describes the clinical purpose and target population.',
    `jurisdiction_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the jurisdiction where the approval is valid. Examples: USA, GBR, DEU, AUS, CAN.. Valid values are `^[A-Z]{3}$`',
    `jurisdiction_region` STRING COMMENT 'Geographic region or regulatory zone for the approval. Examples: European Union, North America, Asia-Pacific. Used for multi-country approvals like CE-IVD.',
    `labeling_requirements` STRING COMMENT 'Specific labeling, instructions for use (IFU), or package insert requirements mandated by the regulatory authority.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection or audit conducted by the health authority related to this approval.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this regulatory approval record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory approval record was last modified or updated.',
    `next_renewal_date` DATE COMMENT 'Date by which the next renewal application must be submitted or the approval must be renewed. Null if no renewal is required.',
    `notes` STRING COMMENT 'Additional notes, comments, or internal observations related to the regulatory approval. Free-text field for regulatory affairs team use.',
    `post_market_surveillance_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether post-market surveillance, post-approval studies, or periodic safety update reports are required as a condition of approval.',
    `predicate_device` STRING COMMENT 'For 510(k) clearances, the legally marketed device to which substantial equivalence was demonstrated. Includes predicate device name and 510(k) number.',
    `product_code` STRING COMMENT 'Internal product code or SKU (Stock Keeping Unit) for the approved product. Links the approval to the product master data.',
    `product_name` STRING COMMENT 'Commercial or trade name of the product as approved by the regulatory authority. The name under which the product is marketed.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority or health agency that granted the approval. Examples: FDA (U.S. Food and Drug Administration), EMA (European Medicines Agency), MHRA (Medicines and Healthcare products Regulatory Agency), TGA (Therapeutic Goods Administration).',
    `regulatory_contact_email` STRING COMMENT 'Email address of the primary regulatory affairs contact person for this approval.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `regulatory_contact_name` STRING COMMENT 'Name of the primary regulatory affairs contact person responsible for this approval.',
    `regulatory_contact_phone` STRING COMMENT 'Phone number of the primary regulatory affairs contact person for this approval.',
    `regulatory_pathway` STRING COMMENT 'Regulatory submission pathway or route used to obtain the approval. Examples: 510(k) premarket notification, PMA premarket approval, De Novo classification, CE conformity assessment.. Valid values are `premarket_notification|premarket_approval|de_novo|conformity_assessment|mutual_recognition|national_registration`',
    `renewal_frequency_months` STRING COMMENT 'Frequency in months at which the approval must be renewed. Null if no renewal is required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the approval requires periodic renewal or re-certification. True if renewal is required, False if approval is perpetual.',
    `ruo_ivd_designation` STRING COMMENT 'Designation indicating whether the product is approved for clinical diagnostic use (IVD), research use only (RUO), or as a laboratory developed test (LDT).. Valid values are `ruo|ivd|ldt`',
    `technical_file_reference` STRING COMMENT 'Reference identifier for the technical file or design dossier submitted to support the approval. Links to the regulatory documentation repository.',
    CONSTRAINT pk_approval PRIMARY KEY(`approval_id`)
) COMMENT 'Master record of regulatory approvals, clearances, and registrations granted by health authorities — FDA 510(k) clearance, PMA approval, CE-IVD certificate, IVDR certificate of conformity, EMA marketing authorization, and country-specific IVD registrations. Captures approval date, approval number, notified body or agency, approved indications, conditions of approval, expiry date, and renewal obligations. SSOT for all granted regulatory authorizations.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` (
    `agency_correspondence_id` BIGINT COMMENT 'Unique identifier for the regulatory agency correspondence record. Primary key.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Agency correspondence can relate directly to an existing approval (e.g., post-approval change correspondence, renewal queries, annual report submissions, conditions-of-approval follow-up). agency_corr',
    `submission_id` BIGINT COMMENT 'Reference to the regulatory submission this correspondence is associated with (e.g., FDA 510(k), PMA, CE-IVD technical file, EMA dossier).',
    `document_id` BIGINT COMMENT 'Unique identifier of the correspondence document stored in Veeva Vault for regulatory document control and version management.',
    `agency_contact_email` STRING COMMENT 'Email address of the agency contact for follow-up and correspondence tracking.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `agency_contact_name` STRING COMMENT 'Name of the primary agency representative or reviewer handling the correspondence.',
    `agency_contact_phone` STRING COMMENT 'Phone number of the agency contact for direct communication.',
    `agency_division` STRING COMMENT 'Specific division, office, or department within the regulatory agency handling the correspondence (e.g., FDA CDRH Office of In Vitro Diagnostics and Radiological Health, EMA CHMP).',
    `agency_feedback_received` STRING COMMENT 'Summary of the feedback, guidance, or recommendations provided by the regulatory agency in response to the correspondence or meeting.',
    `agency_name` STRING COMMENT 'The regulatory agency or body involved in the correspondence (e.g., FDA, EMA, Notified Body, CLIA, CAP, Health Canada, TGA, PMDA, NMPA, ANVISA). [ENUM-REF-CANDIDATE: fda|ema|notified_body|clia|cap|health_canada|tga|pmda|nmpa|anvisa|other — 11 candidates stripped; promote to reference product]',
    `agenda_topics` STRING COMMENT 'List or description of topics covered in the meeting agenda or correspondence discussion points.',
    `correspondence_date` DATE COMMENT 'The official date the correspondence was sent or received, as indicated on the document or communication.',
    `correspondence_number` STRING COMMENT 'Business identifier for the correspondence record, often assigned by the agency or internal tracking system (e.g., FDA Q-Sub number, EMA procedure number).',
    `correspondence_status` STRING COMMENT 'Current lifecycle status of the correspondence record, indicating whether it is open, awaiting response, closed, or archived.. Valid values are `open|pending_response|closed|archived|escalated`',
    `correspondence_type` STRING COMMENT 'Classification of the correspondence based on its purpose and stage in the regulatory lifecycle. [ENUM-REF-CANDIDATE: pre_submission|deficiency_letter|additional_information_request|interactive_review_meeting|agency_question|agency_response|scientific_advice|notified_body_query|post_approval_correspondence|other — 10 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the correspondence record was first created in the system.',
    `direction` STRING COMMENT 'Indicates whether the correspondence was received from the agency (inbound) or sent to the agency (outbound).. Valid values are `inbound|outbound`',
    `document_reference` STRING COMMENT 'Reference identifier or link to the controlled document in the document management system (e.g., Veeva Vault document ID) containing the full correspondence text or meeting minutes.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the correspondence has been escalated to senior management or executive leadership due to complexity or risk.',
    `impact_on_submission_strategy` STRING COMMENT 'Assessment of how the agency feedback or correspondence outcome affects the overall regulatory submission strategy, timelines, or approach.',
    `interaction_subtype` STRING COMMENT 'Detailed subtype of the interaction, providing granular classification (e.g., FDA Q-Sub for quality questions, Pre-Sub for pre-submission meetings, AIR for Additional Information Request). [ENUM-REF-CANDIDATE: q_sub|pre_sub|pre_application_consultation|deficiency_response|air_response|meeting_request|meeting_minutes|clarification_request|withdrawal_notice|approval_letter|other — 11 candidates stripped; promote to reference product]',
    `internal_notes` STRING COMMENT 'Confidential internal notes or commentary regarding the correspondence, strategy considerations, or follow-up actions.',
    `jurisdiction` STRING COMMENT 'Geographic or regulatory jurisdiction under which the correspondence falls (e.g., USA for FDA, EU for EMA/Notified Bodies, Canada for Health Canada). [ENUM-REF-CANDIDATE: usa|eu|canada|australia|japan|china|brazil|other — 8 candidates stripped; promote to reference product]',
    `key_questions_posed` STRING COMMENT 'Summary of the primary questions or issues raised by the sponsor or agency during the correspondence or meeting.',
    `meeting_date` DATE COMMENT 'Date of the regulatory meeting or teleconference, if the correspondence relates to a scheduled interaction (e.g., Pre-Sub meeting, EMA scientific advice session).',
    `meeting_type` STRING COMMENT 'Classification of the meeting format (e.g., FDA Type A/B/C meeting, EMA scientific advice, notified body pre-application consultation). [ENUM-REF-CANDIDATE: pre_submission|interactive_review|type_c|type_b|scientific_advice|pre_application|other — 7 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the correspondence record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the correspondence record.',
    `priority` STRING COMMENT 'Priority level assigned to the correspondence based on urgency, regulatory impact, or business criticality.. Valid values are `critical|high|medium|low`',
    `product_code` STRING COMMENT 'Internal product code or SKU identifying the specific product or product family related to the correspondence.',
    `product_name` STRING COMMENT 'Name of the IVD product, sequencing platform, or assay that is the subject of the correspondence.',
    `regulatory_pathway` STRING COMMENT 'The regulatory pathway or submission type associated with the correspondence (e.g., FDA 510(k), PMA, De Novo, CE-IVD, IVDR, EMA Centralized, LDT, RUO). [ENUM-REF-CANDIDATE: 510k|pma|de_novo|ce_ivd|ivdr|ema_centralized|ldt|ruo|other — 9 candidates stripped; promote to reference product]',
    `response_due_date` DATE COMMENT 'Deadline by which a response to the agency correspondence is required (e.g., deficiency letter response deadline, AIR due date).',
    `response_status` STRING COMMENT 'Current status of the response to the agency correspondence, tracking whether action is pending, in progress, or completed.. Valid values are `pending|in_progress|submitted|accepted|rejected|no_response_required`',
    `response_submitted_date` DATE COMMENT 'Date on which the sponsors response to the agency correspondence was officially submitted.',
    `subject` STRING COMMENT 'Brief subject line or title summarizing the topic of the correspondence.',
    `created_by` STRING COMMENT 'User identifier or name of the person who created the correspondence record.',
    CONSTRAINT pk_agency_correspondence PRIMARY KEY(`agency_correspondence_id`)
) COMMENT 'Transactional record of all formal communications and interactions with regulatory agencies — including pre-submission engagements (FDA Q-Sub/Pre-Sub meetings, EMA scientific advice, notified body pre-application consultations, CLIA/CAP consultation interactions), FDA deficiency letters, additional information requests (AIRs), interactive review meetings, EMA questions, notified body queries, and agency responses. Captures correspondence type, interaction subtype (pre-submission, during-review, post-approval), direction (inbound/outbound), agency contact, meeting date, agenda topics, key questions posed, agency feedback received, impact on submission strategy, due date for response, response status, and linked submission. SSOT for all regulatory agency dialogue — from proactive pre-submission engagement through post-approval interactions.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`regulatory`.`document` (
    `document_id` BIGINT COMMENT 'Unique identifier for the regulatory document record. Primary key.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Regulatory documents (technical files, approval certificates, post-approval reports) are associated with specific approvals. document already has submission_id for pre-approval documents; adding appro',
    `change_control_id` BIGINT COMMENT 'Identifier of the change control record that authorized the creation or revision of this document version.',
    `family_id` BIGINT COMMENT 'Identifier of the product or device to which this regulatory document applies. Links document to specific product master record.',
    `submission_id` BIGINT COMMENT 'Identifier of the regulatory submission dossier (FDA 510(k), PMA, CE-IVD technical file, etc.) to which this document is attached or referenced.',
    `superseded_document_id` BIGINT COMMENT 'Identifier of the previous document version that this current version replaces. Maintains document lineage and version history.',
    `approval_date` DATE COMMENT 'Date on which the document received final approval and was authorized for use.',
    `approval_status` STRING COMMENT 'Current approval state indicating whether the document has received required sign-offs from designated approvers per the approval matrix.. Valid values are `Pending|Approved|Rejected|Conditional`',
    `approver_name` STRING COMMENT 'Name of the individual who provided final approval for the document to become effective.',
    `archive_location` STRING COMMENT 'Physical or electronic location where the document is archived after it becomes obsolete (e.g., Veeva Vault archive folder, offsite storage facility).',
    `audit_trail_summary` STRING COMMENT 'High-level summary of key audit events for this document (creation, approvals, revisions, access) maintained in Veeva Vault for compliance traceability.',
    `author_name` STRING COMMENT 'Name of the individual who authored or prepared the current version of the document.',
    `checksum_value` DECIMAL(18,2) COMMENT 'SHA-256 cryptographic hash of the document file, ensuring integrity and detecting unauthorized modifications.',
    `comments` STRING COMMENT 'Free-text field for additional notes, special instructions, or contextual information about the document not captured in other structured fields.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for the document content.. Valid values are `Public|Internal|Confidential|Restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory document record was first created in the data system.',
    `distribution_list` STRING COMMENT 'Comma-separated list of roles, departments, or individuals authorized to access and use this controlled document.',
    `document_number` STRING COMMENT 'Business-assigned controlled document number used for regulatory traceability and cross-referencing in submissions.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `document_type` STRING COMMENT 'Classification of the regulatory document according to its purpose and regulatory function within the quality management system and submission dossier. [ENUM-REF-CANDIDATE: Technical File|Clinical Evaluation Report|Performance Evaluation Report|Risk Management File|Instructions For Use|Labeling Artwork|Regulatory SOP|Design History File|Device Master Record|Certificate of Analysis|Declaration of Conformity|Essential Requirements Checklist — 12 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date on which the approved document becomes officially effective and enforceable within the quality management system.',
    `expiration_date` DATE COMMENT 'Date on which the document is scheduled to expire or become obsolete if not renewed or superseded.',
    `file_format` STRING COMMENT 'Electronic file format of the document as stored in Veeva Vault (e.g., PDF for controlled final versions, DOCX for working drafts).. Valid values are `PDF|DOCX|XLSX|PPTX|XML|HTML`',
    `file_size_mb` DECIMAL(18,2) COMMENT 'Size of the document file in megabytes, used for storage management and submission package size planning.',
    `jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the regulatory jurisdiction or market for which this document is prepared and applicable. [ENUM-REF-CANDIDATE: USA|CAN|GBR|DEU|FRA|ITA|ESP|JPN|CHN|AUS|BRA|IND|KOR|SGP|CHE|NLD|SWE|NOR|DNK|FIN|BEL|AUT|IRL|NZL|MEX|ZAF|ISR|TUR|POL|CZE|HUN|ROU|GRC|PRT|HRV|SVN|SVK|BGR|LTU|LVA|EST|CYP|MLT|LUX — 44 candidates stripped; promote to reference product]',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the primary language in which the document is written (e.g., en, de, fr, es, ja).. Valid values are `^[a-z]{2}$`',
    `lifecycle_status` STRING COMMENT 'Current state of the document in its controlled lifecycle from creation through approval, effectiveness, and eventual obsolescence. [ENUM-REF-CANDIDATE: Draft|In Review|Approved|Effective|Superseded|Obsolete|Archived — 7 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory document record was last modified in the data system.',
    `page_count` STRING COMMENT 'Total number of pages in the document, used for completeness verification and submission package assembly.',
    `regulatory_framework` STRING COMMENT 'Governing regulatory framework or standard under which the document is prepared and maintained (e.g., FDA premarket submission, IVDR technical documentation, ISO quality standard).. Valid values are `FDA 510(k)|FDA PMA|FDA De Novo|CE-IVD|IVDR|EMA CTD|ICH M4|CLIA|CAP|ISO 13485|ISO 15189|ISO 14971|GDPR|HIPAA|GxP`',
    `retention_period_years` STRING COMMENT 'Number of years the document must be retained after obsolescence per regulatory requirements and internal retention policy.',
    `review_due_date` DATE COMMENT 'Scheduled date by which the document must undergo periodic review to ensure continued accuracy, relevance, and regulatory compliance.',
    `revision_description` STRING COMMENT 'Summary of changes made in the current version compared to the previous version. Documents the nature and scope of revisions.',
    `subtype` STRING COMMENT 'Secondary classification providing additional granularity within the document type (e.g., IFU-Professional, IFU-Patient, CER-Initial, CER-Update).',
    `title` STRING COMMENT 'Full official title of the regulatory document as it appears in the controlled document header.',
    `training_required_flag` BOOLEAN COMMENT 'Indicates whether personnel must complete formal training on this document before performing related activities (True) or not (False).',
    `vault_document_reference` STRING COMMENT 'Unique document identifier assigned by Veeva Vault system of record. External system key for document control integration.. Valid values are `^VV[0-9]{10,15}$`',
    `version_number` STRING COMMENT 'Version identifier for the document following major.minor versioning convention. Incremented per change control procedures.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    CONSTRAINT pk_document PRIMARY KEY(`document_id`)
) COMMENT 'Master record for controlled regulatory documents managed in Veeva Vault — technical files, clinical evaluation reports (CER), performance evaluation reports (PER), risk management files (ISO 14971), instructions for use (IFU), labeling artwork, and regulatory SOPs. Captures document type, Veeva Vault document ID, version, effective date, document owner, approval status, and applicable submission references. Integrates with Veeva Vault as the system of record for document control.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` (
    `labeling_id` BIGINT COMMENT 'Unique identifier for the labeling record. Primary key for the labeling master data product.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: labeling tracks product labeling and IFU assets subject to regulatory control. Each labeling version is associated with a specific regulatory approval (the approved product for which labeling is creat',
    `change_control_id` BIGINT COMMENT 'Reference to the change control record that authorized this labeling version. Links to the quality management system change control process.',
    `device_identifier_id` BIGINT COMMENT 'Foreign key linking to regulatory.device_identifier. Business justification: Labeling contains a udi_di STRING field that duplicates the authoritative UDI-DI stored in the device_identifier master record. Adding device_identifier_id FK normalizes this reference, eliminating th',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU that this labeling asset applies to. Links labeling to specific reagent kits, instruments, consumables, or IVD products.',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Labeling changes frequently require regulatory submissions (e.g., 510(k) labeling supplements, CE-IVD labeling notifications). Linking labeling to the associated submission record enables tracking of ',
    `approval_date` DATE COMMENT 'Date on which the labeling asset received regulatory approval from the applicable authority (FDA, Notified Body, or internal Quality Assurance). Null if not yet approved.',
    `authorized_representative` STRING COMMENT 'Name and address of the authorized representative in the European Union, if applicable. Required for non-EU manufacturers marketing IVD products in the EU under IVDR.',
    `barcode_type` STRING COMMENT 'Type of barcode or machine-readable identifier printed on the labeling. Supports supply chain automation and inventory management.. Valid values are `ean13|upc|gs1_datamatrix|qr_code|none`',
    `ce_mark_required` BOOLEAN COMMENT 'Indicates whether this labeling must display the CE-IVD mark for European market distribution. True for IVD products marketed in the EU under IVDR; false for RUO or non-EU products.',
    `change_classification` STRING COMMENT 'Classification of the change that resulted in this labeling version. Major changes typically require regulatory notification or re-approval; minor changes may be implemented under quality system authority; administrative changes are non-substantive corrections.. Valid values are `major|minor|administrative`',
    `change_reason` STRING COMMENT 'Business justification and rationale for the labeling change. Documents why the revision was necessary, including regulatory requirements, safety updates, product improvements, or error corrections.',
    `change_summary` STRING COMMENT 'High-level summary of the specific changes made in this labeling version compared to the previous version. Supports regulatory submission documentation and internal change tracking.',
    `checksum_md5` STRING COMMENT 'MD5 hash of the labeling file content. Ensures file integrity and detects unauthorized modifications in the controlled document environment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this labeling record was first created in the system. Part of the audit trail for regulatory compliance.',
    `customer_support_contact` STRING COMMENT 'Customer support phone number, email, or website URL printed on the labeling for technical assistance and inquiries.',
    `document_number` STRING COMMENT 'Unique document control number assigned by the quality management system. Used for traceability and change control across the labeling lifecycle.',
    `effective_date` DATE COMMENT 'Date on which this labeling version becomes effective and must be used for product distribution. Marks the start of the labeling lifecycle in the market.',
    `expiration_date` DATE COMMENT 'Date on which this labeling version is no longer valid for use. After this date, the labeling must be replaced with a newer version. Null for currently active labeling with no planned obsolescence.',
    `expiry_date_format` STRING COMMENT 'Specification for the expiry date format that will be printed on this labeling. Defines date representation (e.g., YYYY-MM-DD, MM/YYYY) for product shelf-life indication.',
    `fda_establishment_identifier` STRING COMMENT 'FDA Establishment Identifier (FEI) or registration number that must appear on the labeling for US-marketed products. Required for IVD products under FDA jurisdiction.',
    `file_format` STRING COMMENT 'Digital file format of the labeling asset. Supports document control and publishing workflows.. Valid values are `pdf|docx|html|xml|indesign|illustrator`',
    `file_path` STRING COMMENT 'File system path or document management system URI where the digital labeling asset is stored. Links to the controlled document repository (e.g., Veeva Vault).',
    `file_size_bytes` BIGINT COMMENT 'Size of the digital labeling file in bytes. Used for storage management and document transfer validation.',
    `hazard_symbols` STRING COMMENT 'Comma-separated list of hazard symbols or pictograms that must appear on the labeling. Supports chemical safety and regulatory compliance for reagents and consumables.',
    `impacted_markets` STRING COMMENT 'Comma-separated list of market regions or countries affected by this labeling change. Used to coordinate multi-market labeling updates and regulatory notifications.',
    `implementation_date` DATE COMMENT 'Actual date on which this labeling version was implemented in production and distribution systems. May differ from effective_date due to operational lead times or inventory depletion strategies.',
    `intended_use_statement` STRING COMMENT 'Regulatory intended use statement for the product as documented in the labeling. Critical for IVD and RUO product classification and regulatory compliance.',
    `labeling_type` STRING COMMENT 'Classification of the labeling asset. Distinguishes between physical labels, package inserts, Instructions for Use (IFU) documents, carton artwork, digital labeling content, and Safety Data Sheets (SDS).. Valid values are `instrument_label|reagent_kit_insert|ifu_document|carton_artwork|digital_labeling|safety_data_sheet`',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language variant of the labeling content. Supports multi-market and multi-lingual labeling requirements.',
    `lot_number_format` STRING COMMENT 'Specification for the lot number format that will be printed on this labeling. Defines the structure and content of lot identifiers for traceability and quality control.',
    `manufacturer_address` STRING COMMENT 'Physical address of the manufacturing facility as it appears on the labeling. Required for regulatory compliance and customer contact.',
    `manufacturer_name` STRING COMMENT 'Legal name of the manufacturer as it appears on the labeling. Required for regulatory compliance and traceability.',
    `modified_by` STRING COMMENT 'Username or identifier of the person who last modified this labeling record. Supports audit trail and change tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this labeling record was last modified in the system. Part of the audit trail for regulatory compliance and change control.',
    `notification_date` DATE COMMENT 'Date on which regulatory notification was submitted to the applicable authority for this labeling change. Null if no notification was required or if not yet submitted.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates whether this labeling change requires formal notification to regulatory authorities (FDA, Notified Body, or other competent authority). True for major changes; false for minor or administrative changes.',
    `regulatory_status` STRING COMMENT 'Current regulatory approval status of the labeling asset. Tracks progression from draft through regulatory review to approval, effectiveness, and eventual obsolescence.. Valid values are `draft|under_review|approved|effective|obsolete|withdrawn`',
    `storage_conditions` STRING COMMENT 'Storage temperature and environmental conditions specified on the labeling. Critical for reagent stability and product quality. Examples: 2-8°C, -20°C, room temperature.',
    `title` STRING COMMENT 'Official title or name of the labeling asset. Human-readable identifier used in regulatory submissions and internal documentation.',
    `version` STRING COMMENT 'Version identifier for the labeling asset. Tracks revisions and updates to labeling content over time. Format typically follows semantic versioning or document control numbering scheme.',
    `created_by` STRING COMMENT 'Username or identifier of the person who created this labeling record in the system. Supports audit trail and accountability.',
    CONSTRAINT pk_labeling PRIMARY KEY(`labeling_id`)
) COMMENT 'Master record for all product labeling and IFU (Instructions for Use) assets subject to regulatory control, including their change history. Covers instrument labels, reagent kit inserts, IFU documents, carton artwork, and digital labeling. Captures labeling version, applicable markets/jurisdictions, language variants, regulatory approval status, effective date, linked product SKU, and full change history — including change reason, change classification (major/minor), impacted markets, regulatory notification requirements, change control reference, and implementation date. Tracks labeling lifecycle and compliance with FDA 21 CFR Part 801, EU IVDR Annex I, and global jurisdiction-specific labeling requirements.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` (
    `adverse_event_report_id` BIGINT COMMENT 'Unique identifier for the adverse event report. Primary key for post-market surveillance tracking.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: adverse_event_report tracks post-market adverse events for approved products. Each AER is associated with a specific regulatory approval (the approved product involved in the event). Adding regulatory',
    `capa_id` BIGINT COMMENT 'Reference to the associated CAPA record in the quality management system. Links adverse event to corrective and preventive action workflow.',
    `field_safety_action_id` BIGINT COMMENT 'Foreign key linking to regulatory.field_safety_action. Business justification: Adverse event reports frequently trigger field safety corrective actions (FSCAs). Linking adverse_event_report to the resulting field_safety_action_id establishes the causal chain from vigilance event',
    `post_market_surveillance_id` BIGINT COMMENT 'Foreign key linking to regulatory.post_market_surveillance. Business justification: Individual adverse event reports are aggregated into post-market surveillance plans and periodic safety update reports (PSURs/PSURs). Linking adverse_event_report to its governing PMS plan (N:1) enabl',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Adverse event reports for IVD/genomics products must be traceable to the specific production batch (lot) involved. This is a fundamental post-market safety requirement (FDA MDR 21 CFR 803, EU IVDR Art',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Adverse event reports (MDRs, vigilance reports) are formally submitted to regulatory agencies as regulatory submissions. The adverse_event_report has submission_date and submission_method fields but n',
    `document_id` BIGINT COMMENT 'Reference to the controlled regulatory document in Veeva Vault system. Links to the official regulatory submission package.',
    `affected_lot_numbers` STRING COMMENT 'Comma-separated list of all lot numbers affected by the adverse event or corrective action. Used for recall scope determination.',
    `affected_markets` STRING COMMENT 'Comma-separated list of geographic markets or jurisdictions affected by the adverse event or corrective action (e.g., USA, DEU, GBR, FRA).',
    `agency_acknowledgment_date` DATE COMMENT 'Date when the regulatory agency acknowledged receipt of the adverse event report.',
    `agency_reference_number` STRING COMMENT 'Reference number or tracking identifier assigned by the regulatory agency (FDA, EMA, competent authority) upon receipt of the report.',
    `closure_date` DATE COMMENT 'Date when the adverse event report and all associated corrective actions were closed. Marks completion of the post-market surveillance lifecycle.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action taken to address the adverse event and prevent recurrence. Links to CAPA (Corrective and Preventive Action) system.',
    `corrective_action_type` STRING COMMENT 'Type of corrective action taken in response to the adverse event. Recall, FSCA (Field Safety Corrective Action), FSN (Field Safety Notice), product modification, labeling change, or no action required.. Valid values are `recall|fsca|fsn|product_modification|labeling_change|no_action`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the adverse event report record was first created in the system. Audit trail for record creation.',
    `customer_notification_date` DATE COMMENT 'Date when affected customers were notified of the adverse event or corrective action.',
    `customer_notification_status` STRING COMMENT 'Status of customer notification for field safety corrective actions or recalls. Tracks whether affected customers have been notified.. Valid values are `not_required|pending|in_progress|complete`',
    `device_product_code` STRING COMMENT 'Product code or SKU (Stock Keeping Unit) of the device involved in the adverse event. Links to product master for device identification.',
    `device_serial_number` STRING COMMENT 'Serial number of the specific device unit involved in the adverse event, if applicable. Enables unit-level traceability.',
    `event_date` DATE COMMENT 'Date when the adverse event or serious incident occurred. Principal business event timestamp for post-market surveillance.',
    `event_description` STRING COMMENT 'Detailed narrative description of the adverse event, serious incident, or field safety issue. Includes patient/user impact, device behavior, and circumstances of the event.',
    `follow_up_status` STRING COMMENT 'Status of any follow-up reporting or supplemental information requested by the regulatory agency.. Valid values are `no_follow_up|follow_up_pending|follow_up_submitted|follow_up_complete`',
    `jurisdiction` STRING COMMENT 'Regulatory jurisdiction or competent authority to which the report was submitted (e.g., USA-FDA, DEU-BfArM, GBR-MHRA). Uses 3-letter country codes with authority suffix.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified the adverse event report record. Audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the adverse event report record was last modified. Audit trail for record updates.',
    `patient_impact` STRING COMMENT 'Severity classification of the impact on the patient or user. Death, serious injury, malfunction with no injury, or no impact. Determines reportability and urgency.. Valid values are `death|serious_injury|malfunction_no_injury|no_impact`',
    `regulatory_notification_date` DATE COMMENT 'Date when regulatory authorities were notified of the corrective action (e.g., recall notification, FSCA notification).',
    `report_number` STRING COMMENT 'Business identifier for the adverse event report. External reference number used in regulatory submissions and agency correspondence.',
    `report_status` STRING COMMENT 'Current lifecycle status of the adverse event report in the post-market surveillance workflow.. Valid values are `draft|under_review|submitted|acknowledged|follow_up_required|closed`',
    `report_type` STRING COMMENT 'Classification of the adverse event report. MDR (Medical Device Report) for FDA filings, serious incident for EU IVDR, FSCA (Field Safety Corrective Action), FSN (Field Safety Notice), recall, or market withdrawal.. Valid values are `mdr|serious_incident|fsca|fsn|recall|market_withdrawal`',
    `reportability_determination` STRING COMMENT 'Assessment of whether the event meets regulatory criteria for mandatory reporting to health authorities (FDA, EMA, competent authorities).. Valid values are `reportable|non_reportable|under_evaluation`',
    `reportability_rationale` STRING COMMENT 'Business justification for the reportability determination. Documents the regulatory assessment and decision-making process.',
    `reporter_contact` STRING COMMENT 'Contact information (email or phone) for the individual who reported the adverse event. Used for follow-up inquiries.',
    `reporter_name` STRING COMMENT 'Name of the individual or organization who reported the adverse event. May be confidential depending on jurisdiction.',
    `reporter_type` STRING COMMENT 'Classification of the party who reported the adverse event. Customer, field service engineer, internal QA, regulatory authority, or healthcare provider.. Valid values are `customer|field_service|internal_qa|regulatory_authority|healthcare_provider`',
    `root_cause` STRING COMMENT 'Identified root cause of the adverse event based on investigation. Links to quality investigation and CAPA processes.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause for trending and analytics. Design defect, manufacturing defect, labeling issue, user error, environmental factor, or unknown.. Valid values are `design|manufacturing|labeling|user_error|environmental|unknown`',
    `submission_date` DATE COMMENT 'Date when the adverse event report was submitted to the regulatory agency (FDA, EMA, competent authority).',
    `submission_method` STRING COMMENT 'Method used to submit the report to the regulatory agency. Electronic (e.g., FDA eSubmitter), paper, or agency portal.. Valid values are `electronic|paper|portal`',
    CONSTRAINT pk_adverse_event_report PRIMARY KEY(`adverse_event_report_id`)
) COMMENT 'Transactional record for the complete post-market vigilance and field safety workflow — adverse event reports, serious incident reports, field safety corrective actions (FSCA), and field safety notices (FSN). Covers FDA MDR filings, EU IVDR serious incident reports, product recalls, market withdrawals, hazard alerts, and corrective field actions. Captures event date, event description, device involved, patient/user impact, reportability determination, report submission date, agency acknowledgment, follow-up status, action type, affected lot numbers, affected markets, root cause, corrective action description, regulatory notification dates, customer notification status, and closure date. Integrates with quality CAPA and supply chain recall management. SSOT for all post-market safety signals from detection through corrective action closure.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` (
    `post_market_surveillance_id` BIGINT COMMENT 'Unique identifier for the post-market surveillance plan or report record.',
    `approval_id` BIGINT COMMENT 'Reference to the regulatory approval record this PMS plan is associated with.',
    `catalog_item_id` BIGINT COMMENT 'Foreign key linking to product.catalog_item. Business justification: EU IVDR/MDR mandates PMS plans per product. Regulatory affairs teams run PMS reports and benefit-risk assessments by catalog item. Current product_name and product_code are denormalized text fields — ',
    `submission_id` BIGINT COMMENT 'Identifier of the regulatory submission (510(k), PMA, CE technical file) that this PMS plan is linked to or was submitted as part of.',
    `adverse_event_count` STRING COMMENT 'Total number of adverse events or incidents reported for this product during the current PMS reporting period.',
    `benefit_risk_assessment_summary` STRING COMMENT 'Summary of the benefit-risk analysis conducted as part of the PMS evaluation, documenting whether the product continues to meet safety and performance requirements.',
    `clinical_follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether post-market clinical follow-up (PMCF) or post-market performance follow-up (PMPF) studies are required as part of this PMS plan.',
    `complaint_data_included_flag` BOOLEAN COMMENT 'Indicates whether customer complaint data is included as a data source in this PMS plan.',
    `corrective_action_description` STRING COMMENT 'Description of corrective actions taken or planned in response to PMS findings, including design modifications, labeling changes, or field safety actions.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions (design changes, labeling updates, field actions) are required based on PMS findings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PMS record was first created in the system.',
    `data_sources` STRING COMMENT 'Comma-separated list or description of data sources used for PMS data collection: complaint data, adverse event reports, scientific literature, clinical registries, post-market clinical follow-up studies, customer feedback, field performance data.',
    `device_classification` STRING COMMENT 'Regulatory risk classification of the device: Class I, IIa, IIb, III (IVDR/EU), or Class A, B, C (FDA/US). [ENUM-REF-CANDIDATE: class_i|class_iia|class_iib|class_iii|class_a|class_b|class_c — 7 candidates stripped; promote to reference product]',
    `document_reference` STRING COMMENT 'Reference to the controlled document or file location (e.g., Veeva Vault document ID) where the full PMS plan or report is stored.',
    `field_safety_notice_issued_flag` BOOLEAN COMMENT 'Indicates whether a Field Safety Notice (FSN) or Field Safety Corrective Action (FSCA) has been issued for this product during the PMS period.',
    `jurisdiction_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the regulatory jurisdiction where this PMS plan applies (e.g., USA, DEU, GBR, FRA).',
    `last_report_submission_date` DATE COMMENT 'Date when the most recent PMS report was submitted to the regulatory authority.',
    `literature_review_included_flag` BOOLEAN COMMENT 'Indicates whether systematic scientific literature review is included as a data source in this PMS plan.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this PMS record was last modified or updated.',
    `next_report_due_date` DATE COMMENT 'Date when the next periodic PMS report (PSUR, PMPF, or post-approval study report) is due for submission to the regulatory authority.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding this PMS plan or report, including internal observations or regulatory authority feedback.',
    `plan_effective_date` DATE COMMENT 'Date when this PMS plan version became effective and data collection activities commenced.',
    `plan_expiry_date` DATE COMMENT 'Date when this PMS plan version expires or is scheduled for review and renewal. Null for ongoing plans without fixed end date.',
    `plan_version` STRING COMMENT 'Version number or identifier of the PMS plan document, used to track revisions and updates over time.',
    `pmpf_study_protocol_reference` STRING COMMENT 'Document reference or identifier for the PMPF study protocol associated with this PMS plan, if applicable.',
    `pms_plan_number` STRING COMMENT 'Business identifier for the PMS plan or report, used for external reference and regulatory submissions.',
    `pms_status` STRING COMMENT 'Current lifecycle status of the PMS plan or report: draft (in preparation), active (ongoing data collection), under review (internal QA), approved (ready for submission), submitted (filed with authority), closed (completed), suspended (temporarily halted). [ENUM-REF-CANDIDATE: draft|active|under_review|approved|submitted|closed|suspended — 7 candidates stripped; promote to reference product]',
    `pms_type` STRING COMMENT 'Type of post-market surveillance activity: PMS plan (IVDR general plan), PSUR (Periodic Safety Update Report), PMPF plan (Post-Market Performance Follow-up), post-approval study (FDA commitment), vigilance report, or field safety corrective action.. Valid values are `pms_plan|psur|pmpf_plan|post_approval_study|vigilance_report|field_safety_corrective_action`',
    `recall_initiated_flag` BOOLEAN COMMENT 'Indicates whether a product recall or market withdrawal was initiated during the PMS period.',
    `registry_data_included_flag` BOOLEAN COMMENT 'Indicates whether clinical registry or real-world evidence registry data is included in this PMS plan.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority or competent authority overseeing this PMS activity (e.g., FDA, MHRA, BfArM, ANSM).',
    `reporting_frequency` STRING COMMENT 'Frequency at which PMS reports (PSUR, PMPF updates) must be generated and submitted to regulatory authorities. [ENUM-REF-CANDIDATE: monthly|quarterly|semi_annual|annual|biennial|event_driven|continuous — 7 candidates stripped; promote to reference product]',
    `responsible_department` STRING COMMENT 'Department or functional unit responsible for managing this PMS plan (e.g., Regulatory Affairs, Quality Assurance, Post-Market Surveillance).',
    `risk_management_file_reference` STRING COMMENT 'Reference to the risk management file (per ISO 14971) that this PMS plan supports and updates with post-market data.',
    `serious_adverse_event_count` STRING COMMENT 'Number of serious adverse events (death, serious injury, or serious public health threat) reported during the current PMS reporting period.',
    `technical_file_reference` STRING COMMENT 'Reference to the technical documentation or technical file that includes this PMS plan as a required component.',
    CONSTRAINT pk_post_market_surveillance PRIMARY KEY(`post_market_surveillance_id`)
) COMMENT 'Master record for post-market surveillance (PMS) plans and reports per product — IVDR PMS plans, periodic safety update reports (PSUR), post-market performance follow-up (PMPF) plans, and FDA post-approval study commitments. Captures PMS plan version, reporting frequency, data sources (complaint data, literature, registry), next due date, responsible owner, and regulatory submission linkage. SSOT for ongoing post-market regulatory obligations per product.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` (
    `field_safety_action_id` BIGINT COMMENT 'Unique identifier for the field safety corrective action or field safety notice record.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: field_safety_action tracks field safety corrective actions (FSCA) and field safety notices (FSN) for products. Each FSA is associated with a specific regulatory approval (the approved product subject ',
    `capa_id` BIGINT COMMENT 'Identifier linking this field safety action to the originating CAPA record in the quality management system, establishing traceability to root cause investigation and corrective action planning.',
    `catalog_item_id` BIGINT COMMENT 'Identifier of the product subject to the field safety action, linking to the master product catalog.',
    `post_market_surveillance_id` BIGINT COMMENT 'Foreign key linking to regulatory.post_market_surveillance. Business justification: Field safety corrective actions (FSCAs) and field safety notices (FSNs) are tracked within post-market surveillance reports. A PMS plan/report encompasses multiple FSCAs (N:1). Linking field_safety_ac',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Field safety actions (recalls, FSCAs) in IVD/genomics biotech are initiated against specific production batches/lots. Direct FK traceability from field safety action to production batch is required fo',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: Field safety corrective actions often require formal regulatory submissions (e.g., recall notifications to FDA, FSCA notifications to competent authorities). Linking field_safety_action to the associa',
    `action_number` STRING COMMENT 'Business identifier for the field safety action, typically formatted as FSA-NNNNNN for external tracking and regulatory reporting.. Valid values are `^FSA-[0-9]{6,10}$`',
    `action_status` STRING COMMENT 'Current lifecycle status of the field safety action indicating progress through investigation, notification, recovery, and closure phases.. Valid values are `initiated|in_progress|customer_notification_complete|product_recovery_complete|closed|cancelled`',
    `action_type` STRING COMMENT 'Classification of the field safety action: recall (product return), market withdrawal (removal from market), safety alert (hazard notification), field correction (on-site fix), customer notification (informational), or product removal (permanent discontinuation).. Valid values are `recall|market_withdrawal|safety_alert|field_correction|customer_notification|product_removal`',
    `affected_lot_numbers` STRING COMMENT 'Comma-separated list of lot numbers or batch identifiers affected by the field safety action, enabling precise traceability and targeted recovery.',
    `affected_markets` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing the geographic markets where the affected product was distributed and the field safety action applies.',
    `affected_product_code` STRING COMMENT 'Stock Keeping Unit (SKU) or catalog number of the affected product for precise identification in supply chain and inventory systems.',
    `affected_product_name` STRING COMMENT 'Commercial name of the product affected by the field safety action, captured for reporting and customer communication purposes.',
    `affected_serial_numbers` STRING COMMENT 'Comma-separated list or range of device serial numbers affected by the field safety action, used for instrument-level traceability.',
    `closure_date` DATE COMMENT 'Date when the field safety action was formally closed after all corrective activities, customer notifications, and product recovery were completed and verified.',
    `competent_authority_notification_date` DATE COMMENT 'Date when national competent authorities in affected EU member states were notified of the field safety action via the European Database on Medical Devices (EUDAMED).',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective actions taken to address the root cause, including product modifications, process changes, customer instructions, and preventive measures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this field safety action record was first created in the system, supporting audit trail and data lineage requirements.',
    `customer_notification_date` DATE COMMENT 'Date when affected customers were first notified of the field safety action, marking the start of customer communication activities.',
    `customer_notification_method` STRING COMMENT 'Primary method used to notify affected customers of the field safety action: email, postal mail, phone, fax, web portal, field representative visit, or multiple channels. [ENUM-REF-CANDIDATE: email|postal_mail|phone|fax|web_portal|field_representative|multiple — 7 candidates stripped; promote to reference product]',
    `customer_notification_status` STRING COMMENT 'Status of customer notification activities indicating whether all affected customers have been successfully contacted and informed of the field safety action.. Valid values are `not_started|in_progress|complete|partial`',
    `customers_notified_count` STRING COMMENT 'Total number of customers who have been successfully notified of the field safety action, tracked for regulatory reporting and effectiveness monitoring.',
    `effectiveness_check_date` DATE COMMENT 'Date when the effectiveness check was performed to verify that corrective actions successfully resolved the issue and prevented recurrence.',
    `effectiveness_check_outcome` STRING COMMENT 'Result of the effectiveness check assessment: effective (corrective action successful), partially effective (additional actions needed), ineffective (corrective action failed), or pending (check not yet completed).. Valid values are `effective|partially_effective|ineffective|pending`',
    `effectiveness_check_required_flag` BOOLEAN COMMENT 'Indicates whether a formal effectiveness check is required to verify that the field safety action successfully addressed the root cause and prevented recurrence.',
    `estimated_completion_date` DATE COMMENT 'Projected date for completing all field safety action activities including customer notification, product recovery, and regulatory reporting, used for planning and regulatory commitment tracking.',
    `fda_notification_date` DATE COMMENT 'Date when the U.S. Food and Drug Administration (FDA) was formally notified of the field safety action, as required under 21 CFR 806 for medical device recalls.',
    `fda_recall_number` STRING COMMENT 'Official FDA-assigned recall number for tracking in the FDA recall database, typically formatted as Z-YYYY-NNNN where Z is the recall class.. Valid values are `^[A-Z]-[0-9]{4}-[0-9]{4}$`',
    `financial_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated total financial impact of the field safety action including product recovery costs, customer credits, regulatory penalties, and operational expenses, captured in the companys reporting currency.',
    `fsn_reference_number` STRING COMMENT 'Reference number of the Field Safety Notice document issued to customers and regulatory authorities, used for cross-referencing in regulatory correspondence.',
    `hazard_classification` STRING COMMENT 'FDA recall classification indicating the severity of the health hazard: Class I (serious injury or death), Class II (temporary or reversible health consequences), Class III (unlikely to cause adverse health consequences).. Valid values are `class_i|class_ii|class_iii`',
    `initiation_date` DATE COMMENT 'Date when the field safety action was formally initiated and documented, marking the start of the corrective action process.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this field safety action record was last modified, supporting audit trail and change control requirements for regulatory compliance.',
    `notes` STRING COMMENT 'Free-text field for additional context, special circumstances, lessons learned, or supplementary information relevant to the field safety action that does not fit structured fields.',
    `notified_body_notification_date` DATE COMMENT 'Date when the EU Notified Body was notified of the field safety action, as required under IVDR Article 83 for CE-marked in vitro diagnostic devices.',
    `recovery_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of affected units successfully recovered or corrected, calculated as (units_recovered / units_distributed) * 100, used to track field safety action effectiveness.',
    `regulatory_contact_email` STRING COMMENT 'Business email address of the regulatory contact for agency correspondence regarding the field safety action.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `regulatory_contact_name` STRING COMMENT 'Full name of the regulatory affairs contact person responsible for regulatory authority communications and submissions related to this field safety action.',
    `root_cause_summary` STRING COMMENT 'Concise summary of the root cause analysis findings that led to the field safety action, including failure mode, contributing factors, and investigation conclusions.',
    `units_distributed_count` STRING COMMENT 'Total number of affected product units that were distributed to customers and are subject to the field safety action.',
    `units_recovered_count` STRING COMMENT 'Number of affected product units that have been successfully recovered, returned, or corrected as part of the field safety action.',
    CONSTRAINT pk_field_safety_action PRIMARY KEY(`field_safety_action_id`)
) COMMENT 'Transactional record for field safety corrective actions (FSCA) and field safety notices (FSN) — product recalls, market withdrawals, hazard alerts, and corrective field actions initiated in response to safety signals or regulatory requirements. Captures action type, affected lot numbers, affected markets, root cause, corrective action description, regulatory notification dates, customer notification status, and closure date. Integrates with quality CAPA and supply chain recall management.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` (
    `ivd_registration_id` BIGINT COMMENT 'Unique identifier for the IVD registration record. Primary key for the ivd_registration product.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: ivd_registration tracks product-level IVD registrations with regulatory authorities. Each registration is associated with a specific regulatory approval (the approved product being registered). Adding',
    `device_identifier_id` BIGINT COMMENT 'Foreign key linking to regulatory.device_identifier. Business justification: IVD registrations are for specific devices identified by their UDI/device identifier. Linking ivd_registration to device_identifier connects the registration record to the authoritative device identit',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: ivd_registration tracks product-level IVD registrations, which are associated with a registered facility/establishment. Adding establishment_registration_id FK normalizes facility address attributes t',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: IVD product registrations in many jurisdictions (e.g., China NMPA, Brazil ANVISA, Japan PMDA) require a formal submission/dossier filing. Linking ivd_registration to the supporting submission record e',
    `annual_report_due_date` DATE COMMENT 'Date by which the annual report, annual declaration, or periodic update is due to the regulatory authority. Applicable for jurisdictions requiring annual reporting (e.g., FDA establishment registration annual update).',
    `authorized_representative_address` STRING COMMENT 'Full address of the authorized representative or legal representative. Organizational contact data classified as confidential.',
    `authorized_representative_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the authorized representative location. [ENUM-REF-CANDIDATE: USA|CAN|AUS|BRA|CHN|JPN|IND|DEU|FRA|GBR|ITA|ESP|NLD|BEL|SWE|CHE|AUT|POL|DNK|NOR|FIN|IRL|PRT|CZE|HUN|ROU|GRC|BGR|HRV|SVK|SVN|LTU|LVA|EST|CYP|LUX|MLT|MEX|ARG|CHL|COL|PER|ZAF|KOR|TWN|SGP|MYS|THA|IDN|PHL|VNM|NZL|ISR|TUR|SAU|ARE|EGY|NGA|KEN|MAR|TUN|DZA|GHA|UGA|TZA|ETH|SEN|CIV|CMR|ZWE|ZMB|MOZ|AGO|RWA|UKR|RUS|BLR|KAZ|UZB|GEO|ARM|AZE|MDA|SRB|BIH|MKD|ALB|MNE|XKX — 89 candidates stripped; promote to reference product]',
    `authorized_representative_name` STRING COMMENT 'Name of the authorized representative or legal representative in the jurisdiction. Required for EU IVDR registrations and other jurisdictions where a local representative is mandated for non-domestic manufacturers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this registration record was first created in the system.',
    `device_listing_numbers` STRING COMMENT 'Comma-separated list of device listing numbers or product listing numbers associated with this registration (e.g., FDA device listing numbers). Applicable for jurisdictions requiring device listing in addition to establishment registration.',
    `effective_date` DATE COMMENT 'Date from which the registration becomes legally effective and the product or facility may operate under the registration.',
    `expiry_date` DATE COMMENT 'Date when the registration expires and must be renewed. Nullable for registrations without fixed expiry (e.g., some FDA establishment registrations require annual renewal but do not have a fixed expiry date).',
    `jurisdiction_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the regulatory jurisdiction where the registration is held (e.g., USA for FDA, CAN for Health Canada, AUS for TGA, BRA for ANVISA, CHN for NMPA, JPN for PMDA, IND for CDSCO). [ENUM-REF-CANDIDATE: USA|CAN|AUS|BRA|CHN|JPN|IND|DEU|FRA|GBR|ITA|ESP|NLD|BEL|SWE|CHE|AUT|POL|DNK|NOR|FIN|IRL|PRT|CZE|HUN|ROU|GRC|BGR|HRV|SVK|SVN|LTU|LVA|EST|CYP|LUX|MLT|MEX|ARG|CHL|COL|PER|ZAF|KOR|TWN|SGP|MYS|THA|IDN|PHL|VNM|NZL|ISR|TUR|SAU|ARE|EGY|NGA|KEN|MAR|TUN|DZA|GHA|UGA|TZA|ETH|SEN|CIV|CMR|ZWE|ZMB|MOZ|AGO|RWA|UKR|RUS|BLR|KAZ|UZB|GEO|ARM|AZE|MDA|SRB|BIH|MKD|ALB|MNE|XKX — 89 candidates stripped; promote to reference product]',
    `jurisdiction_region` STRING COMMENT 'Sub-national region, state, or province within the jurisdiction country if applicable (e.g., California for US state-level registrations, Ontario for Canadian provincial requirements). Nullable for national-level registrations.',
    `manufacturer_address` STRING COMMENT 'Full address of the manufacturer. Organizational contact data classified as confidential.',
    `manufacturer_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the manufacturer location. [ENUM-REF-CANDIDATE: USA|CAN|AUS|BRA|CHN|JPN|IND|DEU|FRA|GBR|ITA|ESP|NLD|BEL|SWE|CHE|AUT|POL|DNK|NOR|FIN|IRL|PRT|CZE|HUN|ROU|GRC|BGR|HRV|SVK|SVN|LTU|LVA|EST|CYP|LUX|MLT|MEX|ARG|CHL|COL|PER|ZAF|KOR|TWN|SGP|MYS|THA|IDN|PHL|VNM|NZL|ISR|TUR|SAU|ARE|EGY|NGA|KEN|MAR|TUN|DZA|GHA|UGA|TZA|ETH|SEN|CIV|CMR|ZWE|ZMB|MOZ|AGO|RWA|UKR|RUS|BLR|KAZ|UZB|GEO|ARM|AZE|MDA|SRB|BIH|MKD|ALB|MNE|XKX — 89 candidates stripped; promote to reference product]',
    `manufacturer_name` STRING COMMENT 'Legal name of the manufacturer or legal manufacturer of the IVD product or facility covered by this registration.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this registration record was last modified or updated in the system.',
    `next_renewal_date` DATE COMMENT 'Date by which the next renewal submission or renewal fee payment is due. Null if renewal is not required or not yet scheduled.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this registration, including special conditions, restrictions, or internal tracking information.',
    `registration_certificate_reference` STRING COMMENT 'Document reference, file path, or vault identifier for the official registration certificate or approval letter issued by the regulatory authority.',
    `registration_date` DATE COMMENT 'Date when the registration was officially granted or issued by the regulatory authority.',
    `registration_number` STRING COMMENT 'Official registration number or identifier issued by the regulatory authority. This is the externally-known unique identifier for the registration (e.g., FDA establishment registration number, Health Canada device license number, TGA ARTG number).',
    `registration_scope` STRING COMMENT 'Description of the scope of the registration: which products, device types, or activities are covered by this registration. May list multiple products or device families if the registration covers a portfolio.',
    `registration_status` STRING COMMENT 'Current lifecycle status of the registration: active (in force), pending (submitted but not yet approved), expired (past expiry date), suspended (temporarily halted by authority), cancelled (terminated by registrant), or withdrawn (revoked by authority).. Valid values are `active|pending|expired|suspended|cancelled|withdrawn`',
    `registration_type` STRING COMMENT 'Type of registration: product-level IVD registration, facility/establishment registration, manufacturer registration, importer registration, distributor registration, or authorized representative registration.. Valid values are `product|facility|manufacturer|importer|distributor|authorized_representative`',
    `regulatory_authority_name` STRING COMMENT 'Name of the regulatory authority or competent authority that issued the registration (e.g., U.S. Food and Drug Administration, Health Canada, Therapeutic Goods Administration, ANVISA, NMPA, PMDA, CDSCO, national competent authority in EU member states).',
    `regulatory_contact_email` STRING COMMENT 'Email address of the primary regulatory contact person. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `regulatory_contact_name` STRING COMMENT 'Name of the primary regulatory contact person responsible for this registration at the registrant organization.',
    `regulatory_contact_phone` STRING COMMENT 'Phone number of the primary regulatory contact person. Organizational contact data classified as confidential.',
    `renewal_frequency_months` STRING COMMENT 'Frequency in months at which the registration must be renewed (e.g., 12 for annual renewal, 60 for five-year renewal). Null if renewal is not required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this registration requires periodic renewal (True) or is perpetual/does not require renewal (False).',
    `ruo_ivd_designation` STRING COMMENT 'Designation indicating whether the product is for Research Use Only (RUO), In Vitro Diagnostic (IVD) use, or Laboratory Developed Test (LDT). RUO products are not intended for clinical diagnostic use; IVD products are approved for clinical use; LDT are laboratory-developed tests.. Valid values are `RUO|IVD|LDT`',
    CONSTRAINT pk_ivd_registration PRIMARY KEY(`ivd_registration_id`)
) COMMENT 'Master record for all regulatory registrations — product-level IVD registrations, facility/establishment registrations, and manufacturer/importer registrations with global health authorities. Covers Health Canada, TGA (Australia), ANVISA (Brazil), NMPA (China), PMDA (Japan), CDSCO (India), FDA establishment registration (21 CFR Part 807), EU authorized representative registrations, and other national competent authority filings. Captures registration type (product, facility, manufacturer, importer, distributor), registration number, country, facility address, registration date, expiry date, renewal status, local authorized representative, applicable product or facility scope, device types listed, and annual renewal obligations. SSOT for global regulatory registration, establishment compliance, and market access status across all registration types.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` (
    `device_identifier_id` BIGINT COMMENT 'Primary key for device_identifier',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: device_identifier tracks UDI assignments and device database registrations. UDI is assigned post-approval for approved products. Adding regulatory_approval_id FK directly links the UDI assignment to t',
    `catalog_item_id` BIGINT COMMENT 'Reference to the product master record for which this UDI assignment applies. Links to the genomic instrument, reagent kit, or IVD device product.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: UDI device identifiers are registered by specific manufacturing establishments. The GUDID and EUDAMED registrations require the manufacturers establishment registration. device_identifier has regulat',
    `submission_id` BIGINT COMMENT 'The unique submission identifier assigned by FDA GUDID when the device identifier record was submitted to the FDA database.',
    `basic_udi_di` STRING COMMENT 'The primary identifier of a device model that groups all device versions or models having the same intended purpose, design, and risk classification. Used for regulatory database queries.',
    `catalog_number` STRING COMMENT 'The manufacturers catalog or part number used for ordering and inventory management. May differ from UDI-DI.',
    `contains_latex_flag` BOOLEAN COMMENT 'Indicates whether the device or its packaging contains natural rubber latex, requiring allergen labeling.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this UDI assignment record was first created in the system.',
    `device_classification` STRING COMMENT 'The risk-based classification of the device under FDA or EU IVDR regulations. FDA uses Class I/II/III; EU IVDR uses Class A/B/C/D for IVDs. [ENUM-REF-CANDIDATE: class_i|class_iia|class_iib|class_iii|class_a|class_b|class_c|class_d — 8 candidates stripped; promote to reference product]',
    `device_description` STRING COMMENT 'A detailed description of the device including its intended use, technology, and key features for regulatory database publication.',
    `device_name` STRING COMMENT 'The proprietary or trade name of the device as it appears on the label and in regulatory submissions.',
    `discontinuation_date` DATE COMMENT 'The date on which this UDI-DI was discontinued and is no longer used on newly manufactured devices.',
    `economic_operator_registration_number` STRING COMMENT 'The Single Registration Number (SRN) assigned to the manufacturer or authorized representative in EUDAMED for economic operator identification.',
    `eudamed_device_identifier` STRING COMMENT 'The unique device identifier assigned by EUDAMED for EU IVDR compliance. Links to the EU device registration and economic operator records.',
    `eudamed_registration_date` DATE COMMENT 'The date the device was registered in EUDAMED by the manufacturer or authorized representative.',
    `eudamed_registration_status` STRING COMMENT 'The current registration status of the device in the European Database on Medical Devices under EU IVDR Article 26.. Valid values are `draft|submitted|registered|active|suspended|withdrawn`',
    `gmdn_code` STRING COMMENT 'The internationally recognized GMDN term code that categorizes the device by its intended purpose and technology.',
    `gmdn_term_name` STRING COMMENT 'The human-readable GMDN term name corresponding to the GMDN code.',
    `gudid_status` STRING COMMENT 'The current status of the device identifier record in the FDA GUDID system.. Valid values are `draft|submitted|published|inactive|discontinued`',
    `gudid_submission_date` DATE COMMENT 'The date the UDI-DI record was submitted to the FDA Global Unique Device Identification Database.',
    `intended_use_statement` STRING COMMENT 'The general purpose of the device or its intended use as described in the labeling and regulatory submissions.',
    `issuing_agency` STRING COMMENT 'The FDA-accredited issuing agency that assigned the UDI-DI code. GS1 (Global Standards 1), HIBCC (Health Industry Business Communications Council), or ICCBBA (International Council for Commonality in Blood Banking Automation).. Valid values are `GS1|HIBCC|ICCBBA`',
    `labeling_effective_date` DATE COMMENT 'The date on which the current UDI labeling became effective and must appear on all newly manufactured devices.',
    `labeling_storage_conditions` STRING COMMENT 'The storage temperature and environmental conditions specified on the device label (e.g., 2-8°C, room temperature, protect from light).',
    `model_number` STRING COMMENT 'The manufacturers model number or version identifier for the device, used to distinguish different configurations or generations.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this UDI assignment record was last modified.',
    `mri_safety_status` STRING COMMENT 'The MRI safety classification of the device indicating whether it is safe, conditionally safe, or unsafe in an MRI environment.. Valid values are `mr_safe|mr_conditional|mr_unsafe|not_applicable`',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to this UDI assignment, labeling requirements, or regulatory database submissions.',
    `package_quantity` STRING COMMENT 'The number of individual device units contained in the labeled package.',
    `package_type` STRING COMMENT 'The type of packaging used for the device (e.g., box, vial, tube, cartridge, flow cell).',
    `regulatory_contact_email` STRING COMMENT 'The email address of the regulatory affairs contact for UDI-related inquiries and submissions.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `regulatory_contact_name` STRING COMMENT 'The name of the regulatory affairs contact responsible for this UDI assignment and database submissions.',
    `ruo_ivd_designation` STRING COMMENT 'Indicates whether the device is marketed for Research Use Only, as an In Vitro Diagnostic, or as a Laboratory Developed Test.. Valid values are `RUO|IVD|LDT`',
    `shelf_life_months` STRING COMMENT 'The validated shelf life of the device in months from the date of manufacture, as stated on the label and in stability studies.',
    `single_use_flag` BOOLEAN COMMENT 'Indicates whether the device is intended for single use only and must not be reprocessed or reused.',
    `sterile_flag` BOOLEAN COMMENT 'Indicates whether the device is provided in a sterile state and requires sterile labeling and handling.',
    `udi_assignment_status` STRING COMMENT 'The current lifecycle status of this UDI assignment record indicating whether it is actively used on device labels.. Valid values are `active|inactive|discontinued|pending_approval`',
    `udi_carrier_type` STRING COMMENT 'The form of automatic identification and data capture (AIDC) technology or human-readable interpretation used to convey the UDI on the device label.. Valid values are `barcode_1d|barcode_2d|rfid|human_readable_text`',
    `udi_di_code` STRING COMMENT 'The Device Identifier portion of the UDI that identifies the labeler and specific version or model of a device. Globally unique and assigned by an FDA-accredited issuing agency.',
    `udi_pi_format` STRING COMMENT 'The format of the Production Identifier portion of the UDI that identifies one or more production-specific attributes (lot, serial, manufacturing date, expiration date) for traceability. [ENUM-REF-CANDIDATE: lot_number|serial_number|manufacturing_date|expiration_date|lot_and_serial|lot_and_expiration|serial_and_expiration — 7 candidates stripped; promote to reference product]',
    `version_number` STRING COMMENT 'The version or revision number of the device design, software, or labeling that may trigger a new UDI-DI assignment.',
    CONSTRAINT pk_device_identifier PRIMARY KEY(`device_identifier_id`)
) COMMENT 'Master record for Unique Device Identifier (UDI) assignments and device database registrations — UDI-DI (device identifier), UDI-PI (production identifier), GUDID submissions (FDA), and EUDAMED device registrations (EU IVDR). Captures UDI-DI code, UDI-PI format, Basic UDI-DI, issuing agency (GS1, HIBCC, ICCBBA), product reference, EUDAMED device identifier, EUDAMED registration status, economic operator registrations, and UDI-DI/UDI-PI linkage to labeling. Supports FDA GUDID, EU EUDAMED Article 26/Annex VI, and global UDI compliance for IVD and genomic instrument products.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` (
    `establishment_registration_id` BIGINT COMMENT 'Unique identifier for the establishment registration record. Primary key.',
    `annual_report_due_date` DATE COMMENT 'Date by which the annual establishment registration update or report must be submitted to the regulatory authority. Format yyyy-MM-dd.',
    `authorized_representative_address` STRING COMMENT 'Full address of the authorized representative. Must be located within the jurisdiction where representation is required.',
    `authorized_representative_name` STRING COMMENT 'Name of the authorized representative in the EU or other jurisdiction acting on behalf of the manufacturer. Required for non-EU manufacturers under IVDR.',
    `contact_person_title` STRING COMMENT 'Job title or role of the primary regulatory contact person. Typically Regulatory Affairs Manager, Quality Director, or similar.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this establishment registration record was first created in the system. Format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `device_classification_scope` STRING COMMENT 'Regulatory device classifications covered by this establishment registration. For FDA: Class I, II, III. For EU: Class A, B, C, D per IVDR. May include multiple classifications.',
    `device_types_manufactured` STRING COMMENT 'Comma-separated list or description of the types of medical devices or IVD products manufactured, imported, or distributed by this establishment. Includes product categories such as NGS sequencers, array platforms, reagent kits, consumables.',
    `effective_date` DATE COMMENT 'Date when the registration becomes legally effective and the establishment may begin operations under this registration. Format yyyy-MM-dd.',
    `establishment_dba_name` STRING COMMENT 'Trade name or doing business as name if different from legal establishment name. Used for facilities operating under alternate brand names.',
    `establishment_name` STRING COMMENT 'Legal name of the facility or establishment as registered with the regulatory authority. Must match official business registration documents.',
    `expiry_date` DATE COMMENT 'Date when the establishment registration expires and renewal is required. Null for jurisdictions with indefinite registration periods. Format yyyy-MM-dd.',
    `facility_address_line1` STRING COMMENT 'Primary street address line of the registered establishment facility. Includes street number, street name, and building identifier.',
    `facility_address_line2` STRING COMMENT 'Secondary address line for suite, floor, department, or other location details within the facility.',
    `facility_city` STRING COMMENT 'City or municipality where the registered establishment is physically located.',
    `facility_country_code` STRING COMMENT 'Three-letter ISO country code indicating the country where the establishment is physically located.. Valid values are `^[A-Z]{3}$`',
    `facility_postal_code` STRING COMMENT 'Postal or ZIP code for the facility address. Format varies by country jurisdiction.',
    `facility_state_province` STRING COMMENT 'State, province, or administrative region where the facility is located. Use standard postal abbreviations where applicable.',
    `gmp_certified_flag` BOOLEAN COMMENT 'Indicates whether the establishment holds valid GMP certification. True if certified under applicable GMP regulations, false otherwise.',
    `inspection_outcome` STRING COMMENT 'Result classification of the most recent regulatory inspection. Compliant indicates no findings, minor/major/critical indicate severity of non-conformances, pending indicates inspection report not yet finalized.. Valid values are `compliant|minor_findings|major_findings|critical_findings|pending`',
    `iso_13485_certificate_number` STRING COMMENT 'Certificate number for the establishments ISO 13485 certification if applicable. Issued by notified body or certification authority.',
    `iso_13485_certified_flag` BOOLEAN COMMENT 'Indicates whether the establishment holds valid ISO 13485 quality management system certification for medical devices.',
    `jurisdiction_country_code` STRING COMMENT 'Three-letter ISO country code indicating the regulatory jurisdiction under which this registration is filed. May differ from facility country for authorized representative registrations.. Valid values are `^[A-Z]{3}$`',
    `jurisdiction_region` STRING COMMENT 'Regional or sub-national jurisdiction if applicable. Used for countries with state-level or provincial regulatory requirements.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection or audit conducted at this establishment by the competent authority or notified body. Format yyyy-MM-dd.',
    `last_renewal_date` DATE COMMENT 'Date when the most recent renewal was completed and accepted by the regulatory authority. Format yyyy-MM-dd.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this establishment registration record was last modified or updated. Format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `next_renewal_date` DATE COMMENT 'Target date for the next registration renewal submission. Used for proactive compliance tracking. Format yyyy-MM-dd.',
    `notes` STRING COMMENT 'Free-text field for additional information, special conditions, or internal notes regarding this establishment registration. Used for tracking unique circumstances or compliance considerations.',
    `owner_operator_name` STRING COMMENT 'Name of the legal entity or individual that owns or operates the establishment. May differ from establishment name for contract facilities.',
    `parent_company_name` STRING COMMENT 'Name of the parent company or corporate entity if the establishment is part of a larger organization. Used for corporate hierarchy tracking.',
    `registration_date` DATE COMMENT 'Date when the establishment registration was officially granted or accepted by the regulatory authority. Format yyyy-MM-dd.',
    `registration_number` STRING COMMENT 'Official registration number assigned by the regulatory authority. For FDA this is the establishment registration number per 21 CFR Part 807. For EU this is the authorized representative registration identifier.',
    `registration_status` STRING COMMENT 'Current lifecycle status of the establishment registration. Active indicates valid registration, expired indicates renewal required, suspended indicates temporary hold by authority, cancelled indicates permanent termination, pending_renewal indicates renewal application submitted, under_review indicates initial application being evaluated.. Valid values are `active|expired|suspended|cancelled|pending_renewal|under_review`',
    `registration_type` STRING COMMENT 'Type of establishment registration indicating the role of the facility in the supply chain. Manufacturer produces devices, importer brings devices into jurisdiction, distributor handles logistics, authorized representative acts on behalf of non-EU manufacturer, contract manufacturer produces under contract, sterilizer provides sterilization services.. Valid values are `manufacturer|importer|distributor|authorized_representative|contract_manufacturer|sterilizer`',
    `regulatory_authority` STRING COMMENT 'Regulatory agency or competent authority that issued the establishment registration. FDA for United States, EMA for European Union, MHRA for United Kingdom, TGA for Australia, PMDA for Japan, ANVISA for Brazil, Health Canada for Canada, NMPA for China, COFEPRIS for Mexico. [ENUM-REF-CANDIDATE: FDA|EMA|MHRA|TGA|PMDA|ANVISA|Health_Canada|NMPA|COFEPRIS — 9 candidates stripped; promote to reference product]',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals. Typically 12 for annual renewal jurisdictions. Null if renewal not required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this registration requires periodic renewal. True for jurisdictions requiring annual or periodic renewal, false for indefinite registrations.',
    `us_agent_address` STRING COMMENT 'Full address of the designated US agent. Must be a physical US address, not a post office box.',
    `us_agent_name` STRING COMMENT 'Name of the US agent designated by foreign establishments for FDA registration per 21 CFR 807.40. Required for non-US manufacturers marketing devices in the United States.',
    CONSTRAINT pk_establishment_registration PRIMARY KEY(`establishment_registration_id`)
) COMMENT 'Master record for facility and establishment registrations with regulatory authorities — FDA establishment registration (21 CFR Part 807), EU authorized representative registrations, and country-specific manufacturer/importer registrations. Captures establishment name, registration number, facility address, registration type (manufacturer, importer, distributor), applicable device types, registration expiry, and annual renewal status. SSOT for regulatory facility compliance across global markets.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ADD CONSTRAINT `fk_regulatory_submission_event_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ADD CONSTRAINT `fk_regulatory_submission_event_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ADD CONSTRAINT `fk_regulatory_submission_event_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ADD CONSTRAINT `fk_regulatory_approval_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ADD CONSTRAINT `fk_regulatory_agency_correspondence_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ADD CONSTRAINT `fk_regulatory_agency_correspondence_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ADD CONSTRAINT `fk_regulatory_agency_correspondence_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ADD CONSTRAINT `fk_regulatory_document_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ADD CONSTRAINT `fk_regulatory_document_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ADD CONSTRAINT `fk_regulatory_document_superseded_document_id` FOREIGN KEY (`superseded_document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ADD CONSTRAINT `fk_regulatory_labeling_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ADD CONSTRAINT `fk_regulatory_labeling_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ADD CONSTRAINT `fk_regulatory_labeling_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ADD CONSTRAINT `fk_regulatory_adverse_event_report_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ADD CONSTRAINT `fk_regulatory_adverse_event_report_field_safety_action_id` FOREIGN KEY (`field_safety_action_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`field_safety_action`(`field_safety_action_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ADD CONSTRAINT `fk_regulatory_adverse_event_report_post_market_surveillance_id` FOREIGN KEY (`post_market_surveillance_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance`(`post_market_surveillance_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ADD CONSTRAINT `fk_regulatory_adverse_event_report_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ADD CONSTRAINT `fk_regulatory_adverse_event_report_document_id` FOREIGN KEY (`document_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`document`(`document_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ADD CONSTRAINT `fk_regulatory_post_market_surveillance_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ADD CONSTRAINT `fk_regulatory_post_market_surveillance_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ADD CONSTRAINT `fk_regulatory_field_safety_action_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ADD CONSTRAINT `fk_regulatory_field_safety_action_post_market_surveillance_id` FOREIGN KEY (`post_market_surveillance_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance`(`post_market_surveillance_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ADD CONSTRAINT `fk_regulatory_field_safety_action_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ADD CONSTRAINT `fk_regulatory_ivd_registration_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ADD CONSTRAINT `fk_regulatory_ivd_registration_device_identifier_id` FOREIGN KEY (`device_identifier_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`device_identifier`(`device_identifier_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ADD CONSTRAINT `fk_regulatory_ivd_registration_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ADD CONSTRAINT `fk_regulatory_ivd_registration_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ADD CONSTRAINT `fk_regulatory_device_identifier_approval_id` FOREIGN KEY (`approval_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`approval`(`approval_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ADD CONSTRAINT `fk_regulatory_device_identifier_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ADD CONSTRAINT `fk_regulatory_device_identifier_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `genomics_biotech_ecm`.`regulatory`.`submission`(`submission_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`regulatory` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `genomics_biotech_ecm`.`regulatory` SET TAGS ('dbx_domain' = 'regulatory');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` SET TAGS ('dbx_subdomain' = 'submission_approval');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `adverse_event_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Reporting Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `clinical_data_required` SET TAGS ('dbx_business_glossary_term' = 'Clinical Data Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `clinical_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Clinical Study Reference');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `competent_authority` SET TAGS ('dbx_business_glossary_term' = 'Competent Authority');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `correspondence_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Agency Correspondence Log Reference');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `device_classification` SET TAGS ('dbx_business_glossary_term' = 'Device Classification');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `dossier_reference` SET TAGS ('dbx_business_glossary_term' = 'Dossier Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `expedited_review_granted` SET TAGS ('dbx_business_glossary_term' = 'Expedited Review Granted Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `expedited_review_requested` SET TAGS ('dbx_business_glossary_term' = 'Expedited Review Requested Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Submission Fee Amount');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Submission Fee Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `gmp_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Statement');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `iso_13485_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'ISO 13485 Certificate Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `labeling_compliance_verified` SET TAGS ('dbx_business_glossary_term' = 'Labeling Compliance Verified Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Submission Language');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `local_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Local Authorized Representative Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `local_representative_required` SET TAGS ('dbx_business_glossary_term' = 'Local Representative Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `notified_body_number` SET TAGS ('dbx_business_glossary_term' = 'Notified Body Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `post_market_surveillance_plan` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance Plan Reference');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `predicate_device` SET TAGS ('dbx_business_glossary_term' = 'Predicate Device');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Submission Priority');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Device Registration Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Framework');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Pathway Classification');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Lifecycle Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = '510(k)|PMA|De Novo|CE-IVD|IVDR|EMA Dossier');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `target_agency` SET TAGS ('dbx_business_glossary_term' = 'Target Regulatory Agency');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `target_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Target Decision Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `target_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Target Jurisdiction');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission` ALTER COLUMN `udi_di` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identification - Device Identifier (UDI-DI)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` SET TAGS ('dbx_subdomain' = 'submission_approval');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `submission_event_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Event Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Dossier Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Package Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `actual_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Decision Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `agency_receipt_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Agency Receipt Confirmation Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `agency_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Receipt Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `decision_letter_reference` SET TAGS ('dbx_business_glossary_term' = 'Decision Letter Reference');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Decision Outcome');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|rejected|withdrawn|pending');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `deficiency_letter_date` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Letter Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `deficiency_letter_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Letter Received Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `deficiency_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Response Due Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `ectd_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Common Technical Document (eCTD) Sequence Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `fee_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `fee_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `fee_payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|waived|refunded|overdue');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `regulatory_correspondent_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Correspondent Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `review_clock_days` SET TAGS ('dbx_business_glossary_term' = 'Review Clock Days');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `submission_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Submission Fee Amount');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `submission_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Submission Fee Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `submission_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `submission_format` SET TAGS ('dbx_business_glossary_term' = 'Submission Format');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `submission_format` SET TAGS ('dbx_value_regex' = 'ectd|neesr|paper|pdf|xml|proprietary');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'ectd_gateway|estar|paper|electronic_portal|email|courier');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `submission_notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `submission_package_reference` SET TAGS ('dbx_business_glossary_term' = 'Submission Package Reference');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `submission_version` SET TAGS ('dbx_business_glossary_term' = 'Submission Version');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `submission_volume_count` SET TAGS ('dbx_business_glossary_term' = 'Submission Volume Count');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `target_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Target Decision Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `total_document_count` SET TAGS ('dbx_business_glossary_term' = 'Total Document Count');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`submission_event` ALTER COLUMN `total_page_count` SET TAGS ('dbx_business_glossary_term' = 'Total Page Count');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` SET TAGS ('dbx_subdomain' = 'submission_approval');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `annual_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Annual Report Due Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|withdrawn|pending_renewal|revoked');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `approval_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `approved_indications` SET TAGS ('dbx_business_glossary_term' = 'Approved Clinical Indications');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `clia_complexity` SET TAGS ('dbx_business_glossary_term' = 'Clinical Laboratory Improvement Amendments (CLIA) Complexity');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `clia_complexity` SET TAGS ('dbx_value_regex' = 'waived|moderate|high');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `conditions_of_approval` SET TAGS ('dbx_business_glossary_term' = 'Conditions of Approval');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `device_classification` SET TAGS ('dbx_business_glossary_term' = 'Medical Device Classification');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Approval Document Reference');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `holder_address` SET TAGS ('dbx_business_glossary_term' = 'Approval Holder Address');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `holder_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `holder_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `holder_name` SET TAGS ('dbx_business_glossary_term' = 'Approval Holder Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `intended_use` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Statement');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `jurisdiction_region` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Region');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `labeling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Labeling Requirements');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Inspection Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `post_market_surveillance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `predicate_device` SET TAGS ('dbx_business_glossary_term' = 'Predicate Device');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Approved Product Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Email Address');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `regulatory_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `regulatory_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `regulatory_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Pathway');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_value_regex' = 'premarket_notification|premarket_approval|de_novo|conformity_assessment|mutual_recognition|national_registration');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency in Months');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `ruo_ivd_designation` SET TAGS ('dbx_business_glossary_term' = 'Research Use Only (RUO) or In Vitro Diagnostic (IVD) Designation');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `ruo_ivd_designation` SET TAGS ('dbx_value_regex' = 'ruo|ivd|ldt');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`approval` ALTER COLUMN `technical_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Technical File Reference');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` SET TAGS ('dbx_subdomain' = 'submission_approval');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `agency_correspondence_id` SET TAGS ('dbx_business_glossary_term' = 'Agency Correspondence Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Email Address');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `agency_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `agency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Agency Contact Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `agency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `agency_division` SET TAGS ('dbx_business_glossary_term' = 'Agency Division or Office');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `agency_feedback_received` SET TAGS ('dbx_business_glossary_term' = 'Agency Feedback Received');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `agenda_topics` SET TAGS ('dbx_business_glossary_term' = 'Meeting Agenda Topics');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `correspondence_date` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `correspondence_number` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `correspondence_status` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `correspondence_status` SET TAGS ('dbx_value_regex' = 'open|pending_response|closed|archived|escalated');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Direction');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Identifier');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `impact_on_submission_strategy` SET TAGS ('dbx_business_glossary_term' = 'Impact on Submission Strategy');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `interaction_subtype` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subtype');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `key_questions_posed` SET TAGS ('dbx_business_glossary_term' = 'Key Questions Posed');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Meeting Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `meeting_type` SET TAGS ('dbx_business_glossary_term' = 'Meeting Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Priority');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code or Stock Keeping Unit (SKU)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Pathway');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|submitted|accepted|rejected|no_response_required');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Subject');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`agency_correspondence` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` SET TAGS ('dbx_subdomain' = 'document_labeling');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Document ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `superseded_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Document ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Document Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Pending|Approved|Rejected|Conditional');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Document Approver Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `archive_location` SET TAGS ('dbx_business_glossary_term' = 'Archive Storage Location');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `audit_trail_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Summary');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Document Author Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `checksum_value` SET TAGS ('dbx_business_glossary_term' = 'Document Checksum Value (SHA-256)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Document Comments');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Document Confidentiality Level');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'Public|Internal|Confidential|Restricted');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Document Distribution List');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Control Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Document Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Document Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Document File Format');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'PDF|DOCX|XLSX|PPTX|XML|HTML');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `file_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Document File Size (Megabytes)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Document Language Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Document Lifecycle Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Document Page Count');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_value_regex' = 'FDA 510(k)|FDA PMA|FDA De Novo|CE-IVD|IVDR|EMA CTD|ICH M4|CLIA|CAP|ISO 13485|ISO 15189|ISO 14971|GDPR|HIPAA|GxP');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Document Retention Period (Years)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Periodic Review Due Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `revision_description` SET TAGS ('dbx_business_glossary_term' = 'Revision Description');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Document Subtype');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `training_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `vault_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `vault_document_reference` SET TAGS ('dbx_value_regex' = '^VV[0-9]{10,15}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`document` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` SET TAGS ('dbx_subdomain' = 'document_labeling');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `labeling_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `device_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Stock Keeping Unit (SKU) ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `authorized_representative` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `barcode_type` SET TAGS ('dbx_business_glossary_term' = 'Barcode Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `barcode_type` SET TAGS ('dbx_value_regex' = 'ean13|upc|gs1_datamatrix|qr_code|none');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `ce_mark_required` SET TAGS ('dbx_business_glossary_term' = 'Conformité Européenne (CE) Mark Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `change_classification` SET TAGS ('dbx_business_glossary_term' = 'Change Classification');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `change_classification` SET TAGS ('dbx_value_regex' = 'major|minor|administrative');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `checksum_md5` SET TAGS ('dbx_business_glossary_term' = 'Message Digest 5 (MD5) Checksum');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `customer_support_contact` SET TAGS ('dbx_business_glossary_term' = 'Customer Support Contact');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `customer_support_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `customer_support_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Control Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `expiry_date_format` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date Format');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `fda_establishment_identifier` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Establishment Identifier');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|html|xml|indesign|illustrator');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size in Bytes');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `hazard_symbols` SET TAGS ('dbx_business_glossary_term' = 'Hazard Symbols');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `impacted_markets` SET TAGS ('dbx_business_glossary_term' = 'Impacted Markets');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `intended_use_statement` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Statement');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `labeling_type` SET TAGS ('dbx_business_glossary_term' = 'Labeling Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `labeling_type` SET TAGS ('dbx_value_regex' = 'instrument_label|reagent_kit_insert|ifu_document|carton_artwork|digital_labeling|safety_data_sheet');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `lot_number_format` SET TAGS ('dbx_business_glossary_term' = 'Lot Number Format');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Address');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|effective|obsolete|withdrawn');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Labeling Title');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Labeling Version');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`labeling` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` SET TAGS ('dbx_subdomain' = 'post_market');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `adverse_event_report_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Report ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `field_safety_action_id` SET TAGS ('dbx_business_glossary_term' = 'Field Safety Action Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `post_market_surveillance_id` SET TAGS ('dbx_business_glossary_term' = 'Post Market Surveillance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `affected_lot_numbers` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot Numbers');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `affected_markets` SET TAGS ('dbx_business_glossary_term' = 'Affected Markets');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `agency_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Acknowledgment Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `agency_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Agency Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `corrective_action_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `corrective_action_type` SET TAGS ('dbx_value_regex' = 'recall|fsca|fsn|product_modification|labeling_change|no_action');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `customer_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `customer_notification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|complete');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `device_product_code` SET TAGS ('dbx_business_glossary_term' = 'Device Product Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `device_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_value_regex' = 'no_follow_up|follow_up_pending|follow_up_submitted|follow_up_complete');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `patient_impact` SET TAGS ('dbx_business_glossary_term' = 'Patient Impact');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `patient_impact` SET TAGS ('dbx_value_regex' = 'death|serious_injury|malfunction_no_injury|no_impact');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|submitted|acknowledged|follow_up_required|closed');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'mdr|serious_incident|fsca|fsn|recall|market_withdrawal');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `reportability_determination` SET TAGS ('dbx_business_glossary_term' = 'Reportability Determination');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `reportability_determination` SET TAGS ('dbx_value_regex' = 'reportable|non_reportable|under_evaluation');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `reportability_rationale` SET TAGS ('dbx_business_glossary_term' = 'Reportability Rationale');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `reporter_contact` SET TAGS ('dbx_business_glossary_term' = 'Reporter Contact');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `reporter_contact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `reporter_contact` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `reporter_name` SET TAGS ('dbx_business_glossary_term' = 'Reporter Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `reporter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `reporter_type` SET TAGS ('dbx_business_glossary_term' = 'Reporter Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `reporter_type` SET TAGS ('dbx_value_regex' = 'customer|field_service|internal_qa|regulatory_authority|healthcare_provider');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'design|manufacturing|labeling|user_error|environmental|unknown');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`adverse_event_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` SET TAGS ('dbx_subdomain' = 'post_market');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `post_market_surveillance_id` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance (PMS) ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Catalog Item Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `adverse_event_count` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Count');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `benefit_risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Benefit-Risk Assessment Summary');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `clinical_follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Clinical Follow-Up Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `complaint_data_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Complaint Data Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `data_sources` SET TAGS ('dbx_business_glossary_term' = 'Data Sources');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `device_classification` SET TAGS ('dbx_business_glossary_term' = 'Device Classification');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `field_safety_notice_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Field Safety Notice Issued Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `last_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Last Report Submission Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `literature_review_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Literature Review Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `next_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Report Due Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `plan_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `plan_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `pmpf_study_protocol_reference` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Performance Follow-Up (PMPF) Study Protocol Reference');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `pms_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance (PMS) Plan Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `pms_status` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance (PMS) Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `pms_type` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance (PMS) Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `pms_type` SET TAGS ('dbx_value_regex' = 'pms_plan|psur|pmpf_plan|post_approval_study|vigilance_report|field_safety_corrective_action');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `recall_initiated_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiated Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `registry_data_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Registry Data Included Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `risk_management_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Risk Management File Reference');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `serious_adverse_event_count` SET TAGS ('dbx_business_glossary_term' = 'Serious Adverse Event Count');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`post_market_surveillance` ALTER COLUMN `technical_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Technical File Reference');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` SET TAGS ('dbx_subdomain' = 'post_market');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `field_safety_action_id` SET TAGS ('dbx_business_glossary_term' = 'Field Safety Action ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `post_market_surveillance_id` SET TAGS ('dbx_business_glossary_term' = 'Post Market Surveillance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Field Safety Action Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `action_number` SET TAGS ('dbx_value_regex' = '^FSA-[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Field Safety Action Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|customer_notification_complete|product_recovery_complete|closed|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Field Safety Action Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'recall|market_withdrawal|safety_alert|field_correction|customer_notification|product_removal');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `affected_lot_numbers` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot Numbers');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `affected_markets` SET TAGS ('dbx_business_glossary_term' = 'Affected Geographic Markets');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `affected_product_code` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `affected_product_name` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `affected_serial_numbers` SET TAGS ('dbx_business_glossary_term' = 'Affected Serial Numbers');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Action Closure Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `competent_authority_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Competent Authority Notification Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `customer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `customer_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Method');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `customer_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `customer_notification_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|complete|partial');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `customers_notified_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Notified Count');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `effectiveness_check_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `effectiveness_check_outcome` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Outcome');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `effectiveness_check_outcome` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|pending');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `effectiveness_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `estimated_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `fda_notification_date` SET TAGS ('dbx_business_glossary_term' = 'FDA Notification Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `fda_recall_number` SET TAGS ('dbx_business_glossary_term' = 'FDA Recall Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `fda_recall_number` SET TAGS ('dbx_value_regex' = '^[A-Z]-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimate');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `fsn_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Field Safety Notice (FSN) Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'FDA Hazard Classification');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'class_i|class_ii|class_iii');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Action Initiation Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Field Safety Action Notes');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `notified_body_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notified Body Notification Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `recovery_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recovery Completion Percentage');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Email Address');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `root_cause_summary` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Summary');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `units_distributed_count` SET TAGS ('dbx_business_glossary_term' = 'Units Distributed Count');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`field_safety_action` ALTER COLUMN `units_recovered_count` SET TAGS ('dbx_business_glossary_term' = 'Units Recovered Count');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` SET TAGS ('dbx_subdomain' = 'device_registration');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `ivd_registration_id` SET TAGS ('dbx_business_glossary_term' = 'In Vitro Diagnostic (IVD) Registration Identifier');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `device_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `annual_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Annual Report Due Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `authorized_representative_address` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Address');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `authorized_representative_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `authorized_representative_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `authorized_representative_country_code` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Country Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `authorized_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `device_listing_numbers` SET TAGS ('dbx_business_glossary_term' = 'Device Listing Numbers');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `jurisdiction_region` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Region');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Address');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `manufacturer_country_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Country Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `registration_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Registration Certificate Reference');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `registration_scope` SET TAGS ('dbx_business_glossary_term' = 'Registration Scope');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|cancelled|withdrawn');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'product|facility|manufacturer|importer|distributor|authorized_representative');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Email Address');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `regulatory_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `regulatory_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `regulatory_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency in Months');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `ruo_ivd_designation` SET TAGS ('dbx_business_glossary_term' = 'Research Use Only (RUO) or In Vitro Diagnostic (IVD) Designation');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`ivd_registration` ALTER COLUMN `ruo_ivd_designation` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` SET TAGS ('dbx_subdomain' = 'device_registration');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `device_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier Identifier');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Global Unique Device Identification Database (GUDID) Submission ID');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `basic_udi_di` SET TAGS ('dbx_business_glossary_term' = 'Basic Unique Device Identifier - Device Identifier (Basic UDI-DI)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `catalog_number` SET TAGS ('dbx_business_glossary_term' = 'Catalog Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `contains_latex_flag` SET TAGS ('dbx_business_glossary_term' = 'Contains Latex Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `device_classification` SET TAGS ('dbx_business_glossary_term' = 'Device Classification');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `device_description` SET TAGS ('dbx_business_glossary_term' = 'Device Description');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `device_name` SET TAGS ('dbx_business_glossary_term' = 'Device Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'UDI Discontinuation Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `economic_operator_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Economic Operator Registration Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `eudamed_device_identifier` SET TAGS ('dbx_business_glossary_term' = 'European Database on Medical Devices (EUDAMED) Device Identifier');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `eudamed_registration_date` SET TAGS ('dbx_business_glossary_term' = 'EUDAMED Registration Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `eudamed_registration_status` SET TAGS ('dbx_business_glossary_term' = 'EUDAMED Registration Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `eudamed_registration_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|registered|active|suspended|withdrawn');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `gmdn_code` SET TAGS ('dbx_business_glossary_term' = 'Global Medical Device Nomenclature (GMDN) Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `gmdn_term_name` SET TAGS ('dbx_business_glossary_term' = 'GMDN Term Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `gudid_status` SET TAGS ('dbx_business_glossary_term' = 'GUDID Registration Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `gudid_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|published|inactive|discontinued');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `gudid_submission_date` SET TAGS ('dbx_business_glossary_term' = 'GUDID Submission Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `intended_use_statement` SET TAGS ('dbx_business_glossary_term' = 'Intended Use Statement');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'UDI Issuing Agency');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_value_regex' = 'GS1|HIBCC|ICCBBA');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `labeling_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Labeling Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `labeling_storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Labeling Storage Conditions');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `mri_safety_status` SET TAGS ('dbx_business_glossary_term' = 'Magnetic Resonance Imaging (MRI) Safety Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `mri_safety_status` SET TAGS ('dbx_value_regex' = 'mr_safe|mr_conditional|mr_unsafe|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'UDI Assignment Notes');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `package_quantity` SET TAGS ('dbx_business_glossary_term' = 'Package Quantity');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Email');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `ruo_ivd_designation` SET TAGS ('dbx_business_glossary_term' = 'Research Use Only (RUO) / In Vitro Diagnostic (IVD) Designation');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `ruo_ivd_designation` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Months');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `single_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Use Device Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `sterile_flag` SET TAGS ('dbx_business_glossary_term' = 'Sterile Device Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `udi_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'UDI Assignment Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `udi_assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending_approval');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `udi_carrier_type` SET TAGS ('dbx_business_glossary_term' = 'UDI Carrier Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `udi_carrier_type` SET TAGS ('dbx_value_regex' = 'barcode_1d|barcode_2d|rfid|human_readable_text');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `udi_di_code` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier - Device Identifier (UDI-DI) Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `udi_pi_format` SET TAGS ('dbx_business_glossary_term' = 'Unique Device Identifier - Production Identifier (UDI-PI) Format');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`device_identifier` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` SET TAGS ('dbx_subdomain' = 'device_registration');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `annual_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Annual Report Due Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `authorized_representative_address` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Address');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `authorized_representative_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `authorized_representative_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `authorized_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Authorized Representative Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `contact_person_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Title');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `device_classification_scope` SET TAGS ('dbx_business_glossary_term' = 'Device Classification Scope');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `device_types_manufactured` SET TAGS ('dbx_business_glossary_term' = 'Device Types Manufactured');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `establishment_dba_name` SET TAGS ('dbx_business_glossary_term' = 'Establishment Doing Business As (DBA) Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `establishment_name` SET TAGS ('dbx_business_glossary_term' = 'Establishment Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Facility Address Line 1');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Facility Address Line 2');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_city` SET TAGS ('dbx_business_glossary_term' = 'Facility City');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_country_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Country Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Postal Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_state_province` SET TAGS ('dbx_business_glossary_term' = 'Facility State or Province');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `gmp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'compliant|minor_findings|major_findings|critical_findings|pending');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `iso_13485_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'ISO 13485 Certificate Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `iso_13485_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 13485 Certified Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `jurisdiction_region` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Region');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `owner_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Owner or Operator Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `owner_operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `owner_operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `parent_company_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Company Name');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|cancelled|pending_renewal|under_review');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'manufacturer|importer|distributor|authorized_representative|contract_manufacturer|sterilizer');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency in Months');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `us_agent_address` SET TAGS ('dbx_business_glossary_term' = 'United States (US) Agent Address');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `us_agent_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `us_agent_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `us_agent_name` SET TAGS ('dbx_business_glossary_term' = 'United States (US) Agent Name');
