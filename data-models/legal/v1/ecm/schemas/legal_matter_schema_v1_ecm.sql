-- Schema for Domain: matter | Business: Legal | Version: v1_ecm
-- Generated on: 2026-05-07 11:59:01

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `legal_ecm`.`matter` COMMENT 'Core operational domain governing the lifecycle of every legal matter and case from inception to closure. Serves as the central hub linking clients, timekeepers, documents, and billing to a single matter record. Supports matter management, case administration, litigation, corporate transaction advisory, and LPM workflows across all practice groups.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`tribunal` (
    `tribunal_id` BIGINT COMMENT 'Unique identifier for the tribunal, court, arbitral body, or ADR (Alternative Dispute Resolution) forum. Primary key for the tribunal master record.',
    `jurisdiction_coverage_id` BIGINT COMMENT 'Foreign key linking to service.jurisdiction_coverage. Business justification: Firms track which tribunals they have admission/coverage for to determine pro hac vice requirements, local counsel needs, and matter acceptance criteria. Drives conflict checks and staffing decisions ',
    `judge_id` BIGINT COMMENT 'FK to court.judge',
    `address_line_1` STRING COMMENT 'Primary street address of the tribunals courthouse or administrative office (e.g., 500 Pearl Street). Used for physical filing, in-person appearances, and service of process. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building number (e.g., Suite 200, Courtroom 15A). Organizational contact data classified as confidential.',
    `adr_program_description` STRING COMMENT 'Textual description of the ADR programs offered by the tribunal, including mediation panels, arbitration services, early neutral evaluation, and settlement conference procedures. Null if ADR services are not available.',
    `adr_services_available` BOOLEAN COMMENT 'Indicates whether the tribunal offers or requires Alternative Dispute Resolution (ADR) services such as mediation, arbitration, or settlement conferences as part of its case management process. True if ADR programs are available, False otherwise.',
    `arbitration_rules_reference` STRING COMMENT 'Reference to the arbitration rules governing proceedings before this tribunal if it is an arbitral body (e.g., ICC Arbitration Rules 2021, LCIA Arbitration Rules 2020, UNCITRAL Arbitration Rules, AAA Commercial Arbitration Rules). Null for non-arbitration tribunals.',
    `business_hours` STRING COMMENT 'The standard business hours during which the tribunals clerks office is open for filings, inquiries, and in-person visits (e.g., Monday-Friday 9:00 AM - 5:00 PM, 08:30-16:30 GMT). Used to determine filing deadlines and availability for emergency motions.',
    `city` STRING COMMENT 'The city or municipality where the tribunals primary courthouse or administrative office is located (e.g., New York, Los Angeles, London, Paris, The Hague). Used for physical appearance scheduling and document delivery.',
    `clerk_of_court_name` STRING COMMENT 'The name of the clerk of court or court administrator responsible for managing case filings, dockets, and administrative functions. Primary contact for procedural questions and filing issues.',
    `closure_date` DATE COMMENT 'The date the tribunal was officially closed, dissolved, or merged into another tribunal. Null if the tribunal is still operational.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the primary country where the tribunal is located or operates (e.g., USA, GBR, FRA, CHE for Switzerland-based ICC). For international tribunals, the code of the host country or headquarters.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this tribunal record was first created in the system. Used for audit trail and data lineage tracking.',
    `ecf_enabled` BOOLEAN COMMENT 'Indicates whether the tribunal supports Electronic Case Filing (ECF) for electronic submission of pleadings, motions, and other court documents. True if ECF is available, False if paper filing is required or ECF is not yet implemented.',
    `ecf_enrollment_status` STRING COMMENT 'The firms enrollment status with the tribunals ECF system. Enrolled means the firm has active credentials and can file electronically. Pending indicates an application is in progress. Not Enrolled means the firm must enroll before filing. Not Applicable if the tribunal does not offer ECF.. Valid values are `enrolled|pending|not_enrolled|not_applicable`',
    `ecf_system_name` STRING COMMENT 'The name or identifier of the electronic filing system used by the tribunal (e.g., CM/ECF for federal courts, NYSCEF for New York State courts, File & ServeXpress for California). Null if ECF is not enabled.',
    `email_address` STRING COMMENT 'Official email address for the tribunals clerks office or administrative contact. Used for electronic correspondence, filing confirmations, and procedural notifications. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `established_date` DATE COMMENT 'The date the tribunal was officially established or chartered. For historical courts, this may be the date of enabling legislation. For arbitration panels, the date the institution was founded.',
    `fax_number` STRING COMMENT 'Fax number for the tribunals clerks office. Some courts still require or accept fax filings for certain document types or emergency motions. Organizational contact data classified as confidential.',
    `filing_deadline_time` TIMESTAMP COMMENT 'The cutoff time by which electronic or physical filings must be submitted to be considered filed on that business day (e.g., 11:59 PM local time for ECF, 5:00 PM for paper filings). Critical for calculating compliance with procedural deadlines.',
    `filing_fee_schedule_url` STRING COMMENT 'URL to the tribunals published schedule of filing fees for various document types and motions. Used by billing and matter management systems to estimate litigation costs and validate disbursements.',
    `jurisdiction_geographic` STRING COMMENT 'The geographic area or territory over which the tribunal has legal authority. For federal courts, this may be a district or circuit (e.g., Southern District of New York, Ninth Circuit). For state courts, the state or county. For international tribunals, the countries or regions covered (e.g., Global, European Union, APAC).',
    `jurisdiction_level` STRING COMMENT 'The hierarchical level of legal authority for the tribunal. Federal courts have nationwide jurisdiction, state courts operate within state boundaries, county and municipal courts handle local matters, international tribunals (ICC, LCIA, ICJ) handle cross-border disputes, and tribal courts operate within sovereign tribal lands. [ENUM-REF-CANDIDATE: federal|state|county|municipal|international|regional|tribal — 7 candidates stripped; promote to reference product]',
    `language_primary` STRING COMMENT 'The primary language in which proceedings are conducted and documents must be filed (e.g., English, French, Spanish, Mandarin). For international tribunals, this may be the official working language.',
    `language_secondary` STRING COMMENT 'A secondary language accepted by the tribunal for filings or proceedings, if applicable. Common in bilingual jurisdictions (e.g., French in Canadian federal courts, Spanish in Puerto Rico). Null if only one language is accepted.',
    `local_rules_url` STRING COMMENT 'URL to the tribunals local rules of procedure, which supplement federal or state rules with court-specific requirements for formatting, filing deadlines, motion practice, and courtroom decorum. Essential reference for litigation teams.',
    `notes` STRING COMMENT 'Free-text field for additional information about the tribunal, including special filing procedures, historical context, relationships with other courts, or firm-specific practice notes (e.g., Judge Smith prefers courtesy copies for motions over 20 pages, This court requires a separate courtesy copy for chambers).',
    `operational_status` STRING COMMENT 'Current operational status of the tribunal. Active indicates the tribunal is fully operational and accepting filings. Inactive means the tribunal is no longer hearing cases. Temporarily Closed indicates a temporary suspension (e.g., due to emergency, renovation). Merged indicates the tribunal has been consolidated with another. Dissolved indicates permanent closure.. Valid values are `active|inactive|temporarily_closed|merged|dissolved`',
    `pacer_enabled` BOOLEAN COMMENT 'Indicates whether the tribunal provides access to case dockets and documents through PACER (Public Access to Court Electronic Records), the federal judiciarys electronic public access service. True for federal courts with PACER access, False otherwise.',
    `pacer_site_code` STRING COMMENT 'The unique site code assigned by PACER to identify the tribunal in the PACER system (e.g., nysd for Southern District of New York, ca9 for Ninth Circuit). Used to construct PACER URLs and retrieve docket information programmatically. Null if PACER is not enabled.',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the tribunals clerks office or administrative staff. Used for procedural inquiries, hearing confirmations, and emergency filings. Organizational contact data classified as confidential.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the tribunals address (e.g., 10007, SW1A 1AA). Organizational contact data classified as confidential.',
    `standing_orders_url` STRING COMMENT 'URL to the tribunals standing orders, which are general directives issued by the court or individual judges that govern case management, scheduling, and procedural matters. May include COVID-19 protocols, electronic filing requirements, or case management procedures.',
    `state_province` STRING COMMENT 'The state, province, or administrative region where the tribunal is located (e.g., New York, California, Ontario, England and Wales). Applicable primarily to state and county courts. Null for federal or international tribunals without state-level jurisdiction.',
    `time_zone` STRING COMMENT 'The time zone in which the tribunal operates (e.g., America/New_York, Europe/London, Asia/Hong_Kong). Critical for scheduling hearings, calculating filing deadlines, and coordinating appearances across multiple jurisdictions.',
    `translation_required` BOOLEAN COMMENT 'Indicates whether documents filed in a language other than the tribunals primary language must be accompanied by certified translations. True if translation is required, False otherwise.',
    `tribunal_code` STRING COMMENT 'Short alphanumeric code or abbreviation used internally or externally to identify the tribunal (e.g., SDNY, ICC, LCIA, CA9 for Ninth Circuit Court of Appeals). Used for quick reference in matter management and docket tracking.',
    `tribunal_name` STRING COMMENT 'The official legal name of the court, tribunal, arbitral body, or ADR forum as recognized by the governing jurisdiction (e.g., United States District Court for the Southern District of New York, International Chamber of Commerce (ICC) International Court of Arbitration, London Court of International Arbitration (LCIA)).',
    `tribunal_type` STRING COMMENT 'Classification of the tribunal by its legal function and authority. Distinguishes between trial courts (district), appellate courts (circuit, appellate, supreme), specialized courts (chancery, bankruptcy, tax, family), and ADR forums (arbitration panel, mediation forum, ICC, LCIA). Critical for determining procedural rules and filing requirements. [ENUM-REF-CANDIDATE: district|circuit|appellate|supreme|chancery|bankruptcy|tax|family|arbitration_panel|mediation_forum|adr_body|international_tribunal|administrative_tribunal — 13 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this tribunal record was last modified. Used for audit trail, change tracking, and data quality monitoring.',
    `website_url` STRING COMMENT 'Official website URL for the tribunal (e.g., https://www.nysd.uscourts.gov, https://iccwbo.org/dispute-resolution-services/icc-international-court-arbitration). Provides access to court rules, filing instructions, docket information, and public records.',
    CONSTRAINT pk_tribunal PRIMARY KEY(`tribunal_id`)
) COMMENT 'Master record for every court, tribunal, arbitral body, and ADR forum the firm interacts with. Captures the official name, jurisdiction level (federal, state, appellate, international), court type (district, circuit, chancery, arbitration panel, ICC, LCIA), geographic jurisdiction, ECF/PACER enrollment status, filing system credentials reference, and operational status. Serves as the authoritative SSOT for court identity across the litigation and dispute resolution practice.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`jurisdiction` (
    `jurisdiction_id` BIGINT COMMENT 'Primary key for jurisdiction',
    `appellate_jurisdiction_id` BIGINT COMMENT 'Foreign key reference to the next-level appellate jurisdiction for this court. Null for courts of last resort. Used for appellate pathway analysis and escalation planning.',
    `practice_note_id` BIGINT COMMENT 'Foreign key linking to knowledge.practice_note. Business justification: Jurisdictions have practice notes covering procedural rules, local customs, filing requirements, and practice standards. Linking jurisdiction to practice notes supports multi-jurisdictional practice, ',
    `adr_available` BOOLEAN COMMENT 'Indicates whether Alternative Dispute Resolution (ADR) mechanisms (mediation, arbitration, conciliation) are formally available or mandated in this jurisdiction.',
    `arbitration_institution` STRING COMMENT 'Name of the primary arbitration institution administering disputes in this jurisdiction (e.g., International Chamber of Commerce (ICC), London Court of International Arbitration (LCIA), American Arbitration Association (AAA)). Null if not an arbitral jurisdiction.',
    `arbitration_seat` BOOLEAN COMMENT 'Indicates whether this jurisdiction serves as a recognized arbitral seat under international arbitration conventions (e.g., New York Convention, UNCITRAL Model Law). True for jurisdictions like London, Paris, Singapore, New York.',
    `business_hours` STRING COMMENT 'Standard business hours for the court clerks office (e.g., 9:00 AM - 5:00 PM Monday-Friday). Used for filing deadline calculations and in-person appearance planning.',
    `civil_procedure_rules` STRING COMMENT 'Name or citation of the governing rules of civil procedure applicable in this jurisdiction (e.g., Federal Rules of Civil Procedure, CPR 1998, Code of Civil Procedure). Determines pleading standards, discovery scope, and motion practice.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the jurisdictions sovereign nation (e.g., USA, GBR, CAN). Used for international matter classification and treaty applicability.. Valid values are `^[A-Z]{3}$`',
    `court_level` STRING COMMENT 'Hierarchical level of the court within its jurisdiction (trial court of first instance, intermediate appellate, court of last resort, or specialized tribunal).. Valid values are `trial|appellate|supreme|specialized`',
    `court_website_url` STRING COMMENT 'Official website URL for the court or tribunal. Used for accessing public dockets, forms, and administrative information.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this jurisdiction record was first created in the system. Used for data lineage and audit trail.',
    `criminal_procedure_rules` STRING COMMENT 'Name or citation of the governing rules of criminal procedure applicable in this jurisdiction. Null if jurisdiction does not handle criminal matters.',
    `ecf_integration_enabled` BOOLEAN COMMENT 'Indicates whether automated Electronic Case Filing (ECF) integration is enabled for this jurisdiction. True if the firm has technical integration with the courts filing system.',
    `ecf_system_name` STRING COMMENT 'Name of the electronic case filing system used by this jurisdiction (e.g., CM/ECF, PACER, CourtLink). Used for Electronic Case Filing (ECF) integration and docket retrieval.',
    `effective_date` DATE COMMENT 'Date when this jurisdiction became operational or when the current configuration became effective. Used for historical matter classification.',
    `electronic_filing_deadline_time` TIMESTAMP COMMENT 'Cut-off time for same-day electronic filings in local time (e.g., 11:59 PM, 5:00 PM). Critical for deadline compliance in Electronic Case Filing (ECF) systems.',
    `evidence_rules` STRING COMMENT 'Name or citation of the governing rules of evidence (e.g., Federal Rules of Evidence, Evidence Act 1995). Determines admissibility standards for documents, testimony, and expert opinions.',
    `filing_fee_schedule_url` STRING COMMENT 'URL to the official court filing fee schedule. Used for cost estimation during matter intake and budgeting.',
    `geographic_region` STRING COMMENT 'Geographic area or circuit covered by the jurisdiction (e.g., Ninth Circuit, England and Wales, State of California). Used for venue analysis and conflict-of-laws determination.',
    `jurisdiction_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the jurisdiction (e.g., federal circuit code, state abbreviation, international arbitral seat code). Used for matter classification and filing system integration.. Valid values are `^[A-Z0-9]{2,10}$`',
    `jurisdiction_name` STRING COMMENT 'Full legal name of the jurisdiction (e.g., United States Court of Appeals for the Ninth Circuit, Supreme Court of the United Kingdom, International Chamber of Commerce (ICC) Arbitration).',
    `jurisdiction_status` STRING COMMENT 'Current operational status of the jurisdiction. Inactive or abolished jurisdictions are retained for historical matter reference.. Valid values are `active|inactive|merged|abolished`',
    `jurisdiction_type` STRING COMMENT 'Classification of the jurisdiction by governmental or institutional level. Determines applicable procedural rules and appellate pathways. [ENUM-REF-CANDIDATE: federal|state|provincial|municipal|international|arbitral|administrative|tribal — 8 candidates stripped; promote to reference product]',
    `language_primary` STRING COMMENT 'Primary language used for court proceedings and filings in this jurisdiction (e.g., English, French, Spanish). Used for document preparation and interpreter requirements.',
    `language_secondary` STRING COMMENT 'Secondary or co-official language accepted in this jurisdiction (e.g., French in Canadian federal courts). Null if jurisdiction is monolingual.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this jurisdiction record was last modified. Used for change tracking and data quality monitoring.',
    `legal_system` STRING COMMENT 'Governing legal tradition of the jurisdiction (common law, civil law, mixed system, Sharia law, or customary law). Influences case law precedent, statutory interpretation, and evidentiary standards.. Valid values are `common_law|civil_law|mixed|sharia|customary`',
    `local_rules_url` STRING COMMENT 'URL to the jurisdictions local court rules and standing orders. Critical for compliance with jurisdiction-specific procedural requirements.',
    `notes` STRING COMMENT 'Free-text notes capturing jurisdiction-specific practice tips, local counsel requirements, or procedural quirks. Used by litigation teams for matter planning.',
    `pacer_court_code` STRING COMMENT 'PACER-specific court identifier for federal courts. Used for automated docket retrieval and case monitoring via Public Access to Court Electronic Records (PACER) integration. Null for non-federal jurisdictions.',
    `state_province_code` STRING COMMENT 'Two-letter state or province code for sub-national jurisdictions (e.g., CA for California, ON for Ontario). Null for federal or international jurisdictions.',
    `statute_of_limitations_default_years` DECIMAL(18,2) COMMENT 'Default statute of limitations period in years for general civil claims in this jurisdiction. Used for matter intake risk assessment and calendar management. Actual limitations vary by claim type.',
    `termination_date` DATE COMMENT 'Date when this jurisdiction ceased operations or was merged into another jurisdiction. Null for active jurisdictions.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the jurisdiction (e.g., America/New_York, Europe/London). Used for hearing scheduling, filing deadlines, and calendar management.',
    `treaty_memberships` STRING COMMENT 'Comma-separated list of international treaties and conventions to which this jurisdiction is a signatory (e.g., New York Convention, Hague Convention, Patent Cooperation Treaty (PCT)). Used for cross-border enforcement and recognition analysis.',
    CONSTRAINT pk_jurisdiction PRIMARY KEY(`jurisdiction_id`)
) COMMENT 'Reference catalog of legal jurisdictions — federal circuits, state/provincial courts, international arbitral seats, and regulatory jurisdictions. Stores jurisdiction code, governing law system (common law, civil law, mixed), geographic region, applicable rules of civil procedure, statute of limitations defaults, and treaty memberships (e.g., New York Convention for arbitration enforcement). Used to classify matters, filings, and judgments by controlling law.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`judge` (
    `judge_id` BIGINT COMMENT 'Unique identifier for the judicial officer, arbitrator, or mediator record.',
    `jurisdiction_id` BIGINT COMMENT 'Identifier of the court or tribunal to which this judicial officer is assigned.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Judges specialize by practice area; firms track this for case strategy, motion practice preferences, and business development. Replaces denormalized practice_area_specialization text with structured F',
    `adr_certification_type` STRING COMMENT 'Type of Alternative Dispute Resolution (ADR) certification held by the judicial officer or neutral party.. Valid values are `Certified Mediator|Certified Arbitrator|Neutral Evaluator|Settlement Master|Not Certified`',
    `adr_panel_membership` STRING COMMENT 'Names of ADR panels or rosters to which the judicial officer or neutral belongs (e.g., ICC, LCIA, AAA, JAMS).',
    `appearance_count` STRING COMMENT 'Number of times the firm has appeared before this judicial officer. Used for relationship intelligence and conflict screening.',
    `appointment_date` DATE COMMENT 'Date when the judicial officer was appointed or elected to the bench.',
    `appointment_type` STRING COMMENT 'Method by which the judicial officer obtained their position (e.g., Appointed, Elected, Designated).. Valid values are `Appointed|Elected|Designated|Pro Tempore|Retired Recalled`',
    `bar_admission_date` DATE COMMENT 'Date when the judicial officer was first admitted to the bar.',
    `bar_admission_jurisdiction` STRING COMMENT 'Jurisdiction(s) where the judicial officer is admitted to practice law (prior to appointment).',
    `case_management_style` STRING COMMENT 'Characterization of the judicial officers approach to case management and courtroom procedure.. Valid values are `Active|Hands-Off|Settlement-Oriented|Trial-Oriented|Strict Procedural|Flexible`',
    `chamber_number` STRING COMMENT 'Physical chamber or courtroom number where the judicial officer typically presides.',
    `chambers_email` STRING COMMENT 'Official email address for the judicial officers chambers or administrative staff.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `chambers_phone` STRING COMMENT 'Primary phone number for the judicial officers chambers.',
    `court_name` STRING COMMENT 'Name of the court or tribunal where the judicial officer presides.',
    `courtroom_technology_preferences` STRING COMMENT 'Notes on the judicial officers preferences or requirements for courtroom technology (e.g., electronic presentations, video conferencing, document display systems).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this judge record was first created in the system.',
    `ecf_participant_identifier` STRING COMMENT 'Unique identifier for the judicial officer in the Electronic Case Filing (ECF) system.',
    `education_background` STRING COMMENT 'Educational background of the judicial officer, including law school and undergraduate institutions.',
    `full_name` STRING COMMENT 'Complete legal name of the judicial officer, arbitrator, or mediator.',
    `honorific` STRING COMMENT 'Formal honorific used when addressing or referring to the judicial officer.. Valid values are `The Honorable|Hon.|Justice|Chief Justice|Associate Justice|Magistrate Judge`',
    `judge_status` STRING COMMENT 'Current status of the judicial officer in their role.. Valid values are `Active|Senior Status|Retired|Suspended|Deceased|Inactive`',
    `judicial_philosophy_notes` STRING COMMENT 'Internal notes capturing the judicial officers known legal philosophy, tendencies, or approach to case management. Used for litigation strategy and appearance preparation.',
    `jurisdiction` STRING COMMENT 'Geographic or subject matter jurisdiction of the court (e.g., Federal, State, County, District).',
    `last_appearance_date` DATE COMMENT 'Date of the most recent appearance by the firm before this judicial officer.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this judge record was last updated.',
    `law_clerk_name` STRING COMMENT 'Name of the primary law clerk or judicial assistant supporting the judicial officer.',
    `motion_practice_preferences` STRING COMMENT 'Known preferences or requirements for motion practice, including page limits, oral argument preferences, and briefing schedules.',
    `notable_rulings_summary` STRING COMMENT 'Summary of notable or landmark rulings issued by the judicial officer. Used for litigation strategy and appearance preparation.',
    `pacer_identifier` STRING COMMENT 'Unique identifier for the judicial officer in the PACER (Public Access to Court Electronic Records) system for federal courts.',
    `preferred_communication_method` STRING COMMENT 'Preferred method for communicating with the judicial officer or their chambers.. Valid values are `Email|Phone|Chambers Staff|Written Correspondence|ECF Messaging`',
    `preferred_filing_protocol` STRING COMMENT 'Preferred method or protocol for filing documents with this judicial officer (e.g., ECF, paper, specific formatting requirements).',
    `prior_firm_affiliation` STRING COMMENT 'Name of law firm or organization where the judicial officer practiced prior to appointment. Used for conflict screening.',
    `professional_affiliations` STRING COMMENT 'Professional organizations, bar associations, or judicial conferences to which the judicial officer belongs.',
    `published_opinions_count` STRING COMMENT 'Number of published judicial opinions authored by this judicial officer. Used for relationship intelligence and litigation strategy.',
    `recusal_history_flag` BOOLEAN COMMENT 'Indicates whether the judicial officer has a history of recusals involving the firm or its clients. Used for conflict screening and appearance planning.',
    `recusal_notes` STRING COMMENT 'Detailed notes on past recusals, conflicts, or ethical wall considerations involving this judicial officer.',
    `relationship_strength` STRING COMMENT 'Assessment of the firms relationship strength with this judicial officer based on past appearances and interactions. Used for relationship intelligence.. Valid values are `Strong|Moderate|Weak|None|Unknown`',
    `reversal_rate_notes` STRING COMMENT 'Internal notes on the judicial officers appellate reversal rate or patterns. Used for litigation strategy.',
    `scheduling_preferences` STRING COMMENT 'Known preferences or constraints for scheduling hearings, motions, or trials with this judicial officer.',
    `term_expiration_date` DATE COMMENT 'Date when the current judicial term expires, if applicable. Null for lifetime appointments.',
    `title` STRING COMMENT 'Official title of the judicial officer (e.g., Judge, Justice, Magistrate, Arbitrator, Mediator). [ENUM-REF-CANDIDATE: Judge|Justice|Magistrate|Arbitrator|Mediator|Commissioner|Master|Referee — 8 candidates stripped; promote to reference product]',
    `trial_experience_level` STRING COMMENT 'Assessment of the judicial officers level of trial experience and comfort with jury or bench trials.. Valid values are `Extensive|Moderate|Limited|Primarily Appellate|Primarily ADR`',
    CONSTRAINT pk_judge PRIMARY KEY(`judge_id`)
) COMMENT 'Master record for judicial officers, arbitrators, and mediators before whom the firm appears. Captures full name, title, court assignment, chamber details, appointment date, judicial philosophy notes, recusal history flags, ADR certification type, and preferred filing/communication protocols. Supports conflict screening, appearance preparation, and relationship intelligence for litigation strategy.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`docket` (
    `docket_id` BIGINT COMMENT 'Unique identifier for the docket record. Primary key for the docket entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: Litigation matters routinely require trust accounts for court-ordered deposits, settlement funds held pending resolution, and litigation expense advances. Attorneys must track which trust account hold',
    `judge_id` BIGINT COMMENT 'Reference to the judge assigned to preside over this case. Links to the judge master data.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the lead attorney of record for this docket. Links to the timekeeper or workforce entity.',
    `docket_lead_attorney_attorney_profile_id` BIGINT COMMENT 'FK to workforce.attorney_profile',
    `last_modified_by_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user who last modified this docket record. Used for audit trail and accountability.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter associated with this docket. Links the docket to the internal matter management system.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Dockets are categorized by practice area for resource allocation, conflict checking, rate card application, and matter profitability analysis. Essential for billing, staffing, and business intelligenc',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.client_profile. Business justification: Every litigation docket represents a client being represented. Direct link enables conflict checks, client-specific litigation reporting, outside counsel guideline compliance, and e-billing (LEDES) cl',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Litigation dockets generate risk register entries for tracking adverse outcome exposure, cost overruns, and malpractice potential. Essential for practice risk management and insurer reporting.',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: Litigation arising from regulatory breaches is core to legal-services; dockets track court cases defending or prosecuting breaches for compliance reporting and regulatory coordination.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user who created this docket record. Used for audit trail and accountability.',
    `tribunal_id` BIGINT COMMENT 'Reference to the court or tribunal where this case is filed. Links to the court master data.',
    `adr_proceeding_type` STRING COMMENT 'Type of ADR proceeding associated with this docket, if any. Tracks alternative dispute resolution efforts.. Valid values are `none|mediation|arbitration|settlement_conference|early_neutral_evaluation`',
    `appeal_status` STRING COMMENT 'Status of any appeal filed in this case. Tracks whether the case has been or is being appealed.. Valid values are `not_appealed|appeal_pending|appeal_granted|appeal_denied|remanded`',
    `appellate_docket_number` STRING COMMENT 'Docket number assigned by the appellate court if the case has been appealed. Links the trial court docket to the appellate docket.',
    `arbitration_case_number` STRING COMMENT 'Case number assigned by the arbitration forum. Used for tracking arbitration proceedings.',
    `arbitration_forum` STRING COMMENT 'Name of the arbitration institution or forum if the case is being arbitrated (e.g., ICC, LCIA, AAA, JAMS).',
    `case_caption` STRING COMMENT 'The formal title of the case as it appears on court documents, typically in the format Plaintiff v. Defendant or In re: Matter Name.',
    `case_closed_date` DATE COMMENT 'Date when the case was officially closed by the court. Null for active cases.',
    `case_complexity_level` STRING COMMENT 'Assessment of the case complexity based on legal issues, number of parties, document volume, and procedural requirements. Used for resource planning and matter management.. Valid values are `low|medium|high|exceptional`',
    `case_status` STRING COMMENT 'Current procedural status of the case in the court system. Indicates the lifecycle stage of the docket. [ENUM-REF-CANDIDATE: active|stayed|closed|appealed|settled|dismissed|pending — 7 candidates stripped; promote to reference product]',
    `case_subtype` STRING COMMENT 'More granular classification of the case (e.g., contract dispute, personal injury, securities fraud, patent infringement). Provides additional detail beyond the primary case type.',
    `case_type` STRING COMMENT 'Classification of the case type indicating the nature of the legal proceeding.. Valid values are `civil|criminal|appellate|arbitration|administrative|bankruptcy`',
    `case_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated case value.. Valid values are `^[A-Z]{3}$`',
    `closure_reason` STRING COMMENT 'Reason for case closure (e.g., settled, dismissed, judgment entered, withdrawn). Provides context for the case outcome.',
    `confidentiality_level` STRING COMMENT 'Confidentiality classification of the docket and associated case materials. Indicates access restrictions and handling requirements.. Valid values are `public|confidential|highly_confidential|sealed`',
    `court_access_url` STRING COMMENT 'URL for accessing the case in the courts electronic filing system or PACER. Provides direct link to court records.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this docket record was first created in the system. Used for audit trail and data lineage.',
    `docket_number` STRING COMMENT 'Court-assigned docket number or case number. This is the official identifier used by the court system to track the case.',
    `ecf_registration_date` DATE COMMENT 'Date when the firm completed ECF registration for this case.',
    `ecf_registration_status` STRING COMMENT 'Status of the firms registration for electronic case filing in this matter. Indicates whether the firm is authorized to file documents electronically.. Valid values are `registered|pending|not_required|failed`',
    `estimated_case_value` DECIMAL(18,2) COMMENT 'Estimated monetary value at stake in the case. Used for risk assessment and matter prioritization.',
    `filing_date` DATE COMMENT 'The date when the case was officially filed with the court. This is the court-recorded filing date, not the date of internal matter creation.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this docket record is currently active. Used for filtering and reporting on active cases.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction of the court (e.g., federal, state, county, international tribunal). Indicates the authority under which the court operates.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this docket record was last updated. Used for audit trail and change tracking.',
    `next_scheduled_event_date` DATE COMMENT 'Date of the next scheduled court event, hearing, or deadline. Used for calendar management and appearance tracking.',
    `next_scheduled_event_type` STRING COMMENT 'Type of the next scheduled event (e.g., hearing, trial, motion deadline, status conference, deposition).',
    `notes` STRING COMMENT 'Free-text notes and comments about the docket, case strategy, or procedural history. Used for internal knowledge management.',
    `opposing_counsel_firm` STRING COMMENT 'Name of the law firm representing the opposing party.',
    `opposing_counsel_name` STRING COMMENT 'Name of the primary opposing counsel or law firm representing the adverse party.',
    `pacer_case_number` STRING COMMENT 'Unique identifier for federal court cases in the PACER system. Used for electronic access to federal court records.',
    `trial_date` DATE COMMENT 'Scheduled date for trial commencement. May be null if trial date has not been set.',
    `venue` STRING COMMENT 'Geographic location or district where the case is being heard (e.g., Southern District of New York, Los Angeles Superior Court).',
    CONSTRAINT pk_docket PRIMARY KEY(`docket_id`)
) COMMENT 'Official docket record linking a matter to a specific court or tribunal. Stores the court-assigned docket number, case caption, filing date, case type (civil, criminal, appellate, arbitration), assigned judge reference, case status (active, stayed, closed, appealed), PACER case ID for federal matters, ECF registration status, and next scheduled event date. Acts as the operational hub for all court-side activity on a matter.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`hearing` (
    `hearing_id` BIGINT COMMENT 'Unique identifier for the hearing record. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the lead attorney from the firm representing the client at this hearing.',
    `jurisdiction_id` BIGINT COMMENT 'Reference to the court or tribunal where the hearing is scheduled.',
    `filing_id` BIGINT COMMENT 'The unique identifier assigned by the Electronic Case Filing system for any filings associated with this hearing.',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to knowledge.form_template. Business justification: Hearings require specific court forms (notice of hearing, appearance forms, motion forms). Linking hearing to the form template used enables form library management, tracks form usage, and ensures com',
    `indemnity_claim_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_claim. Business justification: Hearings in indemnity claim litigation are tracked for insurer reporting, reserve adjustments, and defense cost allocation; critical for claims management and regulatory compliance.',
    `judge_id` BIGINT COMMENT 'Reference to the presiding judge or arbitrator for this hearing.',
    `matter_id` BIGINT COMMENT 'Reference to the matter or case to which this hearing belongs.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'The identifier of the user who last modified this hearing record.',
    `prior_hearing_id` BIGINT COMMENT 'Reference to the previous hearing record if this hearing is a continuation.',
    `privacy_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_breach. Business justification: Hearings in privacy breach litigation inform supervisory authority notifications, risk assessments, and remediation planning; critical for GDPR compliance and DPO reporting.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.client_profile. Business justification: Hearings involve client representation. Linking enables client attendance tracking, billing reconciliation for hearing preparation time, client communication workflows, and client satisfaction metrics',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Hearings create risk events (adverse rulings, missed appearances, procedural sanctions) requiring documentation in risk management systems for malpractice prevention and quality control.',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: Hearings in breach-related litigation require tracking for regulatory reporting; compliance teams monitor hearing outcomes to assess remediation progress and regulatory exposure.',
    `research_memo_id` BIGINT COMMENT 'Foreign key linking to knowledge.research_memo. Business justification: Complex hearings (summary judgment, Daubert, dispositive motions) require extensive legal research. Linking hearing to supporting research memos captures the research underlying hearing preparation, e',
    `timekeeper_id` BIGINT COMMENT 'The identifier of the user who created this hearing record.',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the hearing concluded.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the hearing commenced.',
    `adr_proceeding_flag` BOOLEAN COMMENT 'Indicates whether this hearing is part of an Alternative Dispute Resolution proceeding such as mediation or arbitration.',
    `appearance_required_flag` BOOLEAN COMMENT 'Indicates whether attorney or client appearance is mandatory for this hearing.',
    `appearance_type` STRING COMMENT 'The mode of appearance permitted or required for this hearing.. Valid values are `in person|telephonic|video conference|written submission`',
    `arbitration_body` STRING COMMENT 'The name of the arbitration institution administering the proceeding (e.g., International Chamber of Commerce (ICC), London Court of International Arbitration (LCIA)).',
    `client_attendance_flag` BOOLEAN COMMENT 'Indicates whether the client attended or was present at the hearing.',
    `continuance_flag` BOOLEAN COMMENT 'Indicates whether this hearing has been continued or rescheduled from a prior date.',
    `continuance_reason` STRING COMMENT 'The reason provided for continuing or rescheduling the hearing.',
    `courtroom_number` STRING COMMENT 'The physical courtroom or chamber number where the hearing is held.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this hearing record was first created in the system.',
    `duration_minutes` STRING COMMENT 'The total duration of the hearing in minutes, calculated from actual start and end times.',
    `hearing_number` STRING COMMENT 'External business identifier or docket number assigned to this hearing by the court or firm.',
    `hearing_status` STRING COMMENT 'Current lifecycle status of the hearing in the court calendar and matter workflow. [ENUM-REF-CANDIDATE: scheduled|confirmed|in progress|completed|continued|cancelled|vacated — 7 candidates stripped; promote to reference product]',
    `hearing_type` STRING COMMENT 'Classification of the hearing event. [ENUM-REF-CANDIDATE: status conference|motion hearing|trial|deposition|arbitration session|preliminary hearing|sentencing|oral argument|case management conference|settlement conference — promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this hearing record was last updated or modified.',
    `notes` STRING COMMENT 'Internal notes or observations recorded by the attorney regarding the hearing proceedings.',
    `opposing_counsel_name` STRING COMMENT 'The name of the opposing counsel or law firm appearing at the hearing.',
    `outcome_summary` STRING COMMENT 'A brief narrative summary of the hearing outcome, ruling, or decision rendered.',
    `pacer_case_number` STRING COMMENT 'The case number used in the PACER system for federal court access and docket retrieval.',
    `ruling_date` DATE COMMENT 'The date on which the judge issued a ruling or order following the hearing.',
    `ruling_issued_flag` BOOLEAN COMMENT 'Indicates whether a formal ruling or order was issued as a result of this hearing.',
    `scheduled_date` DATE COMMENT 'The date on which the hearing is scheduled to occur.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The anticipated date and time when the hearing is expected to conclude.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time when the hearing is scheduled to begin.',
    `transcript_available_flag` BOOLEAN COMMENT 'Indicates whether an official court transcript of the hearing is available.',
    `transcript_ordered_date` DATE COMMENT 'The date on which the hearing transcript was ordered from the court reporter.',
    `transcript_received_date` DATE COMMENT 'The date on which the official transcript was received by the firm.',
    `virtual_meeting_url` STRING COMMENT 'The URL or meeting link for accessing the virtual hearing session.',
    `virtual_platform` STRING COMMENT 'The name of the virtual conferencing platform used for remote hearings (e.g., Zoom, Microsoft Teams, CourtCall).',
    CONSTRAINT pk_hearing PRIMARY KEY(`hearing_id`)
) COMMENT 'Transactional record of each scheduled or completed court hearing, conference, or oral argument. Captures hearing type (status conference, motion hearing, trial, deposition, arbitration session), scheduled date and time, courtroom or virtual platform, presiding judge, duration, outcome summary, continuance flag, and appearance requirements. Feeds the firm-wide court calendar and attorney appearance tracking workflows.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`appearance` (
    `appearance_id` BIGINT COMMENT 'Unique identifier for the attorney appearance record. Primary key.',
    `docket_id` BIGINT COMMENT 'Reference to the court docket or case file for which the appearance was made. Links to the docket management record.',
    `hearing_id` BIGINT COMMENT 'Reference to the specific hearing, proceeding, or court session at which the attorney appeared. Links to the hearing schedule record.',
    `matter_id` BIGINT COMMENT 'Reference to the client matter for which the appearance was made. Links to the matter management record for billing and matter tracking purposes.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.client_profile. Business justification: Attorney appearances are on behalf of clients. Direct link supports client utilization reporting, matter staffing analysis, client service quality metrics, and UTBMS activity code validation for e-bil',
    `time_entry_id` BIGINT COMMENT 'Reference to the corresponding time entry record in the time and billing system. Links the appearance to the billable time record for invoice generation.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the attorney or legal professional making the appearance. Links to the timekeeper master record in the practice management system.',
    `adr_forum` STRING COMMENT 'The name or identifier of the ADR forum or arbitration body if the appearance was for an arbitration or mediation proceeding (e.g., ICC, LCIA, AAA). Null for court appearances.',
    `appearance_date` DATE COMMENT 'The calendar date on which the attorney made the court appearance. Used for billing verification, court-mandated reporting, and attorney utilization analytics.',
    `appearance_status` STRING COMMENT 'Current status of the appearance record in its lifecycle. Tracks whether the appearance was completed as scheduled, cancelled, postponed, or if the attorney did not appear.. Valid values are `scheduled|completed|cancelled|postponed|no_show`',
    `appearance_type` STRING COMMENT 'Classification of the attorneys role in the proceeding. Indicates whether the attorney appeared as lead counsel, co-counsel, local counsel, observer, amicus curiae, or intervenor.. Valid values are `lead_counsel|co_counsel|local_counsel|observer|amicus_curiae|intervenor`',
    `bar_admission_jurisdiction` STRING COMMENT 'The jurisdiction (state, federal district, or country) in which the attorney is admitted to practice and under which authority they made the appearance. Uses standard jurisdiction codes.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the time spent on this appearance is billable to the client. True if billable, False if non-billable (e.g., pro bono, internal matter).',
    `billed_flag` BOOLEAN COMMENT 'Indicates whether the time for this appearance has been included in a client invoice. True if already billed, False if unbilled Work in Progress (WIP).',
    `continuance_granted` BOOLEAN COMMENT 'Indicates whether a continuance or postponement was granted during this appearance. True if continuance was granted, False otherwise.',
    `court_jurisdiction` STRING COMMENT 'The jurisdiction of the court or tribunal where the appearance took place. Identifies the legal authority under which the proceeding was conducted.',
    `court_reporter_present` BOOLEAN COMMENT 'Indicates whether a court reporter was present to create an official transcript of the proceeding. True if reporter present, False otherwise.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created this appearance record. Supports audit trail and accountability requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this appearance record was first created in the system. Used for audit trail and data lineage tracking.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total time spent by the attorney at the appearance, measured in hours. Calculated from start and end times or manually entered. Used for billing and timekeeper utilization analysis.',
    `ecf_filing_reference` STRING COMMENT 'Reference number or identifier from the Electronic Case Filing system linking this appearance to the official court record. Used for PACER integration and docket tracking.',
    `end_time` TIMESTAMP COMMENT 'The precise timestamp when the attorneys appearance concluded. Used to calculate total time spent for billing and resource allocation.',
    `judge_name` STRING COMMENT 'Name of the judge, magistrate, arbitrator, or mediator presiding over the proceeding. Used for court analytics and conflict checking.',
    `location` STRING COMMENT 'Physical location or venue where the appearance took place. May be a courthouse name, arbitration center, or office location. Null for remote appearances.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this appearance record. Supports audit trail and accountability requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this appearance record was last modified. Used for audit trail, data lineage, and change tracking.',
    `next_hearing_date` DATE COMMENT 'The date of the next scheduled hearing or appearance resulting from this proceeding. Null if no follow-up hearing was scheduled.',
    `opposing_counsel_name` STRING COMMENT 'Name of the opposing counsel or law firm present at the appearance. Used for relationship tracking and conflict checking.',
    `outcome_notes` STRING COMMENT 'Free-text narrative describing the outcome or key events of the appearance. May include rulings, decisions, next steps, or observations. Confidential attorney work product.',
    `preparation_time_hours` DECIMAL(18,2) COMMENT 'Time spent preparing for the appearance, including research, document review, and strategy sessions. Measured in hours and typically billable to the client matter.',
    `pro_hac_vice_status` BOOLEAN COMMENT 'Indicates whether the attorney appeared under pro hac vice admission (temporary admission to practice in a jurisdiction where they are not regularly licensed). True if pro hac vice, False if admitted in the jurisdiction.',
    `proceeding_type` STRING COMMENT 'Classification of the type of legal proceeding at which the appearance was made. Distinguishes between court hearings, trials, depositions, Alternative Dispute Resolution (ADR) sessions, arbitration, and mediation.. Valid values are `hearing|trial|deposition|arbitration|mediation|settlement_conference`',
    `remote_appearance_flag` BOOLEAN COMMENT 'Indicates whether the appearance was conducted remotely via video conference or telephone rather than in person. True if remote, False if in-person.',
    `ruling_received` BOOLEAN COMMENT 'Indicates whether a judicial ruling or decision was issued during or as a result of this appearance. True if a ruling was received, False otherwise.',
    `start_time` TIMESTAMP COMMENT 'The precise timestamp when the attorneys appearance began. Supports accurate time tracking for billing and utilization reporting.',
    `transcript_ordered` BOOLEAN COMMENT 'Indicates whether a transcript of the proceeding has been ordered. True if transcript ordered, False otherwise. Used for document management and billing tracking.',
    `travel_time_hours` DECIMAL(18,2) COMMENT 'Time spent traveling to and from the appearance location, measured in hours. May be billable or non-billable depending on client agreement and Alternative Fee Arrangement (AFA) terms.',
    `utbms_activity_code` STRING COMMENT 'The UTBMS activity code providing granular detail on the specific activity performed during the appearance. Used for detailed billing analysis and client reporting.',
    `utbms_task_code` STRING COMMENT 'The UTBMS task code associated with this appearance for standardized billing and matter management. Enables consistent categorization of legal work across firms and clients.',
    CONSTRAINT pk_appearance PRIMARY KEY(`appearance_id`)
) COMMENT 'Records each attorney appearance at a court proceeding, arbitration session, or ADR hearing. Stores timekeeper reference, docket reference, hearing reference, appearance type (lead counsel, co-counsel, local counsel, observer), pro hac vice status, bar admission jurisdiction, appearance date, outcome notes, and time spent. Supports billing verification, court-mandated appearance reporting, and attorney utilization analytics.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`filing` (
    `filing_id` BIGINT COMMENT 'Unique identifier for the court filing record. Primary key.',
    `amended_filing_id` BIGINT COMMENT 'Reference to the original filing that this filing amends or supersedes, if applicable.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or legal professional who submitted the filing on behalf of the client.',
    `clause_id` BIGINT COMMENT 'Foreign key linking to knowledge.clause. Business justification: Certain filings (settlement agreements filed with court, consent decrees, stipulations) contain negotiated clauses from the clause library. Links filing to reusable clause content, enables clause perf',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to knowledge.form_template. Business justification: Court filings are generated from standardized form templates (pleadings, motions, briefs, discovery requests). This is the primary use case for form templates in litigation practice, enabling template',
    `indemnity_claim_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_claim. Business justification: Court filings in indemnity defense must be documented for insurer coordination, defense cost tracking, and SRA reporting; essential for claims management workflow.',
    `legal_document_id` BIGINT COMMENT 'Reference to the source document in the document management system that was filed.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case for which this filing was submitted.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the system user who last modified this filing record.',
    `privacy_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_breach. Business justification: Court filings in breach litigation must be tracked for DPO reporting, supervisory authority coordination, and breach incident documentation; essential for GDPR compliance.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.client_profile. Business justification: Court filings are made on behalf of clients. Direct link supports e-billing LEDES file generation, outside counsel guideline compliance reporting, client-specific filing analytics, and cost allocation',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Filing errors, rejections, and deadline non-compliance are primary malpractice triggers. Risk teams track filing failures for insurer notification and practice improvement initiatives.',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: Court filings in breach litigation must be documented for compliance records and regulatory defense; essential for breach incident lifecycle tracking and supervisory authority coordination.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the system user who created this filing record.',
    `tribunal_id` BIGINT COMMENT 'Reference to the court, tribunal, or arbitral body where the document was filed.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the filing fee and associated costs are billable to the client for cost recovery.',
    `confidential_flag` BOOLEAN COMMENT 'Indicates whether the filing contains confidential or sealed information subject to restricted access.',
    `cost_allocation_code` STRING COMMENT 'The code used to allocate filing costs to specific client billing categories or cost centers.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this filing record was first created in the system.',
    `deadline_compliance_flag` BOOLEAN COMMENT 'Indicates whether the filing was submitted on or before the applicable deadline (True) or was late (False).',
    `deadline_date` DATE COMMENT 'The court-imposed or procedural deadline by which the filing must be submitted.',
    `docket_entry_number` STRING COMMENT 'The sequential number assigned to this filing on the court docket or case register.',
    `ecf_confirmation_number` STRING COMMENT 'The confirmation number issued by the Electronic Case Filing system upon successful submission of the filing.',
    `exhibit_count` STRING COMMENT 'The number of exhibits or attachments included with the filing.',
    `expedited_flag` BOOLEAN COMMENT 'Indicates whether the filing was submitted under expedited or emergency procedures.',
    `fee_amount` DECIMAL(18,2) COMMENT 'The monetary fee charged by the court or tribunal for processing the filing.',
    `fee_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the filing fee amount.. Valid values are `^[A-Z]{3}$`',
    `filing_date` DATE COMMENT 'The date on which the document was officially filed with the court or tribunal.',
    `filing_description` STRING COMMENT 'A brief textual description or summary of the filing content and purpose.',
    `filing_number` STRING COMMENT 'The court-assigned or system-generated unique filing number for tracking and reference purposes.',
    `filing_status` STRING COMMENT 'Current status of the filing indicating whether it has been accepted, rejected, or is pending review by the court.. Valid values are `accepted|rejected|pending|withdrawn|amended`',
    `filing_timestamp` TIMESTAMP COMMENT 'The precise date and time when the filing was submitted to the court system, critical for deadline compliance and time-stamped filings.',
    `filing_type` STRING COMMENT 'The category or type of document being filed with the court. [ENUM-REF-CANDIDATE: complaint|motion|brief|answer|notice|order|judgment|petition|affidavit|exhibit — 10 candidates stripped; promote to reference product]',
    `format` STRING COMMENT 'The format in which the filing was submitted to the court.. Valid values are `pdf|docx|electronic|paper`',
    `hearing_date` DATE COMMENT 'The scheduled date for any hearing or court appearance associated with this filing.',
    `judge_assigned` STRING COMMENT 'The name of the judge or judicial officer assigned to review or rule on this filing.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this filing record was last modified or updated.',
    `notes` STRING COMMENT 'Additional notes or comments related to the filing, including special instructions or procedural context.',
    `pacer_transaction_reference` STRING COMMENT 'The transaction identifier assigned by PACER for federal court filings, used for tracking and retrieval.',
    `page_count` STRING COMMENT 'The total number of pages in the filed document.',
    `party` STRING COMMENT 'The role or designation of the party on whose behalf the filing is made. [ENUM-REF-CANDIDATE: plaintiff|defendant|petitioner|respondent|appellant|appellee|intervenor|amicus_curiae — 8 candidates stripped; promote to reference product]',
    `rejection_reason` STRING COMMENT 'The reason provided by the court or ECF system for rejecting the filing, if applicable.',
    `sealed_flag` BOOLEAN COMMENT 'Indicates whether the filing has been sealed by court order and is not available for public access.',
    `service_date` DATE COMMENT 'The date on which the filing was served on the opposing parties or other required recipients.',
    `service_method` STRING COMMENT 'The method by which the filing was served on opposing parties or the court.. Valid values are `electronic|mail|hand_delivery|certified_mail|courier`',
    CONSTRAINT pk_filing PRIMARY KEY(`filing_id`)
) COMMENT 'Transactional record of every document filed with a court, tribunal, or arbitral body. Captures filing type (complaint, motion, brief, answer, notice, order, judgment), filing date/time, ECF confirmation number, PACER transaction ID, filed-by attorney, filing fee amount, service method, acceptance status (accepted, rejected, pending), and deadline compliance flag. Links to document management for source document reference and supports cost recovery allocation for client billing.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`matter_deadline` (
    `matter_deadline_id` BIGINT COMMENT 'Primary key for deadline',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or timekeeper assigned primary responsibility for meeting this deadline.',
    `checklist_id` BIGINT COMMENT 'Foreign key linking to knowledge.checklist. Business justification: Deadline management follows jurisdiction-specific procedural checklists. Links deadline to the compliance checklist used to identify and track it, critical for malpractice prevention and procedural co',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Critical deadlines often require specific client contact action (document production, settlement authority, filing approvals). This link enables targeted deadline notifications, tracks client responsi',
    `docket_id` BIGINT COMMENT 'Reference to the docket or case to which this deadline applies.',
    `hearing_id` BIGINT COMMENT 'Foreign key linking to matter.hearing. Business justification: Court deadlines are often set during hearings or are hearing-related (e.g., deadline to file pre-hearing briefs). The matter_deadline table does not currently link to the hearing entity. This FK allow',
    `judge_id` BIGINT COMMENT 'Reference to the judge who issued the order or ruling establishing this deadline.',
    `last_modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified this deadline record.',
    `matter_id` BIGINT COMMENT 'Reference to the internal matter associated with this deadline.',
    `order_id` BIGINT COMMENT 'Foreign key linking to matter.order. Business justification: Court orders frequently impose deadlines (e.g., deadline to respond to a motion, deadline to produce documents). The matter_deadline table has court_rule_citation and triggering_event fields but no di',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.client_profile. Business justification: Court deadlines are client-specific obligations. Direct link enables client-facing deadline dashboards, malpractice risk monitoring per client, client notification workflows, and compliance reporting ',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Missed court deadlines are the leading cause of legal malpractice claims. Risk management systems track deadline compliance failures for insurer reporting and practice quality control.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Legal deadlines are often imposed by regulatory obligations (filing deadlines, response deadlines, compliance certification deadlines, regulatory notice requirements). Tracking which regulatory obliga',
    `responsible_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney or paralegal) who is primarily responsible for ensuring compliance with this deadline.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who created this deadline record in the system.',
    `tribunal_id` BIGINT COMMENT 'Reference to the court or tribunal that imposed or governs this deadline.',
    `adr_proceeding_flag` BOOLEAN COMMENT 'Indicates whether this deadline is associated with an ADR proceeding such as arbitration or mediation (True/False).',
    `adr_proceeding_type` STRING COMMENT 'Type of ADR proceeding if applicable (e.g., arbitration, mediation, settlement conference, early neutral evaluation).. Valid values are `arbitration|mediation|settlement_conference|early_neutral_evaluation`',
    `alert_days_before` STRING COMMENT 'Number of days before the due date when alerts or reminders should be triggered.',
    `alert_sent_flag` BOOLEAN COMMENT 'Indicates whether an alert or reminder has been sent for this deadline (True/False).',
    `alert_sent_timestamp` TIMESTAMP COMMENT 'The timestamp when the most recent alert was sent. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `calendar_entry_reference` STRING COMMENT 'Reference to the calendar or docket control system entry associated with this deadline for tracking and reminder purposes.',
    `calendar_sync_status` STRING COMMENT 'Status indicating whether this deadline has been successfully synchronized with the firm-wide court calendar system.. Valid values are `synced|pending|failed|not_synced`',
    `calendar_sync_timestamp` TIMESTAMP COMMENT 'The timestamp when the deadline was last synchronized with the calendar system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `client_notified_date` DATE COMMENT 'The date on which the client was notified of this deadline, particularly important for critical deadlines requiring client input or approval.',
    `completion_date` DATE COMMENT 'The actual date on which the required action was completed and the deadline was satisfied. Null if not yet completed.',
    `completion_notes` STRING COMMENT 'Free-text notes documenting how the deadline was satisfied, any issues encountered, or reasons for missed or waived status.',
    `completion_status` STRING COMMENT 'Current status of the deadline: pending (not yet due), completed (satisfied on time), missed (deadline passed without completion), waived (deadline no longer applicable), extended (deadline date moved).. Valid values are `pending|completed|missed|waived|extended`',
    `completion_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the deadline was marked as completed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `court_case_number` STRING COMMENT 'The official case number or docket number assigned by the court or tribunal, if this deadline is associated with litigation.',
    `court_rule_citation` STRING COMMENT 'Citation to the applicable court rule, statute, or procedural code that establishes this deadline (e.g., FRCP 12(a)(1)(A), Local Rule 7.1).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this deadline record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `deadline_date` DATE COMMENT 'The calendar date by which the required action must be completed. This is the hard deadline for compliance or filing.',
    `deadline_description` STRING COMMENT 'Detailed narrative description of the deadline, including the specific action required, the legal basis, and any relevant context or instructions.',
    `deadline_time` TIMESTAMP COMMENT 'The precise timestamp (date and time) by which the action must be completed, used when time-of-day precision is required (e.g., court filing cutoff at 11:59 PM).',
    `deadline_type` STRING COMMENT 'Classification of the deadline by its legal or procedural nature (e.g., statute of limitations, court-ordered deadline, regulatory filing deadline, contractual notice period, discovery cutoff, motion filing deadline).. Valid values are `statute_of_limitations|court_ordered|regulatory_filing|contractual_notice|discovery_cutoff|motion_filing`',
    `document_reference` STRING COMMENT 'Reference to the document or filing that must be completed by this deadline (e.g., Motion for Summary Judgment, Answer to Complaint, SEC Form 10-K).',
    `due_date` DATE COMMENT 'The calculated date by which the deadline must be met. Format: yyyy-MM-dd.',
    `due_time` TIMESTAMP COMMENT 'The precise timestamp by which the deadline must be met, including time of day. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `ecf_filing_required_flag` BOOLEAN COMMENT 'Indicates whether this deadline requires an electronic filing through the courts ECF system (True/False).',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this deadline requires escalation to senior management or the supervising partner if not completed within the reminder window.',
    `extended_deadline_date` DATE COMMENT 'The new deadline date after an extension has been granted. Null if no extension has been granted.',
    `extended_due_date` DATE COMMENT 'The new due date after an extension has been granted. Format: yyyy-MM-dd.',
    `extension_granted_date` DATE COMMENT 'The date on which an extension to the original deadline was granted by the court, opposing counsel, or regulatory body.',
    `extension_granted_flag` BOOLEAN COMMENT 'Indicates whether an extension of time was granted for this deadline (True/False).',
    `extension_order_reference` STRING COMMENT 'Reference number or citation to the court order granting the extension of time.',
    `filing_method` STRING COMMENT 'The method by which the deadline action must be filed or delivered (electronic filing, paper filing, hand delivery, certified mail).. Valid values are `electronic|paper|hand_delivery|certified_mail`',
    `governing_rule_reference` STRING COMMENT 'Citation to the statute, rule, regulation, or contractual provision that establishes this deadline (e.g., FRCP Rule 56(c), 28 U.S.C. § 1658, Contract Section 12.3).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this deadline is currently active and requires monitoring. Inactive deadlines are historical or cancelled.',
    `jurisdiction` STRING COMMENT 'The legal jurisdiction or court system under which this deadline is governed (e.g., Federal District Court Southern District of New York, California Superior Court, SEC).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this deadline record was last updated in the system.',
    `malpractice_insurance_notified` BOOLEAN COMMENT 'Indicates whether the firms malpractice insurance carrier has been notified of a missed deadline or potential claim related to this deadline.',
    `malpractice_risk_flag` BOOLEAN COMMENT 'Indicates whether missing this deadline poses a significant malpractice risk (True/False). Used for risk management and quality control.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified this deadline record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this deadline record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the deadline, including special instructions, dependencies, or context.',
    `opposing_counsel_name` STRING COMMENT 'Name of the opposing counsel or law firm involved in the matter, relevant for deadlines involving adversarial proceedings.',
    `pacer_case_number` STRING COMMENT 'The PACER case number associated with this deadline for federal court cases.',
    `priority_level` STRING COMMENT 'Business priority classification of the deadline based on risk, client impact, and legal consequences (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `reminder_lead_time_days` STRING COMMENT 'Number of days before the deadline date when the first reminder notification should be triggered to the responsible timekeeper.',
    `responsible_team` STRING COMMENT 'Name or identifier of the practice group or team responsible for this deadline.',
    `risk_level` STRING COMMENT 'Assessment of the malpractice or business risk associated with missing this deadline (high, medium, low).. Valid values are `high|medium|low`',
    `triggering_event` STRING COMMENT 'The event or action that initiated the deadline calculation (e.g., service of complaint, court order issued, notice of appeal filed).',
    `triggering_event_date` DATE COMMENT 'The date on which the triggering event occurred. Format: yyyy-MM-dd.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created this deadline record.',
    CONSTRAINT pk_matter_deadline PRIMARY KEY(`matter_deadline_id`)
) COMMENT 'Tracks all court-imposed and rule-based deadlines associated with a docket or ADR proceeding. Stores deadline type (answer due, discovery cutoff, motion deadline, trial date, appeal window, briefing deadline), calculated due date, triggering event, applicable court rule citation, responsible attorney, completion status, extension granted flag, extension order reference, and calendar synchronization status. Critical for docket management, malpractice risk avoidance, and firm-wide court calendar views.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`order` (
    `order_id` BIGINT COMMENT 'Primary key for order',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or timekeeper responsible for tracking and managing compliance with this order on behalf of the firms client.',
    `clause_id` BIGINT COMMENT 'Foreign key linking to knowledge.clause. Business justification: Court orders, especially injunctions and consent decrees, incorporate standard clauses (injunctive relief language, compliance provisions, reporting requirements). Linking enables clause library manag',
    `jurisdiction_id` BIGINT COMMENT 'Reference to the court or tribunal that issued the order.',
    `data_subject_request_id` BIGINT COMMENT 'Foreign key linking to compliance.data_subject_request. Business justification: Court orders compelling DSR compliance or challenging refusals must be tracked for GDPR compliance, DPO reporting, and supervisory authority coordination.',
    `docket_id` BIGINT COMMENT 'Reference to the docket or case to which this order pertains.',
    `hearing_id` BIGINT COMMENT 'Foreign key linking to matter.hearing. Business justification: Court orders are frequently issued during or immediately following hearings. The order table has hearing_date as a STRING but no FK to the hearing entity. Adding this FK allows direct linkage to the h',
    `indemnity_claim_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_claim. Business justification: Court orders in indemnity litigation (discovery orders, summary judgment) affect claim management, defense strategy, and insurer coordination; essential for claims workflow.',
    `judge_id` BIGINT COMMENT 'Reference to the judge who issued or signed the order.',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Court orders are legal documents requiring DMS storage; linking order records to document representations enables unified document retrieval, version control, and integration with matter-based documen',
    `matter_id` BIGINT COMMENT 'Reference to the internal matter associated with this court order.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Court orders, especially published opinions and significant rulings, become precedents for future matters. This captures the knowledge creation lifecycle from court order to reusable precedent, essent',
    `privacy_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_breach. Business justification: Court orders in privacy litigation (disclosure orders, injunctions) affect breach response, DPO obligations, and supervisory authority reporting; critical for GDPR compliance.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.client_profile. Business justification: Court orders directly affect clients. Linking supports client outcome tracking, win/loss reporting, appeals deadline monitoring, client communication about order compliance, and litigation portfolio a',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Adverse court orders (sanctions, fee awards, injunctions against clients) generate risk events requiring documentation for practice management, client communication, and potential malpractice defense.',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: Court orders in breach cases (injunctions, compliance orders) must be tracked for remediation planning, regulatory reporting, and breach incident closure.',
    `filing_id` BIGINT COMMENT 'Reference to the motion or pleading that prompted this order, if applicable. Null if the order was issued sua sponte (on the courts own initiative).',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user or system account that created this order record. Audit trail field.',
    `trust_disbursement_id` BIGINT COMMENT 'Foreign key linking to trust.trust_disbursement. Business justification: Court orders may mandate specific disbursements from trust accounts: payments to opposing parties, sanctions, cost awards, or settlement distributions. Firms must link orders to trust disbursements fo',
    `updated_by_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this order record. Audit trail field.',
    `adr_proceeding_type` STRING COMMENT 'If the order relates to or arises from an Alternative Dispute Resolution (ADR) proceeding, specifies the type: mediation, arbitration (including ICC, LCIA), settlement conference, or none if not ADR-related.. Valid values are `mediation|arbitration|settlement_conference|none`',
    `appeal_deadline` DATE COMMENT 'The last date on which a party may file an appeal or motion to reconsider this order, as determined by applicable court rules.',
    `compliance_deadline` DATE COMMENT 'The date by which parties must comply with the directives or obligations set forth in the order. Null if no specific deadline is imposed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for any monetary amounts in the order (e.g., USD, GBP, EUR). Null if no monetary amounts are involved.. Valid values are `^[A-Z]{3}$`',
    `document_storage_path` STRING COMMENT 'Internal file path or document management system (DMS) reference where the order document is stored (e.g., iManage Work, NetDocuments).',
    `ecf_document_number` STRING COMMENT 'The document number assigned by the courts Electronic Case Filing (ECF) system. Used for PACER retrieval and docket tracking.',
    `effective_date` DATE COMMENT 'The date from which the order becomes legally effective and enforceable. May differ from issue date if the order specifies a future effective date.',
    `enforcement_status` STRING COMMENT 'Current status of enforcement or compliance activities: not_required (order is declaratory or self-executing), pending (enforcement not yet initiated), in_progress (active enforcement), completed (obligations fulfilled), or contested (enforcement disputed).. Valid values are `not_required|pending|in_progress|completed|contested`',
    `filing_method` STRING COMMENT 'The method by which the order was filed or entered: ECF (Electronic Case Filing system), paper (physical filing), email, or fax.. Valid values are `ecf|paper|email|fax`',
    `is_appealable` BOOLEAN COMMENT 'Indicates whether the order is immediately appealable (true) or interlocutory and not subject to immediate appeal (false).',
    `is_final` BOOLEAN COMMENT 'Indicates whether the order is a final order disposing of all claims and parties (true) or an interlocutory order (false).',
    `is_published` BOOLEAN COMMENT 'Indicates whether the order is published in official court reporters or legal databases (true) or remains unpublished (false). Published orders may have precedential value.',
    `is_sealed` BOOLEAN COMMENT 'Indicates whether the order is under seal (true) and subject to restricted access, or publicly accessible (false).',
    `issue_date` DATE COMMENT 'The date on which the court issued or entered the order. This is the principal business event timestamp for the order.',
    `monetary_award_amount` DECIMAL(18,2) COMMENT 'The total monetary amount awarded or ordered to be paid, if the order includes a financial judgment or damages award. Null if the order does not involve monetary relief.',
    `notes` STRING COMMENT 'Internal notes, annotations, or strategic commentary regarding the order, its implications, or required follow-up actions. Confidential attorney work product.',
    `order_category` STRING COMMENT 'High-level categorization of the orders subject matter: discovery (document production, depositions), motion (ruling on a motion), scheduling (case management), judgment (final disposition), sentencing (criminal penalty), or relief (equitable remedy).. Valid values are `discovery|motion|scheduling|judgment|sentencing|relief`',
    `order_number` STRING COMMENT 'The court-assigned or internally-assigned unique number identifying this order. This is the externally-known business identifier.',
    `order_status` STRING COMMENT 'Current lifecycle status of the order: draft (prepared but not issued), issued (entered by court), stayed (temporarily suspended), vacated (nullified), appealed (under appellate review), enforced (execution in progress), or complied (obligations fulfilled). [ENUM-REF-CANDIDATE: draft|issued|stayed|vacated|appealed|enforced|complied — 7 candidates stripped; promote to reference product]',
    `order_text` STRING COMMENT 'The complete text of the court order as issued. May contain confidential case details and party information.',
    `order_type` STRING COMMENT 'Classification of the order by its legal nature: procedural (scheduling, discovery), substantive (merits decision), consent (agreed by parties), default (non-appearance), summary judgment (pre-trial disposition), or injunction (equitable relief).. Valid values are `procedural|substantive|consent|default|summary_judgment|injunction`',
    `pacer_url` STRING COMMENT 'Direct URL to the order document in the PACER (Public Access to Court Electronic Records) system for federal court orders.',
    `prevailing_party` STRING COMMENT 'Identifies which party or side prevailed or was granted relief by the order. none indicates the order was neutral or procedural without a clear prevailing party. [ENUM-REF-CANDIDATE: plaintiff|defendant|petitioner|respondent|movant|non_movant|none — 7 candidates stripped; promote to reference product]',
    `summary` STRING COMMENT 'A concise textual summary of the orders content, directives, and key holdings. Provides quick reference without reading the full order text.',
    `title` STRING COMMENT 'The formal title or caption of the order as it appears in court records (e.g., Order Granting Motion for Summary Judgment, Temporary Restraining Order).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this order record was last modified. Audit trail field.',
    CONSTRAINT pk_order PRIMARY KEY(`order_id`)
) COMMENT 'Records judicial orders, rulings, and decisions issued in connection with a docket. Captures order type (procedural, substantive, consent, default, summary judgment, injunction), issue date, issuing judge, order text summary, compliance deadline, appeal deadline, enforcement status, and whether the order is published or unpublished. Distinct from filed documents — this is the authoritative record of what the court has directed.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`court_rule` (
    `court_rule_id` BIGINT COMMENT 'Unique identifier for the court rule record. Primary key.',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to knowledge.form_template. Business justification: Court rules mandate specific forms (local rule forms, mandatory judicial council forms, model forms). Linking rule to template ensures compliance, tracks form currency when rules change, and enables a',
    `parent_rule_court_rule_id` BIGINT COMMENT 'Reference to the parent rule if this is a sub-rule or subsection. Enables hierarchical rule structures (e.g., Rule 26(a)(1) is a child of Rule 26).',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Court rules vary by practice area (civil procedure, criminal, family, IP). Firms map rules to practice areas for compliance automation, deadline calculation engines, training programs, and knowledge m',
    `practice_note_id` BIGINT COMMENT 'Foreign key linking to knowledge.practice_note. Business justification: Court rules are explained and contextualized in practice notes (rule interpretation, practical application, compliance tips, common pitfalls). Linking rule to interpretive practice notes supports atto',
    `primary_superseded_by_rule_court_rule_id` BIGINT COMMENT 'Reference to the court rule that supersedes or replaces this rule. Null if the rule is still active or was retired without replacement.',
    `tribunal_id` BIGINT COMMENT 'Reference to the court or tribunal to which this rule applies. Links to the court master data.',
    `advisory_committee_notes` STRING COMMENT 'Summary or reference to advisory committee notes or official commentary explaining the purpose and application of this rule. Provides interpretive guidance.',
    `amendment_history` STRING COMMENT 'Summary of significant amendments to this rule, including dates and nature of changes. Supports historical research and transition planning.',
    `applicable_case_types` STRING COMMENT 'Comma-separated list of case types to which this rule applies (e.g., civil, criminal, bankruptcy, family, probate). Null if the rule applies to all case types in the court.',
    `citation_format` STRING COMMENT 'The standard citation format for this rule as used in legal briefs and filings (e.g., Fed. R. Civ. P. 26(a), Local Rule 7.1(a)).',
    `compliance_checklist` STRING COMMENT 'Structured checklist or list of requirements that must be satisfied to comply with this rule. Supports automated compliance verification and attorney guidance.',
    `court_rule_status` STRING COMMENT 'Current lifecycle status of the court rule. Active rules are enforceable; superseded rules have been replaced; proposed rules are pending adoption.. Valid values are `active|superseded|proposed|suspended|archived`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this court rule record was first created in the system. Audit trail field.',
    `deadline_calculation_rule` STRING COMMENT 'Formula or logic for calculating deadlines under this rule (e.g., 30 days from service, 14 days before hearing, within 21 days of order). Enables automated deadline tracking and calendar management.',
    `ecf_event_code` STRING COMMENT 'The ECF event code associated with filings governed by this rule. Used for automated docket entry and deadline calculation in CM/ECF systems.',
    `effective_date` DATE COMMENT 'The date on which this court rule became or will become effective and enforceable. Critical for determining applicability to pending matters.',
    `electronic_filing_required` BOOLEAN COMMENT 'Indicates whether this rule mandates electronic filing through ECF (Electronic Case Filing) or similar systems. True if electronic filing is required; false if paper filing is permitted.',
    `exceptions_and_exemptions` STRING COMMENT 'Description of any exceptions, exemptions, or circumstances under which this rule does not apply or may be waived.',
    `expiry_date` DATE COMMENT 'The date on which this court rule expires or was superseded. Null for rules that remain in effect indefinitely.',
    `jurisdiction_scope` STRING COMMENT 'The jurisdictional level or scope to which this rule applies (e.g., federal, state, specific district, circuit court, appellate court). [ENUM-REF-CANDIDATE: federal|state|district|circuit|appellate|trial|specialized — 7 candidates stripped; promote to reference product]',
    `last_reviewed_date` DATE COMMENT 'The date on which this court rule record was last reviewed or verified for accuracy and currency. Supports knowledge management and compliance assurance.',
    `mandatory_form_reference` STRING COMMENT 'Reference to any mandatory court forms required by this rule (e.g., Form AO 440, CM/ECF Form). Null if no specific form is mandated.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this court rule record was last modified in the system. Audit trail field.',
    `notice_period_days` STRING COMMENT 'Minimum number of days notice required by this rule (e.g., 21 days notice for a motion hearing). Null if no specific notice period is mandated.',
    `page_limit` STRING COMMENT 'Maximum number of pages allowed for filings governed by this rule. Null if no page limit applies.',
    `penalty_for_noncompliance` STRING COMMENT 'Description of sanctions, penalties, or consequences for failing to comply with this rule (e.g., dismissal, striking of pleadings, monetary sanctions, contempt).',
    `related_statutes` STRING COMMENT 'References to statutes, codes, or regulations that this rule implements or relates to (e.g., 28 U.S.C. § 1332, state civil procedure code sections).',
    `rule_category` STRING COMMENT 'Classification of the rule by its primary procedural area. Enables filtering and compliance checks by rule type. [ENUM-REF-CANDIDATE: filing|service|discovery|evidence|scheduling|motion_practice|case_management|electronic_filing|appeal|trial_procedure|other — 11 candidates stripped; promote to reference product]',
    `rule_code` STRING COMMENT 'The official alphanumeric code or citation identifier for the court rule (e.g., FRCP 26, Local Rule 7.1, CPR 3.9). This is the externally-known business identifier used in legal filings and references.',
    `rule_text` STRING COMMENT 'The full text of the court rule or a summary of its key provisions. May include subsections, clauses, and commentary.',
    `rule_title` STRING COMMENT 'The full official title or short description of the court rule (e.g., Duty to Disclose; General Provisions Governing Discovery, Motion Practice).',
    `rule_type` STRING COMMENT 'Distinguishes between federal/national rules, local court rules, standing orders, and practice directions. Determines hierarchy and applicability.. Valid values are `federal_rule|local_rule|standing_order|practice_direction|administrative_order|interim_order`',
    `service_method_required` STRING COMMENT 'The method of service required or permitted by this rule (e.g., personal service, certified mail, electronic service). Critical for compliance with service of process requirements.. Valid values are `personal|mail|electronic|publication|any`',
    `source_document_url` STRING COMMENT 'URL or hyperlink to the authoritative source document for this rule (e.g., court website, legal research platform, official government publication).',
    `word_limit` STRING COMMENT 'Maximum number of words allowed for filings governed by this rule. Null if no word limit applies.',
    CONSTRAINT pk_court_rule PRIMARY KEY(`court_rule_id`)
) COMMENT 'Reference catalog of procedural rules, local rules, standing orders, and practice directions applicable to each court or tribunal. Stores rule code, rule title, effective date, expiry date, court reference, rule category (filing, service, discovery, evidence, scheduling), page/word limits, mandatory form references, and electronic filing requirements. Enables automated deadline calculation and filing compliance checks.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`judgment` (
    `judgment_id` BIGINT COMMENT 'Unique identifier for the judgment record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to trust.trust_account. Business justification: Judgments often result in funds held in trust: settlement proceeds, damage awards, garnished funds, or judgment debtor payments. Attorneys must track which trust account holds judgment-related funds f',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney responsible for managing this judgment and any post-judgment proceedings.',
    `jurisdiction_id` BIGINT COMMENT 'Reference to the court that entered this judgment.',
    `docket_id` BIGINT COMMENT 'Reference to the court docket associated with this judgment.',
    `indemnity_claim_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_claim. Business justification: Judgments in indemnity claims determine payout amounts, reserve releases, and claim closure; critical for insurer settlement and regulatory reporting.',
    `indemnity_exposure_id` BIGINT COMMENT 'Foreign key linking to risk.indemnity_exposure. Business justification: Adverse judgments trigger professional indemnity exposure analysis and insurer notification obligations. Direct operational link for reserve setting and claims management in legal practice.',
    `judge_id` BIGINT COMMENT 'FK to court.judge',
    `legal_document_id` BIGINT COMMENT 'Foreign key linking to document.legal_document. Business justification: Judgments are legal documents requiring DMS storage and retention management; link enables retrieval of judgment documents from case records, supports appeal preparation, and ensures compliance with d',
    `matter_id` BIGINT COMMENT 'Reference to the matter in which this judgment was entered.',
    `order_id` BIGINT COMMENT 'Foreign key linking to matter.order. Business justification: Judgments are often based on or reference prior court orders. This FK allows tracking which order(s) led to or are associated with the judgment. The judgment table does not currently have this link, a',
    `pi_claim_id` BIGINT COMMENT 'Foreign key linking to risk.pi_claim. Business justification: Malpractice claims frequently arise from adverse judgments. Essential link for tracking claim causation, defense strategy, and insurer coordination in professional liability management.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Final judgments, particularly those with novel legal holdings or significant outcomes, are captured as precedents for reuse in future litigation. Essential for knowledge management, legal research, an',
    `privacy_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_breach. Business justification: Judgments in privacy litigation determine financial penalties, remediation obligations, and breach incident closure; critical for supervisory authority reporting and DPO compliance.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.client_profile. Business justification: Judgments are client litigation outcomes. Direct link supports win/loss analysis, financial impact assessment, client satisfaction metrics, appeals planning, and enforcement tracking for judgment coll',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: Final judgments in breach cases determine financial exposure, penalties, and remediation obligations; critical for compliance reporting and regulatory penalty tracking.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary amount awarded in the judgment, if applicable. Null for non-monetary judgments.',
    `appeal_case_number` STRING COMMENT 'Case number assigned by the appellate court for the appeal of this judgment.',
    `appeal_court_name` STRING COMMENT 'Name of the appellate court where an appeal was filed, if applicable.',
    `appeal_deadline_date` DATE COMMENT 'Final date by which an appeal of this judgment must be filed.',
    `appeal_filed_date` DATE COMMENT 'Date on which an appeal of this judgment was filed, if applicable.',
    `attorney_fees_awarded` DECIMAL(18,2) COMMENT 'Amount of attorney fees awarded as part of the judgment, if applicable.',
    `consent_judgment_flag` BOOLEAN COMMENT 'Indicates whether this is a consent judgment agreed to by all parties.',
    `cost_award_amount` DECIMAL(18,2) COMMENT 'Amount of court costs and litigation expenses awarded as part of the judgment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this judgment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the judgment amount.. Valid values are `^[A-Z]{3}$`',
    `declaratory_relief_flag` BOOLEAN COMMENT 'Indicates whether the judgment provides declaratory relief clarifying rights and obligations.',
    `default_judgment_flag` BOOLEAN COMMENT 'Indicates whether this judgment was entered by default due to failure to respond or appear.',
    `ecf_document_number` STRING COMMENT 'Electronic Case Filing system document number for the judgment entry.',
    `enforcement_status` STRING COMMENT 'Current status of enforcement actions taken to collect or execute the judgment.. Valid values are `not_enforced|enforcement_pending|actively_enforced|partially_satisfied|fully_satisfied`',
    `entry_date` DATE COMMENT 'Date on which the judgment was officially entered by the court.',
    `entry_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the judgment was entered into the court record.',
    `final_judgment_flag` BOOLEAN COMMENT 'Indicates whether this is a final judgment that disposes of all claims and parties.',
    `for_client` BOOLEAN COMMENT 'Indicates whether the judgment was favorable to the firms client.',
    `injunctive_relief_flag` BOOLEAN COMMENT 'Indicates whether the judgment includes injunctive relief or equitable remedies.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applicable to the judgment amount from entry date until satisfaction, expressed as a percentage.',
    `judgment_number` STRING COMMENT 'Court-assigned judgment number or docket entry number for this judgment.',
    `judgment_status` STRING COMMENT 'Current lifecycle status of the judgment indicating its enforceability and procedural state. [ENUM-REF-CANDIDATE: entered|appealed|affirmed|reversed|vacated|satisfied|enforced — 7 candidates stripped; promote to reference product]',
    `judgment_text` STRING COMMENT 'Full text of the judgment as entered by the court, or reference to the document location.',
    `judgment_type` STRING COMMENT 'Classification of the judgment based on how it was obtained or entered.. Valid values are `default|consent|summary|trial_verdict|appellate|declaratory`',
    `lien_filed_flag` BOOLEAN COMMENT 'Indicates whether a judgment lien has been filed to secure the judgment amount.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this judgment record was last modified.',
    `notes` STRING COMMENT 'Internal notes and commentary regarding the judgment, enforcement strategy, or related matters.',
    `pacer_case_number` STRING COMMENT 'PACER system case number for federal court electronic records access.',
    `partial_judgment_flag` BOOLEAN COMMENT 'Indicates whether this is a partial judgment resolving some but not all claims.',
    `prevailing_party` STRING COMMENT 'Designation of which party prevailed in the judgment. [ENUM-REF-CANDIDATE: plaintiff|defendant|petitioner|respondent|claimant|cross_claimant|third_party — 7 candidates stripped; promote to reference product]',
    `prevailing_party_name` STRING COMMENT 'Name of the party or parties that prevailed in the judgment.',
    `satisfaction_date` DATE COMMENT 'Date on which the judgment was satisfied or paid in full.',
    `settlement_judgment_flag` BOOLEAN COMMENT 'Indicates whether this judgment reflects a court-entered settlement agreement.',
    `source_system` STRING COMMENT 'Name of the source system from which this judgment record originated.',
    `summary` STRING COMMENT 'Brief summary of the judgments holdings, orders, and relief granted.',
    CONSTRAINT pk_judgment PRIMARY KEY(`judgment_id`)
) COMMENT 'Records final judgments, decrees, and court-entered settlements in litigated matters. Stores judgment type (default, consent, summary, trial verdict, appellate), entry date, court reference, docket reference, judgment amount, currency, prevailing party, interest rate, cost award, appeal deadline, satisfaction date, and enforcement status. Distinct from court_order — judgments are final dispositions that close or substantially resolve a docket.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`appeal` (
    `appeal_id` BIGINT COMMENT 'Unique identifier for the appellate proceeding record. Primary key.',
    `indemnity_claim_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_claim. Business justification: Appeals of indemnity judgments affect reserve calculations, insurer obligations, and claim lifecycle; essential for claims management and regulatory compliance tracking.',
    `judgment_id` BIGINT COMMENT 'Foreign key linking to matter.judgment. Business justification: Appeals are typically filed to challenge judgments. While appeal.lower_court_matter_id links to the matter, the specific judgment being appealed should be directly referenced. This provides clear trac',
    `timekeeper_id` BIGINT COMMENT 'Reference to the primary attorney or timekeeper responsible for managing this appeal.',
    `matter_id` BIGINT COMMENT 'Reference to the originating matter in the lower court from which this appeal was initiated.',
    `precedent_id` BIGINT COMMENT 'Foreign key linking to knowledge.precedent. Business justification: Appellate decisions are primary sources of binding precedent in legal practice. Linking appeal outcomes to precedent records is fundamental to legal knowledge capture, case law research, and ensuring ',
    `privacy_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_breach. Business justification: Appeals of privacy judgments extend breach incident lifecycle and regulatory exposure; essential for supervisory authority reporting and breach remediation tracking.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to client.client_profile. Business justification: Appeals are client decisions requiring strategic consultation. Direct link enables appellate strategy tracking, client communication about appeal status, cost-benefit analysis of further appeals, and ',
    `register_id` BIGINT COMMENT 'Foreign key linking to risk.risk_register. Business justification: Appeals create significant risk exposure (cost escalation, adverse precedent, client dissatisfaction). Risk teams track appeal outcomes for practice management and client expectation management.',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: Appeals of breach-related judgments extend compliance risk exposure and require tracking for reserve adjustments and regulatory reporting; essential for breach incident closure.',
    `research_memo_id` BIGINT COMMENT 'Foreign key linking to knowledge.research_memo. Business justification: Appeals require extensive legal research on appellate standards, preservation of error, and substantive legal issues. Linking appeal to supporting research memos captures appellate work product for re',
    `tribunal_id` BIGINT COMMENT 'Reference to the appellate court or tribunal where this appeal is being heard.',
    `appeal_status` STRING COMMENT 'Current procedural status of the appellate proceeding in its lifecycle. [ENUM-REF-CANDIDATE: notice_filed|briefing|oral_argument_scheduled|under_advisement|decided|dismissed|withdrawn — 7 candidates stripped; promote to reference product]',
    `appeal_type` STRING COMMENT 'Classification of the appeal based on the stage and nature of the lower court decision being challenged.. Valid values are `interlocutory|final_judgment|certiorari_petition|leave_to_appeal|cross_appeal|permissive_appeal`',
    `appellant_brief_due_date` DATE COMMENT 'The deadline by which the appellant must file their opening brief with the appellate court.',
    `appellant_brief_filed_date` DATE COMMENT 'The actual date on which the appellant filed their opening brief.',
    `appellant_party_name` STRING COMMENT 'The name of the party or parties initiating the appeal (the appellant).',
    `appellate_docket_number` STRING COMMENT 'The official docket or case number assigned by the appellate court to this appeal.',
    `appellee_brief_due_date` DATE COMMENT 'The deadline by which the appellee must file their response brief with the appellate court.',
    `appellee_brief_filed_date` DATE COMMENT 'The actual date on which the appellee filed their response brief.',
    `appellee_party_name` STRING COMMENT 'The name of the party or parties responding to the appeal (the appellee or respondent).',
    `bond_amount` DECIMAL(18,2) COMMENT 'The monetary amount of any supersedeas bond or appeal bond required to stay enforcement of the lower court judgment.',
    `bond_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the appeal bond amount.. Valid values are `^[A-Z]{3}$`',
    `certiorari_petition_filed_date` DATE COMMENT 'The date on which a petition for writ of certiorari was filed with a higher appellate court (e.g., Supreme Court).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this appeal record was first created in the system.',
    `decision_date` DATE COMMENT 'The date on which the appellate court issued its decision or opinion.',
    `decision_outcome` STRING COMMENT 'The disposition rendered by the appellate court regarding the lower court decision.. Valid values are `affirmed|reversed|remanded|affirmed_in_part_reversed_in_part|dismissed|vacated`',
    `ecf_filing_enabled_flag` BOOLEAN COMMENT 'Indicates whether electronic case filing is enabled and required for this appellate proceeding.',
    `further_appeal_available_flag` BOOLEAN COMMENT 'Indicates whether additional appellate remedies (such as petition for rehearing or certiorari) remain available.',
    `issues_on_appeal` STRING COMMENT 'A summary of the legal issues or questions presented to the appellate court for review.',
    `lower_court_docket_number` STRING COMMENT 'The official docket or case number assigned by the lower court to the original proceeding.',
    `mandate_issued_date` DATE COMMENT 'The date on which the appellate court issued its mandate to the lower court, finalizing the appeal.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this appeal record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or internal commentary regarding the appellate proceeding.',
    `notice_of_appeal_filed_date` DATE COMMENT 'The date on which the notice of appeal was filed with the lower court, initiating the appellate process.',
    `opinion_citation` STRING COMMENT 'The official legal citation for the appellate court opinion, if published.',
    `opinion_type` STRING COMMENT 'Classification of the appellate court opinion based on its precedential value and publication status.. Valid values are `published|unpublished|per_curiam|memorandum|summary_order`',
    `oral_argument_location` STRING COMMENT 'The physical or virtual location where oral argument will be conducted.',
    `oral_argument_requested_flag` BOOLEAN COMMENT 'Indicates whether any party has requested oral argument before the appellate panel.',
    `oral_argument_scheduled_date` DATE COMMENT 'The date on which oral argument is scheduled to be heard by the appellate court.',
    `pacer_case_number` STRING COMMENT 'The case number assigned in the PACER system for federal court electronic access and docket retrieval.',
    `panel_composition` STRING COMMENT 'The names or identifiers of the judges assigned to the appellate panel hearing this appeal.',
    `petition_for_rehearing_filed_date` DATE COMMENT 'The date on which a party filed a petition for rehearing or rehearing en banc with the appellate court.',
    `record_on_appeal_filed_date` DATE COMMENT 'The date on which the official record from the lower court proceeding was transmitted to the appellate court.',
    `reply_brief_due_date` DATE COMMENT 'The deadline by which the appellant may file an optional reply brief addressing arguments raised in the appellee brief.',
    `reply_brief_filed_date` DATE COMMENT 'The actual date on which the appellant filed their reply brief, if applicable.',
    `standard_of_review` STRING COMMENT 'The legal standard applied by the appellate court when reviewing the lower court decision.. Valid values are `de_novo|abuse_of_discretion|clearly_erroneous|substantial_evidence|plain_error`',
    `stay_pending_appeal_granted_flag` BOOLEAN COMMENT 'Indicates whether the appellate court or lower court granted a stay of the lower court judgment pending appeal.',
    CONSTRAINT pk_appeal PRIMARY KEY(`appeal_id`)
) COMMENT 'Tracks appellate proceedings initiated from a lower court judgment or order. Records appeal type (interlocutory, final judgment, certiorari petition), appellate court reference, lower court docket reference, notice of appeal filing date, appellant and appellee parties, briefing schedule deadlines, oral argument date, appellate decision date, outcome (affirmed, reversed, remanded, dismissed), and further appeal options. Supports multi-level litigation lifecycle management.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`matter` (
    `matter_id` BIGINT COMMENT 'Unique identifier for the legal matter. Primary key. Role: MASTER_AGREEMENT (matter is a long-running engagement container linking client, timekeepers, documents, and billing).',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney responsible for reviewing and approving invoices for this matter. May differ from the responsible attorney.',
    `client_engagement_scope_id` BIGINT COMMENT 'Foreign key linking to client.engagement_scope. Business justification: Matters operate under specific engagement scopes (panel appointments, rate agreements, authorized practice areas). This link enforces billing compliance (rate caps, LEDES requirements), validates matt',
    `indemnity_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.indemnity_policy. Business justification: Matters are covered under specific professional indemnity policies based on incident date, practice area, and policy period. Claims management and regulatory compliance (SRA minimum terms compliance) ',
    `matter_attorney_profile_id` BIGINT COMMENT 'Reference to the attorney (timekeeper) who has primary day-to-day responsibility for managing the matter and client relationship. Also known as the matter owner or lead attorney.',
    `matter_supervising_partner_attorney_profile_id` BIGINT COMMENT 'Reference to the partner who supervises the matter, reviews work product, and has ultimate accountability for quality and client satisfaction.',
    `originating_attorney_attorney_profile_id` BIGINT COMMENT 'Reference to the attorney who originated the client relationship or brought in the matter. Used for origination credit and compensation calculations.',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to service.practice_area. Business justification: Matters are categorized by practice area for resource allocation, billing rate determination, conflict checking scope, and management reporting. The practice_group attribute is a denormalized text fie',
    `profile_id` BIGINT COMMENT 'Reference to the client organization or individual for whom this matter is being handled. Links to the client master record.',
    `billing_frequency` STRING COMMENT 'The agreed schedule for invoicing the client. Determines when Work in Progress (WIP) is converted to invoices.. Valid values are `monthly|quarterly|milestone|upon_completion|as_incurred`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget for the matter in the firms base currency. Used for budget tracking, variance analysis, and client communications. Confidential financial information.',
    `close_date` DATE COMMENT 'Date the matter was officially closed. Nullable for active matters. Once closed, no further time or disbursements may be posted without reopening.',
    `confidentiality_level` STRING COMMENT 'Classification of the matters confidentiality requirements. Ethical wall matters require strict information barriers to prevent conflicts of interest.. Valid values are `standard|high|restricted|ethical_wall`',
    `conflict_clearance_date` DATE COMMENT 'Date the matter received conflict clearance approval. Required for regulatory compliance and audit trails.',
    `conflict_cleared_flag` BOOLEAN COMMENT 'Indicates whether the matter has passed conflict checking and been approved for engagement. Must be true before work can commence.',
    `court_case_number` STRING COMMENT 'Official case number assigned by the court or tribunal for litigation matters. Used for Electronic Case Filing (ECF) and Public Access to Court Electronic Records (PACER) integration.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the matter record was first created in the practice management system. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the matters billing currency (e.g., USD, GBP, EUR). All financial amounts are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `engagement_letter_sent_date` DATE COMMENT 'Date the formal engagement letter (LOE) was sent to the client. Required for professional indemnity insurance and regulatory compliance.',
    `engagement_letter_signed_date` DATE COMMENT 'Date the client signed and returned the engagement letter, formalizing the attorney-client relationship and scope of work.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Total estimated billable hours required to complete the matter. Used for resource planning and Legal Project Management (LPM) tracking.',
    `fee_arrangement_type` STRING COMMENT 'The billing model agreed with the client. Hourly is traditional time-based billing; AFA includes fixed fee, contingency, capped fee, and other non-hourly arrangements. [ENUM-REF-CANDIDATE: hourly|fixed_fee|contingency|blended_rate|capped_fee|success_fee|retainer|afa_other — 8 candidates stripped; promote to reference product]',
    `governing_law` STRING COMMENT 'The body of law that governs the substantive legal issues in this matter (e.g., Delaware Corporate Law, UK Employment Law). May differ from jurisdiction.',
    `jurisdiction` STRING COMMENT 'Primary legal jurisdiction or court system governing this matter (e.g., New York State, England and Wales, Federal - 9th Circuit). Critical for conflict checking and regulatory compliance.',
    `ledes_matter_category` STRING COMMENT 'Standardized LEDES billing code category for the matter type (e.g., L01 for Litigation, L02 for Corporate). Enables electronic billing submission to corporate clients.. Valid values are `^L[0-9]{2}$`',
    `lpp_flag` BOOLEAN COMMENT 'Indicates whether the matter and its documents are subject to Legal Professional Privilege (attorney-client privilege). Critical for eDiscovery and document production.',
    `matter_description` STRING COMMENT 'Detailed narrative description of the matter scope, legal issues, and objectives. Confidential business information subject to Legal Professional Privilege (LPP).',
    `matter_name` STRING COMMENT 'Human-readable descriptive name or title of the legal matter (e.g., Acme Corp v. Beta Inc. - Patent Infringement, XYZ Merger and Acquisition).',
    `matter_number` STRING COMMENT 'Externally-known unique business identifier for the matter, typically formatted as client code plus sequential number (e.g., CLI001-00123). Used in all client communications, invoices, and internal references.. Valid values are `^[A-Z0-9]{6,20}$`',
    `matter_status` STRING COMMENT 'Current lifecycle status of the matter. Active matters allow time entry and billing; closed matters are complete; archived matters are retained for compliance but inactive.. Valid values are `active|suspended|closed|archived|pending_approval`',
    `matter_type` STRING COMMENT 'Primary classification of the matter by legal service category. Determines workflow, billing rules, and reporting groupings. [ENUM-REF-CANDIDATE: litigation|transactional|advisory|intellectual_property|regulatory_compliance|employment|real_estate|tax|bankruptcy|other — 10 candidates stripped; promote to reference product]',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified the matter record. Used for audit trails and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the matter record was last modified. Used for audit trails, change tracking, and data synchronization.',
    `office_code` STRING COMMENT 'Code identifying the firm office or location that opened and manages this matter (e.g., NYC, LON, SFO). Used for geographic profitability and resource planning.. Valid values are `^[A-Z]{2,5}$`',
    `open_date` DATE COMMENT 'Date the matter was officially opened and approved for work to commence. Marks the start of the matter lifecycle and billing eligibility.',
    `opposing_party_name` STRING COMMENT 'Name of the opposing party or counterparty in litigation or transactional matters. Used for conflict checking and matter identification. Confidential.',
    `outcome` STRING COMMENT 'Final outcome or result of the matter upon closure. Used for knowledge management, precedent tracking, and performance analysis. Confidential.. Valid values are `favorable|unfavorable|settled|dismissed|withdrawn|ongoing`',
    `phase` STRING COMMENT 'Current phase or stage in the matter lifecycle. Used for Legal Project Management (LPM) tracking and resource forecasting. Phases vary by matter type. [ENUM-REF-CANDIDATE: intake|discovery|motion_practice|trial|appeal|settlement|closing|post_closing — 8 candidates stripped; promote to reference product]',
    `risk_rating` STRING COMMENT 'Internal risk assessment for the matter based on complexity, client profile, regulatory exposure, and reputational factors. Used for partner oversight and resource allocation. Confidential.. Valid values are `low|medium|high|critical`',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Final settlement amount agreed in litigation or dispute resolution matters. Confidential financial information subject to non-disclosure agreements.',
    `statute_of_limitations_date` DATE COMMENT 'Critical deadline by which legal action must be filed or rights will be forfeited. Used for docket management and malpractice risk mitigation.',
    `trial_date` DATE COMMENT 'Scheduled date for trial or hearing in litigation matters. Nullable for non-litigation matters. Used for resource planning and deadline tracking.',
    `utbms_activity_code` STRING COMMENT 'Primary UTBMS task code representing the predominant activity type for this matter (e.g., A101 for Case Assessment, L110 for Legal Research). Used for client billing guidelines compliance.. Valid values are `^[A-Z][0-9]{3}$`',
    CONSTRAINT pk_matter PRIMARY KEY(`matter_id`)
) COMMENT 'Core master record for every legal matter and case managed by the firm. Represents the central hub of the matter domain, capturing the full lifecycle from inception to closure. Stores matter number, matter name, practice group, matter type (litigation, transactional, advisory, IP, regulatory), open date, close date, status (active, suspended, closed, archived), responsible attorney, supervising partner, originating attorney, billing attorney, office, jurisdiction, governing law, matter description, LPM classification, budget amount, estimated hours, risk rating, confidentiality flag, LPP flag, and LEDES matter category. Sourced primarily from Elite 3E Client/Matter Management module.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`phase` (
    `phase_id` BIGINT COMMENT 'Unique identifier for the matter phase record. Primary key.',
    `checklist_id` BIGINT COMMENT 'Foreign key linking to knowledge.checklist. Business justification: Matter phases execute using standardized checklists (due diligence, discovery, closing procedures). Tracks which checklist governs phase execution, ensures consistent methodology and quality control a',
    `last_modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user (timekeeper or administrator) who last modified this phase record. Used for audit trail and accountability.',
    `matter_id` BIGINT COMMENT 'Reference to the parent matter to which this phase belongs. Links phase to the overarching legal matter or case.',
    `responsible_timekeeper_id` BIGINT COMMENT 'Reference to the primary timekeeper (attorney, paralegal, or legal professional) responsible for managing and delivering this phase. Used for accountability and resource allocation.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user (timekeeper or administrator) who created this phase record. Used for audit trail and accountability.',
    `actual_disbursements_to_date` DECIMAL(18,2) COMMENT 'Cumulative total of actual disbursements (expenses) recorded against this phase to date. Used for budget vs. actual variance analysis.',
    `actual_end_date` DATE COMMENT 'Actual date on which this phase was completed or closed. Null if phase is still in progress. Used for schedule variance analysis and audit trail.',
    `actual_fees_to_date` DECIMAL(18,2) COMMENT 'Cumulative total of actual professional fees (time charges) recorded against this phase to date. Calculated from time entries at applicable rates. Used for budget vs. actual variance analysis.',
    `actual_hours_to_date` DECIMAL(18,2) COMMENT 'Cumulative total of actual hours recorded against this phase to date. Sourced from time entry records. Used for budget vs. actual variance analysis.',
    `actual_start_date` DATE COMMENT 'Actual date on which work on this phase commenced. Used for schedule variance analysis and audit trail.',
    `budgeted_disbursements` DECIMAL(18,2) COMMENT 'Estimated total disbursements (out-of-pocket expenses such as court fees, expert witness fees, travel, filing fees) allocated for this phase.',
    `budgeted_fees` DECIMAL(18,2) COMMENT 'Estimated total professional fees (in the matter currency) allocated for this phase. Includes attorney and paralegal time at standard or negotiated rates. Excludes disbursements.',
    `budgeted_hours` DECIMAL(18,2) COMMENT 'Estimated total hours allocated for this phase as part of the matter budget. Used for LPM planning and AFA (Alternative Fee Arrangement) scoping.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this phase record was first created in the system. Used for audit trail and data lineage.',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this phase record is currently active and available for time entry and reporting. False for archived or logically deleted phases.',
    `is_billable` BOOLEAN COMMENT 'Flag indicating whether time and expenses recorded against this phase are billable to the client. False for pro bono, internal, or non-billable phases.',
    `is_contingent` BOOLEAN COMMENT 'Flag indicating whether this phase is subject to a contingent fee arrangement (fees payable only upon successful outcome). Common in litigation and personal injury matters.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this phase record was last updated. Used for audit trail, data lineage, and incremental ETL processing.',
    `milestone_due_date` DATE COMMENT 'Target due date for the key milestone or deliverable associated with this phase. Used for critical path tracking and client SLA management.',
    `milestone_name` STRING COMMENT 'Optional name of a key milestone or deliverable associated with this phase (e.g., Summary Judgment Motion Filed, Closing Documents Executed). Used for client reporting and LPM tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this phase. Used for internal coordination, issue tracking, and knowledge capture.',
    `phase_code` STRING COMMENT 'Short alphanumeric code identifying the phase, often aligned with UTBMS (Uniform Task-Based Management System) phase codes for standardized billing and project management.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `phase_description` STRING COMMENT 'Detailed description of the scope, objectives, and deliverables for this phase. Used for LPM (Legal Project Management) planning and client communication.',
    `phase_name` STRING COMMENT 'Human-readable name of the phase (e.g., Pleadings, Discovery, Motion Practice, Trial, Appeal, Due Diligence, Negotiation, Closing). Describes the stage of work within the matter lifecycle.',
    `phase_status` STRING COMMENT 'Current lifecycle status of the phase. Indicates whether the phase has not started, is actively in progress, is on hold pending external events, has been completed, was cancelled, or deferred to a later date.. Valid values are `not_started|in_progress|on_hold|completed|cancelled|deferred`',
    `phase_type` STRING COMMENT 'Categorical classification of the phase based on the nature of legal work: litigation (court-based dispute), transactional (M&A, corporate deals), advisory (counseling), compliance (regulatory adherence), IP prosecution (patent/trademark filing), dispute resolution (ADR, arbitration), regulatory (agency proceedings), or other. [ENUM-REF-CANDIDATE: litigation|transactional|advisory|compliance|ip_prosecution|dispute_resolution|regulatory|other — 8 candidates stripped; promote to reference product]',
    `planned_end_date` DATE COMMENT 'Target date by which this phase is planned to be completed. Used for LPM scheduling, milestone tracking, and client SLA (Service Level Agreement) management.',
    `planned_start_date` DATE COMMENT 'Target date on which this phase is planned to commence. Used for LPM scheduling and milestone tracking.',
    `risk_level` STRING COMMENT 'Assessment of the risk level associated with this phase (e.g., risk of cost overrun, schedule delay, adverse outcome). Used for risk management and escalation.. Valid values are `low|medium|high|critical`',
    `sequence_order` STRING COMMENT 'Numeric ordering of the phase within the matter lifecycle. Used to display phases in chronological or logical sequence (e.g., 1=Intake, 2=Pleadings, 3=Discovery, 4=Trial).',
    CONSTRAINT pk_phase PRIMARY KEY(`phase_id`)
) COMMENT 'Defines the structured phases within a matter lifecycle used for LPM (Legal Project Management) and UTBMS-aligned task budgeting. Each phase record captures phase code, phase name (e.g., Pleadings, Discovery, Trial, Closing), sequence order, estimated hours, budgeted fees, actual hours to date, phase status, start date, target end date, and actual end date. Enables phase-level budget vs. actual tracking and milestone management across litigation and transactional matters.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`task` (
    `task_id` BIGINT COMMENT 'Unique identifier for the matter task record. Primary key.',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Tasks often require specific client contact involvement (document requests, approval signatures, information gathering). This link enables targeted task assignment notifications, tracks client deliver',
    `deadline_id` BIGINT COMMENT 'Foreign key linking to matter.deadline. Business justification: Tasks are often created to ensure deadlines are met (e.g., task to draft brief due by deadline, task to file motion by deadline). The task table has due_date but no FK to the deadline entity. This FK ',
    `matter_deadline_id` BIGINT COMMENT 'Foreign key linking to matter.matter_deadline. Business justification: Tasks may be created specifically to satisfy court-imposed deadlines tracked in matter_deadline. This FK allows linking tasks to the specific court deadlines they address, which is critical for litiga',
    `matter_id` BIGINT COMMENT 'Reference to the parent matter to which this task belongs. Links task to the overarching legal matter or case.',
    `mitigation_action_id` BIGINT COMMENT 'Foreign key linking to risk.risk_mitigation_action. Business justification: Risk mitigation actions often require specific matter tasks for implementation (e.g., policy updates, training, control testing). Links operational tasks to their originating risk mitigation requireme',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the system user who last modified the task record. Supports accountability and audit trail.',
    `phase_id` BIGINT COMMENT 'Reference to the specific phase within the matter lifecycle to which this task is assigned (e.g., discovery, trial preparation, closing).',
    `predecessor_task_id` BIGINT COMMENT 'Reference to a prior task that must be completed before this task can begin. Supports task dependency modeling and critical path analysis in LPM workflows.',
    `task_approved_by_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper who approved the completed task. Null if approval is not required or task is not yet approved.',
    `task_assigned_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney, paralegal, or legal professional) assigned primary responsibility for completing this task.',
    `task_timekeeper_id` BIGINT COMMENT 'Reference to the supervising attorney or partner who owns accountability for task completion and quality. May differ from assigned timekeeper for delegation scenarios.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the system user who created the task record. Supports accountability and audit trail.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for the task based on actual hours and timekeeper rates. Supports budget variance reporting and profitability analysis.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Total hours recorded against this task by all timekeepers. Aggregated from time entry records for budget variance analysis and billing.',
    `approval_date` DATE COMMENT 'Date the task was formally approved. Null if approval is not required or task is not yet approved.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether task completion requires formal approval or review by a supervising attorney or partner before the task can be marked complete.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether time and expenses incurred on this task are billable to the client. False for pro bono, internal administrative, or non-billable matter tasks.',
    `blocking_reason` STRING COMMENT 'Free-text explanation of why the task is on hold or deferred. Captures dependencies, client delays, or external blockers.',
    `budget_variance_cost` DECIMAL(18,2) COMMENT 'Difference between estimated cost and actual cost (actual minus estimated). Positive values indicate over-budget, negative values indicate under-budget. Supports financial performance tracking.',
    `budget_variance_hours` DECIMAL(18,2) COMMENT 'Difference between estimated hours and actual hours (actual minus estimated). Positive values indicate over-budget, negative values indicate under-budget. Supports budget performance analysis.',
    `client_visible_flag` BOOLEAN COMMENT 'Indicates whether this task is visible to the client in client portal or matter status reports. False for internal administrative or strategy tasks.',
    `completion_date` DATE COMMENT 'Actual date the task was marked complete. Null if task is not yet complete. Supports cycle time analysis and on-time delivery metrics.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the task record was first created in the system. Supports audit trail and task lifecycle tracking.',
    `deliverable_description` STRING COMMENT 'Description of the expected output or work product from this task (e.g., motion document, research memo, contract redline). Supports quality review and client communication.',
    `due_date` DATE COMMENT 'Target completion date for the task. Used for deadline tracking, SLA monitoring, and LPM milestone management.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Budgeted cost for the task based on estimated hours and applicable timekeeper rates. Used for matter budget planning and AFA cost modeling.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Planned or budgeted hours to complete the task. Used for matter budgeting, workload forecasting, and Alternative Fee Arrangement (AFA) planning.',
    `external_task_reference` STRING COMMENT 'External identifier or reference number for the task in integrated systems (e.g., project management tool, client portal, court ECF system). Supports cross-system reconciliation.',
    `is_milestone_flag` BOOLEAN COMMENT 'Indicates whether this task represents a key milestone in the matter lifecycle (e.g., complaint filed, discovery complete, trial date). Used for high-level matter status reporting and client communication.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time the task record was last updated. Supports change tracking and audit trail.',
    `notes` STRING COMMENT 'Internal notes and comments related to task execution, issues encountered, or coordination details. Supports knowledge capture and handoff continuity.',
    `priority_level` STRING COMMENT 'Business priority classification for the task. Drives workload sequencing and resource allocation decisions.. Valid values are `critical|high|medium|low`',
    `start_date` DATE COMMENT 'Date the task was initiated or moved to in-progress status. Supports task duration and throughput analysis.',
    `task_category` STRING COMMENT 'High-level classification of the task type for reporting and workload analysis. Complements UTBMS task code with firm-specific categorization. [ENUM-REF-CANDIDATE: legal_research|document_drafting|client_communication|court_filing|discovery|negotiation|administrative — 7 candidates stripped; promote to reference product]',
    `task_description` STRING COMMENT 'Detailed narrative description of the task scope, deliverables, and context. Supports LPM workflow documentation and task handoff clarity.',
    `task_name` STRING COMMENT 'Short descriptive name of the task (e.g., Draft Motion to Dismiss, Review Contract Terms, Conduct Client Interview).',
    `task_status` STRING COMMENT 'Current lifecycle status of the task. Tracks progression from assignment through completion or deferral.. Valid values are `open|in_progress|complete|deferred|cancelled|on_hold`',
    `utbms_task_code` STRING COMMENT 'Standardized UTBMS task code for structured billing and matter budgeting (e.g., L110 for Case Assessment, L310 for Discovery). Enables LEDES-compliant billing narratives and industry-standard task classification.. Valid values are `^[A-Z][0-9]{3}$`',
    CONSTRAINT pk_task PRIMARY KEY(`task_id`)
) COMMENT 'Granular task records within a matter phase, aligned to UTBMS task codes for structured billing and LPM tracking. Captures task code, task name, task description, assigned timekeeper, estimated hours, actual hours, task status (open, in-progress, complete, deferred), due date, completion date, priority level, and billable flag. Supports matter budgeting, workload distribution, and LEDES-compliant billing narratives. Sourced from Elite 3E task management and LPM workflow modules.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`matter_status_history` (
    `matter_status_history_id` BIGINT COMMENT 'Unique identifier for each matter status transition event. Primary key for the matter status history log. Inferred role: EVENT_LOG - immutable audit log of status change events.',
    `approved_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who approved the status change, if approval was required. Null if no approval was required or if approval is still pending. Links to the workforce/user management system.',
    `matter_id` BIGINT COMMENT 'Reference to the matter that experienced the status change. Links this status transition event to the parent matter record in the matter management system.',
    `tertiary_matter_id` BIGINT COMMENT 'FK to matter.matter.matter_id — Status history is an audit trail of the parent matters lifecycle transitions. Cannot exist without matter reference.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who initiated or authorized the status change. Links to the workforce/user management system to identify the responsible party. Essential for accountability and audit compliance.',
    `to_matter_id` BIGINT COMMENT 'FK to matter.matter.matter_id — Status transitions must reference the matter they belong to. This is the fundamental audit trail relationship.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this status change required supervisory or partner approval before becoming effective. True if approval was required, False if the change could be made directly. Supports governance and control framework compliance.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when the status change was approved by the approving authority. Null if no approval was required or if approval is pending. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `approved_by_user_name` STRING COMMENT 'Full name of the user who approved the status change. Provides human-readable identification for audit reports. Null if no approval was required or if approval is pending.',
    `billing_impact_flag` BOOLEAN COMMENT 'Indicates whether this status change has implications for billing operations. True if the change affects Work In Progress (WIP), billing holds, or invoicing processes. False if the change is purely administrative with no billing impact. Used to trigger billing workflow reviews.',
    `change_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for the status change. Supports categorization and trend analysis of matter lifecycle events. Common reasons include matter concluded (work completed), client request (client-initiated change), conflict identified (ethical conflict discovered), resource unavailable (staffing constraints), billing issue (payment or fee arrangement problems), regulatory requirement (compliance-driven change), administrative (internal process change). [ENUM-REF-CANDIDATE: matter_concluded|client_request|conflict_identified|resource_unavailable|billing_issue|regulatory_requirement|administrative — 7 candidates stripped; promote to reference product]',
    `change_reason_description` STRING COMMENT 'Free-text narrative providing detailed explanation of why the status change occurred. Captures context, business justification, and any relevant circumstances that led to the transition. Critical for audit trails and regulatory compliance.',
    `changed_by_role` STRING COMMENT 'The organizational role of the user who made the status change at the time of the event. Supports role-based analytics and segregation of duties compliance. Common roles include partner, associate, paralegal, legal assistant, practice manager, billing coordinator, system administrator. [ENUM-REF-CANDIDATE: partner|associate|paralegal|legal_assistant|practice_manager|billing_coordinator|system_administrator — 7 candidates stripped; promote to reference product]',
    `changed_by_user_name` STRING COMMENT 'Full name of the user who initiated or authorized the status change. Provides human-readable identification for audit reports and compliance documentation without requiring joins to user tables.',
    `compliance_review_required_flag` BOOLEAN COMMENT 'Indicates whether this status change triggers a compliance or regulatory review requirement. True if the change requires review by compliance, risk, or regulatory teams. False if no special review is required. Supports regulatory audit and risk management workflows.',
    `effective_date` DATE COMMENT 'The calendar date when the status change became effective. Provides day-level granularity for reporting and analytics where precise time is not required. Format: yyyy-MM-dd.',
    `effective_timestamp` TIMESTAMP COMMENT 'The precise date and time when the status change became effective. This is the business event timestamp representing when the matter officially transitioned to the new status. Used for lifecycle analytics, billing cutoffs, and regulatory audit trails. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `new_status` STRING COMMENT 'The status of the matter after this transition event. Captures the to-state in the status lifecycle. Represents the current state following the change event.. Valid values are `pending|active|suspended|closed|reopened|archived`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether automated notifications were sent to relevant stakeholders (client, matter team, billing) as a result of this status change. True if notifications were successfully sent, False otherwise. Supports communication audit trails.',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time when automated notifications were sent to stakeholders. Null if no notifications were sent. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `previous_status` STRING COMMENT 'The status of the matter immediately before this transition event. Captures the from-state in the status lifecycle. Common values include pending (pre-engagement), active (work in progress), suspended (temporarily paused), closed (matter concluded), reopened (reactivated after closure), archived (long-term storage).. Valid values are `pending|active|suspended|closed|reopened|archived`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this status history record was first created in the data platform. Represents when the event was captured in the lakehouse, which may differ slightly from the effective timestamp. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `source_system` STRING COMMENT 'The name or identifier of the system that originated this status change event. Typically Elite 3E, but may include other integrated practice management or workflow systems. Supports data lineage and integration troubleshooting.',
    `source_transaction_reference` STRING COMMENT 'The unique transaction or event identifier from the source system that generated this status change. Enables traceability back to the originating system record for audit and reconciliation purposes.',
    `system_notes` STRING COMMENT 'System-generated notes or metadata associated with the status change event. May include automated workflow messages, integration logs, or system-triggered change details. Distinct from user-entered change reason descriptions.',
    `wip_action_taken` STRING COMMENT 'The action taken on unbilled Work In Progress as a result of this status change. Common actions include none (no WIP action), hold (WIP placed on billing hold), release (WIP released for billing), transfer (WIP transferred to another matter), write_off (WIP written off). Critical for financial reconciliation and revenue recognition.. Valid values are `none|hold|release|transfer|write_off`',
    CONSTRAINT pk_matter_status_history PRIMARY KEY(`matter_status_history_id`)
) COMMENT 'Immutable audit log of all matter status transitions throughout the matter lifecycle. Records each status change event including prior status, new status, effective date and timestamp, reason for change, changed by user, and any associated notes. Supports compliance reporting, matter lifecycle analytics, and regulatory audit requirements. Captures transitions such as active→suspended, active→closed, closed→reopened.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`team` (
    `team_id` BIGINT COMMENT 'Unique identifier for the matter team assignment record. Primary key for the matter team association entity.',
    `clearance_id` BIGINT COMMENT 'Reference to the conflict clearance record that authorized this timekeepers assignment to the matter. Links to Intapp Conflicts clearance record.',
    `created_by_user_timekeeper_id` BIGINT COMMENT 'User ID of the person who created this matter team assignment record. Audit trail field.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter to which the timekeeper is assigned. Links to the matter record in Elite 3E or Aderant Expert.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'User ID of the person who last modified this matter team assignment record. Audit trail field.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney, paralegal, or staff member) assigned to the matter. Links to the timekeeper record in Elite 3E or Aderant Expert.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the timekeepers capacity allocated to this matter. Used for workload planning and resource management. Value between 0.00 and 100.00.',
    `assignment_end_date` DATE COMMENT 'Date when the timekeepers assignment to the matter ended. Null if the timekeeper is still actively assigned to the matter.',
    `assignment_notes` STRING COMMENT 'Free-text notes regarding the timekeepers assignment to the matter. May include special instructions, scope limitations, or coordination notes.',
    `assignment_source_reference` STRING COMMENT 'Unique identifier of this assignment record in the source system (Elite 3E or Aderant Expert). Used for data lineage and reconciliation.',
    `assignment_source_system` STRING COMMENT 'System from which the matter team assignment record originated. Values: elite_3e (Elite 3E Practice Management), aderant_expert (Aderant Expert Time and Billing), manual (manually entered), import (bulk import).. Valid values are `elite_3e|aderant_expert|manual|import`',
    `assignment_start_date` DATE COMMENT 'Date when the timekeeper was assigned to the matter team. Marks the beginning of the timekeepers involvement in the matter.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the timekeepers assignment to the matter. Values: active (currently working), inactive (assignment ended), suspended (temporarily paused), pending (assignment approved but not yet started), completed (matter closed, assignment complete).. Valid values are `active|inactive|suspended|pending|completed`',
    `billing_rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the billing rate override (e.g., USD, GBP, EUR). Aligns with the matters billing currency.. Valid values are `^[A-Z]{3}$`',
    `billing_rate_override` DECIMAL(18,2) COMMENT 'Matter-specific billing rate override for this timekeeper, expressed in the matters billing currency. Overrides the timekeepers standard rate for this matter only. Used for Alternative Fee Arrangements (AFA) or negotiated rates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this matter team assignment record was first created in the system. Audit trail field.',
    `department_code` STRING COMMENT 'Code representing the department or cost center to which the timekeepers work on this matter is allocated. Used for internal financial reporting and profitability analysis.',
    `ethical_wall_flag` BOOLEAN COMMENT 'Indicates whether this timekeeper is subject to an ethical wall (information barrier) for this matter due to conflict of interest considerations. True if ethical wall applies, False otherwise.',
    `fee_budget_cap` DECIMAL(18,2) COMMENT 'Maximum fee amount this timekeeper is authorized to bill to the matter, expressed in the matters billing currency. Used for Alternative Fee Arrangement (AFA) and budget governance. Null if no cap applies.',
    `hours_budget_cap` DECIMAL(18,2) COMMENT 'Maximum number of hours this timekeeper is authorized to bill to the matter. Used for budget control and Alternative Fee Arrangement (AFA) compliance. Null if no cap applies.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the timekeeper is currently actively assigned to the matter. True if active, False if assignment has ended or is suspended.',
    `is_billing_timekeeper` BOOLEAN COMMENT 'Indicates whether this timekeeper is authorized to approve billing and invoices for the matter. True if billing authority, False otherwise.',
    `is_originating_timekeeper` BOOLEAN COMMENT 'Indicates whether this timekeeper originated the client relationship and matter. True if originating attorney, False otherwise. Used for credit allocation and Revenue Per Equity Partner (RPE) calculations.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this timekeeper is the primary client contact for the matter. True if primary contact, False otherwise. Typically the Responsible Attorney.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this matter team assignment record was last modified. Audit trail field.',
    `office_code` STRING COMMENT 'Code representing the office location from which the timekeeper is working on this matter. Used for geographic revenue allocation and cost center reporting.',
    `practice_group_code` STRING COMMENT 'Code representing the practice group under which this timekeeper is assigned to the matter (e.g., LIT for Litigation, CORP for Corporate, IP for Intellectual Property). May differ from the timekeepers primary practice group.',
    `role_code` STRING COMMENT 'Code representing the timekeepers role on the matter. Values: RESP_ATT (Responsible Attorney), SUPV_PRTNR (Supervising Partner), ASSOC (Associate), PARA (Paralegal), BILL_ATT (Billing Attorney), ORIG_ATT (Originating Attorney - client relationship owner), CO_COUNSEL (Co-Counsel), CONSULT (Consultant), EXPERT (Expert Witness), ADMIN (Administrative Support). [ENUM-REF-CANDIDATE: RESP_ATT|SUPV_PRTNR|ASSOC|PARA|BILL_ATT|ORIG_ATT|CO_COUNSEL|CONSULT|EXPERT|ADMIN — 10 candidates stripped; promote to reference product]',
    `role_description` STRING COMMENT 'Full text description of the timekeepers role and responsibilities on the matter. Provides additional context beyond the role code.',
    CONSTRAINT pk_team PRIMARY KEY(`team_id`)
) COMMENT 'Association entity capturing the assignment of timekeepers and staff to a matter, representing the matter team roster. Records timekeeper role on the matter (responsible attorney, supervising partner, associate, paralegal, billing attorney, originating attorney, co-counsel), assignment start date, assignment end date, billing rate override, hours cap, and active flag. Enables matter-level staffing management, rate governance, and workload reporting. Sourced from Elite 3E and Aderant Expert timekeeper-matter assignment modules.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`budget` (
    `budget_id` BIGINT COMMENT 'Unique identifier for the matter budget record. Primary key.',
    `billing_fee_arrangement_id` BIGINT COMMENT 'Foreign key linking to billing.fee_arrangement. Business justification: Budget vs. billing arrangement variance reporting is a core financial management process in legal operations. Firms compare matter budget performance (internal cost planning) against fee arrangement c',
    `budget_approved_by_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (partner or authorized approver) who approved the budget.',
    `budget_timekeeper_id` BIGINT COMMENT 'Reference to the individual timekeeper for whom a specific rate is defined. Null for role-based rates; populated for individual rate agreements.',
    `matter_id` BIGINT COMMENT 'Reference to the parent matter for which this budget and rate schedule applies.',
    `modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified this budget record.',
    `phase_id` BIGINT COMMENT 'Foreign key linking to matter.phase. Business justification: Budgets are often allocated at the phase level for legal project management. The budget table has phase_name and phase_code as STRING attributes but no FK to the phase entity. Adding this FK allows pr',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Matter budgets implement specific pricing models (hourly, fixed-fee, contingency, blended rate, retainer). Budget approval workflows validate budget structure against pricing model parameters. The afa',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who created this budget record.',
    `amount` DECIMAL(18,2) COMMENT 'Total approved budget amount for the matter or phase, expressed in the budget currency.',
    `approved_date` DATE COMMENT 'Date on which the client or engagement partner formally approved this budget version.',
    `budget_number` STRING COMMENT 'Business identifier for the matter budget, typically used in engagement letters and client communications.',
    `budget_source` STRING COMMENT 'Origin of the budget: engagement letter, LOE (Letter of Engagement), RFP (Request for Proposal) response, court order (fee cap), client guideline (outside counsel guideline), or internal estimate.. Valid values are `engagement_letter|loe|rfp_response|court_order|client_guideline|internal_estimate`',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget: draft (under preparation), approved (client-accepted), revised (amended post-approval), closed (matter concluded), suspended (on hold), or exceeded (over budget threshold).. Valid values are `draft|approved|revised|closed|suspended|exceeded`',
    `budget_type` STRING COMMENT 'Classification of the budget scope: total fees (all professional fees), phase fees (by litigation or transaction phase), disbursements (out-of-pocket costs), total matter (fees plus disbursements), task-based (UTBMS task codes), or milestone-based (deliverable-driven).. Valid values are `total_fees|phase_fees|disbursements|total_matter|task_based|milestone_based`',
    `client_agreed_flag` BOOLEAN COMMENT 'Indicates whether the client has formally agreed to this budget in writing (engagement letter, LOE, or budget approval email).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the system.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `effective_from_date` DATE COMMENT 'Date from which this budget version becomes effective for WIP (Work in Progress) valuation and billing.',
    `effective_to_date` DATE COMMENT 'Date on which this budget version expires or is superseded by a new version. Null for open-ended budgets.',
    `hourly_rate_amount` DECIMAL(18,2) COMMENT 'Hourly billing rate for the timekeeper or role, expressed in the rate currency. Null for non-hourly AFA arrangements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last modified.',
    `notes` STRING COMMENT 'Free-text notes capturing budget assumptions, client instructions, special terms, or variance explanations.',
    `rate_approval_status` STRING COMMENT 'Approval status of the rate: draft (under negotiation), approved (finalized), pending_client_approval (awaiting client sign-off), rejected (client declined), or superseded (replaced by newer rate).. Valid values are `draft|approved|pending_client_approval|rejected|superseded`',
    `rate_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the hourly rate amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `rate_effective_date` DATE COMMENT 'Date from which this rate becomes effective for time entry valuation and billing.',
    `rate_expiry_date` DATE COMMENT 'Date on which this rate expires or is superseded. Null for open-ended rate agreements.',
    `rate_schedule_name` STRING COMMENT 'Name of the rate schedule or rate card associated with this budget (e.g., Standard 2024, Client ABC Preferred Rates, AFA Blended Rate).',
    `rate_source` STRING COMMENT 'Origin of the rate: engagement letter (LOE-specified rate), rate_schedule (firm rate card), court_order (court-imposed fee cap or rate), client_guideline (outside counsel guideline rate), or firm_standard (default firm rate).. Valid values are `engagement_letter|rate_schedule|court_order|client_guideline|firm_standard`',
    `rate_type` STRING COMMENT 'Classification of the billing rate: standard (firm standard rate), agreed (client-negotiated rate), afa_blended (single blended rate for AFA), pro_bono (zero rate for public interest work), discounted (reduced rate), or premium (elevated rate for specialized work).. Valid values are `standard|agreed|afa_blended|pro_bono|discounted|premium`',
    `rate_version` STRING COMMENT 'Version number of the rate to track rate changes and amendments over the matter lifecycle.',
    `timekeeper_role` STRING COMMENT 'Role or level of the timekeeper for rate governance (e.g., Equity Partner, Non-Equity Partner, Senior Associate, Associate, Paralegal, Legal Assistant). Used for role-based rate schedules.',
    `variance_threshold_percentage` DECIMAL(18,2) COMMENT 'Percentage threshold above which budget variance triggers client notification or approval requirement (e.g., 10.00 means notify at 10% over budget).',
    `version` STRING COMMENT 'Version number of the budget to track revisions and amendments over the matter lifecycle.',
    CONSTRAINT pk_budget PRIMARY KEY(`budget_id`)
) COMMENT 'Formal matter budget, fee arrangement, and rate governance record serving as the single source of truth for all financial planning, approved fee budgets, cost budgets, and matter-level billing rate agreements. Supports AFA (Alternative Fee Arrangement) and hourly billing models. Stores budget type (total fees, phase fees, disbursements, total matter), budget amount, currency, approved date, approved by, budget version, budget status (draft, approved, revised, closed), AFA type (fixed fee, capped fee, blended rate, contingency, success fee), variance threshold percentage. Includes comprehensive rate schedule management: timekeeper role, individual timekeeper reference, rate type (standard, agreed, AFA blended, pro bono), hourly rate amount, rate currency, effective date, expiry date, rate approval status, client-agreed flag, rate source (engagement letter, rate schedule, court order), and rate version history. Enables WIP monitoring, budget vs. actual reporting, rate card management, client budget compliance, LEDES-compliant billing, rate benchmarking analytics, and accurate WIP valuation. This product is the single home for all matter-level rate governance — there is no separate rate entity. Sourced from Elite 3E and Aderant Expert rate and budget management modules.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`event` (
    `event_id` BIGINT COMMENT 'Unique identifier for the matter event record. Primary key.',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Court hearings, depositions, and client meetings involve specific client contacts. This link tracks attendance requirements, sends targeted notifications, manages calendar invitations, and documents c',
    `last_modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the user who last modified this event record.',
    `legal_document_id` BIGINT COMMENT 'Reference to a document in the DMS that is associated with this event (e.g., motion to be filed, brief to be submitted, contract to be executed).',
    `matter_id` BIGINT COMMENT 'Reference to the parent matter to which this event belongs.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Court events and deadlines are frequently mandated by specific regulatory obligations (statute of limitations deadlines, mandatory filing dates, regulatory hearing requirements). Legal practice manage',
    `responsible_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney or legal professional) who is responsible for managing and completing this event or deadline.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the user who created this event record.',
    `tribunal_id` BIGINT COMMENT 'Reference to the court or tribunal where the event is scheduled, if applicable.',
    `attendees` STRING COMMENT 'List or description of attendees expected or required for the event, including internal timekeepers, clients, opposing counsel, and witnesses.',
    `calendar_sync_status` STRING COMMENT 'Status of synchronization with external calendar systems (Outlook, Google Calendar): synced, pending, failed, or not applicable.. Valid values are `synced|pending|failed|not_applicable`',
    `client_attendance_required` BOOLEAN COMMENT 'Indicates whether the client is required or expected to attend this event.',
    `client_notification_required` BOOLEAN COMMENT 'Indicates whether the client must be notified of this event or deadline in advance.',
    `completion_date` DATE COMMENT 'Actual date on which the event was completed or the deadline was met. Null if still pending or missed.',
    `completion_status` STRING COMMENT 'Current lifecycle status of the event: pending, completed, missed, cancelled, rescheduled, or in progress.. Valid values are `pending|completed|missed|cancelled|rescheduled|in_progress`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this event record was first created in the system.',
    `deadline_criticality` STRING COMMENT 'Risk classification of the deadline: critical (malpractice risk if missed), high, medium, or low. Used for escalation and reminder prioritization.. Valid values are `critical|high|medium|low`',
    `docket_number` STRING COMMENT 'Court-assigned case docket number or filing reference associated with this event.',
    `ecf_filing_required` BOOLEAN COMMENT 'Indicates whether this event requires an electronic filing through the courts ECF system.',
    `end_time` TIMESTAMP COMMENT 'The scheduled end date and time for the event, used for calendar blocking and duration calculation.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this event has been escalated to management or senior partners due to criticality, risk, or missed preliminary milestones.',
    `event_category` STRING COMMENT 'High-level practice area category for the event: litigation, transactional, regulatory, compliance, advisory, or administrative.. Valid values are `litigation|transactional|regulatory|compliance|advisory|administrative`',
    `event_date` DATE COMMENT 'The calendar date on which the event is scheduled or the deadline falls.',
    `event_description` STRING COMMENT 'Detailed description of the event, including purpose, context, and any special instructions or notes.',
    `event_number` STRING COMMENT 'Business identifier for the event, often used for docket tracking and calendar reference.',
    `event_time` TIMESTAMP COMMENT 'The precise date and time at which the event is scheduled to occur, including time zone information.',
    `event_type` STRING COMMENT 'Primary classification of the event: hearing, deadline, meeting, milestone, limitation period, closing, regulatory filing, deposition, arbitration, mediation, trial, conference, filing, notice, discovery, or motion. [ENUM-REF-CANDIDATE: hearing|deadline|meeting|milestone|limitation_period|closing|regulatory_filing|deposition|arbitration|mediation|trial|conference|filing|notice|discovery|motion — 16 candidates stripped; promote to reference product]',
    `governing_rule_reference` STRING COMMENT 'Citation to the court rule, statute, regulation, or contractual provision that establishes or governs this deadline or event.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this event record is currently active and should appear in calendars and deadline reports. Inactive events are archived or cancelled.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction in which the event or deadline applies (federal, state, county, or international jurisdiction).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this event record was last updated.',
    `location` STRING COMMENT 'Physical or virtual location where the event will take place (courtroom, conference room, video conference link, arbitration venue).',
    `opposing_counsel` STRING COMMENT 'Name and firm of opposing counsel or counterparty legal representation involved in the event.',
    `outcome_notes` STRING COMMENT 'Free-text notes capturing the outcome, result, or key takeaways from the event after completion.',
    `presiding_judge` STRING COMMENT 'Name of the judge, arbitrator, mediator, or other presiding official for the event.',
    `recurrence_pattern` STRING COMMENT 'Description of any recurring schedule for the event (e.g., weekly status meetings, quarterly compliance filings).',
    `reminder_lead_time_days` STRING COMMENT 'Number of days before the event date that reminders should be triggered to responsible timekeepers and matter team members.',
    `statute_of_limitations_flag` BOOLEAN COMMENT 'Indicates whether this event represents a statute of limitations deadline, which carries critical malpractice risk if missed.',
    `subtype` STRING COMMENT 'Deadline-specific classification indicating the source or nature of the deadline: court-ordered, statutory, contractual, regulatory, internal, or client-requested.. Valid values are `court_ordered|statutory|contractual|regulatory|internal|client_requested`',
    `title` STRING COMMENT 'Descriptive title or name of the event for calendar and docket display.',
    CONSTRAINT pk_event PRIMARY KEY(`event_id`)
) COMMENT 'Unified calendar, docket, deadline, and milestone record serving as the single source of truth for ALL time-sensitive events and deadlines associated with a matter. Encompasses court hearings, filing deadlines, statute of limitations dates, court-ordered deadlines, regulatory filing deadlines, contractual notice periods, client meetings, deposition dates, arbitration sessions, transaction closing dates, and internal review milestones. Captures event type (hearing, deadline, meeting, milestone, limitation period, closing, regulatory filing), event subtype for deadline-specific classification (court-ordered, statutory, contractual, regulatory, internal), deadline criticality level (critical/malpractice-risk, high, medium, low), event title, event date and time, location, presiding judge or arbitrator, attendees, court or tribunal reference, docket number, governing rule or statute reference, jurisdiction, responsible timekeeper, escalation flag, reminder lead time, completion status, completion date, and outcome notes. Integrates with court domain docket data and supports litigation calendar management, deadline compliance, malpractice prevention, ECF deadline tracking, transactional closing timeline management, and regulatory filing deadline monitoring. This product subsumes all deadline and limitation period tracking — there is no separate deadline entity.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`matter_disbursement` (
    `matter_disbursement_id` BIGINT COMMENT 'Unique identifier for the matter disbursement record. Primary key.',
    `invoice_id` BIGINT COMMENT 'Identifier of the client invoice to which this disbursement has been posted, if applicable. Null if the disbursement has not yet been invoiced.',
    `matter_id` BIGINT COMMENT 'Identifier of the legal matter to which this disbursement is charged.',
    `profile_id` BIGINT COMMENT 'Identifier of the client on whose behalf this disbursement was incurred.',
    `tertiary_matter_id` BIGINT COMMENT 'FK to matter.matter.matter_id — Disbursements are costs incurred on a specific matter. Required for cost recovery and client billing.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the timekeeper who incurred or recorded the disbursement.',
    `to_matter_id` BIGINT COMMENT 'FK to matter.matter.matter_id — Disbursements are incurred on behalf of a specific matter. Essential for WIP tracking and prebilling workflows.',
    `amount` DECIMAL(18,2) COMMENT 'Gross monetary amount of the disbursement expense before tax or adjustments.',
    `approval_status` STRING COMMENT 'Current approval status of the disbursement in the workflow. Indicates whether the expense has been approved for billing or reimbursement.. Valid values are `pending|approved|rejected|under_review`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the disbursement for billing or reimbursement.',
    `approved_date` DATE COMMENT 'Date on which the disbursement was approved for billing or reimbursement.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the disbursement is billable to the client. True if the expense can be charged to the client; False if it is non-billable or absorbed by the firm.',
    `cost_center_code` STRING COMMENT 'Code identifying the cost center or department responsible for the disbursement expense.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disbursement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the disbursement amount is denominated.. Valid values are `^[A-Z]{3}$`',
    `disbursement_number` STRING COMMENT 'Business identifier or reference number for the disbursement entry, often system-generated or manually assigned for tracking purposes.',
    `disbursement_type` STRING COMMENT 'Category of the disbursement expense. Common types include court filing fees, expert witness fees, travel, courier, process server, transcript costs, eDiscovery processing, search fees, registration fees, photocopying, telephone, and postage. [ENUM-REF-CANDIDATE: court_filing_fee|expert_witness_fee|travel|courier|process_server|transcript|ediscovery_processing|search_fee|registration_fee|photocopying|telephone|postage|other — 13 candidates stripped; promote to reference product]',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this disbursement expense is posted for financial accounting purposes.',
    `incurred_date` DATE COMMENT 'Date on which the disbursement expense was incurred or the service was rendered. This is the principal business event timestamp for the disbursement.',
    `invoice_date` DATE COMMENT 'Date on which the disbursement was included in a client invoice.',
    `matter_disbursement_description` STRING COMMENT 'Detailed narrative description of the disbursement expense, explaining the nature and business purpose of the cost incurred.',
    `modified_by` STRING COMMENT 'Username or identifier of the individual who last modified the disbursement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the disbursement record was last modified.',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding the disbursement, used for internal tracking, clarification, or audit purposes.',
    `office_code` STRING COMMENT 'Code identifying the firm office or location where the disbursement was incurred.',
    `paid_date` DATE COMMENT 'Date on which the disbursement expense was paid to the vendor or service provider.',
    `payment_received_date` DATE COMMENT 'Date on which payment for this disbursement was received from the client.',
    `practice_group_code` STRING COMMENT 'Code identifying the practice group or legal specialty area to which the disbursement is attributed.',
    `reimbursable_flag` BOOLEAN COMMENT 'Indicates whether the disbursement is eligible for reimbursement from the client. True if the expense is reimbursable; False otherwise.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Amount of tax (e.g., VAT, GST, sales tax) applied to the disbursement expense.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total monetary amount of the disbursement including tax and any other adjustments. Represents the net cost to be recovered or written off.',
    `utbms_expense_code` STRING COMMENT 'Standardized expense code from the UTBMS framework used for categorizing legal disbursements for client billing and reporting.',
    `vendor_invoice_reference` STRING COMMENT 'Reference number or identifier from the vendor invoice associated with this disbursement, used for reconciliation and audit purposes.',
    `vendor_name` STRING COMMENT 'Name of the third-party vendor or service provider from whom the disbursement expense was incurred.',
    `wip_status` STRING COMMENT 'Current status of the disbursement in the work-in-progress and billing lifecycle. Tracks progression from WIP through prebilling, billing, collection, or write-off.. Valid values are `wip|prebilled|billed|collected|written_off`',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the disbursement that has been written off and will not be recovered from the client.',
    `write_off_flag` BOOLEAN COMMENT 'Indicates whether the disbursement has been written off and will not be billed or recovered from the client. True if written off; False otherwise.',
    `write_off_reason` STRING COMMENT 'Explanation or justification for why the disbursement was written off, such as client relationship management, billing guideline compliance, or firm policy.',
    `created_by` STRING COMMENT 'Username or identifier of the individual who created the disbursement record.',
    CONSTRAINT pk_matter_disbursement PRIMARY KEY(`matter_disbursement_id`)
) COMMENT 'Records of out-of-pocket costs and disbursements incurred on behalf of a client matter, distinct from fee-based time entries. Captures disbursement type (court filing fees, expert witness fees, travel, courier, process server, transcript costs, eDiscovery processing, search fees, registration fees), vendor name, invoice reference, amount, currency, tax amount, billable flag, write-off flag, reimbursable flag, approval status, incurred date, paid date, and UTBMS expense code. Feeds into WIP and prebilling workflows in Elite 3E and Aderant Expert. Supports cost recovery tracking and client reimbursement management.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`counsel` (
    `counsel_id` BIGINT COMMENT 'Unique identifier for the matter counsel record. Primary key for the matter counsel registry.',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Outside counsel firms are often clients in other matters (common in legal industry). This link enables conflict checking (firm as opposing counsel vs. firm as client), relationship intelligence, and c',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter or case to which this counsel is associated.',
    `matter_party_id` BIGINT COMMENT 'Foreign key linking to matter.matter_party. Business justification: Counsel represents specific parties in a matter. The counsel table has party_represented as a STRING but no FK to the matter_party entity. This FK establishes the formal relationship between counsel a',
    `bar_jurisdiction` STRING COMMENT 'The jurisdiction (state, province, or country) in which the counsel holds their bar admission. May include multiple jurisdictions separated by semicolons for counsel admitted in multiple bars.',
    `bar_number` STRING COMMENT 'The unique bar registration or license number issued by the jurisdiction in which the counsel is admitted to practice. Used for verification of good standing and disciplinary history.',
    `conflict_check_reference` STRING COMMENT 'Reference identifier linking this counsel record to the conflict check clearance record in the conflict management system. Supports ethical wall enforcement and adverse party screening.',
    `counsel_name` STRING COMMENT 'Full legal name of the individual attorney or counsel representing the party. Used for service of process, correspondence, and conflict checking.',
    `counsel_role` STRING COMMENT 'The role of the counsel in relation to the matter. Defines whether the counsel represents an opposing party, co-counsel, local counsel, amicus curiae, intervenor, or guardian ad litem.. Valid values are `opposing|co-counsel|local counsel|amicus|intervenor|guardian ad litem`',
    `counsel_status` STRING COMMENT 'Current status of the counsels representation in this matter. Active indicates ongoing representation; withdrawn indicates voluntary withdrawal; substituted indicates replacement by another counsel; suspended or disbarred indicates disciplinary action.. Valid values are `active|withdrawn|substituted|suspended|disbarred`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this matter counsel record was first created in the system. Supports audit trail and data lineage tracking.',
    `ecf_registration_number` STRING COMMENT 'The counsels registration number in the courts Electronic Case Filing (ECF) or Case Management/Electronic Case Files (CM/ECF) system. Used for electronic service and filing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this matter counsel record. Supports change tracking and audit compliance.',
    `lead_counsel_flag` BOOLEAN COMMENT 'Indicates whether this counsel is the lead or primary counsel for their party. True if lead counsel, false otherwise.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or context regarding this counsels involvement in the matter. May include communication preferences, accessibility requirements, or procedural notes.',
    `office_address_line1` STRING COMMENT 'First line of the counsels office street address, including building number and street name.',
    `office_address_line2` STRING COMMENT 'Second line of the counsels office address, typically suite, floor, or unit number. Nullable.',
    `office_city` STRING COMMENT 'City or municipality of the counsels office address.',
    `office_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the counsels office address.. Valid values are `^[A-Z]{3}$`',
    `office_postal_code` STRING COMMENT 'Postal or ZIP code of the counsels office address.',
    `office_state_province` STRING COMMENT 'State, province, or region of the counsels office address.',
    `primary_email` STRING COMMENT 'Primary email address for correspondence and service of electronic documents to the counsel.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Primary telephone contact number for the counsel, including country and area codes.',
    `pro_hac_vice_flag` BOOLEAN COMMENT 'Indicates whether the counsel has been admitted to practice in this jurisdiction on a temporary basis for this specific matter under pro hac vice rules. True if admitted pro hac vice, false if admitted in the jurisdiction.',
    `representation_end_date` DATE COMMENT 'The date on which the counsels representation concluded, either through withdrawal, substitution, or matter closure. Nullable for ongoing representation.',
    `representation_start_date` DATE COMMENT 'The date on which the counsel began representing their party in this matter. Used for conflict checking and timeline analysis.',
    `service_preference` STRING COMMENT 'Preferred method for service of legal documents and correspondence to this counsel. Supports Electronic Case Filing (ECF) and traditional service methods.. Valid values are `electronic|mail|courier|fax`',
    `withdrawal_date` DATE COMMENT 'Date on which the counsel formally withdrew from representation, if applicable. Nullable for counsel who have not withdrawn.',
    `withdrawal_reason` STRING COMMENT 'Brief description or code indicating the reason for withdrawal, such as client request, conflict of interest, non-payment, or completion of limited scope representation. Nullable.',
    CONSTRAINT pk_counsel PRIMARY KEY(`counsel_id`)
) COMMENT 'Registry of opposing counsel, co-counsel, local counsel, and third-party legal representatives associated with a matter. Captures counsel role (opposing, co-counsel, local counsel, amicus, intervenor), counsel name, law firm name, bar number, jurisdiction, contact details, representation start date, representation end date, and conflict check reference. Supports conflict-of-interest screening, service of process management, and litigation party tracking. Distinct from the firms own timekeeper assignments captured in matter_team.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`matter_party` (
    `matter_party_id` BIGINT COMMENT 'Unique identifier for the matter party record. Primary key for the matter party entity.',
    `individual_id` BIGINT COMMENT 'Foreign key linking to client.individual. Business justification: Individual parties in matters may be existing individual clients. Critical for conflict checking, KYC compliance (reusing existing verification), and relationship tracking. Prevents duplicate client r',
    `organisation_id` BIGINT COMMENT 'Foreign key linking to client.organisation. Business justification: Matter parties are frequently existing client organisations. This link enables conflict checking (identifying when a party in litigation is also a client), consolidated client relationship views, and ',
    `intake_party_id` BIGINT COMMENT 'Foreign key linking to intake.intake_party. Business justification: Tracks lineage from intake-identified party to matter-operational party record. Essential for conflict monitoring continuity, KYC audit trails, and regulatory compliance—ensures matter party inherits ',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter to which this party is associated. Links the party to the specific case or transaction.',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to risk.sanctions_screening. Business justification: Matter parties (clients, counterparties, opposing parties) undergo mandatory AML/sanctions screening per regulatory requirements. Links party records to their screening results for KYC compliance, con',
    `tertiary_matter_id` BIGINT COMMENT 'FK to matter.matter.matter_id — Parties are associated with a specific matter. Required for conflict checking and litigation/transaction party management.',
    `to_matter_id` BIGINT COMMENT 'FK to matter.matter.matter_id — Parties are associated with a specific matter. Essential for conflict checking, litigation management, and corporate transaction party tracking.',
    `address_line_1` STRING COMMENT 'First line of the partys primary address. Used for service of process and official correspondence.',
    `address_line_2` STRING COMMENT 'Second line of the partys primary address. Optional field for suite, apartment, or building information.',
    `adverse_party_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this party is adverse to the primary client. Critical for conflict checking and ethical wall management.',
    `beneficial_owner_flag` BOOLEAN COMMENT 'Indicates whether this party is identified as a beneficial owner in the matter. Critical for corporate transaction advisory and regulatory compliance.',
    `city` STRING COMMENT 'City component of the partys primary address.',
    `conflict_check_cleared_flag` BOOLEAN COMMENT 'Indicates whether conflict checking has been completed and cleared for this party. Critical for ethical compliance and new business intake.',
    `conflict_check_date` DATE COMMENT 'Date when conflict checking was performed for this party. Used to track compliance with ethical screening requirements.',
    `contact_email` STRING COMMENT 'Primary email address for communicating with the party or their representative. Used for service of documents and correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary telephone number for the party or their representative. Used for urgent communications and matter coordination.',
    `country_code` STRING COMMENT 'Three-letter ISO country code representing the partys primary country of operation or residence.. Valid values are `^[A-Z]{3}$`',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created the matter party record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the matter party record was first created in the system. Used for audit trail and data lineage tracking.',
    `entity_type` STRING COMMENT 'Legal classification of the party entity. Distinguishes between individuals, corporations, partnerships, trusts, government bodies, limited liability companies, and nonprofit organizations. [ENUM-REF-CANDIDATE: individual|corporation|partnership|trust|government|llc|nonprofit — 7 candidates stripped; promote to reference product]',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Total insurance coverage amount applicable to this party in the matter. Relevant for litigation matters involving insurance claims or coverage disputes.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the matter party record is currently active. Used for soft deletion and record lifecycle management.',
    `jurisdiction_of_incorporation` STRING COMMENT 'Legal jurisdiction where the party entity is incorporated or registered. For individuals, this represents domicile jurisdiction. Uses standard jurisdiction codes.',
    `kyc_risk_rating` STRING COMMENT 'Risk classification assigned to the party based on KYC and AML screening results. Determines level of due diligence and monitoring required.. Valid values are `low|medium|high|prohibited`',
    `kyc_screening_date` DATE COMMENT 'Date when KYC or AML screening was last performed for this party. Used to track compliance with regulatory screening requirements.',
    `kyc_screening_reference` STRING COMMENT 'Reference identifier to the KYC or AML screening record performed for this party. Links to compliance screening systems for regulatory due diligence.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified the matter party record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the matter party record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special instructions, or contextual information about the partys involvement in the matter.',
    `party_name` STRING COMMENT 'Full legal name of the party involved in the matter. May be an individual name or organization name depending on entity type.',
    `party_status` STRING COMMENT 'Current status of the party in the matter lifecycle. Tracks whether the party is actively involved, has settled, been dismissed, withdrawn, deceased, or merged with another entity.. Valid values are `active|settled|dismissed|withdrawn|deceased|merged`',
    `party_type` STRING COMMENT 'Classification of the partys role in the matter. Identifies whether the party is a plaintiff, defendant, counterparty, guarantor, regulator, witness, expert, joint venture partner, licensor, or licensee. [ENUM-REF-CANDIDATE: plaintiff|defendant|counterparty|guarantor|regulator|witness|expert|joint_venture_partner|licensor|licensee — 10 candidates stripped; promote to reference product]',
    `pep_status` STRING COMMENT 'Classification indicating whether the party is a politically exposed person. Used for enhanced due diligence in AML compliance.. Valid values are `not_pep|domestic_pep|foreign_pep|international_organization`',
    `postal_code` STRING COMMENT 'Postal or ZIP code component of the partys primary address.',
    `registration_number` STRING COMMENT 'Official registration or incorporation number assigned by the jurisdiction. Used for corporate entities to verify legal standing.',
    `representation_status` STRING COMMENT 'Indicates whether the party is represented by legal counsel, unrepresented, self-represented, or representation status is pending determination.. Valid values are `represented|unrepresented|self_represented|pending`',
    `representing_counsel_name` STRING COMMENT 'Name of the primary attorney or counsel representing this party. Null if party is unrepresented.',
    `representing_firm_name` STRING COMMENT 'Name of the law firm or legal organization representing this party in the matter. Null if party is unrepresented.',
    `role_effective_date` DATE COMMENT 'Date when the partys role in the matter became effective. Marks the beginning of the partys involvement in the legal matter.',
    `role_end_date` DATE COMMENT 'Date when the partys role in the matter ended. Null for parties still actively involved. Populated when party is dismissed, settled, or withdrawn.',
    `sanctions_check_status` STRING COMMENT 'Result of sanctions list screening for this party. Indicates whether party appears on government sanctions lists or watchlists.. Valid values are `clear|match|pending|not_performed`',
    `settlement_authority_amount` DECIMAL(18,2) COMMENT 'Maximum settlement amount authorized for this party. Used in litigation and dispute resolution to track negotiation parameters.',
    `state_province` STRING COMMENT 'State or province component of the partys primary address. Uses standard state/province codes where applicable.',
    `tax_identification_number` STRING COMMENT 'Tax identification number for the party. May be SSN, EIN, VAT number, or other jurisdiction-specific tax identifier. Critical for corporate transactions and tax reporting.',
    CONSTRAINT pk_matter_party PRIMARY KEY(`matter_party_id`)
) COMMENT 'All parties to a legal matter beyond the primary client, including adverse parties, co-parties, third parties, intervenors, guarantors, counterparties in transactions, joint venture partners, regulatory bodies, government agencies, and beneficial owners. Captures party name, party type (plaintiff, defendant, counterparty, guarantor, regulator, witness, expert, joint venture partner, licensor, licensee), entity type (individual, corporation, partnership, trust, government), jurisdiction of incorporation or domicile, representation status, party role effective date, party status (active, settled, dismissed, withdrawn), and KYC/AML screening reference. Critical for conflict checking, litigation management, corporate transaction advisory, and regulatory filing party disclosures.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`deadline` (
    `deadline_id` BIGINT COMMENT 'Primary key for deadline',
    CONSTRAINT pk_deadline PRIMARY KEY(`deadline_id`)
) COMMENT 'Formal deadline and limitation period records for a matter, including statute of limitations dates, court-ordered deadlines, regulatory filing deadlines, and contractual notice periods. Captures deadline type, deadline description, deadline date, jurisdiction, governing rule or statute reference, responsible timekeeper, reminder lead time (days), escalation flag, completion date, and completion status. Supports risk management, malpractice prevention, and docket control. Distinct from matter_event which covers calendar appointments.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`rate` (
    `rate_id` BIGINT COMMENT 'Unique identifier for the matter rate record. Primary key.',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter to which this rate applies.',
    `pricing_model_id` BIGINT COMMENT 'Foreign key linking to service.pricing_model. Business justification: Individual matter rate cards must conform to approved pricing models for billing guideline compliance and rate approval workflows. Rate validation processes check rate_type, billing increments, and ca',
    `superseded_by_rate_id` BIGINT COMMENT 'Reference to the matter_rate_id of the rate record that replaces this one, if this rate has been superseded. Null if this is the current active rate.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the individual timekeeper (attorney, paralegal, or other billing professional) to whom this rate applies. Null if rate applies to a role rather than an individual.',
    `adjustment_reason` STRING COMMENT 'Business justification or explanation for any deviation from standard rates, including discounts, premiums, or special arrangements. Used for audit trail and client communication.',
    `approval_date` DATE COMMENT 'The date on which this rate was approved by the responsible partner or client. Null if rate is not yet approved.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the rate record. Draft indicates rate is being configured; Pending Approval indicates rate awaits partner or client approval; Approved indicates rate is active and billable; Rejected indicates rate was not approved; Superseded indicates rate has been replaced by a newer rate; Expired indicates rate has passed its expiry date.. Valid values are `DRAFT|PENDING_APPROVAL|APPROVED|REJECTED|SUPERSEDED|EXPIRED`',
    `approved_by_name` STRING COMMENT 'Name of the partner, billing manager, or client representative who approved this rate.',
    `approved_by_role` STRING COMMENT 'Role or title of the individual who approved this rate (e.g., Partner, Billing Manager, General Counsel).. Valid values are `PARTNER|BILLING_MANAGER|CLIENT_CONTACT|GENERAL_COUNSEL|OTHER`',
    `billing_guideline_compliant_flag` BOOLEAN COMMENT 'Indicates whether this rate complies with the clients outside counsel billing guidelines. True if compliant; False if rate exceeds guideline caps or violates guideline terms.',
    `cap_amount` DECIMAL(18,2) COMMENT 'Maximum allowable hourly rate for this timekeeper on this matter, as specified by client billing guidelines or engagement terms. Null if no cap applies. Expressed in rate currency.',
    `client_agreed_flag` BOOLEAN COMMENT 'Indicates whether this rate has been explicitly agreed to by the client in writing (e.g., in LOE - Letter of Engagement, rate schedule, or engagement agreement). True if client has agreed; False if rate is firm-determined or pending client agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the hourly rate amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the standard rate to arrive at the agreed hourly rate amount. Null if no discount applies. Expressed as a percentage (e.g., 15.00 for 15% discount).',
    `effective_date` DATE COMMENT 'The date from which this rate becomes applicable for time entries on the matter. Rate applies to all time entries on or after this date until the expiry date.',
    `expiry_date` DATE COMMENT 'The date on which this rate ceases to be applicable. Null indicates an open-ended rate with no defined end date.',
    `hourly_rate_amount` DECIMAL(18,2) COMMENT 'The billing rate per hour for this timekeeper on this matter, expressed in the rate currency. Used for WIP (Work in Progress) valuation and invoice generation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate record was last updated. Used for audit trail and change tracking.',
    `ledes_compliant_flag` BOOLEAN COMMENT 'Indicates whether this rate record is structured to support LEDES-compliant electronic billing submission. True if compliant; False otherwise.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this rate record. Used for audit trail and accountability.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or instructions related to this rate (e.g., Rate applies only to pre-trial work, Subject to annual CPI adjustment).',
    `rate_source` STRING COMMENT 'The origin or authoritative document from which this rate was derived. Engagement Letter indicates rate from LOE (Letter of Engagement); Rate Schedule indicates rate from published firm schedule; Court Order indicates court-mandated rate; Fee Agreement indicates rate from AFA (Alternative Fee Arrangement) or other fee agreement; Firm Standard indicates default firm rate card; Client Guideline indicates rate from outside counsel guideline; RFP Response indicates rate from proposal. [ENUM-REF-CANDIDATE: ENGAGEMENT_LETTER|RATE_SCHEDULE|COURT_ORDER|FEE_AGREEMENT|FIRM_STANDARD|CLIENT_GUIDELINE|RFP_RESPONSE|OTHER — 8 candidates stripped; promote to reference product]',
    `rate_tier` STRING COMMENT 'Optional tiering classification for multi-tier rate structures (e.g., Tier 1, Tier 2, Premium, Standard). Used in complex AFA (Alternative Fee Arrangement) structures.',
    `source_reference` STRING COMMENT 'Document number, agreement ID, or other reference identifier for the source document from which this rate was derived (e.g., engagement letter number, court docket number, rate schedule version).',
    `standard_rate_amount` DECIMAL(18,2) COMMENT 'The firms standard published hourly rate for this timekeeper or role, before any matter-specific discounts or adjustments. Used for variance analysis and realization reporting. Expressed in rate currency.',
    `timekeeper_role_code` STRING COMMENT 'Role or classification of the timekeeper for rate purposes (e.g., Partner, Associate, Paralegal). Used when rate applies to a role rather than a specific individual. [ENUM-REF-CANDIDATE: PARTNER|COUNSEL|ASSOCIATE|PARALEGAL|LAW_CLERK|LEGAL_ASSISTANT|EXPERT|OTHER — 8 candidates stripped; promote to reference product]',
    `utbms_activity_code` STRING COMMENT 'Optional UTBMS activity code if this rate applies only to specific activity types. Null if rate applies to all activities.',
    `utbms_task_code` STRING COMMENT 'Optional UTBMS task code if this rate applies only to specific task categories (e.g., L100 for Case Assessment, L200 for Discovery). Null if rate applies to all tasks.',
    `version_number` STRING COMMENT 'Sequential version number for rate changes on the same matter and timekeeper combination. Increments with each rate adjustment. Used for rate history tracking.',
    CONSTRAINT pk_rate PRIMARY KEY(`rate_id`)
) COMMENT 'Timekeeper billing rates applicable to a specific matter, capturing matter-level rate agreements that may differ from standard rate schedules. Stores timekeeper role or individual timekeeper reference, rate type (standard, agreed, AFA blended, pro bono), hourly rate amount, currency, effective date, expiry date, rate approval status, client-agreed flag, and rate source (engagement letter, rate schedule, court order). Enables accurate WIP valuation and LEDES-compliant billing. Sourced from Aderant Expert rate management module.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`matter_risk` (
    `matter_risk_id` BIGINT COMMENT 'Unique identifier for the matter risk record. Primary key for the matter risk register.',
    `compliance_control_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_control. Business justification: Matter-specific risks (malpractice exposure, conflict risk, regulatory breach risk, client relationship risk) are mitigated by specific compliance controls (conflict check procedures, engagement lette',
    `timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper who identified and logged the risk.',
    `owner_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (partner, associate, or counsel) who is accountable for monitoring and managing this risk. Typically the lead partner on the matter.',
    `practice_note_id` BIGINT COMMENT 'Foreign key linking to knowledge.practice_note. Business justification: Risk mitigation strategies reference practice notes for guidance on handling specific risk categories. Links risk to authoritative guidance document, supports consistent risk management approach and k',
    `matter_id` BIGINT COMMENT 'Reference to the legal matter to which this risk is associated. Links the risk to the parent matter record in the matter management system.',
    `tertiary_matter_id` BIGINT COMMENT 'FK to matter.matter.matter_id — Risk records are specific to an individual matter. Required for matter-level risk dashboards and PI insurance reporting.',
    `to_matter_id` BIGINT COMMENT 'FK to matter.matter.matter_id — Risk register entries are assessed at the matter level. Essential for PI exposure tracking and risk management reporting.',
    `appetite_threshold` STRING COMMENT 'The maximum acceptable residual risk score as defined by the firms risk appetite framework. Risks exceeding this threshold require escalation or additional mitigation.',
    `closure_date` DATE COMMENT 'The date on which the risk was formally closed, either because it was fully mitigated, accepted, or no longer applicable.',
    `closure_reason` STRING COMMENT 'Explanation of why the risk was closed, including whether it was mitigated, accepted, transferred, or became irrelevant due to matter circumstances.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this risk record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial exposure amount.. Valid values are `^[A-Z]{3}$`',
    `escalated_to` STRING COMMENT 'Name or role of the individual or committee to whom the risk was escalated (e.g., Managing Partner, Risk Committee, Professional Indemnity Insurer).',
    `escalation_date` DATE COMMENT 'The date on which the risk was escalated to a higher authority or governance body.',
    `escalation_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the risk requires escalation to senior management, the risk committee, or the professional indemnity insurer.',
    `financial_exposure_amount` DECIMAL(18,2) COMMENT 'Estimated financial exposure or potential loss amount associated with the risk, expressed in the matters currency. Used for professional indemnity reserve calculations.',
    `identified_date` DATE COMMENT 'The date on which the risk was first identified and recorded in the matter risk register.',
    `impact_rating` STRING COMMENT 'Qualitative assessment of the severity of consequences if the risk materializes. Ratings typically follow a five-point scale: insignificant, minor, moderate, major, catastrophic.. Valid values are `insignificant|minor|moderate|major|catastrophic`',
    `inherent_risk_score` STRING COMMENT 'Calculated risk score before any mitigation actions are applied, typically derived from likelihood and impact ratings. Used to assess the raw exposure level.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this risk record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this risk record was most recently updated.',
    `last_review_date` DATE COMMENT 'The date on which the risk was most recently reviewed and reassessed by the risk owner or matter team.',
    `likelihood_rating` STRING COMMENT 'Qualitative assessment of the probability that the risk will materialize. Ratings typically follow a five-point scale: rare, unlikely, possible, likely, almost certain.. Valid values are `rare|unlikely|possible|likely|almost_certain`',
    `mitigation_action` STRING COMMENT 'Description of the actions, controls, or strategies implemented or planned to reduce the likelihood or impact of the risk.',
    `mitigation_status` STRING COMMENT 'Current status of the mitigation action implementation. Values include not started, in progress, completed, or deferred.. Valid values are `not_started|in_progress|completed|deferred`',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formal review of this risk. Used to drive risk review meeting agendas and partner dashboards.',
    `notes` STRING COMMENT 'Free-text field for additional context, observations, or commentary related to the risk, including updates from risk review meetings.',
    `pi_claim_reference` STRING COMMENT 'Reference number assigned by the professional indemnity insurer if a formal claim or circumstance notification was made.',
    `pi_notification_date` DATE COMMENT 'The date on which the risk was formally notified to the professional indemnity insurer.',
    `pi_notification_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether this risk must be notified to the firms professional indemnity insurer under the policy terms.',
    `reference_number` STRING COMMENT 'Business-facing unique reference number for the risk record, used in risk review meetings and professional indemnity reporting.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority to which the risk must be reported, if applicable (e.g., SRA, State Bar, Law Society).',
    `regulatory_report_date` DATE COMMENT 'The date on which the risk was reported to the relevant regulatory body.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the risk triggers a mandatory reporting obligation to a regulatory body such as the Solicitors Regulation Authority (SRA), State Bar, or other governing authority.',
    `residual_risk_score` STRING COMMENT 'Calculated risk score after mitigation actions have been applied, representing the remaining exposure. Used to determine whether additional controls are required.',
    `review_frequency` STRING COMMENT 'The cadence at which this risk should be reviewed, based on its severity and volatility. Common values include weekly, fortnightly, monthly, quarterly, or ad hoc.. Valid values are `weekly|fortnightly|monthly|quarterly|ad_hoc`',
    `risk_category` STRING COMMENT 'Classification of the risk type. Categories include professional indemnity exposure, adverse litigation outcome, regulatory sanction, client credit/collection risk, data breach, Legal Professional Privilege (LPP) waiver, conflict escalation, and scope creep.. Valid values are `professional_indemnity_exposure|adverse_litigation_outcome|regulatory_sanction|client_credit_collection|data_breach|lpp_waiver`',
    `risk_description` STRING COMMENT 'Detailed narrative description of the identified risk, including context, potential triggers, and circumstances that could lead to risk realization.',
    `risk_status` STRING COMMENT 'Current lifecycle status of the risk. Values include open (active monitoring), mitigated (controls in place), accepted (within appetite), escalated (requires senior attention), or closed (no longer relevant).. Valid values are `open|mitigated|accepted|escalated|closed`',
    `subcategory` STRING COMMENT 'Detailed subcategory or specific classification within the primary risk category, providing granular risk taxonomy for reporting and analysis.',
    `title` STRING COMMENT 'Short descriptive title summarizing the nature of the risk, used in risk dashboards and executive summaries.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this risk record.',
    CONSTRAINT pk_matter_risk PRIMARY KEY(`matter_risk_id`)
) COMMENT 'Matter-level operational risk register capturing identified risks specific to the conduct and outcome of an individual matter, distinct from enterprise-level risk records owned by the risk domain. Records risk category (professional indemnity exposure, adverse litigation outcome, regulatory sanction, client credit/collection, data breach, LPP waiver, conflict escalation, scope creep), risk description, likelihood rating, impact rating, inherent risk score, residual risk score, mitigation action, risk owner (timekeeper), identified date, next review date, and risk status (open, mitigated, accepted, escalated, closed). Supports the firms professional indemnity insurance reporting, matter-level risk dashboards, and partner risk review meetings. The enterprise risk domain owns firm-wide risk aggregation and risk appetite frameworks.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`hold` (
    `hold_id` BIGINT COMMENT 'Unique identifier for the matter hold record. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or legal professional who authorized and issued the hold.',
    `client_contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Legal holds identify client contacts as custodians of relevant data. This link enables custodian acknowledgement tracking, targeted hold notifications, and custodian interview scheduling. Essential fo',
    `last_modified_by_user_timekeeper_id` BIGINT COMMENT 'System user identifier of the individual who last modified the hold record.',
    `matter_id` BIGINT COMMENT 'Reference to the parent matter for which this hold was issued.',
    `timekeeper_id` BIGINT COMMENT 'System user identifier of the individual who created the hold record.',
    `acknowledgement_deadline_date` DATE COMMENT 'Date by which all custodians are required to acknowledge the hold notice.',
    `client_notified_date` DATE COMMENT 'Date on which the client was formally notified of the hold and its implications for document retention and business operations.',
    `collection_scope_description` STRING COMMENT 'Detailed description of the collection methodology, date ranges, search terms, and custodian-specific instructions for ESI collection.',
    `court_case_number` STRING COMMENT 'Official court docket or case number if the hold is issued in connection with active litigation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hold record was first created in the system.',
    `data_categories_in_scope` STRING COMMENT 'Comma-separated or structured list of data categories subject to the hold, such as email, instant messages, documents, databases, social media, mobile device data, and cloud storage.',
    `data_sources_in_scope` STRING COMMENT 'Specific systems, repositories, or platforms from which ESI must be preserved, such as Exchange, SharePoint, Salesforce, file servers, or mobile devices.',
    `ediscovery_vendor_name` STRING COMMENT 'Name of the third-party eDiscovery vendor or ALSP (Alternative Legal Service Provider) engaged to support collection, processing, and review.',
    `ediscovery_vendor_reference` STRING COMMENT 'Vendor-assigned project or matter reference number for tracking and billing purposes.',
    `estimated_data_volume_gb` DECIMAL(18,2) COMMENT 'Estimated volume of ESI subject to the hold, measured in gigabytes, used for proportionality assessment and eDiscovery planning.',
    `estimated_document_count` BIGINT COMMENT 'Estimated number of documents or files subject to the hold, used for scoping and cost estimation.',
    `governing_rule_reference` STRING COMMENT 'Citation to the legal rule, regulation, or standard governing the preservation obligation, such as FRCP Rule 37(e), GDPR Article 17, or industry-specific regulation.',
    `hold_number` STRING COMMENT 'Business identifier for the litigation hold or preservation notice, typically assigned by the issuing attorney or legal operations team.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the hold indicating whether preservation obligations are in effect.. Valid values are `active|released|modified|expired|suspended`',
    `hold_type` STRING COMMENT 'Classification of the hold based on its legal or regulatory purpose.. Valid values are `litigation_hold|regulatory_hold|internal_investigation_hold|pre_litigation_preservation|data_subject_request_hold|compliance_hold`',
    `issuance_date` DATE COMMENT 'Date on which the litigation hold or preservation notice was formally issued to custodians.',
    `issuing_attorney_name` STRING COMMENT 'Full name of the attorney who issued the hold, captured for audit and accountability purposes.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction governing the hold, such as federal, state, or international regulatory body.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the hold record was last updated.',
    `malpractice_insurance_notified_flag` BOOLEAN COMMENT 'Indicates whether the firms malpractice insurance carrier was notified of the hold due to high spoliation risk or potential exposure.',
    `modification_history` STRING COMMENT 'Structured log or narrative of all modifications made to the hold scope, custodians, or status over its lifecycle.',
    `notes` STRING COMMENT 'Free-text field for additional context, instructions, or observations related to the hold.',
    `proportionality_assessment` STRING COMMENT 'Narrative assessment of the proportionality of the hold scope relative to the needs of the case, considering factors such as cost, burden, and relevance.',
    `relativity_workspace_name` STRING COMMENT 'Human-readable name of the Relativity workspace associated with this hold.',
    `relativity_workspace_reference` STRING COMMENT 'Unique identifier for the Relativity workspace or case database where collected ESI is hosted for review and production.',
    `release_date` DATE COMMENT 'Date on which the hold was formally released and preservation obligations were lifted. Null if hold is still active.',
    `release_reason` STRING COMMENT 'Business justification for releasing the hold, such as matter closure, settlement, or expiration of preservation period.',
    `reminder_cadence_days` STRING COMMENT 'Frequency in days at which reminder notices are sent to custodians who have not yet acknowledged the hold.',
    `scope_description` STRING COMMENT 'Detailed narrative describing the scope of ESI (Electronically Stored Information) and physical documents subject to preservation, including relevant date ranges, topics, and custodians.',
    `spoliation_risk_level` STRING COMMENT 'Assessment of the risk of spoliation or destruction of evidence if the hold is not properly enforced, used for prioritization and escalation.. Valid values are `low|medium|high|critical`',
    CONSTRAINT pk_hold PRIMARY KEY(`hold_id`)
) COMMENT 'Litigation hold, legal preservation notice, and investigation hold records issued in connection with a matter, capturing ESI (Electronically Stored Information) preservation obligations, eDiscovery scope metadata, and custodian acknowledgement tracking. Records hold type (litigation hold, regulatory hold, internal investigation hold, pre-litigation preservation), hold issuance date, hold custodians (individuals and departments), data categories and sources in scope, collection scope description, data volume estimates, issuing attorney, hold status (active, released, modified, expired), release date and reason, custodian acknowledgement status and date, reminder cadence, eDiscovery vendor reference, and Relativity workspace identifier. Supports eDiscovery readiness, proportionality assessment, ESI protocol compliance, GDPR/DPA data subject request management, and spoliation risk mitigation.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`court_filing` (
    `court_filing_id` BIGINT COMMENT 'Unique identifier for the court filing record. Primary key for the matter_court_filing product.',
    `filed_by_timekeeper_id` BIGINT COMMENT 'Reference to the timekeeper (attorney or paralegal) who prepared and submitted the filing on behalf of the client.',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to knowledge.form_template. Business justification: Court filings routinely use standardized court forms from the knowledge repository. Tracks which template was used for each filing, essential for compliance verification and quality control in litigat',
    `last_modified_by_user_timekeeper_id` BIGINT COMMENT 'Reference to the system user who last modified this court filing record. Supports audit trail and accountability.',
    `matter_id` BIGINT COMMENT 'Reference to the parent litigated matter for which this court filing was made. Links the filing to the matter management system.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Court filings are frequently mandated by specific regulatory obligations (mandatory disclosure requirements, statutory notice filings, regulatory reporting obligations, court rule compliance). Legal p',
    `filing_id` BIGINT COMMENT 'Reference to another court filing record that is directly related to this filing. Supports tracking of filing sequences such as motion and opposition, or original and amended filings.',
    `timekeeper_id` BIGINT COMMENT 'Reference to the system user who created this court filing record. Supports audit trail and accountability.',
    `acceptance_date` DATE COMMENT 'Date on which the court officially accepted the filing and entered it into the case record. Marks the completion of the filing process.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the work associated with this filing is billable to the client. Used for time and disbursement allocation in billing workflows.',
    `confidentiality_level` STRING COMMENT 'Classification of the sensitivity and access restrictions for the filing. Aligns with protective orders and confidentiality agreements in the matter.. Valid values are `public|attorneys_eyes_only|outside_counsel_only|in_house_only`',
    `court_reference` STRING COMMENT 'Reference identifier or name of the court or tribunal where the filing was submitted. May include court division or department information.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this court filing record was first created in the system. Audit trail for record creation.',
    `docket_number` STRING COMMENT 'Court-assigned case docket number under which this filing was submitted. Links the filing to the official court record.',
    `document_reference` STRING COMMENT 'Reference identifier linking this filing record to the source document stored in the Document Management System (DMS). Bridges to iManage Work or NetDocuments for document retrieval.',
    `document_title` STRING COMMENT 'Official title or caption of the filed document as it appears in the court record. Provides human-readable identification of the filing content.',
    `ecf_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the Electronic Case Filing system upon submission. Used for tracking and reconciliation with court records.',
    `filed_by_name` STRING COMMENT 'Full name of the attorney or legal professional who filed the document with the court. Captured for quick reference and reporting.',
    `filing_date` DATE COMMENT 'Date on which the document was officially filed with the court. Represents the principal business event timestamp for this filing record.',
    `filing_fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged by the court for processing this filing. Captured for disbursement tracking and client billing purposes.',
    `filing_fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the filing fee amount. Ensures accurate financial reporting across multi-jurisdiction matters.. Valid values are `^[A-Z]{3}$`',
    `filing_number` STRING COMMENT 'Unique business identifier assigned to this court filing by the law firm or court system. Used for tracking and reference purposes.',
    `filing_party_role` STRING COMMENT 'Role of the party on whose behalf this filing was made. Identifies the filers position in the litigation.. Valid values are `plaintiff|defendant|petitioner|respondent|intervenor|amicus_curiae`',
    `filing_status` STRING COMMENT 'Current lifecycle status of the court filing. Tracks the filing through submission, court review, acceptance, or rejection workflow stages.. Valid values are `submitted|accepted|rejected|pending|withdrawn`',
    `filing_timestamp` TIMESTAMP COMMENT 'Precise date and time when the document was submitted to the court system via ECF or manual filing. Captures the exact moment of submission for audit and compliance purposes.',
    `filing_type` STRING COMMENT 'Classification of the court document being filed. Indicates the nature and purpose of the filing within the litigation workflow. [ENUM-REF-CANDIDATE: complaint|answer|motion|brief|order|judgment|notice_of_appeal|stipulation|discovery_request|discovery_response|subpoena|affidavit|declaration|exhibit|memorandum|petition|writ|injunction|summons — promote to reference product]',
    `hearing_date` DATE COMMENT 'Scheduled date for any hearing or oral argument associated with this filing. Captured for calendar management and deadline tracking.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this court filing record is currently active and relevant to the matter. Supports soft-delete and historical record management.',
    `judge_name` STRING COMMENT 'Name of the presiding judge or magistrate assigned to the case at the time of filing. Captured for case tracking and correspondence purposes.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction under which the court operates. Identifies the geographic or subject-matter authority of the court.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this court filing record was last updated. Audit trail for record modification.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, instructions, or observations related to the filing. Supports knowledge management and case administration.',
    `pacer_document_number` STRING COMMENT 'Document number assigned by PACER for public access and retrieval of the filed document. Links the internal filing record to the public court record.',
    `page_count` STRING COMMENT 'Total number of pages in the filed document. Used for court fee calculation and filing compliance verification.',
    `rejection_date` DATE COMMENT 'Date on which the court rejected the filing due to procedural deficiencies or non-compliance. Triggers corrective action workflow.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the court for rejecting the filing. Informs corrective actions required for resubmission.',
    `response_due_date` DATE COMMENT 'Deadline by which opposing parties must respond to this filing. Critical for tracking procedural compliance and case progression.',
    `seal_status` STRING COMMENT 'Indicates whether the filing is publicly accessible or subject to sealing, redaction, or confidentiality orders. Governs access control and disclosure obligations.. Valid values are `public|sealed|redacted|confidential`',
    `served_by_name` STRING COMMENT 'Name of the individual or service agent who performed service of the filing on opposing parties. Required for certificate of service documentation.',
    `service_date` DATE COMMENT 'Date on which the filed document was served on opposing parties or other required recipients. Critical for compliance with service of process requirements.',
    `service_method` STRING COMMENT 'Method by which the filing was served on other parties. Documents the service mechanism for procedural compliance and proof of service.. Valid values are `personal|mail|electronic|publication|substituted`',
    `submission_method` STRING COMMENT 'Method by which the filing was submitted to the court. Distinguishes between electronic case filing systems and traditional paper-based or alternative submission channels.. Valid values are `ecf_electronic|manual_paper|courier|fax|email`',
    CONSTRAINT pk_court_filing PRIMARY KEY(`court_filing_id`)
) COMMENT 'Records of court and tribunal filings made in connection with a litigated matter, capturing ECF (Electronic Case Filing) and PACER submission metadata. Stores filing type (complaint, answer, motion, brief, order, judgment, notice of appeal), filing date, filed by, court reference, docket number, filing status (submitted, accepted, rejected, pending), rejection reason, service date, and document reference to iManage Work. Bridges the matter domain with the court domain for litigation workflow management.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`outcome` (
    `outcome_id` BIGINT COMMENT 'Unique identifier for the matter outcome record. Primary key.',
    `appeal_id` BIGINT COMMENT 'Foreign key linking to matter.appeal. Business justification: Appeal decisions are a type of matter outcome. When an appeal is resolved, the outcome should reference the appeal record. This FK allows tracking outcomes that result from appellate proceedings, dist',
    `judgment_id` BIGINT COMMENT 'Foreign key linking to matter.judgment. Business justification: The outcome product records matter resolution and disposition. When the outcome is a judgment (as opposed to settlement, dismissal, etc.), there should be a direct FK to the judgment record. This allo',
    `last_modified_by_user_timekeeper_id` BIGINT COMMENT 'Identifier of the user who last modified this outcome record.',
    `matter_id` BIGINT COMMENT 'Reference to the parent matter for which this outcome is recorded.',
    `regulatory_breach_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_breach. Business justification: Adverse matter outcomes (regulatory sanctions, disciplinary findings, court orders against the firm, malpractice judgments) often constitute or evidence regulatory breaches requiring compliance report',
    `responsible_timekeeper_id` BIGINT COMMENT 'Identifier of the timekeeper (attorney or legal professional) responsible for recording and managing this outcome.',
    `timekeeper_id` BIGINT COMMENT 'Identifier of the user who created this outcome record.',
    `appealed_outcome_id` BIGINT COMMENT 'Self-referencing FK on outcome (appealed_outcome_id)',
    `appeal_deadline_date` DATE COMMENT 'Deadline date by which an appeal must be filed. Null if no appeal is possible or deadline has passed.',
    `appeal_filed_by_party` STRING COMMENT 'Identifies which party filed the appeal: client, opposing party, third party, or not applicable.. Valid values are `client|opposing_party|third_party|not_applicable`',
    `appeal_filed_date` DATE COMMENT 'Date on which an appeal was filed. Null if no appeal has been filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether an appeal has been filed against this outcome. True if appeal filed, False otherwise.',
    `billing_impact_flag` BOOLEAN COMMENT 'Indicates whether this outcome has billing implications (e.g., contingent fee trigger, success fee, AFA milestone). True if billing impact exists, False otherwise.',
    `client_satisfaction_rating` STRING COMMENT 'Client satisfaction rating for the outcome on a scale of 1-5, where 5 is highly satisfied. Null if not collected.',
    `compliance_status` STRING COMMENT 'Status of compliance with the outcome terms: complied, partially complied, non-compliant, pending, or not applicable.. Valid values are `complied|partially_complied|non_compliant|pending|not_applicable`',
    `contingent_fee_triggered_flag` BOOLEAN COMMENT 'Indicates whether this outcome triggered a contingent fee arrangement. True if triggered, False otherwise.',
    `court_case_number` STRING COMMENT 'Official court or tribunal case number associated with the outcome. Applicable to litigation matters.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this outcome record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts (settlement, damages, transaction value).. Valid values are `^[A-Z]{3}$`',
    `damages_awarded_amount` DECIMAL(18,2) COMMENT 'Amount of damages awarded by court or tribunal. Applicable to litigation outcomes. Null if not applicable.',
    `enforcement_action_date` DATE COMMENT 'Date on which enforcement action was initiated. Null if no enforcement action taken.',
    `enforcement_action_required_flag` BOOLEAN COMMENT 'Indicates whether enforcement action is required to compel compliance with the outcome. True if enforcement needed, False otherwise.',
    `favorable_outcome_flag` BOOLEAN COMMENT 'Indicates whether the outcome was favorable to the client. True if favorable, False if unfavorable.',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction in which the outcome was rendered (e.g., state, federal district, country).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this outcome record was last modified.',
    `lessons_learned_reference` STRING COMMENT 'Reference to knowledge management system entry or document capturing lessons learned from this matter outcome.',
    `matter_closure_triggered_flag` BOOLEAN COMMENT 'Indicates whether this outcome triggered the closure of the parent matter. True if closure triggered, False otherwise.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the matter outcome.',
    `office_code` STRING COMMENT 'Code identifying the office location responsible for the matter outcome.',
    `opposing_counsel_name` STRING COMMENT 'Name of the lead counsel representing the opposing party.',
    `opposing_law_firm_name` STRING COMMENT 'Name of the law firm representing the opposing party.',
    `opposing_party_name` STRING COMMENT 'Name of the opposing party or counterparty in the matter.',
    `outcome_category` STRING COMMENT 'High-level categorization of the outcome aligned with practice area: litigation, transaction, advisory, regulatory, IP prosecution, compliance. [ENUM-REF-CANDIDATE: litigation|transaction|advisory|regulatory|ip_prosecution|compliance|other — 7 candidates stripped; promote to reference product]',
    `outcome_date` DATE COMMENT 'The date on which the outcome was achieved or recorded. For litigation: judgment date, settlement date. For transactions: closing date. For regulatory: approval/denial date.',
    `outcome_description` STRING COMMENT 'Detailed narrative description of the outcome, including key terms, conditions, and context.',
    `outcome_status` STRING COMMENT 'Current status of the outcome: preliminary, final, appealed, vacated, modified, enforced, satisfied, pending approval, draft. [ENUM-REF-CANDIDATE: preliminary|final|appealed|vacated|modified|enforced|satisfied|pending_approval|draft — 9 candidates stripped; promote to reference product]',
    `outcome_type` STRING COMMENT 'Classification of the matter outcome. For litigation: judgment, settlement, dismissal, verdict, consent order. For transactions: signing, closing, abandonment. For advisory: opinion delivered, memo issued. For regulatory: approval, denial, conditional approval. [ENUM-REF-CANDIDATE: judgment|settlement|dismissal|verdict|consent_order|signing|closing|abandonment|opinion_delivered|memo_issued|approval|denial|conditional_approval|withdrawal|arbitration_award|mediation_settlement|default_judgment|summary_judgment|mistrial|acquittal|conviction|other — 22 candidates stripped; promote to reference product]',
    `practice_group_code` STRING COMMENT 'Code identifying the practice group responsible for the matter outcome (e.g., litigation, corporate, IP).',
    `presiding_judge_name` STRING COMMENT 'Name of the judge, arbitrator, or decision-maker who presided over the matter outcome. Applicable to litigation and arbitration.',
    `prevailing_party` STRING COMMENT 'Identifies which party prevailed in the matter: client, opposing party, mutual (both parties achieved objectives), none, or not applicable.. Valid values are `client|opposing_party|mutual|none|not_applicable`',
    `reference_number` STRING COMMENT 'Business identifier for the outcome record, used for external reference and tracking.',
    `satisfaction_date` DATE COMMENT 'Date on which the outcome was fully satisfied or complied with (e.g., settlement payment received, judgment satisfied, transaction closed).',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Monetary value of settlement or resolution. For litigation: settlement payment. For transactions: transaction value. Null if not applicable.',
    `transaction_value_amount` DECIMAL(18,2) COMMENT 'Total value of the transaction for M&A, corporate transaction, or deal closure outcomes. Null if not applicable.',
    `win_loss_classification` STRING COMMENT 'Classification of the outcome for win/loss analytics: win, loss, partial win, neutral, or not applicable.. Valid values are `win|loss|partial_win|neutral|not_applicable`',
    CONSTRAINT pk_outcome PRIMARY KEY(`outcome_id`)
) COMMENT 'Records the resolution, disposition, or completion of a matter including case outcomes for litigation (judgment, settlement, dismissal, verdict, consent order), transaction completions (signing, closing, abandonment), advisory deliverables (opinion delivered, memo issued), and regulatory outcomes (approval, denial, conditional approval). Captures outcome type, outcome date, outcome description, financial terms (settlement amount, damages awarded, transaction value), prevailing party, outcome status (preliminary, final, appealed), appeal deadline, satisfaction/compliance date, and lessons learned reference. Supports matter closure workflows, financial reporting of contingent outcomes, win/loss analytics, and practice group performance measurement.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`assignment` (
    `assignment_id` BIGINT COMMENT 'Unique identifier for this matter-timekeeper assignment record. Primary key.',
    `created_by_user_timekeeper_id` BIGINT COMMENT 'User ID of the person who created this assignment record (typically matter manager, partner, or practice group administrator). Used for audit trail.',
    `last_modified_by_user_timekeeper_id` BIGINT COMMENT 'User ID of the person who most recently modified this assignment record. Used for audit trail and change management.',
    `matter_id` BIGINT COMMENT 'Foreign key linking to the legal matter to which the timekeeper is assigned',
    `timekeeper_id` BIGINT COMMENT 'Foreign key linking to the timekeeper (attorney, paralegal, or staff) assigned to the matter',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the timekeepers total capacity allocated to this matter (e.g., 25.00 means 25% of their time). Used for resource planning, workload balancing, and capacity management across the firm.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of this assignment. ACTIVE assignments allow time entry and billing. PLANNED assignments are future staffing. ON_HOLD assignments are temporarily suspended. COMPLETED assignments ended normally with matter closure. TERMINATED assignments ended early due to reassignment or other reasons.',
    `billing_rate_override` DECIMAL(18,2) COMMENT 'Matter-specific billing rate override for this timekeeper on this matter, overriding the timekeepers standard hourly rate. Used when client agreements specify discounted rates, blended rates, or role-specific rates that differ from the timekeepers standard rate. Nullable if standard rate applies.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this assignment record was created in the system. Used for audit trail and assignment history tracking.',
    `end_date` DATE COMMENT 'Date on which the timekeepers assignment to this matter in this role ended. Nullable for active assignments. Once set, time entries after this date may be flagged for review or rejected.',
    `hours_budget_cap` DECIMAL(18,2) COMMENT 'Maximum billable hours allocated to this timekeeper for this matter assignment. Used for budget management and resource allocation planning. Nullable if no specific cap is set for this assignment.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this assignment is currently active. Active assignments allow time entry and appear in matter staffing reports. Inactive assignments represent historical staffing or planned future assignments.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this timekeeper is the primary client contact for this matter. Used for client communications, matter correspondence routing, and client-facing materials. Typically true for the responsible attorney.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this assignment record. Used for change tracking and audit trail.',
    `notes` STRING COMMENT 'Free-text notes about this assignment, capturing context such as specific responsibilities, client preferences, handoff notes, or reasons for rate overrides or early termination.',
    `role_code` STRING COMMENT 'Standardized code identifying the role in which the timekeeper is assigned to this matter (e.g., RESP_ATT for responsible attorney, SUPV_PART for supervising partner, ASSOC for associate, PARALEGAL for paralegal). Determines responsibility level, approval authority, and billing treatment.',
    `role_description` STRING COMMENT 'Human-readable description of the timekeepers role on this matter (e.g., Responsible Attorney, Supervising Partner, Associate - Discovery, Paralegal - Document Review). Provides context for the assignment beyond the standardized role code.',
    `start_date` DATE COMMENT 'Date on which the timekeeper was assigned to this matter in this role. Marks the beginning of the assignment period and determines when time entries and billing for this assignment become valid.',
    CONSTRAINT pk_assignment PRIMARY KEY(`assignment_id`)
) COMMENT 'This association product represents the Assignment between matter and timekeeper. It captures the staffing relationship where timekeepers are assigned to legal matters in specific roles (responsible attorney, supervising partner, billing attorney, associate, paralegal, etc.) with role-specific billing rates, time allocation budgets, and assignment lifecycle tracking. Each record links one matter to one timekeeper with attributes that exist only in the context of this specific assignment, enabling matter staffing management, resource allocation, billing rate overrides, and workload tracking across the firm.. Existence Justification: In legal practice, matters routinely require multiple timekeepers working in different roles (responsible attorney, supervising partner, associates, paralegals, legal assistants), and timekeepers work on multiple matters concurrently. The matter product already contains four separate FK attributes pointing to timekeeper for specific roles (attorney_profile_id, supervising_partner_attorney_profile_id, originating_attorney_attorney_profile_id, billing_attorney_attorney_profile_id), which is a classic anti-pattern indicating that a proper M:N association is needed. The detection reasoning explicitly states this is already modeled via matter_team and matter_assignment junction tables, confirming the business recognizes this as an operational M:N relationship.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`matter_contact` (
    `matter_contact_id` BIGINT COMMENT 'Primary key for matter_contact',
    `client_contact_id` BIGINT COMMENT 'Unique identifier for this matter-contact assignment record. Primary key.',
    `matter_id` BIGINT COMMENT 'Foreign key linking to the legal matter this contact is assigned to',
    `assignment_end_date` DATE COMMENT 'Date this contacts assignment to this matter ended (e.g., contact left organization, role transferred). Null for active assignments.',
    `assignment_start_date` DATE COMMENT 'Date this contact was assigned to this matter in this role. Critical for tracking contact involvement timeline and conflict checking.',
    `assignment_status` STRING COMMENT 'Current status of this contact assignment to this matter. Active assignments receive communications and have authorization; inactive assignments are historical.',
    `authorization_level` STRING COMMENT 'The level of authorization this contact has for this specific matter (e.g., full authority to approve invoices and sign documents, limited to specific thresholds, view-only access).',
    `communication_frequency` STRING COMMENT 'The agreed frequency of proactive communication with this contact for this matter (e.g., weekly status updates, monthly summaries, as-needed only).',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this matter-contact assignment record was created in the system.',
    `is_billing_contact` BOOLEAN COMMENT 'Indicates whether this contact receives and approves invoices for this specific matter. A contact may be billing contact on some matters but not others.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the primary point of contact for this specific matter. A contact may be primary on some matters but not others.',
    `last_modified_by` STRING COMMENT 'User or system that last modified this matter-contact assignment record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this matter-contact assignment record was last updated.',
    `notification_preference` STRING COMMENT 'The contacts preferred notification level for this specific matter. Preferences may vary by matter based on the contacts involvement level.',
    `role_on_matter` STRING COMMENT 'The functional role this contact serves specifically for this matter (e.g., billing contact, technical SME, signatory, decision-maker, witness). A contact may have different roles across different matters.',
    `created_by` STRING COMMENT 'User or system that created this matter-contact assignment record.',
    CONSTRAINT pk_matter_contact PRIMARY KEY(`matter_contact_id`)
) COMMENT 'This association product represents the Role-based assignment between contact and matter. It captures the participation of client contacts in legal matters across multiple functional roles (billing, technical, signatory, decision-maker). Each record links one contact to one matter with attributes that exist only in the context of this relationship, including role on matter, notification preferences, authorization levels, and assignment lifecycle dates.. Existence Justification: In legal practice operations, a single client contact participates in multiple matters simultaneously (e.g., a General Counsel oversees 20+ active matters across different practice areas), and each matter involves multiple client contacts serving different functional roles (billing contact, technical SME, signatory, decision-maker, witness). Law firms actively manage these matter-contact assignments as a distinct operational concept with role-specific attributes, authorization levels, notification preferences, and lifecycle tracking (assignment start/end dates).';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`hold_custodian` (
    `hold_custodian_id` BIGINT COMMENT 'Unique identifier for this hold custodian assignment record. Primary key.',
    `hold_id` BIGINT COMMENT 'Foreign key linking to the litigation hold or preservation notice issued for this custodian assignment',
    `matter_party_id` BIGINT COMMENT 'Foreign key linking to the party serving as custodian for this hold assignment',
    `acknowledgement_date` DATE COMMENT 'Date when the custodian formally acknowledged receipt and understanding of the hold notice and their preservation obligations',
    `acknowledgement_status` STRING COMMENT 'Current status of the custodians acknowledgement of the hold notice, tracking whether they have confirmed receipt and understanding of their preservation obligations',
    `assignment_date` DATE COMMENT 'Date when this custodian was formally assigned to the hold and the hold notice was issued to them',
    `collection_completion_date` DATE COMMENT 'Date when ESI collection from this custodian was completed and data was transferred to the eDiscovery platform or review workspace',
    `collection_status` STRING COMMENT 'Current status of ESI collection from this custodian, tracking progress through the eDiscovery collection workflow',
    `custodian_acknowledgement_status` STRING COMMENT 'Aggregate status indicating whether all custodians have acknowledged receipt and understanding of the hold notice. [Moved from matter_hold: This aggregate status field attempts to summarize acknowledgement across all custodians, but the business requires tracking of individual custodian acknowledgement status, dates, and reminder history. This becomes a derived metric from the hold_custodian association.]. Valid values are `pending|partial|complete|overdue`',
    `custodian_count` STRING COMMENT 'Total number of custodians to whom the hold was issued, used for tracking acknowledgement rates and compliance. [Moved from matter_hold: This is a derived aggregate that can be calculated from COUNT(*) of hold_custodian records for a given matter_hold_id. It does not belong as a stored attribute when the underlying detail records exist.]',
    `custodian_list` STRING COMMENT 'Structured or delimited list of individuals and departments identified as custodians whose data is subject to the hold. May reference employee IDs or names. [Moved from matter_hold: This denormalized STRING field attempts to capture multiple custodians in a single field, which cannot support the required tracking of individual custodian acknowledgement status, data volumes, and collection progress. Each custodian assignment is a distinct operational record that must be managed individually.]',
    `custodian_notes` STRING COMMENT 'Free-text field for case-specific notes about this custodian assignment, such as special collection instructions, data access issues, or custodian-specific preservation challenges',
    `custodian_role` STRING COMMENT 'Classification of the custodians role in the hold, such as primary custodian (direct participant in matter), secondary custodian (supporting role), IT custodian (technical data owner), or departmental custodian (manages department-wide data sources)',
    `data_sources_in_scope_for_custodian` STRING COMMENT 'Specific systems, repositories, or data sources for which this custodian is responsible under the hold, such as email account, shared drives, mobile devices, or departmental systems',
    `estimated_data_volume_gb_for_custodian` DECIMAL(18,2) COMMENT 'Estimated volume of ESI subject to preservation for this specific custodian, measured in gigabytes, used for proportionality assessment and collection planning',
    `release_date` DATE COMMENT 'Date when this specific custodian was released from the hold obligations, which may differ from the overall hold release date if custodians are released individually',
    `reminder_sent_date` DATE COMMENT 'Most recent date when a reminder notice was sent to this custodian regarding their outstanding hold acknowledgement or ongoing preservation obligations',
    CONSTRAINT pk_hold_custodian PRIMARY KEY(`hold_custodian_id`)
) COMMENT 'This association product represents the assignment of a litigation hold or preservation notice to a specific party who serves as a custodian of potentially relevant ESI (Electronically Stored Information). Each record links one matter_hold to one matter_party (in custodian role) with attributes that track the custodians acknowledgement status, data preservation obligations, collection progress, and compliance with the hold notice. This is a core eDiscovery workflow entity that supports spoliation risk mitigation, proportionality assessment, and regulatory compliance tracking.. Existence Justification: In legal eDiscovery practice, litigation holds are issued to multiple custodians (parties who control potentially relevant ESI), and each custodian may be subject to multiple holds across different matters. Law firms actively manage hold-custodian assignments as distinct operational records, tracking each custodians acknowledgement, data sources, collection status, and compliance obligations. This is not a reference lookup—it is a managed workflow with specialized hold management systems (like Zapproved, Exterro, or Relativity Legal Hold) that track the many-to-many relationship between holds and custodians.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` (
    `jurisdiction_practice_coverage_id` BIGINT COMMENT 'Unique identifier for this jurisdiction-practice area coverage record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to the jurisdiction in which the firm may practice',
    `practice_area_id` BIGINT COMMENT 'Foreign key linking to the practice area being offered in this jurisdiction',
    `admission_required` BOOLEAN COMMENT 'Indicates whether bar admission or professional certification in this jurisdiction is required to practice in this practice area. Drives staffing and local counsel decisions.',
    `admitted_attorney_count` STRING COMMENT 'Number of firm attorneys currently admitted to practice in this jurisdiction for this practice area. Used for capacity planning and matter staffing.',
    `coverage_status` STRING COMMENT 'Current operational status of the firms ability to practice in this jurisdiction-practice area combination. Active = full coverage, Restricted = limited scope, Inactive = no longer offered, Pending = in process of establishing coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage record was first created in the system.',
    `effective_from_date` DATE COMMENT 'Date from which the firm established coverage in this jurisdiction-practice area combination. Used for matter acceptance decisions and conflict checks.',
    `effective_to_date` DATE COMMENT 'Date on which the firm ceased offering services in this jurisdiction-practice area combination. Null for current active coverage.',
    `last_review_date` DATE COMMENT 'Date when this jurisdiction-practice area coverage record was last reviewed for accuracy and currency. Used for compliance and risk management.',
    `local_counsel_required` BOOLEAN COMMENT 'Indicates whether local counsel must be engaged for matters in this jurisdiction-practice area combination due to admission rules or firm policy.',
    `practice_area_restrictions` STRING COMMENT 'Narrative description of any scope limitations, regulatory restrictions, or practice constraints specific to this jurisdiction-practice area combination (e.g., Securities litigation only - no advisory, Restricted to federal matters).',
    `preferred_local_counsel_firm` STRING COMMENT 'Name of the preferred local counsel firm for this jurisdiction-practice area combination when local counsel is required.',
    `regulatory_notes` STRING COMMENT 'Free-text notes capturing jurisdiction-specific regulatory requirements, ethical considerations, or practice nuances for this practice area (e.g., Requires annual CLE in securities law, Pro hac vice available for out-of-state counsel).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage record was last modified.',
    CONSTRAINT pk_jurisdiction_practice_coverage PRIMARY KEY(`jurisdiction_practice_coverage_id`)
) COMMENT 'This association product represents the operational coverage matrix between jurisdictions and practice areas. It captures the firms ability to practice in each jurisdiction-practice area combination, including admission requirements, local counsel needs, and practice restrictions. Each record links one jurisdiction to one practice area with regulatory and operational attributes that exist only in the context of this specific combination.. Existence Justification: Law firms operate across multiple jurisdictions and offer multiple practice areas, creating a true many-to-many operational matrix. A single jurisdiction (e.g., New York State Court) supports many practice areas (M&A, Litigation, IP, Employment), and a single practice area (e.g., Securities Litigation) is practiced across many jurisdictions (federal circuits, state courts, international tribunals). The firm actively manages this coverage matrix to determine matter acceptance, staffing requirements, and local counsel needs.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique surrogate identifier for each matter-risk category assessment record. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to the risk category being assessed against this matter',
    `matter_id` BIGINT COMMENT 'Foreign key linking to the legal matter being assessed for risk exposure',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or partner who owns the management and monitoring of this specific risk for this matter. May differ from the responsible attorney based on risk specialization.',
    `applicability_date` DATE COMMENT 'Date on which this risk category was determined to be applicable to this matter. Marks when the risk was first identified or registered for this matter.',
    `assessed_by` STRING COMMENT 'Name or identifier of the risk manager, partner, or committee member who performed or approved the most recent assessment of this matter-risk combination.',
    `assessment_status` STRING COMMENT 'Current status of the risk assessment for this matter-risk combination. Tracks the assessment workflow from initial identification through approval.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether this matter-risk combination has triggered escalation thresholds and requires partner or committee review based on score or category rules.',
    `inherent_risk_score` DECIMAL(18,2) COMMENT 'Numeric score representing the inherent (pre-control) risk exposure of this specific matter to this risk category. Matter-specific score that may differ from the categorys default inherent score based on matter characteristics.',
    `last_assessment_date` DATE COMMENT 'Date on which this matter-risk combination was most recently formally assessed or reviewed. Used to track assessment currency and trigger review cycles.',
    `mitigation_plan` STRING COMMENT 'Narrative description of the specific controls, mitigations, or action plans in place for this matter to address this risk category. Matter-specific mitigation strategy.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this matters exposure to this risk category. Calculated based on the risk categorys review frequency and matter-specific factors.',
    `notification_sent_date` DATE COMMENT 'Date on which regulatory or internal escalation notification was sent for this matter-risk assessment. Nullable if no notification required or not yet sent.',
    `regulatory_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether required regulatory notification has been sent for this matter-risk combination, applicable when the risk category requires external reporting.',
    `residual_risk_score` DECIMAL(18,2) COMMENT 'Numeric score representing the residual (post-control) risk exposure of this specific matter to this risk category after applying matter-specific controls and mitigations.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'This association product represents the Risk Assessment between matter and risk_category. It captures the firms evaluation of each risk categorys applicability and exposure level for each legal matter. Each record links one matter to one risk_category with assessment scores, dates, and review status that exist only in the context of this specific matter-risk combination.. Existence Justification: Legal firms operationally assess each matter against multiple risk categories (cybersecurity, AML, professional indemnity, reputational, data privacy, etc.) as part of their risk management and professional indemnity insurance compliance processes. Each matter-risk combination requires its own assessment with matter-specific inherent and residual risk scores, assessment dates, review cycles, mitigation plans, and risk owners. Risk managers and partners actively create, update, and review these assessments throughout the matter lifecycle.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`assertion` (
    `assertion_id` BIGINT COMMENT 'Unique identifier for this patent assertion record. Primary key.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to the court docket where this IP asset is asserted',
    `ip_asset_id` BIGINT COMMENT 'Foreign key linking to the intellectual property asset being asserted in this docket',
    `matter_party_id` BIGINT COMMENT 'Reference to the technical expert witness assigned to provide testimony on this specific patent in this case. Different patents may require different technical experts based on technology area.',
    `accused_products` STRING COMMENT 'List or description of defendants products accused of infringing this specific patent in this case. Different patents in the same case may be asserted against different product lines.',
    `assertion_date` DATE COMMENT 'Date when this IP asset was formally asserted in the docket, typically the filing date of the complaint or amended complaint adding this patent to the case.',
    `assertion_status` STRING COMMENT 'Current procedural status of this specific patent assertion within the docket. A patent may be withdrawn from a case while other patents remain active, or may be stayed pending IPR while the case proceeds on other patents.',
    `claim_construction_ruling` STRING COMMENT 'Summary of the courts claim construction (Markman) ruling specific to the claims of this patent asserted in this case. Critical for infringement and validity analysis.',
    `claim_scope` STRING COMMENT 'Specification of which claims of the IP asset are asserted in this docket. May reference specific claim numbers (e.g., claims 1, 3, 7-12) or indicate all claims. Critical for damages calculation and invalidity analysis.',
    `damages_theory` STRING COMMENT 'Damages calculation methodology applied to this specific patent in this case. May include reasonable royalty rate, lost profits allocation, or other theories. Each patent in a multi-patent case may have different damages theories.',
    `infringement_theory` STRING COMMENT 'Legal theory of infringement for this patent in this case (e.g., direct infringement, induced infringement, contributory infringement). May vary by patent within the same case depending on the accused products and claim scope.',
    `invalidity_defense_raised` STRING COMMENT 'Summary of invalidity defenses raised by the defendant specific to this patent in this case. May include anticipation, obviousness, indefiniteness, or other grounds. Varies by patent-case combination.',
    `settlement_allocation` DECIMAL(18,2) COMMENT 'Portion of settlement amount allocated to this specific patent assertion. Used when a case involving multiple patents settles and the settlement is apportioned across the asserted patents for portfolio valuation and accounting purposes.',
    CONSTRAINT pk_assertion PRIMARY KEY(`assertion_id`)
) COMMENT 'This association product represents the assertion of a specific intellectual property asset (patent, trademark, or other IP) within a specific court docket. It captures the operational reality of IP litigation where multiple patents may be asserted in a single case, and a single patent may be asserted across multiple cases. Each record links one docket to one IP asset with attributes that exist only in the context of this specific assertion, including which claims are asserted, invalidity defenses raised, damages theories, and settlement allocations.. Existence Justification: Patent litigation routinely involves multiple patents asserted in a single case (one docket references many IP assets) and individual patents asserted across multiple cases (one IP asset is referenced in many dockets). The business actively manages assertion-specific data including which claims are asserted, invalidity defenses per patent-case pair, damages allocation per patent, and settlement apportionment. This is a core operational relationship in IP litigation practice.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`lateral_conflict` (
    `lateral_conflict_id` BIGINT COMMENT 'Unique identifier for this matter-lateral conflict mapping record. Primary key.',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the conflicts counsel attorney who performed the analysis of this specific matter conflict. Establishes accountability for the conflict determination.',
    `lateral_screening_id` BIGINT COMMENT 'Foreign key linking to the lateral hire screening record',
    `matter_id` BIGINT COMMENT 'Foreign key linking to the current firm matter that has a potential conflict with the lateral candidates prior work',
    `client_consent_obtained` BOOLEAN COMMENT 'Indicates whether the required client consent for this specific matter has been obtained and documented. Must be true before hire can proceed if client_consent_required is true.',
    `client_consent_required` BOOLEAN COMMENT 'Indicates whether informed consent from the client on this current matter is required to proceed with the lateral hire. Required for material conflicts where the client must waive the conflict.',
    `conflict_analysis_date` DATE COMMENT 'Date when the conflicts counsel completed the detailed analysis of this specific matter-to-matter conflict relationship. Establishes the timeline of the screening process.',
    `conflict_severity` STRING COMMENT 'The severity assessment of this specific matter-to-matter conflict. Disqualifying conflicts prevent hire without client consent. Material conflicts require ethical walls and disclosure. Moderate conflicts require monitoring. Minor conflicts are documented but may not require mitigation. Waivable conflicts can proceed with informed client consent.',
    `disclosure_date` DATE COMMENT 'Date when this specific matter conflict was disclosed by the lateral candidate in their screening questionnaire or interview. Establishes the timeline of disclosure for regulatory compliance.',
    `ethical_wall_required` BOOLEAN COMMENT 'Indicates whether an ethical wall (information barrier) must be established between the lateral hire and this specific current matter. True when the conflict severity and relationship nature require screening the candidate from matter access.',
    `mitigation_notes` STRING COMMENT 'Detailed notes on the specific mitigation measures implemented or planned for this matter-lateral conflict pair. Documents ethical wall procedures, client communications, access restrictions, and monitoring requirements.',
    `mitigation_required` BOOLEAN COMMENT 'Indicates whether specific mitigation measures are required for this matter-lateral conflict pair. True if ethical walls, client consent, or other mitigation is necessary to proceed with the hire.',
    `prior_matter_description` STRING COMMENT 'Description of the prior matter at the candidates former firm that creates the conflict with the current matter. Captured from candidate disclosure. May contain confidential information about prior representations.',
    `prior_matter_role` STRING COMMENT 'The role the lateral candidate played on the prior matter at their former firm. Lead attorney and partner roles indicate deeper involvement and higher conflict risk. Support roles may have limited exposure.',
    `relationship_nature` STRING COMMENT 'The specific nature of the conflict relationship between the prior matter and current matter. Adverse party indicates the candidate represented a party adverse to a current client. Co-counsel indicates prior joint representation. Same client indicates the candidate represented the same entity. Related party indicates corporate affiliates or related entities. Opposing counsel indicates the candidate was on the opposing side. Confidential info overlap indicates potential access to confidential information relevant to current matter.',
    `substantive_involvement_flag` BOOLEAN COMMENT 'Indicates whether the lateral candidate had substantive involvement in the prior matter (vs. administrative or minimal involvement). Substantive involvement increases conflict severity and likelihood of confidential information access.',
    CONSTRAINT pk_lateral_conflict PRIMARY KEY(`lateral_conflict_id`)
) COMMENT 'This association product represents the conflict relationship between current firm matters and lateral hire candidate prior matters. It captures the specific conflict analysis performed during lateral attorney screening, documenting which prior matters from the candidates former firm create conflicts with which current firm matters. Each record links one current matter to one lateral screening with attributes that describe the nature, severity, and mitigation requirements of the specific conflict relationship.. Existence Justification: In legal lateral hire screening, a single lateral candidate may have worked on multiple prior matters at their former firm, each of which may conflict with multiple current firm matters. Conflicts counsel maintain a matter-to-matter conflict matrix where each prior matter is analyzed against each potentially conflicting current matter. The business actively manages this many-to-many relationship, tracking the specific nature of each conflict (adverse party, co-counsel, confidential information overlap), severity level, required mitigation measures, and client consent status for each matter pair.';

CREATE OR REPLACE TABLE `legal_ecm`.`matter`.`matter_control` (
    `matter_control_id` BIGINT COMMENT 'Primary key for matter_control',
    `matter_id` BIGINT COMMENT 'Foreign key linking to the legal matter for which this control is implemented and tested',
    `matter_risk_id` BIGINT COMMENT 'Foreign key linking to matter.risk. Business justification: The matter_control product represents implementation of risk controls within a matter. It currently links to risk.risk_control (external domain) but does NOT link to the matter.risk product, which rep',
    `attorney_profile_id` BIGINT COMMENT 'Reference to the attorney or timekeeper accountable for ensuring this control is implemented and tested for this specific matter. May differ from the enterprise control_owner in risk_control because matter teams assign control responsibilities based on matter staffing and expertise.',
    `risk_control_id` BIGINT COMMENT 'Foreign key linking to the enterprise risk control being applied to this matter',
    `deficiency_description` STRING COMMENT 'Narrative description of any control deficiency, gap, or weakness identified during matter-specific testing. Captures matter-specific control failures that may not exist at the enterprise level.',
    `effectiveness_rating` STRING COMMENT 'Assessment of how effectively this control is operating within the context of this specific matter. May differ from the enterprise-level operational_effectiveness_rating in risk_control because matter-specific circumstances (e.g., client requirements, jurisdiction, matter complexity) affect control performance.',
    `evidence_reference` STRING COMMENT 'Document Management System (DMS) reference or iManage Work document identifier for matter-specific control testing evidence. Points to the specific evidence artifacts collected for this matter-control pairing (e.g., conflict check report, privilege log, billing guideline acknowledgment).',
    `implementation_date` DATE COMMENT 'Date on which this control was fully implemented and became operational for this specific matter. Tracks when the control was activated in the matter lifecycle.',
    `implementation_status` STRING COMMENT 'Current lifecycle state of this controls implementation for this specific matter. Tracks whether the control has been applied to the matter, is pending implementation, or has been deemed not applicable based on matter-specific risk assessment.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or re-testing of this control for this matter. Supports matter-specific control review cycles that may differ from enterprise review frequencies.',
    `notes` STRING COMMENT 'Free-text field for matter-specific control implementation notes, context, or special considerations that apply to this matter-control pairing.',
    `remediation_due_date` DATE COMMENT 'Target date by which any identified control deficiency for this matter must be remediated. Null if no remediation is required.',
    `remediation_required_flag` BOOLEAN COMMENT 'Indicates whether a remediation action is required for this matter-control pairing as a result of test findings or identified deficiencies.',
    `test_date` DATE COMMENT 'Date on which this specific control was tested for this specific matter. Distinct from the enterprise-level last_test_date in risk_control, this captures matter-specific testing cycles required for engagement-level compliance reviews.',
    `test_outcome` STRING COMMENT 'Result of the most recent control test for this matter-control pairing. Indicates whether the control operated as designed within the matter context.',
    CONSTRAINT pk_matter_control PRIMARY KEY(`matter_control_id`)
) COMMENT 'This association product represents the implementation and testing of specific risk controls within the context of individual legal matters. It captures the matter-specific application of enterprise risk controls, including control effectiveness ratings, test results, evidence references, and responsible timekeepers for each matter-control pairing. Each record links one matter to one risk control with attributes that exist only in the context of this relationship, enabling matter-level control dashboards and ISO 27001/SRA compliance tracking at the engagement level.. Existence Justification: In legal practice, matters require implementation of multiple risk controls (conflict checks, data protection protocols, billing compliance, privilege management, confidentiality safeguards), and each enterprise risk control is applied across many matters with matter-specific testing, effectiveness ratings, and evidence collection. Law firms actively manage matter-level control dashboards for ISO 27001 certification and SRA compliance reviews, tracking which controls are implemented per engagement, test results, responsible timekeepers, and remediation status. This is an operational many-to-many relationship where the business manages matter-control pairings as distinct compliance records.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ADD CONSTRAINT `fk_matter_tribunal_judge_id` FOREIGN KEY (`judge_id`) REFERENCES `legal_ecm`.`matter`.`judge`(`judge_id`);
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ADD CONSTRAINT `fk_matter_jurisdiction_appellate_jurisdiction_id` FOREIGN KEY (`appellate_jurisdiction_id`) REFERENCES `legal_ecm`.`matter`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `legal_ecm`.`matter`.`judge` ADD CONSTRAINT `fk_matter_judge_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `legal_ecm`.`matter`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_judge_id` FOREIGN KEY (`judge_id`) REFERENCES `legal_ecm`.`matter`.`judge`(`judge_id`);
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`docket` ADD CONSTRAINT `fk_matter_docket_tribunal_id` FOREIGN KEY (`tribunal_id`) REFERENCES `legal_ecm`.`matter`.`tribunal`(`tribunal_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `legal_ecm`.`matter`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `legal_ecm`.`matter`.`filing`(`filing_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_judge_id` FOREIGN KEY (`judge_id`) REFERENCES `legal_ecm`.`matter`.`judge`(`judge_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`hearing` ADD CONSTRAINT `fk_matter_hearing_prior_hearing_id` FOREIGN KEY (`prior_hearing_id`) REFERENCES `legal_ecm`.`matter`.`hearing`(`hearing_id`);
ALTER TABLE `legal_ecm`.`matter`.`appearance` ADD CONSTRAINT `fk_matter_appearance_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`matter`.`appearance` ADD CONSTRAINT `fk_matter_appearance_hearing_id` FOREIGN KEY (`hearing_id`) REFERENCES `legal_ecm`.`matter`.`hearing`(`hearing_id`);
ALTER TABLE `legal_ecm`.`matter`.`appearance` ADD CONSTRAINT `fk_matter_appearance_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_amended_filing_id` FOREIGN KEY (`amended_filing_id`) REFERENCES `legal_ecm`.`matter`.`filing`(`filing_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`filing` ADD CONSTRAINT `fk_matter_filing_tribunal_id` FOREIGN KEY (`tribunal_id`) REFERENCES `legal_ecm`.`matter`.`tribunal`(`tribunal_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_hearing_id` FOREIGN KEY (`hearing_id`) REFERENCES `legal_ecm`.`matter`.`hearing`(`hearing_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_judge_id` FOREIGN KEY (`judge_id`) REFERENCES `legal_ecm`.`matter`.`judge`(`judge_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_order_id` FOREIGN KEY (`order_id`) REFERENCES `legal_ecm`.`matter`.`order`(`order_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ADD CONSTRAINT `fk_matter_matter_deadline_tribunal_id` FOREIGN KEY (`tribunal_id`) REFERENCES `legal_ecm`.`matter`.`tribunal`(`tribunal_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `legal_ecm`.`matter`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_hearing_id` FOREIGN KEY (`hearing_id`) REFERENCES `legal_ecm`.`matter`.`hearing`(`hearing_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_judge_id` FOREIGN KEY (`judge_id`) REFERENCES `legal_ecm`.`matter`.`judge`(`judge_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`order` ADD CONSTRAINT `fk_matter_order_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `legal_ecm`.`matter`.`filing`(`filing_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ADD CONSTRAINT `fk_matter_court_rule_parent_rule_court_rule_id` FOREIGN KEY (`parent_rule_court_rule_id`) REFERENCES `legal_ecm`.`matter`.`court_rule`(`court_rule_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ADD CONSTRAINT `fk_matter_court_rule_primary_superseded_by_rule_court_rule_id` FOREIGN KEY (`primary_superseded_by_rule_court_rule_id`) REFERENCES `legal_ecm`.`matter`.`court_rule`(`court_rule_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ADD CONSTRAINT `fk_matter_court_rule_tribunal_id` FOREIGN KEY (`tribunal_id`) REFERENCES `legal_ecm`.`matter`.`tribunal`(`tribunal_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `legal_ecm`.`matter`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_judge_id` FOREIGN KEY (`judge_id`) REFERENCES `legal_ecm`.`matter`.`judge`(`judge_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`judgment` ADD CONSTRAINT `fk_matter_judgment_order_id` FOREIGN KEY (`order_id`) REFERENCES `legal_ecm`.`matter`.`order`(`order_id`);
ALTER TABLE `legal_ecm`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_judgment_id` FOREIGN KEY (`judgment_id`) REFERENCES `legal_ecm`.`matter`.`judgment`(`judgment_id`);
ALTER TABLE `legal_ecm`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`appeal` ADD CONSTRAINT `fk_matter_appeal_tribunal_id` FOREIGN KEY (`tribunal_id`) REFERENCES `legal_ecm`.`matter`.`tribunal`(`tribunal_id`);
ALTER TABLE `legal_ecm`.`matter`.`phase` ADD CONSTRAINT `fk_matter_phase_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_deadline_id` FOREIGN KEY (`deadline_id`) REFERENCES `legal_ecm`.`matter`.`deadline`(`deadline_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_matter_deadline_id` FOREIGN KEY (`matter_deadline_id`) REFERENCES `legal_ecm`.`matter`.`matter_deadline`(`matter_deadline_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `legal_ecm`.`matter`.`phase`(`phase_id`);
ALTER TABLE `legal_ecm`.`matter`.`task` ADD CONSTRAINT `fk_matter_task_predecessor_task_id` FOREIGN KEY (`predecessor_task_id`) REFERENCES `legal_ecm`.`matter`.`task`(`task_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ADD CONSTRAINT `fk_matter_matter_status_history_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ADD CONSTRAINT `fk_matter_matter_status_history_tertiary_matter_id` FOREIGN KEY (`tertiary_matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ADD CONSTRAINT `fk_matter_matter_status_history_to_matter_id` FOREIGN KEY (`to_matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`team` ADD CONSTRAINT `fk_matter_team_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`budget` ADD CONSTRAINT `fk_matter_budget_phase_id` FOREIGN KEY (`phase_id`) REFERENCES `legal_ecm`.`matter`.`phase`(`phase_id`);
ALTER TABLE `legal_ecm`.`matter`.`event` ADD CONSTRAINT `fk_matter_event_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`event` ADD CONSTRAINT `fk_matter_event_tribunal_id` FOREIGN KEY (`tribunal_id`) REFERENCES `legal_ecm`.`matter`.`tribunal`(`tribunal_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ADD CONSTRAINT `fk_matter_matter_disbursement_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ADD CONSTRAINT `fk_matter_matter_disbursement_tertiary_matter_id` FOREIGN KEY (`tertiary_matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ADD CONSTRAINT `fk_matter_matter_disbursement_to_matter_id` FOREIGN KEY (`to_matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`counsel` ADD CONSTRAINT `fk_matter_counsel_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`counsel` ADD CONSTRAINT `fk_matter_counsel_matter_party_id` FOREIGN KEY (`matter_party_id`) REFERENCES `legal_ecm`.`matter`.`matter_party`(`matter_party_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_tertiary_matter_id` FOREIGN KEY (`tertiary_matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ADD CONSTRAINT `fk_matter_matter_party_to_matter_id` FOREIGN KEY (`to_matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`rate` ADD CONSTRAINT `fk_matter_rate_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`rate` ADD CONSTRAINT `fk_matter_rate_superseded_by_rate_id` FOREIGN KEY (`superseded_by_rate_id`) REFERENCES `legal_ecm`.`matter`.`rate`(`rate_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ADD CONSTRAINT `fk_matter_matter_risk_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ADD CONSTRAINT `fk_matter_matter_risk_tertiary_matter_id` FOREIGN KEY (`tertiary_matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ADD CONSTRAINT `fk_matter_matter_risk_to_matter_id` FOREIGN KEY (`to_matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`hold` ADD CONSTRAINT `fk_matter_hold_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ADD CONSTRAINT `fk_matter_court_filing_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ADD CONSTRAINT `fk_matter_court_filing_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `legal_ecm`.`matter`.`filing`(`filing_id`);
ALTER TABLE `legal_ecm`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `legal_ecm`.`matter`.`appeal`(`appeal_id`);
ALTER TABLE `legal_ecm`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_judgment_id` FOREIGN KEY (`judgment_id`) REFERENCES `legal_ecm`.`matter`.`judgment`(`judgment_id`);
ALTER TABLE `legal_ecm`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`outcome` ADD CONSTRAINT `fk_matter_outcome_appealed_outcome_id` FOREIGN KEY (`appealed_outcome_id`) REFERENCES `legal_ecm`.`matter`.`outcome`(`outcome_id`);
ALTER TABLE `legal_ecm`.`matter`.`assignment` ADD CONSTRAINT `fk_matter_assignment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ADD CONSTRAINT `fk_matter_matter_contact_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ADD CONSTRAINT `fk_matter_hold_custodian_hold_id` FOREIGN KEY (`hold_id`) REFERENCES `legal_ecm`.`matter`.`hold`(`hold_id`);
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ADD CONSTRAINT `fk_matter_hold_custodian_matter_party_id` FOREIGN KEY (`matter_party_id`) REFERENCES `legal_ecm`.`matter`.`matter_party`(`matter_party_id`);
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ADD CONSTRAINT `fk_matter_jurisdiction_practice_coverage_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `legal_ecm`.`matter`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ADD CONSTRAINT `fk_matter_risk_assessment_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`assertion` ADD CONSTRAINT `fk_matter_assertion_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `legal_ecm`.`matter`.`docket`(`docket_id`);
ALTER TABLE `legal_ecm`.`matter`.`assertion` ADD CONSTRAINT `fk_matter_assertion_matter_party_id` FOREIGN KEY (`matter_party_id`) REFERENCES `legal_ecm`.`matter`.`matter_party`(`matter_party_id`);
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ADD CONSTRAINT `fk_matter_lateral_conflict_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ADD CONSTRAINT `fk_matter_matter_control_matter_id` FOREIGN KEY (`matter_id`) REFERENCES `legal_ecm`.`matter`.`matter`(`matter_id`);
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ADD CONSTRAINT `fk_matter_matter_control_matter_risk_id` FOREIGN KEY (`matter_risk_id`) REFERENCES `legal_ecm`.`matter`.`matter_risk`(`matter_risk_id`);

-- ========= TAGS =========
ALTER SCHEMA `legal_ecm`.`matter` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `legal_ecm`.`matter` SET TAGS ('dbx_domain' = 'matter');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` SET TAGS ('dbx_subdomain' = 'litigation_proceedings');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `tribunal_id` SET TAGS ('dbx_business_glossary_term' = 'Tribunal Identifier');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `jurisdiction_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Coverage Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `judge_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `adr_program_description` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Program Description');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `adr_services_available` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Services Available');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `arbitration_rules_reference` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Rules Reference');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `business_hours` SET TAGS ('dbx_business_glossary_term' = 'Business Hours');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `clerk_of_court_name` SET TAGS ('dbx_business_glossary_term' = 'Clerk of Court Name');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `ecf_enabled` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Enabled');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `ecf_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Enrollment Status');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `ecf_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|pending|not_enrolled|not_applicable');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `ecf_system_name` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) System Name');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Established Date');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `filing_deadline_time` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Time');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `filing_fee_schedule_url` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Schedule Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `jurisdiction_geographic` SET TAGS ('dbx_business_glossary_term' = 'Geographic Jurisdiction');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Level');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `language_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `language_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Language');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `local_rules_url` SET TAGS ('dbx_business_glossary_term' = 'Local Rules Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|temporarily_closed|merged|dissolved');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `pacer_enabled` SET TAGS ('dbx_business_glossary_term' = 'Public Access to Court Electronic Records (PACER) Enabled');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `pacer_site_code` SET TAGS ('dbx_business_glossary_term' = 'Public Access to Court Electronic Records (PACER) Site Code');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `standing_orders_url` SET TAGS ('dbx_business_glossary_term' = 'Standing Orders Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `translation_required` SET TAGS ('dbx_business_glossary_term' = 'Translation Required');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `tribunal_code` SET TAGS ('dbx_business_glossary_term' = 'Tribunal Code');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `tribunal_name` SET TAGS ('dbx_business_glossary_term' = 'Tribunal Official Name');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `tribunal_type` SET TAGS ('dbx_business_glossary_term' = 'Tribunal Type');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`tribunal` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` SET TAGS ('dbx_subdomain' = 'litigation_proceedings');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Identifier');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `appellate_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Appellate Jurisdiction Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `practice_note_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Note Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `adr_available` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Available');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `arbitration_institution` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Institution');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `arbitration_seat` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Seat');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `business_hours` SET TAGS ('dbx_business_glossary_term' = 'Business Hours');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `civil_procedure_rules` SET TAGS ('dbx_business_glossary_term' = 'Civil Procedure Rules');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `court_level` SET TAGS ('dbx_business_glossary_term' = 'Court Level');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `court_level` SET TAGS ('dbx_value_regex' = 'trial|appellate|supreme|specialized');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `court_website_url` SET TAGS ('dbx_business_glossary_term' = 'Court Website Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `criminal_procedure_rules` SET TAGS ('dbx_business_glossary_term' = 'Criminal Procedure Rules');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `ecf_integration_enabled` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Integration Enabled');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `ecf_system_name` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) System Name');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `electronic_filing_deadline_time` SET TAGS ('dbx_business_glossary_term' = 'Electronic Filing Deadline Time');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `evidence_rules` SET TAGS ('dbx_business_glossary_term' = 'Evidence Rules');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `filing_fee_schedule_url` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Schedule Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Name');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `jurisdiction_status` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Status');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `jurisdiction_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|abolished');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Type');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `language_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `language_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Language');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `legal_system` SET TAGS ('dbx_business_glossary_term' = 'Legal System');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `legal_system` SET TAGS ('dbx_value_regex' = 'common_law|civil_law|mixed|sharia|customary');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `local_rules_url` SET TAGS ('dbx_business_glossary_term' = 'Local Rules Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `pacer_court_code` SET TAGS ('dbx_business_glossary_term' = 'Public Access to Court Electronic Records (PACER) Court Code');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `statute_of_limitations_default_years` SET TAGS ('dbx_business_glossary_term' = 'Statute of Limitations Default (Years)');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction` ALTER COLUMN `treaty_memberships` SET TAGS ('dbx_business_glossary_term' = 'Treaty Memberships');
ALTER TABLE `legal_ecm`.`matter`.`judge` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`matter`.`judge` SET TAGS ('dbx_subdomain' = 'litigation_proceedings');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `judge_id` SET TAGS ('dbx_business_glossary_term' = 'Judge Identifier');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Court Identifier');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `adr_certification_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Certification Type');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `adr_certification_type` SET TAGS ('dbx_value_regex' = 'Certified Mediator|Certified Arbitrator|Neutral Evaluator|Settlement Master|Not Certified');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `adr_panel_membership` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Panel Membership');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `appearance_count` SET TAGS ('dbx_business_glossary_term' = 'Appearance Count');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'Appointed|Elected|Designated|Pro Tempore|Retired Recalled');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `bar_admission_date` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Date');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `bar_admission_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Jurisdiction');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `case_management_style` SET TAGS ('dbx_business_glossary_term' = 'Case Management Style');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `case_management_style` SET TAGS ('dbx_value_regex' = 'Active|Hands-Off|Settlement-Oriented|Trial-Oriented|Strict Procedural|Flexible');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `chamber_number` SET TAGS ('dbx_business_glossary_term' = 'Chamber Number');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `chambers_email` SET TAGS ('dbx_business_glossary_term' = 'Chambers Email Address');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `chambers_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `chambers_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `chambers_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `chambers_phone` SET TAGS ('dbx_business_glossary_term' = 'Chambers Phone Number');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `chambers_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `chambers_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `court_name` SET TAGS ('dbx_business_glossary_term' = 'Court Name');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `courtroom_technology_preferences` SET TAGS ('dbx_business_glossary_term' = 'Courtroom Technology Preferences');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `ecf_participant_identifier` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Participant Identifier');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `education_background` SET TAGS ('dbx_business_glossary_term' = 'Education Background');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Judge Full Name');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `honorific` SET TAGS ('dbx_business_glossary_term' = 'Judicial Honorific');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `honorific` SET TAGS ('dbx_value_regex' = 'The Honorable|Hon.|Justice|Chief Justice|Associate Justice|Magistrate Judge');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `judge_status` SET TAGS ('dbx_business_glossary_term' = 'Judicial Status');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `judge_status` SET TAGS ('dbx_value_regex' = 'Active|Senior Status|Retired|Suspended|Deceased|Inactive');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `judicial_philosophy_notes` SET TAGS ('dbx_business_glossary_term' = 'Judicial Philosophy Notes');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `judicial_philosophy_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Judicial Jurisdiction');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `last_appearance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Appearance Date');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `law_clerk_name` SET TAGS ('dbx_business_glossary_term' = 'Law Clerk Name');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `law_clerk_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `motion_practice_preferences` SET TAGS ('dbx_business_glossary_term' = 'Motion Practice Preferences');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `notable_rulings_summary` SET TAGS ('dbx_business_glossary_term' = 'Notable Rulings Summary');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `notable_rulings_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `pacer_identifier` SET TAGS ('dbx_business_glossary_term' = 'Public Access to Court Electronic Records (PACER) Identifier');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `preferred_communication_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Method');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `preferred_communication_method` SET TAGS ('dbx_value_regex' = 'Email|Phone|Chambers Staff|Written Correspondence|ECF Messaging');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `preferred_filing_protocol` SET TAGS ('dbx_business_glossary_term' = 'Preferred Filing Protocol');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `prior_firm_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Prior Firm Affiliation');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `prior_firm_affiliation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `professional_affiliations` SET TAGS ('dbx_business_glossary_term' = 'Professional Affiliations');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `published_opinions_count` SET TAGS ('dbx_business_glossary_term' = 'Published Opinions Count');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `recusal_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Recusal History Flag');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `recusal_history_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `recusal_notes` SET TAGS ('dbx_business_glossary_term' = 'Recusal Notes');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `recusal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `relationship_strength` SET TAGS ('dbx_business_glossary_term' = 'Relationship Strength');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `relationship_strength` SET TAGS ('dbx_value_regex' = 'Strong|Moderate|Weak|None|Unknown');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `relationship_strength` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `reversal_rate_notes` SET TAGS ('dbx_business_glossary_term' = 'Reversal Rate Notes');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `reversal_rate_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `scheduling_preferences` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Preferences');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `term_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Term Expiration Date');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Judicial Title');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `trial_experience_level` SET TAGS ('dbx_business_glossary_term' = 'Trial Experience Level');
ALTER TABLE `legal_ecm`.`matter`.`judge` ALTER COLUMN `trial_experience_level` SET TAGS ('dbx_value_regex' = 'Extensive|Moderate|Limited|Primarily Appellate|Primarily ADR');
ALTER TABLE `legal_ecm`.`matter`.`docket` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`matter`.`docket` SET TAGS ('dbx_subdomain' = 'litigation_proceedings');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket ID');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `judge_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Judge ID');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Attorney ID');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `docket_lead_attorney_attorney_profile_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `tribunal_id` SET TAGS ('dbx_business_glossary_term' = 'Court ID');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `adr_proceeding_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Proceeding Type');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `adr_proceeding_type` SET TAGS ('dbx_value_regex' = 'none|mediation|arbitration|settlement_conference|early_neutral_evaluation');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_pending|appeal_granted|appeal_denied|remanded');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `appellate_docket_number` SET TAGS ('dbx_business_glossary_term' = 'Appellate Docket Number');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `arbitration_case_number` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Case Number');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `arbitration_forum` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Forum');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `case_caption` SET TAGS ('dbx_business_glossary_term' = 'Case Caption');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `case_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Date');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `case_complexity_level` SET TAGS ('dbx_business_glossary_term' = 'Case Complexity Level');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `case_complexity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|exceptional');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `case_subtype` SET TAGS ('dbx_business_glossary_term' = 'Case Subtype');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'civil|criminal|appellate|arbitration|administrative|bankruptcy');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `case_value_currency` SET TAGS ('dbx_business_glossary_term' = 'Case Value Currency');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `case_value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|confidential|highly_confidential|sealed');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `court_access_url` SET TAGS ('dbx_business_glossary_term' = 'Court Access URL');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Docket Number');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `ecf_registration_date` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Registration Date');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `ecf_registration_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Registration Status');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `ecf_registration_status` SET TAGS ('dbx_value_regex' = 'registered|pending|not_required|failed');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `estimated_case_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Case Value');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `estimated_case_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `next_scheduled_event_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Event Date');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `next_scheduled_event_type` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Event Type');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Docket Notes');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `opposing_counsel_firm` SET TAGS ('dbx_business_glossary_term' = 'Opposing Counsel Firm');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `opposing_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Opposing Counsel Name');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `pacer_case_number` SET TAGS ('dbx_business_glossary_term' = 'Public Access to Court Electronic Records (PACER) Case ID');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `trial_date` SET TAGS ('dbx_business_glossary_term' = 'Trial Date');
ALTER TABLE `legal_ecm`.`matter`.`docket` ALTER COLUMN `venue` SET TAGS ('dbx_business_glossary_term' = 'Venue');
ALTER TABLE `legal_ecm`.`matter`.`hearing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`matter`.`hearing` SET TAGS ('dbx_subdomain' = 'litigation_proceedings');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `hearing_id` SET TAGS ('dbx_business_glossary_term' = 'Hearing Identifier');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Attorney Identifier');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Court Identifier');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Filing Identifier');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `judge_id` SET TAGS ('dbx_business_glossary_term' = 'Judge Identifier');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `prior_hearing_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Hearing Identifier');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `privacy_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `research_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Research Memo Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `adr_proceeding_flag` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Proceeding Flag');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `appearance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Appearance Required Flag');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `appearance_type` SET TAGS ('dbx_business_glossary_term' = 'Appearance Type');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `appearance_type` SET TAGS ('dbx_value_regex' = 'in person|telephonic|video conference|written submission');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `arbitration_body` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Body');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `client_attendance_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Attendance Flag');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `continuance_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuance Flag');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `continuance_reason` SET TAGS ('dbx_business_glossary_term' = 'Continuance Reason');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `courtroom_number` SET TAGS ('dbx_business_glossary_term' = 'Courtroom Number');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `hearing_number` SET TAGS ('dbx_business_glossary_term' = 'Hearing Number');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `hearing_status` SET TAGS ('dbx_business_glossary_term' = 'Hearing Status');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `hearing_type` SET TAGS ('dbx_business_glossary_term' = 'Hearing Type');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hearing Notes');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `opposing_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Opposing Counsel Name');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `outcome_summary` SET TAGS ('dbx_business_glossary_term' = 'Outcome Summary');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `pacer_case_number` SET TAGS ('dbx_business_glossary_term' = 'Public Access to Court Electronic Records (PACER) Case Number');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `ruling_date` SET TAGS ('dbx_business_glossary_term' = 'Ruling Date');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `ruling_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Ruling Issued Flag');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `transcript_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Transcript Available Flag');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `transcript_ordered_date` SET TAGS ('dbx_business_glossary_term' = 'Transcript Ordered Date');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `transcript_received_date` SET TAGS ('dbx_business_glossary_term' = 'Transcript Received Date');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `virtual_meeting_url` SET TAGS ('dbx_business_glossary_term' = 'Virtual Meeting Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `virtual_meeting_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`hearing` ALTER COLUMN `virtual_platform` SET TAGS ('dbx_business_glossary_term' = 'Virtual Platform');
ALTER TABLE `legal_ecm`.`matter`.`appearance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`matter`.`appearance` SET TAGS ('dbx_subdomain' = 'litigation_proceedings');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `appearance_id` SET TAGS ('dbx_business_glossary_term' = 'Appearance Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `hearing_id` SET TAGS ('dbx_business_glossary_term' = 'Hearing Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `adr_forum` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Forum');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `appearance_date` SET TAGS ('dbx_business_glossary_term' = 'Appearance Date');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `appearance_status` SET TAGS ('dbx_business_glossary_term' = 'Appearance Status');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `appearance_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|cancelled|postponed|no_show');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `appearance_type` SET TAGS ('dbx_business_glossary_term' = 'Appearance Type');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `appearance_type` SET TAGS ('dbx_value_regex' = 'lead_counsel|co_counsel|local_counsel|observer|amicus_curiae|intervenor');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `bar_admission_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Jurisdiction');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `billed_flag` SET TAGS ('dbx_business_glossary_term' = 'Billed Flag');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `continuance_granted` SET TAGS ('dbx_business_glossary_term' = 'Continuance Granted Indicator');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `court_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Court Jurisdiction');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `court_reporter_present` SET TAGS ('dbx_business_glossary_term' = 'Court Reporter Present Indicator');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration in Hours');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `ecf_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Filing Reference');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Appearance End Time');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `judge_name` SET TAGS ('dbx_business_glossary_term' = 'Judge or Arbitrator Name');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Appearance Location');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `next_hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Next Hearing Date');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `opposing_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Opposing Counsel Name');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Appearance Outcome Notes');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `preparation_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Preparation Time in Hours');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `pro_hac_vice_status` SET TAGS ('dbx_business_glossary_term' = 'Pro Hac Vice Status');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `proceeding_type` SET TAGS ('dbx_business_glossary_term' = 'Proceeding Type');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `proceeding_type` SET TAGS ('dbx_value_regex' = 'hearing|trial|deposition|arbitration|mediation|settlement_conference');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `remote_appearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Appearance Flag');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `ruling_received` SET TAGS ('dbx_business_glossary_term' = 'Ruling Received Indicator');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Appearance Start Time');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `transcript_ordered` SET TAGS ('dbx_business_glossary_term' = 'Transcript Ordered Indicator');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `travel_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Travel Time in Hours');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Activity Code');
ALTER TABLE `legal_ecm`.`matter`.`appearance` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm`.`matter`.`filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`matter`.`filing` SET TAGS ('dbx_subdomain' = 'litigation_proceedings');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Identifier');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `amended_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Amended Filing Identifier');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Filed By Attorney Identifier');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `clause_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Clause Library Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `privacy_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `tribunal_id` SET TAGS ('dbx_business_glossary_term' = 'Court Identifier');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `confidential_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `cost_allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Code');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `deadline_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Deadline Compliance Flag');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Deadline Date');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `docket_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Docket Entry Number');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `ecf_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Confirmation Number');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `exhibit_count` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Count');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `expedited_flag` SET TAGS ('dbx_business_glossary_term' = 'Expedited Flag');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Amount');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Currency');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `filing_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Description');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending|withdrawn|amended');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `format` SET TAGS ('dbx_business_glossary_term' = 'Filing Format');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `format` SET TAGS ('dbx_value_regex' = 'pdf|docx|electronic|paper');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Hearing Date');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `judge_assigned` SET TAGS ('dbx_business_glossary_term' = 'Judge Assigned');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Filing Notes');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `pacer_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Public Access to Court Electronic Records (PACER) Transaction Identifier');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `party` SET TAGS ('dbx_business_glossary_term' = 'Filing Party');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `sealed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sealed Flag');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `service_method` SET TAGS ('dbx_business_glossary_term' = 'Service Method');
ALTER TABLE `legal_ecm`.`matter`.`filing` ALTER COLUMN `service_method` SET TAGS ('dbx_value_regex' = 'electronic|mail|hand_delivery|certified_mail|courier');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` SET TAGS ('dbx_subdomain' = 'litigation_proceedings');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `matter_deadline_id` SET TAGS ('dbx_business_glossary_term' = 'Deadline Identifier');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `hearing_id` SET TAGS ('dbx_business_glossary_term' = 'Hearing Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `judge_id` SET TAGS ('dbx_business_glossary_term' = 'Judge Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `responsible_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Timekeeper Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `tribunal_id` SET TAGS ('dbx_business_glossary_term' = 'Court Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `adr_proceeding_flag` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Proceeding Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `adr_proceeding_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Proceeding Type');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `adr_proceeding_type` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|settlement_conference|early_neutral_evaluation');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `alert_days_before` SET TAGS ('dbx_business_glossary_term' = 'Alert Days Before');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `alert_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Sent Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `alert_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Sent Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `calendar_entry_reference` SET TAGS ('dbx_business_glossary_term' = 'Calendar Entry Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `calendar_sync_status` SET TAGS ('dbx_business_glossary_term' = 'Calendar Synchronization Status');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `calendar_sync_status` SET TAGS ('dbx_value_regex' = 'synced|pending|failed|not_synced');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `calendar_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calendar Synchronization Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `client_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Client Notified Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'pending|completed|missed|waived|extended');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `court_case_number` SET TAGS ('dbx_business_glossary_term' = 'Court Case Number');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `court_rule_citation` SET TAGS ('dbx_business_glossary_term' = 'Court Rule Citation');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Deadline Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `deadline_description` SET TAGS ('dbx_business_glossary_term' = 'Deadline Description');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `deadline_time` SET TAGS ('dbx_business_glossary_term' = 'Deadline Time');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `deadline_type` SET TAGS ('dbx_business_glossary_term' = 'Deadline Type');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `deadline_type` SET TAGS ('dbx_value_regex' = 'statute_of_limitations|court_ordered|regulatory_filing|contractual_notice|discovery_cutoff|motion_filing');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `due_time` SET TAGS ('dbx_business_glossary_term' = 'Due Time');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `ecf_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Filing Required Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `extended_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Deadline Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `extended_due_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Due Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `extension_granted_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Granted Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `extension_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Extension Granted Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `extension_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Extension Order Reference');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|hand_delivery|certified_mail');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `governing_rule_reference` SET TAGS ('dbx_business_glossary_term' = 'Governing Rule Reference');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `malpractice_insurance_notified` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Insurance Notified');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `malpractice_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Risk Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `opposing_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Opposing Counsel Name');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `pacer_case_number` SET TAGS ('dbx_business_glossary_term' = 'Public Access to Court Electronic Records (PACER) Case Number');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `reminder_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Lead Time Days');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `triggering_event` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `triggering_event_date` SET TAGS ('dbx_business_glossary_term' = 'Triggering Event Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_deadline` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm`.`matter`.`order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`matter`.`order` SET TAGS ('dbx_subdomain' = 'litigation_proceedings');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `clause_id` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Clause Library Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Court Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `data_subject_request_id` SET TAGS ('dbx_business_glossary_term' = 'Data Subject Request Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `hearing_id` SET TAGS ('dbx_business_glossary_term' = 'Hearing Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `judge_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Judge Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `privacy_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Related Motion Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `trust_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Disbursement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `updated_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `updated_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `updated_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `adr_proceeding_type` SET TAGS ('dbx_business_glossary_term' = 'Alternative Dispute Resolution (ADR) Proceeding Type');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `adr_proceeding_type` SET TAGS ('dbx_value_regex' = 'mediation|arbitration|settlement_conference|none');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `appeal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline Date');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Path');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `ecf_document_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Document Number');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Order Effective Date');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Status');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|contested');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Method');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'ecf|paper|email|fax');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `is_appealable` SET TAGS ('dbx_business_glossary_term' = 'Appealable Order Flag');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `is_final` SET TAGS ('dbx_business_glossary_term' = 'Final Order Flag');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `is_published` SET TAGS ('dbx_business_glossary_term' = 'Published Order Flag');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `is_sealed` SET TAGS ('dbx_business_glossary_term' = 'Sealed Order Flag');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Order Issue Date');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `monetary_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Monetary Award Amount');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `order_category` SET TAGS ('dbx_business_glossary_term' = 'Order Category');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `order_category` SET TAGS ('dbx_value_regex' = 'discovery|motion|scheduling|judgment|sentencing|relief');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `order_text` SET TAGS ('dbx_business_glossary_term' = 'Order Full Text');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `order_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'procedural|substantive|consent|default|summary_judgment|injunction');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `pacer_url` SET TAGS ('dbx_business_glossary_term' = 'Public Access to Court Electronic Records (PACER) URL');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `prevailing_party` SET TAGS ('dbx_business_glossary_term' = 'Prevailing Party');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Order Summary');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Order Title');
ALTER TABLE `legal_ecm`.`matter`.`order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` SET TAGS ('dbx_subdomain' = 'litigation_proceedings');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `court_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Court Rule ID');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `parent_rule_court_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Rule ID');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `practice_note_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Note Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `primary_superseded_by_rule_court_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rule ID');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `tribunal_id` SET TAGS ('dbx_business_glossary_term' = 'Court ID');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `advisory_committee_notes` SET TAGS ('dbx_business_glossary_term' = 'Advisory Committee Notes');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `amendment_history` SET TAGS ('dbx_business_glossary_term' = 'Amendment History');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `applicable_case_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable Case Types');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `citation_format` SET TAGS ('dbx_business_glossary_term' = 'Citation Format');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `compliance_checklist` SET TAGS ('dbx_business_glossary_term' = 'Compliance Checklist');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `court_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `court_rule_status` SET TAGS ('dbx_value_regex' = 'active|superseded|proposed|suspended|archived');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `deadline_calculation_rule` SET TAGS ('dbx_business_glossary_term' = 'Deadline Calculation Rule');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `ecf_event_code` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Event Code');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `electronic_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Electronic Filing Required');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `exceptions_and_exemptions` SET TAGS ('dbx_business_glossary_term' = 'Exceptions and Exemptions');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `jurisdiction_scope` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Scope');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `mandatory_form_reference` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Form Reference');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `page_limit` SET TAGS ('dbx_business_glossary_term' = 'Page Limit');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `penalty_for_noncompliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Noncompliance');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `related_statutes` SET TAGS ('dbx_business_glossary_term' = 'Related Statutes');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `rule_text` SET TAGS ('dbx_business_glossary_term' = 'Rule Text');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `rule_title` SET TAGS ('dbx_business_glossary_term' = 'Rule Title');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'federal_rule|local_rule|standing_order|practice_direction|administrative_order|interim_order');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `service_method_required` SET TAGS ('dbx_business_glossary_term' = 'Service Method Required');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `service_method_required` SET TAGS ('dbx_value_regex' = 'personal|mail|electronic|publication|any');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `source_document_url` SET TAGS ('dbx_business_glossary_term' = 'Source Document Uniform Resource Locator (URL)');
ALTER TABLE `legal_ecm`.`matter`.`court_rule` ALTER COLUMN `word_limit` SET TAGS ('dbx_business_glossary_term' = 'Word Limit');
ALTER TABLE `legal_ecm`.`matter`.`judgment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`matter`.`judgment` SET TAGS ('dbx_subdomain' = 'litigation_proceedings');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `judgment_id` SET TAGS ('dbx_business_glossary_term' = 'Judgment Identifier');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Trust Account Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney Identifier');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Court Identifier');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Identifier');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `indemnity_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Exposure Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `judge_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `pi_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Pi Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `privacy_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Judgment Amount');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `appeal_case_number` SET TAGS ('dbx_business_glossary_term' = 'Appeal Case Number');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `appeal_court_name` SET TAGS ('dbx_business_glossary_term' = 'Appellate Court Name');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `attorney_fees_awarded` SET TAGS ('dbx_business_glossary_term' = 'Attorney Fees Awarded');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `consent_judgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Judgment Flag');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `cost_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Award Amount');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `declaratory_relief_flag` SET TAGS ('dbx_business_glossary_term' = 'Declaratory Relief Flag');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `default_judgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Default Judgment Flag');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `ecf_document_number` SET TAGS ('dbx_business_glossary_term' = 'ECF (Electronic Case Filing) Document Number');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Status');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `enforcement_status` SET TAGS ('dbx_value_regex' = 'not_enforced|enforcement_pending|actively_enforced|partially_satisfied|fully_satisfied');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Judgment Entry Date');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Judgment Entry Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `final_judgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Final Judgment Flag');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `for_client` SET TAGS ('dbx_business_glossary_term' = 'Judgment For Client Flag');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `injunctive_relief_flag` SET TAGS ('dbx_business_glossary_term' = 'Injunctive Relief Flag');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Post-Judgment Interest Rate');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `judgment_number` SET TAGS ('dbx_business_glossary_term' = 'Judgment Number');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `judgment_status` SET TAGS ('dbx_business_glossary_term' = 'Judgment Status');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `judgment_text` SET TAGS ('dbx_business_glossary_term' = 'Judgment Full Text');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `judgment_type` SET TAGS ('dbx_business_glossary_term' = 'Judgment Type');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `judgment_type` SET TAGS ('dbx_value_regex' = 'default|consent|summary|trial_verdict|appellate|declaratory');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `lien_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Judgment Lien Filed Flag');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Judgment Notes');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `pacer_case_number` SET TAGS ('dbx_business_glossary_term' = 'PACER (Public Access to Court Electronic Records) Case Number');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `partial_judgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Judgment Flag');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `prevailing_party` SET TAGS ('dbx_business_glossary_term' = 'Prevailing Party');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `prevailing_party_name` SET TAGS ('dbx_business_glossary_term' = 'Prevailing Party Name');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `satisfaction_date` SET TAGS ('dbx_business_glossary_term' = 'Judgment Satisfaction Date');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `settlement_judgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Settlement Judgment Flag');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`matter`.`judgment` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Judgment Summary');
ALTER TABLE `legal_ecm`.`matter`.`appeal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`matter`.`appeal` SET TAGS ('dbx_subdomain' = 'litigation_proceedings');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `indemnity_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Claim Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `judgment_id` SET TAGS ('dbx_business_glossary_term' = 'Judgment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Counsel Timekeeper Identifier');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Lower Court Matter Identifier');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `precedent_id` SET TAGS ('dbx_business_glossary_term' = 'Precedent Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `privacy_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Data Breach Incident Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client Profile Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `research_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Research Memo Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `tribunal_id` SET TAGS ('dbx_business_glossary_term' = 'Appellate Court Identifier');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_business_glossary_term' = 'Appeal Type');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_value_regex' = 'interlocutory|final_judgment|certiorari_petition|leave_to_appeal|cross_appeal|permissive_appeal');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `appellant_brief_due_date` SET TAGS ('dbx_business_glossary_term' = 'Appellant Brief Due Date');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `appellant_brief_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appellant Brief Filed Date');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `appellant_party_name` SET TAGS ('dbx_business_glossary_term' = 'Appellant Party Name');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `appellate_docket_number` SET TAGS ('dbx_business_glossary_term' = 'Appellate Docket Number');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `appellee_brief_due_date` SET TAGS ('dbx_business_glossary_term' = 'Appellee Brief Due Date');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `appellee_brief_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appellee Brief Filed Date');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `appellee_party_name` SET TAGS ('dbx_business_glossary_term' = 'Appellee Party Name');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Appeal Bond Amount');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `bond_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Bond Currency Code');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `bond_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `certiorari_petition_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Certiorari Petition Filed Date');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appellate Decision Date');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appellate Decision Outcome');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_value_regex' = 'affirmed|reversed|remanded|affirmed_in_part_reversed_in_part|dismissed|vacated');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `ecf_filing_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Enabled Flag');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `further_appeal_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Further Appeal Available Flag');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `issues_on_appeal` SET TAGS ('dbx_business_glossary_term' = 'Issues on Appeal');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `lower_court_docket_number` SET TAGS ('dbx_business_glossary_term' = 'Lower Court Docket Number');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `mandate_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Mandate Issued Date');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Appeal Notes');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `notice_of_appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Notice of Appeal Filed Date');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `opinion_citation` SET TAGS ('dbx_business_glossary_term' = 'Opinion Citation');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `opinion_type` SET TAGS ('dbx_business_glossary_term' = 'Opinion Type');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `opinion_type` SET TAGS ('dbx_value_regex' = 'published|unpublished|per_curiam|memorandum|summary_order');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `oral_argument_location` SET TAGS ('dbx_business_glossary_term' = 'Oral Argument Location');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `oral_argument_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Oral Argument Requested Flag');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `oral_argument_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Oral Argument Scheduled Date');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `pacer_case_number` SET TAGS ('dbx_business_glossary_term' = 'Public Access to Court Electronic Records (PACER) Case Number');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `panel_composition` SET TAGS ('dbx_business_glossary_term' = 'Panel Composition');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `petition_for_rehearing_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Petition for Rehearing Filed Date');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `record_on_appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Record on Appeal Filed Date');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `reply_brief_due_date` SET TAGS ('dbx_business_glossary_term' = 'Reply Brief Due Date');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `reply_brief_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Reply Brief Filed Date');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `standard_of_review` SET TAGS ('dbx_business_glossary_term' = 'Standard of Review');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `standard_of_review` SET TAGS ('dbx_value_regex' = 'de_novo|abuse_of_discretion|clearly_erroneous|substantial_evidence|plain_error');
ALTER TABLE `legal_ecm`.`matter`.`appeal` ALTER COLUMN `stay_pending_appeal_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Stay Pending Appeal Granted Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`matter`.`matter` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Attorney ID');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `client_engagement_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Scope Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `indemnity_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Indemnity Policy Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `matter_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Attorney ID');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `matter_supervising_partner_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Supervising Partner ID');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `originating_attorney_attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Attorney ID');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|milestone|upon_completion|as_incurred');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Matter Budget Amount');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `close_date` SET TAGS ('dbx_business_glossary_term' = 'Matter Close Date');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'standard|high|restricted|ethical_wall');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `conflict_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Clearance Date');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `conflict_cleared_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Cleared Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `court_case_number` SET TAGS ('dbx_business_glossary_term' = 'Court Case Number');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `engagement_letter_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) Sent Date');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `engagement_letter_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Engagement (LOE) Signed Date');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `fee_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Type (Alternative Fee Arrangement - AFA)');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `ledes_matter_category` SET TAGS ('dbx_business_glossary_term' = 'Legal Electronic Data Exchange Standard (LEDES) Matter Category');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `ledes_matter_category` SET TAGS ('dbx_value_regex' = '^L[0-9]{2}$');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `lpp_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Professional Privilege (LPP) Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `matter_description` SET TAGS ('dbx_business_glossary_term' = 'Matter Description');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `matter_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `matter_name` SET TAGS ('dbx_business_glossary_term' = 'Matter Name');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `matter_number` SET TAGS ('dbx_business_glossary_term' = 'Matter Number');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `matter_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `matter_status` SET TAGS ('dbx_business_glossary_term' = 'Matter Status');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `matter_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|archived|pending_approval');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `matter_type` SET TAGS ('dbx_business_glossary_term' = 'Matter Type');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `office_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Matter Open Date');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `opposing_party_name` SET TAGS ('dbx_business_glossary_term' = 'Opposing Party Name');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `opposing_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Matter Outcome');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'favorable|unfavorable|settled|dismissed|withdrawn|ongoing');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `outcome` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Matter Phase');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Matter Risk Rating');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `statute_of_limitations_date` SET TAGS ('dbx_business_glossary_term' = 'Statute of Limitations Date');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `trial_date` SET TAGS ('dbx_business_glossary_term' = 'Trial Date');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Activity Code');
ALTER TABLE `legal_ecm`.`matter`.`matter` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`phase` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`matter`.`phase` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Phase ID');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `checklist_id` SET TAGS ('dbx_business_glossary_term' = 'Checklist Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `responsible_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Timekeeper ID');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `actual_disbursements_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Disbursements To Date');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `actual_fees_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Fees To Date');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `actual_hours_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours To Date');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `budgeted_disbursements` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Disbursements');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `budgeted_fees` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Fees');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `budgeted_hours` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Hours');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `is_contingent` SET TAGS ('dbx_business_glossary_term' = 'Is Contingent');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `milestone_due_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Due Date');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Phase Notes');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `phase_code` SET TAGS ('dbx_business_glossary_term' = 'Phase Code');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `phase_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `phase_description` SET TAGS ('dbx_business_glossary_term' = 'Phase Description');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `phase_name` SET TAGS ('dbx_business_glossary_term' = 'Phase Name');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `phase_status` SET TAGS ('dbx_business_glossary_term' = 'Phase Status');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `phase_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|on_hold|completed|cancelled|deferred');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `phase_type` SET TAGS ('dbx_business_glossary_term' = 'Phase Type');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`matter`.`phase` ALTER COLUMN `sequence_order` SET TAGS ('dbx_business_glossary_term' = 'Sequence Order');
ALTER TABLE `legal_ecm`.`matter`.`task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`matter`.`task` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `task_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Task ID');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `deadline_id` SET TAGS ('dbx_business_glossary_term' = 'Deadline Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `matter_deadline_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Deadline Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `mitigation_action_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Action Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Phase ID');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `predecessor_task_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Task ID');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `task_approved_by_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Timekeeper ID');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `task_assigned_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timekeeper ID');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `task_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Task Owner ID');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `budget_variance_cost` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Cost');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `budget_variance_hours` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Hours');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `client_visible_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Visible Flag');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `external_task_reference` SET TAGS ('dbx_business_glossary_term' = 'External Task Reference');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `is_milestone_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Milestone Flag');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Task Notes');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `task_category` SET TAGS ('dbx_business_glossary_term' = 'Task Category');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Task Name');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|complete|deferred|cancelled|on_hold');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Task Code');
ALTER TABLE `legal_ecm`.`matter`.`task` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `matter_status_history_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Status History ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `approved_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `approved_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `approved_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Changed By User ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Name');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `billing_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Impact Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Code');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Description');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `changed_by_role` SET TAGS ('dbx_business_glossary_term' = 'Changed By User Role');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `changed_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Changed By User Name');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `changed_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `changed_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `compliance_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Change Effective Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `effective_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Change Effective Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Matter Status');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `new_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|closed|reopened|archived');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Matter Status');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `previous_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|closed|reopened|archived');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `system_notes` SET TAGS ('dbx_business_glossary_term' = 'System Notes');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `wip_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Work In Progress (WIP) Action Taken');
ALTER TABLE `legal_ecm`.`matter`.`matter_status_history` ALTER COLUMN `wip_action_taken` SET TAGS ('dbx_value_regex' = 'none|hold|release|transfer|write_off');
ALTER TABLE `legal_ecm`.`matter`.`team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`matter`.`team` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Team ID');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `clearance_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Clearance ID');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `created_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `created_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `created_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `assignment_source_reference` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source System ID');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `assignment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Assignment Source System');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `assignment_source_system` SET TAGS ('dbx_value_regex' = 'elite_3e|aderant_expert|manual|import');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|completed');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `billing_rate_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Currency Code');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `billing_rate_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `billing_rate_override` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Override Amount');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `billing_rate_override` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `ethical_wall_flag` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Flag');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `fee_budget_cap` SET TAGS ('dbx_business_glossary_term' = 'Fee Budget Cap Amount');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `fee_budget_cap` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `hours_budget_cap` SET TAGS ('dbx_business_glossary_term' = 'Hours Budget Cap');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `hours_budget_cap` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Assignment Flag');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `is_billing_timekeeper` SET TAGS ('dbx_business_glossary_term' = 'Billing Timekeeper Flag');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `is_originating_timekeeper` SET TAGS ('dbx_business_glossary_term' = 'Originating Timekeeper Flag');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `practice_group_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Code');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Matter Role Code');
ALTER TABLE `legal_ecm`.`matter`.`team` ALTER COLUMN `role_description` SET TAGS ('dbx_business_glossary_term' = 'Matter Role Description');
ALTER TABLE `legal_ecm`.`matter`.`budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`matter`.`budget` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Budget ID');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `billing_fee_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Arrangement Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `budget_approved_by_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Timekeeper ID');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `budget_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approved Date');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `budget_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Number');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `budget_source` SET TAGS ('dbx_business_glossary_term' = 'Budget Source');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `budget_source` SET TAGS ('dbx_value_regex' = 'engagement_letter|loe|rfp_response|court_order|client_guideline|internal_estimate');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|approved|revised|closed|suspended|exceeded');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'total_fees|phase_fees|disbursements|total_matter|task_based|milestone_based');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `client_agreed_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Agreed Flag');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective From Date');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective To Date');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `hourly_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate Amount');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `rate_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Approval Status');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `rate_approval_status` SET TAGS ('dbx_value_regex' = 'draft|approved|pending_client_approval|rejected|superseded');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `rate_currency` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `rate_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `rate_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `rate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Expiry Date');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `rate_schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'engagement_letter|rate_schedule|court_order|client_guideline|firm_standard');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'standard|agreed|afa_blended|pro_bono|discounted|premium');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `rate_version` SET TAGS ('dbx_business_glossary_term' = 'Rate Version');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `timekeeper_role` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Role');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `variance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `legal_ecm`.`matter`.`budget` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `legal_ecm`.`matter`.`event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`matter`.`event` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `event_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Event ID');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `legal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Linked Document ID');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `responsible_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Timekeeper ID');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `tribunal_id` SET TAGS ('dbx_business_glossary_term' = 'Court ID');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `attendees` SET TAGS ('dbx_business_glossary_term' = 'Event Attendees');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `calendar_sync_status` SET TAGS ('dbx_business_glossary_term' = 'Calendar Synchronization Status');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `calendar_sync_status` SET TAGS ('dbx_value_regex' = 'synced|pending|failed|not_applicable');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `client_attendance_required` SET TAGS ('dbx_business_glossary_term' = 'Client Attendance Required');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `client_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Required');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'pending|completed|missed|cancelled|rescheduled|in_progress');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `deadline_criticality` SET TAGS ('dbx_business_glossary_term' = 'Deadline Criticality Level');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `deadline_criticality` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Docket Number');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `ecf_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Required');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Event End Time');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `event_category` SET TAGS ('dbx_value_regex' = 'litigation|transactional|regulatory|compliance|advisory|administrative');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Event Date');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Event Number');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `event_time` SET TAGS ('dbx_business_glossary_term' = 'Event Time');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `governing_rule_reference` SET TAGS ('dbx_business_glossary_term' = 'Governing Rule or Statute Reference');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Event Location');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `opposing_counsel` SET TAGS ('dbx_business_glossary_term' = 'Opposing Counsel');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Outcome Notes');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `presiding_judge` SET TAGS ('dbx_business_glossary_term' = 'Presiding Judge or Arbitrator');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `reminder_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Lead Time (Days)');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `statute_of_limitations_flag` SET TAGS ('dbx_business_glossary_term' = 'Statute of Limitations Flag');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Event Subtype');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `subtype` SET TAGS ('dbx_value_regex' = 'court_ordered|statutory|contractual|regulatory|internal|client_requested');
ALTER TABLE `legal_ecm`.`matter`.`event` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Event Title');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `matter_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Disbursement ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `disbursement_number` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Number');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Type');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `incurred_date` SET TAGS ('dbx_business_glossary_term' = 'Incurred Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `matter_disbursement_description` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Description');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Notes');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `paid_date` SET TAGS ('dbx_business_glossary_term' = 'Paid Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `practice_group_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Code');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `reimbursable_flag` SET TAGS ('dbx_business_glossary_term' = 'Reimbursable Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Disbursement Amount');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `utbms_expense_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Task-Based Management System (UTBMS) Expense Code');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `vendor_invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Reference');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `wip_status` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Status');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `wip_status` SET TAGS ('dbx_value_regex' = 'wip|prebilled|billed|collected|written_off');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `legal_ecm`.`matter`.`matter_disbursement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm`.`matter`.`counsel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`matter`.`counsel` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `counsel_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Counsel Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Law Firm Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `matter_party_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Party Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `bar_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Bar Admission Jurisdiction');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `bar_number` SET TAGS ('dbx_business_glossary_term' = 'Bar Registration Number');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `bar_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `bar_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `conflict_check_reference` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Reference Number');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Counsel Full Name');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `counsel_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `counsel_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `counsel_role` SET TAGS ('dbx_business_glossary_term' = 'Counsel Role');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `counsel_role` SET TAGS ('dbx_value_regex' = 'opposing|co-counsel|local counsel|amicus|intervenor|guardian ad litem');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `counsel_status` SET TAGS ('dbx_business_glossary_term' = 'Counsel Status');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `counsel_status` SET TAGS ('dbx_value_regex' = 'active|withdrawn|substituted|suspended|disbarred');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `ecf_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Registration Number');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `lead_counsel_flag` SET TAGS ('dbx_business_glossary_term' = 'Lead Counsel Flag');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Counsel Notes');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Office Address Line 1');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Office Address Line 2');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_city` SET TAGS ('dbx_business_glossary_term' = 'Office City');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_country_code` SET TAGS ('dbx_business_glossary_term' = 'Office Country Code');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Office Postal Code');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_state_province` SET TAGS ('dbx_business_glossary_term' = 'Office State or Province');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `office_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `pro_hac_vice_flag` SET TAGS ('dbx_business_glossary_term' = 'Pro Hac Vice (PHV) Admission Flag');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `representation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Representation End Date');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `representation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Representation Start Date');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `service_preference` SET TAGS ('dbx_business_glossary_term' = 'Service of Process Preference');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `service_preference` SET TAGS ('dbx_value_regex' = 'electronic|mail|courier|fax');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `legal_ecm`.`matter`.`counsel` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `matter_party_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Party Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `individual_id` SET TAGS ('dbx_business_glossary_term' = 'Client Individual Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `organisation_id` SET TAGS ('dbx_business_glossary_term' = 'Client Organisation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `intake_party_id` SET TAGS ('dbx_business_glossary_term' = 'Intake Party Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Identifier (ID)');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Sanctions Screening Result Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `adverse_party_flag` SET TAGS ('dbx_business_glossary_term' = 'Adverse Party Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `beneficial_owner_flag` SET TAGS ('dbx_business_glossary_term' = 'Beneficial Owner Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `conflict_check_cleared_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Cleared Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `conflict_check_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Check Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Type');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `jurisdiction_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction of Incorporation');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `kyc_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Risk Rating');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `kyc_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|prohibited');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `kyc_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Screening Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `kyc_screening_reference` SET TAGS ('dbx_business_glossary_term' = 'Know Your Client (KYC) Screening Reference');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Party Notes');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `party_name` SET TAGS ('dbx_business_glossary_term' = 'Party Name');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `party_status` SET TAGS ('dbx_business_glossary_term' = 'Party Status');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `party_status` SET TAGS ('dbx_value_regex' = 'active|settled|dismissed|withdrawn|deceased|merged');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `party_type` SET TAGS ('dbx_business_glossary_term' = 'Party Type');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `pep_status` SET TAGS ('dbx_business_glossary_term' = 'Politically Exposed Person (PEP) Status');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `pep_status` SET TAGS ('dbx_value_regex' = 'not_pep|domestic_pep|foreign_pep|international_organization');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `representation_status` SET TAGS ('dbx_business_glossary_term' = 'Representation Status');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `representation_status` SET TAGS ('dbx_value_regex' = 'represented|unrepresented|self_represented|pending');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `representing_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Representing Counsel Name');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `representing_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Representing Firm Name');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `role_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Party Role Effective Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `role_end_date` SET TAGS ('dbx_business_glossary_term' = 'Party Role End Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `sanctions_check_status` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Check Status');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `sanctions_check_status` SET TAGS ('dbx_value_regex' = 'clear|match|pending|not_performed');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `settlement_authority_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Authority Amount');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`deadline` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`matter`.`deadline` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`deadline` ALTER COLUMN `deadline_id` SET TAGS ('dbx_business_glossary_term' = 'deadline Identifier');
ALTER TABLE `legal_ecm`.`matter`.`rate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`matter`.`rate` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Rate ID');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `pricing_model_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `superseded_by_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Matter Rate ID');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper ID');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Rate Adjustment Reason');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Approval Date');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Approval Status');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'DRAFT|PENDING_APPROVAL|APPROVED|REJECTED|SUPERSEDED|EXPIRED');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `approved_by_role` SET TAGS ('dbx_business_glossary_term' = 'Approved By Role');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `approved_by_role` SET TAGS ('dbx_value_regex' = 'PARTNER|BILLING_MANAGER|CLIENT_CONTACT|GENERAL_COUNSEL|OTHER');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `billing_guideline_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Guideline Compliant Flag');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Cap Amount');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `client_agreed_flag` SET TAGS ('dbx_business_glossary_term' = 'Client Agreed Flag');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Currency Code');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `hourly_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate Amount');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `ledes_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'LEDES (Legal Electronic Data Exchange Standard) Compliant Flag');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Notes');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `rate_tier` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `source_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Source Reference');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `standard_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Rate Amount');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `timekeeper_role_code` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Role Code');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `utbms_activity_code` SET TAGS ('dbx_business_glossary_term' = 'UTBMS (Uniform Task-Based Management System) Activity Code');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `utbms_task_code` SET TAGS ('dbx_business_glossary_term' = 'UTBMS (Uniform Task-Based Management System) Task Code');
ALTER TABLE `legal_ecm`.`matter`.`rate` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Version Number');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `matter_risk_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Risk ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `compliance_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Control Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Identified By Timekeeper ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `owner_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Timekeeper ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `practice_note_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Note Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `appetite_threshold` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Threshold');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Closure Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Risk Closure Reason');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `escalated_to` SET TAGS ('dbx_business_glossary_term' = 'Escalated To');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `financial_exposure_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Exposure Amount');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `financial_exposure_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Identified Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Impact Rating');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `impact_rating` SET TAGS ('dbx_value_regex' = 'insignificant|minor|moderate|major|catastrophic');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Rating');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_value_regex' = 'rare|unlikely|possible|likely|almost_certain');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `mitigation_action` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Action');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Status');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Notes');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `pi_claim_reference` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity (PI) Claim Reference');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `pi_claim_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `pi_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity (PI) Notification Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `pi_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Professional Indemnity (PI) Notification Required Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Reference Number');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `regulatory_report_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'weekly|fortnightly|monthly|quarterly|ad_hoc');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'professional_indemnity_exposure|adverse_litigation_outcome|regulatory_sanction|client_credit_collection|data_breach|lpp_waiver');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'open|mitigated|accepted|escalated|closed');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `legal_ecm`.`matter`.`matter_risk` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `legal_ecm`.`matter`.`hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`matter`.`hold` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Hold ID');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Attorney ID');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Contact Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `acknowledgement_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Deadline Date');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `client_notified_date` SET TAGS ('dbx_business_glossary_term' = 'Client Notified Date');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `collection_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Collection Scope Description');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `court_case_number` SET TAGS ('dbx_business_glossary_term' = 'Court Case Number');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `data_categories_in_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Categories In Scope');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `data_sources_in_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Sources In Scope');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `ediscovery_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'eDiscovery Vendor Name');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `ediscovery_vendor_reference` SET TAGS ('dbx_business_glossary_term' = 'eDiscovery Vendor Reference');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `estimated_data_volume_gb` SET TAGS ('dbx_business_glossary_term' = 'Estimated Data Volume (GB)');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `estimated_document_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Document Count');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `governing_rule_reference` SET TAGS ('dbx_business_glossary_term' = 'Governing Rule Reference');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Hold Number');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|modified|expired|suspended');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'litigation_hold|regulatory_hold|internal_investigation_hold|pre_litigation_preservation|data_subject_request_hold|compliance_hold');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Issuance Date');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `issuing_attorney_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Attorney Name');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `malpractice_insurance_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Insurance Notified Flag');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `modification_history` SET TAGS ('dbx_business_glossary_term' = 'Hold Modification History');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hold Notes');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `proportionality_assessment` SET TAGS ('dbx_business_glossary_term' = 'Proportionality Assessment');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `relativity_workspace_name` SET TAGS ('dbx_business_glossary_term' = 'Relativity Workspace Name');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `relativity_workspace_reference` SET TAGS ('dbx_business_glossary_term' = 'Relativity Workspace ID');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Reason');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `reminder_cadence_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Cadence Days');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Scope Description');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `spoliation_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Spoliation Risk Level');
ALTER TABLE `legal_ecm`.`matter`.`hold` ALTER COLUMN `spoliation_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` SET TAGS ('dbx_subdomain' = 'litigation_proceedings');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `court_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Court Filing ID');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `filed_by_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Filed By Timekeeper ID');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Form Template Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Related Filing ID');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|attorneys_eyes_only|outside_counsel_only|in_house_only');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `court_reference` SET TAGS ('dbx_business_glossary_term' = 'Court Reference');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Docket Number');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `ecf_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Case Filing (ECF) Transaction ID');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `filed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Filed By Name');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `filing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Amount');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `filing_fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Filing Fee Currency Code');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `filing_fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `filing_party_role` SET TAGS ('dbx_business_glossary_term' = 'Filing Party Role');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `filing_party_role` SET TAGS ('dbx_value_regex' = 'plaintiff|defendant|petitioner|respondent|intervenor|amicus_curiae');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'submitted|accepted|rejected|pending|withdrawn');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `filing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Filing Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Hearing Date');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `judge_name` SET TAGS ('dbx_business_glossary_term' = 'Judge Name');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `pacer_document_number` SET TAGS ('dbx_business_glossary_term' = 'Public Access to Court Electronic Records (PACER) Document Number');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `seal_status` SET TAGS ('dbx_business_glossary_term' = 'Seal Status');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `seal_status` SET TAGS ('dbx_value_regex' = 'public|sealed|redacted|confidential');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `served_by_name` SET TAGS ('dbx_business_glossary_term' = 'Served By Name');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `service_method` SET TAGS ('dbx_business_glossary_term' = 'Service Method');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `service_method` SET TAGS ('dbx_value_regex' = 'personal|mail|electronic|publication|substituted');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `legal_ecm`.`matter`.`court_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'ecf_electronic|manual_paper|courier|fax|email');
ALTER TABLE `legal_ecm`.`matter`.`outcome` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `legal_ecm`.`matter`.`outcome` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `outcome_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Outcome ID');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `judgment_id` SET TAGS ('dbx_business_glossary_term' = 'Judgment Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter ID');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `regulatory_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Breach Compliance Breach Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `responsible_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Timekeeper ID');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `appealed_outcome_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `appeal_filed_by_party` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed By Party');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `appeal_filed_by_party` SET TAGS ('dbx_value_regex' = 'client|opposing_party|third_party|not_applicable');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Date');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `billing_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Impact Flag');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `client_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Client Satisfaction Rating');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'complied|partially_complied|non_compliant|pending|not_applicable');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `contingent_fee_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Contingent Fee Triggered Flag');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `court_case_number` SET TAGS ('dbx_business_glossary_term' = 'Court Case Number');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `damages_awarded_amount` SET TAGS ('dbx_business_glossary_term' = 'Damages Awarded Amount');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `damages_awarded_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `enforcement_action_date` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Date');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `enforcement_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Required Flag');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `favorable_outcome_flag` SET TAGS ('dbx_business_glossary_term' = 'Favorable Outcome Flag');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `lessons_learned_reference` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned Reference');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `matter_closure_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Matter Closure Triggered Flag');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `office_code` SET TAGS ('dbx_business_glossary_term' = 'Office Code');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `opposing_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Opposing Counsel Name');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `opposing_law_firm_name` SET TAGS ('dbx_business_glossary_term' = 'Opposing Law Firm Name');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `opposing_party_name` SET TAGS ('dbx_business_glossary_term' = 'Opposing Party Name');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `outcome_category` SET TAGS ('dbx_business_glossary_term' = 'Outcome Category');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `outcome_date` SET TAGS ('dbx_business_glossary_term' = 'Outcome Date');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Outcome Description');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Outcome Status');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `outcome_type` SET TAGS ('dbx_business_glossary_term' = 'Outcome Type');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `practice_group_code` SET TAGS ('dbx_business_glossary_term' = 'Practice Group Code');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `presiding_judge_name` SET TAGS ('dbx_business_glossary_term' = 'Presiding Judge Name');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `prevailing_party` SET TAGS ('dbx_business_glossary_term' = 'Prevailing Party');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `prevailing_party` SET TAGS ('dbx_value_regex' = 'client|opposing_party|mutual|none|not_applicable');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Outcome Reference Number');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `satisfaction_date` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Date');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `transaction_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Transaction Value Amount');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `transaction_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `win_loss_classification` SET TAGS ('dbx_business_glossary_term' = 'Win Loss Classification');
ALTER TABLE `legal_ecm`.`matter`.`outcome` ALTER COLUMN `win_loss_classification` SET TAGS ('dbx_value_regex' = 'win|loss|partial_win|neutral|not_applicable');
ALTER TABLE `legal_ecm`.`matter`.`assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`matter`.`assignment` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`assignment` SET TAGS ('dbx_association_edges' = 'matter.matter,workforce.timekeeper');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Assignment ID');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `created_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created By User');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `created_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `created_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Last Modified By User');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `last_modified_by_user_timekeeper_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Assignment - Matter Id');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `timekeeper_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Assignment - Timekeeper Id');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Assignment Allocation Percentage');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `billing_rate_override` SET TAGS ('dbx_business_glossary_term' = 'Assignment Billing Rate Override');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Created Date');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `hours_budget_cap` SET TAGS ('dbx_business_glossary_term' = 'Assignment Hours Budget Cap');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Assignment Active Flag');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Last Modified Date');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role Code');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `role_description` SET TAGS ('dbx_business_glossary_term' = 'Assignment Role Description');
ALTER TABLE `legal_ecm`.`matter`.`assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` SET TAGS ('dbx_association_edges' = 'client.contact,matter.matter');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `matter_contact_id` SET TAGS ('dbx_business_glossary_term' = 'matter_contact Identifier');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Contact Assignment ID');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Contact - Matter Id');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `communication_frequency` SET TAGS ('dbx_business_glossary_term' = 'Communication Frequency');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `is_billing_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Billing Contact Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `role_on_matter` SET TAGS ('dbx_business_glossary_term' = 'Contact Role on Matter');
ALTER TABLE `legal_ecm`.`matter`.`matter_contact` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` SET TAGS ('dbx_association_edges' = 'matter.matter_hold,matter.matter_party');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `hold_custodian_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Custodian Assignment Identifier');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Custodian - Matter Hold Id');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `matter_party_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Custodian - Matter Party Id');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Acknowledgement Date');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Acknowledgement Status');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Assignment Date');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `collection_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Custodian Collection Completion Date');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Custodian Collection Status');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `custodian_acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Custodian Acknowledgement Status');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `custodian_acknowledgement_status` SET TAGS ('dbx_value_regex' = 'pending|partial|complete|overdue');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `custodian_count` SET TAGS ('dbx_business_glossary_term' = 'Custodian Count');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `custodian_list` SET TAGS ('dbx_business_glossary_term' = 'Custodian List');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `custodian_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `custodian_notes` SET TAGS ('dbx_business_glossary_term' = 'Custodian Assignment Notes');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `custodian_role` SET TAGS ('dbx_business_glossary_term' = 'Custodian Role Type');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `data_sources_in_scope_for_custodian` SET TAGS ('dbx_business_glossary_term' = 'Custodian-Specific Data Sources');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `estimated_data_volume_gb_for_custodian` SET TAGS ('dbx_business_glossary_term' = 'Custodian Data Volume Estimate');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Custodian Hold Release Date');
ALTER TABLE `legal_ecm`.`matter`.`hold_custodian` ALTER COLUMN `reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Reminder Sent Date');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` SET TAGS ('dbx_association_edges' = 'court.jurisdiction,service.practice_area');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `jurisdiction_practice_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Practice Coverage ID');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Practice Coverage - Court Jurisdiction Id');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `practice_area_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Practice Coverage - Practice Area Id');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `admission_required` SET TAGS ('dbx_business_glossary_term' = 'Admission Required');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `admitted_attorney_count` SET TAGS ('dbx_business_glossary_term' = 'Admitted Attorney Count');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `local_counsel_required` SET TAGS ('dbx_business_glossary_term' = 'Local Counsel Required');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `practice_area_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Practice Area Restrictions');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `preferred_local_counsel_firm` SET TAGS ('dbx_business_glossary_term' = 'Preferred Local Counsel Firm');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `regulatory_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notes');
ALTER TABLE `legal_ecm`.`matter`.`jurisdiction_practice_coverage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` SET TAGS ('dbx_association_edges' = 'matter.matter,risk.risk_category');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Risk Assessment Identifier');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Risk Assessment - Risk Category Id');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Risk Assessment - Matter Id');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `applicability_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Applicability Date');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `assessed_by` SET TAGS ('dbx_business_glossary_term' = 'Assessor');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Matter Inherent Risk Score');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `last_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Plan');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `regulatory_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Sent Flag');
ALTER TABLE `legal_ecm`.`matter`.`risk_assessment` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Matter Residual Risk Score');
ALTER TABLE `legal_ecm`.`matter`.`assertion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`matter`.`assertion` SET TAGS ('dbx_subdomain' = 'litigation_proceedings');
ALTER TABLE `legal_ecm`.`matter`.`assertion` SET TAGS ('dbx_association_edges' = 'court.docket,ip.asset');
ALTER TABLE `legal_ecm`.`matter`.`assertion` ALTER COLUMN `assertion_id` SET TAGS ('dbx_business_glossary_term' = 'Assertion Identifier');
ALTER TABLE `legal_ecm`.`matter`.`assertion` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Assertion - Docket Id');
ALTER TABLE `legal_ecm`.`matter`.`assertion` ALTER COLUMN `ip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Assertion - Ip Asset Id');
ALTER TABLE `legal_ecm`.`matter`.`assertion` ALTER COLUMN `matter_party_id` SET TAGS ('dbx_business_glossary_term' = 'Expert Witness');
ALTER TABLE `legal_ecm`.`matter`.`assertion` ALTER COLUMN `accused_products` SET TAGS ('dbx_business_glossary_term' = 'Accused Products');
ALTER TABLE `legal_ecm`.`matter`.`assertion` ALTER COLUMN `assertion_date` SET TAGS ('dbx_business_glossary_term' = 'Assertion Date');
ALTER TABLE `legal_ecm`.`matter`.`assertion` ALTER COLUMN `assertion_status` SET TAGS ('dbx_business_glossary_term' = 'Assertion Status');
ALTER TABLE `legal_ecm`.`matter`.`assertion` ALTER COLUMN `claim_construction_ruling` SET TAGS ('dbx_business_glossary_term' = 'Claim Construction Ruling');
ALTER TABLE `legal_ecm`.`matter`.`assertion` ALTER COLUMN `claim_scope` SET TAGS ('dbx_business_glossary_term' = 'Claim Scope');
ALTER TABLE `legal_ecm`.`matter`.`assertion` ALTER COLUMN `damages_theory` SET TAGS ('dbx_business_glossary_term' = 'Damages Theory');
ALTER TABLE `legal_ecm`.`matter`.`assertion` ALTER COLUMN `infringement_theory` SET TAGS ('dbx_business_glossary_term' = 'Infringement Theory');
ALTER TABLE `legal_ecm`.`matter`.`assertion` ALTER COLUMN `invalidity_defense_raised` SET TAGS ('dbx_business_glossary_term' = 'Invalidity Defense');
ALTER TABLE `legal_ecm`.`matter`.`assertion` ALTER COLUMN `settlement_allocation` SET TAGS ('dbx_business_glossary_term' = 'Settlement Allocation');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` SET TAGS ('dbx_association_edges' = 'matter.matter,conflict.lateral_screening');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `lateral_conflict_id` SET TAGS ('dbx_business_glossary_term' = 'Matter-Lateral Conflict ID');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Analyzing Attorney Profile ID');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `lateral_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Lateral Conflict - Lateral Screening Id');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Lateral Conflict - Matter Id');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `client_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Client Consent Obtained Flag');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `client_consent_required` SET TAGS ('dbx_business_glossary_term' = 'Client Consent Required Flag');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `conflict_analysis_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Analysis Date');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `conflict_severity` SET TAGS ('dbx_business_glossary_term' = 'Conflict Severity Level');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Conflict Disclosure Date');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `ethical_wall_required` SET TAGS ('dbx_business_glossary_term' = 'Ethical Wall Required Flag');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `mitigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Notes');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `mitigation_required` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Required Flag');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `prior_matter_description` SET TAGS ('dbx_business_glossary_term' = 'Prior Matter Description');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `prior_matter_description` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `prior_matter_role` SET TAGS ('dbx_business_glossary_term' = 'Prior Matter Role');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `relationship_nature` SET TAGS ('dbx_business_glossary_term' = 'Conflict Relationship Nature');
ALTER TABLE `legal_ecm`.`matter`.`lateral_conflict` ALTER COLUMN `substantive_involvement_flag` SET TAGS ('dbx_business_glossary_term' = 'Substantive Involvement Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` SET TAGS ('dbx_subdomain' = 'case_management');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` SET TAGS ('dbx_association_edges' = 'matter.matter,risk.risk_control');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `matter_control_id` SET TAGS ('dbx_business_glossary_term' = 'matter_control Identifier');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `matter_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Control - Matter Id');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `matter_risk_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Id (Foreign Key)');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `attorney_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Control Responsible Timekeeper');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `risk_control_id` SET TAGS ('dbx_business_glossary_term' = 'Matter Control - Risk Control Id');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Matter Control Deficiency Description');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Matter-Specific Control Effectiveness Rating');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Matter Control Evidence Reference');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Matter Control Implementation Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Matter Control Implementation Status');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Matter Control Next Review Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Matter Control Notes');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Matter Control Remediation Due Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `remediation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Matter Control Remediation Required Flag');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Matter Control Test Date');
ALTER TABLE `legal_ecm`.`matter`.`matter_control` ALTER COLUMN `test_outcome` SET TAGS ('dbx_business_glossary_term' = 'Matter Control Test Outcome');
