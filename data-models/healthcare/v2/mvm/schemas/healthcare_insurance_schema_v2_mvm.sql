-- Schema for Domain: insurance | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-06-23 16:10:10

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`insurance` COMMENT 'Master data management for insurance payers, health plans, benefit structures, provider networks, and coverage policies. SSOT for payer identity, plan configurations, network definitions, and benefit rules that are referenced by billing, claim, patient, and encounter domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`payer` (
    `payer_id` BIGINT COMMENT 'Unique identifier for the payer organization.',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Payers are registered entities with NPIs in the NPI registry. Provider credentialing, claims routing, and HIPAA EDI transactions require linking payer records to their authoritative NPI registry entry',
    `parent_payer_id` BIGINT COMMENT 'Reference to parent payer organization in a hierarchy.',
    `primary_successor_payer_id` BIGINT COMMENT 'Reference to the payer that succeeded this one after merger or acquisition.',
    `accepts_assignment` BOOLEAN COMMENT 'Indicates whether the payer accepts assignment of benefits.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the payer is currently active.',
    `appeal_limit_days` STRING COMMENT 'Number of days allowed for filing an appeal.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether contracts auto-renew.',
    `payer_category` STRING COMMENT 'Category of payer (e.g., commercial, government, self-pay).',
    `claim_scrubbing_vendor` STRING COMMENT 'Name of the claim scrubbing vendor used.',
    `claims_inquiry_phone` STRING COMMENT 'Phone number for claims inquiries.',
    `claims_submission_endpoint` STRING COMMENT 'URL or EDI endpoint for claim submission.',
    `clearinghouse_code` STRING COMMENT 'Code identifying the clearinghouse used.',
    `coordination_of_benefits_required` BOOLEAN COMMENT 'Indicates whether coordination of benefits is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `customer_service_phone` STRING COMMENT 'Customer service phone number.',
    `edi_payer_code` STRING COMMENT 'EDI payer identification code.',
    `electronic_funds_transfer_flag` BOOLEAN COMMENT 'Indicates whether electronic funds transfer is supported.',
    `eligibility_verification_method` STRING COMMENT 'Method used for eligibility verification (e.g., real-time, batch).',
    `id_external` STRING COMMENT 'External system identifier for the payer.',
    `inactivation_date` DATE COMMENT 'Date when the payer was inactivated.',
    `inactivation_reason` STRING COMMENT 'Reason for payer inactivation.',
    `payer_name` STRING COMMENT 'Full legal name of the payer organization.',
    `notes` STRING COMMENT 'Free-text notes about the payer.',
    `payer_type` STRING COMMENT 'Type of payer (e.g., HMO, PPO, Medicare, Medicaid).',
    `payment_terms_days` STRING COMMENT 'Number of days for payment terms.',
    `portal_url` STRING COMMENT 'URL of the payers provider portal.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required.',
    `provider_relations_email` STRING COMMENT 'Email address for provider relations.',
    `remittance_address_line1` STRING COMMENT 'First line of remittance address.',
    `remittance_address_line2` STRING COMMENT 'Second line of remittance address.',
    `remittance_city` STRING COMMENT 'City for remittance address.',
    `remittance_delivery_method` STRING COMMENT 'Method of remittance delivery (e.g., mail, electronic).',
    `remittance_postal_code` STRING COMMENT 'Postal code for remittance address.',
    `remittance_state` STRING COMMENT 'State for remittance address.',
    `short_name` STRING COMMENT 'Abbreviated name of the payer.',
    `submission_method` STRING COMMENT 'Method for claim submission (e.g., EDI, portal, paper).',
    `tax_identification_number` STRING COMMENT 'Tax ID (TIN/EIN) of the payer organization.',
    `tier` STRING COMMENT 'Tier classification of the payer.',
    `timely_filing_limit_days` STRING COMMENT 'Number of days for timely filing of claims.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    CONSTRAINT pk_payer PRIMARY KEY(`payer_id`)
) COMMENT 'Insurance payer organization master table storing health plan companies, government programs, and third-party administrators.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` (
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan.',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to consent.form_template. Business justification: Health plans mandate specific consent form templates for member enrollment (plan-specific HIPAA NPP, terms of coverage). Payer operations configure which form template applies per health plan. Role-pr',
    `payer_id` BIGINT COMMENT 'Reference to the payer offering this plan.',
    `predecessor_health_plan_id` BIGINT COMMENT 'Reference to the predecessor plan if this plan replaced another.',
    `provider_network_id` BIGINT COMMENT 'Reference to the provider network for this plan.',
    `benefit_year` STRING COMMENT 'Calendar year for which benefits apply.',
    `cms_contract_number` STRING COMMENT 'CMS contract number for Medicare Advantage or Part D plans.',
    `cob_order` STRING COMMENT 'Coordination of benefits order (primary, secondary, tertiary).',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Default coinsurance percentage for the plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was created.',
    `effective_date` DATE COMMENT 'Date when the plan becomes effective.',
    `emergency_room_copay_amount` DECIMAL(18,2) COMMENT 'Copay amount for emergency room visits.',
    `family_deductible_amount` DECIMAL(18,2) COMMENT 'Annual family deductible amount.',
    `family_oop_max_amount` DECIMAL(18,2) COMMENT 'Annual family out-of-pocket maximum.',
    `fsa_eligible` BOOLEAN COMMENT 'Indicates whether the plan is FSA-eligible.',
    `funding_type` STRING COMMENT 'Funding type (e.g., fully insured, self-funded).',
    `group_number` STRING COMMENT 'Group number for employer-sponsored plans.',
    `hra_eligible` BOOLEAN COMMENT 'Indicates whether the plan is HRA-eligible.',
    `hsa_eligible` BOOLEAN COMMENT 'Indicates whether the plan is HSA-eligible.',
    `individual_deductible_amount` DECIMAL(18,2) COMMENT 'Annual individual deductible amount.',
    `individual_oop_max_amount` DECIMAL(18,2) COMMENT 'Annual individual out-of-pocket maximum.',
    `inpatient_hospital_copay_amount` DECIMAL(18,2) COMMENT 'Copay amount for inpatient hospital stays.',
    `issuer_state` STRING COMMENT 'State where the plan is issued.',
    `metal_tier` STRING COMMENT 'ACA metal tier (Bronze, Silver, Gold, Platinum).',
    `open_enrollment_end_date` DATE COMMENT 'End date of open enrollment period.',
    `open_enrollment_start_date` DATE COMMENT 'Start date of open enrollment period.',
    `out_of_network_coverage` BOOLEAN COMMENT 'Indicates whether out-of-network coverage is available.',
    `out_of_network_deductible_amount` DECIMAL(18,2) COMMENT 'Annual out-of-network deductible amount.',
    `out_of_network_oop_max_amount` DECIMAL(18,2) COMMENT 'Annual out-of-network out-of-pocket maximum.',
    `plan_document_url` STRING COMMENT 'URL to the plan document or summary of benefits.',
    `plan_identifier` STRING COMMENT 'External plan identifier or code.',
    `plan_name` STRING COMMENT 'Name of the health plan.',
    `plan_status` STRING COMMENT 'Status of the plan (active, inactive, pending).',
    `plan_type` STRING COMMENT 'Type of plan (HMO, PPO, EPO, POS, HDHP).',
    `prescription_tier1_copay_amount` DECIMAL(18,2) COMMENT 'Copay amount for tier 1 prescriptions.',
    `prescription_tier2_copay_amount` DECIMAL(18,2) COMMENT 'Copay amount for tier 2 prescriptions.',
    `prescription_tier3_copay_amount` DECIMAL(18,2) COMMENT 'Copay amount for tier 3 prescriptions.',
    `prescription_tier4_copay_amount` DECIMAL(18,2) COMMENT 'Copay amount for tier 4 prescriptions.',
    `preventive_care_covered` BOOLEAN COMMENT 'Indicates whether preventive care is covered at 100%.',
    `primary_care_copay_amount` DECIMAL(18,2) COMMENT 'Copay amount for primary care visits.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required.',
    `requires_pcp_selection` BOOLEAN COMMENT 'Indicates whether members must select a primary care physician.',
    `requires_referral_for_specialist` BOOLEAN COMMENT 'Indicates whether referrals are required for specialist visits.',
    `service_area_description` STRING COMMENT 'Description of the geographic service area.',
    `specialist_copay_amount` DECIMAL(18,2) COMMENT 'Copay amount for specialist visits.',
    `state_filing_number` STRING COMMENT 'State regulatory filing number.',
    `termination_date` DATE COMMENT 'Date when the plan terminates.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was last updated.',
    `urgent_care_copay_amount` DECIMAL(18,2) COMMENT 'Copay amount for urgent care visits.',
    CONSTRAINT pk_health_plan PRIMARY KEY(`health_plan_id`)
) COMMENT 'Specific health insurance plan products offered by payers, including benefit design and coverage rules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`benefit` (
    `benefit_id` BIGINT COMMENT 'Unique identifier for the benefit component within a health plan. Primary key for the benefit master record.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Benefits often require specific diagnoses for coverage (e.g., CGM for diabetes, PT for specific conditions). Medical necessity validation and claims auto-adjudication depend on diagnosis-benefit linka',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Inpatient hospital benefits are defined at the DRG level with specific cost-sharing structures (e.g., per-diem copay for DRG 470). Health plan benefit design, EOB generation, and inpatient claims adju',
    `parent_benefit_id` BIGINT COMMENT 'Self-referencing FK on benefit (parent_benefit_id)',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Benefits are defined by specific CPT procedures with associated copays, coinsurance, and authorization requirements. Core to claims adjudication engine and member cost-sharing calculation in every pay',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Benefits for DME, supplies, and non-physician services are defined by HCPCS codes. Essential for benefit determination, prior authorization rules, and claims payment calculation in healthcare payer op',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to consent.form_template. Business justification: Certain benefits (behavioral health, genetic testing, experimental treatments) require specific consent forms before utilization. Benefits configuration teams assign required consent form templates pe',
    `allowed_amount_basis` STRING COMMENT 'Method used to determine the allowed amount for benefit adjudication. Defines how the plan calculates the maximum payable amount for a service.. Valid values are `usual_customary_reasonable|medicare_rate|negotiated_rate|billed_charges`',
    `benefit_status` STRING COMMENT 'Current lifecycle status of the benefit component. Active benefits are available for adjudication; inactive benefits are historical or discontinued.. Valid values are `active|inactive|suspended|pending_approval`',
    `benefit_category` STRING COMMENT 'High-level classification of the healthcare service category covered by this benefit. [ENUM-REF-CANDIDATE: inpatient_hospital|outpatient_surgery|primary_care|specialist|emergency|mental_health|substance_use|preventive|durable_medical_equipment|home_health|hospice|vision|dental|pharmacy|rehabilitation|skilled_nursing — promote to reference product]',
    `benefit_code` STRING COMMENT 'Unique business identifier for the benefit component used in plan documentation, member communications, and adjudication rules. Externally visible code.. Valid values are `^[A-Z0-9]{3,20}$`',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of allowed amount the member pays after deductible is met. Expressed as percentage (e.g., 20.00 for 20%). Null if benefit uses copay instead of coinsurance.',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the member pays per service or visit as defined by the benefit. Null if benefit uses coinsurance instead of copay.',
    `cost_sharing_tier` STRING COMMENT 'Actuarial value tier of the benefit indicating the percentage of costs the plan covers on average. Used for ACA marketplace plans.. Valid values are `bronze|silver|gold|platinum`',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'Percentage of allowed amount the plan pays for this benefit. Expressed as percentage (e.g., 80.00 for 80% plan payment). Inverse of coinsurance_percentage.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit record was first created in the system. Used for audit trail and data lineage tracking.',
    `day_limit_count` STRING COMMENT 'Maximum number of days covered per benefit period for services measured in days (e.g., 90 days skilled nursing facility per benefit period). Null if no day limit applies.',
    `day_limit_period` STRING COMMENT 'Time period over which the day limit count applies. Example: per_admission for inpatient stays, per_year for annual day limits.. Valid values are `per_admission|per_year|per_lifetime`',
    `days_supply_limit` STRING COMMENT 'Maximum number of days supply allowed per prescription fill for pharmacy benefits. Common limits are 30, 60, or 90 days. Null if not applicable.',
    `deductible_applies_flag` BOOLEAN COMMENT 'Indicates whether the plan deductible must be met before this benefit pays. True if deductible applies, False if benefit is not subject to deductible (e.g., preventive services).',
    `benefit_description` STRING COMMENT 'Detailed narrative description of the benefit coverage, limitations, and member responsibilities. Used in Summary of Benefits and Coverage (SBC) and member materials.',
    `diagnosis_code_type` STRING COMMENT 'Type of diagnosis coding system used for medical necessity determination and benefit eligibility. ICD-10-CM is current standard in US; ICD-9-CM is legacy.. Valid values are `ICD10CM|ICD9CM`',
    `dollar_limit_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount the plan will pay for this benefit per limit period. Null if no dollar limit applies. Note: ACA prohibits lifetime and annual dollar limits on essential health benefits.',
    `dollar_limit_period` STRING COMMENT 'Time period over which the dollar limit amount applies. Used for non-essential benefits where dollar limits are permitted.. Valid values are `per_visit|per_day|per_year|per_lifetime`',
    `effective_date` DATE COMMENT 'Date when this benefit component becomes active and available for coverage. Must align with plan year or mid-year plan changes.',
    `essential_health_benefit_flag` BOOLEAN COMMENT 'Indicates whether this benefit is classified as an Essential Health Benefit under ACA. EHBs cannot have annual or lifetime dollar limits.',
    `exclusions_text` STRING COMMENT 'Narrative description of services or conditions explicitly excluded from this benefit. Critical for claims denial and member communication.',
    `formulary_tier` STRING COMMENT 'Pharmacy formulary tier for drug benefits indicating cost-sharing level. Tier 1 typically generic, Tier 2 preferred brand, Tier 3 non-preferred brand, Tier 4 specialty drugs.. Valid values are `tier_1|tier_2|tier_3|tier_4|specialty`',
    `hsa_eligible_flag` BOOLEAN COMMENT 'Indicates whether this benefit is compatible with Health Savings Account (HSA) requirements. True if benefit meets HSA-qualified high-deductible health plan (HDHP) rules.',
    `limitations_text` STRING COMMENT 'Narrative description of limitations, restrictions, or conditions that apply to this benefit beyond the structured limit fields.',
    `mail_order_available_flag` BOOLEAN COMMENT 'Indicates whether this pharmacy benefit can be fulfilled through mail order pharmacy with potentially different cost-sharing. True if mail order option available.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit record was last modified. Updated whenever any attribute changes. Used for change tracking and audit compliance.',
    `benefit_name` STRING COMMENT 'Human-readable name of the benefit component displayed to members and providers. Example: Inpatient Hospital Services, Primary Care Office Visit.',
    `network_type` STRING COMMENT 'Indicates whether this benefit applies to in-network providers, out-of-network providers, or both. Critical for cost-sharing calculation and provider network adjudication.. Valid values are `in_network|out_of_network|both`',
    `out_of_pocket_applies_flag` BOOLEAN COMMENT 'Indicates whether member cost-sharing for this benefit counts toward the annual out-of-pocket maximum. True if it counts, False if excluded (e.g., non-covered services).',
    `place_of_service_code` STRING COMMENT 'Standard two-digit code identifying where the service is delivered (e.g., 11=Office, 21=Inpatient Hospital, 22=Outpatient Hospital, 23=Emergency Room). Used for benefit adjudication rules.. Valid values are `^[0-9]{2}$`',
    `preventive_care_flag` BOOLEAN COMMENT 'Indicates whether this benefit is classified as preventive care under ACA requirements. Preventive services must be covered at 100% with no cost-sharing when delivered in-network.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Indicates whether prior authorization from the health plan is required before the service is covered. True if PA required, False otherwise.',
    `procedure_code_type` STRING COMMENT 'Type of procedure coding system used to identify services covered by this benefit. CPT for physician services, HCPCS for supplies and equipment, ICD-10-PCS for inpatient procedures, CDT for dental.. Valid values are `CPT|HCPCS|ICD10PCS|CDT|revenue_code`',
    `quantity_limit_flag` BOOLEAN COMMENT 'Indicates whether this benefit has quantity or frequency limits (e.g., maximum number of visits, days supply, units per fill). True if limits apply.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicates whether a referral from Primary Care Physician (PCP) is required to access this benefit. Common in Health Maintenance Organization (HMO) plans.',
    `service_type_code` STRING COMMENT 'Standard code identifying the type of healthcare service covered by this benefit. Aligns with X12 837 claim service type codes for electronic transactions.. Valid values are `^[0-9]{2}$`',
    `step_therapy_required_flag` BOOLEAN COMMENT 'Indicates whether step therapy protocol must be followed (trying lower-cost alternatives before higher-cost treatments). Primarily used for pharmacy benefits.',
    `subcategory` STRING COMMENT 'Detailed subcategory within the benefit category providing granular service classification. Example: Acute Inpatient, Observation Stay, Ambulatory Surgery.',
    `termination_date` DATE COMMENT 'Date when this benefit component is no longer active. Null for currently active benefits with no planned end date.',
    `tier` STRING COMMENT 'Tiering level of the benefit indicating cost-sharing structure. Commonly used for pharmacy benefits (generic, preferred brand, non-preferred brand, specialty) and provider networks (in-network tier 1, tier 2).. Valid values are `tier_1|tier_2|tier_3|tier_4|specialty`',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `vibe_mutation_marker` STRING COMMENT '',
    `visit_limit_count` STRING COMMENT 'Maximum number of visits or services allowed per benefit period (e.g., 20 physical therapy visits per year). Null if no visit limit applies.',
    `visit_limit_period` STRING COMMENT 'Time period over which the visit limit count applies. Example: per_year for annual limits, per_lifetime for lifetime maximums.. Valid values are `per_day|per_week|per_month|per_year|per_lifetime`',
    CONSTRAINT pk_benefit PRIMARY KEY(`benefit_id`)
) COMMENT 'Master record defining individual benefit components within a health plan, representing the specific coverage rules for a category of healthcare services. Captures benefit category (inpatient hospital, outpatient surgery, primary care, specialist, emergency, mental health, substance use, preventive, DME, home health, hospice, vision, dental, pharmacy), benefit tier, in-network vs out-of-network rules, prior authorization requirement flag, referral requirement flag, copay amount, coinsurance percentage, deductible applicability, benefit limit (visit limits, dollar limits, day limits), and benefit effective dates. Enables granular benefit adjudication and member cost-sharing calculation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` (
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network. Primary key.',
    `parent_network_provider_network_id` BIGINT COMMENT 'Identifier of the parent or umbrella network if this network is a subset or regional variant. Used for hierarchical network structures where a national network has regional sub-networks. Null for top-level networks.',
    `parent_provider_network_id` BIGINT COMMENT 'Self-referencing FK on provider_network (parent_provider_network_id)',
    `payer_id` BIGINT COMMENT 'Identifier of the payer or health plan that owns and manages this provider network.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether the network as a whole has capacity to accept new members. True if sufficient providers are accepting new patients. False if network is at capacity. Used for enrollment management.',
    `adequacy_review_date` DATE COMMENT 'Date of the most recent network adequacy assessment by CMS or state regulators. Networks must be reviewed annually or when material changes occur.',
    `behavioral_health_included_flag` BOOLEAN COMMENT 'Indicates whether this network includes behavioral health and mental health providers. True if behavioral health services are covered. False if behavioral health is carved out to a separate network.',
    `cms_approval_date` DATE COMMENT 'Date when CMS approved the network adequacy filing. Null if not yet approved or not required.',
    `cms_filing_date` DATE COMMENT 'Date when the network adequacy filing was submitted to CMS. Required for Medicare Advantage and Marketplace plans.',
    `cms_filing_status` STRING COMMENT 'Status of the network adequacy filing with CMS for Medicare Advantage or Marketplace plans. Filed indicates submission. Approved indicates CMS acceptance. Rejected indicates CMS denial. Pending indicates under CMS review. Not required for non-CMS regulated plans.. Valid values are `filed|approved|rejected|pending|not_required`',
    `contract_type` STRING COMMENT 'Payment model used for provider contracts in this network. Fee-for-service pays per service. Capitation pays per member per month. Shared savings shares cost savings with providers. Bundled payment pays fixed amount for episode of care. Value-based ties payment to quality and outcomes. Hybrid combines multiple models.. Valid values are `fee_for_service|capitation|shared_savings|bundled_payment|value_based|hybrid`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this provider network record was first created in the system. Used for audit trail and data lineage.',
    `credentialing_standard` STRING COMMENT 'Accreditation or regulatory standard used for provider credentialing in this network. NCQA (National Committee for Quality Assurance) is most common. URAC is utilization review accreditation. AAAHC (Accreditation Association for Ambulatory Health Care) for ambulatory settings. TJC (The Joint Commission) for hospitals. State-specific for state-mandated standards. Internal for payer-defined standards.. Valid values are `NCQA|URAC|AAAHC|TJC|state_specific|internal`',
    `dental_network_included_flag` BOOLEAN COMMENT 'Indicates whether this network includes dental providers or if dental benefits are managed separately. True if dental is included. False if dental is carved out.',
    `directory_last_updated_date` DATE COMMENT 'Date when the provider directory was last updated with current network participation information. CMS requires directories to be updated at least monthly.',
    `effective_date` DATE COMMENT 'Date when the provider network becomes active and available for member enrollment and claim adjudication. Must align with plan year or regulatory approval dates.',
    `effective_end_date` DATE COMMENT 'Effective End Date for provider_network.',
    `effective_start_date` DATE COMMENT 'Effective Start Date for provider_network.',
    `facility_count` STRING COMMENT 'Total number of facilities (hospitals, clinics, surgery centers, imaging centers) participating in this network. Used for network adequacy assessment and member communications.',
    `geographic_service_area` STRING COMMENT 'Geographic region where the provider network operates, defined by state, county, ZIP code, or metropolitan statistical area. Used for network adequacy assessment and member eligibility determination.',
    `is_active` BOOLEAN COMMENT 'Is Active for provider_network.',
    `network_adequacy_status` STRING COMMENT 'Assessment of whether the provider network meets regulatory standards for provider availability, geographic access, and appointment wait times. Adequate networks meet all standards. Inadequate networks require corrective action. Conditionally adequate networks meet standards with exceptions.. Valid values are `adequate|inadequate|pending_review|conditionally_adequate|exempt`',
    `network_code` STRING COMMENT 'Business identifier for the provider network, used externally by payers, providers, and members. May be referenced on insurance cards and claim submissions.',
    `network_description` STRING COMMENT 'Detailed description of the provider network, including key features, geographic coverage, specialty availability, and member benefits. Used in plan marketing materials and member communications.',
    `network_directory_url` STRING COMMENT 'Web address of the online provider directory for this network. Members use this to search for in-network providers. Required by CMS for Medicare Advantage and Marketplace plans.',
    `network_model` STRING COMMENT 'Organizational structure of the provider network. Staff model employs providers directly. Group model contracts with multi-specialty groups. Network model contracts with multiple IPAs. IPA (Independent Practice Association) is a physician-owned network. Direct contract is payer-to-provider agreements. Rental network leases access to another payers network.. Valid values are `staff_model|group_model|network_model|IPA|direct_contract|rental_network`',
    `network_name` STRING COMMENT 'Human-readable name of the provider network, used in member communications, plan documents, and provider directories.',
    `network_status` STRING COMMENT 'Current lifecycle status of the provider network. Active networks are available for member enrollment and claim adjudication. Pending networks are under development or regulatory review. Suspended networks are temporarily unavailable. Terminated networks are closed and no longer accepting new members.. Valid values are `active|inactive|pending|suspended|terminated`',
    `network_tier` STRING COMMENT 'Tier classification of the network for cost-sharing purposes. Preferred or Tier 1 networks offer lowest member cost-sharing. Standard or Tier 2 networks have moderate cost-sharing. Out-of-network or Tier 3 have highest cost-sharing. Used in tiered network benefit designs.. Valid values are `preferred|standard|out_of_network|tier_1|tier_2|tier_3`',
    `network_type` STRING COMMENT 'Classification of the provider network structure. HMO (Health Maintenance Organization) requires PCP referrals and in-network care. PPO (Preferred Provider Organization) allows out-of-network care at higher cost. EPO (Exclusive Provider Organization) requires in-network care except emergencies. POS (Point of Service) combines HMO and PPO features. ACO (Accountable Care Organization) is a value-based network. Narrow network limits provider choice for lower premiums. Tiered network assigns cost-sharing levels by provider performance. [ENUM-REF-CANDIDATE: HMO|PPO|EPO|POS|ACO|narrow_network|tiered_network|exclusive_network|open_network — 9 candidates stripped; promote to reference product]',
    `pcp_count` STRING COMMENT 'Total number of primary care physicians in this network. Critical metric for HMO and POS networks that require PCP selection. Used for network adequacy assessment.',
    `pharmacy_network_included_flag` BOOLEAN COMMENT 'Indicates whether this network includes pharmacy providers or if pharmacy benefits are managed separately. True if pharmacy is included. False if pharmacy is carved out.',
    `provider_count` STRING COMMENT 'Total number of individual providers (physicians, specialists, allied health professionals) participating in this network. Used for network adequacy assessment and member communications.',
    `quality_tier_methodology` STRING COMMENT 'Description of the methodology used to assign providers to quality or performance tiers within this network. May reference HEDIS measures, patient satisfaction scores, cost efficiency, or clinical outcomes. Used in tiered network designs.',
    `recredentialing_cycle_months` STRING COMMENT 'Number of months between provider recredentialing reviews. Typically 24 or 36 months per NCQA standards. Used to schedule provider credential verification and quality reviews.',
    `risk_arrangement` STRING COMMENT 'Financial risk-sharing arrangement between payer and network providers. Full risk transfers all financial risk to providers. Shared risk splits risk between payer and providers. Upside only allows providers to share savings but not losses. Downside risk requires providers to cover losses. No risk is traditional fee-for-service.. Valid values are `full_risk|shared_risk|upside_only|downside_risk|no_risk`',
    `service_area_type` STRING COMMENT 'Classification of the geographic service area scope. Statewide covers entire state. Regional covers multiple counties or regions. County covers specific counties. ZIP code covers specific ZIP codes. MSA (Metropolitan Statistical Area) covers census-defined metro areas. National covers multiple states or entire country.. Valid values are `statewide|regional|county|zip_code|msa|national`',
    `specialist_count` STRING COMMENT 'Total number of specialist physicians in this network. Used for network adequacy assessment and member communications.',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'Indicates whether this network includes telehealth or virtual care providers. True if telehealth services are available. False if only in-person care is covered.',
    `termination_date` DATE COMMENT 'Date when the provider network is terminated and no longer available for new member enrollment. Existing members may have a transition period. Null for open-ended networks.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this provider network record was last modified. Used for audit trail and change tracking.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `vibe_mutation_marker` STRING COMMENT '',
    `vision_network_included_flag` BOOLEAN COMMENT 'Indicates whether this network includes vision providers or if vision benefits are managed separately. True if vision is included. False if vision is carved out.',
    CONSTRAINT pk_provider_network PRIMARY KEY(`provider_network_id`)
) COMMENT 'Master record for every provider network defined and managed by a payer, representing the contracted network of providers available to plan members. Captures network name, network ID, network type (HMO, PPO, EPO, narrow network, tiered network, ACO network), geographic service area, network tier (preferred, standard, out-of-network), network effective and termination dates, network adequacy status, CMS network adequacy filing status, and the payer that owns the network. SSOT for network identity referenced by plan-network associations, provider participation records, and claim adjudication.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` (
    `coverage_policy_id` BIGINT COMMENT 'Unique identifier for the coverage policy record. Primary key.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Coverage policies define medical necessity criteria for specific CPT procedures. Current text field applicable_cpt_codes should be normalized to proper FK for policy enforcement, prior authorization',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Coverage policies define payment rules and authorization requirements for specific DRGs in inpatient settings. Critical for bundled payment administration, outlier payment calculation, and hospital co',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Coverage policies govern HCPCS code reimbursement and authorization requirements. Denormalized text field applicable_hcpcs_codes should be proper FK for policy administration, utilization management',
    `health_plan_id` BIGINT COMMENT 'Reference to the specific health plan under which this coverage policy applies.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Coverage policies specify diagnosis criteria for medical necessity. Text field applicable_icd10_codes should be normalized FK for automated policy evaluation, clinical documentation requirements, an',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Coverage policies for specialty and high-cost drugs are defined against specific NDC drug codes. Formulary coverage determination, specialty drug prior auth, and CMS Part D compliance require linking ',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or health plan that owns this coverage policy.',
    `primary_superseded_by_coverage_policy_id` BIGINT COMMENT 'Reference to the coverage policy that replaces this policy when it is retired or superseded. Nullable if the policy is still active or has not been replaced.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Medical policies define coverage criteria by specialty (e.g., orthopedic surgery criteria, cardiology device policies). Essential for claims adjudication, medical necessity determination, and specialt',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to provider.provider_taxonomy. Business justification: Coverage policies reference taxonomy codes for provider type restrictions (e.g., only board-certified surgeons, only licensed clinical psychologists). Critical for claims auto-adjudication and provide',
    `age_restrictions` STRING COMMENT 'Age-based limitations or requirements for coverage under this policy (e.g., covered for patients 18 years and older, pediatric use only).',
    `appeals_allowed` BOOLEAN COMMENT 'Indicates whether coverage denials based on this policy can be appealed by the provider or patient. True = appeals allowed; False = no appeals allowed.',
    `appeals_process_description` STRING COMMENT 'Detailed description of the appeals process for coverage denials based on this policy, including timelines, required documentation, and contact information.',
    `clinical_evidence_source` STRING COMMENT 'Reference to the clinical evidence, guidelines, or literature that supports the coverage determination (e.g., NCCN Guidelines, FDA approval, peer-reviewed clinical trial).',
    `coverage_determination` STRING COMMENT 'Final determination of whether the service, procedure, or technology is covered under this policy. Covered = reimbursable; Non-Covered = not reimbursable; Conditional = covered only if specific criteria met; Investigational/Experimental = not covered due to lack of evidence; Not Medically Necessary = does not meet medical necessity criteria.. Valid values are `covered|non_covered|conditional|investigational|experimental|not_medically_necessary`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the coverage policy record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the coverage policy becomes active and enforceable for claims adjudication and prior authorization decisions.',
    `exclusions` STRING COMMENT 'Specific services, procedures, diagnoses, or circumstances that are explicitly excluded from coverage under this policy.',
    `expiration_date` DATE COMMENT 'Date on which the coverage policy ceases to be active. Nullable for policies with no defined end date.',
    `frequency_limitations` STRING COMMENT 'Limitations on how often the service or procedure can be performed and reimbursed within a specified time period (e.g., once per calendar year, maximum 12 visits per year).',
    `gender_restrictions` STRING COMMENT 'Gender-based limitations or requirements for coverage under this policy (e.g., female patients only, male patients only, no gender restrictions).',
    `last_updated_date` DATE COMMENT 'Date when the coverage policy was last modified or revised.',
    `medical_necessity_criteria` STRING COMMENT 'Clinical criteria defining when the service or procedure is considered medically necessary and therefore eligible for coverage under this policy.',
    `network_restrictions` STRING COMMENT 'Indicates whether the service or procedure must be performed by an in-network provider to be covered. In-Network Only = only in-network providers eligible; Out-of-Network Allowed = both in-network and out-of-network providers eligible (may have different reimbursement); No Restriction = network status does not affect coverage.. Valid values are `in_network_only|out_of_network_allowed|no_restriction`',
    `place_of_service_restrictions` STRING COMMENT 'Restrictions on where the service or procedure can be performed to be eligible for coverage (e.g., inpatient hospital only, outpatient facility or office, home health setting).',
    `policy_approval_date` DATE COMMENT 'Date on which the coverage policy was formally approved by the payers medical policy committee or equivalent governance body.',
    `policy_approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved the coverage policy.',
    `policy_category` STRING COMMENT 'High-level categorization of the coverage policy by clinical domain or service type (e.g., Radiology, Pharmacy, Surgical Procedures, Durable Medical Equipment).',
    `policy_description` STRING COMMENT 'Detailed narrative description of the coverage policy, including the clinical rationale, scope of coverage, and any special conditions or limitations.',
    `policy_number` STRING COMMENT 'Externally-known unique identifier for the coverage policy, used in prior authorization and claims adjudication workflows.. Valid values are `^[A-Z0-9]{6,20}$`',
    `policy_owner` STRING COMMENT 'Name or identifier of the individual or department responsible for maintaining and updating this coverage policy.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the coverage policy. Active = in effect and enforceable; Inactive = temporarily suspended; Draft = not yet finalized; Under Review = being evaluated or updated; Retired = no longer in use; Superseded = replaced by a newer policy version.. Valid values are `active|inactive|draft|under_review|retired|superseded`',
    `policy_title` STRING COMMENT 'Human-readable title or name of the coverage policy, describing the service or condition covered.',
    `policy_type` STRING COMMENT 'Classification of the coverage policy. Medical Policy = internal payer medical necessity policy; Coverage Determination = specific coverage decision; LCD = Local Coverage Determination (Medicare contractor-specific); NCD = National Coverage Determination (CMS national policy); Administrative Policy = non-clinical coverage rule; Clinical Guideline = evidence-based clinical criteria.. Valid values are `medical_policy|coverage_determination|lcd|ncd|administrative_policy|clinical_guideline`',
    `policy_version` STRING COMMENT 'Version number of the coverage policy, used to track revisions and updates over time (e.g., 1.0, 2.3).. Valid values are `^[0-9]+.[0-9]+$`',
    `prior_authorization_criteria` STRING COMMENT 'Detailed clinical and administrative criteria that must be met to obtain prior authorization for the service or procedure covered by this policy.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required before the service or procedure can be performed and reimbursed under this policy. True = prior authorization required; False = no prior authorization required.',
    `provider_specialty_restrictions` STRING COMMENT 'Restrictions on which provider specialties are authorized to perform the service or procedure under this policy (e.g., board-certified cardiologist only, licensed physical therapist).',
    `quantity_limitations` STRING COMMENT 'Limitations on the quantity or dosage of the service, supply, or medication that can be provided and reimbursed under this policy (e.g., maximum 30-day supply, up to 10 units per month).',
    `regulatory_basis` STRING COMMENT 'Reference to the regulatory or statutory basis for the coverage policy (e.g., CMS NCD 210.1, State Medicaid Manual Section 4.5, ACA Essential Health Benefits).',
    `review_date` DATE COMMENT 'Scheduled date for the next policy review or update cycle, ensuring the policy remains aligned with current clinical evidence and regulatory requirements.',
    `step_therapy_criteria` STRING COMMENT 'Detailed criteria defining the step therapy requirements, including which treatments must be tried first and the conditions under which step therapy can be bypassed.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether step therapy (trial of less expensive or less invasive treatments first) is required before the service or procedure is covered. True = step therapy required; False = no step therapy required.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the coverage policy record was last updated in the system.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `vibe_mutation_marker` STRING COMMENT '',
    CONSTRAINT pk_coverage_policy PRIMARY KEY(`coverage_policy_id`)
) COMMENT 'Master record for payer coverage policies and medical policies governing whether specific services, procedures, diagnoses, or technologies are covered under a health plan. Captures policy number, policy title, policy type (medical policy, coverage determination, LCD — Local Coverage Determination, NCD — National Coverage Determination), covered/non-covered determination, applicable CPT/HCPCS codes, applicable ICD-10 diagnosis codes, prior authorization requirements, clinical criteria (medical necessity criteria, step therapy requirements), effective date, and review/expiration date. SSOT for coverage rules referenced during prior authorization and claim adjudication.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` (
    `member_enrollment_id` BIGINT COMMENT 'Unique identifier for the member enrollment record. Primary key for this transactional enrollment entity.',
    `dependent_id` BIGINT COMMENT 'Foreign key linking to insurance.dependent. Business justification: A member enrollment record can represent a dependents enrollment (not just the primary subscriber). member_enrollment already has relationship_to_subscriber (string) indicating the enrollee may be a ',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the specific health plan product the member is enrolled in. Links to the health plan master record.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: CMS enrollment reporting and care management require direct patient-to-enrollment reconciliation. Enterprise healthcare systems must link enrollment records to the master patient identity for eligibil',
    `npp_acknowledgment_id` BIGINT COMMENT 'Foreign key linking to consent.npp_acknowledgment. Business justification: HIPAA requires NPP acknowledgment at first service or enrollment. Linking member_enrollment to npp_acknowledgment enables compliance reporting confirming each enrolled member acknowledged the NPP. CMS',
    `payer_id` BIGINT COMMENT 'Unique identifier for the insurance payer or health plan organization providing coverage. Links to the payer master record.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: PCP assignment is a core enrollment operation: member_enrollment tracks pcp_assignment_date but stores only a denormalized NPI. A proper FK to clinician supports PCP panel management, HEDIS attributio',
    `subscriber_id` BIGINT COMMENT 'External subscriber identifier assigned by the payer or health plan. Used for eligibility verification and claim adjudication.',
    `prior_member_enrollment_id` BIGINT COMMENT 'Self-referencing FK on member_enrollment (prior_member_enrollment_id)',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network associated with this enrollment. Determines in-network vs out-of-network benefits.',
    `benefit_period_end_date` DATE COMMENT 'End date of the benefit period for deductible and out-of-pocket maximum tracking. Resets accumulators for next period.',
    `benefit_period_start_date` DATE COMMENT 'Start date of the benefit period for deductible and out-of-pocket maximum tracking. Typically calendar year or plan year.',
    `cobra_indicator` BOOLEAN COMMENT 'Indicates whether this enrollment is a COBRA continuation coverage following employment termination.',
    `cobra_qualifying_event_date` DATE COMMENT 'Date of the qualifying event that triggered COBRA eligibility (e.g., employment termination, divorce). Nullable for non-COBRA enrollments.',
    `coverage_tier` STRING COMMENT 'Coverage tier indicating the scope of family members covered under this enrollment. Affects premium calculation.. Valid values are `individual|individual_plus_spouse|individual_plus_children|family`',
    `eligibility_verification_date` DATE COMMENT 'Date when member eligibility was last verified with the payer. Used for real-time eligibility checks.',
    `eligibility_verification_status` STRING COMMENT 'Status of the most recent eligibility verification attempt. Used to flag potential coverage issues.. Valid values are `verified|pending|failed|not_verified`',
    `enrollment_channel` STRING COMMENT 'Channel or interface through which the member completed the enrollment process.. Valid values are `web|mobile|phone|mail|in_person|broker`',
    `enrollment_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in the system. Used for audit and data lineage tracking.',
    `enrollment_effective_date` DATE COMMENT 'Date when the member coverage becomes effective and benefits are available. Used for eligibility determination.',
    `enrollment_notes` STRING COMMENT 'Free-text notes or comments related to this enrollment. Used for documenting special circumstances or exceptions.',
    `enrollment_source` STRING COMMENT 'Source system or channel through which the enrollment was initiated. [ENUM-REF-CANDIDATE: employer_group|aca_exchange|medicare_cms|medicaid_agency|direct_enrollment|broker|navigator|other — promote to reference product]',
    `enrollment_source_system` STRING COMMENT 'Name of the source system that originated this enrollment record. Used for data lineage and reconciliation.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the member enrollment. Used for eligibility verification and claim adjudication.. Valid values are `active|pending|suspended|terminated|cancelled`',
    `enrollment_termination_date` DATE COMMENT 'Date when the member coverage ends and benefits are no longer available. Nullable for active enrollments.',
    `enrollment_type` STRING COMMENT 'Type of enrollment event that initiated this coverage. Determines eligibility rules and enrollment period constraints.. Valid values are `open_enrollment|special_enrollment|auto_enrollment|cobra|medicare|medicaid`',
    `enrollment_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was last modified. Used for audit and change tracking.',
    `group_number` STRING COMMENT 'Employer or sponsor group number under which the member is enrolled. Used to identify the benefit group and premium structure.',
    `last_premium_payment_date` DATE COMMENT 'Date of the most recent premium payment received for this enrollment. Used for grace period and termination calculations.',
    `medicaid_number` STRING COMMENT 'State-assigned Medicaid identifier for dual-eligible members. Used for coordination of benefits and claim adjudication.',
    `medicare_part_a_effective_date` DATE COMMENT 'Effective date of Medicare Part A coverage for dual-eligible members. Used for coordination of benefits.',
    `medicare_part_b_effective_date` DATE COMMENT 'Effective date of Medicare Part B coverage for dual-eligible members. Used for coordination of benefits.',
    `pcp_assignment_date` DATE COMMENT 'Date when the primary care physician was assigned to this member. Used for continuity of care tracking.',
    `premium_amount` DECIMAL(18,2) COMMENT 'Monthly premium amount for this member enrollment. May be employer-paid, member-paid, or split.',
    `premium_payment_frequency` STRING COMMENT 'Frequency at which premium payments are due for this enrollment.. Valid values are `monthly|quarterly|annual|biweekly`',
    `premium_payment_status` STRING COMMENT 'Current status of premium payments for this enrollment. Affects coverage eligibility and claim payment.. Valid values are `current|past_due|grace_period|suspended|terminated`',
    `relationship_to_subscriber` STRING COMMENT 'Relationship of the member to the primary subscriber. Determines dependent status and coverage eligibility rules.. Valid values are `self|spouse|child|domestic_partner|other_dependent`',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Monthly premium subsidy or tax credit amount applied to this enrollment. Applicable for ACA marketplace plans.',
    `subsidy_type` STRING COMMENT 'Type of premium subsidy or cost-sharing reduction applied to this enrollment. APTC = Advanced Premium Tax Credit, CSR = Cost-Sharing Reduction.. Valid values are `aptc|csr|medicaid|chip|none`',
    `termination_reason` STRING COMMENT 'Reason for enrollment termination. [ENUM-REF-CANDIDATE: voluntary_disenrollment|employment_termination|loss_of_eligibility|non_payment|death|medicare_eligibility|medicaid_eligibility|plan_discontinuation|other — promote to reference product]',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `vibe_mutation_marker` STRING COMMENT '',
    CONSTRAINT pk_member_enrollment PRIMARY KEY(`member_enrollment_id`)
) COMMENT 'Transactional record of a members enrollment into a specific health plan, capturing the full enrollment lifecycle from initial enrollment through termination. Captures member ID (subscriber ID), payer ID, health plan ID, group number, subscriber vs dependent relationship, enrollment type (open enrollment, special enrollment period, auto-enrollment, COBRA), enrollment effective date, termination date, termination reason, premium amount, premium payment status, benefit period, and enrollment source (employer group, exchange, Medicaid agency, Medicare CMS). SSOT for member plan enrollment referenced by eligibility verification and claim adjudication.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` (
    `subscriber_id` BIGINT COMMENT 'Unique identifier for the subscriber record. Primary key. The subscriber is the primary insured individual (policyholder) who holds the insurance contract with the payer and is responsible for premium payment.',
    `health_plan_id` BIGINT COMMENT 'Reference to the specific health plan product under which this subscriber is enrolled. Links to the plan master in the insurance domain.',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Subscriber-to-patient identity reconciliation is required for dual-eligible identification, care coordination, and population health management. Health systems must know when a subscriber is also a pa',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer (health plan) that issued this subscriber contract. Links to the payer master in the insurance domain.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: subscriber.primary_care_physician_npi is a denormalized plain column. Replacing it with a proper FK to clinician supports PCP panel management, care coordination, and HEDIS PCP attribution reporting —',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Subscriber PCP assignment requires linking to the authoritative NPI registry for provider directory validation, PCP panel management, and care coordination reporting. primary_care_physician_npi is a d',
    `prior_subscriber_id` BIGINT COMMENT 'Self-referencing FK on subscriber (prior_subscriber_id)',
    `address_line_1` STRING COMMENT 'Primary street address line for the subscribers residence.',
    `address_line_2` STRING COMMENT 'Secondary address line (apartment, suite, unit number) for the subscribers residence.',
    `city` STRING COMMENT 'City of the subscribers residence.',
    `cobra_eligible_flag` BOOLEAN COMMENT 'Indicates whether the subscriber is eligible for COBRA continuation coverage after employment termination. True=eligible, False=not eligible.',
    `cobra_end_date` DATE COMMENT 'Date when COBRA continuation coverage ends, if applicable. Null if not on COBRA or coverage is ongoing.',
    `cobra_start_date` DATE COMMENT 'Date when COBRA continuation coverage began, if applicable. Null if not on COBRA.',
    `country_code` STRING COMMENT 'Three-letter ISO country code of the subscribers residence. Typically USA for US-based subscribers.. Valid values are `USA|CAN|MEX`',
    `coverage_status` STRING COMMENT 'Current lifecycle status of the subscribers coverage. Active=currently covered, Inactive=coverage lapsed, Suspended=temporarily paused, Terminated=permanently ended, Pending=awaiting activation.. Valid values are `active|inactive|suspended|terminated|pending`',
    `coverage_type` STRING COMMENT 'Type of insurance coverage provided under this subscriber contract. Indicates the primary benefit category.. Valid values are `medical|dental|vision|pharmacy|behavioral_health|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this subscriber record was first created in the data platform.',
    `date_of_birth` DATE COMMENT 'Date of birth of the subscriber. Used for eligibility verification and age-based benefit determination.',
    `dual_eligible_flag` BOOLEAN COMMENT 'Indicates whether the subscriber is dually eligible for both Medicare and Medicaid. True=dual eligible, False=not dual eligible. Critical for coordination of benefits and cost-sharing determination.',
    `effective_end_date` DATE COMMENT 'Date when the subscribers coverage terminates. Null for open-ended active coverage.',
    `effective_start_date` DATE COMMENT 'Date when the subscribers coverage becomes effective and benefits are available.',
    `email_address` STRING COMMENT 'Email address for subscriber communication and electronic correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Legal first name of the subscriber as registered with the payer.',
    `gender` STRING COMMENT 'Administrative gender of the subscriber. M=Male, F=Female, U=Unknown, O=Other.. Valid values are `M|F|U|O`',
    `group_number` STRING COMMENT 'Employer or sponsor group number under which the subscriber is enrolled. Used for group billing and benefit determination.',
    `last_name` STRING COMMENT 'Legal last name (family name) of the subscriber as registered with the payer.',
    `medicaid_eligible_flag` BOOLEAN COMMENT 'Indicates whether the subscriber is eligible for Medicaid coverage. True=eligible, False=not eligible. Used for coordination of benefits and dual eligibility determination.',
    `medicaid_number` STRING COMMENT 'State-issued Medicaid identification number, if the subscriber is Medicaid-eligible. Used for coordination of benefits.',
    `medicare_eligible_flag` BOOLEAN COMMENT 'Indicates whether the subscriber is eligible for Medicare coverage. True=eligible, False=not eligible. Used for coordination of benefits.',
    `medicare_number` STRING COMMENT 'Medicare Beneficiary Identifier (MBI) assigned by CMS, if the subscriber is Medicare-eligible. Used for coordination of benefits between Medicare and commercial insurance.',
    `middle_name` STRING COMMENT 'Middle name or initial of the subscriber, if provided.',
    `network_tier` STRING COMMENT 'Network tier or level assigned to the subscribers plan. Determines cost-sharing and provider access levels.. Valid values are `in_network|out_of_network|preferred|standard`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the subscriber.',
    `postal_code` STRING COMMENT 'ZIP code or postal code of the subscribers residence.',
    `premium_amount` DECIMAL(18,2) COMMENT 'Monthly or periodic premium amount the subscriber is responsible for paying. Amount in USD.',
    `premium_frequency` STRING COMMENT 'Frequency at which the subscriber pays premiums.. Valid values are `monthly|quarterly|annual|biweekly`',
    `relationship_to_insured` STRING COMMENT 'Relationship of the subscriber to the primary insured. For subscriber records, this is typically self since the subscriber IS the insured party. Used when subscriber may be a dependent on another policy.. Valid values are `self|spouse|child|other`',
    `source_system_code` STRING COMMENT 'Unique identifier for this subscriber in the source system. Used for data lineage and reconciliation.',
    `ssn` STRING COMMENT 'Social Security Number of the subscriber. Stored in masked or encrypted format per HIPAA security requirements. Used for identity verification and coordination of benefits.',
    `state` STRING COMMENT 'State or province of the subscribers residence. Two-letter state code for US addresses.',
    `suffix` STRING COMMENT 'Name suffix of the subscriber (Jr, Sr, II, III, etc.), if applicable.. Valid values are `Jr|Sr|II|III|IV|V`',
    `termination_reason` STRING COMMENT 'Reason for coverage termination, if applicable. Null for active coverage.. Valid values are `voluntary|non_payment|employment_ended|death|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this subscriber record was last updated in the data platform.',
    `vibe_mutation_marker` STRING COMMENT '',
    CONSTRAINT pk_subscriber PRIMARY KEY(`subscriber_id`)
) COMMENT 'Master record for the primary insured individual (subscriber/policyholder) who holds the insurance contract with the payer. Distinct from the patient master (patient.mpi_record) — the subscriber is the contractual party responsible for premium payment and may or may not be a patient. Captures subscriber ID (member ID), payer-assigned subscriber number, subscriber name, date of birth, gender, SSN (masked), employer group, group number, relationship to dependents, premium responsibility, COBRA eligibility status, and Medicare/Medicaid dual eligibility flags. SSOT for the insurance contractual relationship owner.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`dependent` (
    `dependent_id` BIGINT COMMENT 'Unique identifier for the dependent record. Primary key.',
    `clinician_id` BIGINT COMMENT 'Reference to the primary care physician assigned to this dependent for managed care plans.',
    `mpi_record_id` BIGINT COMMENT 'Unique member identifier assigned by the health plan to this dependent for eligibility verification and claims processing.',
    `dependent_mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Dependents are patients with MPI records. Business process: dependent enrollment creates patient identity; clinical care delivery, scheduling, and medical records require linking insurance dependent t',
    `primary_dependent_id` BIGINT COMMENT 'Self-referencing FK on dependent (primary_dependent_id)',
    `subscriber_id` BIGINT COMMENT 'Reference to the primary subscriber under whose health plan this dependent is covered.',
    `address_line_1` STRING COMMENT 'Primary street address line for the dependent.',
    `address_line_2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number.',
    `city` STRING COMMENT 'City of residence for the dependent.',
    `coordination_of_benefits_indicator` BOOLEAN COMMENT 'Indicates whether the dependent has other health insurance coverage requiring coordination of benefits.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the dependents residence.. Valid values are `^[A-Z]{3}$`',
    `coverage_effective_date` DATE COMMENT 'Date when the dependents coverage under the subscribers health plan becomes effective.',
    `coverage_termination_date` DATE COMMENT 'Date when the dependents coverage under the subscribers health plan terminates. Null if coverage is currently active.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dependent record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Date of birth of the dependent, used for age-based eligibility determination and coverage rules.',
    `disability_status` STRING COMMENT 'Indicates whether the dependent has a qualifying disability that extends eligibility beyond standard age or relationship limits.. Valid values are `Disabled|Not Disabled`',
    `disability_verification_date` DATE COMMENT 'Date when the dependents disability status was last verified for extended eligibility purposes.',
    `eligibility_status` STRING COMMENT 'Current eligibility status of the dependent for coverage under the subscribers health plan.. Valid values are `Active|Inactive|Pending|Terminated|Suspended|Deceased`',
    `email_address` STRING COMMENT 'Email address for the dependent for communication and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `enrollment_date` DATE COMMENT 'Date when the dependent was enrolled in the health plan.',
    `enrollment_source` STRING COMMENT 'Source through which the dependent was enrolled in the health plan (e.g., employer, exchange, direct, Medicaid, Medicare, CHIP). [ENUM-REF-CANDIDATE: Employer|Exchange|Direct|Medicaid|Medicare|CHIP|Other — 7 candidates stripped; promote to reference product]',
    `first_name` STRING COMMENT 'Legal first name of the dependent as registered with the health plan.',
    `gender` STRING COMMENT 'Gender of the dependent as recorded for coverage and clinical purposes.. Valid values are `Male|Female|Other|Unknown`',
    `last_eligibility_verification_date` DATE COMMENT 'Date when the dependents eligibility was last verified by the health plan.',
    `last_name` STRING COMMENT 'Legal last name (surname) of the dependent as registered with the health plan.',
    `middle_name` STRING COMMENT 'Middle name or initial of the dependent.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the dependent.. Valid values are `^+?[1-9]d{1,14}$`',
    `postal_code` STRING COMMENT 'ZIP code for the dependents residence.. Valid values are `^d{5}(-d{4})?$`',
    `relationship_type` STRING COMMENT 'Type of relationship between the dependent and the subscriber (e.g., spouse, child, domestic partner, disabled dependent).. Valid values are `Spouse|Child|Domestic Partner|Disabled Dependent|Other`',
    `ssn` STRING COMMENT 'Social Security Number of the dependent for tax reporting and identity verification purposes.. Valid values are `^d{3}-d{2}-d{4}$`',
    `state` STRING COMMENT 'Two-letter state code for the dependents residence.. Valid values are `^[A-Z]{2}$`',
    `student_status` STRING COMMENT 'Indicates whether the dependent is a full-time or part-time student, which may extend eligibility beyond standard age limits (e.g., up to age 26).. Valid values are `Full-Time Student|Part-Time Student|Not a Student`',
    `student_verification_date` DATE COMMENT 'Date when the dependents student status was last verified for eligibility extension purposes.',
    `suffix` STRING COMMENT 'Name suffix for the dependent (e.g., Jr, Sr, II, III).. Valid values are `Jr|Sr|II|III|IV|V`',
    `termination_reason` STRING COMMENT 'Reason for termination of the dependents coverage (e.g., aging off at 26, divorce, loss of eligibility, death).. Valid values are `Aged Out|Divorce|Loss of Eligibility|Death|Voluntary Termination|Other`',
    `tobacco_use_indicator` BOOLEAN COMMENT 'Indicates whether the dependent uses tobacco products, which may affect premium calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the dependent record was last updated in the system.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `vibe_mutation_marker` STRING COMMENT '',
    CONSTRAINT pk_dependent PRIMARY KEY(`dependent_id`)
) COMMENT 'Master record for individuals covered under a subscribers health plan as dependents, including spouses, domestic partners, and children. Captures dependent ID, subscriber ID, dependent name, date of birth, gender, relationship type (spouse, child, domestic partner, disabled dependent), dependent eligibility status, coverage effective date, termination date, termination reason (aging off at 26, divorce, loss of eligibility), and student status for age-extension eligibility. Enables accurate member-level eligibility verification and COB determination for dependents.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` (
    `payer_contract_id` BIGINT COMMENT 'Unique identifier for the payer contract record. Primary key for the payer contract entity.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Solo practitioners and direct-pay clinicians contract individually with payers — not through a group or org_provider. payer_contract already has group_id and org_provider_id; adding clinician_id compl',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.provider_group. Business justification: Contracts executed with provider groups for network participation, VBC arrangements, and group-level reimbursement. Essential for contract management, payment reconciliation, and network operations. C',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Contracts executed with organizational providers for facility network participation and hospital reimbursement. Critical for facility contract management, claims pricing, and network adequacy. Creatin',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer organization that is party to this contract.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to insurance.provider_network. Business justification: A payer contract is negotiated between a provider organization and a payer for participation in a specific provider network. The payer_contract already has network_tier (string) but lacks a direct FK ',
    `renewed_payer_contract_id` BIGINT COMMENT 'Self-referencing FK on payer_contract (renewed_payer_contract_id)',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Contracts specify covered specialties and carve-outs (e.g., behavioral health carved out, oncology specialty contract). Critical for network adequacy planning, specialty-specific rate negotiations, an',
    `amendment_count` STRING COMMENT 'Number of amendments or modifications made to this contract since its original execution.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this contract automatically renews at the end of its term unless either party provides notice of termination.',
    `base_reimbursement_percentage` DECIMAL(18,2) COMMENT 'The baseline percentage rate applied to charges or fee schedules for reimbursement calculation (e.g., 110% of Medicare rates). Null if reimbursement method is not percentage-based.',
    `carve_out_services` STRING COMMENT 'Description or list of services explicitly excluded from this contract and reimbursed under separate arrangements (e.g., behavioral health, pharmacy, transplant services).',
    `claims_submission_method` STRING COMMENT 'The method by which claims under this contract must be submitted to the payer for adjudication.. Valid values are `electronic|paper|portal|clearinghouse`',
    `contract_administrator_email` STRING COMMENT 'Email address of the internal contract administrator for operational communication regarding this contract.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contract_administrator_name` STRING COMMENT 'Name of the internal staff member or department responsible for managing and administering this payer contract.',
    `contract_document_location` STRING COMMENT 'File path, URL, or document management system reference to the signed contract document for audit and reference purposes.',
    `contract_name` STRING COMMENT 'Human-readable name or title of the payer contract for identification and reporting purposes.',
    `contract_number` STRING COMMENT 'The externally-known unique business identifier for this payer contract, used in communications with the payer and internal revenue cycle operations.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the payer contract. Draft indicates contract under negotiation; pending approval awaiting internal or payer sign-off; active means contract is in force; suspended indicates temporary hold; terminated means contract ended before expiration; expired means contract reached its end date.. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `contract_type` STRING COMMENT 'Classification of the reimbursement model governing this contract. Fee-for-service pays per service rendered; capitation pays a fixed amount per member per month; bundled payment covers an episode of care; shared savings rewards cost reduction; pay-for-performance (P4P) ties payment to quality metrics; value-based combines quality and cost outcomes.. Valid values are `fee_for_service|capitation|bundled_payment|shared_savings|pay_for_performance|value_based`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payer contract record was first created in the system.',
    `credentialing_required` BOOLEAN COMMENT 'Indicates whether individual providers must be credentialed and enrolled with the payer to bill under this contract.',
    `effective_date` DATE COMMENT 'The date on which this payer contract becomes binding and reimbursement terms take effect.',
    `fee_schedule_reference` STRING COMMENT 'Reference identifier to the base fee schedule or rate table that governs reimbursement rates for services under this contract (e.g., Medicare Fee Schedule, custom negotiated rates).',
    `geographic_coverage` STRING COMMENT 'Description of the geographic region or service area covered by this contract (e.g., statewide, multi-state, specific counties).',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to this contract.',
    `network_tier` STRING COMMENT 'The tier or level of this provider within the payers network, affecting member cost-sharing and reimbursement rates. Tier 1 typically offers lowest member cost-sharing; out-of-network highest.. Valid values are `tier_1|tier_2|tier_3|preferred|standard|out_of_network`',
    `notes` STRING COMMENT 'Free-text field for additional notes, special provisions, or operational guidance related to this payer contract.',
    `payment_terms_days` STRING COMMENT 'Number of days within which the payer is contractually obligated to remit payment after claim adjudication.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required for certain services under this contract before services are rendered.',
    `quality_bonus_eligible` BOOLEAN COMMENT 'Indicates whether this contract includes provisions for quality-based bonus payments tied to performance metrics such as Healthcare Effectiveness Data and Information Set (HEDIS) scores or Merit-based Incentive Payment System (MIPS) performance.',
    `quality_measure_set` STRING COMMENT 'Identifier or name of the quality measure set or program used to evaluate performance under this contract (e.g., HEDIS, MIPS, hospital-acquired infection rates).',
    `quality_penalty_eligible` BOOLEAN COMMENT 'Indicates whether this contract includes provisions for quality-based penalties or payment reductions for failure to meet performance thresholds.',
    `reconciliation_frequency` STRING COMMENT 'The frequency at which financial reconciliation and settlement occurs between provider and payer for shared savings, risk adjustments, or quality bonuses.. Valid values are `monthly|quarterly|semi_annually|annually|none`',
    `regulatory_filing_reference` STRING COMMENT 'Reference number or identifier assigned by the regulatory body for this contracts filing or approval.',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this contract must be filed with state insurance departments or other regulatory bodies for approval or compliance purposes.',
    `reimbursement_method` STRING COMMENT 'The calculation method used to determine payment amounts. Percent of charges pays a percentage of billed charges; percent of Medicare pays a percentage of Medicare rates; flat rate is a fixed amount per service; per diem is a daily rate; case rate is a fixed amount per case; DRG-based uses Diagnosis-Related Group rates; capitation is a fixed per-member-per-month amount. [ENUM-REF-CANDIDATE: percent_of_charges|percent_of_medicare|flat_rate|per_diem|case_rate|drg_based|capitation — 7 candidates stripped; promote to reference product]',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required to terminate or renegotiate the contract before auto-renewal occurs.',
    `risk_arrangement_type` STRING COMMENT 'Defines the financial risk-sharing model between provider and payer. No risk means traditional fee-for-service; upside only allows provider to share in savings; downside only exposes provider to penalties; two-sided risk includes both savings and penalties; full risk transfers all financial risk to provider.. Valid values are `no_risk|upside_only|downside_only|two_sided_risk|full_risk`',
    `state_code` STRING COMMENT 'Two-letter state code indicating the primary state jurisdiction for this contract.',
    `stop_loss_threshold_amount` DECIMAL(18,2) COMMENT 'The dollar amount threshold above which stop-loss or reinsurance provisions apply, protecting the provider or payer from catastrophic claims costs. Null if no stop-loss provision exists.',
    `termination_date` DATE COMMENT 'The date on which this payer contract ends or is scheduled to end. Null for open-ended contracts or contracts with auto-renewal.',
    `timely_filing_limit_days` STRING COMMENT 'Number of days from date of service within which claims must be submitted to the payer to be considered timely filed and eligible for reimbursement.',
    `updated_by` STRING COMMENT 'User identifier or name of the person who last updated this payer contract record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this payer contract record was last modified in the system.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `vibe_mutation_marker` STRING COMMENT '',
    CONSTRAINT pk_payer_contract PRIMARY KEY(`payer_contract_id`)
) COMMENT 'Master record for negotiated contracts between the healthcare organization (provider) and insurance payers, defining reimbursement terms, fee schedules, value-based care arrangements, and contractual obligations. Captures contract number, payer ID, contract type (fee-for-service, capitation, bundled payment, shared savings, P4P — Pay for Performance), contract effective date, termination date, auto-renewal terms, base fee schedule reference, carve-out provisions, quality bonus/penalty terms, risk arrangement type, and contract status. SSOT for provider-payer contractual relationships governing reimbursement.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` (
    `fee_schedule_id` BIGINT COMMENT 'Unique identifier for the fee schedule record. Primary key.',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Fee schedules in healthcare are frequently plan-specific — a payer may negotiate different reimbursement rates for different health plan products (e.g., HMO vs PPO vs Medicare Advantage). While fee_sc',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Hospitals and facilities negotiate facility-specific fee schedules (facility rates vs. professional rates) directly with payers. fee_schedule has facility_type as a plain attribute but no FK to the sp',
    `payer_contract_id` BIGINT COMMENT 'Reference to the provider-payer contract under which this fee schedule is defined. Links to the contract master entity.',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer or health plan that owns this fee schedule. Links to the payer master entity.',
    `primary_predecessor_schedule_fee_schedule_id` BIGINT COMMENT 'Reference to the previous version of this fee schedule, enabling version history tracking and audit trails.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to insurance.provider_network. Business justification: Fee schedules are network-specific — in-network and out-of-network rates are distinct schedules. The fee_schedule has network_tier (string) but no direct FK to the provider_network master. Adding prov',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Fee schedules vary by specialty for differential reimbursement (primary care vs subspecialty rates, surgical vs medical specialties). Essential for specialty-specific contract rates and claims pricing',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to provider.provider_taxonomy. Business justification: Fee schedules reference taxonomy codes for provider type-specific rates (e.g., different rates for MD vs NP, different facility rates by type). Critical for accurate claims pricing and contract compli',
    `annual_inflation_rate` DECIMAL(18,2) COMMENT 'The annual percentage rate applied for inflation adjustments, if applicable. Expressed as a decimal (e.g., 3.50 for 3.5%).',
    `approval_date` DATE COMMENT 'The date on which this fee schedule was formally approved for implementation.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or authority who approved this fee schedule for use.',
    `authorization_required` BOOLEAN COMMENT 'Indicates whether services under this fee schedule require prior authorization before rendering care.',
    `billed_charges_percentage` DECIMAL(18,2) COMMENT 'The percentage of billed charges used as the basis for reimbursement when rate_basis is percent_of_billed_charges. Expressed as a decimal (e.g., 80.00 for 80% of billed charges).',
    `carve_out_services` STRING COMMENT 'Description of services explicitly excluded or carved out from this fee schedule, to be reimbursed under separate arrangements.',
    `claims_submission_method` STRING COMMENT 'The required method for submitting claims under this fee schedule: electronic (EDI), paper, web portal, or clearinghouse.. Valid values are `electronic|paper|portal|clearinghouse`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fee schedule record was first created in the system.',
    `effective_date` DATE COMMENT 'The date on which this fee schedule becomes active and applicable for reimbursement calculations.',
    `facility_type` STRING COMMENT 'The type of healthcare facility to which this fee schedule applies: inpatient, outpatient, ambulatory surgery center (ASC), skilled nursing facility (SNF), home health, or hospice.. Valid values are `inpatient|outpatient|ambulatory_surgery_center|skilled_nursing_facility|home_health|hospice`',
    `fee_schedule_status` STRING COMMENT 'Current lifecycle status of the fee schedule: draft (under development), active (in use), suspended (temporarily inactive), terminated (ended by agreement), expired (past termination date), or pending approval (awaiting authorization).. Valid values are `draft|active|suspended|terminated|expired|pending_approval`',
    `filing_reference_number` STRING COMMENT 'The reference number assigned by the regulatory authority when this fee schedule was filed for approval.',
    `geographic_adjustment_factor` DECIMAL(18,2) COMMENT 'Geographic adjustment factor applied to base rates to account for regional cost variations. Based on CMS Geographic Practice Cost Index (GPCI) methodology.',
    `geographic_scope` STRING COMMENT 'The geographic applicability of the fee schedule: national, regional, state-level, county-level, zip code-level, or facility-specific.. Valid values are `national|regional|state|county|zip_code|facility_specific`',
    `inflation_adjustment_method` STRING COMMENT 'The method used for annual inflation adjustments to fee schedule rates: Consumer Price Index (CPI), Medical CPI, fixed percentage, none, or custom methodology.. Valid values are `cpi|medical_cpi|fixed_percentage|none|custom`',
    `interest_penalty_rate` DECIMAL(18,2) COMMENT 'The annual interest rate applied to late payments as a penalty for exceeding payment terms. Expressed as a decimal (e.g., 10.00 for 10%).',
    `locality_code` STRING COMMENT 'CMS locality code used for Medicare geographic adjustment purposes, defining the specific payment locality.',
    `medicare_percentage` DECIMAL(18,2) COMMENT 'The percentage of Medicare allowable rates used as the basis for reimbursement when rate_basis is percent_of_medicare. Expressed as a decimal (e.g., 110.00 for 110% of Medicare).',
    `network_tier` STRING COMMENT 'The provider network tier to which this fee schedule applies: tier 1 (highest reimbursement), tier 2, tier 3, preferred, standard, or out-of-network.. Valid values are `tier_1|tier_2|tier_3|preferred|standard|out_of_network`',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the fee schedule.',
    `outlier_payment_threshold` DECIMAL(18,2) COMMENT 'The cost threshold above which outlier payments are triggered for exceptionally high-cost cases, typically in DRG-based reimbursement.',
    `payment_terms_days` STRING COMMENT 'The number of days within which the payer is contractually obligated to remit payment after receiving a clean claim.',
    `quality_adjustment_percentage` DECIMAL(18,2) COMMENT 'The maximum percentage adjustment (positive or negative) that can be applied to base rates based on quality performance metrics.',
    `quality_incentive_eligible` BOOLEAN COMMENT 'Indicates whether this fee schedule is eligible for quality-based incentive payments under value-based purchasing or pay-for-performance programs.',
    `rate_basis` STRING COMMENT 'The methodology used to determine reimbursement rates: percentage of Medicare rates, percentage of billed charges, case rate, per diem, fee-for-service, or capitation.. Valid values are `percent_of_medicare|percent_of_billed_charges|case_rate|per_diem|fee_for_service|capitation`',
    `regulatory_filing_required` BOOLEAN COMMENT 'Indicates whether this fee schedule must be filed with state insurance regulators or other governing bodies for approval.',
    `reimbursement_model` STRING COMMENT 'The payment model under which this fee schedule operates: fee-for-service, bundled payment, value-based, shared savings, capitation, or per diem.. Valid values are `fee_for_service|bundled_payment|value_based|shared_savings|capitation|per_diem`',
    `schedule_code` STRING COMMENT 'Unique alphanumeric code assigned to the fee schedule for system identification and cross-referencing.',
    `schedule_name` STRING COMMENT 'Business-friendly name or title of the fee schedule, used for identification and reporting purposes.',
    `schedule_type` STRING COMMENT 'Classification of the fee schedule by service category: professional services, facility services, durable medical equipment (DME), laboratory, pharmacy, or radiology.. Valid values are `professional|facility|dme|laboratory|pharmacy|radiology`',
    `service_category` STRING COMMENT 'Broad classification of services covered by this fee schedule (e.g., surgical, medical, diagnostic, preventive, behavioral health).',
    `state_code` STRING COMMENT 'Two-letter state code indicating the primary state jurisdiction for this fee schedule, if applicable.',
    `stop_loss_threshold` DECIMAL(18,2) COMMENT 'The dollar amount threshold above which stop-loss provisions apply, limiting payer liability for high-cost cases.',
    `termination_date` DATE COMMENT 'The date on which this fee schedule expires or is terminated. Null indicates an open-ended schedule.',
    `timely_filing_limit_days` STRING COMMENT 'The number of days from the date of service within which claims must be submitted to be considered timely filed.',
    `updated_by` STRING COMMENT 'Identifier of the user or system process that last updated this fee schedule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this fee schedule record was last modified.',
    `version_number` STRING COMMENT 'Version identifier for the fee schedule, used to track revisions and amendments over time.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `vibe_mutation_marker` STRING COMMENT '',
    CONSTRAINT pk_fee_schedule PRIMARY KEY(`fee_schedule_id`)
) COMMENT 'Master record for payer-specific reimbursement fee schedules defining the contracted payment rates for procedures, services, and supplies. Captures fee schedule name, payer ID, contract ID, fee schedule type (professional, facility, DME, lab, pharmacy), effective date, termination date, geographic adjustment factor (GPCI), and the basis for rates (% of Medicare, % of billed charges, case rate, per diem). Parent entity for fee schedule line items. Supports contract modeling, underpayment detection, and revenue cycle optimization.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` (
    `fee_schedule_line_id` BIGINT COMMENT 'Unique identifier for the fee schedule line item record. Primary key for this entity.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Fee schedule lines define contracted reimbursement rates per CPT code for professional services pricing. Payer contract management and provider reimbursement reporting require linking each rate line t',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Fee schedules include DRG-based case rates for inpatient hospital reimbursement. Essential for hospital claims pricing, bundled payment calculation, and value-based contract administration in payer sy',
    `fee_schedule_id` BIGINT COMMENT 'Reference to the parent fee schedule contract that contains this line item. Links this rate to the overall fee schedule agreement.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Fee schedules include HCPCS rates for DME, supplies, and ancillary services. Essential for claims auto-pricing, provider reimbursement calculation, and contract rate validation in payer financial syst',
    `primary_superseded_by_fee_schedule_line_id` BIGINT COMMENT 'Reference to the fee_schedule_line_id that replaces this line when status is superseded. Enables tracking of rate history and lineage.',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: fee_schedule_line.specialty_code is a denormalized plain column. A single fee schedule can contain different rates by specialty (e.g., cardiology vs. primary care rates on the same payer contract). A ',
    `anesthesia_base_units` DECIMAL(18,2) COMMENT 'For anesthesia services, the base unit value assigned to the procedure used in calculating anesthesia reimbursement (base units + time units + modifying units) × conversion factor.',
    `assistant_surgeon_allowed` BOOLEAN COMMENT 'Indicates whether an assistant surgeon is allowed for this procedure and will be separately reimbursed according to the fee schedule.',
    `authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required from the payer before performing this service at the contracted rate. True means authorization is mandatory.',
    `bilateral_indicator` STRING COMMENT 'Indicates whether the procedure can be performed bilaterally (on both sides of the body) and how it affects reimbursement.. Valid values are `not_applicable|bilateral_surgery|unilateral_surgery`',
    `bundled_indicator` BOOLEAN COMMENT 'Indicates whether this procedure code is part of a bundled payment arrangement where multiple services are reimbursed as a single package. True means this is bundled.',
    `case_rate_amount` DECIMAL(18,2) COMMENT 'When rate_basis is case_rate, this field contains the bundled payment amount for an entire episode of care or procedure (e.g., DRG-based payment, bundled surgical package).',
    `contract_reference_number` STRING COMMENT 'External reference number or identifier linking this fee schedule line to the source contract document or agreement section.',
    `contracted_rate_amount` DECIMAL(18,2) COMMENT 'The negotiated reimbursement amount for this specific procedure code and modifier combination. Represents the dollar amount the payer will reimburse for the service.',
    `conversion_factor` DECIMAL(18,2) COMMENT 'The dollar multiplier applied to total RVUs to calculate the contracted rate amount. For example, if total RVU is 2.5 and conversion factor is $40.00, the rate is $100.00.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fee schedule line record was first created in the system. Part of audit trail.',
    `effective_date` DATE COMMENT 'The date on which this fee schedule line item becomes active and applicable for reimbursement calculations. Part of the temporal validity period.',
    `facility_type` STRING COMMENT 'Classification of the facility setting where the service is rendered, affecting reimbursement methodology and rates. [ENUM-REF-CANDIDATE: inpatient|outpatient|ambulatory_surgery|emergency|skilled_nursing|home_health|hospice — 7 candidates stripped; promote to reference product]',
    `fee_schedule_line_status` STRING COMMENT 'Current lifecycle status of the fee schedule line item: active (in use), inactive (not in use), pending (approved but not yet effective), superseded (replaced by newer version), expired (past termination date), or suspended (temporarily disabled).. Valid values are `active|inactive|pending|superseded|expired|suspended`',
    `geographic_modifier` STRING COMMENT 'Two-digit code representing the geographic locality for Medicare GPCI adjustments. Used to adjust RVU-based payments for regional cost variations.. Valid values are `^[0-9]{2}$`',
    `global_period_days` STRING COMMENT 'Number of days in the global surgical period during which follow-up care is included in the procedure payment and not separately reimbursable. Common values are 0, 10, or 90 days.',
    `line_number` STRING COMMENT 'Sequential line number within the parent fee schedule, used for ordering and reference purposes.',
    `maximum_reimbursement` DECIMAL(18,2) COMMENT 'The ceiling amount for reimbursement regardless of calculation method. Caps the payment level for the service.',
    `minimum_reimbursement` DECIMAL(18,2) COMMENT 'The floor amount for reimbursement regardless of calculation method. Ensures a minimum payment level for the service.',
    `modifier_1` STRING COMMENT 'Primary two-character CPT or HCPCS modifier that provides additional information about the service performed, affecting reimbursement calculation.. Valid values are `^[0-9A-Z]{2}$`',
    `modifier_2` STRING COMMENT 'Secondary two-character CPT or HCPCS modifier providing additional service context.. Valid values are `^[0-9A-Z]{2}$`',
    `modifier_3` STRING COMMENT 'Tertiary two-character CPT or HCPCS modifier providing additional service context.. Valid values are `^[0-9A-Z]{2}$`',
    `modifier_4` STRING COMMENT 'Quaternary two-character CPT or HCPCS modifier providing additional service context.. Valid values are `^[0-9A-Z]{2}$`',
    `multiple_procedure_reduction` DECIMAL(18,2) COMMENT 'Percentage reduction applied when multiple procedures are performed in the same session (e.g., 50.00 means second procedure is reimbursed at 50% of the fee schedule rate).',
    `notes` STRING COMMENT 'Free-text field for additional information, special instructions, or clarifications about this fee schedule line item (e.g., carve-outs, special conditions, negotiation context).',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'When rate_basis is per_diem, this field contains the daily rate amount for inpatient or long-term care services.',
    `percent_of_charges` DECIMAL(18,2) COMMENT 'When rate_basis is percent_of_charges, this field contains the percentage multiplier applied to the providers billed charges (e.g., 65.00 means 65% of charges).',
    `percent_of_medicare` DECIMAL(18,2) COMMENT 'When rate_basis is percent_of_medicare, this field contains the percentage multiplier applied to the Medicare allowable amount (e.g., 110.00 means 110% of Medicare rates).',
    `place_of_service_code` STRING COMMENT 'Two-digit code identifying the physical location where the service was rendered (e.g., 11=Office, 21=Inpatient Hospital, 22=Outpatient Hospital, 23=Emergency Department). Affects reimbursement rates.. Valid values are `^[0-9]{2}$`',
    `quality_reporting_required` BOOLEAN COMMENT 'Indicates whether quality measure reporting is required for this service as part of value-based payment programs (e.g., MIPS, APM).',
    `rate_basis` STRING COMMENT 'The methodology used to calculate the contracted rate: flat_rate (fixed dollar amount), rvu_based (Relative Value Unit multiplied by conversion factor), percent_of_charges (percentage of billed charges), percent_of_medicare (percentage of Medicare allowable), per_diem (daily rate), case_rate (bundled payment), or stop_loss (threshold-based). [ENUM-REF-CANDIDATE: flat_rate|rvu_based|percent_of_charges|percent_of_medicare|per_diem|case_rate|stop_loss — 7 candidates stripped; promote to reference product]',
    `rate_version` STRING COMMENT 'Version number tracking changes to this specific fee schedule line over time. Increments with each rate update or modification.',
    `revenue_code` STRING COMMENT 'Four-digit revenue code used primarily for facility billing (UB-04 claims) to classify the type of service or accommodation provided. Used in conjunction with procedure codes for hospital outpatient and inpatient services.. Valid values are `^[0-9]{4}$`',
    `rvu_malpractice` DECIMAL(18,2) COMMENT 'The malpractice component of the RVU representing professional liability insurance costs associated with the service.',
    `rvu_practice_expense` DECIMAL(18,2) COMMENT 'The practice expense component of the RVU representing overhead costs (staff, supplies, equipment) associated with providing the service.',
    `rvu_total` DECIMAL(18,2) COMMENT 'The total RVU value calculated as the sum of work, practice expense, and malpractice components. Used with conversion factor to determine reimbursement.',
    `rvu_work` DECIMAL(18,2) COMMENT 'The work component of the Relative Value Unit (RVU) representing physician time, skill, and intensity required to perform the service. Used in RVU-based reimbursement calculations.',
    `stop_loss_threshold` DECIMAL(18,2) COMMENT 'When rate_basis is stop_loss, this field contains the dollar threshold above which different reimbursement rules apply (e.g., outlier payments for high-cost cases).',
    `termination_date` DATE COMMENT 'The date on which this fee schedule line item is no longer active for reimbursement. Null indicates the rate is currently active with no planned end date.',
    `updated_by` STRING COMMENT 'Identifier of the user or system process that last updated this record. Supports audit trail and accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fee schedule line record was last modified. Part of audit trail for tracking changes.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `vibe_mutation_marker` STRING COMMENT '',
    CONSTRAINT pk_fee_schedule_line PRIMARY KEY(`fee_schedule_line_id`)
) COMMENT 'Individual line-item rate record within a fee schedule, defining the contracted reimbursement rate for a specific procedure code, service, or supply item. Captures fee schedule ID, procedure code (CPT/HCPCS), modifier applicability, revenue code (for facility), place of service, contracted rate amount, rate basis (flat rate, RVU-based, % of Medicare allowable), RVU value, conversion factor, effective date, and termination date. Enables line-level contract modeling, expected reimbursement calculation, and underpayment variance analysis.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` (
    `prior_auth_rule_id` BIGINT COMMENT 'Unique identifier for the prior authorization rule record. Primary key.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to insurance.benefit. Business justification: Prior authorization rules govern specific benefits within a health plan. A PA rule requiring authorization for a specific service type (e.g., inpatient surgery, specialty drugs) maps directly to a ben',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Prior authorization rules are the operational implementation of coverage policies. A PA rule enforces the medical necessity criteria and authorization requirements defined in a coverage policy. prior_',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Prior authorization rules are defined against specific CPT procedure codes (e.g., PA required for CPT 27447 knee replacement). Payer PA management, utilization management reporting, and CMS compliance',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Prior auth rules are frequently diagnosis-specific — e.g., PA for MRI only when ICD-10 M54.5 low back pain is present. Utilization management and medical necessity determination require linking PA rul',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: Prior auth rules for inpatient admissions are defined at the DRG level (e.g., PA required for DRG 470 major joint replacement). Inpatient utilization management and CMS inpatient PA compliance reporti',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: PA rules govern HCPCS codes for DME, supplies, and specialty drugs. Critical for authorization workflow automation, step therapy enforcement, and utilization management in payer operations.',
    `health_plan_id` BIGINT COMMENT 'Reference to the specific health plan product under which this prior authorization rule applies.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Prior auth rules are frequently facility-specific: certain procedures require PA only at non-accredited or non-trauma-designated facilities. prior_auth_rule already has specialty_id and taxonomy_id; a',
    `payer_id` BIGINT COMMENT 'Reference to the insurance payer organization that enforces this prior authorization requirement.',
    `form_template_id` BIGINT COMMENT 'Foreign key linking to consent.consent_form_template. Business justification: PA rules specify which consent forms must be completed before authorization (e.g., experimental treatment consent, genetic testing consent). Policy enforcement mechanism linking authorization requirem',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Prior authorization rules are specialty-specific (e.g., cardiology procedures, oncology treatments, orthopedic surgery). Critical for PA determination engines and clinical criteria application. Creati',
    `superseded_prior_auth_rule_id` BIGINT COMMENT 'Self-referencing FK on prior_auth_rule (superseded_prior_auth_rule_id)',
    `taxonomy_id` BIGINT COMMENT 'Foreign key linking to provider.provider_taxonomy. Business justification: PA rules reference NUCC taxonomy codes to determine which provider types can perform services (e.g., only board-certified surgeons for certain procedures). Essential for PA auto-adjudication and provi',
    `age_maximum` STRING COMMENT 'Maximum patient age in years for which this prior authorization rule applies. Null if no age restriction.',
    `age_minimum` STRING COMMENT 'Minimum patient age in years for which this prior authorization rule applies. Null if no age restriction.',
    `appeal_process_description` STRING COMMENT 'Description of the process for appealing a prior authorization denial under this rule, including timelines and contact information.',
    `auto_approval_criteria` STRING COMMENT 'Description of the criteria that must be met for automated approval of the prior authorization request.',
    `auto_approval_eligible` BOOLEAN COMMENT 'Indicates whether this prior authorization rule supports automated approval based on predefined criteria without manual review.',
    `clinical_criteria_reference` STRING COMMENT 'Reference to the clinical guideline, medical policy, or evidence-based criteria document that defines the medical necessity standards for this prior authorization rule.',
    `contact_fax` STRING COMMENT 'Payer fax number for prior authorization document submission related to this rule.. Valid values are `^+?[0-9]{10,15}$`',
    `contact_phone` STRING COMMENT 'Payer contact phone number for prior authorization inquiries and submissions related to this rule.. Valid values are `^+?[0-9]{10,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this prior authorization rule record was first created in the system.',
    `documentation_required` STRING COMMENT 'List or description of clinical documentation that must be submitted with the prior authorization request (e.g., chart notes, lab results, imaging reports).',
    `effective_date` DATE COMMENT 'Date on which this prior authorization rule becomes active and enforceable by the payer.',
    `exception_criteria` STRING COMMENT 'Description of circumstances under which exceptions to the prior authorization requirement may be granted (e.g., emergency situations, continuity of care).',
    `frequency_limit` STRING COMMENT 'Maximum number of times the service can be performed within the frequency period without prior authorization. Null if no frequency limit applies.',
    `frequency_limit_period_days` STRING COMMENT 'Time period in days over which the frequency limit is measured. Null if no period applies.',
    `gender_restriction` STRING COMMENT 'Gender-specific applicability of the prior authorization rule. Values: male, female, all (no restriction), or other.. Valid values are `male|female|all|other`',
    `medical_policy_number` STRING COMMENT 'Payer-specific medical policy document number or identifier that governs this prior authorization rule.. Valid values are `^[A-Z0-9-]{5,20}$`',
    `notes` STRING COMMENT 'Free-text field for additional comments, clarifications, or special instructions related to this prior authorization rule.',
    `pa_requirement_type` STRING COMMENT 'Classification of the prior authorization requirement level: required (mandatory PA), not required, clinical review (medical necessity review), peer-to-peer (physician discussion), notification only, or retrospective review.. Valid values are `required|not_required|clinical_review|peer_to_peer|notification_only|retrospective_review`',
    `place_of_service_code` STRING COMMENT 'Two-digit CMS Place of Service code identifying the location where the service is rendered (e.g., 11=office, 21=inpatient hospital, 22=outpatient hospital).. Valid values are `^[0-9]{2}$`',
    `portal_url` STRING COMMENT 'Web address of the payer portal for electronic prior authorization submission, if applicable.. Valid values are `^https?://.*$`',
    `prior_auth_rule_status` STRING COMMENT 'Current lifecycle status of the prior authorization rule: active (in effect), inactive (not enforced), pending (scheduled for activation), suspended (temporarily paused), or retired (permanently discontinued).. Valid values are `active|inactive|pending|suspended|retired`',
    `quantity_limit` DECIMAL(18,2) COMMENT 'Maximum quantity or units of service allowed without prior authorization under this rule. Null if no quantity limit applies.',
    `quantity_limit_period_days` STRING COMMENT 'Time period in days over which the quantity limit is measured (e.g., 30 days, 90 days). Null if no period applies.',
    `regulatory_basis` STRING COMMENT 'Citation of the regulatory or statutory authority that permits or requires this prior authorization rule (e.g., CMS National Coverage Determination, state insurance law).',
    `rule_code` STRING COMMENT 'Unique business identifier code for this prior authorization rule, used for external reference and reporting.. Valid values are `^[A-Z0-9]{4,20}$`',
    `rule_name` STRING COMMENT 'Human-readable descriptive name of the prior authorization rule for display and reporting purposes.',
    `service_category` STRING COMMENT 'Broad classification of the healthcare service type subject to prior authorization (e.g., inpatient, outpatient, surgical, pharmacy, durable medical equipment). [ENUM-REF-CANDIDATE: inpatient|outpatient|emergency|surgical|diagnostic|therapeutic|pharmacy|dme|home_health|behavioral_health — 10 candidates stripped; promote to reference product]',
    `step_therapy_criteria` STRING COMMENT 'Description of the step therapy requirements, including which alternative treatments must be tried first and failure criteria.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether step therapy (trial of alternative treatments before approval) is required as part of the prior authorization criteria.',
    `submission_method` STRING COMMENT 'Allowed method(s) for submitting the prior authorization request: payer portal, fax, phone, EDI 278 transaction, email, or postal mail.. Valid values are `portal|fax|phone|edi_278|email|mail`',
    `termination_date` DATE COMMENT 'Date on which this prior authorization rule is no longer active. Null indicates the rule is currently in effect with no planned end date.',
    `turnaround_time_hours` STRING COMMENT 'Standard turnaround time in hours for the payer to respond to a prior authorization request under this rule.',
    `updated_by` STRING COMMENT 'Identifier of the user or system process that last updated this prior authorization rule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this prior authorization rule record was last modified.',
    `urgent_turnaround_time_hours` STRING COMMENT 'Expedited turnaround time in hours for urgent or emergent prior authorization requests under this rule.',
    `vibe_added_flag` BOOLEAN COMMENT 'Flag added by VIBE mutator to ensure change',
    `vibe_mutation_marker` STRING COMMENT '',
    CONSTRAINT pk_prior_auth_rule PRIMARY KEY(`prior_auth_rule_id`)
) COMMENT 'Master record defining payer-specific prior authorization (PA) requirements for procedures, services, medications, and care settings. Captures payer ID, health plan ID, procedure code (CPT/HCPCS), diagnosis code applicability, service category, place of service, PA requirement type (required, not required, clinical review, peer-to-peer), clinical criteria reference, turnaround time standard (urgent vs standard), submission method (portal, fax, phone, EDI 278), effective date, and termination date. SSOT for PA requirement rules used by utilization management and order authorization workflows.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ADD CONSTRAINT `fk_insurance_payer_parent_payer_id` FOREIGN KEY (`parent_payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ADD CONSTRAINT `fk_insurance_payer_primary_successor_payer_id` FOREIGN KEY (`primary_successor_payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_predecessor_health_plan_id` FOREIGN KEY (`predecessor_health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ADD CONSTRAINT `fk_insurance_health_plan_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ADD CONSTRAINT `fk_insurance_benefit_parent_benefit_id` FOREIGN KEY (`parent_benefit_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ADD CONSTRAINT `fk_insurance_provider_network_parent_network_provider_network_id` FOREIGN KEY (`parent_network_provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ADD CONSTRAINT `fk_insurance_provider_network_parent_provider_network_id` FOREIGN KEY (`parent_provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ADD CONSTRAINT `fk_insurance_provider_network_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ADD CONSTRAINT `fk_insurance_coverage_policy_primary_superseded_by_coverage_policy_id` FOREIGN KEY (`primary_superseded_by_coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_dependent_id` FOREIGN KEY (`dependent_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`dependent`(`dependent_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_prior_member_enrollment_id` FOREIGN KEY (`prior_member_enrollment_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`member_enrollment`(`member_enrollment_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ADD CONSTRAINT `fk_insurance_member_enrollment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ADD CONSTRAINT `fk_insurance_subscriber_prior_subscriber_id` FOREIGN KEY (`prior_subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_primary_dependent_id` FOREIGN KEY (`primary_dependent_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`dependent`(`dependent_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ADD CONSTRAINT `fk_insurance_dependent_subscriber_id` FOREIGN KEY (`subscriber_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`subscriber`(`subscriber_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ADD CONSTRAINT `fk_insurance_payer_contract_renewed_payer_contract_id` FOREIGN KEY (`renewed_payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_payer_contract_id` FOREIGN KEY (`payer_contract_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer_contract`(`payer_contract_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_primary_predecessor_schedule_fee_schedule_id` FOREIGN KEY (`primary_predecessor_schedule_fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ADD CONSTRAINT `fk_insurance_fee_schedule_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ADD CONSTRAINT `fk_insurance_fee_schedule_line_primary_superseded_by_fee_schedule_line_id` FOREIGN KEY (`primary_superseded_by_fee_schedule_line_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`fee_schedule_line`(`fee_schedule_line_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_benefit_id` FOREIGN KEY (`benefit_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`benefit`(`benefit_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_coverage_policy_id` FOREIGN KEY (`coverage_policy_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`coverage_policy`(`coverage_policy_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_health_plan_id` FOREIGN KEY (`health_plan_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`health_plan`(`health_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_payer_id` FOREIGN KEY (`payer_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`payer`(`payer_id`);
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ADD CONSTRAINT `fk_insurance_prior_auth_rule_superseded_prior_auth_rule_id` FOREIGN KEY (`superseded_prior_auth_rule_id`) REFERENCES `vibe_healthcare_v1`.`insurance`.`prior_auth_rule`(`prior_auth_rule_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`insurance` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_healthcare_v1`.`insurance` SET TAGS ('dbx_domain' = 'insurance');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` SET TAGS ('dbx_subdomain' = 'payer_management');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `parent_payer_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Payer');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `primary_successor_payer_id` SET TAGS ('dbx_business_glossary_term' = 'Successor Payer');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `accepts_assignment` SET TAGS ('dbx_business_glossary_term' = 'Accepts Assignment');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `appeal_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Appeal Limit Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_category` SET TAGS ('dbx_business_glossary_term' = 'Payer Category');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claim_scrubbing_vendor` SET TAGS ('dbx_business_glossary_term' = 'Claim Scrubbing Vendor');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('dbx_business_glossary_term' = 'Claims Inquiry Phone');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_inquiry_phone` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `claims_submission_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Claims Submission Endpoint');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `clearinghouse_code` SET TAGS ('dbx_business_glossary_term' = 'Clearinghouse Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `coordination_of_benefits_required` SET TAGS ('dbx_business_glossary_term' = 'COB Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Phone');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `customer_service_phone` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `edi_payer_code` SET TAGS ('dbx_business_glossary_term' = 'EDI Payer Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `electronic_funds_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'EFT Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `eligibility_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `id_external` SET TAGS ('dbx_business_glossary_term' = 'External ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `inactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Inactivation Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `inactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Inactivation Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `portal_url` SET TAGS ('dbx_business_glossary_term' = 'Portal URL');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('dbx_business_glossary_term' = 'Provider Relations Email');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `provider_relations_email` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Remittance Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Remittance Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('dbx_business_glossary_term' = 'Remittance City');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_city` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Remittance Delivery Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Remittance Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `remittance_state` SET TAGS ('dbx_business_glossary_term' = 'Remittance State');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Short Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `short_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Payer Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `timely_filing_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Timely Filing Limit Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` SET TAGS ('dbx_subdomain' = 'payer_management');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Consent Form Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Health Plan');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `predecessor_health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `benefit_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Year');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `cms_contract_number` SET TAGS ('dbx_business_glossary_term' = 'CMS Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `cob_order` SET TAGS ('dbx_business_glossary_term' = 'COB Order');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `emergency_room_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'ER Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `family_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Family Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `family_oop_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Family OOP Max Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `fsa_eligible` SET TAGS ('dbx_business_glossary_term' = 'FSA Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `funding_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `hra_eligible` SET TAGS ('dbx_business_glossary_term' = 'HRA Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `hsa_eligible` SET TAGS ('dbx_business_glossary_term' = 'HSA Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `individual_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Individual Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `individual_oop_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Individual OOP Max Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `inpatient_hospital_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Inpatient Hospital Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `inpatient_hospital_copay_amount` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `inpatient_hospital_copay_amount` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `issuer_state` SET TAGS ('dbx_business_glossary_term' = 'Issuer State');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `metal_tier` SET TAGS ('dbx_business_glossary_term' = 'Metal Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `open_enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `open_enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `out_of_network_coverage` SET TAGS ('dbx_business_glossary_term' = 'Out of Network Coverage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `out_of_network_deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Out of Network Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `out_of_network_oop_max_amount` SET TAGS ('dbx_business_glossary_term' = 'Out of Network OOP Max Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Plan Document URL');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_identifier` SET TAGS ('dbx_business_glossary_term' = 'Plan Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Prescription Tier 1 Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier1_copay_amount` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Prescription Tier 2 Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier2_copay_amount` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Prescription Tier 3 Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier3_copay_amount` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Prescription Tier 4 Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prescription_tier4_copay_amount` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `preventive_care_covered` SET TAGS ('dbx_business_glossary_term' = 'Preventive Care Covered');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `primary_care_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `requires_pcp_selection` SET TAGS ('dbx_business_glossary_term' = 'Requires PCP Selection');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `requires_referral_for_specialist` SET TAGS ('dbx_business_glossary_term' = 'Requires Referral for Specialist');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `service_area_description` SET TAGS ('dbx_business_glossary_term' = 'Service Area Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `specialist_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Specialist Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `state_filing_number` SET TAGS ('dbx_business_glossary_term' = 'State Filing Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_audit' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`health_plan` ALTER COLUMN `urgent_care_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Urgent Care Copay Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` SET TAGS ('dbx_subdomain' = 'payer_management');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `parent_benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Benefit Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `parent_benefit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Required Consent Form Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `allowed_amount_basis` SET TAGS ('dbx_business_glossary_term' = 'Allowed Amount Basis');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `allowed_amount_basis` SET TAGS ('dbx_value_regex' = 'usual_customary_reasonable|medicare_rate|negotiated_rate|billed_charges');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_category` SET TAGS ('dbx_business_glossary_term' = 'Benefit Category');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copayment (Copay) Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cost_sharing_tier` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `cost_sharing_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coverage Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `coverage_percentage` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Benefit Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `day_limit_count` SET TAGS ('dbx_business_glossary_term' = 'Day Limit Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `day_limit_period` SET TAGS ('dbx_business_glossary_term' = 'Day Limit Period');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `day_limit_period` SET TAGS ('dbx_value_regex' = 'per_admission|per_year|per_lifetime');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `days_supply_limit` SET TAGS ('dbx_business_glossary_term' = 'Days Supply Limit');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `deductible_applies_flag` SET TAGS ('dbx_business_glossary_term' = 'Deductible Applies Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_description` SET TAGS ('dbx_business_glossary_term' = 'Benefit Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Code Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_value_regex' = 'ICD10CM|ICD9CM');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `diagnosis_code_type` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `dollar_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Dollar Limit Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `dollar_limit_period` SET TAGS ('dbx_business_glossary_term' = 'Dollar Limit Period');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `dollar_limit_period` SET TAGS ('dbx_value_regex' = 'per_visit|per_day|per_year|per_lifetime');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_business_glossary_term' = 'Essential Health Benefit (EHB) Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `essential_health_benefit_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `exclusions_text` SET TAGS ('dbx_business_glossary_term' = 'Benefit Exclusions Text');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|specialty');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `hsa_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `limitations_text` SET TAGS ('dbx_business_glossary_term' = 'Benefit Limitations Text');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `mail_order_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Mail Order Available Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Benefit Record Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `benefit_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `network_type` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|both');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `out_of_pocket_applies_flag` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket (OOP) Maximum Applies Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `preventive_care_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventive Care Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_business_glossary_term' = 'Procedure Code Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_value_regex' = 'CPT|HCPCS|ICD10PCS|CDT|revenue_code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `procedure_code_type` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `quantity_limit_flag` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `service_type_code` SET TAGS ('dbx_business_glossary_term' = 'Service Type Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `service_type_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `step_therapy_required_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Benefit Subcategory');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Benefit Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|specialty');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `visit_limit_count` SET TAGS ('dbx_business_glossary_term' = 'Visit Limit Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `visit_limit_period` SET TAGS ('dbx_business_glossary_term' = 'Visit Limit Period');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`benefit` ALTER COLUMN `visit_limit_period` SET TAGS ('dbx_value_regex' = 'per_day|per_week|per_month|per_year|per_lifetime');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` SET TAGS ('dbx_subdomain' = 'payer_management');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `parent_network_provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Network ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `parent_provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Provider Network Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `parent_provider_network_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `adequacy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Review Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Behavioral Health Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `behavioral_health_included_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `cms_approval_date` SET TAGS ('dbx_business_glossary_term' = 'CMS (Centers for Medicare and Medicaid Services) Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `cms_filing_date` SET TAGS ('dbx_business_glossary_term' = 'CMS (Centers for Medicare and Medicaid Services) Filing Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `cms_filing_status` SET TAGS ('dbx_business_glossary_term' = 'CMS (Centers for Medicare and Medicaid Services) Filing Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `cms_filing_status` SET TAGS ('dbx_value_regex' = 'filed|approved|rejected|pending|not_required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'fee_for_service|capitation|shared_savings|bundled_payment|value_based|hybrid');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `credentialing_standard` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Standard');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `credentialing_standard` SET TAGS ('dbx_value_regex' = 'NCQA|URAC|AAAHC|TJC|state_specific|internal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `dental_network_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Dental Network Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `directory_last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Directory Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Network Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `facility_count` SET TAGS ('dbx_business_glossary_term' = 'Facility Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Service Area');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_value_regex' = 'adequate|inadequate|pending_review|conditionally_adequate|exempt');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_code` SET TAGS ('dbx_business_glossary_term' = 'Network Identifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_description` SET TAGS ('dbx_business_glossary_term' = 'Network Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_directory_url` SET TAGS ('dbx_business_glossary_term' = 'Network Directory URL (Uniform Resource Locator)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_model` SET TAGS ('dbx_business_glossary_term' = 'Network Model');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_model` SET TAGS ('dbx_value_regex' = 'staff_model|group_model|network_model|IPA|direct_contract|rental_network');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('dbx_business_glossary_term' = 'Network Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'preferred|standard|out_of_network|tier_1|tier_2|tier_3');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `pcp_count` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `pharmacy_network_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Network Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `provider_count` SET TAGS ('dbx_business_glossary_term' = 'Provider Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `quality_tier_methodology` SET TAGS ('dbx_business_glossary_term' = 'Quality Tier Methodology');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `recredentialing_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Recredentialing Cycle Months');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `risk_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Risk Arrangement');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `risk_arrangement` SET TAGS ('dbx_value_regex' = 'full_risk|shared_risk|upside_only|downside_risk|no_risk');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `service_area_type` SET TAGS ('dbx_business_glossary_term' = 'Service Area Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `service_area_type` SET TAGS ('dbx_value_regex' = 'statewide|regional|county|zip_code|msa|national');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `specialist_count` SET TAGS ('dbx_business_glossary_term' = 'Specialist Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Network Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`provider_network` ALTER COLUMN `vision_network_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Vision Network Included Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` SET TAGS ('dbx_subdomain' = 'payer_management');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `drg_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `primary_superseded_by_coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Policy ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Taxonomy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `age_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Age Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `appeals_allowed` SET TAGS ('dbx_business_glossary_term' = 'Appeals Allowed');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `appeals_process_description` SET TAGS ('dbx_business_glossary_term' = 'Appeals Process Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('dbx_business_glossary_term' = 'Clinical Evidence Source');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `clinical_evidence_source` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `coverage_determination` SET TAGS ('dbx_business_glossary_term' = 'Coverage Determination');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `coverage_determination` SET TAGS ('dbx_value_regex' = 'covered|non_covered|conditional|investigational|experimental|not_medically_necessary');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `exclusions` SET TAGS ('dbx_business_glossary_term' = 'Exclusions');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `frequency_limitations` SET TAGS ('dbx_business_glossary_term' = 'Frequency Limitations');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Gender Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `gender_restrictions` SET TAGS ('dbx_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('dbx_business_glossary_term' = 'Medical Necessity Criteria');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `medical_necessity_criteria` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `network_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Network Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `network_restrictions` SET TAGS ('dbx_value_regex' = 'in_network_only|out_of_network_allowed|no_restriction');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `place_of_service_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Place of Service Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Policy Approved By');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Category');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Policy Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_owner` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|under_review|retired|superseded');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_title` SET TAGS ('dbx_business_glossary_term' = 'Policy Title');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Policy Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'medical_policy|coverage_determination|lcd|ncd|administrative_policy|clinical_guideline');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `prior_authorization_criteria` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Criteria');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `provider_specialty_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialty Restrictions');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `quantity_limitations` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limitations');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Criteria');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`coverage_policy` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` SET TAGS ('dbx_subdomain' = 'member_coverage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `member_enrollment_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `npp_acknowledgment_id` SET TAGS ('dbx_business_glossary_term' = 'Npp Acknowledgment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `prior_member_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Member Enrollment Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `prior_member_enrollment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `prior_member_enrollment_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `prior_member_enrollment_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `benefit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `benefit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `cobra_indicator` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `cobra_qualifying_event_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Qualifying Event Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'individual|individual_plus_spouse|individual_plus_children|family');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `eligibility_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `eligibility_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `eligibility_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not_verified');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|phone|mail|in_person|broker');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source System');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'open_enrollment|special_enrollment|auto_enrollment|cobra|medicare|medicaid');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `enrollment_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `last_premium_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Premium Payment Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicare_part_a_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Medicare Part A Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `medicare_part_b_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Medicare Part B Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `pcp_assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Assignment Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `premium_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `premium_payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|biweekly');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_value_regex' = 'current|past_due|grace_period|suspended|terminated');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Subscriber');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_value_regex' = 'self|spouse|child|domestic_partner|other_dependent');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `relationship_to_subscriber` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_value_regex' = 'aptc|csr|medicaid|chip|none');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`member_enrollment` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` SET TAGS ('dbx_subdomain' = 'member_coverage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Pcp Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Subscriber Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `prior_subscriber_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_1` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `address_line_2` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Subscriber City');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `city` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `cobra_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `cobra_end_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `cobra_start_date` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Country Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated|pending');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|behavioral_health|other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Date of Birth (DOB)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `dual_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Dual Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Email Address');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `email_address` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Subscriber First Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `first_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Gender');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'M|F|U|O');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `gender` SET TAGS ('dbx_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `group_number` SET TAGS ('dbx_business_glossary_term' = 'Group Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Last Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `last_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicaid_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicaid_eligible_flag` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Identification Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicaid_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicare_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicare Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicare_number` SET TAGS ('dbx_business_glossary_term' = 'Medicare Beneficiary Identifier (MBI) Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicare_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `medicare_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `middle_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'in_network|out_of_network|preferred|standard');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `phone_number` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `postal_code` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Premium Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `premium_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment Frequency');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `premium_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|biweekly');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `relationship_to_insured` SET TAGS ('dbx_business_glossary_term' = 'Relationship to Insured');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `relationship_to_insured` SET TAGS ('dbx_value_regex' = 'self|spouse|child|other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Source System Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `ssn` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Subscriber State');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Name Suffix');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `suffix` SET TAGS ('dbx_value_regex' = 'Jr|Sr|II|III|IV|V');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary|non_payment|employment_ended|death|other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`subscriber` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` SET TAGS ('dbx_subdomain' = 'member_coverage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Dependent Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician (PCP) Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `dependent_mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `primary_dependent_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Dependent Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `primary_dependent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_business_glossary_term' = 'Subscriber Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `subscriber_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_1` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `address_line_2` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `city` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `coordination_of_benefits_indicator` SET TAGS ('dbx_business_glossary_term' = 'Coordination of Benefits (COB) Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `coverage_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `coverage_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Dependent Date of Birth (DOB)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_value_regex' = 'Disabled|Not Disabled');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Disability Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_verification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `disability_verification_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Dependent Eligibility Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Pending|Terminated|Suspended|Deceased');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `email_address` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent First Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `first_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Dependent Gender');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'Male|Female|Other|Unknown');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `gender` SET TAGS ('dbx_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_eligibility_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Eligibility Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent Last Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `last_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Dependent Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `middle_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `phone_number` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP Code)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `postal_code` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type to Subscriber');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'Spouse|Child|Domestic Partner|Disabled Dependent|Other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_value_regex' = '^d{3}-d{2}-d{4}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `ssn` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `student_status` SET TAGS ('dbx_business_glossary_term' = 'Student Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `student_status` SET TAGS ('dbx_value_regex' = 'Full-Time Student|Part-Time Student|Not a Student');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `student_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Student Status Verification Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `suffix` SET TAGS ('dbx_business_glossary_term' = 'Name Suffix');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `suffix` SET TAGS ('dbx_value_regex' = 'Jr|Sr|II|III|IV|V');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'Aged Out|Divorce|Loss of Eligibility|Death|Voluntary Termination|Other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `tobacco_use_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Use Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `tobacco_use_indicator` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `tobacco_use_indicator` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`dependent` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` SET TAGS ('dbx_subdomain' = 'contract_reimbursement');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `renewed_payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Renewed Payer Contract Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `renewed_payer_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `base_reimbursement_percentage` SET TAGS ('dbx_business_glossary_term' = 'Base Reimbursement Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `base_reimbursement_percentage` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `carve_out_services` SET TAGS ('dbx_business_glossary_term' = 'Carve-Out Services');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `claims_submission_method` SET TAGS ('dbx_business_glossary_term' = 'Claims Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `claims_submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal|clearinghouse');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_business_glossary_term' = 'Contract Administrator Email Address');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_email` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Administrator Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_administrator_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_document_location` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Location');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_document_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'fee_for_service|capitation|bundled_payment|shared_savings|pay_for_performance|value_based');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `credentialing_required` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `fee_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Reference');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|preferred|standard|out_of_network');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `quality_bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Quality Bonus Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `quality_measure_set` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Set');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `quality_penalty_eligible` SET TAGS ('dbx_business_glossary_term' = 'Quality Penalty Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|none');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `reimbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `risk_arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Arrangement Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `risk_arrangement_type` SET TAGS ('dbx_value_regex' = 'no_risk|upside_only|downside_only|two_sided_risk|full_risk');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `stop_loss_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Stop-Loss Threshold Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `timely_filing_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Timely Filing Limit Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`payer_contract` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` SET TAGS ('dbx_subdomain' = 'contract_reimbursement');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `primary_predecessor_schedule_fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Fee Schedule ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Taxonomy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `annual_inflation_rate` SET TAGS ('dbx_business_glossary_term' = 'Annual Inflation Rate');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `annual_inflation_rate` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `billed_charges_percentage` SET TAGS ('dbx_business_glossary_term' = 'Billed Charges Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `billed_charges_percentage` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `carve_out_services` SET TAGS ('dbx_business_glossary_term' = 'Carve Out Services');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `claims_submission_method` SET TAGS ('dbx_business_glossary_term' = 'Claims Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `claims_submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal|clearinghouse');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|ambulatory_surgery_center|skilled_nursing_facility|home_health|hospice');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `fee_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `fee_schedule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired|pending_approval');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `filing_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_adjustment_factor` SET TAGS ('dbx_business_glossary_term' = 'Geographic Practice Cost Index (GPCI) Adjustment Factor');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|state|county|zip_code|facility_specific');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `inflation_adjustment_method` SET TAGS ('dbx_business_glossary_term' = 'Inflation Adjustment Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `inflation_adjustment_method` SET TAGS ('dbx_value_regex' = 'cpi|medical_cpi|fixed_percentage|none|custom');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `interest_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Penalty Rate');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `interest_penalty_rate` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `locality_code` SET TAGS ('dbx_business_glossary_term' = 'Locality Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `medicare_percentage` SET TAGS ('dbx_business_glossary_term' = 'Medicare Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `medicare_percentage` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `network_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|preferred|standard|out_of_network');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `outlier_payment_threshold` SET TAGS ('dbx_business_glossary_term' = 'Outlier Payment Threshold');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `quality_adjustment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Adjustment Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `quality_adjustment_percentage` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `quality_incentive_eligible` SET TAGS ('dbx_business_glossary_term' = 'Quality Incentive Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `rate_basis` SET TAGS ('dbx_value_regex' = 'percent_of_medicare|percent_of_billed_charges|case_rate|per_diem|fee_for_service|capitation');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `rate_basis` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `reimbursement_model` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Model');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `reimbursement_model` SET TAGS ('dbx_value_regex' = 'fee_for_service|bundled_payment|value_based|shared_savings|capitation|per_diem');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'professional|facility|dme|laboratory|pharmacy|radiology');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `stop_loss_threshold` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Threshold');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `timely_filing_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Timely Filing Limit Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` SET TAGS ('dbx_subdomain' = 'contract_reimbursement');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `drg_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `primary_superseded_by_fee_schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Line Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `anesthesia_base_units` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Base Units');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `assistant_surgeon_allowed` SET TAGS ('dbx_business_glossary_term' = 'Assistant Surgeon Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `bilateral_indicator` SET TAGS ('dbx_business_glossary_term' = 'Bilateral Procedure Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `bilateral_indicator` SET TAGS ('dbx_value_regex' = 'not_applicable|bilateral_surgery|unilateral_surgery');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `bundled_indicator` SET TAGS ('dbx_business_glossary_term' = 'Bundled Service Indicator');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `case_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Case Rate Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `case_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `case_rate_amount` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `contracted_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `contracted_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `contracted_rate_amount` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `conversion_factor` SET TAGS ('dbx_business_glossary_term' = 'Conversion Factor');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `conversion_factor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `fee_schedule_line_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `fee_schedule_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded|expired|suspended');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('dbx_business_glossary_term' = 'Geographic Practice Cost Index (GPCI) Modifier');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `geographic_modifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `global_period_days` SET TAGS ('dbx_business_glossary_term' = 'Global Period Days');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `maximum_reimbursement` SET TAGS ('dbx_business_glossary_term' = 'Maximum Reimbursement Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `maximum_reimbursement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `minimum_reimbursement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Reimbursement Amount');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `minimum_reimbursement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_business_glossary_term' = 'Modifier 1');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_1` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_business_glossary_term' = 'Modifier 2');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_2` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_business_glossary_term' = 'Modifier 3');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_3` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_business_glossary_term' = 'Modifier 4');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `modifier_4` SET TAGS ('dbx_value_regex' = '^[0-9A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('dbx_business_glossary_term' = 'Multiple Procedure Reduction Percentage');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `multiple_procedure_reduction` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Line Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `percent_of_charges` SET TAGS ('dbx_business_glossary_term' = 'Percent of Billed Charges');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `percent_of_charges` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `percent_of_charges` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `percent_of_medicare` SET TAGS ('dbx_business_glossary_term' = 'Percent of Medicare Allowable');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `percent_of_medicare` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `percent_of_medicare` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `quality_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Reporting Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `rate_basis` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `rate_version` SET TAGS ('dbx_business_glossary_term' = 'Rate Version Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `rate_version` SET TAGS ('dbx_vibe_rate_typing' = 'decimal');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `revenue_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `rvu_malpractice` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Malpractice Component');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `rvu_practice_expense` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Practice Expense Component');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `rvu_total` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Total');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `rvu_work` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Work Component');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `stop_loss_threshold` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Threshold');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `stop_loss_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`fee_schedule_line` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` SET TAGS ('dbx_subdomain' = 'payer_management');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Rule ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `form_template_id` SET TAGS ('dbx_business_glossary_term' = 'Required Consent Form Template Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `form_template_id` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `form_template_id` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `superseded_prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Prior Auth Rule Id');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `superseded_prior_auth_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Taxonomy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `age_maximum` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age (Years)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `age_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age (Years)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `appeal_process_description` SET TAGS ('dbx_business_glossary_term' = 'Appeal Process Description');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `auto_approval_criteria` SET TAGS ('dbx_business_glossary_term' = 'Auto-Approval Criteria');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `auto_approval_eligible` SET TAGS ('dbx_business_glossary_term' = 'Auto-Approval Eligible');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('dbx_business_glossary_term' = 'Clinical Criteria Reference');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `clinical_criteria_reference` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_business_glossary_term' = 'Contact Fax Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_fax` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `contact_phone` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `documentation_required` SET TAGS ('dbx_business_glossary_term' = 'Documentation Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `exception_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exception Criteria');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `frequency_limit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Limit');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `frequency_limit_period_days` SET TAGS ('dbx_business_glossary_term' = 'Frequency Limit Period (Days)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_value_regex' = 'male|female|all|other');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii_sensitive' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_uc_classification' = 'sensitive');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `medical_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `medical_policy_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `medical_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `medical_policy_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `medical_policy_number` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `medical_policy_number` SET TAGS ('dbx_uc_classification' = 'phi');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `pa_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Requirement Type');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `pa_requirement_type` SET TAGS ('dbx_value_regex' = 'required|not_required|clinical_review|peer_to_peer|notification_only|retrospective_review');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_business_glossary_term' = 'Place of Service (POS) Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `place_of_service_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `portal_url` SET TAGS ('dbx_business_glossary_term' = 'Payer Portal Uniform Resource Locator (URL)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `portal_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `prior_auth_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Rule Status');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `prior_auth_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|retired');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `quantity_limit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `quantity_limit_period_days` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Period (Days)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Rule Code');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Rule Name');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_pii_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_uc_classification' = 'pii');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Criteria');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_pii_phi' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'portal|fax|phone|edi_278|email|mail');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (Hours)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `urgent_turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Urgent Turnaround Time (Hours)');
ALTER TABLE `vibe_healthcare_v1`.`insurance`.`prior_auth_rule` ALTER COLUMN `vibe_added_flag` SET TAGS ('dbx_vibe_added' = 'true');
