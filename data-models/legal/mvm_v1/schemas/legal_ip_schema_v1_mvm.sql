-- Schema for Domain: ip | Business: Legal | Version: v1_mvm
-- Generated on: 2026-05-07 14:36:19

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm`.`ip` COMMENT 'Manages the intellectual property portfolio lifecycle including patent prosecution (PCT, PPH), trademark registration, copyright registration, trade secrets, licensing, FRAND obligations, and IP docketing deadlines. Serves as SSOT for all IP assets, annuity payments, portfolio valuation, and IP ownership records across all jurisdictions.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`asset` (
    `asset_id` BIGINT COMMENT 'Unique identifier for the intellectual property asset. Primary key for the IP asset master record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: IP assets frequently require dedicated trust accounts for holding annuity payments, licensing royalties, settlement proceeds, or security deposits. Essential for tracking fund sources for IP maintenan',
    `matter_id` BIGINT COMMENT 'Identifier of the matter under which this IP asset is managed.',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: IP portfolio management and annuity payment processing requires the asset owner to be a linked client organisation for billing, regulatory filings, and ownership recordal. owner_name is a denormalized',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: IP assets are managed within specific practice areas (patent prosecution, trademark, IP litigation) for resource allocation, conflict checking, and practice-level portfolio reporting. Essential for pr',
    `profile_id` BIGINT COMMENT 'Identifier of the client who owns this intellectual property asset.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: IP assets generate inherent risks (infringement exposure, invalidity challenges, loss of rights through missed deadlines, valuation uncertainty) that legal teams track in risk registers for portfolio ',
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
    CONSTRAINT pk_asset PRIMARY KEY(`asset_id`)
) COMMENT 'Master record for every intellectual property asset managed by the firm on behalf of clients, including patents, trademarks, copyrights, trade secrets, and design rights. Serves as the SSOT for IP asset identity, type, status, jurisdiction, ownership, filing dates, registration numbers, and portfolio classification. Anchors all downstream IP lifecycle, docketing, annuity, and licensing records.';

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`patent` (
    `patent_id` BIGINT COMMENT 'Unique identifier for the patent asset record. Primary key for the patent data product.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.contract_agreement. Business justification: Patent assignment and technology transfer agreements are named, distinct business processes in IP law. Patent records must reference the governing contract_agreement for assignment chain tracking, due',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Patent prosecution and portfolio management requires the assignee to be a linked client organisation for assignment recordal, conflict checks, and ownership chain reporting. assignee_name is a denorma',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Patents filed as part of engagement opportunities (e.g., patent portfolio development engagements) require linkage for origination credit allocation, engagement scope tracking, and business developmen',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Patents are managed under specific legal services (prosecution, maintenance, licensing). A direct patent→legal_service link supports portfolio-level service assignment reporting and billing analysis w',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Patent infringement and validity litigation requires direct tracking from patent to court docket. Essential for monitoring enforcement actions, calculating patent portfolio risk, and coordinating pros',
    `judgment_id` BIGINT COMMENT 'Foreign key linking to matter.judgment. Business justification: Invalidity, infringement, and damages judgments directly determine patent enforceability, licensing status, and portfolio valuation. Patent portfolio managers require direct linkage to the controlling',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this patent prosecution work is managed. Links patent activities to time tracking, billing, and case management.',
    `asset_id` BIGINT COMMENT 'Reference to the parent IP asset record. Links this patent to the broader IP asset portfolio.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Patents are managed by patent prosecution practice groups. Required for practice-level revenue reporting, staffing models, and expertise-based matter routing in legal practice management systems.',
    `patent_family_id` BIGINT COMMENT 'Identifier linking this patent to its patent family - a group of related patent applications filed in multiple jurisdictions claiming the same priority. Enables portfolio-level analysis and management.',
    `profile_id` BIGINT COMMENT 'Reference to the client who owns or is associated with this patent asset. Links the patent to the client master record for billing, matter management, and portfolio reporting.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Patents face prosecution risks (rejection, abandonment), opposition risks, invalidity challenges, and enforcement risks. Legal teams track these in risk registers for client advisories, portfolio stra',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Patents with SEP/FRAND flags and export-controlled technology must be linked to the specific regulatory obligation (e.g., ETSI FRAND declaration rules, export control regulations) governing them. IP c',
    `to_ip_asset_id` BIGINT COMMENT 'FK to ip.ip_asset.ip_asset_id — Patent extends ip_asset — every patent record MUST reference its parent ip_asset record. This is the fundamental inheritance/extension FK that connects the type-specific detail to the master asset rec',
    `to_patent_family_id` BIGINT COMMENT 'FK to ip.patent_family.patent_family_id — Every patent belongs to a patent family (or is a singleton family). This FK enables family-level portfolio analysis and prosecution strategy.',
    `abstract` STRING COMMENT 'A concise summary of the invention disclosed in the patent, typically 150-250 words, providing a high-level overview of the technical problem and solution.',
    `agent_name` STRING COMMENT 'The name of the registered patent agent or patent attorney who is prosecuting the patent application before the patent office.',
    `annuity_due_date` DATE COMMENT 'The next scheduled date for payment of patent maintenance fees (annuities) to keep the patent in force. Missing this deadline can result in patent lapse.',
    `annuity_payment_status` STRING COMMENT 'Current status of the patent maintenance fee (annuity) payment. Tracks whether fees are current, overdue, or if the patent has lapsed due to non-payment.. Valid values are `current|overdue|paid|waived|lapsed`',
    `application_number` STRING COMMENT 'The official application number assigned when the patent application was filed (e.g., US16/123,456, PCT/US2020/012345).',
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
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.contract_agreement. Business justification: Trademark co-existence agreements, consent-to-use agreements, and assignment agreements are named business processes requiring direct reference to the governing contract_agreement. Trademark counsel r',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Trademark prosecution, registration, renewal, and opposition proceedings are distinct legal services. Linking trademark assets directly to the legal service supports service-level billing, matter inta',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Trademark opposition, cancellation, and infringement litigation requires direct link from trademark to court docket. Essential for tracking TTAB proceedings that escalate to district court, monitoring',
    `judgment_id` BIGINT COMMENT 'Foreign key linking to matter.judgment. Business justification: Trademark cancellation, infringement, and dilution judgments directly affect trademark registration status, renewal eligibility, and portfolio valuation. Brand managers and IP counsel require direct l',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this trademark prosecution is being handled. Links to Elite 3E matter management.',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Trademark registration, renewal, and enforcement requires the owner to be a linked client organisation for watch notices, conflict searches, and regulatory filings. owner_name and owner_address are de',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Trademarks are managed by trademark practice groups. Essential for practice-level billing allocation, capacity planning, and trademark-specific service delivery tracking in law firm operations.',
    `profile_id` BIGINT COMMENT 'Reference to the client who owns or is prosecuting this trademark. Essential for client matter management and billing.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Trademarks are subject to jurisdiction-specific regulatory obligations (Madrid Protocol filing rules, use requirements, renewal mandates). IP counsel managing trademark compliance portfolios needs to ',
    `asset_id` BIGINT COMMENT 'FK to ip.ip_asset.ip_asset_id — Trademark extends ip_asset — every trademark record MUST reference its parent ip_asset record. Same inheritance pattern as patent.',
    `trademark_asset_id` BIGINT COMMENT 'Reference to the parent IP asset record. Links this trademark to the broader IP portfolio management system.',
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
    `asset_id` BIGINT COMMENT 'FK to ip.ip_asset.ip_asset_id — Every prosecution event occurs against a specific IP asset (patent or trademark application). This is the core transactional-to-master FK.',
    `fee_arrangement_id` BIGINT COMMENT 'Foreign key linking to billing.billing_fee_arrangement. Business justification: Prosecution events (office action responses, examinations) trigger billing under specific fee arrangements (flat fee per response, capped prosecution budgets). Linking prosecution events to the govern',
    `legal_document_id` BIGINT COMMENT 'Reference to the internal document management system record for the official communication or response document associated with this prosecution event.',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Each prosecution event (office action response, amendment filing, interview) represents delivery of a specific legal service. Critical for service delivery tracking, billing reconciliation, SLA compli',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this prosecution event is managed.',
    `patent_id` BIGINT COMMENT 'Reference to the patent or trademark application to which this prosecution event belongs.',
    `order_id` BIGINT COMMENT 'Foreign key linking to matter.order. Business justification: Court orders (ITC exclusion orders, PTAB institution decisions, district court claim construction orders) directly trigger prosecution events such as reexamination requests, IPR petitions, or prosecut',
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
    `prosecution_event_id` BIGINT COMMENT 'FK to ip.prosecution_event.prosecution_event_id — Many deadlines are triggered by prosecution events (e.g., office action received triggers response deadline). This FK enables automated deadline calculation from prosecution events.',
    `order_id` BIGINT COMMENT 'Foreign key linking to matter.order. Business justification: Court orders frequently set or modify IP docket deadlines (e.g., ITC procedural orders, PTAB scheduling orders, district court orders extending prosecution response deadlines). IP docketing teams must',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Docket deadlines are tied to specific service deliverables (file response, pay annuity, file renewal). Essential for SLA tracking, service delivery management, and linking deadline compliance to servi',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to ip.license_agreement. Business justification: Docket deadlines are not limited to prosecution events — license agreements have critical docketed deadlines including renewal dates, expiry dates, audit rights windows, performance milestone deadline',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or prosecution file associated with this deadline.',
    `asset_id` BIGINT COMMENT 'Reference to the IP asset (patent, trademark, copyright, trade secret) to which this deadline applies.',
    `primary_docket_prosecution_event_id` BIGINT COMMENT 'Foreign key linking to ip.prosecution_event. Business justification: Docket deadlines are triggered by prosecution events (office actions, examiner responses, etc.). A single prosecution event can generate multiple deadlines (response deadline, appeal deadline, etc.). ',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Missed or at-risk deadlines create professional indemnity exposure, loss of IP rights, and client relationship damage. Legal teams track high-risk deadlines (short timeframes, complex filings, resourc',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Docket deadlines are statutory deadlines mandated by specific regulatory obligations (PCT national phase entry rules, annuity payment regulations). IP docketing teams need to trace each deadline to it',
    `sla_template_id` BIGINT COMMENT 'Foreign key linking to service.sla_template. Business justification: IP docketing SLA templates define response time targets and escalation thresholds that directly govern deadline calculation and client notification obligations. Linking docket_deadline to sla_template',
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
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.account. Business justification: IP annuity and filing fee payment reconciliation requires knowing which trust account funded each payment. Trust accounting rules mandate direct account traceability on every disbursement. ip_payment.',
    `asset_id` BIGINT COMMENT 'Reference to the IP asset (patent, trademark, copyright, trade secret) associated with this payment.',
    `billing_disbursement_id` BIGINT COMMENT 'Foreign key linking to billing.billing_disbursement. Business justification: IP official fee payments (annuities, filing fees) are processed as billing disbursements and recovered from clients. Linking ip_payment to billing_disbursement supports reconciliation of IP fee paymen',
    `disbursement_authorization_id` BIGINT COMMENT 'Foreign key linking to trust.disbursement_authorization. Business justification: Every IP fee payment disbursed from a trust account requires a disbursement authorization under bar rules and IOLTA regulations. Linking ip_payment to disbursement_authorization supports the authoriza',
    `docket_deadline_id` BIGINT COMMENT 'Foreign key linking to ip.docket_deadline. Business justification: IP payments (annuity payments, maintenance fees, renewal fees) are directly triggered by docket deadlines. The docket_deadline record establishes the due date and statutory requirement; the ip_payment',
    `ledger_entry_id` BIGINT COMMENT 'Foreign key linking to trust.trust_ledger_entry. Business justification: Annuity and royalty payments for IP assets are commonly disbursed from trust accounts. Links IP payment records to specific trust ledger entries for three-way reconciliation, regulatory compliance (IO',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: IP annuity and filing fee payments are administered under specific legal services (e.g., IP portfolio management, patent prosecution). Linking ip_payment to legal_service enables service-level cost tr',
    `license_agreement_id` BIGINT COMMENT 'Reference to the license agreement associated with this payment, if applicable for royalty or milestone payments.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case associated with this IP payment, if applicable. Links payment to matter management for cost tracking and billing.',
    `profile_id` BIGINT COMMENT 'Reference to the client or IP owner on whose behalf the payment is made or to whom the payment is attributed.',
    `prosecution_event_id` BIGINT COMMENT 'Foreign key linking to ip.prosecution_event. Business justification: IP payments are frequently triggered by specific prosecution events — filing fees, issue fees, appeal fees, and extension fees are all tied to discrete prosecution actions. The ip_payment table alread',
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
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.contract_agreement. Business justification: IP license agreements are a specific type of contract agreement. Legal operations require linking the IP-specific license record to the governing contract_agreement for obligation tracking, billing, d',
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Law firms must conduct AML/KYC due diligence on counterparties to licensing transactions under anti-money laundering regulations. Linking each license agreement to the applicable AML/KYC program enabl',
    `asset_id` BIGINT COMMENT 'FK to ip.asset.asset_id — License agreements grant rights to specific IP assets. This is a many-to-many relationship but the FK from license to asset (or junction) is essential for portfolio encumbrance analysis.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: License disputes (breach, royalty calculation, scope interpretation, FRAND obligations) frequently result in litigation. Direct link from license_agreement to court docket tracks these disputes, enabl',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: License agreements negotiated during engagement opportunities (licensing deal origination) require linkage for origination credit, opportunity-to-revenue tracking, and business development pipeline re',
    `escrow_arrangement_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_arrangement. Business justification: High-value IP licenses frequently use escrow for source code deposits, technology transfer security, or payment guarantees. Links license agreements to escrow arrangements for tracking release conditi',
    `order_id` BIGINT COMMENT 'Foreign key linking to matter.order. Business justification: Court orders mandating or modifying license terms (e.g., compulsory license orders, injunction-lifted-upon-licensing orders, FRAND rate-setting orders) must be tracked against the license agreement fo',
    `judgment_id` BIGINT COMMENT 'Foreign key linking to matter.judgment. Business justification: Court-ordered licenses (compulsory licensing, FRAND determinations, settlement judgments) require linking the license agreement to the originating judgment for enforcement monitoring, compliance track',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: License agreement drafting and negotiation is a distinct legal service offering in IP practices. Required for service catalog management, cross-selling analytics, and linking licensing work to service',
    `letter_of_engagement_id` BIGINT COMMENT 'Foreign key linking to intake.letter_of_engagement. Business justification: A letter of engagement formally authorizes the firm to negotiate and draft a license agreement, defining scope and fees. Legal operations require linking the LOE to the resulting license agreement for',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: IP licensing practice requires tracking the licensee as a proper client organisation FK for conflict checks, KYC compliance, royalty reporting, and panel management. licensee_name is a denormalized re',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this IP license agreement is managed.',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to ip.patent_family. Business justification: Portfolio license agreements in IP law frequently cover entire patent families rather than individual patents. A license agreement may grant rights to all current and future members of a patent family',
    `profile_id` BIGINT COMMENT 'Reference to the client who is party to this IP license agreement.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: License agreements create contractual risks (breach, termination disputes), payment risks (royalty underpayment, audit findings), and compliance risks (sublicensing violations, field-of-use breaches).',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: License agreements trigger regulatory obligations including antitrust filings (FRAND commitments), foreign investment approvals, technology transfer regulations, and export control compliance. Essenti',
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
    `aml_kyc_program_id` BIGINT COMMENT 'Foreign key linking to compliance.aml_kyc_program. Business justification: Royalty payments to/from foreign entities require AML screening under the firms AML/KYC program. Legal services firms must flag IP-related financial flows for anti-money laundering review. Compliance',
    `asset_id` BIGINT COMMENT 'Reference to the specific IP asset (patent, trademark, copyright, trade secret) for which royalty is being paid.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice issued for this royalty payment, if applicable.',
    `judgment_id` BIGINT COMMENT 'Foreign key linking to matter.judgment. Business justification: Court-ordered royalty payments (FRAND-determined rates, damages awards structured as ongoing royalties) must reference the originating judgment for enforcement compliance, audit trails, and financial ',
    `ledger_entry_id` BIGINT COMMENT 'Foreign key linking to trust.ledger_entry. Business justification: Royalty receipts and disbursements must be recorded as trust ledger entries for IOLTA compliance and client accounting. royalty_payment has receipt_id→trust.receipt for inbound flows but no ledger_ent',
    `license_agreement_id` BIGINT COMMENT 'Reference to the IP license agreement under which this royalty payment is made or received.',
    `organisation_id` BIGINT COMMENT 'Reference to the party making the royalty payment (the licensee using the IP).',
    `receipt_id` BIGINT COMMENT 'Foreign key linking to trust.trust_receipt. Business justification: When royalty payments are received into trust accounts (common in IP licensing), links the royalty payment record to the trust receipt for AML/KYC compliance, source-of-funds verification, and reconci',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Royalty payments are subject to withholding tax obligations, FRAND rate compliance requirements, and transfer pricing regulations. Legal/finance teams need to link each royalty payment to the specific',
    `trust_disbursement_id` BIGINT COMMENT 'Foreign key linking to trust.trust_disbursement. Business justification: Outbound royalty payments to licensors or inventors disbursed from trust accounts generate trust_disbursement records. royalty_payment.payment_direction indicates bidirectional flows; linking to trust',
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
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.account. Business justification: IP assignment transactions involve consideration payments (ownership.consideration_amount) held in or disbursed from trust accounts. Linking ownership to trust.account enables tracking of which trust ',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.contract_agreement. Business justification: IP ownership transfers are governed by assignment agreements modeled as contract_agreements. The ownership record must reference the governing contract_agreement for chain-of-title verification, due d',
    `asset_id` BIGINT COMMENT 'Reference to the IP asset (patent, trademark, copyright, trade secret) that is subject to this ownership record.',
    `escrow_arrangement_id` BIGINT COMMENT 'Foreign key linking to trust.escrow_arrangement. Business justification: IP ownership transfers (assignments) in M&A and licensing transactions routinely use escrow to hold consideration pending IP office recordal. Linking ownership directly to escrow_arrangement supports ',
    `judgment_id` BIGINT COMMENT 'Foreign key linking to matter.judgment. Business justification: Court-ordered IP ownership transfers (judgment ordering assignment to prevailing party, bankruptcy court orders, inventorship correction judgments) require linking the ownership record to the mandatin',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: IP ownership transfers, assignment recordals, and chain-of-title work are specific legal services billed to clients. Linking ownership records to the legal service that managed the transfer supports b',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to ip.license_agreement. Business justification: The ownership table has license_back_flag and license_back_terms indicating that ownership transfers sometimes include license-back arrangements. A license-back is a specific license_agreement granted',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case file associated with this ownership record. Links to the matter management system for tracking legal work related to the ownership.',
    `predecessor_ownership_id` BIGINT COMMENT 'Reference to the previous ownership record in the chain of title. Enables reconstruction of the complete ownership history for due diligence purposes.',
    `profile_id` BIGINT COMMENT 'Reference to the client entity that owns or is associated with this IP ownership record. Links to the client master data.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: IP ownership changes trigger regulatory obligations including recordal requirements at IP offices, foreign ownership notifications, security interest filings (UCC), and beneficial ownership disclosure',
    `assignment_date` DATE COMMENT 'Date on which the ownership rights were assigned or transferred to the current owner. Represents the effective date of the assignment agreement.',
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
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Patent family prosecution management requires the applicant to be a linked client organisation for PCT filings, national phase entries, and portfolio valuation reporting. applicant_name is a denormali',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Patent family prosecution strategy is initiated through an engagement opportunity. Firms track which BD opportunity led to a multi-jurisdiction patent family prosecution engagement for origination cre',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter under which this patent family is managed. Links to the matter master data product for billing, timekeeper assignment, and matter-level reporting.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Patent families are managed at portfolio level under specific practice areas (e.g., patent prosecution, SEP licensing). Practice area classification drives staffing allocation, partner assignment, and',
    `profile_id` BIGINT COMMENT 'Reference to the client entity that owns or controls this patent family. Links to the client master data product.',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.register. Business justification: Patent family portfolio risk management requires a family-level risk register entry for aggregate litigation, invalidity, and FRAND exposure tracking. Individual patents have register_id but the famil',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Patent families with frand_obligation_indicator or standard_essential_patent_indicator are governed by specific regulatory obligations (e.g., ETSI IPR Policy, competition law FRAND commitments). SEP p',
    `abstract_text` STRING COMMENT 'Brief technical summary of the invention from the priority or representative application. Typically 150-300 words describing the technical problem, solution, and key features.',
    `active_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this patent family record is currently active in the system. True for active records, False for archived or soft-deleted records. Used for data retention and reporting filters.',
    `annuity_payment_status` STRING COMMENT 'Current status of annuity (maintenance fee) payments across all family members. Current (all fees paid), Overdue (payment missed but within grace period), Grace_period (in statutory grace period), Lapsed (patent rights lost due to non-payment).. Valid values are `current|overdue|grace_period|lapsed`',
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

CREATE OR REPLACE TABLE `legal_ecm`.`ip`.`copyright` (
    `copyright_id` BIGINT COMMENT 'Primary key for copyright',
    `asset_id` BIGINT COMMENT 'Foreign key reference to the parent IP asset record in the IP asset master table. Links this copyright to the broader IP portfolio management system.',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Copyright registration and enforcement requires the claimant to be a linked client organisation for ownership verification, licensing negotiations, and infringement actions. claimant_name is a denorma',
    `engagement_opportunity_id` BIGINT COMMENT 'Foreign key linking to intake.engagement_opportunity. Business justification: Copyright registration and enforcement engagements originate through the intake pipeline. Linking copyright to its originating engagement_opportunity enables BD-to-IP-delivery tracing and portfolio or',
    `legal_service_id` BIGINT COMMENT 'Foreign key linking to service.legal_service. Business justification: Copyright registration, enforcement actions, and licensing are distinct legal services billed to clients. Linking copyright assets to the specific legal service rendered supports service-level billing',
    `docket_id` BIGINT COMMENT 'Foreign key linking to court.docket. Business justification: Copyright infringement litigation requires direct link from copyright registration to court docket. Essential for tracking enforcement actions in federal court, coordinating DMCA takedowns with litiga',
    `judgment_id` BIGINT COMMENT 'Foreign key linking to matter.judgment. Business justification: Copyright infringement judgments, fair use rulings, and work-for-hire determinations directly affect copyright registration status, licensing eligibility, and valuation. IP counsel require direct link',
    `matter_id` BIGINT COMMENT 'Foreign key reference to the legal matter under which this copyright is being managed. Links to the matter management system.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Copyright prosecution, registration, and enforcement are managed under a dedicated IP/copyright practice area. Firms report copyright work volume, staffing, and revenue by practice area. A legal exper',
    `profile_id` BIGINT COMMENT 'Foreign key reference to the client who owns or is the claimant of this copyright asset. Links to the client master data.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Copyright registrations have regulatory obligations including deposit copy requirements (Library of Congress), renewal filings (pre-1978 works), and mandatory registration for US litigation. Essential',
    `application_date` DATE COMMENT 'The date on which the copyright registration application was filed with the copyright office. Establishes priority and filing date for registration purposes.',
    `application_number` STRING COMMENT 'The application or case number assigned when the copyright registration application was filed. Used to track the application through the registration process.',
    `author_names` STRING COMMENT 'The name(s) of the individual(s) or entity(ies) who created the work. May include multiple authors separated by delimiters. Author information is critical for determining copyright ownership and duration.',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `legal_ecm`.`ip`.`patent_family`(`patent_family_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_to_ip_asset_id` FOREIGN KEY (`to_ip_asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`patent` ADD CONSTRAINT `fk_ip_patent_to_patent_family_id` FOREIGN KEY (`to_patent_family_id`) REFERENCES `legal_ecm`.`ip`.`patent_family`(`patent_family_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`trademark` ADD CONSTRAINT `fk_ip_trademark_trademark_asset_id` FOREIGN KEY (`trademark_asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ADD CONSTRAINT `fk_ip_prosecution_event_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `legal_ecm`.`ip`.`patent`(`patent_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_prosecution_event_id` FOREIGN KEY (`prosecution_event_id`) REFERENCES `legal_ecm`.`ip`.`prosecution_event`(`prosecution_event_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ADD CONSTRAINT `fk_ip_docket_deadline_primary_docket_prosecution_event_id` FOREIGN KEY (`primary_docket_prosecution_event_id`) REFERENCES `legal_ecm`.`ip`.`prosecution_event`(`prosecution_event_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_docket_deadline_id` FOREIGN KEY (`docket_deadline_id`) REFERENCES `legal_ecm`.`ip`.`docket_deadline`(`docket_deadline_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ADD CONSTRAINT `fk_ip_ip_payment_prosecution_event_id` FOREIGN KEY (`prosecution_event_id`) REFERENCES `legal_ecm`.`ip`.`prosecution_event`(`prosecution_event_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ADD CONSTRAINT `fk_ip_license_agreement_patent_family_id` FOREIGN KEY (`patent_family_id`) REFERENCES `legal_ecm`.`ip`.`patent_family`(`patent_family_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ADD CONSTRAINT `fk_ip_royalty_payment_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_license_agreement_id` FOREIGN KEY (`license_agreement_id`) REFERENCES `legal_ecm`.`ip`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `legal_ecm`.`ip`.`ownership` ADD CONSTRAINT `fk_ip_ownership_predecessor_ownership_id` FOREIGN KEY (`predecessor_ownership_id`) REFERENCES `legal_ecm`.`ip`.`ownership`(`ownership_id`);
ALTER TABLE `legal_ecm`.`ip`.`inventor` ADD CONSTRAINT `fk_ip_inventor_patent_id` FOREIGN KEY (`patent_id`) REFERENCES `legal_ecm`.`ip`.`patent`(`patent_id`);
ALTER TABLE `legal_ecm`.`ip`.`copyright` ADD CONSTRAINT `fk_ip_copyright_asset_id` FOREIGN KEY (`asset_id`) REFERENCES `legal_ecm`.`ip`.`asset`(`asset_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm`.`ip` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `legal_ecm`.`ip` SET TAGS ('dbx_domain' = 'ip');
ALTER TABLE `legal_ecm`.`ip`.`asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`ip`.`asset` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset ID');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `annuity_amount` SET TAGS ('dbx_business_glossary_term' = 'Annuity Amount');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `annuity_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Annuity Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `annuity_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `annuity_due_date` SET TAGS ('dbx_business_glossary_term' = 'Annuity Due Date');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Number');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Type');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'patent|trademark|copyright|trade_secret|design_right|plant_variety');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `classification_code` SET TAGS ('dbx_business_glossary_term' = 'Classification Code');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `docketing_system_code` SET TAGS ('dbx_business_glossary_term' = 'Docketing System ID');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `document_repository_path` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Path');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `frand_declaration_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Reasonable and Non-Discriminatory (FRAND) Declaration Flag');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `inventor_names` SET TAGS ('dbx_business_glossary_term' = 'Inventor Names');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `inventor_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `ip_asset_description` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Description');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `ip_asset_status` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Status');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `ip_office_name` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Office Name');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `licensing_status` SET TAGS ('dbx_business_glossary_term' = 'Licensing Status');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `licensing_status` SET TAGS ('dbx_value_regex' = 'not_licensed|exclusively_licensed|non_exclusively_licensed|cross_licensed|frand_committed');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `opposition_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Opposition Filed Flag');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `pct_application_flag` SET TAGS ('dbx_business_glossary_term' = 'Patent Cooperation Treaty (PCT) Application Flag');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `portfolio_category` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Category');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `pph_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Patent Prosecution Highway (PPH) Request Flag');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `priority_date` SET TAGS ('dbx_business_glossary_term' = 'Priority Date');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Subtype');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `technology_area` SET TAGS ('dbx_business_glossary_term' = 'Technology Area');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'IP Asset Title');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency Code');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`ip`.`asset` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `legal_ecm`.`ip`.`patent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`ip`.`patent` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Identifier');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Assignee Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `judgment_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Judgment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset Identifier');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Identifier');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `abstract` SET TAGS ('dbx_business_glossary_term' = 'Patent Abstract');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Patent Agent Name');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `annuity_due_date` SET TAGS ('dbx_business_glossary_term' = 'Annuity Due Date');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `annuity_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Annuity Payment Status');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `annuity_payment_status` SET TAGS ('dbx_value_regex' = 'current|overdue|paid|waived|lapsed');
ALTER TABLE `legal_ecm`.`ip`.`patent` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Patent Application Number');
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
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `judgment_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Judgment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`trademark` ALTER COLUMN `trademark_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset Identifier');
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
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` SET TAGS ('dbx_subdomain' = 'prosecution_docketing');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `prosecution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Event Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Fee Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Application Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`prosecution_event` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Order Id (Foreign Key)');
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
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` SET TAGS ('dbx_subdomain' = 'prosecution_docketing');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `docket_deadline_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Deadline Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Order Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `primary_docket_prosecution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Event Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`docket_deadline` ALTER COLUMN `sla_template_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Template Id (Foreign Key)');
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
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` SET TAGS ('dbx_subdomain' = 'licensing_royalties');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `ip_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `billing_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Disbursement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `disbursement_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Authorization Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `docket_deadline_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Deadline Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Ledger Entry Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`ip`.`ip_payment` ALTER COLUMN `prosecution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Prosecution Event Id (Foreign Key)');
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
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` SET TAGS ('dbx_subdomain' = 'licensing_royalties');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Governing Order Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `judgment_id` SET TAGS ('dbx_business_glossary_term' = 'Judgment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `letter_of_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Letter Of Engagement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`license_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
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
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` SET TAGS ('dbx_subdomain' = 'licensing_royalties');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `royalty_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Payment Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `aml_kyc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Aml Kyc Program Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `judgment_id` SET TAGS ('dbx_business_glossary_term' = 'Judgment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `ledger_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Entry Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Licensee Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Receipt Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`royalty_payment` ALTER COLUMN `trust_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Disbursement Id (Foreign Key)');
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
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset ID');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `escrow_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `judgment_id` SET TAGS ('dbx_business_glossary_term' = 'Judgment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `predecessor_ownership_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Ownership ID');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`ownership` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
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
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Identifier (ID)');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `abstract_text` SET TAGS ('dbx_business_glossary_term' = 'Patent Abstract Text');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `active_indicator` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator Flag');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `annuity_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Annuity Payment Status');
ALTER TABLE `legal_ecm`.`ip`.`patent_family` ALTER COLUMN `annuity_payment_status` SET TAGS ('dbx_value_regex' = 'current|overdue|grace_period|lapsed');
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
ALTER TABLE `legal_ecm`.`ip`.`copyright` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`ip`.`copyright` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `copyright_id` SET TAGS ('dbx_business_glossary_term' = 'Copyright Identifier');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Asset ID');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Claimant Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `engagement_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Opportunity Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `legal_service_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Service Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Docket Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `judgment_id` SET TAGS ('dbx_business_glossary_term' = 'Litigation Judgment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `author_names` SET TAGS ('dbx_business_glossary_term' = 'Author Names');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `author_names` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`ip`.`copyright` ALTER COLUMN `author_names` SET TAGS ('dbx_pii_name' = 'true');
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
