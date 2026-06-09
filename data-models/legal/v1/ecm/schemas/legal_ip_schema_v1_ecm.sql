-- Schema for Domain: ip | Business: Legal | Version: v1_ecm
-- Generated on: 2026-05-07 11:59:01

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm`.`ip` COMMENT 'Manages the intellectual property portfolio lifecycle including patent prosecution (PCT, PPH), trademark registration, copyright registration, trade secrets, licensing, FRAND obligations, and IP docketing deadlines. Serves as SSOT for all IP assets, annuity payments, portfolio valuation, and IP ownership records across all jurisdictions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`ip_asset` (
    `ip_asset_id` BIGINT COMMENT 'Unique identifier for the intellectual property asset. Primary key for the IP asset master record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: IP assets frequently require dedicated trust accounts for holding annuity payments, licensing royalties, settlement proceeds, or security deposits. Essential for tracking fund sources for IP maintenan',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the attorney or legal professional responsible for managing the prosecution and maintenance of this IP asset.',
    `knowledge_asset_id` BIGINT COMMENT 'Foreign key linking to knowledge.knowledge_asset. Business justification: IP assets frequently reference the knowledge precedent, template, or form used during their creation, filing, or prosecution. Enables tracking which knowledge assets were leveraged for specific IP fil',
    `matter_id` BIGINT COMMENT 'Identifier of the matter under which this IP asset is managed.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: IP assets are managed within specific practice areas (patent prosecution, trademark, IP litigation) for resource allocation, conflict checking, and practice-level portfolio reporting. Essential for pr',
    `profile_id` BIGINT COMMENT 'Identifier of the client who owns this intellectual property asset.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: IP assets generate inherent risks (infringement exposure, invalidity challenges, loss of rights through missed deadlines, valuation uncertainty) that legal teams track in risk registers for portfolio ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: IP assets (patents, trademarks) are subject to jurisdiction-specific regulatory obligations including filing requirements, annuity deadlines, disclosure rules, and recordal obligations. Essential for ',
    `annuity_amount` DECIMAL(18,2) COMMENT 'Monetary amount due for the next annuity or maintenance fee payment.',
    `annuity_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the annuity payment amount.. Valid values are `^[A-Z]{3}$`',
    `annuity_due_date` DATE COMMENT 'Next scheduled date for payment of maintenance fees or annuities to keep the IP asset in force.',
    `application_number` STRING COMMENT 'Official application number assigned by the intellectual property office upon filing.',
    `asset_number` STRING COMMENT 'Business-facing unique identifier or reference number for the IP asset, often used in client communications and docketing systems.',
    `asset_type` STRING COMMENT 'Classification of the intellectual property asset type.. Valid values are `patent|trademark|copyright|trade_secret|design_right|plant_variety`',
    `classification_code` STRING COMMENT 'International Patent Classification (IPC), Cooperative Patent Classification (CPC), or Nice Classification code assigned to the IP asset.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for the IP asset information.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the IP asset record was first created in the system.',
    `docketing_system_code` STRING COMMENT 'External identifier used in the IP docketing or deadline management system for tracking prosecution milestones.',
    `document_repository_path` STRING COMMENT 'File path or URI reference to the location in the document management system (DMS) where IP asset documents are stored.',
    `expiration_date` DATE COMMENT 'Date on which the intellectual property protection expires, subject to maintenance fee payments and renewals.',
    `filing_date` DATE COMMENT 'Date on which the intellectual property application was officially filed with the relevant IP office.',
    `frand_declaration_flag` BOOLEAN COMMENT 'Indicates whether the IP asset is subject to a FRAND declaration to a standards-setting organization.',
    `inventor_names` STRING COMMENT 'Comma-separated list of inventor names credited on the patent or IP asset application.',
    `ip_asset_description` STRING COMMENT 'Detailed business description of the intellectual property asset, including its purpose, scope, and key features.',
    `ip_asset_status` STRING COMMENT 'Current lifecycle status of the intellectual property asset in the prosecution or registration process. [ENUM-REF-CANDIDATE: pending|registered|granted|abandoned|expired|lapsed|opposed|cancelled — 8 candidates stripped; promote to reference product]',
    `ip_office_name` STRING COMMENT 'Name of the intellectual property office or authority responsible for examining and granting the IP asset (e.g., USPTO, EPO, JPO).',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code or regional code representing the jurisdiction where the IP asset is filed or registered.',
    `licensing_status` STRING COMMENT 'Current licensing arrangement status for the IP asset, including Fair Reasonable and Non-Discriminatory (FRAND) commitments.. Valid values are `not_licensed|exclusively_licensed|non_exclusively_licensed|cross_licensed|frand_committed`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the IP asset record was last modified or updated.',
    `opposition_filed_flag` BOOLEAN COMMENT 'Indicates whether a third-party opposition or challenge has been filed against the IP asset.',
    `owner_name` STRING COMMENT 'Legal name of the entity or individual who holds ownership rights to the intellectual property asset.',
    `pct_application_flag` BOOLEAN COMMENT 'Indicates whether the IP asset was filed under the Patent Cooperation Treaty (PCT) international application process.',
    `portfolio_category` STRING COMMENT 'Business classification or grouping of the IP asset within the clients portfolio (e.g., core technology, defensive, licensing).',
    `pph_request_flag` BOOLEAN COMMENT 'Indicates whether a Patent Prosecution Highway (PPH) request has been filed to accelerate examination based on a related application.',
    `priority_date` DATE COMMENT 'Earliest filing date claimed for priority purposes under the Paris Convention or Patent Cooperation Treaty (PCT).',
    `registration_date` DATE COMMENT 'Date on which the intellectual property asset was officially registered or granted by the IP office.',
    `registration_number` STRING COMMENT 'Official registration or grant number assigned by the intellectual property office upon approval.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which the IP asset data originated (e.g., Elite 3E, external IP management system).',
    `subtype` STRING COMMENT 'Further classification within the asset type, such as utility patent, design patent, word mark, logo mark, sound mark, etc.',
    `technology_area` STRING COMMENT 'Broad technology or industry domain to which the IP asset relates (e.g., pharmaceuticals, software, telecommunications).',
    `title` STRING COMMENT 'The official title or name of the intellectual property asset as registered or filed.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Estimated or appraised monetary value of the intellectual property asset for portfolio management and financial reporting.',
    `valuation_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the valuation amount.. Valid values are `^[A-Z]{3}$`',
    `valuation_date` DATE COMMENT 'Date on which the IP asset valuation was performed or last updated.',
    CONSTRAINT pk_ip_asset PRIMARY KEY(`ip_asset_id`)
) COMMENT 'Master record for every intellectual property asset managed by the firm on behalf of clients, including patents, trademarks, copyrights, trade secrets, and design rights. Serves as the SSOT for IP asset identity, type, status, jurisdiction, ownership, filing dates, registration numbers, and portfolio classification. Anchors all downstream IP lifecycle, docketing, annuity, and licensing records.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`patent` (
    `patent_id` BIGINT COMMENT 'Unique identifier for the patent asset record. Primary key for the patent data product.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney (timekeeper) who is primarily responsible for prosecuting this patent and managing client communications.',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Patents filed as part of engagement opportunities (e.g., patent portfolio development engagements) require linkage for origination credit allocation, engagement scope tracking, and business developmen',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Patent infringement and validity litigation requires direct tracking from patent to court docket. Essential for monitoring enforcement actions, calculating patent portfolio risk, and coordinating pros',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this patent prosecution work is managed. Links patent activities to time tracking, billing, and case management.',
    `patent_family_id` BIGINT COMMENT 'FK to ip.patent_family.patent_family_id — Patents belong to patent families sharing common priority. Essential for coordinated prosecution strategy and portfolio landscape analysis.',
    `ip_asset_id` BIGINT COMMENT 'Reference to the parent IP asset record. Links this patent to the broader IP asset portfolio.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Patents are managed by patent prosecution practice groups. Required for practice-level revenue reporting, staffing models, and expertise-based matter routing in legal practice management systems.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Patent applications and prosecution documents often cite specific precedent templates (claims language, specification sections) used during drafting. Critical for tracking precedent effectiveness, cla',
    `primary_patent_family_id` BIGINT COMMENT 'Identifier linking this patent to its patent family - a group of related patent applications filed in multiple jurisdictions claiming the same priority. Enables portfolio-level analysis and management.',
    `profile_id` BIGINT COMMENT 'Reference to the client who owns or is associated with this patent asset. Links the patent to the client master record for billing, matter management, and portfolio reporting.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Patents face prosecution risks (rejection, abandonment), opposition risks, invalidity challenges, and enforcement risks. Legal teams track these in risk registers for client advisories, portfolio stra',
    `to_ip_asset_id` BIGINT COMMENT 'FK to ip.ip_asset.ip_asset_id — Patent extends ip_asset — every patent record MUST reference its parent ip_asset record. This is the fundamental inheritance/extension FK that connects the type-specific detail to the master asset rec',
    `to_patent_family_id` BIGINT COMMENT 'FK to ip.patent_family.patent_family_id — Every patent belongs to a patent family (or is a singleton family). This FK enables family-level portfolio analysis and prosecution strategy.',
    `abstract` STRING COMMENT 'A concise summary of the invention disclosed in the patent, typically 150-250 words, providing a high-level overview of the technical problem and solution.',
    `agent_name` STRING COMMENT 'The name of the registered patent agent or patent attorney who is prosecuting the patent application before the patent office.',
    `annuity_due_date` DATE COMMENT 'The next scheduled date for payment of patent maintenance fees (annuities) to keep the patent in force. Missing this deadline can result in patent lapse.',
    `annuity_payment_status` STRING COMMENT 'Current status of the patent maintenance fee (annuity) payment. Tracks whether fees are current, overdue, or if the patent has lapsed due to non-payment.. Valid values are `current|overdue|paid|waived|lapsed`',
    `application_number` STRING COMMENT 'The official application number assigned when the patent application was filed (e.g., US16/123,456, PCT/US2020/012345).',
    `assignee_name` STRING COMMENT 'The current legal owner of the patent rights. This is typically the organization or individual to whom the inventors have assigned their rights.',
    `assignment_chain` STRING COMMENT 'A chronological record of all ownership transfers (assignments) of the patent rights, tracking the chain of title from original assignee to current owner.',
    `cpc_classification_codes` STRING COMMENT 'Classification codes assigned under the Cooperative Patent Classification system, jointly developed by the EPO and USPTO. Provides more granular technology classification than IPC.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this patent record was first created in the system. Used for audit trail and data lineage tracking.',
    `estimated_portfolio_value` DECIMAL(18,2) COMMENT 'The estimated monetary value of this patent asset based on valuation methodologies such as cost approach, market approach, or income approach. Used for portfolio management and financial reporting.',
    `examiner_name` STRING COMMENT 'The name of the patent office examiner who examined the patent application.',
    `expiry_date` DATE COMMENT 'The date the patent protection expires, typically 20 years from the filing date for utility patents, after which the invention enters the public domain.',
    `extends_asset` BIGINT COMMENT 'FK to ip.asset.asset_id — Patent is a subtype extension of the ip_asset master. Every patent record MUST reference its parent asset record for portfolio-level queries, ownership inheritance, and docketing. This is the core inh',
    `filing_date` DATE COMMENT 'The date the patent application was officially filed with the patent office. This date establishes priority rights and is critical for determining patent term.',
    `frand_obligation_flag` BOOLEAN COMMENT 'Indicates whether this patent is subject to FRAND licensing obligations, typically because it is essential to a technical standard. FRAND patents must be licensed on fair, reasonable, and non-discriminatory terms.',
    `grant_date` DATE COMMENT 'The date the patent was officially granted by the patent office, conferring exclusive rights to the patent holder.',
    `independent_claims_count` STRING COMMENT 'The number of independent claims in the patent. Independent claims stand alone and define the broadest scope of protection, making them particularly valuable for enforcement.',
    `inventor_id` BIGINT COMMENT 'Foreign key linking to ip.inventor. Business justification: Patents are created by inventors - this is a fundamental 1:N relationship (one inventor can be named on many patents, but for normalization we create the FK from patent to inventor). The patent table ',
    `ipc_classification_codes` STRING COMMENT 'Hierarchical classification codes assigned to the patent based on the International Patent Classification system. Multiple codes may be present, separated by semicolons (e.g., H04L29/06; G06F21/60).',
    `jurisdiction_code` STRING COMMENT 'The country or regional patent office jurisdiction where this patent is filed or granted (e.g., US, EP, JP, CN). Uses ISO 3166-1 alpha-2 country codes or regional office codes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this patent record was last updated in the system. Used for audit trail and change tracking.',
    `licensing_status` STRING COMMENT 'Current licensing availability and status of the patent. Indicates whether the patent is available for licensing, already licensed, or subject to exclusive or cross-licensing arrangements.. Valid values are `available|licensed|exclusively_licensed|cross_licensed|not_available`',
    `litigation_flag` BOOLEAN COMMENT 'Indicates whether this patent is currently involved in litigation, opposition, or other legal proceedings. Critical for risk assessment and portfolio management.',
    `original_assignee_name` STRING COMMENT 'The initial assignee of the patent at the time of filing or grant. Tracks the original owner before any subsequent assignments or transfers.',
    `patent_number` STRING COMMENT 'The official patent number assigned by the granting patent office (e.g., US10123456B2, EP3456789A1). This is the externally-known unique identifier for the granted patent.',
    `patent_type` STRING COMMENT 'The classification of patent: utility (functional inventions), design (ornamental designs), or plant (new plant varieties).. Valid values are `utility|design|plant`',
    `pct_application_number` STRING COMMENT 'The PCT international application number if this patent was filed under the Patent Cooperation Treaty, enabling a single application to seek protection in multiple jurisdictions.',
    `pph_eligible_flag` BOOLEAN COMMENT 'Indicates whether this patent application is eligible for accelerated examination under the Patent Prosecution Highway program, which allows applicants to fast-track examination based on positive results from another participating patent office.',
    `prior_art_references` STRING COMMENT 'A list of prior art references cited during patent examination that were considered relevant to patentability. Multiple references are separated by semicolons.',
    `priority_date` DATE COMMENT 'The earliest filing date claimed for this patent, which may be from a prior application (provisional, foreign, or parent application). Determines the effective date for prior art assessment.',
    `prosecution_status` STRING COMMENT 'Current lifecycle status of the patent in the prosecution process. Tracks the patent from initial drafting through grant, maintenance, or abandonment. [ENUM-REF-CANDIDATE: draft|filed|pending|published|granted|abandoned|expired|lapsed — 8 candidates stripped; promote to reference product]',
    `publication_date` DATE COMMENT 'The date the patent application was published and made publicly available, typically 18 months after the priority date.',
    `publication_number` STRING COMMENT 'The official publication number assigned when the patent application was published (typically 18 months after filing).',
    `standard_essential_patent_flag` BOOLEAN COMMENT 'Indicates whether this patent has been declared as essential to implementing a technical standard (e.g., telecommunications, wireless, video compression standards).',
    `title` STRING COMMENT 'The official title of the patent invention as recorded in the patent grant or application.',
    `total_claims_count` STRING COMMENT 'The total number of claims in the patent. Claims define the legal scope of patent protection and are critical for enforcement and valuation.',
    `valuation_date` DATE COMMENT 'The date on which the patent valuation was performed or last updated.',
    CONSTRAINT pk_patent PRIMARY KEY(`patent_id`)
) COMMENT 'Detailed master record for patent assets including utility, design, and plant patents. Captures patent-specific attributes such as PCT application number, PPH eligibility, claims count, independent claims, priority date, publication number, grant date, expiry date, patent family identifier, IPC/CPC classification codes, prosecution status, and assignee chain. Extends ip_asset for patent-specific prosecution and portfolio management.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`trademark` (
    `trademark_id` BIGINT COMMENT 'Unique identifier for the trademark asset. Primary key for the trademark product.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Trademark opposition, cancellation, and infringement litigation requires direct link from trademark to court docket. Essential for tracking TTAB proceedings that escalate to district court, monitoring',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this trademark prosecution is being handled. Links to Elite 3E matter management.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Trademarks are managed by trademark practice groups. Essential for practice-level billing allocation, capacity planning, and trademark-specific service delivery tracking in law firm operations.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Trademark applications reference standard precedent templates for goods/services descriptions, disclaimers, and filing statements. Enables tracking which precedents were used for specific trademark fi',
    `profile_id` BIGINT COMMENT 'Reference to the client who owns or is prosecuting this trademark. Essential for client matter management and billing.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Trademarks face opposition proceedings, cancellation actions, genericness challenges, and infringement risks. Legal teams track these risks for brand protection strategy, renewal decisions, and enforc',
    `ip_asset_id` BIGINT COMMENT 'FK to ip.ip_asset.ip_asset_id — Trademark extends ip_asset — every trademark record MUST reference its parent ip_asset record. Same inheritance pattern as patent.',
    `trademark_ip_asset_id` BIGINT COMMENT 'Reference to the parent IP asset record. Links this trademark to the broader IP portfolio management system.',
    `annuity_amount` DECIMAL(18,2) COMMENT 'The renewal or maintenance fee amount due for the next renewal period. Critical for IP portfolio budgeting and annuity payment management.',
    `annuity_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the annuity amount (e.g., USD, EUR, GBP).',
    `application_serial_number` STRING COMMENT 'The official serial number assigned by the trademark office upon filing. Unique identifier for the trademark application in the jurisdictions registry.',
    `attorney_docket_number` STRING COMMENT 'Internal docket or reference number assigned by the law firm for tracking this trademark matter. Links to internal matter management and billing systems.',
    `attorney_of_record` STRING COMMENT 'The name of the attorney or law firm representing the applicant/registrant in the trademark prosecution. Links to internal timekeeper records.',
    `color_claim` STRING COMMENT 'Description of any color(s) claimed as a feature of the trademark. Relevant for marks where color is a distinguishing element.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time this trademark record was first created in the system. Audit trail for record creation.',
    `disclaimer_text` STRING COMMENT 'Text of any disclaimer filed with the trademark application, disclaiming exclusive rights to certain descriptive or generic elements of the mark.',
    `expiration_date` DATE COMMENT 'The date the trademark registration will expire if not renewed. Typically 10 years from registration or last renewal in most jurisdictions.',
    `extends_asset` BIGINT COMMENT 'FK to ip.asset.asset_id — Trademark is a subtype extension of ip_asset. Every trademark record MUST reference its parent asset for portfolio management, ownership, and docketing integration.',
    `filing_basis` STRING COMMENT 'The legal basis under which the trademark application was filed (US-specific): actual use in commerce (Section 1(a)), intent to use (Section 1(b)), foreign application (Section 44(d)), or foreign registration (Section 44(e)).. Valid values are `use_in_commerce|intent_to_use|foreign_application|foreign_registration`',
    `filing_date` DATE COMMENT 'The date the trademark application was officially filed with the trademark office. Establishes priority date for the mark.',
    `first_use_anywhere_date` DATE COMMENT 'The date the trademark was first used anywhere in the world, regardless of jurisdiction. May predate use in commerce date.',
    `goods_services_description` STRING COMMENT 'Detailed description of the goods and/or services for which the trademark is registered or applied. Must conform to acceptable identification standards per the trademark office.',
    `jurisdiction_code` STRING COMMENT 'The country or regional trademark office code (ISO 3166-1 alpha-3) where this trademark is filed or registered (e.g., USA, GBR, EPO for EUIPO).',
    `madrid_designated_countries` STRING COMMENT 'Comma-separated list of country codes (ISO 3166-1 alpha-3) designated for protection under a Madrid Protocol international registration.',
    `madrid_protocol_indicator` BOOLEAN COMMENT 'Indicates whether this trademark was filed under the Madrid Protocol for international registration. True if filed via WIPO Madrid System.',
    `madrid_registration_number` STRING COMMENT 'The international registration number assigned by WIPO under the Madrid Protocol. Null if not a Madrid Protocol filing.',
    `mark_description` STRING COMMENT 'Detailed description of the trademark, especially for device marks, trade dress, or composite marks. Describes visual elements, colors, design features, and overall appearance.',
    `mark_text` STRING COMMENT 'The literal text of the trademark for word marks. Null for device marks or design-only marks. Core identifier for the trademark asset.',
    `mark_type` STRING COMMENT 'Classification of the trademark by its form: word mark (text only), device mark (logo/design), composite mark (text and design), trade dress (product appearance), certification mark, or collective mark.. Valid values are `word_mark|device_mark|composite_mark|trade_dress|certification_mark|collective_mark`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time this trademark record was last modified. Audit trail for record updates.',
    `multi_class_indicator` BOOLEAN COMMENT 'Indicates whether this trademark application covers multiple Nice Classification classes. True if filed under more than one class.',
    `nice_classification_codes` STRING COMMENT 'Comma-separated list of Nice Classification class numbers (1-45) under which the trademark is registered. Classes 1-34 cover goods; classes 35-45 cover services.',
    `opposition_period_end_date` DATE COMMENT 'The deadline by which third parties may file an opposition to the trademark application. Typically 30 days after publication in the Official Gazette (US) or similar publication.',
    `opposition_status` STRING COMMENT 'Status of any opposition proceedings filed against this trademark application. Tracks whether the mark is under challenge by third parties.. Valid values are `none|pending|sustained|dismissed`',
    `owner_address` STRING COMMENT 'The full address of the trademark owner as recorded in the trademark registry. Required for official correspondence and ownership verification.',
    `owner_name` STRING COMMENT 'The legal name of the trademark owner (registrant). May be an individual or organization. Critical for ownership records and portfolio valuation.',
    `portfolio_valuation_amount` DECIMAL(18,2) COMMENT 'The estimated financial value of this trademark asset as part of the overall IP portfolio. Used for portfolio management and financial reporting.',
    `priority_claim_country` STRING COMMENT 'The country code (ISO 3166-1 alpha-3) of the jurisdiction where the priority application was filed. Used for Paris Convention priority claims.',
    `priority_claim_date` DATE COMMENT 'The priority date claimed under the Paris Convention or other treaty, based on an earlier foreign filing. Establishes earlier effective filing date.',
    `registration_date` DATE COMMENT 'The date the trademark was officially registered by the trademark office. Null for pending or abandoned applications.',
    `registration_number` STRING COMMENT 'The official registration number issued by the trademark office upon successful registration. Null for pending or abandoned applications.',
    `renewal_due_date` DATE COMMENT 'The next deadline for renewing the trademark registration to maintain its active status. Critical for IP docketing and annuity payment management.',
    `specimen_of_use_description` STRING COMMENT 'Description of the specimen submitted to demonstrate actual use of the trademark in commerce. Required for US trademark applications.',
    `trademark_status` STRING COMMENT 'Current lifecycle status of the trademark application or registration. Tracks progression through prosecution and maintenance phases. [ENUM-REF-CANDIDATE: pending|published|registered|opposed|cancelled|abandoned|expired — 7 candidates stripped; promote to reference product]',
    `translation_text` STRING COMMENT 'English translation of any foreign wording in the mark, as required by trademark offices for non-English marks.',
    `transliteration_text` STRING COMMENT 'Transliteration of any non-Latin characters in the mark into Latin characters, as required by trademark offices.',
    `use_in_commerce_date` DATE COMMENT 'The date the trademark was first used in commerce (for US applications). Critical for establishing trademark rights and priority in use-based jurisdictions.',
    CONSTRAINT pk_trademark PRIMARY KEY(`trademark_id`)
) COMMENT 'Master record for trademark assets including word marks, device marks, trade dress, and certification marks. Captures Nice Classification codes, goods and services descriptions, application serial number, registration number, registration date, renewal due date, use-in-commerce date, specimen of use, opposition period status, Madrid Protocol designations, and multi-class filing indicators. Extends ip_asset for trademark-specific prosecution and maintenance.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`prosecution_event` (
    `prosecution_event_id` BIGINT COMMENT 'Unique identifier for the prosecution event record. Primary key for the prosecution event entity.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the internal attorney or timekeeper record for the attorney of record handling this prosecution event.',
    `ip_asset_id` BIGINT COMMENT 'FK to ip.ip_asset.ip_asset_id — Every prosecution event occurs against a specific IP asset (patent or trademark application). This is the core transactional-to-master FK.',
    `legal_document_id` BIGINT COMMENT 'Reference to the internal document management system record for the official communication or response document associated with this prosecution event.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Each prosecution event (office action response, amendment filing, interview) represents delivery of a specific legal service. Critical for service delivery tracking, billing reconciliation, SLA compli',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this prosecution event is managed.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'User identifier of the person who last modified this prosecution event record in the system.',
    `patent_id` BIGINT COMMENT 'Reference to the patent or trademark application to which this prosecution event belongs.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Adverse prosecution events (final rejections, restriction requirements, examiner interviews with negative outcomes) create risks requiring escalation, additional budget, or strategic abandonment decis',
    `research_memo_id` BIGINT COMMENT 'Foreign key linking to knowledge.research_memo. Business justification: Prosecution responses to office actions frequently rely on research memos analyzing prior art, patentability issues, or claim construction. Links prosecution strategy to underlying legal research, sup',
    `rfp_submission_id` BIGINT COMMENT 'Foreign key linking to intake.rfp_submission. Business justification: Prosecution events responding to RFP requirements (e.g., patent prosecution RFPs requiring specific filing milestones) require linkage for RFP deliverable tracking, proposal commitment verification, a',
    `timekeeper_id` BIGINT COMMENT 'User identifier of the person who created this prosecution event record in the system.',
    `application_number` STRING COMMENT 'Official application number assigned by the patent or trademark office. Denormalized for quick reference and reporting.',
    `art_unit` STRING COMMENT 'USPTO art unit or technology center code to which the examiner belongs. Indicates the technical classification area for patent examination.',
    `attorney_of_record` STRING COMMENT 'Name of the attorney or patent agent officially representing the applicant for this prosecution event.',
    `claims_allowed_count` STRING COMMENT 'Number of claims allowed by the examiner in this prosecution event. Relevant for notices of allowance and final dispositions.',
    `claims_rejected_count` STRING COMMENT 'Number of claims rejected by the examiner in this prosecution event. Relevant for office actions and final rejections.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prosecution event record was first created in the system.',
    `docketing_trigger_flag` BOOLEAN COMMENT 'Indicates whether this prosecution event triggers an automated docketing action or deadline alert in the IP management system.',
    `document_reference_number` STRING COMMENT 'Official document or communication reference number assigned by the patent or trademark office to this prosecution event.',
    `estoppel_risk_flag` BOOLEAN COMMENT 'Indicates whether this prosecution event may create prosecution history estoppel risk, limiting claim scope interpretation in future litigation.',
    `event_date` DATE COMMENT 'Date on which the prosecution event occurred or was officially recorded by the patent or trademark office.',
    `event_type` STRING COMMENT 'Type of prosecution event. Categorizes the official action or applicant response in the patent or trademark prosecution lifecycle. [ENUM-REF-CANDIDATE: office_action_received|response_filed|notice_of_allowance|final_rejection|restriction_requirement|appeal_filed|grant_issued|request_for_continued_examination|interview_conducted|amendment_filed|information_disclosure_statement|petition_filed|suspension_notice|abandonment_notice — promote to reference product]. Valid values are `office_action_received|response_filed|notice_of_allowance|final_rejection|restriction_requirement|appeal_filed`',
    `examiner_name` STRING COMMENT 'Full name of the patent or trademark examiner assigned to review the application and issue the prosecution event.',
    `extension_granted_flag` BOOLEAN COMMENT 'Indicates whether a deadline extension was granted by the patent or trademark office for this prosecution event.',
    `extension_requested_flag` BOOLEAN COMMENT 'Indicates whether a deadline extension was requested for this prosecution event.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Official fee amount paid or due for this prosecution event (e.g., response filing fee, extension fee, appeal fee).',
    `fee_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the fee amount (e.g., USD, EUR, JPY).',
    `filing_date` DATE COMMENT 'Original filing date of the patent or trademark application. Denormalized for prosecution history analysis and priority date calculations.',
    `for_asset` BIGINT COMMENT 'FK to ip.asset.asset_id — Every prosecution event occurs in the context of a specific IP asset (patent or trademark application). This FK is essential for prosecution history reconstruction and estoppel analysis.',
    `interview_conducted_flag` BOOLEAN COMMENT 'Indicates whether an examiner interview was conducted as part of this prosecution event.',
    `interview_date` DATE COMMENT 'Date on which an examiner interview was conducted, if applicable.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code or jurisdiction identifier for the patent or trademark office where the prosecution event occurred (e.g., USA, EPO, JPN).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this prosecution event record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text notes or internal commentary regarding the prosecution event. May include strategic considerations, client instructions, or follow-up actions.',
    `office_action_type` STRING COMMENT 'Specific type of office action issued by the patent or trademark office. Distinguishes between non-final, final, restriction, and other action types.. Valid values are `non_final|final|restriction|election|ex_parte_quayle|advisory`',
    `official_deadline` DATE COMMENT 'Statutory or official deadline imposed by the patent or trademark office for responding to this event. Critical for docketing and deadline management.',
    `outcome` STRING COMMENT 'Outcome or result of the prosecution event. Indicates whether claims were allowed, rejected, or the application status changed.. Valid values are `allowed|rejected|pending|withdrawn|abandoned|granted`',
    `prior_art_references` STRING COMMENT 'List or summary of prior art references cited by the examiner in the office action. May include patent numbers, publication identifiers, or non-patent literature.',
    `prosecution_stage` STRING COMMENT 'Current stage of the prosecution lifecycle at the time of this event. Provides context for the event within the overall application timeline.. Valid values are `examination|appeal|allowance|grant|post_grant|opposition`',
    `rejection_basis` STRING COMMENT 'Legal or technical basis for rejection cited by the examiner. May reference prior art, statutory sections (e.g., 35 USC 102, 103, 112), or formality issues.',
    `response_deadline` DATE COMMENT 'Internal or client-agreed deadline for filing a response to this prosecution event. May be earlier than the official deadline to allow for review and preparation.',
    `response_filed_date` DATE COMMENT 'Date on which the applicant or attorney filed a response to the prosecution event with the patent or trademark office.',
    `response_summary` STRING COMMENT 'Brief summary of the applicants response or the substance of the office action. Captures key arguments, amendments, or examiner positions for quick reference.',
    CONSTRAINT pk_prosecution_event PRIMARY KEY(`prosecution_event_id`)
) COMMENT 'Transactional record of every official prosecution action, office communication, or applicant response in the lifecycle of a patent or trademark application. Captures event type (office action received, response filed, notice of allowance, final rejection, restriction requirement, appeal filed, grant issued, request for continued examination), event date, official deadline, response deadline, examiner name and art unit, attorney of record, response summary, and outcome. Supports docketing trigger automation, deadline management, and prosecution history estoppel analysis.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`docket_deadline` (
    `docket_deadline_id` BIGINT COMMENT 'Unique identifier for the docket deadline record. Primary key for the docket deadline entity.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney (timekeeper) responsible for ensuring compliance with this deadline. This is the primary owner of the deadline.',
    `docket_deadline_triggered_by_event` BIGINT COMMENT 'FK to ip.prosecution_event.prosecution_event_id — Many deadlines are triggered by prosecution events (e.g., office action received triggers response deadline). This FK enables automated deadline calculation from prosecution events.',
    `docket_ip_asset_id` BIGINT COMMENT 'Reference to the IP asset (patent, trademark, copyright, trade secret) to which this deadline applies.',
    `docket_prosecution_event_id` BIGINT COMMENT 'Foreign key linking to ip.prosecution_event. Business justification: Docket deadlines are triggered by prosecution events (office actions, examiner responses, etc.). A single prosecution event can generate multiple deadlines (response deadline, appeal deadline, etc.). ',
    `ip_asset_id` BIGINT COMMENT 'FK to ip.ip_asset.ip_asset_id — Every docketed deadline relates to a specific IP asset. This is critical for deadline management — you must know which asset a deadline belongs to.',
    `last_modified_by_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user (attorney, clerk, or system process) who last modified this record. Used for audit trail and accountability.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Docket deadlines are tied to specific service deliverables (file response, pay annuity, file renewal). Essential for SLA tracking, service delivery management, and linking deadline compliance to servi',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or prosecution file associated with this deadline.',
    `prosecution_event_id` BIGINT COMMENT 'FK to ip.prosecution_event.prosecution_event_id — Many deadlines are triggered by prosecution events (e.g., office action response deadline). This FK enables deadline calculation from triggering events.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Missed or at-risk deadlines create professional indemnity exposure, loss of IP rights, and client relationship damage. Legal teams track high-risk deadlines (short timeframes, complex filings, resourc',
    `timekeeper_id` BIGINT COMMENT 'Reference to the docketing clerk or paralegal responsible for monitoring and managing this deadline in the docketing system.',
    `active_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this deadline is currently active and requires monitoring. False if the deadline has been completed, missed, waived, or the underlying IP asset has been abandoned.',
    `calculated_due_date` DATE COMMENT 'Rule-based calculated due date for the deadline, derived from statutory rules, office action issuance date, priority date, or other triggering event. This is the baseline due date before any extensions.',
    `client_instruction_received_date` DATE COMMENT 'Date on which client instructions regarding this deadline were received (e.g., instruction to file response, instruction to abandon, instruction to pay annuity). Nullable if client instruction is not yet received or not required.',
    `client_instruction_summary` STRING COMMENT 'Summary of client instructions regarding this deadline. Confidential and subject to Legal Professional Privilege (LPP).',
    `client_notification_date` DATE COMMENT 'Date on which the client was notified of this deadline. Used to demonstrate compliance with duty to inform client and for Service Level Agreement (SLA) tracking.',
    `completion_confirmation_number` STRING COMMENT 'Confirmation or receipt number issued by the patent office or payment processor upon completion of the required action (e.g., filing receipt number, payment transaction ID).',
    `completion_date` DATE COMMENT 'Date on which the required action was completed (e.g., response filed, payment made). Nullable if the deadline is still pending or was missed.',
    `completion_status` STRING COMMENT 'Current lifecycle status of the deadline. Pending indicates the deadline is active and not yet met. Completed indicates the required action was taken. Missed indicates the deadline was not met. Waived indicates the deadline was intentionally not pursued. Abandoned indicates the underlying IP asset prosecution was abandoned.. Valid values are `pending|completed|missed|waived|abandoned`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this docket deadline record was first created in the system. Used for audit trail and data lineage.',
    `deadline_description` STRING COMMENT 'Detailed textual description of the deadline, including the specific action required (e.g., Respond to Office Action - Claim Rejection, Pay 5th Year Annuity, Enter National Phase in USA).',
    `deadline_for_asset` BIGINT COMMENT 'FK to ip.asset.asset_id — Every docketed deadline relates to a specific IP asset. This is mission-critical — deadline management without asset linkage is operationally useless.',
    `deadline_type` STRING COMMENT 'Classification of the deadline. Indicates whether it is a statutory deadline, office action response, annuity/renewal payment, Patent Cooperation Treaty (PCT) national phase entry (30/31 month), opposition filing window, or other IP-specific deadline type. [ENUM-REF-CANDIDATE: statutory|office_action_response|annuity_payment|renewal_payment|pct_national_phase_entry|opposition_filing|priority_claim|divisional_filing|continuation_filing|appeal_filing|hearing_date|examination_request — promote to reference product]. Valid values are `statutory|office_action_response|annuity_payment|renewal_payment|pct_national_phase_entry|opposition_filing`',
    `docket_system_code` STRING COMMENT 'External identifier for this deadline in the IP docketing system of record (e.g., CPI, Anaqua, PatSnap). Used for system integration and reconciliation.',
    `escalation_date` DATE COMMENT 'Date on which a missed deadline was escalated to management or risk committee. Nullable if no escalation has occurred.',
    `escalation_notes` STRING COMMENT 'Confidential notes documenting the circumstances of a missed deadline, remediation actions taken, and communications with client or insurance carrier. Subject to Legal Professional Privilege (LPP).',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost to meet this deadline, including attorney fees, official fees, and disbursements. Used for client budgeting and Work in Progress (WIP) forecasting.',
    `estimated_cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `extended_due_date` DATE COMMENT 'Extended due date if an extension of time has been requested and granted. Nullable if no extension applies. Represents the final enforceable deadline.',
    `extension_fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the extension fee required to extend the deadline, if applicable. Nullable if no extension fee applies.',
    `extension_fee_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the extension fee amount (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `extension_fee_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether an extension fee must be paid to obtain the extended due date. True if fee is required, False otherwise.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country code or regional patent office code (e.g., US, EP, JP, CN, WO for WIPO) indicating the jurisdiction in which the deadline applies.. Valid values are `^[A-Z]{2,3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this docket deadline record was last modified. Used for audit trail and change tracking.',
    `missed_deadline_escalation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a missed deadline has been escalated to management, risk committee, or malpractice insurance carrier. True if escalated, False otherwise.',
    `missed_deadline_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this deadline was missed. True if the deadline passed without completion, False otherwise. Mission-critical for malpractice risk tracking.',
    `priority_level` STRING COMMENT 'Business priority level assigned to this deadline. Critical deadlines (e.g., statutory bar dates, national phase entry) require highest attention. Used for escalation and resource allocation.. Valid values are `critical|high|medium|low`',
    `reminder_schedule` STRING COMMENT 'Cascade schedule for deadline reminders, typically expressed as days before due date (e.g., 90,60,30,14,7,3,1 indicating reminders at 90 days, 60 days, 30 days, 14 days, 7 days, 3 days, and 1 day before the deadline).',
    `statutory_rule_reference` STRING COMMENT 'Citation to the statutory rule, regulation, or patent office practice that defines this deadline (e.g., 37 CFR 1.136, EPC Rule 71(3), PCT Article 22(1)).',
    CONSTRAINT pk_docket_deadline PRIMARY KEY(`docket_deadline_id`)
) COMMENT 'Operational record of every docketed deadline associated with an IP asset or prosecution event. Covers statutory deadlines, office action response due dates, annuity/renewal payment dates, PCT national phase entry deadlines (30/31 month), opposition filing windows, priority year expiry, and divisional filing deadlines. Captures deadline type, rule-based calculated due date, extended due date (with extension fee flag), responsible attorney, docketing clerk, reminder cascade schedule, completion status, completion date, and missed-deadline escalation flag. Mission-critical for IP docketing compliance — a missed deadline can result in irrecoverable loss of rights and malpractice liability.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`ip_payment` (
    `ip_payment_id` BIGINT COMMENT 'Primary key for payment',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or IP professional responsible for managing this payment and the associated IP asset or license agreement.',
    `created_by_user_timekeeper_id` BIGINT COMMENT 'User identifier of the person who created the payment record in the system.',
    `ip_asset_id` BIGINT COMMENT 'Reference to the IP asset (patent, trademark, copyright, trade secret) associated with this payment.',
    `ledger_entry_id` BIGINT COMMENT 'Foreign key linking to trust.trust_ledger_entry. Business justification: Annuity and royalty payments for IP assets are commonly disbursed from trust accounts. Links IP payment records to specific trust ledger entries for three-way reconciliation, regulatory compliance (IO',
    `license_agreement_id` BIGINT COMMENT 'Reference to the license agreement associated with this payment, if applicable for royalty or milestone payments.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case associated with this IP payment, if applicable. Links payment to matter management for cost tracking and billing.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'User identifier of the person who last modified the payment record in the system.',
    `profile_id` BIGINT COMMENT 'Reference to the client or IP owner on whose behalf the payment is made or to whom the payment is attributed.',
    `regulatory_return_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_return. Business justification: IP payments (annuities, royalties) require regulatory reporting including tax returns, withholding tax filings, cross-border payment disclosures, and transfer pricing documentation. Essential for tax ',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user or timekeeper who approved the payment for processing.',
    `agent_name` STRING COMMENT 'Name of the payment agent, annuity service provider, or IP management firm that processed the payment on behalf of the organization.',
    `amount` DECIMAL(18,2) COMMENT 'Gross payment amount before any adjustments, withholding tax, or surcharges. Represents the base payment value.',
    `approval_date` DATE COMMENT 'Date when the payment was approved for processing by the authorized approver or financial controller.',
    `audit_adjustment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this payment record has been adjusted as a result of an audit review or correction. True if adjusted, False otherwise.',
    `audit_adjustment_reason` STRING COMMENT 'Explanation or reason for any audit adjustment made to the payment record. Populated only when audit_adjustment_flag is True.',
    `cost_center_code` STRING COMMENT 'Cost center or department code to which this payment is allocated for internal cost management and budgeting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'Official due date for the payment as specified by the IP office, licensing agreement, or contractual obligation. Critical for lapse risk monitoring and deadline docketing.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this payment is posted for financial accounting and reporting purposes.',
    `ip_office_code` STRING COMMENT 'Code or identifier of the IP office or jurisdiction where the payment was submitted (e.g., USPTO, EPO, JPO, WIPO).',
    `jurisdiction_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the jurisdiction where the IP asset is registered and the payment is applicable.. Valid values are `^[A-Z]{3}$`',
    `late_payment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the payment was made after the official due date. True if late, False if on time. Used for lapse risk monitoring and performance tracking.',
    `late_payment_surcharge_amount` DECIMAL(18,2) COMMENT 'Additional surcharge or penalty amount assessed for late payment beyond the official due date. Common for annuity and maintenance fee payments.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was last modified or updated. Used for audit trail and change tracking.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'Net payment amount after deducting withholding tax and adding any surcharges. Represents the actual amount paid or received.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the payment transaction, including special instructions, dispute details, or reconciliation remarks.',
    `payment_date` DATE COMMENT 'Actual date the payment was made or received. Used for reconciliation, revenue recognition, and audit trail.',
    `payment_method` STRING COMMENT 'Method or instrument used to execute the payment transaction (e.g., wire transfer, credit card, check, ACH, direct debit, electronic funds transfer).. Valid values are `wire_transfer|credit_card|check|ach|direct_debit|electronic_funds_transfer`',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Pending: awaiting processing. Scheduled: scheduled for future payment. Paid: successfully completed. Failed: payment attempt failed. Cancelled: payment cancelled before execution. Refunded: payment reversed and refunded. Disputed: payment under dispute or audit review. [ENUM-REF-CANDIDATE: pending|scheduled|paid|failed|cancelled|refunded|disputed — 7 candidates stripped; promote to reference product]',
    `payment_type` STRING COMMENT 'Classification of the payment transaction type. Annuity: periodic fee to maintain IP rights. Maintenance fee: official fee to keep IP registration active. Renewal fee: fee to renew IP registration. Royalty inbound: royalty received from licensee. Royalty outbound: royalty paid to licensor. Surcharge: late payment penalty or official surcharge. Milestone: contractual milestone payment. FRAND commitment: Fair Reasonable and Non-Discriminatory licensing payment. Filing fee: initial application fee. Examination fee: substantive examination fee. [ENUM-REF-CANDIDATE: annuity|maintenance_fee|renewal_fee|royalty_inbound|royalty_outbound|surcharge|milestone|frand_commitment|filing_fee|examination_fee — 10 candidates stripped; promote to reference product]',
    `reconciliation_status` STRING COMMENT 'Status of payment reconciliation against bank statements, IP office receipts, or license agreement terms. Unreconciled: not yet matched. Reconciled: fully matched and verified. Partially reconciled: partial match requiring further review. Disputed: discrepancy identified requiring resolution.. Valid values are `unreconciled|reconciled|partially_reconciled|disputed`',
    `reference_number` STRING COMMENT 'External reference number for the payment transaction, such as IP office receipt number, remittance reference, or payment agent transaction ID.',
    `royalty_base_amount` DECIMAL(18,2) COMMENT 'Base amount (e.g., net sales, gross revenue, units sold) upon which the royalty rate is applied. Applicable only for royalty payment types.',
    `royalty_period_end_date` DATE COMMENT 'End date of the reporting period for which royalty is calculated and paid. Applicable only for royalty payment types.',
    `royalty_period_start_date` DATE COMMENT 'Start date of the reporting period for which royalty is calculated and paid. Applicable only for royalty payment types.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to the royalty base to calculate the royalty payment amount. Applicable only for royalty payment types.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from the payment, typically applicable to cross-border royalty payments. Used for tax compliance and net payment calculation.',
    CONSTRAINT pk_ip_payment PRIMARY KEY(`ip_payment_id`)
) COMMENT 'Unified transactional record of every financial payment made or received in connection with IP assets and license agreements. Covers annuity fees, maintenance fees, renewal fees, official surcharges, royalty payments (inbound and outbound), milestone payments, and FRAND commitment payments. Captures payment type (annuity, maintenance_fee, renewal_fee, royalty_inbound, royalty_outbound, surcharge, milestone), associated IP asset or license agreement, due date, payment date, payment amount, currency, IP office receipt number or remittance reference, payment agent, payment method, royalty base and rate (for royalty types), royalty period, withholding tax, late payment surcharge flag, audit adjustment flag, reconciliation status, and payment status. Supports portfolio cost management, annuity forecasting, lapse risk monitoring, royalty accounting, audit rights enforcement, revenue recognition, and unified payment reconciliation.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`license_agreement` (
    `license_agreement_id` BIGINT COMMENT 'Primary key for license_agreement',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: IP license agreements often require trust accounts for holding advance royalty payments, security deposits, or ongoing royalty proceeds pending distribution. Essential for tracking financial obligatio',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or timekeeper responsible for managing this IP license agreement.',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: License agreements process personal data (licensor/licensee contact details, inventor information, payment details) requiring GDPR Article 30 registration. Essential for data protection compliance in ',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: License disputes (breach, royalty calculation, scope interpretation, FRAND obligations) frequently result in litigation. Direct link from license_agreement to court docket tracks these disputes, enabl',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: License agreements negotiated during engagement opportunities (licensing deal origination) require linkage for origination credit, opportunity-to-revenue tracking, and business development pipeline re',
    `escrow_arrangement_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_arrangement. Business justification: High-value IP licenses frequently use escrow for source code deposits, technology transfer security, or payment guarantees. Links license agreements to escrow arrangements for tracking release conditi',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: License agreement drafting and negotiation is a distinct legal service offering in IP practices. Required for service catalog management, cross-selling analytics, and linking licensing work to service',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this IP license agreement is managed.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user who last modified this IP license agreement record in the system.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: License agreements are drafted from precedent templates containing standard clauses for royalty structures, field-of-use restrictions, FRAND obligations, and termination provisions. Essential for trac',
    `profile_id` BIGINT COMMENT 'Reference to the client who is party to this IP license agreement.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: License agreements create contractual risks (breach, termination disputes), payment risks (royalty underpayment, audit findings), and compliance risks (sublicensing violations, field-of-use breaches).',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: License agreements trigger regulatory obligations including antitrust filings (FRAND commitments), foreign investment approvals, technology transfer regulations, and export control compliance. Essenti',
    `third_party_risk_id` BIGINT COMMENT 'Foreign key linking to risk.third_party_risk. Business justification: Licensees are third parties with access to confidential IP, technical data, and client information requiring due diligence (financial stability, data security, sanctions screening) and ongoing monitor',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user who created this IP license agreement record in the system.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the IP license agreement, used for client communication and filing.',
    `agreement_type` STRING COMMENT 'Discriminator classifying the type of IP agreement. [ENUM-REF-CANDIDATE: exclusive_license|non_exclusive_license|sole_license|cross_license|compulsory_license|frand_license|invention_assignment|co_ownership_agreement|joint_development_agreement|technology_transfer_agreement|ip_indemnification_agreement|confidentiality_agreement_with_ip_terms|settlement_agreement_with_ip_covenants — promote to reference product]',
    `amendment_history` STRING COMMENT 'Record of amendments, addenda, or modifications made to the original agreement, including dates and summary of changes.',
    `audit_rights` STRING COMMENT 'Description of the licensors rights to audit the licensees records to verify royalty calculations and compliance.',
    `confidentiality_terms` STRING COMMENT 'Summary of confidentiality obligations related to proprietary information exchanged under the agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IP license agreement record was first created in the system.',
    `dispute_resolution_mechanism` STRING COMMENT 'Method specified in the agreement for resolving disputes between the parties.. Valid values are `litigation|arbitration|mediation|adr`',
    `document_storage_location` STRING COMMENT 'Reference to the location in the Document Management System (DMS) where the executed agreement and related documents are stored.',
    `effective_date` DATE COMMENT 'Date on which the IP license agreement becomes legally binding and enforceable.',
    `exclusivity_terms` STRING COMMENT 'Description of any exclusivity provisions, including exclusive territories, fields of use, or time periods during which the licensee has exclusive rights.',
    `execution_status` STRING COMMENT 'Current lifecycle status of the IP license agreement indicating its execution and enforceability state.. Valid values are `draft|under_negotiation|executed|pending_signature|terminated|expired`',
    `expiry_date` DATE COMMENT 'Date on which the IP license agreement terminates or expires. Nullable for perpetual agreements.',
    `field_of_use` STRING COMMENT 'Specific industry, application, or market segment in which the licensee is permitted to use the licensed IP.',
    `fixed_royalty_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount payable under the license agreement, if applicable. Nullable for non-fixed structures.',
    `frand_obligation_flag` BOOLEAN COMMENT 'Indicates whether this license is subject to FRAND (Fair, Reasonable, and Non-Discriminatory) licensing obligations, typically for standard-essential patents.',
    `governing_law` STRING COMMENT 'Jurisdiction and legal framework governing the interpretation and enforcement of the IP license agreement.',
    `improvement_rights` STRING COMMENT 'Terms governing ownership and licensing of improvements, modifications, or derivative works created under the agreement.',
    `indemnification_terms` STRING COMMENT 'Summary of indemnification obligations, including IP infringement indemnities and liability caps.',
    `key_obligations` STRING COMMENT 'Summary of the principal obligations of each party under the agreement, including performance milestones, reporting requirements, and quality standards.',
    `license_covers_asset` BIGINT COMMENT 'FK to ip.asset.asset_id — License agreements grant rights to specific IP assets. This is a many-to-many relationship but the FK from license to asset (or junction) is essential for portfolio encumbrance analysis.',
    `licensed_ip_assets` STRING COMMENT 'Description or enumeration of the specific IP assets covered by this agreement (patents, trademarks, copyrights, trade secrets). May reference IP asset identifiers.',
    `licensee_name` STRING COMMENT 'Legal name of the party receiving the IP license or acquiring IP rights.',
    `licensor_name` STRING COMMENT 'Legal name of the party granting the IP license or assigning IP rights.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this IP license agreement record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context regarding the IP license agreement.',
    `payment_terms` STRING COMMENT 'Description of payment schedule, due dates, and invoicing arrangements for royalties or license fees.',
    `performance_milestones` STRING COMMENT 'Key performance milestones or deliverables required under the agreement, particularly relevant for joint development or technology transfer agreements.',
    `practice_group_code` STRING COMMENT 'Code identifying the practice group (e.g., IP Transactions, IP Litigation) responsible for this agreement.',
    `renewal_terms` STRING COMMENT 'Description of the conditions and process for renewing the license agreement upon expiry, including notice periods and renewal fees.',
    `royalty_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for royalty payments.. Valid values are `^[A-Z]{3}$`',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to revenue or sales for running royalty calculations. Nullable if not applicable.',
    `royalty_structure` STRING COMMENT 'Type of royalty or payment structure governing compensation under the license agreement.. Valid values are `fixed_fee|running_royalty|milestone_based|lump_sum|hybrid|royalty_free`',
    `sublicensing_permitted_flag` BOOLEAN COMMENT 'Indicates whether the licensee is permitted to grant sublicenses to third parties under this agreement.',
    `termination_provisions` STRING COMMENT 'Summary of the conditions under which either party may terminate the agreement, including breach, insolvency, or convenience termination clauses.',
    `territory` STRING COMMENT 'Geographic scope of the license, specifying countries or regions where the licensed IP may be used. Use ISO 3166-1 alpha-3 country codes where applicable.',
    `warranty_terms` STRING COMMENT 'Summary of warranties provided by the licensor regarding IP ownership, validity, and non-infringement.',
    CONSTRAINT pk_license_agreement PRIMARY KEY(`license_agreement_id`)
) COMMENT 'Master record for ALL IP-specific agreements governing the use, transfer, ownership, co-development, or protection of IP assets. Covers license agreements (exclusive, non-exclusive, sole, cross-license, compulsory, FRAND-encumbered), invention assignment agreements, co-ownership agreements, joint development agreements, technology transfer agreements, IP indemnification agreements, confidentiality agreements with IP-specific terms, and settlement agreements with IP covenants. Captures agreement type discriminator, parties (licensor/licensee, assignor/assignee, co-owners, joint developers), licensed/assigned IP assets, territory, field of use, royalty structure (fixed, running, milestone, lump-sum), effective date, expiry date, renewal terms, sublicensing rights, FRAND obligation flag, key obligations, governing law, execution status, termination provisions, and amendment history. SSOT for all IP agreement relationships — the ONLY product in this domain for recording any IP-related agreement. Distinct from the contract domains general CLM pipeline which handles engagement letters and vendor contracts.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`royalty_payment` (
    `royalty_payment_id` BIGINT COMMENT 'Unique identifier for the royalty payment transaction. Primary key for the royalty payment record.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice issued for this royalty payment, if applicable.',
    `ip_asset_id` BIGINT COMMENT 'Reference to the specific IP asset (patent, trademark, copyright, trade secret) for which royalty is being paid.',
    `license_agreement_id` BIGINT COMMENT 'Reference to the IP license agreement under which this royalty payment is made or received.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user or system account that last modified the royalty payment record.',
    `organisation_id` BIGINT COMMENT 'Reference to the party making the royalty payment (the licensee using the IP).',
    `receipt_id` BIGINT COMMENT 'Foreign key linking to trust.trust_receipt. Business justification: When royalty payments are received into trust accounts (common in IP licensing), links the royalty payment record to the trust receipt for AML/KYC compliance, source-of-funds verification, and reconci',
    `regulatory_return_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_return. Business justification: Royalty payments require regulatory returns including withholding tax filings, cross-border payment reports, transfer pricing documentation, and VAT/GST returns. Essential for tax compliance and regul',
    `royalty_report_id` BIGINT COMMENT 'Reference to the royalty report submitted by the licensee that supports this royalty payment.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user or system account that created the royalty payment record.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any adjustment amount applied to the calculated royalty (e.g., audit adjustments, true-up adjustments, credits, or penalties).',
    `adjustment_reason` STRING COMMENT 'Explanation or reason for any adjustment made to the calculated royalty amount (e.g., audit finding, prior period correction, contractual penalty).',
    `audit_date` DATE COMMENT 'Date on which the royalty payment or underlying royalty calculation was audited.',
    `audit_findings` STRING COMMENT 'Summary of findings from the royalty audit, including any discrepancies, adjustments, or compliance issues identified.',
    `audit_flag` BOOLEAN COMMENT 'Boolean indicator of whether this royalty payment has been subject to audit or requires audit review.',
    `calculated_royalty_amount` DECIMAL(18,2) COMMENT 'The gross royalty amount calculated by applying the royalty rate to the royalty base, before any adjustments, withholdings, or deductions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the royalty payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the royalty payment (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `frand_obligation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this royalty payment is subject to FRAND (Fair, Reasonable, and Non-Discriminatory) licensing obligations, typically for standard-essential patents.',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the jurisdiction governing the royalty payment and tax treatment.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the royalty payment record was last modified or updated.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The final net royalty payment amount after applying withholding tax, adjustments, and any other deductions.',
    `payment_date` DATE COMMENT 'The actual date on which the royalty payment was made or received.',
    `payment_direction` STRING COMMENT 'Indicates whether the royalty payment is inbound (received by the firm) or outbound (paid by the firm).. Valid values are `inbound|outbound`',
    `payment_due_date` DATE COMMENT 'The contractual due date by which the royalty payment should be made according to the license agreement.',
    `payment_method` STRING COMMENT 'The method or instrument used to make the royalty payment (e.g., wire transfer, ACH, check, credit card).. Valid values are `wire_transfer|ach|check|credit_card|electronic_funds_transfer|other`',
    `payment_notes` STRING COMMENT 'Free-text notes or comments regarding the royalty payment, including special circumstances, disputes, or clarifications.',
    `payment_period_end_date` DATE COMMENT 'End date of the reporting period for which royalties are calculated and paid.',
    `payment_period_start_date` DATE COMMENT 'Start date of the reporting period for which royalties are calculated and paid.',
    `payment_reference_number` STRING COMMENT 'External reference number or transaction identifier for the royalty payment, used for reconciliation and audit purposes.',
    `payment_status` STRING COMMENT 'Current status of the royalty payment in its lifecycle (e.g., pending, processed, cleared, failed, reversed, disputed).. Valid values are `pending|processed|cleared|failed|reversed|disputed`',
    `reconciliation_date` DATE COMMENT 'Date on which the royalty payment was reconciled with the royalty report and license agreement.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the royalty payment has been reconciled with the licensees royalty report and the license agreement terms.. Valid values are `unreconciled|reconciled|partially_reconciled|disputed`',
    `royalty_base_amount` DECIMAL(18,2) COMMENT 'The monetary or quantitative base amount upon which the royalty rate is applied to calculate the royalty payment.',
    `royalty_base_type` STRING COMMENT 'The basis on which royalty is calculated (e.g., net sales, gross sales, units sold, revenue, profit, fixed fee, or minimum guarantee). [ENUM-REF-CANDIDATE: net_sales|gross_sales|units_sold|revenue|profit|fixed_fee|minimum_guarantee — 7 candidates stripped; promote to reference product]',
    `royalty_rate` DECIMAL(18,2) COMMENT 'The percentage or per-unit rate applied to the royalty base to calculate the royalty amount. Expressed as a decimal (e.g., 0.05 for 5%).',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of tax withheld at source from the royalty payment as required by applicable tax jurisdiction.',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'The percentage rate of withholding tax applied to the royalty payment, as per tax treaty or domestic law.',
    CONSTRAINT pk_royalty_payment PRIMARY KEY(`royalty_payment_id`)
) COMMENT 'Transactional record of royalty payments made or received under an IP license agreement. Captures payment period, royalty base (net sales, units, revenue), royalty rate, calculated royalty amount, currency, payment date, payment direction (inbound/outbound), withholding tax amount, audit adjustment flag, and reconciliation status. Supports royalty accounting, audit rights enforcement, and revenue recognition for IP licensing income.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`ownership` (
    `ownership_id` BIGINT COMMENT 'Primary key for ownership',
    `ip_asset_id` BIGINT COMMENT 'Reference to the IP asset (patent, trademark, copyright, trade secret) that is subject to this ownership record.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case file associated with this ownership record. Links to the matter management system for tracking legal work related to the ownership.',
    `predecessor_ownership_id` BIGINT COMMENT 'Reference to the previous ownership record in the chain of title. Enables reconstruction of the complete ownership history for due diligence purposes.',
    `profile_id` BIGINT COMMENT 'Reference to the client entity that owns or is associated with this IP ownership record. Links to the client master data.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Ownership disputes, chain-of-title defects, unrecorded assignments, and security interests create transaction risks (M&A due diligence failures), enforcement risks (standing challenges), and valuation',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: IP ownership changes trigger regulatory obligations including recordal requirements at IP offices, foreign ownership notifications, security interest filings (UCC), and beneficial ownership disclosure',
    `assignment_date` DATE COMMENT 'Date on which the ownership rights were assigned or transferred to the current owner. Represents the effective date of the assignment agreement.',
    `assignment_document_reference` STRING COMMENT 'Reference identifier or document management system (DMS) link to the legal assignment agreement or deed of assignment that evidences the ownership transfer.',
    `basis` STRING COMMENT 'Legal basis or mechanism by which ownership was acquired. Distinguishes between original application, assignment, merger/acquisition, inheritance, court order, license conversion, or other mechanisms. [ENUM-REF-CANDIDATE: original_applicant|assignment|merger_acquisition|inheritance|court_order|license_conversion|other — 7 candidates stripped; promote to reference product]',
    `beneficial_owner_identifier` STRING COMMENT 'Unique identifier for the beneficial owner (e.g., tax ID, national ID, passport number). Required for KYC and AML compliance.',
    `beneficial_owner_name` STRING COMMENT 'Name of the ultimate beneficial owner if different from the legal owner. Required for Anti-Money Laundering (AML) and Know Your Client (KYC) compliance.',
    `consideration_amount` DECIMAL(18,2) COMMENT 'Monetary consideration paid for the assignment or transfer of ownership rights. May be zero for assignments without monetary consideration (e.g., employment agreements).',
    `consideration_currency` STRING COMMENT 'Three-letter ISO currency code for the consideration amount. Required when consideration_amount is non-zero.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ownership record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `effective_end_date` DATE COMMENT 'Date until which this ownership record is effective. Null for current ownership. Supports temporal tracking of ownership changes and chain of title reconstruction.',
    `effective_start_date` DATE COMMENT 'Date from which this ownership record is effective. Supports temporal tracking of ownership changes and chain of title reconstruction.',
    `frand_commitment_reference` STRING COMMENT 'Reference to the FRAND commitment or declaration made to the relevant standards development organization (SDO).',
    `frand_obligation_flag` BOOLEAN COMMENT 'Indicates whether the IP asset is subject to Fair Reasonable and Non-Discriminatory (FRAND) licensing obligations, typically for standard-essential patents.',
    `is_current_owner` BOOLEAN COMMENT 'Flag indicating whether this record represents the current owner of the IP asset. True for the active ownership record, false for historical records.',
    `joint_ownership_flag` BOOLEAN COMMENT 'Indicates whether the IP asset is subject to joint ownership by multiple parties. True if multiple ownership records exist for the same IP asset.',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO country code representing the jurisdiction in which this ownership record applies. IP ownership may vary by jurisdiction for international assets.. Valid values are `^[A-Z]{3}$`',
    `license_back_flag` BOOLEAN COMMENT 'Indicates whether the assignment includes a license-back provision allowing the assignor to continue using the IP. Common in employment and M&A contexts.',
    `license_back_terms` STRING COMMENT 'Summary of the license-back terms if applicable, including scope, duration, and any royalty obligations.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this ownership record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ownership record was last modified. Part of the audit trail for tracking changes over time.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the ownership record. May include special conditions, restrictions, or contextual information relevant to the ownership.',
    `of_asset` BIGINT COMMENT 'FK to ip.asset.asset_id — Ownership records establish chain of title for specific IP assets. Essential for assignment tracking and M&A due diligence.',
    `owner_address` STRING COMMENT 'Full legal address of the owner entity as recorded with the IP office. Required for official correspondence and recordal purposes.',
    `owner_contact_email` STRING COMMENT 'Primary email address for correspondence with the owner regarding this IP ownership record.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_contact_phone` STRING COMMENT 'Primary telephone number for contacting the owner regarding this IP ownership record.',
    `owner_country_code` STRING COMMENT 'Three-letter ISO country code representing the country of domicile or incorporation of the owner entity.. Valid values are `^[A-Z]{3}$`',
    `owner_entity_name` STRING COMMENT 'Full legal name of the entity or individual that holds ownership rights in the IP asset. May be an individual inventor, corporate assignee, joint owner, or government entity.',
    `owner_type` STRING COMMENT 'Classification of the ownership entity type. Distinguishes between individual inventors, corporate assignees, joint owners, government entities, universities, and trusts.. Valid values are `individual_inventor|corporate_assignee|joint_owner|government|university|trust`',
    `ownership_status` STRING COMMENT 'Current lifecycle status of the ownership record. Tracks whether ownership is active, pending recordal, transferred to another party, terminated, under dispute, or lapsed.. Valid values are `active|pending|transferred|terminated|disputed|lapsed`',
    `percentage` DECIMAL(18,2) COMMENT 'Percentage of ownership interest held by this owner in the IP asset. For sole ownership, this is 100.00. For joint ownership, reflects the proportional share.',
    `recordal_date` DATE COMMENT 'Date on which the ownership assignment was officially recorded with the relevant IP office or registry. Critical for establishing priority and chain of title.',
    `recordal_number` STRING COMMENT 'Official recordal or registration number issued by the IP office when the ownership assignment was recorded. Used for verification and audit purposes.',
    `security_interest_description` STRING COMMENT 'Description of any security interest, lien, or encumbrance affecting the IP ownership. Includes details of the secured party and nature of the security.',
    `security_interest_flag` BOOLEAN COMMENT 'Indicates whether the IP asset is subject to a security interest, lien, or encumbrance that affects ownership rights. True if security interest exists.',
    `verification_date` DATE COMMENT 'Date on which the ownership record was last verified or validated. Critical for due diligence and portfolio audits.',
    `verification_status` STRING COMMENT 'Status of the ownership verification process. Indicates whether the chain of title has been verified, is pending verification, remains unverified, or is disputed.. Valid values are `verified|pending_verification|unverified|disputed`',
    `verified_by` STRING COMMENT 'Name or identifier of the person or system that performed the ownership verification. Used for audit trail purposes.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this ownership record. Used for audit trail and accountability.',
    CONSTRAINT pk_ownership PRIMARY KEY(`ownership_id`)
) COMMENT 'Master record establishing the chain of title and ownership interests in each IP asset across all jurisdictions. Captures owner entity name, owner type (individual inventor, corporate assignee, joint owner, government), ownership percentage, assignment date, recordal date, IP office recordal number, consideration paid, and ownership status. Supports ownership verification, assignment recordal tracking, and portfolio due diligence for M&A transactions.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`inventor` (
    `inventor_id` BIGINT COMMENT 'Unique identifier for the inventor record. Primary key for the inventor entity.',
    `patent_id` BIGINT COMMENT 'FK to ip.patent.patent_id — Inventors are named on specific patent applications. This many-to-many relationship is essential for inventorship determination and assignment chain integrity.',
    `assignment_executed_flag` BOOLEAN COMMENT 'Indicates whether the inventor has executed a formal assignment of patent rights to the employer or assignee. Critical for chain of title verification.',
    `assignment_execution_date` DATE COMMENT 'Date on which the inventor signed the patent assignment document transferring rights to the assignee.',
    `assignment_recordation_number` STRING COMMENT 'USPTO or patent office recordation number for the assignment document. Used to verify chain of title in patent prosecution and litigation.',
    `conception_date` DATE COMMENT 'Date on which the inventor conceived the complete and operative invention. Used for priority determination in interference and derivation proceedings.',
    `contribution_description` STRING COMMENT 'Detailed description of the inventors specific contribution to the conception of the claimed invention. Used for inventorship determination and correction of inventorship proceedings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inventor record was first created in the IP management system.',
    `data_source_system` STRING COMMENT 'Name of the source system from which the inventor record originated (e.g., patent docketing system, invention disclosure system, HR system).',
    `deceased_date` DATE COMMENT 'Date of death of the inventor, if applicable. Triggers substitute statement requirements for pending applications.',
    `derivation_proceeding_number` STRING COMMENT 'USPTO Patent Trial and Appeal Board (PTAB) proceeding number for any derivation proceeding involving this inventor.',
    `email_address` STRING COMMENT 'Primary email address for inventor correspondence regarding patent prosecution, inventorship disputes, and assignment execution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employer_at_invention` STRING COMMENT 'Name of the organization employing the inventor at the time the invention was conceived. Critical for determining assignment rights and work-for-hire status.',
    `employment_agreement_reference` STRING COMMENT 'Reference identifier or document number for the employment agreement containing IP assignment provisions. Used to verify pre-invention assignment obligations.',
    `family_name` STRING COMMENT 'Last or family name of the inventor. Used for structured name parsing in international patent filings.',
    `full_legal_name` STRING COMMENT 'Complete legal name of the inventor as it appears on patent applications and grants. Used for inventorship determination and official USPTO/EPO/WIPO filings.',
    `given_name` STRING COMMENT 'First or given name of the inventor. Used for structured name parsing in international patent filings.',
    `invention_disclosure_date` DATE COMMENT 'Date on which the inventor formally disclosed the invention to the employer or patent counsel. Establishes priority date for derivation proceedings and assignment chain.',
    `inventor_status` STRING COMMENT 'Current lifecycle status of the inventor record. Affects ability to obtain signatures for continuation applications and assignment documents.. Valid values are `active|inactive|deceased|unlocatable|disputed`',
    `inventorship_dispute_flag` BOOLEAN COMMENT 'Indicates whether this inventor is involved in an inventorship dispute, derivation proceeding, or correction of inventorship petition.',
    `joint_inventor_flag` BOOLEAN COMMENT 'Indicates whether this inventor is one of multiple joint inventors on one or more patent applications. Joint inventors must each contribute to the conception of at least one claim.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the inventor record was last updated. Used for audit trail and data lineage tracking.',
    `legal_representative_name` STRING COMMENT 'Name of the legal representative (executor, administrator, guardian) authorized to act on behalf of a deceased or incapacitated inventor.',
    `nationality_country_code` STRING COMMENT 'Three-letter ISO country code representing the inventors nationality. Required for PCT applications and determines eligibility for certain patent prosecution highways.. Valid values are `^[A-Z]{3}$`',
    `oath_declaration_date` DATE COMMENT 'Date on which the inventor executed the oath or declaration for the patent application.',
    `oath_declaration_status` STRING COMMENT 'Status of the inventors oath or declaration required for patent application filing. Indicates whether the inventor has sworn to the accuracy of the application.. Valid values are `executed|pending|substitute_statement_filed|not_required`',
    `orcid_identifier` STRING COMMENT 'Unique persistent digital identifier for the inventor as a researcher. Facilitates disambiguation of inventor names across patent offices and academic publications.. Valid values are `^d{4}-d{4}-d{4}-d{3}[0-9X]$`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the inventor. Used for urgent patent prosecution matters and inventorship verification.',
    `prior_art_disclosure_obligation_flag` BOOLEAN COMMENT 'Indicates whether the inventor has an ongoing duty to disclose known prior art material to patentability under the duty of candor.',
    `residence_address_line_1` STRING COMMENT 'Primary street address line of the inventors residence. Required for inventor oath or declaration filings.',
    `residence_address_line_2` STRING COMMENT 'Secondary street address line of the inventors residence (apartment, suite, building number).',
    `residence_city` STRING COMMENT 'City or municipality of the inventors residence address.',
    `residence_country_code` STRING COMMENT 'Three-letter ISO country code representing the inventors country of residence at time of invention. Determines applicable patent law jurisdiction and filing requirements.. Valid values are `^[A-Z]{3}$`',
    `residence_postal_code` STRING COMMENT 'Postal or ZIP code of the inventors residence address.',
    `residence_state_province` STRING COMMENT 'State, province, or administrative region of the inventors residence address.',
    CONSTRAINT pk_inventor PRIMARY KEY(`inventor_id`)
) COMMENT 'Master record for individual inventors named on patent applications and grants, maintaining independent lifecycle for inventorship determination, derivation proceedings, and assignment chain management. Captures inventor full name, nationality, residence address, employer at time of invention, invention disclosure date, assignment executed flag, oath or declaration status, inventor contribution description, joint inventor flag, and employment agreement reference. Supports inventorship disputes, correction of inventorship filings, assignment chain integrity verification, and derivation proceeding risk management. Linked to patents via many-to-many relationship reflecting that inventors may appear on multiple patent applications.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`patent_family` (
    `patent_family_id` BIGINT COMMENT 'Unique identifier for the patent family record. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the timekeeper (attorney or patent agent) responsible for managing prosecution and strategy for this patent family. Links to the timekeeper master data product.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this patent family is managed. Links to the matter master data product for billing, timekeeper assignment, and matter-level reporting.',
    `profile_id` BIGINT COMMENT 'Reference to the client entity that owns or controls this patent family. Links to the client master data product.',
    `abstract_text` STRING COMMENT 'Brief technical summary of the invention from the priority or representative application. Typically 150-300 words describing the technical problem, solution, and key features.',
    `active_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this patent family record is currently active in the system. True for active records, False for archived or soft-deleted records. Used for data retention and reporting filters.',
    `annuity_payment_status` STRING COMMENT 'Current status of annuity (maintenance fee) payments across all family members. Current (all fees paid), Overdue (payment missed but within grace period), Grace_period (in statutory grace period), Lapsed (patent rights lost due to non-payment).. Valid values are `current|overdue|grace_period|lapsed`',
    `applicant_name` STRING COMMENT 'Legal name of the applicant (assignee) for the priority application. Typically the corporate entity owning the IP rights. Business-confidential.',
    `continuation_chain_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this family includes continuation, continuation-in-part, or divisional applications. True if continuation chain exists, False otherwise.',
    `cpc_class` STRING COMMENT 'Primary CPC classification code. Joint classification system developed by EPO and USPTO providing more granular technical categorization than IPC.. Valid values are `^[A-HY][0-9]{2}[A-Z][0-9]{1,4}/[0-9]{2,6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this patent family record was first created in the system. Audit trail for data lineage and compliance.',
    `divisional_chain_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this family includes divisional applications filed to pursue distinct inventions disclosed in a parent application. True if divisional chain exists, False otherwise.',
    `docketing_system_reference` STRING COMMENT 'External reference identifier in the IP docketing system (e.g., CPI, Foundation IP, Alt Legal) used for deadline management and prosecution tracking. Enables cross-system reconciliation.',
    `family_identifier` STRING COMMENT 'Externally-known unique identifier for the patent family, typically assigned by the IP management system or patent office. Used for cross-system reference and client communication.. Valid values are `^[A-Z0-9]{6,20}$`',
    `family_status` STRING COMMENT 'Current overall status of the patent family. Active (at least one granted and in-force patent), Pending (applications under prosecution), Expired (all patents reached end of term), Abandoned (all applications withdrawn or rejected), Lapsed (all patents lapsed due to non-payment).. Valid values are `active|pending|expired|abandoned|lapsed`',
    `family_type` STRING COMMENT 'Classification of the patent family structure. Simple (Paris Convention family sharing same priority), Extended (INPADOC family including all related applications), Complete (all documents sharing technical content).. Valid values are `simple|extended|complete`',
    `frand_obligation_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this patent family is subject to FRAND (Fair, Reasonable, and Non-Discriminatory) licensing obligations due to standard-essential patent (SEP) declarations. True if FRAND-encumbered, False otherwise.',
    `freedom_to_operate_status` STRING COMMENT 'Status of freedom-to-operate analysis for this patent family. Clear (no blocking patents identified), Risk_identified (potential infringement risk found), Under_review (FTO analysis in progress), Not_assessed (no FTO performed). Business-confidential strategic information.. Valid values are `clear|risk_identified|under_review|not_assessed`',
    `invention_title` STRING COMMENT 'The title of the invention as disclosed in the priority or representative application. Used for quick identification and portfolio reporting.',
    `inventor_names` STRING COMMENT 'Comma-separated list of inventor names as disclosed in the priority application. May be business-confidential depending on client agreement and jurisdiction disclosure requirements.',
    `ipc_class` STRING COMMENT 'Primary IPC classification code assigned to this patent family. Hierarchical classification system used worldwide for categorizing patent documents by technical field.. Valid values are `^[A-H][0-9]{2}[A-Z][0-9]{1,4}/[0-9]{2,6}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this patent family record was last updated. Critical for change tracking, audit compliance, and data synchronization.',
    `licensing_status` STRING COMMENT 'Current licensing posture of this patent family. Unlicensed (no active licenses), Exclusively_licensed (single licensee with exclusive rights), Non_exclusively_licensed (multiple licensees), Cross_licensed (licensed as part of cross-license agreement).. Valid values are `unlicensed|exclusively_licensed|non_exclusively_licensed|cross_licensed`',
    `litigation_involvement_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this patent family is currently or has been involved in patent litigation, opposition, or inter partes review proceedings. True if litigation history exists, False otherwise.',
    `member_jurisdiction_count` STRING COMMENT 'Total number of distinct jurisdictions (countries or patent offices) where patent applications or grants exist as members of this family. Indicates geographic breadth of protection.',
    `next_annuity_due_date` DATE COMMENT 'Earliest upcoming annuity or maintenance fee due date across all active family members. Critical for IP docketing and cash flow planning.',
    `opposition_count` STRING COMMENT 'Total number of opposition or post-grant review proceedings filed against patents in this family. Indicator of competitive interest and patent strength.',
    `pct_application_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this family includes a PCT international application. True if PCT route was used, False otherwise. Critical for understanding prosecution strategy and timeline.',
    `portfolio_valuation_amount` DECIMAL(18,2) COMMENT 'Estimated monetary value of this patent family based on valuation methodology (cost, market, income approach). Used for portfolio management, licensing negotiations, and financial reporting. Business-confidential.',
    `pph_eligibility_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this family is eligible for accelerated examination under Patent Prosecution Highway agreements based on allowance in a participating office. True if eligible, False otherwise.',
    `priority_application_number` STRING COMMENT 'The application number of the earliest filing (priority application) that establishes the priority date for this patent family. Format typically includes country code and serial number.. Valid values are `^[A-Z]{2}[0-9]{4,12}$`',
    `priority_country_code` STRING COMMENT 'ISO country code of the jurisdiction where the priority application was filed. Three-letter ISO 3166-1 alpha-3 format.. Valid values are `^[A-Z]{2,3}$`',
    `priority_date` DATE COMMENT 'The earliest filing date claimed by any member of this patent family. Critical for determining patent term, prior art cutoff, and prosecution strategy across jurisdictions.',
    `record_source_system` STRING COMMENT 'Name of the source system from which this patent family record originated (e.g., Elite 3E, IP docketing system, patent office data feed). Used for data lineage and reconciliation.',
    `standard_essential_patent_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this patent family has been declared as essential to one or more technical standards. True if declared as SEP, False otherwise.',
    `strategic_importance_rating` STRING COMMENT 'Business assessment of the strategic value of this patent family to the clients IP portfolio. Used for prioritization of prosecution spend, licensing strategy, and portfolio pruning decisions.. Valid values are `critical|high|medium|low`',
    `technology_area` STRING COMMENT 'Primary technology domain or field of invention based on International Patent Classification (IPC) or Cooperative Patent Classification (CPC) codes. Used for portfolio segmentation and landscape analysis.',
    `valuation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the portfolio valuation amount.. Valid values are `^[A-Z]{3}$`',
    `valuation_date` DATE COMMENT 'Date on which the portfolio valuation was performed or last updated. Critical for financial reporting and audit trail.',
    CONSTRAINT pk_patent_family PRIMARY KEY(`patent_family_id`)
) COMMENT 'Master record grouping related patent applications and grants that share a common priority claim into a patent family. Captures family identifier, priority application reference (earliest filing), priority date, family type (simple/Paris Convention, extended/INPADOC, complete), member jurisdiction count, technology area (IPC/CPC based), strategic importance rating, family status, and continuation/divisional chain indicators. Enables portfolio-level analysis, freedom-to-operate assessments, patent landscape mapping, and coordinated multi-jurisdictional prosecution strategy.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`valuation` (
    `valuation_id` BIGINT COMMENT 'Primary key for valuation',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or partner who approved the valuation for use in the matter.',
    `escrow_arrangement_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_arrangement. Business justification: IP valuations are frequently required for escrow arrangements in M&A transactions, licensing deals, or litigation settlements involving IP assets. Links valuation reports to escrow arrangements for do',
    `ip_asset_id` BIGINT COMMENT 'Reference to the IP asset being valued (patent, trademark, copyright, trade secret).',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: IP valuation is a specialized advisory service offering (M&A due diligence, portfolio valuation, damages analysis). Required for service line reporting, valuation service revenue tracking, and cross-s',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this valuation was conducted (M&A transaction, litigation, licensing negotiation).',
    `pitch_id` BIGINT COMMENT 'Foreign key linking to intake.pitch. Business justification: IP valuations performed during pitch phase (e.g., M&A due diligence pitches, portfolio valuation proposals) require linkage for pitch cost tracking, proposal deliverable tracking, and win/loss analysi',
    `profile_id` BIGINT COMMENT 'Reference to the client who owns or is acquiring the IP asset being valued.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Valuation assumptions (discount rates, royalty rates, useful life) create financial reporting risks (impairment, tax audit challenges) and transaction risks (purchase price disputes). Legal teams trac',
    `regulatory_return_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_return. Business justification: IP valuations are used in regulatory returns including tax filings (transfer pricing), financial reporting (FAS 141/142), customs valuations, and estate tax returns. Essential for linking valuation re',
    `amount` DECIMAL(18,2) COMMENT 'The determined fair market value of the IP asset as of the valuation date, expressed in the valuation currency.',
    `appraiser_credentials` STRING COMMENT 'Professional credentials of the appraiser (e.g., ASA, CFA, ABV, CVA) demonstrating qualification to perform IP valuations.',
    `appraiser_firm` STRING COMMENT 'Name of the valuation firm or organization that performed the IP valuation (e.g., Big Four accounting firm, boutique IP valuation consultancy).',
    `appraiser_name` STRING COMMENT 'Full name of the lead valuation professional who conducted the appraisal.',
    `approval_date` DATE COMMENT 'Date on which the valuation was formally approved by the responsible partner or client. Nullable if not yet approved.',
    `assumptions` STRING COMMENT 'Key assumptions underlying the valuation (e.g., revenue growth rates, market penetration, competitive landscape, technology obsolescence risk). Critical for understanding valuation limitations.',
    `comparable_transaction_count` STRING COMMENT 'Number of comparable market transactions used in market approach valuation. Nullable if market approach was not used.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the valuation record: public (publicly disclosed), internal (firm-wide access), confidential (matter team only), restricted (partner and client only).. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this valuation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the valuation amount is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_rate` DECIMAL(18,2) COMMENT 'The discount rate (expressed as a percentage) applied in income-based valuation methods to present-value future cash flows. Reflects risk-adjusted cost of capital.',
    `frand_consideration_flag` BOOLEAN COMMENT 'Indicates whether FRAND licensing obligations were factored into the valuation (relevant for standard-essential patents).',
    `limitations` STRING COMMENT 'Documented limitations or caveats of the valuation (e.g., limited market data, pending litigation, regulatory uncertainty, technology disruption risk).',
    `litigation_impact_adjustment` DECIMAL(18,2) COMMENT 'Adjustment amount (positive or negative) applied to valuation to account for pending or threatened litigation affecting the IP asset. Nullable if no litigation impact.',
    `methodology` STRING COMMENT 'The primary valuation approach applied: income approach (relief-from-royalty, discounted cash flow, excess earnings method), market approach (comparable transactions, guideline public company), or cost approach (replacement cost, reproduction cost). [ENUM-REF-CANDIDATE: income_approach|market_approach|cost_approach|relief_from_royalty|discounted_cash_flow|excess_earnings|comparable_transactions — 7 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this valuation record was last modified.',
    `of_asset` BIGINT COMMENT 'FK to ip.asset.asset_id — Valuations are performed on specific IP assets or asset groups. FK to asset enables portfolio valuation aggregation and trend analysis.',
    `portfolio_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total IP portfolio value represented by this asset, used for portfolio strategy and risk management.',
    `purpose` STRING COMMENT 'The business reason for conducting the valuation (M&A due diligence, licensing negotiation, litigation damages assessment, balance sheet reporting under ASC 350, portfolio strategy, tax planning, bankruptcy proceedings, or financing collateral). [ENUM-REF-CANDIDATE: mergers_and_acquisitions|licensing_negotiation|litigation_damages|balance_sheet_reporting|portfolio_strategy|tax_planning|bankruptcy|financing — 8 candidates stripped; promote to reference product]',
    `report_path` STRING COMMENT 'File path or document management system (DMS) reference to the full valuation report (typically stored in iManage Work or NetDocuments).',
    `revenue_projection_period_years` STRING COMMENT 'Number of years over which revenue projections were modeled in income approach valuation (typically 5-10 years).',
    `royalty_rate` DECIMAL(18,2) COMMENT 'The hypothetical royalty rate (expressed as a percentage of revenue) used in relief-from-royalty valuation method. Nullable if methodology does not use royalty rates.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system from which this valuation record originated (e.g., Elite 3E, external valuation firm system, Excel-based valuation model).',
    `tax_amortization_benefit_flag` BOOLEAN COMMENT 'Indicates whether the valuation incorporated tax amortization benefits (relevant for certain IP acquisitions under IRC Section 197).',
    `terminal_value_method` STRING COMMENT 'Method used to calculate terminal value in discounted cash flow analysis: perpetuity growth model, exit multiple, or none (if asset has finite life).. Valid values are `perpetuity_growth|exit_multiple|none`',
    `useful_life_years` STRING COMMENT 'The estimated remaining useful economic life of the IP asset in years, used for amortization and valuation projections.',
    `valuation_date` DATE COMMENT 'The as-of date for which the IP asset value was determined. Critical for M&A due diligence and financial reporting.',
    `valuation_number` STRING COMMENT 'Business identifier for the valuation engagement, typically assigned by the valuation firm or internal finance team.',
    `valuation_status` STRING COMMENT 'Current lifecycle status of the valuation: draft (in preparation), under_review (submitted for partner or client review), approved (finalized and accepted), rejected (not accepted), superseded (replaced by a newer valuation).. Valid values are `draft|under_review|approved|rejected|superseded`',
    CONSTRAINT pk_valuation PRIMARY KEY(`valuation_id`)
) COMMENT 'Transactional record of formal IP asset valuations conducted for purposes including M&A due diligence, licensing negotiations, balance sheet reporting, litigation damages, and portfolio strategy. Captures valuation date, valuation methodology (income approach, market approach, cost approach, relief-from-royalty), appraiser name, appraiser firm, valuation amount, currency, discount rate applied, useful life estimate, valuation purpose, and approval status.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`opposition_proceeding` (
    `opposition_proceeding_id` BIGINT COMMENT 'Unique identifier for the opposition proceeding record. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or timekeeper responsible for managing this opposition proceeding.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: IP opposition proceedings (trademark oppositions, patent challenges) often escalate to formal court litigation with a court docket. This FK links the IP proceeding to the court case. is_new_attribute=',
    `intake_engagement_scope_id` BIGINT COMMENT 'Foreign key linking to intake.intake_engagement_scope. Business justification: Opposition proceedings scoped during intake engagement definition require linkage for scope-to-deliverable tracking, estimated vs. actual cost reconciliation, and engagement scope change management wh',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Opposition proceedings (IPR, PTAB, trademark opposition) are specialized legal services with distinct pricing and delivery models. Needed for service delivery tracking, resource planning, and oppositi',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this opposition proceeding is managed.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified this opposition proceeding record.',
    `ip_asset_id` BIGINT COMMENT 'Reference to the IP asset being challenged in this opposition proceeding.',
    `primary_ip_asset_id` BIGINT COMMENT 'FK to ip.ip_asset.ip_asset_id — Every opposition/IPR/PGR proceeding challenges a specific IP asset. Critical for tracking validity challenges.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Opposition proceedings create litigation risk, cost overrun exposure, and asset loss risk (cancellation, claim narrowing). Legal teams track these in risk registers for budget forecasting, settlement ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Opposition proceedings trigger regulatory obligations including tribunal notifications, mandatory disclosure requirements, and procedural compliance with PTAB/EPO/national office rules. Essential for ',
    `research_memo_id` BIGINT COMMENT 'Foreign key linking to knowledge.research_memo. Business justification: Opposition and IPR proceedings require legal research memos analyzing validity, prior art, claim construction, and patentability. Links proceeding strategy to underlying research, supporting quality r',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who created this opposition proceeding record.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual total cost incurred for the opposition proceeding (legal fees, filing fees, expert witness fees).',
    `actual_cost_currency_code` STRING COMMENT 'Three-letter ISO currency code for the actual cost amount.',
    `appeal_court_name` STRING COMMENT 'Name of the appellate court or body handling the appeal (e.g., Federal Circuit, EPO Boards of Appeal).',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether an appeal has been filed following the tribunals decision.',
    `appeal_status` STRING COMMENT 'Current status of any appeal filed after the opposition decision.. Valid values are `not_filed|pending|decided|withdrawn`',
    `claim_amendments_proposed_flag` BOOLEAN COMMENT 'Indicates whether the patent owner has proposed amendments to the challenged claims during the proceeding.',
    `claims_at_issue` STRING COMMENT 'Specific patent claims or trademark goods/services classes being challenged in the opposition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this opposition proceeding record was first created in the system.',
    `decision_date` DATE COMMENT 'Date the tribunal issued its final decision on the opposition proceeding.',
    `decision_outcome` STRING COMMENT 'Final outcome of the opposition proceeding (e.g., patent claims maintained, revoked, amended; trademark registration cancelled or sustained).. Valid values are `maintained|revoked|amended|cancelled|dismissed|sustained`',
    `docketing_system_code` STRING COMMENT 'External identifier from the IP docketing or matter management system tracking this opposition proceeding.',
    `document_repository_path` STRING COMMENT 'File path or URI to the document repository folder containing all filings, evidence, and correspondence for this opposition proceeding.',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Estimated total cost to defend or prosecute the opposition proceeding.',
    `estimated_cost_currency_code` STRING COMMENT 'Three-letter ISO currency code for the estimated cost amount.',
    `filing_date` DATE COMMENT 'Date the opposition petition or notice of opposition was filed with the tribunal.',
    `grounds_of_challenge` STRING COMMENT 'Legal grounds cited for challenging the IP asset (e.g., anticipation, obviousness, non-use, descriptiveness, likelihood of confusion).',
    `hearing_date` DATE COMMENT 'Date of the oral hearing or oral proceedings before the tribunal.',
    `institution_date` DATE COMMENT 'Date the tribunal formally instituted the proceeding (applicable to IPR, PGR, CBM reviews).',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO country code or regional code for the jurisdiction where the opposition is filed (e.g., USA, EPO, GBR).',
    `lead_counsel_name` STRING COMMENT 'Name of the lead counsel representing the client in this opposition proceeding.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this opposition proceeding record was last modified.',
    `notes` STRING COMMENT 'Free-text notes capturing strategy, key developments, or internal commentary on the opposition proceeding.',
    `opposing_counsel_name` STRING COMMENT 'Name of the lead counsel representing the opposing party (petitioner or respondent).',
    `opposition_against_asset` BIGINT COMMENT 'FK to ip.asset.asset_id — Opposition proceedings challenge specific IP assets. Essential for portfolio risk assessment and defensive strategy.',
    `opposition_proceeding_status` STRING COMMENT 'Current lifecycle status of the opposition proceeding. [ENUM-REF-CANDIDATE: filed|instituted|pending|settled|decided|appealed|closed — 7 candidates stripped; promote to reference product]',
    `petitioner_name` STRING COMMENT 'Name of the party challenging the IP asset (petitioner in IPR/PGR, opponent in EPO opposition, opposer in trademark opposition).',
    `prior_art_references` STRING COMMENT 'List or summary of prior art references cited by the petitioner to challenge patent validity (e.g., patent numbers, publication citations).',
    `proceeding_number` STRING COMMENT 'Official proceeding number assigned by the tribunal or board (e.g., IPR2023-00123, Opposition No. 91234567).',
    `proceeding_type` STRING COMMENT 'Type of inter partes proceeding challenging the IP asset validity or registrability. [ENUM-REF-CANDIDATE: patent_opposition|inter_partes_review|post_grant_review|covered_business_method_review|trademark_opposition|cancellation_proceeding|invalidation_action — 7 candidates stripped; promote to reference product]',
    `respondent_name` STRING COMMENT 'Name of the party defending the IP asset (patent owner, trademark registrant).',
    `risk_assessment_level` STRING COMMENT 'Internal risk assessment level for the potential impact of this opposition on the IP portfolio.. Valid values are `low|medium|high|critical`',
    `settlement_date` DATE COMMENT 'Date the settlement agreement was executed or the proceeding was terminated by settlement.',
    `settlement_reached_flag` BOOLEAN COMMENT 'Indicates whether the parties reached a settlement agreement before final decision.',
    `strategic_importance` STRING COMMENT 'Strategic importance rating of the IP asset subject to opposition for the clients business or portfolio.. Valid values are `low|medium|high|critical`',
    `tribunal_name` STRING COMMENT 'Name of the tribunal, board, or office handling the opposition (e.g., PTAB, TTAB, EPO Opposition Division, EUIPO).',
    CONSTRAINT pk_opposition_proceeding PRIMARY KEY(`opposition_proceeding_id`)
) COMMENT 'Transactional record of inter partes proceedings challenging the validity or registrability of an IP asset. Covers patent oppositions (EPO), inter partes reviews (IPR), post-grant reviews (PGR), covered business method reviews, trademark oppositions (TTAB, EUIPO), cancellation proceedings, and invalidation actions. Captures proceeding type, tribunal or board (PTAB, TTAB, EPO Opposition Division), petitioner/opponent, patent owner/respondent, institution date, grounds of challenge (anticipation, obviousness, non-use, descriptiveness), claims at issue, claim amendments proposed, hearing dates, oral proceedings date, decision date, outcome (maintained, revoked, amended, cancelled), and appeal status. Supports portfolio risk assessment and defensive prosecution strategy.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`trade_secret` (
    `trade_secret_id` BIGINT COMMENT 'Unique identifier for the trade secret asset. Primary key for the trade secret master record.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or legal professional responsible for managing the legal protection strategy and compliance for this trade secret.',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: Trade secrets often contain personal data (employee inventions, customer lists, personnel know-how) requiring GDPR Article 30 registration. Essential for data protection compliance in trade secret man',
    `ip_asset_id` BIGINT COMMENT 'FK to ip.ip_asset.ip_asset_id — Trade secret extends ip_asset — every trade secret record MUST reference its parent ip_asset record.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Trade secret misappropriation litigation under DTSA/UTSA requires direct link from trade_secret to court docket. Essential for tracking enforcement actions, coordinating protective orders with confide',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this trade secret is managed, tracked, or litigated.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified this trade secret record in the system.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Trade secrets are managed by IP/trade secret practice groups. Needed for practice-level portfolio management, trade secret protection service delivery tracking, and practice-specific resource allocati',
    `profile_id` BIGINT COMMENT 'Reference to the client entity that owns or is associated with this trade secret asset.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Trade secrets face misappropriation risk, inadequate protection measures risk, and loss of secrecy through disclosure. Legal teams track these risks for reasonable measures compliance (DTSA/UTSA requi',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Trade secrets subject to regulatory obligations including DTSA notice requirements (18 USC 1833(b)), employment law disclosures, export control compliance (ITAR/EAR), and whistleblower protection prov',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who created this trade secret record in the system.',
    `access_control_measures` STRING COMMENT 'Detailed description of technical and administrative access control measures in place, including access control lists, role-based permissions, multi-factor authentication, and need-to-know protocols.',
    `asset_number` STRING COMMENT 'Business-facing unique identifier for the trade secret, typically formatted as TS- prefix followed by alphanumeric code. Used for external communication and portfolio tracking.. Valid values are `^TS-[A-Z0-9]{6,12}$`',
    `classification_type` STRING COMMENT 'High-level categorization of the trade secret by its business domain: technical (formulas, algorithms, designs), business (strategies, methods), customer (lists, preferences), financial (pricing, cost structures), operational (processes, procedures), or strategic (plans, forecasts).. Valid values are `technical|business|customer|financial|operational|strategic`',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for this trade secret: confidential (standard protection), highly confidential (elevated protection), or restricted (maximum protection with need-to-know access only).. Valid values are `confidential|highly confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this trade secret record was first created in the system.',
    `custodian_email` STRING COMMENT 'Primary email address of the designated custodian for communication regarding access requests and security matters.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `custodian_name` STRING COMMENT 'Name of the individual or department designated as the custodian responsible for safeguarding and controlling access to this trade secret.',
    `discovery_date` DATE COMMENT 'Date when the organization first recognized or documented this information as a trade secret requiring protection. May differ from creation date if the information existed before being classified as a trade secret.',
    `document_repository_path` STRING COMMENT 'File system path or document management system location where the trade secret documentation and supporting materials are stored.',
    `dtsa_protection_flag` BOOLEAN COMMENT 'Indicates whether this trade secret qualifies for protection under the federal Defend Trade Secrets Act (DTSA). True if DTSA protection applies, false otherwise.',
    `economic_value_amount` DECIMAL(18,2) COMMENT 'Estimated economic value or competitive advantage derived from this trade secret, expressed in monetary terms. Used for portfolio valuation and litigation damages assessment.',
    `economic_value_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the economic value amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `employee_access_count` STRING COMMENT 'Number of employees or contractors who currently have authorized access to this trade secret under need-to-know protocols.',
    `encryption_flag` BOOLEAN COMMENT 'Indicates whether the trade secret information is stored and transmitted using encryption. True if encryption is applied, false otherwise.',
    `encryption_method` STRING COMMENT 'Technical specification of the encryption algorithm and key strength used to protect the trade secret (e.g., AES-256, RSA-2048).',
    `extends_asset` BIGINT COMMENT 'FK to ip.asset.asset_id — Trade secret is a subtype extension of ip_asset. Must reference parent asset for portfolio-level reporting and ownership tracking.',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary legal jurisdiction under which this trade secret is protected (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `last_audit_date` DATE COMMENT 'Date of the most recent security audit or compliance review conducted for this trade secret to verify that reasonable protective measures are in place and effective.',
    `litigation_flag` BOOLEAN COMMENT 'Indicates whether this trade secret is currently or has been the subject of litigation, including misappropriation claims, ownership disputes, or injunctive relief proceedings. True if litigation exists, false otherwise.',
    `misappropriation_incident_count` STRING COMMENT 'Number of documented incidents of attempted or actual misappropriation, unauthorized disclosure, or security breaches involving this trade secret.',
    `misappropriation_risk_level` STRING COMMENT 'Assessment of the risk that this trade secret could be misappropriated, stolen, or improperly disclosed: low (minimal risk), medium (moderate risk), high (elevated risk), or critical (imminent or severe risk).. Valid values are `low|medium|high|critical`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this trade secret record was last modified or updated.',
    `multi_jurisdiction_flag` BOOLEAN COMMENT 'Indicates whether this trade secret is protected under the laws of multiple jurisdictions. True if multi-jurisdictional protection applies, false if single jurisdiction only.',
    `nda_count` STRING COMMENT 'Number of executed NDA agreements currently in force that cover access to this trade secret.',
    `nda_coverage_flag` BOOLEAN COMMENT 'Indicates whether access to this trade secret is governed by executed NDA agreements with all parties having access. True if NDA coverage is in place, false otherwise.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next periodic security audit or compliance review of protective measures for this trade secret.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context regarding the trade secret, its protection strategy, or related business considerations.',
    `owner_entity_name` STRING COMMENT 'Legal name of the entity (corporation, subsidiary, joint venture, or individual) that holds legal ownership rights to this trade secret.',
    `physical_security_measures` STRING COMMENT 'Description of physical security controls protecting the trade secret, including locked storage, restricted access areas, surveillance systems, and visitor controls.',
    `public_disclosure_risk_flag` BOOLEAN COMMENT 'Indicates whether there is a known risk that this trade secret may become publicly disclosed through reverse engineering, independent discovery, or other means. True if disclosure risk exists, false otherwise.',
    `reasonable_measures_documentation` STRING COMMENT 'Comprehensive documentation of all reasonable measures taken to maintain the secrecy of this information, as required for trade secret protection under DTSA and UTSA. Includes policies, procedures, training records, and enforcement actions.',
    `third_party_access_count` STRING COMMENT 'Number of external third parties (vendors, partners, consultants) who have been granted access to this trade secret under NDA or other contractual protections.',
    `title` STRING COMMENT 'Short descriptive title or name of the trade secret asset for identification and cataloging purposes.',
    `trade_secret_description` STRING COMMENT 'Detailed narrative description of the trade secret, including its nature, scope, and business application. May include proprietary formulas, processes, algorithms, customer lists, pricing methodologies, or other confidential business information.',
    `trade_secret_status` STRING COMMENT 'Current lifecycle status of the trade secret: active (currently protected and in use), inactive (no longer in active use but still protected), compromised (protection breached), disputed (subject to ownership or misappropriation dispute), under review (being evaluated for continued protection), or retired (no longer considered a trade secret).. Valid values are `active|inactive|compromised|disputed|under review|retired`',
    `utsa_protection_flag` BOOLEAN COMMENT 'Indicates whether this trade secret is protected under state-level Uniform Trade Secrets Act (UTSA) or equivalent state law. True if UTSA protection applies, false otherwise.',
    `valuation_date` DATE COMMENT 'Date when the economic value assessment was performed or last updated.',
    `creation_date` DATE COMMENT 'Date when the trade secret was first created, developed, or came into existence. Critical for establishing priority and duration of protection under DTSA and state UTSA equivalents.',
    CONSTRAINT pk_trade_secret PRIMARY KEY(`trade_secret_id`)
) COMMENT 'Master record for trade secret assets including proprietary formulas, manufacturing processes, algorithms, customer lists, pricing methodologies, and confidential business information protected under DTSA and state UTSA equivalents. Captures trade secret identifier, description, classification level (confidential, highly confidential, restricted), date of creation, owner entity, designated custodian, protective measures inventory (NDA coverage, access control lists, physical security, encryption, need-to-know protocols), last audit date, misappropriation risk level, and jurisdiction of protection. Supports trade secret portfolio management, reasonable measures documentation for litigation, and DTSA compliance.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`ip_agreement` (
    `ip_agreement_id` BIGINT COMMENT 'Unique identifier for the IP agreement record. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the attorney or legal professional responsible for managing this IP agreement.',
    `data_privacy_register_id` BIGINT COMMENT 'Foreign key linking to compliance.data_privacy_register. Business justification: IP agreements process personal data (party contact details, inventor information, confidential personnel data) requiring GDPR Article 30 registration. Essential for data protection compliance in IP co',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: IP agreements (NDAs, assignment agreements) negotiated during engagement opportunities require linkage for origination tracking, scope-to-deliverable mapping, and business development reporting on IP ',
    `legal_document_id` BIGINT COMMENT 'Unique identifier of the agreement document in the DMS (e.g., iManage Work or NetDocuments).',
    `matter_id` BIGINT COMMENT 'Identifier of the legal matter under which this IP agreement is managed.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user who last modified this IP agreement record.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: IP agreements (NDAs, assignment agreements, joint development agreements) reference standard form precedents. Links executed agreements to their template source, enabling precedent effectiveness track',
    `profile_id` BIGINT COMMENT 'Identifier of the client associated with this IP agreement.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: IP agreements (NDAs, assignments, joint development, material transfer) create contractual risks (breach, scope disputes), confidentiality risks (disclosure), and compliance risks (export control, ant',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: IP agreements (NDAs, assignments, joint development) trigger regulatory obligations including recordal requirements, antitrust notifications, foreign investment approvals, and export control complianc',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user who created this IP agreement record.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the IP agreement, used for reference and tracking.',
    `agreement_type` STRING COMMENT 'Classification of the IP agreement type. Distinguishes IP-specific agreements from general CLM contracts.. Valid values are `invention_assignment|confidentiality|co_ownership|joint_development|technology_transfer|ip_indemnification`',
    `arbitration_venue` STRING COMMENT 'The location or institution designated for arbitration proceedings, if applicable.',
    `assignment_rights` STRING COMMENT 'Description of rights to assign or transfer IP ownership or interests under the agreement.',
    `confidentiality_level` STRING COMMENT 'Data classification level of the agreement document itself.. Valid values are `public|internal|confidential|restricted`',
    `confidentiality_obligations` STRING COMMENT 'Specific confidentiality and non-disclosure obligations imposed by the agreement.',
    `counterparty_name` STRING COMMENT 'The primary external party or counterparty to the IP agreement.',
    `counterparty_type` STRING COMMENT 'Classification of the counterparty entity type.. Valid values are `individual|corporation|partnership|government|university|research_institution`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this IP agreement record was first created in the system.',
    `dispute_resolution_method` STRING COMMENT 'The agreed method for resolving disputes arising under the agreement. ADR = Alternative Dispute Resolution.. Valid values are `litigation|arbitration|mediation|adr`',
    `document_repository_path` STRING COMMENT 'File path or URI to the executed agreement document in the Document Management System (DMS).',
    `effective_date` DATE COMMENT 'The date on which the IP agreement becomes legally binding and enforceable.',
    `execution_date` DATE COMMENT 'The date on which the agreement was signed by all parties.',
    `execution_status` STRING COMMENT 'Indicates whether the agreement has been signed by all required parties.. Valid values are `not_executed|partially_executed|fully_executed`',
    `expiry_date` DATE COMMENT 'The date on which the IP agreement terminates or expires. Nullable for perpetual or open-ended agreements.',
    `frand_obligation_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes FRAND licensing obligations.',
    `governing_law` STRING COMMENT 'The jurisdiction and legal framework governing the interpretation and enforcement of the agreement.',
    `indemnification_terms` STRING COMMENT 'Summary of indemnification provisions, including scope and limitations.',
    `ip_agreement_description` STRING COMMENT 'Detailed narrative description of the IP agreement purpose, scope, and key terms.',
    `ip_agreement_status` STRING COMMENT 'Current lifecycle status of the IP agreement, indicating its operational state. [ENUM-REF-CANDIDATE: draft|pending_execution|executed|active|suspended|terminated|expired — 7 candidates stripped; promote to reference product]',
    `ip_assets_covered` STRING COMMENT 'Comma-separated list or description of the IP assets (patents, trademarks, copyrights, trade secrets) covered by this agreement.',
    `jurisdiction_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code or jurisdiction identifier for the governing law.',
    `key_obligations` STRING COMMENT 'Summary of the primary obligations and responsibilities of each party under the agreement.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this IP agreement record was last modified.',
    `nda_flag` BOOLEAN COMMENT 'Indicates whether this agreement includes or is a Non-Disclosure Agreement.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or internal notes regarding the agreement.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required for termination or non-renewal.',
    `party_names` STRING COMMENT 'Comma-separated list of all parties to the IP agreement, including legal entity names.',
    `pct_related_flag` BOOLEAN COMMENT 'Indicates whether the agreement relates to PCT patent applications or filings.',
    `renewal_terms` STRING COMMENT 'Description of automatic renewal provisions, notice periods, and renewal conditions.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this IP agreement data originated (e.g., Elite 3E, iManage Work).',
    `subtype` STRING COMMENT 'Further classification or specialization of the agreement type, capturing nuances within the primary type.',
    `termination_date` DATE COMMENT 'The actual date on which the agreement was terminated, if applicable.',
    `termination_terms` STRING COMMENT 'Conditions and procedures under which the agreement may be terminated by either party.',
    `title` STRING COMMENT 'The formal title or name of the IP agreement as it appears on the executed document.',
    CONSTRAINT pk_ip_agreement PRIMARY KEY(`ip_agreement_id`)
) COMMENT 'Master record for IP-specific agreements that are distinct from general CLM contracts, including invention assignment agreements, confidentiality agreements covering IP, co-ownership agreements, joint development agreements, technology transfer agreements, and IP indemnification agreements. Captures agreement type, parties, effective date, expiry date, IP assets covered, key obligations, governing law, and execution status. Complements the contract domain without duplicating general CLM records.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`copyright` (
    `copyright_id` BIGINT COMMENT 'Primary key for copyright',
    `attorney_profile_id` BIGINT COMMENT 'Foreign key reference to the attorney or legal professional responsible for managing this copyright asset. Links to the timekeeper or workforce master data.',
    `ip_asset_id` BIGINT COMMENT 'Foreign key reference to the parent IP asset record in the IP asset master table. Links this copyright to the broader IP portfolio management system.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Copyright infringement litigation requires direct link from copyright registration to court docket. Essential for tracking enforcement actions in federal court, coordinating DMCA takedowns with litiga',
    `matter_id` BIGINT COMMENT 'Foreign key reference to the legal matter under which this copyright is being managed. Links to the matter management system.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'The user ID or system identifier of the person or process that last modified this copyright record. Audit trail for accountability.',
    `profile_id` BIGINT COMMENT 'Foreign key reference to the client who owns or is the claimant of this copyright asset. Links to the client master data.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Copyrights face infringement risks, fair use challenges, work-for-hire disputes, and authorship challenges. Legal teams track these risks for enforcement strategy, licensing decisions, and professiona',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Copyright registrations have regulatory obligations including deposit copy requirements (Library of Congress), renewal filings (pre-1978 works), and mandatory registration for US litigation. Essential',
    `timekeeper_id` BIGINT COMMENT 'The user ID or system identifier of the person or process that created this copyright record. Audit trail for accountability.',
    `application_date` DATE COMMENT 'The date on which the copyright registration application was filed with the copyright office. Establishes priority and filing date for registration purposes.',
    `application_number` STRING COMMENT 'The application or case number assigned when the copyright registration application was filed. Used to track the application through the registration process.',
    `author_names` STRING COMMENT 'The name(s) of the individual(s) or entity(ies) who created the work. May include multiple authors separated by delimiters. Author information is critical for determining copyright ownership and duration.',
    `claimant_name` STRING COMMENT 'The name of the individual or entity claiming copyright ownership in the work. May differ from the author if rights have been transferred.',
    `confidentiality_level` STRING COMMENT 'Data classification level for this copyright record. Determines access controls and handling requirements for the copyright information.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this copyright record was first created in the system. Audit trail for record creation.',
    `deposit_copy_status` STRING COMMENT 'Status of the deposit copy requirement for copyright registration. Indicates whether the required copy of the work has been submitted to the copyright office.. Valid values are `submitted|pending|accepted|not_required|waived`',
    `derivative_work_flag` BOOLEAN COMMENT 'Indicates whether this work is a derivative work based on one or more preexisting works. Affects copyright scope and registration requirements.',
    `document_repository_path` STRING COMMENT 'File path or URI to the folder in the document management system (DMS) where all documents related to this copyright are stored. Links to iManage Work or NetDocuments.',
    `duration_years` STRING COMMENT 'The calculated duration of copyright protection in years from the date of creation or publication. Varies by jurisdiction and work type.',
    `enforcement_action_count` STRING COMMENT 'The total number of enforcement actions (cease and desist letters, litigation, takedown notices) taken to protect this copyright. Used for portfolio risk assessment.',
    `expiration_date` DATE COMMENT 'The date on which the copyright protection expires and the work enters the public domain. Calculated based on copyright duration rules.',
    `extends_asset` BIGINT COMMENT 'FK to ip.asset.asset_id — Copyright registration is a subtype extension of ip_asset. Must reference parent asset for portfolio management.',
    `fair_use_analysis_flag` BOOLEAN COMMENT 'Indicates whether a fair use analysis has been conducted for this work in relation to potential infringement claims. Relevant for enforcement strategy.',
    `infringement_detected_flag` BOOLEAN COMMENT 'Indicates whether any copyright infringement has been detected for this work. True if infringement monitoring has identified unauthorized use.',
    `jurisdiction_code` STRING COMMENT 'The country or jurisdiction code where the copyright is registered or claimed. Uses ISO 3166-1 alpha-3 country codes for standardization.',
    `licensing_status` STRING COMMENT 'Current licensing status of the copyright. Indicates whether the work is available for licensing and under what terms.. Valid values are `not_licensed|exclusively_licensed|non_exclusively_licensed|public_domain|creative_commons`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this copyright record was last modified or updated. Audit trail for record changes.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the copyright registration and management. Used for attorney work product and internal communications.',
    `office_name` STRING COMMENT 'The name of the copyright office or registration authority where the copyright is registered (e.g., U.S. Copyright Office, UK Intellectual Property Office).',
    `portfolio_category` STRING COMMENT 'Business classification or grouping of the copyright within the clients IP portfolio. Used for strategic portfolio management and reporting.',
    `preexisting_work_reference` STRING COMMENT 'Reference to the preexisting work(s) upon which this derivative work is based. Includes title, author, and registration information of the underlying work.',
    `registration_certificate_reference` STRING COMMENT 'Document reference or file path to the official copyright registration certificate issued by the copyright office. Links to the document management system (DMS).',
    `registration_date` DATE COMMENT 'The date on which the copyright registration was officially granted by the copyright office. Establishes the effective date of registration for enforcement purposes.',
    `registration_number` STRING COMMENT 'The official registration number assigned by the copyright office upon successful registration. Unique identifier for the registered copyright.',
    `registration_status` STRING COMMENT 'Current status of the copyright registration with the relevant copyright office. Indicates whether the work has formal registration protection.. Valid values are `registered|unregistered|pending|rejected|abandoned|cancelled`',
    `valuation_amount` DECIMAL(18,2) COMMENT 'The estimated monetary value of the copyright asset. Used for portfolio valuation, financial reporting, and transaction purposes.',
    `valuation_currency_code` STRING COMMENT 'The currency in which the valuation amount is expressed. Uses ISO 4217 three-letter currency codes.',
    `valuation_date` DATE COMMENT 'The date on which the copyright valuation was performed or last updated. Critical for financial reporting and portfolio management.',
    `work_description` STRING COMMENT 'Detailed description of the copyrighted work including its nature, content, and distinguishing characteristics. Used for identification and enforcement purposes.',
    `work_made_for_hire_flag` BOOLEAN COMMENT 'Indicates whether the work was created as a work made for hire, affecting copyright ownership and duration. True if the work was created by an employee within the scope of employment or under a written agreement.',
    `work_title` STRING COMMENT 'The title or name of the copyrighted work as registered or claimed. This is the primary human-readable identifier for the work.',
    `work_type` STRING COMMENT 'The category or type of copyrighted work. Classifies the work according to copyright law categories for registration and enforcement purposes. [ENUM-REF-CANDIDATE: literary|musical|dramatic|artistic|audiovisual|software|architectural|sound_recording|choreographic|pictorial_graphic_sculptural|compilation|derivative — 12 candidates stripped; promote to reference product]',
    `year_of_creation` STRING COMMENT 'The year in which the work was created or fixed in tangible form. Critical for determining copyright duration and term calculations.',
    `year_of_first_publication` STRING COMMENT 'The year in which the work was first published or made available to the public. Affects copyright duration and registration requirements.',
    CONSTRAINT pk_copyright PRIMARY KEY(`copyright_id`)
) COMMENT 'Master record for copyright assets including both registered and unregistered works managed by the firm on behalf of clients. Covers literary, musical, dramatic, artistic, audiovisual, and software works. Captures work title, work type, author(s), copyright claimant, year of creation, year of first publication, registration status (registered, unregistered, pending), registration number, registration date, jurisdiction, deposit copy status, registration certificate reference, and copyright duration. Extends ip_asset for copyright-specific portfolio management, enforcement readiness, and licensing support.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`enforcement_action` (
    `enforcement_action_id` BIGINT COMMENT 'Primary key for enforcement_action',
    `attorney_profile_id` BIGINT COMMENT 'Identifier of the attorney or legal professional responsible for managing this enforcement action. Links to workforce/timekeeper records.',
    `ip_asset_id` BIGINT COMMENT 'Identifier of the IP asset being protected through this enforcement action. Links to the IP asset registry.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: IP enforcement actions (cease & desist, infringement analysis, litigation referral) are billable legal services. Essential for service revenue tracking, enforcement service catalog management, and lin',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Enforcement actions (cease-and-desist, demand letters) frequently escalate to litigation. Direct link from enforcement_action to court docket tracks this escalation path, enables cost-benefit analysis',
    `matter_id` BIGINT COMMENT 'Identifier of the matter under which this enforcement action is tracked. Links to matter management system.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user who last modified this enforcement action record. Audit trail field.',
    `panel_appointment_id` BIGINT COMMENT 'Foreign key linking to intake.panel_appointment. Business justification: Enforcement actions initiated under panel appointments (clients on legal panels requesting enforcement services) require linkage for panel volume commitment tracking, panel rate card application, and ',
    `profile_id` BIGINT COMMENT 'Identifier of the client whose IP rights are being enforced. Links to the client master data.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Enforcement actions create litigation risk (counterclaims, invalidity challenges), cost exposure, and reputational risk. Legal teams track these in risk registers for budget management, settlement aut',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Enforcement actions trigger regulatory obligations including competition law notifications (abuse of dominance), consumer protection disclosures, and customs recordation requirements. Essential for en',
    `reputational_risk_id` BIGINT COMMENT 'Foreign key linking to risk.reputational_risk. Business justification: Enforcement actions against high-profile targets, in sensitive jurisdictions, or involving controversial IP (pharmaceutical patents, copyright takedowns) create reputational exposure requiring board n',
    `research_memo_id` BIGINT COMMENT 'Foreign key linking to knowledge.research_memo. Business justification: Enforcement actions (cease-and-desist, infringement claims) rely on research memos analyzing infringement theories, claim construction, defenses, and damages. Links enforcement strategy to legal resea',
    `sar_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.sar_filing. Business justification: Enforcement actions involving suspected money laundering (counterfeit goods trafficking, IP-based fraud schemes) trigger SAR filing obligations under AML regulations. Essential for linking IP enforcem',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: Settlement proceeds from IP infringement enforcement actions must be held in trust pending distribution to clients or resolution of disputes. Role-prefixed to distinguish from other trust account rela',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user who created this enforcement action record. Audit trail field.',
    `action_date` DATE COMMENT 'Date when the enforcement action was formally initiated or sent to the infringing party. Primary business event timestamp for this transaction.',
    `action_reference_number` STRING COMMENT 'Business identifier or reference number assigned to this enforcement action for tracking and communication purposes.',
    `confidentiality_level` STRING COMMENT 'Data classification level for this enforcement action record. Determines access controls and handling requirements.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enforcement action record was first created in the system. Audit trail field.',
    `document_repository_path` STRING COMMENT 'File path or URI to the document management system location where all enforcement action correspondence, evidence, and supporting documents are stored.',
    `enforcement_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for this enforcement action, including legal fees, filing fees, investigation costs, and other related expenses.',
    `enforcement_cost_currency_code` STRING COMMENT 'Three-letter ISO currency code for enforcement costs.. Valid values are `^[A-Z]{3}$`',
    `enforcement_protects_asset` BIGINT COMMENT 'FK to ip.asset.asset_id — Enforcement actions are initiated to protect specific IP assets. FK enables enforcement history tracking per asset.',
    `enforcement_status` STRING COMMENT 'Current lifecycle status of the enforcement action. Tracks progression from initiation through resolution or escalation. [ENUM-REF-CANDIDATE: initiated|pending_response|in_negotiation|escalated|resolved|withdrawn|referred_to_litigation — 7 candidates stripped; promote to reference product]',
    `enforcement_type` STRING COMMENT 'Type of enforcement action initiated. Includes cease-and-desist letters, customs recordal actions, domain name dispute filings (UDRP - Uniform Domain-Name Dispute-Resolution Policy), takedown notices (DMCA - Digital Millennium Copyright Act), and infringement litigation referrals.. Valid values are `cease_and_desist|customs_recordal|udrp|dmca_takedown|litigation_referral|settlement_negotiation`',
    `enforcement_venue` STRING COMMENT 'Specific venue, forum, or authority where the enforcement action is filed or pursued (e.g., WIPO Arbitration Center, USPTO, specific customs authority, domain registrar).',
    `infringement_type` STRING COMMENT 'Category of IP right being infringed. Aligns with the type of IP asset being protected.. Valid values are `patent|trademark|copyright|trade_secret|design_right|unfair_competition`',
    `infringing_activity_description` STRING COMMENT 'Detailed description of the alleged infringing activity, including nature of infringement, products or services involved, and evidence of unauthorized use of client IP.',
    `jurisdiction_code` STRING COMMENT 'Three-letter ISO country code representing the jurisdiction where the enforcement action is being pursued. Critical for determining applicable IP law and enforcement mechanisms.. Valid values are `^[A-Z]{3}$`',
    `litigation_referral_date` DATE COMMENT 'Date when the enforcement action was formally referred to litigation. Null if not escalated to litigation.',
    `litigation_referral_flag` BOOLEAN COMMENT 'Indicates whether this enforcement action was escalated and referred to formal litigation proceedings. Distinguishes pre-litigation enforcement from filed court cases.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this enforcement action record was last modified. Audit trail field for tracking changes.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, strategy considerations, or internal communications regarding this enforcement action.',
    `outcome` STRING COMMENT 'Final or current outcome of the enforcement action. Captures whether infringement ceased, settlement was reached, or matter escalated to litigation.. Valid values are `infringement_ceased|settlement_reached|litigation_filed|action_withdrawn|no_response|ongoing`',
    `practice_group_code` STRING COMMENT 'Code identifying the practice group handling this enforcement action, typically IP litigation or IP prosecution group.',
    `priority_level` STRING COMMENT 'Business priority assigned to this enforcement action based on strategic importance, potential damages, or client requirements.. Valid values are `critical|high|medium|low`',
    `response_deadline` DATE COMMENT 'Deadline by which the target party must respond to the enforcement action. Typically specified in cease-and-desist letters or formal notices.',
    `response_received_date` DATE COMMENT 'Date when a response was received from the target party, if any. Null if no response has been received.',
    `response_summary` STRING COMMENT 'Summary of the target partys response to the enforcement action, including their position, defenses raised, or willingness to negotiate.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Monetary value of settlement payment or damages recovered through this enforcement action, if applicable.',
    `settlement_currency_code` STRING COMMENT 'Three-letter ISO currency code for the settlement amount.. Valid values are `^[A-Z]{3}$`',
    `settlement_date` DATE COMMENT 'Date when settlement agreement was executed, if applicable. Null if no settlement was reached.',
    `settlement_reached_flag` BOOLEAN COMMENT 'Indicates whether a settlement agreement was reached with the target party as a result of this enforcement action.',
    `settlement_terms_summary` STRING COMMENT 'High-level summary of settlement terms, including monetary compensation, licensing arrangements, cessation commitments, or other negotiated outcomes. Detailed terms stored in settlement agreement documents.',
    `target_party_address` STRING COMMENT 'Physical or registered address of the target party for service of enforcement notices and legal correspondence.',
    `target_party_email` STRING COMMENT 'Email address of the target party used for electronic service of enforcement notices and communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `target_party_name` STRING COMMENT 'Name of the individual or organization alleged to be infringing the clients IP rights and targeted by this enforcement action.',
    CONSTRAINT pk_enforcement_action PRIMARY KEY(`enforcement_action_id`)
) COMMENT 'Transactional record of IP enforcement activities initiated to protect client IP rights, including cease-and-desist letters, customs recordal actions, domain name dispute filings (UDRP), takedown notices (DMCA), and infringement litigation referrals. Captures enforcement type, target party, infringing activity description, enforcement date, jurisdiction, outcome, settlement terms, and referral to litigation flag. Distinct from court domain litigation records which cover filed proceedings.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`asset_precedent_usage` (
    `asset_precedent_usage_id` BIGINT COMMENT 'Primary key for the asset_precedent_usage association',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to the IP asset that utilized the precedent document',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to the precedent document that was used',
    `adaptation_type` STRING COMMENT 'Classification of how extensively the precedent was modified for this specific IP asset usage (used as-is, minor edits, substantial customization, reference only). Explicitly identified in detection phase relationship data.',
    `attorney_name` STRING COMMENT 'Name of the attorney who applied this precedent to this IP asset, for knowledge management attribution and feedback loop purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this usage record was created in the knowledge management system.',
    `effectiveness_rating` DECIMAL(18,2) COMMENT 'Knowledge management effectiveness rating (0.00 to 5.00 scale) capturing attorney feedback on how well this precedent served the needs of this IP asset, used to refine precedent quality and relevance. Explicitly identified in detection phase relationship data.',
    `notes` STRING COMMENT 'Free-text notes capturing attorney observations, challenges encountered, or suggestions for precedent improvement based on this specific usage instance.',
    `sections_used` STRING COMMENT 'Comma-separated list or structured reference to which sections, clauses, or components of the precedent were utilized for this IP asset (e.g., claims template, abstract, background section). Explicitly identified in detection phase relationship data.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this usage record was last updated (e.g., effectiveness rating added post-completion).',
    `usage_context` STRING COMMENT 'The specific IP lifecycle stage or activity during which the precedent was used (e.g., initial filing, office action response, assignment agreement, licensing negotiation). Explicitly identified in detection phase relationship data.',
    `usage_date` DATE COMMENT 'The date on which this precedent was applied or referenced during the IP asset lifecycle (e.g., filing date, prosecution response date, assignment execution date). Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_asset_precedent_usage PRIMARY KEY(`asset_precedent_usage_id`)
) COMMENT 'This association product represents the usage event between an IP asset and a precedent document. It captures when and how a specific precedent template was applied during the lifecycle of an IP asset, including which sections were used, how they were adapted, and effectiveness ratings for knowledge management feedback loops. Each record links one IP asset to one precedent with attributes that exist only in the context of this specific usage instance.. Existence Justification: In legal practice, a single IP asset (patent, trademark, copyright) progresses through multiple lifecycle stages (filing, prosecution, assignment, licensing, maintenance) and may reference different precedent templates at each stage—a patent might use a filing template, then a prosecution response template, then an assignment agreement template. Conversely, a single precedent template (e.g., a standard office action response template) is reused across hundreds or thousands of IP assets. The relationship is operationally managed by knowledge management teams who track which precedents are used, how they are adapted, and their effectiveness to continuously improve the precedent library.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`asset_contact_assignment` (
    `asset_contact_assignment_id` BIGINT COMMENT 'Unique identifier for this contact-to-asset assignment record. Primary key.',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to the contact serving a role for this IP asset',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to the IP asset being managed',
    `assignment_notes` STRING COMMENT 'Free-text notes about this specific contact assignment, including special instructions, escalation procedures, or context.',
    `authority_level` STRING COMMENT 'The level of decision-making authority this contact has for instructions and approvals related to this IP asset.',
    `contact_role` STRING COMMENT 'The functional role this contact serves for this specific IP asset (e.g., inventor liaison, business owner, licensing manager, billing contact). A contact may serve different roles for different assets.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was created in the system.',
    `effective_date` DATE COMMENT 'The date from which this contact assignment became effective for this IP asset.',
    `expiry_date` DATE COMMENT 'The date on which this contact assignment expires or was terminated for this IP asset. Null indicates an active, ongoing assignment.',
    `is_primary_for_role` BOOLEAN COMMENT 'Indicates whether this contact is the primary contact for this specific role on this IP asset (e.g., primary billing contact vs. secondary billing contact).',
    `notification_preference` STRING COMMENT 'The contacts preference for receiving notifications about deadlines, annuities, and status changes for this specific IP asset.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this assignment record was last updated.',
    CONSTRAINT pk_asset_contact_assignment PRIMARY KEY(`asset_contact_assignment_id`)
) COMMENT 'This association product represents the role-based assignment between contacts and IP assets. It captures the operational relationship where contacts serve specific functions (inventor liaison, business owner, licensing manager, billing contact) for IP assets under management. Each record links one contact to one IP asset with role, notification preferences, authority level, and temporal validity that exist only in the context of this assignment.. Existence Justification: In legal IP practice management, a single IP asset requires multiple contacts serving different operational roles (inventor liaison for technical queries, business owner for strategic decisions, licensing manager for commercialization, billing contact for invoicing). Conversely, a single contact—especially in-house counsel or portfolio managers—is routinely assigned responsibility for multiple IP assets across a clients portfolio. This is an operational assignment that IP practice managers actively create, update, and terminate based on client organizational changes, matter staffing, and portfolio restructuring.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` (
    `patent_prosecution_assignment_id` BIGINT COMMENT 'Unique identifier for this patent prosecution assignment record. Primary key.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to the patent asset being prosecuted',
    `timekeeper_id` BIGINT COMMENT 'Foreign key linking to the timekeeper assigned to prosecution work',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this prosecution assignment. Tracks whether the timekeeper is actively working on the patent, temporarily paused, or has completed their work.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this assignment record was created in the system.',
    `end_date` DATE COMMENT 'The date the timekeepers active assignment to this patent prosecution matter ended. Null if the assignment is ongoing. Tracks the conclusion of the working relationship. This attribute was explicitly identified in the detection reasoning.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Cumulative billable and non-billable hours the timekeeper has recorded against this patent prosecution matter. Used for billing, workload analysis, and matter budgeting. This attribute was explicitly identified in the detection reasoning.',
    `primary_responsibility_flag` BOOLEAN COMMENT 'Indicates whether this timekeeper holds primary responsibility for this patent prosecution matter. Distinguishes the lead attorney or primary contact from supporting team members. This attribute was explicitly identified in the detection reasoning.',
    `prosecution_role` STRING COMMENT 'The specific role the timekeeper plays in this patent prosecution matter. Defines responsibility level and work type (e.g., Lead Attorney, Associate Attorney, Patent Agent, Paralegal). This attribute was explicitly identified in the detection reasoning.',
    `start_date` DATE COMMENT 'The date the timekeeper was assigned to work on this patent prosecution matter. Tracks the beginning of the working relationship. This attribute was explicitly identified in the detection reasoning.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this assignment record was last modified.',
    CONSTRAINT pk_patent_prosecution_assignment PRIMARY KEY(`patent_prosecution_assignment_id`)
) COMMENT 'This association product represents the assignment of timekeepers to patent prosecution matters. It captures the role-based participation of attorneys, patent agents, paralegals, and support staff in patent prosecution work. Each record links one patent to one timekeeper with attributes that exist only in the context of this working relationship, including prosecution role, time allocation, responsibility designation, and engagement period.. Existence Justification: Patent prosecution is a team-based legal process where multiple timekeepers (lead attorneys, associate attorneys, patent agents, paralegals, technical specialists) collaborate on a single patent application over its multi-year lifecycle, and each timekeeper typically works on dozens to hundreds of patents simultaneously. Law firms actively manage these assignments for staffing optimization, workload balancing, billing allocation, and expertise matching. The relationship itself carries operational data including prosecution role, hours worked, responsibility designation, and engagement period that cannot be attributed to either the patent or the timekeeper alone.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`royalty_report` (
    `royalty_report_id` BIGINT COMMENT 'Primary key for royalty_report',
    `employee_id` BIGINT COMMENT 'Reference to the internal user or role responsible for reviewing and approving this royalty report.',
    `ip_asset_id` BIGINT COMMENT 'Reference to the intellectual property asset (patent, trademark, copyright, trade secret) for which royalties are being reported.',
    `license_agreement_id` BIGINT COMMENT 'Reference to the license agreement under which this royalty report is generated.',
    `licensor_organisation_id` BIGINT COMMENT 'Reference to the party entitled to receive royalties under the license agreement.',
    `organisation_id` BIGINT COMMENT 'Reference to the party obligated to pay royalties under the license agreement.',
    `prior_royalty_report_id` BIGINT COMMENT 'Self-referencing FK on royalty_report (prior_royalty_report_id)',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Any adjustment amount applied to the royalty calculation due to corrections, credits, or prior period true-ups.',
    `adjustment_reason` STRING COMMENT 'Explanation for any adjustment applied to the royalty amount, including reference to prior periods or contractual provisions.',
    `approval_date` DATE COMMENT 'The date on which the royalty report was formally approved by the licensor.',
    `audit_completion_date` DATE COMMENT 'The date on which the audit of this royalty report was completed, if applicable.',
    `audit_flag` BOOLEAN COMMENT 'Indicates whether this royalty report has been flagged for audit or detailed review by the licensor.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this royalty report record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this royalty report.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the royalty report is currently under dispute between licensor and licensee.',
    `dispute_reason` STRING COMMENT 'Detailed explanation of the reason for dispute, if the report is flagged as disputed.',
    `due_date` DATE COMMENT 'The contractual deadline by which the royalty report must be submitted per the license agreement terms.',
    `gross_revenue_amount` DECIMAL(18,2) COMMENT 'Total gross revenue generated from the licensed intellectual property during the reporting period, before any deductions.',
    `minimum_royalty_amount` DECIMAL(18,2) COMMENT 'The contractual minimum royalty payment guaranteed per the license agreement, regardless of actual usage or sales.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this royalty report record was last modified or updated.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The final net amount paid to the licensor after all adjustments, deductions, and withholding taxes.',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Net revenue amount after contractually permitted deductions (returns, allowances, taxes) used as the royalty calculation base.',
    `payment_due_date` DATE COMMENT 'The contractual deadline by which the royalty payment must be remitted to the licensor.',
    `payment_received_date` DATE COMMENT 'The actual date on which the royalty payment was received by the licensor.',
    `payment_reference_number` STRING COMMENT 'External reference number or transaction identifier for the royalty payment, used for reconciliation.',
    `report_notes` STRING COMMENT 'Free-text notes or comments provided by the licensee to explain report details, unusual circumstances, or clarifications.',
    `report_number` STRING COMMENT 'Business identifier for the royalty report, typically used for external reference and tracking.',
    `report_status` STRING COMMENT 'Current lifecycle status of the royalty report indicating its position in the review and payment workflow.',
    `reporting_period_end_date` DATE COMMENT 'The end date of the period covered by this royalty report.',
    `reporting_period_start_date` DATE COMMENT 'The start date of the period covered by this royalty report.',
    `review_completion_date` DATE COMMENT 'The date on which the internal review of the royalty report was completed.',
    `royalty_amount_due` DECIMAL(18,2) COMMENT 'The calculated royalty payment amount owed by the licensee for the reporting period.',
    `royalty_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage rate applied to the royalty base to calculate the royalty amount owed, as specified in the license agreement.',
    `submission_date` DATE COMMENT 'The date on which the licensee submitted the royalty report to the licensor.',
    `territory_code` STRING COMMENT 'Geographic territory or jurisdiction code where the licensed IP was exploited and royalties were generated.',
    `units_sold` BIGINT COMMENT 'Total number of units sold or licensed that generated royalty obligations during the reporting period.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from the royalty payment per applicable tax treaty or local tax law.',
    `withholding_tax_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage rate of withholding tax applied to the royalty payment.',
    CONSTRAINT pk_royalty_report PRIMARY KEY(`royalty_report_id`)
) COMMENT 'Master reference table for royalty_report. Referenced by royalty_report_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `legal_ecm`.`ip`.`patent_family`(`patent_family_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_primary_patent_family_id` FOREIGN KEY (`primary_patent_family_id`) REFERENCES `legal_ecm`.`ip`.`patent_family`(`patent_family_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_to_ip_asset_id` FOREIGN KEY (`to_ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_to_patent_family_id` FOREIGN KEY (`to_patent_family_id`) REFERENCES `legal_ecm`.`ip`.`patent_family`(`patent_family_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_trademark_ip_asset_id` FOREIGN KEY (`trademark_ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `legal_ecm`.`ip`.`patent`(`patent_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_docket_deadline_triggered_by_event` FOREIGN KEY (`docket_deadline_triggered_by_event`) REFERENCES `legal_ecm`.`ip`.`prosecution_event`(`prosecution_event_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_docket_ip_asset_id` FOREIGN KEY (`docket_ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_docket_prosecution_event_id` FOREIGN KEY (`docket_prosecution_event_id`) REFERENCES `legal_ecm`.`ip`.`prosecution_event`(`prosecution_event_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_prosecution_event_id` FOREIGN KEY (`prosecution_event_id`) REFERENCES `legal_ecm`.`ip`.`prosecution_event`(`prosecution_event_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_royalty_report_id` FOREIGN KEY (`royalty_report_id`) REFERENCES `legal_ecm`.`ip`.`royalty_report`(`royalty_report_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_predecessor_ownership_id` FOREIGN KEY (`predecessor_ownership_id`) REFERENCES `legal_ecm`.`ip`.`ownership`(`ownership_id`);
ALTER TABLE `legal_ecm`.`ip`.`inventor` ADD CONSTRAINT `fk_ip_inventor_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `legal_ecm`.`ip`.`patent`(`patent_id`);
ALTER TABLE `legal_ecm`.`ip`.`valuation` ADD CONSTRAINT `fk_ip_valuation_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ADD CONSTRAINT `fk_ip_opposition_proceeding_primary_ip_asset_id` FOREIGN KEY (`primary_ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ADD CONSTRAINT `fk_ip_trade_secret_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ADD CONSTRAINT `fk_ip_enforcement_action_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ADD CONSTRAINT `fk_ip_asset_precedent_usage_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` ADD CONSTRAINT `fk_ip_asset_contact_assignment_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` ADD CONSTRAINT `fk_ip_patent_prosecution_assignment_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `legal_ecm`.`ip`.`patent`(`patent_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_report` ADD CONSTRAINT `fk_ip_royalty_report_ip_asset_id` FOREIGN KEY (`ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`ip_asset`(`ip_asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_report` ADD CONSTRAINT `fk_ip_royalty_report_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_report` ADD CONSTRAINT `fk_ip_royalty_report_prior_royalty_report_id` FOREIGN KEY (`prior_royalty_report_id`) REFERENCES `legal_ecm`.`ip`.`royalty_report`(`royalty_report_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm`.`ip` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `legal_ecm`.`ip` SET TAGS ('dbx_domain' = 'ip');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `knowledge_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Asset Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `annuity_amount` SET TAGS ('dbx_business_glossary_term' = 'Annuity Amount');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `annuity_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Annuity Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `annuity_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `annuity_due_date` SET TAGS ('dbx_business_glossary_term' = 'Annuity Due Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Number');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Type');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'patent|trademark|copyright|trade_secret|design_right|plant_variety');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `classification_code` SET TAGS ('dbx_business_glossary_term' = 'Classification Code');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `docketing_system_code` SET TAGS ('dbx_business_glossary_term' = 'Docketing System ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `document_repository_path` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Path');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `frand_declaration_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Reasonable and Non-Discriminatory (FRAND) Declaration Flag');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `inventor_names` SET TAGS ('dbx_business_glossary_term' = 'Inventor Names');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `inventor_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `ip_asset_description` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Description');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `ip_asset_status` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Status');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `ip_office_name` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Office Name');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `licensing_status` SET TAGS ('dbx_business_glossary_term' = 'Licensing Status');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `licensing_status` SET TAGS ('dbx_value_regex' = 'not_licensed|exclusively_licensed|non_exclusively_licensed|cross_licensed|frand_committed');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `opposition_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Opposition Filed Flag');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'IP Owner Name');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `pct_application_flag` SET TAGS ('dbx_business_glossary_term' = 'Patent Cooperation Treaty (PCT) Application Flag');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `portfolio_category` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Category');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `pph_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Patent Prosecution Highway (PPH) Request Flag');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `priority_date` SET TAGS ('dbx_business_glossary_term' = 'Priority Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Subtype');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `technology_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Area');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Title');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`ip_asset` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `legal_ecm`.`ip`.`patent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`ip`.`patent` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Identifier');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Identifier');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset Identifier');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `primary_patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Identifier');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `abstract` SET TAGS ('dbx_business_glossary_term' = 'Patent Abstract');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Patent Agent Name');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `annuity_due_date` SET TAGS ('dbx_business_glossary_term' = 'Annuity Due Date');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `annuity_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Annuity Payment Status');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `annuity_payment_status` SET TAGS ('dbx_value_regex' = 'current|overdue|paid|waived|lapsed');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Number');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `assignee_name` SET TAGS ('dbx_business_glossary_term' = 'Assignee Name');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `assignment_chain` SET TAGS ('dbx_business_glossary_term' = 'Assignment Chain');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `cpc_classification_codes` SET TAGS ('dbx_business_glossary_term' = 'Cooperative Patent Classification (CPC) Codes');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `estimated_portfolio_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Portfolio Value');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `estimated_portfolio_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `examiner_name` SET TAGS ('dbx_business_glossary_term' = 'Patent Examiner Name');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Expiry Date');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Filing Date');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `frand_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Reasonable and Non-Discriminatory (FRAND) Obligation Flag');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `grant_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Grant Date');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `independent_claims_count` SET TAGS ('dbx_business_glossary_term' = 'Independent Claims Count');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `inventor_id` SET TAGS ('dbx_business_glossary_term' = 'Inventor Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `ipc_classification_codes` SET TAGS ('dbx_business_glossary_term' = 'International Patent Classification (IPC) Codes');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `licensing_status` SET TAGS ('dbx_business_glossary_term' = 'Licensing Status');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `licensing_status` SET TAGS ('dbx_value_regex' = 'available|licensed|exclusively_licensed|cross_licensed|not_available');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `litigation_flag` SET TAGS ('dbx_business_glossary_term' = 'Litigation Flag');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `original_assignee_name` SET TAGS ('dbx_business_glossary_term' = 'Original Assignee Name');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `patent_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Number');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `patent_type` SET TAGS ('dbx_business_glossary_term' = 'Patent Type');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `patent_type` SET TAGS ('dbx_value_regex' = 'utility|design|plant');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `pct_application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Cooperation Treaty (PCT) Application Number');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `pph_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Patent Prosecution Highway (PPH) Eligible Flag');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `prior_art_references` SET TAGS ('dbx_business_glossary_term' = 'Prior Art References');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `priority_date` SET TAGS ('dbx_business_glossary_term' = 'Priority Date');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `prosecution_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Prosecution Status');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Publication Date');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `publication_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Publication Number');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `standard_essential_patent_flag` SET TAGS ('dbx_business_glossary_term' = 'Standard Essential Patent (SEP) Flag');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Patent Title');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `total_claims_count` SET TAGS ('dbx_business_glossary_term' = 'Total Claims Count');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `legal_ecm`.`ip`.`trademark` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`ip`.`trademark` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Identifier');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `trademark_ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset Identifier');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `annuity_amount` SET TAGS ('dbx_business_glossary_term' = 'Annuity Amount');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `annuity_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `annuity_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Annuity Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `application_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Application Serial Number');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `attorney_docket_number` SET TAGS ('dbx_business_glossary_term' = 'Attorney Docket Number');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `attorney_of_record` SET TAGS ('dbx_business_glossary_term' = 'Attorney of Record');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `color_claim` SET TAGS ('dbx_business_glossary_term' = 'Color Claim');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `disclaimer_text` SET TAGS ('dbx_business_glossary_term' = 'Disclaimer Text');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `filing_basis` SET TAGS ('dbx_business_glossary_term' = 'Filing Basis');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `filing_basis` SET TAGS ('dbx_value_regex' = 'use_in_commerce|intent_to_use|foreign_application|foreign_registration');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `first_use_anywhere_date` SET TAGS ('dbx_business_glossary_term' = 'First Use Anywhere Date');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `goods_services_description` SET TAGS ('dbx_business_glossary_term' = 'Goods and Services Description');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `goods_services_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `madrid_designated_countries` SET TAGS ('dbx_business_glossary_term' = 'Madrid Designated Countries');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `madrid_protocol_indicator` SET TAGS ('dbx_business_glossary_term' = 'Madrid Protocol Indicator');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `madrid_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Madrid Registration Number');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `mark_description` SET TAGS ('dbx_business_glossary_term' = 'Mark Description');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `mark_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `mark_text` SET TAGS ('dbx_business_glossary_term' = 'Mark Text');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `mark_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `mark_type` SET TAGS ('dbx_business_glossary_term' = 'Mark Type');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `mark_type` SET TAGS ('dbx_value_regex' = 'word_mark|device_mark|composite_mark|trade_dress|certification_mark|collective_mark');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `multi_class_indicator` SET TAGS ('dbx_business_glossary_term' = 'Multi-Class Indicator');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `nice_classification_codes` SET TAGS ('dbx_business_glossary_term' = 'Nice Classification Codes');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `opposition_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Opposition Period End Date');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `opposition_status` SET TAGS ('dbx_business_glossary_term' = 'Opposition Status');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `opposition_status` SET TAGS ('dbx_value_regex' = 'none|pending|sustained|dismissed');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `owner_address` SET TAGS ('dbx_business_glossary_term' = 'Owner Address');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `owner_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `owner_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Name');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `portfolio_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Valuation Amount');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `portfolio_valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `priority_claim_country` SET TAGS ('dbx_business_glossary_term' = 'Priority Claim Country');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `priority_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Priority Claim Date');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `specimen_of_use_description` SET TAGS ('dbx_business_glossary_term' = 'Specimen of Use Description');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `specimen_of_use_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `trademark_status` SET TAGS ('dbx_business_glossary_term' = 'Trademark Status');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `translation_text` SET TAGS ('dbx_business_glossary_term' = 'Translation Text');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `transliteration_text` SET TAGS ('dbx_business_glossary_term' = 'Transliteration Text');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `use_in_commerce_date` SET TAGS ('dbx_business_glossary_term' = 'Use in Commerce Date');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` SET TAGS ('dbx_subdomain' = 'prosecution_management');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `prosecution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Event Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Attorney Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `research_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Research Memo Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `rfp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Rfp Submission Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `art_unit` SET TAGS ('dbx_business_glossary_term' = 'Art Unit Code');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `attorney_of_record` SET TAGS ('dbx_business_glossary_term' = 'Attorney of Record Name');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `claims_allowed_count` SET TAGS ('dbx_business_glossary_term' = 'Claims Allowed Count');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `claims_rejected_count` SET TAGS ('dbx_business_glossary_term' = 'Claims Rejected Count');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `docketing_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Docketing Trigger Flag');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `estoppel_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Prosecution History Estoppel Risk Flag');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Event Date');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Event Type');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'office_action_received|response_filed|notice_of_allowance|final_rejection|restriction_requirement|appeal_filed');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `examiner_name` SET TAGS ('dbx_business_glossary_term' = 'Patent or Trademark Examiner Name');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `extension_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `extension_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Requested Flag');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Event Fee Amount');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Application Filing Date');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `interview_conducted_flag` SET TAGS ('dbx_business_glossary_term' = 'Examiner Interview Conducted Flag');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `interview_date` SET TAGS ('dbx_business_glossary_term' = 'Examiner Interview Date');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Event Notes');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `office_action_type` SET TAGS ('dbx_business_glossary_term' = 'Office Action Type');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `office_action_type` SET TAGS ('dbx_value_regex' = 'non_final|final|restriction|election|ex_parte_quayle|advisory');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `official_deadline` SET TAGS ('dbx_business_glossary_term' = 'Official Deadline Date');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Event Outcome');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'allowed|rejected|pending|withdrawn|abandoned|granted');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `prior_art_references` SET TAGS ('dbx_business_glossary_term' = 'Prior Art References');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `prosecution_stage` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Stage');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `prosecution_stage` SET TAGS ('dbx_value_regex' = 'examination|appeal|allowance|grant|post_grant|opposition');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `rejection_basis` SET TAGS ('dbx_business_glossary_term' = 'Rejection Basis Description');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline Date');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `response_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Response Filed Date');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `response_summary` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Response Summary');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` SET TAGS ('dbx_subdomain' = 'prosecution_management');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `docket_deadline_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Deadline Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `docket_ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `docket_prosecution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Event Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Docketing Clerk Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `calculated_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calculated Due Date');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `client_instruction_received_date` SET TAGS ('dbx_business_glossary_term' = 'Client Instruction Received Date');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `client_instruction_summary` SET TAGS ('dbx_business_glossary_term' = 'Client Instruction Summary');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `client_instruction_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `client_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Date');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `completion_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Completion Confirmation Number');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'pending|completed|missed|waived|abandoned');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `deadline_description` SET TAGS ('dbx_business_glossary_term' = 'Deadline Description');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `deadline_type` SET TAGS ('dbx_business_glossary_term' = 'Deadline Type');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `deadline_type` SET TAGS ('dbx_value_regex' = 'statutory|office_action_response|annuity_payment|renewal_payment|pct_national_phase_entry|opposition_filing');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `docket_system_code` SET TAGS ('dbx_business_glossary_term' = 'Docket System Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `escalation_notes` SET TAGS ('dbx_business_glossary_term' = 'Escalation Notes');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `escalation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `estimated_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `estimated_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `extended_due_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Due Date');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `extension_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Extension Fee Amount');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `extension_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Extension Fee Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `extension_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `extension_fee_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Fee Required Flag');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `missed_deadline_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Missed Deadline Escalation Flag');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `missed_deadline_flag` SET TAGS ('dbx_business_glossary_term' = 'Missed Deadline Flag');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `reminder_schedule` SET TAGS ('dbx_business_glossary_term' = 'Reminder Schedule');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `statutory_rule_reference` SET TAGS ('dbx_business_glossary_term' = 'Statutory Rule Reference');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` SET TAGS ('dbx_subdomain' = 'commercial_licensing');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `ip_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `created_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `created_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `created_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Ledger Entry Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `regulatory_return_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Return Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Approved By ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Agent Name');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Approval Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `audit_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Adjustment Flag');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `audit_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Audit Adjustment Reason');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `ip_office_code` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Office Code');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `jurisdiction_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `late_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Flag');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `late_payment_surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Surcharge Amount');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|credit_card|check|ach|direct_debit|electronic_funds_transfer');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|partially_reconciled|disputed');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `royalty_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Base Amount');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `royalty_base_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `royalty_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Royalty Period End Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `royalty_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Royalty Period Start Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` SET TAGS ('dbx_subdomain' = 'commercial_licensing');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Identifier');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `third_party_risk_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Risk Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `amendment_history` SET TAGS ('dbx_business_glossary_term' = 'Amendment History');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `audit_rights` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `confidentiality_terms` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Terms');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Mechanism');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `dispute_resolution_mechanism` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|adr');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Location');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `exclusivity_terms` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Terms');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'draft|under_negotiation|executed|pending_signature|terminated|expired');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `field_of_use` SET TAGS ('dbx_business_glossary_term' = 'Field of Use');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `fixed_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Fixed Royalty Amount');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `frand_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Reasonable and Non-Discriminatory (FRAND) Obligation Flag');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `improvement_rights` SET TAGS ('dbx_business_glossary_term' = 'Improvement Rights');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `indemnification_terms` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Terms');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `key_obligations` SET TAGS ('dbx_business_glossary_term' = 'Key Obligations');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `licensed_ip_assets` SET TAGS ('dbx_business_glossary_term' = 'Licensed Intellectual Property (IP) Assets');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `licensee_name` SET TAGS ('dbx_business_glossary_term' = 'Licensee Name');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `licensor_name` SET TAGS ('dbx_business_glossary_term' = 'Licensor Name');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `performance_milestones` SET TAGS ('dbx_business_glossary_term' = 'Performance Milestones');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `practice_group_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Code');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `royalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Royalty Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `royalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `royalty_structure` SET TAGS ('dbx_business_glossary_term' = 'Royalty Structure');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `royalty_structure` SET TAGS ('dbx_value_regex' = 'fixed_fee|running_royalty|milestone_based|lump_sum|hybrid|royalty_free');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `sublicensing_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Permitted Flag');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `termination_provisions` SET TAGS ('dbx_business_glossary_term' = 'Termination Provisions');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Territory');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` SET TAGS ('dbx_subdomain' = 'commercial_licensing');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `royalty_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Receipt Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `regulatory_return_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Return Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `royalty_report_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Report Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `audit_findings` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Flag');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `calculated_royalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Calculated Royalty Amount');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `frand_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Reasonable and Non-Discriminatory (FRAND) Obligation Flag');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `payment_direction` SET TAGS ('dbx_business_glossary_term' = 'Payment Direction');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `payment_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|electronic_funds_transfer|other');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `payment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Period End Date');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `payment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Period Start Date');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|cleared|failed|reversed|disputed');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|partially_reconciled|disputed');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `royalty_base_amount` SET TAGS ('dbx_business_glossary_term' = 'Royalty Base Amount');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `royalty_base_type` SET TAGS ('dbx_business_glossary_term' = 'Royalty Base Type');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `legal_ecm`.`ip`.`ownership` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`ip`.`ownership` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `ownership_id` SET TAGS ('dbx_business_glossary_term' = 'Ownership Identifier');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset ID');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `predecessor_ownership_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Ownership ID');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `assignment_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Assignment Document Reference');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `assignment_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Ownership Basis');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `beneficial_owner_identifier` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Identifier');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `beneficial_owner_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `beneficial_owner_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `beneficial_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Name');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `beneficial_owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `beneficial_owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_business_glossary_term' = 'Consideration Amount');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `consideration_currency` SET TAGS ('dbx_business_glossary_term' = 'Consideration Currency');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `consideration_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `frand_commitment_reference` SET TAGS ('dbx_business_glossary_term' = 'Fair Reasonable and Non-Discriminatory (FRAND) Commitment Reference');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `frand_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Reasonable and Non-Discriminatory (FRAND) Obligation Flag');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `is_current_owner` SET TAGS ('dbx_business_glossary_term' = 'Is Current Owner');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `joint_ownership_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Ownership Flag');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `license_back_flag` SET TAGS ('dbx_business_glossary_term' = 'License Back Flag');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `license_back_terms` SET TAGS ('dbx_business_glossary_term' = 'License Back Terms');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `license_back_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Ownership Notes');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_address` SET TAGS ('dbx_business_glossary_term' = 'Owner Address');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Email');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Phone');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_country_code` SET TAGS ('dbx_business_glossary_term' = 'Owner Country Code');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Entity Name');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Owner Type');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `owner_type` SET TAGS ('dbx_value_regex' = 'individual_inventor|corporate_assignee|joint_owner|government|university|trust');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `ownership_status` SET TAGS ('dbx_business_glossary_term' = 'Ownership Status');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `ownership_status` SET TAGS ('dbx_value_regex' = 'active|pending|transferred|terminated|disputed|lapsed');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `recordal_date` SET TAGS ('dbx_business_glossary_term' = 'Recordal Date');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `recordal_number` SET TAGS ('dbx_business_glossary_term' = 'Recordal Number');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `security_interest_description` SET TAGS ('dbx_business_glossary_term' = 'Security Interest Description');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `security_interest_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `security_interest_flag` SET TAGS ('dbx_business_glossary_term' = 'Security Interest Flag');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Ownership Verification Status');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|unverified|disputed');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm`.`ip`.`inventor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`ip`.`inventor` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `inventor_id` SET TAGS ('dbx_business_glossary_term' = 'Inventor Identifier');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `assignment_executed_flag` SET TAGS ('dbx_business_glossary_term' = 'Assignment Executed Flag');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `assignment_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Execution Date');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `assignment_recordation_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Recordation Number');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `conception_date` SET TAGS ('dbx_business_glossary_term' = 'Invention Conception Date');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `contribution_description` SET TAGS ('dbx_business_glossary_term' = 'Inventor Contribution Description');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `deceased_date` SET TAGS ('dbx_business_glossary_term' = 'Inventor Deceased Date');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `derivation_proceeding_number` SET TAGS ('dbx_business_glossary_term' = 'Derivation Proceeding Number');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Inventor Email Address');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `employer_at_invention` SET TAGS ('dbx_business_glossary_term' = 'Employer at Time of Invention');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `employment_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Employment Agreement Reference');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `family_name` SET TAGS ('dbx_business_glossary_term' = 'Inventor Family Name');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `family_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `full_legal_name` SET TAGS ('dbx_business_glossary_term' = 'Inventor Full Legal Name');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `full_legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `full_legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `given_name` SET TAGS ('dbx_business_glossary_term' = 'Inventor Given Name');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `given_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `given_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `invention_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Invention Disclosure Date');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `inventor_status` SET TAGS ('dbx_business_glossary_term' = 'Inventor Status');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `inventor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deceased|unlocatable|disputed');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `inventorship_dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventorship Dispute Flag');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `joint_inventor_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint Inventor Flag');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `legal_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Representative Name');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_business_glossary_term' = 'Inventor Nationality Country Code');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `oath_declaration_date` SET TAGS ('dbx_business_glossary_term' = 'Oath or Declaration Execution Date');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `oath_declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Oath or Declaration Status');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `oath_declaration_status` SET TAGS ('dbx_value_regex' = 'executed|pending|substitute_statement_filed|not_required');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `orcid_identifier` SET TAGS ('dbx_business_glossary_term' = 'ORCID (Open Researcher and Contributor ID) Identifier');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `orcid_identifier` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}-d{4}-d{3}[0-9X]$');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Inventor Phone Number');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `prior_art_disclosure_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Art Disclosure Obligation Flag');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Inventor Residence Address Line 1');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Inventor Residence Address Line 2');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_city` SET TAGS ('dbx_business_glossary_term' = 'Inventor Residence City');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_country_code` SET TAGS ('dbx_business_glossary_term' = 'Inventor Residence Country Code');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Inventor Residence Postal Code');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_state_province` SET TAGS ('dbx_business_glossary_term' = 'Inventor Residence State or Province');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`inventor` ALTER COLUMN `residence_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `abstract_text` SET TAGS ('dbx_business_glossary_term' = 'Patent Abstract Text');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `active_indicator` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator Flag');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `annuity_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Annuity Payment Status');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `annuity_payment_status` SET TAGS ('dbx_value_regex' = 'current|overdue|grace_period|lapsed');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `applicant_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Legal Name');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `applicant_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `continuation_chain_indicator` SET TAGS ('dbx_business_glossary_term' = 'Continuation Chain Indicator Flag');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `cpc_class` SET TAGS ('dbx_business_glossary_term' = 'Cooperative Patent Classification (CPC) Class Code');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `cpc_class` SET TAGS ('dbx_value_regex' = '^[A-HY][0-9]{2}[A-Z][0-9]{1,4}/[0-9]{2,6}$');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `divisional_chain_indicator` SET TAGS ('dbx_business_glossary_term' = 'Divisional Application Chain Indicator Flag');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `docketing_system_reference` SET TAGS ('dbx_business_glossary_term' = 'IP Docketing System Reference Identifier');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `family_identifier` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Business Identifier');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `family_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `family_status` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Lifecycle Status');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `family_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|abandoned|lapsed');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `family_type` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Type Classification');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `family_type` SET TAGS ('dbx_value_regex' = 'simple|extended|complete');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `frand_obligation_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fair Reasonable and Non-Discriminatory (FRAND) Obligation Indicator');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `freedom_to_operate_status` SET TAGS ('dbx_business_glossary_term' = 'Freedom to Operate (FTO) Assessment Status');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `freedom_to_operate_status` SET TAGS ('dbx_value_regex' = 'clear|risk_identified|under_review|not_assessed');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `freedom_to_operate_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `invention_title` SET TAGS ('dbx_business_glossary_term' = 'Invention Title');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `inventor_names` SET TAGS ('dbx_business_glossary_term' = 'Inventor Names List');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `inventor_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `ipc_class` SET TAGS ('dbx_business_glossary_term' = 'International Patent Classification (IPC) Class Code');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `ipc_class` SET TAGS ('dbx_value_regex' = '^[A-H][0-9]{2}[A-Z][0-9]{1,4}/[0-9]{2,6}$');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `licensing_status` SET TAGS ('dbx_business_glossary_term' = 'Licensing Status');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `licensing_status` SET TAGS ('dbx_value_regex' = 'unlicensed|exclusively_licensed|non_exclusively_licensed|cross_licensed');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `litigation_involvement_indicator` SET TAGS ('dbx_business_glossary_term' = 'Litigation Involvement Indicator Flag');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `member_jurisdiction_count` SET TAGS ('dbx_business_glossary_term' = 'Member Jurisdiction Count');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `next_annuity_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Annuity Payment Due Date');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `opposition_count` SET TAGS ('dbx_business_glossary_term' = 'Opposition Proceeding Count');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `pct_application_indicator` SET TAGS ('dbx_business_glossary_term' = 'Patent Cooperation Treaty (PCT) Application Indicator');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `portfolio_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Valuation Amount');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `portfolio_valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `pph_eligibility_indicator` SET TAGS ('dbx_business_glossary_term' = 'Patent Prosecution Highway (PPH) Eligibility Indicator');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `priority_application_number` SET TAGS ('dbx_business_glossary_term' = 'Priority Application Reference Number');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `priority_application_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{4,12}$');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `priority_country_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Filing Country Code');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `priority_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `priority_date` SET TAGS ('dbx_business_glossary_term' = 'Priority Filing Date');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System Name');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `standard_essential_patent_indicator` SET TAGS ('dbx_business_glossary_term' = 'Standard Essential Patent (SEP) Indicator');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `strategic_importance_rating` SET TAGS ('dbx_business_glossary_term' = 'Strategic Importance Rating');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `strategic_importance_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `technology_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Classification Area');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Assessment Date');
ALTER TABLE `legal_ecm`.`ip`.`valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`ip`.`valuation` SET TAGS ('dbx_subdomain' = 'commercial_licensing');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Identifier');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Attorney ID');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset ID');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `pitch_id` SET TAGS ('dbx_business_glossary_term' = 'Pitch Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `regulatory_return_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Return Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `appraiser_credentials` SET TAGS ('dbx_business_glossary_term' = 'Appraiser Credentials');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `appraiser_firm` SET TAGS ('dbx_business_glossary_term' = 'Appraiser Firm');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `appraiser_name` SET TAGS ('dbx_business_glossary_term' = 'Appraiser Name');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `assumptions` SET TAGS ('dbx_business_glossary_term' = 'Valuation Assumptions');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `assumptions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `comparable_transaction_count` SET TAGS ('dbx_business_glossary_term' = 'Comparable Transaction Count');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `discount_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `frand_consideration_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Reasonable and Non-Discriminatory (FRAND) Consideration Flag');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `limitations` SET TAGS ('dbx_business_glossary_term' = 'Valuation Limitations');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `limitations` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `litigation_impact_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Litigation Impact Adjustment');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `litigation_impact_adjustment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Valuation Methodology');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `portfolio_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Allocation Percentage');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Valuation Purpose');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `report_path` SET TAGS ('dbx_business_glossary_term' = 'Valuation Report Document Path');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `report_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `revenue_projection_period_years` SET TAGS ('dbx_business_glossary_term' = 'Revenue Projection Period (Years)');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `royalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `tax_amortization_benefit_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Amortization Benefit Flag');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `terminal_value_method` SET TAGS ('dbx_business_glossary_term' = 'Terminal Value Method');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `terminal_value_method` SET TAGS ('dbx_value_regex' = 'perpetuity_growth|exit_multiple|none');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `valuation_number` SET TAGS ('dbx_business_glossary_term' = 'Valuation Reference Number');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `legal_ecm`.`ip`.`valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|superseded');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` SET TAGS ('dbx_subdomain' = 'prosecution_management');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `opposition_proceeding_id` SET TAGS ('dbx_business_glossary_term' = 'Opposition Proceeding Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `intake_engagement_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Engagement Scope Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `research_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Research Memo Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `actual_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `appeal_court_name` SET TAGS ('dbx_business_glossary_term' = 'Appeal Court Name');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_filed|pending|decided|withdrawn');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `claim_amendments_proposed_flag` SET TAGS ('dbx_business_glossary_term' = 'Claim Amendments Proposed Flag');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `claims_at_issue` SET TAGS ('dbx_business_glossary_term' = 'Claims at Issue');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Decision Outcome');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_value_regex' = 'maintained|revoked|amended|cancelled|dismissed|sustained');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `docketing_system_code` SET TAGS ('dbx_business_glossary_term' = 'Docketing System Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `document_repository_path` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Path');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Amount');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `estimated_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Opposition Filing Date');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `grounds_of_challenge` SET TAGS ('dbx_business_glossary_term' = 'Grounds of Challenge');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Hearing Date');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `institution_date` SET TAGS ('dbx_business_glossary_term' = 'Institution Date');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `lead_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Counsel Name');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Opposition Proceeding Notes');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `opposing_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Opposing Counsel Name');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `opposition_proceeding_status` SET TAGS ('dbx_business_glossary_term' = 'Opposition Proceeding Status');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `petitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Petitioner or Opponent Name');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `petitioner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `prior_art_references` SET TAGS ('dbx_business_glossary_term' = 'Prior Art References');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `proceeding_number` SET TAGS ('dbx_business_glossary_term' = 'Opposition Proceeding Number');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `proceeding_type` SET TAGS ('dbx_business_glossary_term' = 'Opposition Proceeding Type');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `respondent_name` SET TAGS ('dbx_business_glossary_term' = 'Respondent or Patent Owner Name');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `respondent_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Level');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `risk_assessment_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `settlement_reached_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reached Flag');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_business_glossary_term' = 'Strategic Importance');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`opposition_proceeding` ALTER COLUMN `tribunal_name` SET TAGS ('dbx_business_glossary_term' = 'Tribunal or Board Name');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `trade_secret_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Secret Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `access_control_measures` SET TAGS ('dbx_business_glossary_term' = 'Access Control Measures');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Secret Asset Number');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^TS-[A-Z0-9]{6,12}$');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `classification_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Secret Classification Type');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `classification_type` SET TAGS ('dbx_value_regex' = 'technical|business|customer|financial|operational|strategic');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'confidential|highly confidential|restricted');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `custodian_email` SET TAGS ('dbx_business_glossary_term' = 'Custodian Email Address');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `custodian_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `custodian_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `custodian_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `custodian_name` SET TAGS ('dbx_business_glossary_term' = 'Designated Custodian Name');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `custodian_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Secret Discovery Date');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `document_repository_path` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Path');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `document_repository_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `dtsa_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Defend Trade Secrets Act (DTSA) Protection Flag');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `economic_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Economic Value Amount');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `economic_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `economic_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Economic Value Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `economic_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `employee_access_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Access Count');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `encryption_flag` SET TAGS ('dbx_business_glossary_term' = 'Encryption Flag');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `encryption_method` SET TAGS ('dbx_business_glossary_term' = 'Encryption Method');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `litigation_flag` SET TAGS ('dbx_business_glossary_term' = 'Litigation Flag');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `misappropriation_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Misappropriation Incident Count');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `misappropriation_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Misappropriation Risk Level');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `misappropriation_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `multi_jurisdiction_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Jurisdiction Flag');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `nda_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Count');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `nda_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Coverage Flag');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `owner_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Entity Name');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `physical_security_measures` SET TAGS ('dbx_business_glossary_term' = 'Physical Security Measures');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `public_disclosure_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Risk Flag');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `reasonable_measures_documentation` SET TAGS ('dbx_business_glossary_term' = 'Reasonable Measures Documentation');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `third_party_access_count` SET TAGS ('dbx_business_glossary_term' = 'Third Party Access Count');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Trade Secret Title');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `trade_secret_description` SET TAGS ('dbx_business_glossary_term' = 'Trade Secret Description');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `trade_secret_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `trade_secret_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Secret Status');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `trade_secret_status` SET TAGS ('dbx_value_regex' = 'active|inactive|compromised|disputed|under review|retired');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `utsa_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Uniform Trade Secrets Act (UTSA) Protection Flag');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `legal_ecm`.`ip`.`trade_secret` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Secret Creation Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` SET TAGS ('dbx_subdomain' = 'commercial_licensing');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `ip_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Agreement ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `data_privacy_register_id` SET TAGS ('dbx_business_glossary_term' = 'Data Privacy Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'invention_assignment|confidentiality|co_ownership|joint_development|technology_transfer|ip_indemnification');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `arbitration_venue` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Venue');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `assignment_rights` SET TAGS ('dbx_business_glossary_term' = 'Assignment Rights');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `confidentiality_obligations` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Obligations');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_value_regex' = 'individual|corporation|partnership|government|university|research_institution');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|adr');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `document_repository_path` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Path');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `execution_status` SET TAGS ('dbx_value_regex' = 'not_executed|partially_executed|fully_executed');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `frand_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Reasonable and Non-Discriminatory (FRAND) Obligation Flag');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `indemnification_terms` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Terms');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `ip_agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Description');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `ip_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `ip_assets_covered` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Assets Covered');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `key_obligations` SET TAGS ('dbx_business_glossary_term' = 'Key Obligations');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `nda_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Flag');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `party_names` SET TAGS ('dbx_business_glossary_term' = 'Party Names');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `pct_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Patent Cooperation Treaty (PCT) Related Flag');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Agreement Subtype');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `termination_terms` SET TAGS ('dbx_business_glossary_term' = 'Termination Terms');
ALTER TABLE `legal_ecm`.`ip`.`ip_agreement` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Agreement Title');
ALTER TABLE `legal_ecm`.`ip`.`copyright` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`ip`.`copyright` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `copyright_id` SET TAGS ('dbx_business_glossary_term' = 'Copyright Identifier');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney ID');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset ID');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `author_names` SET TAGS ('dbx_business_glossary_term' = 'Author Names');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `author_names` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `author_names` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `claimant_name` SET TAGS ('dbx_business_glossary_term' = 'Copyright Claimant Name');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `claimant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `claimant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `deposit_copy_status` SET TAGS ('dbx_business_glossary_term' = 'Deposit Copy Status');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `deposit_copy_status` SET TAGS ('dbx_value_regex' = 'submitted|pending|accepted|not_required|waived');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `derivative_work_flag` SET TAGS ('dbx_business_glossary_term' = 'Derivative Work Flag');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `document_repository_path` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Path');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `duration_years` SET TAGS ('dbx_business_glossary_term' = 'Copyright Duration Years');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `enforcement_action_count` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Count');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `fair_use_analysis_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Use Analysis Flag');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `infringement_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Infringement Detected Flag');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `licensing_status` SET TAGS ('dbx_business_glossary_term' = 'Licensing Status');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `licensing_status` SET TAGS ('dbx_value_regex' = 'not_licensed|exclusively_licensed|non_exclusively_licensed|public_domain|creative_commons');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `office_name` SET TAGS ('dbx_business_glossary_term' = 'Copyright Office Name');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `portfolio_category` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Category');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `preexisting_work_reference` SET TAGS ('dbx_business_glossary_term' = 'Preexisting Work Reference');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `registration_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Registration Certificate Reference');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'registered|unregistered|pending|rejected|abandoned|cancelled');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `work_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `work_made_for_hire_flag` SET TAGS ('dbx_business_glossary_term' = 'Work Made for Hire Flag');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `work_title` SET TAGS ('dbx_business_glossary_term' = 'Work Title');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `work_type` SET TAGS ('dbx_business_glossary_term' = 'Work Type');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `year_of_creation` SET TAGS ('dbx_business_glossary_term' = 'Year of Creation');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `year_of_first_publication` SET TAGS ('dbx_business_glossary_term' = 'Year of First Publication');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` SET TAGS ('dbx_subdomain' = 'prosecution_management');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `enforcement_action_id` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Identifier');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney ID');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset ID');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `panel_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Panel Appointment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `reputational_risk_id` SET TAGS ('dbx_business_glossary_term' = 'Reputational Risk Flag Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `research_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Research Memo Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `sar_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Sar Filing Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `action_date` SET TAGS ('dbx_business_glossary_term' = 'Action Date');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `action_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Action Reference Number');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `document_repository_path` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Path');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `enforcement_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Cost Amount');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `enforcement_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `enforcement_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Cost Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `enforcement_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Status');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `enforcement_type` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Type');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `enforcement_type` SET TAGS ('dbx_value_regex' = 'cease_and_desist|customs_recordal|udrp|dmca_takedown|litigation_referral|settlement_negotiation');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `enforcement_venue` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Venue');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `infringement_type` SET TAGS ('dbx_business_glossary_term' = 'Infringement Type');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `infringement_type` SET TAGS ('dbx_value_regex' = 'patent|trademark|copyright|trade_secret|design_right|unfair_competition');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `infringing_activity_description` SET TAGS ('dbx_business_glossary_term' = 'Infringing Activity Description');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `infringing_activity_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `litigation_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Litigation Referral Date');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `litigation_referral_flag` SET TAGS ('dbx_business_glossary_term' = 'Litigation Referral Flag');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Notes');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Outcome');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'infringement_ceased|settlement_reached|litigation_filed|action_withdrawn|no_response|ongoing');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `practice_group_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Code');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `response_received_date` SET TAGS ('dbx_business_glossary_term' = 'Response Received Date');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `response_summary` SET TAGS ('dbx_business_glossary_term' = 'Response Summary');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `response_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `settlement_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `settlement_reached_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Reached Flag');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `settlement_terms_summary` SET TAGS ('dbx_business_glossary_term' = 'Settlement Terms Summary');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `settlement_terms_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `target_party_address` SET TAGS ('dbx_business_glossary_term' = 'Target Party Address');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `target_party_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `target_party_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `target_party_email` SET TAGS ('dbx_business_glossary_term' = 'Target Party Email Address');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `target_party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `target_party_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `target_party_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `target_party_name` SET TAGS ('dbx_business_glossary_term' = 'Target Party Name');
ALTER TABLE `legal_ecm`.`ip`.`enforcement_action` ALTER COLUMN `target_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` SET TAGS ('dbx_subdomain' = 'prosecution_management');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` SET TAGS ('dbx_association_edges' = 'ip.asset,knowledge.precedent');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ALTER COLUMN `asset_precedent_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Precedent Usage - Asset Precedent Usage Id');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Precedent Usage - Ip Asset Id');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Precedent Usage - Precedent Id');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ALTER COLUMN `adaptation_type` SET TAGS ('dbx_business_glossary_term' = 'Adaptation Type');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ALTER COLUMN `attorney_name` SET TAGS ('dbx_business_glossary_term' = 'Attorney Name');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ALTER COLUMN `attorney_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Rating');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Usage Notes');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ALTER COLUMN `sections_used` SET TAGS ('dbx_business_glossary_term' = 'Sections Used');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `legal_ecm`.`ip`.`asset_precedent_usage` ALTER COLUMN `usage_date` SET TAGS ('dbx_business_glossary_term' = 'Usage Date');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` SET TAGS ('dbx_subdomain' = 'prosecution_management');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` SET TAGS ('dbx_association_edges' = 'client.contact,ip.asset');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` ALTER COLUMN `asset_contact_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Contact Assignment Identifier');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Contact Assignment - Contact Id');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Contact Assignment - Ip Asset Id');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` ALTER COLUMN `authority_level` SET TAGS ('dbx_business_glossary_term' = 'Authority Level');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role for IP Asset');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Date');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Expiry Date');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` ALTER COLUMN `is_primary_for_role` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag for Role');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `legal_ecm`.`ip`.`asset_contact_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` SET TAGS ('dbx_subdomain' = 'prosecution_management');
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` SET TAGS ('dbx_association_edges' = 'ip.patent,workforce.timekeeper');
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` ALTER COLUMN `patent_prosecution_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Prosecution Assignment ID');
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Prosecution Assignment - Patent Id');
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Prosecution Assignment - Timekeeper Id');
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` ALTER COLUMN `primary_responsibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Responsibility Flag');
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` ALTER COLUMN `prosecution_role` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Role');
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `legal_ecm`.`ip`.`patent_prosecution_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`royalty_report` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`ip`.`royalty_report` SET TAGS ('dbx_subdomain' = 'commercial_licensing');
ALTER TABLE `legal_ecm`.`ip`.`royalty_report` ALTER COLUMN `royalty_report_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Report Identifier');
ALTER TABLE `legal_ecm`.`ip`.`royalty_report` ALTER COLUMN `prior_royalty_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
