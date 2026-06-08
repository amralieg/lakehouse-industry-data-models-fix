-- Schema for Domain: court | Business: Legal | Version: v8_ecm
-- Generated on: 2026-05-21 01:11:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm_v1`.`court` COMMENT 'Manages court and tribunal information including court jurisdictions, judges, court rules, filing requirements, hearing schedules, docket management, and electronic case filing (ECF) integration. Supports litigation practice with court calendar management, appearance tracking, ADR proceedings, arbitration (ICC, LCIA), and PACER integration for federal court access.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm_v1`.`court`.`service_of_process` (
    `service_of_process_id` BIGINT COMMENT 'Unique identifier for the service of process record. Primary key.',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to knowledge.form_template. Business justification: Service of process requires specific forms (summons, proof of service affidavits, declaration of service). Linking service events to the forms used tracks compliance with service requirements and enab',
    `indemnity_claim_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_claim. Business justification: Service of process in indemnity claims triggers insurer notification and defense coordination; critical for claims management and regulatory compliance.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this service of process belongs.',
    `legal_document_id` BIGINT COMMENT 'Reference to the document management system record for the filed proof of service (affidavit, certificate, or return of service).',
    `privacy_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_breach. Business justification: Service of process in privacy litigation triggers DPO notification and supervisory authority reporting; essential for GDPR compliance and breach incident tracking.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.client_profile. Business justification: Service of process events involve clients as parties. Linking enables client notification workflows, litigation timeline tracking, response deadline calculation, and proof-of-service documentation for',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Service failures create jurisdictional defects and statute of limitations issues, leading to malpractice exposure. Risk teams track service compliance for quality control and insurer reporting.',
    `attempted_service_count` STRING COMMENT 'Number of attempts made to effect service on the party before successful service or abandonment.',
    `central_authority_reference` STRING COMMENT 'Reference number or identifier assigned by the Central Authority when service is effected under the Hague Service Convention.',
    `compliance_deadline_date` DATE COMMENT 'Date by which the served party must comply with the served document (e.g., response deadline for complaint, production deadline for subpoena duces tecum, appearance date for subpoena ad testificandum).',
    `created_by_user_code` BIGINT COMMENT 'Identifier of the user or system account that created this service of process record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service of process record was first created in the system.',
    `document_type` STRING COMMENT 'Type of legal document being served. Distinguishes between complaints, summonses, subpoenas (ad testificandum for testimony, duces tecum for documents), arbitration notices, and other compulsory instruments. [ENUM-REF-CANDIDATE: complaint|summons|subpoena_ad_testificandum|subpoena_duces_tecum|arbitration_notice|motion|order|notice|other — 9 candidates stripped; promote to reference product]',
    `ecf_filing_reference` STRING COMMENT 'Reference number or transaction ID from the Electronic Case Filing (ECF) system if proof of service was filed electronically.',
    `esi_ediscovery_flag` BOOLEAN COMMENT 'Indicates whether this service of process involves electronically stored information (ESI) or triggers eDiscovery obligations (True/False), particularly relevant for subpoenas duces tecum requesting electronic documents.',
    `hague_convention_flag` BOOLEAN COMMENT 'Indicates whether service was effected under the Hague Service Convention for international service of process (True/False).',
    `jurisdiction_code` STRING COMMENT 'Code identifying the legal jurisdiction governing this service of process (federal, state, county, or international jurisdiction).',
    `modified_by_user_code` BIGINT COMMENT 'Identifier of the user or system account that last modified this service of process record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service of process record was last modified or updated.',
    `objection_date` DATE COMMENT 'Date on which an objection or motion to quash service was filed by the served party.',
    `objection_filed_flag` BOOLEAN COMMENT 'Indicates whether the party served has filed an objection or motion to quash service (True/False).',
    `objection_reason` STRING COMMENT 'Textual description of the grounds for objection to service (e.g., insufficient process, insufficient service of process, lack of personal jurisdiction).',
    `pacer_case_number` STRING COMMENT 'PACER case number for federal court cases, linking this service of process to the federal court docket.',
    `party_served_name` STRING COMMENT 'Full legal name of the individual or entity upon whom service was effected.',
    `party_served_role` STRING COMMENT 'Role of the party being served in the legal proceeding (defendant, plaintiff, witness, third-party, agent, registered agent). [ENUM-REF-CANDIDATE: defendant|plaintiff|witness|third_party|agent|registered_agent|other — 7 candidates stripped; promote to reference product]',
    `process_server_license_number` STRING COMMENT 'License or registration number of the process server, if applicable under jurisdictional requirements.',
    `process_server_name` STRING COMMENT 'Full name of the individual or entity who effected service (process server, sheriff, marshal, attorney, or other authorized person).',
    `proof_of_service_filed_date` DATE COMMENT 'Date on which the proof of service (affidavit or certificate of service) was filed with the court or tribunal.',
    `response_due_date` DATE COMMENT 'Date by which the served party must file a responsive pleading or answer, calculated from the service date per applicable rules.',
    `service_address_line1` STRING COMMENT 'Primary street address line where service was effected.',
    `service_address_line2` STRING COMMENT 'Secondary address line (suite, apartment, floor) where service was effected.',
    `service_city` STRING COMMENT 'City where service was effected.',
    `service_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for effecting service of process, including process server fees, mailing costs, publication costs, or international service fees.',
    `service_cost_currency_code` STRING COMMENT 'Three-letter ISO currency code for the service cost amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `service_country_code` STRING COMMENT 'Three-letter ISO country code where service was effected (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `service_date` DATE COMMENT 'Date on which service of process was completed and the document was delivered to or left with the party served.',
    `service_docket` BIGINT COMMENT 'FK to court.docket.docket_id — Service of process is performed in connection with a docket. Required for proof of service filing and compliance tracking.',
    `service_method` STRING COMMENT 'Method by which service was effected: personal service, substituted service, service by publication, electronic service, Hague Convention service for international parties, certified or registered mail, or other jurisdictionally-approved method. [ENUM-REF-CANDIDATE: personal|substituted|publication|electronic|hague_convention|certified_mail|registered_mail|other — 8 candidates stripped; promote to reference product]',
    `service_notes` STRING COMMENT 'Free-text notes documenting circumstances of service, challenges encountered, special instructions followed, or other relevant details provided by the process server or attorney.',
    `service_postal_code` STRING COMMENT 'Postal or ZIP code where service was effected.',
    `service_reference_number` STRING COMMENT 'Business identifier or tracking number assigned to this service of process event for external reference and tracking.',
    `service_state_province` STRING COMMENT 'State or province where service was effected.',
    `service_status` STRING COMMENT 'Current operational status of the service of process attempt: pending (not yet attempted), completed (successfully served), failed (attempt unsuccessful), returned unserved (unable to locate or serve party), or quashed (invalidated by court).. Valid values are `pending|completed|failed|returned_unserved|quashed`',
    `service_time` TIMESTAMP COMMENT 'Precise timestamp when service was completed, including time of day, for jurisdictions requiring exact time documentation.',
    `service_to_docket` BIGINT COMMENT 'FK to court.docket.docket_id — Service of process occurs in connection with a litigated matter/docket. Required to track which case the service relates to.',
    `service_validity_status` STRING COMMENT 'Current validity status of the service of process: valid (accepted by court), invalid (rejected or defective), pending validation, quashed (set aside by court order), or objected (party has filed objection).. Valid values are `valid|invalid|pending_validation|quashed|objected`',
    CONSTRAINT pk_service_of_process PRIMARY KEY(`service_of_process_id`)
) COMMENT 'Tracks formal service of legal process on parties including complaints, summonses, subpoenas (ad testificandum and duces tecum), arbitration notices, and other compulsory instruments. Records service method (personal, substituted, publication, electronic, Hague Convention), service date, process server identity, party served, document type and reference, proof of service filing date, service validity status, objection status, compliance deadline, and ESI/eDiscovery implications flag. Supports litigation workflow, ensures compliance with jurisdictional service requirements, and links to document management for collection when subpoenas duces tecum are involved.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`court`.`adr_proceeding` (
    `adr_proceeding_id` BIGINT COMMENT 'Unique identifier for the ADR proceeding. Primary key for the ADR proceeding record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: ADR proceedings frequently involve trust or escrow arrangements for settlement funds, arbitration deposits, or mediation settlement amounts. Attorneys must track which trust account holds ADR-related ',
    `indemnity_claim_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_claim. Business justification: Mediation/arbitration of indemnity claims is standard practice for settlement; essential for claims management, insurer coordination, and regulatory compliance.',
    `matter_id` BIGINT COMMENT 'Reference to the parent matter under which this ADR proceeding is conducted. Links the ADR proceeding to the broader legal matter for tracking and billing purposes.',
    `practice_note_id` BIGINT COMMENT 'Foreign key linking to knowledge.practice_note. Business justification: ADR forums have specific practice notes (arbitration procedures, mediation protocols, institutional rules, discovery in arbitration). Linking proceeding to practice notes ensures procedural compliance',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.client_profile. Business justification: ADR proceedings are client matters. Direct link supports alternative dispute resolution tracking, client preference analysis for settlement vs. litigation, cost-benefit reporting, and ADR outcome metr',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: ADR/arbitration of regulatory disputes is common in commercial regulatory matters; essential for breach resolution tracking and regulatory reporting.',
    `administering_institution` STRING COMMENT 'The arbitration or ADR institution administering the proceeding (e.g., ICC, LCIA, AAA, JAMS, SIAC, HKIAC). For ad hoc proceedings, this field may be null or indicate Ad Hoc.',
    `adr_administering_body` BIGINT COMMENT 'FK to court.tribunal.tribunal_id — ADR proceedings are administered by an institution (ICC, LCIA, AAA) which is stored as a tribunal record. Required for institutional rule application.',
    `adr_to_administering_body` BIGINT COMMENT 'FK to court.tribunal.tribunal_id — ADR proceedings are administered by a specific body (ICC, LCIA, AAA). The tribunal product covers arbitral bodies. Links ADR to its forum.',
    `adr_to_seat_jurisdiction` BIGINT COMMENT 'FK to court.court_jurisdiction.court_jurisdiction_id — ADR proceedings have a seat of arbitration which determines the governing jurisdiction for procedural matters and enforcement.',
    `adr_type` STRING COMMENT 'The type of ADR mechanism being used to resolve the dispute. Arbitration is binding; mediation is facilitative; expert determination involves a neutral expert; adjudication is common in construction disputes; conciliation is similar to mediation; dispute boards provide ongoing dispute resolution during long-term projects.. Valid values are `arbitration|mediation|expert_determination|adjudication|conciliation|dispute_board`',
    `award_amount` DECIMAL(18,2) COMMENT 'The monetary amount awarded by the tribunal in favor of the prevailing party. May be positive (in favor of claimant) or negative (in favor of respondent if counterclaim succeeds). Excludes costs and interest unless specified. Confidential financial information.',
    `award_currency` STRING COMMENT 'The currency in which the award amount is denominated, using ISO 4217 three-letter currency code. Null if no award has been issued.. Valid values are `^[A-Z]{3}$`',
    `award_date` DATE COMMENT 'The date on which the final award was issued by the arbitral tribunal. For mediation, the date of the settlement agreement. Null if no award or settlement has been reached.',
    `case_reference_number` STRING COMMENT 'External case or proceeding reference number assigned by the administering institution or by the parties. This is the business identifier used in correspondence and filings.',
    `claim_amount` DECIMAL(18,2) COMMENT 'The monetary value of the claim as stated by the claimant in the notice of arbitration or statement of claim. Excludes interest, costs, and fees unless explicitly included in the claim. Confidential financial information.',
    `claim_currency` STRING COMMENT 'The currency in which the claim amount is denominated, using ISO 4217 three-letter currency code (e.g., USD, GBP, EUR, CHF).. Valid values are `^[A-Z]{3}$`',
    `claimant_party_name` STRING COMMENT 'The name of the claimant party (or parties) initiating the ADR proceeding. May be a single entity or multiple co-claimants. Confidential business information.',
    `commencement_date` DATE COMMENT 'The date on which the ADR proceeding was formally commenced, typically the date the notice of arbitration or request for mediation was filed with the administering institution or served on the respondent.',
    `confidentiality_level` STRING COMMENT 'The level of confidentiality applicable to the ADR proceeding. Public: no confidentiality restrictions. Confidential: standard confidentiality per institutional rules. Highly confidential: enhanced confidentiality by agreement. Sealed: court-ordered sealing or equivalent. Most arbitrations are confidential by default.. Valid values are `public|confidential|highly_confidential|sealed`',
    `costs_awarded_to_claimant` DECIMAL(18,2) COMMENT 'The amount of legal costs and expenses awarded to the claimant by the tribunal. Null if no costs award has been made or if costs were awarded to respondent. Confidential financial information.',
    `costs_awarded_to_respondent` DECIMAL(18,2) COMMENT 'The amount of legal costs and expenses awarded to the respondent by the tribunal. Null if no costs award has been made or if costs were awarded to claimant. Confidential financial information.',
    `counterclaim_amount` DECIMAL(18,2) COMMENT 'The monetary value of any counterclaim filed by the respondent. Null if no counterclaim has been filed. Confidential financial information.',
    `counterclaim_currency` STRING COMMENT 'The currency in which the counterclaim amount is denominated, using ISO 4217 three-letter currency code. Null if no counterclaim exists.. Valid values are `^[A-Z]{3}$`',
    `dispute_subject_matter` STRING COMMENT 'A brief description of the subject matter of the dispute (e.g., breach of contract, intellectual property infringement, construction delay, shareholder dispute, M&A dispute). Confidential business information.',
    `emergency_arbitrator_appointed_flag` BOOLEAN COMMENT 'Indicates whether an emergency arbitrator was appointed under the institutional rules to grant urgent interim relief before the tribunal is constituted. True if emergency arbitrator appointed; False otherwise.',
    `enforcement_jurisdiction` STRING COMMENT 'The country or jurisdiction in which enforcement of the award is being sought or has been obtained. May be multiple jurisdictions if enforcement is pursued in multiple countries. Null if no enforcement action has been initiated.',
    `enforcement_status` STRING COMMENT 'The status of enforcement of the arbitral award. Not applicable: no award issued or settlement reached voluntarily. Pending: award issued, enforcement not yet initiated. In progress: enforcement proceedings underway. Enforced: award successfully enforced. Challenged: enforcement challenged by losing party. Set aside: award set aside by competent court. Refused: enforcement refused by court. [ENUM-REF-CANDIDATE: not_applicable|pending|in_progress|enforced|challenged|set_aside|refused — 7 candidates stripped; promote to reference product]',
    `first_hearing_date` DATE COMMENT 'The date of the first substantive hearing or procedural conference in the ADR proceeding. Null if no hearing has been scheduled or held.',
    `governing_law` STRING COMMENT 'The substantive law governing the merits of the dispute (e.g., English law, New York law, Swiss law). Distinct from the procedural law, which is determined by the seat of arbitration.',
    `governing_rules` STRING COMMENT 'The procedural rules governing the ADR proceeding (e.g., ICC Arbitration Rules 2021, LCIA Arbitration Rules 2020, UNCITRAL Arbitration Rules 2013, AAA Commercial Arbitration Rules). Includes version year where applicable.',
    `interim_measures_granted_flag` BOOLEAN COMMENT 'Indicates whether the tribunal or emergency arbitrator granted interim measures (provisional relief) during the proceeding, such as injunctions, asset freezes, or orders for security for costs. True if interim measures granted; False otherwise.',
    `lead_counsel_firm` STRING COMMENT 'The name of the law firm representing the client (claimant or respondent) as lead counsel in the ADR proceeding. Confidential business information.',
    `number_of_arbitrators` STRING COMMENT 'The number of arbitrators constituting the tribunal. Typically 1 (sole arbitrator) or 3 (panel). Occasionally 5 or more for complex multi-party disputes. Null for non-arbitration ADR types.',
    `opposing_counsel_firm` STRING COMMENT 'The name of the law firm representing the opposing party in the ADR proceeding. Confidential business information.',
    `place_of_hearing` STRING COMMENT 'The physical or virtual location where hearings are conducted. May differ from the seat of arbitration. Can include multiple locations or indicate Virtual for remote hearings.',
    `proceeding_status` STRING COMMENT 'Current lifecycle status of the ADR proceeding. Initiated: proceeding has been commenced. Constituted: tribunal or mediator appointed. Ongoing: active proceedings. Suspended: temporarily paused. Settled: parties reached agreement. Award issued: final decision rendered. Terminated: proceeding ended without award. Enforcement pending: award issued, enforcement in progress. Enforced: award successfully enforced. [ENUM-REF-CANDIDATE: initiated|constituted|ongoing|suspended|settled|award_issued|terminated|enforcement_pending|enforced — 9 candidates stripped; promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this ADR proceeding record was first created in the system. Audit trail field for data governance and lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this ADR proceeding record was last updated in the system. Audit trail field for data governance and lineage tracking.',
    `respondent_party_name` STRING COMMENT 'The name of the respondent party (or parties) against whom the ADR proceeding is brought. May be a single entity or multiple co-respondents. Confidential business information.',
    `seat_of_arbitration` STRING COMMENT 'The legal seat (juridical seat) of the arbitration, which determines the procedural law and supervisory court jurisdiction. Typically a city and country (e.g., London, United Kingdom; New York, USA; Singapore). Critical for enforcement under the New York Convention.',
    `settlement_date` DATE COMMENT 'The date on which the parties executed a settlement agreement, if applicable. Null if no settlement was reached.',
    `settlement_reached_flag` BOOLEAN COMMENT 'Indicates whether the parties reached a settlement during the ADR proceeding, resulting in termination of the proceeding by consent. True if settlement reached; False otherwise.',
    `termination_date` DATE COMMENT 'The date on which the ADR proceeding was formally terminated, whether by award, settlement, withdrawal, or other means. Null if the proceeding is still ongoing.',
    `termination_reason` STRING COMMENT 'The reason for termination of the ADR proceeding. Award issued: tribunal rendered final award. Settlement: parties reached agreement. Withdrawal: claimant withdrew claim. Lack of prosecution: proceeding terminated due to inactivity. Jurisdictional objection sustained: tribunal declined jurisdiction. Other: other reasons.. Valid values are `award_issued|settlement|withdrawal|lack_of_prosecution|jurisdictional_objection_sustained|other`',
    `tribunal_constitution_date` DATE COMMENT 'The date on which the arbitral tribunal was fully constituted (all arbitrators appointed and confirmed). For mediation, the date the mediator was appointed. Null if not yet constituted.',
    `underlying_contract_type` STRING COMMENT 'The type of contract or agreement that is the subject of the dispute (e.g., Share Purchase Agreement (SPA), Joint Venture Agreement, Construction Contract, License Agreement, Distribution Agreement, Employment Agreement). Null if dispute does not arise from a contract.',
    CONSTRAINT pk_adr_proceeding PRIMARY KEY(`adr_proceeding_id`)
) COMMENT 'Master record for Alternative Dispute Resolution proceedings including mediation, arbitration (ICC, LCIA, AAA, JAMS), and expert determination. Captures ADR type, administering institution, seat of arbitration, governing rules version, number of arbitrators, arbitrator appointment dates, claimant and respondent references, claim amount, currency, commencement date, award date, and enforcement status. Distinct from court dockets — ADR proceedings follow separate procedural rules and timelines.';

CREATE OR REPLACE TABLE `legal_ecm_v1`.`court`.`arbitral_award` (
    `arbitral_award_id` BIGINT COMMENT 'Unique identifier for the arbitral award record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: Arbitral awards often require trust accounts for holding award payments pending enforcement, satisfaction, or appeal. Attorneys must track which trust account holds arbitral award proceeds for client ',
    `indemnity_claim_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_claim. Business justification: Arbitral awards in indemnity matters determine payout and closure; essential for claims management, insurer settlement, and regulatory compliance.',
    `indemnity_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.indemnity_exposure. Business justification: Adverse arbitral awards can trigger professional indemnity claims, particularly in international arbitration. Essential for reserve setting and insurer notification in arbitration practice.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Arbitral awards are legal documents requiring secure storage, confidentiality controls, and retention management; link connects award records to document files for enforcement proceedings and New York',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this arbitral award pertains.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Significant arbitration awards, especially published ones, serve as precedents for future ADR proceedings. Captures institutional knowledge from alternative dispute resolution, enables arbitration str',
    `adr_proceeding_id` BIGINT COMMENT 'FK to court.adr_proceeding.adr_proceeding_id — Arbitral awards are issued in connection with a specific ADR proceeding. This is the parent-child relationship between the proceeding and its outcome.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.client_profile. Business justification: Arbitral awards directly impact clients financially and operationally. Linking enables financial outcome tracking, enforcement planning, client reporting on award status, and portfolio analysis of arb',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: Arbitral awards in regulatory disputes determine financial exposure and compliance obligations; critical for breach incident closure and regulatory reporting.',
    `adr_mechanism` STRING COMMENT 'The specific ADR mechanism under which this award was issued.. Valid values are `arbitration|mediation|conciliation|expert_determination|adjudication`',
    `arbitral_institution` STRING COMMENT 'The name of the arbitral institution administering the arbitration (e.g., ICC, LCIA, AAA, SIAC) or indication of ad hoc arbitration.',
    `award_reference_number` STRING COMMENT 'The official reference or case number assigned to this arbitral award by the arbitral institution or tribunal.',
    `award_status` STRING COMMENT 'Current lifecycle status of the arbitral award reflecting enforcement and challenge proceedings. [ENUM-REF-CANDIDATE: issued|challenged|upheld|set_aside|enforced|partially_enforced|recognition_pending — 7 candidates stripped; promote to reference product]',
    `award_summary` STRING COMMENT 'A concise summary of the key findings, rulings, and relief granted in the arbitral award.',
    `award_type` STRING COMMENT 'Classification of the arbitral award indicating its nature and finality within the arbitration proceeding.. Valid values are `final|partial|interim|consent|additional|correction`',
    `awarded_amount` DECIMAL(18,2) COMMENT 'The principal monetary amount awarded to the prevailing party, excluding interest and costs.',
    `challenge_filed_flag` BOOLEAN COMMENT 'Indicates whether a challenge or application to set aside the award has been filed by any party.',
    `challenge_filing_date` DATE COMMENT 'The date on which a challenge or set-aside application was filed against the award.',
    `challenge_grounds` STRING COMMENT 'Description of the legal grounds cited for challenging or setting aside the arbitral award.',
    `challenge_outcome` STRING COMMENT 'The outcome or current status of the challenge proceedings against the award.. Valid values are `pending|dismissed|upheld|partially_upheld|withdrawn`',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether the arbitral award is subject to confidentiality obligations restricting disclosure.',
    `cost_allocation_basis` STRING COMMENT 'Description of the basis or rationale used by the tribunal for allocating costs between parties (e.g., costs follow the event, proportional allocation).',
    `costs_awarded_to_claimant` DECIMAL(18,2) COMMENT 'The amount of arbitration costs and legal fees awarded to the claimant party.',
    `costs_awarded_to_respondent` DECIMAL(18,2) COMMENT 'The amount of arbitration costs and legal fees awarded to the respondent party.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this arbitral award record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the awarded amount.. Valid values are `^[A-Z]{3}$`',
    `document_reference` STRING COMMENT 'Reference to the full arbitral award document stored in the document management system (DMS).',
    `enforcement_jurisdiction` STRING COMMENT 'The jurisdiction or country where enforcement of the award is being sought or has been granted.',
    `enforcement_order_date` DATE COMMENT 'The date on which the enforcement or recognition order was issued by the competent court.',
    `enforcement_order_reference` STRING COMMENT 'Reference number or citation of the court order granting enforcement or recognition of the arbitral award.',
    `governing_law` STRING COMMENT 'The substantive law applied by the tribunal to resolve the dispute.',
    `interest_calculation_method` STRING COMMENT 'The method specified for calculating interest on the awarded amount.. Valid values are `simple|compound|statutory|contractual`',
    `interest_provision_flag` BOOLEAN COMMENT 'Indicates whether the award includes provisions for interest on the awarded amount.',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate percentage awarded, if applicable.',
    `interest_start_date` DATE COMMENT 'The date from which interest begins to accrue on the awarded amount.',
    `issue_date` DATE COMMENT 'The date on which the arbitral tribunal issued and signed the award.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this arbitral award record was last updated or modified.',
    `matter_closure_trigger_flag` BOOLEAN COMMENT 'Indicates whether the issuance of this award triggers closure of the associated legal matter.',
    `new_york_convention_applicable_flag` BOOLEAN COMMENT 'Indicates whether the award is subject to the New York Convention on the Recognition and Enforcement of Foreign Arbitral Awards, facilitating international enforcement.',
    `notes` STRING COMMENT 'Free-text field for internal notes, observations, or strategic considerations related to the arbitral award and its enforcement.',
    `notification_date` DATE COMMENT 'The date on which the parties were formally notified of the arbitral award.',
    `presiding_arbitrator_name` STRING COMMENT 'Full name of the presiding arbitrator or sole arbitrator who issued the award.',
    `publication_permitted_flag` BOOLEAN COMMENT 'Indicates whether the award may be published in redacted or anonymized form for legal research or precedent purposes.',
    `seat_of_arbitration` STRING COMMENT 'The legal seat or place of arbitration which determines the procedural law governing the arbitration.',
    `tribunal_composition` STRING COMMENT 'Description of the arbitral tribunal composition including number of arbitrators and their appointment method (e.g., sole arbitrator, three-member panel).',
    CONSTRAINT pk_arbitral_award PRIMARY KEY(`arbitral_award_id`)
) COMMENT 'Records final and interim awards issued in arbitration and ADR proceedings. Stores award type (final, partial, interim, consent), issue date, arbitral tribunal composition, awarded amount, currency, interest provisions, cost allocation, enforcement jurisdiction, New York Convention applicability flag, challenge status, and enforcement order reference. Supports post-award enforcement strategy and matter closure.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ADD CONSTRAINT `fk_court_arbitral_award_adr_proceeding_id` FOREIGN KEY (`adr_proceeding_id`) REFERENCES `legal_ecm_v1`.`court`.`adr_proceeding`(`adr_proceeding_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm_v1`.`court` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `legal_ecm_v1`.`court` SET TAGS ('dbx_domain' = 'court');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` SET TAGS ('dbx_subdomain' = 'matter');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` SET TAGS ('dbx_domain' = 'matter');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_of_process_id` SET TAGS ('dbx_business_glossary_term' = 'Service of Process ID');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Proof of Service Document ID');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `privacy_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `attempted_service_count` SET TAGS ('dbx_business_glossary_term' = 'Attempted Service Count');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `central_authority_reference` SET TAGS ('dbx_business_glossary_term' = 'Central Authority Reference');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `compliance_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline Date');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `ecf_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Filing Reference');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `esi_ediscovery_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronically Stored Information (ESI) / eDiscovery Flag');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `hague_convention_flag` SET TAGS ('dbx_business_glossary_term' = 'Hague Convention Flag');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_dbx_pii' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `objection_date` SET TAGS ('dbx_business_glossary_term' = 'Objection Date');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `objection_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Objection Filed Flag');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `objection_reason` SET TAGS ('dbx_business_glossary_term' = 'Objection Reason');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `pacer_case_number` SET TAGS ('dbx_business_glossary_term' = 'Public Access to Court Electronic Records (PACER) Case Number');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `party_served_name` SET TAGS ('dbx_business_glossary_term' = 'Party Served Name');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `party_served_name` SET TAGS ('dbx_dbx_restricted' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `party_served_name` SET TAGS ('dbx_dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `party_served_role` SET TAGS ('dbx_business_glossary_term' = 'Party Served Role');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `process_server_license_number` SET TAGS ('dbx_business_glossary_term' = 'Process Server License Number');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `process_server_name` SET TAGS ('dbx_business_glossary_term' = 'Process Server Name');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `proof_of_service_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Proof of Service Filed Date');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 1');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_city` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_city` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Cost Amount');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Service Cost Currency Code');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_country_code` SET TAGS ('dbx_business_glossary_term' = 'Service Country Code');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_docket` SET TAGS ('dbx_business_glossary_term' = 'Service Docket');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_method` SET TAGS ('dbx_business_glossary_term' = 'Service Method');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_notes` SET TAGS ('dbx_business_glossary_term' = 'Service Notes');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Service Postal Code');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Service Reference Number');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_state_province` SET TAGS ('dbx_business_glossary_term' = 'Service State or Province');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|returned_unserved|quashed');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_time` SET TAGS ('dbx_business_glossary_term' = 'Service Timestamp');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_to_docket` SET TAGS ('dbx_business_glossary_term' = 'Service To Docket');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_validity_status` SET TAGS ('dbx_business_glossary_term' = 'Service Validity Status');
ALTER TABLE `legal_ecm_v1`.`court`.`service_of_process` ALTER COLUMN `service_validity_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|pending_validation|quashed|objected');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` SET TAGS ('dbx_subdomain' = 'matter');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` SET TAGS ('dbx_domain' = 'matter');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `adr_proceeding_id` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Proceeding Identifier');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `practice_note_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Note Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `administering_institution` SET TAGS ('dbx_business_glossary_term' = 'Administering Institution');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `adr_administering_body` SET TAGS ('dbx_business_glossary_term' = 'Adr Administering Body');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `adr_to_administering_body` SET TAGS ('dbx_business_glossary_term' = 'Adr To Administering Body');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `adr_to_seat_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Adr To Seat Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `adr_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Type');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `adr_type` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|expert_determination|adjudication|conciliation|dispute_board');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `award_amount` SET TAGS ('dbx_business_glossary_term' = 'Award Amount');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `award_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `award_currency` SET TAGS ('dbx_business_glossary_term' = 'Award Currency');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `award_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `case_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Case Reference Number');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `claim_amount` SET TAGS ('dbx_business_glossary_term' = 'Claim Amount');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `claim_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `claim_currency` SET TAGS ('dbx_business_glossary_term' = 'Claim Currency');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `claim_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `claimant_party_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant Party Name');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `claimant_party_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Commencement Date');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|confidential|highly_confidential|sealed');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `costs_awarded_to_claimant` SET TAGS ('dbx_business_glossary_term' = 'Costs Awarded to Claimant');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `costs_awarded_to_claimant` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `costs_awarded_to_respondent` SET TAGS ('dbx_business_glossary_term' = 'Costs Awarded to Respondent');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `costs_awarded_to_respondent` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `counterclaim_amount` SET TAGS ('dbx_business_glossary_term' = 'Counterclaim Amount');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `counterclaim_amount` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `counterclaim_currency` SET TAGS ('dbx_business_glossary_term' = 'Counterclaim Currency');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `counterclaim_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `dispute_subject_matter` SET TAGS ('dbx_business_glossary_term' = 'Dispute Subject Matter');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `dispute_subject_matter` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `emergency_arbitrator_appointed_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Arbitrator Appointed Flag');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `enforcement_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Status');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `first_hearing_date` SET TAGS ('dbx_business_glossary_term' = 'First Hearing Date');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `governing_rules` SET TAGS ('dbx_business_glossary_term' = 'Governing Rules');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `interim_measures_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Interim Measures Granted Flag');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `lead_counsel_firm` SET TAGS ('dbx_business_glossary_term' = 'Lead Counsel Firm');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `lead_counsel_firm` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `number_of_arbitrators` SET TAGS ('dbx_business_glossary_term' = 'Number of Arbitrators');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `opposing_counsel_firm` SET TAGS ('dbx_business_glossary_term' = 'Opposing Counsel Firm');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `opposing_counsel_firm` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `place_of_hearing` SET TAGS ('dbx_business_glossary_term' = 'Place of Hearing');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `proceeding_status` SET TAGS ('dbx_business_glossary_term' = 'Proceeding Status');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `respondent_party_name` SET TAGS ('dbx_business_glossary_term' = 'Respondent Party Name');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `respondent_party_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `seat_of_arbitration` SET TAGS ('dbx_business_glossary_term' = 'Seat of Arbitration');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `settlement_reached_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reached Flag');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'award_issued|settlement|withdrawal|lack_of_prosecution|jurisdictional_objection_sustained|other');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `tribunal_constitution_date` SET TAGS ('dbx_business_glossary_term' = 'Tribunal Constitution Date');
ALTER TABLE `legal_ecm_v1`.`court`.`adr_proceeding` ALTER COLUMN `underlying_contract_type` SET TAGS ('dbx_business_glossary_term' = 'Underlying Contract Type');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` SET TAGS ('dbx_subdomain' = 'matter');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` SET TAGS ('dbx_domain' = 'matter');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `arbitral_award_id` SET TAGS ('dbx_business_glossary_term' = 'Arbitral Award Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `indemnity_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Exposure Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `adr_proceeding_id` SET TAGS ('dbx_business_glossary_term' = 'Adr Proceeding Id');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `adr_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Mechanism');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `adr_mechanism` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|conciliation|expert_determination|adjudication');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `arbitral_institution` SET TAGS ('dbx_business_glossary_term' = 'Arbitral Institution');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `award_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Award Reference Number');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `award_summary` SET TAGS ('dbx_business_glossary_term' = 'Award Summary');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `award_summary` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `award_type` SET TAGS ('dbx_business_glossary_term' = 'Award Type');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `award_type` SET TAGS ('dbx_value_regex' = 'final|partial|interim|consent|additional|correction');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `awarded_amount` SET TAGS ('dbx_business_glossary_term' = 'Awarded Amount');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `challenge_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Challenge Filed Flag');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `challenge_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Challenge Filing Date');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `challenge_grounds` SET TAGS ('dbx_business_glossary_term' = 'Challenge Grounds');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `challenge_outcome` SET TAGS ('dbx_business_glossary_term' = 'Challenge Outcome');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `challenge_outcome` SET TAGS ('dbx_value_regex' = 'pending|dismissed|upheld|partially_upheld|withdrawn');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `cost_allocation_basis` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Basis');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `costs_awarded_to_claimant` SET TAGS ('dbx_business_glossary_term' = 'Costs Awarded to Claimant');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `costs_awarded_to_respondent` SET TAGS ('dbx_business_glossary_term' = 'Costs Awarded to Respondent');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `enforcement_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Jurisdiction');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `enforcement_order_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Order Date');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `enforcement_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Order Reference');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Calculation Method');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `interest_calculation_method` SET TAGS ('dbx_value_regex' = 'simple|compound|statutory|contractual');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `interest_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Interest Provision Flag');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `interest_start_date` SET TAGS ('dbx_business_glossary_term' = 'Interest Start Date');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Award Issue Date');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `matter_closure_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Matter Closure Trigger Flag');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `new_york_convention_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'New York Convention Applicable Flag');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `notes` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Award Notification Date');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `presiding_arbitrator_name` SET TAGS ('dbx_business_glossary_term' = 'Presiding Arbitrator Name');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `presiding_arbitrator_name` SET TAGS ('dbx_dbx_confidential' = 'true');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `publication_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Publication Permitted Flag');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `seat_of_arbitration` SET TAGS ('dbx_business_glossary_term' = 'Seat of Arbitration');
ALTER TABLE `legal_ecm_v1`.`court`.`arbitral_award` ALTER COLUMN `tribunal_composition` SET TAGS ('dbx_business_glossary_term' = 'Arbitral Tribunal Composition');
