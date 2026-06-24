-- Schema for Domain: donor | Business: Ngo | Version: v2_mvm
-- Generated on: 2026-06-23 02:07:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`donor` COMMENT 'Source systems: Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committees). Donor/constituent relationship management and fundraising. Systems of record: Salesforce NPSP, Raisers Edge NXT, SAP CRM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`constituent` (
    `constituent_id` BIGINT COMMENT 'Unique identifier for the constituent record. Primary key for the constituent entity representing every donor, funder, and supporter in the CRM (Constituent Relationship Management) system.',
    `country_id` BIGINT COMMENT 'The three-letter ISO 3166-1 alpha-3 country code of the constituents mailing address (e.g., USA, GBR, CHE).',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: In-country donors, local foundations, and government ministries are managed by the responsible country office. Role-prefixed managing_ to distinguish from geographic country_id. Enables country offi',
    `communication_preference` STRING COMMENT 'The constituents preferred method of communication for stewardship, acknowledgment, and cultivation activities.. Valid values are `email|phone|mail|sms|no_contact`',
    `constituent_type` STRING COMMENT 'The classification of the constituent entity. Individual = private person major gift donor; Institutional = government agency or public sector donor (USAID, DFID/FCDO); Foundation = private or family foundation; Corporate = business or corporate sponsor; Bilateral = government-to-government donor (DAC member); Multilateral = international organization (UN agencies, World Bank); Household = family unit for joint giving. [ENUM-REF-CANDIDATE: individual|institutional|foundation|corporate|bilateral|multilateral|household — 7 candidates stripped; promote to reference product]',
    `country_of_origin` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code representing the constituents country of origin or headquarters. For bilateral and multilateral donors, this is the donor country. For foundations and corporates, this is the country of incorporation.. Valid values are `^[A-Z]{3}$`',
    `crm_source_record_code` STRING COMMENT 'The unique identifier of this constituent record in the source CRM system. Used for data lineage, reconciliation, and bi-directional sync.',
    `crm_source_system` STRING COMMENT 'The source CRM system from which this constituent record originated. Salesforce Nonprofit Cloud = Salesforce NPSP or Nonprofit Cloud; Raisers Edge NXT = Blackbaud Raisers Edge NXT; Other = other donor management system.. Valid values are `salesforce_nonprofit_cloud|raisers_edge_nxt|other`',
    `dac_member_flag` BOOLEAN COMMENT 'Indicates whether this constituent is a member of the OECD Development Assistance Committee. True = DAC member; False = not a DAC member. Used for ODA reporting and donor classification.',
    `deceased_date` DATE COMMENT 'The date on which the constituent passed away. Used for planned giving, estate gift tracking, and memorial acknowledgment.',
    `deceased_flag` BOOLEAN COMMENT 'Indicates whether the constituent is deceased. True = deceased; False = living. Used to prevent inappropriate communications and for planned giving tracking.',
    `email_opt_in_flag` BOOLEAN COMMENT 'Indicates whether the constituent has explicitly consented to receive email communications. True = opted in; False = opted out or consent not given.',
    `estimated_giving_capacity` DECIMAL(18,2) COMMENT 'The estimated total giving capacity of the constituent based on wealth screening, prospect research, and capacity analysis. Expressed in USD. Used for major gift solicitation strategy and campaign goal setting.',
    `first_gift_date` DATE COMMENT 'The date of the first gift or grant received from this constituent. Used for donor tenure analysis, anniversary recognition, and retention metrics.',
    `funder_classification` STRING COMMENT 'The classification of the funder based on international development and humanitarian standards. Bilateral = government-to-government donor; Multilateral = international organization (UN, World Bank); DAC Member = OECD Development Assistance Committee member country; Foundation = private or family foundation; Corporate = business or corporate sponsor; Individual = private individual donor; Other = other funder type. [ENUM-REF-CANDIDATE: bilateral|multilateral|dac_member|foundation|corporate|individual|other — 7 candidates stripped; promote to reference product]',
    `gdpr_consent_date` DATE COMMENT 'The date on which the constituent provided GDPR consent for data processing. Used for audit and compliance tracking.',
    `gdpr_consent_flag` BOOLEAN COMMENT 'Indicates whether the constituent has provided explicit consent for data processing under GDPR requirements. True = consent given; False = consent not given or withdrawn.',
    `iati_organization_identifier` STRING COMMENT 'The globally unique identifier for the organization as registered in the IATI registry. Used for transparency reporting and tracking ODA (Official Development Assistance) flows. Format: country-code-registration-agency-identifier (e.g., US-EIN-123456789, GB-COH-12345678).. Valid values are `^[A-Z]{2}-[A-Z]+-[0-9A-Z]+$`',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The negotiated indirect cost rate (also known as NICRA - Negotiated Indirect Cost Rate Agreement) that this donor allows for F&A (Facilities and Administration) costs. Expressed as a decimal (e.g., 0.1500 for 15%). Used for grant budgeting and financial planning.',
    `largest_gift_amount` DECIMAL(18,2) COMMENT 'The amount of the largest single gift or grant received from this constituent. Expressed in USD. Used for major gift benchmarking and solicitation strategy.',
    `last_gift_date` DATE COMMENT 'The date of the most recent gift or grant received from this constituent. Used for lapsed donor identification, recency-frequency-monetary (RFM) analysis, and re-engagement campaigns.',
    `legal_name` STRING COMMENT 'The full legal name of the constituent as registered with government authorities or as appears on official documents. For individuals, this is the full legal name; for organizations, this is the registered entity name.',
    `lifetime_giving_total` DECIMAL(18,2) COMMENT 'The cumulative total of all gifts and grants received from this constituent since the first gift date. Expressed in USD. Used for donor recognition, stewardship segmentation, and major gift qualification.',
    `mailing_address_line1` STRING COMMENT 'The first line of the constituents mailing address, typically containing street number and street name or PO Box.',
    `mailing_address_line2` STRING COMMENT 'The second line of the constituents mailing address, typically containing apartment, suite, or building information.',
    `mailing_city` STRING COMMENT 'The city or municipality of the constituents mailing address.',
    `mailing_postal_code` STRING COMMENT 'The postal code or ZIP code of the constituents mailing address.',
    `mailing_state_province` STRING COMMENT 'The state, province, or administrative region of the constituents mailing address.',
    `oda_eligibility_flag` BOOLEAN COMMENT 'Indicates whether gifts from this constituent qualify as ODA under DAC (Development Assistance Committee) criteria. True = ODA-eligible; False = not ODA-eligible. Used for IATI reporting and donor transparency.',
    `organization_affiliation` STRING COMMENT 'The name of the organization or institution the constituent is affiliated with. For individual donors, this may be their employer or foundation board membership; for institutional contacts, this is the parent agency or department.',
    `preferred_grant_modality` STRING COMMENT 'The type of grant funding this donor typically provides. Restricted = tied to specific projects or activities; Unrestricted = general operating support; Project = specific project funding; Program = program-level funding; Core = institutional core support; Capital = infrastructure or capital expenditure; Endowment = long-term endowment funding. [ENUM-REF-CANDIDATE: restricted|unrestricted|project|program|core|capital|endowment — 7 candidates stripped; promote to reference product]',
    `preferred_name` STRING COMMENT 'The name the constituent prefers to be addressed by in communications and correspondence. May differ from legal name for individuals (e.g., nickname, shortened name) or organizations (e.g., brand name, acronym).',
    `primary_email` STRING COMMENT 'The primary email address for constituent communication, gift acknowledgment, and stewardship correspondence. This is the operational source of truth for digital outreach.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'The primary telephone number for constituent contact. May include country code, area code, and extension for institutional donors.',
    `prospect_research_rating` STRING COMMENT 'The wealth screening and prospect research rating assigned to this constituent. A = highest capacity and propensity; B = high capacity; C = moderate capacity; D = lower capacity; Unrated = not yet screened. Used for major gift cultivation and campaign planning.. Valid values are `A|B|C|D|unrated`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this constituent record was first created in the system. Used for audit trail and data lineage.',
    `record_status` STRING COMMENT 'The current lifecycle status of this constituent record. Active = current and valid; Inactive = no longer active but retained for history; Merged = merged into another record; Duplicate = identified as duplicate; Archived = archived for compliance retention.. Valid values are `active|inactive|merged|duplicate|archived`',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this constituent record was last updated. Used for change tracking, data freshness monitoring, and incremental load processing.',
    `relationship_tier` STRING COMMENT 'The donor cultivation and stewardship tier assigned to this constituent based on giving history, capacity, and engagement. Major = major gift donor; Principal = top-tier institutional funder; Leadership = leadership circle member; Sustaining = recurring donor; Annual = annual fund donor; Lapsed = former donor; Prospect = prospective donor under cultivation. [ENUM-REF-CANDIDATE: major|principal|leadership|sustaining|annual|lapsed|prospect — 7 candidates stripped; promote to reference product]',
    `salutation` STRING COMMENT 'The formal greeting or title used when addressing the constituent in written or verbal communication (e.g., Mr., Ms., Dr., His Excellency, The Honorable).',
    CONSTRAINT pk_constituent PRIMARY KEY(`constituent_id`)
) COMMENT 'Master identity record and single source of truth for all donor and funder constituents across Salesforce Nonprofit Cloud and Raisers Edge NXT. Represents every entity that gives to or funds the NGO — individual major gift contributors, institutional donors (USAID, DFID/FCDO, UN agencies, DAC members), bilateral and multilateral agencies, private foundations, corporate sponsors, and households. Captures full constituent profile including legal name, preferred name/salutation, constituent type (individual, institutional, foundation, corporate, bilateral, multilateral, household), organization affiliation, IATI organization identifier, communication preferences, GDPR/data consent flags, deceased indicator, ODA eligibility flag, indirect cost rate (ICR/NICRA) terms, preferred grant modality, relationship tier, funder classification (bilateral, multilateral, DAC), country of origin, and CRM source system reference. All gift, pledge, grant, soft credit, and cultivation records reference this entity as the authoritative donor identity. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`prospect` (
    `prospect_id` BIGINT COMMENT 'Unique identifier for the prospect record. Primary key for the prospect entity.',
    `appeal_id` BIGINT COMMENT 'Foreign key linking to donor.appeal. Business justification: In Raisers Edge NXT, prospects are frequently associated with specific fundraising appeals or solicitation packages that triggered their identification or are being used to cultivate them. prospect al',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to donor.campaign. Business justification: Prospects are often identified through specific campaigns (e.g., acquisition campaign identifies new prospects). Campaign attribution for prospect identification enables source tracking and campaign e',
    `constituent_id` BIGINT COMMENT 'Reference to the constituent record in the CRM (Constituent Relationship Management) system. Links prospect to their constituent profile in Salesforce Nonprofit Cloud or Raisers Edge NXT.',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: Prospects are cultivated based on specific program outcome interests. prospect.program_interest_area is a denormalized text field; a proper FK to indicator normalizes this and enables prospect segment',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: NGO gift officers cultivate prospects for specific interventions matching donor interests. Direct link enables prospect portfolio reporting by intervention, aligning solicitation strategy to program f',
    `major_gift_opportunity_id` BIGINT COMMENT 'Foreign key linking to donor.major_gift_opportunity. Business justification: In Raisers Edge NXT and Salesforce NPSP, a prospect record represents the pre-qualification cultivation pipeline, and a major gift opportunity represents the active solicitation pipeline. When a prosp',
    `ability_score` STRING COMMENT 'Ability score component of the LAI (Linkage-Ability-Interest) assessment. Measures financial capacity to make a significant gift. Typically scored 1-5.',
    `board_affiliation` STRING COMMENT 'Known board memberships or trustee positions held by the prospect at other nonprofit organizations, foundations, or corporate boards. Indicates philanthropic engagement and network connections.',
    `communication_preference` STRING COMMENT 'Prospects preferred method of communication for cultivation and stewardship activities.. Valid values are `email|phone|mail|in_person|no_preference`',
    `conversion_date` DATE COMMENT 'Date when the prospect converted to an active donor by making their first gift or grant commitment. Null if not yet converted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prospect record was first created in the system. Audit trail field for data governance.',
    `cultivation_strategy` DOUBLE COMMENT 'Detailed narrative describing the cultivation strategy, engagement plan, and relationship-building approach for this prospect. Includes key talking points, areas of interest, preferred communication channels, and strategic next steps.',
    `disqualification_reason` STRING COMMENT 'Explanation for why the prospect was disqualified from active cultivation. Null if prospect is not disqualified. Examples: Insufficient capacity, No mission alignment, Unresponsive to outreach, Ethical concerns.',
    `donor_recognition_preference` STRING COMMENT 'Prospects stated preference for public recognition of their giving. Public (full recognition in donor lists and materials), Anonymous (no public attribution), Limited (recognition in select contexts only), No Preference (not yet specified).. Valid values are `public|anonymous|limited|no_preference`',
    `email_address` STRING COMMENT 'Primary email address for prospect communication and correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `estimated_capacity` DECIMAL(18,2) COMMENT 'Estimated total giving capacity of the prospect in USD. Based on wealth screening, research, and capacity assessment. For institutional donors, represents estimated annual grant-making budget available for alignment with organizational mission.',
    `estimated_gift_range_max` DECIMAL(18,2) COMMENT 'Maximum estimated gift amount expected from this prospect in USD. Upper bound of the anticipated solicitation range.',
    `estimated_gift_range_min` DECIMAL(18,2) COMMENT 'Minimum estimated gift amount expected from this prospect in USD. Lower bound of the anticipated solicitation range.',
    `expected_close_date` DATE COMMENT 'Anticipated date when the prospect is expected to make a commitment decision or when grant award notification is expected.',
    `geographic_interest` STRING COMMENT 'Geographic regions or countries where the prospect has expressed interest in supporting programs. Comma-separated list of ISO 3166-1 alpha-3 country codes or regional descriptors.',
    `identification_date` DATE COMMENT 'Date when the prospect was first identified and entered into the cultivation pipeline. Marks the beginning of the prospect lifecycle.',
    `interest_score` STRING COMMENT 'Interest score component of the LAI (Linkage-Ability-Interest) assessment. Measures alignment of prospects philanthropic interests with organizational mission and programs. Typically scored 1-5.',
    `last_contact_date` DATE COMMENT 'Date of the most recent meaningful contact or engagement with the prospect. Includes meetings, calls, events, correspondence.',
    `last_contact_type` STRING COMMENT 'Type of the most recent contact or engagement activity with the prospect. [ENUM-REF-CANDIDATE: meeting|phone_call|email|event|site_visit|proposal_submission|other — 7 candidates stripped; promote to reference product]',
    `linkage_score` STRING COMMENT 'Linkage score component of the LAI (Linkage-Ability-Interest) assessment. Measures strength of existing connections to the organization (board members, staff, volunteers, beneficiaries). Typically scored 1-5.',
    `mailing_address` STRING COMMENT 'Full mailing address for prospect correspondence. Includes street address, city, state/province, postal code, and country.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this prospect record was last modified. Audit trail field for data governance and change tracking.',
    `prospect_name` STRING COMMENT 'Full legal or preferred name of the prospective donor or funder. For institutional donors, this is the organization name.',
    `next_action_date` DATE COMMENT 'Scheduled date for the next cultivation activity or touchpoint with this prospect. Used for pipeline management and follow-up tracking.',
    `next_action_description` STRING COMMENT 'Description of the planned next cultivation action or engagement activity (e.g., Schedule site visit, Send program impact report, Invite to annual gala, Submit grant proposal).',
    `phone_number` STRING COMMENT 'Primary phone number for prospect contact. Includes country code for international prospects.',
    `previous_giving_history` STRING COMMENT 'Summary of the prospects known philanthropic giving history to other organizations or prior gifts to this organization. Includes gift amounts, recipient organizations, and giving patterns.',
    `probability_percentage` DECIMAL(18,2) COMMENT 'Estimated probability (0-100%) that this prospect will convert to an active donor and make a gift. Used for pipeline forecasting and weighted revenue projections.',
    `prospect_status` STRING COMMENT 'Current operational status of the prospect record. Active (currently being cultivated), Inactive (no current engagement), Disqualified (determined not viable), Converted (became active donor), On Hold (temporarily paused cultivation).. Valid values are `active|inactive|disqualified|converted|on_hold`',
    `prospect_type` STRING COMMENT 'Classification of the prospect by donor category. Individual (major gift prospects), Foundation (private/family/community foundations), Corporate (corporate sponsors), Institutional (USAID, DFID, DAC members), Government (bilateral government donors), Multilateral (UN agencies, World Bank, regional development banks).. Valid values are `individual|foundation|corporate|institutional|government|multilateral`',
    `qualification_date` DATE COMMENT 'Date when the prospect was qualified as a viable cultivation target after initial research and assessment. Null if not yet qualified.',
    `rating` STRING COMMENT 'Qualitative rating assigned by prospect research or major gift officer indicating overall prospect quality and likelihood of conversion. A+ (highest priority, strongest capacity and affinity), D (lowest priority).. Valid values are `A+|A|B+|B|C+|C|D`',
    `research_stage` STRING COMMENT 'Current stage of prospect research activities. Not Started (no research conducted), Preliminary (initial screening and public records review), In Depth (comprehensive research including wealth screening and relationship mapping), Completed (research finalized and briefing prepared), Ongoing Monitoring (periodic updates and news monitoring).. Valid values are `not_started|preliminary|in_depth|completed|ongoing_monitoring`',
    `solicitation_amount` DECIMAL(18,2) COMMENT 'Specific dollar amount being requested or proposed in the current solicitation. Null if not yet at solicitation stage.',
    `solicitation_date` DATE COMMENT 'Date when the formal ask or grant proposal was submitted to the prospect. Null if not yet solicited.',
    `source_of_wealth` STRING COMMENT 'Primary source of the prospects wealth or funding capacity (e.g., Technology entrepreneur, Inherited wealth, Real estate, Government appropriation, Endowment income). For institutional donors, describes funding source.',
    `stage` STRING COMMENT 'Current stage in the donor cultivation pipeline lifecycle. Identification (newly identified prospect), Qualification (research and capacity assessment underway), Cultivation (relationship building and engagement), Solicitation (active proposal or ask), Negotiation (terms and agreement discussion), Stewardship (post-gift relationship management).. Valid values are `identification|qualification|cultivation|solicitation|negotiation|stewardship`',
    `wealth_screening_score` DECIMAL(18,2) COMMENT 'Quantitative wealth screening score from third-party wealth screening service (e.g., WealthEngine, iWave). Typically scaled 0-100 indicating relative wealth capacity.',
    CONSTRAINT pk_prospect PRIMARY KEY(`prospect_id`)
) COMMENT 'Prospect research and donor cultivation pipeline record managed in Raisers Edge NXT and Salesforce Nonprofit Cloud. Tracks prospective donors and funders through the cultivation lifecycle from identification through qualification, cultivation, solicitation, and stewardship. Captures prospect rating, estimated giving capacity, wealth screening score, research stage, assigned major gift officer, next action date, cultivation strategy notes, and linkage-ability-interest (LAI) assessment. Supports the Donor Cultivation and Fundraising core business process. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`gift` (
    `gift_id` BIGINT COMMENT 'Unique identifier for the gift transaction. Primary key for the gift data product.',
    `appeal_id` BIGINT COMMENT 'Reference to the specific appeal or solicitation within a campaign that generated this gift.',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign that solicited or attributed this gift.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Country offices process and receipt gifts for IATI financial reporting and office-level fundraising dashboards. NGO finance teams run gift income reports by country office for budget management and do',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Emergency gifts (disaster relief donations) are a distinct gift type requiring emergency-level fundraising totals for OCHA reporting and donor compliance. Enables emergency income tracking, flash appe',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Every gift in an NGO fundraising system is designated to a specific donor fund — this is a fundamental financial and compliance requirement. The gifts restriction_type and restriction_description des',
    `major_gift_opportunity_id` BIGINT COMMENT 'Foreign key linking to donor.major_gift_opportunity. Business justification: Gifts can close major gift opportunities. Linking closed opportunities to realized gifts enables pipeline conversion tracking, forecasting accuracy analysis, and gift officer performance measurement. ',
    `original_gift_id` BIGINT COMMENT 'Reference to the original employee gift that this matching gift is matching. Populated only for matching gifts.',
    `pledge_id` BIGINT COMMENT 'Foreign key linking to donor.pledge. Business justification: Gifts can be payments against pledges. This FK is CRITICAL for pledge fulfillment tracking, balance calculation, and installment schedule management. Nullable (not all gifts are pledge payments; some ',
    `constituent_id` BIGINT COMMENT 'Reference to the donor who made this gift. Links to the donor master record in the donor domain.',
    `acknowledgement_date` DATE COMMENT 'Date the donor acknowledgement or thank-you letter was sent for this gift.',
    `acknowledgement_type` STRING COMMENT 'Classification of the donor acknowledgement or thank-you communication sent for this gift. [ENUM-REF-CANDIDATE: standard|personalized|major-gift|planned-giving|corporate|foundation|none — 7 candidates stripped; promote to reference product]',
    `amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the gift in the transaction currency before any adjustments or fees.',
    `anonymous_flag` BOOLEAN COMMENT 'Indicates whether the donor requested anonymity for this gift in public recognition and donor lists.',
    `batch_number` STRING COMMENT 'Gift processing batch identifier for grouping gifts deposited or processed together for reconciliation and audit purposes.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Transaction processing fees or costs deducted from the gross gift amount (e.g., credit card fees, wire transfer fees).',
    `gift_date` DATE COMMENT 'The date the gift was received or pledged. This is the principal business event timestamp for revenue recognition per FASB ASC 958.',
    `gift_number` STRING COMMENT 'Externally-known unique business identifier for this gift transaction, used for donor communication and receipt references.',
    `gift_status` STRING COMMENT 'Current lifecycle status of the gift transaction in the processing workflow.. Valid values are `pending|received|processed|acknowledged|refunded|cancelled`',
    `gift_type` STRING COMMENT 'Discriminator indicating the nature and form of the gift. Determines processing rules, revenue recognition treatment, and IRS substantiation requirements. [ENUM-REF-CANDIDATE: cash|check|wire|in-kind|stock|cryptocurrency|matching|tribute|pledge|recurring|refund|adjustment — 12 candidates stripped; promote to reference product]',
    `gl_posting_date` DATE COMMENT 'Date this gift transaction was posted to the general ledger for financial reporting.',
    `goods_services_value` DECIMAL(18,2) COMMENT 'Fair market value of any goods or services provided to the donor in exchange for the gift, required for IRS substantiation and deductibility calculation.',
    `honoree_name` STRING COMMENT 'Full name of the person being honored or memorialized by this tribute gift. Populated only when tribute_flag is true.',
    `irs_compliant_flag` BOOLEAN COMMENT 'Indicates whether the gift acknowledgement includes IRS-required substantiation language for charitable contribution deductions per IRS Publication 1771.',
    `match_approval_status` STRING COMMENT 'Current status of the matching gift request with the employer. Populated only for matching gifts.. Valid values are `pending|approved|denied|paid`',
    `match_ratio` DECIMAL(18,2) COMMENT 'The employer matching ratio (e.g., 1.00 for 1:1, 2.00 for 2:1, 0.50 for 1:2). Populated only for matching gifts.',
    `match_request_date` DATE COMMENT 'Date the matching gift request was submitted to the employer. Populated only for matching gifts.',
    `matching_gift_flag` BOOLEAN COMMENT 'Indicates whether this gift is a corporate matching gift from an employer matching an employees donation.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount received after deducting processing fees, transaction costs, or goods-and-services fair market value per IRS requirements.',
    `notification_recipient_address` STRING COMMENT 'Mailing address for sending tribute gift notification to the honorees family or designated recipient.',
    `notification_recipient_name` STRING COMMENT 'Name of the person who should be notified about this tribute gift (typically a family member of the honoree).',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether the tribute gift notification has been sent to the designated recipient.',
    `payment_channel` DECIMAL(18,2) COMMENT 'The interface or touchpoint through which the donor made the gift, used for campaign attribution and channel effectiveness analysis. [ENUM-REF-CANDIDATE: online|mobile-app|direct-mail|phone|in-person|event|major-gift-officer|peer-to-peer|text-to-give|other — 10 candidates stripped; promote to reference product]',
    `payment_method` DECIMAL(18,2) COMMENT 'The financial instrument or mechanism used to make the gift payment. [ENUM-REF-CANDIDATE: credit-card|debit-card|ach|wire-transfer|check|cash|paypal|stock-transfer|cryptocurrency|mobile-payment|other — 11 candidates stripped; promote to reference product]',
    `receipt_number` STRING COMMENT 'Unique receipt number issued for this gift for IRS substantiation and donor tax deduction purposes.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gift record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this gift record was last modified in the system.',
    `refund_flag` BOOLEAN COMMENT 'Indicates whether this record represents a gift refund or reversal transaction.',
    `refund_reason` STRING COMMENT 'Explanation or business reason for refunding or reversing this gift. Populated only when refund_flag is true.',
    `restriction_description` STRING COMMENT 'Detailed narrative of any donor-imposed restrictions, purpose designations, or conditions on the use of the gift funds.',
    `restriction_type` STRING COMMENT 'Classification of donor-imposed restrictions on the use of the gift per FASB ASC 958 net asset classification requirements.. Valid values are `unrestricted|temporarily-restricted|permanently-restricted`',
    `tribute_flag` BOOLEAN COMMENT 'Indicates whether this gift is made in honor or memory of another person (tribute gift).',
    `tribute_type` STRING COMMENT 'Classification of the tribute gift as either in honor of a living person or in memory of a deceased person. Populated only when tribute_flag is true.. Valid values are `in-honor-of|in-memory-of`',
    CONSTRAINT pk_gift PRIMARY KEY(`gift_id`)
) COMMENT 'Authoritative transactional ledger and single source of truth for every financial transaction in the donor domain — gifts, donations, matching gifts, tribute gifts, refunds, adjustments, and acknowledgements — processed through Salesforce Nonprofit Cloud and Raisers Edge NXT. This is the ONE table that answers what is this donors total giving? Captures gift date, amount, currency, gift type discriminator (cash, check, wire, in-kind, stock, crypto, matching, tribute, refund/adjustment, recurring), fund designation, campaign and appeal attribution, gift source (online, direct mail, event, major gift officer), payment method, batch reference, anonymous flag, restricted vs. unrestricted designation, and GL posting reference. For matching gifts: match ratio, matching employer/corporation, match request date, match approval status, match payment received date, maximum match amount. For tribute gifts: tribute type (in-memoriam, in-honor-of), honoree name, honoree relationship, notification recipient, notification sent flag. For refunds/adjustments: original gift reference, refund date, refund amount, refund reason, refund method, GL reversal reference. For acknowledgements: acknowledgement type, acknowledgement date, receipt number, delivery method, acknowledgement status, IRS-compliant language flag, goods-or-services disclosure. Core financial transaction for donor revenue recognition per FASB ASC 958 and IRS 501(c)(3) substantiation requirements. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`pledge` (
    `pledge_id` BIGINT COMMENT 'Unique identifier for the pledge commitment record. Primary key.',
    `appeal_id` BIGINT COMMENT 'Reference to the specific appeal or solicitation that generated this pledge.',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign associated with this pledge.',
    `constituent_id` BIGINT COMMENT 'Reference to the donor who made this pledge commitment.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Country offices manage pledge pipelines for cash flow forecasting and operational planning. Office directors need pledge attribution for their portfolio. Standard NGO CRM practice — pledge pipeline re',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Pledges in NGO fundraising are designated to specific donor funds, establishing the programmatic or operational purpose the donor intends to support over the pledge period. This FK is essential for fu',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Restricted pledges in NGOs are designated to specific interventions. Direct link enables restricted pledge fulfillment reporting against intervention budgets — a core NGO financial accountability requ',
    `major_gift_opportunity_id` BIGINT COMMENT 'Foreign key linking to donor.major_gift_opportunity. Business justification: Pledges can result from major gift opportunities (e.g., major gift solicitation results in multi-year pledge commitment). Linking pipeline to commitment enables conversion tracking and forecasting. Nu',
    `acknowledgment_date` DATE COMMENT 'The date on which the pledge acknowledgment was sent to the donor.',
    `acknowledgment_sent` BOOLEAN COMMENT 'Indicates whether a pledge acknowledgment letter or receipt has been sent to the donor.',
    `amount_paid` DECIMAL(18,2) COMMENT 'The cumulative amount paid to date across all installments. Updated as installment payments are received.',
    `balance_outstanding` DECIMAL(18,2) COMMENT 'The remaining unpaid balance on the pledge. Calculated as total_pledge_amount minus amount_paid.',
    `cancellation_date` DATE COMMENT 'The date on which the donor or organization cancelled the pledge commitment. Populated only when pledge_status is cancelled.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the pledge was cancelled (e.g., donor request, duplicate entry, data entry error).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this pledge record was first created in the system.',
    `first_installment_date` DATE COMMENT 'The scheduled due date for the first installment payment.',
    `fulfillment_date` DATE COMMENT 'The date on which the pledge was fully paid and marked as fulfilled. Populated only when pledge_status is fulfilled.',
    `installment_frequency` STRING COMMENT 'The recurring schedule for installment payments. One-time for single-payment pledges; monthly, quarterly, semi-annual, annual for standard recurring schedules; custom for irregular or donor-specified schedules.. Valid values are `one_time|monthly|quarterly|semi_annual|annual|custom`',
    `installments_paid` STRING COMMENT 'The count of installments that have been fully paid to date. Updated as installment payments are received.',
    `installments_remaining` STRING COMMENT 'The count of installments that are still unpaid. Calculated as number_of_installments minus installments_paid.',
    `is_anonymous` BOOLEAN COMMENT 'Indicates whether the donor has requested that this pledge be kept anonymous in public recognition and reporting.',
    `is_matching_gift_eligible` BOOLEAN COMMENT 'Indicates whether this pledge is eligible for corporate matching gift programs.',
    `is_recurring` BOOLEAN COMMENT 'Indicates whether this pledge is a recurring sustainer commitment with ongoing installments beyond the initial schedule.',
    `last_installment_date` DATE COMMENT 'The scheduled due date for the final installment payment.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'The amount of the most recent installment payment received.',
    `last_payment_date` DATE COMMENT 'The date on which the most recent installment payment was received.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this pledge record was last modified in the system.',
    `next_installment_amount` DECIMAL(18,2) COMMENT 'The scheduled amount for the next unpaid installment.',
    `next_installment_due_date` DATE COMMENT 'The due date for the next unpaid installment. Used for reminder generation and overdue tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about the pledge, including special donor instructions, stewardship considerations, or internal processing notes.',
    `number_of_installments` STRING COMMENT 'The total number of scheduled installment payments for this pledge. For one-time pledges, this is 1.',
    `payment_method` DECIMAL(18,2) COMMENT 'The primary payment instrument or method the donor intends to use for installment payments.',
    `pledge_date` DATE COMMENT 'The date on which the donor made the pledge commitment. This is the principal business event timestamp for the pledge.',
    `pledge_number` STRING COMMENT 'Human-readable business identifier for the pledge commitment, often displayed on donor communications and receipts.',
    `pledge_status` STRING COMMENT 'Current lifecycle status of the pledge commitment. Active indicates ongoing installment schedule; fulfilled indicates all installments paid; lapsed indicates overdue with no recent payment; written-off indicates uncollectible; cancelled indicates donor withdrew commitment; pending indicates awaiting approval or activation.. Valid values are `active|fulfilled|lapsed|written_off|cancelled|pending`',
    `pledge_type` STRING COMMENT 'Classification of the pledge based on its purpose and structure. Standard for general multi-installment pledges; sustainer for recurring monthly giving; major gift for high-value commitments; planned giving for estate or deferred gifts; capital campaign for infrastructure projects; endowment for permanent fund contributions.. Valid values are `standard|sustainer|major_gift|planned_giving|capital_campaign|endowment`',
    `reminder_schedule` STRING COMMENT 'The timing for automated payment reminders sent to the donor before each installment due date.. Valid values are `none|7_days_before|14_days_before|30_days_before|custom`',
    `total_pledge_amount` DECIMAL(18,2) COMMENT 'The total monetary value committed by the donor across all installments. This is the gross pledge amount before any payments.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'The outstanding balance amount that was written off. Populated only when pledge_status is written_off.',
    `write_off_date` DATE COMMENT 'The date on which the pledge was written off as uncollectible. Populated only when pledge_status is written_off.',
    `write_off_reason` STRING COMMENT 'Free-text explanation for why the pledge was written off (e.g., donor deceased, donor financial hardship, unable to contact, donor dispute).',
    CONSTRAINT pk_pledge PRIMARY KEY(`pledge_id`)
) COMMENT 'Tracks multi-installment giving commitments, pledge agreements, and their individual installment schedules from donors, managed in Raisers Edge NXT and Salesforce Nonprofit Cloud. Captures pledge date, total pledge amount, installment schedule (monthly, quarterly, annual), number of installments, pledge balance outstanding, pledge status (active, fulfilled, lapsed, written-off), fund designation, campaign, appeal, reminder schedule, and write-off reason. Includes installment-level detail: individual due dates, scheduled amounts, actual payment dates, amounts paid, installment status (scheduled, paid, overdue, skipped, waived), payment method, and linked gift reference upon payment. Enables granular pledge fulfillment tracking, overdue installment identification, automated reminder generation, and BvA (Budget vs. Actual) reconciliation for pledged revenue. Distinct from gift — a pledge is a commitment to give, not a completed transaction. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` (
    `major_gift_opportunity_id` BIGINT COMMENT 'Unique identifier for the major gift opportunity record. Primary key for this entity.',
    `appeal_id` BIGINT COMMENT 'Foreign key linking to donor.appeal. Business justification: Major gift opportunities can be generated from specific appeals (e.g., direct mail appeal identifies a major gift prospect). Tracking appeal attribution enables ROI analysis and source channel reporti',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign this opportunity is associated with, if applicable.',
    `constituent_id` BIGINT COMMENT 'Reference to the donor or prospect associated with this major gift opportunity. Links to the donor master record in the CRM system.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Major gift officers are organized by country office; country directors participate in cultivation and solicitation. Pipeline reports and weighted revenue forecasts are run by country office. Essential',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Major gift opportunities are solicited for specific programmatic purposes or donor-designated funds. The major_gift_opportunity has gift_purpose (STRING) and restriction_type (STRING) as free-text des',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Major gift officers in NGOs develop proposals tied to specific interventions. Direct link enables tracking which intervention a major gift opportunity is designated for, supporting proposal developmen',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Major gift opportunities are frequently tied to specific project sites — naming rights, facility funding, site-specific capital campaigns. Gift purpose and donor recognition are site-specific. Enables',
    `actual_close_date` DATE COMMENT 'Actual date when the opportunity was closed (won or lost). Populated when solicitation_stage reaches closed_won or closed_lost.',
    `ask_amount` DECIMAL(18,2) COMMENT 'The specific dollar amount being requested from the donor in this solicitation. Represents the formal ask figure.',
    `ask_strategy` DOUBLE COMMENT 'Narrative description of the solicitation approach, cultivation plan, and key messaging tailored to this donors interests and capacity.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this major gift opportunity record was first created in the system.',
    `donor_recognition_level` STRING COMMENT 'Anticipated recognition tier or giving society membership the donor will qualify for if the gift is secured (e.g., Leadership Circle, Legacy Society).',
    `expected_close_date` DATE COMMENT 'Anticipated date when the donor is expected to make a commitment decision or when the gift will be secured.',
    `expected_gift_amount` DECIMAL(18,2) COMMENT 'The anticipated or forecasted gift amount based on donor capacity, engagement level, and cultivation progress. May differ from ask amount.',
    `fiscal_year` STRING COMMENT 'The organizations fiscal year in which this opportunity is expected to close, used for annual fundraising goal tracking and reporting.',
    `gift_purpose` STRING COMMENT 'Detailed description of the intended use or program impact of the gift, aligned with donor interests and organizational priorities.',
    `gift_type` STRING COMMENT 'Classification of the expected gift instrument or vehicle (e.g., outright cash, multi-year pledge, bequest, stock transfer).. Valid values are `cash|pledge|planned_giving|in_kind|stock|real_estate`',
    `is_active` BOOLEAN COMMENT 'Flag indicating whether this opportunity is currently active in the pipeline. False for closed opportunities or those marked inactive.',
    `is_anonymous` BOOLEAN COMMENT 'Flag indicating whether the donor has requested anonymity for this gift. True if donor wishes to remain anonymous in public recognition.',
    `is_matching_gift_eligible` BOOLEAN COMMENT 'Flag indicating whether this gift is eligible for corporate matching gift programs through the donors employer.',
    `last_contact_date` DATE COMMENT 'Date of the most recent substantive interaction or touchpoint with the donor regarding this opportunity.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this opportunity record was last updated or modified.',
    `loss_reason` STRING COMMENT 'Explanation or categorization of why the opportunity was closed-lost, if applicable. Used for pipeline analysis and strategy refinement.',
    `next_step_action` STRING COMMENT 'Description of the next planned cultivation or solicitation activity (e.g., site visit, proposal submission, follow-up meeting).',
    `next_step_date` DATE COMMENT 'Scheduled date for the next cultivation or solicitation activity with this prospect.',
    `notes` STRING COMMENT 'Confidential internal notes and observations about the opportunity, donor relationship dynamics, cultivation history, and strategic considerations.',
    `opportunity_code` STRING COMMENT 'Unique business identifier or tracking code for this opportunity, used for external reporting and donor communications.',
    `opportunity_name` STRING COMMENT 'Descriptive name or title for this major gift opportunity, typically including donor name and purpose (e.g., Smith Foundation - WASH Program Endowment).',
    `probability_percentage` DECIMAL(18,2) COMMENT 'Estimated likelihood (0-100%) that this opportunity will close successfully, based on donor engagement, capacity, and stage progression.',
    `proposal_reference` STRING COMMENT 'Reference number or identifier for the formal written proposal or case for support submitted to the donor, if applicable.',
    `restriction_type` STRING COMMENT 'Classification of donor-imposed restrictions on the gift per FASB ASC 958 standards for not-for-profit accounting.. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `solicitation_stage` STRING COMMENT 'Current stage in the major gift solicitation pipeline. Tracks progression from initial identification through cultivation, ask, and closure. [ENUM-REF-CANDIDATE: identification|qualification|cultivation|solicitation|negotiation|stewardship|closed_won|closed_lost — 8 candidates stripped; promote to reference product]',
    `source_channel` STRING COMMENT 'The channel or method through which this major gift opportunity was originally identified or sourced. [ENUM-REF-CANDIDATE: direct_mail|event|peer_referral|board_introduction|prospect_research|planned_giving|online — 7 candidates stripped; promote to reference product]',
    `stage_changed_date` TIMESTAMP COMMENT 'Timestamp when the solicitation_stage was last changed, used to track velocity through the pipeline.',
    `weighted_value` DECIMAL(18,2) COMMENT 'Calculated forecast value (expected_gift_amount × probability_percentage) used for revenue forecasting and pipeline analysis.',
    CONSTRAINT pk_major_gift_opportunity PRIMARY KEY(`major_gift_opportunity_id`)
) COMMENT 'Pipeline management record for major gift solicitations tracked in Raisers Edge NXT and Salesforce Nonprofit Cloud. Represents a specific ask or solicitation opportunity with a named prospect or donor. Captures opportunity name, ask amount, expected gift amount, probability percentage, solicitation stage (identification, qualification, cultivation, solicitation, stewardship, closed-won, closed-lost), expected close date, assigned major gift officer, fund designation, campaign, proposal reference, and ask strategy. Enables major gift pipeline reporting and revenue forecasting. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`campaign` (
    `campaign_id` BIGINT COMMENT 'Unique identifier for the fundraising campaign. Primary key.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Campaigns are often country-specific (e.g., Yemen Crisis Appeal, Bangladesh Rohingya Response) for donor targeting, regulatory compliance, and financial reporting. Links campaign fundraising to operat',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that this campaign is raising funds for, enabling fund accounting and impact tracking.',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: NGO campaigns require a governing MEAL plan defining monitoring, evaluation, accountability, and learning protocols. Fundraising campaigns are pitched to donors with reference to the MEAL framework. C',
    `parent_campaign_id` BIGINT COMMENT 'Reference to a parent campaign if this campaign is part of a larger multi-phase or hierarchical campaign structure.',
    `acknowledgment_template` STRING COMMENT 'Name or identifier of the donor acknowledgment letter or email template used for gifts to this campaign.',
    `appeal_channel` STRING COMMENT 'Primary communication channel used to solicit donations for this campaign. [ENUM-REF-CANDIDATE: direct_mail|email|social_media|website|event|phone|peer_to_peer — 7 candidates stripped; promote to reference product]',
    `appeal_description` STRING COMMENT 'Detailed narrative describing the campaigns mission, beneficiaries, and impact story used in donor communications.',
    `campaign_status` STRING COMMENT 'Current lifecycle status of the campaign indicating its operational state.. Valid values are `planned|active|completed|cancelled|on_hold`',
    `campaign_type` STRING COMMENT 'Classification of the fundraising campaign by its strategic purpose and donor engagement model.. Valid values are `annual_fund|capital_campaign|emergency_appeal|planned_giving|corporate_partnership|digital_online`',
    `campaign_code` STRING COMMENT 'Short alphanumeric code used for internal tracking and gift attribution. Often used in appeal codes and donation forms.',
    `cost_of_fundraising` DECIMAL(18,2) COMMENT 'Total expenses incurred to execute the campaign, including marketing, events, staff time, and materials.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was first created in the system.',
    `donor_count` STRING COMMENT 'Total number of unique donors who have contributed to this campaign.',
    `end_date` DATE COMMENT 'The date when the campaign officially closes. Null for ongoing campaigns without a defined end.',
    `gift_count` STRING COMMENT 'Total number of individual gift transactions attributed to this campaign.',
    `goal_amount` DECIMAL(18,2) COMMENT 'The target fundraising amount the campaign aims to raise, expressed in the organizations base currency.',
    `impact_report_url` STRING COMMENT 'Web address of the campaign impact report or results summary shared with donors.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the campaign is currently active and accepting donations.',
    `is_public` BOOLEAN COMMENT 'Boolean flag indicating whether the campaign is publicly visible on the organizations website and donation pages.',
    `matching_gift_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether donations to this campaign are eligible for corporate matching gift programs.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the campaign record was last updated.',
    `campaign_name` STRING COMMENT 'The full name of the fundraising campaign as displayed to donors and staff.',
    `roi_percentage` DECIMAL(18,2) COMMENT 'Calculated return on investment for the campaign, expressed as a percentage of net revenue over cost.',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of UN Sustainable Development Goal numbers (1-17) that this campaign contributes to, supporting impact reporting.',
    `start_date` DATE COMMENT 'The date when the campaign officially begins accepting donations and engaging donors.',
    `stewardship_plan` STRING COMMENT 'Description of the donor stewardship and engagement activities planned for campaign contributors.',
    `target_audience_segment` STRING COMMENT 'Description of the donor segment or constituency this campaign is designed to engage (e.g., major donors, monthly sustainers, corporate partners, lapsed donors).',
    `tax_deductible` BOOLEAN COMMENT 'Boolean flag indicating whether donations to this campaign are tax-deductible under IRS 501(c)(3) regulations or equivalent.',
    `total_raised_amount` DECIMAL(18,2) COMMENT 'Cumulative amount of gifts and pledges received to date for this campaign.',
    CONSTRAINT pk_campaign PRIMARY KEY(`campaign_id`)
) COMMENT 'Fundraising campaign master record managing all donor-facing fundraising initiatives in Salesforce Nonprofit Cloud. Captures campaign name, campaign type (annual fund, capital campaign, emergency appeal, planned giving, corporate partnership, digital/online), campaign goal amount, start and end dates, campaign status, target audience segment, appeal codes associated, total gifts raised to date, number of donors, cost of fundraising, and ROI. Supports campaign performance tracking and donor attribution across all gift transactions. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`appeal` (
    `appeal_id` BIGINT COMMENT 'Unique identifier for the fundraising appeal. Primary key.',
    `campaign_id` BIGINT COMMENT 'Reference to the parent fundraising campaign under which this appeal is organized.',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Appeals direct donors to specific funds. Currently fund_designation is a STRING (likely fund name/code); replacing with FK to fund.fund_id provides referential integrity and enables JOIN to retrieve f',
    `acknowledgment_template` STRING COMMENT 'Name or identifier of the gift acknowledgment letter template used for donors responding to this appeal.',
    `appeal_status` STRING COMMENT 'Current lifecycle status of the appeal.. Valid values are `draft|scheduled|active|completed|cancelled|on_hold`',
    `appeal_type` STRING COMMENT 'Classification of the appeal based on donor lifecycle stage and solicitation strategy.. Valid values are `acquisition|renewal|upgrade|lapsed_reactivation|major_gift|planned_giving`',
    `ask_amount` DECIMAL(18,2) COMMENT 'Suggested or recommended gift amount presented to constituents in the appeal solicitation.',
    `ask_string` STRING COMMENT 'Formatted ask string presented to constituents showing multiple giving levels (e.g., $50, $100, $250, $500, Other).',
    `average_gift_amount` DECIMAL(18,2) COMMENT 'Average gift size for responses to this appeal calculated as total_revenue_amount / response_count.',
    `channel` STRING COMMENT 'Primary communication channel through which the appeal is delivered to constituents. [ENUM-REF-CANDIDATE: direct_mail|email|phone|digital|event|face_to_face|social_media — 7 candidates stripped; promote to reference product]',
    `appeal_code` STRING COMMENT 'Externally-known unique code for the appeal used in gift attribution and tracking (e.g., DM2024Q1, EMAIL-SPRING, PHONE-EOY).. Valid values are `^[A-Z0-9]{3,20}$`',
    `control_group_flag` BOOLEAN COMMENT 'Indicates whether this appeal represents the control group in an A/B test (true) or a test variant (false).',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to execute the appeal including production, postage, vendor fees, and staff time.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the appeal record was first created in the system.',
    `end_date` DATE COMMENT 'Date the appeal closes and stops accepting new responses. Nullable for ongoing appeals.',
    `mailing_date` DATE COMMENT 'Date the appeal solicitation was sent or deployed to the target segment.',
    `manager_name` STRING COMMENT 'Name of the staff member responsible for managing and executing this appeal.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified the appeal record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the appeal record was last modified in the system.',
    `appeal_name` STRING COMMENT 'Human-readable name of the appeal (e.g., Spring Direct Mail Appeal, Year-End Email Solicitation).',
    `notes` STRING COMMENT 'Free-text notes and comments about the appeal including lessons learned, special circumstances, and post-campaign observations.',
    `package_description` STRING COMMENT 'Detailed description of the solicitation package contents including letter, brochure, reply device, premium, and other components.',
    `pieces_sent` STRING COMMENT 'Total count of solicitation pieces (letters, emails, calls) sent to constituents for this appeal.',
    `premium_offered` STRING COMMENT 'Description of any premium or thank-you gift offered to donors responding to this appeal (e.g., tote bag, calendar, recognition pin).',
    `response_count` STRING COMMENT 'Total number of constituents who responded to the appeal with a gift or pledge.',
    `response_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of constituents who responded to the appeal calculated as (response_count / pieces_sent) * 100.',
    `roi_ratio` DECIMAL(18,2) COMMENT 'Return on investment ratio for the appeal calculated as total_revenue_amount / cost_amount. Values greater than 1.0 indicate positive ROI.',
    `solicitor_name` STRING COMMENT 'Name of the primary solicitor or fundraiser credited with this appeal (may be staff, volunteer, or board member).',
    `start_date` DATE COMMENT 'Date the appeal becomes active and begins accepting responses.',
    `test_segment_flag` BOOLEAN COMMENT 'Indicates whether this appeal is part of an A/B test or experimental segment for testing messaging, package, or channel effectiveness.',
    `total_revenue_amount` DECIMAL(18,2) COMMENT 'Total gross revenue generated by gifts and pledges attributed to this appeal.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created the appeal record.',
    CONSTRAINT pk_appeal PRIMARY KEY(`appeal_id`)
) COMMENT 'Specific fundraising appeal or solicitation package within a campaign, managed in Raisers Edge NXT. An appeal is a targeted ask sent to a defined segment of constituents via a specific channel (direct mail, email, phone, event). Captures appeal code, appeal name, parent campaign, appeal type (acquisition, renewal, upgrade, lapsed reactivation), mailing date, channel (mail, email, phone, digital), cost, number of pieces sent, response rate, and total revenue generated. Enables granular attribution of gifts to specific solicitation efforts. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`fund` (
    `fund_id` BIGINT COMMENT 'Unique identifier for the donor-designated fund record. Primary key.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Restricted funds often have country-specific designations per donor agreements. Essential for compliance with donor restrictions, country-level financial reporting, registration requirements, and ensu',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project to which this fund is designated. Links donor intent to operational program delivery.',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Donor funds are tied to specific logframes that define the results framework for fund-supported activities. NGO donor reporting requires linking fund disbursements to the logframe hierarchy to demonst',
    `constituent_id` BIGINT COMMENT 'Reference to the primary donor or institutional funder who established or designated this fund. Links fund to donor cultivation and stewardship records in Salesforce Nonprofit Cloud or Raisers Edge NXT.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Donor funds have defined reporting_frequency and compliance deadlines. Linking to reporting_period enables fund managers to track which MEL reporting cycle governs each funds compliance submissions, ',
    `audit_required` BOOLEAN COMMENT 'Indicates whether the fund is subject to separate audit requirements beyond organizational annual audit, such as single audit or donor-specific financial audit per OMB Uniform Guidance or grant terms.',
    `balance` DECIMAL(18,2) COMMENT 'Current available balance in the fund representing cumulative gifts received minus disbursements and allocations. Updated through integration with SAP S/4HANA or Unit4 ERP fund accounting modules.',
    `beneficiary_population` STRING COMMENT 'Description of the target beneficiary population or vulnerable group that this fund is designated to serve (e.g., IDPs, refugees, children under 5, women survivors of GBV).',
    `fund_category` STRING COMMENT 'High-level classification of the funds purpose for portfolio management and strategic planning. Distinguishes operating funds from capital campaigns, emergency response funds, and endowments. [ENUM-REF-CANDIDATE: operating|capital|program|emergency_response|endowment|scholarship|research — 7 candidates stripped; promote to reference product]',
    `closure_date` DATE COMMENT 'Date when the fund was formally closed and ceased accepting new gifts. Nullable for active funds. Used for endowment spend-down tracking and restricted fund completion.',
    `fund_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the fund in donor communications, grant agreements, and financial reports. Used as the business identifier for fund accounting and stewardship.. Valid values are `^[A-Z0-9]{3,15}$`',
    `compliance_notes` STRING COMMENT 'Free-text field capturing special compliance requirements, donor-specific terms and conditions, procurement restrictions, or regulatory obligations unique to this fund.',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'Required percentage of organizational cost-sharing or matching funds relative to total project budget. Nullable if cost share is not required.',
    `cost_share_required` BOOLEAN COMMENT 'Indicates whether the fund requires organizational cost-sharing or matching contributions per donor agreement terms. True if cost share is mandatory.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fund record was first created in the system. Audit trail for data lineage and record lifecycle tracking.',
    `dac_sector_code` STRING COMMENT 'Five-digit OECD DAC sector classification code indicating the primary sector focus of the fund (e.g., health, education, WASH, humanitarian aid). Required for DAC reporting by institutional donors.. Valid values are `^[0-9]{5}$`',
    `fund_description` STRING COMMENT 'Detailed narrative describing the purpose, scope, and intended use of the fund. Captures donor intent and programmatic objectives for stewardship and compliance reporting.',
    `endowment_spending_policy` DECIMAL(18,2) COMMENT 'Description of the board-approved spending policy for endowment funds, including annual distribution rate, calculation methodology, and underwater endowment provisions per ASC 958.',
    `fund_status` STRING COMMENT 'Current lifecycle state of the fund indicating whether it is actively accepting gifts and disbursing funds, or has been closed or temporarily suspended.. Valid values are `open|closed|suspended|pending_approval`',
    `fund_type` STRING COMMENT 'Classification of the fund based on donor restrictions and organizational policy. Determines accounting treatment per ASC 958 net asset classification requirements.. Valid values are `restricted|temporarily_restricted|unrestricted|endowment|quasi_endowment|board_designated`',
    `geographic_scope` STRING COMMENT 'Geographic reach of the funds programmatic activities. Indicates whether the fund supports global operations, regional initiatives, or country-specific programs.. Valid values are `global|regional|country_specific|multi_country`',
    `iati_identifier` STRING COMMENT 'Unique IATI activity identifier for this fund if reported under IATI transparency standards. Enables public disclosure and donor coordination.',
    `inception_date` DATE COMMENT 'Date when the fund was established and opened for gift acceptance. Marks the beginning of the funds lifecycle.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Percentage rate for Facilities and Administration (F&A) indirect costs allowed under this fund per donor agreement or NICRA. Expressed as a percentage (e.g., 15.00 for 15%).',
    `investment_policy` STRING COMMENT 'Summary of investment strategy and asset allocation policy for endowment or quasi-endowment funds. References board-approved investment policy statement.',
    `minimum_gift_amount` DECIMAL(18,2) COMMENT 'Minimum contribution threshold required to designate a gift to this fund. Used for major gift funds, endowments, and named funds with donor-established minimums.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this fund record. Supports change management and audit compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fund record was last updated. Supports change tracking and audit compliance.',
    `fund_name` STRING COMMENT 'Full descriptive name of the fund as presented to donors and in financial statements. Human-readable identity label for the fund.',
    `reporting_frequency` STRING COMMENT 'Required frequency of stewardship and financial reporting to the donor or funding agency for this fund per grant agreement or donor stewardship plan.. Valid values are `monthly|quarterly|semi_annual|annual|upon_request`',
    `restriction_description` STRING COMMENT 'Detailed explanation of donor-imposed restrictions, including specific programmatic purposes, geographic limitations, beneficiary populations, or time-bound conditions that govern fund usage.',
    `restriction_expiration_date` DATE COMMENT 'Date when time-based donor restrictions expire and temporarily restricted funds are released to unrestricted net assets. Nullable for perpetual or purpose-only restrictions.',
    `restriction_type` STRING COMMENT 'Nature of donor-imposed restrictions on the fund. Purpose-restricted funds must be used for specific programs or activities; time-restricted funds have temporal constraints; perpetual restrictions apply to endowments.. Valid values are `purpose_restricted|time_restricted|perpetual|unrestricted`',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of United Nations Sustainable Development Goal (SDG) numbers (1-17) to which this funds programmatic purpose aligns. Used for impact reporting and IATI transparency.',
    `target_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where the funds resources are designated to be used. Supports geographic restriction tracking and field operations planning.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this fund record. Audit trail for accountability and data stewardship.',
    CONSTRAINT pk_fund PRIMARY KEY(`fund_id`)
) COMMENT 'Donor-designated fund master record representing the specific programmatic or operational purpose to which a gift is directed. Captures fund code, fund name, fund type (restricted, temporarily restricted, unrestricted, endowment, quasi-endowment), fund description, associated program or project, GL account mapping, fund status (open, closed, suspended), minimum gift threshold, and fund stewardship contact. Serves as the bridge between donor intent (gift designation) and financial stewardship (fund accounting in SAP/Unit4). Distinct from GL account — fund is the donor-facing designation. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero. [SSOT: non-authoritative; defers to canonical finance.finance_fund.] SSOT: single source of truth is finance.finance_fund; this entity defers to it. [SSOT] Single source of truth for the donor_fund/finance_fund concept; finance.finance_fund is the secondary/aligned view. [SSOT: canonical source of truth for this concept; dependent alias is finance.finance_fund.]';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` (
    `stewardship_activity_id` BIGINT COMMENT 'Unique identifier for the stewardship activity record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Partnership stewardship reporting: NGO relationship managers conduct stewardship visits, calls, and impact briefings tied to specific partnership agreements. This FK enables tracking all relationship ',
    `appeal_id` BIGINT COMMENT 'Foreign key linking to donor.appeal. Business justification: Stewardship activities can be triggered by specific appeals (e.g., thank-you call after appeal response, acknowledgment letter for appeal gift). Appeal attribution enables integrated donor journey tra',
    `campaign_id` BIGINT COMMENT 'Reference to the fundraising campaign context for this stewardship activity. Nullable if not campaign-specific.',
    `constituent_id` BIGINT COMMENT 'Reference to the donor or constituent involved in this stewardship activity. Links to the constituent master record in Salesforce Nonprofit Cloud or Raisers Edge NXT.',
    `evaluation_id` BIGINT COMMENT 'Foreign key linking to mel.evaluation. Business justification: Stewardship meetings often discuss evaluation findings with donors to demonstrate accountability and learning. Linking stewardship activity to evaluation enables tracking which evaluations were shared',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Stewardship activities can be fund-specific (e.g., endowment impact report, scholarship recipient introduction, program site visit). Fund attribution enables fund-specific stewardship planning and imp',
    `gift_id` BIGINT COMMENT 'Reference to the specific gift or donation that triggered or is associated with this stewardship activity. Nullable for activities not tied to a specific gift.',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: Stewardship communications share impact stories tied to specific indicators the donor funded. This link enables personalized donor reporting, tracking which indicators were discussed in stewardship me',
    `indicator_result_id` BIGINT COMMENT 'Foreign key linking to mel.indicator_result. Business justification: Stewardship activities frequently involve sharing specific indicator results as impact evidence with donors. Linking stewardship_activity to indicator_result enables tracking exactly which result data',
    `major_gift_opportunity_id` BIGINT COMMENT 'Foreign key linking to donor.major_gift_opportunity. Business justification: Stewardship activities can be tied to specific major gift opportunities (e.g., proposal presentation, site visit during solicitation). Linking stewardship to active opportunities enables pipeline mana',
    `pledge_id` BIGINT COMMENT 'Reference to the pledge commitment associated with this stewardship activity. Nullable for activities not related to a pledge.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Stewardship activities include donor field visits to project sites for relationship cultivation and impact demonstration. Critical for visit logistics, security coordination, beneficiary consent manag',
    `prospect_id` BIGINT COMMENT 'Foreign key linking to donor.prospect. Business justification: Stewardship activities include pre-conversion cultivation touchpoints (calls, meetings, site visits) that occur during the prospect qualification and cultivation stages — before a major gift opportuni',
    `acknowledgement_sent_date` DATE COMMENT 'The date on which the acknowledgement communication was sent to the donor. Nullable if no acknowledgement was sent.',
    `acknowledgement_sent_flag` BOOLEAN COMMENT 'Boolean indicator of whether a formal acknowledgement or thank-you communication was sent following this stewardship activity.',
    `activity_date` DATE COMMENT 'The date on which the stewardship activity was conducted or scheduled. Principal business event timestamp for this transaction.',
    `activity_description` STRING COMMENT 'Detailed narrative description of the stewardship activity, including context, discussion points, and any relevant details captured by the staff member.',
    `activity_outcome` STRING COMMENT 'Summary of the outcome or result of the stewardship activity, including donor response, feedback received, and any commitments made.',
    `activity_status` STRING COMMENT 'Current lifecycle status of the stewardship activity indicating whether it is planned, completed, cancelled, rescheduled, or pending.. Valid values are `planned|completed|cancelled|rescheduled|pending`',
    `activity_subject` STRING COMMENT 'Brief subject line or title summarizing the purpose of the stewardship activity.',
    `activity_type` STRING COMMENT 'Classification of the stewardship activity. [ENUM-REF-CANDIDATE: acknowledgement_letter|impact_report|site_visit|phone_call|event_invitation|personal_meeting|grant_report_delivery|thank_you_call|donor_briefing|recognition_event — promote to reference product]. Valid values are `acknowledgement_letter|impact_report|site_visit|phone_call|event_invitation|personal_meeting`',
    `attendee_count` STRING COMMENT 'Number of individuals who participated in the stewardship activity, including staff and constituents. Applicable for meetings, site visits, and events.',
    `communication_channel` STRING COMMENT 'The medium or channel through which the stewardship activity was conducted (in-person meeting, phone call, email, video conference, postal mail, or event).. Valid values are `in_person|phone|email|video_call|mail|event`',
    `completed_date` DATE COMMENT 'The actual date on which the stewardship activity was marked as completed. Nullable for activities that are planned or cancelled.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The direct cost incurred for conducting this stewardship activity, including event costs, travel expenses, materials, or gifts. Nullable if no cost was tracked.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this stewardship activity record was first created in the system. Record audit trail.',
    `donor_response` STRING COMMENT 'The donors response to any solicitation or engagement request made during the stewardship activity.. Valid values are `committed|interested|considering|declined|no_response`',
    `donor_sentiment` STRING COMMENT 'Qualitative assessment of the donors sentiment or engagement level observed during the stewardship activity, used for relationship health tracking.. Valid values are `very_positive|positive|neutral|negative|very_negative`',
    `duration_minutes` STRING COMMENT 'The length of the stewardship activity in minutes, applicable for meetings, calls, and site visits. Nullable for activities without a defined duration.',
    `engagement_score` STRING COMMENT 'Quantitative engagement score assigned to the activity based on donor responsiveness, interest level, and interaction quality. Scale typically 1-10.',
    `follow_up_due_date` DATE COMMENT 'The target date by which follow-up action should be completed. Nullable if no follow-up is required.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether follow-up action is required based on the outcome of this stewardship activity.',
    `impact_story_shared_flag` BOOLEAN COMMENT 'Boolean indicator of whether a beneficiary impact story or program outcome was shared with the donor during this activity.',
    `location` STRING COMMENT 'Physical or virtual location where the stewardship activity took place (office address, donor site, event venue, or virtual meeting platform).',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this stewardship activity record was last modified. Record audit trail.',
    `next_steps` STRING COMMENT 'Documented follow-up actions or next steps identified during or after the stewardship activity to continue donor cultivation.',
    `notes` STRING COMMENT 'Internal staff notes and observations about the stewardship activity, donor preferences, or relationship insights. Confidential business information.',
    `priority_level` STRING COMMENT 'Priority classification of the stewardship activity indicating its importance in the overall donor cultivation strategy.. Valid values are `high|medium|low`',
    `scheduled_date` DATE COMMENT 'The originally scheduled date for the stewardship activity. May differ from activity_date if the activity was rescheduled or completed on a different date.',
    `solicitation_amount` DECIMAL(18,2) COMMENT 'The specific funding amount requested from the donor during the solicitation. Nullable if no solicitation was made.',
    `solicitation_made_flag` BOOLEAN COMMENT 'Boolean indicator of whether a funding solicitation or ask was made to the donor during this stewardship activity.',
    `stewardship_plan_stage` STRING COMMENT 'The stage in the donor cultivation and stewardship lifecycle that this activity supports, aligned with the organizations donor relationship management framework.. Valid values are `identification|cultivation|solicitation|stewardship|renewal`',
    CONSTRAINT pk_stewardship_activity PRIMARY KEY(`stewardship_activity_id`)
) COMMENT 'Records all donor stewardship touchpoints and relationship management activities conducted by major gift officers and stewardship staff. Captures activity type (acknowledgement letter, impact report, site visit, phone call, event invitation, personal meeting, grant report delivery), activity date, staff member responsible, constituent involved, related gift or pledge, activity outcome, next steps, and stewardship plan stage. Supports the donor cultivation and stewardship lifecycle and enables relationship health tracking in Salesforce Nonprofit Cloud. Systems of record: SAP / SAP S/4HANA (VISION) (ERP back-office); eTools (programme management); InSight (BI); RAM (results assessment); eZHACT (HACT); ICON (procurement); DHIS2 (health data aggregation); Kobo Toolbox (data collection); Primero (child protection); Salesforce Nonprofit Cloud (National Committee CRM); Raisers Edge NXT (National Committee CRM) (beyond Salesforce Nonprofit Cloud and Raisers Edge NXT National Committee CRMs). Deployable as a Databricks lakehouse (Unity Catalog, Delta, medallion). [lakehouse-sor] [sor:un-agency] Operational systems of record include Salesforce Nonprofit Cloud, Raisers Edge NXT (National Committee CRMs) and the UN-agency stack SAP, SAP S/4HANA (VISION), eTools, InSight, RAM, eZHACT, ICON, DHIS2, Kobo Toolbox, Primero.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ADD CONSTRAINT `fk_donor_prospect_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `vibe_ngo_v1`.`donor`.`appeal`(`appeal_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ADD CONSTRAINT `fk_donor_prospect_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ADD CONSTRAINT `fk_donor_prospect_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ADD CONSTRAINT `fk_donor_prospect_major_gift_opportunity_id` FOREIGN KEY (`major_gift_opportunity_id`) REFERENCES `vibe_ngo_v1`.`donor`.`major_gift_opportunity`(`major_gift_opportunity_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `vibe_ngo_v1`.`donor`.`appeal`(`appeal_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_major_gift_opportunity_id` FOREIGN KEY (`major_gift_opportunity_id`) REFERENCES `vibe_ngo_v1`.`donor`.`major_gift_opportunity`(`major_gift_opportunity_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_original_gift_id` FOREIGN KEY (`original_gift_id`) REFERENCES `vibe_ngo_v1`.`donor`.`gift`(`gift_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `vibe_ngo_v1`.`donor`.`pledge`(`pledge_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ADD CONSTRAINT `fk_donor_gift_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `vibe_ngo_v1`.`donor`.`appeal`(`appeal_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ADD CONSTRAINT `fk_donor_pledge_major_gift_opportunity_id` FOREIGN KEY (`major_gift_opportunity_id`) REFERENCES `vibe_ngo_v1`.`donor`.`major_gift_opportunity`(`major_gift_opportunity_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ADD CONSTRAINT `fk_donor_major_gift_opportunity_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `vibe_ngo_v1`.`donor`.`appeal`(`appeal_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ADD CONSTRAINT `fk_donor_major_gift_opportunity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ADD CONSTRAINT `fk_donor_major_gift_opportunity_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ADD CONSTRAINT `fk_donor_major_gift_opportunity_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ADD CONSTRAINT `fk_donor_campaign_parent_campaign_id` FOREIGN KEY (`parent_campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ADD CONSTRAINT `fk_donor_appeal_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ADD CONSTRAINT `fk_donor_appeal_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ADD CONSTRAINT `fk_donor_fund_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_appeal_id` FOREIGN KEY (`appeal_id`) REFERENCES `vibe_ngo_v1`.`donor`.`appeal`(`appeal_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_campaign_id` FOREIGN KEY (`campaign_id`) REFERENCES `vibe_ngo_v1`.`donor`.`campaign`(`campaign_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_constituent_id` FOREIGN KEY (`constituent_id`) REFERENCES `vibe_ngo_v1`.`donor`.`constituent`(`constituent_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_fund_id` FOREIGN KEY (`fund_id`) REFERENCES `vibe_ngo_v1`.`donor`.`fund`(`fund_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_gift_id` FOREIGN KEY (`gift_id`) REFERENCES `vibe_ngo_v1`.`donor`.`gift`(`gift_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_major_gift_opportunity_id` FOREIGN KEY (`major_gift_opportunity_id`) REFERENCES `vibe_ngo_v1`.`donor`.`major_gift_opportunity`(`major_gift_opportunity_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_pledge_id` FOREIGN KEY (`pledge_id`) REFERENCES `vibe_ngo_v1`.`donor`.`pledge`(`pledge_id`);
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ADD CONSTRAINT `fk_donor_stewardship_activity_prospect_id` FOREIGN KEY (`prospect_id`) REFERENCES `vibe_ngo_v1`.`donor`.`prospect`(`prospect_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`donor` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_ngo_v1`.`donor` SET TAGS ('dbx_domain' = 'donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` SET TAGS ('dbx_subdomain' = 'constituent_management');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `constituent_id` SET TAGS ('dbx_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Mailing Country Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `country_id` SET TAGS ('dbx_relationship' = 'lookup_reference');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `country_id` SET TAGS ('dbx_standard_reference' = 'ISO 3166-1 alpha-3 country codes');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `country_id` SET TAGS ('dbx_pii_donor' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Managing Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|phone|mail|sms|no_contact');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `communication_preference` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `constituent_type` SET TAGS ('dbx_business_glossary_term' = 'Constituent Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `constituent_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `constituent_type` SET TAGS ('dbx_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `crm_source_record_code` SET TAGS ('dbx_business_glossary_term' = 'Constituent Relationship Management (CRM) Source Record Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `crm_source_record_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `crm_source_record_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `crm_source_record_code` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `crm_source_system` SET TAGS ('dbx_business_glossary_term' = 'Constituent Relationship Management (CRM) Source System');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `crm_source_system` SET TAGS ('dbx_value_regex' = 'salesforce_nonprofit_cloud|raisers_edge_nxt|other');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `crm_source_system` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `dac_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Member Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `dac_member_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `deceased_date` SET TAGS ('dbx_business_glossary_term' = 'Deceased Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `deceased_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `deceased_flag` SET TAGS ('dbx_business_glossary_term' = 'Deceased Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `deceased_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_business_glossary_term' = 'Email Opt-In Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_'pii_email'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_'pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `email_opt_in_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `estimated_giving_capacity` SET TAGS ('dbx_business_glossary_term' = 'Estimated Giving Capacity');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `estimated_giving_capacity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `estimated_giving_capacity` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `estimated_giving_capacity` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `first_gift_date` SET TAGS ('dbx_business_glossary_term' = 'First Gift Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `first_gift_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `funder_classification` SET TAGS ('dbx_business_glossary_term' = 'Funder Classification');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `funder_classification` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `gdpr_consent_date` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'General Data Protection Regulation (GDPR) Consent Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `gdpr_consent_flag` SET TAGS ('dbx_standard_reference' = 'GDPR Art.6-7; UNHCR Data Protection Policy 2015; CHS Commitment 4');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `iati_organization_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Organization Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `iati_organization_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}-[A-Z]+-[0-9A-Z]+$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `iati_organization_identifier` SET TAGS ('dbx_standard_reference' = 'IATI Standard v2.03 (iatistandard.org)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `largest_gift_amount` SET TAGS ('dbx_business_glossary_term' = 'Largest Gift Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `largest_gift_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `last_gift_date` SET TAGS ('dbx_business_glossary_term' = 'Last Gift Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `last_gift_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_'pii_name'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_'pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `legal_name` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `lifetime_giving_total` SET TAGS ('dbx_business_glossary_term' = 'Lifetime Giving Total');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `lifetime_giving_total` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_'pii_address'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_'pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_'pii_address'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_'pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_city` SET TAGS ('dbx_business_glossary_term' = 'Mailing City');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_city` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Postal Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_postal_code` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Mailing State or Province');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `mailing_state_province` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `oda_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Official Development Assistance (ODA) Eligibility Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `oda_eligibility_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `organization_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Organization Affiliation');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `organization_affiliation` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_grant_modality` SET TAGS ('dbx_business_glossary_term' = 'Preferred Grant Modality');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_grant_modality` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_'pii_name'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_'pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `preferred_name` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_'pii_email'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_'pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_email` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_'pii_phone'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_'pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `primary_phone` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `prospect_research_rating` SET TAGS ('dbx_business_glossary_term' = 'Prospect Research Rating');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `prospect_research_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|unrated');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `prospect_research_rating` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|duplicate|archived');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `record_status` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `relationship_tier` SET TAGS ('dbx_business_glossary_term' = 'Relationship Tier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `relationship_tier` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `salutation` SET TAGS ('dbx_business_glossary_term' = 'Salutation');
ALTER TABLE `vibe_ngo_v1`.`donor`.`constituent` ALTER COLUMN `salutation` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` SET TAGS ('dbx_subdomain' = 'constituent_management');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `campaign_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `constituent_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `constituent_id` SET TAGS ('dbx_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `major_gift_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Major Gift Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `ability_score` SET TAGS ('dbx_business_glossary_term' = 'Ability Score (LAI Assessment)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `ability_score` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `board_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Board Affiliation');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `board_affiliation` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|phone|mail|in_person|no_preference');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `communication_preference` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `conversion_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `cultivation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Cultivation Strategy Notes');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `cultivation_strategy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `cultivation_strategy` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `donor_recognition_preference` SET TAGS ('dbx_business_glossary_term' = 'Donor Recognition Preference');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `donor_recognition_preference` SET TAGS ('dbx_value_regex' = 'public|anonymous|limited|no_preference');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `donor_recognition_preference` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_'pii_email'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_'pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `email_address` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_capacity` SET TAGS ('dbx_business_glossary_term' = 'Estimated Giving Capacity');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_capacity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_capacity` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_capacity` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_gift_range_max` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gift Range Maximum');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_gift_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_gift_range_max` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_gift_range_min` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gift Range Minimum');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_gift_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `estimated_gift_range_min` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `geographic_interest` SET TAGS ('dbx_business_glossary_term' = 'Geographic Interest');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `geographic_interest` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `geographic_interest` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `identification_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `interest_score` SET TAGS ('dbx_business_glossary_term' = 'Interest Score (LAI Assessment)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `interest_score` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_pii_donor' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `last_contact_type` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `last_contact_type` SET TAGS ('dbx_pii_donor' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `last_contact_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `linkage_score` SET TAGS ('dbx_business_glossary_term' = 'Linkage Score (LAI Assessment)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `linkage_score` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `linkage_score` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_'pii_address'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_'pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `mailing_address` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_business_glossary_term' = 'Prospect Full Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_'pii_name'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_'pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_name` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `next_action_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `next_action_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `next_action_description` SET TAGS ('dbx_business_glossary_term' = 'Next Action Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `next_action_description` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_'pii_phone'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_'reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_'pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_'mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_'lookup_review' = 'no_target]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `phone_number` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `previous_giving_history` SET TAGS ('dbx_business_glossary_term' = 'Previous Giving History');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `previous_giving_history` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `previous_giving_history` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `probability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Probability Percentage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `probability_percentage` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `probability_percentage` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_status` SET TAGS ('dbx_business_glossary_term' = 'Prospect Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_status` SET TAGS ('dbx_value_regex' = 'active|inactive|disqualified|converted|on_hold');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_status` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_business_glossary_term' = 'Prospect Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_value_regex' = 'individual|foundation|corporate|institutional|government|multilateral');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `prospect_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `qualification_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Prospect Rating');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `rating` SET TAGS ('dbx_value_regex' = 'A+|A|B+|B|C+|C|D');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `rating` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `research_stage` SET TAGS ('dbx_business_glossary_term' = 'Research Stage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `research_stage` SET TAGS ('dbx_value_regex' = 'not_started|preliminary|in_depth|completed|ongoing_monitoring');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `research_stage` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `research_stage` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `solicitation_amount` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `solicitation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `solicitation_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `solicitation_date` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `solicitation_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `source_of_wealth` SET TAGS ('dbx_business_glossary_term' = 'Source of Wealth');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `source_of_wealth` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `source_of_wealth` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `source_of_wealth` SET TAGS ('dbx_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Prospect Stage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'identification|qualification|cultivation|solicitation|negotiation|stewardship');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `stage` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `stage` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `wealth_screening_score` SET TAGS ('dbx_business_glossary_term' = 'Wealth Screening Score');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `wealth_screening_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `wealth_screening_score` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `wealth_screening_score` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `wealth_screening_score` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`prospect` ALTER COLUMN `wealth_screening_score` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_id` SET TAGS ('dbx_business_glossary_term' = 'Gift Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `appeal_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `campaign_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `major_gift_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Major Gift Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `major_gift_opportunity_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `original_gift_id` SET TAGS ('dbx_business_glossary_term' = 'Original Gift Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `original_gift_id` SET TAGS ('dbx_relationship' = 'self_reference');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `original_gift_id` SET TAGS ('dbx_hierarchy_self_reference' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `original_gift_id` SET TAGS ('dbx_self_reference' = 'hierarchy');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `original_gift_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `pledge_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `constituent_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `constituent_id` SET TAGS ('dbx_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `acknowledgement_type` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `acknowledgement_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Gift Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `anonymous_flag` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Gift Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `anonymous_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `batch_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `batch_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `batch_number` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `fee_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_date` SET TAGS ('dbx_business_glossary_term' = 'Gift Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_number` SET TAGS ('dbx_business_glossary_term' = 'Gift Number');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_number` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_status` SET TAGS ('dbx_business_glossary_term' = 'Gift Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_status` SET TAGS ('dbx_value_regex' = 'pending|received|processed|acknowledged|refunded|cancelled');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_status` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_type` SET TAGS ('dbx_business_glossary_term' = 'Gift Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gift_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `goods_services_value` SET TAGS ('dbx_business_glossary_term' = 'Goods or Services Fair Market Value');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `goods_services_value` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_business_glossary_term' = 'Honoree Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_'pii_name'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_'pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `honoree_name` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `irs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Revenue Service (IRS) Compliant Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `irs_compliant_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `match_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Match Approval Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `match_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|paid');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `match_approval_status` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `match_ratio` SET TAGS ('dbx_business_glossary_term' = 'Match Ratio');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `match_ratio` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `match_request_date` SET TAGS ('dbx_business_glossary_term' = 'Match Request Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `match_request_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `matching_gift_flag` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `matching_gift_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Gift Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `net_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipient Address');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_'pii_address'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_'pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_address` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Notification Recipient Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_'pii_name'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_'pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_recipient_name` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `payment_channel` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `payment_method` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `receipt_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `receipt_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `receipt_number` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `refund_flag` SET TAGS ('dbx_business_glossary_term' = 'Refund Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `refund_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `refund_reason` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `refund_reason` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Restriction Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `restriction_description` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily-restricted|permanently-restricted');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `restriction_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `tribute_flag` SET TAGS ('dbx_business_glossary_term' = 'Tribute Gift Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `tribute_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `tribute_type` SET TAGS ('dbx_business_glossary_term' = 'Tribute Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `tribute_type` SET TAGS ('dbx_value_regex' = 'in-honor-of|in-memory-of');
ALTER TABLE `vibe_ngo_v1`.`donor`.`gift` ALTER COLUMN `tribute_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `appeal_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `campaign_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `constituent_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `constituent_id` SET TAGS ('dbx_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `major_gift_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Major Gift Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `major_gift_opportunity_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `acknowledgment_sent` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Sent');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `acknowledgment_sent` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `amount_paid` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `balance_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Balance Outstanding');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `balance_outstanding` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `first_installment_date` SET TAGS ('dbx_business_glossary_term' = 'First Installment Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `first_installment_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `fulfillment_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Installment Frequency');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|semi_annual|annual|custom');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `installments_paid` SET TAGS ('dbx_business_glossary_term' = 'Installments Paid');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `installments_paid` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `installments_remaining` SET TAGS ('dbx_business_glossary_term' = 'Installments Remaining');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `installments_remaining` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `installments_remaining` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `installments_remaining` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `installments_remaining` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Is Anonymous');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `is_matching_gift_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Matching Gift Eligible');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `is_matching_gift_eligible` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `is_recurring` SET TAGS ('dbx_business_glossary_term' = 'Is Recurring');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `is_recurring` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `last_installment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Installment Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `last_installment_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `next_installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Next Installment Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `next_installment_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `next_installment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Installment Due Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `next_installment_due_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Pledge Notes');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `number_of_installments` SET TAGS ('dbx_business_glossary_term' = 'Number of Installments');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `number_of_installments` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `payment_method` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_date` SET TAGS ('dbx_business_glossary_term' = 'Pledge Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_number` SET TAGS ('dbx_business_glossary_term' = 'Pledge Number');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_number` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_business_glossary_term' = 'Pledge Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_value_regex' = 'active|fulfilled|lapsed|written_off|cancelled|pending');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_status` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_type` SET TAGS ('dbx_business_glossary_term' = 'Pledge Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_type` SET TAGS ('dbx_value_regex' = 'standard|sustainer|major_gift|planned_giving|capital_campaign|endowment');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `pledge_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `reminder_schedule` SET TAGS ('dbx_business_glossary_term' = 'Reminder Schedule');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `reminder_schedule` SET TAGS ('dbx_value_regex' = 'none|7_days_before|14_days_before|30_days_before|custom');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `reminder_schedule` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `total_pledge_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Pledge Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `total_pledge_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `write_off_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `vibe_ngo_v1`.`donor`.`pledge` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `major_gift_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Major Gift Opportunity ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `appeal_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `constituent_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `constituent_id` SET TAGS ('dbx_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Close Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `actual_close_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `ask_amount` SET TAGS ('dbx_business_glossary_term' = 'Ask Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `ask_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `ask_strategy` SET TAGS ('dbx_business_glossary_term' = 'Ask Strategy');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `ask_strategy` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `created_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `donor_recognition_level` SET TAGS ('dbx_business_glossary_term' = 'Donor Recognition Level');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `donor_recognition_level` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `expected_gift_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Gift Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `expected_gift_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `gift_purpose` SET TAGS ('dbx_business_glossary_term' = 'Gift Purpose');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `gift_purpose` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `gift_type` SET TAGS ('dbx_business_glossary_term' = 'Gift Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `gift_type` SET TAGS ('dbx_value_regex' = 'cash|pledge|planned_giving|in_kind|stock|real_estate');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `gift_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `is_active` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Is Anonymous');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `is_matching_gift_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Matching Gift Eligible');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `is_matching_gift_eligible` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_pii_donor' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_business_glossary_term' = 'Loss Reason');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `loss_reason` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `next_step_action` SET TAGS ('dbx_business_glossary_term' = 'Next Step Action');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `next_step_action` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `next_step_date` SET TAGS ('dbx_business_glossary_term' = 'Next Step Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `next_step_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Notes');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_code` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_['pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `probability_percentage` SET TAGS ('dbx_business_glossary_term' = 'Probability Percentage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `probability_percentage` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `probability_percentage` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `proposal_reference` SET TAGS ('dbx_business_glossary_term' = 'Proposal Reference');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `proposal_reference` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `restriction_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `solicitation_stage` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Stage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `solicitation_stage` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `solicitation_stage` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `source_channel` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `stage_changed_date` SET TAGS ('dbx_business_glossary_term' = 'Stage Changed Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `stage_changed_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `stage_changed_date` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `weighted_value` SET TAGS ('dbx_business_glossary_term' = 'Weighted Value');
ALTER TABLE `vibe_ngo_v1`.`donor`.`major_gift_opportunity` ALTER COLUMN `weighted_value` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` SET TAGS ('dbx_subdomain' = 'constituent_management');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `country_office_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_relationship' = 'self_reference');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_hierarchy_self_reference' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_self_reference' = 'hierarchy');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `parent_campaign_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `acknowledgment_template` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Template');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `acknowledgment_template` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `appeal_channel` SET TAGS ('dbx_business_glossary_term' = 'Appeal Channel');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `appeal_channel` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `appeal_description` SET TAGS ('dbx_business_glossary_term' = 'Appeal Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `appeal_description` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled|on_hold');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_status` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'annual_fund|capital_campaign|emergency_appeal|planned_giving|corporate_partnership|digital_online');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `cost_of_fundraising` SET TAGS ('dbx_business_glossary_term' = 'Cost of Fundraising');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `cost_of_fundraising` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `donor_count` SET TAGS ('dbx_business_glossary_term' = 'Donor Count');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `donor_count` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `gift_count` SET TAGS ('dbx_business_glossary_term' = 'Gift Count');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `gift_count` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `goal_amount` SET TAGS ('dbx_business_glossary_term' = 'Campaign Goal Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `goal_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `impact_report_url` SET TAGS ('dbx_business_glossary_term' = 'Impact Report URL');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `impact_report_url` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `is_active` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `is_public` SET TAGS ('dbx_business_glossary_term' = 'Is Public Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `is_public` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `matching_gift_eligible` SET TAGS ('dbx_business_glossary_term' = 'Matching Gift Eligible Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `matching_gift_eligible` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_pii_donor' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `campaign_name` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Percentage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `roi_percentage` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_standard_reference' = 'UN Sustainable Development Goals indicator framework (A/RES/71/313)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `stewardship_plan` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Plan');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `stewardship_plan` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Audience Segment');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `target_audience_segment` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `tax_deductible` SET TAGS ('dbx_business_glossary_term' = 'Tax Deductible Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `tax_deductible` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `total_raised_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Raised Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`campaign` ALTER COLUMN `total_raised_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `campaign_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `fund_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `acknowledgment_template` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Template');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `acknowledgment_template` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'draft|scheduled|active|completed|cancelled|on_hold');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_status` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_business_glossary_term' = 'Appeal Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_value_regex' = 'acquisition|renewal|upgrade|lapsed_reactivation|major_gift|planned_giving');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `ask_amount` SET TAGS ('dbx_business_glossary_term' = 'Suggested Ask Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `ask_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `ask_string` SET TAGS ('dbx_business_glossary_term' = 'Ask String');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `ask_string` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `average_gift_amount` SET TAGS ('dbx_business_glossary_term' = 'Average Gift Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `average_gift_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `average_gift_amount` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Channel');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `channel` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_code` SET TAGS ('dbx_business_glossary_term' = 'Appeal Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_code` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `control_group_flag` SET TAGS ('dbx_business_glossary_term' = 'Control Group Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `control_group_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Appeal Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `cost_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal End Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `end_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `mailing_date` SET TAGS ('dbx_business_glossary_term' = 'Mailing Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `mailing_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `mailing_date` SET TAGS ('dbx_pii_donor' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Appeal Manager Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `manager_name` SET TAGS ('dbx_['pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `manager_name` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `manager_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `manager_name` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `manager_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `manager_name` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `manager_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `manager_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `manager_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `manager_name` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `modified_by` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_business_glossary_term' = 'Appeal Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_['pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `appeal_name` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Appeal Notes');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `package_description` SET TAGS ('dbx_business_glossary_term' = 'Appeal Package Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `package_description` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `package_description` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `pieces_sent` SET TAGS ('dbx_business_glossary_term' = 'Number of Pieces Sent');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `pieces_sent` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `premium_offered` SET TAGS ('dbx_business_glossary_term' = 'Premium Offered');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `premium_offered` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `response_count` SET TAGS ('dbx_business_glossary_term' = 'Response Count');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `response_count` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `response_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Response Rate Percentage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `response_rate_percent` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `roi_ratio` SET TAGS ('dbx_business_glossary_term' = 'Return on Investment (ROI) Ratio');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `roi_ratio` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `solicitor_name` SET TAGS ('dbx_business_glossary_term' = 'Solicitor Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `solicitor_name` SET TAGS ('dbx_['pii_donor'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `solicitor_name` SET TAGS ('dbx_'pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `solicitor_name` SET TAGS ('dbx_'mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `solicitor_name` SET TAGS ('dbx_'pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `solicitor_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `solicitor_name` SET TAGS ('dbx_'uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `solicitor_name` SET TAGS ('dbx_'mask_in_nonprod' = 'true]');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `solicitor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `solicitor_name` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `solicitor_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `solicitor_name` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Start Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `start_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `test_segment_flag` SET TAGS ('dbx_business_glossary_term' = 'Test Segment Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `test_segment_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `total_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Revenue Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `total_revenue_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_ngo_v1`.`donor`.`appeal` ALTER COLUMN `created_by` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` SET TAGS ('dbx_subdomain' = 'fundraising_operations');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `country_office_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `constituent_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `constituent_id` SET TAGS ('dbx_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `audit_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `audit_required` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `balance` SET TAGS ('dbx_business_glossary_term' = 'Fund Balance');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `balance` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `beneficiary_population` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Population');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `beneficiary_population` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_category` SET TAGS ('dbx_business_glossary_term' = 'Fund Category');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_category` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Closure Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `closure_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_description` SET TAGS ('dbx_business_glossary_term' = 'Fund Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_description` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `endowment_spending_policy` SET TAGS ('dbx_business_glossary_term' = 'Endowment Spending Policy');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `endowment_spending_policy` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_business_glossary_term' = 'Fund Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_value_regex' = 'open|closed|suspended|pending_approval');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_value_regex' = 'restricted|temporarily_restricted|unrestricted|endowment|quasi_endowment|board_designated');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country_specific|multi_country');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `iati_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Identifier');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `iati_identifier` SET TAGS ('dbx_standard_reference' = 'IATI Standard v2.03 (iatistandard.org)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Inception Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `inception_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `investment_policy` SET TAGS ('dbx_business_glossary_term' = 'Investment Policy');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `investment_policy` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `minimum_gift_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Gift Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `minimum_gift_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `modified_by` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Name');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_pii_donor' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_mask_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_pii_classification' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_uc_tag' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_mask_in_nonprod' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|upon_request');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `restriction_description` SET TAGS ('dbx_business_glossary_term' = 'Restriction Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `restriction_description` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `restriction_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction Expiration Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `restriction_expiration_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'purpose_restricted|time_restricted|perpetual|unrestricted');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `restriction_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_standard_reference' = 'UN Sustainable Development Goals indicator framework (A/RES/71/313)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `target_countries` SET TAGS ('dbx_business_glossary_term' = 'Target Countries');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `target_countries` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `vibe_ngo_v1`.`donor`.`fund` ALTER COLUMN `created_by` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` SET TAGS ('dbx_subdomain' = 'constituent_management');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Activity ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `appeal_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `appeal_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `campaign_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `constituent_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `constituent_id` SET TAGS ('dbx_sensitivity' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `fund_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `gift_id` SET TAGS ('dbx_business_glossary_term' = 'Gift ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `gift_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `indicator_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `indicator_result_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Result Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `major_gift_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Major Gift Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `major_gift_opportunity_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `pledge_id` SET TAGS ('dbx_business_glossary_term' = 'Pledge ID');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `pledge_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `project_site_id` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `prospect_id` SET TAGS ('dbx_business_glossary_term' = 'Prospect Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `acknowledgement_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Sent Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `acknowledgement_sent_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `acknowledgement_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Sent Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `acknowledgement_sent_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `activity_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `activity_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `activity_description` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `activity_outcome` SET TAGS ('dbx_business_glossary_term' = 'Activity Outcome');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `activity_outcome` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'planned|completed|cancelled|rescheduled|pending');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `activity_subject` SET TAGS ('dbx_business_glossary_term' = 'Activity Subject');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `activity_subject` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'acknowledgement_letter|impact_report|site_visit|phone_call|event_invitation|personal_meeting');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `attendee_count` SET TAGS ('dbx_business_glossary_term' = 'Attendee Count');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `attendee_count` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'in_person|phone|email|video_call|mail|event');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `communication_channel` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Completed Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `completed_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `cost_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `donor_response` SET TAGS ('dbx_business_glossary_term' = 'Donor Response');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `donor_response` SET TAGS ('dbx_value_regex' = 'committed|interested|considering|declined|no_response');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `donor_response` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `donor_sentiment` SET TAGS ('dbx_business_glossary_term' = 'Donor Sentiment');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `donor_sentiment` SET TAGS ('dbx_value_regex' = 'very_positive|positive|neutral|negative|very_negative');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `donor_sentiment` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `engagement_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Score');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `engagement_score` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `engagement_score` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `impact_story_shared_flag` SET TAGS ('dbx_business_glossary_term' = 'Impact Story Shared Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `impact_story_shared_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Activity Location');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `location` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `location` SET TAGS ('dbx_pii_detected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `next_steps` SET TAGS ('dbx_business_glossary_term' = 'Next Steps');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `next_steps` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `priority_level` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `solicitation_amount` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Amount');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `solicitation_amount` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `solicitation_made_flag` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Made Flag');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `solicitation_made_flag` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_plan_stage` SET TAGS ('dbx_business_glossary_term' = 'Stewardship Plan Stage');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_plan_stage` SET TAGS ('dbx_value_regex' = 'identification|cultivation|solicitation|stewardship|renewal');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_plan_stage` SET TAGS ('dbx_standard_reference' = 'IATI Organisation Standard v2.03; ASC 958-605 Revenue Recognition; IPSAS 23; Form 990 Schedule B; Fundraising Regulator (UK) Code of Practice');
ALTER TABLE `vibe_ngo_v1`.`donor`.`stewardship_activity` ALTER COLUMN `stewardship_plan_stage` SET TAGS ('dbx_pii_detected' = 'true');
