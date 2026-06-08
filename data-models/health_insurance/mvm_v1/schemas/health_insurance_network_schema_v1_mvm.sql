-- Schema for Domain: network | Business: Health Insurance | Version: v1_mvm
-- Generated on: 2026-05-03 21:25:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `health_insurance_ecm`.`network` COMMENT 'Owns provider network configurations, tier assignments, in-network/out-of-network designations, geographic access standards, network adequacy metrics, and service area configurations. Manages ACO and VBC arrangement participation, network-to-plan associations, network directories, and CMS network adequacy filings. Distinct from provider identity (provider domain) and contract terms (contract domain); network owns the structural relationship between providers and plan networks.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `health_insurance_ecm`.`network`.`provider_network` (
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network. Primary key for the provider network entity.',
    `aco_participation_flag` BOOLEAN COMMENT 'Indicates whether this network includes participation in ACO arrangements. True if ACO providers are part of the network, False otherwise.',
    `cms_network_code` STRING COMMENT 'The unique identifier assigned by CMS for Medicare Advantage and Part D networks. Required for all Medicare networks. Format: one letter followed by five digits.. Valid values are `^[A-Z][0-9]{5}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this provider network record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'The date when this provider network becomes active and available for member enrollment and provider participation. Start of the networks operational lifecycle.',
    `facility_count` STRING COMMENT 'The number of hospitals, skilled nursing facilities, and other institutional providers in this network. Used for facility access adequacy assessments.',
    `geographic_footprint` STRING COMMENT 'Comma-separated list of states, counties, or service areas where this network operates. Defines the geographic scope of provider availability and member eligibility.',
    `last_adequacy_review_date` DATE COMMENT 'The date of the most recent internal or regulatory network adequacy review. Used to track compliance with annual review requirements.',
    `line_of_business` STRING COMMENT 'The primary business segment this network serves. Commercial (employer-sponsored), Medicare (federal beneficiaries), Medicaid (state beneficiaries), Exchange (ACA marketplace), ASO (Administrative Services Only self-funded).. Valid values are `Commercial|Medicare|Medicaid|Exchange|ASO`',
    `member_enrollment_count` STRING COMMENT 'The current number of members enrolled in plans associated with this network. Used for provider-to-member ratio calculations and capacity planning.',
    `network_adequacy_filing_date` DATE COMMENT 'The date when the most recent network adequacy filing was submitted to CMS or state regulators. Required annually for Medicare Advantage and Exchange plans.',
    `network_adequacy_status` STRING COMMENT 'Regulatory assessment of whether the network meets time-and-distance and provider-to-member ratio standards. Adequate (meets all standards), Deficient (fails standards), Conditional (approved with corrective action plan), Pending Review (under regulatory evaluation).. Valid values are `Adequate|Deficient|Conditional|Pending Review`',
    `network_code` STRING COMMENT 'Short alphanumeric code used to identify the network in operational systems, claims processing, and provider directories. Externally-known business identifier.. Valid values are `^[A-Z0-9]{3,10}$`',
    `network_description` STRING COMMENT 'Detailed narrative description of the networks design, provider composition, geographic coverage, and unique features. Used in member materials and regulatory filings.',
    `network_directory_url` STRING COMMENT 'The web URL where members and providers can access the online provider directory for this network. Required for ACA and Medicare Advantage compliance.. Valid values are `^https?://.*$`',
    `network_name` STRING COMMENT 'The official business name of the provider network (e.g., HMO Narrow Network, PPO Broad Network, Medicare Advantage Network). Human-readable identifier used in member communications and plan documents.',
    `network_status` STRING COMMENT 'Current operational status of the provider network. Active (accepting enrollments and claims), Inactive (closed to new enrollments), Suspended (temporary hold), Pending (awaiting regulatory approval), Terminated (permanently closed).. Valid values are `Active|Inactive|Suspended|Pending|Terminated`',
    `network_type` STRING COMMENT 'The structural classification of the provider network. HMO (Health Maintenance Organization) requires PCP and referrals; PPO (Preferred Provider Organization) allows out-of-network access; EPO (Exclusive Provider Organization) no out-of-network except emergency; POS (Point of Service) hybrid model; HDHP (High Deductible Health Plan) network; ACO (Accountable Care Organization) value-based network.. Valid values are `HMO|PPO|EPO|POS|HDHP|ACO`',
    `next_adequacy_review_date` DATE COMMENT 'The scheduled date for the next network adequacy review. Typically annual for Medicare Advantage and Exchange networks.',
    `out_of_network_coverage_flag` BOOLEAN COMMENT 'Indicates whether the network allows members to access out-of-network providers with cost-sharing. True for PPO and some POS networks, False for HMO and EPO.',
    `pcp_count` STRING COMMENT 'The number of primary care physicians in this network. Key metric for network adequacy and member-to-PCP ratio calculations.',
    `pcp_required_flag` BOOLEAN COMMENT 'Indicates whether members enrolled in this network are required to select a primary care physician. True for HMO and POS networks, False for PPO and EPO.',
    `provider_count` STRING COMMENT 'The total number of unique providers (physicians, facilities, ancillary) participating in this network. Used for network adequacy calculations and member communications.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicates whether specialist visits require a referral from the PCP. True for HMO networks, False for PPO, EPO, and most POS networks.',
    `regulatory_approval_date` DATE COMMENT 'The date when the network received regulatory approval from CMS or state Department of Insurance to begin operations.',
    `service_area_type` STRING COMMENT 'The geographic granularity at which this network is defined. Statewide (entire state), Regional (multi-county region), County (county-level), ZIP (ZIP code level), National (multi-state or nationwide).. Valid values are `Statewide|Regional|County|ZIP|National`',
    `specialist_count` STRING COMMENT 'The number of specialist physicians in this network. Used for specialty access adequacy assessments.',
    `star_rating` DECIMAL(18,2) COMMENT 'The CMS Star Rating for Medicare Advantage networks, ranging from 1.0 to 5.0 stars. Based on quality measures including network access, member satisfaction, and clinical outcomes. Null for non-Medicare networks.',
    `termination_date` DATE COMMENT 'The date when this provider network ceases operations and is no longer available for new enrollments. Nullable for open-ended networks. Existing members may have run-out periods.',
    `tier_classification` STRING COMMENT 'The tiering structure of the network for cost-sharing purposes. Tier 1 (lowest cost-sharing, narrow network), Tier 2 (moderate cost-sharing), Tier 3 (highest cost-sharing, broadest access), Single Tier (no tiering), Tiered (multi-tier structure).. Valid values are `Tier 1|Tier 2|Tier 3|Single Tier|Tiered`',
    `updated_by` STRING COMMENT 'The user ID or system identifier of the person or process that last modified this network record. Used for audit and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this provider network record was last modified. Used for audit trail and change tracking.',
    `vbc_arrangement_flag` BOOLEAN COMMENT 'Indicates whether this network includes value-based care arrangements with providers (e.g., shared savings, bundled payments, capitation). True if VBC arrangements exist, False otherwise.',
    `created_by` STRING COMMENT 'The user ID or system identifier of the person or process that created this network record. Used for audit and accountability.',
    CONSTRAINT pk_provider_network PRIMARY KEY(`provider_network_id`)
) COMMENT 'Master entity representing a named provider network — the structural grouping of providers under a specific network product (e.g., HMO Narrow Network, PPO Broad Network, Medicare Advantage Network). Owns network identity, network type (HMO, PPO, EPO, POS), line of business association, effective/termination dates, geographic footprint, CMS network ID, NCQA accreditation status, and tier classification. SSOT for network identity — distinct from plan (benefit design), provider (provider identity), and contract (reimbursement terms).';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`network`.`tier` (
    `tier_id` BIGINT COMMENT 'Unique identifier for the network tier. Primary key.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Network tier definitions are scoped to a specific provider network; adding provider_network_id FK establishes the parent relationship.',
    `coinsurance_differential_percentage` DECIMAL(18,2) COMMENT 'Percentage coinsurance differential for this tier. Used when cost_share_differential_type is coinsurance or hybrid. Null if not applicable.',
    `copay_differential_amount` DECIMAL(18,2) COMMENT 'Fixed dollar copay differential for this tier compared to baseline tier. Used when cost_share_differential_type is copay or hybrid. Null if not applicable.',
    `cost_share_differential_type` STRING COMMENT 'Type of cost-sharing differential applied to this tier (copay, coinsurance, deductible, hybrid, or none). Determines how member out-of-pocket (OOP) costs are calculated.. Valid values are `copay|coinsurance|deductible|hybrid|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this network tier record was first created in the system.',
    `deductible_applies_flag` BOOLEAN COMMENT 'Indicates whether the plan deductible applies to services rendered by providers in this tier before cost-sharing begins.',
    `display_label` STRING COMMENT 'Member-facing display label for the tier shown in EOB, member portal, and Summary of Benefits and Coverage (SBC). May differ from internal tier name for clarity.',
    `effective_date` DATE COMMENT 'Date when this network tier configuration becomes active and applicable to member cost-sharing and provider network assignments.',
    `facility_type_applicability` STRING COMMENT 'Defines which facility types this tier applies to (all, hospital, Skilled Nursing Facility (SNF), Durable Medical Equipment (DME), lab, imaging, pharmacy, home health, or custom list). Used to segment tier assignment rules by facility type. [ENUM-REF-CANDIDATE: all|hospital|snf|dme|lab|imaging|pharmacy|home_health|custom — 9 candidates stripped; promote to reference product]',
    `internal_notes` STRING COMMENT 'Internal operational notes or comments about this tier configuration. Not visible to members or external parties.',
    `last_updated_by` STRING COMMENT 'User identifier or system account that last modified this network tier record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this network tier record was last modified.',
    `member_steerage_incentive_description` STRING COMMENT 'Description of any member steerage incentives or rewards offered for using providers in this tier (e.g., reduced cost-sharing, waived deductible, wellness credits).',
    `network_adequacy_credit_flag` BOOLEAN COMMENT 'Indicates whether providers in this tier count toward CMS network adequacy standards and state Department of Insurance (DOI) access requirements.',
    `oop_max_applies_flag` BOOLEAN COMMENT 'Indicates whether member cost-sharing for this tier counts toward the plan Maximum Out-of-Pocket (MOOP) limit.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Indicates whether services from providers in this tier require Prior Authorization (PA) or Utilization Management (UM) review.',
    `quality_tier_flag` BOOLEAN COMMENT 'Indicates whether this tier is designated as a quality tier based on HEDIS, STAR ratings, or other quality performance metrics.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicates whether members must obtain a referral from their Primary Care Provider (PCP) to access providers in this tier. Typically applies to HMO and POS plans.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier for the state Department of Insurance (DOI) or CMS filing that approved this tier structure. Used for compliance audit trails.',
    `sbc_disclosure_text` STRING COMMENT 'Standardized disclosure text for this tier that appears in the Summary of Benefits and Coverage (SBC) document provided to members under ACA requirements.',
    `specialty_applicability` STRING COMMENT 'Defines which provider specialties this tier applies to (all, primary care only, specialist only, facility, ancillary, behavioral health, or custom list). Used to segment tier assignment rules by provider type. [ENUM-REF-CANDIDATE: all|primary_care|specialist|facility|ancillary|behavioral_health|custom — 7 candidates stripped; promote to reference product]',
    `termination_date` DATE COMMENT 'Date when this network tier configuration is terminated and no longer applicable. Null if currently active.',
    `tier_code` STRING COMMENT 'Business identifier code for the network tier (e.g., TIER1, TIER2, TIER3, OON). Used in system integrations and member communications.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `tier_name` STRING COMMENT 'Official name of the network tier as defined in plan documents and contracts.',
    `tier_rank` STRING COMMENT 'Numeric ranking of the tier indicating preference and cost-share level. Lower rank indicates preferred tier with lower member cost-sharing (e.g., 1=Tier 1 Preferred, 2=Tier 2 Standard, 3=Tier 3 Specialty, 99=Out-of-Network).',
    `tier_status` STRING COMMENT 'Current lifecycle status of the network tier configuration (active, inactive, pending approval, suspended, or retired).. Valid values are `active|inactive|pending|suspended|retired`',
    `tier_type` STRING COMMENT 'Classification of the tier indicating its strategic purpose within the network design (preferred, standard, specialty, out-of-network, value-based, narrow network).. Valid values are `preferred|standard|specialty|out_of_network|value_based|narrow_network`',
    `vbc_arrangement_eligible_flag` BOOLEAN COMMENT 'Indicates whether this tier is eligible for Value-Based Care (VBC) or Accountable Care Organization (ACO) performance incentives and shared savings arrangements.',
    CONSTRAINT pk_tier PRIMARY KEY(`tier_id`)
) COMMENT 'Defines the tier structure within a provider network — Tier 1 (preferred/lowest cost-share), Tier 2 (standard), Tier 3 (specialty/higher cost-share), and out-of-network designations. Captures tier name, tier rank, cost-share differential rules, member-facing display label, and applicability by specialty or facility type. Used to drive member cost-sharing calculations and EOB generation. Distinct from contract fee schedules (owned by contract domain).';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`network`.`network_provider` (
    `network_provider_id` BIGINT COMMENT 'Unique identifier for the network-provider association record. Primary key for this entity.',
    `practice_location_id` BIGINT COMMENT 'Foreign key linking to provider.practice_location. Business justification: Network directory accuracy and adequacy assessment require knowing the specific practice location where a provider participates in-network. Provider directory listings, time-distance adequacy calculat',
    `provider_id` BIGINT COMMENT 'Identifier of the provider participating in this network. Links to the provider master entity.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network to which this provider participates. Links to the network master entity.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: network_provider has a denormalized STRING column tier_assignment that captures the providers tier within the network. The tier table is the authoritative reference for tier definitions within a prov',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider is currently accepting new patients from this network. True indicates accepting new patients.',
    `accessibility_ada_compliant_flag` BOOLEAN COMMENT 'Boolean indicator of whether this providers facilities meet ADA accessibility requirements for members with disabilities. True indicates ADA compliance.',
    `aco_participant_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider participates in an ACO arrangement within this network. True indicates ACO participation.',
    `after_hours_availability_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider offers after-hours or extended-hours services to members of this network. True indicates after-hours availability.',
    `continuity_of_care_end_date` DATE COMMENT 'The date through which existing members may continue to see this provider under in-network benefits after network termination, per continuity of care requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this network-provider association record was first created in the system.',
    `credentialing_date` DATE COMMENT 'The date on which the provider was most recently credentialed for participation in this network.',
    `credentialing_status` STRING COMMENT 'Current credentialing status of the provider for participation in this network. Credentialed indicates all requirements met.. Valid values are `credentialed|pending|expired|suspended|revoked`',
    `current_panel_size` STRING COMMENT 'The current number of members assigned to or served by this provider within this network.',
    `directory_last_verified_date` DATE COMMENT 'The date on which the providers directory information was last verified for accuracy. CMS requires quarterly verification.',
    `directory_listing_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider should be included in the published provider directory for this network. True indicates directory inclusion.',
    `effective_date` DATE COMMENT 'The date on which the providers participation in this network became or will become effective.',
    `geographic_service_area` STRING COMMENT 'The geographic area or region within which this provider serves members of this network. May be county, ZIP code range, or custom service area code.',
    `in_network_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider is currently in-network for this network. True indicates in-network status.',
    `language_services_available` STRING COMMENT 'Comma-separated list of languages in which this provider offers services to members of this network, supporting cultural and linguistic access requirements.',
    `network_adequacy_category` STRING COMMENT 'Classification of this providers role in meeting network adequacy requirements. Essential indicates critical for minimum adequacy standards.. Valid values are `essential|standard|enhanced|specialty`',
    `network_participation_type` STRING COMMENT 'Classification of the providers participation relationship with this network. PAR indicates participating provider with contracted rates; non-PAR indicates non-participating.. Valid values are `par|non_par|out_of_network`',
    `panel_capacity` STRING COMMENT 'The maximum number of members this provider can serve within this network. Used for network adequacy calculations.',
    `panel_status` STRING COMMENT 'Current status of the providers patient panel for this network. Open indicates capacity for new members; closed indicates no capacity.. Valid values are `open|closed|limited|full`',
    `participation_status` STRING COMMENT 'Current status of the providers participation in this network. Active indicates the provider is currently in-network and accepting members.. Valid values are `active|inactive|suspended|pending|terminated`',
    `pcp_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider serves as a Primary Care Provider within this network. True indicates PCP designation.',
    `quality_tier_designation` STRING COMMENT 'Quality-based tier assignment for this provider within the network, based on HEDIS or Star Ratings performance metrics.. Valid values are `high_quality|standard_quality|low_quality|not_rated`',
    `record_active_flag` BOOLEAN COMMENT 'Boolean indicator of whether this network-provider association record is currently active in the system. False indicates a logically deleted or superseded record.',
    `recredentialing_due_date` DATE COMMENT 'The date by which the provider must complete recredentialing to maintain participation in this network. Typically every 3 years per NCQA standards.',
    `risk_sharing_arrangement_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider participates in risk-sharing financial arrangements within this network. True indicates risk-sharing participation.',
    `source_system` STRING COMMENT 'The name of the operational system from which this network-provider association record originated (e.g., Cactus, ProviderSource, Facets).',
    `specialist_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider is designated as a specialist within this network. True indicates specialist designation.',
    `telehealth_available_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider offers telehealth services to members of this network. True indicates telehealth availability.',
    `termination_date` DATE COMMENT 'The date on which the providers participation in this network ended or will end. Null for ongoing participation.',
    `termination_initiated_by` STRING COMMENT 'Indicates which party initiated the termination of the providers network participation. Null for active participation.. Valid values are `provider|health_plan|mutual|regulatory`',
    `termination_reason_code` STRING COMMENT 'Code indicating the reason for termination of the providers participation in this network. Null for active participation. [ENUM-REF-CANDIDATE: voluntary|contract_expiration|quality_issues|credentialing_failure|network_restructure|provider_request|other — 7 candidates stripped; promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this network-provider association record was most recently updated in the system.',
    `vbc_participant_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider participates in value-based care arrangements within this network. True indicates VBC participation.',
    `weekend_availability_flag` BOOLEAN COMMENT 'Boolean indicator of whether this provider offers weekend services to members of this network. True indicates weekend availability.',
    CONSTRAINT pk_network_provider PRIMARY KEY(`network_provider_id`)
) COMMENT 'Association entity representing the participation of a specific provider (NPI) within a specific provider network, capturing in-network status, effective and termination dates, tier assignment, accepting-new-patients flag, telehealth availability, panel status (open/closed), panel capacity, and credentialing linkage. This is the SSOT for the structural relationship between a provider and a network — distinct from provider identity (provider domain), contract terms (contract domain), and ACO-specific participation (aco_provider). Supports provider directory publication, CMS network adequacy filings, and member eligibility verification.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`network`.`plan_association` (
    `plan_association_id` BIGINT COMMENT 'Unique identifier for the plan association record. Primary key for this entity.',
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan product that is associated with this provider network. Links to the plan and benefit domains plan entity.',
    `network_service_area_id` BIGINT COMMENT 'Reference to the geographic service area where this plan-network association is valid. Defines the counties, ZIP codes, or regions where members can access this network under this plan.',
    `provider_network_id` BIGINT COMMENT 'Reference to the provider network being associated with the health plan product. Links to the network domains network configuration entity.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: plan_association has a network_tier STRING column that captures the tier designation for the plan-network association. The tier table is the authoritative reference for tier definitions within a provi',
    `aco_participation_flag` BOOLEAN COMMENT 'Indicates whether this plan-network association includes participation in an Accountable Care Organization arrangement. True means ACO providers are included in this network for this plan; false means no ACO participation.',
    `adequacy_certification_date` DATE COMMENT 'The date when this plan-network association was certified as meeting network adequacy requirements by the regulatory authority or internal compliance review.',
    `adequacy_review_date` DATE COMMENT 'The date of the most recent network adequacy review or assessment for this plan-network association. Used to track compliance monitoring cycles.',
    `association_code` STRING COMMENT 'Business identifier code for this plan-to-network association, used in eligibility verification (270/271 EDI transactions) and claims adjudication routing.. Valid values are `^[A-Z0-9]{6,20}$`',
    `association_name` STRING COMMENT 'Human-readable name for this plan-to-network association, typically combining plan name and network name for operational reference.',
    `association_type` STRING COMMENT 'Classification of the networks role for this plan. Primary indicates the main network for member access; supplemental provides additional coverage; specialty covers specific service categories; out-of-area supports members outside primary service area; reciprocal represents shared network arrangements; tertiary provides fallback coverage.. Valid values are `primary|supplemental|specialty|out_of_area|reciprocal|tertiary`',
    `auto_assignment_eligible_flag` BOOLEAN COMMENT 'Indicates whether members can be automatically assigned to providers in this network under this plan. Relevant for Medicaid and some Medicare programs that use auto-assignment for members who do not actively select a provider. True means eligible for auto-assignment; false means member must actively select.',
    `contract_reference_number` STRING COMMENT 'Reference to the master contract or agreement document that governs this plan-network association. Links to contract management systems for terms, rates, and legal provisions.. Valid values are `^[A-Z0-9-]{8,30}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this plan-network association record was first created in the system. Used for audit trail and data lineage tracking.',
    `directory_publication_flag` BOOLEAN COMMENT 'Indicates whether providers in this network for this plan should be published in member-facing provider directories and online search tools. True means include in directory; false means exclude (e.g., for internal or specialty networks).',
    `effective_date` DATE COMMENT 'The date when this plan-to-network association becomes active and members can begin accessing providers in this network under this plan.',
    `lob` STRING COMMENT 'The line of business this plan-network association serves. Commercial covers employer-sponsored and individual plans; Medicare includes Medicare Advantage; Medicaid covers state programs; Marketplace represents ACA exchange plans; dual eligible serves Medicare-Medicaid beneficiaries; CHIP covers Childrens Health Insurance Program.. Valid values are `commercial|medicare|medicaid|marketplace|dual_eligible|chip`',
    `market_segment` STRING COMMENT 'The market segment this plan-network association targets. Individual covers direct-to-consumer; small group typically 2-50 employees; large group 51-999 employees; jumbo group 1000+ employees; government includes federal and state employee plans; student covers university and college plans.. Valid values are `individual|small_group|large_group|jumbo_group|government|student`',
    `member_count` STRING COMMENT 'The number of members currently enrolled in this plan who have access to this network. Used for network adequacy calculations and capacity planning.',
    `network_adequacy_status` STRING COMMENT 'Indicates whether this plan-network association meets regulatory network adequacy standards for provider access, time-and-distance requirements, and specialty coverage. Compliant meets all standards; non-compliant fails requirements; under review is being evaluated; exempt has regulatory waiver; conditional meets standards with restrictions.. Valid values are `compliant|non_compliant|under_review|exempt|conditional`',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about this plan-network association. Used for operational notes that do not fit structured fields.',
    `out_of_network_coverage_flag` BOOLEAN COMMENT 'Indicates whether this plan provides any coverage for out-of-network services when this network is the members assigned network. True means out-of-network benefits exist (typical for PPO); false means no out-of-network coverage (typical for HMO and EPO).',
    `pcp_selection_required_flag` BOOLEAN COMMENT 'Indicates whether members enrolled in this plan with this network must select a primary care provider. Typically true for HMO and POS plans; false for PPO and EPO plans.',
    `plan_association_status` STRING COMMENT 'Current lifecycle status of the plan-network association. Active indicates operational; inactive means temporarily disabled; pending awaits regulatory approval or contract execution; suspended indicates temporary hold; terminated means permanently ended.. Valid values are `active|inactive|pending|suspended|terminated`',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Indicates whether services rendered by providers in this network under this plan require prior authorization. True means PA is required; false means no PA requirement. This is a network-level default that may be overridden by specific service or provider rules.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the priority order of this network when multiple networks are associated with the same plan. Lower numbers indicate higher priority. Used in claims adjudication routing when a member has access to multiple networks.',
    `provider_count` STRING COMMENT 'The number of unique providers (individual practitioners and facilities) participating in this network for this plan. Used for network adequacy reporting and member communications.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicates whether members must obtain a referral from their primary care provider to access specialists in this network under this plan. Typically true for HMO plans; false for PPO and EPO plans.',
    `regulatory_approval_date` DATE COMMENT 'The date when the regulatory authority (CMS or state DOI) approved this plan-network association for use. Required before the association can become effective.',
    `source_system` STRING COMMENT 'The name of the operational system of record that originated this plan-network association data. Typically the Core Administration Platform (Facets, QNXT) or Provider Management System (Cactus, ProviderSource).',
    `star_rating_impact_flag` BOOLEAN COMMENT 'Indicates whether provider performance in this network impacts the plans CMS Star Ratings. Applicable primarily to Medicare Advantage plans. True means network performance affects Star metrics; false means no Star impact.',
    `termination_date` DATE COMMENT 'The date when this plan-to-network association ends. Null indicates an open-ended association. After this date, members can no longer access providers in this network under this plan for new services.',
    `updated_by` STRING COMMENT 'The user identifier or system account that last modified this plan-network association record. Used for audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this plan-network association record was last modified. Used for audit trail and change tracking.',
    `vbc_arrangement_flag` BOOLEAN COMMENT 'Indicates whether this plan-network association operates under a value-based care payment model. True means providers in this network are reimbursed based on quality and outcomes; false means traditional fee-for-service.',
    `created_by` STRING COMMENT 'The user identifier or system account that created this plan-network association record. Used for audit trail and accountability.',
    CONSTRAINT pk_plan_association PRIMARY KEY(`plan_association_id`)
) COMMENT 'Association entity linking a provider network to one or more health plan products, capturing the effective period, LOB, market segment (individual, small group, large group, Medicare, Medicaid), and whether the network is the primary or supplemental network for that plan. Enables plan-to-network resolution for eligibility verification (270/271 EDI) and claims adjudication routing. Owned by the network domain as the structural bridge between network configurations and plan offerings.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`network`.`network_service_area` (
    `network_service_area_id` BIGINT COMMENT 'Unique identifier for the geographic service area. Primary key.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network to which this service area belongs.',
    `cms_service_area_code` STRING COMMENT 'CMS-assigned identifier for the service area, used in Medicare Advantage and Marketplace (QHP) filings.. Valid values are `^[A-Z0-9]{1,20}$`',
    `commercial_approved_flag` BOOLEAN COMMENT 'Indicates whether this service area is approved for commercial (employer-sponsored and individual) plan enrollment.',
    `county_fips_code` STRING COMMENT 'Five-digit Federal Information Processing Standards code uniquely identifying the county. Null for non-county-based service areas.. Valid values are `^[0-9]{5}$`',
    `county_name` STRING COMMENT 'Name of the county included in this service area. Null for non-county-based service areas.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service area record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when this service area configuration becomes active and available for member enrollment.',
    `geographic_boundary_description` STRING COMMENT 'Textual description of the service area boundaries, used for custom or complex geographic definitions not captured by standard codes.',
    `medicaid_approved_flag` BOOLEAN COMMENT 'Indicates whether this service area is approved for Medicaid managed care enrollment.',
    `medicare_advantage_approved_flag` BOOLEAN COMMENT 'Indicates whether this service area is approved for Medicare Advantage plan enrollment.',
    `member_residency_required_flag` BOOLEAN COMMENT 'Indicates whether members must reside within this service area to be eligible for enrollment in the associated network.',
    `msa_code` STRING COMMENT 'Five-digit code identifying the Metropolitan Statistical Area. Null for non-MSA-based service areas.. Valid values are `^[0-9]{5}$`',
    `msa_name` STRING COMMENT 'Name of the Metropolitan Statistical Area (e.g., San Francisco-Oakland-Hayward, CA). Null for non-MSA-based service areas.',
    `network_adequacy_approval_date` DATE COMMENT 'Date when the network adequacy filing was approved by CMS or the state Department of Insurance for this service area.',
    `network_adequacy_filing_date` DATE COMMENT 'Date when the most recent network adequacy filing was submitted to CMS or the state Department of Insurance for this service area.',
    `network_adequacy_status` STRING COMMENT 'Indicates whether the service area meets CMS and state network adequacy standards for provider access: compliant, non-compliant, under review, waiver granted, or not applicable.. Valid values are `compliant|non_compliant|under_review|waiver_granted|not_applicable`',
    `network_service_area_status` STRING COMMENT 'Current lifecycle status of the service area: active (available for enrollment), inactive (not available), pending approval (awaiting regulatory approval), suspended (temporarily unavailable), or terminated (permanently closed).. Valid values are `active|inactive|pending_approval|suspended|terminated`',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, exceptions, or special instructions related to this service area configuration.',
    `out_of_area_coverage_allowed_flag` BOOLEAN COMMENT 'Indicates whether the plan allows coverage for services received outside this service area (e.g., for travel or temporary relocation).',
    `population_count` BIGINT COMMENT 'Estimated total population residing in this service area, used for network adequacy calculations and market sizing.',
    `qhp_approved_flag` BOOLEAN COMMENT 'Indicates whether this service area is approved for Qualified Health Plan (Marketplace/Exchange) enrollment under the Affordable Care Act.',
    `service_area_code` STRING COMMENT 'Business identifier for the service area, used in contracts, filings, and member communications.. Valid values are `^[A-Z0-9]{3,15}$`',
    `service_area_name` STRING COMMENT 'Human-readable name of the service area (e.g., Northern California Region, Metro Atlanta Service Area).',
    `service_area_type` STRING COMMENT 'Classification of how the service area is defined geographically: county-based, ZIP code-based, Metropolitan Statistical Area (MSA)-based, state-based, custom boundary, or multi-state.. Valid values are `county_based|zip_based|msa_based|state_based|custom_boundary|multi_state`',
    `state_code` STRING COMMENT 'Two-letter state abbreviation where the service area is located (e.g., CA, TX, NY). For multi-state service areas, this represents the primary state.. Valid values are `^[A-Z]{2}$`',
    `termination_date` DATE COMMENT 'Date when this service area configuration is no longer active. Null for currently active service areas.',
    `updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this service area record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service area record was last modified.',
    `urban_rural_designation` STRING COMMENT 'Classification of the service area as urban, suburban, rural, frontier (very low population density), or mixed.. Valid values are `urban|suburban|rural|frontier|mixed`',
    `zip_code` STRING COMMENT 'Five-digit ZIP code included in this service area. Null for non-ZIP-based service areas.. Valid values are `^[0-9]{5}$`',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this service area record.',
    CONSTRAINT pk_network_service_area PRIMARY KEY(`network_service_area_id`)
) COMMENT 'Defines the geographic service area for a provider network — the counties, ZIP codes, or metropolitan statistical areas (MSAs) where the network is available and where members must reside to enroll. Captures state, county FIPS code, ZIP code, service area type (county-based, ZIP-based), CMS service area ID, effective dates, and whether the area is approved for QHP/Medicare Advantage enrollment. Critical for CMS network adequacy filings and state DOI market conduct compliance.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`network`.`adequacy_standard` (
    `adequacy_standard_id` BIGINT COMMENT 'Unique identifier for the network adequacy standard record. Primary key.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: Adequacy standards are derived directly from regulatory obligations (CMS 42 CFR 438.68, NCQA standards, state rules). adequacy_standard.regulatory_source references these obligations. Compliance offic',
    `adequacy_standard_status` STRING COMMENT 'Current lifecycle status of this adequacy standard: active (currently enforced), inactive (not currently enforced), proposed (pending regulatory approval), superseded (replaced by newer standard), or under-review (being evaluated for changes).. Valid values are `active|inactive|proposed|superseded|under-review`',
    `after_hours_availability_required` BOOLEAN COMMENT 'Indicates whether after-hours availability (evenings, weekends, holidays) is required for this specialty and geography. True if after-hours access is mandated, false otherwise.',
    `after_hours_definition` STRING COMMENT 'Definition of what constitutes after-hours for this standard (e.g., weekdays after 5pm, weekends, 24/7 access). Null if after-hours availability is not required.',
    `appointment_type` STRING COMMENT 'Type of appointment this wait-time standard applies to: routine (non-urgent care), urgent (same-day/next-day need), preventive (wellness visits), behavioral-health (mental health/substance abuse), specialist (referral appointments), or emergency. Null if standard is not appointment-access based.. Valid values are `routine|urgent|preventive|behavioral-health|specialist|emergency`',
    `compliance_reporting_frequency` STRING COMMENT 'How often compliance with this standard must be assessed and reported to regulators: annual, semi-annual, quarterly, monthly, or on-demand (event-triggered).. Valid values are `annual|semi-annual|quarterly|monthly|on-demand`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this adequacy standard record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date when this adequacy standard becomes effective and must be met. Standards change over time as regulations evolve.',
    `exception_criteria` STRING COMMENT 'Conditions under which an exception or waiver to this standard may be granted (e.g., provider shortage area designation, rural exception, temporary hardship). Null if no exceptions allowed.',
    `geographic_classification` STRING COMMENT 'Geographic area classification for which this standard applies: urban (metropolitan areas), suburban (surrounding metro areas), rural (non-metropolitan), or frontier (very low population density areas). Standards vary by geography.. Valid values are `urban|suburban|rural|frontier`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this adequacy standard record was last modified. Used for audit trail and change tracking.',
    `line_of_business` STRING COMMENT 'Health insurance line of business this standard applies to: medicare-advantage (MA plans), medicaid (state programs), commercial (employer-sponsored), marketplace (ACA exchange plans), dual-eligible (Medicare-Medicaid), or all (applies to all LOBs).. Valid values are `medicare-advantage|medicaid|commercial|marketplace|dual-eligible|all`',
    `maximum_distance_miles` DECIMAL(18,2) COMMENT 'Maximum allowable distance in miles from member residence to nearest in-network provider of this specialty in this geographic area. Null if standard is not distance-based.',
    `maximum_travel_time_minutes` STRING COMMENT 'Maximum allowable travel time in minutes from member residence to nearest in-network provider of this specialty in this geographic area. Null if standard is not time-based.',
    `maximum_wait_time_days` STRING COMMENT 'Maximum allowable wait time in days from appointment request to appointment date for this appointment type and specialty. Null if standard is not appointment-access based.',
    `measurement_methodology` STRING COMMENT 'Description of how compliance with this standard is measured (e.g., GeoAccess analysis, member survey, claims-based appointment tracking, provider attestation). Defines the assessment approach.',
    `minimum_provider_count` STRING COMMENT 'Absolute minimum number of providers of this specialty required in the network for this geography, regardless of member count. Null if not applicable.',
    `notes` STRING COMMENT 'Additional notes, clarifications, or special instructions related to this adequacy standard. May include implementation guidance, historical context, or regulatory interpretation.',
    `penalty_for_non_compliance` STRING COMMENT 'Description of regulatory penalties or consequences for failing to meet this standard (e.g., corrective action plan, fines, enrollment suspension, Star rating impact). Null if no specific penalty defined.',
    `plan_type` STRING COMMENT 'Type of health plan this standard applies to: HMO (Health Maintenance Organization), PPO (Preferred Provider Organization), EPO (Exclusive Provider Organization), POS (Point of Service), HDHP (High Deductible Health Plan), or all (applies to all plan types). Standards may vary by plan structure.. Valid values are `HMO|PPO|EPO|POS|HDHP|all`',
    `provider_to_member_ratio` STRING COMMENT 'Required ratio of providers to members for this specialty and geography, expressed as ratio string (e.g., 1:2000 for PCPs, 1:5000 for specialists). Null if standard is not ratio-based.',
    `regulatory_source` STRING COMMENT 'Governing body or regulatory authority that mandates this standard: CMS (Centers for Medicare and Medicaid Services), state-DOI (State Department of Insurance), NCQA (National Committee for Quality Assurance), URAC, ACA (Affordable Care Act), or internal (company-defined standard exceeding regulatory minimums).. Valid values are `CMS|state-DOI|NCQA|URAC|ACA|internal`',
    `service_area_type` STRING COMMENT 'Geographic unit for which this standard is defined: county (county-level), zip (ZIP code level), state (state-wide), region (multi-state region), or national (nationwide standard).. Valid values are `county|zip|state|region|national`',
    `specialty_category` STRING COMMENT 'Provider specialty or facility type this standard applies to (e.g., PCP, cardiology, behavioral-health, hospital, SNF, DME). May be broad category or specific specialty code.',
    `standard_category` STRING COMMENT 'Classification of the adequacy standard type: time-distance (geographic access), provider-ratio (provider-to-member ratios), appointment-access (wait time standards), after-hours (availability requirements), telehealth-equivalency (virtual care standards), or network-composition (network mix requirements).. Valid values are `time-distance|provider-ratio|appointment-access|after-hours|telehealth-equivalency|network-composition`',
    `standard_code` STRING COMMENT 'Business identifier code for the adequacy standard (e.g., PCP_URBAN_TIME, BH_RURAL_RATIO). Used for external reference and reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `standard_name` STRING COMMENT 'Human-readable name of the adequacy standard (e.g., Primary Care Physician Urban Time-Distance Standard).',
    `standard_version` STRING COMMENT 'Version identifier for this standard, used to track changes over time (e.g., 2024.1, v3.0). Supports historical analysis and regulatory audit trails.',
    `telehealth_equivalency_allowed` BOOLEAN COMMENT 'Indicates whether telehealth/virtual care providers can be counted toward meeting this adequacy standard. True if telehealth equivalency is permitted, false if only in-person providers count.',
    `telehealth_percentage_cap` DECIMAL(18,2) COMMENT 'Maximum percentage of the adequacy requirement that can be met through telehealth providers (e.g., 25.00 means up to 25% of required providers can be telehealth-only). Null if no cap or telehealth not allowed.',
    `termination_date` DATE COMMENT 'Date when this adequacy standard is no longer in effect, either due to regulatory change or supersession by a new standard. Null if currently active with no planned end date.',
    `threshold_percentage` DECIMAL(18,2) COMMENT 'Percentage of members or geographic area that must meet this standard (e.g., 90.00 means 90% of members must have access within the specified time/distance). Used for compliance measurement.',
    CONSTRAINT pk_adequacy_standard PRIMARY KEY(`adequacy_standard_id`)
) COMMENT 'Reference entity defining all network compliance standards by specialty, facility type, and geographic area — encompassing time-distance standards (e.g., 30 miles/30 minutes for PCPs), provider-to-member ratios, appointment access wait-time standards (routine, urgent, preventive, behavioral health), after-hours availability requirements, and telehealth equivalency rules. Captures regulatory source (CMS, state DOI, NCQA, URAC), standard category (time-distance, provider-ratio, appointment-access, after-hours, telehealth-equivalency), specialty category, geographic classification (urban, suburban, rural, frontier), maximum wait time in days, threshold values, and after-hours availability flag. This is the single source of truth for all network adequacy and access compliance standards — both geographic access (time-distance, ratios) and appointment access (wait times, after-hours). Used to evaluate compliance in adequacy assessments, access surveys, and CMS/state regulatory filings.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` (
    `adequacy_assessment_id` BIGINT COMMENT 'Unique identifier for the network adequacy assessment record. Primary key.',
    `access_standard_id` BIGINT COMMENT 'Foreign key linking to network.access_standard. Business justification: adequacy_assessment evaluates both network adequacy (via adequacy_standard_id) and appointment access/availability compliance. The access_standard table defines appointment wait-time and availability ',
    `adequacy_standard_id` BIGINT COMMENT 'Foreign key linking to network.adequacy_standard. Business justification: Each adequacy assessment applies a specific adequacy standard; linking via adequacy_standard_id enables reference to the standard definition.',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: CMS requires Medicare Advantage network adequacy assessments at the Plan Benefit Package (PBP) level. Regulatory submissions to CMS and state DOIs for adequacy certification must reference the specifi',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with this network adequacy assessment.',
    `network_service_area_id` BIGINT COMMENT 'Identifier of the geographic service area evaluated in this assessment.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Adequacy assessments are performed per contract to verify network adequacy obligations; link enables contract‑level performance dashboards.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network being assessed for adequacy compliance.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Adequacy assessments are performed to meet a specific regulatory obligation for network adequacy compliance.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether providers in the assessed specialty or facility type are accepting new patients. True if accepting, False otherwise.',
    `appointment_type_requested` STRING COMMENT 'Type of appointment requested during mystery shopper or survey assessment: routine care, urgent care, preventive visit, follow-up visit, new patient intake, or specialist referral.. Valid values are `routine|urgent|preventive|follow-up|new-patient|specialist-referral`',
    `assessment_date` DATE COMMENT 'Date on which the network adequacy assessment was conducted or completed.',
    `assessment_number` STRING COMMENT 'Business identifier for the adequacy assessment, used for external reference and regulatory submissions.',
    `assessment_period_end_date` DATE COMMENT 'End date of the evaluation period covered by this assessment.',
    `assessment_period_start_date` DATE COMMENT 'Start date of the evaluation period covered by this assessment.',
    `assessment_type` STRING COMMENT 'Type of network compliance evaluation performed: adequacy (provider count and ratio), access-survey (member experience survey), mystery-shopper (secret shopper call study), gap-analysis (deficiency identification), time-distance (geographic access compliance), or appointment-availability (wait time measurement).. Valid values are `adequacy|access-survey|mystery-shopper|gap-analysis|time-distance|appointment-availability`',
    `assessor_name` STRING COMMENT 'Name of the individual or team responsible for conducting the network adequacy assessment.',
    `assessor_organization` STRING COMMENT 'Organization or department that conducted the assessment (e.g., internal network management team, third-party consultant, regulatory auditor).',
    `comments` STRING COMMENT 'Additional notes, observations, or context related to the network adequacy assessment, including qualitative findings or special circumstances.',
    `compliance_outcome` STRING COMMENT 'Overall compliance result of the network adequacy assessment: compliant (meets all standards), non-compliant (fails standards), partially-compliant (meets some but not all standards), under-review (pending final determination), or remediation-required (corrective action needed).. Valid values are `compliant|non-compliant|partially-compliant|under-review|remediation-required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the adequacy assessment record was first created in the system.',
    `facility_type` STRING COMMENT 'Type of healthcare facility evaluated in this assessment (e.g., hospital, urgent care, skilled nursing facility (SNF), ambulatory surgery center, imaging center).',
    `gap_identified_flag` BOOLEAN COMMENT 'Indicates whether network gaps or deficiencies were identified during the assessment. True if gaps exist, False otherwise.',
    `gap_severity` STRING COMMENT 'Severity level of identified network gaps: critical (immediate member access risk), high (significant access limitation), moderate (minor access concern), or low (minimal impact).. Valid values are `critical|high|moderate|low`',
    `member_to_provider_ratio` DECIMAL(18,2) COMMENT 'Calculated ratio of enrolled members to available providers in the assessed specialty or facility type, expressed as members per provider.',
    `provider_count_available` STRING COMMENT 'Number of in-network providers or facilities available in the assessed specialty or facility type within the service area.',
    `provider_count_required` STRING COMMENT 'Minimum number of providers or facilities required by regulatory standards to meet network adequacy thresholds for the assessed specialty or facility type.',
    `regulatory_submission_type` STRING COMMENT 'Type of regulatory body or framework for which this assessment is being conducted: CMS Medicare, CMS Marketplace, State Department of Insurance (DOI), NCQA accreditation, internal monitoring, or ACA Qualified Health Plan (QHP) certification.. Valid values are `cms-medicare|cms-marketplace|state-doi|ncqa|internal|aca-qhp`',
    `remediation_action_taken` STRING COMMENT 'Description of corrective actions taken to address identified network gaps, such as provider recruitment, contract expansion, telehealth deployment, or member outreach.',
    `remediation_due_date` DATE COMMENT 'Target date by which remediation actions must be completed to resolve identified network gaps and achieve compliance.',
    `remediation_status` STRING COMMENT 'Current status of remediation efforts: not-started (action plan pending), in-progress (corrective actions underway), completed (actions finished), verified (compliance confirmed), or overdue (past due date).. Valid values are `not-started|in-progress|completed|verified|overdue`',
    `specialty_type` STRING COMMENT 'Medical specialty or provider type being evaluated in this assessment (e.g., primary care, cardiology, orthopedics, behavioral health, pediatrics).',
    `submission_date` DATE COMMENT 'Date on which the network adequacy assessment was submitted to the regulatory body (CMS, State DOI, NCQA).',
    `submission_status` STRING COMMENT 'Status of the regulatory submission: draft (not yet submitted), submitted (under review), accepted (approved by regulator), rejected (not approved), or resubmission-required (corrections needed).. Valid values are `draft|submitted|accepted|rejected|resubmission-required`',
    `survey_method` STRING COMMENT 'Methodology used to conduct the assessment: member survey (CAHPS or custom), secret shopper call (mystery shopper study), provider survey (direct provider inquiry), administrative data (claims and enrollment analysis), or geospatial analysis (GIS mapping).. Valid values are `member-survey|secret-shopper-call|provider-survey|administrative-data|geospatial-analysis`',
    `telehealth_offered_flag` BOOLEAN COMMENT 'Indicates whether telehealth or virtual care options were offered as an alternative during the assessment. True if telehealth was available, False otherwise.',
    `time_distance_compliance_percentage` DECIMAL(18,2) COMMENT 'Percentage of members in the service area who have access to the assessed provider specialty or facility type within the required time and distance standards.',
    `time_distance_standard_miles` DECIMAL(18,2) COMMENT 'Maximum distance in miles that members should travel to access the assessed provider specialty or facility type, as defined by regulatory standards.',
    `time_distance_standard_minutes` STRING COMMENT 'Maximum travel time in minutes that members should travel to access the assessed provider specialty or facility type, as defined by regulatory standards.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the adequacy assessment record was last modified in the system.',
    `wait_time_days_routine` STRING COMMENT 'Average number of days members wait for a routine appointment with the assessed provider specialty, measured through survey or mystery shopper methodology.',
    `wait_time_days_urgent` STRING COMMENT 'Average number of days members wait for an urgent appointment with the assessed provider specialty, measured through survey or mystery shopper methodology.',
    CONSTRAINT pk_adequacy_assessment PRIMARY KEY(`adequacy_assessment_id`)
) COMMENT 'Transactional record of a network compliance evaluation — including network adequacy assessments, access surveys, mystery shopper studies, and gap identification. Captures assessment type (adequacy, access-survey, mystery-shopper), assessment date, regulatory submission type (CMS, state DOI), specialty/facility type evaluated, provider counts, member-to-provider ratios, time-distance compliance results, wait-time measurements, survey method (member survey, secret shopper call), appointment type requested, telehealth offered flag, and overall compliance outcome. Includes detail-level gap findings as child records: specific specialty or facility type shortfalls within a geographic area, gap severity, number of providers available vs. required, remediation actions taken, and resolution status. Supports CMS network adequacy filings, NCQA HEDIS access measures (Getting Care Quickly), CAHPS survey supplementation, and targeted network development. This is the SSOT for all network compliance evaluations and their associated gap findings.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`network`.`adequacy_gap` (
    `adequacy_gap_id` BIGINT COMMENT 'Unique identifier for the network adequacy gap record. Primary key.',
    `adequacy_assessment_id` BIGINT COMMENT 'Reference to the parent network adequacy assessment that identified this gap.',
    `adequacy_standard_id` BIGINT COMMENT 'Foreign key linking to network.adequacy_standard. Business justification: adequacy_gap captures specific compliance gaps identified during an assessment. It has standard_type and standard_threshold as STRING columns that describe which standard was violated. Adding a direct',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: CMS adequacy gap remediation tracking for Medicare Advantage requires PBP-level linkage — gaps are identified and remediated at the benefit package level. Regulatory submissions and exception requests',
    `health_plan_id` BIGINT COMMENT 'Reference to the health plan affected by this network adequacy gap.',
    `network_service_area_id` BIGINT COMMENT 'Reference to the geographic service area where this adequacy gap exists.',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Identified adequacy gaps are addressed within the context of the specific provider contract; required for remediation tracking.',
    `provider_network_id` BIGINT COMMENT 'Reference to the provider network in which this adequacy gap exists.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: Adequacy gaps are identified against specific regulatory obligations (CMS 42 CFR 438.68, state network adequacy rules). Compliance officers must link each gap to its governing obligation to track pena',
    `actual_resolution_date` DATE COMMENT 'Actual date on which this adequacy gap was resolved and the network met the applicable adequacy standard. Null if gap remains unresolved.',
    `affected_member_count` STRING COMMENT 'Estimated number of plan members residing in the affected geographic area who are impacted by this adequacy gap.',
    `available_provider_count` STRING COMMENT 'Number of providers or facilities of the specified type currently available in the network in this geographic area. Null if standard is not count-based.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this adequacy gap record was first created in the system.',
    `exception_approval_date` DATE COMMENT 'Date on which the regulatory exception or access plan waiver was approved by CMS or the state DOI. Null if no exception has been granted.',
    `exception_expiration_date` DATE COMMENT 'Date on which the granted regulatory exception or access plan waiver expires and the network must meet the full adequacy standard. Null if no exception has been granted or if exception is permanent.',
    `exception_granted_flag` BOOLEAN COMMENT 'Indicates whether a regulatory exception or access plan waiver has been granted by CMS or the state DOI for this adequacy gap.',
    `exception_justification` STRING COMMENT 'Business rationale and supporting documentation for the regulatory exception or access plan waiver request (e.g., rural area with limited provider availability, specialty shortage area designation, alternative access arrangements).',
    `exception_request_date` DATE COMMENT 'Date on which a regulatory exception or access plan waiver was formally requested for this adequacy gap. Null if no exception has been requested.',
    `exception_requested_flag` BOOLEAN COMMENT 'Indicates whether a regulatory exception or access plan waiver has been requested from CMS or the state DOI for this adequacy gap.',
    `gap_magnitude` STRING COMMENT 'Numeric difference between required and available provider count (required minus available). Positive values indicate shortfall. Null if standard is not count-based.',
    `gap_number` STRING COMMENT 'Business identifier for the adequacy gap, used for tracking and reporting purposes.',
    `gap_severity` STRING COMMENT 'Severity classification of the adequacy gap based on magnitude of shortfall, number of affected members, and criticality of the specialty or service type. Used to prioritize remediation efforts.. Valid values are `critical|high|medium|low`',
    `gap_status` STRING COMMENT 'Current lifecycle status of the adequacy gap indicating whether it has been identified, is being remediated, has been resolved, or has received a regulatory exception or waiver.. Valid values are `identified|remediation_in_progress|resolved|exception_granted|waived`',
    `gap_type` STRING COMMENT 'Classification of the adequacy gap by the dimension of network adequacy that fails to meet standards (specialty provider shortage, facility type shortage, geographic coverage gap, time and distance standard violation, appointment wait time standard violation, or essential community provider requirement shortfall).. Valid values are `specialty|facility|geographic|time_distance|appointment_wait_time|essential_community_provider`',
    `geographic_area_code` STRING COMMENT 'Code identifying the specific geographic area affected by this adequacy gap (e.g., FIPS county code, ZIP code, CBSA code).',
    `geographic_area_name` STRING COMMENT 'Human-readable name of the geographic area affected by this adequacy gap (e.g., county name, city name, region name).',
    `geographic_area_type` STRING COMMENT 'Type of geographic unit used to define the area affected by this adequacy gap (county, ZIP code, Core-Based Statistical Area, service area, or custom region).. Valid values are `county|zip_code|cbsa|service_area|custom_region`',
    `identified_date` DATE COMMENT 'Date on which this network adequacy gap was first identified during an adequacy assessment.',
    `lob` STRING COMMENT 'Line of business to which this adequacy gap applies (Commercial, Medicare Advantage, Medicaid, Marketplace/Exchange, or Dual Eligible Special Needs Plan). Different LOBs may have different adequacy standards.. Valid values are `commercial|medicare_advantage|medicaid|marketplace|dual_eligible`',
    `notes` STRING COMMENT 'Additional free-text notes, context, or commentary regarding this adequacy gap, remediation efforts, or regulatory interactions.',
    `plan_year` STRING COMMENT 'Calendar year for which this adequacy gap applies and must be remediated (e.g., 2024, 2025). Network adequacy is assessed and certified annually.',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Indicates whether this adequacy gap must be disclosed in regulatory filings to CMS, state DOI, or other governing bodies (e.g., QHP certification, network adequacy annual report).',
    `remediation_action` STRING COMMENT 'Description of the corrective action plan or strategy being implemented to close this adequacy gap (e.g., targeted provider recruitment, contract expansion, telehealth deployment, access plan exception request).',
    `remediation_owner` STRING COMMENT 'Name or identifier of the individual, team, or department responsible for executing the remediation action and closing this adequacy gap.',
    `required_provider_count` STRING COMMENT 'Number of providers or facilities of the specified type required to meet the adequacy standard in this geographic area. Null if standard is not count-based.',
    `specialty_code` STRING COMMENT 'Standard taxonomy code for the provider specialty or facility type that is deficient (e.g., NUCC taxonomy code for specialty providers, facility type code for facilities). Null if gap is not specialty-specific.',
    `specialty_name` STRING COMMENT 'Human-readable name of the provider specialty or facility type that is deficient (e.g., Cardiology, Skilled Nursing Facility, Primary Care Physician). Null if gap is not specialty-specific.',
    `standard_threshold` STRING COMMENT 'The regulatory or contractual adequacy standard threshold that must be met (e.g., 30 miles or 30 minutes, 1 PCP per 2000 members, 95% within 10 business days). Format varies by standard type.',
    `standard_type` STRING COMMENT 'Type of network adequacy standard that this gap violates (time and distance, provider-to-member ratio, appointment availability, or essential community provider percentage requirement).. Valid values are `time_distance|provider_to_member_ratio|appointment_availability|essential_community_provider_percentage`',
    `target_resolution_date` DATE COMMENT 'Planned date by which this adequacy gap is expected to be resolved or mitigated to meet the applicable standard.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this adequacy gap record was last modified in the system.',
    CONSTRAINT pk_adequacy_gap PRIMARY KEY(`adequacy_gap_id`)
) COMMENT 'Captures individual network adequacy gaps identified during an adequacy assessment — specific specialty or facility type shortfalls within a geographic area that fail to meet the applicable adequacy standard. Records gap type, affected specialty, geographic area, number of providers available vs. required, gap severity, remediation action taken (e.g., provider recruitment, access plan exception), and resolution status. Enables targeted network development and regulatory gap closure tracking.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`network`.`provider_directory` (
    `provider_directory_id` BIGINT COMMENT 'Unique identifier for the provider directory record. Primary key for the published provider directory entry representing the member-facing view of a providers network participation.',
    `network_provider_id` BIGINT COMMENT 'Foreign key linking to network.network_provider. Business justification: provider_directory is the member-facing published view of a providers network participation. network_provider is the internal operational record of that same participation. These are two representati',
    `provider_network_id` BIGINT COMMENT 'Reference to the network configuration. Identifies which network this provider participates in for member directory searches.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether the provider is currently accepting new patients. Critical field for member directory searches and CMS directory accuracy compliance.',
    `accessibility_features` STRING COMMENT 'Description of specific accessibility features available at the practice location, such as wheelchair ramps, accessible parking, or assistive listening devices.',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates whether the practice location is ADA-compliant and accessible to individuals with disabilities. Supports member searches for accessible facilities.',
    `address_line_1` STRING COMMENT 'Primary street address of the practice location. First line of the physical address where the provider sees patients.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or building number. Optional address component for practice location.',
    `board_certification_status` STRING COMMENT 'Indicates whether the provider is board-certified in their specialty. Used for quality assessment and member directory filtering.. Valid values are `certified|not_certified|eligible|unknown`',
    `city` STRING COMMENT 'City name of the practice location. Used for geographic search and network adequacy reporting.',
    `county` STRING COMMENT 'County name of the practice location. Used for CMS network adequacy reporting and geographic access standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this provider directory record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Calculated data quality score for this directory entry based on completeness, accuracy, and recency of verification. Range 0.00 to 100.00. Supports directory quality monitoring.',
    `directory_publication_channel` STRING COMMENT 'The channel through which this directory entry is published and accessible to members. Supports multi-channel directory distribution tracking.. Valid values are `online|print|api|mobile_app|call_center`',
    `directory_status` STRING COMMENT 'Current status of the provider directory entry. Indicates whether the entry is actively published, pending verification, or suspended from member-facing display.. Valid values are `active|inactive|pending_verification|suspended`',
    `effective_end_date` DATE COMMENT 'Date when this provider directory entry was terminated or became inactive. Null for currently active entries. Supports historical directory analysis.',
    `effective_start_date` DATE COMMENT 'Date when this provider directory entry became effective and available for member searches. Supports historical tracking of directory changes.',
    `email_address` STRING COMMENT 'Email contact for the practice location. Used for electronic communication and directory verification outreach.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the practice location. Used for prior authorization and medical records transmission.. Valid values are `^[0-9]{10}$`',
    `gender` STRING COMMENT 'Gender of the provider. Used for member preference-based directory searches, particularly for gender-specific care.. Valid values are `male|female|non-binary|other|unknown`',
    `hospital_affiliation` STRING COMMENT 'Name of the hospital or health system with which the provider has admitting privileges or affiliation. Supports continuity of care and member decision-making.',
    `languages_spoken` STRING COMMENT 'Comma-separated list of languages spoken by the provider or available at the practice location. Supports culturally competent care and member language preference searches.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this provider directory record was last modified. Supports change tracking and audit compliance.',
    `last_verification_method` STRING COMMENT 'Method used for the most recent directory verification. Tracks how the provider information was validated for audit and compliance purposes.. Valid values are `outbound_call|online_attestation|ehr_data_match|claims_inference|mail_survey|email_confirmation`',
    `last_verification_outcome` STRING COMMENT 'Outcome of the most recent verification attempt. Indicates whether information was confirmed, updated, or if verification was unsuccessful.. Valid values are `confirmed|updated|unable_to_reach|provider_declined|no_response`',
    `last_verified_date` DATE COMMENT 'Date when the provider directory information was last verified. Critical for CMS 90-day directory update mandate and No Surprises Act compliance.',
    `next_verification_due_date` DATE COMMENT 'Date by which the next directory verification must be completed. Supports compliance with CMS 90-day update mandate and quarterly verification tracking.',
    `npi` STRING COMMENT 'The 10-digit National Provider Identifier assigned by CMS. Used for provider identification in claims and directory searches.. Valid values are `^[0-9]{10}$`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the practice location. Ten-digit phone number displayed in member directory for appointment scheduling.. Valid values are `^[0-9]{10}$`',
    `practice_location_name` STRING COMMENT 'Name of the practice location or facility where the provider sees patients. Displayed in member directory for location identification.',
    `source_system` STRING COMMENT 'Name of the source system from which this directory record originated. Examples include ProviderSource, Cactus, or manual entry. Supports data lineage and reconciliation.',
    `specialty_primary` STRING COMMENT 'The primary medical specialty or taxonomy classification of the provider. Used for member search and filtering in the directory.',
    `specialty_secondary` STRING COMMENT 'Additional specialty or sub-specialty of the provider. Supports multi-specialty provider directory searches.',
    `state` STRING COMMENT 'Two-letter state abbreviation of the practice location. Used for geographic filtering and state-level network adequacy compliance.. Valid values are `^[A-Z]{2}$`',
    `telehealth_available_flag` BOOLEAN COMMENT 'Indicates whether the provider offers telehealth or virtual visit services. Supports member search for remote care options.',
    `termination_reason` STRING COMMENT 'Reason why the provider directory entry was terminated or inactivated. Examples include provider left network, practice closed, or data quality issue.',
    `verified_fields` STRING COMMENT 'Comma-separated list of fields that were verified during the last verification event. Examples include address, phone, accepting_new_patients, specialty.',
    `verifying_agent` STRING COMMENT 'Name or identifier of the person or system that performed the last verification. Used for audit trail and quality assurance.',
    `website_url` STRING COMMENT 'Website address for the provider or practice location. Displayed in member directory for additional provider information.',
    `zip_code` STRING COMMENT 'Five-digit or nine-digit ZIP code of the practice location. Used for proximity-based member searches and geographic access analysis.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    CONSTRAINT pk_provider_directory PRIMARY KEY(`provider_directory_id`)
) COMMENT 'Published provider directory record representing the member-facing view of a providers network participation, including full verification lifecycle tracking. Captures provider name, specialty, practice location, phone, accepting-new-patients status, telehealth availability, languages spoken, accessibility features (ADA compliance), last verified date, and directory publication channel (online, print, API). Embeds complete verification history as child records — including verification method (outbound call, online attestation, EHR/HIE data match, claims-based inference), verification date, verified fields (address, phone, accepting-new-patients, specialty), verification outcome (confirmed, updated, unable to reach), and verifying agent/system. Supports CMS directory accuracy requirements (42 CFR 422.111), No Surprises Act compliance, the 90-day directory update mandate, and quarterly verification tracking. This is the SSOT for member-facing directory data and its verification audit trail.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` (
    `vbc_arrangement_id` BIGINT COMMENT 'Primary key for vbc_arrangement',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Value-based care arrangements are executed under specific health plans — shared savings reconciliation, quality performance reporting, and CMS ACO reporting all require knowing which health plan spons',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.network_service_area. Business justification: vbc_arrangement has a service_area_description STRING that describes the geographic scope of the VBC arrangement. network_service_area is the authoritative entity for service area definitions. Adding ',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: vbc_arrangement represents a VBC program participation arrangement that operates within a specific provider network. The arrangement tracks participating_provider_count, participating_aco_name, and se',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: VBC arrangements with cms_reporting_required_flag=true operate under specific CMS regulatory obligations (MSSP, CPC+, ACO REACH). Compliance officers must link each arrangement to its governing obliga',
    `vbc_program_id` BIGINT COMMENT 'Foreign key linking to network.vbc_program. Business justification: A VBC arrangement implements a defined VBC program; adding vbc_program_id FK ties arrangement to its program definition.',
    `arrangement_name` STRING COMMENT 'Human-readable name of the VBC arrangement or ACO program (e.g., Metro Health ACO MSSP Track 1, Regional P4P Quality Incentive Program).',
    `arrangement_number` STRING COMMENT 'Business identifier or contract number assigned to this VBC arrangement. Externally-known reference used in communications with providers and CMS.',
    `arrangement_status` STRING COMMENT 'Current lifecycle status of the VBC arrangement. Tracks progression from draft through active participation to termination or completion.. Valid values are `draft|pending_approval|active|suspended|terminated|completed`',
    `arrangement_type` STRING COMMENT 'Classification of the VBC arrangement model. Distinguishes between Medicare Shared Savings Program (MSSP) tracks, Next Generation ACO, Realizing Equity Access and Community Health (REACH) ACO, commercial pay-for-performance (P4P), episode-based payment, capitation, bundled payment, or other VBC models. [ENUM-REF-CANDIDATE: mssp_track_1|mssp_track_2|mssp_track_3|next_gen_aco|reach_aco|commercial_p4p|episode_based_payment|capitation|bundled_payment|other — 10 candidates stripped; promote to reference product]',
    `attributed_member_count` STRING COMMENT 'Number of health plan members or Medicare beneficiaries attributed to this ACO or VBC arrangement for the performance period. Used for PMPM calculations and risk adjustment.',
    `attribution_methodology` STRING COMMENT 'Method used to assign members to the ACO or provider group. Prospective assigns at year start; retrospective assigns at year end based on utilization; voluntary alignment allows member choice; claims-based uses historical claims patterns.. Valid values are `prospective|retrospective|voluntary_alignment|claims_based`',
    `benchmark_amount` DECIMAL(18,2) COMMENT 'Target cost or quality benchmark value established for the performance period. Expressed in dollars for cost benchmarks or as a quality score for quality benchmarks.',
    `benchmark_methodology` STRING COMMENT 'Method used to establish the cost or quality benchmark against which performance is measured. Options include historical baseline (prior year costs), regional average, national trend, risk-adjusted PMPM, or episode target price.. Valid values are `historical_baseline|regional_average|national_trend|risk_adjusted_pmpm|episode_target_price`',
    `care_coordination_required_flag` BOOLEAN COMMENT 'Indicates whether the VBC arrangement requires formal care coordination programs (care management, transitional care, chronic disease management). True if required; False if optional or not applicable.',
    `cms_aco_code` STRING COMMENT 'CMS-assigned identifier for Medicare Shared Savings Program (MSSP) or other federally-recognized ACO arrangements. Null for commercial VBC programs.',
    `cms_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this arrangement requires formal reporting to Centers for Medicare and Medicaid Services (CMS). True for all Medicare ACOs; False for commercial-only VBC programs.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VBC arrangement record was first created in the system. Used for audit trail and data lineage.',
    `data_sharing_agreement_flag` BOOLEAN COMMENT 'Indicates whether a formal data sharing agreement exists between the health plan and the ACO or provider group for claims, clinical, and quality data exchange. True if agreement is in place; False otherwise.',
    `effective_end_date` DATE COMMENT 'Date when the VBC arrangement ends or is scheduled to end. Null for open-ended arrangements. Aligns with CMS performance year end for Medicare ACOs.',
    `effective_start_date` DATE COMMENT 'Date when the VBC arrangement becomes active and performance measurement begins. Aligns with CMS performance year start for Medicare ACOs.',
    `health_it_certification_required_flag` BOOLEAN COMMENT 'Indicates whether participating providers must use certified Electronic Health Record (EHR) systems and meet health IT standards. True if required; False if not required.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this VBC arrangement record was last modified. Used for audit trail and change tracking.',
    `minimum_loss_rate` DECIMAL(18,2) COMMENT 'Minimum percentage of cost overruns before shared losses are assessed. Provides a buffer zone for two-sided risk arrangements.',
    `minimum_savings_rate` DECIMAL(18,2) COMMENT 'Minimum percentage of cost savings required before shared savings are paid. Acts as a threshold to ensure savings are statistically significant.',
    `participating_aco_name` STRING COMMENT 'Legal name of the Accountable Care Organization or provider group participating in this VBC arrangement. Null for program template records.',
    `participating_provider_count` STRING COMMENT 'Number of individual providers (physicians, specialists, facilities) participating in this ACO or VBC arrangement. Used for network adequacy and capacity planning.',
    `performance_guarantee_amount` DECIMAL(18,2) COMMENT 'Dollar amount of financial guarantee or bond required from the ACO or provider group to participate in two-sided risk arrangements. Ensures ability to repay shared losses.',
    `performance_year` STRING COMMENT 'Calendar year for which performance is measured and financial reconciliation is calculated. Aligns with CMS performance year for Medicare ACOs.',
    `primary_care_physician_count` STRING COMMENT 'Number of primary care physicians participating in this ACO or VBC arrangement. Critical for attribution and care coordination requirements.',
    `quality_measure_set` STRING COMMENT 'Name or identifier of the quality measure set used to evaluate clinical performance (e.g., CMS ACO Quality Measures, HEDIS Comprehensive, Custom Commercial P4P Measures).',
    `quality_performance_threshold` DECIMAL(18,2) COMMENT 'Minimum quality performance score required to earn shared savings or avoid penalties. Expressed as a percentage (e.g., 70.00 for 70th percentile).',
    `reconciliation_frequency` STRING COMMENT 'Frequency at which financial performance is reconciled and shared savings or losses are calculated and settled. Most Medicare ACOs reconcile annually; commercial arrangements may reconcile more frequently.. Valid values are `annual|semi_annual|quarterly|monthly`',
    `record_type` STRING COMMENT 'Distinguishes whether this record represents a program definition template (reusable VBC program design) or a specific participation instance (actual arrangement with a provider group or ACO).. Valid values are `program_template|participation_instance`',
    `risk_model` STRING COMMENT 'Financial risk-sharing model of the arrangement. One-sided risk allows shared savings only; two-sided risk includes shared savings and losses; upside-only is gain-sharing; downside risk is penalty-only; full capitation transfers all risk.. Valid values are `one_sided_risk|two_sided_risk|upside_only|downside_risk|full_capitation`',
    `service_area_description` STRING COMMENT 'Geographic description of the service area covered by this VBC arrangement (e.g., Statewide California, Metro Atlanta Region, National Medicare Population).',
    `shared_loss_rate` DECIMAL(18,2) COMMENT 'Percentage of cost overruns above benchmark that the ACO or provider group is responsible for under two-sided risk models. Null for one-sided risk arrangements.',
    `shared_savings_rate` DECIMAL(18,2) COMMENT 'Percentage of cost savings below benchmark that the ACO or provider group earns as shared savings. Expressed as a percentage (e.g., 50.00 for 50%).',
    `source_system` STRING COMMENT 'Name of the operational system from which this VBC arrangement record originated (e.g., Cactus Provider Management, Custom VBC Platform, CMS ACO Portal).',
    `specialist_physician_count` STRING COMMENT 'Number of specialist physicians participating in this ACO or VBC arrangement. Used for network adequacy and specialty care access analysis.',
    `sponsoring_entity_name` STRING COMMENT 'Name of the organization sponsoring or administering the VBC program (e.g., health plan name, CMS for federal programs, employer group for commercial arrangements).',
    `stop_loss_limit` DECIMAL(18,2) COMMENT 'Maximum financial loss amount the ACO or provider group is responsible for under two-sided risk arrangements. Provides downside risk protection. Null for one-sided risk or full capitation models.',
    `termination_date` DATE COMMENT 'Actual date the VBC arrangement was terminated or withdrawn. Null for active or completed arrangements. Distinct from effective_end_date which is the scheduled end.',
    `termination_reason` STRING COMMENT 'Business reason for early termination of the VBC arrangement (e.g., Poor Financial Performance, Provider Withdrawal, Regulatory Non-Compliance, Mutual Agreement). Null for arrangements that completed their term.',
    CONSTRAINT pk_vbc_arrangement PRIMARY KEY(`vbc_arrangement_id`)
) COMMENT 'Master entity representing Value-Based Care (VBC) programs and their participation arrangements — covering both program design (program type, sponsoring entity, quality measure set, risk model, benchmark methodology) and specific ACO/VBC participation instances (ACO name, CMS ACO ID, arrangement dates, shared savings/risk terms, participating provider groups). Supports MSSP, Next Gen, REACH, commercial P4P, episode-based payment, and capitation models. Records may represent a program definition (template) or a specific arrangement instance (participation record), distinguished by record type. Owned by the network domain as the structural participation record — financial settlement terms are owned by the contract domain.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`network`.`exception` (
    `exception_id` BIGINT COMMENT 'Unique identifier for the network adequacy exception record. Primary key.',
    `adequacy_assessment_id` BIGINT COMMENT 'Foreign key linking to network.adequacy_assessment. Business justification: An exception is filed when a network adequacy assessment reveals non-compliance that cannot be remediated. Linking exception to the triggering adequacy_assessment provides full traceability from asses',
    `adequacy_gap_id` BIGINT COMMENT 'Foreign key linking to network.adequacy_gap. Business justification: An exception (network adequacy exception filed with a regulator) is typically triggered by a specific adequacy_gap that could not be remediated. adequacy_gap already tracks exception_granted_flag, exc',
    `adequacy_standard_id` BIGINT COMMENT 'Foreign key linking to network.adequacy_standard. Business justification: An exception is filed when a network fails to meet a specific adequacy standard (e.g., time-distance standard for a specialty). exception has time_distance_standard_waived (STRING) and specialty_code ',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.appeal_case. Business justification: Exception Appeal Tracking process records when a member appeals a network exception decision, linking exception to the appeal case.',
    `benefit_package_id` BIGINT COMMENT 'CMS Plan Benefit Package identifier for the specific Medicare Advantage plan affected by this exception.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with this network adequacy exception, if applicable.',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.network_service_area. Business justification: exception has a service_area_code STRING column that identifies the geographic service area for which the exception is filed. network_service_area is the authoritative entity for service area definiti',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: Contract exceptions are recorded against the governing provider contract for audit and exception‑management workflows.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network for which the adequacy exception applies.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: Network adequacy exceptions are granted under specific regulatory obligations (e.g., 42 CFR 438.68 for Medicaid, CMS MA network adequacy rules). Compliance officers must link each exception to its gov',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: Network adequacy exceptions (time-distance waivers, specialty shortages) require formal regulatory submissions to CMS or state agencies. exception.regulatory_body is denormalized from regulatory_submi',
    `affected_member_count` STRING COMMENT 'Estimated number of plan members residing in the affected geographic area who may be impacted by the network adequacy gap.',
    `alternative_access_arrangement` STRING COMMENT 'Description of alternative access arrangements provided to members in lieu of meeting standard adequacy (e.g., telehealth services, out-of-network reimbursement at in-network rates, transportation assistance).',
    `appeal_decision` STRING COMMENT 'Outcome of the appeal process if an appeal was filed: upheld (denial confirmed), overturned (exception granted on appeal), or pending (appeal under review). Null if no appeal filed.. Valid values are `upheld|overturned|pending`',
    `appeal_filed_flag` BOOLEAN COMMENT 'Indicates whether an appeal was filed in response to a denial of this exception request. True if appeal filed, false otherwise.',
    `approval_date` DATE COMMENT 'Date the exception was approved by the regulatory body. Null if not yet approved or if denied.',
    `approved_terms` STRING COMMENT 'Specific terms and conditions under which the exception was granted by the regulatory body, including any requirements, limitations, or reporting obligations.',
    `cms_contract_number` STRING COMMENT 'CMS Medicare Advantage or Part D contract number associated with this exception filing, if applicable to Medicare lines of business.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this exception record was first created in the system.',
    `denial_date` DATE COMMENT 'Date the exception was denied by the regulatory body. Null if approved or still under review.',
    `effective_date` DATE COMMENT 'Date from which the approved exception terms become effective and the network adequacy waiver applies.',
    `exception_number` STRING COMMENT 'External filing or tracking number assigned by the regulatory body or internal system for this exception request.',
    `exception_status` STRING COMMENT 'Current lifecycle status of the exception filing: draft (being prepared), submitted (filed with regulator), under review (regulator reviewing), approved (exception granted), denied (exception rejected), withdrawn (voluntarily withdrawn), or expired (approval period ended). [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|denied|withdrawn|expired — 7 candidates stripped; promote to reference product]',
    `exception_type` STRING COMMENT 'Category of network adequacy exception being filed: time-distance waiver (cannot meet time/distance standards), rural exception (rural area with limited providers), access plan (formal plan to address gaps), specialty shortage (insufficient specialists in area), temporary disruption (short-term network change), or other.. Valid values are `time_distance_waiver|rural_exception|access_plan|specialty_shortage|temporary_disruption|other`',
    `expiration_date` DATE COMMENT 'Date on which the approved exception expires and standard network adequacy requirements resume. Null for indefinite exceptions.',
    `filing_date` DATE COMMENT 'Date the exception request was officially submitted to the regulatory body.',
    `geographic_description` STRING COMMENT 'Textual description of the geographic area affected by the exception, including counties, ZIP codes, or other location identifiers.',
    `internal_notes` STRING COMMENT 'Internal operational notes regarding the exception filing, review process, or follow-up actions. Not shared with regulatory bodies or members.',
    `last_updated_by` STRING COMMENT 'User ID or name of the person who last updated this exception record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this exception record was most recently updated.',
    `lob` STRING COMMENT 'Line of business to which this network adequacy exception applies: Medicare Advantage, Medicaid, commercial, marketplace (ACA exchange), or dual eligible (Medicare-Medicaid).. Valid values are `medicare_advantage|medicaid|commercial|marketplace|dual_eligible`',
    `member_notification_date` DATE COMMENT 'Date on which affected members were notified of the network adequacy exception and alternative access options. Null if notification not yet completed or not required.',
    `member_notification_flag` BOOLEAN COMMENT 'Indicates whether members in the affected area must be notified of the network adequacy exception and alternative access arrangements. True if notification is required, false otherwise.',
    `mitigation_plan` STRING COMMENT 'Description of the health plans strategy to mitigate member access issues during the exception period, such as out-of-network coverage, telehealth options, or provider recruitment efforts.',
    `provider_recruitment_effort` STRING COMMENT 'Summary of the health plans efforts to recruit additional providers in the affected specialty and geographic area to resolve the adequacy gap.',
    `reason` STRING COMMENT 'Detailed explanation of why the network cannot meet standard adequacy thresholds in this area, including market conditions, provider availability, and geographic constraints.',
    `regulatory_jurisdiction` STRING COMMENT 'Specific jurisdiction or state where the exception is filed (e.g., state abbreviation for state DOI filings, or Federal for CMS).',
    `review_due_date` DATE COMMENT 'Expected or required date by which the regulatory body must complete review of the exception request.',
    `specialty_code` STRING COMMENT 'Code identifying the provider specialty or service type affected by this exception (e.g., cardiology, orthopedic surgery, behavioral health). May reference taxonomy codes or internal specialty classifications.',
    `specialty_name` STRING COMMENT 'Human-readable name of the provider specialty or service type affected by this exception.',
    `supporting_documentation_reference` STRING COMMENT 'Reference identifier or location of supporting documentation submitted with the exception filing (e.g., provider availability analysis, geographic access study, member impact assessment).',
    `time_distance_standard_waived` STRING COMMENT 'Specific time or distance standard that is waived under this exception (e.g., 30 minutes/30 miles for primary care). Applicable for time-distance waiver exception types.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this exception record.',
    CONSTRAINT pk_exception PRIMARY KEY(`exception_id`)
) COMMENT 'Transactional record of a network adequacy exception or access plan filed with a regulator when a network cannot meet standard adequacy thresholds in a specific geographic area or specialty. Captures exception type (time-distance waiver, rural exception, access plan), affected network, specialty, geographic area, regulatory body (CMS, state DOI), filing date, approval status, approved exception terms, and expiration date. Supports CMS HPMS exception filings and state DOI access plan submissions.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`network`.`access_standard` (
    `access_standard_id` BIGINT COMMENT 'Unique identifier for the access standard record. Primary key.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: Access standards (appointment wait times, after-hours availability) are mandated by specific regulatory obligations (CMS access standards, state timely access rules). access_standard.regulatory_citati',
    `superseded_by_standard_access_standard_id` BIGINT COMMENT 'Reference to the access_standard_id of the newer standard that replaces this one, if status is superseded. Enables version tracking and historical compliance analysis.',
    `access_standard_status` STRING COMMENT 'Current lifecycle status of the access standard: active (in force and monitored), inactive (no longer enforced), draft (under development), pending_approval (awaiting regulatory or executive approval), superseded (replaced by a newer version).. Valid values are `active|inactive|draft|pending_approval|superseded`',
    `after_hours_availability_required_flag` BOOLEAN COMMENT 'Indicates whether providers must offer after-hours (evening, weekend, or holiday) appointment availability to meet this access standard. True for urgent care, behavioral health crisis, and certain primary care standards; false for routine specialty care.',
    `appointment_type_scope` STRING COMMENT 'Defines whether this access standard applies to new patient appointments, established patient follow-ups, specialist consultations, or all appointment types. New patient access is typically more stringent than follow-up access.. Valid values are `new_patient|established_patient|follow_up|consultation|all`',
    `compliance_measurement_method` STRING COMMENT 'The method used to measure and audit compliance with this access standard: appointment_log_audit (review of provider scheduling systems), member_survey (CAHPS or custom surveys), secret_shopper (test calls to provider offices), provider_attestation (self-reported compliance), claims_analysis (time between referral and service date in claims data).. Valid values are `appointment_log_audit|member_survey|secret_shopper|provider_attestation|claims_analysis`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this access standard record was first created in the system.',
    `effective_date` DATE COMMENT 'The date on which this access standard becomes enforceable. Aligns with regulatory effective dates, contract year start, or accreditation cycle.',
    `exception_criteria` STRING COMMENT 'Conditions under which this access standard may be waived or modified (e.g., rural service area with documented provider shortage, member preference for delayed appointment, specialist unavailability due to leave). Used for compliance reporting and grievance resolution.',
    `internal_notes` STRING COMMENT 'Free-text field for operational notes, implementation guidance, or context for network management and compliance teams. Not disclosed to members or regulators.',
    `last_updated_by` STRING COMMENT 'The user ID or system account that last modified this access standard record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this access standard record was most recently modified.',
    `line_of_business_applicability` STRING COMMENT 'Comma-separated list of lines of business to which this access standard applies (e.g., Commercial, Medicare Advantage, Medicaid, Exchange/QHP). Some standards are federally mandated for Medicare/Medicaid; others are state-specific or voluntary for commercial plans.',
    `maximum_wait_time_days` STRING COMMENT 'The maximum number of calendar days allowed between the members request for an appointment and the scheduled appointment date. For urgent care, this is typically 1-2 days; for routine care, 7-30 days depending on specialty and regulatory requirements.',
    `maximum_wait_time_hours` STRING COMMENT 'For emergent or crisis access standards, the maximum number of hours allowed for appointment availability (e.g., behavioral health crisis must be seen within 6 hours). Null for standards measured in days.',
    `member_age_group` STRING COMMENT 'The member age cohort to which this access standard applies: pediatric (under 18), adult (18-64), geriatric (65+), or all. Pediatric and geriatric populations often have stricter access requirements.. Valid values are `pediatric|adult|geriatric|all`',
    `monitoring_frequency` STRING COMMENT 'How often compliance with this access standard is measured and reported: monthly (for high-risk or CMS-mandated standards), quarterly (typical for HEDIS and accreditation), semi_annual, annual (for internal benchmarks), or continuous (real-time monitoring via appointment systems).. Valid values are `monthly|quarterly|semi_annual|annual|continuous`',
    `network_adequacy_credit_flag` BOOLEAN COMMENT 'Indicates whether meeting this access standard contributes to network adequacy compliance calculations for regulatory filings. True for standards tied to CMS or state DOI network adequacy requirements; false for internal quality benchmarks.',
    `penalty_for_noncompliance` STRING COMMENT 'Description of the consequences for failing to meet this access standard: regulatory sanctions, accreditation downgrade, member grievance escalation, provider contract breach, financial penalties, or corrective action plan requirements.',
    `regulatory_citation` STRING COMMENT 'Specific regulatory or accreditation standard citation (e.g., 42 CFR 438.206, NCQA HEDIS AAP measure, State Insurance Code Section 1367.03). Provides traceability to the authoritative source.',
    `regulatory_source` STRING COMMENT 'The governing body or accreditation organization that mandates or recommends this access standard: NCQA (National Committee for Quality Assurance), URAC (health care accreditation), CMS (Centers for Medicare and Medicaid Services), state_doi (State Department of Insurance), aca (Affordable Care Act QHP standards), internal (health plans own standards exceeding regulatory minimums), joint_commission (for facility-based care). [ENUM-REF-CANDIDATE: ncqa|urac|cms|state_doi|aca|internal|joint_commission — 7 candidates stripped; promote to reference product]',
    `specialty_category` STRING COMMENT 'The provider specialty or service category to which this access standard applies (e.g., Primary Care, Cardiology, Orthopedics, Behavioral Health, Obstetrics). May be null for standards that apply across all specialties.',
    `standard_code` STRING COMMENT 'Business identifier code for the access standard, used for external reference and reporting (e.g., ROUTINE_PCP, URGENT_SPEC, BH_CRISIS).. Valid values are `^[A-Z0-9_]{3,20}$`',
    `standard_name` STRING COMMENT 'Human-readable name of the access standard (e.g., Routine Primary Care Appointment, Urgent Specialty Care, Behavioral Health Crisis Access).',
    `standard_type` STRING COMMENT 'Classification of the access standard by care urgency and category: routine (non-urgent scheduled care), urgent (same-day or next-day need), emergent (immediate life-threatening), preventive (wellness and screening), behavioral_health (mental health and substance use), specialty (specialist consultation).. Valid values are `routine|urgent|emergent|preventive|behavioral_health|specialty`',
    `telehealth_equivalency_flag` BOOLEAN COMMENT 'Indicates whether telehealth (virtual) appointments satisfy this access standard in lieu of in-person visits. True for most routine and behavioral health standards post-COVID; may be false for certain procedures requiring physical examination.',
    `termination_date` DATE COMMENT 'The date on which this access standard is no longer in effect, either due to regulatory change, standard revision, or plan policy update. Null for currently active standards.',
    `created_by` STRING COMMENT 'The user ID or system account that created this access standard record.',
    CONSTRAINT pk_access_standard PRIMARY KEY(`access_standard_id`)
) COMMENT 'Reference entity defining appointment access and availability standards for the network — capturing standard type (routine, urgent, preventive, behavioral health), specialty category, maximum wait time in days, after-hours availability requirement, telehealth equivalency flag, and the regulatory or accreditation source (NCQA, URAC, state DOI, CMS). Distinct from adequacy_standard (which governs time-distance and provider-to-member ratios) — access_standard governs appointment availability and wait time compliance.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`network`.`vbc_program` (
    `vbc_program_id` BIGINT COMMENT 'Unique identifier for the value-based care program. Primary key.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: VBC programs (MSSP, CPC+, ACO REACH) are defined by CMS regulatory frameworks. vbc_program.regulatory_filing_reference and cms_program_identifier reference specific obligations. Program-level complian',
    `attribution_methodology` STRING COMMENT 'The method used to assign members or patients to providers or ACOs for performance measurement and accountability.. Valid values are `Prospective|Retrospective|Voluntary Alignment|Claims-Based|Hybrid`',
    `benchmark_methodology` STRING COMMENT 'The method used to calculate the cost or quality benchmark against which performance is measured. PMPM = Per Member Per Month.. Valid values are `Historical Trend|Regional Average|National Average|Risk-Adjusted PMPM|Episode-Based`',
    `benchmark_year` STRING COMMENT 'The base year or period used to establish the performance benchmark for this program.',
    `care_coordination_required_flag` BOOLEAN COMMENT 'Indicates whether participating providers must implement formal care coordination programs as a condition of participation.',
    `cms_program_identifier` STRING COMMENT 'The official CMS-assigned identifier for this VBC program, used for regulatory reporting and tracking. CMS = Centers for Medicare and Medicaid Services.',
    `contact_email` STRING COMMENT 'Primary email address for inquiries and communications regarding this VBC program.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this VBC program record was first created in the system.',
    `effective_date` DATE COMMENT 'The date when this VBC program design becomes active and available for provider participation.',
    `eligible_provider_types` STRING COMMENT 'Comma-separated list of provider types eligible to participate in this VBC program (e.g., PCP, Specialist, Hospital, SNF). PCP = Primary Care Provider, SNF = Skilled Nursing Facility.',
    `health_it_requirement` STRING COMMENT 'Description of health IT capabilities required for participation (e.g., EHR certification, HIE connectivity, data reporting). EHR = Electronic Health Record, HIE = Health Information Exchange.',
    `internal_notes` STRING COMMENT 'Free-text field for internal operational notes, special considerations, or program-specific guidance.',
    `last_updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this VBC program record was most recently modified.',
    `line_of_business` STRING COMMENT 'The insurance product line or market segment to which this VBC program applies. LOB = Line of Business.. Valid values are `Medicare|Medicaid|Commercial|Exchange|Dual Eligible|Medicare Advantage`',
    `minimum_loss_rate` DECIMAL(18,2) COMMENT 'The minimum percentage loss threshold that must be exceeded before shared losses are assessed. MLR = Minimum Loss Rate. Distinct from Medical Loss Ratio.',
    `minimum_member_threshold` STRING COMMENT 'The minimum number of attributed members required for a provider or ACO to participate in or qualify for this VBC program.',
    `minimum_savings_rate` DECIMAL(18,2) COMMENT 'The minimum percentage savings threshold that must be achieved before shared savings are paid. MSR = Minimum Savings Rate.',
    `performance_period_end_date` DATE COMMENT 'The date when the performance measurement period for this VBC program ends.',
    `performance_period_start_date` DATE COMMENT 'The date when the performance measurement period for this VBC program begins.',
    `program_category` STRING COMMENT 'Broad category of value-based arrangement that this program represents. ACO = Accountable Care Organization.. Valid values are `ACO|Bundled Payment|Shared Savings|Pay for Performance|Capitation|Population Health`',
    `program_code` STRING COMMENT 'Unique business identifier code for the VBC program used across systems and external reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `program_description` STRING COMMENT 'Detailed narrative description of the VBC program objectives, structure, and key features.',
    `program_name` STRING COMMENT 'Full business name of the value-based care program.',
    `program_owner` STRING COMMENT 'The internal business unit or department responsible for managing and administering this VBC program.',
    `program_status` STRING COMMENT 'Current operational status of the VBC program.. Valid values are `Active|Inactive|Pending Approval|Suspended|Terminated|Pilot`',
    `program_type` STRING COMMENT 'Classification of the VBC program model. MSSP = Medicare Shared Savings Program, REACH = Realizing Equity Access and Community Health, NextGen = Next Generation ACO, P4P = Pay for Performance.. Valid values are `MSSP|REACH|NextGen|Commercial P4P|Episode-Based|Capitation`',
    `program_url` STRING COMMENT 'Web address for the program information page, provider portal, or documentation site.',
    `program_year` STRING COMMENT 'The calendar or performance year for which this VBC program design is configured.',
    `quality_measure_set` STRING COMMENT 'The standardized set of quality measures used to evaluate performance (e.g., HEDIS, STAR, CMS Quality Measures). HEDIS = Healthcare Effectiveness Data and Information Set.',
    `quality_performance_threshold` DECIMAL(18,2) COMMENT 'The minimum quality score threshold required to qualify for shared savings or incentive payments, expressed as a percentage.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier for the regulatory filing or approval associated with this VBC program.',
    `risk_model` STRING COMMENT 'The financial risk arrangement structure. Upside Only = shared savings only, Two-Sided = shared savings and losses, Downside Only = shared losses only.. Valid values are `Upside Only|Two-Sided|Downside Only|Capitation|Blended`',
    `settlement_frequency` STRING COMMENT 'How often financial reconciliation and shared savings/loss settlements are calculated and paid.. Valid values are `Annual|Semi-Annual|Quarterly|Monthly`',
    `shared_loss_rate` DECIMAL(18,2) COMMENT 'The percentage of losses above benchmark that is shared with participating providers, expressed as a percentage. Null for upside-only models.',
    `shared_savings_rate` DECIMAL(18,2) COMMENT 'The percentage of savings below benchmark that is shared with participating providers, expressed as a percentage (e.g., 50.00 for 50%).',
    `sponsoring_entity` STRING COMMENT 'The organization or regulatory body that sponsors and governs this VBC program. CMS = Centers for Medicare and Medicaid Services.. Valid values are `CMS|State Medicaid|Commercial|Self-Insured Employer|Multi-Payer`',
    `termination_date` DATE COMMENT 'The date when this VBC program design is terminated or discontinued. Null for active programs.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this record.',
    CONSTRAINT pk_vbc_program PRIMARY KEY(`vbc_program_id`)
) COMMENT 'Master entity representing a Value-Based Care (VBC) program design — the template or program structure under which ACO arrangements, pay-for-performance contracts, and shared savings models are organized. Captures program name, program type (MSSP, REACH, commercial P4P, episode-based payment, capitation), sponsoring entity (CMS, state Medicaid, commercial), program year, quality measure set, risk model (upside-only, two-sided), and benchmark methodology. Distinct from aco_arrangement (which is a specific participation instance) — vbc_program is the program definition.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`network`.`par_agreement` (
    `par_agreement_id` BIGINT COMMENT 'System-generated unique identifier for the provider participation agreement.',
    `baa_id` BIGINT COMMENT 'Foreign key linking to compliance.baa. Business justification: Provider participation agreements with providers who handle PHI require a Business Associate Agreement under HIPAA. Compliance officers must verify a valid BAA exists before or concurrent with executi',
    `benefit_package_id` BIGINT COMMENT 'Foreign key linking to plan.benefit_package. Business justification: Provider participation agreements specify which benefit packages a provider participates in — a provider may accept the PPO benefit package but not the HMO package. Claims adjudication and member cost',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.fee_schedule. Business justification: A PAR agreement governs the specific fee schedule applicable to a participating provider. Claims adjudication systems look up the fee schedule directly from the PAR agreement record. par_agreement lin',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: PAR agreements are executed at the group practice (TIN) level, not only at the individual provider level. Contract management and credentialing operations require linking PAR agreements to the group p',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan associated with the agreement, if plan‑specific.',
    `network_provider_id` BIGINT COMMENT 'Foreign key linking to network.network_provider. Business justification: par_agreement is the formal participation agreement that governs a providers network participation. network_provider is the association entity representing the actual participation of a provider with',
    `parent_par_agreement_id` BIGINT COMMENT 'Self-referencing FK on par_agreement (parent_par_agreement_id)',
    `provider_contract_id` BIGINT COMMENT 'Foreign key linking to contract.provider_contract. Business justification: PAR agreements are executed under a specific provider contract; linking enables contract‑level reporting and compliance tracking.',
    `provider_network_id` BIGINT COMMENT 'Identifier of the provider network to which the agreement applies.',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: par_agreement has a provider_tier_assignment STRING column that captures the tier assigned to the provider under this participation agreement. The tier table is the authoritative reference for tier de',
    `agreement_number` STRING COMMENT 'External reference number assigned to the agreement by the health plan.',
    `agreement_scope_description` STRING COMMENT 'Narrative description of the services, specialties, and geographic areas covered.',
    `agreement_type` STRING COMMENT 'Classifies the agreement as individual provider, group practice, or other entity.. Valid values are `individual|group|entity`',
    `agreement_version` STRING COMMENT 'Version identifier for the agreement document (e.g., v1, v2).',
    `amendment_effective_date` DATE COMMENT 'Date the amendment becomes effective.',
    `amendment_flag` BOOLEAN COMMENT 'Indicates whether this record represents an amendment to a prior agreement.',
    `amendment_number` STRING COMMENT 'Identifier for the amendment (e.g., A1, A2).',
    `amendment_termination_date` DATE COMMENT 'Date the amendment expires, if different from the base agreement.',
    `compliance_status_flag` STRING COMMENT 'Indicates whether the agreement meets all applicable regulatory requirements.. Valid values are `compliant|non_compliant|pending`',
    `contract_reference_number` STRING COMMENT 'Reference to the broader provider contract that governs reimbursement terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `effective_date` DATE COMMENT 'Date the agreement becomes binding and in‑force.',
    `electronic_signature_flag` BOOLEAN COMMENT 'True if the agreement was signed electronically.',
    `last_updated_by` STRING COMMENT 'User or system that performed the most recent update.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the agreement.',
    `paper_signature_flag` BOOLEAN COMMENT 'True if the agreement was signed on paper.',
    `par_agreement_status` STRING COMMENT 'Current lifecycle status of the agreement.. Valid values are `active|inactive|terminated|pending|draft`',
    `provider_credentialing_date` DATE COMMENT 'Date the provider completed credentialing for the network.',
    `provider_credentialing_status` STRING COMMENT 'Credentialing state of the provider for network participation.. Valid values are `credentialed|pending|revoked`',
    `provider_directory_last_verified_date` DATE COMMENT 'Date the providers directory information was last verified.',
    `provider_directory_listing_flag` BOOLEAN COMMENT 'Indicates whether the provider is listed in the public network directory.',
    `provider_network_status` STRING COMMENT 'Current network participation status of the provider.. Valid values are `in_network|out_of_network|pending`',
    `provider_participation_role` STRING COMMENT 'Role of the provider within the network (e.g., primary care, specialist).. Valid values are `primary_care|specialist|both|other`',
    `provider_recredentialing_due_date` DATE COMMENT 'Next scheduled date for provider re‑credentialing.',
    `regulatory_approval_date` DATE COMMENT 'Date the agreement received regulatory approval, if required.',
    `regulatory_filing_reference` STRING COMMENT 'Reference number for any required regulatory filing (e.g., CMS network adequacy filing).',
    `renewal_date` DATE COMMENT 'Planned date for renewal of the agreement, if applicable.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement is set for automatic renewal.',
    `signature_date` DATE COMMENT 'Date the agreement was signed by the provider.',
    `signed_by_name` STRING COMMENT 'Legal name of the individual who signed the agreement on behalf of the provider.',
    `signed_by_npi` STRING COMMENT 'National Provider Identifier of the signing individual.',
    `signed_by_title` STRING COMMENT 'Job title or role of the signing individual.',
    `termination_date` DATE COMMENT 'Date the agreement ends, either by expiration or early termination.',
    `termination_reason_code` STRING COMMENT 'Standardized code describing why the agreement was terminated.',
    `termination_reason_description` STRING COMMENT 'Free‑text description of the termination reason.',
    `created_by` STRING COMMENT 'User or system that created the agreement record.',
    CONSTRAINT pk_par_agreement PRIMARY KEY(`par_agreement_id`)
) COMMENT 'Provider participation agreement record — the formal agreement a provider signs to participate in a network. Captures agreement type (individual, group), signature date, effective date, termination provisions, and agreement version. Distinct from the broader provider_contract which covers reimbursement terms.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ADD CONSTRAINT `fk_network_tier_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ADD CONSTRAINT `fk_network_network_provider_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ADD CONSTRAINT `fk_network_network_provider_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ADD CONSTRAINT `fk_network_network_service_area_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_access_standard_id` FOREIGN KEY (`access_standard_id`) REFERENCES `health_insurance_ecm`.`network`.`access_standard`(`access_standard_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_adequacy_standard_id` FOREIGN KEY (`adequacy_standard_id`) REFERENCES `health_insurance_ecm`.`network`.`adequacy_standard`(`adequacy_standard_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_adequacy_assessment_id` FOREIGN KEY (`adequacy_assessment_id`) REFERENCES `health_insurance_ecm`.`network`.`adequacy_assessment`(`adequacy_assessment_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_adequacy_standard_id` FOREIGN KEY (`adequacy_standard_id`) REFERENCES `health_insurance_ecm`.`network`.`adequacy_standard`(`adequacy_standard_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_network_provider_id` FOREIGN KEY (`network_provider_id`) REFERENCES `health_insurance_ecm`.`network`.`network_provider`(`network_provider_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ADD CONSTRAINT `fk_network_vbc_arrangement_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ADD CONSTRAINT `fk_network_vbc_arrangement_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ADD CONSTRAINT `fk_network_vbc_arrangement_vbc_program_id` FOREIGN KEY (`vbc_program_id`) REFERENCES `health_insurance_ecm`.`network`.`vbc_program`(`vbc_program_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_adequacy_assessment_id` FOREIGN KEY (`adequacy_assessment_id`) REFERENCES `health_insurance_ecm`.`network`.`adequacy_assessment`(`adequacy_assessment_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_adequacy_gap_id` FOREIGN KEY (`adequacy_gap_id`) REFERENCES `health_insurance_ecm`.`network`.`adequacy_gap`(`adequacy_gap_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_adequacy_standard_id` FOREIGN KEY (`adequacy_standard_id`) REFERENCES `health_insurance_ecm`.`network`.`adequacy_standard`(`adequacy_standard_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `health_insurance_ecm`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ADD CONSTRAINT `fk_network_access_standard_superseded_by_standard_access_standard_id` FOREIGN KEY (`superseded_by_standard_access_standard_id`) REFERENCES `health_insurance_ecm`.`network`.`access_standard`(`access_standard_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_network_provider_id` FOREIGN KEY (`network_provider_id`) REFERENCES `health_insurance_ecm`.`network`.`network_provider`(`network_provider_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_parent_par_agreement_id` FOREIGN KEY (`parent_par_agreement_id`) REFERENCES `health_insurance_ecm`.`network`.`par_agreement`(`par_agreement_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `health_insurance_ecm`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_tier_id` FOREIGN KEY (`tier_id`) REFERENCES `health_insurance_ecm`.`network`.`tier`(`tier_id`);

-- ========= TAGS =========
ALTER SCHEMA `health_insurance_ecm`.`network` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `health_insurance_ecm`.`network` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` SET TAGS ('dbx_subdomain' = 'network_structure');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `aco_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Participation Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `cms_network_code` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Network Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `cms_network_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{5}$');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Network Effective Date');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `facility_count` SET TAGS ('dbx_business_glossary_term' = 'Facility Count');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_business_glossary_term' = 'Geographic Footprint');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `last_adequacy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Network Adequacy Review Date');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'Commercial|Medicare|Medicaid|Exchange|ASO');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `member_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Count');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `network_adequacy_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Filing Date');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Status');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_value_regex' = 'Adequate|Deficient|Conditional|Pending Review');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `network_code` SET TAGS ('dbx_business_glossary_term' = 'Network Code');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `network_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `network_description` SET TAGS ('dbx_business_glossary_term' = 'Network Description');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `network_directory_url` SET TAGS ('dbx_business_glossary_term' = 'Network Provider Directory Uniform Resource Locator (URL)');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `network_directory_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('dbx_business_glossary_term' = 'Network Name');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Pending|Terminated');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = 'HMO|PPO|EPO|POS|HDHP|ACO');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `next_adequacy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Network Adequacy Review Date');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `out_of_network_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Network Coverage Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `pcp_count` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Count');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `pcp_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `provider_count` SET TAGS ('dbx_business_glossary_term' = 'Provider Count');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `service_area_type` SET TAGS ('dbx_business_glossary_term' = 'Service Area Type');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `service_area_type` SET TAGS ('dbx_value_regex' = 'Statewide|Regional|County|ZIP|National');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `specialist_count` SET TAGS ('dbx_business_glossary_term' = 'Specialist Physician Count');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `star_rating` SET TAGS ('dbx_business_glossary_term' = 'Star Rating');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Network Termination Date');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Network Tier Classification');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `tier_classification` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Single Tier|Tiered');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `vbc_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Care (VBC) Arrangement Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_network` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` SET TAGS ('dbx_subdomain' = 'network_structure');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Network Tier Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `coinsurance_differential_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Differential Percentage');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `copay_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Differential Amount');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `cost_share_differential_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Differential Type');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `cost_share_differential_type` SET TAGS ('dbx_value_regex' = 'copay|coinsurance|deductible|hybrid|none');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `deductible_applies_flag` SET TAGS ('dbx_business_glossary_term' = 'Deductible Applies Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `display_label` SET TAGS ('dbx_business_glossary_term' = 'Tier Display Label');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `facility_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Facility Type Applicability');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `member_steerage_incentive_description` SET TAGS ('dbx_business_glossary_term' = 'Member Steerage Incentive Description');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `network_adequacy_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Credit Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `oop_max_applies_flag` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket (OOP) Maximum Applies Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `quality_tier_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Tier Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `sbc_disclosure_text` SET TAGS ('dbx_business_glossary_term' = 'Summary of Benefits and Coverage (SBC) Disclosure Text');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `specialty_applicability` SET TAGS ('dbx_business_glossary_term' = 'Specialty Applicability');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Code');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `tier_rank` SET TAGS ('dbx_business_glossary_term' = 'Tier Rank');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Status');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|retired');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `tier_type` SET TAGS ('dbx_business_glossary_term' = 'Tier Type');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `tier_type` SET TAGS ('dbx_value_regex' = 'preferred|standard|specialty|out_of_network|value_based|narrow_network');
ALTER TABLE `health_insurance_ecm`.`network`.`tier` ALTER COLUMN `vbc_arrangement_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Care (VBC) Arrangement Eligible Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` SET TAGS ('dbx_subdomain' = 'network_structure');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `network_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Network Provider ID');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `accessibility_ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `aco_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Participant Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `after_hours_availability_flag` SET TAGS ('dbx_business_glossary_term' = 'After Hours Availability Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `continuity_of_care_end_date` SET TAGS ('dbx_business_glossary_term' = 'Continuity of Care End Date');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `credentialing_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Date');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'credentialed|pending|expired|suspended|revoked');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `current_panel_size` SET TAGS ('dbx_business_glossary_term' = 'Current Panel Size');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `directory_last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Directory Last Verified Date');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `directory_listing_flag` SET TAGS ('dbx_business_glossary_term' = 'Directory Listing Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Service Area');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `in_network_flag` SET TAGS ('dbx_business_glossary_term' = 'In-Network Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `language_services_available` SET TAGS ('dbx_business_glossary_term' = 'Language Services Available');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `network_adequacy_category` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Category');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `network_adequacy_category` SET TAGS ('dbx_value_regex' = 'essential|standard|enhanced|specialty');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `network_participation_type` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Type');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `network_participation_type` SET TAGS ('dbx_value_regex' = 'par|non_par|out_of_network');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `panel_capacity` SET TAGS ('dbx_business_glossary_term' = 'Panel Capacity');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `panel_status` SET TAGS ('dbx_business_glossary_term' = 'Panel Status');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `panel_status` SET TAGS ('dbx_value_regex' = 'open|closed|limited|full');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `pcp_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider (PCP) Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `quality_tier_designation` SET TAGS ('dbx_business_glossary_term' = 'Quality Tier Designation');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `quality_tier_designation` SET TAGS ('dbx_value_regex' = 'high_quality|standard_quality|low_quality|not_rated');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `recredentialing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recredentialing Due Date');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `risk_sharing_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Sharing Arrangement Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `specialist_flag` SET TAGS ('dbx_business_glossary_term' = 'Specialist Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `telehealth_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Available Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `termination_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Termination Initiated By');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `termination_initiated_by` SET TAGS ('dbx_value_regex' = 'provider|health_plan|mutual|regulatory');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `vbc_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Care (VBC) Participant Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_provider` ALTER COLUMN `weekend_availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Weekend Availability Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` SET TAGS ('dbx_subdomain' = 'network_structure');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `plan_association_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Association Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Product Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `aco_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Accountable Care Organization (ACO) Participation Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `adequacy_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Certification Date');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `adequacy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Review Date');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `association_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Association Code');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `association_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `association_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Association Name');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `association_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Association Type');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `association_type` SET TAGS ('dbx_value_regex' = 'primary|supplemental|specialty|out_of_area|reciprocal|tertiary');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `auto_assignment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Assignment Eligible Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,30}$');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `directory_publication_flag` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory Publication Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Association Effective Date');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|marketplace|dual_eligible|chip');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'individual|small_group|large_group|jumbo_group|government|student');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Status');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|exempt|conditional');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Association Notes');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `out_of_network_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Network Coverage Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `pcp_selection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Provider (PCP) Selection Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `plan_association_status` SET TAGS ('dbx_business_glossary_term' = 'Association Status');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `plan_association_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Network Priority Rank');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `provider_count` SET TAGS ('dbx_business_glossary_term' = 'Provider Count');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `star_rating_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Star Rating Impact Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Association Termination Date');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `vbc_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Care (VBC) Arrangement Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`plan_association` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` SET TAGS ('dbx_subdomain' = 'network_structure');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area ID');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `cms_service_area_code` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Service Area ID');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `cms_service_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `commercial_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Approved Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_business_glossary_term' = 'County Federal Information Processing Standards (FIPS) Code');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `county_name` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `geographic_boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary Description');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `medicaid_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Approved Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `medicare_advantage_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicare Advantage Approved Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `member_residency_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Member Residency Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `msa_code` SET TAGS ('dbx_business_glossary_term' = 'Metropolitan Statistical Area (MSA) Code');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `msa_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `msa_name` SET TAGS ('dbx_business_glossary_term' = 'Metropolitan Statistical Area (MSA) Name');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `network_adequacy_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Approval Date');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `network_adequacy_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Filing Date');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Status');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|waiver_granted|not_applicable');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `network_service_area_status` SET TAGS ('dbx_business_glossary_term' = 'Service Area Status');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `network_service_area_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|suspended|terminated');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Service Area Notes');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `out_of_area_coverage_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Area Coverage Allowed Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `population_count` SET TAGS ('dbx_business_glossary_term' = 'Population Count');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `qhp_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Qualified Health Plan (QHP) Approved Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `service_area_code` SET TAGS ('dbx_business_glossary_term' = 'Service Area Code');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `service_area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `service_area_name` SET TAGS ('dbx_business_glossary_term' = 'Service Area Name');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `service_area_type` SET TAGS ('dbx_business_glossary_term' = 'Service Area Type');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `service_area_type` SET TAGS ('dbx_value_regex' = 'county_based|zip_based|msa_based|state_based|custom_boundary|multi_state');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `urban_rural_designation` SET TAGS ('dbx_business_glossary_term' = 'Urban Rural Designation');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `urban_rural_designation` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|frontier|mixed');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `zip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`network_service_area` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` SET TAGS ('dbx_subdomain' = 'adequacy_compliance');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `adequacy_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Standard Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `adequacy_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Standard Status');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `adequacy_standard_status` SET TAGS ('dbx_value_regex' = 'active|inactive|proposed|superseded|under-review');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `after_hours_availability_required` SET TAGS ('dbx_business_glossary_term' = 'After Hours Availability Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `after_hours_definition` SET TAGS ('dbx_business_glossary_term' = 'After Hours Definition');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `appointment_type` SET TAGS ('dbx_value_regex' = 'routine|urgent|preventive|behavioral-health|specialist|emergency');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `compliance_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reporting Frequency');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `compliance_reporting_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi-annual|quarterly|monthly|on-demand');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `exception_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exception Criteria');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `geographic_classification` SET TAGS ('dbx_business_glossary_term' = 'Geographic Classification');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `geographic_classification` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|frontier');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'medicare-advantage|medicaid|commercial|marketplace|dual-eligible|all');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `maximum_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Maximum Distance in Miles');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `maximum_travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Travel Time in Minutes');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `maximum_wait_time_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Wait Time in Days');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `minimum_provider_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Provider Count');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Standard Notes');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'HMO|PPO|EPO|POS|HDHP|all');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `provider_to_member_ratio` SET TAGS ('dbx_business_glossary_term' = 'Provider to Member Ratio');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `regulatory_source` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Source');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `regulatory_source` SET TAGS ('dbx_value_regex' = 'CMS|state-DOI|NCQA|URAC|ACA|internal');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `service_area_type` SET TAGS ('dbx_business_glossary_term' = 'Service Area Type');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `service_area_type` SET TAGS ('dbx_value_regex' = 'county|zip|state|region|national');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `specialty_category` SET TAGS ('dbx_business_glossary_term' = 'Specialty Category');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `standard_category` SET TAGS ('dbx_business_glossary_term' = 'Standard Category');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `standard_category` SET TAGS ('dbx_value_regex' = 'time-distance|provider-ratio|appointment-access|after-hours|telehealth-equivalency|network-composition');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Code');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `standard_name` SET TAGS ('dbx_business_glossary_term' = 'Standard Name');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `standard_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Version');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `telehealth_equivalency_allowed` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Equivalency Allowed Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `telehealth_percentage_cap` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Percentage Cap');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_standard` ALTER COLUMN `threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Threshold Percentage');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` SET TAGS ('dbx_subdomain' = 'adequacy_compliance');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `adequacy_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Assessment ID');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `access_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Access Standard Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `adequacy_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Standard Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area ID');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `appointment_type_requested` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Requested');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `appointment_type_requested` SET TAGS ('dbx_value_regex' = 'routine|urgent|preventive|follow-up|new-patient|specialist-referral');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period End Date');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period Start Date');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'adequacy|access-survey|mystery-shopper|gap-analysis|time-distance|appointment-availability');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `assessor_organization` SET TAGS ('dbx_business_glossary_term' = 'Assessor Organization');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `compliance_outcome` SET TAGS ('dbx_business_glossary_term' = 'Compliance Outcome');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `compliance_outcome` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|partially-compliant|under-review|remediation-required');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `gap_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Gap Identified Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `gap_severity` SET TAGS ('dbx_business_glossary_term' = 'Gap Severity');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `gap_severity` SET TAGS ('dbx_value_regex' = 'critical|high|moderate|low');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `member_to_provider_ratio` SET TAGS ('dbx_business_glossary_term' = 'Member to Provider Ratio');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `provider_count_available` SET TAGS ('dbx_business_glossary_term' = 'Provider Count Available');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `provider_count_required` SET TAGS ('dbx_business_glossary_term' = 'Provider Count Required');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Type');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_value_regex' = 'cms-medicare|cms-marketplace|state-doi|ncqa|internal|aca-qhp');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Taken');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not-started|in-progress|completed|verified|overdue');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `specialty_type` SET TAGS ('dbx_business_glossary_term' = 'Specialty Type');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|resubmission-required');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'member-survey|secret-shopper-call|provider-survey|administrative-data|geospatial-analysis');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `telehealth_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Offered Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `time_distance_compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Time Distance Compliance Percentage');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `time_distance_standard_miles` SET TAGS ('dbx_business_glossary_term' = 'Time Distance Standard Miles');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `time_distance_standard_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time Distance Standard Minutes');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `wait_time_days_routine` SET TAGS ('dbx_business_glossary_term' = 'Wait Time Days Routine');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_assessment` ALTER COLUMN `wait_time_days_urgent` SET TAGS ('dbx_business_glossary_term' = 'Wait Time Days Urgent');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` SET TAGS ('dbx_subdomain' = 'adequacy_compliance');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `adequacy_gap_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Gap Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `adequacy_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `adequacy_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Standard Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `affected_member_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Member Count');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `available_provider_count` SET TAGS ('dbx_business_glossary_term' = 'Available Provider Count');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `exception_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Approval Date');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `exception_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Expiration Date');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `exception_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Granted Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `exception_justification` SET TAGS ('dbx_business_glossary_term' = 'Exception Justification');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `exception_request_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Request Date');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `exception_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Requested Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `gap_magnitude` SET TAGS ('dbx_business_glossary_term' = 'Gap Magnitude');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `gap_number` SET TAGS ('dbx_business_glossary_term' = 'Gap Number');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `gap_severity` SET TAGS ('dbx_business_glossary_term' = 'Gap Severity');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `gap_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `gap_status` SET TAGS ('dbx_business_glossary_term' = 'Gap Status');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `gap_status` SET TAGS ('dbx_value_regex' = 'identified|remediation_in_progress|resolved|exception_granted|waived');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_business_glossary_term' = 'Gap Type');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_value_regex' = 'specialty|facility|geographic|time_distance|appointment_wait_time|essential_community_provider');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `geographic_area_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area Code');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `geographic_area_name` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area Name');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `geographic_area_type` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area Type');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `geographic_area_type` SET TAGS ('dbx_value_regex' = 'county|zip_code|cbsa|service_area|custom_region');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'commercial|medicare_advantage|medicaid|marketplace|dual_eligible');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `remediation_owner` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `required_provider_count` SET TAGS ('dbx_business_glossary_term' = 'Required Provider Count');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Specialty Code');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `specialty_name` SET TAGS ('dbx_business_glossary_term' = 'Specialty Name');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `standard_threshold` SET TAGS ('dbx_business_glossary_term' = 'Standard Threshold');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `standard_type` SET TAGS ('dbx_business_glossary_term' = 'Standard Type');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `standard_type` SET TAGS ('dbx_value_regex' = 'time_distance|provider_to_member_ratio|appointment_availability|essential_community_provider_percentage');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `health_insurance_ecm`.`network`.`adequacy_gap` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` SET TAGS ('dbx_subdomain' = 'provider_access');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `provider_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory ID');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `network_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Network Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `accessibility_features` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Features');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliant Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `board_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Status');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `board_certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|eligible|unknown');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `directory_publication_channel` SET TAGS ('dbx_business_glossary_term' = 'Directory Publication Channel');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `directory_publication_channel` SET TAGS ('dbx_value_regex' = 'online|print|api|mobile_app|call_center');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `directory_status` SET TAGS ('dbx_business_glossary_term' = 'Directory Status');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `directory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_verification|suspended');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `fax_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Provider Gender');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non-binary|other|unknown');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `hospital_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Hospital Affiliation');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `last_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Method');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `last_verification_method` SET TAGS ('dbx_value_regex' = 'outbound_call|online_attestation|ehr_data_match|claims_inference|mail_survey|email_confirmation');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `last_verification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Outcome');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `last_verification_outcome` SET TAGS ('dbx_value_regex' = 'confirmed|updated|unable_to_reach|provider_declined|no_response');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `next_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `practice_location_name` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Name');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `specialty_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Specialty');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `specialty_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Specialty');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `telehealth_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Available Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `verified_fields` SET TAGS ('dbx_business_glossary_term' = 'Verified Fields');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `verifying_agent` SET TAGS ('dbx_business_glossary_term' = 'Verifying Agent');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `zip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`provider_directory` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` SET TAGS ('dbx_subdomain' = 'value_care');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `vbc_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Arrangement Identifier');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Network Service Area Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `vbc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Program Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Name');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Number');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Status');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|completed');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Type');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `attributed_member_count` SET TAGS ('dbx_business_glossary_term' = 'Attributed Member Count');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `attribution_methodology` SET TAGS ('dbx_business_glossary_term' = 'Attribution Methodology');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `attribution_methodology` SET TAGS ('dbx_value_regex' = 'prospective|retrospective|voluntary_alignment|claims_based');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `benchmark_amount` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Amount');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `benchmark_methodology` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Methodology');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `benchmark_methodology` SET TAGS ('dbx_value_regex' = 'historical_baseline|regional_average|national_trend|risk_adjusted_pmpm|episode_target_price');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `care_coordination_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Care Coordination Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `cms_aco_code` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) ACO ID');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `cms_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'CMS Reporting Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `data_sharing_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `health_it_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Information Technology (IT) Certification Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `health_it_certification_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `health_it_certification_required_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `minimum_loss_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Loss Rate (MLR)');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `minimum_savings_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Savings Rate (MSR)');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `participating_aco_name` SET TAGS ('dbx_business_glossary_term' = 'Participating ACO Name');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `participating_provider_count` SET TAGS ('dbx_business_glossary_term' = 'Participating Provider Count');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `performance_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Amount');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `performance_year` SET TAGS ('dbx_business_glossary_term' = 'Performance Year');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `primary_care_physician_count` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Count');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `quality_measure_set` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Set');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `quality_performance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Quality Performance Threshold');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|monthly');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `record_type` SET TAGS ('dbx_business_glossary_term' = 'Record Type');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `record_type` SET TAGS ('dbx_value_regex' = 'program_template|participation_instance');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `risk_model` SET TAGS ('dbx_business_glossary_term' = 'Risk Model');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `risk_model` SET TAGS ('dbx_value_regex' = 'one_sided_risk|two_sided_risk|upside_only|downside_risk|full_capitation');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `service_area_description` SET TAGS ('dbx_business_glossary_term' = 'Service Area Description');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `shared_loss_rate` SET TAGS ('dbx_business_glossary_term' = 'Shared Loss Rate');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `shared_savings_rate` SET TAGS ('dbx_business_glossary_term' = 'Shared Savings Rate');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `specialist_physician_count` SET TAGS ('dbx_business_glossary_term' = 'Specialist Physician Count');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `sponsoring_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Entity Name');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `stop_loss_limit` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Limit');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_arrangement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` SET TAGS ('dbx_subdomain' = 'adequacy_compliance');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `exception_id` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Exception ID');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `adequacy_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Assessment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `adequacy_gap_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Gap Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `adequacy_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Standard Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Appeal Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'CMS Plan Benefit Package (PBP) ID');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Network Service Area Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `affected_member_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Member Count');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `alternative_access_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Alternative Access Arrangement');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_value_regex' = 'upheld|overturned|pending');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Approval Date');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `approved_terms` SET TAGS ('dbx_business_glossary_term' = 'Approved Exception Terms');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `cms_contract_number` SET TAGS ('dbx_business_glossary_term' = 'CMS Contract Number');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `denial_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Denial Date');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Effective Date');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Filing Number');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'time_distance_waiver|rural_exception|access_plan|specialty_shortage|temporary_disruption|other');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Expiration Date');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Filing Date');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `geographic_description` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area Description');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated By User');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `lob` SET TAGS ('dbx_value_regex' = 'medicare_advantage|medicaid|commercial|marketplace|dual_eligible');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `member_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Date');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `member_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Access Mitigation Plan');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `provider_recruitment_effort` SET TAGS ('dbx_business_glossary_term' = 'Provider Recruitment Effort Description');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason Description');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Due Date');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialty Code');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `specialty_name` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialty Name');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `time_distance_standard_waived` SET TAGS ('dbx_business_glossary_term' = 'Time-Distance Standard Waived');
ALTER TABLE `health_insurance_ecm`.`network`.`exception` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` SET TAGS ('dbx_subdomain' = 'provider_access');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `access_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Access Standard Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `superseded_by_standard_access_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Access Standard Identifier (ID)');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `access_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Access Standard Status');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `access_standard_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|pending_approval|superseded');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `after_hours_availability_required_flag` SET TAGS ('dbx_business_glossary_term' = 'After-Hours Availability Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `appointment_type_scope` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Scope');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `appointment_type_scope` SET TAGS ('dbx_value_regex' = 'new_patient|established_patient|follow_up|consultation|all');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `compliance_measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Measurement Method');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `compliance_measurement_method` SET TAGS ('dbx_value_regex' = 'appointment_log_audit|member_survey|secret_shopper|provider_attestation|claims_analysis');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `exception_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exception Criteria');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `line_of_business_applicability` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB) Applicability');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `maximum_wait_time_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Wait Time in Days');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `maximum_wait_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Maximum Wait Time in Hours');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `member_age_group` SET TAGS ('dbx_business_glossary_term' = 'Member Age Group');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `member_age_group` SET TAGS ('dbx_value_regex' = 'pediatric|adult|geriatric|all');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|continuous');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `network_adequacy_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Credit Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `penalty_for_noncompliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Noncompliance');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `regulatory_source` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Source');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `specialty_category` SET TAGS ('dbx_business_glossary_term' = 'Specialty Category');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_business_glossary_term' = 'Access Standard Code');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `standard_name` SET TAGS ('dbx_business_glossary_term' = 'Access Standard Name');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `standard_type` SET TAGS ('dbx_business_glossary_term' = 'Access Standard Type');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `standard_type` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergent|preventive|behavioral_health|specialty');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `telehealth_equivalency_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Equivalency Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`network`.`access_standard` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` SET TAGS ('dbx_subdomain' = 'value_care');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `vbc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Care (VBC) Program ID');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `attribution_methodology` SET TAGS ('dbx_business_glossary_term' = 'Attribution Methodology');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `attribution_methodology` SET TAGS ('dbx_value_regex' = 'Prospective|Retrospective|Voluntary Alignment|Claims-Based|Hybrid');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `benchmark_methodology` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Methodology');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `benchmark_methodology` SET TAGS ('dbx_value_regex' = 'Historical Trend|Regional Average|National Average|Risk-Adjusted PMPM|Episode-Based');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `benchmark_year` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Year');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `care_coordination_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Care Coordination Required Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `cms_program_identifier` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Program Identifier');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Email');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `eligible_provider_types` SET TAGS ('dbx_business_glossary_term' = 'Eligible Provider Types');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `health_it_requirement` SET TAGS ('dbx_business_glossary_term' = 'Health Information Technology (IT) Requirement');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `health_it_requirement` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `health_it_requirement` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'Medicare|Medicaid|Commercial|Exchange|Dual Eligible|Medicare Advantage');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `minimum_loss_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Loss Rate (MLR)');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `minimum_member_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Member Threshold');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `minimum_savings_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Savings Rate (MSR)');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `performance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `performance_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'ACO|Bundled Payment|Shared Savings|Pay for Performance|Capitation|Population Health');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `program_owner` SET TAGS ('dbx_business_glossary_term' = 'Program Owner');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Pending Approval|Suspended|Terminated|Pilot');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'MSSP|REACH|NextGen|Commercial P4P|Episode-Based|Capitation');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `program_url` SET TAGS ('dbx_business_glossary_term' = 'Program URL');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `program_year` SET TAGS ('dbx_business_glossary_term' = 'Program Year');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `quality_measure_set` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Set');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `quality_performance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Quality Performance Threshold');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `risk_model` SET TAGS ('dbx_business_glossary_term' = 'Risk Model');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `risk_model` SET TAGS ('dbx_value_regex' = 'Upside Only|Two-Sided|Downside Only|Capitation|Blended');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'Annual|Semi-Annual|Quarterly|Monthly');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `shared_loss_rate` SET TAGS ('dbx_business_glossary_term' = 'Shared Loss Rate');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `shared_savings_rate` SET TAGS ('dbx_business_glossary_term' = 'Shared Savings Rate');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `sponsoring_entity` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Entity');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `sponsoring_entity` SET TAGS ('dbx_value_regex' = 'CMS|State Medicaid|Commercial|Self-Insured Employer|Multi-Payer');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`network`.`vbc_program` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` SET TAGS ('dbx_subdomain' = 'network_structure');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Agreement ID');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `baa_id` SET TAGS ('dbx_business_glossary_term' = 'Baa Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Package Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `network_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Network Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `parent_par_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `agreement_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Scope Description');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'individual|group|entity');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `agreement_version` SET TAGS ('dbx_business_glossary_term' = 'Agreement Version');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `amendment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `amendment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amendment Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `amendment_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Termination Date');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `compliance_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `compliance_status_flag` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `electronic_signature_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Signature Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `paper_signature_flag` SET TAGS ('dbx_business_glossary_term' = 'Paper Signature Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `par_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `par_agreement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending|draft');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `provider_credentialing_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Credentialing Date');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `provider_credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Provider Credentialing Status');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `provider_credentialing_status` SET TAGS ('dbx_value_regex' = 'credentialed|pending|revoked');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `provider_directory_last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory Last Verified Date');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `provider_directory_listing_flag` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory Listing Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `provider_network_status` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Status');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `provider_network_status` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|pending');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `provider_participation_role` SET TAGS ('dbx_business_glossary_term' = 'Provider Participation Role');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `provider_participation_role` SET TAGS ('dbx_value_regex' = 'primary_care|specialist|both|other');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `provider_recredentialing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Re‑credentialing Due Date');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `signed_by_name` SET TAGS ('dbx_business_glossary_term' = 'Signed By Name');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `signed_by_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `signed_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `signed_by_npi` SET TAGS ('dbx_business_glossary_term' = 'Signed By NPI');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `signed_by_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `signed_by_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `signed_by_title` SET TAGS ('dbx_business_glossary_term' = 'Signed By Title');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `termination_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Description');
ALTER TABLE `health_insurance_ecm`.`network`.`par_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
