-- Schema for Domain: network | Business:  | Version: v2_ecm
-- Generated on: 2026-06-22 23:51:45

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`network` COMMENT 'Owns provider network configurations, tier assignments, in-network/out-of-network designations, geographic access standards, network adequacy metrics, and service area configurations. Manages ACO and VBC arrangement participation, network-to-plan associations, network directories, and CMS network adequacy filings. Distinct from provider identity (provider domain) and contract terms (contract domain); network owns the structural relationship between providers and plan networks.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`provider_network` (
    `provider_network_id` BIGINT COMMENT 'Surrogate primary key for the provider network.',
    `ledger_id` BIGINT COMMENT 'FK to the finance ledger associated with this network.',
    `vendor_id` BIGINT COMMENT 'FK to the vendor managing this network.',
    `aco_participation_flag` BOOLEAN COMMENT 'Indicates if the network participates in an ACO arrangement.',
    `cms_network_code` STRING COMMENT 'CMS-assigned network identifier.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_date` DATE COMMENT 'Date the network becomes effective.',
    `facility_count` STRING COMMENT 'Number of facilities in the network.',
    `geographic_footprint` STRING COMMENT 'Description of the geographic coverage area.',
    `last_adequacy_review_date` DATE COMMENT 'Date of the most recent adequacy review.',
    `line_of_business` STRING COMMENT 'Line of business the network serves.',
    `member_enrollment_count` STRING COMMENT 'Number of members enrolled in this network.',
    `ncqa_accreditation_date` DATE COMMENT 'Date of NCQA accreditation.',
    `ncqa_accreditation_status` STRING COMMENT 'Current NCQA accreditation status.',
    `ncqa_expiration_date` DATE COMMENT 'Expiration date of NCQA accreditation.',
    `network_adequacy_filing_date` DATE COMMENT 'Date of the network adequacy filing.',
    `network_adequacy_status` STRING COMMENT 'Current adequacy compliance status.',
    `network_code` STRING COMMENT 'Internal network code identifier.',
    `network_description` STRING COMMENT 'Descriptive text for the network.',
    `network_directory_url` STRING COMMENT 'URL to the public provider directory.',
    `network_name` STRING COMMENT 'Human-readable name of the network.',
    `network_status` STRING COMMENT 'Current operational status of the network.',
    `network_type` STRING COMMENT 'Type classification (HMO, PPO, EPO, etc.).',
    `next_adequacy_review_date` DATE COMMENT 'Scheduled date for next adequacy review.',
    `out_of_network_coverage_flag` BOOLEAN COMMENT 'Indicates if out-of-network coverage is available.',
    `pcp_count` STRING COMMENT 'Number of primary care physicians in the network.',
    `pcp_required_flag` BOOLEAN COMMENT 'Indicates if PCP selection is required.',
    `provider_count` STRING COMMENT 'Total number of providers in the network.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicates if referrals are required for specialists.',
    `regulatory_approval_date` DATE COMMENT 'Date of regulatory approval for the network.',
    `service_area_type` STRING COMMENT 'Type of service area (state, county, MSA).',
    `specialist_count` STRING COMMENT 'Number of specialists in the network.',
    `star_rating` DECIMAL(18,2) COMMENT 'CMS star rating for the network.',
    `termination_date` DATE COMMENT 'Date the network is terminated.',
    `tier_classification` STRING COMMENT 'Tier classification of the network.',
    `updated_by` STRING COMMENT 'User who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `vbc_arrangement_flag` BOOLEAN COMMENT 'Indicates if VBC arrangements exist in this network.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `created_by` STRING COMMENT 'User who created the record.',
    CONSTRAINT pk_provider_network PRIMARY KEY(`provider_network_id`)
) COMMENT 'Defines a provider network offered by the health plan, including adequacy and regulatory status.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`tier` (
    `tier_id` BIGINT COMMENT 'Surrogate primary key for the tier.',
    `employee_id` BIGINT COMMENT 'FK to the workforce employee managing this tier.',
    `provider_network_id` BIGINT COMMENT 'FK to the parent provider network.',
    `tier_code` STRING COMMENT 'Code identifier for the tier.',
    `coinsurance_differential_percentage` DECIMAL(18,2) COMMENT 'Coinsurance differential for this tier.',
    `copay_differential_amount` DECIMAL(18,2) COMMENT 'Copay differential amount for this tier.',
    `cost_share_differential_type` DECIMAL(18,2) COMMENT 'Type of cost share differential applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `deductible_applies_flag` BOOLEAN COMMENT 'Indicates if deductible applies to this tier.',
    `display_label` STRING COMMENT 'Member-facing display label for the tier.',
    `effective_date` DATE COMMENT 'Date the tier becomes effective.',
    `facility_type_applicability` STRING COMMENT 'Facility types to which this tier applies.',
    `internal_notes` STRING COMMENT 'Internal notes about the tier.',
    `last_updated_by` STRING COMMENT 'User who last updated the record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `member_steerage_incentive_description` STRING COMMENT 'Description of member steerage incentives.',
    `tier_name` STRING COMMENT 'Human-readable name of the tier.',
    `network_adequacy_credit_flag` BOOLEAN COMMENT 'Indicates if tier counts toward adequacy.',
    `oop_max_applies_flag` BOOLEAN COMMENT 'Indicates if OOP max applies to this tier.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Indicates if prior auth is required.',
    `quality_tier_flag` BOOLEAN COMMENT 'Indicates if this is a quality-based tier.',
    `rank` STRING COMMENT 'Numeric rank/order of the tier.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicates if referral is required.',
    `regulatory_filing_reference` STRING COMMENT 'Reference to regulatory filing for this tier.',
    `sbc_disclosure_text` STRING COMMENT 'Summary of Benefits and Coverage disclosure text.',
    `specialty_applicability` STRING COMMENT 'Specialties to which this tier applies.',
    `termination_date` DATE COMMENT 'Date the tier is terminated.',
    `tier_status` STRING COMMENT 'Current status of the tier.',
    `tier_type` STRING COMMENT 'Classification type of the tier.',
    `vbc_arrangement_eligible_flag` BOOLEAN COMMENT 'Indicates if tier is eligible for VBC arrangements.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_tier PRIMARY KEY(`tier_id`)
) COMMENT 'Defines tiered benefit structures within a provider network for cost-sharing differentiation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`network_provider` (
    `network_provider_id` BIGINT COMMENT 'Surrogate primary key.',
    `delegated_entity_id` BIGINT COMMENT 'FK to credentialing delegated entity.',
    `employee_id` BIGINT COMMENT 'FK to the workforce employee liaison.',
    `practice_location_id` BIGINT COMMENT 'FK to the provider master.',
    `provider_network_id` BIGINT COMMENT 'FK to the parent provider network.',
    `record_id` BIGINT COMMENT 'FK to the credentialing record.',
    `vendor_id` BIGINT COMMENT 'FK to the telehealth vendor.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates if provider is accepting new patients.',
    `accessibility_ada_compliant_flag` BOOLEAN COMMENT 'Indicates ADA compliance.',
    `aco_participant_flag` BOOLEAN COMMENT 'Indicates ACO participation.',
    `after_hours_availability_flag` BOOLEAN COMMENT 'Indicates after-hours availability.',
    `continuity_of_care_end_date` DATE COMMENT 'End date for continuity of care period.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `credentialing_date` DATE COMMENT 'Date of credentialing.',
    `credentialing_status` STRING COMMENT 'Current credentialing status.',
    `current_panel_size` STRING COMMENT 'Current number of patients on panel.',
    `directory_last_verified_date` DATE COMMENT 'Date directory info was last verified.',
    `directory_listing_flag` BOOLEAN COMMENT 'Indicates if listed in directory.',
    `effective_date` DATE COMMENT 'Participation effective date.',
    `geographic_service_area` STRING COMMENT 'Geographic area served.',
    `in_network_flag` BOOLEAN COMMENT 'Indicates in-network status.',
    `language_services_available` STRING COMMENT 'Languages available at this provider.',
    `network_adequacy_category` STRING COMMENT 'Adequacy category classification.',
    `network_participation_type` STRING COMMENT 'Type of network participation.',
    `npi` STRING COMMENT 'National Provider Identifier.',
    `panel_capacity` STRING COMMENT 'Maximum panel capacity.',
    `panel_status` STRING COMMENT 'Current panel status (open/closed).',
    `participation_status` STRING COMMENT 'Current participation status.',
    `pcp_flag` BOOLEAN COMMENT 'Indicates if provider is a PCP.',
    `quality_tier_designation` STRING COMMENT 'Quality tier assigned to provider.',
    `record_active_flag` BOOLEAN COMMENT 'Indicates if record is active.',
    `recredentialing_due_date` DATE COMMENT 'Date recredentialing is due.',
    `risk_sharing_arrangement_flag` BOOLEAN COMMENT 'Indicates risk sharing participation.',
    `specialist_flag` BOOLEAN COMMENT 'Indicates if provider is a specialist.',
    `telehealth_available_flag` BOOLEAN COMMENT 'Indicates telehealth availability.',
    `termination_date` DATE COMMENT 'Date of network termination.',
    `termination_initiated_by` STRING COMMENT 'Party that initiated termination.',
    `termination_reason_code` STRING COMMENT 'Reason code for termination.',
    `tier_assignment` STRING COMMENT 'Tier assigned to this provider.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `vbc_participant_flag` BOOLEAN COMMENT 'Indicates VBC participation.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `weekend_availability_flag` BOOLEAN COMMENT 'Indicates weekend availability.',
    CONSTRAINT pk_network_provider PRIMARY KEY(`network_provider_id`)
) COMMENT 'Associates a provider with a network, tracking participation status, panel, and credentialing details.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`plan_association` (
    `plan_association_id` BIGINT COMMENT 'Surrogate primary key.',
    `health_plan_id` BIGINT COMMENT 'FK to the health plan.',
    `network_service_area_id` BIGINT COMMENT 'FK to the network service area.',
    `filing_id` BIGINT COMMENT 'FK to the CMS filing.',
    `provider_network_id` BIGINT COMMENT 'FK to the provider network.',
    `aco_participation_flag` BOOLEAN COMMENT 'Indicates ACO participation.',
    `adequacy_certification_date` DATE COMMENT 'Date of adequacy certification.',
    `adequacy_review_date` DATE COMMENT 'Date of adequacy review.',
    `association_code` STRING COMMENT 'Code for the plan-network association.',
    `association_name` STRING COMMENT 'Name of the association.',
    `association_type` STRING COMMENT 'Type of association.',
    `auto_assignment_eligible_flag` BOOLEAN COMMENT 'Indicates auto-assignment eligibility.',
    `contract_reference_number` STRING COMMENT 'Reference number for the contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `directory_publication_flag` BOOLEAN COMMENT 'Indicates if published in directory.',
    `effective_date` DATE COMMENT 'Effective date of association.',
    `lob` STRING COMMENT 'Line of business.',
    `market_segment` STRING COMMENT 'Market segment served.',
    `member_count` STRING COMMENT 'Number of members in this association.',
    `network_adequacy_status` STRING COMMENT 'Adequacy status.',
    `network_tier` STRING COMMENT 'Tier of the network.',
    `notes` STRING COMMENT 'Additional notes.',
    `out_of_network_coverage_flag` BOOLEAN COMMENT 'Indicates OON coverage.',
    `pcp_selection_required_flag` BOOLEAN COMMENT 'Indicates if PCP selection is required.',
    `plan_association_status` STRING COMMENT 'Status of the association.',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Indicates if prior auth is required.',
    `priority_rank` STRING COMMENT 'Priority ranking.',
    `provider_count` STRING COMMENT 'Number of providers.',
    `referral_required_flag` BOOLEAN COMMENT 'Indicates if referral is required.',
    `regulatory_approval_date` DATE COMMENT 'Date of regulatory approval.',
    `star_rating_impact_flag` BOOLEAN COMMENT 'Indicates star rating impact.',
    `termination_date` DATE COMMENT 'Termination date.',
    `updated_by` STRING COMMENT 'User who last updated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `vbc_arrangement_flag` BOOLEAN COMMENT 'Indicates VBC arrangement.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `created_by` STRING COMMENT 'User who created the record.',
    CONSTRAINT pk_plan_association PRIMARY KEY(`plan_association_id`)
) COMMENT 'Links a provider network to a health plan, defining the network-plan relationship and adequacy status.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` (
    `network_service_area_id` BIGINT COMMENT 'Surrogate primary key.',
    `provider_network_id` BIGINT COMMENT 'FK to the provider network.',
    `filing_id` BIGINT COMMENT 'FK to the regulatory filing.',
    `cms_service_area_code` STRING COMMENT 'CMS-assigned service area code.',
    `commercial_approved_flag` BOOLEAN COMMENT 'Indicates commercial approval.',
    `county_fips_code` STRING COMMENT 'FIPS code for the county.',
    `county_name` STRING COMMENT 'Name of the county.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_date` DATE COMMENT 'Effective date.',
    `geographic_boundary_description` STRING COMMENT 'Description of geographic boundaries.',
    `medicaid_approved_flag` BOOLEAN COMMENT 'Indicates Medicaid approval.',
    `medicare_advantage_approved_flag` BOOLEAN COMMENT 'Indicates MA approval.',
    `member_residency_required_flag` BOOLEAN COMMENT 'Indicates if member residency is required.',
    `msa_code` STRING COMMENT 'Metropolitan Statistical Area code.',
    `msa_name` STRING COMMENT 'The descriptive name assigned to the msa for identification purposes.',
    `network_adequacy_approval_date` DATE COMMENT 'Date of adequacy approval.',
    `network_adequacy_filing_date` DATE COMMENT 'Date of adequacy filing.',
    `network_adequacy_status` STRING COMMENT 'Adequacy status.',
    `network_service_area_status` STRING COMMENT 'Status of the service area.',
    `notes` STRING COMMENT 'Additional notes.',
    `out_of_area_coverage_allowed_flag` BOOLEAN COMMENT 'Indicates if OOA coverage is allowed.',
    `population_count` BIGINT COMMENT 'Population in the service area.',
    `qhp_approved_flag` BOOLEAN COMMENT 'Indicates QHP approval.',
    `regulatory_approval_number` STRING COMMENT 'Regulatory approval number.',
    `service_area_code` STRING COMMENT 'Internal service area code.',
    `service_area_name` STRING COMMENT 'Name of the service area.',
    `service_area_type` STRING COMMENT 'Type of service area.',
    `state_code` STRING COMMENT 'State code.',
    `termination_date` DATE COMMENT 'Termination date.',
    `updated_by` STRING COMMENT 'User who last updated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `urban_rural_designation` STRING COMMENT 'Urban/rural classification.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `zip_code` STRING COMMENT 'A standardized code representing the zip classification.',
    `created_by` STRING COMMENT 'User who created the record.',
    CONSTRAINT pk_network_service_area PRIMARY KEY(`network_service_area_id`)
) COMMENT 'Defines the geographic service area for a provider network including regulatory approval status.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` (
    `adequacy_standard_id` BIGINT COMMENT 'Surrogate primary key.',
    `adequacy_standard_status` STRING COMMENT 'Current status of the standard.',
    `after_hours_availability_required` BOOLEAN COMMENT 'Indicates if after-hours availability is required.',
    `after_hours_definition` STRING COMMENT 'Definition of after-hours.',
    `appointment_type` STRING COMMENT 'Type of appointment.',
    `compliance_reporting_frequency` STRING COMMENT 'Frequency of compliance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `effective_date` DATE COMMENT 'Effective date.',
    `exception_criteria` STRING COMMENT 'Criteria for exceptions.',
    `geographic_classification` STRING COMMENT 'Geographic classification (urban/rural).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `line_of_business` STRING COMMENT 'Applicable line of business.',
    `maximum_distance_miles` DECIMAL(18,2) COMMENT 'Maximum distance in miles.',
    `maximum_travel_time_minutes` STRING COMMENT 'Maximum travel time in minutes.',
    `maximum_wait_time_days` STRING COMMENT 'Maximum wait time in days.',
    `measurement_methodology` STRING COMMENT 'Methodology for measurement.',
    `minimum_provider_count` STRING COMMENT 'Minimum number of providers required.',
    `notes` STRING COMMENT 'Additional notes.',
    `penalty_for_non_compliance` STRING COMMENT 'Penalty description.',
    `plan_type` STRING COMMENT 'Applicable plan type.',
    `provider_to_member_ratio` DECIMAL(18,2) COMMENT 'Required provider-to-member ratio.',
    `regulatory_source` STRING COMMENT 'Source of the regulatory requirement.',
    `service_area_type` STRING COMMENT 'Type of service area.',
    `specialty_category` STRING COMMENT 'Specialty category.',
    `standard_category` STRING COMMENT 'Category of the standard.',
    `standard_code` STRING COMMENT 'Code for the standard.',
    `standard_name` STRING COMMENT 'Name of the standard.',
    `standard_version` STRING COMMENT 'Version of the standard.',
    `telehealth_equivalency_allowed` DECIMAL(18,2) COMMENT 'Telehealth equivalency allowance.',
    `telehealth_percentage_cap` DECIMAL(18,2) COMMENT 'Cap on telehealth percentage.',
    `termination_date` DATE COMMENT 'Termination date.',
    `threshold_percentage` DECIMAL(18,2) COMMENT 'Compliance threshold percentage.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_adequacy_standard PRIMARY KEY(`adequacy_standard_id`)
) COMMENT 'Defines regulatory and internal standards for network adequacy including distance, time, and ratio requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` (
    `adequacy_assessment_id` BIGINT COMMENT 'Surrogate primary key.',
    `adequacy_standard_id` BIGINT COMMENT 'FK to the adequacy standard.',
    `obligation_id` BIGINT COMMENT 'FK to regulatory obligation.',
    `cost_center_id` BIGINT COMMENT 'FK to cost center.',
    `health_plan_id` BIGINT COMMENT 'FK to health plan.',
    `network_service_area_id` BIGINT COMMENT 'FK to network service area.',
    `provider_network_id` BIGINT COMMENT 'FK to provider network.',
    `pool_id` BIGINT COMMENT 'FK to risk pool.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates if providers are accepting new patients.',
    `appointment_type_requested` STRING COMMENT 'Type of appointment assessed.',
    `assessment_date` DATE COMMENT 'Date of assessment.',
    `assessment_number` STRING COMMENT 'Assessment reference number.',
    `assessment_period_end_date` DATE COMMENT 'End of assessment period.',
    `assessment_period_start_date` DATE COMMENT 'Start of assessment period.',
    `assessment_type` STRING COMMENT 'Type of assessment.',
    `assessor_name` STRING COMMENT 'Name of the assessor.',
    `assessor_organization` STRING COMMENT 'Organization performing assessment.',
    `comments` STRING COMMENT 'Assessment comments.',
    `compliance_outcome` STRING COMMENT 'Outcome of compliance check.',
    `contract_provider_contract_id` BIGINT COMMENT 'FK to provider contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `facility_type` STRING COMMENT 'Type of facility assessed.',
    `gap_identified_flag` BOOLEAN COMMENT 'Indicates if a gap was identified.',
    `gap_severity` STRING COMMENT 'Severity of identified gap.',
    `member_to_provider_ratio` DECIMAL(18,2) COMMENT 'Measured member-to-provider ratio.',
    `provider_count_available` STRING COMMENT 'Number of providers available.',
    `provider_count_required` STRING COMMENT 'Number of providers required.',
    `regulatory_submission_type` STRING COMMENT 'Type of regulatory submission.',
    `remediation_action_taken` STRING COMMENT 'Remediation actions taken.',
    `remediation_due_date` DATE COMMENT 'Due date for remediation.',
    `remediation_status` STRING COMMENT 'Status of remediation.',
    `specialty_type` STRING COMMENT 'Specialty type assessed.',
    `submission_date` DATE COMMENT 'Date of submission.',
    `submission_status` STRING COMMENT 'Status of submission.',
    `survey_method` STRING COMMENT 'Method of survey.',
    `telehealth_offered_flag` BOOLEAN COMMENT 'Indicates telehealth availability.',
    `time_distance_compliance_percentage` DECIMAL(18,2) COMMENT 'Compliance percentage for time/distance.',
    `time_distance_standard_miles` DECIMAL(18,2) COMMENT 'Standard distance in miles.',
    `time_distance_standard_minutes` STRING COMMENT 'Standard time in minutes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `wait_time_days_routine` STRING COMMENT 'Wait time for routine appointments.',
    `wait_time_days_urgent` STRING COMMENT 'Wait time for urgent appointments.',
    CONSTRAINT pk_adequacy_assessment PRIMARY KEY(`adequacy_assessment_id`)
) COMMENT 'Records the results of a network adequacy assessment against defined standards.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` (
    `adequacy_gap_id` BIGINT COMMENT 'Surrogate primary key.',
    `adequacy_assessment_id` BIGINT COMMENT 'FK to the assessment.',
    `health_plan_id` BIGINT COMMENT 'FK to health plan.',
    `network_service_area_id` BIGINT COMMENT 'FK to network service area.',
    `provider_network_id` BIGINT COMMENT 'FK to provider network.',
    `actual_resolution_date` DATE COMMENT 'Actual date gap was resolved.',
    `affected_member_count` STRING COMMENT 'Number of members affected.',
    `available_provider_count` STRING COMMENT 'Providers currently available.',
    `contract_provider_contract_id` BIGINT COMMENT 'FK to provider contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp.',
    `exception_approval_date` DATE COMMENT 'Date exception was approved.',
    `exception_expiration_date` DATE COMMENT 'Expiration date of exception.',
    `exception_granted_flag` BOOLEAN COMMENT 'Indicates if exception was granted.',
    `exception_justification` STRING COMMENT 'Justification for exception.',
    `exception_request_date` DATE COMMENT 'Date exception was requested.',
    `exception_requested_flag` BOOLEAN COMMENT 'Indicates if exception was requested.',
    `gap_magnitude` STRING COMMENT 'Magnitude of the gap.',
    `gap_number` STRING COMMENT 'Reference number for the gap.',
    `gap_severity` STRING COMMENT 'Severity classification.',
    `gap_status` STRING COMMENT 'Current status of the gap.',
    `gap_type` STRING COMMENT 'Type of gap.',
    `geographic_area_code` STRING COMMENT 'Code for the geographic area.',
    `geographic_area_name` STRING COMMENT 'Name of the geographic area.',
    `geographic_area_type` STRING COMMENT 'Type of geographic area.',
    `identified_date` DATE COMMENT 'Date gap was identified.',
    `lob` STRING COMMENT 'Line of business.',
    `notes` STRING COMMENT 'Additional notes.',
    `plan_year` STRING COMMENT 'Plan year.',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Indicates if regulatory filing is required.',
    `remediation_action` STRING COMMENT 'Planned remediation action.',
    `remediation_owner` STRING COMMENT 'Owner of remediation.',
    `required_provider_count` STRING COMMENT 'Required number of providers.',
    `specialty_code` STRING COMMENT 'Specialty code.',
    `specialty_name` STRING COMMENT 'Specialty name.',
    `standard_threshold` STRING COMMENT 'Threshold from the standard.',
    `standard_type` STRING COMMENT 'Type of standard.',
    `target_resolution_date` DATE COMMENT 'Target date for resolution.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of last update.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_adequacy_gap PRIMARY KEY(`adequacy_gap_id`)
) COMMENT 'Tracks identified gaps in network adequacy including remediation plans and exception requests.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` (
    `provider_directory_id` BIGINT COMMENT 'Unique identifier for the provider directory record within the provider directory entity.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the directory vendor record within the provider directory entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the maintaining employee record within the provider directory entity.',
    `practice_location_id` BIGINT COMMENT 'Provider Id',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network record within the provider directory entity.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Boolean indicator for the accepting new patients condition or state.',
    `accessibility_features` STRING COMMENT 'The accessibility features attribute capturing relevant data for the provider directory in the network domain.',
    `ada_compliant_flag` BOOLEAN COMMENT 'Boolean indicator for the ada compliant condition or state.',
    `address_line_1` STRING COMMENT 'The address line 1 attribute capturing relevant data for the provider directory in the network domain.',
    `address_line_2` STRING COMMENT 'The address line 2 attribute capturing relevant data for the provider directory in the network domain.',
    `board_certification_status` STRING COMMENT 'The current status indicator for the board certification within the workflow.',
    `city` STRING COMMENT 'The city attribute capturing relevant data for the provider directory in the network domain.',
    `county` STRING COMMENT 'The county attribute capturing relevant data for the provider directory in the network domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the provider directory in the network domain.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'The data quality score attribute capturing relevant data for the provider directory in the network domain.',
    `directory_publication_channel` STRING COMMENT 'The directory publication channel attribute capturing relevant data for the provider directory in the network domain.',
    `directory_status` STRING COMMENT 'The current status indicator for the directory within the workflow.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this provider directory record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this provider directory record.',
    `email_address` STRING COMMENT 'The email address attribute capturing relevant data for the provider directory in the network domain.',
    `fax_number` STRING COMMENT 'The fax number attribute capturing relevant data for the provider directory in the network domain.',
    `gender` STRING COMMENT 'The gender attribute capturing relevant data for the provider directory in the network domain.',
    `hospital_affiliation` STRING COMMENT 'The hospital affiliation attribute capturing relevant data for the provider directory in the network domain.',
    `languages_spoken` STRING COMMENT 'The languages spoken attribute capturing relevant data for the provider directory in the network domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp attribute capturing relevant data for the provider directory in the network domain.',
    `last_verification_method` STRING COMMENT 'The last verification method attribute capturing relevant data for the provider directory in the network domain.',
    `last_verification_outcome` STRING COMMENT 'The last verification outcome attribute capturing relevant data for the provider directory in the network domain.',
    `last_verified_date` DATE COMMENT 'The date value representing last verified date for this provider directory record.',
    `next_verification_due_date` DATE COMMENT 'The date value representing next verification due date for this provider directory record.',
    `npi` STRING COMMENT 'The npi attribute capturing relevant data for the provider directory in the network domain.',
    `phone_number` STRING COMMENT 'The phone number attribute capturing relevant data for the provider directory in the network domain.',
    `practice_location_name` STRING COMMENT 'The descriptive name assigned to the practice location for identification purposes.',
    `specialty_primary` STRING COMMENT 'The specialty primary attribute capturing relevant data for the provider directory in the network domain.',
    `specialty_secondary` STRING COMMENT 'The specialty secondary attribute capturing relevant data for the provider directory in the network domain.',
    `state` STRING COMMENT 'The state attribute capturing relevant data for the provider directory in the network domain.',
    `telehealth_available_flag` BOOLEAN COMMENT 'Boolean indicator for the telehealth available condition or state.',
    `termination_reason` STRING COMMENT 'The termination reason attribute capturing relevant data for the provider directory in the network domain.',
    `verified_fields` STRING COMMENT 'The verified fields attribute capturing relevant data for the provider directory in the network domain.',
    `verifying_agent` STRING COMMENT 'The verifying agent attribute capturing relevant data for the provider directory in the network domain.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `website_url` STRING COMMENT 'The website url attribute capturing relevant data for the provider directory in the network domain.',
    `zip_code` STRING COMMENT 'A standardized code representing the zip classification.',
    CONSTRAINT pk_provider_directory PRIMARY KEY(`provider_directory_id`)
) COMMENT 'Provider directory entry with verified contact and practice information for member-facing directories.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` (
    `network_directory_verification_id` BIGINT COMMENT 'Unique identifier for the network directory verification record within the network directory verification entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record within the network directory verification entity.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan record within the network directory verification entity.',
    `practice_location_id` BIGINT COMMENT 'Provider Id',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network record within the network directory verification entity.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the verification vendor record within the network directory verification entity.',
    `accepting_new_patients_status` STRING COMMENT 'The current status indicator for the accepting new patients within the workflow.',
    `accepting_new_patients_verified` BOOLEAN COMMENT 'The accepting new patients verified attribute capturing relevant data for the network directory verification in the network domain.',
    `accuracy_score` DECIMAL(18,2) COMMENT 'The accuracy score attribute capturing relevant data for the network directory verification in the network domain.',
    `address_verified` BOOLEAN COMMENT 'The address verified attribute capturing relevant data for the network directory verification in the network domain.',
    `change_summary` STRING COMMENT 'The change summary attribute capturing relevant data for the network directory verification in the network domain.',
    `changes_identified` BOOLEAN COMMENT 'The changes identified attribute capturing relevant data for the network directory verification in the network domain.',
    `cms_reportable` BOOLEAN COMMENT 'The cms reportable attribute capturing relevant data for the network directory verification in the network domain.',
    `compliance_quarter` STRING COMMENT 'The compliance quarter attribute capturing relevant data for the network directory verification in the network domain.',
    `compliance_year` STRING COMMENT 'The calendar or fiscal year associated with the compliance.',
    `contact_attempt_count` STRING COMMENT 'The total count of contact attempt items associated with this record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the network directory verification in the network domain.',
    `directory_update_timestamp` TIMESTAMP COMMENT 'The directory update timestamp attribute capturing relevant data for the network directory verification in the network domain.',
    `directory_updated` BOOLEAN COMMENT 'The directory updated attribute capturing relevant data for the network directory verification in the network domain.',
    `first_contact_attempt_date` DATE COMMENT 'The date value representing first contact attempt date for this network directory verification record.',
    `last_contact_attempt_date` DATE COMMENT 'The date value representing last contact attempt date for this network directory verification record.',
    `next_verification_due_date` DATE COMMENT 'The date value representing next verification due date for this network directory verification record.',
    `npi_verified` BOOLEAN COMMENT 'The npi verified attribute capturing relevant data for the network directory verification in the network domain.',
    `phone_verified` BOOLEAN COMMENT 'The phone verified attribute capturing relevant data for the network directory verification in the network domain.',
    `prior_verification_date` DATE COMMENT 'The date value representing prior verification date for this network directory verification record.',
    `provider_response_time_hours` DECIMAL(18,2) COMMENT 'The provider response time hours attribute capturing relevant data for the network directory verification in the network domain.',
    `specialty_verified` BOOLEAN COMMENT 'The specialty verified attribute capturing relevant data for the network directory verification in the network domain.',
    `updated_by` STRING COMMENT 'The updated by attribute capturing relevant data for the network directory verification in the network domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the network directory verification in the network domain.',
    `verification_agent_name` STRING COMMENT 'The descriptive name assigned to the verification agent for identification purposes.',
    `verification_channel` STRING COMMENT 'The verification channel attribute capturing relevant data for the network directory verification in the network domain.',
    `verification_date` DATE COMMENT 'The date value representing verification date for this network directory verification record.',
    `verification_language` STRING COMMENT 'The verification language attribute capturing relevant data for the network directory verification in the network domain.',
    `verification_method` STRING COMMENT 'The verification method attribute capturing relevant data for the network directory verification in the network domain.',
    `verification_notes` STRING COMMENT 'The verification notes attribute capturing relevant data for the network directory verification in the network domain.',
    `verification_number` STRING COMMENT 'The verification number attribute capturing relevant data for the network directory verification in the network domain.',
    `verification_source_document` STRING COMMENT 'The verification source document attribute capturing relevant data for the network directory verification in the network domain.',
    `verification_status` STRING COMMENT 'The current status indicator for the verification within the workflow.',
    `verification_system` STRING COMMENT 'The verification system attribute capturing relevant data for the network directory verification in the network domain.',
    `verification_timestamp` TIMESTAMP COMMENT 'The verification timestamp attribute capturing relevant data for the network directory verification in the network domain.',
    `verified_fields` STRING COMMENT 'The verified fields attribute capturing relevant data for the network directory verification in the network domain.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the network directory verification in the network domain.',
    CONSTRAINT pk_network_directory_verification PRIMARY KEY(`network_directory_verification_id`)
) COMMENT 'Tracks verification activities for provider directory accuracy compliance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` (
    `vbc_arrangement_id` BIGINT COMMENT 'Unique identifier for the vbc arrangement record within the vbc arrangement entity.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center record within the vbc arrangement entity.',
    `vbc_program_id` BIGINT COMMENT 'Unique identifier for the vbc program record within the vbc arrangement entity.',
    `arrangement_name` STRING COMMENT 'The descriptive name assigned to the arrangement for identification purposes.',
    `arrangement_number` STRING COMMENT 'The arrangement number attribute capturing relevant data for the vbc arrangement in the network domain.',
    `arrangement_status` STRING COMMENT 'The current status indicator for the arrangement within the workflow.',
    `arrangement_type` STRING COMMENT 'The category or classification type of the arrangement.',
    `attributed_member_count` STRING COMMENT 'The total count of attributed member items associated with this record.',
    `attribution_methodology` STRING COMMENT 'The attribution methodology attribute capturing relevant data for the vbc arrangement in the network domain.',
    `benchmark_amount` DECIMAL(18,2) COMMENT 'The numeric benchmark amount value associated with this vbc arrangement record.',
    `benchmark_methodology` STRING COMMENT 'The benchmark methodology attribute capturing relevant data for the vbc arrangement in the network domain.',
    `care_coordination_required_flag` BOOLEAN COMMENT 'Boolean indicator for the care coordination required condition or state.',
    `cms_aco_code` STRING COMMENT 'A standardized code representing the cms aco classification.',
    `cms_reporting_required_flag` BOOLEAN COMMENT 'Boolean indicator for the cms reporting required condition or state.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the vbc arrangement in the network domain.',
    `data_sharing_agreement_flag` BOOLEAN COMMENT 'Boolean indicator for the data sharing agreement condition or state.',
    `effective_end_date` DATE COMMENT 'The date value representing effective end date for this vbc arrangement record.',
    `effective_start_date` DATE COMMENT 'The date value representing effective start date for this vbc arrangement record.',
    `health_it_certification_required_flag` BOOLEAN COMMENT 'Boolean indicator for the health it certification required condition or state.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp attribute capturing relevant data for the vbc arrangement in the network domain.',
    `minimum_loss_rate` DECIMAL(18,2) COMMENT 'The numeric minimum loss rate value associated with this vbc arrangement record.',
    `minimum_savings_rate` DECIMAL(18,2) COMMENT 'The numeric minimum savings rate value associated with this vbc arrangement record.',
    `participating_aco_name` STRING COMMENT 'The descriptive name assigned to the participating aco for identification purposes.',
    `participating_provider_count` STRING COMMENT 'The total count of participating provider items associated with this record.',
    `participating_tin` STRING COMMENT 'The participating tin attribute capturing relevant data for the vbc arrangement in the network domain.',
    `performance_guarantee_amount` DECIMAL(18,2) COMMENT 'The numeric performance guarantee amount value associated with this vbc arrangement record.',
    `performance_year` STRING COMMENT 'The calendar or fiscal year associated with the performance.',
    `primary_care_physician_count` STRING COMMENT 'The total count of primary care physician items associated with this record.',
    `quality_measure_set` STRING COMMENT 'The quality measure set attribute capturing relevant data for the vbc arrangement in the network domain.',
    `quality_performance_threshold` DECIMAL(18,2) COMMENT 'The quality performance threshold attribute capturing relevant data for the vbc arrangement in the network domain.',
    `reconciliation_frequency` STRING COMMENT 'The reconciliation frequency attribute capturing relevant data for the vbc arrangement in the network domain.',
    `record_type` STRING COMMENT 'The category or classification type of the record.',
    `risk_model` STRING COMMENT 'The risk model attribute capturing relevant data for the vbc arrangement in the network domain.',
    `service_area_description` STRING COMMENT 'A detailed textual description of the service area.',
    `shared_loss_rate` DECIMAL(18,2) COMMENT 'The numeric shared loss rate value associated with this vbc arrangement record.',
    `shared_savings_rate` DECIMAL(18,2) COMMENT 'The numeric shared savings rate value associated with this vbc arrangement record.',
    `specialist_physician_count` STRING COMMENT 'The total count of specialist physician items associated with this record.',
    `sponsoring_entity_name` STRING COMMENT 'The descriptive name assigned to the sponsoring entity for identification purposes.',
    `stop_loss_limit` DECIMAL(18,2) COMMENT 'The stop loss limit attribute capturing relevant data for the vbc arrangement in the network domain.',
    `termination_date` DATE COMMENT 'The date value representing termination date for this vbc arrangement record.',
    `termination_reason` STRING COMMENT 'The termination reason attribute capturing relevant data for the vbc arrangement in the network domain.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    CONSTRAINT pk_vbc_arrangement PRIMARY KEY(`vbc_arrangement_id`)
) COMMENT 'Defines value-based care arrangements including shared savings/loss parameters.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` (
    `aco_provider_id` BIGINT COMMENT 'Unique identifier for the aco provider record within the aco provider entity.',
    `practice_location_id` BIGINT COMMENT 'Service Location Id',
    `vbc_arrangement_id` BIGINT COMMENT 'Unique identifier for the vbc arrangement record within the aco provider entity.',
    `attributed_member_count` STRING COMMENT 'The total count of attributed member items associated with this record.',
    `attribution_methodology` STRING COMMENT 'The attribution methodology attribute capturing relevant data for the aco provider in the network domain.',
    `care_coordination_tier` STRING COMMENT 'The care coordination tier attribute capturing relevant data for the aco provider in the network domain.',
    `cost_efficiency_score` DECIMAL(18,2) COMMENT 'The cost efficiency score attribute capturing relevant data for the aco provider in the network domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the aco provider in the network domain.',
    `credentialing_status` STRING COMMENT 'The current status indicator for the credentialing within the workflow.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this aco provider record.',
    `ehr_integration_flag` BOOLEAN COMMENT 'Boolean indicator for the ehr integration condition or state.',
    `enrollment_date` DATE COMMENT 'The date value representing enrollment date for this aco provider record.',
    `internal_notes` STRING COMMENT 'The internal notes attribute capturing relevant data for the aco provider in the network domain.',
    `last_credentialing_date` DATE COMMENT 'The date value representing last credentialing date for this aco provider record.',
    `last_updated_by` STRING COMMENT 'The last updated by attribute capturing relevant data for the aco provider in the network domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp attribute capturing relevant data for the aco provider in the network domain.',
    `next_credentialing_date` DATE COMMENT 'The date value representing next credentialing date for this aco provider record.',
    `panel_size_limit` STRING COMMENT 'The panel size limit attribute capturing relevant data for the aco provider in the network domain.',
    `participation_role` STRING COMMENT 'The participation role attribute capturing relevant data for the aco provider in the network domain.',
    `participation_status` STRING COMMENT 'The current status indicator for the participation within the workflow.',
    `participation_type` STRING COMMENT 'The category or classification type of the participation.',
    `performance_year` STRING COMMENT 'The calendar or fiscal year associated with the performance.',
    `primary_care_flag` BOOLEAN COMMENT 'Boolean indicator for the primary care condition or state.',
    `provider_npi` STRING COMMENT 'The provider npi attribute capturing relevant data for the aco provider in the network domain.',
    `provider_tin` STRING COMMENT 'The provider tin attribute capturing relevant data for the aco provider in the network domain.',
    `quality_reporting_flag` BOOLEAN COMMENT 'Boolean indicator for the quality reporting condition or state.',
    `quality_score` DECIMAL(18,2) COMMENT 'The quality score attribute capturing relevant data for the aco provider in the network domain.',
    `risk_sharing_percentage` DECIMAL(18,2) COMMENT 'The risk sharing percentage attribute capturing relevant data for the aco provider in the network domain.',
    `shared_savings_eligible_flag` BOOLEAN COMMENT 'Boolean indicator for the shared savings eligible condition or state.',
    `specialty_code` STRING COMMENT 'A standardized code representing the specialty classification.',
    `termination_date` DATE COMMENT 'The date value representing termination date for this aco provider record.',
    `termination_reason_code` STRING COMMENT 'A standardized code representing the termination reason classification.',
    `vbc_track` STRING COMMENT 'The vbc track attribute capturing relevant data for the aco provider in the network domain.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the aco provider in the network domain.',
    CONSTRAINT pk_aco_provider PRIMARY KEY(`aco_provider_id`)
) COMMENT 'Tracks provider participation in ACO/VBC arrangements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`exception` (
    `exception_id` BIGINT COMMENT 'Unique identifier for the exception record within the exception entity.',
    `case_id` BIGINT COMMENT 'Unique identifier for the case record within the exception entity.',
    `benefit_package_id` BIGINT COMMENT 'Unique identifier for the cms plan benefit package record within the exception entity.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the health plan record within the exception entity.',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network record within the exception entity.',
    `affected_member_count` STRING COMMENT 'The total count of affected member items associated with this record.',
    `alternative_access_arrangement` STRING COMMENT 'The alternative access arrangement attribute capturing relevant data for the exception in the network domain.',
    `appeal_decision` STRING COMMENT 'The appeal decision attribute capturing relevant data for the exception in the network domain.',
    `appeal_filed_flag` BOOLEAN COMMENT 'Boolean indicator for the appeal filed condition or state.',
    `approval_date` DATE COMMENT 'The date value representing approval date for this exception record.',
    `approved_terms` STRING COMMENT 'The approved terms attribute capturing relevant data for the exception in the network domain.',
    `cms_contract_number` STRING COMMENT 'The cms contract number attribute capturing relevant data for the exception in the network domain.',
    `contract_provider_contract_id` BIGINT COMMENT 'Unique identifier for the contract provider contract record within the exception entity.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the exception in the network domain.',
    `denial_date` DATE COMMENT 'The date value representing denial date for this exception record.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this exception record.',
    `exception_number` STRING COMMENT 'The exception number attribute capturing relevant data for the exception in the network domain.',
    `exception_status` STRING COMMENT 'The current status indicator for the exception within the workflow.',
    `exception_type` STRING COMMENT 'The category or classification type of the exception.',
    `expiration_date` DATE COMMENT 'The date value representing expiration date for this exception record.',
    `filing_date` DATE COMMENT 'The date value representing filing date for this exception record.',
    `geographic_description` STRING COMMENT 'A detailed textual description of the geographic.',
    `internal_notes` STRING COMMENT 'The internal notes attribute capturing relevant data for the exception in the network domain.',
    `last_updated_by` STRING COMMENT 'The last updated by attribute capturing relevant data for the exception in the network domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp attribute capturing relevant data for the exception in the network domain.',
    `lob` STRING COMMENT 'The lob attribute capturing relevant data for the exception in the network domain.',
    `member_notification_date` DATE COMMENT 'The date value representing member notification date for this exception record.',
    `member_notification_flag` BOOLEAN COMMENT 'Boolean indicator for the member notification condition or state.',
    `mitigation_plan` STRING COMMENT 'The mitigation plan attribute capturing relevant data for the exception in the network domain.',
    `provider_recruitment_effort` STRING COMMENT 'The provider recruitment effort attribute capturing relevant data for the exception in the network domain.',
    `reason` STRING COMMENT 'The reason attribute capturing relevant data for the exception in the network domain.',
    `regulatory_body` STRING COMMENT 'The regulatory body attribute capturing relevant data for the exception in the network domain.',
    `regulatory_jurisdiction` STRING COMMENT 'The regulatory jurisdiction attribute capturing relevant data for the exception in the network domain.',
    `review_due_date` DATE COMMENT 'The date value representing review due date for this exception record.',
    `service_area_code` STRING COMMENT 'A standardized code representing the service area classification.',
    `specialty_code` STRING COMMENT 'A standardized code representing the specialty classification.',
    `specialty_name` STRING COMMENT 'The descriptive name assigned to the specialty for identification purposes.',
    `supporting_documentation_reference` STRING COMMENT 'The supporting documentation reference attribute capturing relevant data for the exception in the network domain.',
    `time_distance_standard_waived` STRING COMMENT 'The time distance standard waived attribute capturing relevant data for the exception in the network domain.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the exception in the network domain.',
    CONSTRAINT pk_exception PRIMARY KEY(`exception_id`)
) COMMENT 'Records network adequacy exceptions granted by regulators.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`change_event` (
    `change_event_id` BIGINT COMMENT 'Unique identifier for the change event record within the change event entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record within the change event entity.',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network record within the change event entity.',
    `regulatory_change_id` BIGINT COMMENT 'Unique identifier for the regulatory change record within the change event entity.',
    `aco_participation_flag` BOOLEAN COMMENT 'Boolean indicator for the aco participation condition or state.',
    `change_approval_date` DATE COMMENT 'The date value representing change approval date for this change event record.',
    `change_effective_date` DATE COMMENT 'The date value representing change effective date for this change event record.',
    `change_reason_code` STRING COMMENT 'A standardized code representing the change reason classification.',
    `change_reason_description` STRING COMMENT 'A detailed textual description of the change reason.',
    `change_request_date` DATE COMMENT 'The date value representing change request date for this change event record.',
    `change_status` STRING COMMENT 'The current status indicator for the change within the workflow.',
    `change_type` STRING COMMENT 'The category or classification type of the change.',
    `continuity_of_care_end_date` DATE COMMENT 'The date value representing continuity of care end date for this change event record.',
    `contract_provider_contract_id` BIGINT COMMENT 'Unique identifier for the contract provider contract record within the change event entity.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the change event in the network domain.',
    `facility_type` STRING COMMENT 'The category or classification type of the facility.',
    `internal_notes` STRING COMMENT 'The internal notes attribute capturing relevant data for the change event in the network domain.',
    `last_updated_by` STRING COMMENT 'The last updated by attribute capturing relevant data for the change event in the network domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp attribute capturing relevant data for the change event in the network domain.',
    `lob_applicability` STRING COMMENT 'The lob applicability attribute capturing relevant data for the change event in the network domain.',
    `member_impact_count` STRING COMMENT 'The total count of member impact items associated with this record.',
    `member_notification_required_flag` BOOLEAN COMMENT 'Boolean indicator for the member notification required condition or state.',
    `member_notification_sent_date` DATE COMMENT 'The date value representing member notification sent date for this change event record.',
    `member_notification_status` STRING COMMENT 'The current status indicator for the member notification within the workflow.',
    `member_transition_plan_required_flag` BOOLEAN COMMENT 'Boolean indicator for the member transition plan required condition or state.',
    `network_adequacy_impact_flag` BOOLEAN COMMENT 'Boolean indicator for the network adequacy impact condition or state.',
    `new_panel_status` STRING COMMENT 'The current status indicator for the new panel within the workflow.',
    `new_tier_code` STRING COMMENT 'A standardized code representing the new tier classification.',
    `prior_panel_status` STRING COMMENT 'The current status indicator for the prior panel within the workflow.',
    `prior_tier_code` STRING COMMENT 'A standardized code representing the prior tier classification.',
    `provider_directory_update_date` DATE COMMENT 'The date value representing provider directory update date for this change event record.',
    `provider_npi` STRING COMMENT 'The provider npi attribute capturing relevant data for the change event in the network domain.',
    `regulatory_approval_date` DATE COMMENT 'The date value representing regulatory approval date for this change event record.',
    `regulatory_filing_date` DATE COMMENT 'The date value representing regulatory filing date for this change event record.',
    `regulatory_filing_reference` STRING COMMENT 'The regulatory filing reference attribute capturing relevant data for the change event in the network domain.',
    `regulatory_reporting_required_flag` BOOLEAN COMMENT 'Boolean indicator for the regulatory reporting required condition or state.',
    `service_area_code` STRING COMMENT 'A standardized code representing the service area classification.',
    `specialty_type` STRING COMMENT 'The category or classification type of the specialty.',
    `termination_notice_date` DATE COMMENT 'The date value representing termination notice date for this change event record.',
    `termination_type` STRING COMMENT 'The category or classification type of the termination.',
    `transition_plan_completion_date` DATE COMMENT 'The date value representing transition plan completion date for this change event record.',
    `vbc_arrangement_flag` BOOLEAN COMMENT 'Boolean indicator for the vbc arrangement condition or state.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the change event in the network domain.',
    CONSTRAINT pk_change_event PRIMARY KEY(`change_event_id`)
) COMMENT 'Tracks network change events including provider additions, terminations, and tier changes.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`access_standard` (
    `access_standard_id` BIGINT COMMENT 'Unique identifier for the access standard record within the access standard entity.',
    `superseded_by_standard_access_standard_id` BIGINT COMMENT 'Unique identifier for the superseded by standard access standard record within the access standard entity.',
    `access_standard_status` STRING COMMENT 'The current status indicator for the access standard within the workflow.',
    `after_hours_availability_required_flag` BOOLEAN COMMENT 'Boolean indicator for the after hours availability required condition or state.',
    `appointment_type_scope` STRING COMMENT 'The appointment type scope attribute capturing relevant data for the access standard in the network domain.',
    `compliance_measurement_method` STRING COMMENT 'The compliance measurement method attribute capturing relevant data for the access standard in the network domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the access standard in the network domain.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this access standard record.',
    `exception_criteria` STRING COMMENT 'The exception criteria attribute capturing relevant data for the access standard in the network domain.',
    `internal_notes` STRING COMMENT 'The internal notes attribute capturing relevant data for the access standard in the network domain.',
    `last_updated_by` STRING COMMENT 'The last updated by attribute capturing relevant data for the access standard in the network domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp attribute capturing relevant data for the access standard in the network domain.',
    `line_of_business_applicability` STRING COMMENT 'The line of business applicability attribute capturing relevant data for the access standard in the network domain.',
    `maximum_wait_time_days` STRING COMMENT 'The maximum wait time days attribute capturing relevant data for the access standard in the network domain.',
    `maximum_wait_time_hours` STRING COMMENT 'The maximum wait time hours attribute capturing relevant data for the access standard in the network domain.',
    `member_age_group` STRING COMMENT 'The member age group attribute capturing relevant data for the access standard in the network domain.',
    `monitoring_frequency` STRING COMMENT 'The monitoring frequency attribute capturing relevant data for the access standard in the network domain.',
    `network_adequacy_credit_flag` BOOLEAN COMMENT 'Boolean indicator for the network adequacy credit condition or state.',
    `penalty_for_noncompliance` STRING COMMENT 'The penalty for noncompliance attribute capturing relevant data for the access standard in the network domain.',
    `regulatory_citation` STRING COMMENT 'The regulatory citation attribute capturing relevant data for the access standard in the network domain.',
    `regulatory_source` STRING COMMENT 'The regulatory source attribute capturing relevant data for the access standard in the network domain.',
    `specialty_category` STRING COMMENT 'The specialty category attribute capturing relevant data for the access standard in the network domain.',
    `standard_code` STRING COMMENT 'A standardized code representing the standard classification.',
    `standard_name` STRING COMMENT 'The descriptive name assigned to the standard for identification purposes.',
    `standard_type` STRING COMMENT 'The category or classification type of the standard.',
    `telehealth_equivalency_flag` BOOLEAN COMMENT 'Boolean indicator for the telehealth equivalency condition or state.',
    `termination_date` DATE COMMENT 'The date value representing termination date for this access standard record.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the access standard in the network domain.',
    CONSTRAINT pk_access_standard PRIMARY KEY(`access_standard_id`)
) COMMENT 'Defines appointment access and wait time standards for network providers.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`access_survey` (
    `access_survey_id` BIGINT COMMENT 'Unique identifier for the access survey record within the access survey entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record within the access survey entity.',
    `practice_location_id` BIGINT COMMENT 'Provider Id',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network record within the access survey entity.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Boolean indicator for the accepting new patients condition or state.',
    `access_standard_met_flag` BOOLEAN COMMENT 'Boolean indicator for the access standard met condition or state.',
    `access_standard_threshold_days` STRING COMMENT 'The access standard threshold days attribute capturing relevant data for the access survey in the network domain.',
    `accessibility_accommodation_available_flag` BOOLEAN COMMENT 'Boolean indicator for the accessibility accommodation available condition or state.',
    `accessibility_accommodation_requested_flag` BOOLEAN COMMENT 'Boolean indicator for the accessibility accommodation requested condition or state.',
    `after_hours_access_available_flag` BOOLEAN COMMENT 'Boolean indicator for the after hours access available condition or state.',
    `appointment_offered_date` DATE COMMENT 'The date value representing appointment offered date for this access survey record.',
    `appointment_reason` STRING COMMENT 'The appointment reason attribute capturing relevant data for the access survey in the network domain.',
    `appointment_scheduled_flag` BOOLEAN COMMENT 'Boolean indicator for the appointment scheduled condition or state.',
    `appointment_type_requested` STRING COMMENT 'The appointment type requested attribute capturing relevant data for the access survey in the network domain.',
    `cahps_survey_supplementation_flag` BOOLEAN COMMENT 'Boolean indicator for the cahps survey supplementation condition or state.',
    `call_attempts` STRING COMMENT 'The call attempts attribute capturing relevant data for the access survey in the network domain.',
    `call_outcome` STRING COMMENT 'The call outcome attribute capturing relevant data for the access survey in the network domain.',
    `cms_star_rating_applicable_flag` BOOLEAN COMMENT 'Boolean indicator for the cms star rating applicable condition or state.',
    `compliance_outcome` STRING COMMENT 'The compliance outcome attribute capturing relevant data for the access survey in the network domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the access survey in the network domain.',
    `data_source` STRING COMMENT 'The data source attribute capturing relevant data for the access survey in the network domain.',
    `hedis_measure_applicable_flag` BOOLEAN COMMENT 'Boolean indicator for the hedis measure applicable condition or state.',
    `language_requested` STRING COMMENT 'The language requested attribute capturing relevant data for the access survey in the network domain.',
    `language_services_available_flag` BOOLEAN COMMENT 'Boolean indicator for the language services available condition or state.',
    `last_updated_by` STRING COMMENT 'The last updated by attribute capturing relevant data for the access survey in the network domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp attribute capturing relevant data for the access survey in the network domain.',
    `network_adequacy_filing_applicable_flag` BOOLEAN COMMENT 'Boolean indicator for the network adequacy filing applicable condition or state.',
    `non_compliance_reason` STRING COMMENT 'The non compliance reason attribute capturing relevant data for the access survey in the network domain.',
    `npi` STRING COMMENT 'The npi attribute capturing relevant data for the access survey in the network domain.',
    `specialty_code` STRING COMMENT 'A standardized code representing the specialty classification.',
    `specialty_name` STRING COMMENT 'The descriptive name assigned to the specialty for identification purposes.',
    `survey_cycle` STRING COMMENT 'The survey cycle attribute capturing relevant data for the access survey in the network domain.',
    `survey_date` DATE COMMENT 'The date value representing survey date for this access survey record.',
    `survey_method` STRING COMMENT 'The survey method attribute capturing relevant data for the access survey in the network domain.',
    `survey_notes` STRING COMMENT 'The survey notes attribute capturing relevant data for the access survey in the network domain.',
    `survey_status` STRING COMMENT 'The current status indicator for the survey within the workflow.',
    `telehealth_offered_flag` BOOLEAN COMMENT 'Boolean indicator for the telehealth offered condition or state.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `wait_time_offered_days` STRING COMMENT 'The wait time offered days attribute capturing relevant data for the access survey in the network domain.',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the access survey in the network domain.',
    CONSTRAINT pk_access_survey PRIMARY KEY(`access_survey_id`)
) COMMENT 'Records access survey results measuring appointment availability and wait times.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`filing` (
    `filing_id` BIGINT COMMENT 'Unique identifier for the filing record within the filing entity.',
    `benefit_package_id` BIGINT COMMENT 'Unique identifier for the plan benefit package record within the filing entity.',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network record within the filing entity.',
    `adequacy_standard_met_flag` BOOLEAN COMMENT 'Boolean indicator for the adequacy standard met condition or state.',
    `approval_date` DATE COMMENT 'The date value representing approval date for this filing record.',
    `approval_number` STRING COMMENT 'The approval number attribute capturing relevant data for the filing in the network domain.',
    `attestation_date` DATE COMMENT 'The date value representing attestation date for this filing record.',
    `attestation_flag` BOOLEAN COMMENT 'Boolean indicator for the attestation condition or state.',
    `contract_number` STRING COMMENT 'The contract number attribute capturing relevant data for the filing in the network domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the filing in the network domain.',
    `deficiency_description` STRING COMMENT 'A detailed textual description of the deficiency.',
    `deficiency_issued_date` DATE COMMENT 'The date value representing deficiency issued date for this filing record.',
    `deficiency_issued_flag` BOOLEAN COMMENT 'Boolean indicator for the deficiency issued condition or state.',
    `exception_approval_date` DATE COMMENT 'The date value representing exception approval date for this filing record.',
    `exception_approved_flag` BOOLEAN COMMENT 'Boolean indicator for the exception approved condition or state.',
    `exception_expiration_date` DATE COMMENT 'The date value representing exception expiration date for this filing record.',
    `exception_geography` STRING COMMENT 'The exception geography attribute capturing relevant data for the filing in the network domain.',
    `exception_justification` STRING COMMENT 'The exception justification attribute capturing relevant data for the filing in the network domain.',
    `exception_specialty` STRING COMMENT 'The exception specialty attribute capturing relevant data for the filing in the network domain.',
    `exception_type` STRING COMMENT 'The category or classification type of the exception.',
    `filing_number` STRING COMMENT 'The filing number attribute capturing relevant data for the filing in the network domain.',
    `filing_status` STRING COMMENT 'The current status indicator for the filing within the workflow.',
    `filing_type` STRING COMMENT 'The category or classification type of the filing.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp attribute capturing relevant data for the filing in the network domain.',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the filing in the network domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the filing in the network domain.',
    `period_end_date` DATE COMMENT 'The date value representing period end date for this filing record.',
    `period_start_date` DATE COMMENT 'The date value representing period start date for this filing record.',
    `plan_year` STRING COMMENT 'The calendar or fiscal year associated with the plan.',
    `regulatory_body` STRING COMMENT 'The regulatory body attribute capturing relevant data for the filing in the network domain.',
    `regulatory_jurisdiction` STRING COMMENT 'The regulatory jurisdiction attribute capturing relevant data for the filing in the network domain.',
    `rejection_date` DATE COMMENT 'The date value representing rejection date for this filing record.',
    `rejection_reason` STRING COMMENT 'The rejection reason attribute capturing relevant data for the filing in the network domain.',
    `response_due_date` DATE COMMENT 'The date value representing response due date for this filing record.',
    `response_submitted_date` DATE COMMENT 'The date value representing response submitted date for this filing record.',
    `reviewer_name` STRING COMMENT 'The descriptive name assigned to the reviewer for identification purposes.',
    `submission_date` DATE COMMENT 'The date value representing submission date for this filing record.',
    `submission_method` STRING COMMENT 'The submission method attribute capturing relevant data for the filing in the network domain.',
    `submitted_by` STRING COMMENT 'The submitted by attribute capturing relevant data for the filing in the network domain.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `withdrawal_date` DATE COMMENT 'The date value representing withdrawal date for this filing record.',
    `withdrawal_reason` STRING COMMENT 'The withdrawal reason attribute capturing relevant data for the filing in the network domain.',
    CONSTRAINT pk_filing PRIMARY KEY(`filing_id`)
) COMMENT 'Tracks regulatory filings for network adequacy and compliance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` (
    `vbc_program_id` BIGINT COMMENT 'Unique identifier for the vbc program record within the vbc program entity.',
    `health_plan_id` BIGINT COMMENT 'Unique identifier for the plan health plan record within the vbc program entity.',
    `attribution_methodology` STRING COMMENT 'The attribution methodology attribute capturing relevant data for the vbc program in the network domain.',
    `benchmark_methodology` STRING COMMENT 'The benchmark methodology attribute capturing relevant data for the vbc program in the network domain.',
    `benchmark_year` STRING COMMENT 'The calendar or fiscal year associated with the benchmark.',
    `care_coordination_required_flag` BOOLEAN COMMENT 'Boolean indicator for the care coordination required condition or state.',
    `cms_program_identifier` STRING COMMENT 'The cms program identifier attribute capturing relevant data for the vbc program in the network domain.',
    `contact_email` STRING COMMENT 'The contact email attribute capturing relevant data for the vbc program in the network domain.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the vbc program in the network domain.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this vbc program record.',
    `eligible_provider_types` STRING COMMENT 'The eligible provider types attribute capturing relevant data for the vbc program in the network domain.',
    `health_it_requirement` STRING COMMENT 'The health it requirement attribute capturing relevant data for the vbc program in the network domain.',
    `internal_notes` STRING COMMENT 'The internal notes attribute capturing relevant data for the vbc program in the network domain.',
    `last_updated_by` STRING COMMENT 'The last updated by attribute capturing relevant data for the vbc program in the network domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp attribute capturing relevant data for the vbc program in the network domain.',
    `line_of_business` STRING COMMENT 'The line of business attribute capturing relevant data for the vbc program in the network domain.',
    `minimum_loss_rate` DECIMAL(18,2) COMMENT 'The numeric minimum loss rate value associated with this vbc program record.',
    `minimum_member_threshold` STRING COMMENT 'The minimum member threshold attribute capturing relevant data for the vbc program in the network domain.',
    `minimum_savings_rate` DECIMAL(18,2) COMMENT 'The numeric minimum savings rate value associated with this vbc program record.',
    `performance_period_end_date` DATE COMMENT 'The date value representing performance period end date for this vbc program record.',
    `performance_period_start_date` DATE COMMENT 'The date value representing performance period start date for this vbc program record.',
    `program_category` STRING COMMENT 'The program category attribute capturing relevant data for the vbc program in the network domain.',
    `program_code` STRING COMMENT 'A standardized code representing the program classification.',
    `program_description` STRING COMMENT 'A detailed textual description of the program.',
    `program_name` STRING COMMENT 'The descriptive name assigned to the program for identification purposes.',
    `program_owner` STRING COMMENT 'The program owner attribute capturing relevant data for the vbc program in the network domain.',
    `program_status` STRING COMMENT 'The current status indicator for the program within the workflow.',
    `program_type` STRING COMMENT 'The category or classification type of the program.',
    `program_url` STRING COMMENT 'The program url attribute capturing relevant data for the vbc program in the network domain.',
    `program_year` STRING COMMENT 'The calendar or fiscal year associated with the program.',
    `quality_measure_set` STRING COMMENT 'The quality measure set attribute capturing relevant data for the vbc program in the network domain.',
    `quality_performance_threshold` DECIMAL(18,2) COMMENT 'The quality performance threshold attribute capturing relevant data for the vbc program in the network domain.',
    `regulatory_filing_reference` STRING COMMENT 'The regulatory filing reference attribute capturing relevant data for the vbc program in the network domain.',
    `risk_model` STRING COMMENT 'The risk model attribute capturing relevant data for the vbc program in the network domain.',
    `settlement_frequency` DECIMAL(18,2) COMMENT 'The settlement frequency attribute capturing relevant data for the vbc program in the network domain.',
    `shared_loss_rate` DECIMAL(18,2) COMMENT 'The numeric shared loss rate value associated with this vbc program record.',
    `shared_savings_rate` DECIMAL(18,2) COMMENT 'The numeric shared savings rate value associated with this vbc program record.',
    `sponsoring_entity` STRING COMMENT 'The sponsoring entity attribute capturing relevant data for the vbc program in the network domain.',
    `termination_date` DATE COMMENT 'The date value representing termination date for this vbc program record.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the vbc program in the network domain.',
    CONSTRAINT pk_vbc_program PRIMARY KEY(`vbc_program_id`)
) COMMENT 'Defines value-based care programs with performance parameters and quality thresholds.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` (
    `network_recruitment_id` BIGINT COMMENT 'Unique identifier for the network recruitment record within the network recruitment entity.',
    `adequacy_assessment_id` BIGINT COMMENT 'Unique identifier for the adequacy assessment record within the network recruitment entity.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center record within the network recruitment entity.',
    `filing_id` BIGINT COMMENT 'Unique identifier for the primary network cms filing record within the network recruitment entity.',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network record within the network recruitment entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the recruiter employee record within the network recruitment entity.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record within the network recruitment entity.',
    `adequacy_gap_type` STRING COMMENT 'The category or classification type of the adequacy gap.',
    `contract_effective_date` DATE COMMENT 'The date value representing contract effective date for this network recruitment record.',
    `contract_provider_contract_id` BIGINT COMMENT 'Unique identifier for the contract provider contract record within the network recruitment entity.',
    `contracting_referral_date` DATE COMMENT 'The date value representing contracting referral date for this network recruitment record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the network recruitment in the network domain.',
    `disposition` STRING COMMENT 'The disposition attribute capturing relevant data for the network recruitment in the network domain.',
    `disposition_date` DATE COMMENT 'The date value representing disposition date for this network recruitment record.',
    `disposition_reason` STRING COMMENT 'The disposition reason attribute capturing relevant data for the network recruitment in the network domain.',
    `estimated_annual_claims_volume` DECIMAL(18,2) COMMENT 'The estimated annual claims volume attribute capturing relevant data for the network recruitment in the network domain.',
    `estimated_member_impact` STRING COMMENT 'The estimated member impact attribute capturing relevant data for the network recruitment in the network domain.',
    `follow_up_date` DATE COMMENT 'The date value representing follow up date for this network recruitment record.',
    `lob` STRING COMMENT 'The lob attribute capturing relevant data for the network recruitment in the network domain.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the network recruitment in the network domain.',
    `outreach_date` DATE COMMENT 'The date value representing outreach date for this network recruitment record.',
    `outreach_method` STRING COMMENT 'The outreach method attribute capturing relevant data for the network recruitment in the network domain.',
    `priority_level` STRING COMMENT 'The priority level attribute capturing relevant data for the network recruitment in the network domain.',
    `provider_response` STRING COMMENT 'The provider response attribute capturing relevant data for the network recruitment in the network domain.',
    `reason` STRING COMMENT 'The reason attribute capturing relevant data for the network recruitment in the network domain.',
    `recruiter_assigned` STRING COMMENT 'The recruiter assigned attribute capturing relevant data for the network recruitment in the network domain.',
    `recruitment_code` STRING COMMENT 'A standardized code representing the recruitment classification.',
    `recruitment_status` STRING COMMENT 'The current status indicator for the recruitment within the workflow.',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Boolean indicator for the regulatory filing required condition or state.',
    `response_date` DATE COMMENT 'The date value representing response date for this network recruitment record.',
    `target_county_fips` STRING COMMENT 'The target county fips attribute capturing relevant data for the network recruitment in the network domain.',
    `target_geographic_area` STRING COMMENT 'The target geographic area attribute capturing relevant data for the network recruitment in the network domain.',
    `target_provider_name` STRING COMMENT 'The descriptive name assigned to the target provider for identification purposes.',
    `target_provider_npi` STRING COMMENT 'The target provider npi attribute capturing relevant data for the network recruitment in the network domain.',
    `target_provider_tin` STRING COMMENT 'The target provider tin attribute capturing relevant data for the network recruitment in the network domain.',
    `target_specialty` STRING COMMENT 'The target specialty attribute capturing relevant data for the network recruitment in the network domain.',
    `target_zip_code` STRING COMMENT 'A standardized code representing the target zip classification.',
    `updated_by` STRING COMMENT 'The updated by attribute capturing relevant data for the network recruitment in the network domain.',
    `updated_timestamp` TIMESTAMP COMMENT 'The updated timestamp attribute capturing relevant data for the network recruitment in the network domain.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the network recruitment in the network domain.',
    CONSTRAINT pk_network_recruitment PRIMARY KEY(`network_recruitment_id`)
) COMMENT 'Tracks provider recruitment efforts to address network adequacy gaps.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`termination` (
    `termination_id` BIGINT COMMENT 'Unique identifier for the termination record within the termination entity.',
    `cost_center_id` BIGINT COMMENT 'Unique identifier for the cost center record within the termination entity.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record within the termination entity.',
    `practice_location_id` BIGINT COMMENT 'Provider Id',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network record within the termination entity.',
    `active_treatment_count` STRING COMMENT 'The total count of active treatment items associated with this record.',
    `appeal_outcome` STRING COMMENT 'The appeal outcome attribute capturing relevant data for the termination in the network domain.',
    `appeal_resolution_date` DATE COMMENT 'The date value representing appeal resolution date for this termination record.',
    `appeals_filed_flag` BOOLEAN COMMENT 'Boolean indicator for the appeals filed condition or state.',
    `claims_runout_end_date` DATE COMMENT 'The date value representing claims runout end date for this termination record.',
    `claims_runout_period_days` STRING COMMENT 'The claims runout period days attribute capturing relevant data for the termination in the network domain.',
    `continuity_of_care_end_date` DATE COMMENT 'The date value representing continuity of care end date for this termination record.',
    `contract_end_date` DATE COMMENT 'The date value representing contract end date for this termination record.',
    `contract_provider_contract_id` BIGINT COMMENT 'Unique identifier for the contract provider contract record within the termination entity.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the termination in the network domain.',
    `credentialing_related_flag` BOOLEAN COMMENT 'Boolean indicator for the credentialing related condition or state.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this termination record.',
    `financial_settlement_date` DATE COMMENT 'The date value representing financial settlement date for this termination record.',
    `financial_settlement_required_flag` BOOLEAN COMMENT 'Boolean indicator for the financial settlement required condition or state.',
    `for_cause_flag` BOOLEAN COMMENT 'Boolean indicator for the for cause condition or state.',
    `initiated_by` STRING COMMENT 'Termination Initiated By',
    `last_updated_by` STRING COMMENT 'The last updated by attribute capturing relevant data for the termination in the network domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp attribute capturing relevant data for the termination in the network domain.',
    `member_impact_count` STRING COMMENT 'The total count of member impact items associated with this record.',
    `member_notification_date` DATE COMMENT 'The date value representing member notification date for this termination record.',
    `member_notification_method` STRING COMMENT 'The member notification method attribute capturing relevant data for the termination in the network domain.',
    `member_notification_required_flag` BOOLEAN COMMENT 'Boolean indicator for the member notification required condition or state.',
    `network_adequacy_impact_flag` BOOLEAN COMMENT 'Boolean indicator for the network adequacy impact condition or state.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the termination in the network domain.',
    `notice_date` DATE COMMENT 'The date value representing notice date for this termination record.',
    `npi` STRING COMMENT 'The npi attribute capturing relevant data for the termination in the network domain.',
    `provider_directory_removal_date` DATE COMMENT 'The date value representing provider directory removal date for this termination record.',
    `reason_code` STRING COMMENT 'A standardized code representing the reason classification.',
    `reason_description` STRING COMMENT 'A detailed textual description of the reason.',
    `regulatory_filing_date` DATE COMMENT 'The date value representing regulatory filing date for this termination record.',
    `regulatory_filing_required_flag` BOOLEAN COMMENT 'Boolean indicator for the regulatory filing required condition or state.',
    `regulatory_notification_date` DATE COMMENT 'The date value representing regulatory notification date for this termination record.',
    `specialty_type` STRING COMMENT 'The category or classification type of the specialty.',
    `termination_status` STRING COMMENT 'The current status indicator for the termination within the workflow.',
    `termination_type` STRING COMMENT 'The category or classification type of the termination.',
    `transition_plan_required_flag` BOOLEAN COMMENT 'Boolean indicator for the transition plan required condition or state.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the termination in the network domain.',
    CONSTRAINT pk_termination PRIMARY KEY(`termination_id`)
) COMMENT 'Tracks provider network terminations including member impact and continuity of care.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` (
    `par_agreement_id` BIGINT COMMENT 'Unique identifier for the par agreement record within the par agreement entity.',
    `practice_location_id` BIGINT COMMENT 'Provider Id',
    `provider_network_id` BIGINT COMMENT 'Unique identifier for the provider network record within the par agreement entity.',
    `agreement_code` STRING COMMENT 'A standardized code representing the agreement classification.',
    `agreement_name` STRING COMMENT 'The descriptive name assigned to the agreement for identification purposes.',
    `agreement_status` STRING COMMENT 'The current status indicator for the agreement within the workflow.',
    `agreement_type` STRING COMMENT 'The category or classification type of the agreement.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Boolean indicator for the auto renewal condition or state.',
    `compliance_status_flag` BOOLEAN COMMENT 'Boolean indicator for the compliance status condition or state.',
    `contract_effective_date` DATE COMMENT 'The date value representing contract effective date for this par agreement record.',
    `contract_provider_contract_id` BIGINT COMMENT 'Unique identifier for the contract provider contract record within the par agreement entity.',
    `contract_termination_date` DATE COMMENT 'The date value representing contract termination date for this par agreement record.',
    `created_timestamp` TIMESTAMP COMMENT 'The created timestamp attribute capturing relevant data for the par agreement in the network domain.',
    `credentialing_required_flag` BOOLEAN COMMENT 'Boolean indicator for the credentialing required condition or state.',
    `directory_listing_required_flag` BOOLEAN COMMENT 'Boolean indicator for the directory listing required condition or state.',
    `effective_date` DATE COMMENT 'The date value representing effective date for this par agreement record.',
    `fee_schedule_reference` DECIMAL(18,2) COMMENT 'The fee schedule reference attribute capturing relevant data for the par agreement in the network domain.',
    `last_updated_by` STRING COMMENT 'The last updated by attribute capturing relevant data for the par agreement in the network domain.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The last updated timestamp attribute capturing relevant data for the par agreement in the network domain.',
    `lob_applicability` STRING COMMENT 'The lob applicability attribute capturing relevant data for the par agreement in the network domain.',
    `network_adequacy_contribution_flag` BOOLEAN COMMENT 'Boolean indicator for the network adequacy contribution condition or state.',
    `notes` STRING COMMENT 'The notes attribute capturing relevant data for the par agreement in the network domain.',
    `notice_period_days` STRING COMMENT 'The notice period days attribute capturing relevant data for the par agreement in the network domain.',
    `npi` STRING COMMENT 'The npi attribute capturing relevant data for the par agreement in the network domain.',
    `panel_size_limit` STRING COMMENT 'The panel size limit attribute capturing relevant data for the par agreement in the network domain.',
    `participation_type` STRING COMMENT 'The category or classification type of the participation.',
    `quality_reporting_required_flag` BOOLEAN COMMENT 'Boolean indicator for the quality reporting required condition or state.',
    `renewal_date` DATE COMMENT 'The date value representing renewal date for this par agreement record.',
    `service_area_code` STRING COMMENT 'A standardized code representing the service area classification.',
    `specialty_scope` STRING COMMENT 'The specialty scope attribute capturing relevant data for the par agreement in the network domain.',
    `termination_date` DATE COMMENT 'The date value representing termination date for this par agreement record.',
    `termination_reason` STRING COMMENT 'The termination reason attribute capturing relevant data for the par agreement in the network domain.',
    `tier_assignment` STRING COMMENT 'The tier assignment attribute capturing relevant data for the par agreement in the network domain.',
    `vbc_eligible_flag` BOOLEAN COMMENT 'Boolean indicator for the vbc eligible condition or state.',
    `vreq_validated` STRING COMMENT 'Marker indicating VREQ validation pass',
    `created_by` STRING COMMENT 'The created by attribute capturing relevant data for the par agreement in the network domain.',
    CONSTRAINT pk_par_agreement PRIMARY KEY(`par_agreement_id`)
) COMMENT 'Participation agreements between providers and the network defining terms of participation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ADD CONSTRAINT `fk_network_tier_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ADD CONSTRAINT `fk_network_network_provider_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`filing`(`filing_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ADD CONSTRAINT `fk_network_plan_association_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ADD CONSTRAINT `fk_network_network_service_area_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ADD CONSTRAINT `fk_network_network_service_area_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`filing`(`filing_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_adequacy_standard_id` FOREIGN KEY (`adequacy_standard_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`adequacy_standard`(`adequacy_standard_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ADD CONSTRAINT `fk_network_adequacy_assessment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_adequacy_assessment_id` FOREIGN KEY (`adequacy_assessment_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`adequacy_assessment`(`adequacy_assessment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_network_service_area_id` FOREIGN KEY (`network_service_area_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`network_service_area`(`network_service_area_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ADD CONSTRAINT `fk_network_adequacy_gap_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ADD CONSTRAINT `fk_network_provider_directory_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ADD CONSTRAINT `fk_network_network_directory_verification_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ADD CONSTRAINT `fk_network_vbc_arrangement_vbc_program_id` FOREIGN KEY (`vbc_program_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`vbc_program`(`vbc_program_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ADD CONSTRAINT `fk_network_aco_provider_vbc_arrangement_id` FOREIGN KEY (`vbc_arrangement_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`vbc_arrangement`(`vbc_arrangement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ADD CONSTRAINT `fk_network_exception_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ADD CONSTRAINT `fk_network_change_event_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ADD CONSTRAINT `fk_network_access_standard_superseded_by_standard_access_standard_id` FOREIGN KEY (`superseded_by_standard_access_standard_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`access_standard`(`access_standard_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ADD CONSTRAINT `fk_network_access_survey_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ADD CONSTRAINT `fk_network_filing_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ADD CONSTRAINT `fk_network_network_recruitment_adequacy_assessment_id` FOREIGN KEY (`adequacy_assessment_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`adequacy_assessment`(`adequacy_assessment_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ADD CONSTRAINT `fk_network_network_recruitment_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`filing`(`filing_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ADD CONSTRAINT `fk_network_network_recruitment_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ADD CONSTRAINT `fk_network_termination_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ADD CONSTRAINT `fk_network_par_agreement_provider_network_id` FOREIGN KEY (`provider_network_id`) REFERENCES `vibe_health_insurance_v1`.`network`.`provider_network`(`provider_network_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`network` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_health_insurance_v1`.`network` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('dbx_subdomain' = 'network_management');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` SET TAGS ('dbx_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Network Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `aco_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'ACO Participation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `cms_network_code` SET TAGS ('dbx_business_glossary_term' = 'CMS Network Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `facility_count` SET TAGS ('dbx_business_glossary_term' = 'Facility Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `geographic_footprint` SET TAGS ('dbx_business_glossary_term' = 'Geographic Footprint');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `last_adequacy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Adequacy Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `member_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `ncqa_accreditation_date` SET TAGS ('dbx_business_glossary_term' = 'NCQA Accreditation Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `ncqa_accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'NCQA Accreditation Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `ncqa_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'NCQA Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_adequacy_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_code` SET TAGS ('dbx_business_glossary_term' = 'Network Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_description` SET TAGS ('dbx_business_glossary_term' = 'Network Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_directory_url` SET TAGS ('dbx_business_glossary_term' = 'Network Directory URL');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('dbx_business_glossary_term' = 'Network Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_status` SET TAGS ('dbx_business_glossary_term' = 'Network Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `next_adequacy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Adequacy Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `out_of_network_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Network Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `pcp_count` SET TAGS ('dbx_business_glossary_term' = 'PCP Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `pcp_required_flag` SET TAGS ('dbx_business_glossary_term' = 'PCP Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `provider_count` SET TAGS ('dbx_business_glossary_term' = 'Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `service_area_type` SET TAGS ('dbx_business_glossary_term' = 'Service Area Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `specialist_count` SET TAGS ('dbx_business_glossary_term' = 'Specialist Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `star_rating` SET TAGS ('dbx_business_glossary_term' = 'Star Rating');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Tier Classification');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `vbc_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'VBC Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_network` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('dbx_subdomain' = 'network_management');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_code` SET TAGS ('dbx_business_glossary_term' = 'Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `coinsurance_differential_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Differential Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `copay_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Differential Amount');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `cost_share_differential_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Differential Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `deductible_applies_flag` SET TAGS ('dbx_business_glossary_term' = 'Deductible Applies Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `display_label` SET TAGS ('dbx_business_glossary_term' = 'Display Label');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `facility_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Facility Type Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `member_steerage_incentive_description` SET TAGS ('dbx_business_glossary_term' = 'Member Steerage Incentive Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_business_glossary_term' = 'Tier Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `network_adequacy_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Credit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `oop_max_applies_flag` SET TAGS ('dbx_business_glossary_term' = 'OOP Max Applies Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `quality_tier_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Tier Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `rank` SET TAGS ('dbx_business_glossary_term' = 'Tier Rank');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `sbc_disclosure_text` SET TAGS ('dbx_business_glossary_term' = 'SBC Disclosure Text');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `specialty_applicability` SET TAGS ('dbx_business_glossary_term' = 'Specialty Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `tier_type` SET TAGS ('dbx_business_glossary_term' = 'Tier Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`tier` ALTER COLUMN `vbc_arrangement_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'VBC Arrangement Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` SET TAGS ('dbx_subdomain' = 'network_management');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` SET TAGS ('dbx_fhir_resource' = 'PractitionerRole');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `network_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Network Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `delegated_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Delegated Entity ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Liaison Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `record_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `accessibility_ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'ADA Compliant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `aco_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'ACO Participant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `after_hours_availability_flag` SET TAGS ('dbx_business_glossary_term' = 'After Hours Availability Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `continuity_of_care_end_date` SET TAGS ('dbx_business_glossary_term' = 'Continuity of Care End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `credentialing_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `current_panel_size` SET TAGS ('dbx_business_glossary_term' = 'Current Panel Size');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `directory_last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Directory Last Verified Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `directory_listing_flag` SET TAGS ('dbx_business_glossary_term' = 'Directory Listing Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Service Area');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `in_network_flag` SET TAGS ('dbx_business_glossary_term' = 'In Network Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `language_services_available` SET TAGS ('dbx_business_glossary_term' = 'Language Services Available');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `network_adequacy_category` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Category');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `network_participation_type` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'NPI');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `panel_capacity` SET TAGS ('dbx_business_glossary_term' = 'Panel Capacity');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `panel_status` SET TAGS ('dbx_business_glossary_term' = 'Panel Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `pcp_flag` SET TAGS ('dbx_business_glossary_term' = 'PCP Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `quality_tier_designation` SET TAGS ('dbx_business_glossary_term' = 'Quality Tier Designation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `recredentialing_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recredentialing Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `risk_sharing_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Sharing Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `specialist_flag` SET TAGS ('dbx_business_glossary_term' = 'Specialist Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `telehealth_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `termination_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Termination Initiated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `tier_assignment` SET TAGS ('dbx_business_glossary_term' = 'Tier Assignment');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `vbc_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'VBC Participant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_provider` ALTER COLUMN `weekend_availability_flag` SET TAGS ('dbx_business_glossary_term' = 'Weekend Availability Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('dbx_subdomain' = 'network_management');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `plan_association_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Association ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Network Service Area ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Plan CMS Filing ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `aco_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'ACO Participation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `adequacy_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Certification Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `adequacy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_code` SET TAGS ('dbx_business_glossary_term' = 'Association Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_name` SET TAGS ('dbx_business_glossary_term' = 'Association Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `association_type` SET TAGS ('dbx_business_glossary_term' = 'Association Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `auto_assignment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Assignment Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `directory_publication_flag` SET TAGS ('dbx_business_glossary_term' = 'Directory Publication Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `member_count` SET TAGS ('dbx_business_glossary_term' = 'Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `out_of_network_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Network Coverage Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `pcp_selection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'PCP Selection Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `plan_association_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Association Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `provider_count` SET TAGS ('dbx_business_glossary_term' = 'Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `referral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Referral Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `star_rating_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Star Rating Impact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `vbc_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'VBC Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`plan_association` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('dbx_subdomain' = 'network_management');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` SET TAGS ('dbx_fhir_resource' = 'Location');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Network Service Area ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `cms_service_area_code` SET TAGS ('dbx_business_glossary_term' = 'CMS Service Area Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `commercial_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Approved Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `county_fips_code` SET TAGS ('dbx_business_glossary_term' = 'County FIPS Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `county_name` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `county_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `geographic_boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `medicaid_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Approved Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `medicare_advantage_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicare Advantage Approved Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `member_residency_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Member Residency Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `msa_code` SET TAGS ('dbx_business_glossary_term' = 'MSA Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `msa_name` SET TAGS ('dbx_business_glossary_term' = 'MSA Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `msa_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `network_adequacy_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `network_adequacy_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `network_adequacy_status` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `network_service_area_status` SET TAGS ('dbx_business_glossary_term' = 'Network Service Area Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `out_of_area_coverage_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Out of Area Coverage Allowed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `population_count` SET TAGS ('dbx_business_glossary_term' = 'Population Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `qhp_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'QHP Approved Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `service_area_code` SET TAGS ('dbx_business_glossary_term' = 'Service Area Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `service_area_name` SET TAGS ('dbx_business_glossary_term' = 'Service Area Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `service_area_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `service_area_type` SET TAGS ('dbx_business_glossary_term' = 'Service Area Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `state_code` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `urban_rural_designation` SET TAGS ('dbx_business_glossary_term' = 'Urban Rural Designation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Zip Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_service_area` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('dbx_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `adequacy_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Standard ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `adequacy_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Standard Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `after_hours_availability_required` SET TAGS ('dbx_business_glossary_term' = 'After Hours Availability Required');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `after_hours_definition` SET TAGS ('dbx_business_glossary_term' = 'After Hours Definition');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `appointment_type` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `compliance_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reporting Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `exception_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exception Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `geographic_classification` SET TAGS ('dbx_business_glossary_term' = 'Geographic Classification');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `maximum_distance_miles` SET TAGS ('dbx_business_glossary_term' = 'Maximum Distance Miles');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `maximum_travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Travel Time Minutes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `maximum_wait_time_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Wait Time Days');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Measurement Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `minimum_provider_count` SET TAGS ('dbx_business_glossary_term' = 'Minimum Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `provider_to_member_ratio` SET TAGS ('dbx_business_glossary_term' = 'Provider to Member Ratio');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `regulatory_source` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Source');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `service_area_type` SET TAGS ('dbx_business_glossary_term' = 'Service Area Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `specialty_category` SET TAGS ('dbx_business_glossary_term' = 'Specialty Category');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_category` SET TAGS ('dbx_business_glossary_term' = 'Standard Category');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_name` SET TAGS ('dbx_business_glossary_term' = 'Standard Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `standard_version` SET TAGS ('dbx_business_glossary_term' = 'Standard Version');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `telehealth_equivalency_allowed` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Equivalency Allowed');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `telehealth_percentage_cap` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Percentage Cap');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_standard` ALTER COLUMN `threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Threshold Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('dbx_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `adequacy_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Assessment ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `adequacy_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Standard ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Network Service Area ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `pool_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Pool ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `appointment_type_requested` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Requested');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `assessor_organization` SET TAGS ('dbx_business_glossary_term' = 'Assessor Organization');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `compliance_outcome` SET TAGS ('dbx_business_glossary_term' = 'Compliance Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `contract_provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `gap_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Gap Identified Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `gap_severity` SET TAGS ('dbx_business_glossary_term' = 'Gap Severity');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `member_to_provider_ratio` SET TAGS ('dbx_business_glossary_term' = 'Member to Provider Ratio');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `provider_count_available` SET TAGS ('dbx_business_glossary_term' = 'Provider Count Available');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `provider_count_required` SET TAGS ('dbx_business_glossary_term' = 'Provider Count Required');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `regulatory_submission_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action Taken');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `specialty_type` SET TAGS ('dbx_business_glossary_term' = 'Specialty Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `telehealth_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Offered Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `time_distance_compliance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Time Distance Compliance Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `time_distance_standard_miles` SET TAGS ('dbx_business_glossary_term' = 'Time Distance Standard Miles');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `time_distance_standard_minutes` SET TAGS ('dbx_business_glossary_term' = 'Time Distance Standard Minutes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `wait_time_days_routine` SET TAGS ('dbx_business_glossary_term' = 'Wait Time Days Routine');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_assessment` ALTER COLUMN `wait_time_days_urgent` SET TAGS ('dbx_business_glossary_term' = 'Wait Time Days Urgent');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` SET TAGS ('dbx_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `adequacy_gap_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Gap ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `adequacy_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Assessment ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Network Service Area ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `affected_member_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `available_provider_count` SET TAGS ('dbx_business_glossary_term' = 'Available Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `contract_provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract ID');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `exception_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `exception_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `exception_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Granted Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `exception_justification` SET TAGS ('dbx_business_glossary_term' = 'Exception Justification');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `exception_request_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Request Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `exception_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Requested Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `gap_magnitude` SET TAGS ('dbx_business_glossary_term' = 'Gap Magnitude');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `gap_number` SET TAGS ('dbx_business_glossary_term' = 'Gap Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `gap_severity` SET TAGS ('dbx_business_glossary_term' = 'Gap Severity');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `gap_status` SET TAGS ('dbx_business_glossary_term' = 'Gap Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `gap_type` SET TAGS ('dbx_business_glossary_term' = 'Gap Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `geographic_area_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `geographic_area_name` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `geographic_area_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `geographic_area_type` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `remediation_owner` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `required_provider_count` SET TAGS ('dbx_business_glossary_term' = 'Required Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `specialty_name` SET TAGS ('dbx_business_glossary_term' = 'Specialty Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `specialty_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `standard_threshold` SET TAGS ('dbx_business_glossary_term' = 'Standard Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `standard_type` SET TAGS ('dbx_business_glossary_term' = 'Standard Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`adequacy_gap` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('dbx_subdomain' = 'directory_verification');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` SET TAGS ('dbx_fhir_resource' = 'PractitionerRole');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `provider_directory_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Directory Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Maintaining Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `accessibility_features` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Features');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Ada Compliant Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `board_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Board Certification Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `city` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `city` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `directory_publication_channel` SET TAGS ('dbx_business_glossary_term' = 'Directory Publication Channel');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `directory_status` SET TAGS ('dbx_business_glossary_term' = 'Directory Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fax_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `gender` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `hospital_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Hospital Affiliation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_verification_outcome` SET TAGS ('dbx_business_glossary_term' = 'Last Verification Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `next_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'Npi');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `practice_location_name` SET TAGS ('dbx_business_glossary_term' = 'Practice Location Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `practice_location_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `specialty_primary` SET TAGS ('dbx_business_glossary_term' = 'Specialty Primary');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `specialty_secondary` SET TAGS ('dbx_business_glossary_term' = 'Specialty Secondary');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `state` SET TAGS ('dbx_pii_type' = 'address');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `telehealth_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `verified_fields` SET TAGS ('dbx_business_glossary_term' = 'Verified Fields');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `verifying_agent` SET TAGS ('dbx_business_glossary_term' = 'Verifying Agent');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Url');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Zip Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`provider_directory` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` SET TAGS ('dbx_subdomain' = 'directory_verification');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `network_directory_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Network Directory Verification Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Verification Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `accepting_new_patients_status` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `accepting_new_patients_verified` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Verified');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `accuracy_score` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `address_verified` SET TAGS ('dbx_business_glossary_term' = 'Address Verified');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `address_verified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `address_verified` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `change_summary` SET TAGS ('dbx_business_glossary_term' = 'Change Summary');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `changes_identified` SET TAGS ('dbx_business_glossary_term' = 'Changes Identified');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `cms_reportable` SET TAGS ('dbx_business_glossary_term' = 'Cms Reportable');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `compliance_quarter` SET TAGS ('dbx_business_glossary_term' = 'Compliance Quarter');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Year');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `contact_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Contact Attempt Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `directory_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Directory Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `directory_updated` SET TAGS ('dbx_business_glossary_term' = 'Directory Updated');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `first_contact_attempt_date` SET TAGS ('dbx_business_glossary_term' = 'First Contact Attempt Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `last_contact_attempt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Attempt Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `next_verification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Verification Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `npi_verified` SET TAGS ('dbx_business_glossary_term' = 'Npi Verified');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `npi_verified` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `phone_verified` SET TAGS ('dbx_business_glossary_term' = 'Phone Verified');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `phone_verified` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `phone_verified` SET TAGS ('dbx_pii_type' = 'phone');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `prior_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `provider_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Provider Response Time Hours');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `specialty_verified` SET TAGS ('dbx_business_glossary_term' = 'Specialty Verified');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Verification Agent Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_agent_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_channel` SET TAGS ('dbx_business_glossary_term' = 'Verification Channel');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_language` SET TAGS ('dbx_business_glossary_term' = 'Verification Language');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_source_document` SET TAGS ('dbx_business_glossary_term' = 'Verification Source Document');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_system` SET TAGS ('dbx_business_glossary_term' = 'Verification System');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `verified_fields` SET TAGS ('dbx_business_glossary_term' = 'Verified Fields');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_directory_verification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` SET TAGS ('dbx_subdomain' = 'value_based');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `vbc_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Arrangement Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `vbc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Program Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `attributed_member_count` SET TAGS ('dbx_business_glossary_term' = 'Attributed Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `attribution_methodology` SET TAGS ('dbx_business_glossary_term' = 'Attribution Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `benchmark_amount` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Amount');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `benchmark_methodology` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `care_coordination_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Care Coordination Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `cms_aco_code` SET TAGS ('dbx_business_glossary_term' = 'Cms Aco Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `cms_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cms Reporting Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `data_sharing_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `health_it_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Health It Certification Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `health_it_certification_required_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `health_it_certification_required_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `minimum_loss_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Loss Rate');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `minimum_savings_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Savings Rate');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `participating_aco_name` SET TAGS ('dbx_business_glossary_term' = 'Participating Aco Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `participating_aco_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `participating_provider_count` SET TAGS ('dbx_business_glossary_term' = 'Participating Provider Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `participating_tin` SET TAGS ('dbx_business_glossary_term' = 'Participating Tin');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `participating_tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `participating_tin` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `participating_tin` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `performance_guarantee_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee Amount');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `performance_year` SET TAGS ('dbx_business_glossary_term' = 'Performance Year');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `primary_care_physician_count` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Physician Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `quality_measure_set` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Set');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `quality_performance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Quality Performance Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `record_type` SET TAGS ('dbx_business_glossary_term' = 'Record Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `risk_model` SET TAGS ('dbx_business_glossary_term' = 'Risk Model');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `service_area_description` SET TAGS ('dbx_business_glossary_term' = 'Service Area Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `shared_loss_rate` SET TAGS ('dbx_business_glossary_term' = 'Shared Loss Rate');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `shared_savings_rate` SET TAGS ('dbx_business_glossary_term' = 'Shared Savings Rate');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `specialist_physician_count` SET TAGS ('dbx_business_glossary_term' = 'Specialist Physician Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `sponsoring_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Entity Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `sponsoring_entity_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `stop_loss_limit` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Limit');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_arrangement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` SET TAGS ('dbx_subdomain' = 'value_based');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `aco_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Aco Provider Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `vbc_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Arrangement Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `attributed_member_count` SET TAGS ('dbx_business_glossary_term' = 'Attributed Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `attribution_methodology` SET TAGS ('dbx_business_glossary_term' = 'Attribution Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `care_coordination_tier` SET TAGS ('dbx_business_glossary_term' = 'Care Coordination Tier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `cost_efficiency_score` SET TAGS ('dbx_business_glossary_term' = 'Cost Efficiency Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `ehr_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Ehr Integration Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `last_credentialing_date` SET TAGS ('dbx_business_glossary_term' = 'Last Credentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `next_credentialing_date` SET TAGS ('dbx_business_glossary_term' = 'Next Credentialing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `panel_size_limit` SET TAGS ('dbx_business_glossary_term' = 'Panel Size Limit');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `participation_role` SET TAGS ('dbx_business_glossary_term' = 'Participation Role');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `participation_type` SET TAGS ('dbx_business_glossary_term' = 'Participation Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `performance_year` SET TAGS ('dbx_business_glossary_term' = 'Performance Year');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `primary_care_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Care Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Provider Npi');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_tin` SET TAGS ('dbx_business_glossary_term' = 'Provider Tin');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_tin` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `provider_tin` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `quality_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Reporting Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `risk_sharing_percentage` SET TAGS ('dbx_business_glossary_term' = 'Risk Sharing Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `shared_savings_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Shared Savings Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `vbc_track` SET TAGS ('dbx_business_glossary_term' = 'Vbc Track');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`aco_provider` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` SET TAGS ('dbx_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `exception_id` SET TAGS ('dbx_business_glossary_term' = 'Exception Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Cms Plan Benefit Package Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `affected_member_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Member Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `alternative_access_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Alternative Access Arrangement');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `approved_terms` SET TAGS ('dbx_business_glossary_term' = 'Approved Terms');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `cms_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Cms Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `contract_provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `denial_date` SET TAGS ('dbx_business_glossary_term' = 'Denial Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `geographic_description` SET TAGS ('dbx_business_glossary_term' = 'Geographic Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Lob');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `member_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `member_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `provider_recruitment_effort` SET TAGS ('dbx_business_glossary_term' = 'Provider Recruitment Effort');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `service_area_code` SET TAGS ('dbx_business_glossary_term' = 'Service Area Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `specialty_name` SET TAGS ('dbx_business_glossary_term' = 'Specialty Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `specialty_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `time_distance_standard_waived` SET TAGS ('dbx_business_glossary_term' = 'Time Distance Standard Waived');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`exception` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` SET TAGS ('dbx_subdomain' = 'network_management');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_event_id` SET TAGS ('dbx_business_glossary_term' = 'Change Event Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `aco_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Aco Participation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Change Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Change Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Change Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_request_date` SET TAGS ('dbx_business_glossary_term' = 'Change Request Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `continuity_of_care_end_date` SET TAGS ('dbx_business_glossary_term' = 'Continuity Of Care End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `contract_provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `lob_applicability` SET TAGS ('dbx_business_glossary_term' = 'Lob Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `member_impact_count` SET TAGS ('dbx_business_glossary_term' = 'Member Impact Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `member_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `member_notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Sent Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `member_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `member_transition_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Member Transition Plan Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `network_adequacy_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Impact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `new_panel_status` SET TAGS ('dbx_business_glossary_term' = 'New Panel Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `new_tier_code` SET TAGS ('dbx_business_glossary_term' = 'New Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `prior_panel_status` SET TAGS ('dbx_business_glossary_term' = 'Prior Panel Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `prior_tier_code` SET TAGS ('dbx_business_glossary_term' = 'Prior Tier Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `provider_directory_update_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory Update Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Provider Npi');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `provider_npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `regulatory_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `service_area_code` SET TAGS ('dbx_business_glossary_term' = 'Service Area Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `specialty_type` SET TAGS ('dbx_business_glossary_term' = 'Specialty Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `termination_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `termination_type` SET TAGS ('dbx_business_glossary_term' = 'Termination Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `transition_plan_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Transition Plan Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `vbc_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Vbc Arrangement Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`change_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` SET TAGS ('dbx_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `access_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Access Standard Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `superseded_by_standard_access_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Standard Access Standard Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `access_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Access Standard Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `after_hours_availability_required_flag` SET TAGS ('dbx_business_glossary_term' = 'After Hours Availability Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `appointment_type_scope` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Scope');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `compliance_measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Compliance Measurement Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `exception_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exception Criteria');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `line_of_business_applicability` SET TAGS ('dbx_business_glossary_term' = 'Line Of Business Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `maximum_wait_time_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Wait Time Days');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `maximum_wait_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Maximum Wait Time Hours');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `member_age_group` SET TAGS ('dbx_business_glossary_term' = 'Member Age Group');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `member_age_group` SET TAGS ('dbx_pii_type' = 'demographic');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `network_adequacy_credit_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Credit Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `penalty_for_noncompliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty For Noncompliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `regulatory_source` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Source');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `specialty_category` SET TAGS ('dbx_business_glossary_term' = 'Specialty Category');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `standard_name` SET TAGS ('dbx_business_glossary_term' = 'Standard Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `standard_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `standard_type` SET TAGS ('dbx_business_glossary_term' = 'Standard Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `telehealth_equivalency_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Equivalency Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_standard` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` SET TAGS ('dbx_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `access_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Access Survey Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `access_standard_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Access Standard Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `access_standard_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Access Standard Threshold Days');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `accessibility_accommodation_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodation Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `accessibility_accommodation_requested_flag` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodation Requested Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `after_hours_access_available_flag` SET TAGS ('dbx_business_glossary_term' = 'After Hours Access Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `appointment_offered_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Offered Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `appointment_reason` SET TAGS ('dbx_business_glossary_term' = 'Appointment Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `appointment_scheduled_flag` SET TAGS ('dbx_business_glossary_term' = 'Appointment Scheduled Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `appointment_type_requested` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Requested');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `cahps_survey_supplementation_flag` SET TAGS ('dbx_business_glossary_term' = 'Cahps Survey Supplementation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `call_attempts` SET TAGS ('dbx_business_glossary_term' = 'Call Attempts');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `call_outcome` SET TAGS ('dbx_business_glossary_term' = 'Call Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `cms_star_rating_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Cms Star Rating Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `compliance_outcome` SET TAGS ('dbx_business_glossary_term' = 'Compliance Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `hedis_measure_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Hedis Measure Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `language_requested` SET TAGS ('dbx_business_glossary_term' = 'Language Requested');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `language_services_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Language Services Available Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `network_adequacy_filing_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Filing Applicable Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `non_compliance_reason` SET TAGS ('dbx_business_glossary_term' = 'Non Compliance Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'Npi');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Specialty Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `specialty_name` SET TAGS ('dbx_business_glossary_term' = 'Specialty Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `specialty_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `survey_cycle` SET TAGS ('dbx_business_glossary_term' = 'Survey Cycle');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `survey_notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `telehealth_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Offered Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `wait_time_offered_days` SET TAGS ('dbx_business_glossary_term' = 'Wait Time Offered Days');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`access_survey` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` SET TAGS ('dbx_subdomain' = 'adequacy_compliance');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `benefit_package_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Benefit Package Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `adequacy_standard_met_flag` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Standard Met Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Attestation Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'Attestation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `deficiency_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Issued Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `deficiency_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Issued Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `exception_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `exception_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Approved Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `exception_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `exception_geography` SET TAGS ('dbx_business_glossary_term' = 'Exception Geography');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `exception_justification` SET TAGS ('dbx_business_glossary_term' = 'Exception Justification');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `exception_specialty` SET TAGS ('dbx_business_glossary_term' = 'Exception Specialty');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line Of Business');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `submitted_by` SET TAGS ('dbx_business_glossary_term' = 'Submitted By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`filing` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` SET TAGS ('dbx_subdomain' = 'value_based');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `vbc_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vbc Program Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Health Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `attribution_methodology` SET TAGS ('dbx_business_glossary_term' = 'Attribution Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `benchmark_methodology` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Methodology');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `benchmark_year` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Year');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `care_coordination_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Care Coordination Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `cms_program_identifier` SET TAGS ('dbx_business_glossary_term' = 'Cms Program Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_type' = 'email');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `eligible_provider_types` SET TAGS ('dbx_business_glossary_term' = 'Eligible Provider Types');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `health_it_requirement` SET TAGS ('dbx_business_glossary_term' = 'Health It Requirement');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `health_it_requirement` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `health_it_requirement` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line Of Business');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `minimum_loss_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Loss Rate');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `minimum_member_threshold` SET TAGS ('dbx_business_glossary_term' = 'Minimum Member Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `minimum_savings_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Savings Rate');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `performance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `performance_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_owner` SET TAGS ('dbx_business_glossary_term' = 'Program Owner');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_url` SET TAGS ('dbx_business_glossary_term' = 'Program Url');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `program_year` SET TAGS ('dbx_business_glossary_term' = 'Program Year');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `quality_measure_set` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Set');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `quality_performance_threshold` SET TAGS ('dbx_business_glossary_term' = 'Quality Performance Threshold');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `risk_model` SET TAGS ('dbx_business_glossary_term' = 'Risk Model');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `shared_loss_rate` SET TAGS ('dbx_business_glossary_term' = 'Shared Loss Rate');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `shared_savings_rate` SET TAGS ('dbx_business_glossary_term' = 'Shared Savings Rate');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `sponsoring_entity` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Entity');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`vbc_program` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` SET TAGS ('dbx_subdomain' = 'network_management');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `network_recruitment_id` SET TAGS ('dbx_business_glossary_term' = 'Network Recruitment Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `adequacy_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Assessment Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Network Cms Filing Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `adequacy_gap_type` SET TAGS ('dbx_business_glossary_term' = 'Adequacy Gap Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `contract_provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `contracting_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Contracting Referral Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Disposition');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `estimated_annual_claims_volume` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Claims Volume');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `estimated_member_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Member Impact');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Lob');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `outreach_date` SET TAGS ('dbx_business_glossary_term' = 'Outreach Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `outreach_method` SET TAGS ('dbx_business_glossary_term' = 'Outreach Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `provider_response` SET TAGS ('dbx_business_glossary_term' = 'Provider Response');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `recruiter_assigned` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Assigned');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `recruitment_code` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `recruitment_status` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `target_county_fips` SET TAGS ('dbx_business_glossary_term' = 'Target County Fips');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `target_geographic_area` SET TAGS ('dbx_business_glossary_term' = 'Target Geographic Area');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `target_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Target Provider Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `target_provider_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `target_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Target Provider Npi');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `target_provider_npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `target_provider_tin` SET TAGS ('dbx_business_glossary_term' = 'Target Provider Tin');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `target_provider_tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `target_provider_tin` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `target_provider_tin` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `target_specialty` SET TAGS ('dbx_business_glossary_term' = 'Target Specialty');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `target_zip_code` SET TAGS ('dbx_business_glossary_term' = 'Target Zip Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `target_zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `target_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`network_recruitment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` SET TAGS ('dbx_subdomain' = 'network_management');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `termination_id` SET TAGS ('dbx_business_glossary_term' = 'Termination Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `active_treatment_count` SET TAGS ('dbx_business_glossary_term' = 'Active Treatment Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `active_treatment_count` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `active_treatment_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `appeals_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeals Filed Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `claims_runout_end_date` SET TAGS ('dbx_business_glossary_term' = 'Claims Runout End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `claims_runout_period_days` SET TAGS ('dbx_business_glossary_term' = 'Claims Runout Period Days');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `continuity_of_care_end_date` SET TAGS ('dbx_business_glossary_term' = 'Continuity Of Care End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `contract_provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `credentialing_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Related Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `financial_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Settlement Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `financial_settlement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Settlement Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `for_cause_flag` SET TAGS ('dbx_business_glossary_term' = 'For Cause Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Termination Initiated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `member_impact_count` SET TAGS ('dbx_business_glossary_term' = 'Member Impact Count');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `member_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `member_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Method');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `member_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Member Notification Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `network_adequacy_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Impact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'Npi');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `provider_directory_removal_date` SET TAGS ('dbx_business_glossary_term' = 'Provider Directory Removal Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `regulatory_filing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `specialty_type` SET TAGS ('dbx_business_glossary_term' = 'Specialty Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `termination_status` SET TAGS ('dbx_business_glossary_term' = 'Termination Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `termination_type` SET TAGS ('dbx_business_glossary_term' = 'Termination Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `transition_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Transition Plan Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`termination` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('dbx_subdomain' = 'network_management');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('dbx_domain' = 'network');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` SET TAGS ('dbx_mvm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `par_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Par Agreement Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `practice_location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Agreement Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_pii_type' = 'name');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `compliance_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `contract_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `contract_provider_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Provider Contract Id');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `contract_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `credentialing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `directory_listing_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Directory Listing Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `fee_schedule_reference` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Reference');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `lob_applicability` SET TAGS ('dbx_business_glossary_term' = 'Lob Applicability');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `network_adequacy_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Network Adequacy Contribution Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'Npi');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `npi` SET TAGS ('dbx_pii_type' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `panel_size_limit` SET TAGS ('dbx_business_glossary_term' = 'Panel Size Limit');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `participation_type` SET TAGS ('dbx_business_glossary_term' = 'Participation Type');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `quality_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Reporting Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `service_area_code` SET TAGS ('dbx_business_glossary_term' = 'Service Area Code');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `specialty_scope` SET TAGS ('dbx_business_glossary_term' = 'Specialty Scope');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `tier_assignment` SET TAGS ('dbx_business_glossary_term' = 'Tier Assignment');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `vbc_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Vbc Eligible Flag');
ALTER TABLE `vibe_health_insurance_v1`.`network`.`par_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
