-- Schema for Domain: compliance | Business: Airlines | Version: v1_ecm
-- Generated on: 2026-05-07 12:58:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`compliance` COMMENT 'Regulatory compliance management including FAA, EASA, DOT, and national CAA reporting, airworthiness compliance, operational approvals (ETOPS, RNAV, CAT III), environmental compliance (CORSIA emissions and carbon offset records), consumer protection compliance, audit management, regulatory filings, certifications, and DOT/FAA regulatory filing history.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` (
    `regulatory_requirement_id` BIGINT COMMENT 'Unique identifier for the regulatory requirement record. Primary key.',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Each regulatory requirement is issued by a specific authority (FAA, EASA, ICAO, national CAA). FK normalizes authority reference. Column removal: governing_authority (string name) and issuing_country_',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Each regulatory requirement must have an accountable department for compliance execution (e.g., Flight Ops owns FDP limits, Maintenance owns airworthiness directives). FK enables compliance workload a',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this regulatory requirement is currently active and enforceable (True) or has been superseded, repealed, or is no longer applicable (False).',
    `aircraft_type_applicability` STRING COMMENT 'Specific aircraft type, family, or category to which this requirement applies (e.g., B737, A320 family, twin-engine jets, turboprop). Null if applicable to all aircraft.',
    `amendment_number` STRING COMMENT 'The amendment, revision, or version number of the regulatory requirement as published by the governing authority (e.g., Amendment 121-374, Rev 5).. Valid values are `^[A-Z0-9-]{1,20}$`',
    `applicability_scope` STRING COMMENT 'Defines the scope of operations, aircraft types, routes, or organizational units to which this requirement applies (e.g., all Part 121 operations, widebody aircraft only, ETOPS routes, international flights, specific airport operations).',
    `compliance_category` STRING COMMENT 'High-level classification of the regulatory requirement type: airworthiness (aircraft certification, MEL), operational (flight operations, crew duty limits, ETOPS), environmental (CORSIA emissions, noise), consumer protection (DOT passenger rights, refunds), safety (SMS, incident reporting), or security (TSA, cargo screening).. Valid values are `airworthiness|operational|environmental|consumer_protection|safety|security`',
    `compliance_frequency` STRING COMMENT 'The frequency or cadence at which compliance with this requirement must be demonstrated or reported (e.g., one-time certification, continuous monitoring, annual audit, quarterly report, event-driven such as incident reporting). [ENUM-REF-CANDIDATE: one_time|continuous|annual|quarterly|monthly|event_driven|as_required — 7 candidates stripped; promote to reference product]',
    `compliance_status` STRING COMMENT 'Current compliance status of the airline with respect to this requirement: compliant (fully meeting the requirement), non-compliant (violation or gap identified), in_progress (working toward compliance), not_applicable (requirement does not apply to current operations), under_review (compliance assessment ongoing).. Valid values are `compliant|non_compliant|in_progress|not_applicable|under_review`',
    `compliance_subcategory` STRING COMMENT 'Detailed subcategory or domain within the compliance category (e.g., ETOPS approval, CAT III operations, RNAV certification, carbon offset reporting, tarmac delay rule, baggage liability).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory requirement record was first created in the system.',
    `criticality_level` STRING COMMENT 'Internal risk-based classification of the importance and impact of this requirement: critical (safety-critical, AOG risk, severe penalties), high (significant operational or financial impact), medium (moderate impact), low (minor administrative requirement).. Valid values are `critical|high|medium|low`',
    `effective_date` DATE COMMENT 'The date on which this regulatory requirement became or will become enforceable and binding on the airline.',
    `expiration_date` DATE COMMENT 'The date on which this regulatory requirement ceases to be enforceable, if applicable. Null for requirements with no expiration.',
    `internal_policy_reference` STRING COMMENT 'Reference to the airlines internal policy, procedure, or manual section that implements or addresses this regulatory requirement (e.g., Operations Manual Chapter 5.3, Safety Management System Procedure SOP-123).',
    `last_compliance_review_date` DATE COMMENT 'The date on which the airlines compliance with this requirement was last reviewed, audited, or assessed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory requirement record was last updated or modified.',
    `maximum_penalty_amount` DECIMAL(18,2) COMMENT 'Maximum monetary penalty or fine amount (in USD or local currency) that can be assessed for a single violation of this requirement. Null if penalty is non-monetary or not specified.',
    `next_compliance_review_date` DATE COMMENT 'The scheduled date for the next compliance review, audit, or assessment of this requirement.',
    `notes` STRING COMMENT 'Additional free-text notes, clarifications, or internal commentary regarding this requirement, its interpretation, or compliance approach.',
    `operational_approval_type` STRING COMMENT 'Type of operational approval or certification this requirement pertains to (e.g., ETOPS, RNAV, RNP, CAT II/III, RVSM, PBN). Null if not approval-specific.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the maximum penalty amount (e.g., USD, EUR, GBP). Null if penalty is non-monetary.. Valid values are `^[A-Z]{3}$`',
    `penalty_description` STRING COMMENT 'Description of penalties, fines, sanctions, or enforcement actions that may result from non-compliance with this requirement (e.g., civil penalty up to $25,000 per violation, certificate suspension, AOG).',
    `publication_date` DATE COMMENT 'The date on which this requirement or its current amendment was officially published by the governing authority.',
    `reference_document_title` STRING COMMENT 'Title of the primary regulatory document, regulation, or standard that contains this requirement (e.g., Federal Aviation Regulations Part 121, EASA Part-ORO, ICAO Annex 6, DOT 14 CFR Part 234).',
    `reference_document_url` STRING COMMENT 'Web URL or hyperlink to the official online version of the regulatory document or requirement text.. Valid values are `^https?://.*$`',
    `reporting_deadline_days` STRING COMMENT 'Number of days after the triggering event or period end by which the compliance report or filing must be submitted to the authority. Null if not applicable.',
    `reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this requirement mandates formal reporting or filing to the governing authority (True) or is compliance-only without reporting (False).',
    `requirement_code` STRING COMMENT 'Unique business identifier code for the regulatory requirement as published by the governing authority (e.g., FAR 121.135, EASA Part-ORO.GEN.110, DOT 14 CFR 234.4).. Valid values are `^[A-Z0-9-]{3,20}$`',
    `requirement_description` STRING COMMENT 'Detailed description of the regulatory obligation, including what must be complied with, how, and under what conditions.',
    `requirement_title` STRING COMMENT 'Official title or short name of the regulatory requirement as published by the governing authority.',
    `route_applicability` STRING COMMENT 'Route type or geographic scope to which this requirement applies (e.g., ETOPS routes, polar routes, international, domestic, specific country pairs). Null if universally applicable.',
    `superseded_by_requirement_code` STRING COMMENT 'The requirement code of the new or amended requirement that supersedes this one, if applicable. Null if not superseded.. Valid values are `^[A-Z0-9-]{3,20}$`',
    CONSTRAINT pk_regulatory_requirement PRIMARY KEY(`regulatory_requirement_id`)
) COMMENT 'Master catalog of all regulatory requirements applicable to the airline, sourced from FAA, EASA, ICAO, DOT, national CAAs, TSA, and environmental bodies (CORSIA). Each record defines a specific regulatory obligation, its governing authority, applicability scope (aircraft type, route, operation), effective dates, and compliance category (airworthiness, operational, environmental, consumer protection, safety). This is the SSOT for what the airline must comply with.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`regulatory_authority` (
    `regulatory_authority_id` BIGINT COMMENT 'Unique identifier for the regulatory authority. Primary key for this entity.',
    `parent_authority_regulatory_authority_id` BIGINT COMMENT 'Reference to a parent or umbrella regulatory authority if this authority operates under a higher-level body (e.g., a national CAA under ICAO, or a state aviation authority under a federal FAA).',
    `audit_cycle_months` STRING COMMENT 'Typical interval in months between scheduled audits or inspections conducted by this authority. Null if audits are event-driven or irregular.',
    `authority_code` STRING COMMENT 'Standardized short code or abbreviation for the regulatory authority (e.g., FAA, EASA, ICAO, DOT, TSA, CAA).. Valid values are `^[A-Z0-9]{2,10}$`',
    `authority_name` STRING COMMENT 'Full legal name of the regulatory authority or governing body (e.g., Federal Aviation Administration, European Union Aviation Safety Agency, International Civil Aviation Organization).',
    `authority_status` STRING COMMENT 'Current operational status of the regulatory authority. Active authorities are currently enforcing regulations; inactive, superseded, merged, or dissolved authorities are historical.. Valid values are `active|inactive|superseded|merged|dissolved`',
    `authority_type` STRING COMMENT 'Classification of the regulatory authority by its primary regulatory domain (safety, environmental, consumer protection, security, operational, financial, or industry association). [ENUM-REF-CANDIDATE: safety|environmental|consumer_protection|security|operational|financial|industry_association — 7 candidates stripped; promote to reference product]',
    `certification_scope` STRING COMMENT 'Description of the types of certifications, approvals, or licenses issued by this authority (e.g., Air Operator Certificate, airworthiness certificates, ETOPS approval, RNAV approval, personnel licenses).',
    `city` STRING COMMENT 'City where the regulatory authority headquarters is located.',
    `contact_email` STRING COMMENT 'Primary email address for official correspondence and regulatory inquiries with the authority.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for contacting the regulatory authority, including country code and extension if applicable.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the primary country of jurisdiction for the regulatory authority. Empty for international bodies.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory authority record was first created in the system.',
    `dissolved_date` DATE COMMENT 'Date when the regulatory authority was dissolved, merged, or superseded. Null for active authorities.',
    `enforcement_powers` STRING COMMENT 'Summary of the enforcement actions and penalties this authority can impose (e.g., fines, license suspension, operational restrictions, criminal prosecution).',
    `established_date` DATE COMMENT 'Date when the regulatory authority was officially established or incorporated.',
    `filing_method` STRING COMMENT 'Primary method accepted by the authority for submitting regulatory filings and compliance documents (electronic portal, email, postal mail, fax, API, or mixed methods).. Valid values are `electronic_portal|email|postal_mail|fax|api|mixed`',
    `filing_portal_url` STRING COMMENT 'URL of the online portal or system used for submitting regulatory filings, reports, and compliance documents to this authority.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    `jurisdiction_level` STRING COMMENT 'Geographic scope of the authoritys jurisdiction (international, regional, national, state/provincial, or local).. Valid values are `international|regional|national|state_provincial|local`',
    `language` STRING COMMENT 'ISO 639-1 or ISO 639-2 language code for the primary official language used by the authority for regulations and correspondence.. Valid values are `^[a-z]{2,3}$`',
    `mailing_address` STRING COMMENT 'Full postal mailing address for official correspondence and document submission to the regulatory authority.',
    `notes` STRING COMMENT 'Additional notes, special instructions, or context regarding interactions with this regulatory authority, including historical changes, merger details, or unique compliance requirements.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the regulatory authority headquarters address.',
    `primary_contact_name` STRING COMMENT 'Name of the primary liaison or contact person at the regulatory authority for airline compliance matters.',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact person at the regulatory authority.',
    `region` STRING COMMENT 'Geographic region or multi-country area covered by the authority (e.g., European Union, Asia-Pacific, North America, Middle East). Applicable for regional authorities.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework, legislation, or standards administered by this authority (e.g., Federal Aviation Regulations Part 121, EASA Part-OPS, ICAO Standards and Recommended Practices, CORSIA Carbon Offsetting Scheme).',
    `reporting_frequency` STRING COMMENT 'Typical frequency at which the airline is required to submit reports or filings to this authority (real-time, daily, weekly, monthly, quarterly, annual, event-driven, or as required). [ENUM-REF-CANDIDATE: real_time|daily|weekly|monthly|quarterly|annual|event_driven|as_required — 8 candidates stripped; promote to reference product]',
    `state_province` STRING COMMENT 'State or province where the regulatory authority headquarters is located. Applicable for national and sub-national authorities.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the regulatory authority headquarters location (e.g., America/New_York, Europe/Brussels, Asia/Singapore).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory authority record was last updated in the system.',
    `website_url` STRING COMMENT 'Official website URL of the regulatory authority for accessing regulations, guidance, and filing portals.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    CONSTRAINT pk_regulatory_authority PRIMARY KEY(`regulatory_authority_id`)
) COMMENT 'Reference master of all regulatory and governing bodies the airline interacts with — FAA, EASA, ICAO, DOT, TSA, national CAAs, ISO bodies, CORSIA administrators, IATA, and airport slot coordinators. Captures authority name, jurisdiction, country/region, authority type (safety, environmental, consumer, security), regulatory framework administered, contact details, and filing/submission channels. Used as a foreign key lookup across all compliance products — filings, certificates, approvals, violations, and waivers reference this entity.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`operating_certificate` (
    `operating_certificate_id` BIGINT COMMENT 'Unique identifier for the operating certificate record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Operating certificate renewal fees and administrative costs are allocated to cost centres. Airlines track certificate maintenance costs by department for regulatory compliance budget management and co',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Operating certificates specify principal base of operations (home station/hub). Required for regulatory filings, defines jurisdiction for primary oversight, and determines applicable bilateral agreeme',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Operating certificates (AOC, foreign carrier permits) are managed by specific departments. FK enables certificate renewal tracking, departmental workload visibility, and accountability for maintaining',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Each operating certificate is issued by a specific regulatory authority. FK normalizes authority reference. Column removal: issuing_authority (string name) and jurisdiction (covered by authority.juris',
    `aircraft_types_authorized` STRING COMMENT 'List of aircraft types and models authorized for operation under this certificate. May reference ICAO aircraft type designators.',
    `bilateral_agreement_reference` STRING COMMENT 'Reference to the bilateral air service agreement under which traffic rights or foreign carrier permits are granted. Includes agreement name, date, and relevant articles.',
    `certificate_number` STRING COMMENT 'Official certificate or permit number issued by the regulatory authority. Examples include AOC number, Part 121 certificate number, foreign carrier permit number.',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the operating certificate. Indicates whether the certificate is active, suspended, revoked, expired, pending renewal, or under regulatory review.. Valid values are `active|suspended|revoked|expired|pending_renewal|under_review`',
    `certificate_type` STRING COMMENT 'Type of operating certificate or authorization. Distinguishes between Air Operator Certificate (AOC), foreign carrier permits, bilateral entitlements, traffic rights, and exemptions. [ENUM-REF-CANDIDATE: aoc_domestic|aoc_international|part_121_certificate|easa_aoc|foreign_carrier_permit|bilateral_entitlement|traffic_right|exemption — 8 candidates stripped; promote to reference product]',
    `compliance_notes` STRING COMMENT 'Internal notes regarding compliance status, upcoming audits, regulatory correspondence, or other relevant information related to this certificate.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this operating certificate record was first created in the system.',
    `document_repository_url` STRING COMMENT 'URL or file path to the document management system location where the physical certificate, supporting documentation, and correspondence are stored.',
    `effective_date` DATE COMMENT 'Date from which the operating certificate or permit becomes legally effective and operational authority is granted.',
    `exemption_details` STRING COMMENT 'Details of any regulatory exemptions granted as part of this certificate, including exemption number, scope, and conditions.',
    `expiry_date` DATE COMMENT 'Date on which the operating certificate or permit expires and must be renewed. Null for indefinite certificates subject to continuous surveillance.',
    `issue_date` DATE COMMENT 'Date on which the operating certificate or permit was originally issued by the regulatory authority.',
    `last_renewal_date` DATE COMMENT 'Date of the most recent renewal or revalidation of the operating certificate.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this operating certificate record was last modified in the system.',
    `next_renewal_due_date` DATE COMMENT 'Date by which the next renewal application or revalidation must be submitted to the regulatory authority.',
    `operational_approvals` STRING COMMENT 'Special operational approvals granted under this certificate, such as ETOPS (Extended-range Twin-engine Operational Performance Standards), RNAV (Area Navigation), CAT III (Category III precision approach), or other advanced operational authorizations.',
    `permit_conditions` STRING COMMENT 'Specific conditions, limitations, or restrictions attached to the certificate or permit. May include frequency caps, capacity limits, seasonal restrictions, or operational constraints.',
    `regulatory_contact_email` STRING COMMENT 'Email address of the primary regulatory contact at the issuing authority for correspondence related to this certificate.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `regulatory_contact_name` STRING COMMENT 'Name of the primary regulatory contact or inspector assigned to this certificate at the issuing authority.',
    `regulatory_contact_phone` STRING COMMENT 'Phone number of the primary regulatory contact at the issuing authority.',
    `renewal_status` STRING COMMENT 'Current status of the certificate renewal process. Indicates whether renewal is not required, pending, in progress, approved, or denied.. Valid values are `not_required|pending|in_progress|approved|denied`',
    `revocation_reason` STRING COMMENT 'Reason for revocation of the operating certificate, if applicable. Includes serious safety violations, non-compliance, or voluntary surrender.',
    `route_market_coverage` STRING COMMENT 'Geographic route and market coverage authorized by this certificate or permit. May include specific city pairs, regions, or global coverage depending on certificate type.',
    `scope_of_operations` STRING COMMENT 'Detailed description of the operational scope authorized under this certificate, including aircraft types, route categories, passenger/cargo operations, and any operational limitations.',
    `suspension_reason` STRING COMMENT 'Reason for suspension of the operating certificate, if applicable. Includes regulatory findings, safety concerns, or administrative issues.',
    `traffic_rights_type` STRING COMMENT 'Type of traffic rights granted under bilateral air service agreements, classified by the nine freedoms of the air. Not applicable for domestic AOCs. [ENUM-REF-CANDIDATE: first_freedom|second_freedom|third_freedom|fourth_freedom|fifth_freedom|sixth_freedom|seventh_freedom|eighth_freedom|ninth_freedom|not_applicable — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_operating_certificate PRIMARY KEY(`operating_certificate_id`)
) COMMENT 'Master record of all operating certificates, authorizations, foreign carrier permits, and international traffic rights held by the airline — including Air Operator Certificate (AOC), FAA Part 121 Operating Certificate, EASA AOC, foreign carrier permits, bilateral air service agreement (ASA) entitlements, freedom of the air traffic rights, and country-specific operating licenses. Captures certificate/permit number, issuing authority, type (domestic AOC, foreign carrier permit, bilateral entitlement, exemption, traffic right), jurisdiction, scope of operations, route/market coverage, traffic rights type (1st through 9th freedom) where applicable, permit conditions, issue date, expiry date, renewal status, and conditions or limitations. SSOT for the airlines complete portfolio of legal authority to operate domestically and internationally.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`operational_approval` (
    `operational_approval_id` BIGINT COMMENT 'Unique identifier for the operational approval record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: ETOPS, RNP, CAT III approvals require named accountable managers per regulatory requirements. FK enables verification of manager authority, succession planning for critical approvals, and regulatory a',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: ETOPS, RNP, and CAT III approvals have application fees and audit costs. Airlines allocate operational approval expenses to cost centres for flight operations budget tracking and variance analysis.',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Each operational approval (ETOPS, RNAV, CAT III) is granted by a specific authority. FK normalizes authority reference. Column removal: issuing_authority and issuing_authority_country_code are redunda',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: ETOPS, RNP, and CAT-III approvals are granted for specific routes. Flight operations must verify approval validity before dispatch. Critical for operational control and regulatory audit trails. Remove',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Operational approvals (ETOPS alternates, CAT-III, RNP-AR) are station-specific due to infrastructure requirements (ILS category, navigation aids, rescue/firefighting). Route planning and dispatch requ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Operational approvals (ETOPS, RNP, CAT III) often require vendor-specific qualifications (e.g., approved MRO for ETOPS maintenance, certified avionics supplier for RNP). Airlines must track which vend',
    `aircraft_registration` STRING COMMENT 'Specific aircraft registration (tail number) to which this approval applies, if the approval is aircraft-specific rather than fleet-wide. Nullable for fleet-level approvals.. Valid values are `^[A-Z0-9-]{5,10}$`',
    `aircraft_type_icao_code` STRING COMMENT 'ICAO aircraft type designator code for which this operational approval is granted (e.g., B77W for Boeing 777-300ER, A359 for Airbus A350-900). May be null if approval applies to multiple types.. Valid values are `^[A-Z0-9]{3,4}$`',
    `approval_conditions` STRING COMMENT 'Detailed text description of any conditions, limitations, or operational restrictions attached to this approval by the issuing authority (e.g., crew qualification requirements, maintenance program requirements, operational procedures).',
    `approval_document_url` STRING COMMENT 'URL or file path to the official approval document, certificate, or letter of authorization issued by the regulatory authority.',
    `approval_number` STRING COMMENT 'Externally-known unique reference number or code assigned by the issuing authority to this operational approval (e.g., ETOPS approval number, CAT III authorization number).. Valid values are `^[A-Z0-9]{6,20}$`',
    `approval_status` STRING COMMENT 'Current lifecycle status of the operational approval indicating whether it is in force, suspended, expired, or revoked.. Valid values are `active|suspended|expired|revoked|pending|withdrawn`',
    `approval_type` STRING COMMENT 'Type or category of operational approval granted. [ENUM-REF-CANDIDATE: ETOPS|CAT_II|CAT_III|RVSM|RNP|RNAV|PBN|LVO|MNPS|NAT_HLA|EDTO — promote to reference product]. Valid values are `ETOPS|CAT_II|CAT_III|RVSM|RNP|RNAV`',
    `compliance_program_reference` STRING COMMENT 'Reference to the airlines internal compliance program, operations manual section, or training program that supports this operational approval (e.g., Operations Manual Part B Section 8.3).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this operational approval record was first created in the system.',
    `decision_height_feet` STRING COMMENT 'Minimum decision height (DH) or decision altitude (DA) in feet authorized for precision approaches under this approval (e.g., 100 feet for CAT II). Applicable to CAT II/III approvals.',
    `effective_date` DATE COMMENT 'Date on which the operational approval becomes effective and the airline is authorized to conduct operations under this approval.',
    `etops_diversion_time_minutes` STRING COMMENT 'Maximum diversion time in minutes authorized for ETOPS operations (e.g., 120, 180, 207, 330 minutes). Applicable only to ETOPS approvals; null for other approval types.',
    `expiry_date` DATE COMMENT 'Date on which the operational approval expires and is no longer valid unless renewed. Nullable for approvals without expiration.',
    `last_audit_date` DATE COMMENT 'Date of the most recent regulatory audit or inspection conducted by the issuing authority to verify continued compliance with this operational approval.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this operational approval record was last updated or modified in the system.',
    `maintenance_program_reference` STRING COMMENT 'Reference to the specific maintenance program or MEL (Minimum Equipment List) provisions required to support this operational approval (e.g., ETOPS maintenance program, CAT III equipment maintenance).',
    `minimum_visibility_meters` STRING COMMENT 'Minimum runway visual range (RVR) or visibility in meters authorized for low-visibility operations under this approval (e.g., 75m for CAT IIIb). Applicable to CAT II/III and LVO approvals.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next regulatory audit or inspection required to maintain this operational approval.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or context regarding this operational approval that do not fit into structured fields.',
    `renewal_frequency_months` STRING COMMENT 'Frequency in months at which this approval must be renewed (e.g., 12, 24, 36 months). Applicable only if renewal_required_flag is true; null otherwise.',
    `renewal_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this approval requires periodic renewal (true) or is granted indefinitely subject to continued compliance (false).',
    `rnp_specification` STRING COMMENT 'RNP specification level authorized (e.g., RNP 10, RNP 4, RNP 1, RNP 0.3, RNP AR APCH). Applicable to RNP/RNAV approvals; null for other types.',
    `training_requirement_description` STRING COMMENT 'Description of specific crew training requirements mandated for operations under this approval (e.g., ETOPS-specific training, CAT III simulator training, RNP AR approach training).',
    CONSTRAINT pk_operational_approval PRIMARY KEY(`operational_approval_id`)
) COMMENT 'Master record of specific operational approvals and authorizations granted to the airline beyond the base AOC, including ETOPS (Extended-range Twin-engine Operational Performance Standards) approvals, CAT II/III ILS approach authorizations, RNAV/RNP navigation specifications, RVSM (Reduced Vertical Separation Minimum), PBN (Performance-Based Navigation), and low-visibility operations. Captures approval type, issuing authority, applicable aircraft types, route or airspace scope, approval conditions, effective and expiry dates, and renewal requirements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` (
    `ad_compliance_record_id` BIGINT COMMENT 'Unique identifier for the AD compliance record tracking the compliance status of a specific Airworthiness Directive for a specific aircraft.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Airworthiness Directive compliance generates vendor invoices for parts and labor. Airlines must match AD work orders to AP invoices, track compliance costs per aircraft, and reconcile against maintena',
    `aircraft_id` BIGINT COMMENT 'Reference to the specific aircraft for which this AD compliance is being tracked.',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Each AD compliance record is under the jurisdiction of a specific authority (FAA, EASA). FK normalizes authority reference. Column removal: regulatory_authority (string) is redundant.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: AD compliance often involves vendor-supplied parts or services. Airlines must track which vendor provided the compliant part/service for warranty claims, liability tracking, and future sourcing decisi',
    `ad_number` STRING COMMENT 'The official regulatory AD number issued by the aviation authority (e.g., FAA AD 2023-15-08, EASA AD 2023-0142).. Valid values are `^[A-Z0-9-]+$`',
    `aircraft_cycles_at_compliance` STRING COMMENT 'Total flight cycles accumulated by the aircraft at the time compliance was achieved.',
    `aircraft_hours_at_compliance` DECIMAL(18,2) COMMENT 'Total flight hours accumulated by the aircraft at the time compliance was achieved.',
    `amoc_approval_number` STRING COMMENT 'The regulatory approval number for an Alternative Method of Compliance if one was used instead of the standard AD compliance method.',
    `amoc_approved_flag` BOOLEAN COMMENT 'Indicates whether an Alternative Method of Compliance has been approved by the regulatory authority for this AD compliance.',
    `applicability_status` STRING COMMENT 'Indicates whether this AD is applicable to the specific aircraft based on model, serial number, configuration, and installed components.. Valid values are `applicable|not_applicable|conditionally_applicable`',
    `certifying_mechanic_license` STRING COMMENT 'The license number of the certified aircraft mechanic or engineer who certified the AD compliance work.',
    `certifying_organization` STRING COMMENT 'The name of the maintenance organization (MRO or internal maintenance) that performed and certified the AD compliance work.',
    `compliance_cost_amount` DECIMAL(18,2) COMMENT 'The total cost incurred to achieve compliance with this AD, including labor, parts, and overhead.',
    `compliance_cost_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for the compliance cost amount.. Valid values are `^[A-Z]{3}$`',
    `compliance_date` DATE COMMENT 'The date on which compliance with the AD was achieved for this aircraft.',
    `compliance_documentation_reference` STRING COMMENT 'Reference to the physical or digital documentation (logbook entry, maintenance record, certificate) that provides evidence of AD compliance.',
    `compliance_interval_cycles` STRING COMMENT 'For recurring ADs, the interval in flight cycles between required compliance actions.',
    `compliance_interval_days` STRING COMMENT 'For recurring ADs, the calendar interval in days between required compliance actions.',
    `compliance_interval_hours` DECIMAL(18,2) COMMENT 'For recurring ADs, the interval in flight hours between required compliance actions.',
    `compliance_method` STRING COMMENT 'The method used to achieve compliance with the AD (e.g., inspection, part replacement, modification, operational limitation).. Valid values are `inspection|modification|replacement|operational_limitation|alternative_method|terminating_action`',
    `compliance_status` STRING COMMENT 'Current compliance status of the AD for this aircraft indicating whether the directive has been satisfied, is in progress, or requires action.. Valid values are `compliant|non_compliant|in_progress|not_applicable|deferred|pending_inspection`',
    `corrective_action_taken` STRING COMMENT 'Description of the corrective actions taken to achieve compliance with the AD, including parts replaced, modifications performed, or operational limitations imposed.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this AD compliance record was first created in the system.',
    `deferral_authorization_number` STRING COMMENT 'The regulatory authorization number if compliance with the AD has been deferred under approved conditions.',
    `deferral_expiry_date` DATE COMMENT 'The date by which a deferred AD must be complied with, as specified in the deferral authorization.',
    `due_date` DATE COMMENT 'The regulatory deadline by which the AD must be complied with, calculated based on effective date and compliance time requirements.',
    `inspection_findings` STRING COMMENT 'Detailed findings from the inspection or compliance action, including any discrepancies, defects, or observations noted during the work.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this AD compliance record was last modified or updated.',
    `next_action_due_date` DATE COMMENT 'For recurring ADs, the date by which the next compliance action (inspection, check, etc.) is due.',
    `parts_replaced` STRING COMMENT 'List of aircraft parts or components that were replaced as part of the AD compliance action, including part numbers and serial numbers.',
    `record_source_system` STRING COMMENT 'The name of the source operational system from which this AD compliance record originated (e.g., AMOS, SAP PM).',
    `remarks` STRING COMMENT 'Additional remarks, notes, or comments related to the AD compliance, including special conditions, deviations, or clarifications.',
    `service_bulletin_reference` STRING COMMENT 'Reference to the manufacturer service bulletin that was used to comply with the AD, if applicable.',
    `terminating_action_flag` BOOLEAN COMMENT 'Indicates whether a terminating action has been performed that eliminates the need for recurring compliance with this AD.',
    `work_order_number` STRING COMMENT 'The maintenance work order number under which the AD compliance work was performed.. Valid values are `^[A-Z0-9-]+$`',
    CONSTRAINT pk_ad_compliance_record PRIMARY KEY(`ad_compliance_record_id`)
) COMMENT 'Transactional record tracking compliance status of each Airworthiness Directive for each applicable aircraft, referencing the authoritative AD master in the maintenance domain via FK';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`regulatory_filing` (
    `regulatory_filing_id` BIGINT COMMENT 'Unique identifier for the regulatory filing record. Primary key.',
    `ask_plan_id` BIGINT COMMENT 'Foreign key linking to route.ask_plan. Business justification: Capacity plans (ASK forecasts) are filed with bilateral authorities for frequency/capacity entitlement compliance under restrictive ASAs. International planning teams submit capacity declarations. Ess',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Regulatory filings incur costs (legal fees, consulting, staff time) that must be allocated to cost centers. This FK enables cost tracking and budgeting for compliance activities.',
    `parent_filing_regulatory_filing_id` BIGINT COMMENT 'Reference to the original filing record if this is a resubmission or amendment, establishing lineage between related filings.',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Each filing is submitted to a specific regulatory authority. FK normalizes authority reference. Column removal: regulatory_authority_code (string) is redundant with regulatory_authority.authority_code',
    `schedule_season_id` BIGINT COMMENT 'Foreign key linking to route.schedule_season. Business justification: IATA schedule coordination filings, slot return declarations, and capacity reports are submitted per schedule season. Regulatory affairs teams track filing deadlines by season. Essential for IATA coor',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Many regulatory filings are station-specific: DOT T-100 segment data, environmental reports, noise monitoring, passenger facility charge reports, local authority compliance submissions. Finance and re',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Airlines file regulatory reports about vendor performance, safety incidents, and operational issues with suppliers (e.g., DOT vendor incident reports, EASA Part 145 compliance filings). Tracking the v',
    `acceptance_date` DATE COMMENT 'Date on which the regulatory authority formally accepted the filing as complete and compliant, closing the submission cycle.',
    `acknowledgment_date` DATE COMMENT 'Date on which the regulatory authority acknowledged receipt of the filing, confirming successful submission.',
    `amendment_flag` BOOLEAN COMMENT 'Indicates whether this filing is an amendment or correction to a previously submitted filing (true) or an original submission (false).',
    `compliance_quarter` STRING COMMENT 'Fiscal quarter (1-4) to which this filing applies, used for quarterly regulatory reporting requirements such as DOT Form 41.',
    `compliance_year` STRING COMMENT 'Calendar or fiscal year to which this filing applies for compliance tracking and historical reporting purposes.',
    `confidential_flag` BOOLEAN COMMENT 'Indicates whether the filing contains confidential business information or sensitive safety data subject to restricted disclosure under regulatory protection (true) or is public record (false).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory filing record was first created in the compliance management system, establishing audit trail inception.',
    `department_code` STRING COMMENT 'Code identifying the internal department or business unit responsible for preparing the filing (e.g., Safety, Finance, Operations, Environmental Compliance).',
    `document_count` STRING COMMENT 'Number of supporting documents, attachments, or exhibits included with the regulatory filing submission.',
    `document_storage_path` STRING COMMENT 'File system path or cloud storage URI where the complete filing package and supporting documents are archived for audit and retrieval.',
    `due_date` DATE COMMENT 'Regulatory deadline by which the filing must be submitted to the authority to maintain compliance. Used for tracking on-time submission performance.',
    `filing_description` STRING COMMENT 'Detailed narrative description of the filing content, scope, and context. May include summary of reported data, incident details, or compliance statement.',
    `filing_reference_number` STRING COMMENT 'External reference number or confirmation number assigned by the regulatory authority upon submission (e.g., DOT filing confirmation number, FAA submission ID, EASA occurrence report number).',
    `filing_status` STRING COMMENT 'Current lifecycle status of the regulatory filing in the submission and approval workflow (draft, submitted, under review by authority, accepted, rejected, resubmission required).. Valid values are `draft|submitted|under_review|accepted|rejected|resubmission_required`',
    `filing_title` STRING COMMENT 'Descriptive title or subject line of the regulatory filing, providing human-readable identification of the submission content and purpose.',
    `filing_type` STRING COMMENT 'Classification of the regulatory filing by form type and purpose. Identifies the specific regulatory report or submission category (e.g., DOT Form 41 financial filing, FAA accident/incident report, EASA occurrence report, CORSIA emissions report, noise abatement filing, slot coordination filing). [ENUM-REF-CANDIDATE: DOT_Form_41_Financial|FAA_Accident_Report|FAA_Incident_Report|EASA_Occurrence_Report|DOT_Consumer_Protection_Report|CORSIA_Emissions_Report|Noise_Abatement_Filing|Slot_Coordination_Filing|Airworthiness_Directive_Response|ETOPS_Approval_Filing|CAT_III_Approval_Filing|Environmental_Impact_Report|Safety_Management_System_Report|Crew_Duty_Time_Report|Dangerous_Goods_Incident_Report — promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this regulatory filing record, tracking changes through the filing lifecycle for audit and compliance verification.',
    `rejection_date` DATE COMMENT 'Date on which the regulatory authority rejected the filing due to incompleteness, errors, or non-compliance, requiring resubmission.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the regulatory authority for rejecting the filing, including specific deficiencies or required corrections.',
    `remarks` STRING COMMENT 'Additional notes, comments, or context provided by the compliance team regarding the filing preparation, submission, or follow-up actions.',
    `reporting_period_end_date` DATE COMMENT 'End date of the period covered by this regulatory filing. Defines the temporal scope of data included in the submission.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the period covered by this regulatory filing (e.g., beginning of fiscal quarter for DOT Form 41, start of emissions reporting period for CORSIA).',
    `responsible_officer_email` STRING COMMENT 'Email address of the compliance officer responsible for this filing, used for regulatory authority correspondence and internal audit trail.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `responsible_officer_name` STRING COMMENT 'Full name of the compliance officer or authorized signatory responsible for preparing and submitting this regulatory filing.',
    `responsible_officer_phone` STRING COMMENT 'Contact phone number for the compliance officer responsible for this filing, enabling regulatory authority follow-up and internal coordination.',
    `resubmission_due_date` DATE COMMENT 'Deadline by which a corrected filing must be resubmitted following rejection, as specified by the regulatory authority.',
    `submission_date` DATE COMMENT 'Date on which the filing was officially submitted to the regulatory authority. Represents the business event timestamp for the filing transaction.',
    `submission_method` STRING COMMENT 'Channel or mechanism used to transmit the filing to the regulatory authority (electronic portal, email, postal mail, fax, API integration).. Valid values are `electronic_portal|email|postal_mail|fax|API`',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp (date and time with timezone) when the filing was transmitted to the regulatory authority, capturing exact submission moment for audit trail and compliance verification.',
    CONSTRAINT pk_regulatory_filing PRIMARY KEY(`regulatory_filing_id`)
) COMMENT 'Transactional record of all regulatory filings, submissions, and reports submitted to governing authorities — including DOT Form 41 financial filings, FAA accident/incident reports, EASA occurrence reports, DOT consumer protection reports, CORSIA emissions reports, noise abatement filings, and slot coordination filings. Captures filing type, target authority, submission date, reporting period, filing status (draft, submitted, accepted, rejected), submission reference number, and responsible compliance officer.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`obligation_register` (
    `obligation_register_id` BIGINT COMMENT 'Primary key for obligation_register',
    `audit_id` BIGINT COMMENT 'Foreign key reference to the audit or inspection event that verified compliance with this obligation, if applicable.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee assigned as the accountable owner for ensuring this obligation is met.',
    `regulatory_authority_id` BIGINT COMMENT 'FK to compliance.regulatory_authority',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key reference to the specific regulatory requirement that this obligation fulfills. Links to the external regulatory mandate.',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Compliance obligations frequently stem from contractual commitments in supply agreements (e.g., sustainability reporting requirements, insurance obligations, SLA compliance). Airlines track which cont',
    `training_course_id` BIGINT COMMENT 'Foreign key reference to the training program that fulfills this obligation, if applicable.',
    `applicable_aircraft_type` STRING COMMENT 'Specific aircraft type or model to which this obligation applies (e.g., B737, A320, B787). Null if obligation applies to all aircraft or is not aircraft-specific.',
    `applicable_operation_type` STRING COMMENT 'Type of flight operation to which this obligation applies (e.g., ETOPS (Extended-range Twin-engine Operational Performance Standards), RNAV (Area Navigation), CAT III (Category III precision approach), cargo, passenger). Null if applies to all operations.',
    `completion_date` DATE COMMENT 'The actual date when the compliance obligation was fulfilled. Null if not yet completed.',
    `compliance_method` STRING COMMENT 'Description of the method or process used to achieve compliance with this obligation (e.g., automated reporting, manual inspection, third-party audit, training program).',
    `compliance_owner_department` STRING COMMENT 'The department or business unit responsible for managing and fulfilling this compliance obligation (e.g., Flight Operations, Safety, Maintenance, Legal).',
    `compliance_status` STRING COMMENT 'Current status of the obligation: pending (not yet started), in_progress (work underway), compliant (requirement met), non_compliant (requirement not met), waived (exemption granted), overdue (past due date without completion).. Valid values are `pending|in_progress|compliant|non_compliant|waived|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance obligation record was first created in the system.',
    `due_date` DATE COMMENT 'The date by which this compliance obligation must be fulfilled to meet regulatory requirements.',
    `emissions_reporting_period` STRING COMMENT 'The reporting period for environmental emissions obligations (e.g., Q1 2024, FY2024). Applicable only for environmental compliance obligations.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this obligation relates to environmental compliance requirements such as CORSIA (Carbon Offsetting and Reduction Scheme for International Aviation) emissions reporting or carbon offset records (True if environmental, False otherwise).',
    `escalation_date` DATE COMMENT 'The date when this obligation was escalated due to non-compliance or high risk. Null if not escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this obligation has been escalated to senior management or regulatory authorities due to non-compliance or risk (True if escalated, False otherwise).',
    `evidence_location` STRING COMMENT 'Physical or digital location where compliance evidence is stored (e.g., document management system path, file server location, archive reference).',
    `evidence_reference` STRING COMMENT 'Reference to the documentation, records, or artifacts that serve as evidence of compliance (e.g., document ID, file path, audit report number).',
    `jurisdiction` STRING COMMENT 'Three-letter ISO country code representing the jurisdiction where this obligation applies (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance obligation record was last updated or modified.',
    `last_review_date` DATE COMMENT 'The date when this obligation was last reviewed or assessed for compliance status.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review or reassessment of this compliance obligation.',
    `non_compliance_impact` STRING COMMENT 'Description of the potential consequences if this obligation is not met (e.g., fines, operational restrictions, certificate suspension, reputational damage).',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context regarding this compliance obligation.',
    `obligation_description` STRING COMMENT 'Detailed description of the compliance obligation, including what must be done to satisfy the regulatory requirement.',
    `obligation_reference_number` STRING COMMENT 'Business-readable unique reference number for this compliance obligation, used for tracking and reporting purposes.. Valid values are `^OBL-[A-Z0-9]{8,12}$`',
    `obligation_title` STRING COMMENT 'Short descriptive title of the compliance obligation, summarizing the requirement being tracked.',
    `obligation_type` STRING COMMENT 'Classification of the obligation by its nature: operational compliance, regulatory reporting, certification maintenance, mandatory training, audit requirement, environmental compliance, or safety compliance. [ENUM-REF-CANDIDATE: operational|reporting|certification|training|audit|environmental|safety — 7 candidates stripped; promote to reference product]',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty or fine amount (in USD) that may be imposed for non-compliance with this obligation.',
    `recurrence_frequency` STRING COMMENT 'How often this obligation must be fulfilled: one_time (single occurrence), daily, weekly, monthly, quarterly, annually, or biennial. [ENUM-REF-CANDIDATE: one_time|daily|weekly|monthly|quarterly|annually|biennial — 7 candidates stripped; promote to reference product]',
    `risk_rating` STRING COMMENT 'Risk severity rating if this obligation is not met: critical (severe operational or regulatory impact), high (significant impact), medium (moderate impact), low (minor impact).. Valid values are `critical|high|medium|low`',
    `training_requirement_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this obligation involves mandatory regulatory training requirements (True if training-related, False otherwise). Examples include dangerous goods, security awareness, human trafficking, fatigue risk, SMS (Safety Management System), GDPR (General Data Protection Regulation) training.',
    `waiver_expiry_date` DATE COMMENT 'The date when the granted waiver or exemption expires and the obligation becomes enforceable again.',
    `waiver_granted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a regulatory waiver or exemption has been granted for this obligation (True if waived, False otherwise).',
    `waiver_reference_number` STRING COMMENT 'Official reference number of the regulatory waiver or exemption document, if applicable.',
    CONSTRAINT pk_obligation_register PRIMARY KEY(`obligation_register_id`)
) COMMENT 'Operational tracking record linking a specific regulatory requirement to the airlines internal compliance program, serving as the airlines compliance register and accountability bridge. Captures the assigned compliance owner, due date, compliance method, current status (pending, in-progress, compliant, non-compliant, waived), evidence reference, last review date, next review date, and risk rating. Also tracks training compliance obligations at the program level — whether mandatory regulatory training requirements (dangerous goods, security awareness, human trafficking, fatigue risk, SMS, GDPR) are being met across the organization. This is the bridge between external regulatory requirements and internal accountability — the SSOT for what the airline owes and whether it is meeting those obligations.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`audit_program` (
    `audit_program_id` BIGINT COMMENT 'Unique identifier for the audit program. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each audit program (SMS, quality, security) requires an accountable owner per ISO 19011. FK enables verification of owner authority, succession planning, workload distribution, and accountability for ',
    `applicable_jurisdictions` STRING COMMENT 'Comma-separated list of countries, regions, or regulatory jurisdictions where this audit program applies or is recognized (e.g., USA, EU, ICAO Member States, Global).',
    `audit_authority` STRING COMMENT 'The regulatory body, certification authority, or internal department responsible for conducting or overseeing the audit program (e.g., FAA, EASA, IATA, National CAA, Internal Audit Department).',
    `audit_cycle_frequency` STRING COMMENT 'The recurring frequency or cycle at which audits under this program are conducted (annual, every two years, every three years, quarterly, continuous surveillance, triggered by specific events, or ad-hoc as needed). [ENUM-REF-CANDIDATE: annual|biennial|triennial|quarterly|continuous|event_driven|ad_hoc — 7 candidates stripped; promote to reference product]',
    `audit_duration_days` STRING COMMENT 'The typical or expected duration in days for a single audit event under this program.',
    `audit_methodology` STRING COMMENT 'The primary methodology or approach used to conduct audits under this program (on-site inspection, remote audit, hybrid, document review, continuous surveillance, statistical sampling, continuous monitoring). [ENUM-REF-CANDIDATE: onsite|remote|hybrid|document_review|surveillance|sampling|continuous_monitoring — 7 candidates stripped; promote to reference product]',
    `audit_type` STRING COMMENT 'Classification of the audit program by its primary purpose and scope (regulatory oversight, internal quality assurance, certification, compliance verification, safety management, operational performance, financial controls, environmental compliance). [ENUM-REF-CANDIDATE: regulatory|internal|certification|compliance|safety|quality|operational|financial|environmental — 9 candidates stripped; promote to reference product]',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether successful completion of this audit program results in or is required for a formal certification, approval, or operational authorization (true) or is for compliance monitoring only (false).',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether this audit program mandates formal corrective action plans for identified findings (true) or is advisory only (false).',
    `coverage_areas` STRING COMMENT 'Comma-separated list or structured enumeration of specific operational domains and functional areas covered by the audit program (e.g., Flight Operations, Maintenance, Crew Training, Ground Operations, Cargo, Safety Management, Security, Environmental).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit program record was first created in the system.',
    `cycle_duration_months` STRING COMMENT 'The duration in months of one complete audit cycle for this program (e.g., 24 months for IOSA biennial cycle, 12 months for annual internal audits).',
    `finding_classification_scheme` STRING COMMENT 'The classification or severity scheme used to categorize audit findings under this program (e.g., Critical, Major, Minor, Observation; or Level 1, Level 2, Level 3).',
    `governing_standard` STRING COMMENT 'The primary regulatory standard, framework, or regulation that defines the requirements and scope of this audit program (e.g., IOSA Standards Manual, FAA Part 121, EASA Part-ORO, ISO 9001, CORSIA SARPs).',
    `last_audit_completion_date` DATE COMMENT 'The date on which the most recent audit under this program was completed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit program record was last updated or modified.',
    `next_audit_due_date` DATE COMMENT 'The scheduled date by which the next audit under this program must be completed to maintain compliance or certification.',
    `program_code` STRING COMMENT 'Unique business identifier code for the audit program (e.g., IOSA-2024, FAA-ATOS-01, EASA-STD-2023).. Valid values are `^[A-Z0-9]{4,12}$`',
    `program_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated annual or per-cycle cost to the airline for participation in this audit program, including audit fees, preparation costs, and corrective action implementation. Business-confidential financial data.',
    `program_effective_date` DATE COMMENT 'The date on which this audit program became effective and applicable to the airline.',
    `program_expiry_date` DATE COMMENT 'The date on which this audit program expires or is scheduled for renewal, if applicable. Null for ongoing programs without expiry.',
    `program_name` STRING COMMENT 'Full descriptive name of the audit program (e.g., IATA Operational Safety Audit, FAA Air Transportation Oversight System, EASA Standardization Inspection).',
    `program_notes` STRING COMMENT 'Free-text field for additional notes, special conditions, historical context, or operational guidance related to this audit program.',
    `program_status` STRING COMMENT 'Current lifecycle status of the audit program indicating whether it is actively in force, temporarily suspended, under review for changes, pending regulatory approval, or archived.. Valid values are `active|inactive|suspended|under_review|pending_approval|archived`',
    `public_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether audit results or certification status under this program must be publicly disclosed or reported to external stakeholders (true) or remain confidential (false).',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether participation in this audit program is mandated by regulatory authority (true) or is voluntary/internal (false).',
    `scope_description` STRING COMMENT 'Detailed description of the operational areas, processes, systems, and functions covered by this audit program (e.g., flight operations, maintenance, ground handling, crew training, safety management systems, environmental compliance).',
    CONSTRAINT pk_audit_program PRIMARY KEY(`audit_program_id`)
) COMMENT 'Master record defining the airlines regulatory and internal audit programs, including IOSA (IATA Operational Safety Audit), FAA ATOS (Air Transportation Oversight System) audits, EASA standardization inspections, DOT compliance audits, and internal quality audits. Captures program name, audit type, governing standard, audit cycle frequency, scope of coverage, responsible audit authority, and program status. SSOT for what audit programs the airline participates in or is subject to.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`audit_event` (
    `audit_event_id` BIGINT COMMENT 'Unique identifier for the audit event. Primary key for the audit event record.',
    `audit_program_id` BIGINT COMMENT 'Reference to the parent audit program under which this event was conducted.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Audits target specific organizational units for compliance verification. FK enables audit coverage analysis, resource planning, finding aggregation by department, and regulatory reporting of departmen',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: External regulatory audits generate costs (auditor fees, travel, accommodation) allocated to cost centres. Airlines track audit expenses by department for compliance program budget management and cost',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Internal audits (SMS, quality, safety) require qualified lead auditors. FK enables verification of auditor competency, training currency, independence requirements, and audit assignment workload balan',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Compliance audits frequently audit vendors (Part 145 MRO stations, catering suppliers, ground handlers, fuel suppliers). Airlines must track which vendor was audited for audit program management, vend',
    `actual_end_date` DATE COMMENT 'Actual date the audit event fieldwork concluded. For single-day audits, this equals actual start date.',
    `actual_start_date` DATE COMMENT 'Actual date the audit event commenced. May differ from scheduled date due to operational changes or auditor availability.',
    `aircraft_registration` STRING COMMENT 'Tail number or registration of the specific aircraft audited or inspected, if the audit was aircraft-specific (e.g., FAA ramp inspection, airworthiness review). Null if audit was not aircraft-specific.',
    `aircraft_type` STRING COMMENT 'ICAO aircraft type designator for the aircraft audited (e.g., B738 for Boeing 737-800, A320 for Airbus A320). Null if audit was not aircraft-specific.',
    `assessment_rating` STRING COMMENT 'Quantitative or qualitative rating assigned to the audit event, if applicable. May be numeric score (e.g., 85/100), letter grade (A, B, C), or maturity level (Level 1-5). Format varies by audit program and auditing body.',
    `audit_duration_days` STRING COMMENT 'Total number of calendar days the audit event spanned from actual start date to actual end date, inclusive. For single-day audits, value is 1.',
    `audit_location_code` STRING COMMENT 'IATA (International Air Transport Association) or ICAO (International Civil Aviation Organization) airport code, or internal facility code identifying the specific location audited (e.g., JFK, EGLL, MIA-MX1 for Miami maintenance base).',
    `audit_location_type` STRING COMMENT 'Classification of the physical location where the audit was conducted. Station refers to airport operational locations. Hub refers to major connecting airports. Maintenance base refers to MRO (Maintenance Repair and Overhaul) facilities. Headquarters refers to corporate offices. Training center refers to crew training facilities. Cargo facility refers to freight handling locations. Remote site refers to outstations or line stations. [ENUM-REF-CANDIDATE: station|hub|maintenance_base|headquarters|training_center|cargo_facility|remote_site — 7 candidates stripped; promote to reference product]',
    `audit_notes` STRING COMMENT 'Free-text field for additional notes, context, or observations about the audit event. May include special circumstances, auditor comments, or operational context relevant to the audit.',
    `audit_report_issued_date` DATE COMMENT 'Date the formal audit report was issued or published to stakeholders. Typically follows completion of fieldwork and report review process.',
    `audit_report_reference` STRING COMMENT 'Document reference number or identifier for the formal audit report issued for this event. Used to link to document management system or audit report repository.',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope, including functional areas, processes, standards, or regulations covered. Examples: Flight Operations and Maintenance for IOSA, Ramp Safety and Ground Handling for FAA ramp inspection, Consumer Protection Compliance for DOT review, SMS implementation for internal audit.',
    `auditing_body` STRING COMMENT 'Name of the external organization or internal department conducting the audit. Examples: IATA (International Air Transport Association) for IOSA audits, FAA (Federal Aviation Administration) for ramp inspections, EASA (European Union Aviation Safety Agency) for standardization visits, DOT (Department of Transportation) for consumer compliance, internal Quality Assurance department, third-party certification bodies.',
    `auditor_team_size` STRING COMMENT 'Total number of auditors or inspectors on the audit team, including lead auditor, co-auditors, technical experts, and observers.',
    `certification_standard` STRING COMMENT 'Name and version of the certification standard, regulatory framework, or audit protocol against which the audit was conducted. Examples: IOSA Standards Manual Edition 14, ISO 9001:2015, FAA 14 CFR Part 121, EASA Part-ORO, SMS (Safety Management System) ICAO Annex 19.',
    `compliance_gaps_identified` STRING COMMENT 'Summary description of key compliance gaps, deficiencies, or areas of non-conformance identified during the audit. Provides high-level overview of systemic issues or recurring themes across findings.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which all corrective actions resulting from audit findings must be completed and verified. Null if no corrective action required.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean indicator whether formal corrective action plan is required as a result of this audit event. True indicates corrective actions must be documented and tracked. False indicates no formal corrective action required (audit passed or only minor observations).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit event record was first created in the system. Audit trail for data governance.',
    `critical_findings_count` STRING COMMENT 'Number of critical or major findings requiring immediate corrective action. Critical findings typically indicate significant safety risk, regulatory non-compliance, or system failure.',
    `event_number` STRING COMMENT 'Business identifier for the audit event, typically formatted as program code plus sequence number (e.g., IOSA-2024-001, FAA-RAMP-2024-045).',
    `event_status` STRING COMMENT 'Current lifecycle status of the audit event. Scheduled indicates planning phase. In progress indicates active fieldwork. Completed indicates final report issued and findings closed or tracked. Cancelled indicates event did not occur. Deferred indicates postponed to future date.. Valid values are `scheduled|in_progress|completed|cancelled|deferred`',
    `event_type` STRING COMMENT 'Classification of the audit event by nature and origin. External audit includes IOSA (IATA Operational Safety Audit), third-party certifications. Regulatory inspection includes FAA ramp inspections, EASA standardization visits, DOT (Department of Transportation) consumer compliance reviews. Internal audit covers quality audits per SMS (Safety Management System). Self-assessment and gap analysis are proactive internal reviews. Readiness review prepares for upcoming regulatory or certification audits.. Valid values are `external_audit|regulatory_inspection|internal_audit|self_assessment|gap_analysis|readiness_review`',
    `follow_up_audit_required_flag` BOOLEAN COMMENT 'Boolean indicator whether a follow-up audit or surveillance visit is required to verify closure of findings and effectiveness of corrective actions. True indicates mandatory follow-up. False indicates no follow-up required.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit event record was last updated. Audit trail for data governance and change tracking.',
    `major_findings_count` STRING COMMENT 'Number of major findings or non-conformances that require corrective action within a defined timeframe but do not pose immediate critical risk.',
    `minor_findings_count` STRING COMMENT 'Number of minor findings, observations, or opportunities for improvement that do not constitute non-conformances but warrant attention.',
    `next_scheduled_audit_date` DATE COMMENT 'Planned date for the next audit event in this audit program or for this scope. For recurring audits (e.g., annual internal audits, biennial IOSA audits), this represents the next cycle. Null if no follow-up audit is scheduled.',
    `overall_outcome` STRING COMMENT 'Final assessment result of the audit event. Pass or satisfactory indicates full compliance with no major findings. Fail or unsatisfactory indicates critical non-conformances requiring immediate corrective action. Conditional indicates minor findings that must be addressed within a specified timeframe. Conforming and non-conforming are used for certification audits. [ENUM-REF-CANDIDATE: pass|fail|conditional|satisfactory|unsatisfactory|conforming|non_conforming — 7 candidates stripped; promote to reference product]',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority or national CAA (Civil Aviation Authority) with jurisdiction over this audit event. Examples: FAA (Federal Aviation Administration) for US operations, EASA (European Union Aviation Safety Agency) for EU operations, CAAC for China, DGCA for India. Null for non-regulatory audits.',
    `scheduled_date` DATE COMMENT 'Planned date for the audit event to commence. For multi-day audits, this is the start date.',
    `total_findings_count` STRING COMMENT 'Total number of findings, observations, or non-conformances identified during the audit event, across all severity levels.',
    CONSTRAINT pk_audit_event PRIMARY KEY(`audit_event_id`)
) COMMENT 'Transactional record of a specific audit, inspection, or assessment instance conducted under an audit program — including IOSA audits, FAA ramp inspections, EASA standardization visits, DOT consumer compliance reviews, internal quality audits, self-assessments, gap analyses, and regulatory readiness reviews. Captures event date, type (external audit, regulatory inspection, internal audit, self-assessment, gap analysis, readiness review), auditing body or internal team, lead auditor, scope, location, aircraft or station audited, overall outcome (pass, fail, conditional, satisfactory), number of findings, assessment rating, compliance gaps identified, and next scheduled assessment date. Each event is a distinct business occurrence with its own lifecycle from planning through closure.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`finding` (
    `finding_id` BIGINT COMMENT 'Unique identifier for the compliance finding record. Primary key for the compliance finding entity.',
    `audit_event_id` BIGINT COMMENT 'Reference to the parent audit event during which this finding was identified. Links the finding to the specific audit inspection or assessment.',
    `dangerous_goods_id` BIGINT COMMENT 'Foreign key linking to cargo.dangerous_goods. Business justification: Compliance findings from dangerous goods audits reference specific DG declarations with violations (e.g., improper labeling, documentation errors). Essential for corrective action tracking and root ca',
    `employee_id` BIGINT COMMENT 'Reference to the employee or organizational unit assigned as the owner responsible for implementing corrective action to address the finding.',
    `finding_identified_by_auditor_employee_id` BIGINT COMMENT 'Reference to the auditor or inspector who identified and documented the finding during the audit event.',
    `finding_verified_by_auditor_employee_id` BIGINT COMMENT 'Reference to the auditor or quality assurance personnel who verified the corrective action effectiveness and approved finding closure.',
    `previous_finding_id` BIGINT COMMENT 'Reference to the previous compliance finding record if this is a recurrence. Links related findings for trend analysis and corrective action effectiveness assessment.',
    `security_screening_id` BIGINT COMMENT 'Foreign key linking to cargo.security_screening. Business justification: Security compliance audits identify screening deficiencies in specific screening events (e.g., improper procedures, equipment failures). Links finding to the screening record for corrective action and',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Compliance findings are often station-specific: gate safety issue at DFW, baggage handling non-conformance at LHR, dangerous goods storage violation at FRA. Station managers need visibility to finding',
    `affected_area` STRING COMMENT 'The operational area, department, station, or functional unit where the finding was identified. Examples include maintenance hangar, flight operations, ground handling, crew scheduling, or specific airport station codes.',
    `affected_process` STRING COMMENT 'The specific business process or operational procedure affected by the finding. Examples include aircraft maintenance procedures, crew duty time tracking, baggage handling, fuel uplift procedures, or dispatch release processes.',
    `airworthiness_impact_flag` BOOLEAN COMMENT 'Boolean indicator of whether the finding affects aircraft airworthiness certification or continuing airworthiness compliance. True indicates potential impact on aircraft operational approval.',
    `applicable_regulation` STRING COMMENT 'The specific regulatory requirement, standard, or internal policy that the finding relates to. May reference FAA regulations (14 CFR parts), EASA regulations (Part-145, Part-M), ICAO Annexes, or internal Standard Operating Procedures (SOP).',
    `closure_date` DATE COMMENT 'Official date when the finding was formally closed after successful verification of corrective action effectiveness. Represents the end of the finding lifecycle.',
    `closure_notes` STRING COMMENT 'Final notes and comments documenting the closure of the finding, including verification results, lessons learned, and any residual monitoring requirements.',
    `corrective_action_completion_date` DATE COMMENT 'Actual date when the corrective action was completed and implemented. Null until corrective action is finished.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action plan developed to address the finding and prevent recurrence. Documents the specific steps, process changes, training, or system modifications to be implemented.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the corrective action must be completed. Established based on finding severity, regulatory requirements, and operational risk. May be mandated by regulatory authority for major non-conformances.',
    `finding_description` STRING COMMENT 'Detailed narrative description of the finding, including the specific non-conformance, observation, or concern identified. Documents what was observed, where it was found, and the circumstances of the discovery.',
    `finding_status` STRING COMMENT 'Current lifecycle status of the finding from identification through closure. Tracks the progression of corrective action implementation and verification. [ENUM-REF-CANDIDATE: open|under_investigation|corrective_action_assigned|corrective_action_in_progress|pending_verification|closed|reopened — 7 candidates stripped; promote to reference product]',
    `finding_type` STRING COMMENT 'Classification of the finding severity and nature. Major non-conformance requires immediate corrective action and may affect airworthiness or operational approval. Minor non-conformance requires corrective action but does not pose immediate safety risk. Observation is a noted concern without regulatory breach. Commendation recognizes exemplary compliance.. Valid values are `major_non_conformance|minor_non_conformance|observation|opportunity_for_improvement|commendation|safety_concern`',
    `identification_date` DATE COMMENT 'Date when the finding was first identified during the audit or inspection. Represents the business event timestamp for the discovery of the non-conformance or observation.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance finding record was first created in the system. Audit trail for data lineage and compliance tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance finding record was last modified. Tracks the most recent update to the finding lifecycle or corrective action status.',
    `recurrence_flag` BOOLEAN COMMENT 'Boolean indicator of whether this finding is a recurrence of a previously identified and closed finding. True indicates systemic issue requiring elevated corrective action.',
    `reference_number` STRING COMMENT 'Externally-visible unique reference number assigned to the finding for tracking and communication purposes. Used in corrective action reports and regulatory correspondence.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `regulation_section` STRING COMMENT 'Specific section, paragraph, or clause number within the applicable regulation or standard that was not met or was the subject of the finding.',
    `regulatory_notification_date` DATE COMMENT 'Date when the finding was formally reported to the applicable regulatory authority. Null if regulatory notification is not required.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the finding must be reported to regulatory authorities such as FAA, EASA, or national Civil Aviation Authority (CAA). True for findings that meet mandatory reporting thresholds.',
    `regulatory_reference_number` STRING COMMENT 'Reference number or case identifier assigned by the regulatory authority for tracking this finding. Used for correspondence and follow-up with FAA, EASA, or CAA.',
    `risk_level` STRING COMMENT 'Assessment of the safety or operational risk level associated with the finding. Critical findings may affect airworthiness or pose immediate safety hazards. Used to prioritize corrective action urgency.. Valid values are `critical|high|medium|low|negligible`',
    `root_cause_analysis` STRING COMMENT 'Detailed analysis of the underlying root cause(s) of the finding. Documents the investigation findings, contributing factors, and systemic issues that led to the non-conformance.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the underlying root cause of the finding. Used for trend analysis and systemic issue identification across the compliance program. [ENUM-REF-CANDIDATE: human_error|inadequate_training|procedure_not_followed|procedure_inadequate|equipment_failure|system_failure|resource_constraint|communication_breakdown|supervision_inadequate|documentation_error|other — 11 candidates stripped; promote to reference product]',
    `safety_impact_flag` BOOLEAN COMMENT 'Boolean indicator of whether the finding has direct safety implications for flight operations, airworthiness, or passenger/crew safety. True indicates safety-related finding requiring elevated attention.',
    `verification_date` DATE COMMENT 'Date when the corrective action effectiveness was verified and the finding was confirmed as resolved. Represents the closure verification event.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was effectively implemented and the finding has been resolved. Documents the approach taken to confirm closure. [ENUM-REF-CANDIDATE: document_review|on_site_inspection|follow_up_audit|process_observation|record_sampling|interview|other — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_finding PRIMARY KEY(`finding_id`)
) COMMENT 'Transactional record of individual findings, observations, and non-conformances identified during an audit event. Captures finding reference number, finding type (major non-conformance, minor non-conformance, observation, commendation), finding description, applicable regulatory standard or requirement, root cause category, assigned corrective action owner, corrective action due date, and finding closure status. Supports the full corrective action lifecycle from identification to closure verification.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`capa` (
    `capa_id` BIGINT COMMENT 'Unique identifier for the corrective and preventive action record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key reference to the audit record that generated this CAPA, if applicable. Links to compliance audit management system.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the CAPA owner. Links to workforce management system for accountability tracking.',
    `capa_closure_approved_by_employee_id` BIGINT COMMENT 'Employee identifier of the approver who authorized CAPA closure. Provides audit trail for closure authority.',
    `capa_verified_by_employee_id` BIGINT COMMENT 'Employee identifier of the verifier. Provides audit trail for verification accountability.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Corrective actions have cost estimates and actual costs allocated to cost centres. Airlines track CAPA expenditures by department for budget variance analysis and compliance program cost management.',
    `finding_id` BIGINT COMMENT 'Foreign key reference to the specific audit finding or non-conformance record that triggered this CAPA.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each CAPA addresses non-conformance with a specific regulatory requirement. FK links CAPA to the requirement being addressed. Column removal: regulation_reference (string) is redundant with regulatory',
    `regulatory_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_violation. Business justification: Many CAPAs are raised in response to regulatory violations (enforcement actions). FK links CAPA to the violation that triggered it. Nullable - not all CAPAs stem from violations (some from audit findi',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Corrective actions frequently address vendor performance issues (quality defects, delivery failures, safety non-conformances). Airlines must track which vendor triggered the CAPA for vendor performanc',
    `action_description` STRING COMMENT 'Detailed description of the corrective or preventive action to be taken, including specific steps, process changes, training requirements, system modifications, or procedural updates required to address the non-conformance and prevent recurrence.',
    `actual_completion_date` DATE COMMENT 'Actual date when the action was completed and submitted for verification. Null if action is still in progress.',
    `actual_cost_usd` DECIMAL(18,2) COMMENT 'Actual cost in USD incurred to implement the CAPA. Null if action is not yet complete or costs have not been finalized.',
    `assigned_owner_name` STRING COMMENT 'Full name of the individual assigned as the owner and accountable party for completing this CAPA. This is a business reference, not direct PII of a customer.',
    `capa_number` STRING COMMENT 'Business identifier for the CAPA record, typically formatted as CAPA-NNNNNN. Used for external reference and tracking.. Valid values are `^CAPA-[0-9]{6,10}$`',
    `capa_status` STRING COMMENT 'Current lifecycle status of the CAPA: open (newly created), in_progress (action being implemented), pending_verification (awaiting effectiveness check), verified (action confirmed effective), closed (completed and approved), cancelled (no longer required).. Valid values are `open|in_progress|pending_verification|verified|closed|cancelled`',
    `capa_type` STRING COMMENT 'Classification of the action: corrective (addresses existing non-conformance), preventive (prevents potential non-conformance), systemic (addresses root cause across organization), immediate (short-term containment), interim (temporary solution), or permanent (long-term resolution).. Valid values are `corrective|preventive|systemic|immediate|interim|permanent`',
    `closure_approved_by_name` STRING COMMENT 'Full name of the individual who approved the closure of the CAPA (typically Quality Manager, Compliance Manager, or Accountable Manager).',
    `closure_date` DATE COMMENT 'Date when the CAPA was formally closed after successful verification and approval. Null if CAPA is still open.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated cost in USD to implement the corrective or preventive action, including labor, materials, training, system changes, and external consulting. Used for budgeting and cost-benefit analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CAPA record was first created in the system. Audit trail for record origination.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this CAPA record was last updated. Tracks most recent change for audit and version control.',
    `non_conformance_description` STRING COMMENT 'Detailed description of the non-conformance, deficiency, violation, or gap that necessitated this CAPA. Includes what was observed, what standard was violated, and the potential or actual impact.',
    `notes` STRING COMMENT 'Free-text field for additional comments, context, lessons learned, or supplementary information related to the CAPA. Used for knowledge capture and continuous improvement.',
    `priority` STRING COMMENT 'Urgency level of the CAPA based on safety impact, regulatory risk, and operational criticality. Critical indicates immediate safety or regulatory threat.. Valid values are `critical|high|medium|low`',
    `recurrence_flag` BOOLEAN COMMENT 'Indicates whether this CAPA addresses a recurring non-conformance (True) or a first-time occurrence (False). Used to identify systemic issues requiring deeper root cause analysis.',
    `regulatory_authority` STRING COMMENT 'The governing body or national civil aviation authority that issued the requirement, violation notice, or compliance mandate triggering this CAPA. Examples: FAA (Federal Aviation Administration), EASA (European Union Aviation Safety Agency), ICAO (International Civil Aviation Organization), DOT (Department of Transportation), national CAAs. [ENUM-REF-CANDIDATE: FAA|EASA|ICAO|DOT|TSA|CAA_UK|DGCA_IN|CAAC_CN|ANAC_BR|TCCA_CA — 10 candidates stripped; promote to reference product]',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this CAPA must be reported to a regulatory authority (True) or is internal only (False). Drives external reporting and notification workflows.',
    `risk_level_after` STRING COMMENT 'Assessed risk level after the CAPA was implemented and verified. Demonstrates residual risk and effectiveness of risk mitigation.. Valid values are `critical|high|medium|low|negligible`',
    `risk_level_before` STRING COMMENT 'Assessed risk level of the non-conformance before the CAPA was implemented. Used to measure risk reduction effectiveness.. Valid values are `critical|high|medium|low|negligible`',
    `root_cause_analysis` STRING COMMENT 'Summary of the root cause investigation findings, identifying underlying systemic factors that led to the non-conformance. May reference techniques used (5 Whys, Fishbone, Fault Tree Analysis).',
    `sms_integration_flag` BOOLEAN COMMENT 'Indicates whether this CAPA is integrated with the airlines Safety Management System (SMS) for safety risk tracking and hazard management (True) or is purely a quality/compliance action (False).',
    `source_reference_number` STRING COMMENT 'External reference identifier linking this CAPA to the originating event, audit finding, violation notice, or incident report (e.g., audit report number, FAA enforcement case number, SMS occurrence ID).',
    `source_type` STRING COMMENT 'Origin of the CAPA: audit_finding (internal or external audit), regulatory_violation (FAA/EASA/DOT enforcement), safety_occurrence (SMS event), incident (operational disruption), customer_complaint, internal_inspection, or sms_report (Safety Management System report). [ENUM-REF-CANDIDATE: audit_finding|regulatory_violation|safety_occurrence|incident|customer_complaint|internal_inspection|sms_report — 7 candidates stripped; promote to reference product]',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective or preventive action must be fully implemented. Often driven by regulatory deadlines or audit response timelines.',
    `verification_date` DATE COMMENT 'Date when the effectiveness of the CAPA was verified and confirmed. Null if verification has not yet occurred.',
    `verification_method` STRING COMMENT 'Method used to verify the effectiveness of the CAPA: document_review (procedure/record review), on_site_inspection (physical verification), process_audit (follow-up audit), data_analysis (trend analysis), testing (functional test), observation (operational observation), interview (staff interviews). [ENUM-REF-CANDIDATE: document_review|on_site_inspection|process_audit|data_analysis|testing|observation|interview — 7 candidates stripped; promote to reference product]',
    `verification_result` STRING COMMENT 'Outcome of the effectiveness verification: effective (action resolved the issue), partially_effective (some improvement but further action needed), ineffective (action did not resolve issue), pending (verification not yet complete).. Valid values are `effective|partially_effective|ineffective|pending`',
    `verified_by_name` STRING COMMENT 'Full name of the individual who performed the effectiveness verification (typically Quality Assurance, Safety, or Compliance personnel).',
    CONSTRAINT pk_capa PRIMARY KEY(`capa_id`)
) COMMENT 'Transactional record tracking corrective and preventive actions (CAPAs) raised in response to audit findings, regulatory violations, safety occurrences, or internal non-conformances. Captures action description, action type (corrective, preventive, systemic), responsible department, assigned owner, target completion date, actual completion date, verification method, verification date, and closure status. Supports regulatory evidence of continuous improvement and compliance remediation.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`emissions_report` (
    `emissions_report_id` BIGINT COMMENT 'Unique identifier for the emissions report record. Primary key.',
    `manifest_id` BIGINT COMMENT 'Foreign key linking to cargo.manifest. Business justification: Emissions reports calculate CO2 based on cargo manifests (weight, distance flown). Real business need: CORSIA compliance requires accurate cargo weight data from manifests for emissions calculations.',
    `fuel_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.fuel_contract. Business justification: Emissions reports are calculated from fuel consumption tied to specific fuel contracts. Contract-level carbon intensity, SAF percentage, and fuel type drive CORSIA and EU ETS reporting. Real regulator',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Carbon offset purchases and CORSIA compliance costs generate GL entries. Airlines must account for environmental compliance expenditures in financial statements and track offset retirement costs for r',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each emissions report is filed to satisfy a specific regulatory requirement (e.g., CORSIA annual reporting under 14 CFR Part 1030). FK links report to the requirement it fulfills. Column removal: comp',
    `compliance_period` STRING COMMENT 'The compliance year to which this emissions report applies, formatted as YYYY.. Valid values are `^[0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this emissions report record was first created in the system.',
    `emission_factor` DECIMAL(18,2) COMMENT 'Emission factor applied in the calculation, expressed as kilograms of CO2 per kilogram of fuel burned.',
    `emissions_calculation_methodology` STRING COMMENT 'Methodology used to calculate emissions: CORSIA CERT, ICAO Default factors, Actual Fuel Burn measurement, or Third Party Tool.. Valid values are `CORSIA CERT|ICAO Default|Actual Fuel Burn|Third Party Tool`',
    `fuel_burn_tonnes` DECIMAL(18,2) COMMENT 'Total fuel consumed in metric tonnes during the reporting period and scope.',
    `fuel_type` STRING COMMENT 'Type of aviation fuel used: Jet A, Jet A-1, Jet B, Avgas, SAF (Sustainable Aviation Fuel), or Biofuel.. Valid values are `Jet A|Jet A-1|Jet B|Avgas|SAF|Biofuel`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this emissions report record was last modified or updated.',
    `offset_obligation_tonnes` DECIMAL(18,2) COMMENT 'Total carbon offset obligation in tonnes of CO2 equivalent that must be retired to achieve compliance for this reporting period.',
    `offset_project_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the carbon offset project is located.. Valid values are `^[A-Z]{3}$`',
    `offset_project_name` STRING COMMENT 'Name of the carbon offset project from which the offset units were sourced.',
    `offset_registry` STRING COMMENT 'Name of the carbon offset registry where the offset units are registered and retired (e.g., Verra, Gold Standard, CDM Registry). [ENUM-REF-CANDIDATE: Verra|Gold Standard|CDM Registry|American Carbon Registry|Climate Action Reserve|Plan Vivo|APX — promote to reference product]',
    `offset_unit_type` STRING COMMENT 'Type of carbon offset unit used (e.g., CORSIA Eligible Emission Unit, VCS, Gold Standard, CDM CER). [ENUM-REF-CANDIDATE: CORSIA Eligible Unit|VCS VCU|Gold Standard VER|CDM CER|JI ERU|ACR|CAR|Plan Vivo — promote to reference product]',
    `offset_vintage_year` STRING COMMENT 'The vintage year of the carbon offset units, representing the year in which the emission reductions occurred.',
    `offsets_retired_tonnes` DECIMAL(18,2) COMMENT 'Total carbon offsets in tonnes of CO2 equivalent that have been retired against this report to meet the compliance obligation.',
    `reconciliation_status` STRING COMMENT 'Status of the reconciliation between offset obligation and offsets retired: pending, reconciled (fully met), shortfall (under-compliance), or surplus (over-compliance).. Valid values are `pending|reconciled|shortfall|surplus`',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority or compliance scheme administrator to which the report was submitted (e.g., ICAO, EASA, FAA, National CAA).',
    `remarks` STRING COMMENT 'Free-text field for additional notes, explanations, or context related to the emissions report, verification, or compliance reconciliation.',
    `report_number` STRING COMMENT 'Externally-known unique business identifier for the emissions report, formatted as EMR-YYYY-NNNNNN.. Valid values are `^EMR-[0-9]{4}-[0-9]{6}$`',
    `report_status` STRING COMMENT 'Current lifecycle status of the emissions report (draft, submitted, under_verification, verified, accepted, rejected).. Valid values are `draft|submitted|under_verification|verified|accepted|rejected`',
    `report_type` STRING COMMENT 'Type of emissions report: annual, quarterly, ad_hoc, or amendment to a prior submission.. Valid values are `annual|quarterly|ad_hoc|amendment`',
    `reporting_period_end` DATE COMMENT 'End date of the emissions reporting period covered by this report.',
    `reporting_period_start` DATE COMMENT 'Start date of the emissions reporting period covered by this report.',
    `retirement_certificate_reference` STRING COMMENT 'Reference number or document identifier of the retirement certificate issued by the offset registry confirming the retirement of offset units.',
    `retirement_date` DATE COMMENT 'Date on which the carbon offset units were retired in the registry to meet the compliance obligation.',
    `route_code` STRING COMMENT 'IATA airport code pair representing the route or sector covered (e.g., JFK-LHR). Null for fleet-wide reports.. Valid values are `^[A-Z]{3}-[A-Z]{3}$`',
    `saf_percentage` DECIMAL(18,2) COMMENT 'Percentage of total fuel burn that was Sustainable Aviation Fuel (SAF) during the reporting period.',
    `scope` STRING COMMENT 'Scope of emissions covered: fleet_wide (all operations), route_specific, sector_specific, or aircraft_specific.. Valid values are `fleet_wide|route_specific|sector_specific|aircraft_specific`',
    `shortfall_tonnes` DECIMAL(18,2) COMMENT 'Amount of carbon offset shortfall in tonnes CO2e if the offset obligation has not been fully met. Null if reconciled or surplus.',
    `submission_date` DATE COMMENT 'Date on which the emissions report was submitted to the regulatory authority or compliance scheme administrator.',
    `submission_method` STRING COMMENT 'Method used to submit the report: online_portal, email, postal, or API integration.. Valid values are `online_portal|email|postal|API`',
    `surplus_tonnes` DECIMAL(18,2) COMMENT 'Amount of carbon offset surplus in tonnes CO2e if more offsets were retired than required. Null if reconciled or shortfall.',
    `total_co2_emissions_tonnes` DECIMAL(18,2) COMMENT 'Total carbon dioxide emissions in metric tonnes (CO2) for the reporting period and scope.',
    `verification_date` DATE COMMENT 'Date on which the emissions report was verified by the third-party verifier.',
    `verification_statement_reference` STRING COMMENT 'Reference number or document identifier of the verification statement issued by the verifier.',
    `verification_status` STRING COMMENT 'Status of third-party verification: not_required, pending, in_progress, verified, or failed.. Valid values are `not_required|pending|in_progress|verified|failed`',
    `verifier_accreditation_number` STRING COMMENT 'Accreditation number of the verification body issued by the national accreditation authority.',
    `verifier_name` STRING COMMENT 'Name of the accredited third-party verification body that verified the emissions report.',
    CONSTRAINT pk_emissions_report PRIMARY KEY(`emissions_report_id`)
) COMMENT 'Transactional record of the airlines environmental compliance reporting, carbon offset portfolio, and emissions reconciliation under CORSIA, EU ETS, and national environmental regulations. Captures reporting period, route/sector scope, total CO2 emissions (tonnes), fuel burn data, emissions calculation methodology, verification status, verifier identity, and submission date. Also manages the carbon offset portfolio: offset unit type (CORSIA Eligible Emission Unit, voluntary standard), registry, project name, project country, vintage year, quantity (tonnes CO2e), purchase date, retirement date, retirement certificate reference, and compliance period reconciliation. SSOT for environmental emissions compliance evidence, carbon offset tracking, and CORSIA compliance credits.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`carbon_offset` (
    `carbon_offset_id` BIGINT COMMENT 'Unique identifier for the carbon offset record. Primary key for the carbon offset portfolio tracking system.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Carbon offset purchases from suppliers create AP invoices. Airlines procure offsets through vendors, generating payables that must be matched to purchase orders and settled according to payment terms.',
    `emissions_report_id` BIGINT COMMENT 'Foreign key linking to compliance.emissions_report. Business justification: Carbon offsets are purchased and retired to meet obligations calculated in specific emissions reports. The retirement_certificate_reference and compliance_period tie the offset to a reporting period. ',
    `additionality_confirmed_flag` BOOLEAN COMMENT 'Boolean indicator of whether the offset project has been confirmed to meet additionality criteria (i.e., the emission reductions would not have occurred without the carbon finance incentive). True indicates additionality confirmed; False indicates not confirmed or under review.',
    `allocation_notes` STRING COMMENT 'Free-text notes describing how the offset units have been allocated to specific flights, routes, compliance periods, or customer programs. Used for internal tracking and audit documentation.',
    `co_benefits_description` STRING COMMENT 'Free-text description of additional environmental or social co-benefits delivered by the offset project beyond carbon emission reductions. Examples include biodiversity conservation, community employment, water quality improvement, or renewable energy access.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the purchase contract or agreement under which the offset units were acquired. Links to procurement and legal contract management systems.',
    `corsia_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether the offset units are eligible for use under the ICAO CORSIA scheme. True indicates CORSIA-eligible units; False indicates voluntary-only units.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carbon offset record was first created in the system. Used for audit trail and data lineage tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this carbon offset record was last updated. Used for audit trail, change tracking, and data quality monitoring.',
    `offset_status` STRING COMMENT 'Current lifecycle status of the carbon offset units. PURCHASED indicates units acquired but not yet retired; HELD indicates units in inventory; RETIRED indicates units permanently removed from circulation; CANCELLED indicates units invalidated; EXPIRED indicates units past their eligibility window.. Valid values are `PURCHASED|HELD|RETIRED|CANCELLED|EXPIRED`',
    `offset_unit_type` STRING COMMENT 'Classification of the carbon offset unit according to the certification standard. CORSIA Eligible Emission Units are approved for ICAO CORSIA compliance; voluntary standards include VCS, Gold Standard, CAR, and ACR for voluntary carbon neutrality commitments. [ENUM-REF-CANDIDATE: CORSIA_ELIGIBLE_EMISSION_UNIT|VOLUNTARY_CARBON_STANDARD|GOLD_STANDARD|CLIMATE_ACTION_RESERVE|AMERICAN_CARBON_REGISTRY|VERIFIED_CARBON_STANDARD|PLAN_VIVO|SOCIAL_CARBON — promote to reference product]. Valid values are `CORSIA_ELIGIBLE_EMISSION_UNIT|VOLUNTARY_CARBON_STANDARD|GOLD_STANDARD|CLIMATE_ACTION_RESERVE|AMERICAN_CARBON_REGISTRY|VERIFIED_CARBON_STANDARD`',
    `permanence_risk_rating` STRING COMMENT 'Assessment of the risk that the emission reductions or removals may be reversed in the future (e.g., reforestation projects at risk of fire or deforestation). LOW indicates minimal reversal risk; MEDIUM indicates moderate risk with mitigation measures; HIGH indicates significant risk requiring buffer reserves.. Valid values are `LOW|MEDIUM|HIGH`',
    `project_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the carbon offset project is located. Used for geographic analysis and compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `project_identifier` STRING COMMENT 'Unique identifier assigned to the carbon offset project by the certifying body or registry. Used for project-level tracking and reporting.',
    `project_name` STRING COMMENT 'Name of the carbon offset project that generated the emission reduction or removal units. Examples include renewable energy projects, reforestation initiatives, methane capture, or energy efficiency programs.',
    `project_type` STRING COMMENT 'Classification of the carbon offset project by the type of emission reduction or removal activity. Categories include renewable energy generation, reforestation and afforestation, methane capture from waste or agriculture, energy efficiency improvements, and avoided deforestation (REDD+). [ENUM-REF-CANDIDATE: RENEWABLE_ENERGY|REFORESTATION|AFFORESTATION|METHANE_CAPTURE|ENERGY_EFFICIENCY|AVOIDED_DEFORESTATION|SOIL_CARBON_SEQUESTRATION|DIRECT_AIR_CAPTURE|BLUE_CARBON — promote to reference product]. Valid values are `RENEWABLE_ENERGY|REFORESTATION|AFFORESTATION|METHANE_CAPTURE|ENERGY_EFFICIENCY|AVOIDED_DEFORESTATION`',
    `purchase_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the purchase transaction. Examples include USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `purchase_date` DATE COMMENT 'The date on which the airline purchased or acquired the carbon offset units. Used for financial accounting, portfolio management, and compliance period allocation.',
    `purchase_price_per_tonne` DECIMAL(18,2) COMMENT 'The unit price paid per tonne of CO2e offset, in the transaction currency. Used for cost analysis, budgeting, and carbon pricing strategy evaluation.',
    `quantity_tonnes_co2e` DECIMAL(18,2) COMMENT 'The quantity of carbon offset units in this record, measured in metric tonnes of carbon dioxide equivalent (CO2e). Represents the total emission reductions or removals covered by this offset batch.',
    `registry_identifier` STRING COMMENT 'Unique identifier or serial number assigned by the carbon offset registry to this batch of offset units. Used for traceability and verification of offset authenticity.',
    `registry_name` STRING COMMENT 'Name of the carbon offset registry where the offset units are registered and tracked. Examples include Verra Registry, Gold Standard Registry, American Carbon Registry, Climate Action Reserve, or national registries.',
    `retirement_certificate_reference` STRING COMMENT 'Reference number or identifier of the official retirement certificate issued by the carbon registry. Provides proof of retirement for audit and compliance verification.',
    `retirement_date` DATE COMMENT 'The date on which the carbon offset units were retired (permanently removed from circulation) to claim the emission reduction benefit. Retirement is required for CORSIA compliance and voluntary carbon neutrality claims.',
    `retirement_reason` STRING COMMENT 'The business purpose or program for which the offset units were retired. CORSIA_COMPLIANCE indicates mandatory regulatory offsetting; VOLUNTARY_COMMITMENT indicates airline carbon neutrality goals; CORPORATE_SUSTAINABILITY indicates broader ESG initiatives; CUSTOMER_PROGRAM indicates customer-facing carbon offset offerings.. Valid values are `CORSIA_COMPLIANCE|VOLUNTARY_COMMITMENT|CORPORATE_SUSTAINABILITY|CUSTOMER_PROGRAM`',
    `total_purchase_amount` DECIMAL(18,2) COMMENT 'The total amount paid for this batch of carbon offset units in the purchase currency. Calculated as quantity_tonnes_co2e multiplied by purchase_price_per_tonne.',
    `verification_body` STRING COMMENT 'Name of the independent third-party organization that verified the emission reductions of the offset project. Used for credibility assessment and audit trail.',
    `verification_standard` STRING COMMENT 'The third-party verification standard or methodology used to validate the emission reductions of the offset project. Examples include CDM (Clean Development Mechanism), VCS (Verified Carbon Standard), Gold Standard, or ISO 14064.',
    `vintage_year` STRING COMMENT 'The year in which the emission reductions or removals represented by the offset units occurred. Vintage year is critical for CORSIA compliance period matching and offset eligibility determination.',
    CONSTRAINT pk_carbon_offset PRIMARY KEY(`carbon_offset_id`)
) COMMENT 'Master and transactional record of carbon offset units purchased and retired by the airline to meet CORSIA obligations and voluntary carbon neutrality commitments. Captures offset unit type (CORSIA Eligible Emission Unit, voluntary standard), registry, project name, project country, vintage year, quantity (tonnes CO2e), purchase date, retirement date, retirement certificate reference, and compliance period. SSOT for the airlines carbon offset portfolio and CORSIA compliance credits.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` (
    `consumer_protection_case_id` BIGINT COMMENT 'Unique identifier for the consumer protection compliance case. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: EU261 and DOT passenger compensation payments create payables. Airlines must process compensation disbursements through AP systems, tracking payment status and reconciling against regulatory case reco',
    `ancillary_order_id` BIGINT COMMENT 'Foreign key linking to ancillary.order. Business justification: Consumer protection cases (DOT complaints, EU261 claims) frequently involve ancillary service failures: paid seat not provided, baggage fee disputes, lounge access denied. Case investigation and resol',
    `ancillary_refund_id` BIGINT COMMENT 'Foreign key linking to ancillary.ancillary_refund. Business justification: Consumer protection cases often mandate ancillary fee refunds as resolution. Regulatory case tracking must link to refund transaction for audit trail, compliance verification, and reporting to authori',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: DOT/EC261 consumer protection cases require assigned case managers for resolution tracking, regulatory reporting, and customer communication. FK enables workload balancing, performance tracking, and v',
    `catering_order_id` BIGINT COMMENT 'Foreign key linking to procurement.catering_order. Business justification: Consumer protection cases (food safety incidents, allergen violations, meal quality complaints) often trace back to specific catering orders. Airlines must link cases to orders for root cause analysis',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Consumer protection cases (denied boarding, delay compensation, accessibility violations) reference specific flight inventory records where the incident occurred. Essential for case investigation, com',
    `occurrence_id` BIGINT COMMENT 'Foreign key linking to safety.occurrence. Business justification: Consumer protection cases (denied boarding, delays, cancellations) often stem from safety occurrences (mechanical issues, weather diversions). Links consumer compensation tracking to root cause occurr',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Each consumer protection case is reported to/managed by a specific authority (DOT, EASA). FK normalizes authority reference. Column removal: regulatory_authority (string) and reporting_jurisdiction ar',
    `accessibility_violation_flag` BOOLEAN COMMENT 'Indicates whether this case involves a violation of accessibility requirements under the Air Carrier Access Act (ACAA) for passengers with disabilities.',
    `accessibility_violation_type` STRING COMMENT 'Specific type of ACAA accessibility violation if applicable (e.g., wheelchair damage, service animal denial, boarding assistance failure).',
    `actual_value` DECIMAL(18,2) COMMENT 'Actual measured value of the incident metric (e.g., 195 minutes for a tarmac delay that exceeded the 180-minute threshold).',
    `case_notes` STRING COMMENT 'Additional notes, comments, or context related to the consumer protection case for internal tracking and audit purposes.',
    `case_number` STRING COMMENT 'External case reference number assigned by the airline or regulatory authority for tracking and reporting purposes.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the consumer protection case indicating its resolution progress.. Valid values are `open|under_investigation|pending_resolution|resolved|closed|escalated`',
    `case_type` STRING COMMENT 'Classification of the consumer protection case type based on the nature of the regulatory incident or violation. [ENUM-REF-CANDIDATE: denied_boarding|tarmac_delay|baggage_liability|fare_advertising|accessibility_acaa|refund_delay|cancellation_compensation|downgrade_compensation — 8 candidates stripped; promote to reference product]',
    `compensation_amount_total` DECIMAL(18,2) COMMENT 'Total monetary compensation paid or owed to all affected passengers for this consumer protection case.',
    `compensation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the compensation amount paid.. Valid values are `^[A-Z]{3}$`',
    `compensation_per_passenger` DECIMAL(18,2) COMMENT 'Standard compensation amount paid per affected passenger as required by regulatory guidelines.',
    `compensation_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory compensation is required to be paid to affected passengers based on the incident type and jurisdiction.',
    `complaint_receipt_date` DATE COMMENT 'Date on which the passenger complaint related to this incident was received by the airline.',
    `corrective_action_taken` STRING COMMENT 'Description of corrective actions implemented to prevent recurrence of similar consumer protection incidents.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consumer protection case record was first created in the system.',
    `destination_airport_code` STRING COMMENT 'Three-letter IATA airport code for the arrival airport of the flight involved in the incident.. Valid values are `^[A-Z]{3}$`',
    `dot_case_reference` STRING COMMENT 'Official DOT case reference number if the incident was reported to or investigated by the US Department of Transportation.',
    `easa_case_reference` STRING COMMENT 'Official EASA or national CAA case reference number if the incident occurred under EU jurisdiction and was reported to European authorities.',
    `flight_date` DATE COMMENT 'Scheduled departure date of the flight involved in the consumer protection case.',
    `flight_number` STRING COMMENT 'The flight number associated with the consumer protection incident, following IATA flight number format.. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$`',
    `incident_date` DATE COMMENT 'The date on which the consumer protection incident occurred, triggering the compliance case.',
    `incident_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the consumer protection incident occurred, used for tarmac delay threshold calculations and regulatory reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this consumer protection case record was last updated or modified.',
    `origin_airport_code` STRING COMMENT 'Three-letter IATA airport code for the departure airport of the flight involved in the incident.. Valid values are `^[A-Z]{3}$`',
    `passenger_complaint_received_flag` BOOLEAN COMMENT 'Indicates whether a formal passenger complaint was received related to this consumer protection incident.',
    `passenger_count_affected` STRING COMMENT 'Total number of passengers affected by the consumer protection incident, used for regulatory reporting and compensation calculations.',
    `regulatory_threshold_breached` BOOLEAN COMMENT 'Indicates whether the incident exceeded regulatory thresholds requiring mandatory reporting or compensation (e.g., 3-hour tarmac delay for domestic flights, 4-hour for international).',
    `report_submission_date` DATE COMMENT 'Date on which the consumer protection case was formally reported to the regulatory authority.',
    `reported_to_authority_flag` BOOLEAN COMMENT 'Indicates whether this case has been formally reported to the applicable regulatory authority as required by consumer protection regulations.',
    `resolution_date` DATE COMMENT 'Date on which the consumer protection case was resolved, including all compensation payments and corrective actions completed.',
    `resolution_description` STRING COMMENT 'Detailed narrative describing how the consumer protection case was resolved, including actions taken and compensation provided.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause that led to the consumer protection incident. [ENUM-REF-CANDIDATE: weather|atc_delay|mechanical|crew_scheduling|ground_operations|security|passenger_behavior|airline_operational — 8 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed explanation of the root cause analysis findings for the consumer protection incident.',
    `threshold_type` STRING COMMENT 'Specific regulatory threshold category that was breached or evaluated in this case.. Valid values are `tarmac_delay_domestic|tarmac_delay_international|denied_boarding_involuntary|baggage_delay|cancellation_notice|refund_processing`',
    `threshold_unit` STRING COMMENT 'Unit of measure for the regulatory threshold value (e.g., minutes for tarmac delays, passengers for denied boarding).. Valid values are `minutes|hours|days|passengers|dollars`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric value of the regulatory threshold applicable to this case (e.g., 180 minutes for domestic tarmac delay).',
    CONSTRAINT pk_consumer_protection_case PRIMARY KEY(`consumer_protection_case_id`)
) COMMENT 'Transactional record of consumer protection compliance cases and DOT/EASA consumer regulation incidents, including denied boarding (involuntary bumping), tarmac delay violations, baggage liability claims, fare advertising complaints, and accessibility (ACAA) compliance cases. Captures case type, incident date, flight reference, passenger count affected, regulatory threshold breached, compensation paid, DOT/EASA case reference number, and resolution status. Supports DOT consumer protection reporting obligations.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`regulatory_violation` (
    `regulatory_violation_id` BIGINT COMMENT 'Unique identifier for the regulatory violation record. Primary key.',
    `embargo_id` BIGINT COMMENT 'Foreign key linking to cargo.embargo. Business justification: Embargo violations (shipping restricted goods/routes) result in regulatory enforcement actions. Links violation to the specific embargo breached for penalty assessment and compliance investigation.',
    `dangerous_goods_id` BIGINT COMMENT 'Foreign key linking to cargo.dangerous_goods. Business justification: Dangerous goods violations result in regulatory enforcement actions with penalties. Links violation record to the specific DG shipment for legal defense, penalty assessment, and corrective action.',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Regulatory violations (slot breach, noise curfew, crew rest) often tied to specific flight operations. Linking violation to flight inventory enables root cause analysis, corrective action tracking, an',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Regulatory penalties and fines generate GL postings for financial reporting and audit trails. Airlines must track penalty payments in the general ledger for accurate financial statements and regulator',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Each violation is issued/enforced by a specific authority. FK normalizes authority reference. Column removal: issuing_authority and issuing_authority_country_code are redundant.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each violation is a breach of a specific regulatory requirement. FK links violation to the requirement violated. Column removal: applicable_regulation and regulation_section are redundant with regulat',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Regulatory violations are attributed to departments for corrective action accountability and trend analysis. FK enables departmental violation tracking, resource allocation for remediation, and regula',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Regulatory violations can be caused by vendor failures (unapproved parts, maintenance errors by contract MRO, ground handling safety breaches). Airlines must track vendor accountability for compliance',
    `aircraft_registration` STRING COMMENT 'The tail number or registration of the specific aircraft involved in the violation, if applicable. Null if violation is not aircraft-specific.',
    `appeal_date` DATE COMMENT 'The date on which the airline filed the formal appeal or contest of the enforcement action. Null if no appeal was filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether the airline has filed a formal appeal or contest of the enforcement action with the regulatory authority or administrative law judge.',
    `appeal_status` STRING COMMENT 'The current status of the appeal process if an appeal was filed. Null if no appeal was filed.. Valid values are `pending|upheld|overturned|settled|withdrawn`',
    `arrival_airport_code` STRING COMMENT 'Three-letter IATA code of the arrival airport for the flight involved in the violation, if applicable. Null if violation is not flight-specific.. Valid values are `^[A-Z]{3}$`',
    `case_manager` STRING COMMENT 'The name of the airline compliance or legal team member assigned to manage this violation case and coordinate with the regulatory authority.',
    `corrective_action_completion_date` DATE COMMENT 'The date on which the airline completed all mandated corrective actions and reported compliance to the regulatory authority.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective actions mandated by the regulatory authority to address the violation and prevent recurrence.',
    `corrective_action_due_date` DATE COMMENT 'The deadline by which the airline must complete and report the mandated corrective actions to the regulatory authority.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether the regulatory authority mandated specific corrective actions as part of the enforcement action.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory violation record was first created in the system. Audit trail field.',
    `departure_airport_code` STRING COMMENT 'Three-letter IATA code of the departure airport for the flight involved in the violation, if applicable. Null if violation is not flight-specific.. Valid values are `^[A-Z]{3}$`',
    `discovery_date` DATE COMMENT 'The date on which the violation was discovered or reported to the regulatory authority, which may differ from the incident date.',
    `disposition_date` DATE COMMENT 'The date on which the violation case reached its final disposition and was closed by the regulatory authority.',
    `enforcement_action_type` STRING COMMENT 'The type of enforcement action taken by the regulatory authority in response to the violation (e.g., Warning Letter, Civil Penalty, Certificate Suspension, Certificate Revocation, Corrective Action Order). [ENUM-REF-CANDIDATE: warning_letter|civil_penalty|certificate_suspension|certificate_revocation|corrective_action_order|administrative_action|emergency_order — promote to reference product]',
    `final_disposition` STRING COMMENT 'The final outcome or resolution of the violation case after all enforcement actions, appeals, and settlements have been completed.. Valid values are `penalty_paid|settled|dismissed|overturned|certificate_action_taken`',
    `flight_number` STRING COMMENT 'The flight number of the specific flight operation during which the violation occurred, if applicable. Null if violation is not flight-specific.',
    `incident_date` DATE COMMENT 'The date on which the violation or non-compliance incident occurred. This is the real-world event date that triggered the regulatory action.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory violation record was last updated or modified. Audit trail field.',
    `legal_counsel_assigned_flag` BOOLEAN COMMENT 'Indicates whether external or internal legal counsel has been formally assigned to represent the airline in this violation case.',
    `notification_date` DATE COMMENT 'The date on which the airline was formally notified of the violation by the regulatory authority.',
    `payment_date` DATE COMMENT 'The actual date on which the airline made the penalty payment to the regulatory authority.',
    `payment_due_date` DATE COMMENT 'The date by which the civil penalty payment must be made to the regulatory authority to avoid additional enforcement action.',
    `penalty_amount_assessed` DECIMAL(18,2) COMMENT 'The monetary civil penalty amount assessed by the regulatory authority in the enforcement action. Null if no financial penalty was imposed.',
    `penalty_amount_paid` DECIMAL(18,2) COMMENT 'The actual monetary amount paid by the airline to settle or satisfy the civil penalty. May differ from assessed amount due to negotiation or settlement.',
    `penalty_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amounts (assessed and paid).. Valid values are `^[A-Z]{3}$`',
    `public_disclosure_date` DATE COMMENT 'The date on which the violation was publicly disclosed by the regulatory authority. Null if not publicly disclosed.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Indicates whether the violation and enforcement action were publicly disclosed by the regulatory authority (e.g., published in FAA enforcement database or DOT public docket).',
    `remarks` STRING COMMENT 'Additional notes, comments, or context regarding the violation case, enforcement actions, or internal response. Free-text field for case management.',
    `severity_level` STRING COMMENT 'The severity classification assigned to the violation by the regulatory authority, reflecting the risk and impact to safety, security, or compliance.. Valid values are `critical|major|moderate|minor`',
    `violation_description` STRING COMMENT 'Detailed narrative description of the violation, including the circumstances, findings, and specific non-compliance details as documented by the regulatory authority.',
    `violation_number` STRING COMMENT 'External reference number assigned by the regulatory authority to this violation case. Used for correspondence and tracking with the issuing agency.',
    `violation_status` STRING COMMENT 'Current lifecycle status of the regulatory violation case in the enforcement process.. Valid values are `open|under_investigation|contested|settled|closed|appealed`',
    `violation_type` STRING COMMENT 'High-level classification of the regulatory violation based on the nature of the infraction.. Valid values are `operational|maintenance|safety|security|environmental|consumer_protection`',
    CONSTRAINT pk_regulatory_violation PRIMARY KEY(`regulatory_violation_id`)
) COMMENT 'Transactional record of confirmed regulatory violations, enforcement actions, and civil penalty proceedings initiated by FAA, EASA, DOT, TSA, or national CAAs against the airline. Captures violation type, applicable regulation, incident date, discovery date, issuing authority, enforcement action type (warning, civil penalty, certificate action), penalty amount assessed, penalty amount paid, appeal status, and final disposition. SSOT for the airlines regulatory enforcement history.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` (
    `foreign_carrier_permit_id` BIGINT COMMENT 'Unique identifier for the foreign carrier permit record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Foreign carrier permit applications have filing fees and legal costs. Airlines allocate permit expenses to cost centres for international operations budget tracking and route profitability analysis.',
    `employee_id` BIGINT COMMENT 'Employee ID of the individual responsible for managing this permit and ensuring compliance with its conditions.',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Each foreign carrier permit is issued by a foreign regulatory authority. FK normalizes authority reference. Column removal: issuing_authority_name and issuing_country_code are redundant with regulator',
    `route_id` BIGINT COMMENT 'Foreign key linking to route.route. Business justification: Foreign carrier permits authorize operation on specific routes. This FK links the permit to the route master for route authority tracking and compliance verification.',
    `aircraft_type_restriction` STRING COMMENT 'Specific aircraft types or categories allowed or restricted under this permit (e.g., Wide-body only, B777, A350).',
    `application_date` DATE COMMENT 'Date on which the airline submitted the application for this foreign carrier permit.',
    `approval_date` DATE COMMENT 'Date on which the issuing authority officially approved and granted the permit.',
    `bilateral_asa_reference` STRING COMMENT 'Reference number or title of the bilateral air service agreement under which this permit is granted.',
    `capacity_limit_seats` STRING COMMENT 'Maximum seat capacity per flight or per period allowed under this permit. Null if unlimited.',
    `cargo_authorization_flag` BOOLEAN COMMENT 'Indicates whether the permit authorizes cargo operations (True) or is passenger-only (False).',
    `codeshare_allowed_flag` BOOLEAN COMMENT 'Indicates whether codeshare operations are permitted under this permit (True) or restricted (False).',
    `compliance_audit_required_flag` BOOLEAN COMMENT 'Indicates whether the issuing authority requires periodic compliance audits as a condition of the permit (True/False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this foreign carrier permit record was first created in the system.',
    `destination_airport_code` STRING COMMENT 'IATA three-letter code of the destination airport covered by the permit, if route-specific.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date on which the permit becomes valid and the airline is authorized to commence operations under this permit.',
    `expiry_date` DATE COMMENT 'Date on which the permit expires and is no longer valid. Null if the permit is indefinite or subject to periodic review.',
    `frequency_limit` STRING COMMENT 'Maximum number of flights per week or per period allowed under this permit. Null if unlimited.',
    `interline_allowed_flag` BOOLEAN COMMENT 'Indicates whether interline ticketing and baggage agreements are permitted under this permit (True) or restricted (False).',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit conducted by the issuing authority for this permit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this foreign carrier permit record was last updated or modified in the system.',
    `last_renewal_date` DATE COMMENT 'Date of the most recent renewal or revalidation of this permit.',
    `next_audit_due_date` DATE COMMENT 'Date by which the next compliance audit must be completed to maintain the permit in good standing.',
    `next_renewal_due_date` DATE COMMENT 'Date by which the next renewal application must be submitted or approved to maintain continuous authorization.',
    `origin_airport_code` STRING COMMENT 'IATA three-letter code of the origin airport covered by the permit, if route-specific.. Valid values are `^[A-Z]{3}$`',
    `passenger_authorization_flag` BOOLEAN COMMENT 'Indicates whether the permit authorizes passenger operations (True) or is cargo-only (False).',
    `permit_conditions` STRING COMMENT 'Detailed conditions, restrictions, or special requirements attached to the permit (e.g., slot restrictions, codeshare limitations, cargo-only).',
    `permit_document_url` STRING COMMENT 'URL or file path to the official permit document, certificate, or authorization letter issued by the foreign authority.',
    `permit_number` STRING COMMENT 'Official permit or authorization number issued by the foreign regulatory authority. This is the externally-known business identifier for the permit.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the foreign carrier permit.. Valid values are `active|pending|suspended|expired|revoked|under_review`',
    `permit_type` STRING COMMENT 'Classification of the permit or authorization type granted by the foreign jurisdiction.. Valid values are `foreign_carrier_permit|exemption|bilateral_entitlement|cabotage_authorization|fifth_freedom|technical_stop`',
    `remarks` STRING COMMENT 'Additional notes, comments, or context regarding the permit, including any special circumstances, historical changes, or operational considerations.',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals, if renewal_required_flag is True. Null if not applicable.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the permit requires periodic renewal (True) or is granted indefinitely subject to compliance (False).',
    `route_scope` STRING COMMENT 'Description of the routes, city pairs, or geographic markets covered by this permit (e.g., JFK-LHR, US-EU routes, All domestic points).',
    `traffic_rights_type` STRING COMMENT 'Type of traffic rights granted under the permit, based on the nine freedoms of the air as defined by ICAO. [ENUM-REF-CANDIDATE: first_freedom|second_freedom|third_freedom|fourth_freedom|fifth_freedom|sixth_freedom|seventh_freedom|eighth_freedom|ninth_freedom — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_foreign_carrier_permit PRIMARY KEY(`foreign_carrier_permit_id`)
) COMMENT 'Master record of foreign carrier permits, traffic rights, and bilateral air service agreement (ASA) authorizations that allow the airline to operate in foreign jurisdictions. Captures permit type (foreign carrier permit, exemption, bilateral entitlement), issuing country authority, route or market covered, traffic rights type (1st through 9th freedom), permit conditions, effective date, expiry date, and renewal status. SSOT for the airlines international operating rights portfolio.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`exemption_waiver` (
    `exemption_waiver_id` BIGINT COMMENT 'Unique identifier for the regulatory exemption or waiver record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Exemption applications have filing fees and legal costs. Airlines allocate exemption expenses to cost centres for regulatory affairs budget tracking and special operations cost management.',
    `flight_inventory_id` BIGINT COMMENT 'Foreign key linking to inventory.flight_inventory. Business justification: Exemptions/waivers may apply to specific flights (e.g., temporary ETOPS waiver, noise exemption for specific date). Flight inventory must reference applicable waivers for dispatch validation and regul',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Each exemption/waiver is granted by a specific authority. FK normalizes authority reference. Column removal: issuing_authority and issuing_authority_country_code are redundant.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each exemption/waiver is a deviation from a specific regulatory requirement. FK links waiver to the requirement being waived. Column removal: regulation_reference (string) is redundant with regulatory',
    `employee_id` BIGINT COMMENT 'Employee identifier of the individual accountable for managing this exemption or waiver and ensuring ongoing compliance with its conditions.',
    `station_id` BIGINT COMMENT 'Foreign key linking to airport.station. Business justification: Exemptions/waivers often apply to specific airport operations: noise curfew relief at SNA, slot waiver at LHR, customs facility exemption. Operations and dispatch need to know which waivers apply at w',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Exemptions/waivers may be granted based on contractual arrangements (e.g., COVID relief tied to specific vendor agreements, temporary operational waivers linked to supply contracts). Airlines track wh',
    `aircraft_registration` STRING COMMENT 'Specific aircraft registration number(s) to which this exemption or waiver applies. Null if exemption applies fleet-wide or is not aircraft-specific. Multiple registrations may be separated by semicolons.',
    `aircraft_type_icao_code` STRING COMMENT 'ICAO aircraft type designator code for aircraft covered by this exemption or waiver (e.g., B738 for Boeing 737-800, A320 for Airbus A320). Null if exemption applies to all aircraft types or is not aircraft-specific.. Valid values are `^[A-Z0-9]{2,4}$`',
    `application_date` DATE COMMENT 'Date when the exemption or waiver application was formally submitted to the regulatory authority.',
    `application_status` STRING COMMENT 'Current lifecycle status of the exemption or waiver application (e.g., draft, submitted, under review, approved, denied, withdrawn, expired, renewed). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|denied|withdrawn|expired|renewed — 8 candidates stripped; promote to reference product]',
    `approval_date` DATE COMMENT 'Date when the exemption or waiver was officially granted by the regulatory authority. Null if not yet approved.',
    `compliance_program_reference` STRING COMMENT 'Reference to the internal compliance program or audit program that monitors adherence to the conditions of this exemption or waiver.',
    `conditions_attached` STRING COMMENT 'Specific conditions, limitations, or requirements imposed by the regulatory authority as part of granting the exemption or waiver. May include operational restrictions, reporting obligations, or compensating controls.',
    `corsia_exemption_flag` BOOLEAN COMMENT 'Indicates whether this exemption or waiver relates to CORSIA emissions reporting or carbon offset requirements (True) or not (False).',
    `covid_relief_flag` BOOLEAN COMMENT 'Indicates whether this exemption or waiver was granted as part of COVID-19 pandemic relief measures (True) or not (False). Includes slot waivers and operational relief during the pandemic.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this exemption or waiver record was first created in the system.',
    `denial_reason` STRING COMMENT 'Explanation provided by the regulatory authority for denying the exemption or waiver application. Null if application was approved or is still pending.',
    `document_reference_url` STRING COMMENT 'URL or file path to the official exemption or waiver document, approval letter, or supporting documentation stored in the document management system.',
    `effective_date` DATE COMMENT 'Date from which the exemption or waiver becomes valid and enforceable for airline operations.',
    `etops_diversion_time_minutes` STRING COMMENT 'Maximum diversion time in minutes for ETOPS operations covered by this exemption or waiver (e.g., 120, 180, 207). Applicable only to ETOPS-related exemptions.',
    `exemption_number` STRING COMMENT 'Official exemption or waiver number assigned by the issuing regulatory authority (e.g., FAA exemption number, EASA deviation approval number).',
    `exemption_type` STRING COMMENT 'Classification of the exemption or waiver type (e.g., regulatory exemption, operational waiver, airworthiness deviation, slot waiver, special flight permit, ETOPS deviation). [ENUM-REF-CANDIDATE: regulatory_exemption|operational_waiver|airworthiness_deviation|slot_waiver|special_flight_permit|etops_deviation|temporary_relief|other — 8 candidates stripped; promote to reference product]',
    `expiry_date` DATE COMMENT 'Date when the exemption or waiver expires and is no longer valid. Null for indefinite exemptions or those pending expiry determination.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this exemption or waiver record was most recently updated in the system.',
    `last_renewal_date` DATE COMMENT 'Date of the most recent renewal of the exemption or waiver. Null if never renewed or if this is the original grant.',
    `next_renewal_due_date` DATE COMMENT 'Date by which the next renewal application must be submitted to maintain continuous validity. Null if renewal is not required.',
    `public_disclosure_required_flag` BOOLEAN COMMENT 'Indicates whether the exemption or waiver must be publicly disclosed or published in regulatory notices (True) or can remain confidential (False).',
    `remarks` STRING COMMENT 'Additional notes, comments, or context regarding the exemption or waiver that do not fit into other structured fields. May include internal observations, lessons learned, or coordination notes.',
    `renewal_frequency_months` STRING COMMENT 'Frequency in months at which the exemption or waiver must be renewed. Null if renewal is not required or frequency is not specified.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the exemption or waiver requires periodic renewal (True) or is granted indefinitely (False).',
    `requesting_basis` STRING COMMENT 'Business or operational justification for requesting the exemption or waiver. Describes why relief from the regulation is necessary and how equivalent safety or compliance will be maintained.',
    `route_scope` STRING COMMENT 'Geographic or route-specific scope of the exemption or waiver (e.g., specific city pairs, regions, or route networks). Null if exemption applies to all routes.',
    `scope_description` STRING COMMENT 'Detailed description of the operational scope covered by the exemption or waiver, including applicable aircraft types, routes, flight operations, or organizational units.',
    `withdrawal_reason` STRING COMMENT 'Reason for withdrawing the exemption or waiver application by the airline. Null if not withdrawn.',
    CONSTRAINT pk_exemption_waiver PRIMARY KEY(`exemption_waiver_id`)
) COMMENT 'Master record of regulatory exemptions, waivers, and deviations granted to or applied for by the airline from FAA, EASA, DOT, or national CAAs. Captures exemption type, applicable regulation being waived, requesting basis, issuing authority, grant date, expiry date, conditions attached, scope of operations covered, and renewal history. Includes COVID-era slot waivers, ETOPS deviation approvals, and special flight permits. SSOT for all regulatory relief instruments held by the airline.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`self_assessment` (
    `self_assessment_id` BIGINT COMMENT 'Primary key for self_assessment',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for conducting or overseeing the compliance assessment.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Compliance self-assessments have administrative costs and consultant fees. Airlines allocate assessment expenses to cost centres for compliance program budget tracking and departmental cost allocation',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Each self-assessment evaluates compliance with a specific authoritys regulatory framework. FK links assessment to the authority being assessed against. Column removal: regulatory_authority (string) i',
    `assessment_completion_date` DATE COMMENT 'The date when the compliance assessment was finalized and all findings documented.',
    `assessment_date` DATE COMMENT 'The date on which the compliance self-assessment was conducted or completed.',
    `assessment_frequency` STRING COMMENT 'The recurrence pattern for this type of compliance assessment (annual, semi-annual, quarterly, monthly, ad-hoc, or event-driven).. Valid values are `annual|semi_annual|quarterly|monthly|ad_hoc|event_driven`',
    `assessment_methodology` STRING COMMENT 'Description of the methodology or approach used to conduct the assessment (e.g., document review, interviews, site inspections, data analysis, checklist-based evaluation).',
    `assessment_owner_name` STRING COMMENT 'Full name of the compliance officer or employee responsible for the assessment.',
    `assessment_reference_number` STRING COMMENT 'Business identifier for the self-assessment, typically formatted as prefix-year-sequence (e.g., COMP-2024-000123).. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$`',
    `assessment_start_date` DATE COMMENT 'The date when the compliance assessment activity commenced.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the compliance assessment (planned, in progress, under review, completed, cancelled, or deferred).. Valid values are `planned|in_progress|under_review|completed|cancelled|deferred`',
    `assessment_team_members` STRING COMMENT 'Comma-separated list of names or employee IDs of team members who participated in the assessment.',
    `assessment_type` STRING COMMENT 'Classification of the compliance assessment activity conducted (self-assessment, gap analysis, readiness review, internal audit, pre-certification review, or regulatory preparedness).. Valid values are `self_assessment|gap_analysis|readiness_review|internal_audit|pre_certification_review|regulatory_preparedness`',
    `compliance_score_percentage` DECIMAL(18,2) COMMENT 'Quantitative compliance score expressed as a percentage (0.00 to 100.00), representing the proportion of requirements met during the assessment.',
    `corrective_action_plan_reference` STRING COMMENT 'Reference number or identifier of the corrective action plan developed in response to the assessment findings.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are required based on the assessment findings (True if corrective actions are needed, False otherwise).',
    `coverage_areas` STRING COMMENT 'Comma-separated list of business domains or operational areas covered by the assessment (e.g., Flight Operations, Maintenance, Ground Operations, Safety Management, Environmental Compliance).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance assessment record was first created in the system.',
    `critical_gaps_count` STRING COMMENT 'The number of critical or high-severity compliance gaps identified that require immediate corrective action.',
    `evidence_documentation_reference` STRING COMMENT 'Reference to the location or document management system path where assessment evidence and supporting documentation are stored.',
    `findings_summary` STRING COMMENT 'Executive summary of the key findings, observations, and recommendations from the compliance assessment.',
    `gaps_identified_count` STRING COMMENT 'The total number of compliance gaps, deficiencies, or non-conformances identified during the assessment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this compliance assessment record was last updated or modified.',
    `major_gaps_count` STRING COMMENT 'The number of major compliance gaps identified that require corrective action within a defined timeframe.',
    `minor_gaps_count` STRING COMMENT 'The number of minor compliance gaps or observations identified that require monitoring or improvement.',
    `next_assessment_due_date` DATE COMMENT 'The scheduled date for the next compliance self-assessment or follow-up review.',
    `overall_compliance_rating` STRING COMMENT 'Summary rating of the overall compliance status based on the assessment findings (compliant, substantially compliant, partially compliant, non-compliant, or not assessed).. Valid values are `compliant|substantially_compliant|partially_compliant|non_compliant|not_assessed`',
    `regulatory_framework` STRING COMMENT 'The regulatory framework or standard being assessed (e.g., FAA Part 121, EASA Air OPS, DOT Consumer Protection, CORSIA, SMS, ISO 9001). Multiple frameworks may be listed if the assessment spans multiple areas.',
    `regulatory_readiness_status` STRING COMMENT 'Assessment of the organizations readiness for regulatory inspection or audit based on the self-assessment findings (ready, substantially ready, needs improvement, or not ready).. Valid values are `ready|substantially_ready|needs_improvement|not_ready`',
    `remarks` STRING COMMENT 'Additional notes, comments, or contextual information related to the compliance assessment.',
    `report_approved_by` STRING COMMENT 'Name or employee ID of the senior compliance officer or executive who approved the assessment report.',
    `report_issued_date` DATE COMMENT 'The date when the formal assessment report was issued to stakeholders.',
    `requirements_met` STRING COMMENT 'The number of regulatory requirements or control points that were found to be fully compliant during the assessment.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the compliance gaps or deficiencies identified (critical, high, medium, low, or negligible).. Valid values are `critical|high|medium|low|negligible`',
    `scope_description` STRING COMMENT 'Detailed description of the scope of the compliance assessment, including specific operational areas, processes, or requirements being evaluated.',
    `total_requirements_assessed` STRING COMMENT 'The total number of regulatory requirements or control points evaluated during the assessment.',
    CONSTRAINT pk_self_assessment PRIMARY KEY(`self_assessment_id`)
) COMMENT 'Transactional record of periodic internal compliance assessments and self-evaluations conducted by the airlines compliance function to assess adherence to regulatory requirements, operational approvals, and internal standards. Captures assessment date, assessment type (self-assessment, gap analysis, readiness review), regulatory framework assessed, scope, overall compliance rating, number of gaps identified, assessment owner, and next scheduled assessment date. Supports proactive compliance management and regulatory readiness.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` (
    `channel_audit_assessment_id` BIGINT COMMENT 'Unique identifier for this channel-specific audit assessment record. Primary key.',
    `audit_event_id` BIGINT COMMENT 'Foreign key linking to the parent audit event under which this channel assessment was conducted.',
    `sales_channel_id` BIGINT COMMENT 'Foreign key linking to the specific sales channel that was assessed in this audit.',
    `auditor_assigned` STRING COMMENT 'Name or identifier of the specific auditor or audit team member who assessed this channel within the broader audit event.',
    `channel_audit_date` DATE COMMENT 'Specific date this channel was assessed within the broader audit event. For multi-day audits covering multiple channels, each channel may be audited on different days within the audit_event.actual_start_date to audit_event.actual_end_date window.',
    `channel_audit_notes` STRING COMMENT 'Free-text notes and observations specific to this channels audit assessment, including context for findings, mitigating factors, or areas of excellence.',
    `channel_audit_scope` STRING COMMENT 'Detailed description of the audit scope specific to this channel, including which ancillary products, pricing rules, disclosure requirements, refund processes, and merchandising practices were assessed. This is channel-specific and more granular than the overall audit_event.audit_scope.',
    `channel_compliance_rating` STRING COMMENT 'Compliance rating assigned specifically to this channels performance in the audit. May differ from the overall audit_event.assessment_rating as different channels may have different compliance levels within the same audit event.',
    `channel_corrective_action_due_date` DATE COMMENT 'Deadline by which corrective actions for this channel must be completed and verified.',
    `channel_corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether formal corrective action is required for this channel based on audit findings.',
    `channel_corrective_action_status` STRING COMMENT 'Current status of corrective action implementation for this channel.',
    `channel_critical_findings_count` STRING COMMENT 'Number of critical findings identified for this channel, requiring immediate corrective action.',
    `channel_findings_count` STRING COMMENT 'Total number of findings, observations, or non-conformances identified for this specific channel during the audit event. Channel-level count that rolls up to audit_event.total_findings_count.',
    `channel_major_findings_count` STRING COMMENT 'Number of major findings identified for this channel, requiring corrective action within a defined timeframe.',
    `channel_minor_findings_count` STRING COMMENT 'Number of minor findings or observations identified for this channel.',
    `next_channel_audit_due` DATE COMMENT 'Scheduled date for the next audit assessment of this specific channel. May differ from audit_event.next_scheduled_audit_date if channels have different audit frequencies based on risk profile or prior findings.',
    CONSTRAINT pk_channel_audit_assessment PRIMARY KEY(`channel_audit_assessment_id`)
) COMMENT 'This association product represents the audit assessment of individual sales channels within a broader compliance audit event. It captures channel-specific audit scope, findings, compliance ratings, and remediation timelines. Each record links one audit_event to one sales_channel with attributes that exist only in the context of this regulatory assessment relationship.. Existence Justification: In airline ancillary revenue compliance audits, a single audit event (IOSA, DOT, internal compliance review) assesses multiple sales channels (GDS, NDC API, mobile app, kiosk, agent) for regulatory compliance with pricing transparency, disclosure requirements, and refund processing rules. Each channel within an audit receives its own scope definition, findings count, compliance rating, and remediation timeline. Conversely, each sales channel undergoes multiple audit events over time as part of ongoing regulatory compliance programs. This is an operational M:N relationship where compliance teams actively manage channel-specific audit assessments.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` (
    `audit_cost_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for this audit cost allocation record. Primary key.',
    `audit_program_id` BIGINT COMMENT 'Foreign key linking to the audit program for which costs are being allocated and tracked.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to the cost centre that incurs costs for participation in the audit program.',
    `employee_id` BIGINT COMMENT 'Foreign key to workforce.employee identifying the manager accountable for this cost allocation, typically the cost centre manager or audit program coordinator.',
    `actual_cost_to_date` DECIMAL(18,2) COMMENT 'The cumulative actual costs incurred by this cost centre for this audit program as of the current reporting date. Enables budget vs actual variance analysis.',
    `allocated_budget_amount` DECIMAL(18,2) COMMENT 'The budget amount allocated to this cost centre for participation in this specific audit program for the fiscal period. Represents planned expenditure.',
    `allocation_effective_date` DATE COMMENT 'The date from which this cost allocation becomes effective and the cost centre begins incurring costs for this audit program.',
    `allocation_end_date` DATE COMMENT 'The date on which this cost allocation ends, typically aligned with audit program completion or fiscal year end.',
    `allocation_notes` STRING COMMENT 'Free-text field for additional context about this cost allocation, such as special circumstances, allocation methodology rationale, or variance explanations.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of this cost allocation record. Values: planned (budget proposed), approved (budget authorized), active (costs being incurred), completed (audit cycle finished), cancelled (allocation withdrawn).',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'Calculated variance between allocated budget and actual costs (actual_cost_to_date - allocated_budget_amount). Positive values indicate over-budget, negative indicate under-budget.',
    `cost_allocation_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total audit program cost allocated to this cost centre, reflecting the proportional responsibility or scope coverage. Sum across all cost centres for a program should equal 100%.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit cost allocation record was first created in the system.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this cost allocation applies, enabling year-over-year audit cost tracking and multi-year audit cycle cost management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit cost allocation record was last updated, supporting audit trail and change tracking.',
    CONSTRAINT pk_audit_cost_allocation PRIMARY KEY(`audit_cost_allocation_id`)
) COMMENT 'This association product represents the cost allocation relationship between audit programs and cost centres within the airline. It captures the budgeting and actual cost tracking for compliance audit activities across organizational units. Each record links one audit program to one cost centre with budget allocation amounts, actual costs incurred, allocation percentages, and fiscal tracking attributes that exist only in the context of this relationship. Enables compliance budget management, departmental audit cost reporting, and CASK attribution of regulatory compliance expenses.. Existence Justification: In airline operations, audit programs (IOSA, FAA ATOS, EASA inspections) span multiple organizational units - flight operations, maintenance, cabin crew, ground handling, and corporate functions all participate in regulatory audits. Conversely, each cost centre participates in multiple audit programs simultaneously (e.g., flight operations is audited under IOSA, FAA ATOS, and internal quality programs). The airline actively manages budget allocations and tracks actual costs per cost centre per audit program for compliance budget management and CASK attribution of regulatory expenses.';

CREATE OR REPLACE TABLE `airlines_ecm`.`compliance`.`cost_allocation` (
    `cost_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for this compliance cost allocation record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key to finance.cost_centre identifying the organizational unit receiving the cost allocation',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key to compliance.regulatory_requirement identifying the regulatory obligation whose costs are allocated',
    `allocation_driver_value` DECIMAL(18,2) COMMENT 'Quantitative value of the allocation driver used for this cost centre (e.g., 12500 flight hours, 450 employees, 2.5M ASK) that determines the cost_sharing_ratio',
    `allocation_method` STRING COMMENT 'Method used to determine the cost allocation to this cost centre: direct (directly attributable), activity_based (ABC costing), proportional (percentage split), headcount (per employee), flight_hours, ASK_based (per available seat kilometer)',
    `allocation_status` STRING COMMENT 'Current status of this cost allocation: active (currently applied), planned (future allocation), suspended (temporarily inactive), superseded (replaced by newer allocation)',
    `annual_compliance_cost` DECIMAL(18,2) COMMENT 'Total annual cost amount allocated to this cost centre for compliance with this specific regulatory requirement, in the cost centres controlling currency',
    `budget_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total compliance cost for this regulatory requirement allocated to this cost centre (0.00 to 100.00). Sum across all cost centres for a requirement should equal 100%.',
    `budget_version` STRING COMMENT 'SAP CO planning version identifier for the budget cycle associated with this allocation (e.g., PLAN0, FCST1, ACT)',
    `cost_sharing_ratio` DECIMAL(18,2) COMMENT 'Proportional cost sharing ratio used to distribute compliance costs to this cost centre based on activity drivers (e.g., flight hours, ASK, headcount). Used for dynamic cost allocation calculations.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this allocation record was created in the system',
    `effective_date` DATE COMMENT 'Date from which this cost allocation becomes effective and is applied in financial reporting and budget tracking',
    `expiry_date` DATE COMMENT 'Date on which this cost allocation expires or is superseded by a new allocation structure. Null indicates ongoing allocation.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this cost allocation applies (e.g., 2024, 2025)',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp when this allocation record was last modified',
    `notes` STRING COMMENT 'Free-text notes explaining the rationale for this allocation, special circumstances, or adjustments made by management accountants',
    CONSTRAINT pk_cost_allocation PRIMARY KEY(`cost_allocation_id`)
) COMMENT 'This association product represents the cost allocation relationship between regulatory requirements and cost centres. It captures how compliance costs for specific regulatory obligations are distributed across organizational cost centres, enabling accurate CASK attribution, departmental P&L reporting, and regulatory cost tracking. Each record links one regulatory requirement to one cost centre with the allocated cost amount, budget percentage, and validity period for that allocation.. Existence Justification: In airline operations, regulatory compliance costs are systematically allocated across multiple organizational cost centres because compliance activities span departments (e.g., CORSIA environmental compliance involves fuel procurement, operations planning, finance reporting, and sustainability teams). Each cost centre manages budgets for multiple regulatory requirements simultaneously (safety, environmental, consumer protection, operational approvals). Finance controllers and management accountants actively manage these allocations with specific cost amounts, budget percentages, allocation methods, and validity periods.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ADD CONSTRAINT `fk_compliance_regulatory_requirement_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ADD CONSTRAINT `fk_compliance_regulatory_authority_parent_authority_regulatory_authority_id` FOREIGN KEY (`parent_authority_regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ADD CONSTRAINT `fk_compliance_operating_certificate_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ADD CONSTRAINT `fk_compliance_operational_approval_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ADD CONSTRAINT `fk_compliance_ad_compliance_record_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_parent_filing_regulatory_filing_id` FOREIGN KEY (`parent_filing_regulatory_filing_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_filing`(`regulatory_filing_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ADD CONSTRAINT `fk_compliance_regulatory_filing_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ADD CONSTRAINT `fk_compliance_obligation_register_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ADD CONSTRAINT `fk_compliance_obligation_register_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ADD CONSTRAINT `fk_compliance_audit_event_audit_program_id` FOREIGN KEY (`audit_program_id`) REFERENCES `airlines_ecm`.`compliance`.`audit_program`(`audit_program_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ADD CONSTRAINT `fk_compliance_finding_audit_event_id` FOREIGN KEY (`audit_event_id`) REFERENCES `airlines_ecm`.`compliance`.`audit_event`(`audit_event_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ADD CONSTRAINT `fk_compliance_finding_previous_finding_id` FOREIGN KEY (`previous_finding_id`) REFERENCES `airlines_ecm`.`compliance`.`finding`(`finding_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ADD CONSTRAINT `fk_compliance_capa_finding_id` FOREIGN KEY (`finding_id`) REFERENCES `airlines_ecm`.`compliance`.`finding`(`finding_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ADD CONSTRAINT `fk_compliance_capa_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ADD CONSTRAINT `fk_compliance_capa_regulatory_violation_id` FOREIGN KEY (`regulatory_violation_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_violation`(`regulatory_violation_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ADD CONSTRAINT `fk_compliance_emissions_report_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ADD CONSTRAINT `fk_compliance_carbon_offset_emissions_report_id` FOREIGN KEY (`emissions_report_id`) REFERENCES `airlines_ecm`.`compliance`.`emissions_report`(`emissions_report_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ADD CONSTRAINT `fk_compliance_consumer_protection_case_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ADD CONSTRAINT `fk_compliance_regulatory_violation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ADD CONSTRAINT `fk_compliance_foreign_carrier_permit_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ADD CONSTRAINT `fk_compliance_exemption_waiver_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ADD CONSTRAINT `fk_compliance_exemption_waiver_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ADD CONSTRAINT `fk_compliance_self_assessment_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ADD CONSTRAINT `fk_compliance_channel_audit_assessment_audit_event_id` FOREIGN KEY (`audit_event_id`) REFERENCES `airlines_ecm`.`compliance`.`audit_event`(`audit_event_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ADD CONSTRAINT `fk_compliance_audit_cost_allocation_audit_program_id` FOREIGN KEY (`audit_program_id`) REFERENCES `airlines_ecm`.`compliance`.`audit_program`(`audit_program_id`);
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ADD CONSTRAINT `fk_compliance_cost_allocation_regulatory_requirement_id` FOREIGN KEY (`regulatory_requirement_id`) REFERENCES `airlines_ecm`.`compliance`.`regulatory_requirement`(`regulatory_requirement_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `airlines_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department Org Unit Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `aircraft_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Applicability');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `amendment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `applicability_scope` SET TAGS ('dbx_business_glossary_term' = 'Applicability Scope');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'airworthiness|operational|environmental|consumer_protection|safety|security');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compliance Frequency');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|in_progress|not_applicable|under_review');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `compliance_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Compliance Subcategory');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `criticality_level` SET TAGS ('dbx_business_glossary_term' = 'Criticality Level');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `criticality_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `internal_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Internal Policy Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `maximum_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Penalty Amount');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `next_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Compliance Review Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `operational_approval_type` SET TAGS ('dbx_business_glossary_term' = 'Operational Approval Type');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `penalty_description` SET TAGS ('dbx_business_glossary_term' = 'Penalty Description');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `reference_document_title` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Title');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `reference_document_url` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `reference_document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_deadline_days` SET TAGS ('dbx_business_glossary_term' = 'Reporting Deadline Days');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Reporting Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Requirement Code');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Requirement Description');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `requirement_title` SET TAGS ('dbx_business_glossary_term' = 'Requirement Title');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `route_applicability` SET TAGS ('dbx_business_glossary_term' = 'Route Applicability');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `superseded_by_requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Requirement Code');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_requirement` ALTER COLUMN `superseded_by_requirement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `parent_authority_regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Authority Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `audit_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Cycle in Months');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `authority_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Code');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `authority_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `authority_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `authority_status` SET TAGS ('dbx_business_glossary_term' = 'Authority Status');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `authority_status` SET TAGS ('dbx_value_regex' = 'active|inactive|superseded|merged|dissolved');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `authority_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Type');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `dissolved_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolved Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `enforcement_powers` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Powers');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Established Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'electronic_portal|email|postal_mail|fax|api|mixed');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `filing_portal_url` SET TAGS ('dbx_business_glossary_term' = 'Filing Portal Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `filing_portal_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Level');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `jurisdiction_level` SET TAGS ('dbx_value_regex' = 'international|regional|national|state_provincial|local');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Official Language Code');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `mailing_address` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `mailing_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `mailing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Administered');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `operating_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Certificate ID');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Home Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Owner Department Org Unit Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `aircraft_types_authorized` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Types Authorized');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `bilateral_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Bilateral Air Service Agreement (ASA) Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'active|suspended|revoked|expired|pending_renewal|under_review');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Certificate Type');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `document_repository_url` SET TAGS ('dbx_business_glossary_term' = 'Document Repository URL');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Effective Date');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `exemption_details` SET TAGS ('dbx_business_glossary_term' = 'Exemption Details');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `operational_approvals` SET TAGS ('dbx_business_glossary_term' = 'Operational Approvals');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `permit_conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions and Limitations');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Email Address');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Name');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `regulatory_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Phone Number');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `regulatory_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|approved|denied');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `route_market_coverage` SET TAGS ('dbx_business_glossary_term' = 'Route and Market Coverage');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `scope_of_operations` SET TAGS ('dbx_business_glossary_term' = 'Scope of Operations');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `airlines_ecm`.`compliance`.`operating_certificate` ALTER COLUMN `traffic_rights_type` SET TAGS ('dbx_business_glossary_term' = 'Traffic Rights Type (Freedoms of the Air)');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `operational_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Approval Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Owner Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `aircraft_type_icao_code` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type ICAO (International Civil Aviation Organization) Code');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `aircraft_type_icao_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,4}$');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `approval_conditions` SET TAGS ('dbx_business_glossary_term' = 'Approval Conditions and Limitations');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `approval_document_url` SET TAGS ('dbx_business_glossary_term' = 'Approval Document URL (Uniform Resource Locator)');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `approval_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference Number');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `approval_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Lifecycle Status');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|revoked|pending|withdrawn');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `approval_type` SET TAGS ('dbx_business_glossary_term' = 'Operational Approval Type');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `approval_type` SET TAGS ('dbx_value_regex' = 'ETOPS|CAT_II|CAT_III|RVSM|RNP|RNAV');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `compliance_program_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `decision_height_feet` SET TAGS ('dbx_business_glossary_term' = 'Decision Height in Feet');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Effective Date');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `etops_diversion_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'ETOPS (Extended-range Twin-engine Operational Performance Standards) Diversion Time in Minutes');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiry Date');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Audit Date');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `maintenance_program_reference` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Program Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `minimum_visibility_meters` SET TAGS ('dbx_business_glossary_term' = 'Minimum Visibility in Meters');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Operational Approval Remarks');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency in Months');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `rnp_specification` SET TAGS ('dbx_business_glossary_term' = 'RNP (Required Navigation Performance) Specification');
ALTER TABLE `airlines_ecm`.`compliance`.`operational_approval` ALTER COLUMN `training_requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement Description');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` SET TAGS ('dbx_subdomain' = 'obligation_tracking');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `ad_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Compliance Record ID');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `aircraft_id` SET TAGS ('dbx_business_glossary_term' = 'Aircraft ID');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `ad_number` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Directive (AD) Number');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `ad_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `aircraft_cycles_at_compliance` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Cycles at Compliance');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `aircraft_hours_at_compliance` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Hours at Compliance');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `amoc_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Alternative Method of Compliance (AMOC) Approval Number');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `amoc_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Alternative Method of Compliance (AMOC) Approved Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `applicability_status` SET TAGS ('dbx_business_glossary_term' = 'Applicability Status');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `applicability_status` SET TAGS ('dbx_value_regex' = 'applicable|not_applicable|conditionally_applicable');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `certifying_mechanic_license` SET TAGS ('dbx_business_glossary_term' = 'Certifying Mechanic License Number');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `certifying_mechanic_license` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `certifying_organization` SET TAGS ('dbx_business_glossary_term' = 'Certifying Organization');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `compliance_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Compliance Cost Amount');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `compliance_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `compliance_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Compliance Cost Currency');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `compliance_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `compliance_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Date');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `compliance_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Documentation Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `compliance_interval_cycles` SET TAGS ('dbx_business_glossary_term' = 'Compliance Interval Cycles');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `compliance_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Compliance Interval Days');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `compliance_interval_hours` SET TAGS ('dbx_business_glossary_term' = 'Compliance Interval Hours');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `compliance_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Method');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `compliance_method` SET TAGS ('dbx_value_regex' = 'inspection|modification|replacement|operational_limitation|alternative_method|terminating_action');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|in_progress|not_applicable|deferred|pending_inspection');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `deferral_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Deferral Authorization Number');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `deferral_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Deferral Expiry Date');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `inspection_findings` SET TAGS ('dbx_business_glossary_term' = 'Inspection Findings');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `parts_replaced` SET TAGS ('dbx_business_glossary_term' = 'Parts Replaced');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Compliance Remarks');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `service_bulletin_reference` SET TAGS ('dbx_business_glossary_term' = 'Service Bulletin (SB) Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `terminating_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Terminating Action Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `airlines_ecm`.`compliance`.`ad_compliance_record` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `ask_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Ask Plan Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `parent_filing_regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Filing Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `schedule_season_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Season Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_quarter` SET TAGS ('dbx_business_glossary_term' = 'Compliance Quarter');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Year');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `confidential_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Filing Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Path');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Description');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Reference Number');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|accepted|rejected|resubmission_required');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_title` SET TAGS ('dbx_business_glossary_term' = 'Filing Title');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Filing Remarks');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_officer_email` SET TAGS ('dbx_business_glossary_term' = 'Responsible Compliance Officer Email');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_officer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_officer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_officer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Compliance Officer Name');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_officer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_officer_phone` SET TAGS ('dbx_business_glossary_term' = 'Responsible Compliance Officer Phone Number');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_officer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `responsible_officer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `resubmission_due_date` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic_portal|email|postal_mail|fax|API');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_filing` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` SET TAGS ('dbx_subdomain' = 'obligation_tracking');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `obligation_register_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Register Identifier');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Program Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `applicable_aircraft_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Aircraft Type');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `applicable_operation_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Operation Type');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `compliance_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Method');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `compliance_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner Department');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|compliant|non_compliant|waived|overdue');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `emissions_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Emissions Reporting Period');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Evidence Location');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `evidence_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `non_compliance_impact` SET TAGS ('dbx_business_glossary_term' = 'Non-Compliance Impact');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `obligation_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Reference Number');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `obligation_reference_number` SET TAGS ('dbx_value_regex' = '^OBL-[A-Z0-9]{8,12}$');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `obligation_title` SET TAGS ('dbx_business_glossary_term' = 'Obligation Title');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `training_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Requirement Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `waiver_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiry Date');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`obligation_register` ALTER COLUMN `waiver_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reference Number');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `applicable_jurisdictions` SET TAGS ('dbx_business_glossary_term' = 'Applicable Jurisdictions');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `audit_authority` SET TAGS ('dbx_business_glossary_term' = 'Audit Authority or Body');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `audit_cycle_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Cycle Frequency');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `audit_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Typical Audit Duration in Days');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type Classification');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `coverage_areas` SET TAGS ('dbx_business_glossary_term' = 'Audit Coverage Areas');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `cycle_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Cycle Duration in Months');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `finding_classification_scheme` SET TAGS ('dbx_business_glossary_term' = 'Finding Classification Scheme');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `governing_standard` SET TAGS ('dbx_business_glossary_term' = 'Governing Standard or Regulation');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `last_audit_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Completion Date');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Code');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Cost Estimate');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Date');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Program Expiry Date');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Name');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Notes');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Status');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|pending_approval|archived');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `public_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_program` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Description');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Auditee Department Org Unit Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Audit End Date');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Audit Start Date');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `aircraft_type` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Designator');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `assessment_rating` SET TAGS ('dbx_business_glossary_term' = 'Assessment Rating or Score');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `audit_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Audit Duration in Days');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `audit_location_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Location Code');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `audit_location_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Location Type');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Notes');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `audit_report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Issued Date');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference Number');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Description');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `auditing_body` SET TAGS ('dbx_business_glossary_term' = 'Auditing Body or Organization');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `auditor_team_size` SET TAGS ('dbx_business_glossary_term' = 'Auditor Team Size');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard or Framework');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `compliance_gaps_identified` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gaps Identified');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Number');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Status');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|deferred');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Type');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'external_audit|regulatory_inspection|internal_audit|self_assessment|gap_analysis|readiness_review');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `follow_up_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `next_scheduled_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Audit Date');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Outcome');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Audit Date');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_event` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Finding Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Event Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `dangerous_goods_id` SET TAGS ('dbx_business_glossary_term' = 'Dg Declaration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `finding_identified_by_auditor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Identified By Auditor Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `finding_identified_by_auditor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `finding_identified_by_auditor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `finding_verified_by_auditor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Auditor Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `finding_verified_by_auditor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `finding_verified_by_auditor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `previous_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `security_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Security Screening Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `affected_area` SET TAGS ('dbx_business_glossary_term' = 'Affected Operational Area');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `affected_process` SET TAGS ('dbx_business_glossary_term' = 'Affected Business Process');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `airworthiness_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Impact Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `applicable_regulation` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulation or Standard');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Closure Date');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'major_non_conformance|minor_non_conformance|observation|opportunity_for_improvement|commendation|safety_concern');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Identification Date');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Reference Number');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `regulation_section` SET TAGS ('dbx_business_glossary_term' = 'Regulation Section or Clause');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `safety_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `airlines_ecm`.`compliance`.`finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Corrective and Preventive Action (CAPA) ID');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit ID');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Employee ID');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `capa_closure_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closure Approved By Employee ID');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `capa_closure_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `capa_verified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Employee ID');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `capa_verified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Finding ID');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `regulatory_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Violation Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost United States Dollars (USD)');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `actual_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `assigned_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Owner Name');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `assigned_owner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Number');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `capa_number` SET TAGS ('dbx_value_regex' = '^CAPA-[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Status');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `capa_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_verification|verified|closed|cancelled');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Type');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `capa_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|systemic|immediate|interim|permanent');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `closure_approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Closure Approved By Name');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `closure_approved_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate United States Dollars (USD)');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `non_conformance_description` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Description');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Priority');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `recurrence_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `risk_level_after` SET TAGS ('dbx_business_glossary_term' = 'Risk Level After Corrective and Preventive Action (CAPA)');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `risk_level_after` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `risk_level_before` SET TAGS ('dbx_business_glossary_term' = 'Risk Level Before Corrective and Preventive Action (CAPA)');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `risk_level_before` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `sms_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Management System (SMS) Integration Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `source_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Source Reference Number');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `source_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Source Type');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `verification_result` SET TAGS ('dbx_business_glossary_term' = 'Verification Result');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `verification_result` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|pending');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `verified_by_name` SET TAGS ('dbx_business_glossary_term' = 'Verified By Name');
ALTER TABLE `airlines_ecm`.`compliance`.`capa` ALTER COLUMN `verified_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `emissions_report_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Report ID');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `manifest_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Manifest Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `fuel_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `compliance_period` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period (Year)');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `compliance_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor (kg CO2 per kg Fuel)');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `emissions_calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Emissions Calculation Methodology');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `emissions_calculation_methodology` SET TAGS ('dbx_value_regex' = 'CORSIA CERT|ICAO Default|Actual Fuel Burn|Third Party Tool');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `fuel_burn_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Fuel Burn (Tonnes)');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'Jet A|Jet A-1|Jet B|Avgas|SAF|Biofuel');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `offset_obligation_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Offset Obligation (Tonnes CO2e)');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `offset_project_country` SET TAGS ('dbx_business_glossary_term' = 'Offset Project Country');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `offset_project_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `offset_project_name` SET TAGS ('dbx_business_glossary_term' = 'Offset Project Name');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `offset_registry` SET TAGS ('dbx_business_glossary_term' = 'Offset Registry');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `offset_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Offset Unit Type');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `offset_vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Offset Vintage Year');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `offsets_retired_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Offsets Retired (Tonnes CO2e)');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|shortfall|surplus');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Report Number');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `report_number` SET TAGS ('dbx_value_regex' = '^EMR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_verification|verified|accepted|rejected');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|ad_hoc|amendment');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `retirement_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Retirement Certificate Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `retirement_certificate_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `route_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `saf_percentage` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Aviation Fuel (SAF) Percentage');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Report Scope');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `scope` SET TAGS ('dbx_value_regex' = 'fleet_wide|route_specific|sector_specific|aircraft_specific');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `shortfall_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Shortfall (Tonnes CO2e)');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'online_portal|email|postal|API');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `surplus_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Surplus (Tonnes CO2e)');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `total_co2_emissions_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Total Carbon Dioxide (CO2) Emissions (Tonnes)');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `verification_statement_reference` SET TAGS ('dbx_business_glossary_term' = 'Verification Statement Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `verification_statement_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|verified|failed');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `verifier_accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Verifier Accreditation Number');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `verifier_accreditation_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `verifier_name` SET TAGS ('dbx_business_glossary_term' = 'Verifier Name');
ALTER TABLE `airlines_ecm`.`compliance`.`emissions_report` ALTER COLUMN `verifier_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `carbon_offset_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `emissions_report_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Report Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `additionality_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Additionality Confirmed Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `co_benefits_description` SET TAGS ('dbx_business_glossary_term' = 'Co-Benefits Description');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `corsia_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'CORSIA (Carbon Offsetting and Reduction Scheme for International Aviation) Eligible Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `offset_status` SET TAGS ('dbx_business_glossary_term' = 'Offset Status');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `offset_status` SET TAGS ('dbx_value_regex' = 'PURCHASED|HELD|RETIRED|CANCELLED|EXPIRED');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `offset_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Offset Unit Type');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `offset_unit_type` SET TAGS ('dbx_value_regex' = 'CORSIA_ELIGIBLE_EMISSION_UNIT|VOLUNTARY_CARBON_STANDARD|GOLD_STANDARD|CLIMATE_ACTION_RESERVE|AMERICAN_CARBON_REGISTRY|VERIFIED_CARBON_STANDARD');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `permanence_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Permanence Risk Rating');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `permanence_risk_rating` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `project_country_code` SET TAGS ('dbx_business_glossary_term' = 'Project Country Code');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `project_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `project_identifier` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Project Name');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'RENEWABLE_ENERGY|REFORESTATION|AFFORESTATION|METHANE_CAPTURE|ENERGY_EFFICIENCY|AVOIDED_DEFORESTATION');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `purchase_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Purchase Currency Code');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `purchase_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Date');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `purchase_price_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price Per Tonne');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `purchase_price_per_tonne` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `quantity_tonnes_co2e` SET TAGS ('dbx_business_glossary_term' = 'Quantity in Tonnes Carbon Dioxide Equivalent (CO2e)');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `registry_identifier` SET TAGS ('dbx_business_glossary_term' = 'Registry Identifier');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `registry_name` SET TAGS ('dbx_business_glossary_term' = 'Carbon Registry Name');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `retirement_certificate_reference` SET TAGS ('dbx_business_glossary_term' = 'Retirement Certificate Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_value_regex' = 'CORSIA_COMPLIANCE|VOLUNTARY_COMMITMENT|CORPORATE_SUSTAINABILITY|CUSTOMER_PROGRAM');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `total_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Amount');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `total_purchase_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `verification_body` SET TAGS ('dbx_business_glossary_term' = 'Verification Body');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `verification_standard` SET TAGS ('dbx_business_glossary_term' = 'Verification Standard');
ALTER TABLE `airlines_ecm`.`compliance`.`carbon_offset` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` SET TAGS ('dbx_subdomain' = 'obligation_tracking');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `consumer_protection_case_id` SET TAGS ('dbx_business_glossary_term' = 'Consumer Protection Case ID');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `ancillary_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `ancillary_refund_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Refund Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Case Manager Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `catering_order_id` SET TAGS ('dbx_business_glossary_term' = 'Catering Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Occurrence Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `accessibility_violation_flag` SET TAGS ('dbx_business_glossary_term' = 'Air Carrier Access Act (ACAA) Violation Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `accessibility_violation_type` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Violation Type');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `case_notes` SET TAGS ('dbx_business_glossary_term' = 'Case Notes');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Reference Number');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `case_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_resolution|resolved|closed|escalated');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `compensation_amount_total` SET TAGS ('dbx_business_glossary_term' = 'Total Compensation Amount');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `compensation_amount_total` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `compensation_amount_total` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `compensation_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `compensation_per_passenger` SET TAGS ('dbx_business_glossary_term' = 'Compensation Per Passenger');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `compensation_per_passenger` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `compensation_per_passenger` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `compensation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `compensation_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `compensation_required_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `complaint_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Complaint Receipt Date');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `dot_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Case Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `easa_case_reference` SET TAGS ('dbx_business_glossary_term' = 'European Union Aviation Safety Agency (EASA) Case Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `flight_date` SET TAGS ('dbx_business_glossary_term' = 'Flight Date');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `flight_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}[A-Z]?$');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `passenger_complaint_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Passenger Complaint Received Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `passenger_count_affected` SET TAGS ('dbx_business_glossary_term' = 'Passenger (Pax) Count Affected');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `regulatory_threshold_breached` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Breached Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `reported_to_authority_flag` SET TAGS ('dbx_business_glossary_term' = 'Reported to Authority Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `threshold_type` SET TAGS ('dbx_business_glossary_term' = 'Threshold Type');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `threshold_type` SET TAGS ('dbx_value_regex' = 'tarmac_delay_domestic|tarmac_delay_international|denied_boarding_involuntary|baggage_delay|cancellation_notice|refund_processing');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit of Measure');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'minutes|hours|days|passengers|dollars');
ALTER TABLE `airlines_ecm`.`compliance`.`consumer_protection_case` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `regulatory_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Violation Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `embargo_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Embargo Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `dangerous_goods_id` SET TAGS ('dbx_business_glossary_term' = 'Dg Declaration Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department Org Unit Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filing Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Case Status');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|upheld|overturned|settled|withdrawn');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `arrival_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Arrival Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `arrival_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `case_manager` SET TAGS ('dbx_business_glossary_term' = 'Case Manager Name');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `departure_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Departure Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `departure_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Discovery Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Final Disposition Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `enforcement_action_type` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Type');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `final_disposition` SET TAGS ('dbx_business_glossary_term' = 'Final Case Disposition');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `final_disposition` SET TAGS ('dbx_value_regex' = 'penalty_paid|settled|dismissed|overturned|certificate_action_taken');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `flight_number` SET TAGS ('dbx_business_glossary_term' = 'Flight Number');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `legal_counsel_assigned_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Assigned Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Airline Notification Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Payment Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Payment Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `penalty_amount_assessed` SET TAGS ('dbx_business_glossary_term' = 'Civil Penalty Amount Assessed');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `penalty_amount_assessed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `penalty_amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Civil Penalty Amount Paid');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `penalty_amount_paid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency Code');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `penalty_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `public_disclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Date');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Case Remarks and Notes');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity Level');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Detailed Description');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `violation_number` SET TAGS ('dbx_business_glossary_term' = 'Violation Reference Number');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `violation_status` SET TAGS ('dbx_business_glossary_term' = 'Violation Case Status');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `violation_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|contested|settled|closed|appealed');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type Classification');
ALTER TABLE `airlines_ecm`.`compliance`.`regulatory_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = 'operational|maintenance|safety|security|environmental|consumer_protection');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `foreign_carrier_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Foreign Carrier Permit Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Owner Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `route_id` SET TAGS ('dbx_business_glossary_term' = 'Route Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `aircraft_type_restriction` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type Restriction');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `bilateral_asa_reference` SET TAGS ('dbx_business_glossary_term' = 'Bilateral Air Service Agreement (ASA) Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `capacity_limit_seats` SET TAGS ('dbx_business_glossary_term' = 'Capacity Limit (Seats)');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `cargo_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Cargo Authorization Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `codeshare_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Codeshare Allowed Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `compliance_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `destination_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `frequency_limit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Limit');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `interline_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Interline Allowed Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Airport Code (IATA)');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `origin_airport_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `passenger_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Passenger Authorization Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `permit_conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `permit_document_url` SET TAGS ('dbx_business_glossary_term' = 'Permit Document Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|expired|revoked|under_review');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'foreign_carrier_permit|exemption|bilateral_entitlement|cabotage_authorization|fifth_freedom|technical_stop');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency (Months)');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `route_scope` SET TAGS ('dbx_business_glossary_term' = 'Route Scope');
ALTER TABLE `airlines_ecm`.`compliance`.`foreign_carrier_permit` ALTER COLUMN `traffic_rights_type` SET TAGS ('dbx_business_glossary_term' = 'Traffic Rights Type (Freedoms of the Air)');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` SET TAGS ('dbx_subdomain' = 'regulatory_oversight');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `exemption_waiver_id` SET TAGS ('dbx_business_glossary_term' = 'Exemption Waiver Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `flight_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Inventory Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `station_id` SET TAGS ('dbx_business_glossary_term' = 'Station Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `aircraft_type_icao_code` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type ICAO (International Civil Aviation Organization) Code');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `aircraft_type_icao_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `compliance_program_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `conditions_attached` SET TAGS ('dbx_business_glossary_term' = 'Conditions Attached');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `corsia_exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'CORSIA (Carbon Offsetting and Reduction Scheme for International Aviation) Exemption Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `covid_relief_flag` SET TAGS ('dbx_business_glossary_term' = 'COVID-19 Relief Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `document_reference_url` SET TAGS ('dbx_business_glossary_term' = 'Document Reference URL (Uniform Resource Locator)');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `etops_diversion_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'ETOPS (Extended-range Twin-engine Operational Performance Standards) Diversion Time Minutes');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `exemption_number` SET TAGS ('dbx_business_glossary_term' = 'Exemption Number');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `exemption_type` SET TAGS ('dbx_business_glossary_term' = 'Exemption Type');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `public_disclosure_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency Months');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `requesting_basis` SET TAGS ('dbx_business_glossary_term' = 'Requesting Basis');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `route_scope` SET TAGS ('dbx_business_glossary_term' = 'Route Scope');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `airlines_ecm`.`compliance`.`exemption_waiver` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `self_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Self Assessment Identifier');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Owner Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `assessment_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Completion Date');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `assessment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Assessment Frequency');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `assessment_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly|ad_hoc|event_driven');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `assessment_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Assessment Owner Name');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `assessment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Reference Number');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `assessment_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `assessment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Start Date');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|under_review|completed|cancelled|deferred');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `assessment_team_members` SET TAGS ('dbx_business_glossary_term' = 'Assessment Team Members');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'self_assessment|gap_analysis|readiness_review|internal_audit|pre_certification_review|regulatory_preparedness');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `compliance_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score Percentage');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `corrective_action_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `coverage_areas` SET TAGS ('dbx_business_glossary_term' = 'Coverage Areas');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `critical_gaps_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Gaps Count');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `evidence_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Documentation Reference');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `gaps_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Gaps Identified Count');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `major_gaps_count` SET TAGS ('dbx_business_glossary_term' = 'Major Gaps Count');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `minor_gaps_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Gaps Count');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `overall_compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Rating');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `overall_compliance_rating` SET TAGS ('dbx_value_regex' = 'compliant|substantially_compliant|partially_compliant|non_compliant|not_assessed');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `regulatory_readiness_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Readiness Status');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `regulatory_readiness_status` SET TAGS ('dbx_value_regex' = 'ready|substantially_ready|needs_improvement|not_ready');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `report_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Report Approved By');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Report Issued Date');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `requirements_met` SET TAGS ('dbx_business_glossary_term' = 'Requirements Met');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `airlines_ecm`.`compliance`.`self_assessment` ALTER COLUMN `total_requirements_assessed` SET TAGS ('dbx_business_glossary_term' = 'Total Requirements Assessed');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` SET TAGS ('dbx_association_edges' = 'compliance.audit_event,ancillary.sales_channel');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `channel_audit_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Audit Assessment Identifier');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `audit_event_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Audit Assessment - Audit Event Id');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `sales_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Audit Assessment - Ancillary Channel Id');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `auditor_assigned` SET TAGS ('dbx_business_glossary_term' = 'Auditor Assigned');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `channel_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Audit Date');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `channel_audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Channel Audit Notes');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `channel_audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Channel Audit Scope');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `channel_compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Channel Compliance Rating');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `channel_corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Channel Corrective Action Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `channel_corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Channel Corrective Action Required Flag');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `channel_corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Channel Corrective Action Status');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `channel_critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Channel Critical Findings Count');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `channel_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Channel Findings Count');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `channel_major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Channel Major Findings Count');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `channel_minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Channel Minor Findings Count');
ALTER TABLE `airlines_ecm`.`compliance`.`channel_audit_assessment` ALTER COLUMN `next_channel_audit_due` SET TAGS ('dbx_business_glossary_term' = 'Next Channel Audit Due Date');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` SET TAGS ('dbx_subdomain' = 'audit_management');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` SET TAGS ('dbx_association_edges' = 'compliance.audit_program,finance.cost_centre');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `audit_cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Allocation Identifier');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Allocation - Audit Program Id');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Allocation - Cost Centre Id');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Employee Identifier');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `actual_cost_to_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost To Date');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `allocated_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget Amount');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `allocation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `allocation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `allocation_notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `cost_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `airlines_ecm`.`compliance`.`audit_cost_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` SET TAGS ('dbx_subdomain' = 'obligation_tracking');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` SET TAGS ('dbx_association_edges' = 'compliance.regulatory_requirement,finance.cost_centre');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `cost_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Cost Allocation Identifier');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Identifier');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Identifier');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `allocation_driver_value` SET TAGS ('dbx_business_glossary_term' = 'Allocation Driver Value');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `annual_compliance_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual Compliance Cost');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `budget_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation Percentage');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `cost_sharing_ratio` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Ratio');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective Date');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Expiry Date');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `airlines_ecm`.`compliance`.`cost_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
