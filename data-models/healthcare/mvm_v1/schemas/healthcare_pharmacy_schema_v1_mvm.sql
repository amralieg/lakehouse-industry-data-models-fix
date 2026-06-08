-- Schema for Domain: pharmacy | Business: Healthcare | Version: v1_mvm
-- Generated on: 2026-05-04 19:04:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `healthcare_ecm`.`pharmacy` COMMENT 'Owns the medication lifecycle from prescribing through dispensing and administration. Manages formulary, NDC (National Drug Code) drug master, MAR (Medication Administration Record), medication reconciliation, controlled substance tracking (DEA Schedule), adverse drug event monitoring, pharmacy inventory, and prescription fulfillment. Sourced from Epic Willow and Cerner PharmNet.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `healthcare_ecm`.`pharmacy`.`drug_master` (
    `drug_master_id` BIGINT COMMENT 'Unique identifier for the drug master record. Primary key for the drug master product.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Injectable and infusion drugs in the drug master require HCPCS J-code assignment for Medicare Part B billing, outpatient drug reimbursement, and CMS cost reporting. Pharmacy billing specialists expect',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Drug master (clinical/regulatory catalog) and material master (supply catalog) represent the same medication item in different systems. Direct cross-reference enables procurement-to-formulary alignmen',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Drug master maintenance requires validation against the FDA NDC reference registry for regulatory compliance, drug recall management, and formulary accuracy. Pharmacy directors expect internal drug re',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: REMS programs, DEA controlled substance schedules, and FDA risk management programs are compliance programs that govern specific drugs. Real process: REMS enrollment verification requires linking drug',
    `training_id` BIGINT COMMENT 'Foreign key linking to compliance.training. Business justification: REMS programs, high-alert medications (ISMP), and controlled substances mandate specific staff training per drug. Pharmacy directors must know which training program is required before staff can handl',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Drug master records require SNOMED CT mapping for HL7 FHIR interoperability, clinical decision support, and EHR integration. Healthcare informaticists expect drug_master to reference canonical SNOMED ',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Drug master records carry specialty-restricted prescribing rules (e.g., oncology-only biologics, psychiatry-only controlled substances, REMS programs). Specialty pharmacy programs and CMS enrollment s',
    `active_status` STRING COMMENT 'The current lifecycle status of the drug in the organizations drug master, indicating whether it is available for prescribing, dispensing, and administration.. Valid values are `Active|Inactive|Discontinued|Recalled`',
    `atc_code` STRING COMMENT 'The World Health Organizations ATC classification code that categorizes drugs according to the organ or system on which they act and their therapeutic, pharmacological, and chemical properties.',
    `beyond_use_date_hours` STRING COMMENT 'The number of hours after opening or preparation that the drug remains safe and effective for use, particularly relevant for compounded or multi-dose preparations.',
    `black_box_warning_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the FDA has issued a black box warning (boxed warning) for this drug, signaling serious or life-threatening risks that require prominent disclosure.',
    `brand_name` STRING COMMENT 'The proprietary, trademarked name assigned by the pharmaceutical manufacturer for marketing and commercial distribution.',
    `controlled_substance_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the drug is classified as a controlled substance under DEA regulations, requiring special handling, documentation, and security measures.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this drug master record was first created in the system.',
    `dea_schedule` STRING COMMENT 'The DEA controlled substance schedule classification indicating the drugs potential for abuse and accepted medical use. Schedule I has highest abuse potential with no accepted medical use; Schedule V has lowest abuse potential.. Valid values are `Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Non-Controlled`',
    `discontinuation_date` DATE COMMENT 'The date on which the drug was discontinued from the formulary or removed from active use in the organization.',
    `discontinuation_reason` STRING COMMENT 'The business or clinical rationale for discontinuing the drug from the formulary (e.g., Manufacturer Discontinuation, Safety Concern, Cost, Therapeutic Alternative Available).',
    `dosage_form` STRING COMMENT 'The physical form in which the drug is manufactured and dispensed (e.g., Tablet, Capsule, Injection, Solution, Cream, Patch, Inhaler).',
    `drug_class` STRING COMMENT 'The pharmacological or therapeutic classification of the drug based on mechanism of action, chemical structure, or therapeutic use (e.g., Beta-Blocker, ACE Inhibitor, NSAID).',
    `fda_application_number` STRING COMMENT 'The FDA-assigned New Drug Application (NDA) or Abbreviated New Drug Application (ANDA) number that uniquely identifies the regulatory submission and approval.',
    `fda_approval_date` DATE COMMENT 'The date on which the FDA granted marketing approval for this drug product, establishing its legal authorization for commercial distribution in the United States.',
    `formulary_status` STRING COMMENT 'The drugs inclusion status in the organizations formulary, indicating whether it is approved for routine use, requires special authorization, or is preferred based on clinical and cost-effectiveness criteria. [ENUM-REF-CANDIDATE: Formulary|Non-Formulary|Restricted|Preferred|Tier 1|Tier 2|Tier 3 — 7 candidates stripped; promote to reference product]',
    `generic_name` STRING COMMENT 'The non-proprietary, scientific name of the active pharmaceutical ingredient as established by the United States Adopted Names (USAN) Council or international nomenclature standards.',
    `geriatric_dosing_adjustment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug requires dosing adjustments or special considerations for geriatric patients due to altered pharmacokinetics or increased sensitivity.',
    `hazardous_drug_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug is classified as hazardous per NIOSH criteria, requiring special handling, personal protective equipment, and disposal procedures to protect healthcare workers.',
    `hepatic_dosing_adjustment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug requires dosing adjustments for patients with hepatic impairment or liver disease.',
    `ismp_high_alert_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug is classified as high-alert by ISMP, meaning it carries heightened risk of causing significant patient harm when used in error.',
    `lactation_risk_category` STRING COMMENT 'The classification indicating the drugs safety profile for use during breastfeeding and potential risks to nursing infants.',
    `lasa_drug_pairs` STRING COMMENT 'Comma-separated list of drug names that are commonly confused with this drug due to similar appearance or pronunciation, used for clinical decision support and error prevention.',
    `lasa_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the drug has been identified as having look-alike or sound-alike characteristics with other medications, requiring additional safety measures to prevent confusion.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this drug master record was most recently modified or updated.',
    `light_sensitive_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug is photosensitive and requires protection from light exposure during storage and handling.',
    `manufacturer_labeler_code` STRING COMMENT 'The first segment of the NDC identifying the labeler or manufacturer, assigned by the FDA.',
    `manufacturer_name` STRING COMMENT 'The name of the pharmaceutical company or labeler responsible for manufacturing and distributing the drug product.',
    `multi_dose_vial_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug is packaged as a multi-dose vial that can be used for multiple patient administrations, requiring special dating and handling protocols.',
    `package_size` STRING COMMENT 'The quantity of drug units contained in the standard package or container (e.g., 100 tablets, 10 mL vial, 30-day supply).',
    `package_type` STRING COMMENT 'The type of container or packaging in which the drug is supplied (e.g., Bottle, Blister Pack, Vial, Ampule, Syringe, Box).',
    `pediatric_approved_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug has FDA approval for use in pediatric populations with established dosing and safety data.',
    `pregnancy_category` STRING COMMENT 'The FDA pregnancy category or Pregnancy and Lactation Labeling Rule (PLLR) classification indicating the drugs safety profile for use during pregnancy.',
    `refrigeration_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug requires refrigerated storage conditions to maintain stability and efficacy.',
    `rems_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the FDA requires a Risk Evaluation and Mitigation Strategy program for this drug to ensure that benefits outweigh risks.',
    `renal_dosing_adjustment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the drug requires dosing adjustments for patients with renal impairment based on creatinine clearance or glomerular filtration rate.',
    `route_of_administration` STRING COMMENT 'The path by which the drug is administered into the body (e.g., Oral, Intravenous, Intramuscular, Subcutaneous, Topical, Inhalation, Ophthalmic).',
    `rxnorm_code` STRING COMMENT 'The standardized nomenclature code from the National Library of Medicines RxNorm system, used for semantic interoperability and clinical decision support across health IT systems.',
    `storage_temperature_range` STRING COMMENT 'The recommended temperature range for proper storage of the drug to maintain potency and safety (e.g., 2-8°C, 15-30°C, Room Temperature).',
    `strength` STRING COMMENT 'The amount of active pharmaceutical ingredient per dosage unit, expressed with numeric value and unit of measure (e.g., 500 mg, 10 mg/mL, 0.5%).',
    `tall_man_lettering` STRING COMMENT 'The drug name displayed with mixed-case capitalization to emphasize differences between look-alike drug names and reduce medication errors (e.g., hydrOXYzine vs hydrALAzine).',
    `therapeutic_category` STRING COMMENT 'The clinical therapeutic category indicating the primary disease state or condition the drug is used to treat (e.g., Cardiovascular, Antibiotic, Analgesic, Antidiabetic).',
    `unit_of_measure` STRING COMMENT 'The standard unit used to quantify the drug for inventory, dispensing, and administration purposes (e.g., Each, Milliliter, Gram, Vial, Patch).',
    CONSTRAINT pk_drug_master PRIMARY KEY(`drug_master_id`)
) COMMENT 'Authoritative pharmacy drug master for every medication managed within the organization. Captures NDC (National Drug Code), drug name (generic and brand), drug class, DEA schedule, dosage form, strength, route of administration, unit of measure, therapeutic category, formulary status, controlled substance indicator, hazardous drug flag, tall-man lettering, ISMP high-alert flag, look-alike/sound-alike (LASA) indicators, and regulatory approval metadata. Serves as the pharmacy-owned SSOT for drug attributes consumed by prescribing, dispensing, administration, and inventory workflows. Distinct from reference domain NDC code sets — this product adds pharmacy-operational attributes (formulary status, ISMP flags, hazardous drug classification). Sourced from Epic Willow and Cerner PharmNet drug dictionaries.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`pharmacy`.`formulary` (
    `formulary_id` BIGINT COMMENT 'Unique identifier for the formulary entry. Primary key for the formulary product.',
    `benefit_id` BIGINT COMMENT 'Foreign key linking to insurance.benefit. Business justification: A formulary entry is directly governed by the health plan benefit definition that specifies formulary_tier, days_supply_limit, prior_authorization_required_flag, and step_therapy_required_flag for pha',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or hospital system for which this formulary is defined. Supports facility-specific formulary management.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Formulary coverage restrictions are tied to specific ICD diagnoses for prior authorization, step therapy, and medical necessity determination. Pharmacy benefit managers expect formulary entries to ref',
    `drug_master_id` BIGINT COMMENT 'Reference to the drug master record containing NDC (National Drug Code), drug name, strength, dosage form, and therapeutic class.',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Medicare Part B drug formularies reference HCPCS codes for coverage determination, benefit design, and CMS compliance reporting. Managed care pharmacy directors expect formulary entries for infusibles',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Formulary committees evaluate both pharmaceuticals and durable medical equipment (DME) for coverage tiers, prior authorization requirements, and therapeutic alternatives. Healthcare organizations main',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Formulary management requires linking coverage rules to standardized NDC drug definitions for tier assignment, prior authorization criteria, and therapeutic interchange decisions. Essential for payer ',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: CMS Part D and state Medicaid regulatory obligations directly govern formulary tier placement, coverage decisions, and quantity limits. Formulary managers must track which specific obligation mandates',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Formulary decisions are governed by P&T committee policies (prior auth criteria, step therapy protocols). Real process: formulary management requires linking formulary entries to governing policies fo',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Formulary rules for specialty drugs administered in clinical settings (e.g., infusion therapy, chemotherapy) require CPT code linkage for procedure-based coverage determination. Essential for buy-and-',
    `service_id` BIGINT COMMENT 'Foreign key linking to facility.service. Business justification: Service-line formulary management (oncology, cardiac, transplant, pain management formularies) is a named clinical pharmacy process. Payer contracts and accreditation bodies (ASCO, FACT) require servi',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Pharmacy & Therapeutics (P&T) committees define specialty-specific formularies (e.g., oncology, cardiology). Formulary tier assignments, prior authorization criteria, and step therapy protocols are sp',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Unit-restricted formularies (ICU sedation protocols, NICU formulary, oncology unit chemotherapy formulary) are a standard clinical pharmacy management process. Formulary already links to care_site; un',
    `age_restriction_max` STRING COMMENT 'Maximum patient age (in years) for which this drug is covered under the formulary. Null if no maximum age restriction applies.',
    `age_restriction_min` STRING COMMENT 'Minimum patient age (in years) for which this drug is covered under the formulary. Null if no minimum age restriction applies.',
    `approval_date` DATE COMMENT 'Date when this formulary entry was officially approved for inclusion in the formulary. Format: yyyy-MM-dd.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved this formulary entry (e.g., P&T Committee, Chief Pharmacy Officer).',
    `clinical_review_required` BOOLEAN COMMENT 'Indicates whether clinical review by a pharmacist or physician is required before dispensing. True if clinical review is mandatory.',
    `controlled_substance_schedule` STRING COMMENT 'DEA schedule classification for controlled substances. Schedule II drugs have high abuse potential, Schedule V have lowest. Non-controlled if not a controlled substance.. Valid values are `schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V|non_controlled`',
    `coverage_status` STRING COMMENT 'Indicates whether the drug is covered under this formulary. Conditional or restricted coverage requires additional criteria to be met.. Valid values are `covered|not_covered|conditional|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this formulary record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `days_supply_limit` STRING COMMENT 'Maximum number of days supply that can be dispensed per prescription under this formulary. Common values are 30, 60, or 90 days.',
    `effective_date` DATE COMMENT 'Date when this formulary entry becomes active and coverage rules take effect. Format: yyyy-MM-dd.',
    `expiration_date` DATE COMMENT 'Date when this formulary entry expires and coverage rules are no longer in effect. Null for open-ended formularies. Format: yyyy-MM-dd.',
    `formulary_name` STRING COMMENT 'Business name or label for this formulary (e.g., Commercial Preferred Formulary 2024, Medicare Part D Standard Formulary).',
    `formulary_status` STRING COMMENT 'Current lifecycle status of this formulary entry. Active entries are in effect, inactive are not currently used, pending are awaiting approval.. Valid values are `active|inactive|pending|suspended|archived`',
    `formulary_tier` STRING COMMENT 'The tier classification of the drug within the formulary, determining patient cost-sharing and coverage level. Tier 1 typically has lowest cost-sharing, Tier 5 for specialty drugs.. Valid values are `tier_1_preferred_generic|tier_2_generic|tier_3_preferred_brand|tier_4_non_preferred_brand|tier_5_specialty|not_covered`',
    `formulary_type` STRING COMMENT 'Type or category of formulary, typically aligned with payer type or benefit plan category (e.g., commercial, Medicare Part D, Medicaid).. Valid values are `commercial|medicare_part_d|medicaid|exchange|employer_group|specialty`',
    `gender_restriction` STRING COMMENT 'Gender restriction for coverage of this drug under the formulary. Some drugs may be covered only for specific genders based on clinical indication.. Valid values are `male|female|all|not_specified`',
    `generic_substitution_allowed` BOOLEAN COMMENT 'Indicates whether generic substitution is permitted for this drug under the formulary. True if pharmacist may substitute with generic equivalent.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this formulary record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_reviewed_date` DATE COMMENT 'Date when this formulary entry was last reviewed by the Pharmacy and Therapeutics (P&T) committee or formulary management team. Format: yyyy-MM-dd.',
    `mail_order_eligible` BOOLEAN COMMENT 'Indicates whether this drug is eligible for mail-order pharmacy fulfillment under the formulary. True if mail-order is available.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formulary review of this entry. Format: yyyy-MM-dd.',
    `notes` STRING COMMENT 'Free-text notes or comments about this formulary entry, including special instructions, clinical guidance, or administrative notes for pharmacists and prescribers.',
    `pharmacy_network_restriction` STRING COMMENT 'Indicates which pharmacy network tier or type is required for dispensing this drug under the formulary (e.g., specialty pharmacy only, preferred network).. Valid values are `preferred_network|standard_network|specialty_pharmacy_only|all_networks`',
    `prior_authorization_criteria` STRING COMMENT 'Detailed clinical or administrative criteria that must be met for prior authorization approval. May reference diagnosis codes, lab values, or prior treatment history.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization from the payer is required before the drug can be dispensed. True if PA is mandatory.',
    `quantity_limit` DECIMAL(18,2) COMMENT 'Maximum quantity of the drug that can be dispensed per prescription or per time period under this formulary. Null if no quantity limit applies.',
    `quantity_limit_unit` STRING COMMENT 'Unit of measure for the quantity limit (e.g., tablets, capsules, milliliters, days supply). Defines how the quantity limit is measured. [ENUM-REF-CANDIDATE: tablets|capsules|ml|units|doses|days|per_30_days|per_90_days — 8 candidates stripped; promote to reference product]',
    `refill_limit` STRING COMMENT 'Maximum number of refills allowed for this drug under the formulary. Null if no refill limit applies or unlimited refills are permitted.',
    `specialty_drug_indicator` BOOLEAN COMMENT 'Indicates whether this drug is classified as a specialty drug requiring special handling, distribution, or patient management. True if specialty drug.',
    `step_therapy_protocol` STRING COMMENT 'Description of the step therapy protocol, including which alternative medications must be tried first and for how long before this drug is covered.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether step therapy (trial of alternative medications) is required before this drug is covered. True if step therapy protocol must be followed.',
    `therapeutic_alternative_available` BOOLEAN COMMENT 'Indicates whether therapeutic alternatives (drugs with similar clinical effect) are available on the formulary. True if alternatives exist.',
    `therapeutic_class_code` STRING COMMENT 'Standardized therapeutic class code for the drug (e.g., AHFS, ETC, or internal classification). Used for formulary management and therapeutic interchange.',
    `version` STRING COMMENT 'Version identifier for the formulary, used to track changes and updates over time (e.g., 2024.1, Q1-2024).',
    CONSTRAINT pk_formulary PRIMARY KEY(`formulary_id`)
) COMMENT 'Defines the approved drug formulary for each health plan, payer, or facility tier. Captures formulary tier (preferred/non-preferred/specialty), prior authorization requirements, step therapy requirements, quantity limits, formulary effective and expiration dates, therapeutic alternatives, payer-specific coverage rules, and specialty drug classification. Supports formulary management, clinical decision support at point of prescribing, and prescription adjudication. Benefit plan financial details (copay/coinsurance schedules, deductible applicability, mail-order benefit rules) are sourced from the billing domain; this product owns drug-level coverage and access rules only. Sourced from Epic Willow and Cerner PharmNet formulary modules.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`pharmacy`.`prescription` (
    `prescription_id` BIGINT COMMENT 'Unique identifier for the prescription record. Primary key.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to scheduling.scheduling_appointment. Business justification: Prescriptions are frequently written during appointments. Tracking this enables medication reconciliation workflows, prescription-to-visit analytics for quality measures, and supports e-prescribing au',
    `authorization_id` BIGINT COMMENT 'Foreign key linking to encounter.encounter_authorization. Business justification: Pharmacy benefit management requires matching each prescription to its prior authorization record for payer audit trails and denial management. Replaces denormalized prior_authorization_number text fi',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Prescriptions originate from clinical orders in CPOE workflows. This link enables e-prescribing traceability, medication reconciliation, clinical decision support alerts, and regulatory audit trails r',
    `coverage_policy_id` BIGINT COMMENT 'Foreign key linking to insurance.coverage_policy. Business justification: Pharmacy benefit adjudication requires validating each prescription against the payers coverage policy to determine medical necessity, exclusions, and PA requirements. Pharmacy staff and PBMs referen',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Prescriptions must link to diagnoses for prior authorization, formulary compliance, and medical necessity documentation. Required for payer adjudication, quality measure reporting, and regulatory comp',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: A prescription is written for a specific drug in the drug master. This FK establishes the authoritative link between the prescription transaction and the pharmacy drug master, enabling formulary check',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Formulary checking is a mandatory step in prescription processing — the prescriber and pharmacist must verify the drug is on the patients applicable formulary tier. This FK links the prescription to ',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Pre-medication prescriptions (steroids, antihistamines for contrast allergy prophylaxis, sedation) are directly ordered in support of a specific imaging order. Linking prescription to imaging_order en',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Prescriptions require ICD-10 diagnosis linkage for medical necessity validation, prior authorization processing, and off-label use documentation. Essential for payer coverage determination and clinica',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Prior authorization submission, formulary tier determination, and copay calculation at prescribing time require the specific patient insurance coverage record. Prescription already stores prior_author',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: Prescribing decisions require lab results for renal/hepatic dosing adjustments, therapeutic drug monitoring, and culture-directed antibiotic therapy. Clinical decision support workflow standard in EHR',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Prescriptions must reference standardized NDC definitions for drug identification, dispensing validation, formulary checking, and pharmacy claims processing. Core to e-prescribing workflows and medica',
    `original_prescription_id` BIGINT COMMENT 'Reference to the original prescription record if this is a refill, renewal, or change. Null for new prescriptions. Enables tracking of prescription history and refill chains.',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Prescription validity requires prescriber NPI validation against the NPPES registry for DEA EPCS compliance, state board of pharmacy audits, and payer credentialing verification. Pharmacy compliance o',
    `clinician_id` BIGINT COMMENT 'Reference to the provider who wrote this prescription. Links to the provider master.',
    `mpi_record_id` BIGINT COMMENT 'Reference to the patient for whom this prescription was written. Links to the patient master.',
    `prescription_patient_mpi_record_id` BIGINT COMMENT 'FK to patient.mpi_record.mpi_record_id — Prescriptions must link to the patient for medication reconciliation, drug interaction checking, and longitudinal medication history. Required for patient safety.',
    `prescription_prescriber_clinician_id` BIGINT COMMENT 'FK to provider.clinician.clinician_id — Every prescription must identify the prescribing provider for DEA compliance, controlled substance tracking, and clinical accountability. Required by state pharmacy boards and CMS.',
    `prior_auth_rule_id` BIGINT COMMENT 'Foreign key linking to insurance.prior_auth_rule. Business justification: When a prescription requires prior authorization, pharmacy staff must reference the specific PA rule governing that drug/plan combination to submit the correct documentation. The prescription already ',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Prescriptions requiring PA must reference the approved PA record before dispensing and claim submission. Pharmacy and revenue cycle teams link prescriptions to PA records for authorization validation ',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: Prescriptions generated from standing medication order protocols must reference the originating standing_order for protocol compliance tracking, renewal cycle management, and regulatory audit trails. ',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Pre-operative and post-operative prescriptions (bowel prep, post-op pain management, prophylactic antibiotics) are directly tied to a surgical case. Perioperative pharmacy reconciliation and surgical ',
    `susceptibility_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.susceptibility_result. Business justification: Antibiotic Stewardship Program (ASP) review requires pharmacists and ID physicians to verify that the prescribed antibiotic matches the organism susceptibility profile. Linking the prescription direct',
    `training_completion_id` BIGINT COMMENT 'Foreign key linking to compliance.training_completion. Business justification: E-prescribing of controlled substances (EPCS) requires DEA-mandated training completion. Real process: prescription validation verifies prescriber completed required EPCS training; link enables creden',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: Medication reconciliation (Joint Commission NPSG.03.06.01) and diagnosis-driven prescribing quality measures require linking each prescription to the specific coded visit diagnosis that indicated it. ',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which this prescription was written. May be null for outpatient prescriptions written outside of a visit context.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this prescription record was first created in the system. Used for audit trail and data lineage tracking.',
    `daw_code` STRING COMMENT 'NCPDP standard code indicating the reason for dispensing a brand-name drug when a generic is available. 0=no product selection indicated; 1=substitution not allowed by prescriber; 2=substitution allowed but patient requested brand; 3-9=other specific reasons. [ENUM-REF-CANDIDATE: 0|1|2|3|4|5|6|7|8|9 — 10 candidates stripped; promote to reference product]',
    `days_supply` STRING COMMENT 'The number of days the prescribed quantity is expected to last based on the sig instructions. Used for refill timing and insurance adjudication.',
    `dea_schedule` STRING COMMENT 'The DEA controlled substance schedule classification for this medication. Schedule I-V indicates controlled substances with varying abuse potential and regulatory requirements; non-controlled indicates the medication is not a controlled substance.. Valid values are `I|II|III|IV|V|non-controlled`',
    `discontinuation_date` DATE COMMENT 'The date on which the prescription was discontinued by the prescriber. Null if the prescription has not been discontinued.',
    `discontinuation_reason` STRING COMMENT 'Free-text explanation of why the prescription was discontinued (e.g., adverse reaction, treatment completed, medication no longer needed, switched to alternative therapy).',
    `dosage_form` STRING COMMENT 'The physical form in which the medication is dispensed (e.g., tablet, capsule, liquid, injection). [ENUM-REF-CANDIDATE: tablet|capsule|liquid|injection|topical|inhaler|patch|suppository|cream|ointment|solution|suspension — 12 candidates stripped; promote to reference product]',
    `drug_strength` STRING COMMENT 'The strength or concentration of the medication (e.g., 500mg, 10mg/mL). Includes both numeric value and unit of measure.',
    `effective_date` DATE COMMENT 'The date on which the prescription becomes active and may be filled. May differ from prescription_date for future-dated prescriptions.',
    `epcs_flag` BOOLEAN COMMENT 'Indicates whether this prescription for a controlled substance was transmitted electronically using EPCS-compliant technology. True if EPCS was used; false if paper or non-EPCS electronic transmission.',
    `erx_transmission_status` STRING COMMENT 'The status of electronic transmission of this prescription to the dispensing pharmacy. Transmitted indicates successful delivery; pending indicates queued for transmission; failed indicates transmission error; not-transmitted indicates paper or verbal prescription.. Valid values are `transmitted|pending|failed|not-transmitted|acknowledged|rejected`',
    `erx_transmission_timestamp` TIMESTAMP COMMENT 'The date and time when the prescription was electronically transmitted to the pharmacy. Null if not electronically transmitted.',
    `expiration_date` DATE COMMENT 'The date after which the prescription is no longer valid and cannot be filled. Typically one year from prescription_date for non-controlled substances; shorter for controlled substances per DEA regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this prescription record was last updated. Used for audit trail and change tracking.',
    `medication_name` STRING COMMENT 'The name of the prescribed medication, typically the generic or brand name as entered by the prescriber.',
    `pharmacy_notes` STRING COMMENT 'Free-text notes entered by pharmacy staff regarding this prescription. May include clarifications, patient counseling notes, or special handling instructions.',
    `prescriber_dea_number` STRING COMMENT 'The DEA registration number of the prescriber, required for prescribing controlled substances. Format: two letters followed by seven digits.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `prescriber_notes` STRING COMMENT 'Free-text notes entered by the prescriber regarding this prescription. May include clinical rationale, special instructions, or patient-specific considerations.',
    `prescription_date` DATE COMMENT 'The date on which the prescription was written by the prescriber. This is the authoritative date for prescription validity and expiration calculations.',
    `prescription_number` STRING COMMENT 'The externally-known prescription number or control number assigned by the pharmacy system. Used for prescription tracking, refill requests, and patient communication.',
    `prescription_status` STRING COMMENT 'The current lifecycle status of the prescription. Active prescriptions may be filled; discontinued prescriptions have been stopped by the prescriber; expired prescriptions have passed their expiration date; on-hold prescriptions are temporarily suspended. [ENUM-REF-CANDIDATE: active|discontinued|expired|on-hold|completed|cancelled|entered-in-error — 7 candidates stripped; promote to reference product]',
    `prescription_timestamp` TIMESTAMP COMMENT 'The precise date and time when the prescription was written and entered into the system. Used for audit trails and CPOE (Computerized Physician Order Entry) compliance.',
    `prescription_type` STRING COMMENT 'Classifies the prescription transaction type. New indicates first-time prescription; refill indicates subsequent fill of existing prescription; renewal indicates new prescription for same medication after previous expired; transfer indicates prescription moved between pharmacies; change indicates modification to existing prescription.. Valid values are `new|refill|renewal|transfer-in|transfer-out|change`',
    `prior_authorization_required_flag` BOOLEAN COMMENT 'Indicates whether insurance prior authorization is required before this prescription can be filled. True if prior auth is needed; false otherwise.',
    `quantity_prescribed` DECIMAL(18,2) COMMENT 'The total quantity of medication prescribed, expressed in the unit appropriate to the dosage form (e.g., number of tablets, milliliters of liquid).',
    `quantity_unit` STRING COMMENT 'The unit of measure for the prescribed quantity (e.g., tablets, capsules, mL, grams).',
    `refills_authorized` STRING COMMENT 'The number of refills authorized by the prescriber. Zero indicates no refills allowed. Controlled substances have regulatory limits on refill counts.',
    `refills_remaining` STRING COMMENT 'The number of refills remaining on this prescription. Decremented each time the prescription is filled.',
    `route_of_administration` STRING COMMENT 'The path by which the medication is administered to the patient (e.g., oral, intravenous, topical). [ENUM-REF-CANDIDATE: oral|intravenous|intramuscular|subcutaneous|topical|inhalation|rectal|transdermal|sublingual|ophthalmic|otic|nasal — 12 candidates stripped; promote to reference product]',
    `sig` STRING COMMENT 'The prescribers instructions to the patient on how to take the medication. Free-text field containing dosing frequency, timing, and special instructions (e.g., Take 1 tablet by mouth twice daily with food).',
    `substitution_allowed_flag` BOOLEAN COMMENT 'Indicates whether generic substitution is permitted by the prescriber. True allows the pharmacist to dispense a generic equivalent; false requires dispensing as written (DAW).',
    CONSTRAINT pk_prescription PRIMARY KEY(`prescription_id`)
) COMMENT 'Core transactional record representing a medication order written by an authorized prescriber for a patient. Captures MRN, prescriber NPI, drug name, NDC, sig (directions), quantity prescribed, days supply, refills authorized, prescribing date, indication (ICD-10), prescription status (active/discontinued/expired/on-hold), e-prescribing transmission status, DEA number for controlled substances, and EPCS (Electronic Prescribing of Controlled Substances) compliance flag. Sourced from Epic Willow and Cerner PharmNet.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` (
    `dispense_event_id` BIGINT COMMENT 'Unique identifier for each medication dispensing event. Primary key for the dispense event transaction.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Pharmacy dispense events in facility settings (inpatient, clinic-administered medications) generate facility claims. Hospitals bill medications as part of facility claims using revenue codes. Links di',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: Medication dispense events must trace back to the originating clinical order for pharmacovigilance, Joint Commission medication reconciliation audits, and CMS compliance reporting. Pharmacists verify ',
    `demographics_id` BIGINT COMMENT 'Reference to the patient receiving the dispensed medication. Links to patient master record.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Pharmacy dispensing systems validate diagnosis codes for restricted medications and prior authorization requirements. Required for REMS compliance, controlled substance monitoring, and payer claim adj',
    `inventory_location_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_location. Business justification: Dispense events occur at specific physical locations (ADC cabinets, satellite pharmacies). Linking to inventory_location replaces denormalized dispensing_location_name and enables ADC-level dispensing',
    `care_site_id` BIGINT COMMENT 'Foreign key linking to facility.care_site. Business justification: DEA site-level controlled substance dispensing reports, CMS cost reports, and state pharmacy board audits require knowing which care site dispensed each medication. dispensing_location_name is a den',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Dispensing pharmacist is a licensed clinician. Pharmacy operations require tracking which clinician dispensed medication for regulatory compliance, audit trails, quality assurance, and liability. NPI ',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Each dispense event dispenses a specific drug from the drug master. Cardinality N:1 (many dispense events for one drug). The medication_name can be retrieved from drug_master via JOIN. The ndc_code is',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Dispense events for Medicare Part B drugs (infusibles, injectables, vaccines) require HCPCS J-code assignment for claim submission and reimbursement. Pharmacy billing specialists expect dispense recor',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to insurance.health_plan. Business justification: Dispense events must reference the specific health plan for benefit determination (copay, coinsurance, deductible application, formulary tier). Plan-specific rules govern coverage and patient cost-sha',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: When pharmacy dispenses contrast agents or pre-medications for a radiology procedure, the dispense_event must reference the imaging_order to support pharmacy-radiology charge reconciliation, prior aut',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Pharmacy billing adjudication applies the specific coverage record to determine copay, deductible application, and COB priority at point of dispensing. Existing payer_id/health_plan_id FKs are insuffi',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Pharmacy dispenses medical supplies (diabetic testing supplies, ostomy supplies, wound care products, nebulizers) alongside medications. Dispense events must track both drug and supply dispensing for ',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Enterprise medication history, controlled substance DEA monitoring, and population health reporting require dispense events linked to the authoritative MPI identity — not just demographics. Medication',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Dispense events require direct NDC reference for PDMP reporting, DEA compliance, pharmacy claims adjudication, and drug recall tracking. Regulatory mandate for controlled substance monitoring and stat',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: Pharmacy claims adjudication requires payer identification for real-time eligibility verification, formulary checks, and payment processing at point of dispense. Every dispensing event in retail/outpa',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Dispense event records require prescriber NPI validation against NPPES for controlled substance dispensing audits, state PMP reporting, and payer claim adjudication. Pharmacy auditors expect dispense ',
    `prescription_id` BIGINT COMMENT 'Reference to the prescription order that authorized this dispensing event. Links to the prescription master record.',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Specialty and controlled drug dispense events must validate against an approved PA before dispensing. Specialty pharmacy compliance audits and payer audits require linking each dispense event to its a',
    `training_completion_id` BIGINT COMMENT 'Foreign key linking to compliance.training_completion. Business justification: REMS programs require pharmacies to verify dispensing pharmacist training completion before dispensing REMS drugs. The dispense_event must reference the verified training_completion record at time of ',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: Dispense events for recurring medications under standing orders must reference the standing_order to support renewal tracking, expiration management, and pharmacy operations reporting on standing orde',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter or visit during which this medication was dispensed. May be null for outpatient retail dispensing.',
    `controlled_substance_tracking_number` STRING COMMENT 'Unique tracking identifier for controlled substance dispensing events. Required for DEA reporting and audit trail of Schedule II-V medications.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this dispense event. Typically USD for US healthcare organizations.. Valid values are `^[A-Z]{3}$`',
    `days_supply` STRING COMMENT 'The estimated number of days the dispensed medication quantity is expected to last based on prescribed dosing instructions. Used for refill timing and adherence monitoring.',
    `dea_schedule` STRING COMMENT 'DEA controlled substance schedule classification for the dispensed medication. Schedules I-V indicate increasing levels of accepted medical use and decreasing abuse potential. Non-controlled indicates no DEA restriction.. Valid values are `I|II|III|IV|V|non_controlled`',
    `dispense_status` STRING COMMENT 'Current status of the dispensing event in its lifecycle. Indicates whether the medication was successfully dispensed, partially filled, cancelled, or encountered an error.. Valid values are `completed|partial|cancelled|on_hold|stopped|entered_in_error`',
    `dispense_timestamp` TIMESTAMP COMMENT 'The exact date and time when the medication was physically dispensed to the patient or their representative. Represents the business event timestamp for the dispensing action.',
    `dispense_type` STRING COMMENT 'Classification of the dispensing setting or channel. Distinguishes between inpatient hospital pharmacy, outpatient clinic, retail pharmacy, specialty pharmacy, mail order, or emergency dispensing.. Valid values are `inpatient|outpatient|retail|specialty|mail_order|emergency`',
    `dispensed_quantity` DECIMAL(18,2) COMMENT 'The numeric quantity of medication dispensed, measured in the unit specified by quantity_unit. Represents the actual amount provided to the patient.',
    `dispensing_fee_amount` DECIMAL(18,2) COMMENT 'The professional fee charged by the pharmacy for dispensing services, separate from the medication cost. Used for revenue cycle and reimbursement tracking.',
    `expiration_date` DATE COMMENT 'The expiration date of the specific medication lot dispensed. Ensures patient safety and regulatory compliance for medication shelf life.',
    `fill_number` STRING COMMENT 'Sequential fill number for this prescription. Value of 0 or 1 indicates original fill; values greater than 1 indicate refills. Tracks prescription fulfillment history.',
    `insurance_paid_amount` DECIMAL(18,2) COMMENT 'The amount reimbursed or expected to be reimbursed by the patients insurance plan for this dispensing event. Used for revenue cycle and claims reconciliation.',
    `lot_number` STRING COMMENT 'Manufacturer lot or batch number for the dispensed medication. Critical for product recalls, quality control, and adverse event tracking.',
    `medication_cost_amount` DECIMAL(18,2) COMMENT 'The ingredient cost of the medication dispensed, representing the pharmacy acquisition cost or contracted price. Used for financial and inventory management.',
    `ndc_code` STRING COMMENT 'The 11-digit National Drug Code identifying the specific drug product, strength, and package size dispensed. Standardized FDA identifier for medications.. Valid values are `^[0-9]{11}$|^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$`',
    `patient_counseling_completed_flag` BOOLEAN COMMENT 'Indicates whether the pharmacist provided patient counseling on medication use, side effects, and interactions as required by state pharmacy practice acts.',
    `patient_counseling_declined_flag` BOOLEAN COMMENT 'Indicates whether the patient or their representative declined pharmacist counseling when offered. Documents patient choice for regulatory compliance.',
    `patient_pay_amount` DECIMAL(18,2) COMMENT 'The out-of-pocket amount paid by the patient for this dispensing event, including copay, coinsurance, or full cash price. Represents patient financial responsibility.',
    `prescriber_dea_number` STRING COMMENT 'The DEA registration number of the prescriber, required for controlled substance prescriptions. Format is two letters followed by seven digits.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `prescription_written_date` DATE COMMENT 'The date the original prescription was written by the prescriber. Used to validate prescription validity and track time from prescribing to dispensing.',
    `quantity_unit` STRING COMMENT 'The unit of measure for the dispensed quantity (e.g., tablets, capsules, mL, grams, inhalers, patches). Standardized using UCUM codes where applicable.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this dispense event record was first created in the data platform. Audit field for data lineage and troubleshooting.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this dispense event record was last modified in the data platform. Tracks data currency and change history.',
    `refills_remaining` STRING COMMENT 'Number of authorized refills remaining after this dispense event. Decremented with each fill to track prescription lifecycle.',
    `sig_text` STRING COMMENT 'The patient instructions for medication use as written on the prescription label. Includes dosing frequency, route, and special instructions. Latin abbreviation sig means write on label.',
    `source_system` STRING COMMENT 'The name of the pharmacy information system that originated this dispense event record. Examples include Epic Willow, Cerner PharmNet, or other pharmacy management systems.',
    `source_system_dispense_code` STRING COMMENT 'The unique identifier for this dispense event in the originating pharmacy system. Maintains traceability to source system for reconciliation and troubleshooting.',
    `substitution_made_flag` BOOLEAN COMMENT 'Indicates whether a generic or therapeutic substitution was made from the originally prescribed medication. Tracks formulary compliance and cost management.',
    `substitution_reason` STRING COMMENT 'Free-text or coded reason for medication substitution when substitution_made_flag is true. Examples include formulary requirement, drug shortage, patient request, or cost savings.',
    `verification_timestamp` TIMESTAMP COMMENT 'The date and time when the dispensing action was verified by a pharmacist. Represents the final quality check before medication is released to patient.',
    `verifying_pharmacist_npi` STRING COMMENT 'The NPI of the pharmacist who verified the dispensing action. In many workflows, a second pharmacist verifies the dispense for safety and accuracy.. Valid values are `^[0-9]{10}$`',
    CONSTRAINT pk_dispense_event PRIMARY KEY(`dispense_event_id`)
) COMMENT 'Transactional record of each medication dispensing action performed by the pharmacy. Captures prescription reference, dispensed NDC, dispensed quantity, dispensed days supply, lot number, expiration date, dispensing pharmacist NPI, dispensing location, dispense date and time, fill number (original vs. refill), dispense type (inpatient/outpatient/retail/specialty), patient counseling flag, and verification status. Represents the physical fulfillment of a prescription. Sourced from Epic Willow and Cerner PharmNet.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`pharmacy`.`mar_record` (
    `mar_record_id` BIGINT COMMENT 'Unique identifier for the medication administration record. Primary key for the MAR record product.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Administering provider is a licensed clinician. Medication administration records must track which licensed provider administered medication for legal liability, clinical review, audit compliance, and',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Unit-level medication administration compliance reports, ISMP unit-based ADE tracking, and nursing unit controlled substance reconciliation require the unit where administration occurred. Patients tra',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Inpatient medication administration (MAR) drives facility claim line items. Hospitals bill for administered medications via claim lines with revenue codes. Essential for claim substantiation, medical ',
    `clinical_order_id` BIGINT COMMENT 'Unique identifier for the clinical order that authorized this medication administration.',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: Medication administration records reference diagnosis being treated for documentation and billing compliance. Required for medication administration documentation standards and charge capture validati',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: The MAR record should trace to the specific dispense event (fill) that was administered. This FK enables lot-level traceability — critical for recall management and controlled substance reconciliation',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Each MAR record documents administration of a specific drug from the drug master. Cardinality N:1 (many MAR records for one drug). The medication_name can be retrieved from drug_master via JOIN. The m',
    `imaging_order_id` BIGINT COMMENT 'Foreign key linking to radiology.imaging_order. Business justification: Pre-medication administration (corticosteroids, antihistamines) documented in the MAR must reference the imaging_order it was administered for. This supports contrast pre-medication protocol complianc',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient who received the medication. Links to the patient master.',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Medication administration records need NDC linkage for barcode medication administration (BCMA) validation, regulatory reporting to CMS, and adverse event tracking. Required for Joint Commission medic',
    `or_suite_id` BIGINT COMMENT 'Foreign key linking to facility.or_suite. Business justification: Intraoperative medication administration (anesthesia drugs, surgical antibiotics) is documented in MAR tied to a specific OR suite. OR-level controlled substance reconciliation (DEA requirement), OR p',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: The Medication Administration Record (MAR) documents the actual administration of a medication that was authorized by a prescription. This FK completes the medication lifecycle chain: prescription (or',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Nurses document which specific lab result (e.g., blood glucose for insulin sliding scale, aPTT for heparin, serum potassium for KCl replacement) justified the dose administered. This lab-value-driven ',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to order.standing_order. Business justification: MAR records for medications administered under standing orders must reference the authorizing standing_order for nursing workflow validation, regulatory compliance (TJC standard MM.04.01.01), and stan',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Intraoperative medication administration (anesthesia agents, prophylactic antibiotics, hemostatic drugs) must be linked directly to the surgical case for perioperative medication reconciliation, surgi',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: MAR records require verifying pharmacist NPI validation against NPPES for Joint Commission medication administration compliance, state board of pharmacy audits, and controlled substance verification r',
    `visit_id` BIGINT COMMENT 'Unique identifier for the patient encounter or visit during which the medication was administered.',
    `actual_administration_timestamp` TIMESTAMP COMMENT 'The actual date and time when the medication was administered to the patient. Core timestamp for medication safety and regulatory compliance.',
    `administration_method` STRING COMMENT 'The specific method or technique used to administer the medication (e.g., IV push, IV piggyback, continuous infusion, nebulizer).',
    `administration_site` STRING COMMENT 'The specific anatomical location where the medication was administered (e.g., left deltoid, right forearm, abdomen).',
    `administration_status` STRING COMMENT 'The status of the medication administration event indicating whether the medication was given, held, refused by patient, not available, or omitted. [ENUM-REF-CANDIDATE: given|held|refused|not-available|omitted|stopped|completed|entered-in-error — 8 candidates stripped; promote to reference product]',
    `administration_status_reason` STRING COMMENT 'The reason why the medication was held, refused, not available, or omitted. Required when status is not given.',
    `barcode_scan_timestamp` TIMESTAMP COMMENT 'The date and time when the medication barcode was scanned during administration, supporting five rights verification (right patient, right drug, right dose, right route, right time).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this MAR record was first created in the lakehouse silver layer.',
    `dea_schedule` STRING COMMENT 'The DEA controlled substance schedule classification for the medication (I through V for controlled substances, or non-controlled).. Valid values are `I|II|III|IV|V|non-controlled`',
    `documentation_timestamp` TIMESTAMP COMMENT 'The date and time when the medication administration was documented in the electronic medical record system.',
    `dose_given` DECIMAL(18,2) COMMENT 'The quantity of medication administered to the patient in this administration event.',
    `dose_unit` STRING COMMENT 'The unit of measure for the dose given (e.g., mg, mL, units, tablets). [ENUM-REF-CANDIDATE: mg|g|mcg|mL|L|units|mEq|mmol|tablets|capsules|puffs|drops|patches — 13 candidates stripped; promote to reference product]',
    `expiration_date` DATE COMMENT 'The expiration date of the medication administered. Required for medication safety and quality assurance.',
    `infusion_duration_minutes` STRING COMMENT 'The total duration in minutes over which an intravenous medication was infused.',
    `infusion_rate` DECIMAL(18,2) COMMENT 'The rate at which an intravenous medication was infused, applicable for IV administrations.',
    `infusion_rate_unit` STRING COMMENT 'The unit of measure for the infusion rate (e.g., mL/hr, units/hr, mcg/kg/min).. Valid values are `mL/hr|mL/min|units/hr|mcg/kg/min|mg/hr`',
    `is_first_dose` BOOLEAN COMMENT 'Boolean flag indicating whether this administration represents the first dose of this medication for the patient during this visit or treatment course.',
    `is_stat_order` BOOLEAN COMMENT 'Boolean flag indicating whether this was a stat (immediate/urgent) medication order requiring immediate administration.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this MAR record was last updated in the lakehouse silver layer.',
    `lot_number` STRING COMMENT 'The manufacturers lot or batch number of the medication administered. Critical for recall tracking and adverse event investigation.',
    `medication_ndc` STRING COMMENT 'The National Drug Code identifying the specific medication product administered. Standard 11-digit FDA identifier in 5-4-2, 5-3-2, or 4-4-2 format.. Valid values are `^[0-9]{4,5}-[0-9]{3,4}-[0-9]{1,2}$`',
    `patient_response` STRING COMMENT 'Clinical observation of the patients response to the medication administration, including any adverse reactions or therapeutic effects noted.',
    `pharmacy_verification_timestamp` TIMESTAMP COMMENT 'The date and time when a pharmacist verified the medication order prior to administration, if applicable.',
    `prn_indication` STRING COMMENT 'The clinical indication or reason for administering a PRN (as needed) medication. Required when the order is PRN.',
    `route` STRING COMMENT 'The anatomical route by which the medication was administered to the patient. [ENUM-REF-CANDIDATE: oral|intravenous|intramuscular|subcutaneous|topical|inhalation|rectal|sublingual|transdermal|ophthalmic|otic|nasal|epidural|intrathecal — 14 candidates stripped; promote to reference product]',
    `scheduled_administration_timestamp` TIMESTAMP COMMENT 'The date and time when the medication was originally scheduled to be administered per the order.',
    `source_system` STRING COMMENT 'The source electronic health record system from which this MAR record was extracted (e.g., Epic ClinDoc, Cerner PharmNet).. Valid values are `Epic ClinDoc|Epic Willow|Cerner PharmNet|Cerner PowerChart|MEDITECH`',
    `source_system_record_code` STRING COMMENT 'The unique identifier for this MAR record in the source system, enabling traceability back to the originating EHR.',
    `waste_amount` DECIMAL(18,2) COMMENT 'The quantity of controlled substance medication that was wasted or discarded during this administration event. Required for controlled substance tracking.',
    `waste_unit` STRING COMMENT 'The unit of measure for the waste amount recorded. [ENUM-REF-CANDIDATE: mg|g|mcg|mL|L|units|mEq|mmol|tablets|capsules — 10 candidates stripped; promote to reference product]',
    `witness_provider_name` STRING COMMENT 'The full name of the clinician who witnessed the controlled substance waste.',
    `witness_provider_npi` STRING COMMENT 'The 10-digit National Provider Identifier of the second clinician who witnessed the controlled substance waste. Required for DEA compliance when waste is documented.. Valid values are `^[0-9]{10}$`',
    CONSTRAINT pk_mar_record PRIMARY KEY(`mar_record_id`)
) COMMENT 'Medication Administration Record (MAR) capturing each instance of medication administration to an inpatient or outpatient patient. Records administered drug, dose given, route, administration date and time, administering nurse/clinician NPI, administration site, patient response, waste amount (for controlled substances), witness NPI for controlled substance waste, and administration status (given/held/refused/not-available). Core to inpatient medication safety and regulatory compliance. Sourced from Epic ClinDoc MAR and Cerner PharmNet.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` (
    `adverse_drug_event_id` BIGINT COMMENT 'Unique identifier for the adverse drug event record. Primary key.',
    `clinical_order_id` BIGINT COMMENT 'Foreign key linking to order.clinical_order. Business justification: FDA MedWatch and ISMP pharmacovigilance reporting require tracing ADEs to the originating clinical order for root cause analysis. The ADE already links to prescription/MAR/dispense but the upstream cl',
    `contrast_admin_id` BIGINT COMMENT 'Foreign key linking to radiology.contrast_admin. Business justification: Contrast reactions (anaphylaxis, nephrotoxicity) are a major ADE category. FDA MedWatch reporting and pharmacovigilance root cause analysis require linking the adverse_drug_event to the specific contr',
    `dispense_event_id` BIGINT COMMENT 'Foreign key linking to pharmacy.dispense_event. Business justification: ADEs must be traceable to the specific dispense event to support lot-level recall investigations, dispensing error analysis, and pharmacist accountability. This FK enables identification of whether th',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Adverse drug events are caused by specific drugs in the drug master. The FK is labeled causative_drug_master_id to distinguish from potential other drug references. Cardinality N:1. The causative_dr',
    `mar_record_id` BIGINT COMMENT 'Foreign key linking to pharmacy.mar_record. Business justification: For inpatient ADEs, the administration event (MAR record) is the most granular point of traceability — capturing the exact dose given, route, administration site, and administering provider. This FK e',
    `prescription_id` BIGINT COMMENT 'Foreign key linking to pharmacy.prescription. Business justification: Pharmacovigilance and ADE root cause analysis require tracing the adverse event back to the prescription that authorized the causative medication. This FK enables prescriber-level ADE reporting, prior',
    `claim_id` BIGINT COMMENT 'Foreign key linking to claim.claim. Business justification: Adverse drug events trigger claims for treatment of the adverse event (ED visits, hospitalizations, additional medications). Claims analysis identifies drug safety patterns, cost impact of ADEs, and p',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to laboratory.test_result. Business justification: Pharmacovigilance and ADE root cause analysis workflows require linking the ADE to the specific lab result (e.g., elevated creatinine confirming nephrotoxicity, supratherapeutic drug level confirming ',
    `demographics_id` BIGINT COMMENT 'Reference to the patient who experienced the adverse drug event.',
    `lab_order_id` BIGINT COMMENT 'Foreign key linking to laboratory.lab_order. Business justification: ADE root cause analysis requires linking to lab results that detected the adverse event (elevated liver enzymes for hepatotoxicity, creatinine for nephrotoxicity). Required for FDA MedWatch reporting ',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: FDA MedWatch and ISMP regulatory ADE reporting requires enterprise patient identity (MPI), not just demographics. Patient safety event tracking and cross-facility ADE pattern analysis depend on the au',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: FDA MedWatch reporting and pharmacovigilance surveillance require NDC-level drug identification for adverse event submissions. Essential for patient safety reporting, ISMP medication error tracking, a',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_policy. Business justification: ADE documentation explicitly references the governing compliance policy (medication error reporting policy, adverse event disclosure policy). Joint Commission requires ADE records to cite the policy u',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: ADE events are governed by specific compliance programs (medication safety, sentinel event programs). Medication safety officers report ADEs by program for Joint Commission and ISMP reporting. No exis',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Reporter is often a licensed clinician. Adverse drug event reporting requires tracking reporter identity for follow-up, quality improvement, and regulatory reporting. FK enables linking ADE reports to',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_diagnosis. Business justification: ADEs may result in new diagnoses (drug-induced hepatitis, anaphylaxis, Stevens-Johnson syndrome) that must be documented and coded. Required for patient safety reporting, quality measures, and HAC pre',
    `visit_diagnosis_id` BIGINT COMMENT 'Foreign key linking to encounter.visit_diagnosis. Business justification: FDA MedWatch pharmacovigilance reporting and internal ADE review programs require linking adverse drug events to the specific coded ICD-10 diagnosis they caused. Supports drug-induced condition coding',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to scheduling.surgical_case. Business justification: Intraoperative adverse drug events (anaphylaxis, wrong-drug errors in the OR) must be linked to the specific surgical case for ISMP surgical error reporting, root cause analysis, and Joint Commission ',
    `visit_id` BIGINT COMMENT 'Reference to the clinical encounter during which the adverse drug event was identified or occurred.',
    `adverse_drug_event_status` STRING COMMENT 'Current status of the adverse drug event record in the investigation and resolution workflow: reported, under investigation, investigation complete, or closed.. Valid values are `reported|under_investigation|investigation_complete|closed`',
    `causative_drug_ndc` STRING COMMENT 'National Drug Code (NDC) of the medication identified as the cause or contributing factor to the adverse drug event.. Valid values are `^[0-9]{4,5}-[0-9]{3,4}-[0-9]{1,2}$`',
    `contributing_factors` STRING COMMENT 'Documented factors that contributed to the adverse drug event, such as prescribing errors, dispensing errors, administration errors, patient factors, or system failures.',
    `corrective_actions` STRING COMMENT 'Description of corrective actions implemented to prevent recurrence of similar adverse drug events, such as process changes, staff education, or system modifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the adverse drug event record was first created in the system.',
    `detection_method` STRING COMMENT 'Method by which the adverse drug event was detected: clinical observation, patient report, laboratory result, automated alert, chart review, or pharmacy review.. Valid values are `clinical_observation|patient_report|laboratory_result|automated_alert|chart_review|pharmacy_review`',
    `event_date` DATE COMMENT 'Date on which the adverse drug event occurred or was first identified.',
    `event_description` STRING COMMENT 'Detailed narrative description of the adverse drug event, including clinical presentation, symptoms, and circumstances.',
    `event_number` STRING COMMENT 'Business identifier or case number assigned to the adverse drug event for tracking and reporting purposes.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the adverse drug event occurred or was first identified.',
    `event_type` STRING COMMENT 'Classification of the adverse drug event: allergic reaction, adverse drug reaction (ADR), medication error, near-miss, toxicity, therapeutic failure, or drug interaction. [ENUM-REF-CANDIDATE: allergic_reaction|adverse_drug_reaction|medication_error|near_miss|toxicity|therapeutic_failure|drug_interaction — 7 candidates stripped; promote to reference product]',
    `fda_report_number` STRING COMMENT 'FDA MedWatch report number assigned when the adverse drug event was submitted to the FDA.',
    `harm_category` STRING COMMENT 'NCC MERP index category indicating the level of harm: A (no error), B (error no harm), C (error no harm), D (error monitoring required), E (temporary harm), F (temporary harm hospitalization), G (permanent harm), H (life-threatening), I (death). [ENUM-REF-CANDIDATE: A|B|C|D|E|F|G|H|I — 9 candidates stripped; promote to reference product]',
    `intervention_description` STRING COMMENT 'Description of the clinical interventions performed to address the adverse drug event, such as medication discontinuation, antidote administration, or supportive care.',
    `intervention_required` BOOLEAN COMMENT 'Indicates whether clinical intervention was required to mitigate or treat the adverse drug event.',
    `ismp_report_number` STRING COMMENT 'ISMP report number assigned when the adverse drug event was submitted to the ISMP Medication Errors Reporting Program.',
    `modified_by` STRING COMMENT 'User identifier or name of the individual who last modified or updated the adverse drug event record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the adverse drug event record was last modified or updated.',
    `outcome` STRING COMMENT 'Clinical outcome of the adverse drug event: recovered, recovering, not recovered, fatal, or unknown.. Valid values are `recovered|recovering|not_recovered|fatal|unknown`',
    `pharmacy_review_date` DATE COMMENT 'Date on which the adverse drug event was reviewed by the Pharmacy and Therapeutics (P&T) Committee for safety and quality improvement purposes.',
    `preventability_assessment` STRING COMMENT 'Assessment of whether the adverse drug event was preventable, probably preventable, not preventable, or unknown.. Valid values are `preventable|probably_preventable|not_preventable|unknown`',
    `reported_to_fda` BOOLEAN COMMENT 'Indicates whether the adverse drug event was reported to the FDA MedWatch program.',
    `reported_to_ismp` BOOLEAN COMMENT 'Indicates whether the adverse drug event was reported to the Institute for Safe Medication Practices (ISMP) Medication Errors Reporting Program.',
    `reporter_role` STRING COMMENT 'Professional role or title of the individual who reported the adverse drug event (e.g., physician, nurse, pharmacist, patient).',
    `root_cause_analysis_performed` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis was conducted for this adverse drug event.',
    `root_cause_findings` STRING COMMENT 'Summary of findings from the root cause analysis, identifying underlying system or process failures that contributed to the adverse drug event.',
    `severity_level` STRING COMMENT 'Clinical severity classification of the adverse drug event: mild, moderate, severe, life-threatening, or fatal.. Valid values are `mild|moderate|severe|life_threatening|fatal`',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created the adverse drug event record in the system.',
    CONSTRAINT pk_adverse_drug_event PRIMARY KEY(`adverse_drug_event_id`)
) COMMENT 'Operational record of adverse drug events (ADEs), adverse drug reactions (ADRs), and medication errors identified during patient care. Captures event date and time, patient reference, causative drug (NDC), event type (allergic reaction/toxicity/medication error/near-miss), severity level, harm category (NCC MERP index), contributing factors, reporter NPI, encounter reference, root cause analysis findings, and corrective actions taken. Supports pharmacovigilance, FDA MedWatch reporting, ISMP medication error reporting, and pharmacy P&T committee safety reviews. Sourced from Epic Willow and Cerner PharmNet.';

CREATE OR REPLACE TABLE `healthcare_ecm`.`pharmacy`.`inventory` (
    `inventory_id` BIGINT COMMENT 'Primary key for inventory',
    `care_site_id` BIGINT COMMENT 'Identifier for the healthcare facility where this inventory is located (hospital, clinic, outpatient pharmacy).',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Each inventory record tracks a specific drug from the drug master. Cardinality N:1 (many inventory records for one drug across locations/lots). The drug_name, drug_strength, dosage_form, and therapeut',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to pharmacy.formulary. Business justification: Pharmacy inventory management requires formulary awareness — stocking decisions are driven by formulary status (which drugs are approved for which tiers/plans). This FK links inventory records to the ',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Pharmacy inventory for Part B drugs requires HCPCS code tracking for Medicare cost reporting (CMS 340B program), drug purchase reconciliation, and outpatient billing accuracy. Pharmacy directors expec',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Pharmacy inventory includes medical supplies and devices (syringes, IV supplies, diabetic testing supplies, spacers, peak flow meters) stored alongside medications. Pharmacy inventory management syste',
    `ndc_drug_id` BIGINT COMMENT 'Foreign key linking to reference.ndc_drug. Business justification: Pharmacy inventory management requires NDC linkage for drug procurement, FDA recall response, expiration tracking, and 340B program compliance. Critical for automated reorder systems and drug shortage',
    `unit_id` BIGINT COMMENT 'Foreign key linking to facility.unit. Business justification: Automated dispensing cabinets (Pyxis/Omnicell) are unit-based; unit-level par management, controlled substance accountability reports, and unit-level drug shortage management are standard hospital pha',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_contract. Business justification: Pharmacy inventory items are procured under specific GPO/vendor contracts governing pricing and substitution rights. Linking inventory to vendor_contract enables contract utilization reporting, GPO co',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Pharmacy inventory must track which vendor supplies each drug. Currently has manufacturer_name as text, but vendor relationship provides complete vendor details (contact, terms, status). Normalizes ve',
    `average_daily_usage` DECIMAL(18,2) COMMENT 'The calculated average quantity of this medication dispensed per day over a rolling period (typically 30, 60, or 90 days). Used for demand forecasting and reorder calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this inventory record was first created in the source system.',
    `cycle_count_variance` DECIMAL(18,2) COMMENT 'The difference between the system quantity and physical count from the last cycle count (positive indicates overage, negative indicates shortage).',
    `days_supply_on_hand` STRING COMMENT 'The estimated number of days the current on-hand quantity will last based on average daily usage. Used for inventory planning and shortage prevention.',
    `dea_schedule` STRING COMMENT 'The DEA controlled substance schedule classification (I, II, III, IV, V, or non-controlled) indicating the drugs potential for abuse and regulatory requirements.. Valid values are `I|II|III|IV|V|non-controlled`',
    `expiration_date` DATE COMMENT 'The date beyond which the medication should not be used, as determined by the manufacturer. Critical for patient safety and waste management.',
    `high_alert_medication` BOOLEAN COMMENT 'Flag indicating whether this medication is classified as high-alert by ISMP, requiring additional safety precautions due to increased risk of significant patient harm if used in error.',
    `inventory_status` STRING COMMENT 'The current disposition of the inventory (active/available, quarantined pending quality review, recalled by manufacturer or FDA, expired, damaged, reserved for specific patient or procedure).. Valid values are `active|quarantined|recalled|expired|damaged|reserved`',
    `last_cycle_count_date` DATE COMMENT 'The date when the most recent physical inventory cycle count was performed for this item at this location.',
    `last_dispensed_date` DATE COMMENT 'The date when this medication was most recently dispensed from this location for patient administration or transfer.',
    `last_receipt_date` DATE COMMENT 'The date when inventory was most recently received into this location from purchasing or transfer.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this inventory record was most recently modified in the source system.',
    `lot_number` STRING COMMENT 'The manufacturer-assigned lot or batch number for traceability and recall management.',
    `ndc` STRING COMMENT 'The 11-digit National Drug Code uniquely identifying the drug product, including labeler, product, and package size. Primary drug identifier per FDA standards.. Valid values are `^[0-9]{11}$|^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `par_level` DECIMAL(18,2) COMMENT 'The target maximum inventory level for this medication at this location. Used to optimize inventory investment and storage space.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'The current physical count of medication units available in this location. Measured in the unit of measure specified.',
    `quarantine_reason` STRING COMMENT 'The reason this inventory is quarantined if inventory_status is quarantined (e.g., pending quality review, temperature excursion, damaged packaging, recall investigation).',
    `recall_number` STRING COMMENT 'The FDA or manufacturer recall identification number if this lot is subject to a recall.',
    `reorder_point` DECIMAL(18,2) COMMENT 'The minimum inventory level that triggers a replenishment order. Used to prevent stockouts and ensure medication availability.',
    `shortage_indicator` BOOLEAN COMMENT 'Flag indicating whether this medication is currently on the FDA drug shortage list or experiencing supply chain disruption.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The date and time when this inventory snapshot was captured. Used to track inventory levels over time and support historical analysis.',
    `source_system` STRING COMMENT 'The operational system of record from which this inventory record was sourced (Epic Willow, Cerner PharmNet, Infor Lawson Supply Chain).. Valid values are `Epic Willow|Cerner PharmNet|Infor Lawson`',
    `storage_requirements` STRING COMMENT 'Special storage conditions required for this medication (e.g., refrigeration 2-8°C, room temperature, protect from light, controlled room temperature).',
    `total_value` DECIMAL(18,2) COMMENT 'The total dollar value of the on-hand quantity (quantity_on_hand × unit_cost). Used for financial reporting and asset management.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The acquisition cost per unit of measure. Used for inventory valuation, budgeting, and financial reporting.',
    `unit_of_measure` STRING COMMENT 'The unit in which inventory quantity is tracked (each, tablet, capsule, vial, ampule, bottle, tube, box, milliliter, liter, gram, milligram). [ENUM-REF-CANDIDATE: each|tablet|capsule|vial|ampule|bottle|tube|box|mL|L|g|mg — 12 candidates stripped; promote to reference product]',
    CONSTRAINT pk_inventory PRIMARY KEY(`inventory_id`)
) COMMENT 'Real-time and periodic snapshot of medication inventory levels and movement history across all pharmacy locations including inpatient, outpatient, and automated dispensing cabinets. Captures drug NDC, location, on-hand quantity, reorder point, par level, lot number, expiration date, unit cost, inventory status (active/quarantined/recalled/expired), shortage indicators, and transaction history (receipts, returns, waste, transfers, cycle count adjustments). Supports medication availability, drug shortage management, supply chain integration, waste reduction, and full inventory audit trail. Sourced from Epic Willow and Cerner PharmNet.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ADD CONSTRAINT `fk_pharmacy_formulary_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`formulary`(`formulary_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ADD CONSTRAINT `fk_pharmacy_prescription_original_prescription_id` FOREIGN KEY (`original_prescription_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ADD CONSTRAINT `fk_pharmacy_dispense_event_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ADD CONSTRAINT `fk_pharmacy_mar_record_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_dispense_event_id` FOREIGN KEY (`dispense_event_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`dispense_event`(`dispense_event_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_mar_record_id` FOREIGN KEY (`mar_record_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`mar_record`(`mar_record_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ADD CONSTRAINT `fk_pharmacy_adverse_drug_event_prescription_id` FOREIGN KEY (`prescription_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`prescription`(`prescription_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_drug_master_id` FOREIGN KEY (`drug_master_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`drug_master`(`drug_master_id`);
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ADD CONSTRAINT `fk_pharmacy_inventory_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `healthcare_ecm`.`pharmacy`.`formulary`(`formulary_id`);

-- ========= TAGS =========
ALTER SCHEMA `healthcare_ecm`.`pharmacy` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `healthcare_ecm`.`pharmacy` SET TAGS ('dbx_domain' = 'pharmacy');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` SET TAGS ('dbx_subdomain' = 'medication_catalog');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Required Training Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Active Status');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Discontinued|Recalled');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `beyond_use_date_hours` SET TAGS ('dbx_business_glossary_term' = 'Beyond Use Date Hours');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `black_box_warning_flag` SET TAGS ('dbx_business_glossary_term' = 'Black Box Warning Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Drug Name');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `controlled_substance_indicator` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Indicator');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Non-Controlled');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `discontinuation_reason` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Reason');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `drug_class` SET TAGS ('dbx_business_glossary_term' = 'Drug Classification');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `fda_application_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Application Number');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `fda_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Approval Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `generic_name` SET TAGS ('dbx_business_glossary_term' = 'Generic Drug Name');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `geriatric_dosing_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Geriatric Dosing Adjustment Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `hazardous_drug_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Drug Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `hepatic_dosing_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Hepatic Dosing Adjustment Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `ismp_high_alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Institute for Safe Medication Practices (ISMP) High-Alert Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `lactation_risk_category` SET TAGS ('dbx_business_glossary_term' = 'Lactation Risk Category');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `lasa_drug_pairs` SET TAGS ('dbx_business_glossary_term' = 'Look-Alike Sound-Alike (LASA) Drug Pairs');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `lasa_indicator` SET TAGS ('dbx_business_glossary_term' = 'Look-Alike Sound-Alike (LASA) Indicator');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `light_sensitive_flag` SET TAGS ('dbx_business_glossary_term' = 'Light Sensitive Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `manufacturer_labeler_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Labeler Code');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `multi_dose_vial_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-Dose Vial Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `pediatric_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Pediatric Approved Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `pregnancy_category` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Category');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `refrigeration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Refrigeration Required Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `rems_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Required Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `renal_dosing_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Renal Dosing Adjustment Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `rxnorm_code` SET TAGS ('dbx_business_glossary_term' = 'RxNorm Code');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `storage_temperature_range` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Range');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Strength');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `tall_man_lettering` SET TAGS ('dbx_business_glossary_term' = 'Tall Man Lettering');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `therapeutic_category` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Category');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`drug_master` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` SET TAGS ('dbx_subdomain' = 'medication_catalog');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary ID');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug ID');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `service_id` SET TAGS ('dbx_business_glossary_term' = 'Service Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `age_restriction_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Restriction');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `age_restriction_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Restriction');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `clinical_review_required` SET TAGS ('dbx_business_glossary_term' = 'Clinical Review Required');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Controlled Substance Schedule');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V|non_controlled');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'covered|not_covered|conditional|restricted');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `days_supply_limit` SET TAGS ('dbx_business_glossary_term' = 'Days Supply Limit');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Formulary Effective Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Formulary Expiration Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `formulary_name` SET TAGS ('dbx_business_glossary_term' = 'Formulary Name');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Entry Status');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `formulary_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|archived');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_value_regex' = 'tier_1_preferred_generic|tier_2_generic|tier_3_preferred_brand|tier_4_non_preferred_brand|tier_5_specialty|not_covered');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `formulary_type` SET TAGS ('dbx_business_glossary_term' = 'Formulary Type');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `formulary_type` SET TAGS ('dbx_value_regex' = 'commercial|medicare_part_d|medicaid|exchange|employer_group|specialty');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_business_glossary_term' = 'Gender Restriction');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_value_regex' = 'male|female|all|not_specified');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `gender_restriction` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `generic_substitution_allowed` SET TAGS ('dbx_business_glossary_term' = 'Generic Substitution Allowed');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `mail_order_eligible` SET TAGS ('dbx_business_glossary_term' = 'Mail Order Eligible');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Formulary Notes');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `pharmacy_network_restriction` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Network Restriction');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `pharmacy_network_restriction` SET TAGS ('dbx_value_regex' = 'preferred_network|standard_network|specialty_pharmacy_only|all_networks');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `prior_authorization_criteria` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Criteria');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Required');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `quantity_limit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `quantity_limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Unit of Measure');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `refill_limit` SET TAGS ('dbx_business_glossary_term' = 'Refill Limit');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `specialty_drug_indicator` SET TAGS ('dbx_business_glossary_term' = 'Specialty Drug Indicator');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `step_therapy_protocol` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Protocol');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `therapeutic_alternative_available` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Alternative Available');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `therapeutic_class_code` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Class Code');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`formulary` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Formulary Version');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Identifier');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Authorization Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `coverage_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Indication Icd Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Lab Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `original_prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Original Prescription Identifier');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `original_prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `original_prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Npi Registry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Identifier');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prior_auth_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Auth Rule Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `susceptibility_result_id` SET TAGS ('dbx_business_glossary_term' = 'Susceptibility Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter Identifier');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `daw_code` SET TAGS ('dbx_business_glossary_term' = 'Dispense As Written (DAW) Code');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `days_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Supply');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|non-controlled');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `discontinuation_reason` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Reason');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `drug_strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Strength');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `epcs_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Prescribing of Controlled Substances (EPCS) Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `erx_transmission_status` SET TAGS ('dbx_business_glossary_term' = 'Electronic Prescription (eRx) Transmission Status');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `erx_transmission_status` SET TAGS ('dbx_value_regex' = 'transmitted|pending|failed|not-transmitted|acknowledged|rejected');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `erx_transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Electronic Prescription (eRx) Transmission Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `medication_name` SET TAGS ('dbx_business_glossary_term' = 'Medication Name');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `pharmacy_notes` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Notes');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescriber_dea_number` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Drug Enforcement Administration (DEA) Number');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescriber_dea_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescriber_dea_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescriber_notes` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Notes');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_date` SET TAGS ('dbx_business_glossary_term' = 'Prescription Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_number` SET TAGS ('dbx_business_glossary_term' = 'Prescription Number');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_number` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_business_glossary_term' = 'Prescription Status');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Prescription Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_timestamp` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_type` SET TAGS ('dbx_business_glossary_term' = 'Prescription Type');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_type` SET TAGS ('dbx_value_regex' = 'new|refill|renewal|transfer-in|transfer-out|change');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prescription_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `prior_authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `quantity_prescribed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Prescribed');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `refills_authorized` SET TAGS ('dbx_business_glossary_term' = 'Refills Authorized');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `refills_remaining` SET TAGS ('dbx_business_glossary_term' = 'Refills Remaining');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `sig` SET TAGS ('dbx_business_glossary_term' = 'Sig (Directions for Use)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`prescription` ALTER COLUMN `substitution_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Allowed Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` SET TAGS ('dbx_subdomain' = 'dispensing_operations');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `inventory_location_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Inventory Location Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Location Care Site Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacist Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Npi Registry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Rems Training Completion Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `controlled_substance_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Tracking Number');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `controlled_substance_tracking_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `days_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Supply');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|non_controlled');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `dispense_status` SET TAGS ('dbx_business_glossary_term' = 'Dispense Status');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `dispense_status` SET TAGS ('dbx_value_regex' = 'completed|partial|cancelled|on_hold|stopped|entered_in_error');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `dispense_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispense Date and Time');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `dispense_type` SET TAGS ('dbx_business_glossary_term' = 'Dispense Type');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `dispense_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|retail|specialty|mail_order|emergency');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `dispensed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Dispensed Quantity');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `dispensing_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Fee Amount');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Medication Expiration Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `fill_number` SET TAGS ('dbx_business_glossary_term' = 'Fill Number');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `insurance_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Paid Amount');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `medication_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Medication Cost Amount');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$|^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `patient_counseling_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Counseling Completed Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `patient_counseling_declined_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Counseling Declined Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `patient_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Pay Amount');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `prescriber_dea_number` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Drug Enforcement Administration (DEA) Number');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `prescriber_dea_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `prescriber_dea_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_written_date` SET TAGS ('dbx_business_glossary_term' = 'Prescription Written Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_written_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `prescription_written_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `refills_remaining` SET TAGS ('dbx_business_glossary_term' = 'Refills Remaining');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `sig_text` SET TAGS ('dbx_business_glossary_term' = 'Sig (Signatura) Text');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `source_system_dispense_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Dispense Identifier (ID)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `substitution_made_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Made Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `substitution_reason` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `verifying_pharmacist_npi` SET TAGS ('dbx_business_glossary_term' = 'Verifying Pharmacist National Provider Identifier (NPI)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`dispense_event` ALTER COLUMN `verifying_pharmacist_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` SET TAGS ('dbx_subdomain' = 'patient_safety');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `mar_record_id` SET TAGS ('dbx_business_glossary_term' = 'Medication Administration Record (MAR) Record ID');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Provider Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Administration Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispense Event Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `imaging_order_id` SET TAGS ('dbx_business_glossary_term' = 'Imaging Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `or_suite_id` SET TAGS ('dbx_business_glossary_term' = 'Or Suite Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Result Based Test Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Standing Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Verifying Pharmacist Npi Registry Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Visit ID');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `actual_administration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Administration Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `administration_method` SET TAGS ('dbx_business_glossary_term' = 'Administration Method');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `administration_site` SET TAGS ('dbx_business_glossary_term' = 'Administration Site');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `administration_status` SET TAGS ('dbx_business_glossary_term' = 'Administration Status');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `administration_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Administration Status Reason');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `barcode_scan_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Barcode Scan Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|non-controlled');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `documentation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Documentation Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `dose_given` SET TAGS ('dbx_business_glossary_term' = 'Dose Given');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `dose_unit` SET TAGS ('dbx_business_glossary_term' = 'Dose Unit of Measure');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Medication Expiration Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `infusion_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Infusion Duration in Minutes');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `infusion_rate` SET TAGS ('dbx_business_glossary_term' = 'Infusion Rate');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `infusion_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Infusion Rate Unit of Measure');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `infusion_rate_unit` SET TAGS ('dbx_value_regex' = 'mL/hr|mL/min|units/hr|mcg/kg/min|mg/hr');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `is_first_dose` SET TAGS ('dbx_business_glossary_term' = 'Is First Dose Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `is_stat_order` SET TAGS ('dbx_business_glossary_term' = 'Is Stat Order Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Medication Lot Number');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `medication_ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `medication_ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{4,5}-[0-9]{3,4}-[0-9]{1,2}$');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `patient_response` SET TAGS ('dbx_business_glossary_term' = 'Patient Response');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `pharmacy_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Verification Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `prn_indication` SET TAGS ('dbx_business_glossary_term' = 'Pro Re Nata (PRN) Indication');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `route` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `scheduled_administration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Administration Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Epic ClinDoc|Epic Willow|Cerner PharmNet|Cerner PowerChart|MEDITECH');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `waste_amount` SET TAGS ('dbx_business_glossary_term' = 'Waste Amount');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `waste_unit` SET TAGS ('dbx_business_glossary_term' = 'Waste Unit of Measure');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `witness_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Provider Name');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `witness_provider_npi` SET TAGS ('dbx_business_glossary_term' = 'Witness Provider National Provider Identifier (NPI)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`mar_record` ALTER COLUMN `witness_provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` SET TAGS ('dbx_subdomain' = 'patient_safety');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `adverse_drug_event_id` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) ID');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `clinical_order_id` SET TAGS ('dbx_business_glossary_term' = 'Causative Clinical Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `contrast_admin_id` SET TAGS ('dbx_business_glossary_term' = 'Causative Contrast Admin Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `dispense_event_id` SET TAGS ('dbx_business_glossary_term' = 'Causative Dispense Event Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Causative Drug Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `mar_record_id` SET TAGS ('dbx_business_glossary_term' = 'Causative Mar Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Causative Prescription Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Confirming Test Result Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `lab_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laboratory Lab Order Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Mpi Record Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Policy Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Reporter Clinician Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Clinical Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Resulting Visit Diagnosis Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `visit_diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `visit_id` SET TAGS ('dbx_business_glossary_term' = 'Encounter ID');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `adverse_drug_event_status` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Status');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `adverse_drug_event_status` SET TAGS ('dbx_value_regex' = 'reported|under_investigation|investigation_complete|closed');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `causative_drug_ndc` SET TAGS ('dbx_business_glossary_term' = 'Causative Drug National Drug Code (NDC)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `causative_drug_ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{4,5}-[0-9]{3,4}-[0-9]{1,2}$');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Taken');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'clinical_observation|patient_report|laboratory_result|automated_alert|chart_review|pharmacy_review');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `event_date` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Description');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Number');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Type');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `fda_report_number` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Report Number');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `harm_category` SET TAGS ('dbx_business_glossary_term' = 'National Coordinating Council for Medication Error Reporting and Prevention (NCC MERP) Harm Category');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `intervention_description` SET TAGS ('dbx_business_glossary_term' = 'Intervention Description');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `intervention_required` SET TAGS ('dbx_business_glossary_term' = 'Intervention Required Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `ismp_report_number` SET TAGS ('dbx_business_glossary_term' = 'Institute for Safe Medication Practices (ISMP) Report Number');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Outcome');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'recovered|recovering|not_recovered|fatal|unknown');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `pharmacy_review_date` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy and Therapeutics (P&T) Committee Review Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `preventability_assessment` SET TAGS ('dbx_business_glossary_term' = 'Preventability Assessment');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `preventability_assessment` SET TAGS ('dbx_value_regex' = 'preventable|probably_preventable|not_preventable|unknown');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `reported_to_fda` SET TAGS ('dbx_business_glossary_term' = 'Reported to Food and Drug Administration (FDA) Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `reported_to_ismp` SET TAGS ('dbx_business_glossary_term' = 'Reported to Institute for Safe Medication Practices (ISMP) Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `reporter_role` SET TAGS ('dbx_business_glossary_term' = 'Reporter Role');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `root_cause_analysis_performed` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Performed Flag');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `root_cause_findings` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Findings');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Adverse Drug Event (ADE) Severity Level');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|life_threatening|fatal');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`adverse_drug_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` SET TAGS ('dbx_subdomain' = 'medication_catalog');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Identifier');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `ndc_drug_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Drug Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `average_daily_usage` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Usage');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `cycle_count_variance` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Variance');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `days_supply_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Days Supply On Hand');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|non-controlled');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `high_alert_medication` SET TAGS ('dbx_business_glossary_term' = 'High Alert Medication');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|quarantined|recalled|expired|damaged|reserved');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `last_dispensed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Dispensed Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `last_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Receipt Date');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `ndc` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$|^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Par Level');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `quarantine_reason` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Reason');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `shortage_indicator` SET TAGS ('dbx_business_glossary_term' = 'Shortage Indicator');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Epic Willow|Cerner PharmNet|Infor Lawson');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `storage_requirements` SET TAGS ('dbx_business_glossary_term' = 'Storage Requirements');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `healthcare_ecm`.`pharmacy`.`inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
