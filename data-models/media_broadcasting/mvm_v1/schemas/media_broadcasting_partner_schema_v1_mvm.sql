-- Schema for Domain: partner | Business: Media Broadcasting | Version: v1_mvm
-- Generated on: 2026-05-08 19:23:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `media_broadcasting_ecm`.`partner` COMMENT 'Manages relationships, contracts, and negotiations with studios, syndicators, content providers, MVPDs, and third-party distribution partners. Tracks partner agreements, content acquisition deals, co-production arrangements, and affiliate relationships that feed into rights, distribution, and finance domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` (
    `partner_id` BIGINT COMMENT 'Unique identifier for the partner_partner data product (auto-inserted pre-linking).',
    `legal_entity_id` BIGINT COMMENT 'Unique identifier for the partner entity. Primary key for the partner master record.',
    `partner_partner_id` BIGINT COMMENT 'Reference to the parent partner entity in cases where this partner is a subsidiary or division of a larger corporate entity. Enables tracking of corporate hierarchies and consolidated relationships. Null for top-level parent entities.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Partners (distributors, affiliates, content licensors, co-producers) must meet specific regulatory obligations (content standards, closed captioning, political advertising rules, childrens programmin',
    `annual_content_volume_hours` DECIMAL(18,2) COMMENT 'Estimated or actual annual volume of content hours acquired from or distributed through this partner. Used for capacity planning, content pipeline forecasting, and partner performance evaluation.',
    `annual_revenue_contribution_usd` DECIMAL(18,2) COMMENT 'Estimated or actual annual revenue contribution from this partner relationship in USD. Includes content licensing fees, distribution revenue share, advertising revenue, or other monetization streams. Used for partner valuation and ROI analysis.',
    `content_specialization` STRING COMMENT 'Primary content genres, formats, or categories that the partner specializes in producing or distributing. Examples include scripted drama, unscripted reality, sports, news, childrens programming, documentary, or multi-genre. Supports content acquisition strategy and partner matching.',
    `contract_renewal_date` DATE COMMENT 'Next scheduled date for master agreement renewal or renegotiation with this partner. Used for relationship management planning, contract pipeline tracking, and ensuring continuity of content supply or distribution.',
    `corporate_hierarchy_level` STRING COMMENT 'Numeric level in the corporate hierarchy tree where 1 represents the ultimate parent entity and higher numbers represent deeper subsidiary levels. Used for roll-up reporting and consolidated analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner record was first created in the system. Used for audit trail, data lineage tracking, and record age analysis.',
    `credit_rating` STRING COMMENT 'External credit rating assigned by rating agencies such as Moodys, S&P, or Fitch. Used for financial risk assessment, contract negotiation, and determining payment terms or guarantees required.',
    `distribution_territories` STRING COMMENT 'Geographic territories or markets where the partner operates or holds distribution rights. Stored as comma-separated list of country codes or region identifiers. Critical for rights management and windowing strategy.',
    `domicile_country_code` STRING COMMENT 'Three-letter ISO country code representing the legal domicile jurisdiction where the partner entity is incorporated or registered. Determines applicable regulatory frameworks and tax treaties.. Valid values are `^[A-Z]{3}$`',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet to identify business entities globally. Used for credit assessment, vendor management, and corporate hierarchy tracking.. Valid values are `^[0-9]{9}$`',
    `headquarters_address_line1` STRING COMMENT 'First line of the physical headquarters address including street number and street name. Used for legal correspondence, contract execution, and regulatory filings.',
    `headquarters_address_line2` STRING COMMENT 'Second line of the physical headquarters address for suite, floor, building name, or other secondary address details.',
    `headquarters_city` STRING COMMENT 'City or municipality where the partner headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO country code for the headquarters location. May differ from domicile_country_code if the operational headquarters is in a different jurisdiction than legal incorporation.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the headquarters address. Format varies by country postal system.',
    `headquarters_state_province` STRING COMMENT 'State, province, or primary administrative subdivision where the partner headquarters is located. Format varies by country.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the partnership includes exclusivity provisions that restrict either party from engaging with competing partners in specified territories, content categories, or distribution channels. Critical for rights management and competitive strategy.',
    `last_modified_by` STRING COMMENT 'User identifier or system account that performed the most recent modification to this partner record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner record was most recently updated. Used for change tracking, data freshness monitoring, and audit trail.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special considerations, relationship history, or operational notes about the partner that do not fit structured fields. Used by relationship managers for institutional knowledge capture.',
    `onboarding_stage` STRING COMMENT 'Current stage in the partner onboarding workflow. Tracks progression from initial prospect through due diligence, contract negotiation, legal review, approval, and final onboarding completion.. Valid values are `prospect|due_diligence|contract_negotiation|legal_review|approved|onboarded`',
    `partner_code` STRING COMMENT 'Externally-known unique business identifier for the partner used in operational systems, contracts, and inter-company communications. Typically assigned during onboarding.. Valid values are `^[A-Z0-9]{3,12}$`',
    `partner_name` STRING COMMENT 'The full legal name of the partner organization as registered with governing authorities. Used for contracts, invoicing, and legal documentation.',
    `partner_type` STRING COMMENT 'Primary classification of the partner based on their role in the media ecosystem. Studios produce original content, syndicators distribute content to multiple outlets, content providers supply licensed material, MVPDs are traditional cable/satellite distributors, vMVPDs are virtual distributors, and OTT aggregators operate streaming platforms.. Valid values are `studio|syndicator|content_provider|mvpd|vmvpd|ott_aggregator`',
    `preferred_payment_terms` STRING COMMENT 'Standard payment terms negotiated with the partner for content licensing, royalties, or service fees. Examples include Net 30, Net 60, advance against royalties, or milestone-based payments. Feeds into accounts payable and cash flow planning.',
    `primary_contact_email` STRING COMMENT 'Primary email address for the main business contact at the partner organization. Used for operational communications, contract notifications, and relationship management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the partner organization responsible for day-to-day relationship management and operational coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the main business contact at the partner organization. Includes country code and extension where applicable.',
    `relationship_end_date` DATE COMMENT 'Date when the business relationship with this partner was formally terminated or is scheduled to end. Null for active ongoing relationships. Used for historical analysis and transition planning.',
    `relationship_start_date` DATE COMMENT 'Date when the business relationship with this partner was formally established, typically corresponding to the first executed agreement or onboarding completion. Used for relationship tenure analysis and anniversary tracking.',
    `relationship_status` STRING COMMENT 'Current lifecycle state of the business relationship. Active indicates ongoing business, pending indicates onboarding in progress, suspended indicates temporary hold, inactive indicates no current agreements, and terminated indicates relationship ended.. Valid values are `active|inactive|suspended|pending|terminated`',
    `risk_tier` STRING COMMENT 'Internal risk classification based on financial stability, contract compliance history, operational reliability, and strategic importance. Used for relationship management prioritization and escalation protocols.. Valid values are `low|medium|high|critical`',
    `strategic_tier` STRING COMMENT 'Classification of the partners strategic importance to the business. Tier 1 represents critical strategic partners with significant content volume or distribution reach, Tier 2 represents important but not critical partners, Tier 3 represents transactional relationships, and emerging represents new partners under evaluation.. Valid values are `tier_1|tier_2|tier_3|emerging`',
    `subtype` STRING COMMENT 'Secondary classification providing additional granularity within the partner type. Examples include major studio vs independent studio, first-run syndicator vs off-network syndicator, FAST channel operator, co-production house, or affiliate network.',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number for the partner entity. Format varies by jurisdiction (e.g., EIN in USA, VAT number in EU, GST number in other regions). Used for tax reporting and compliance.',
    CONSTRAINT pk_partner_partner PRIMARY KEY(`partner_id`)
) COMMENT 'Master record for all external business partners including studios, syndicators, content providers, MVPDs, vMVPDs, FAST channel operators, and third-party distribution partners. Serves as the SSOT for partner identity, classification, legal entity details, and relationship status. Tracks partner type (studio, syndicator, MVPD, OTT aggregator, co-production house), corporate hierarchy, domicile jurisdiction, and onboarding lifecycle stage.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique identifier for the partner contact record. Primary key.',
    `partner_id` BIGINT COMMENT 'Reference to the partner organization this contact is associated with. Links to the partner master record.',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: In media broadcasting, partner contacts are sometimes talent themselves (producer-directors, showrunners with production companies, talent-owned studios). Essential for dual-role tracking, conflict of',
    `assistant_email` STRING COMMENT 'The email address of the contacts executive assistant, used for meeting coordination and scheduling.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assistant_name` STRING COMMENT 'The name of the contacts executive assistant or administrative support person, if applicable. Used for scheduling and coordination.',
    `assistant_phone` STRING COMMENT 'The phone number of the contacts executive assistant, used for urgent scheduling needs and coordination.',
    `communication_language` STRING COMMENT 'The preferred language for business communications with this contact, specified using ISO 639-1 two-letter language codes (e.g., EN, ES, FR).',
    `contact_status` STRING COMMENT 'Current lifecycle status of the partner contact. Indicates whether the contact is actively engaged, temporarily unavailable, or no longer with the partner organization.. Valid values are `active|inactive|on_leave|terminated`',
    `contract_signatory` BOOLEAN COMMENT 'Boolean flag indicating whether this contact has legal authority to sign contracts and binding agreements on behalf of the partner organization.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this partner contact record was first created in the system. Used for audit trail and data lineage.',
    `decision_making_authority` STRING COMMENT 'The level of decision-making authority the contact has within their organization for partnership matters, contract negotiations, and business agreements.. Valid values are `full|limited|advisory|none`',
    `department` STRING COMMENT 'The department or division within the partner organization where the contact works (e.g., Legal, Finance, Content Operations, Business Development).',
    `email_address` STRING COMMENT 'Primary email address for the partner contact. Used for official communications, contract negotiations, and business correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `end_date` DATE COMMENT 'The date when this individual ceased to be an active contact, either due to role change, departure from the partner organization, or relationship termination.',
    `first_name` STRING COMMENT 'The first name or given name of the partner contact individual.',
    `full_name` STRING COMMENT 'The complete formatted name of the partner contact, typically combining first, middle, and last names.',
    `is_primary_contact` BOOLEAN COMMENT 'Boolean flag indicating whether this contact is the primary or main point of contact for the partner organization.',
    `job_title` STRING COMMENT 'The official job title or position of the contact within the partner organization (e.g., Vice President of Content Acquisition, Director of Business Development, Legal Counsel).',
    `last_contact_date` DATE COMMENT 'The date of the most recent business interaction or communication with this partner contact. Used for relationship health tracking.',
    `last_name` STRING COMMENT 'The last name or family name of the partner contact individual.',
    `linkedin_profile_url` STRING COMMENT 'The URL to the contacts professional LinkedIn profile, used for professional networking and background verification.',
    `mobile_number` STRING COMMENT 'Mobile or cell phone number for the partner contact, used for urgent communications and on-the-go accessibility.',
    `nda_signed_date` DATE COMMENT 'The date when the contact signed a non-disclosure agreement with Media Broadcasting, if applicable. Used to track confidentiality obligations.',
    `next_scheduled_contact_date` DATE COMMENT 'The planned date for the next scheduled interaction or follow-up with this partner contact. Supports proactive relationship management.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional information, preferences, interaction history, or special considerations related to the partner contact.',
    `office_location` STRING COMMENT 'The physical office location or city where the contact is based within the partner organization.',
    `phone_number` STRING COMMENT 'Primary business phone number for the partner contact, including country code and extension if applicable.',
    `preferred_communication_method` STRING COMMENT 'The contacts preferred method of communication for business interactions and negotiations.. Valid values are `email|phone|mobile|video_conference|in_person`',
    `role_type` STRING COMMENT 'The functional role category of the contact within the partnership context. Defines the primary area of responsibility and engagement. [ENUM-REF-CANDIDATE: executive|legal|business_development|technical|finance|operations|marketing — 7 candidates stripped; promote to reference product]',
    `start_date` DATE COMMENT 'The date when this individual became a contact for the partner organization or when the relationship with Media Broadcasting began.',
    `time_zone` STRING COMMENT 'The time zone where the contact is primarily located, using IANA time zone database format (e.g., America/New_York, Europe/London). Used for scheduling meetings and calls.',
    `updated_by` STRING COMMENT 'The user identifier or name of the person who last modified this partner contact record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this partner contact record was last modified. Used for audit trail and change tracking.',
    `created_by` STRING COMMENT 'The user identifier or name of the person who created this partner contact record in the system.',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Individual contacts associated with a partner organization — executives, legal representatives, business development leads, technical liaisons, and finance contacts. Tracks name, title, role type, communication preferences, and relationship owner within Media Broadcasting. Supports negotiation workflows and partner relationship management.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` (
    `acquisition_deal_id` BIGINT COMMENT 'Unique identifier for the content acquisition deal. Primary key for the acquisition deal entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.partner_agreement. Business justification: Acquisition deals are typically executed under a master partner agreement that establishes the overarching commercial relationship. Linking acquisition_deal to partner_agreement enables tracing indivi',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Acquisition deals for broadcast distribution must verify licensed coverage matches contracted territories. Compliance officers cross-reference deal territories against FCC-licensed footprints to ensur',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Acquisition deals often specify target broadcast channels for content placement (e.g., primetime slot on flagship channel). Critical for content scheduling coordination, deal fulfillment tracking, and',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Content acquisition costs are allocated to cost centers for budget management, variance analysis, and content spend tracking. Essential for production vs. acquisition cost analysis and departmental bu',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Acquisition deals are evaluated and priced based on target demographic appeal of the content being acquired. Essential for content acquisition ROI analysis and portfolio strategy.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the broadcasters legal entity that is the contracting party for this acquisition deal, relevant for multi-entity corporate structures.',
    `partner_id` BIGINT COMMENT 'Reference to the studio, syndicator, or independent content provider from whom content is being acquired. Links to partner master data.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Acquisition deals impact specific profit center EBITDA through content amortization and revenue generation. Critical for segment P&L reporting, content ROI analysis, and business unit performance meas',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: Acquisition deals generate sales opportunities and require tracking the internal sales account managing the partner relationship. Enables sales credit allocation, commission calculation, and account-l',
    `content_delivery_format` STRING COMMENT 'Technical specifications for content delivery including file formats, resolution standards, and delivery methods (e.g., HD 1080p ProRes, 4K HEVC, physical media, digital file transfer).',
    `content_package_scope` STRING COMMENT 'Detailed description of the content included in this acquisition deal, including series titles, episode counts, seasons, or film packages.',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the executed contract document stored in the document management system.',
    `contract_execution_date` DATE COMMENT 'Date when the acquisition deal contract was formally signed and executed by all parties, marking the transition from negotiation to binding agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this acquisition deal record was first created in the system, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this acquisition deal (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `deal_effective_date` DATE COMMENT 'Date when the acquisition deal terms become effective and rights begin to accrue, which may differ from execution date.',
    `deal_expiration_date` DATE COMMENT 'Date when the acquisition deal expires and rights revert to the content provider, marking the end of the license period.',
    `deal_number` STRING COMMENT 'Externally-known business identifier for the acquisition deal, typically formatted with prefix and sequential number for tracking and reference in contracts and communications.. Valid values are `^[A-Z]{2,4}-[0-9]{4,8}$`',
    `deal_status` STRING COMMENT 'Current lifecycle status of the acquisition deal from initial draft through negotiation, execution, and eventual expiration or termination. [ENUM-REF-CANDIDATE: draft|negotiation|legal_review|approved|executed|active|expired|terminated|cancelled — 9 candidates stripped; promote to reference product]',
    `deal_title` STRING COMMENT 'Human-readable name or title of the acquisition deal, typically reflecting the content package or series being acquired.',
    `deal_type` STRING COMMENT 'Classification of the deal structure indicating the financial arrangement: flat fee (fixed payment), revenue share (percentage of revenue), minimum guarantee (MG with upside), hybrid (combination), or barter (exchange of services/inventory).. Valid values are `flat_fee|revenue_share|minimum_guarantee|hybrid|barter`',
    `deal_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the acquisition deal in the specified currency, representing the gross commitment before adjustments.',
    `distribution_rights` STRING COMMENT 'Comma-separated list of distribution platforms and methods covered by this deal (e.g., linear, SVOD, AVOD, TVOD, FAST, syndication, VOD).',
    `episode_count` STRING COMMENT 'Total number of episodes included in the acquisition deal for episodic content such as television series.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the acquisition deal grants exclusive rights within the specified territory, preventing the content provider from licensing to competitors.',
    `exclusivity_scope` STRING COMMENT 'Detailed description of exclusivity terms, including platform restrictions, genre exclusivity, or time-based exclusivity windows.',
    `holdback_period_days` STRING COMMENT 'Number of days during which content must be withheld from certain distribution channels or platforms as part of windowing strategy or exclusivity terms.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this acquisition deal record was most recently updated, supporting audit trail and change tracking requirements.',
    `license_term_months` STRING COMMENT 'Duration of the content license in months, representing the period during which the broadcaster has rights to exploit the acquired content.',
    `marketing_materials_included_flag` BOOLEAN COMMENT 'Indicates whether the deal includes delivery of marketing and promotional materials such as trailers, key art, press kits, and promotional clips.',
    `metadata_requirements` STRING COMMENT 'Specifications for content metadata to be delivered with the content package, including descriptive, technical, and rights metadata standards.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment to the content provider regardless of performance, applicable for minimum guarantee and hybrid deal structures.',
    `negotiation_start_date` DATE COMMENT 'Date when formal negotiations for this acquisition deal commenced.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special terms, or contextual information about the acquisition deal not captured in structured fields.',
    `payment_schedule` STRING COMMENT 'Detailed schedule of payment milestones and amounts, including upfront payments, delivery payments, and ongoing royalty schedules.',
    `performance_guarantees` STRING COMMENT 'Contractual performance commitments such as minimum broadcast hours, promotional support, or audience delivery guarantees required by the content provider.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the broadcaster has the option to renew or extend the acquisition deal beyond the initial term.',
    `renewal_terms` STRING COMMENT 'Detailed terms governing deal renewal, including notice periods, pricing adjustments, and conditions for exercising renewal options.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue shared with the content provider for revenue share and hybrid deal structures, typically applied after minimum guarantee recoupment.',
    `sublicensing_allowed_flag` BOOLEAN COMMENT 'Indicates whether the broadcaster is permitted to sublicense the acquired content to third parties such as MVPDs, vMVPDs, or international distributors.',
    `sublicensing_terms` STRING COMMENT 'Detailed terms and restrictions governing sublicensing rights, including revenue sharing with original content provider and territorial limitations.',
    `territory_coverage` STRING COMMENT 'Geographic territories or markets covered by this acquisition deal, specified as comma-separated ISO 3166-1 alpha-3 country codes or regional designations (e.g., USA, CAN, GBR, or NORTH_AMERICA).',
    `total_runtime_hours` DECIMAL(18,2) COMMENT 'Aggregate runtime of all content included in the acquisition deal, measured in hours, used for inventory planning and scheduling.',
    `windowing_strategy` STRING COMMENT 'Sequential release strategy defining the order and timing of content availability across different platforms and distribution channels.. Valid values are `day_and_date|theatrical_holdback|svod_first|linear_first|staggered|simultaneous`',
    CONSTRAINT pk_acquisition_deal PRIMARY KEY(`acquisition_deal_id`)
) COMMENT 'Master record for content acquisition deals negotiated with studios, syndicators, and independent content providers. Captures deal structure (flat fee, revenue share, MG/minimum guarantee), content package scope, exclusivity terms, territory coverage, windowing strategy (SVOD, AVOD, TVOD, linear), and deal status through the full negotiation-to-execution lifecycle. Source of truth for content acquisition commitments feeding into the rights and finance domains.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` (
    `acquisition_deal_line_id` BIGINT COMMENT 'Unique identifier for the acquisition deal line item. Primary key for this entity.',
    `acquisition_deal_id` BIGINT COMMENT 'Reference to the parent acquisition deal that contains this line item. Links this line to the master deal agreement.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Revenue recognition for individual content license lines requires GL account mapping for ASC 606 compliance and financial statement preparation. Each line item may have different revenue treatment req',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Individual titles and episodes in acquisition deal lines have specific rating requirements for the licensed territory and platform. Compliance verification at the line-item level ensures each delivere',
    `title_id` BIGINT COMMENT 'Reference to the specific content title, episode, season, or package being acquired in this line item.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Content acquisition line items target specific audience demographics (A18-49, families, etc.) to guide programming strategy and justify license fees. Buyers negotiate rights based on expected demo per',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Each acquisition deal line item must be matched to a rights grant to verify that the specific content being acquired has proper rights authorization. Rights verification per deal line is a standard me',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Deal lines license specific assets, not just titles. MAM systems must link assets to deal lines for automated rights validation, windowing enforcement, royalty calculation, and compliance reporting in',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Deal lines specify territory coverage for each content item. Normalizing territory_code to rights_territory_id ensures consistent territory management and enables rights availability checks per deal l',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Content acquisition deals often include attached talent as a key deal point—star power drives content valuation and marketing strategy. Essential for deal valuation models, marketing rights clearance,',
    `content_type` STRING COMMENT 'Classification of the content being acquired in this line item. Determines rights structure and windowing strategy. [ENUM-REF-CANDIDATE: film|series|season|episode|documentary|special|sports_event|news_package|music_video|short_form — 10 candidates stripped; promote to reference product]',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this acquisition deal line record. Supports audit and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this acquisition deal line record was first created in the system. Audit trail for data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this line item.. Valid values are `^[A-Z]{3}$`',
    `delivery_due_date` DATE COMMENT 'The date by which the content provider must deliver the content asset for this line item. Critical for production scheduling and playout planning.',
    `delivery_format` STRING COMMENT 'Technical format and delivery method for the content asset associated with this line item. Determines ingest and playout requirements. [ENUM-REF-CANDIDATE: hd|4k|sd|film|digital_file|tape|satellite|ftp|aspera|physical_media — 10 candidates stripped; promote to reference product]',
    `delivery_status` STRING COMMENT 'Current status of content delivery for this line item. Tracks the fulfillment lifecycle from order to ingest.. Valid values are `pending|in_transit|received|ingested|rejected|delayed`',
    `distribution_rights` STRING COMMENT 'Comma-separated list of distribution rights granted for this content line item. May include linear, VOD, SVOD, AVOD, TVOD, theatrical, home video, digital download, streaming, broadcast, cable, satellite, OTT, FAST, syndication, etc. [ENUM-REF-CANDIDATE: promote to reference product and junction table for complex rights matrices]',
    `dubbing_languages` STRING COMMENT 'Comma-separated list of ISO 639 language codes for dubbed audio tracks included with this content line item. Supports multi-territory distribution.',
    `eidr_identifier` STRING COMMENT 'Unique EIDR identifier for the content in this line item. Global standard for audiovisual content identification.. Valid values are `^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z]$`',
    `episode_count` STRING COMMENT 'Number of episodes included in this line item if the content type is series or season. Null for single-title content.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the rights granted for this line item are exclusive (true) or non-exclusive (false). Impacts windowing and competitive distribution.',
    `genre_primary` STRING COMMENT 'Primary genre classification for the content in this line item. Used for programming strategy and audience analytics.',
    `holdback_restrictions` STRING COMMENT 'Description of any holdback periods or exclusivity restrictions that limit when or how this content can be exploited. Includes blackout periods and sequential windowing constraints.',
    `language_code` STRING COMMENT 'Primary language of the content in this line item. ISO 639 two or three-letter language code.. Valid values are `^[a-z]{2,3}$`',
    `license_duration_months` STRING COMMENT 'Total duration of the license term expressed in months. Calculated from start and end dates for reporting and windowing analysis.',
    `license_fee_amount` DECIMAL(18,2) COMMENT 'The base license fee amount for this specific content line item. Represents the core acquisition cost before adjustments.',
    `license_term_end_date` DATE COMMENT 'The date when the license rights for this content line item expire. Marks the end of the rights window.',
    `license_term_start_date` DATE COMMENT 'The date when the license rights for this content line item become effective. Marks the beginning of the rights window.',
    `line_number` STRING COMMENT 'Sequential line number within the parent acquisition deal. Used for ordering and referencing specific line items within the deal.',
    `line_status` STRING COMMENT 'Current lifecycle status of this acquisition deal line item. Tracks progression from negotiation through fulfillment and expiration.. Valid values are `draft|active|fulfilled|cancelled|expired|suspended`',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guarantee payment amount for this line item. Represents the floor payment regardless of performance or usage.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this acquisition deal line record. Supports audit and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this acquisition deal line record was last modified. Audit trail for change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this acquisition deal line item. Captures special terms, exceptions, or operational instructions.',
    `payment_schedule` STRING COMMENT 'Payment structure for this line item. Defines when and how license fees and guarantees are paid to the content provider.. Valid values are `upfront|on_delivery|installment|revenue_share|hybrid`',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice or delivery milestone until payment is due for this line item. Standard commercial payment terms.',
    `production_year` STRING COMMENT 'Year the content was originally produced or released. Used for catalog management and rights valuation.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate for revenue-sharing or usage-based royalty payments on this content line item. Applied to calculate residuals beyond minimum guarantee.',
    `runs_allowed` STRING COMMENT 'Maximum number of broadcast or exhibition runs permitted for this content line item during the license term. Null indicates unlimited runs.',
    `runtime_minutes` STRING COMMENT 'Total runtime duration in minutes for the content in this line item. Used for scheduling and inventory management.',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of ISO 639 language codes for subtitles or closed captions included with this content line item. Supports accessibility and localization requirements.',
    CONSTRAINT pk_acquisition_deal_line PRIMARY KEY(`acquisition_deal_line_id`)
) COMMENT 'Individual line items within a content acquisition deal, each representing a specific title, episode, season, or content package with its own financial terms, window schedule, territory rights, and delivery obligations. Enables granular tracking of per-title economics within a multi-title deal and feeds rights windowing and royalty calculation processes.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` (
    `distribution_agreement_id` BIGINT COMMENT 'Unique identifier for the distribution agreement. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.partner_agreement. Business justification: Distribution agreements with MVPDs and OTT aggregators are often executed under a master partner agreement. Linking distribution_agreement to partner_agreement establishes the contract hierarchy, allo',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Distribution agreements for linear broadcast channels reference specific licensed facilities. Retransmission consent agreements, carriage deals, and network distribution contracts all specify call sig',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Distribution agreements specify which channels carry content (e.g., cable carriage agreements, affiliate distribution). Fundamental to carriage fee calculation, must-carry compliance, channel position',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Distribution agreements are executed by specific legal entities for proper revenue recognition, tax jurisdiction determination, and SOX compliance. Essential for carriage fee revenue allocation and in',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Distribution operations costs (technical delivery, QC, customer support) are tracked by cost center for P&L reporting and operational expense management. Essential for distribution business unit finan',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Distribution agreements specify which DMAs/markets the partner can distribute content in. Essential for territorial rights management and ensuring distribution partners operate within contracted geogr',
    `partner_id` BIGINT COMMENT 'Reference to the distribution partner (MVPD, vMVPD, cable operator, satellite provider, OTT aggregator) that is party to this agreement.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Carriage fee revenue and minimum guarantees from distribution agreements must be attributed to profit centers for segment reporting, EBITDA calculation, and business unit profitability analysis requir',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: Distribution agreements are managed by sales teams and require account ownership tracking for territory management, quota allocation, and renewal forecasting. Standard sales operations practice in med',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the distribution agreement indicating its operational state. [ENUM-REF-CANDIDATE: draft|negotiation|active|suspended|terminated|expired|renewal_pending — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the distribution agreement based on the nature of the relationship and regulatory framework (e.g., carriage, retransmission consent, must-carry, syndication, OTT distribution, affiliate).. Valid values are `carriage|retransmission_consent|must_carry|syndication|ott_distribution|affiliate`',
    `approval_date` DATE COMMENT 'Date when the distribution agreement received final internal approval before execution.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive who provided final approval for this distribution agreement.',
    `audit_rights_included` BOOLEAN COMMENT 'Indicates whether Media Broadcasting retains the right to audit the distributors subscriber counts, revenue reports, and compliance with agreement terms.',
    `blackout_restrictions` STRING COMMENT 'Description of geographic or content-based blackout restrictions that apply to this distribution agreement (e.g., sports blackouts, regional exclusions).',
    `carriage_fee_amount` DECIMAL(18,2) COMMENT 'Base carriage fee amount per the agreement structure. Interpretation depends on carriage_fee_structure (e.g., per-subscriber monthly rate, annual flat fee).',
    `carriage_fee_structure` STRING COMMENT 'Pricing model for carriage fees paid by the distributor to Media Broadcasting (per-subscriber, flat rate, tiered, revenue share, hybrid).. Valid values are `per_subscriber|flat_rate|tiered|revenue_share|hybrid`',
    `channel_positioning_tier` STRING COMMENT 'Service tier or package level where the channels must be positioned in the distributors lineup (basic, expanded basic, digital, premium, sports tier, custom).. Valid values are `basic|expanded_basic|digital|premium|sports_tier|custom`',
    `channels_included` STRING COMMENT 'List or description of Media Broadcasting channels covered by this distribution agreement (e.g., primary network, secondary channels, HD feeds, regional variants).',
    `contract_document_url` STRING COMMENT 'URL or file path to the signed distribution agreement contract document stored in the document management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this agreement.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when the distribution agreement becomes legally binding and operational.',
    `expiration_date` DATE COMMENT 'Date when the distribution agreement terminates or expires. Nullable for evergreen agreements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution agreement record was last updated in the system.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount from the distributor over the agreement term, regardless of actual subscriber counts or usage.',
    `must_carry_obligation` BOOLEAN COMMENT 'Indicates whether this agreement includes must-carry obligations under FCC regulations requiring the distributor to carry the broadcast signal.',
    `negotiated_by` STRING COMMENT 'Name or identifier of the Media Broadcasting executive or team responsible for negotiating this distribution agreement.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which the distributor must remit carriage fees to Media Broadcasting.',
    `renewal_terms` STRING COMMENT 'Description of renewal terms including automatic renewal provisions, notice periods, and renegotiation triggers.',
    `reporting_frequency` STRING COMMENT 'Frequency at which the distributor must provide subscriber counts, viewership data, and revenue reports to Media Broadcasting.. Valid values are `daily|weekly|monthly|quarterly|annual`',
    `retransmission_consent_granted` BOOLEAN COMMENT 'Indicates whether Media Broadcasting has granted retransmission consent allowing the distributor to rebroadcast the signal.',
    `sla_response_time_hours` STRING COMMENT 'Maximum response time in hours for addressing service disruptions or technical issues under the SLA.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Minimum uptime percentage guaranteed under the Service Level Agreement (SLA) for signal delivery and availability.',
    `streaming_rights_included` BOOLEAN COMMENT 'Indicates whether the agreement includes rights for the distributor to offer live streaming or simulcast of Media Broadcasting channels via OTT platforms.',
    `svod_rights_included` BOOLEAN COMMENT 'Indicates whether the agreement includes rights for the distributor to offer Subscription Video On Demand (SVOD) access as part of a subscription package.',
    `termination_date` DATE COMMENT 'Actual date when the agreement was terminated, if applicable. Nullable for active agreements.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement prior to expiration.',
    `termination_reason` STRING COMMENT 'Reason for early termination of the agreement, if applicable (e.g., breach of contract, mutual agreement, business closure).',
    `territory` STRING COMMENT 'Geographic territory or market covered by this distribution agreement. May include country codes, DMA codes, or regional descriptors.',
    `tvod_rights_included` BOOLEAN COMMENT 'Indicates whether the agreement includes rights for the distributor to offer Transactional Video On Demand (TVOD) access where viewers pay per transaction.',
    `vod_rights_included` BOOLEAN COMMENT 'Indicates whether the agreement includes rights for the distributor to offer Video On Demand (VOD) access to Media Broadcasting content.',
    `vod_window_days` STRING COMMENT 'Number of days that content remains available in the distributors VOD library after initial broadcast, if VOD rights are included.',
    CONSTRAINT pk_distribution_agreement PRIMARY KEY(`distribution_agreement_id`)
) COMMENT 'Formal distribution agreements with MVPDs, vMVPDs, cable operators, satellite providers, and OTT aggregators governing carriage of Media Broadcasting channels and content. Tracks carriage fee structures, must-carry obligations, retransmission consent terms, blackout restrictions, channel positioning commitments, and SLA obligations. Distinct from content acquisition deals — this governs outbound distribution rather than inbound content.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` (
    `syndication_agreement_id` BIGINT COMMENT 'Unique identifier for the syndication agreement. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.partner_agreement. Business justification: Syndication agreements governing content distribution to third-party broadcasters are typically executed under a master partner agreement. This FK establishes the contract hierarchy between individual',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Syndication agreements for broadcast distribution require the syndicating station to hold valid FCC licenses covering the agreed territories. Clearance obligations and territorial exclusivity are defi',
    `channel_id` BIGINT COMMENT 'Foreign key linking to scheduling.channel. Business justification: Syndication deals specify broadcast channels for content airing (e.g., off-network syndication to local stations). Essential for syndication scheduling, clearance tracking, run limit enforcement, and ',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Syndication agreements specify acceptable content ratings for target dayparts and audience demographics. Syndicators require content rated appropriately for early fringe, access, or late-night windows',
    `title_id` BIGINT COMMENT 'Reference to the primary content title being syndicated under this agreement.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Syndication deals require legal entity tracking for revenue allocation, tax treatment, and intercompany elimination. Critical for ASC 606 performance obligation tracking and multi-territory revenue re',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Syndication operations expenses (content delivery, clearance verification, reporting) are allocated to cost centers for operational expense tracking and syndication business unit cost management and b',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Syndication agreements grant rights to specific markets/DMAs. Essential for syndication clearance tracking and ensuring syndication partners broadcast only in contracted markets.',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Syndication agreements grant rights to specific asset packages (e.g., 100-episode library). Direct asset link enables automated rights clearance in playout systems, run-limit enforcement, and syndicat',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Syndication revenue (flat fees, per-episode fees, revenue share) must be attributed to profit centers for syndication business segment P&L reporting and profitability analysis by territory and content',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: Syndication deals are sales-managed and require account ownership for commission tracking, renewal management, and sales performance reporting. Core business process in broadcast syndication operation',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Syndication agreements for selling content distribution rights originate from sales opportunities when the sales team identifies potential syndication partners. Links the sales pipeline to executed sy',
    `partner_id` BIGINT COMMENT 'Reference to the third-party broadcaster, regional station, or international network acquiring syndication rights.',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Syndication deals may require talent consent/clearance for promotional use and residual payment routing, especially for above-the-line talent with approval rights. Essential for talent clearance workf',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the syndication agreement. [ENUM-REF-CANDIDATE: draft|negotiation|pending_approval|active|suspended|terminated|expired — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the syndication agreement based on geographic scope and compensation structure.. Valid values are `domestic_syndication|international_syndication|regional_syndication|barter_syndication|cash_syndication|cash_plus_barter`',
    `audit_rights_flag` BOOLEAN COMMENT 'Indicates whether Media Broadcasting retains the right to audit the syndication partners broadcast logs and financial records.',
    `barter_spot_count` STRING COMMENT 'Number of advertising spots retained by Media Broadcasting per episode in barter syndication arrangements.',
    `broadcast_standard` STRING COMMENT 'Technical broadcast standard required for content delivery in the syndication territory.. Valid values are `ATSC|DVB|ISDB|DTMB`',
    `clearance_obligation` STRING COMMENT 'Party responsible for obtaining broadcast clearances and rights verification in the syndication territory.. Valid values are `broadcaster|syndicator|shared`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this syndication agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this agreement.. Valid values are `^[A-Z]{3}$`',
    `delivery_format` STRING COMMENT 'Technical format and specifications for content delivery to the syndication partner (e.g., HD 1080p, 4K, file-based, tape).',
    `effective_end_date` DATE COMMENT 'Date when the syndication agreement expires and content rights revert. Nullable for open-ended agreements subject to termination clauses.',
    `effective_start_date` DATE COMMENT 'Date when the syndication agreement becomes binding and content rights become available for syndication.',
    `episode_count` STRING COMMENT 'Total number of episodes included in the syndication agreement. Applicable for series content.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the syndication partner has exclusive broadcast rights in the granted territory during the agreement period.',
    `exclusivity_window_end_date` DATE COMMENT 'End date of the exclusivity period. Nullable if exclusivity_flag is false.',
    `exclusivity_window_start_date` DATE COMMENT 'Start date of the exclusivity period during which no other syndication partner may broadcast the content in the granted territory. Nullable if exclusivity_flag is false.',
    `flat_fee_amount` DECIMAL(18,2) COMMENT 'Total flat fee amount for the entire syndication agreement. Applicable when syndication_fee_structure is flat_fee or hybrid.',
    `holdback_period_days` STRING COMMENT 'Number of days after original broadcast during which content cannot be syndicated, protecting the original broadcast window.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this syndication agreement record was last updated.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount regardless of actual revenue or performance. Applicable in revenue-share agreements.',
    `notes` STRING COMMENT 'Free-form notes capturing special terms, amendments, or contextual information about the syndication agreement.',
    `payment_terms` STRING COMMENT 'Detailed payment schedule and terms, including milestones, installments, and due dates.',
    `per_episode_fee_amount` DECIMAL(18,2) COMMENT 'Fee amount charged per episode. Applicable when syndication_fee_structure is per_episode or hybrid.',
    `performance_guarantee` STRING COMMENT 'Minimum performance commitments required from the syndication partner, such as minimum broadcast frequency or audience reach targets.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that the syndication partner must provide notice to exercise renewal option.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the syndication partner has an option to renew the agreement upon expiration.',
    `reporting_frequency` STRING COMMENT 'Frequency at which the syndication partner must provide broadcast logs, audience metrics, and revenue reports.. Valid values are `weekly|monthly|quarterly|annually`',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of advertising or subscription revenue shared with Media Broadcasting. Applicable when syndication_fee_structure is revenue_share or hybrid.',
    `run_limit` STRING COMMENT 'Maximum number of times each episode may be broadcast by the syndication partner during the agreement term.',
    `signed_date` DATE COMMENT 'Date when the syndication agreement was executed by all parties.',
    `syndication_fee_structure` STRING COMMENT 'Compensation model governing how the syndication partner pays for content rights.. Valid values are `flat_fee|per_episode|revenue_share|barter|hybrid`',
    `termination_clause` STRING COMMENT 'Conditions and procedures under which either party may terminate the agreement prior to the effective end date.',
    `territory_grant` STRING COMMENT 'Geographic territories where the syndication partner is granted broadcast rights. Pipe-separated list of ISO 3166-1 alpha-3 country codes or regional designations. [ENUM-REF-CANDIDATE: USA|CAN|GBR|AUS|DEU|FRA|JPN|BRA|MEX|IND|CHN — promote to reference product]',
    CONSTRAINT pk_syndication_agreement PRIMARY KEY(`syndication_agreement_id`)
) COMMENT 'Agreements governing the syndication of Media Broadcasting content to third-party broadcasters, regional stations, and international networks. Captures syndication fee structure, exclusivity windows, holdback periods, territory grants, episode count, run limitations, and clearance obligations. Feeds the scheduling and rights domains for cleared content availability.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` (
    `coproduction_agreement_id` BIGINT COMMENT 'Unique identifier for the co-production agreement record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.partner_agreement. Business justification: Co-production arrangements with studios and international broadcasters are often executed under a master partner agreement that establishes the broader commercial relationship. This FK links coproduct',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Co-production agreements allocate responsibility for obtaining content ratings in different territories (MPAA for US theatrical, TV Parental Guidelines for US broadcast, BBFC for UK, etc.). Partners m',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Co-production investments are capitalized and tracked at legal entity level for consolidation, IP ownership accounting, and residuals liability. Essential for balance sheet classification and intercom',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Co-production investments are budgeted and tracked at cost center level for production accounting, budget variance analysis, and departmental spend control. Essential for production finance and cost a',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Co-production agreements result in specific rights grants defining each partys exploitation rights for the co-produced content. Direct link enables IP ownership tracking, rights allocation management',
    `partner_id` BIGINT COMMENT 'Reference to the primary partner organization responsible for managing the co-production.',
    `talent_profile_id` BIGINT COMMENT 'Foreign key linking to talent.talent_profile. Business justification: Co-production agreements frequently specify lead talent (star, showrunner, director) as part of the deal structure—attached talent drives financing approval and production greenlight decisions. Critic',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Co-production agreements result in license agreements that formalize distribution rights for the co-produced content. Direct link enables rights management teams to navigate from the co-production dea',
    `project_id` BIGINT COMMENT 'Foreign key linking to production.project. Business justification: Co-production agreements directly reference the production project being co-financed and co-produced. Linking enables tracking budget contributions, IP ownership splits, delivery obligations, and fina',
    `title_id` BIGINT COMMENT 'Foreign key linking to content.title. Business justification: Coproduction agreements are title-specific investments requiring direct linkage for production finance tracking, IP ownership percentage calculation, delivery milestone management, and revenue waterfa',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Coproduction ventures are typically structured as separate profit centers for investment tracking, revenue sharing calculation, and ROI analysis. Essential for joint venture financial reporting and pa',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: Co-production deals involve sales negotiation and account management for partner relationship tracking. Enables sales credit for deal origination and account-level co-production portfolio analysis.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Coproduction partnerships target specific audience demographics to justify investment allocation and distribution strategy. Partners negotiate budget share and territory rights based on expected audie',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the co-production agreement. [ENUM-REF-CANDIDATE: draft|negotiation|active|suspended|completed|terminated|expired — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the co-production agreement based on the number and nature of participating parties.. Valid values are `bilateral|multilateral|international|domestic|studio_partnership|network_partnership`',
    `amendment_count` STRING COMMENT 'Number of formal amendments made to the original co-production agreement.',
    `approval_authority` STRING COMMENT 'Designation of which partner or committee has final approval authority over key creative and business decisions.',
    `audit_rights` STRING COMMENT 'Provisions allowing partners to audit financial records and production accounts related to the co-production.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO currency code for the total budget amount.. Valid values are `^[A-Z]{3}$`',
    `confidentiality_terms` STRING COMMENT 'Non-disclosure obligations and confidentiality requirements binding all co-production partners.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this co-production agreement record was first created in the system.',
    `creative_control_level` STRING COMMENT 'Degree of creative decision-making authority held by our organization in the production process.. Valid values are `full|majority|shared|minority|consultative`',
    `credit_obligation` STRING COMMENT 'Contractual requirements for on-screen and promotional credits for each co-production partner.',
    `delivery_date` DATE COMMENT 'Contractual date by which the completed content must be delivered to all co-production partners.',
    `dispute_resolution_method` STRING COMMENT 'Agreed-upon mechanism for resolving disputes between co-production partners.. Valid values are `arbitration|mediation|litigation|negotiation`',
    `distribution_rights_allocation` STRING COMMENT 'Description of how distribution rights are divided among co-production partners by territory and platform.',
    `effective_date` DATE COMMENT 'Date when the co-production agreement becomes legally binding and operational.',
    `expiration_date` DATE COMMENT 'Date when the co-production agreement terminates or expires. Nullable for open-ended agreements.',
    `force_majeure_provision` STRING COMMENT 'Contractual terms addressing obligations and liabilities in the event of unforeseeable circumstances preventing performance.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction whose laws govern the interpretation and enforcement of the co-production agreement.',
    `insurance_requirements` STRING COMMENT 'Mandatory insurance coverage types and amounts required for the co-production.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the co-production agreement.',
    `notes` STRING COMMENT 'Additional comments, special provisions, or contextual information about the co-production agreement.',
    `our_investment_amount` DECIMAL(18,2) COMMENT 'Financial contribution amount committed by our organization to the co-production.',
    `our_investment_percentage` DECIMAL(18,2) COMMENT 'Percentage of total production budget contributed by our organization.',
    `our_ip_ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of intellectual property rights owned by our organization in the co-produced content.',
    `our_primary_territory` STRING COMMENT 'Geographic territory or territories where our organization holds primary distribution rights.',
    `production_end_date` DATE COMMENT 'Scheduled or actual date when principal photography or production activities are completed.',
    `production_start_date` DATE COMMENT 'Scheduled or actual date when principal photography or production activities commence.',
    `production_type` STRING COMMENT 'Category of content being co-produced (film, television series, documentary, etc.).. Valid values are `film|series|documentary|special|miniseries|pilot`',
    `residuals_sharing_formula` STRING COMMENT 'Formula or methodology for distributing residual payments to talent among co-production partners.',
    `revenue_sharing_model` STRING COMMENT 'Methodology for distributing revenues generated from the co-produced content among partners.. Valid values are `proportional|waterfall|hybrid|fixed_split|recoupment_based`',
    `signed_date` DATE COMMENT 'Date when all parties executed the co-production agreement.',
    `termination_clause` STRING COMMENT 'Conditions and procedures under which the co-production agreement may be terminated by any party.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total production budget for the co-produced content across all partners.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this co-production agreement record was last modified in the system.',
    CONSTRAINT pk_coproduction_agreement PRIMARY KEY(`coproduction_agreement_id`)
) COMMENT 'Co-production arrangements with studios, production houses, and international broadcasters for jointly financed and produced content. Tracks co-production budget splits, creative control provisions, IP ownership percentages, territorial distribution rights allocation, credit obligations, and residuals sharing. Bridges the partner, production, and rights domains.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` (
    `affiliate_agreement_id` BIGINT COMMENT 'Unique identifier for the affiliate agreement record. Primary key.',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: affiliate_agreement.affiliate_station_id represents the affiliate station partner. Renaming to affiliate_station_partner_id for clarity (ends with partner_partner_partner_id pattern). Links to partner',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partner.partner_agreement. Business justification: Affiliate relationship agreements with local broadcast stations are often executed under a master partner agreement. This FK links affiliate_agreement to its governing master partner_agreement, enabli',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Network-affiliate agreements are fundamentally tied to the affiliate stations FCC broadcast license. The agreement references the stations call sign, facility ID, licensed market (DMA), and coverage',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Affiliate relations operations costs (network compensation, technical support, compliance monitoring) are tracked by cost center for affiliate operations expense management and network distribution co',
    `market_coverage_id` BIGINT COMMENT 'Foreign key linking to audience.market_coverage. Business justification: Affiliate agreements are market-specific; each affiliate station serves a specific DMA. Essential for network-affiliate relationship management and ensuring proper market coverage. Removes denormalize',
    `panel_id` BIGINT COMMENT 'Foreign key linking to audience.panel. Business justification: Affiliate agreements contractually specify which Nielsen panel (or other measurement panel) is the official source for performance verification and compensation calculations. Agreements reference spec',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Affiliate agreements generate intercompany transactions requiring legal entity tracking for network compensation accounting, retransmission revenue split allocation, and consolidation elimination. Cri',
    `channel_id` BIGINT COMMENT 'Reference to the local broadcast station or regional affiliate partner that is party to this agreement.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Affiliate network revenue (retransmission consent, reverse compensation) and costs must be attributed to profit centers for network distribution segment profitability analysis and affiliate portfolio ',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: Affiliate agreements are sales-managed relationships requiring account tracking for territory assignment, renewal forecasting, and affiliate sales performance reporting. Standard practice in network a',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Network-affiliate agreements specify target demographic performance guarantees (e.g., minimum A25-54 clearance) that drive compensation adjustments and preemption rights. Affiliates commit to deliver ',
    `tertiary_affiliate_network_channel_id` BIGINT COMMENT 'Reference to the parent network or broadcast network entity that is the counterparty to this affiliate agreement.',
    `affiliation_fee_amount` DECIMAL(18,2) COMMENT 'Monthly or annual fee paid by the network to the affiliate station for carrying network programming, or reverse compensation paid by affiliate to network. Negative values indicate reverse compensation.',
    `affiliation_fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the affiliation fee amount (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `affiliation_fee_frequency` STRING COMMENT 'Frequency at which affiliation fees are calculated and paid between network and affiliate.. Valid values are `monthly|quarterly|annual|per_broadcast_hour`',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the affiliate agreement indicating its operational state and enforceability. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|terminated|expired|renewed — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the affiliate relationship: primary affiliation (main channel), secondary affiliation, multicast channel, digital subchannel, network-owned station, or independent affiliate.. Valid values are `primary|secondary|multi_cast|digital_subchannel|network_owned|independent`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at expiration unless either party provides notice of non-renewal.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this affiliate agreement record was first created in the system.',
    `digital_rights_included_flag` BOOLEAN COMMENT 'Indicates whether the affiliate agreement includes rights to distribute network content via digital platforms, streaming services, and Over-The-Top (OTT) channels.',
    `dispute_resolution_method` STRING COMMENT 'Contractually agreed method for resolving disputes between network and affiliate: litigation, binding arbitration, mediation, or good-faith negotiation.. Valid values are `litigation|arbitration|mediation|negotiation`',
    `effective_date` DATE COMMENT 'Date on which the affiliate agreement becomes legally binding and operational obligations commence.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the affiliate has exclusive rights to broadcast network programming within its designated territory, preventing the network from contracting with competing stations in the same market.',
    `exclusivity_territory` STRING COMMENT 'Geographic territory within which the affiliate has exclusive rights to broadcast network programming, typically defined by DMA boundaries, county lists, or signal contours.',
    `expiration_date` DATE COMMENT 'Date on which the affiliate agreement terminates unless renewed or extended. Nullable for evergreen agreements.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law that applies to the interpretation and enforcement of the affiliate agreement (e.g., State of New York, State of California).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this affiliate agreement record was most recently updated or amended.',
    `local_ad_avails_minutes_per_hour` DECIMAL(18,2) COMMENT 'Number of minutes per hour of network programming that the affiliate may use for local advertising insertion, typically 2-4 minutes per hour.',
    `local_insertion_rights_flag` BOOLEAN COMMENT 'Indicates whether the affiliate has the right to insert local advertising spots during designated network programming breaks (ad pods).',
    `minimum_clearance_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage of network programming hours that the affiliate is contractually obligated to broadcast, typically 85-95% for primary affiliates. Expressed as percentage (e.g., 90.00 for 90%).',
    `must_air_programming_hours` DECIMAL(18,2) COMMENT 'Minimum number of weekly hours of network programming that the affiliate must broadcast without preemption, including prime-time, news, and sports.',
    `network_compensation_model` STRING COMMENT 'Economic model governing compensation flow between network and affiliate: fixed fee paid to affiliate, revenue share from advertising, audience-based payments, hybrid model, or reverse compensation where affiliate pays network.. Valid values are `fixed_fee|revenue_share|audience_based|hybrid|reverse_compensation`',
    `performance_measurement_methodology` STRING COMMENT 'Audience measurement methodology used to assess affiliate performance against contractual standards (Nielsen ratings, Comscore, proprietary measurement, or multi-source approach).. Valid values are `nielsen_ratings|comscore|proprietary|multi_source`',
    `performance_standard_grp_minimum` DECIMAL(18,2) COMMENT 'Minimum Gross Rating Points (GRP) that the affiliate must deliver for network programming to meet performance standards and avoid penalties or compensation adjustments.',
    `preemption_notice_hours` STRING COMMENT 'Minimum number of hours advance notice the affiliate must provide to the network before preempting scheduled programming, typically 24-72 hours except for breaking news.',
    `preemption_rights` STRING COMMENT 'Extent to which the affiliate may preempt scheduled network programming for local content, special events, or breaking news. Preemption typically requires advance notice and makegoods.. Valid values are `none|limited|full|news_only|sports_excluded`',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that either party must provide written notice of intent to terminate or renegotiate, typically 90 to 180 days.',
    `retransmission_consent_included_flag` BOOLEAN COMMENT 'Indicates whether the affiliate agreement includes provisions for retransmission consent negotiations with Multichannel Video Programming Distributors (MVPDs) and virtual MVPDs (vMVPDs).',
    `retransmission_revenue_split_percentage` DECIMAL(18,2) COMMENT 'Percentage of retransmission consent fees collected from MVPDs that the affiliate must share with the network. Expressed as percentage (e.g., 30.00 for 30% to network).',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of advertising revenue or other monetization that is shared between network and affiliate under revenue-sharing compensation models. Expressed as percentage (e.g., 15.00 for 15%).',
    `signed_date` DATE COMMENT 'Date on which the affiliate agreement was executed by authorized signatories from both network and affiliate parties.',
    `simulcast_requirement_flag` BOOLEAN COMMENT 'Indicates whether the affiliate is required to simulcast network programming simultaneously across multiple platforms (linear broadcast, digital streaming, mobile apps).',
    `term_length_months` STRING COMMENT 'Duration of the affiliate agreement term expressed in months, typically ranging from 12 to 60 months for broadcast affiliations.',
    `termination_for_cause_provisions` STRING COMMENT 'Description of conditions under which either party may terminate the agreement for cause, including breach of clearance obligations, payment defaults, license revocation, or material violations of broadcast standards.',
    `termination_notice_days` STRING COMMENT 'Number of days advance written notice required for voluntary termination without cause, typically 90-180 days.',
    CONSTRAINT pk_affiliate_agreement PRIMARY KEY(`affiliate_agreement_id`)
) COMMENT 'Affiliate relationship agreements with local broadcast stations, regional affiliates, and network affiliate groups. Tracks affiliation fees, network compensation, programming obligations, local insertion rights, must-air requirements, and affiliate performance standards. Distinct from MVPD distribution agreements — affiliates are broadcast station partners, not pay-TV distributors.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` (
    `delivery_obligation_id` BIGINT COMMENT 'Primary key for delivery_obligation',
    `acquisition_deal_id` BIGINT COMMENT 'Foreign key linking to partner.acquisition_deal. Business justification: Delivery obligations track specific content delivery commitments owed to or from partners under acquisition deals. The delivery_obligation already links to distribution_agreement but acquisition deals',
    `closed_caption_record_id` BIGINT COMMENT 'Foreign key linking to compliance.closed_caption_record. Business justification: Content delivery obligations include captioning deliverables (caption files, format specs, accuracy requirements). Acceptance testing verifies caption files meet FCC technical and quality standards be',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Content delivery specifications include rating certification requirements. Delivered assets must include on-screen rating cards, content descriptor overlays, and rating certification documentation. Ac',
    `title_id` BIGINT COMMENT 'Reference to the content title that must be delivered under this obligation.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Delivery obligations specify exact technical versions (resolution, codec, bitrate, DRM). QC acceptance workflows, redelivery tracking, and technical compliance verification require version-level preci',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Content delivery fulfillment costs (encoding, QC, transmission, storage) are allocated to cost centers for content operations expense tracking and delivery SLA cost management required for operational',
    `asset_version_id` BIGINT COMMENT 'Foreign key linking to mediaasset.asset_version. Business justification: Delivery obligations specify exact version/format requirements (HD vs 4K, dubbed vs subtitled). Tracks which specific version satisfies contractual delivery for acceptance sign-off, QC validation, and',
    `distribution_agreement_id` BIGINT COMMENT 'Reference to the parent partner agreement under which this delivery obligation exists.',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Delivery obligations must be fulfilled only for content covered by a valid rights grant. Rights verification at delivery is a standard media operations process — delivery teams confirm the specific gr',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Delivery obligations are contractual commitments tied to specific license agreements. Direct FK enables delivery tracking against license terms, SLA compliance monitoring, and penalty calculation base',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Core business process: partners have contractual obligations to deliver specific assets. Direct asset link enables MAM integration for delivery tracking, acceptance workflows, automated compliance rep',
    `partner_id` BIGINT COMMENT 'Reference to the partner to whom content must be delivered or from whom content is expected.',
    `program_schedule_id` BIGINT COMMENT 'Foreign key linking to scheduling.program_schedule. Business justification: Content delivery obligations tie to specific broadcast schedules for fulfillment tracking (e.g., deliver episode 3 days before scheduled air date). Critical for partner SLA compliance, on-time deliver',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Delivery obligations also arise from syndication agreements — content must be delivered to syndication partners per the terms of the syndication agreement. This FK links delivery obligations to their ',
    `acceptance_date` DATE COMMENT 'Date on which the partner formally accepted the delivered content as meeting technical and contractual specifications.',
    `actual_delivery_date` DATE COMMENT 'Date on which the content was actually delivered to the partner, null if not yet delivered.',
    `audio_description_required` BOOLEAN COMMENT 'Indicates whether audio description track must be included for visually impaired audiences.',
    `audio_track_languages` STRING COMMENT 'Comma-separated list of audio track languages that must be included in the delivery, using ISO 639 codes.',
    `closed_caption_required` BOOLEAN COMMENT 'Indicates whether closed captioning must be included in the delivered content to meet accessibility and regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery obligation record was first created in the system.',
    `delivery_deadline` DATE COMMENT 'Contractually agreed date by which the content must be delivered to the partner.',
    `delivery_location` STRING COMMENT 'Physical or network location where the content must be delivered, such as FTP server address, CDN endpoint, or facility address.',
    `delivery_method` STRING COMMENT 'Technical method or channel through which the content will be delivered to the partner.. Valid values are `physical_media|ftp|aspera|cdn|satellite|fiber`',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery obligation indicating progress toward fulfillment.. Valid values are `pending|in_progress|delivered|accepted|rejected|overdue`',
    `drm_requirement` STRING COMMENT 'Digital rights management protection required for the delivered content to prevent unauthorized access and distribution.. Valid values are `none|widevine|fairplay|playready|multi_drm`',
    `eidr_identifier` STRING COMMENT 'Universal unique identifier from the Entertainment Identifier Registry for the content being delivered.',
    `episode_count` STRING COMMENT 'Number of episodes included in this delivery obligation for series or multi-episode content.',
    `file_size_gb` DECIMAL(18,2) COMMENT 'Total file size in gigabytes of the content package to be delivered.',
    `isan_identifier` STRING COMMENT 'International Standard Audiovisual Number uniquely identifying the audiovisual work being delivered.',
    `language_version` STRING COMMENT 'Primary language version of the content to be delivered, using ISO 639 language codes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery obligation record was most recently updated.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this delivery obligation record.',
    `notes` STRING COMMENT 'Free-form notes capturing additional context, special instructions, or issues related to this delivery obligation.',
    `obligation_number` STRING COMMENT 'Business identifier for the delivery obligation, typically referenced in contracts and communications.',
    `obligation_type` STRING COMMENT 'Classification of the delivery obligation indicating the direction and nature of content flow.. Valid values are `inbound|outbound|co_production|syndication|licensing`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty amount incurred for late delivery or non-compliance with delivery specifications, in the contract currency.',
    `priority_level` STRING COMMENT 'Business priority assigned to this delivery obligation to guide resource allocation and scheduling.. Valid values are `low|medium|high|critical`',
    `qc_completion_date` DATE COMMENT 'Date on which quality control review was completed and content was approved for delivery.',
    `quality_control_status` STRING COMMENT 'Status of quality control review process for the content before delivery to ensure technical compliance.. Valid values are `not_started|in_progress|passed|failed|waived`',
    `redelivery_required` BOOLEAN COMMENT 'Indicates whether the content must be redelivered due to rejection or technical issues with the initial delivery.',
    `rejection_reason` STRING COMMENT 'Detailed explanation provided by the partner for rejecting the delivered content, typically citing technical or contractual non-compliance.',
    `required_bitrate_mbps` DECIMAL(18,2) COMMENT 'Minimum or target bitrate in megabits per second required for the delivered content to meet quality standards.',
    `required_codec` STRING COMMENT 'Video and audio codec specifications required for the delivery, such as H.264, H.265, AAC, or Dolby Digital.',
    `required_format` STRING COMMENT 'Technical delivery format required by the partner, such as HLS (HTTP Live Streaming), MPEG-DASH (Dynamic Adaptive Streaming over HTTP), or mezzanine file format.',
    `required_resolution` STRING COMMENT 'Video resolution specification required for delivery, ranging from standard definition to ultra-high definition.. Valid values are `SD|HD|FHD|UHD|4K|8K`',
    `sla_compliance` BOOLEAN COMMENT 'Indicates whether the delivery was completed within the service level agreement timeframe specified in the partner contract.',
    `subtitle_languages` STRING COMMENT 'Comma-separated list of subtitle language tracks that must be included in the delivery, using ISO 639 codes.',
    `technical_standard` STRING COMMENT 'Broadcasting or streaming technical standard that the delivery must comply with, such as ATSC (Advanced Television Systems Committee) or DVB (Digital Video Broadcasting).',
    CONSTRAINT pk_delivery_obligation PRIMARY KEY(`delivery_obligation_id`)
) COMMENT 'Tracks specific content delivery obligations owed to or from partners under acquisition, syndication, and co-production agreements. Captures required delivery format (HLS, MPEG-DASH, ISAN-tagged mezzanine), delivery deadline, technical specification compliance (ATSC, DVB), delivery status, and acceptance confirmation. Bridges partner agreements with the digital asset and distribution domains.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` (
    `carriage_fee_schedule_id` BIGINT COMMENT 'Unique identifier for the carriage fee schedule. Primary key for this entity.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Carriage fee schedules for broadcast retransmission consent agreements reference specific licensed stations by call sign, facility ID, and market designation. Fee structures are negotiated per-station',
    `carriage_agreement_id` BIGINT COMMENT 'Reference to the parent carriage agreement that governs this fee schedule. Links to the master distribution agreement between Media Broadcasting and the MVPD or vMVPD.',
    `channel_id` BIGINT COMMENT 'Reference to the specific Media Broadcasting channel covered by this fee schedule. A single carriage agreement may have multiple schedules for different channels.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Carriage fee administration costs (billing, reconciliation, dispute resolution) are tracked by cost center for distribution operations expense management and carriage agreement cost-to-serve analysis.',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Carriage fees are sometimes tiered based on the demographic performance of the channel (e.g., higher fees for channels delivering key demos). Essential for carriage fee negotiation and optimization.',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: A carriage fee schedule governs payments from MVPDs under a specific distribution agreement. Linking carriage_fee_schedule to distribution_agreement establishes the contractual context for each fee sc',
    `genre_id` BIGINT COMMENT 'Foreign key linking to content.genre. Business justification: Carriage fees vary by content genre (sports premium vs general entertainment). Rate card negotiation, subscriber value modeling, and per-genre revenue allocation in distribution agreements require gen',
    `partner_id` BIGINT COMMENT 'Reference to the MVPD, vMVPD, or distribution partner who pays carriage fees under this schedule.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Carriage fee revenue must be attributed to profit centers for distribution segment P&L reporting, MVPD relationship profitability analysis, and subscriber-based revenue performance tracking required b',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Carriage fees are recognized through defined revenue streams with specific accounting treatment, commission structures, and subscriber-based revenue recognition. Critical for distribution revenue acco',
    `audit_rights_flag` BOOLEAN COMMENT 'Boolean indicator of whether Media Broadcasting retains the right to audit the distributors subscriber counts and fee calculations to ensure compliance with the schedule terms.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Boolean indicator of whether this fee schedule automatically renews at the end of its term unless either party provides termination notice.',
    `base_fee_per_subscriber` DECIMAL(18,2) COMMENT 'The baseline carriage fee amount charged per subscriber per month. This is the foundational rate before any escalations, discounts, or adjustments are applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fee schedule record was first created in the system. Used for audit trail and data lineage purposes.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which carriage fees are denominated and invoiced.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date on which this fee schedule expires or is superseded. Nullable for open-ended schedules that remain in force until renegotiated or terminated.',
    `effective_start_date` DATE COMMENT 'Date on which this fee schedule becomes effective and carriage fees begin to be calculated according to its terms.',
    `escalation_frequency` STRING COMMENT 'Frequency at which fee escalations are applied. Defines how often the base fee is adjusted according to the escalation type and rate.. Valid values are `none|annual|biannual|quarterly|monthly|custom`',
    `escalation_rate_percentage` DECIMAL(18,2) COMMENT 'Annual percentage rate by which the base fee per subscriber increases, if escalation type is fixed percentage. Expressed as a percentage (e.g., 3.00 for 3% annual increase).',
    `escalation_type` STRING COMMENT 'Method by which carriage fees increase over time. Options include no escalation, fixed annual percentage increase, Consumer Price Index (CPI) indexing, negotiated increases at specified intervals, or tiered increases based on subscriber growth.. Valid values are `none|fixed_percentage|cpi_indexed|negotiated|tiered`',
    `fee_type` STRING COMMENT 'Classification of the fee structure. Indicates whether fees are charged per subscriber, as a flat monthly rate, in tiers based on subscriber count, volume-based with discounts, a hybrid model, or as a percentage of revenue share.. Valid values are `per_subscriber|flat_rate|tiered|volume_based|hybrid|revenue_share`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fee schedule record was last updated. Tracks the most recent change to any field in the record for audit and compliance purposes.',
    `late_payment_penalty_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied as a penalty for late payment of carriage fees beyond the payment terms. Expressed as an annual percentage rate or per-period rate.',
    `maximum_fee_cap` DECIMAL(18,2) COMMENT 'The maximum total carriage fee amount per billing period, regardless of subscriber count. Protects the distributor from excessive fees in high-subscriber scenarios.',
    `mfn_provision_flag` BOOLEAN COMMENT 'Boolean indicator of whether this schedule includes a Most-Favored-Nation clause. If true, the distributor is entitled to the most favorable carriage fee terms that Media Broadcasting offers to any comparable distributor.',
    `mfn_scope` STRING COMMENT 'Defines the scope and conditions under which the MFN provision applies, including comparable distributor criteria, geographic limitations, and exclusions.',
    `minimum_guaranteed_fee` DECIMAL(18,2) COMMENT 'The minimum total carriage fee amount guaranteed per billing period, regardless of subscriber count. Protects Media Broadcasting revenue in low-subscriber scenarios.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, exceptions, or clarifications related to this fee schedule that do not fit structured fields.',
    `payment_frequency` STRING COMMENT 'Frequency at which carriage fees are invoiced and paid by the distributor. Defines the billing cycle for this fee schedule.. Valid values are `monthly|quarterly|annual|custom`',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due. Standard payment terms such as Net 30, Net 60, or custom terms.',
    `schedule_name` STRING COMMENT 'Business-friendly name or identifier for this fee schedule, used for internal reference and reporting purposes.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the fee schedule. Indicates whether the schedule is in draft, actively in force, temporarily suspended, expired, terminated early, or superseded by a newer version.. Valid values are `draft|active|suspended|expired|terminated|superseded`',
    `schedule_version` STRING COMMENT 'Version identifier for this fee schedule, used to track amendments, renegotiations, and historical changes to fee structures over the life of the agreement.',
    `subscriber_count_source` STRING COMMENT 'Source of subscriber count data used to calculate carriage fees. Options include distributor self-reporting, third-party audit, Nielsen measurement, or Media Broadcasting internal estimates.. Valid values are `distributor_reported|third_party_audit|nielsen|internal_estimate`',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate this fee schedule prior to its natural expiration date.',
    `volume_discount_tier_1_rate` DECIMAL(18,2) COMMENT 'Discounted per-subscriber fee rate applicable when subscriber count exceeds the Tier 1 threshold.',
    `volume_discount_tier_1_threshold` BIGINT COMMENT 'Subscriber count threshold at which the first volume discount tier is triggered. Distributors exceeding this subscriber count qualify for a reduced per-subscriber fee.',
    `volume_discount_tier_2_rate` DECIMAL(18,2) COMMENT 'Discounted per-subscriber fee rate applicable when subscriber count exceeds the Tier 2 threshold.',
    `volume_discount_tier_2_threshold` BIGINT COMMENT 'Subscriber count threshold at which the second volume discount tier is triggered, offering further per-subscriber fee reduction.',
    `volume_discount_tier_3_rate` DECIMAL(18,2) COMMENT 'Discounted per-subscriber fee rate applicable when subscriber count exceeds the Tier 3 threshold.',
    `volume_discount_tier_3_threshold` BIGINT COMMENT 'Subscriber count threshold at which the third volume discount tier is triggered, offering the deepest per-subscriber fee reduction.',
    CONSTRAINT pk_carriage_fee_schedule PRIMARY KEY(`carriage_fee_schedule_id`)
) COMMENT 'Fee schedule governing carriage payments from MVPDs and vMVPDs for distribution of Media Broadcasting channels. Defines per-subscriber fee tiers, escalation clauses, most-favored-nation (MFN) provisions, volume discount thresholds, and payment frequency. Reference entity used to calculate carriage fee invoices in the billing domain.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` (
    `minimum_guarantee_id` BIGINT COMMENT 'Unique identifier for the minimum guarantee commitment within a content acquisition deal.',
    `acquisition_deal_id` BIGINT COMMENT 'Reference to the parent content acquisition deal that contains this minimum guarantee commitment.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: MG advances post to specific GL accounts for balance sheet classification, amortization tracking, and recoupment accounting. Critical for content asset accounting and deferred cost management.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Minimum guarantee amortization expense is allocated to cost centers for content acquisition cost tracking and amortization schedule management required for operational expense reporting and budgeting.',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Minimum guarantee commitments can exist under distribution agreements as well as acquisition deals. The minimum_guarantee already links to acquisition_deal_id, but distribution agreements with MVPDs c',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Minimum guarantees are frequently negotiated as part of license agreements — the licensor requires a minimum financial commitment. Direct link enables financial reconciliation of MG obligations agains',
    `partner_id` BIGINT COMMENT 'Reference to the studio, syndicator, or content provider receiving the minimum guarantee payment.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Minimum guarantee recoupment and overage revenue must be attributed to profit centers for content licensing profitability analysis and ROI tracking by content category and distribution channel.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to billing.invoice. Business justification: MG recoupment tracking requires linking actual invoiced revenue (syndication fees, royalty statements) back to the guarantee for overage calculation, royalty true-ups, and partner financial reporting.',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: MG recoupment flows through specific revenue streams for ASC 606 compliance, performance obligation tracking, and royalty accounting. Essential for revenue recognition method determination and deferre',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Minimum guarantee commitments also arise under syndication agreements — syndication partners often commit to minimum guarantee payments for content licensing. This FK links minimum guarantees to their',
    `accounting_treatment_code` STRING COMMENT 'The financial accounting classification for the minimum guarantee: asset (capitalized content cost), expense (immediate P&L impact), deferred expense (amortized over time), prepaid (advance payment), or liability (obligation to provider).. Valid values are `asset|expense|deferred_expense|prepaid|liability`',
    `amortization_method` STRING COMMENT 'The method used to amortize the minimum guarantee cost over its useful life: straight-line (equal periods), usage-based (viewership-driven), revenue-based (proportional to earnings), accelerated (front-loaded), or none (expensed immediately).. Valid values are `straight_line|usage_based|revenue_based|accelerated|none`',
    `contract_reference_number` STRING COMMENT 'The master contract or agreement number that governs this minimum guarantee commitment. Links to the legal contract document for audit and compliance.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this minimum guarantee record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the minimum guarantee amount (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date when the minimum guarantee commitment expires or the recoupment period ends. After this date, overage terms may continue but the MG obligation is closed.',
    `effective_start_date` DATE COMMENT 'The date when the minimum guarantee commitment becomes active and revenue recoupment begins. Typically aligned with content delivery or first broadcast date.',
    `final_payment_date` DATE COMMENT 'The date when the last scheduled minimum guarantee payment was made or is due. Relevant for installment or milestone-based payment structures.',
    `first_payment_date` DATE COMMENT 'The date when the initial minimum guarantee payment was made or is scheduled to be made to the content provider.',
    `fully_recouped_date` DATE COMMENT 'The date when the minimum guarantee was fully recouped and the outstanding balance reached zero. After this date, overage royalty terms apply to additional revenue.',
    `general_ledger_account_code` STRING COMMENT 'The general ledger account code in the ERP system where minimum guarantee transactions are recorded for financial reporting and reconciliation.. Valid values are `^[0-9]{4,10}$`',
    `is_cross_collateralized` BOOLEAN COMMENT 'Indicates whether this minimum guarantee can be recouped from revenue generated by other content titles or deals with the same provider (true) or is isolated to this specific deal (false).',
    `is_recoupable` BOOLEAN COMMENT 'Indicates whether the minimum guarantee can be recouped from revenue (true) or is a non-recoupable floor payment (false). Non-recoupable MGs are paid regardless of performance with no offset.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this minimum guarantee record was last updated. Tracks changes to amounts, status, or recoupment calculations.',
    `last_recoupment_calculation_date` DATE COMMENT 'The date when the most recent recoupment calculation was performed, updating the recouped to date and outstanding balance amounts.',
    `mg_amount` DECIMAL(18,2) COMMENT 'The floor payment amount owed to the content provider regardless of actual viewership or revenue performance. This is the baseline financial commitment.',
    `mg_number` STRING COMMENT 'Business identifier for the minimum guarantee commitment, used in contracts and financial reconciliation.. Valid values are `^MG-[A-Z0-9]{6,12}$`',
    `mg_status` STRING COMMENT 'Current lifecycle state of the minimum guarantee: draft (under negotiation), active (in effect), partially recouped (some revenue applied), fully recouped (MG threshold met), overage (revenue exceeds MG), expired (term ended), or terminated (contract cancelled). [ENUM-REF-CANDIDATE: draft|active|partially_recouped|fully_recouped|overage|expired|terminated — 7 candidates stripped; promote to reference product]',
    `mg_type` STRING COMMENT 'Classification of the minimum guarantee structure: flat (single fixed payment), tiered (stepped payments based on milestones), performance-based (adjusted by viewership), hybrid (combination), recoupable (can be offset by revenue share), or non-recoupable (floor payment regardless of performance).. Valid values are `flat|tiered|performance_based|hybrid|recoupable|non_recoupable`',
    `next_recoupment_calculation_date` DATE COMMENT 'The scheduled date for the next recoupment calculation cycle. Typically aligned with monthly, quarterly, or annual reporting periods.',
    `notes` STRING COMMENT 'Free-text field for additional context, special terms, exceptions, or business notes related to the minimum guarantee commitment. Used for operational communication and audit trail.',
    `outstanding_balance_amount` DECIMAL(18,2) COMMENT 'Remaining minimum guarantee amount not yet recouped. Calculated as MG amount minus recouped to date amount. When zero, the MG is fully recouped.',
    `overage_amount` DECIMAL(18,2) COMMENT 'Revenue earned beyond the minimum guarantee threshold. Once the MG is fully recouped, additional revenue share payments are calculated on this overage amount per the contract terms.',
    `overage_royalty_rate` DECIMAL(18,2) COMMENT 'The percentage rate applied to overage revenue to calculate additional royalty payments owed to the content provider after the minimum guarantee is fully recouped. Typically ranges from 0.00 to 100.00 percent.',
    `payment_schedule_type` STRING COMMENT 'The timing structure for minimum guarantee payments: upfront (single payment at signing), milestone (tied to delivery/broadcast events), installment (fixed periodic payments), quarterly, annual, upon delivery (when content is delivered), or upon broadcast (when content airs). [ENUM-REF-CANDIDATE: upfront|milestone|installment|quarterly|annual|upon_delivery|upon_broadcast — 7 candidates stripped; promote to reference product]',
    `payment_terms_description` STRING COMMENT 'Detailed narrative of the payment schedule, milestones, and conditions governing the minimum guarantee disbursement. Includes specific dates, amounts, and triggering events.',
    `recouped_to_date_amount` DECIMAL(18,2) COMMENT 'Cumulative revenue amount that has been applied against the minimum guarantee as of the current reporting period. Tracks progress toward full recoupment.',
    `recoupment_basis` STRING COMMENT 'The revenue or performance metric against which the minimum guarantee is recouped: gross revenue (total), net revenue (after costs), advertising revenue (CPM/GRP-based), subscription revenue (SVOD/ARPU), combined revenue (multi-stream), or viewership metric (Nielsen ratings, reach).. Valid values are `gross_revenue|net_revenue|advertising_revenue|subscription_revenue|combined_revenue|viewership_metric`',
    `recoupment_percentage` DECIMAL(18,2) COMMENT 'The percentage of revenue (based on recoupment basis) that is applied toward recouping the minimum guarantee. Typically ranges from 0.00 to 100.00 percent.',
    `recoupment_period_months` STRING COMMENT 'The duration in months over which the minimum guarantee can be recouped from revenue. Common periods are 12, 24, 36, or 60 months depending on content type and windowing strategy.',
    `recoupment_waterfall_description` STRING COMMENT 'Detailed explanation of the revenue allocation sequence and priority order for recouping the minimum guarantee. Defines which revenue streams are applied first and how costs are deducted before recoupment.',
    CONSTRAINT pk_minimum_guarantee PRIMARY KEY(`minimum_guarantee_id`)
) COMMENT 'Minimum guarantee (MG) commitments within content acquisition deals — the floor payment owed to a content provider regardless of actual viewership or revenue performance. Tracks MG amount, recoupment schedule, earned-against-MG balance, recoupment waterfall, and overage terms. Critical for financial reconciliation and royalty management in the finance and rights domains.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`payment_term` (
    `payment_term_id` BIGINT COMMENT 'Unique identifier for the partner payment term record. Primary key.',
    `acquisition_deal_id` BIGINT COMMENT 'Foreign key linking to partner.acquisition_deal. Business justification: Payment terms and schedules are agreed with partners for acquisition fees. Linking payment_term to acquisition_deal establishes which specific acquisition deal the payment term governs. This is essent',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Payment terms specify GL accounts for AP posting, cash flow forecasting, and financial statement classification. Essential for accounts payable automation, payment processing, and balance sheet accura',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payment processing and administration costs are allocated to cost centers for accounts payable operations expense tracking and payment processing efficiency analysis required for finance operations ma',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Payment terms also govern carriage fee payments under distribution agreements. Linking payment_term to distribution_agreement establishes the contractual context for MVPD and OTT carriage fee payment ',
    `partner_id` BIGINT COMMENT 'Reference to the partner (studio, syndicator, content provider, MVPD, or third-party distributor) to whom this payment term applies.',
    `royalty_rule_id` BIGINT COMMENT 'Foreign key linking to rights.royalty_rule. Business justification: Royalty-based payment terms must reference the governing royalty rule for accurate payment calculation and scheduling. Finance and rights operations teams use this link to ensure payment terms align w',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment term record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment amount (e.g., USD, GBP, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'The date on which this payment term expires or is superseded by a new term. Null if the term remains active indefinitely or until contract termination.',
    `effective_start_date` DATE COMMENT 'The date from which this payment term becomes active and enforceable under the contract.',
    `invoice_required_flag` BOOLEAN COMMENT 'Indicates whether the partner must submit an invoice before payment can be processed. True if invoice is required, False if payment is automatic or self-billed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment term record was most recently updated.',
    `late_payment_grace_period_days` STRING COMMENT 'Number of days after the payment due date during which no late payment penalty is assessed, allowing the payer time to remit without financial consequence.',
    `late_payment_penalty_rate` DECIMAL(18,2) COMMENT 'Percentage penalty or interest rate applied to overdue payments, typically expressed as an annual percentage rate (APR) or per-period rate as defined in the contract.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The gross monetary value of the payment obligation before any adjustments, taxes, or withholdings. Expressed in the currency specified in the currency_code field.',
    `payment_approval_required_flag` BOOLEAN COMMENT 'Indicates whether internal approval is required before payment can be released. True if approval workflow must be completed, False if payment is automatic upon due date.',
    `payment_bank_account_number` BIGINT COMMENT 'Reference to the partners bank account record where payment should be remitted. Used for wire transfer and ACH payments.',
    `payment_due_date` DATE COMMENT 'The date by which the payment must be made to the partner to avoid late payment penalties or interest charges.',
    `payment_frequency` STRING COMMENT 'Recurrence pattern for the payment: one-time (single payment), monthly, quarterly, semi-annual, annual, or upon milestone (event-driven).. Valid values are `one_time|monthly|quarterly|semi_annual|annual|upon_milestone`',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to settle the payment: wire transfer, ACH (Automated Clearing House), check, letter of credit, escrow, or barter (non-cash exchange).. Valid values are `wire_transfer|ach|check|letter_of_credit|escrow|barter`',
    `payment_milestone` STRING COMMENT 'Business event or condition that triggers this payment obligation (e.g., Upon Delivery, First Broadcast, Quarterly Arrears, Upon Execution, Net 30 Days from Invoice).',
    `payment_notes` STRING COMMENT 'Internal notes or comments regarding this payment term, including any special handling instructions, dispute history, or reconciliation issues.',
    `payment_remittance_email` STRING COMMENT 'Email address to which payment remittance advice and confirmation should be sent. May differ from the partners primary contact email.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment term: pending (not yet active), scheduled (future payment), due (payment date reached), paid (completed), overdue (past due date), disputed (under review), or waived (obligation removed). [ENUM-REF-CANDIDATE: pending|scheduled|due|paid|overdue|disputed|waived — 7 candidates stripped; promote to reference product]',
    `payment_terms_description` STRING COMMENT 'Free-text narrative describing the payment terms, including any special conditions, contingencies, or negotiated clauses not captured in structured fields.',
    `term_number` STRING COMMENT 'Business identifier for this payment term, often used in invoicing and reconciliation. May follow partner-specific or internal numbering conventions.',
    `term_type` STRING COMMENT 'Classification of the payment term based on the nature of the financial obligation: acquisition fee (content licensing), carriage fee (distribution payment), syndication fee (content resale), co-production contribution (shared production cost), royalty (usage-based payment), or residual (talent reuse payment).. Valid values are `acquisition_fee|carriage_fee|syndication_fee|co_production_contribution|royalty|residual`',
    `withholding_tax_jurisdiction` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the jurisdiction whose tax laws govern the withholding obligation (e.g., USA, GBR, CAN).. Valid values are `^[A-Z]{3}$`',
    `withholding_tax_rate` DECIMAL(18,2) COMMENT 'Percentage of the payment amount that must be withheld for tax purposes based on the partners jurisdiction and applicable tax treaties. Expressed as a percentage (e.g., 15.00 for 15%).',
    CONSTRAINT pk_payment_term PRIMARY KEY(`payment_term_id`)
) COMMENT 'Payment terms and schedules agreed with partners for acquisition fees, carriage fees, syndication fees, and co-production cost contributions. Captures payment milestones, due dates, currency, payment method, late payment penalty clauses, and withholding tax obligations by jurisdiction. Used by the billing domain to generate partner-facing invoices and payment schedules.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` (
    `territory_grant_id` BIGINT COMMENT 'Unique identifier for the territory grant record. Primary key.',
    `acquisition_deal_id` BIGINT COMMENT 'Foreign key linking to partner.acquisition_deal. Business justification: Territory grants define the geographic scope of rights within partner agreements. When territory grants arise from acquisition deals, this FK links the specific territorial rights grant to the acquisi',
    `agreement_id` BIGINT COMMENT 'Reference to the parent partner agreement under which this territorial grant is defined.',
    `broadcast_license_id` BIGINT COMMENT 'Foreign key linking to compliance.broadcast_license. Business justification: Territory grants in distribution agreements must align with licensed broadcast coverage areas. Grants reference DMA codes, coverage contours, and geographic service areas defined by FCC broadcast lice',
    `title_id` BIGINT COMMENT 'Reference to the content title for which territorial rights are granted.',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Territory grants also define geographic scope within distribution agreements — specifying which territories an MVPD or OTT aggregator is authorized to distribute content. This FK links territory grant',
    `grant_id` BIGINT COMMENT 'Foreign key linking to rights.grant. Business justification: Partner territory grants must be validated against rights grants to ensure the partners territorial exploitation rights are properly authorized. Rights clearance for territory grants is a mandatory c',
    `license_agreement_id` BIGINT COMMENT 'Foreign key linking to rights.license_agreement. Business justification: Territory grants in partner domain represent distribution rights that must align with underlying license_agreement terms for territory scope, exclusivity, and windowing. Direct FK enables rights clear',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Territory rights are granted at asset level for international distribution. Playout systems check asset-territory combinations before transmission to prevent rights violations, enable geo-blocking, an',
    `partner_id` BIGINT COMMENT 'Foreign key linking to partner.partner_partner. Business justification: Territory grants license content rights to specific partners (broadcasters, streaming platforms, theatrical distributors) for defined geographic regions. Links rights grants to partner master for righ',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Territorial licensing rights generate distinct revenue streams (linear, VOD, SVOD by territory) requiring separate revenue recognition treatment for ASC 606 compliance and geographic revenue reporting',
    `rights_territory_id` BIGINT COMMENT 'Foreign key linking to rights.rights_territory. Business justification: Territory grants define geographic scope for partner rights. Normalizing to rights_territory_id ensures territory grants reference the canonical rights territory table, enabling consistent rights avai',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Territory grants define geographic scope within syndication agreements — specifying which territories a syndication partner is authorized to broadcast content. This FK links territory grants to their ',
    `avod_rights_flag` BOOLEAN COMMENT 'Indicates whether Advertising-Supported Video On Demand distribution rights are included in this grant.',
    `blackout_zone_indicator` BOOLEAN COMMENT 'Flag indicating whether this grant defines a blackout zone where distribution is explicitly prohibited rather than authorized.',
    `carriage_fee_applicable_flag` BOOLEAN COMMENT 'Indicates whether a carriage fee (distribution payment) is required for this territorial grant.',
    `clearance_status` STRING COMMENT 'Current rights clearance status for this territorial grant. Pending indicates awaiting verification; cleared indicates rights verified and distribution authorized; restricted indicates conditional clearance with limitations; expired indicates grant period has ended; revoked indicates rights withdrawn.. Valid values are `pending|cleared|restricted|expired|revoked`',
    `clearance_verification_date` DATE COMMENT 'Date when rights clearance was last verified for this territorial grant.',
    `created_by_user` STRING COMMENT 'Username or identifier of the user who created this territory grant record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory grant record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial terms associated with this grant (e.g., USD, GBP, EUR).. Valid values are `^[A-Z]{3}$`',
    `dma_code` STRING COMMENT 'Nielsen Designated Market Area code for US local market grants. Used for local broadcast and cable distribution rights.. Valid values are `^[0-9]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the territorial grant expires and distribution rights terminate. Null for perpetual grants.',
    `effective_start_date` DATE COMMENT 'Date when the territorial grant becomes effective and distribution is authorized to begin.',
    `grant_reference_code` STRING COMMENT 'Business identifier for the territory grant, used in contracts and rights clearance documentation.. Valid values are `^TG-[A-Z0-9]{6,12}$`',
    `grant_type` STRING COMMENT 'Type of territorial grant indicating exclusivity level. Exclusive grants prohibit other licensees in the territory; non-exclusive allows multiple licensees; co-exclusive allows a limited number of licensees; holdback restricts distribution during a specific window; reserved indicates rights retained by licensor.. Valid values are `exclusive|non-exclusive|co-exclusive|holdback|reserved`',
    `holdback_restriction` STRING COMMENT 'Description of any holdback period or exclusivity restrictions that limit distribution during specific windows or in relation to other platforms. For example, a 90-day theatrical holdback before SVOD release.',
    `language_restriction` STRING COMMENT 'Comma-separated list of ISO 639-2 language codes specifying which language versions are covered by this grant. Null if all language versions are included.',
    `linear_rights_flag` BOOLEAN COMMENT 'Indicates whether traditional scheduled broadcast (linear) distribution rights are included in this grant.',
    `media_format_restriction` STRING COMMENT 'Restrictions on media formats or technical specifications (e.g., HD only, 4K excluded, standard definition only). Null if no format restrictions apply.',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'Minimum guaranteed payment amount for this territorial grant, regardless of actual distribution revenue. Null if no minimum guarantee applies.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this territory grant record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory grant record was last modified.',
    `must_carry_obligation_flag` BOOLEAN COMMENT 'Indicates whether this grant is subject to must-carry regulations requiring mandatory channel inclusion by distributors.',
    `notes` STRING COMMENT 'Free-text notes capturing additional terms, conditions, or clarifications specific to this territorial grant.',
    `platform_scope` STRING COMMENT 'Comma-separated list of distribution platforms covered by this grant. May include: linear (traditional broadcast), SVOD (Subscription Video On Demand), AVOD (Advertising-Supported Video On Demand), TVOD (Transactional Video On Demand), OTT (Over-The-Top), theatrical, home video, FAST (Free Ad-Supported Streaming Television), MVPD (Multichannel Video Programming Distributor), vMVPD (Virtual Multichannel Video Programming Distributor).',
    `region_name` STRING COMMENT 'Named region for multi-country grants (e.g., North America, European Union, Asia-Pacific, Latin America). Used when grant covers multiple countries as a group.',
    `retransmission_consent_required_flag` BOOLEAN COMMENT 'Indicates whether retransmission consent (rebroadcast authorization) is required for this territorial grant under FCC regulations.',
    `royalty_rate_percent` DECIMAL(18,2) COMMENT 'Percentage royalty rate applicable to revenue generated from distribution in this territory. Used for royalty calculations in the finance domain.',
    `sublicense_permitted_flag` BOOLEAN COMMENT 'Indicates whether the licensee is authorized to sublicense the territorial rights to third parties.',
    `svod_rights_flag` BOOLEAN COMMENT 'Indicates whether Subscription Video On Demand distribution rights are included in this grant.',
    `tvod_rights_flag` BOOLEAN COMMENT 'Indicates whether Transactional Video On Demand (pay-per-view, rental, electronic sell-through) distribution rights are included in this grant.',
    `window_type` STRING COMMENT 'Distribution window classification indicating the sequential release strategy phase. Windowing controls when content is available on different platforms to maximize revenue across release stages. [ENUM-REF-CANDIDATE: theatrical|home_video|pay_tv|free_tv|svod|avod|tvod|syndication|perpetual — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_territory_grant PRIMARY KEY(`territory_grant_id`)
) COMMENT 'Specific territorial rights grants within partner agreements — defining the geographic scope (country, region, DMA, blackout zone) for which content rights are licensed or distribution is authorized. Tracks grant type (exclusive, non-exclusive), platform scope (linear, SVOD, AVOD, TVOD), holdback restrictions, and effective window. Feeds the rights domain for clearance and blackout enforcement.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` (
    `partner_content_window_id` BIGINT COMMENT 'Unique identifier for the content window record. Primary key.',
    `acquisition_deal_id` BIGINT COMMENT 'Reference to the acquisition, distribution, or syndication agreement under which this window is granted.',
    `content_rating_id` BIGINT COMMENT 'Foreign key linking to compliance.content_rating. Business justification: Distribution windows (theatrical, premium cable, broadcast, SVOD) have different rating requirements and standards. Theatrical windows use MPAA ratings; broadcast windows use TV Parental Guidelines. W',
    `title_id` BIGINT COMMENT 'Reference to the specific content title (film, series, episode, or program) to which this window applies.',
    `version_id` BIGINT COMMENT 'Foreign key linking to content.version. Business justification: Windowing plans specify which technical version (theatrical cut vs streaming edit, language dub, HDR format) is available in each distribution window. Platform delivery orchestration, DRM policy appli',
    `demographic_segment_id` BIGINT COMMENT 'Foreign key linking to audience.demographic_segment. Business justification: Content windows are often structured around demographic appeal (e.g., theatrical window targets broader demos, SVOD window targets younger demos). Essential for windowing strategy optimization and rev',
    `distribution_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.distribution_agreement. Business justification: Content windows define sequential release windows granted to partners. When content windows are established under distribution agreements (e.g., SVOD window for an OTT aggregator), this FK links the c',
    `media_asset_id` BIGINT COMMENT 'Foreign key linking to mediaasset.media_asset. Business justification: Windows define when/where specific assets can be exploited (SVOD window, linear window, international window). Direct asset link required for automated compliance checks in playout systems, preventing',
    `partner_id` BIGINT COMMENT 'Reference to the internal employee or team responsible for managing and monitoring this content window (e.g., rights manager, distribution coordinator).',
    `revenue_stream_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_stream. Business justification: Content windowing strategy creates distinct revenue streams (theatrical, PVOD, SVOD, AVOD windows) with different recognition patterns and pricing models requiring separate revenue stream categorizati',
    `rights_content_window_id` BIGINT COMMENT 'Foreign key linking to rights.rights_content_window. Business justification: Partner content windows define when a partner can exploit content; rights content windows define the rights-based availability period. Partner windows must be validated against rights windows to ensur',
    `syndication_agreement_id` BIGINT COMMENT 'Foreign key linking to partner.syndication_agreement. Business justification: Content windows can also be established under syndication agreements — defining the linear or syndication window granted to a syndication partner. This FK links the content window to its governing syn',
    `territory_grant_id` BIGINT COMMENT 'Foreign key linking to partner.territory_grant. Business justification: Content windows are geographically scoped by territory grants — a content window is valid only within the territories granted under the associated territory grant. Linking partner_content_window to te',
    `activation_date` DATE COMMENT 'The actual date on which the content was made available on the platform, which may differ from the planned window_start_date due to operational delays or early releases.',
    `content_format` STRING COMMENT 'The technical video format or resolution standard required for delivery in this window (e.g., SD, HD, 4K, 8K, HDR, Dolby Vision).. Valid values are `sd|hd|4k|8k|hdr|dolby_vision`',
    `contract_reference_number` STRING COMMENT 'External reference number or identifier for the legal contract or agreement document that governs this window. Used for audit and compliance traceability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this content window record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this window record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deactivation_date` DATE COMMENT 'The actual date on which the content was removed from the platform, which may differ from the planned window_end_date due to early termination or extensions.',
    `drm_requirement` STRING COMMENT 'The DRM technology required to protect the content during this window (e.g., Widevine, FairPlay, PlayReady, Multi-DRM, or none for unprotected distribution).. Valid values are `none|widevine|fairplay|playready|multi_drm`',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this window grants exclusive distribution rights to the platform (True) or allows concurrent distribution on other platforms (False).',
    `exclusivity_scope` STRING COMMENT 'Defines the boundaries of exclusivity (e.g., platform-exclusive, territory-exclusive, window-type-exclusive, non-exclusive). Provides context when exclusivity_flag is True.',
    `holdback_period_days` STRING COMMENT 'The mandatory waiting period (in days) between the end of the previous window and the start of this window, ensuring sequential exclusivity and protecting prior windows.',
    `language_availability` STRING COMMENT 'Languages in which the content must be made available during this window (e.g., English, Spanish, French). Comma-separated list of ISO 639-1 language codes.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user or system process that last modified this record. Used for audit and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this content window record was most recently updated. Used for audit trail and change tracking.',
    `marketing_rights_included_flag` BOOLEAN COMMENT 'Indicates whether the platform has rights to use promotional materials, trailers, and marketing assets for this window (True) or must obtain separate clearance (False).',
    `minimum_guarantee_amount` DECIMAL(18,2) COMMENT 'The minimum payment guaranteed to the content provider for this window, regardless of actual revenue performance. Expressed in the deal currency.',
    `monetization_model` STRING COMMENT 'The revenue model associated with this window (e.g., subscription-based SVOD, advertising-supported AVOD, transactional TVOD, free, or hybrid).. Valid values are `subscription|advertising|transactional|free|hybrid`',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or operational notes related to this window (e.g., blackout restrictions, co-exclusive arrangements, partner-specific requirements).',
    `performance_guarantee_description` STRING COMMENT 'Free-text description of any performance commitments tied to this window (e.g., minimum viewership targets, promotional spend requirements, platform placement guarantees).',
    `platform_name` STRING COMMENT 'Name of the specific distribution platform, service, or channel authorized for this window (e.g., Netflix, Hulu, HBO Max, ABC Network).',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the platform has an option to renew or extend this window under predefined terms (True) or the window is non-renewable (False).',
    `renewal_terms` STRING COMMENT 'Free-text description of the terms under which this window may be renewed (e.g., pricing adjustments, duration, notice period). Populated when renewal_option_flag is True.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of revenue generated during this window that is shared with the content provider or partner, as defined in the acquisition deal.',
    `sublicensing_allowed_flag` BOOLEAN COMMENT 'Indicates whether the platform is permitted to sublicense the content to third parties during this window (True) or must distribute directly (False).',
    `subtitle_requirement` STRING COMMENT 'Specifies subtitle languages required for this window to meet accessibility and localization obligations. Comma-separated list of ISO 639-1 language codes.',
    `territory_coverage` STRING COMMENT 'Geographic territories or markets where this window is valid (e.g., USA, CAN, GBR, Worldwide, North America). May be comma-separated list of ISO 3166-1 alpha-3 country codes or region names.',
    `window_duration_days` STRING COMMENT 'The total length of the distribution window in days, calculated from start to end date. Used for planning and compliance tracking.',
    `window_end_date` DATE COMMENT 'The date on which this distribution window expires and the content must be removed from the platform or the rights revert. Nullable for perpetual windows.',
    `window_sequence_number` STRING COMMENT 'Ordinal position of this window in the sequential release strategy (e.g., 1 for theatrical, 2 for SVOD, 3 for AVOD). Defines the chronological order of windowing.',
    `window_start_date` DATE COMMENT 'The date on which this distribution window becomes active and the content may be released on the specified platform.',
    `window_status` STRING COMMENT 'Current lifecycle status of the content window (e.g., planned, active, expired, terminated early, suspended, or extended beyond original end date).. Valid values are `planned|active|expired|terminated|suspended|extended`',
    `window_type` STRING COMMENT 'The distribution model or platform type for this release window (e.g., theatrical, SVOD, AVOD, TVOD, linear broadcast, syndication). [ENUM-REF-CANDIDATE: theatrical|svod|avod|tvod|linear|syndication|vod|fast|free_to_air|pay_per_view — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_partner_content_window PRIMARY KEY(`partner_content_window_id`)
) COMMENT 'Defines the sequential release windows (theatrical, SVOD, AVOD, TVOD, linear, syndication) granted to or from partners for specific content titles under acquisition, distribution, or syndication agreements. Tracks window type, platform exclusivity, start and end dates, holdback periods, and window sequencing order. Authoritative source for windowing strategy within the partner domain, complementing the rights domains rights window records.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Primary key for vendor',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor services (production services, facilities, post-production) are allocated to cost centers for production cost tracking and vendor spend analysis by operational unit required for procurement and',
    `parent_vendor_id` BIGINT COMMENT 'Reference to the parent vendor if this vendor is a subsidiary or division of a larger vendor organization, enabling hierarchical vendor relationships.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Vendors (production services, equipment suppliers, facilities) must comply with industry-specific regulatory obligations (safety standards, labor regulations, environmental compliance, union rules). P',
    `address_line_1` STRING COMMENT 'The first line of the vendors primary business address including street number and name.',
    `address_line_2` STRING COMMENT 'The second line of the vendors primary business address for suite, floor, or building information.',
    `city` STRING COMMENT 'The city or municipality where the vendors primary business address is located.',
    `contract_end_date` DATE COMMENT 'The date on which the master vendor agreement or contract expires or is scheduled for renewal.',
    `contract_start_date` DATE COMMENT 'The date on which the master vendor agreement or contract becomes effective.',
    `country_code` STRING COMMENT 'The three-letter ISO country code representing the country where the vendor is headquartered.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor record was first created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'The maximum credit amount extended to the vendor for outstanding payables before payment is required.',
    `currency_code` STRING COMMENT 'The three-letter ISO currency code representing the vendors preferred currency for transactions.',
    `duns_number` STRING COMMENT 'The nine-digit DUNS number assigned by Dun & Bradstreet to uniquely identify the vendor business entity.',
    `insurance_certificate_expiration_date` DATE COMMENT 'The date on which the vendors current insurance certificate expires, requiring renewal for continued partnership.',
    `last_transaction_date` DATE COMMENT 'The date of the most recent business transaction or interaction with the vendor.',
    `minority_owned_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor is certified as a minority-owned business enterprise.',
    `modified_by` STRING COMMENT 'The user identifier or name of the person who last modified this vendor record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor record was last modified or updated.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional notes, comments, or special instructions related to the vendor relationship.',
    `onboarding_date` DATE COMMENT 'The date on which the vendor was officially onboarded and approved for business transactions.',
    `payment_method` STRING COMMENT 'The preferred payment method for remitting payments to the vendor.',
    `payment_terms` STRING COMMENT 'The standard payment terms agreed upon with the vendor specifying when payment is due after invoice receipt.',
    `performance_rating` STRING COMMENT 'The overall performance rating of the vendor based on delivery quality, timeliness, and service level adherence.',
    `postal_code` STRING COMMENT 'The postal or ZIP code for the vendors primary business address.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor has preferred status for priority consideration in content acquisition and partnership opportunities.',
    `primary_contact_email` STRING COMMENT 'The primary email address for operational communication with the vendor.',
    `primary_contact_name` STRING COMMENT 'The full name of the primary contact person at the vendor organization.',
    `primary_contact_phone` STRING COMMENT 'The primary telephone number for reaching the vendor for business communications.',
    `risk_rating` STRING COMMENT 'The assessed risk level associated with doing business with this vendor based on financial stability, compliance history, and operational reliability.',
    `small_business_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor qualifies as a small business under applicable regulatory definitions.',
    `state_province` STRING COMMENT 'The state, province, or region where the vendors primary business address is located.',
    `tax_identification_number` STRING COMMENT 'The tax identification number or employer identification number (EIN) assigned to the vendor by the tax authority.',
    `vendor_code` STRING COMMENT 'The externally-known unique business identifier or code assigned to the vendor for operational reference.',
    `vendor_name` STRING COMMENT 'The full legal name of the vendor organization as registered for business purposes.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor relationship indicating whether the vendor is actively engaged, suspended, or terminated.',
    `vendor_type` STRING COMMENT 'Classification of the vendor based on their role in the media ecosystem (e.g., studio, syndicator, content provider, MVPD, distributor, production company).',
    `website_url` STRING COMMENT 'The primary website URL for the vendor organization.',
    `woman_owned_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor is certified as a woman-owned business enterprise.',
    `created_by` STRING COMMENT 'The user identifier or name of the person who created this vendor record.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master reference table for vendor. Referenced by vendor_id.';

CREATE OR REPLACE TABLE `media_broadcasting_ecm`.`partner`.`agreement` (
    `agreement_id` BIGINT COMMENT 'Primary key for partner_agreement',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Partnership administration costs (contract management, compliance monitoring, relationship management) are tracked by cost center for partner operations expense management and contract administration ',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity within the organization that is party to this agreement.',
    `master_partner_agreement_id` BIGINT COMMENT 'Self-referencing FK on partner_agreement (master_partner_agreement_id)',
    `partner_id` BIGINT COMMENT 'Reference to the partner entity (studio, syndicator, content provider, MVPD, distributor) that is party to this agreement.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Partnership revenue and costs must be attributed to profit centers for partnership portfolio profitability analysis and strategic partner relationship ROI evaluation required for business development ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Master partner agreements must reference the specific regulatory obligations they satisfy (FCC reporting, content standards, accessibility requirements). Essential for contract compliance audits, regu',
    `sales_account_id` BIGINT COMMENT 'Foreign key linking to sales.sales_account. Business justification: Master partner agreements should link to the sales account managing the relationship for account ownership, renewal tracking, and sales performance attribution. Core sales operations requirement for p',
    `agreement_name` STRING COMMENT 'Human-readable name or title of the partner agreement.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the partner agreement, used in contracts and communications.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the partner agreement indicating its operational state.',
    `agreement_type` STRING COMMENT 'Classification of the partner agreement based on its business purpose: content acquisition, syndication, co-production, distribution, affiliate, or licensing.',
    `amendment_count` STRING COMMENT 'Number of amendments or modifications made to the original agreement.',
    `approval_authority` STRING COMMENT 'Name or title of the executive or committee that approved this agreement.',
    `approval_date` DATE COMMENT 'Date when the agreement received final internal approval.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews upon expiration.',
    `confidentiality_period_years` STRING COMMENT 'Duration in years that confidentiality obligations remain in effect after agreement termination.',
    `content_category` STRING COMMENT 'Primary category of content covered by this agreement.',
    `contract_owner` STRING COMMENT 'Name or identifier of the business unit or individual responsible for managing this agreement.',
    `contract_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the partner agreement over its full term.',
    `contract_value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner agreement record was first created in the system.',
    `dispute_resolution_method` STRING COMMENT 'Method specified in the agreement for resolving disputes between parties.',
    `document_reference` STRING COMMENT 'Reference identifier or storage location for the physical or digital contract document.',
    `effective_end_date` DATE COMMENT 'Date when the partner agreement expires or terminates. Nullable for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the partner agreement becomes legally binding and operational.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this agreement grants exclusive rights to the partner.',
    `execution_date` DATE COMMENT 'Date when the agreement was signed or executed by all parties.',
    `governing_law` STRING COMMENT 'Legal jurisdiction and governing law applicable to this agreement (e.g., State of California, UK Law).',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner agreement record was last updated in the system.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount specified in the agreement for breach or damages.',
    `notes` STRING COMMENT 'Additional notes, comments, or special conditions related to the partner agreement.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required for termination or non-renewal of the agreement.',
    `payment_terms` STRING COMMENT 'Description of payment schedule, milestones, and conditions specified in the agreement.',
    `performance_guarantee_amount` DECIMAL(18,2) COMMENT 'Monetary value of performance guarantees or minimum commitments specified in the agreement.',
    `renewal_date` DATE COMMENT 'Date when the agreement is scheduled for renewal review or automatic renewal.',
    `renewal_term_months` STRING COMMENT 'Duration in months for each renewal period if auto-renewal is enabled.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of revenue shared with the partner under this agreement, if applicable.',
    `termination_date` DATE COMMENT 'Actual date when the agreement was terminated, if applicable.',
    `territory_coverage` STRING COMMENT 'Geographic territories or regions covered by this partner agreement (e.g., North America, EMEA, Global).',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Master reference table for partner_agreement. Referenced by partner_agreement_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ADD CONSTRAINT `fk_partner_contact_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ADD CONSTRAINT `fk_partner_acquisition_deal_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ADD CONSTRAINT `fk_partner_acquisition_deal_line_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ADD CONSTRAINT `fk_partner_distribution_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ADD CONSTRAINT `fk_partner_syndication_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ADD CONSTRAINT `fk_partner_coproduction_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ADD CONSTRAINT `fk_partner_affiliate_agreement_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ADD CONSTRAINT `fk_partner_delivery_obligation_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ADD CONSTRAINT `fk_partner_carriage_fee_schedule_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ADD CONSTRAINT `fk_partner_minimum_guarantee_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ADD CONSTRAINT `fk_partner_payment_term_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ADD CONSTRAINT `fk_partner_payment_term_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ADD CONSTRAINT `fk_partner_payment_term_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ADD CONSTRAINT `fk_partner_territory_grant_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_acquisition_deal_id` FOREIGN KEY (`acquisition_deal_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`acquisition_deal`(`acquisition_deal_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_distribution_agreement_id` FOREIGN KEY (`distribution_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`distribution_agreement`(`distribution_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_syndication_agreement_id` FOREIGN KEY (`syndication_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`syndication_agreement`(`syndication_agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ADD CONSTRAINT `fk_partner_partner_content_window_territory_grant_id` FOREIGN KEY (`territory_grant_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`territory_grant`(`territory_grant_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ADD CONSTRAINT `fk_partner_vendor_parent_vendor_id` FOREIGN KEY (`parent_vendor_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`vendor`(`vendor_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_master_partner_agreement_id` FOREIGN KEY (`master_partner_agreement_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`agreement`(`agreement_id`);
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ADD CONSTRAINT `fk_partner_agreement_partner_id` FOREIGN KEY (`partner_id`) REFERENCES `media_broadcasting_ecm`.`partner`.`partner_partner`(`partner_id`);

-- ========= TAGS =========
ALTER SCHEMA `media_broadcasting_ecm`.`partner` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `media_broadcasting_ecm`.`partner` SET TAGS ('dbx_domain' = 'partner');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for partner_partner');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `partner_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Partner Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `annual_content_volume_hours` SET TAGS ('dbx_business_glossary_term' = 'Annual Content Volume in Hours');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `annual_content_volume_hours` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `annual_revenue_contribution_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Contribution in United States Dollars (USD)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `annual_revenue_contribution_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `content_specialization` SET TAGS ('dbx_business_glossary_term' = 'Content Specialization');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `contract_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `corporate_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Corporate Hierarchy Level');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `distribution_territories` SET TAGS ('dbx_business_glossary_term' = 'Distribution Territories');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `domicile_country_code` SET TAGS ('dbx_business_glossary_term' = 'Domicile Country Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `domicile_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Relationship Indicator');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partner Relationship Notes');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_business_glossary_term' = 'Partner Onboarding Stage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_value_regex' = 'prospect|due_diligence|contract_negotiation|legal_review|approved|onboarded');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_business_glossary_term' = 'Partner Business Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `partner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Legal Name');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type Classification');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'studio|syndicator|content_provider|mvpd|vmvpd|ott_aggregator');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `preferred_payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Terms');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Full Name');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Partner Relationship Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Partner Risk Tier');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `risk_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `strategic_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Partner Tier');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `strategic_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|emerging');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Partner Subtype Classification');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_partner` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `assistant_email` SET TAGS ('dbx_business_glossary_term' = 'Assistant Email Address');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `assistant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `assistant_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `assistant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `assistant_name` SET TAGS ('dbx_business_glossary_term' = 'Assistant Name');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_business_glossary_term' = 'Assistant Phone Number');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `assistant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `communication_language` SET TAGS ('dbx_business_glossary_term' = 'Communication Language');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `contract_signatory` SET TAGS ('dbx_business_glossary_term' = 'Contract Signatory Indicator');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `decision_making_authority` SET TAGS ('dbx_business_glossary_term' = 'Decision Making Authority Level');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `decision_making_authority` SET TAGS ('dbx_value_regex' = 'full|limited|advisory|none');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contact End Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Indicator');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Profile Uniform Resource Locator (URL)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Number');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `nda_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Non-Disclosure Agreement (NDA) Signed Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `next_scheduled_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Contact Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `preferred_communication_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Method');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `preferred_communication_method` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|video_conference|in_person');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Role Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Start Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Contact Time Zone');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`contact` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` SET TAGS ('dbx_subdomain' = 'content_agreements');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Content Provider Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `content_delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Content Delivery Format');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `content_package_scope` SET TAGS ('dbx_business_glossary_term' = 'Content Package Scope');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `contract_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `deal_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `deal_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Deal Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Number');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `deal_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4,8}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `deal_status` SET TAGS ('dbx_business_glossary_term' = 'Deal Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `deal_title` SET TAGS ('dbx_business_glossary_term' = 'Deal Title');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_business_glossary_term' = 'Deal Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `deal_type` SET TAGS ('dbx_value_regex' = 'flat_fee|revenue_share|minimum_guarantee|hybrid|barter');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Deal Value Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `deal_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `distribution_rights` SET TAGS ('dbx_business_glossary_term' = 'Distribution Rights');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period in Days');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `license_term_months` SET TAGS ('dbx_business_glossary_term' = 'License Term in Months');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `marketing_materials_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Materials Included Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `metadata_requirements` SET TAGS ('dbx_business_glossary_term' = 'Metadata Requirements');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deal Notes');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `performance_guarantees` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantees');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Allowed Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `sublicensing_terms` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Terms');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `territory_coverage` SET TAGS ('dbx_business_glossary_term' = 'Territory Coverage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `total_runtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Runtime in Hours');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Windowing Strategy');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal` ALTER COLUMN `windowing_strategy` SET TAGS ('dbx_value_regex' = 'day_and_date|theatrical_holdback|svod_first|linear_first|staggered|simultaneous');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` SET TAGS ('dbx_subdomain' = 'content_agreements');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `acquisition_deal_line_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Line Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `content_type` SET TAGS ('dbx_business_glossary_term' = 'Content Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `delivery_due_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Due Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|in_transit|received|ingested|rejected|delayed');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `distribution_rights` SET TAGS ('dbx_business_glossary_term' = 'Distribution Rights');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `dubbing_languages` SET TAGS ('dbx_business_glossary_term' = 'Dubbing Languages');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'Entertainment Identifier Registry (EIDR) Identifier');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_value_regex' = '^10.5240/[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-F0-9]{4}-[A-Z]$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `genre_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Genre');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `holdback_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Holdback Restrictions');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `license_duration_months` SET TAGS ('dbx_business_glossary_term' = 'License Duration in Months');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `license_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'License Fee Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `license_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'License Term End Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `license_term_start_date` SET TAGS ('dbx_business_glossary_term' = 'License Term Start Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|active|fulfilled|cancelled|expired|suspended');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_value_regex' = 'upfront|on_delivery|installment|revenue_share|hybrid');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `production_year` SET TAGS ('dbx_business_glossary_term' = 'Production Year');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percentage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `runs_allowed` SET TAGS ('dbx_business_glossary_term' = 'Runs Allowed');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `runtime_minutes` SET TAGS ('dbx_business_glossary_term' = 'Runtime in Minutes');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`acquisition_deal_line` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` SET TAGS ('dbx_subdomain' = 'content_agreements');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Identifier');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Contracting Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Partner Identifier');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'carriage|retransmission_consent|must_carry|syndication|ott_distribution|affiliate');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `audit_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Included Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `blackout_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Blackout Restrictions');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `carriage_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Structure');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_value_regex' = 'per_subscriber|flat_rate|tiered|revenue_share|hybrid');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `carriage_fee_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `channel_positioning_tier` SET TAGS ('dbx_business_glossary_term' = 'Channel Positioning Tier');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `channel_positioning_tier` SET TAGS ('dbx_value_regex' = 'basic|expanded_basic|digital|premium|sports_tier|custom');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `channels_included` SET TAGS ('dbx_business_glossary_term' = 'Channels Included');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Uniform Resource Locator (URL)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `must_carry_obligation` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Obligation Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `negotiated_by` SET TAGS ('dbx_business_glossary_term' = 'Negotiated By');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annual');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `retransmission_consent_granted` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Granted Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `sla_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Response Time Hours');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `streaming_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Streaming Rights Included Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `svod_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Subscription Video On Demand (SVOD) Rights Included Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `territory` SET TAGS ('dbx_business_glossary_term' = 'Distribution Territory');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `tvod_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Transactional Video On Demand (TVOD) Rights Included Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `vod_rights_included` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Rights Included Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`distribution_agreement` ALTER COLUMN `vod_window_days` SET TAGS ('dbx_business_glossary_term' = 'Video On Demand (VOD) Window Days');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` SET TAGS ('dbx_subdomain' = 'content_agreements');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Contracting Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Source Opportunity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Partner Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Talent Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'domestic_syndication|international_syndication|regional_syndication|barter_syndication|cash_syndication|cash_plus_barter');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `barter_spot_count` SET TAGS ('dbx_business_glossary_term' = 'Barter Spot Count');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_business_glossary_term' = 'Broadcast Standard');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `broadcast_standard` SET TAGS ('dbx_value_regex' = 'ATSC|DVB|ISDB|DTMB');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `clearance_obligation` SET TAGS ('dbx_business_glossary_term' = 'Clearance Obligation');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `clearance_obligation` SET TAGS ('dbx_value_regex' = 'broadcaster|syndicator|shared');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Delivery Format');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `exclusivity_window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Window End Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `exclusivity_window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Window Start Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Fee Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `flat_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period (Days)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `per_episode_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Per Episode Fee Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `per_episode_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `performance_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annually');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `run_limit` SET TAGS ('dbx_business_glossary_term' = 'Run Limit');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `syndication_fee_structure` SET TAGS ('dbx_business_glossary_term' = 'Syndication Fee Structure');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `syndication_fee_structure` SET TAGS ('dbx_value_regex' = 'flat_fee|per_episode|revenue_share|barter|hybrid');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`syndication_agreement` ALTER COLUMN `territory_grant` SET TAGS ('dbx_business_glossary_term' = 'Territory Grant');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` SET TAGS ('dbx_subdomain' = 'content_agreements');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `coproduction_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Production Agreement Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Contracting Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Partner Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `talent_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Talent Profile Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Production Project Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Production Title Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'bilateral|multilateral|international|domestic|studio_partnership|network_partnership');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `audit_rights` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `confidentiality_terms` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Terms');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `confidentiality_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `creative_control_level` SET TAGS ('dbx_business_glossary_term' = 'Creative Control Level');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `creative_control_level` SET TAGS ('dbx_value_regex' = 'full|majority|shared|minority|consultative');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `credit_obligation` SET TAGS ('dbx_business_glossary_term' = 'Credit Obligation');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'arbitration|mediation|litigation|negotiation');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `distribution_rights_allocation` SET TAGS ('dbx_business_glossary_term' = 'Distribution Rights Allocation');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `distribution_rights_allocation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `force_majeure_provision` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Provision');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `our_investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Our Investment Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `our_investment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `our_investment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Our Investment Percentage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `our_investment_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `our_ip_ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Our Intellectual Property (IP) Ownership Percentage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `our_ip_ownership_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `our_primary_territory` SET TAGS ('dbx_business_glossary_term' = 'Our Primary Territory');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `production_end_date` SET TAGS ('dbx_business_glossary_term' = 'Production End Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `production_start_date` SET TAGS ('dbx_business_glossary_term' = 'Production Start Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `production_type` SET TAGS ('dbx_business_glossary_term' = 'Production Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `production_type` SET TAGS ('dbx_value_regex' = 'film|series|documentary|special|miniseries|pilot');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `residuals_sharing_formula` SET TAGS ('dbx_business_glossary_term' = 'Residuals Sharing Formula');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `residuals_sharing_formula` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_business_glossary_term' = 'Revenue Sharing Model');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_value_regex' = 'proportional|waterfall|hybrid|fixed_split|recoupment_based');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `revenue_sharing_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `termination_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`coproduction_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` SET TAGS ('dbx_subdomain' = 'content_agreements');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Station Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `market_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Market Coverage Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `panel_id` SET TAGS ('dbx_business_glossary_term' = 'Measurement Panel Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Network Legal Entity Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Station Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Target Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `tertiary_affiliate_network_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Network Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliation_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Fee Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliation_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliation_fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Fee Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliation_fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliation_fee_frequency` SET TAGS ('dbx_business_glossary_term' = 'Affiliation Fee Payment Frequency');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `affiliation_fee_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|per_broadcast_hour');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Affiliate Agreement Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|multi_cast|digital_subchannel|network_owned|independent');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `digital_rights_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Digital Distribution Rights Included Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Territorial Exclusivity Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `exclusivity_territory` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Territory Description');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `local_ad_avails_minutes_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Local Advertising Availabilities Minutes Per Hour');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `local_insertion_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Local Advertising Insertion Rights Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `minimum_clearance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Network Clearance Percentage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `must_air_programming_hours` SET TAGS ('dbx_business_glossary_term' = 'Must-Air Programming Hours Per Week');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `network_compensation_model` SET TAGS ('dbx_business_glossary_term' = 'Network Compensation Model');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `network_compensation_model` SET TAGS ('dbx_value_regex' = 'fixed_fee|revenue_share|audience_based|hybrid|reverse_compensation');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `network_compensation_model` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `network_compensation_model` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `performance_measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Performance Measurement Methodology');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `performance_measurement_methodology` SET TAGS ('dbx_value_regex' = 'nielsen_ratings|comscore|proprietary|multi_source');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `performance_standard_grp_minimum` SET TAGS ('dbx_business_glossary_term' = 'Performance Standard Gross Rating Points (GRP) Minimum');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `preemption_notice_hours` SET TAGS ('dbx_business_glossary_term' = 'Preemption Notice Period in Hours');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `preemption_rights` SET TAGS ('dbx_business_glossary_term' = 'Network Programming Preemption Rights');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `preemption_rights` SET TAGS ('dbx_value_regex' = 'none|limited|full|news_only|sports_excluded');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period in Days');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `retransmission_consent_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Included Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `retransmission_revenue_split_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Revenue Split Percentage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `retransmission_revenue_split_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `simulcast_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Simulcast Requirement Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `term_length_months` SET TAGS ('dbx_business_glossary_term' = 'Agreement Term Length in Months');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `termination_for_cause_provisions` SET TAGS ('dbx_business_glossary_term' = 'Termination for Cause Provisions');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`affiliate_agreement` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period in Days');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` SET TAGS ('dbx_subdomain' = 'commercial_terms');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Obligation Identifier');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `closed_caption_record_id` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Record Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title ID');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `asset_version_id` SET TAGS ('dbx_business_glossary_term' = 'Delivered Asset Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement ID');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `program_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Program Schedule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `audio_description_required` SET TAGS ('dbx_business_glossary_term' = 'Audio Description Required');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `audio_track_languages` SET TAGS ('dbx_business_glossary_term' = 'Audio Track Languages');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `closed_caption_required` SET TAGS ('dbx_business_glossary_term' = 'Closed Caption Required');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_deadline` SET TAGS ('dbx_business_glossary_term' = 'Delivery Deadline');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'physical_media|ftp|aspera|cdn|satellite|fiber');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|delivered|accepted|rejected|overdue');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_business_glossary_term' = 'DRM (Digital Rights Management) Requirement');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_value_regex' = 'none|widevine|fairplay|playready|multi_drm');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `eidr_identifier` SET TAGS ('dbx_business_glossary_term' = 'EIDR (Entertainment Identifier Registry) Identifier');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `episode_count` SET TAGS ('dbx_business_glossary_term' = 'Episode Count');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `file_size_gb` SET TAGS ('dbx_business_glossary_term' = 'File Size (GB)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `isan_identifier` SET TAGS ('dbx_business_glossary_term' = 'ISAN (International Standard Audiovisual Number) Identifier');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `language_version` SET TAGS ('dbx_business_glossary_term' = 'Language Version');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `obligation_number` SET TAGS ('dbx_business_glossary_term' = 'Obligation Number');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'inbound|outbound|co_production|syndication|licensing');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `qc_completion_date` SET TAGS ('dbx_business_glossary_term' = 'QC (Quality Control) Completion Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `quality_control_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|waived');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `redelivery_required` SET TAGS ('dbx_business_glossary_term' = 'Redelivery Required');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `required_bitrate_mbps` SET TAGS ('dbx_business_glossary_term' = 'Required Bitrate (Mbps)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `required_codec` SET TAGS ('dbx_business_glossary_term' = 'Required Codec');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `required_format` SET TAGS ('dbx_business_glossary_term' = 'Required Format');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `required_resolution` SET TAGS ('dbx_business_glossary_term' = 'Required Resolution');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `required_resolution` SET TAGS ('dbx_value_regex' = 'SD|HD|FHD|UHD|4K|8K');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `sla_compliance` SET TAGS ('dbx_business_glossary_term' = 'SLA (Service Level Agreement) Compliance');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `subtitle_languages` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Languages');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`delivery_obligation` ALTER COLUMN `technical_standard` SET TAGS ('dbx_business_glossary_term' = 'Technical Standard');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` SET TAGS ('dbx_subdomain' = 'commercial_terms');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `carriage_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Schedule ID');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `carriage_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carriage Agreement ID');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel ID');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `genre_id` SET TAGS ('dbx_business_glossary_term' = 'Genre Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner ID');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `audit_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Rights Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `base_fee_per_subscriber` SET TAGS ('dbx_business_glossary_term' = 'Base Fee Per Subscriber');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `escalation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Escalation Frequency');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `escalation_frequency` SET TAGS ('dbx_value_regex' = 'none|annual|biannual|quarterly|monthly|custom');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `escalation_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Escalation Rate Percentage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Escalation Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `escalation_type` SET TAGS ('dbx_value_regex' = 'none|fixed_percentage|cpi_indexed|negotiated|tiered');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'per_subscriber|flat_rate|tiered|volume_based|hybrid|revenue_share');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `late_payment_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Rate');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `maximum_fee_cap` SET TAGS ('dbx_business_glossary_term' = 'Maximum Fee Cap');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `mfn_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Most-Favored-Nation (MFN) Provision Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `mfn_scope` SET TAGS ('dbx_business_glossary_term' = 'Most-Favored-Nation (MFN) Scope');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `minimum_guaranteed_fee` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guaranteed Fee');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|custom');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|superseded');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `subscriber_count_source` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Count Source');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `subscriber_count_source` SET TAGS ('dbx_value_regex' = 'distributor_reported|third_party_audit|nielsen|internal_estimate');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `volume_discount_tier_1_rate` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 1 Rate');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `volume_discount_tier_1_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 1 Threshold');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `volume_discount_tier_2_rate` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 2 Rate');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `volume_discount_tier_2_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 2 Threshold');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `volume_discount_tier_3_rate` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 3 Rate');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`carriage_fee_schedule` ALTER COLUMN `volume_discount_tier_3_threshold` SET TAGS ('dbx_business_glossary_term' = 'Volume Discount Tier 3 Threshold');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` SET TAGS ('dbx_subdomain' = 'commercial_terms');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `minimum_guarantee_id` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) ID');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition ID');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Content Provider ID');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Invoice Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `accounting_treatment_code` SET TAGS ('dbx_business_glossary_term' = 'Accounting Treatment Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `accounting_treatment_code` SET TAGS ('dbx_value_regex' = 'asset|expense|deferred_expense|prepaid|liability');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `accounting_treatment_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `accounting_treatment_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `amortization_method` SET TAGS ('dbx_business_glossary_term' = 'Amortization Method');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `amortization_method` SET TAGS ('dbx_value_regex' = 'straight_line|usage_based|revenue_based|accelerated|none');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `final_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Final Payment Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `first_payment_date` SET TAGS ('dbx_business_glossary_term' = 'First Payment Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `fully_recouped_date` SET TAGS ('dbx_business_glossary_term' = 'Fully Recouped Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `general_ledger_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `general_ledger_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `is_cross_collateralized` SET TAGS ('dbx_business_glossary_term' = 'Is Cross-Collateralized Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `is_recoupable` SET TAGS ('dbx_business_glossary_term' = 'Is Recoupable Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `last_recoupment_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Recoupment Calculation Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `mg_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `mg_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `mg_number` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Number');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `mg_number` SET TAGS ('dbx_value_regex' = '^MG-[A-Z0-9]{6,12}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `mg_status` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `mg_type` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee (MG) Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `mg_type` SET TAGS ('dbx_value_regex' = 'flat|tiered|performance_based|hybrid|recoupable|non_recoupable');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `next_recoupment_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recoupment Calculation Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `overage_amount` SET TAGS ('dbx_business_glossary_term' = 'Overage Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `overage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `overage_royalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Overage Royalty Rate');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `overage_royalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `payment_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `payment_terms_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Description');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `recouped_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Recouped to Date Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `recouped_to_date_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `recoupment_basis` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Basis');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `recoupment_basis` SET TAGS ('dbx_value_regex' = 'gross_revenue|net_revenue|advertising_revenue|subscription_revenue|combined_revenue|viewership_metric');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `recoupment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Percentage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `recoupment_period_months` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Period Months');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`minimum_guarantee` ALTER COLUMN `recoupment_waterfall_description` SET TAGS ('dbx_business_glossary_term' = 'Recoupment Waterfall Description');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` SET TAGS ('dbx_subdomain' = 'commercial_terms');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Payment Term Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `royalty_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rule Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `invoice_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `late_payment_grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Grace Period Days');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `late_payment_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Penalty Rate');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Approval Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Bank Account Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_bank_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|semi_annual|annual|upon_milestone');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|letter_of_credit|escrow|barter');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_milestone` SET TAGS ('dbx_business_glossary_term' = 'Payment Milestone');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_remittance_email` SET TAGS ('dbx_business_glossary_term' = 'Payment Remittance Email');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_remittance_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_remittance_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `payment_terms_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Description');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `term_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Number');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `term_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `term_type` SET TAGS ('dbx_value_regex' = 'acquisition_fee|carriage_fee|syndication_fee|co_production_contribution|royalty|residual');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `withholding_tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Jurisdiction');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `withholding_tax_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`payment_term` ALTER COLUMN `withholding_tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Rate');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` SET TAGS ('dbx_subdomain' = 'commercial_terms');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `territory_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Grant ID');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement ID');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `broadcast_license_id` SET TAGS ('dbx_business_glossary_term' = 'Broadcast License Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title ID');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Partner Partner Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `rights_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Territory Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `avod_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Advertising-Supported Video On Demand (AVOD) Rights Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `blackout_zone_indicator` SET TAGS ('dbx_business_glossary_term' = 'Blackout Zone Indicator');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `carriage_fee_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Carriage Fee Applicable Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Clearance Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|restricted|expired|revoked');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `clearance_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Clearance Verification Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `dma_code` SET TAGS ('dbx_business_glossary_term' = 'Designated Market Area (DMA) Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `dma_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `grant_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Reference Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `grant_reference_code` SET TAGS ('dbx_value_regex' = '^TG-[A-Z0-9]{6,12}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `grant_type` SET TAGS ('dbx_business_glossary_term' = 'Grant Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `grant_type` SET TAGS ('dbx_value_regex' = 'exclusive|non-exclusive|co-exclusive|holdback|reserved');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `holdback_restriction` SET TAGS ('dbx_business_glossary_term' = 'Holdback Restriction');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `language_restriction` SET TAGS ('dbx_business_glossary_term' = 'Language Restriction');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `linear_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Linear Rights Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `media_format_restriction` SET TAGS ('dbx_business_glossary_term' = 'Media Format Restriction');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `must_carry_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Carry Obligation Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Grant Notes');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `platform_scope` SET TAGS ('dbx_business_glossary_term' = 'Platform Scope');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Region Name');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `retransmission_consent_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Retransmission Consent Required Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Royalty Rate Percent');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `royalty_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `sublicense_permitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicense Permitted Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `svod_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Subscription Video On Demand (SVOD) Rights Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `tvod_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Transactional Video On Demand (TVOD) Rights Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`territory_grant` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` SET TAGS ('dbx_subdomain' = 'commercial_terms');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `partner_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Content Window Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `acquisition_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Deal Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `content_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Content Rating Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `title_id` SET TAGS ('dbx_business_glossary_term' = 'Content Title Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `version_id` SET TAGS ('dbx_business_glossary_term' = 'Content Version Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `demographic_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Demographic Segment Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `distribution_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `media_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Media Asset Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Window Owner Identifier (ID)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `revenue_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Stream Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `rights_content_window_id` SET TAGS ('dbx_business_glossary_term' = 'Rights Content Window Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `syndication_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Syndication Agreement Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `territory_grant_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Grant Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `content_format` SET TAGS ('dbx_business_glossary_term' = 'Content Format');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `content_format` SET TAGS ('dbx_value_regex' = 'sd|hd|4k|8k|hdr|dolby_vision');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_business_glossary_term' = 'Digital Rights Management (DRM) Requirement');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `drm_requirement` SET TAGS ('dbx_value_regex' = 'none|widevine|fairplay|playready|multi_drm');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `holdback_period_days` SET TAGS ('dbx_business_glossary_term' = 'Holdback Period in Days');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `language_availability` SET TAGS ('dbx_business_glossary_term' = 'Language Availability');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `marketing_rights_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Marketing Rights Included Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Guarantee Amount');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `minimum_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `monetization_model` SET TAGS ('dbx_business_glossary_term' = 'Monetization Model');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `monetization_model` SET TAGS ('dbx_value_regex' = 'subscription|advertising|transactional|free|hybrid');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `performance_guarantee_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Description');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `performance_guarantee_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `platform_name` SET TAGS ('dbx_business_glossary_term' = 'Platform Name');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `sublicensing_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Sublicensing Allowed Flag');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `subtitle_requirement` SET TAGS ('dbx_business_glossary_term' = 'Subtitle Requirement');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `territory_coverage` SET TAGS ('dbx_business_glossary_term' = 'Territory Coverage');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `window_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Window Duration in Days');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `window_end_date` SET TAGS ('dbx_business_glossary_term' = 'Window End Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `window_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Window Sequence Number');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `window_start_date` SET TAGS ('dbx_business_glossary_term' = 'Window Start Date');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `window_status` SET TAGS ('dbx_business_glossary_term' = 'Window Status');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `window_status` SET TAGS ('dbx_value_regex' = 'planned|active|expired|terminated|suspended|extended');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`partner_content_window` ALTER COLUMN `window_type` SET TAGS ('dbx_business_glossary_term' = 'Window Type');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` SET TAGS ('dbx_subdomain' = 'relationship_management');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` SET TAGS ('dbx_subdomain' = 'content_agreements');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Agreement Identifier');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ALTER COLUMN `master_partner_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ALTER COLUMN `sales_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Account Id (Foreign Key)');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ALTER COLUMN `contract_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ALTER COLUMN `performance_guarantee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `media_broadcasting_ecm`.`partner`.`agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_confidential' = 'true');
