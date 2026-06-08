-- Schema for Domain: market | Business: Pharmaceuticals | Version: v1_ecm
-- Generated on: 2026-05-05 17:50:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`market` COMMENT 'Coordinates market access, pricing, reimbursement, and payer relations. Manages formulary positioning, health technology assessment (HTA) submissions, value dossiers, contracting with payers, pharmacy benefit managers (PBM), and group purchasing organizations (GPO). Tracks reimbursement policies, coverage decisions, patient access programs, copay assistance, and gross-to-net revenue management. Owns RWE and RWD assets used for payer negotiations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` (
    `access_strategy_id` BIGINT COMMENT 'Unique system-generated identifier for the market access strategy record. Serves as the primary key for this entity.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Access strategies require budget allocation for HTA submissions, RWE studies, patient support programs, and payer engagement activities. Market access teams must track spend against approved budgets f',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Access strategies are country-specific, requiring regulatory authority names, HTA body details, reimbursement frameworks, and market access tier classifications for strategic planning and submission p',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Access strategies depend on regulatory exclusivity (orphan, pediatric, data) to determine market entry barriers, competitive landscape, and reimbursement positioning. Exclusivity periods directly info',
    `indication_id` BIGINT COMMENT 'Reference to the specific therapeutic indication or disease area for which this access strategy applies, enabling indication-level access differentiation.',
    `master_id` BIGINT COMMENT 'Foreign key linking to hcp.hcp_master. Business justification: Access strategies target specific KOL physicians for advocacy, advisory boards, and peer influence. Market access teams identify and engage key physicians to support formulary positioning and HTA subm',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (drug product or biologic) for which this market access strategy is defined.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Access strategies must reference patent protection to align launch timing with exclusivity windows, inform pricing negotiations, and plan LOE transitions. Market access teams require patent expiry dat',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Market access strategies must operate within compliance programs governing promotional activities, transparency reporting (Sunshine Act/EFPIA), and anti-kickback rules. Compliance oversight is mandato',
    `access_barrier_severity` STRING COMMENT 'Overall severity rating of the identified access barriers for this strategy: low (minor hurdles), medium (manageable barriers), high (significant barriers requiring targeted remediation), or critical (barriers that may prevent market access).. Valid values are `low|medium|high|critical`',
    `access_barrier_summary` STRING COMMENT 'Narrative summary of the primary identified access barriers for this product in the target geography and payer segment (e.g., lack of comparative clinical evidence, high ICER, step therapy requirements, prior authorization burden). Confidential strategic content.',
    `access_objective` STRING COMMENT 'Overarching strategic access objective statement for this product in the target geography and payer segment (e.g., Achieve preferred formulary tier 1 placement in 80% of commercial plans within 12 months of launch). Confidential strategic business information.',
    `actual_launch_date` DATE COMMENT 'Actual date on which the product was commercially launched in the specified geography and payer segment. Compared against planned_launch_date to measure launch execution performance.',
    `approval_date` DATE COMMENT 'Date on which this market access strategy was formally approved by the designated approver. Marks the transition from under_review to approved lifecycle status.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the senior leader (e.g., VP Market Access, Chief Commercial Officer) who formally approved this access strategy.',
    `copay_assistance_flag` BOOLEAN COMMENT 'Indicates whether a copay assistance or copay card program is included in this access strategy to reduce patient out-of-pocket costs and improve commercial insurance access.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this market access strategy record was first created in the system. Used for audit trail and data lineage tracking in compliance with 21 CFR Part 11 and SOX requirements.',
    `effective_from_date` DATE COMMENT 'Date from which this market access strategy becomes operative and binding for downstream access activities including HTA submissions, payer contracting, and patient support programs.',
    `effective_until_date` DATE COMMENT 'Date on which this market access strategy expires or is superseded. Nullable for open-ended strategies. Used to manage strategy lifecycle and trigger renewal workflows.',
    `gross_to_net_target_pct` DECIMAL(18,2) COMMENT 'Target gross-to-net revenue reduction percentage for this access strategy, representing the expected aggregate discount, rebate, and allowance burden relative to gross list price. Critical for P&L planning and net revenue forecasting. Confidential financial data.',
    `heor_study_plan` STRING COMMENT 'Summary of the Health Economics and Outcomes Research (HEOR) study plan, including cost-effectiveness models, budget impact analyses, and quality-of-life studies planned to support payer value dossiers and HTA submissions. Confidential strategic content.',
    `hta_body_code` STRING COMMENT 'Code identifying the primary HTA body responsible for evaluating this product in the target geography (e.g., NICE, G-BA, HAS, PBAC, CADTH, AIFA). [ENUM-REF-CANDIDATE: NICE|G-BA|HAS|PBAC|CADTH|AIFA|SMC|NCPE|TLV|ZIN — promote to reference product]',
    `hta_outcome` STRING COMMENT 'Outcome of the HTA review by the primary HTA body: pending (under review), positive (recommended), positive_with_restriction (recommended with clinical/population restrictions), negative (not recommended), withdrawn (submission withdrawn), or not_applicable.. Valid values are `pending|positive|positive_with_restriction|negative|withdrawn|not_applicable`',
    `hta_strategy` STRING COMMENT 'Description of the Health Technology Assessment (HTA) strategy including target HTA bodies (e.g., NICE, G-BA, HAS, PBAC), submission sequencing, evidence package approach, and comparator selection rationale. Confidential strategic content.',
    `hta_submission_actual_date` DATE COMMENT 'Actual date on which the HTA dossier was submitted to the primary HTA body. Compared against hta_submission_planned_date to track submission timeliness.',
    `hta_submission_planned_date` DATE COMMENT 'Planned date for submission of the HTA dossier or value dossier to the primary HTA body. Used for launch sequencing and access readiness milestone tracking.',
    `icer_threshold_amount` DECIMAL(18,2) COMMENT 'Payer or HTA body willingness-to-pay threshold per quality-adjusted life year (QALY) or other health outcome unit in the target geography. Used to assess pricing headroom and value-based pricing strategy. Confidential strategic financial data.',
    `icer_threshold_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the ICER willingness-to-pay threshold applicable in the target geography (e.g., GBP for NICE, EUR for G-BA/HAS, USD for ICER US).. Valid values are `^[A-Z]{3}$`',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the access strategy document: draft (being authored), under_review (in approval workflow), approved (signed off), active (being executed), on_hold (paused), superseded (replaced by a newer version), or retired (no longer applicable). [ENUM-REF-CANDIDATE: draft|under_review|approved|active|on_hold|superseded|retired — 7 candidates stripped; promote to reference product]',
    `list_price_amount` DECIMAL(18,2) COMMENT 'Gross list price (WAC — Wholesale Acquisition Cost in the US, or equivalent list price in other geographies) for the product in the target geography. Confidential commercial pricing data.',
    `list_price_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the gross list price of the product in the target geography (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `patient_support_program_flag` BOOLEAN COMMENT 'Indicates whether a patient support program (copay assistance, patient assistance program, hub services) is included as a component of this access strategy to improve patient access and adherence.',
    `payer_segment` STRING COMMENT 'Specific payer segment or channel targeted by this access strategy (e.g., Commercial, Medicare Part D, Medicaid, VA/DoD, Private Insurance, NHS, Statutory Health Insurance). [ENUM-REF-CANDIDATE: Commercial|Medicare Part D|Medicaid|VA/DoD|NHS|Statutory Health Insurance|Private Insurance|Integrated Delivery Network — promote to reference product]',
    `planned_launch_date` DATE COMMENT 'Target date for commercial product launch in the specified geography and payer segment, as defined in the launch sequencing plan. Drives milestone planning and access readiness timelines.',
    `reimbursement_pathway` STRING COMMENT 'Regulatory and payer reimbursement pathway pursued for this product: standard (routine formulary review), accelerated (expedited review), managed_entry (conditional coverage), risk_sharing (payer-manufacturer risk agreement), outcomes_based (payment linked to clinical outcomes), named_patient, or compassionate_use. [ENUM-REF-CANDIDATE: standard|accelerated|managed_entry|risk_sharing|outcomes_based|named_patient|compassionate_use — 7 candidates stripped; promote to reference product]',
    `remediation_plan` STRING COMMENT 'Description of planned remediation actions to address identified access barriers, including evidence generation plans, payer engagement activities, managed entry agreement negotiations, and patient support program design. Confidential strategic content.',
    `rwe_rwd_plan` STRING COMMENT 'Description of the Real-World Evidence (RWE) and Real-World Data (RWD) generation plan supporting payer negotiations, HTA submissions, and outcomes-based contracting. Includes study designs, data sources, and timelines. Confidential strategic content.',
    `strategy_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the access strategy, used in cross-functional communications, HTA submissions, and payer contracting documents. Format: MAS-<ProductCode>-<Year>.. Valid values are `^MAS-[A-Z0-9]{4,12}-[0-9]{4}$`',
    `strategy_name` STRING COMMENT 'Human-readable name of the market access strategy, typically including the product name, indication, and geography (e.g., Oncology Product X — US Formulary Access Strategy 2025).',
    `strategy_owner` STRING COMMENT 'Name or employee identifier of the Market Access lead or director accountable for developing and executing this access strategy.',
    `strategy_type` STRING COMMENT 'Classification of the access strategy by its business purpose: launch (initial market entry), lifecycle (ongoing management), indication_expansion (new indication), line_extension (new formulation/dosage), or biosimilar_defense (protecting market share against biosimilar entry).. Valid values are `launch|lifecycle|indication_expansion|line_extension|biosimilar_defense`',
    `strategy_version` STRING COMMENT 'Version number of the access strategy document following major.minor versioning convention (e.g., 1.0, 2.3). Supports document lifecycle management and audit trail requirements.. Valid values are `^[0-9]+.[0-9]+$`',
    `target_formulary_tier` STRING COMMENT 'Desired formulary tier placement targeted by this access strategy for the specified payer segment. Tier 1 represents preferred/lowest cost-share; specialty and non_formulary represent restricted access positions.. Valid values are `tier_1|tier_2|tier_3|tier_4|specialty|non_formulary`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this market access strategy record was last modified. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks Silver layer.',
    `value_proposition` STRING COMMENT 'Narrative summary of the clinical, economic, and humanistic value proposition communicated to payers and HTA bodies to justify formulary placement and reimbursement. Confidential strategic content.',
    CONSTRAINT pk_access_strategy PRIMARY KEY(`access_strategy_id`)
) COMMENT 'Master record defining the market access strategy for a pharmaceutical product in a given geography or payer segment. Captures overarching access objectives, value proposition, target formulary tier, reimbursement pathway, HTA strategy, launch sequencing plan, identified access barriers with severity and remediation actions, key access milestones with planned and actual dates, and milestone status tracking. Serves as the strategic anchor for all downstream access activities including HTA submissions, payer contracting, patient support programs, and systematic access gap management.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`payer_account` (
    `payer_account_id` BIGINT COMMENT 'Unique surrogate identifier for the payer account record within the market access domain. Serves as the primary key and system-of-record identifier for all downstream joins and references.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal market access account manager or payer relations director responsible for managing the relationship with this payer. Maps to the HR employee master for accountability and CRM ownership.',
    `parent_payer_account_id` BIGINT COMMENT 'Self-referencing identifier pointing to the parent payer organization in a payer hierarchy (e.g., a regional health plan rolling up to a national parent). Enables hierarchical covered-lives aggregation and enterprise-level contracting.',
    `third_party_due_diligence_id` BIGINT COMMENT 'Foreign key linking to compliance.third_party_due_diligence. Business justification: Payer accounts are third parties requiring anti-bribery and corruption (ABAC) due diligence, sanctions screening, and debarment checks before contracting. Linking payers to due diligence records ensur',
    `account_status` STRING COMMENT 'Current lifecycle status of the payer account record. Drives eligibility for contracting, rebate processing, and formulary negotiations. Active accounts are eligible for all market access activities.. Valid values are `active|inactive|pending|suspended|terminated`',
    `cms_payer_code` STRING COMMENT 'Official CMS-assigned payer identifier used in Medicare and Medicaid claims processing and enrollment data. Enables cross-referencing with CMS plan finder, Part D enrollment, and government reimbursement data.. Valid values are `^[A-Z0-9]{5,15}$`',
    `contract_type` STRING COMMENT 'Type of commercial arrangement governing the relationship with this payer. Determines the financial model for gross-to-net deductions and market access obligations.. Valid values are `rebate|fee_for_service|value_based|capitation|net_price`',
    `contracting_authority` BOOLEAN COMMENT 'Indicates whether this payer account holds direct contracting authority (True) or operates under a parent/umbrella contract managed by another payer entity. Determines whether a direct rebate or pricing agreement can be executed.',
    `copay_accumulator_policy` BOOLEAN COMMENT 'Indicates whether this payer has implemented a copay accumulator adjustment program that prevents manufacturer copay assistance from counting toward patient deductibles and out-of-pocket maximums. Impacts gross-to-net and patient affordability.',
    `copay_assistance_accepted` BOOLEAN COMMENT 'Indicates whether this payer accepts manufacturer copay assistance cards or patient support programs for its commercially insured members. Government payers (Medicare, Medicaid) are prohibited from accepting copay assistance under Anti-Kickback Statute.',
    `covered_lives` BIGINT COMMENT 'Total number of beneficiaries or members covered under the payers health plan(s). Key metric for assessing payer reach and prioritizing market access investment. Sourced from CMS enrollment data or payer-reported figures.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payer account record was first created in the system. Supports audit trail, data lineage, and 21 CFR Part 11 electronic records compliance.',
    `effective_date` DATE COMMENT 'Date on which this payer account became active and eligible for market access activities, contracting, and formulary engagement. Marks the start of the formal payer relationship.',
    `formulary_decision_cycle` STRING COMMENT 'Frequency at which the payers pharmacy and therapeutics (P&T) committee reviews and updates formulary coverage decisions. Critical for planning HTA submission and contracting timelines.. Valid values are `annual|semi_annual|quarterly|rolling|ad_hoc`',
    `formulary_influence_score` DECIMAL(18,2) COMMENT 'Proprietary numeric score (0–100) reflecting the payers ability to drive formulary adoption and steer prescribing behavior across its covered lives. Used in payer prioritization and contracting strategy.',
    `formulary_tier_position` STRING COMMENT 'Current formulary tier placement of the companys lead product(s) on this payers formulary. Reflects the outcome of market access negotiations and directly impacts patient access and copay levels.. Valid values are `preferred_brand|non_preferred_brand|specialty|generic|excluded|not_listed`',
    `geographic_coverage_scope` STRING COMMENT 'Scope of the payers geographic coverage indicating whether the plan operates nationally, regionally, at state/province level, locally, or across multiple countries. Informs market access strategy and contracting jurisdiction.. Valid values are `national|regional|state|local|multinational`',
    `gpo_membership` STRING COMMENT 'Name of the Group Purchasing Organization (GPO) to which this payer or its affiliated health system belongs (e.g., Vizient, Premier, HealthTrust). Relevant for hospital and institutional formulary contracting.',
    `hq_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the payer organizations primary headquarters location (e.g., USA, GBR, DEU). Determines applicable regulatory framework, pricing regulations, and reimbursement authority.. Valid values are `^[A-Z]{3}$`',
    `hta_body` STRING COMMENT 'Name of the Health Technology Assessment (HTA) body associated with this payers reimbursement decision-making process (e.g., NICE, HAS, G-BA, AIFA, SMC). Drives value dossier format and HEOR evidence requirements.',
    `last_contract_review_date` DATE COMMENT 'Date of the most recent formal contract or rebate agreement review with this payer. Used to track contracting cycle compliance and trigger renewal workflows.',
    `naic_code` STRING COMMENT 'Five-digit NAIC company code assigned to licensed insurance entities in the United States. Used for regulatory identification, state insurance filings, and cross-referencing with insurance regulatory databases.. Valid values are `^[0-9]{5}$`',
    `payer_account_code` STRING COMMENT 'Externally-known alphanumeric code assigned to the payer organization, used in contracting, SAP SD customer master, and Veeva CRM account records for cross-system reconciliation.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `payer_name` STRING COMMENT 'Full legal name of the payer organization as registered with regulatory or governmental authorities (e.g., UnitedHealthcare Insurance Company, Centers for Medicare & Medicaid Services). Used as the primary identity label for the payer.',
    `payer_subtype` STRING COMMENT 'Further granular classification within the payer type (e.g., Medicare Advantage, Medicaid Managed Care, Part D Plan Sponsor, NHS England, Statutory Health Insurer, PBM Formulary Manager). [ENUM-REF-CANDIDATE: medicare_advantage|medicaid_managed_care|part_d_sponsor|fee_for_service|nhs|statutory_health_insurer|pbm_formulary — promote to reference product]',
    `payer_type` STRING COMMENT 'Classification of the payer organization by business model. Drives contracting strategy, rebate structure, and market access approach. [ENUM-REF-CANDIDATE: commercial_health_plan|government_payer|pbm|gpo|integrated_delivery_network|managed_care_organization — promote to reference product]. Valid values are `commercial_health_plan|government_payer|pbm|gpo|integrated_delivery_network|managed_care_organization`',
    `pbm_affiliation` STRING COMMENT 'Name of the Pharmacy Benefit Manager (PBM) affiliated with or contracted by this payer to manage drug benefit administration, formulary design, and rebate negotiations (e.g., Express Scripts, CVS Caremark, OptumRx).',
    `primary_contact_email` STRING COMMENT 'Business email address of the primary contact at the payer organization. Used for contracting correspondence, formulary submission notifications, and market access communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the payer organization (e.g., Director of Pharmacy, VP of Formulary Management). Used for relationship management and contracting communications.',
    `primary_contact_phone` STRING COMMENT 'Business phone number of the primary contact at the payer organization. Used for direct payer relations outreach and contracting negotiations.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `primary_therapeutic_focus` STRING COMMENT 'The primary therapeutic area(s) or disease categories that the payers formulary and coverage policies emphasize (e.g., oncology, immunology, rare diseases, cardiovascular). Informs product-specific formulary positioning strategy.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether this payer requires prior authorization (PA) for coverage of the companys products. PA requirements create patient access barriers and are tracked for market access strategy and REMS compliance.',
    `pt_committee_meeting_month` STRING COMMENT 'Calendar month (1–12) in which the payers Pharmacy and Therapeutics (P&T) committee typically convenes for formulary review. Used to time value dossier submissions and contracting negotiations.',
    `rebate_eligible` BOOLEAN COMMENT 'Indicates whether this payer account is eligible to participate in pharmaceutical rebate programs. Drives gross-to-net revenue calculations and rebate contract eligibility in SAP SD.',
    `reimbursement_authority` STRING COMMENT 'Name of the governmental or statutory body that holds formal authority over reimbursement listing decisions for this payer (e.g., CMS, NHS England, GKV-Spitzenverband, CNAM). Distinct from HTA body which assesses clinical value.',
    `rwe_data_sharing_agreement` BOOLEAN COMMENT 'Indicates whether a Real-World Evidence (RWE) or Real-World Data (RWD) data sharing agreement is in place with this payer. RWE partnerships support value-based contracting, outcomes-based agreements, and payer negotiations.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether this payer mandates step therapy (fail-first) protocols before approving coverage of the companys products. Step therapy requirements are key barriers tracked in market access and patient support programs.',
    `termination_date` DATE COMMENT 'Date on which this payer account was terminated or deactivated. Null for currently active accounts. Used for historical reporting and gross-to-net reconciliation of closed payer relationships.',
    `tier` STRING COMMENT 'Strategic tier classification assigned by the market access team reflecting the payers relative importance based on covered lives, formulary influence, and revenue impact. Tier 1 represents highest-priority national accounts.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this payer account record. Supports change tracking, audit trail, and data quality monitoring in the Silver layer.',
    `value_based_contract_eligible` BOOLEAN COMMENT 'Indicates whether this payer has the infrastructure and willingness to enter into outcomes-based or value-based contracting arrangements. Drives HEOR evidence generation strategy and RWE data requirements.',
    CONSTRAINT pk_payer_account PRIMARY KEY(`payer_account_id`)
) COMMENT 'Master record for payer organizations including commercial health plans, government payers (Medicare, Medicaid, NHS, statutory health insurers), pharmacy benefit managers (PBMs), and group purchasing organizations (GPOs). Captures payer type, tier, covered lives, formulary influence, contracting authority, and geographic coverage. SSOT for payer identity within the market access domain.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` (
    `market_formulary_position_id` BIGINT COMMENT 'Unique surrogate identifier for a formulary position record representing the placement status of a pharmaceutical product within a specific payer formulary at a point in time.',
    `coverage_decision_id` BIGINT COMMENT 'Foreign key linking to market.coverage_decision. Business justification: Formulary positions are determined by coverage decisions. One formulary position results from one coverage decision (1:N from coverage_decision perspective). Column to remove: coverage_decision_date (',
    `drug_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (drug product or SKU) whose formulary placement is being tracked. Aligns to the commercial product master.',
    `formulary_id` BIGINT COMMENT 'Foreign key linking to market.formulary. Business justification: Market formulary positions track where a drug is placed within a specific formulary. Currently market_formulary_position has payer_account_id but no direct link to the formulary master table. Adding f',
    `formulary_listing_id` BIGINT COMMENT 'Reference to the specific formulary (drug benefit list) managed by the payer in which this product placement is tracked. A payer may maintain multiple formularies across plan types.',
    `market_payer_contract_id` BIGINT COMMENT 'Reference to the payer or PBM contract under which this formulary position was negotiated. Links formulary placement to rebate obligations and gross-to-net revenue commitments.',
    `payer_account_id` BIGINT COMMENT 'Reference to the payer organization (health plan, insurer, PBM, or government program) that owns and administers the formulary in which this position is recorded.',
    `pbm_id` BIGINT COMMENT 'Reference to the Pharmacy Benefit Manager (PBM) that administers the formulary on behalf of the payer. PBMs negotiate rebates, manage formulary placement, and adjudicate pharmacy claims.',
    `access_restriction_type` STRING COMMENT 'The primary type of utilization management restriction applied to this formulary position. Enables systematic access gap analysis and identification of patient access barriers across payer segments. [ENUM-REF-CANDIDATE: none|prior_auth|step_therapy|quantity_limit|specialty_pharmacy|age_restriction|diagnosis_restriction|combination — promote to reference product]',
    `atc_code` STRING COMMENT 'The WHO Anatomical Therapeutic Chemical (ATC) classification code assigned to the product. Used for formulary benchmarking, competitive landscape analysis, and cross-market access comparisons.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `coinsurance_rate` DECIMAL(18,2) COMMENT 'The patient coinsurance rate (expressed as a decimal, e.g., 0.20 for 20%) applicable to this formulary tier position. Used when the plan applies percentage-based cost-sharing rather than a fixed copay.',
    `copay_amount` DECIMAL(18,2) COMMENT 'The fixed patient copay amount in USD applicable to this formulary tier position. Used in gross-to-net revenue modeling and patient affordability analysis. Null if the plan uses coinsurance rather than a fixed copay.',
    `country_code` STRING COMMENT 'The ISO 3166-1 alpha-3 country code of the market in which this formulary position applies. Enables multi-market formulary access tracking and international gross-to-net revenue analysis.. Valid values are `^[A-Z]{3}$`',
    `data_source` STRING COMMENT 'The originating system or data feed from which this formulary position record was sourced. Supports data lineage tracking and reconciliation across Salesforce Health Cloud/Veeva CRM, PBM data feeds, and third-party market intelligence providers. [ENUM-REF-CANDIDATE: salesforce_crm|veeva_crm|payer_portal|pbm_feed|iqvia|symphony_health|manual_entry — 7 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'The date on which this formulary position becomes effective and the payer begins applying the associated coverage terms, tier placement, and utilization management requirements.',
    `formulary_position_code` STRING COMMENT 'Externally-known alphanumeric business identifier for this formulary position record, used in payer communications, contracting systems, and gross-to-net reconciliation workflows.. Valid values are `^FP-[A-Z0-9]{6,20}$`',
    `formulary_review_date` DATE COMMENT 'The scheduled or actual date of the next payer formulary review cycle for this product. Used by market access teams to plan payer engagement, evidence submissions, and contracting activities.',
    `hta_submission_status` STRING COMMENT 'The current status of the Health Technology Assessment (HTA) submission associated with this formulary position. HTA outcomes directly influence formulary tier placement and reimbursement decisions in markets such as the EU.. Valid values are `not_submitted|submitted|under_review|approved|rejected|resubmitted`',
    `lives_covered` BIGINT COMMENT 'The estimated number of covered lives (plan members) under the payer formulary associated with this position. Used to weight formulary access metrics and estimate revenue impact of tier placement changes.',
    `market_share_impact_pct` DECIMAL(18,2) COMMENT 'The estimated percentage of total addressable market share attributable to this formulary position, based on covered lives and payer segment weight. Used in market access scenario modeling and launch readiness assessments.',
    `ndc_code` STRING COMMENT 'The FDA-assigned National Drug Code (NDC) for the specific drug product package included on the formulary. Used for formulary file submissions and pharmacy claims adjudication.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `notes` STRING COMMENT 'Free-text field for market access team annotations regarding this formulary position, including payer negotiation context, clinical criteria nuances, or exceptions not captured in structured fields.',
    `patient_access_program_flag` BOOLEAN COMMENT 'Indicates whether a patient access program (e.g., copay assistance, free drug program, or patient support program) is available to offset patient cost-sharing for this formulary position. Relevant for access gap mitigation strategy.',
    `payer_segment` STRING COMMENT 'The market segment classification of the payer administering this formulary. Enables segmented gross-to-net revenue analysis and access gap reporting across commercial, government, and exchange channels.. Valid values are `commercial|medicare|medicaid|managed_medicaid|exchange|va_dod`',
    `plan_year` STRING COMMENT 'The benefit plan year (e.g., 2024) to which this formulary position applies. Payer formularies are typically updated annually and this field enables year-over-year access trend analysis.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether the payer requires prior authorization (PA) before the product will be covered under this formulary position. A value of True signals a utilization management barrier that may impact patient access.',
    `quantity_limit_days` STRING COMMENT 'The number of days supply over which the quantity_limit_value applies. For example, a limit of 30 units per 30 days. Enables precise modeling of dispensing restrictions for patient access programs.',
    `quantity_limit_flag` BOOLEAN COMMENT 'Indicates whether the payer imposes a quantity limit on dispensing of this product under this formulary position. When True, the quantity_limit_value and quantity_limit_days fields define the specific restriction.',
    `quantity_limit_value` DECIMAL(18,2) COMMENT 'The maximum quantity (in dispensing units) of the product that the payer will cover within the quantity limit period defined by quantity_limit_days. Used for access gap and utilization management analysis.',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'The contractually agreed rebate percentage (expressed as a decimal, e.g., 0.15 for 15%) payable to the payer or PBM for this formulary position. A key input to gross-to-net revenue calculations and P&L reporting.',
    `rebate_tier` STRING COMMENT 'The rebate tier designation associated with this formulary position as negotiated in the payer or PBM contract. Determines the rebate percentage or per-unit rebate amount owed to the payer in exchange for preferred formulary placement. [ENUM-REF-CANDIDATE: base|preferred|exclusive|performance|supplemental — promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this formulary position record was first created in the data platform. Supports audit trail requirements and data lineage tracking per 21 CFR Part 11 and SOX compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this formulary position record was last modified in the data platform. Enables change detection, incremental processing, and audit trail maintenance per 21 CFR Part 11 and SOX compliance.',
    `specialty_drug_flag` BOOLEAN COMMENT 'Indicates whether the payer classifies this product as a specialty drug under this formulary, which typically triggers specialty tier placement, specialty pharmacy channel requirements, and higher patient cost-sharing.',
    `specialty_pharmacy_required` BOOLEAN COMMENT 'Indicates whether the payer mandates dispensing through a designated specialty pharmacy network for this formulary position. Impacts patient access and distribution channel strategy.',
    `step_therapy_criteria` STRING COMMENT 'Narrative description of the step therapy requirements imposed by the payer, including which agents must be tried first and the duration or failure criteria required before this product is covered.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether the payer requires step therapy (fail-first protocol), meaning the patient must try and fail one or more alternative therapies before this product will be covered. A key access barrier metric.',
    `termination_date` DATE COMMENT 'The date on which this formulary position ceases to be effective. A null value indicates the position is currently active and open-ended. Used for point-in-time formulary access analysis.',
    `therapeutic_area` STRING COMMENT 'The therapeutic area classification of the product for which this formulary position applies (e.g., Oncology, Immunology, Rare Disease). Enables cross-portfolio formulary access analysis by disease area.',
    CONSTRAINT pk_market_formulary_position PRIMARY KEY(`market_formulary_position_id`)
) COMMENT 'Tracks the formulary placement status of a pharmaceutical product within a specific payer formulary at a point in time. Records formulary tier, prior authorization requirements, step therapy requirements, quantity limits, preferred/non-preferred status, and effective dates. Enables gross-to-net revenue modeling and access gap analysis across payer segments.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` (
    `hta_submission_id` BIGINT COMMENT 'Unique system-generated identifier for the HTA submission record. Serves as the primary key for the full lifecycle of a single HTA engagement from planning through decision.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: HTA submissions target specific country regulatory authorities and HTA bodies tracked in country master. Required for submission planning, regulatory compliance tracking, and reimbursement pathway det',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: HTA bodies evaluate regulatory exclusivity periods when assessing reimbursement value, budget impact over the protected timeframe, and managed entry agreement terms. Exclusivity data is mandatory in m',
    `indication_id` BIGINT COMMENT 'Reference to the specific therapeutic indication for which HTA is being sought. A single product may have multiple HTA submissions across different indications.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: HTA submissions are funded through internal orders that track costs for dossier development, external consultants, agency fees, and translation services. Essential for R&D capitalization decisions and',
    `market_heor_study_id` BIGINT COMMENT 'Reference to the primary HEOR study record that underpins the economic model and value dossier submitted to the HTA body. Links to the medical affairs HEOR study asset.',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the drug product (DP) or finished dosage form (FDF) that is the subject of this HTA submission. Links to the master product record.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: HTA dossiers cite patent protection status to demonstrate value proposition duration and justify pricing over the protected period. HTA bodies evaluate patent expiry when assessing long-term budget im',
    `actual_submission_date` DATE COMMENT 'Date on which the HTA dossier was formally submitted to the HTA body. This is the principal real-world business event timestamp for the submission transaction, used to calculate review timelines and clock-start for statutory deadlines.',
    `appeal_filed` BOOLEAN COMMENT 'Indicates whether the company has filed a formal appeal or clarification request against the HTA bodys decision. Triggers the appeal lifecycle tracking and legal review process.',
    `appeal_outcome` STRING COMMENT 'Outcome of the formal appeal filed against the HTA bodys initial decision. Populated only when appeal_filed is True. Drives revision of the decision_type and downstream contracting actions.. Valid values are `upheld|overturned|partially_upheld|withdrawn|pending`',
    `atc_code` STRING COMMENT 'WHO Anatomical Therapeutic Chemical (ATC) classification code for the drug product subject to this HTA submission. Used by HTA bodies to identify the therapeutic class and relevant comparators.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `benefit_rating` STRING COMMENT 'The HTA bodys formal rating of the added therapeutic benefit of the drug compared to the appropriate comparator. Terminology varies by body: G-BA uses major/considerable/minor/non-quantifiable/no added benefit; NICE uses highly clinically effective/clinically effective; HAS uses ASMR grades I-V. [ENUM-REF-CANDIDATE: major|considerable|minor|non_quantifiable|no_added_benefit|asmr_i|asmr_ii|asmr_iii|asmr_iv|asmr_v — promote to reference product]',
    `comparator_description` STRING COMMENT 'Description of the comparator treatment(s) used in the clinical evidence package submitted to the HTA body. HTA bodies require comparison against the current standard of care or the most appropriate comparator (e.g., best supportive care, existing first-line therapy). Critical for benefit assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HTA submission record was first created in the system. Used for audit trail, data lineage, and compliance with 21 CFR Part 11 electronic records requirements.',
    `decision_date` DATE COMMENT 'Date on which the HTA body issued its formal recommendation or decision. Used to calculate time-to-decision, trigger downstream payer contracting timelines, and manage reimbursement listing effective dates.',
    `decision_type` STRING COMMENT 'The formal recommendation type issued by the HTA body following review of the submission: positive (recommended for reimbursement), negative (not recommended), restricted (recommended for a subset of the indicated population), conditional (recommended subject to managed access or further evidence), deferred (decision postponed), or not recommended.. Valid values are `positive|negative|restricted|conditional|deferred|not_recommended`',
    `dossier_reference` STRING COMMENT 'The official dossier or file reference number assigned by the HTA body upon receipt of the submission. Used for all formal correspondence and tracking within the HTA bodys system.',
    `economic_model_type` STRING COMMENT 'Type of health economic model included in the HTA submission dossier. Cost-utility analysis (CUA) using QALYs is standard for NICE; cost-effectiveness analysis (CEA) is used by other bodies. Determines the analytical framework for reimbursement recommendation.. Valid values are `cost_effectiveness|cost_utility|cost_minimisation|cost_benefit|budget_impact`',
    `ectd_sequence_number` STRING COMMENT 'The eCTD sequence number associated with the regulatory submission that supports this HTA dossier, linking the HTA submission to the corresponding marketing authorisation application (MAA/NDA/BLA) in the regulatory submission system.',
    `evidence_package_type` STRING COMMENT 'Classification of the primary clinical evidence package submitted to the HTA body: randomised controlled trial (RCT), observational study, indirect treatment comparison (ITC), mixed treatment comparison (MTC), single-arm trial, or real-world evidence (RWE). Influences the HTA bodys confidence in the benefit assessment.. Valid values are `RCT|observational|indirect_comparison|mixed_treatment|single_arm|real_world`',
    `external_agency` STRING COMMENT 'Name of any external agency, health economics consultancy, or contract research organisation (CRO) engaged to support dossier preparation, economic modelling, or submission management for this HTA engagement.',
    `hta_body_code` STRING COMMENT 'Code identifying the national or regional HTA body to which this submission is directed (e.g., NICE for England, HAS for France, G-BA for Germany, CADTH for Canada, PBAC for Australia). [ENUM-REF-CANDIDATE: NICE|HAS|G-BA|CADTH|PBAC|SMC|AIFA|TLV|ZIN|NCPE|ANVISA|INFARMED — promote to reference product]',
    `icer_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the ICER value submitted (e.g., GBP for NICE, EUR for HAS/G-BA, CAD for CADTH, AUD for PBAC). Required to interpret the submitted ICER in the correct monetary context.. Valid values are `^[A-Z]{3}$`',
    `icer_submitted` DECIMAL(18,2) COMMENT 'The incremental cost-effectiveness ratio (ICER) as submitted by the company in the economic model, expressed in cost per quality-adjusted life year (QALY) gained or cost per life year gained. Confidential as it reflects internal pricing and modelling assumptions used in payer negotiations.',
    `inn` STRING COMMENT 'The WHO-assigned International Nonproprietary Name (INN) for the active pharmaceutical ingredient (API) that is the subject of this HTA submission. Used by HTA bodies as the standard drug identifier.',
    `managed_access_scheme` BOOLEAN COMMENT 'Indicates whether the HTA decision is conditional on a managed access scheme (MAS), such as NICEs Managed Access Agreements (MAA) or Cancer Drugs Fund (CDF) arrangements, requiring further real-world evidence collection during the access period.',
    `patient_access_program` BOOLEAN COMMENT 'Indicates whether a patient access program (PAP) or copay assistance program has been established in conjunction with this HTA submission to support patient affordability and access pending or following the reimbursement decision.',
    `planned_submission_date` DATE COMMENT 'Target date on which the completed HTA dossier is planned to be formally submitted to the HTA body. Used for project planning, resource allocation, and commercial launch timeline alignment.',
    `price_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the recommended price range values (e.g., GBP, EUR, CAD, AUD). Required to interpret price bounds in the correct monetary context for each jurisdiction.. Valid values are `^[A-Z]{3}$`',
    `recommended_price_lower` DECIMAL(18,2) COMMENT 'Lower bound of the price range recommended or implied by the HTA bodys decision, expressed in the local currency. Used in payer contracting and gross-to-net revenue management. Confidential as it reflects sensitive pricing negotiation data.',
    `recommended_price_upper` DECIMAL(18,2) COMMENT 'Upper bound of the price range recommended or implied by the HTA bodys decision, expressed in the local currency. Used alongside the lower bound to define the acceptable price corridor for payer negotiations and contracting.',
    `regulatory_approval_date` DATE COMMENT 'Date on which the marketing authorisation (MA) was granted by the relevant regulatory authority (FDA, EMA, MHRA, etc.) for the indication covered by this HTA submission. HTA submissions typically follow regulatory approval; this date anchors the HTA timeline.',
    `reimbursement_conditions` STRING COMMENT 'Free-text description of any conditions, restrictions, or requirements attached to the HTA bodys reimbursement recommendation (e.g., restricted to second-line use, mandatory prior authorisation, patient registry requirement, managed access scheme). Drives contracting and access program design.',
    `rwe_required` BOOLEAN COMMENT 'Indicates whether the HTA bodys decision requires the generation and submission of real-world evidence (RWE) or real-world data (RWD) as a condition of continued reimbursement or as part of a managed access arrangement.',
    `submission_lead` STRING COMMENT 'Name or identifier of the internal market access lead or HTA manager responsible for coordinating and owning this submission. Used for accountability, escalation, and stakeholder communication.',
    `submission_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the HTA submission, used in correspondence with the HTA body and in regulatory information management systems (RIMS). Typically follows the HTA bodys own dossier numbering convention.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the HTA submission, tracking progression from planning through dossier preparation, formal submission, review, and final decision or withdrawal. [ENUM-REF-CANDIDATE: planned|in_preparation|submitted|under_review|decision_issued|withdrawn|resubmission — promote to reference product]',
    `submission_type` STRING COMMENT 'Classifies the nature of the HTA submission: initial submission for a new indication, resubmission following a negative decision, renewal of an existing reimbursement listing, line extension for a new formulation or dose, or supplemental submission with new evidence.. Valid values are `initial|resubmission|renewal|line_extension|supplemental`',
    `therapeutic_area` STRING COMMENT 'The disease area or therapeutic category covered by this HTA submission (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular). Aligns with the companys internal therapeutic area taxonomy and the ATC classification system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this HTA submission record was most recently modified. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks Silver layer.',
    `value_dossier_version` STRING COMMENT 'Version identifier of the global value dossier (GVD) used as the basis for this HTA submission. Tracks which version of the evidence synthesis and value story was submitted, enabling audit trail and version control across multiple country submissions.. Valid values are `^v[0-9]+.[0-9]+$`',
    `willingness_to_pay_threshold` DECIMAL(18,2) COMMENT 'The HTA bodys published or applied willingness-to-pay threshold per QALY (or equivalent outcome unit) for the relevant jurisdiction at the time of submission. Used to assess whether the submitted ICER falls within the acceptable range for reimbursement recommendation.',
    CONSTRAINT pk_hta_submission PRIMARY KEY(`hta_submission_id`)
) COMMENT 'Master record for the full lifecycle of Health Technology Assessment (HTA) submissions to bodies such as NICE (UK), HAS (France), G-BA (Germany), CADTH (Canada), and PBAC (Australia). Captures submission planning, dossier preparation, submission date, HTA body, therapeutic indication, comparator, clinical evidence package, economic model type, submission status, and the resulting formal decision including recommendation type (positive, negative, restricted, conditional), benefit rating, added therapeutic benefit classification, recommended price range, and reimbursement conditions. Owns both the submission event and the decision outcome as lifecycle stages of a single HTA engagement. Drives downstream payer contracting and pricing decisions.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` (
    `value_dossier_id` BIGINT COMMENT 'Unique surrogate identifier for the global value dossier (GVD) record in the Databricks Silver Layer. Primary key for this entity.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Value dossiers are developed to support specific market access strategies. One value dossier supports one access strategy (1:N from access_strategy perspective). This eliminates value_dossier as a sil',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Value dossiers are country-specific for HTA submissions, requiring regulatory framework, HTA body details, and reimbursement system context for evidence package preparation. target_country_code denorm',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Value dossiers incorporate regulatory exclusivity data to support pricing justification, demonstrate protected market position, and establish differentiation from biosimilars/generics. Exclusivity per',
    `atc_code` STRING COMMENT 'WHO Anatomical Therapeutic Chemical (ATC) classification code assigned to the drug product, used for formulary positioning, HTA comparisons, and reimbursement benchmarking.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `brand_name` STRING COMMENT 'Proprietary trade name of the drug product as approved by the relevant regulatory authority (FDA, EMA, etc.) and used in commercial and payer-facing communications.',
    `budget_impact_model_ref` STRING COMMENT 'Reference identifier or document name for the budget impact model (BIM) associated with this dossier, enabling traceability to the underlying economic model file stored in Veeva Vault or equivalent document management system.',
    `clinical_evidence_summary` STRING COMMENT 'Structured narrative summarizing the key clinical evidence supporting the products value proposition, including pivotal trial results, patient population, efficacy outcomes, and safety profile as presented to payers.',
    `comparator_description` STRING COMMENT 'Narrative description of the comparator treatments used in the clinical and economic evidence sections of the dossier, including standard of care, active comparators, and placebo arms as defined by the HTA body.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this value dossier record was first created in the system, used for audit trail and data lineage tracking in the Databricks Silver Layer.',
    `decision_date` DATE COMMENT 'Date on which the HTA body or payer issued its coverage, reimbursement, or formulary placement decision in response to this dossier submission.',
    `decision_outcome` STRING COMMENT 'Outcome of the HTA or payer review of this dossier. Positive indicates full reimbursement recommended; positive_with_restrictions indicates conditional coverage; negative indicates rejection.. Valid values are `positive|positive_with_restrictions|negative|deferred|withdrawn|under_review`',
    `dossier_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the value dossier across market access systems and payer submissions. Follows the pattern GVD-<PRODUCT_CODE>-<YEAR>-v<VERSION>.. Valid values are `^GVD-[A-Z0-9]{3,10}-[0-9]{4}-v[0-9]+$`',
    `dossier_owner` STRING COMMENT 'Name or identifier of the internal market access team member or function responsible for authoring, maintaining, and updating this value dossier.',
    `dossier_status` STRING COMMENT 'Current lifecycle state of the value dossier. Draft indicates work-in-progress; approved indicates internal sign-off; published indicates submission to payer or HTA body; superseded indicates replaced by a newer version.. Valid values are `draft|under_review|approved|published|archived|superseded`',
    `dossier_type` STRING COMMENT 'Classification of the dossier by its intended use and audience. Global dossiers serve as the master template; local adaptations are country-specific derivatives. [ENUM-REF-CANDIDATE: global|local_adaptation|payer_specific|hta_submission|reimbursement_dossier|formulary_submission — promote to reference product]. Valid values are `global|local_adaptation|payer_specific|hta_submission|reimbursement_dossier|formulary_submission`',
    `economic_model_type` STRING COMMENT 'Type of health economic model used as the primary analytical framework in the dossier (e.g., cost-effectiveness analysis, cost-utility analysis using QALYs, budget impact model).. Valid values are `cost_effectiveness|cost_utility|cost_minimization|cost_benefit|budget_impact`',
    `effective_from` DATE COMMENT 'Date from which this version of the value dossier is considered active and valid for use in payer negotiations, HTA submissions, or formulary discussions.',
    `effective_until` DATE COMMENT 'Date after which this version of the value dossier is no longer considered current and should be superseded by a newer version. Nullable for currently active dossiers.',
    `formulary_tier_target` STRING COMMENT 'Desired formulary tier placement being sought from the payer or pharmacy benefit manager (PBM) based on the evidence presented in the dossier.. Valid values are `tier_1|tier_2|tier_3|tier_4|specialty|non_formulary`',
    `heor_evidence_summary` STRING COMMENT 'Summary of the Health Economics and Outcomes Research (HEOR) evidence included in the dossier, covering cost-effectiveness analyses, cost-utility analyses, budget impact models, and quality-of-life (QoL) data.',
    `hta_body_name` STRING COMMENT 'Name of the specific Health Technology Assessment (HTA) body or payer organization to which this dossier is submitted or targeted (e.g., NICE, G-BA, HAS, PBAC, ICER).',
    `icd_code` STRING COMMENT 'ICD-10 or ICD-11 code corresponding to the target indication, used for standardized disease classification in HTA submissions and payer negotiations.. Valid values are `^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$`',
    `icur_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the Incremental Cost-Utility Ratio (ICUR) is expressed (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `icur_value` DECIMAL(18,2) COMMENT 'Incremental Cost-Utility Ratio (ICUR) expressed as cost per Quality-Adjusted Life Year (QALY) gained, representing the primary health economic outcome submitted to HTA bodies. Classified as confidential due to commercial sensitivity in payer negotiations.',
    `legal_reviewed` BOOLEAN COMMENT 'Indicates whether the Legal and Compliance function has reviewed this dossier version for regulatory compliance, IP considerations, and promotional material standards.',
    `line_of_therapy` STRING COMMENT 'Intended line of therapy for which the product is being positioned in the dossier (e.g., first-line, second-line). Directly impacts formulary tier placement and reimbursement scope.. Valid values are `first_line|second_line|third_line|adjuvant|neoadjuvant|maintenance`',
    `medical_affairs_reviewed` BOOLEAN COMMENT 'Indicates whether the Medical Affairs function has completed a formal scientific review and sign-off of the clinical evidence sections of this dossier version.',
    `patient_population_size` STRING COMMENT 'Estimated number of eligible patients in the target market who could benefit from the treatment, as used in the budget impact model and payer negotiations.',
    `primary_endpoint` STRING COMMENT 'Primary efficacy endpoint from the pivotal clinical trial(s) supporting the dossier (e.g., Overall Survival (OS), Progression-Free Survival (PFS), Objective Response Rate (ORR)). Directly informs the clinical value narrative.',
    `product_inn` STRING COMMENT 'WHO-assigned International Nonproprietary Name (INN) of the active pharmaceutical ingredient (API) featured in the dossier. Used as the universal scientific identifier across regulatory and payer submissions.',
    `qaly_gain` DECIMAL(18,2) COMMENT 'Estimated Quality-Adjusted Life Year (QALY) gain attributed to the treatment versus the comparator, as reported in the health economic model submitted in the dossier.',
    `reimbursement_scope` STRING COMMENT 'Scope of reimbursement coverage achieved or sought for the product based on the dossier submission, indicating whether full, restricted, or conditional reimbursement applies.. Valid values are `full|restricted|step_therapy|prior_authorization|not_reimbursed`',
    `rwe_included` BOOLEAN COMMENT 'Indicates whether Real-World Evidence (RWE) or Real-World Data (RWD) is included as supporting evidence in this dossier version, in addition to randomized controlled trial data.',
    `submission_date` DATE COMMENT 'Date on which the value dossier was formally submitted to the target HTA body, payer, or formulary committee.',
    `target_indication` STRING COMMENT 'Specific disease or condition for which the product is being positioned in the dossier (e.g., metastatic non-small cell lung cancer, relapsing-remitting multiple sclerosis). Should align with the approved or sought label indication.',
    `target_payer_type` STRING COMMENT 'Classification of the primary payer audience for whom the dossier is tailored. Determines the evidence framing and economic model emphasis. [ENUM-REF-CANDIDATE: national_hta|regional_hta|commercial_payer|pbm|gpo|government_formulary|hospital_formulary — promote to reference product]',
    `therapeutic_area` STRING COMMENT 'Broad disease area or medical specialty the dossier addresses (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular). Aligns with the companys therapeutic area taxonomy.',
    `title` STRING COMMENT 'Full descriptive title of the value dossier, typically including the product name, indication, and target audience (e.g., payer, HTA body).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this value dossier record, supporting audit trail requirements and change tracking in the Databricks Silver Layer.',
    `version_date` DATE COMMENT 'Calendar date on which the current version of the dossier was finalized and approved for use.',
    `version_number` STRING COMMENT 'Semantic version number of the dossier (e.g., 1.0, 2.1, 3.0.1). Incremented with each substantive update to clinical evidence, HEOR data, or comparator landscape.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_value_dossier PRIMARY KEY(`value_dossier_id`)
) COMMENT 'Master record for the global value dossier (GVD) or payer value dossier developed to support market access negotiations. Captures therapeutic area, target indication, clinical evidence summary, HEOR evidence, comparator landscape, budget impact model reference, and version history. Serves as the evidentiary foundation for HTA submissions and payer negotiations.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` (
    `market_payer_contract_id` BIGINT COMMENT 'Unique surrogate identifier for the payer contract record in the Databricks Silver Layer. Primary key for this master agreement entity.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Payer contracts are negotiated within the context of market access strategies. One payer contract supports one access strategy (1:N from access_strategy perspective). No columns to remove as payer_con',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Payer contracts generate receivables through administrative fees, upfront payments, and contract settlements. Finance must track AR by contract for reconciliation, payment collection, and revenue reco',
    `disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_disclosure. Business justification: Market payer contracts should link to compliance disclosures for transparency reporting and regulatory compliance. This enables integrated management of payer agreements and associated disclosure obli',
    `drug_product_id` BIGINT COMMENT 'Reference to the contracted pharmaceutical product (Drug Product / Finished Dosage Form) covered under this payer agreement.',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Contracts reference regulatory exclusivity periods to establish pricing corridors, define renegotiation triggers at LOE, and structure managed entry agreements. Exclusivity timelines are contractual t',
    `legal_entity_id` BIGINT COMMENT 'Reference to the payer, Pharmacy Benefit Manager (PBM), Group Purchasing Organization (GPO), or managed care organization that is the counterparty to this contract.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Payer contracts include patent expiry clauses for price protection, rebate adjustment triggers at loss of exclusivity, and contract termination provisions. Patent status directly affects contract term',
    `payer_account_id` BIGINT COMMENT 'Foreign key linking to market.payer_account. Business justification: Market payer contracts MUST reference which payer organization the contract is with. This is a fundamental relationship - every managed care contract, rebate agreement, or performance-based contract i',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Payer contracts require compliance program oversight for anti-kickback statute compliance, transparency reporting, and government pricing rules (Medicaid best price, 340B). Every contract must be revi',
    `admin_fee_pct` DECIMAL(18,2) COMMENT 'Administrative fee percentage charged by the PBM or GPO for contract administration, data services, and formulary management, expressed as a percentage of net sales. Deducted in gross-to-net calculations.',
    `auto_renewal` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at the end of the effective period unless either party provides notice of termination within the specified notice period.',
    `base_rebate_pct` DECIMAL(18,2) COMMENT 'The unconditional base rebate percentage of Wholesale Acquisition Cost (WAC) or Average Manufacturer Price (AMP) owed to the payer regardless of performance metrics. Core input to gross-to-net revenue accrual calculations.',
    `book_of_business_lives` BIGINT COMMENT 'The number of covered lives (plan members) within the payers book of business that are subject to this contract. Used for rebate volume estimation, market access analytics, and payer segmentation.',
    `contract_name` STRING COMMENT 'Descriptive business name of the payer contract (e.g., CVS Caremark National Formulary Rebate Agreement FY2025), used for identification in reporting and gross-to-net management.',
    `contract_number` STRING COMMENT 'Externally-known unique alphanumeric identifier assigned to this payer contract, used for cross-referencing with the payer, PBM, or GPO and in SAP SD/FI rebate agreement records.',
    `contract_owner` STRING COMMENT 'Name or identifier of the internal Market Access or Managed Care team member responsible for managing and maintaining this payer contract relationship.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the payer contract. Governs whether rebate accruals are active, whether the contract is eligible for payment processing, and whether formulary positioning obligations are in effect. [ENUM-REF-CANDIDATE: draft|pending_execution|active|suspended|terminated|expired|under_renegotiation — promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the payer contract by its commercial structure. Determines rebate calculation methodology and accrual treatment. [ENUM-REF-CANDIDATE: base_rebate|performance_rebate|outcomes_based|value_based|pbm_formulary_rebate|gpo_commitment — promote to reference product if additional types emerge]. Valid values are `base_rebate|performance_rebate|outcomes_based|value_based|pbm_formulary_rebate|gpo_commitment`',
    `copay_assistance_allowed` BOOLEAN COMMENT 'Indicates whether the contract permits the manufacturer to offer copay assistance or patient support programs to members covered under this payers plan. Some commercial contracts restrict copay card use.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this payer contract record was first created in the system. Used for audit trail, data lineage, and SOX compliance purposes.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all rebate amounts, fees, and financial obligations under this contract are denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `data_sharing_required` BOOLEAN COMMENT 'Indicates whether the contract includes a data sharing provision requiring the payer or PBM to provide claims data, utilization data, or outcomes data to the manufacturer. Relevant for outcomes-based and value-based contracts.',
    `data_sharing_scope` STRING COMMENT 'Specifies the type of data the payer or PBM is contractually obligated to share with the manufacturer under the data sharing provision. Null if data_sharing_required is False.. Valid values are `claims_data|utilization_data|outcomes_data|adherence_data|full_claims_and_outcomes`',
    `effective_end_date` DATE COMMENT 'The date on which the payer contract expires or is scheduled to terminate. Nullable for evergreen contracts. Used as the upper bound for rebate accrual period calculations and contract renewal tracking.',
    `effective_start_date` DATE COMMENT 'The date on which the payer contract becomes legally binding and rebate obligations commence. Used as the lower bound for rebate accrual period calculations.',
    `estimated_annual_rebate_amount` DECIMAL(18,2) COMMENT 'The estimated total rebate liability for a full contract year based on projected sales volume and contracted rebate rates. Used for gross-to-net accrual budgeting and financial planning. Not a calculated aggregate — represents the contractually agreed estimate.',
    `exclusivity_provision` BOOLEAN COMMENT 'Indicates whether the contract grants the contracted product exclusive or preferred formulary positioning within its therapeutic class, excluding or restricting competitor products.',
    `execution_date` DATE COMMENT 'The date on which the contract was formally signed and executed by all parties. May differ from the effective start date for retroactive agreements.',
    `formulary_tier` STRING COMMENT 'The formulary tier position secured for the contracted product under this payer agreement. Directly impacts patient access, copay levels, and rebate obligations. Central to PBM formulary management mechanics.. Valid values are `tier_1_preferred|tier_2_non_preferred|tier_3_specialty|tier_4_excluded|tier_5_specialty_preferred`',
    `governing_law_jurisdiction` STRING COMMENT 'The legal jurisdiction (ISO 3166-1 alpha-2 or alpha-3 country/state code) whose laws govern the interpretation and enforcement of this contract (e.g., US-DE for Delaware, USA).. Valid values are `^[A-Z]{2,3}$`',
    `incremental_rebate_pct` DECIMAL(18,2) COMMENT 'Additional rebate percentage earned above the base rebate upon achievement of performance or formulary tier thresholds. Used in tiered and performance-based contract structures.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this payer contract record was most recently modified. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks Silver Layer.',
    `most_favored_nation_clause` BOOLEAN COMMENT 'Indicates whether the contract contains a Most Favored Nation (MFN) clause requiring the manufacturer to offer this payer terms no less favorable than those offered to any other payer. Has significant pricing and compliance implications.',
    `performance_metric_type` STRING COMMENT 'The type of performance metric used to determine eligibility for incremental or performance-based rebates. Applicable for performance rebate, outcomes-based, and value-based contract types.. Valid values are `market_share|formulary_tier|patient_outcomes|adherence_rate|cost_per_cure|utilization_management`',
    `performance_threshold_value` DECIMAL(18,2) COMMENT 'The numeric threshold that must be achieved on the performance metric to trigger incremental rebate payments (e.g., minimum market share percentage, minimum formulary tier position, minimum adherence rate).',
    `price_protection_clause` BOOLEAN COMMENT 'Indicates whether the contract includes a price protection provision that triggers additional rebates if the manufacturer raises the list price (WAC) above a specified threshold, typically tied to CPI or a fixed percentage.',
    `price_protection_threshold_pct` DECIMAL(18,2) COMMENT 'The maximum allowable annual WAC price increase percentage before price protection rebates are triggered under the contract. Null if price_protection_clause is False.',
    `rebate_payment_frequency` STRING COMMENT 'The agreed schedule for rebate payment remittance from the manufacturer to the payer or PBM. Drives rebate accrual timing and cash flow planning in SAP FI.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `rebate_payment_lag_days` STRING COMMENT 'The number of days after the close of a rebate period within which the rebate invoice must be paid. Used for cash flow forecasting and accrual true-up calculations.',
    `renewal_notice_days` STRING COMMENT 'The number of days prior to the effective end date by which either party must provide written notice of intent not to renew the contract. Applicable when auto_renewal is True.',
    `source_system_contract_code` STRING COMMENT 'The native contract identifier from the originating system of record (e.g., SAP S/4HANA SD rebate agreement number, Salesforce Health Cloud contract record ID). Enables traceability back to the operational source system.',
    `termination_date` DATE COMMENT 'The actual date on which the contract was terminated early, if applicable. Distinct from effective_end_date which represents the scheduled expiry. Null if the contract has not been terminated early.',
    `termination_reason` STRING COMMENT 'Reason code for early contract termination. Required for gross-to-net true-up and audit trail purposes when a contract is ended before its scheduled expiry date. [ENUM-REF-CANDIDATE: mutual_agreement|breach|regulatory_action|product_withdrawal|formulary_exclusion|renegotiation|expiry — 7 candidates stripped; promote to reference product]',
    `utilization_management_restrictions` STRING COMMENT 'Specifies the utilization management restrictions applied to the contracted product on the payers formulary (e.g., prior authorization, step therapy, quantity limits). Impacts patient access and market share performance metrics.. Valid values are `none|prior_authorization|step_therapy|quantity_limits|step_therapy_and_pa`',
    CONSTRAINT pk_market_payer_contract PRIMARY KEY(`market_payer_contract_id`)
) COMMENT 'Master record for all managed care contracts, rebate agreements, and performance-based contracts negotiated with payers, PBMs (Express Scripts, CVS Caremark, OptumRx), GPOs, and other contracting entities. Captures contract type (base rebate, performance rebate, outcomes-based, value-based, PBM formulary rebate, GPO commitment), contracted product, rebate tiers, performance metrics, administrative fees, data sharing provisions, book-of-business structure, PBM-specific formulary management mechanics, contract term, and payment schedule. Central to gross-to-net revenue management and rebate accrual calculations. Covers all payer types including PBM-specific contract structures.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` (
    `rebate_claim_id` BIGINT COMMENT 'Unique system-generated identifier for the rebate claim record. Primary key for the rebate_claim data product in the market domain.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Rebate claims track actual rebates paid for brand utilization under payer contracts. Financial reconciliation and GTN forecasting process requires linking rebate claims to brands for revenue recogniti',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Market rebate claims should link to finance accounts receivable for rebate accrual and revenue recognition. This enables accurate gross-to-net calculations and financial reporting for pharmaceutical r',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: Rebate claims reference specific lot numbers for Medicaid best price calculations, chargeback validation, and dispute resolution. Lot-level traceability is required for regulatory compliance and finan',
    `market_payer_contract_id` BIGINT COMMENT 'Reference to the managed care or payer contract under which this rebate claim is generated. Governs the applicable rebate tiers, rates, and eligible products.',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the contracted pharmaceutical product (Drug Product/Finished Dosage Form) for which the rebate claim is being processed.',
    `payer_account_id` BIGINT COMMENT 'Reference to the managed care payer or health plan entity against which this rebate claim is submitted or received. Links to the payer master record.',
    `pbm_id` BIGINT COMMENT 'Reference to the Pharmacy Benefit Manager (PBM) administering the rebate contract on behalf of the payer. Null when the payer administers rebates directly.',
    `accrual_period` STRING COMMENT 'Financial reporting quarter (e.g., 2024-Q3) in which the rebate liability or receivable is accrued in the general ledger. Aligns rebate expense recognition with the period of sale per ASC 606 and gross-to-net accounting policies.. Valid values are `^[0-9]{4}-Q[1-4]$`',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Net adjustments applied to the gross rebate amount, including corrections for prior period true-ups, disputed unit reconciliations, or contractual offsets. Negative values represent reductions; positive values represent additions.',
    `claim_direction` STRING COMMENT 'Indicates whether the rebate claim represents an amount payable by the manufacturer to the payer (outbound rebate) or receivable from a payer/GPO (inbound credit). Drives gross-to-net accounting treatment.. Valid values are `payable|receivable`',
    `claim_number` STRING COMMENT 'Externally-known, human-readable business identifier for the rebate claim. Used in payer correspondence, dispute resolution, and reconciliation. Format: RBC-YYYY-NNNNNN.. Valid values are `^RBC-[0-9]{4}-[0-9]{6}$`',
    `claim_period_end_date` DATE COMMENT 'Last day of the measurement period for which eligible units and rebate amounts are being claimed. Together with claim_period_start_date defines the rebate accrual window.',
    `claim_period_start_date` DATE COMMENT 'First day of the measurement period (quarter or month) for which eligible units and rebate amounts are being claimed. Aligns with the contractual reporting period.',
    `claim_status` STRING COMMENT 'Current lifecycle state of the rebate claim. Tracks progression from initial draft through submission, payer review, approval or dispute, and final payment settlement. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|disputed|paid|voided — promote to reference product]',
    `claim_type` STRING COMMENT 'Classification of the rebate claim by the contractual mechanism that generated it. Base rebates are volume-driven; performance rebates are tied to market share or outcomes; formulary rebates are tied to formulary tier placement. [ENUM-REF-CANDIDATE: base_rebate|performance_rebate|market_share_rebate|formulary_rebate|administrative_fee — promote to reference product]. Valid values are `base_rebate|performance_rebate|market_share_rebate|formulary_rebate|administrative_fee`',
    `cost_center` STRING COMMENT 'SAP cost center to which the rebate expense is allocated for internal management reporting and P&L attribution by therapeutic area or brand.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the market in which the rebate claim is applicable. Supports multi-country gross-to-net reporting and compliance with country-specific pricing and reimbursement regulations.. Valid values are `^[A-Z]{3}$`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all monetary amounts on this rebate claim are denominated (e.g., USD, EUR, GBP). Required for multi-currency gross-to-net reporting.. Valid values are `^[A-Z]{3}$`',
    `dispute_reason` STRING COMMENT 'Categorized reason for the dispute raised on this rebate claim. Used to identify systemic data quality or contracting issues and to prioritize resolution efforts. [ENUM-REF-CANDIDATE: unit_count_discrepancy|rate_discrepancy|eligibility_dispute|period_mismatch|data_quality|other — promote to reference product]. Valid values are `unit_count_discrepancy|rate_discrepancy|eligibility_dispute|period_mismatch|data_quality|other`',
    `dispute_status` STRING COMMENT 'Current status of any dispute raised against this rebate claim by the payer, PBM, or manufacturer. Tracks the dispute lifecycle from initiation through resolution for audit and accrual adjustment purposes.. Valid values are `no_dispute|dispute_raised|under_negotiation|resolved_accepted|resolved_rejected`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Monetary value of the portion of the rebate claim currently under dispute. May be less than or equal to net_rebate_amount. Used to calculate the undisputed payable amount and to set dispute reserves.',
    `eligible_units` DECIMAL(18,2) COMMENT 'Total number of units (prescriptions, unit doses, or pack equivalents) dispensed during the claim period that qualify for rebate under the contract terms. Basis for rebate amount calculation.',
    `formulary_tier` STRING COMMENT 'Formulary tier at which the product was listed during the claim period. Determines the applicable rebate rate and is used to validate formulary access commitments made in the managed care contract.. Valid values are `preferred_brand|non_preferred_brand|specialty|generic|not_covered`',
    `gl_account_code` STRING COMMENT 'SAP General Ledger (GL) account code to which the rebate liability or receivable is posted. Ensures correct financial statement classification of gross-to-net revenue deductions.',
    `gross_rebate_amount` DECIMAL(18,2) COMMENT 'Total calculated rebate amount before any adjustments, offsets, or administrative fees. Computed as eligible_units × wac_price × rebate_rate. Primary input to gross-to-net revenue deduction accounting.',
    `market_share_pct` DECIMAL(18,2) COMMENT 'Product market share within the payers covered lives during the claim period, expressed as a percentage. Used to validate performance tier achievement and to support market share rebate calculations.',
    `medicaid_rebate_flag` BOOLEAN COMMENT 'Indicates whether this claim is subject to the CMS Medicaid Drug Rebate Program (MDRP) reporting and payment obligations. Drives separate regulatory reporting workflows and AMP/Best Price calculations.',
    `ndc_code` STRING COMMENT 'National Drug Code (NDC) identifying the specific drug product, labeler, and package size for which the rebate is claimed. Required for payer reconciliation and CMS Medicaid Drug Rebate Program reporting.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `net_rebate_amount` DECIMAL(18,2) COMMENT 'Final rebate amount after applying all adjustments and administrative fee deductions. Represents the actual liability or receivable recorded in the finance domain for rebate accrual and payment settlement.',
    `payment_date` DATE COMMENT 'Actual date on which the rebate payment was received from or remitted to the payer. Null until payment is confirmed. Used for cash flow reconciliation and gross-to-net revenue deduction accounting.',
    `payment_due_date` DATE COMMENT 'Contractually stipulated date by which the rebate payment must be made or received. Used to calculate days-past-due for outstanding claims and to trigger payment reminders.',
    `payment_reference` STRING COMMENT 'Bank or ERP payment reference number (e.g., SAP payment document number or wire transfer reference) associated with the settlement of this rebate claim. Used for cash application and bank reconciliation.',
    `prior_period_adjustment_flag` BOOLEAN COMMENT 'Indicates whether this rebate claim includes a true-up or correction for a prior reporting period. When true, the adjustment_amount field captures the prior period correction value for audit trail purposes.',
    `rebate_rate` DECIMAL(18,2) COMMENT 'Contractually agreed rebate rate expressed as a percentage of WAC or net price applicable to this claim. May reflect a base rate, a performance tier rate, or a blended rate depending on claim type.',
    `rebate_tier` STRING COMMENT 'Contractual performance tier achieved during the claim period that determines the applicable rebate rate. Higher tiers typically correspond to greater market share or formulary access levels.. Valid values are `tier_1|tier_2|tier_3|tier_4`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rebate claim record was first created in the system. Used for audit trail, data lineage, and SOX compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this rebate claim record. Used for change data capture, audit trail, and incremental data pipeline processing in the Databricks Silver Layer. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `submission_date` DATE COMMENT 'Date on which the rebate claim was formally submitted to the payer or PBM. Used to track timeliness against contractual submission deadlines and to calculate aging of outstanding claims.',
    `therapeutic_area` STRING COMMENT 'Therapeutic area classification of the product covered by this rebate claim (e.g., Oncology, Immunology, Rare Diseases). Used for gross-to-net reporting and market access analytics by franchise.',
    `unit_of_measure` STRING COMMENT 'Unit in which eligible_units are expressed for this rebate claim (e.g., prescription, unit dose, pack). Must align with the unit of measure defined in the underlying managed care contract.. Valid values are `prescription|unit_dose|pack|gram|ml`',
    `wac_price` DECIMAL(18,2) COMMENT 'Wholesale Acquisition Cost (WAC) per unit at the time of the claim period. Serves as the base price from which rebate percentages are calculated for gross-to-net revenue deduction accounting.',
    CONSTRAINT pk_rebate_claim PRIMARY KEY(`rebate_claim_id`)
) COMMENT 'Transactional record of rebate claims submitted to or received from payers and PBMs under managed care contracts. Captures claim period, contracted product, eligible units, applicable rebate rate, calculated rebate amount, dispute status, and payment date. Feeds gross-to-net revenue deduction accounting and rebate liability accruals in the finance domain.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` (
    `gross_to_net_adjustment_id` BIGINT COMMENT 'Primary key for gross_to_net_adjustment',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: GTN adjustments calculate net revenue after all discounts/rebates per brand. Revenue recognition and financial reporting process requires linking GTN records to brands for accurate net sales calculati',
    `pharmacy_id` BIGINT COMMENT 'NCPDP (National Council for Prescription Drug Programs) identifier of the pharmacy that dispensed the drug product for copay assistance claims. Populated only for copay_assistance adjustment type.',
    `drug_product_id` BIGINT COMMENT 'Reference to the pharmaceutical drug product (finished dosage form or drug substance) to which this GTN adjustment applies. Links to the master product record.',
    `inventory_lot_id` BIGINT COMMENT 'Foreign key linking to supply.inventory_lot. Business justification: GTN adjustments track lot-level sales for accrual accuracy, settlement reconciliation, and expiry-based write-offs. Lot traceability enables precise revenue recognition, supports audit requirements, a',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Every GTN adjustment must post to general ledger through journal entries for revenue recognition, accrual accounting, and financial statement preparation. Essential for SOX compliance and audit trail ',
    `market_payer_contract_id` BIGINT COMMENT 'Reference to the commercial or government contract under which this GTN adjustment is obligated. Links to the master agreement governing rebate terms, chargeback rates, or fee schedules.',
    `payer_account_id` BIGINT COMMENT 'Reference to the payer entity (health plan, PBM, government program, GPO, or distributor) associated with this GTN adjustment. Serves as the primary party reference for the transaction.',
    `rebate_claim_id` BIGINT COMMENT 'Foreign key linking to market.rebate_claim. Business justification: Some gross-to-net adjustments are driven by rebate claims. One GTN adjustment may be linked to one rebate claim (1:N from rebate_claim perspective). Column to remove: copay_claim_id (STRING) is a weak',
    `accrual_flag` BOOLEAN COMMENT 'Indicates whether this GTN adjustment record represents an accrual estimate (True) or an actual settled/invoiced amount (False). Distinguishes estimated deductions from confirmed payments for financial close accuracy.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary value of the gross-to-net deduction applied for this adjustment record. Represents the revenue reduction from gross sales. Negative values indicate deductions; positive values indicate reversals or recoveries.',
    `adjustment_rate_pct` DECIMAL(18,2) COMMENT 'Contractual or regulatory rate (as a percentage of gross sales or WAC) used to calculate the adjustment amount. Derived from the applicable contract tier, Medicaid best price calculation, or statutory rebate formula.',
    `adjustment_reference_number` STRING COMMENT 'Externally-known business identifier for this GTN adjustment record, used for reconciliation with payer remittances, SAP SD condition records, and financial close processes. Maps to the document number in SAP S/4HANA FI.',
    `adjustment_status` STRING COMMENT 'Current lifecycle state of the gross-to-net adjustment record, tracking its workflow from initial creation through financial posting or reversal.. Valid values are `draft|pending|approved|posted|reversed|disputed`',
    `adjustment_subtype` STRING COMMENT 'Further classification within an adjustment type, enabling granular deduction analysis (e.g., within performance rebates: market share tier, volume threshold, outcomes-based). Supports detailed GTN waterfall reporting.',
    `adjustment_type` STRING COMMENT 'Category of gross-to-net deduction applied to gross sales. Classifies the revenue deduction by its contractual or regulatory basis. [ENUM-REF-CANDIDATE: base_rebate|performance_rebate|medicaid_best_price|340b|chargeback|copay_assistance|gpo_fee|distribution_fee|patient_assistance|managed_care_rebate|medicare_part_d|state_supplemental_rebate — promote to reference product]',
    `channel` STRING COMMENT 'Commercial distribution channel through which the drug product was dispensed or sold, determining applicable GTN deduction rates and program eligibility (e.g., 340B, Medicaid, specialty pharmacy). [ENUM-REF-CANDIDATE: retail|specialty|mail_order|hospital|government|long_term_care|340b|other — 8 candidates stripped; promote to reference product]',
    `claim_date` DATE COMMENT 'Date on which the copay assistance claim was adjudicated at the pharmacy. Populated only for copay_assistance adjustment type. Used for copay program spend timing analysis.',
    `copay_assistance_paid_amount` DECIMAL(18,2) COMMENT 'Dollar amount of copay assistance paid by the manufacturer on behalf of the patient for a specific claim. Equals the adjustment_amount for copay_assistance type records. Drives copay program financial tracking.',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA cost center to which this GTN adjustment is allocated for internal management reporting and P&L attribution by business unit or therapeutic area.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code identifying the market geography where this GTN adjustment applies. Supports country-level GTN analysis and compliance with local pricing regulations.. Valid values are `^[A-Z]{3}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this GTN adjustment record (e.g., USD, EUR, GBP). Supports multi-currency GTN reporting for international markets.. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this GTN adjustment record is currently under dispute with the payer, PBM, or government agency. Triggers dispute management workflow and prevents premature financial settlement.',
    `dispute_reason` STRING COMMENT 'Textual description of the reason for disputing this GTN adjustment, such as incorrect units, ineligible claims, contract interpretation differences, or data discrepancies. Populated only when dispute_flag is True.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter within the fiscal year in which this GTN adjustment is recognized. Enables quarterly GTN deduction trend analysis and earnings reporting.. Valid values are `Q1|Q2|Q3|Q4`',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this GTN adjustment is recognized for financial reporting purposes. Supports annual GTN waterfall analysis and SOX-compliant revenue reconciliation.',
    `gl_account_code` STRING COMMENT 'SAP S/4HANA general ledger account code to which this GTN deduction is posted. Enables financial statement mapping and deduction category P&L analysis.',
    `gross_copay_amount` DECIMAL(18,2) COMMENT 'Total patient copay obligation before application of copay assistance for a specific claim. Populated only for copay_assistance adjustment type. Used to calculate patient affordability metrics.',
    `gross_sales_amount` DECIMAL(18,2) COMMENT 'Total gross sales revenue (at WAC or list price) before application of any GTN deductions for the product, payer, and period. Serves as the base for GTN waterfall calculations.',
    `medicaid_best_price_flag` BOOLEAN COMMENT 'Indicates whether this GTN adjustment was considered in the Medicaid Best Price calculation for the applicable reporting period. Critical for CMS Medicaid Drug Rebate Program compliance and AMP/Best Price reporting.',
    `ndc_code` STRING COMMENT 'FDA-assigned National Drug Code identifying the specific drug product, labeler, and package configuration subject to this GTN adjustment. Required for Medicaid rebate calculations and 340B program compliance.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `net_revenue_amount` DECIMAL(18,2) COMMENT 'Net revenue after application of this GTN adjustment (gross_sales_amount minus adjustment_amount). Represents the recognized revenue for ASC 606 reporting purposes.',
    `patient_deidentified_code` STRING COMMENT 'De-identified patient token for copay assistance claim records, enabling patient-level program utilization analysis while maintaining HIPAA compliance. Populated only for copay_assistance adjustment type. Never contains direct patient PII.',
    `patient_remaining_liability` DECIMAL(18,2) COMMENT 'Residual out-of-pocket cost borne by the patient after copay assistance is applied (gross_copay_amount minus copay_assistance_paid_amount). Measures patient affordability program effectiveness.',
    `period_end_date` DATE COMMENT 'Last day of the reporting or contract period to which this GTN adjustment applies. Defines the close of the accrual or settlement window.',
    `period_start_date` DATE COMMENT 'First day of the reporting or contract period to which this GTN adjustment applies. Used for period-based accrual accounting and rebate calculation windows.',
    `posting_date` DATE COMMENT 'Date on which this GTN adjustment was posted to the general ledger in SAP S/4HANA FI. Determines the accounting period for revenue recognition and financial reporting.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this GTN adjustment record was first created in the data platform. Supports audit trail, data lineage, and SOX-compliant financial record retention.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this GTN adjustment record was last modified in the data platform. Enables change detection, incremental processing, and audit trail maintenance.',
    `settlement_date` DATE COMMENT 'Date on which the GTN adjustment was financially settled, paid, or credited to the payer. Null for accrual records pending settlement. Used for cash flow and payment timing analysis.',
    `source_system` STRING COMMENT 'Operational system of record from which this GTN adjustment record originated. Supports data lineage, reconciliation, and audit trail requirements for financial close and SOX compliance.. Valid values are `SAP_SD|SAP_FI|COPAY_PROCESSOR|MEDICAID_PORTAL|CHARGEBACK_SYSTEM|MANUAL`',
    `therapeutic_area` STRING COMMENT 'Clinical therapeutic area classification of the drug product subject to this GTN adjustment (e.g., Oncology, Immunology, Rare Diseases). Enables GTN deduction analysis by disease area for portfolio management.',
    `units_sold` DECIMAL(18,2) COMMENT 'Number of drug product units (e.g., bottles, vials, packs) sold during the adjustment period that are subject to this GTN deduction. Used for per-unit rebate calculations and volume-based tier determination.',
    CONSTRAINT pk_gross_to_net_adjustment PRIMARY KEY(`gross_to_net_adjustment_id`)
) COMMENT 'Records all gross-to-net revenue deduction components applied to a pharmaceutical products gross sales to arrive at net revenue. Captures adjustment type (base rebate, performance rebate, Medicaid best price, 340B, chargebacks, copay assistance, GPO fees, distribution fees, patient assistance), period, product, channel, and adjustment amount. For copay assistance adjustments, captures individual claim-level detail including dispensing pharmacy, claim date, patient identifier (de-identified), drug product, gross copay amount, assistance amount paid, and remaining patient liability. Enables net revenue reconciliation, deduction category analysis, copay program spend reporting, and patient affordability program financial tracking. SSOT for all GTN deduction records including copay assistance transactions.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` (
    `coverage_decision_id` BIGINT COMMENT 'Unique surrogate identifier for each coverage decision record in the lakehouse silver layer.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Coverage decisions are made by country-specific payer authorities and regulatory frameworks, requiring HTA body details, reimbursement system context, and regulatory requirements for market access tra',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Coverage decisions factor regulatory exclusivity periods to determine reimbursement duration, managed entry agreement terms, and prior authorization criteria. Exclusivity status is a standard payer ev',
    `hta_submission_id` BIGINT COMMENT 'Foreign key linking to market.hta_submission. Business justification: Coverage decisions are often informed by HTA submission outcomes. One coverage decision may reference one HTA submission (1:N from hta_submission perspective). Columns to remove: hta_body_name and hta',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (drug substance or finished dosage form) for which this coverage decision applies.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Payers assess patent status when making formulary decisions to evaluate long-term value vs. near-term generic entry risk. Patent expiry dates inform coverage duration, tier placement, and utilization ',
    `payer_account_id` BIGINT COMMENT 'Reference to the payer, government health authority, pharmacy benefit manager (PBM), or group purchasing organization (GPO) that issued this coverage decision.',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to market.reimbursement_policy. Business justification: Coverage decisions are transactional instances of reimbursement policies. One reimbursement policy (master) generates many coverage decisions (instances for specific plans, periods, or geographies). T',
    `appeal_deadline_date` DATE COMMENT 'The date by which the manufacturer must file an appeal or request for reconsideration of a negative or restricted coverage decision, critical for market access operations and legal timelines.',
    `atc_code` STRING COMMENT 'WHO Anatomical Therapeutic Chemical (ATC) classification code for the drug, used for therapeutic area benchmarking, payer analytics, and HTA submissions.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `brand_name` STRING COMMENT 'Proprietary brand name of the pharmaceutical product as registered with the relevant regulatory authority (FDA, EMA, etc.), used for payer communications and market access reporting.',
    `coverage_restriction_detail` STRING COMMENT 'Free-text narrative providing additional detail on the coverage restriction, including specific specialty pharmacy networks, prescriber certification requirements, or REMS program elements.',
    `coverage_restriction_type` STRING COMMENT 'Type of coverage restriction applied by the payer: specialty pharmacy requirement, restricted distribution program, age restriction, prescriber specialty restriction, site-of-care restriction, or Risk Evaluation and Mitigation Strategy (REMS) requirement. [ENUM-REF-CANDIDATE: specialty_pharmacy|restricted_distribution|age_restriction|prescriber_restriction|site_of_care|rems — promote to reference product]. Valid values are `specialty_pharmacy|restricted_distribution|age_restriction|prescriber_restriction|site_of_care|rems`',
    `covered_indication` STRING COMMENT 'The specific therapeutic indication or disease condition for which the payer has granted coverage, as stated in the coverage policy document. May be narrower than the full approved label indication.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage decision record was first created in the lakehouse, used for audit trail and data lineage tracking per 21 CFR Part 11 and SOX requirements.',
    `data_source` STRING COMMENT 'Identifies the operational system of record or external data feed from which this coverage decision record was sourced (e.g., Veeva Vault RIM, RIMS, payer portal extract, manual entry), supporting data lineage and audit.',
    `decision_code` STRING COMMENT 'Externally-known alphanumeric reference code assigned to this coverage decision by the payer or health authority, used for cross-system reconciliation and audit trails.',
    `decision_date` DATE COMMENT 'The date on which the payer or health authority formally issued the coverage decision. This is the principal real-world business event date for this record.',
    `decision_rationale` STRING COMMENT 'Narrative summary of the clinical, economic, or policy rationale provided by the payer or HTA body for the coverage determination, used for appeal preparation and value dossier updates.',
    `decision_status` STRING COMMENT 'Current lifecycle status of the coverage decision, indicating whether the product is covered, not covered, covered with restrictions, pending review, withdrawn, or under active review by the payer or health authority. [ENUM-REF-CANDIDATE: covered|not_covered|restricted|pending|withdrawn|under_review — promote to reference product]. Valid values are `covered|not_covered|restricted|pending|withdrawn|under_review`',
    `decision_type` STRING COMMENT 'Classification of the coverage decision scope: national (e.g., CMS national coverage determination), regional (state/province), plan-level, formulary listing, health technology assessment (HTA) outcome, reimbursement determination, or coverage with evidence development. [ENUM-REF-CANDIDATE: national|regional|plan_level|formulary|hta|reimbursement|coverage_with_evidence — promote to reference product]',
    `effective_date` DATE COMMENT 'The date from which the coverage decision becomes binding and claims can be adjudicated under this policy. May differ from the decision date if there is an implementation lag.',
    `icd_code` STRING COMMENT 'ICD-10 or ICD-11 diagnosis code corresponding to the covered indication, used for claims adjudication and outcomes analytics.. Valid values are `^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$`',
    `inn_name` STRING COMMENT 'WHO-assigned International Nonproprietary Name (INN) of the active pharmaceutical ingredient (API), providing a globally recognized non-proprietary identifier for the drug substance.',
    `line_of_therapy` STRING COMMENT 'The treatment line for which coverage is granted (e.g., first-line, second-line, adjuvant), reflecting the payers clinical positioning requirements and step therapy policies.. Valid values are `first_line|second_line|third_line|adjuvant|neoadjuvant|maintenance`',
    `lives_covered` BIGINT COMMENT 'Estimated number of patient lives covered under the payer plan subject to this coverage decision, used for market access impact assessment and revenue forecasting.',
    `managed_entry_agreement_flag` BOOLEAN COMMENT 'Indicates whether this coverage decision is contingent on a managed entry agreement (MEA) or outcomes-based contract between the manufacturer and the payer, such as a performance-based rebate or risk-sharing arrangement.',
    `ndc_code` STRING COMMENT 'National Drug Code (NDC) identifying the specific drug product, labeler, and package configuration subject to this coverage decision, used for claims processing and formulary management.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `patient_access_program_flag` BOOLEAN COMMENT 'Indicates whether a patient access program (e.g., copay assistance, free drug program, hub services) is associated with this coverage decision to support patient affordability and adherence.',
    `payer_type` STRING COMMENT 'Category of the payer organization issuing the coverage decision: government health authority, commercial insurer, pharmacy benefit manager (PBM), group purchasing organization (GPO), managed care organization, Medicaid, or Medicare. [ENUM-REF-CANDIDATE: government|commercial|pbm|gpo|managed_care|medicaid|medicare — promote to reference product]',
    `plan_year` STRING COMMENT 'The benefit plan year (four-digit calendar year) to which this coverage decision applies, used for annual formulary cycle management and gross-to-net revenue planning.',
    `prior_authorization_criteria` STRING COMMENT 'Narrative description of the clinical and administrative criteria that must be met to obtain prior authorization, including diagnosis requirements, prescriber qualifications, and supporting documentation.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether the payer requires prior authorization (PA) before dispensing the covered product. True means PA must be obtained before the claim is adjudicated.',
    `quantity_limit_description` STRING COMMENT 'Narrative description of the quantity limit imposed by the payer, including the maximum units, dosage, or days supply allowed per dispensing event or coverage period.',
    `quantity_limit_flag` BOOLEAN COMMENT 'Indicates whether the payer imposes a quantity limit on dispensing of the covered product per fill or per defined time period.',
    `region_name` STRING COMMENT 'Sub-national region, state, or province to which this coverage decision applies, for decisions issued at a regional rather than national level (e.g., US state Medicaid programs, German Länder).',
    `reimbursement_scope` STRING COMMENT 'Scope of reimbursement granted under this coverage decision: full reimbursement, partial reimbursement (patient co-pay applies), conditional reimbursement (subject to managed entry agreement or outcomes-based contract), or not reimbursed.. Valid values are `full|partial|conditional|not_reimbursed`',
    `review_date` DATE COMMENT 'Scheduled date for the next periodic review or renewal of this coverage decision by the payer or HTA body, used for proactive market access planning and evidence generation timelines.',
    `rwe_required_flag` BOOLEAN COMMENT 'Indicates whether the payer or HTA body has required the submission of real-world evidence (RWE) or real-world data (RWD) as a condition of this coverage decision or for future coverage renewal.',
    `step_therapy_criteria` STRING COMMENT 'Detailed description of the step therapy requirements, including the specific agents that must be tried and failed, duration of prior therapy, and documentation requirements for exception requests.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether the payer mandates step therapy (fail-first policy), requiring patients to try and fail one or more alternative therapies before coverage of this product is granted.',
    `termination_date` DATE COMMENT 'The date on which the coverage decision expires or is formally terminated. Null indicates an open-ended coverage policy with no defined end date.',
    `therapeutic_area` STRING COMMENT 'Broad therapeutic area classification of the product (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular), used for portfolio-level market access analytics and payer segmentation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this coverage decision record was last modified in the lakehouse, used for change tracking, incremental ETL processing, and audit compliance.',
    CONSTRAINT pk_coverage_decision PRIMARY KEY(`coverage_decision_id`)
) COMMENT 'Records national, regional, or plan-level coverage decisions for a pharmaceutical product by a payer or government health authority. Captures coverage status, covered indication, coverage restrictions, prior authorization criteria, step therapy requirements, and effective date. Distinct from formulary position in that it represents the formal coverage policy determination rather than the formulary tier placement.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` (
    `patient_access_program_id` BIGINT COMMENT 'Unique surrogate identifier for the patient access program record in the lakehouse silver layer. Serves as the primary key for all downstream joins and lineage tracking.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Patient access programs are tactical components of market access strategies. One PAP supports one access strategy (1:N from access_strategy perspective). No columns to remove as patient_access_program',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Patient access programs require dedicated budgets for copay assistance, free drug programs, hub services, and patient support. Finance tracks actual spend against approved budgets for program sustaina',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Patient access programs require country-specific regulatory authorization, compliance with local healthcare regulations, and distribution licensing requirements tracked in country master for program d',
    `master_id` BIGINT COMMENT 'Foreign key linking to hcp.hcp_master. Business justification: Patient access programs require physician enrollment and authorization to prescribe. Physicians must be credentialed and trained on program requirements. Critical for program administration, complianc',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (drug substance or drug product) covered by this patient access program. Links to the master product record for formulary, NDC, and supply chain alignment.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Patient access programs (copay assistance, free drug programs) must comply with anti-kickback statute, government payer exclusions, and patient assistance guidelines. Compliance program oversight ensu',
    `annual_program_budget` DECIMAL(18,2) COMMENT 'Total approved annual budget allocated to fund this patient access program, inclusive of benefit payouts and administrative costs. Used for financial planning, P&L management, and gross-to-net revenue forecasting.',
    `approval_date` DATE COMMENT 'Date on which the patient access program received internal governance approval and/or regulatory authorization to commence operations. Used for compliance audit trails.',
    `benefit_cap_amount` DECIMAL(18,2) COMMENT 'Maximum monetary benefit amount that a single patient may receive under this program per benefit period (e.g., annual cap of $25,000 for copay assistance). Used for gross-to-net revenue management and program budget forecasting.',
    `benefit_cap_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the benefit cap amount (e.g., USD, EUR, GBP). Required for multi-country program management and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `benefit_period` STRING COMMENT 'Time period over which the benefit cap applies and resets. Determines how program utilization is tracked and reported for gross-to-net revenue deductions.. Valid values are `annual|calendar_year|rolling_12_months|per_treatment_cycle|lifetime`',
    `benefit_type` STRING COMMENT 'Nature of the financial or product benefit provided to the patient under this program. Includes copay reduction, free drug supply, premium support, deductible support, and out-of-pocket cap benefits.. Valid values are `copay_reduction|free_drug|premium_support|deductible_support|out_of_pocket_cap`',
    `brand_name` STRING COMMENT 'Proprietary brand name of the pharmaceutical product covered by this program, as registered with the FDA or relevant regulatory authority. Used in patient-facing communications and payer submissions.',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance review of this patient access program, covering OIG, anti-kickback, GDPR, HIPAA, and local regulatory requirements. Required for audit readiness and SOX reporting.',
    `effective_end_date` DATE COMMENT 'Date on which the patient access program is scheduled to close or has been terminated. Null for open-ended programs. Used for sunset planning and gross-to-net revenue management.',
    `effective_start_date` DATE COMMENT 'Date on which the patient access program becomes operationally active and eligible patients may begin enrolling or receiving benefits. Aligns with commercial launch or pre-approval access window.',
    `eligibility_criteria_summary` STRING COMMENT 'Narrative summary of the patient eligibility criteria for program enrollment, including insurance status requirements, income thresholds, diagnosis requirements, and prior treatment conditions. Sourced from the program design document.',
    `enrollment_channel` STRING COMMENT 'Primary channel through which patients or HCPs enroll in the program. Includes hub services, specialty pharmacy, HCP portal, patient portal, phone, and field reimbursement manager (FRM) channels. Drives operational routing and analytics.. Valid values are `hub|specialty_pharmacy|hcp_portal|patient_portal|phone|field_reimbursement`',
    `funding_source` STRING COMMENT 'Entity or mechanism funding the patient access program. Manufacturer-funded programs have direct gross-to-net revenue impact; foundation-funded programs may have different OIG compliance implications.. Valid values are `manufacturer|foundation|government|co_funded`',
    `hub_service_provider` STRING COMMENT 'Name of the third-party hub services organization contracted to administer patient enrollment, benefits verification, prior authorization support, and case management for this program (e.g., Lash Group, ConnectiveRx, Inovalon).',
    `income_threshold_required` BOOLEAN COMMENT 'Indicates whether the program requires patients to meet a defined income or financial need threshold as part of eligibility screening. True for patient assistance programs (PAP); typically False for copay assistance programs.',
    `indication` STRING COMMENT 'Specific disease or condition for which the product is approved or being accessed under this program. Aligns with the label indication or the compassionate use/expanded access authorization.',
    `inn` STRING COMMENT 'WHO-assigned International Nonproprietary Name (INN) for the active pharmaceutical ingredient (API) covered by this program. Enables cross-country and cross-payer standardization.',
    `insurance_status_requirement` STRING COMMENT 'Specifies the insurance coverage status required for patient eligibility. Copay assistance programs typically require commercially insured patients; PAPs typically target uninsured or underinsured populations.. Valid values are `insured|uninsured|underinsured|any`',
    `legal_reviewed` BOOLEAN COMMENT 'Indicates whether the program design and terms have been reviewed and approved by the legal department for compliance with anti-kickback statutes, GDPR, HIPAA, and applicable local regulations.',
    `line_of_therapy` STRING COMMENT 'Specifies the treatment line for which this program is applicable (e.g., first-line, second-line). Aligns with formulary positioning, HTA evidence requirements, and clinical trial endpoint definitions (e.g., PFS, OS, ORR).. Valid values are `first_line|second_line|third_line_plus|any_line|maintenance`',
    `patient_population_description` STRING COMMENT 'Narrative description of the target patient population for this program, including disease stage, line of therapy, age group, and any biomarker or diagnostic requirements. Informs HTA submissions and payer value dossiers.',
    `payer_segment` STRING COMMENT 'Insurance or payer segment targeted by this program. Copay assistance programs are typically restricted to commercially insured patients; PAPs target uninsured or government-insured populations. Drives OIG compliance and gross-to-net accounting.. Valid values are `commercial|medicare|medicaid|government|uninsured`',
    `program_notes` STRING COMMENT 'Free-text field for additional operational notes, special conditions, or exceptions associated with this patient access program. Used by market access and hub operations teams for case-by-case documentation.',
    `program_owner` STRING COMMENT 'Name or identifier of the internal business owner (e.g., Market Access Director, Brand Team Lead) accountable for the design, governance, and performance of this patient access program.',
    `program_status` STRING COMMENT 'Current lifecycle state of the patient access program. Drives operational eligibility checks, enrollment processing, and reporting to market access leadership.. Valid values are `active|inactive|pending_approval|suspended|closed`',
    `program_type` STRING COMMENT 'Classification of the program by its access mechanism. Covers copay assistance, free drug programs, patient assistance programs (PAP), named patient programs, compassionate use, expanded access programs (EAP), managed access agreements, hub services, and specialty pharmacy support. [ENUM-REF-CANDIDATE: copay_assistance|free_drug|patient_assistance|named_patient|compassionate_use|expanded_access|managed_access|hub_services|specialty_pharmacy_support — promote to reference product]',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this patient access program record was first created in the lakehouse silver layer. Supports data lineage, audit trails, and 21 CFR Part 11 electronic records compliance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this patient access program record was most recently modified in the lakehouse silver layer. Supports change data capture (CDC), audit trails, and regulatory compliance.',
    `regulatory_authorization_ref` STRING COMMENT 'Reference number or identifier for the regulatory authorization underpinning this program (e.g., FDA Expanded Access IND number, EMA compassionate use authorization, named patient program reference). Links to the regulatory submission record.',
    `rems_program_flag` BOOLEAN COMMENT 'Indicates whether this patient access program is associated with or operates under an FDA-mandated Risk Evaluation and Mitigation Strategy (REMS). REMS programs have additional compliance and reporting obligations.',
    `specialty_pharmacy_required` BOOLEAN COMMENT 'Indicates whether dispensing under this program must occur through a designated specialty pharmacy network. Relevant for REMS programs and high-cost biologics requiring cold-chain or controlled distribution.',
    `supply_terms` STRING COMMENT 'Description of the product supply terms under this program, including dispensing quantity, supply duration, dosage form, and whether supply is provided directly by the manufacturer or through a specialty pharmacy or CMO/CDMO partner.',
    `therapeutic_area` STRING COMMENT 'Clinical therapeutic area for which the program is designed (e.g., Oncology, Immunology, Rare Diseases). Used for portfolio-level market access reporting and HTA alignment.',
    CONSTRAINT pk_patient_access_program PRIMARY KEY(`patient_access_program_id`)
) COMMENT 'Master record for all patient support, early access, and pre-approval access programs designed to improve access to pharmaceutical products. Covers copay assistance programs, free drug programs, patient assistance programs (PAP), hub services, specialty pharmacy support, named patient programs, compassionate use, expanded access, early access programs (EAP), and managed access agreements. Captures program type, eligibility criteria, benefit cap, funding source, enrollment channel, regulatory authorization reference, supply terms, country, patient population, and program status. Bridges pre-approval access through commercial reimbursement and ongoing affordability support across the full product lifecycle.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` (
    `pricing_decision_id` BIGINT COMMENT 'Unique surrogate identifier for each formal pricing decision record in the master pricing decision table.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Pricing decisions are made within the context of market access strategies. One pricing decision supports one access strategy (1:N from access_strategy perspective). No columns to remove as pricing_dec',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Pricing decisions require country-specific regulatory constraints, international reference pricing baskets, reimbursement frameworks, and market access tier classifications for compliant pricing strat',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Pricing decisions incorporate regulatory exclusivity timelines to set launch prices, plan price erosion at LOE, and structure international reference pricing strategies. Exclusivity periods directly a',
    `hta_submission_id` BIGINT COMMENT 'Foreign key linking to market.hta_submission. Business justification: Pricing decisions are often informed by HTA outcomes, especially in markets with formal HTA-based pricing. One pricing decision may reference one HTA submission (1:N from hta_submission perspective). ',
    `market_country_id` BIGINT COMMENT 'Reference to the geographic market or country for which this pricing decision is applicable.',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (Drug Product/Drug Substance) for which this pricing decision applies.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Pricing strategies must account for patent protection duration to optimize lifecycle revenue, manage LOE transitions, and plan price erosion timelines. Patent expiry dates are mandatory inputs to pric',
    `payer_account_id` BIGINT COMMENT 'Reference to the payer, government authority, or channel entity for which this pricing decision is scoped. Nullable for list price decisions applicable to all payers.',
    `preceding_decision_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediately prior pricing decision that this record supersedes or amends. Enables full price history chain reconstruction for audit and IRP analysis.',
    `transfer_price_id` BIGINT COMMENT 'Foreign key linking to finance.transfer_price. Business justification: Intercompany pricing decisions must align with approved transfer pricing policies for tax compliance and arms length requirements. Market access teams need visibility to transfer price constraints wh',
    `approval_date` DATE COMMENT 'Date on which the pricing decision received formal internal governance approval from the approving authority. Distinct from effective_date (when it takes market effect).',
    `approving_authority` STRING COMMENT 'Name or designation of the internal governance body or individual (e.g., Global Pricing Committee, Regional Pricing Board, CFO, VP Market Access) that formally approved this pricing decision.',
    `atc_code` STRING COMMENT 'WHO Anatomical Therapeutic Chemical (ATC) classification code for the product at the 5th level (chemical substance level), used for cross-market pricing benchmarking and formulary positioning analysis.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `ceiling_price` DECIMAL(18,2) COMMENT 'Maximum approved price within the authorized price corridor above which the product must not be priced in this market. Prevents excessive pricing relative to IRP basket and regulatory constraints. Expressed in currency_code.',
    `channel_type` STRING COMMENT 'Distribution or sales channel to which this pricing decision applies, such as retail pharmacy, hospital formulary, government procurement, tender, specialty pharmacy, or direct-to-payer.. Valid values are `retail|hospital|government|tender|specialty_pharmacy|direct`',
    `corridor_breach_threshold_pct` DECIMAL(18,2) COMMENT 'Percentage deviation from the target price that triggers an automated corridor breach alert for proactive price erosion monitoring. For example, a value of 5.00 means a 5% deviation from target_price triggers an alert.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pricing decision record was first created in the system, in ISO 8601 format with timezone offset (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which all price values for this decision are denominated (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `decision_code` STRING COMMENT 'Externally-known alphanumeric business identifier for this pricing decision, formatted as PD-{country_code}-{year}-{sequence}. Used in cross-functional communications, regulatory submissions, and audit trails.. Valid values are `^PD-[A-Z]{2,3}-[0-9]{4}-[0-9]{5}$`',
    `decision_status` STRING COMMENT 'Current lifecycle state of the pricing decision. draft = under preparation; pending_approval = submitted for internal governance review; approved = formally approved but not yet effective; active = currently in force; superseded = replaced by a newer decision; withdrawn = cancelled before activation; expired = past effective period. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|superseded|withdrawn|expired — promote to reference product]',
    `decision_type` STRING COMMENT 'Classification of the pricing decision by the nature of the price change or establishment event. [ENUM-REF-CANDIDATE: launch_price|price_increase|price_decrease|price_correction|irp_adjustment|government_mandated|tender_price|access_program_price — promote to reference product]',
    `effective_date` DATE COMMENT 'Calendar date on which this pricing decision becomes operative and the approved prices take effect in the market. This is the principal business event date for the pricing decision.',
    `expiry_date` DATE COMMENT 'Calendar date on which this pricing decision ceases to be operative. Null indicates an open-ended decision with no scheduled expiry. Superseded decisions will have this populated upon replacement.',
    `floor_price` DECIMAL(18,2) COMMENT 'Minimum approved price within the authorized price corridor below which the product must not be sold in this market. Used for IRP management and cross-country price erosion prevention. Expressed in currency_code.',
    `government_reference_price` DECIMAL(18,2) COMMENT 'Officially approved or regulated price set by a government authority (e.g., NHS reference price, ASMR-based French price, German AMNOG price). Applicable in markets with statutory price regulation. Expressed in currency_code.',
    `gross_to_net_pct` DECIMAL(18,2) COMMENT 'Estimated gross-to-net adjustment percentage representing the aggregate deduction from WAC list price to net realized price, inclusive of all rebates, chargebacks, and mandatory discounts. Used for revenue forecasting and P&L management.',
    `irp_basket_countries` STRING COMMENT 'Pipe-delimited list of ISO 3166-1 alpha-3 country codes that constitute the IRP reference basket monitored for this pricing decision (e.g., DEU|FRA|GBR|ESP|ITA). Used to assess cross-country price erosion risk and inform launch sequencing.',
    `irp_constraint_flag` BOOLEAN COMMENT 'Indicates whether this pricing decision is constrained by International Reference Pricing (IRP) rules in the target market. True = IRP constraint applies; False = no IRP constraint.',
    `irp_reference_price` DECIMAL(18,2) COMMENT 'The IRP-derived price constraint calculated from the basket countries at the time of this decision. Represents the maximum price permissible under IRP rules for this market. Expressed in currency_code.',
    `launch_sequence_priority` STRING COMMENT 'Numeric priority rank assigned to this market in the global launch sequencing plan, where lower values indicate earlier launch. Used to optimize IRP risk by controlling the order of country launches.',
    `list_price_wac` DECIMAL(18,2) COMMENT 'Approved Wholesale Acquisition Cost (WAC) or ex-factory list price per unit for the product in the specified market and channel. This is the gross list price before any rebates, discounts, or government adjustments. Expressed in the currency defined by currency_code.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which the IRP basket and price corridor compliance are reviewed for this pricing decision. Drives scheduling of automated IRP monitoring workflows.. Valid values are `monthly|quarterly|semi_annual|annual|event_driven`',
    `ndc_code` STRING COMMENT 'US National Drug Code (NDC) in 5-4-2 format identifying the specific drug product, dosage form, and package size subject to this pricing decision. Applicable for US market decisions.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `net_price` DECIMAL(18,2) COMMENT 'Approved net price after application of mandatory rebates, statutory discounts, and government-mandated deductions. Represents the effective realized price per unit. Expressed in currency_code.',
    `pack_size_description` STRING COMMENT 'Human-readable description of the pack configuration to which this pricing decision applies (e.g., 30 tablets x 10mg, 1 vial x 100mg/10mL). Ensures unambiguous identification of the priced SKU.',
    `price_change_pct` DECIMAL(18,2) COMMENT 'Percentage change in list price (WAC) relative to the immediately preceding approved pricing decision for the same product, market, and channel. Positive values indicate a price increase; negative values indicate a price decrease.',
    `price_per_unit_type` STRING COMMENT 'Defines the unit basis on which all price values in this decision are expressed (e.g., per pack, per tablet, per vial, per mg of active pharmaceutical ingredient, per mL, per dose).. Valid values are `per_pack|per_tablet|per_vial|per_mg|per_ml|per_dose`',
    `pricing_rationale` STRING COMMENT 'Narrative justification for the pricing decision, documenting the strategic, clinical, health-economic, and competitive factors considered. Supports regulatory transparency requirements and internal audit.',
    `regulatory_submission_ref` STRING COMMENT 'Reference number of the regulatory submission (e.g., NDA, BLA, MAA, eCTD sequence) associated with this pricing decision. Links pricing to the regulatory approval that enables commercialization.',
    `reimbursement_status` STRING COMMENT 'Current reimbursement status of the product under this pricing decision in the target market. Determines patient access and payer coverage scope.. Valid values are `reimbursed|partially_reimbursed|not_reimbursed|pending|restricted`',
    `target_price` DECIMAL(18,2) COMMENT 'Optimal or target price within the approved price corridor, representing the commercially preferred price point balancing access, revenue, and IRP risk. Expressed in currency_code.',
    `therapeutic_area` STRING COMMENT 'Therapeutic area classification of the product subject to this pricing decision (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular). Used for portfolio-level pricing analytics and HTA benchmarking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this pricing decision record, in ISO 8601 format with timezone offset (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking and audit compliance.',
    CONSTRAINT pk_pricing_decision PRIMARY KEY(`pricing_decision_id`)
) COMMENT 'Master record for formal pricing decisions, approved price corridors, and international reference pricing (IRP) management for pharmaceutical products across markets and channels. Captures list price (WAC/ex-factory), government reference price, IRP constraints, price change type, effective date, approving authority, pricing rationale, and approved price corridors including floor price, target price, ceiling price, IRP basket countries, monitoring frequency, and corridor breach alert thresholds. Serves as the authoritative record of approved prices and price bands, enabling proactive management of cross-country price erosion risk and launch sequencing optimization.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` (
    `market_heor_study_id` BIGINT COMMENT 'Unique surrogate identifier for the HEOR study or evidence asset record within the market access domain. Primary key.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: HEOR studies are commissioned to generate evidence supporting specific market access strategies. One HEOR study supports one access strategy (1:N from access_strategy perspective). This eliminates heo',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: HEOR studies target specific country payer audiences and HTA bodies for evidence generation, requiring regulatory requirements, HTA submission standards, and reimbursement framework context. target_co',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: HEOR studies are project-based activities funded through internal orders, tracking costs for RWE data acquisition, economic modeling, CRO services, and publication fees. Required for budget management',
    `value_dossier_id` BIGINT COMMENT 'Foreign key linking to market.value_dossier. Business justification: HEOR studies (health economics and outcomes research) are evidence assets that feed into value dossiers used for payer negotiations and HTA submissions. A HEOR study is typically conducted to support ',
    `atc_code` STRING COMMENT 'WHO Anatomical Therapeutic Chemical (ATC) classification code for the drug product, used for formulary benchmarking and payer segmentation.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `brand_name` STRING COMMENT 'Proprietary brand name of the drug product under study, as approved by the relevant regulatory authority (FDA, EMA, etc.).',
    `budget_impact_year1` DECIMAL(18,2) COMMENT 'Projected net budget impact to the payer in Year 1 of the budget impact model, expressed in the currency defined by icur_currency_code. Key output for payer affordability assessments.',
    `budget_impact_year3` DECIMAL(18,2) COMMENT 'Projected net budget impact to the payer in Year 3 of the budget impact model, expressed in the currency defined by icur_currency_code. Represents the standard 3-year horizon used in US payer budget impact analyses.',
    `comparator_description` STRING COMMENT 'Description of the comparator treatment(s) used in the economic model or study (e.g., standard of care, active comparator INN, best supportive care), critical for HTA submissions and payer negotiations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the HEOR study record was first created in the system, used for audit trail and data lineage tracking.',
    `cro_vendor_name` STRING COMMENT 'Name of the external Contract Research Organization (CRO) or health economics consultancy engaged to conduct or validate the HEOR study, if applicable.',
    `data_use_agreement_ref` STRING COMMENT 'Reference number or identifier for the Data Use Agreement (DUA) governing the use of the real-world dataset, ensuring compliance with data licensing and privacy obligations.',
    `hta_body_name` STRING COMMENT 'Name of the Health Technology Assessment (HTA) body to which this HEOR evidence is being submitted (e.g., NICE, G-BA, HAS, CADTH, PBAC). Relevant for cost-effectiveness and cost-utility analyses.',
    `icd_code` STRING COMMENT 'ICD-10 diagnosis code corresponding to the target indication, enabling standardized cross-study and cross-payer comparisons.. Valid values are `^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$`',
    `icur_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the ICUR value (e.g., USD, GBP, EUR), ensuring correct interpretation of the economic model output across geographies.. Valid values are `^[A-Z]{3}$`',
    `icur_value` DECIMAL(18,2) COMMENT 'Incremental Cost-Utility Ratio (ICUR) expressed as cost per Quality-Adjusted Life Year (QALY) gained, the primary output of cost-utility analyses used in HTA submissions. Expressed in the currency defined by icur_currency_code.',
    `line_of_therapy` STRING COMMENT 'Treatment line for which the HEOR evidence is generated (e.g., first-line, second-line), a key driver of payer coverage decisions and formulary positioning.. Valid values are `first_line|second_line|third_line|adjuvant|neoadjuvant|maintenance`',
    `market_share_assumption_pct` DECIMAL(18,2) COMMENT 'Assumed market share percentage for the drug product used as the base case input in the budget impact model, reflecting expected uptake within the eligible patient population.',
    `model_version` STRING COMMENT 'Version identifier for the economic model or study protocol, tracking iterative updates submitted to payers or HTA bodies over the product lifecycle.. Valid values are `^v[0-9]+.[0-9]+(.[0-9]+)?$`',
    `model_version_date` DATE COMMENT 'Date on which the current model version was finalized and approved for use in payer submissions or HTA dossiers.',
    `patient_population_description` STRING COMMENT 'Narrative description of the patient population assumptions used in the model, including eligibility criteria, disease stage, line of therapy, and demographic assumptions.',
    `patient_population_size` STRING COMMENT 'Estimated number of eligible patients in the target population used as the base case assumption in the economic model, relevant for budget impact models and market sizing.',
    `product_inn` STRING COMMENT 'WHO-assigned International Nonproprietary Name (INN) of the drug product that is the subject of the HEOR study, used for global payer and HTA submissions.',
    `publication_reference` STRING COMMENT 'Citation or DOI reference for the peer-reviewed publication, congress abstract, or technical report associated with this HEOR study, enabling traceability from payer submissions to published evidence.',
    `qaly_gain` DECIMAL(18,2) COMMENT 'Estimated incremental Quality-Adjusted Life Years (QALYs) gained with the study treatment versus comparator, the primary effectiveness measure in cost-utility analyses for HTA submissions.',
    `rwd_data_source_type` STRING COMMENT 'Type of real-world data source used in the study (e.g., claims database, EHR, registry, patient-reported outcomes). Applicable for retrospective RWD studies and RWE generation. Null for purely modeled studies.. Valid values are `claims_database|ehr|registry|patient_reported_outcomes|chart_review|administrative_database`',
    `rwd_data_vendor` STRING COMMENT 'Name of the external data vendor or data provider supplying the real-world dataset (e.g., IQVIA, Optum, Truven, Flatiron Health). Relevant for data use agreement tracking and data provenance.',
    `rwd_data_vintage` STRING COMMENT 'Date range or vintage period of the real-world dataset used in the study (e.g., 2018-2022), indicating the temporal coverage of the underlying data and its currency for payer submissions.',
    `rwe_included` BOOLEAN COMMENT 'Indicates whether real-world evidence (RWE) is incorporated into this HEOR study or model, a key differentiator for payer submissions and HTA dossiers.',
    `study_code` STRING COMMENT 'Externally-known alphanumeric business identifier assigned to the HEOR study or evidence asset, used in payer submissions, HTA dossiers, and cross-functional references.. Valid values are `^HEOR-[A-Z0-9]{3,10}-[0-9]{4}$`',
    `study_completion_date` DATE COMMENT 'Date on which the HEOR study or model was completed and results were finalized, marking the end of the primary evidence generation phase.',
    `study_owner` STRING COMMENT 'Name or employee identifier of the HEOR team member or function responsible for the study, accountable for quality, timelines, and payer submission readiness.',
    `study_start_date` DATE COMMENT 'Date on which the HEOR study or model development was formally initiated, used for project tracking and timeline management.',
    `study_status` STRING COMMENT 'Current lifecycle status of the HEOR study or evidence asset, tracking progression from planning through completion and publication.. Valid values are `planned|in_progress|under_review|completed|published|archived`',
    `study_title` STRING COMMENT 'Full descriptive title of the HEOR study, model, or RWD/RWE dataset as it appears in publications, HTA submissions, or value dossiers.',
    `study_type` STRING COMMENT 'Classification of the HEOR evidence asset by methodological type. Drives analytical approach, model structure, and payer audience targeting. [ENUM-REF-CANDIDATE: budget_impact_model|cost_effectiveness_analysis|cost_utility_analysis|retrospective_rwd_study|pro_study|indirect_treatment_comparison — promote to reference product]. Valid values are `budget_impact_model|cost_effectiveness_analysis|cost_utility_analysis|retrospective_rwd_study|pro_study|indirect_treatment_comparison`',
    `target_indication` STRING COMMENT 'Specific disease indication or clinical condition for which the HEOR evidence is being generated, as used in regulatory submissions and payer negotiations.',
    `target_payer_audience` STRING COMMENT 'Primary payer segment or audience for whom the HEOR evidence asset is designed, guiding value messaging and submission strategy. [ENUM-REF-CANDIDATE: commercial_payer|medicare|medicaid|pbm|gpo|hta_body|integrated_delivery_network|self_insured_employer — promote to reference product]',
    `therapeutic_area` STRING COMMENT 'The disease or therapeutic area addressed by the HEOR study (e.g., Oncology, Immunology, Rare Diseases). Aligns with the companys portfolio therapeutic area taxonomy.',
    `time_horizon` STRING COMMENT 'Duration over which the economic model projects costs and outcomes (e.g., 5 years, lifetime, 10 years). A key structural assumption in cost-effectiveness and budget impact models.',
    `treatment_cost_input` DECIMAL(18,2) COMMENT 'Annual per-patient treatment cost used as the primary cost input in the economic model, expressed in the currency defined by icur_currency_code. Reflects WAC, net price, or negotiated price as specified in the model assumptions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the HEOR study record was last modified, supporting audit trail requirements and change management tracking.',
    CONSTRAINT pk_market_heor_study PRIMARY KEY(`market_heor_study_id`)
) COMMENT 'Master record for Health Economics and Outcomes Research (HEOR) evidence assets including studies, models, and real-world data (RWD) datasets used to support market access, payer negotiations, and HTA submissions. Captures study type (budget impact model, cost-effectiveness analysis, cost-utility analysis, retrospective RWD study, PRO study, indirect treatment comparison), therapeutic indication, target payer audience, study status, model version, patient population assumptions, comparator costs, time horizon, model outputs, publication reference, and budget impact model-specific attributes (market share assumptions, treatment cost inputs). Also manages the inventory of RWD/RWE datasets including data source type (claims database, EHR, registry, patient-reported outcomes), data vendor, data vintage, and data use agreements. SSOT for all HEOR evidence assets and RWD/RWE inventory within the market access domain.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` (
    `rwe_dataset_id` BIGINT COMMENT 'Unique surrogate identifier for the RWE/RWD dataset record. Primary key for the rwe_dataset product within the market access domain.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: RWE datasets are country-specific with data privacy regulations, HTA submission eligibility requirements, and regulatory compliance standards tracked in country master for evidence generation and paye',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: RWE datasets are procured from specialized data vendors (IQVIA, Optum, Flatiron) under licensing agreements. Pharmaceutical companies manage these as vendor relationships with contracts, audits, and c',
    `employee_id` BIGINT COMMENT 'Employee identifier of the internal business owner responsible for this datasets governance, DUA compliance, and fitness-for-purpose assessments within the Market Access or HEOR function.',
    `pass_study_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.pass_study. Business justification: Post-authorization safety studies (PASS) use real-world evidence datasets as data sources. PASS protocols specify RWE datasets (claims, EHR, registries) for safety endpoint assessment. Linking rwe_dat',
    `privacy_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_impact_assessment. Business justification: GDPR Article 35 requires Data Protection Impact Assessments (DPIA) for high-risk processing of health data. RWE datasets processing patient data at scale require DPIA; linking ensures each dataset has',
    `privacy_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_obligation. Business justification: RWE datasets contain patient-level data subject to GDPR (EU), HIPAA (US), and other privacy regulations. Each dataset must be mapped to applicable privacy obligations to ensure lawful processing, rete',
    `safety_signal_id` BIGINT COMMENT 'Foreign key linking to pharmacovigilance.safety_signal. Business justification: Real-world evidence datasets are used to validate or refute safety signals. Signal validation studies analyze RWE data to confirm signal causality, estimate incidence rates, and identify risk factors.',
    `access_restriction_notes` STRING COMMENT 'Free-text notes describing any access restrictions, embargoes, or special conditions governing use of this dataset beyond the standard DUA terms. Confidential as it may contain contractual details.',
    `annual_license_cost` DECIMAL(18,2) COMMENT 'Annual cost of the data license or subscription fee paid to the data vendor for access to this dataset. Confidential as it reflects vendor pricing terms. Used in HEOR budget planning and ROI assessments.',
    `atc_code` STRING COMMENT 'WHO Anatomical Therapeutic Chemical classification code for the primary drug or therapeutic class covered by the dataset. Enables cross-dataset comparisons and HTA alignment.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RWE dataset record was first created in the system. Supports audit trail requirements under 21 CFR Part 11 and data governance lineage tracking.',
    `data_end_date` DATE COMMENT 'Latest date of patient data or clinical events captured in the dataset. Together with data_start_date defines the data vintage window. Payers assess recency of evidence based on this field.',
    `data_quality_assessment_date` DATE COMMENT 'Date on which the most recent internal data quality assessment was completed for this dataset. Determines whether the quality tier classification is current and valid.',
    `data_quality_tier` STRING COMMENT 'Internal quality classification of the dataset based on completeness, accuracy, and fitness-for-purpose assessments: gold (highest quality, validated for regulatory submissions), silver (good quality, suitable for payer negotiations), bronze (exploratory use only).. Valid values are `gold|silver|bronze`',
    `data_refresh_frequency` STRING COMMENT 'Frequency at which the dataset is updated with new data from the vendor: monthly, quarterly, semi_annual, annual, one_time (static snapshot), ad_hoc. Informs evidence currency for ongoing payer negotiations.. Valid values are `monthly|quarterly|semi_annual|annual|one_time|ad_hoc`',
    `data_start_date` DATE COMMENT 'Earliest date of patient data or clinical events captured in the dataset. Defines the temporal boundary of the data vintage for payer and HTA evidence assessments.',
    `dataset_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the dataset, used in payer submissions, HTA dossiers, and HEOR study references. Follows the RWE-XXXX naming convention.. Valid values are `^RWE-[A-Z0-9]{4,12}$`',
    `dataset_name` STRING COMMENT 'Human-readable title of the RWD/RWE dataset (e.g., US Oncology Claims Database 2019-2023). Used in value dossiers, HTA submissions, and payer negotiations.',
    `dataset_status` STRING COMMENT 'Current lifecycle status of the dataset asset: active (available for use), archived (historical, no longer updated), under_review (undergoing quality or legal review), restricted (access limited pending DUA resolution), expired (data use agreement lapsed).. Valid values are `active|archived|under_review|restricted|expired`',
    `dataset_type` STRING COMMENT 'Classification of the data source type: claims (insurance claims database), ehr (Electronic Health Record), registry (disease or product registry), pro (Patient-Reported Outcomes), rct_extension (RCT long-term extension), administrative (hospital/government administrative data), other. [ENUM-REF-CANDIDATE: claims|ehr|registry|pro|rct_extension|administrative|other — promote to reference product]',
    `de_identification_method` STRING COMMENT 'Method used to de-identify patient data in the dataset: safe_harbor (HIPAA Safe Harbor), expert_determination (HIPAA Expert Determination), pseudonymized (GDPR pseudonymization), aggregated (summary-level only), not_applicable (non-patient data). Critical for HIPAA and GDPR compliance.. Valid values are `safe_harbor|expert_determination|pseudonymized|aggregated|not_applicable`',
    `dua_expiry_date` DATE COMMENT 'Date on which the Data Use Agreement for this dataset expires. Triggers renewal workflow to ensure continued compliant access. Datasets with expired DUAs must not be used in active payer submissions.',
    `dua_reference_number` STRING COMMENT 'Reference number of the executed Data Use Agreement governing access to and permitted use of this dataset. Confidential as it contains contractual terms. Required for compliance with HIPAA, GDPR, and vendor contractual obligations.',
    `geographic_scope` STRING COMMENT 'Breadth of geographic coverage of the dataset: national (single country), regional (sub-national region), multi_country (multiple countries), global (worldwide coverage). Informs applicability for specific payer markets.. Valid values are `national|regional|multi_country|global`',
    `heor_study_reference` STRING COMMENT 'Reference code or identifier linking this dataset to the primary HEOR study or analysis plan that utilizes it. Enables traceability from dataset asset to published evidence.',
    `hta_submission_eligible` BOOLEAN COMMENT 'Indicates whether this dataset has been assessed and approved for use in HTA submissions (e.g., NICE, G-BA, HAS, CADTH). True = eligible; False = not eligible or pending review.',
    `icd_code` STRING COMMENT 'ICD-10 or ICD-11 diagnosis code corresponding to the primary indication covered by the dataset. Enables standardized cross-referencing with clinical and payer data.. Valid values are `^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$`',
    `license_cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the annual_license_cost (e.g., USD, EUR, GBP). Required for multi-currency financial reporting and budget consolidation.. Valid values are `^[A-Z]{3}$`',
    `line_of_therapy` STRING COMMENT 'Treatment line context captured in the dataset (1L = first-line, 2L = second-line, 3L+ = third-line or later, any = all lines, not_applicable). Aligns with payer formulary positioning and HTA comparator requirements.. Valid values are `1L|2L|3L+|any|not_applicable`',
    `linked_value_dossier_code` STRING COMMENT 'Business code of the value dossier in which this dataset is cited as supporting evidence. Provides traceability between the RWD/RWE asset inventory and HTA/payer submission documents.',
    `patient_count` STRING COMMENT 'Total number of unique patients included in the dataset. Key metric for payers and HTA bodies assessing statistical power and representativeness of the evidence.',
    `patient_population_description` STRING COMMENT 'Narrative description of the patient population captured in the dataset, including inclusion/exclusion criteria, line of therapy, age range, and comorbidity profile. Critical for payer and HTA assessors evaluating generalizability.',
    `payer_negotiation_eligible` BOOLEAN COMMENT 'Indicates whether this dataset is approved for use in direct payer contract negotiations and rebate discussions. True = eligible; False = not approved for payer use.',
    `permitted_use_scope` STRING COMMENT 'Description of the contractually permitted uses of the dataset as defined in the DUA (e.g., internal HEOR analysis only, payer submissions, HTA submissions, publication). Confidential as it reflects contractual terms with the data vendor.',
    `primary_endpoint_type` STRING COMMENT 'Primary clinical or economic endpoint measurable from this dataset: os (Overall Survival), pfs (Progression-Free Survival), orr (Objective Response Rate), qol (Quality of Life), heor (Health Economics and Outcomes Research), safety (adverse event profiling), utilization (healthcare resource utilization), other. [ENUM-REF-CANDIDATE: os|pfs|orr|qol|heor|safety|utilization|other — promote to reference product]',
    `publication_allowed` BOOLEAN COMMENT 'Indicates whether the DUA permits publication of analyses derived from this dataset in peer-reviewed journals or conference proceedings. True = publication permitted; False = internal use only.',
    `rwe_study_design` STRING COMMENT 'Epidemiological study design applied to generate evidence from this dataset: retrospective_cohort, prospective_cohort, case_control, cross_sectional, chart_review, other. Determines the level of evidence accepted by HTA bodies and payers. [ENUM-REF-CANDIDATE: retrospective_cohort|prospective_cohort|case_control|cross_sectional|chart_review|other — promote to reference product]. Valid values are `retrospective_cohort|prospective_cohort|case_control|cross_sectional|chart_review|other`',
    `target_indication` STRING COMMENT 'Specific disease indication or clinical condition the dataset is intended to support (e.g., Non-Small Cell Lung Cancer, Rheumatoid Arthritis). Used to match datasets to payer negotiation and HTA submission needs.',
    `therapeutic_area` STRING COMMENT 'Primary therapeutic area covered by the dataset (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular). Aligns with the companys therapeutic area taxonomy for cross-domain reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this RWE dataset record was last modified. Supports audit trail requirements under 21 CFR Part 11 and change management tracking for data governance.',
    CONSTRAINT pk_rwe_dataset PRIMARY KEY(`rwe_dataset_id`)
) COMMENT 'Master record for real-world data (RWD) and real-world evidence (RWE) datasets used in payer negotiations, HTA submissions, and HEOR analyses. Captures data source type (claims database, EHR, registry, patient-reported outcomes), data vendor, therapeutic area, patient population, data vintage, and data use agreements. SSOT for RWD/RWE asset inventory within the market access domain.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` (
    `payer_engagement_id` BIGINT COMMENT 'Unique surrogate identifier for each payer engagement record in the market access domain. Primary key for this transactional entity.',
    `access_strategy_id` BIGINT COMMENT 'Reference to the market access strategy that this engagement supports or is aligned to.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the primary market access account manager responsible for this payer relationship and engagement.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Payer engagements occur in specific countries requiring regulatory compliance context, HTA body details, and reimbursement framework knowledge for compliant customer interactions and transparency repo',
    `disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_disclosure. Business justification: Payer engagements (advisory boards, consulting arrangements, speaker programs) constitute transfers of value requiring transparency disclosure. Each engagement must be reported; linking to disclosure ',
    `hta_submission_id` BIGINT COMMENT 'Foreign key linking to market.hta_submission. Business justification: Payer engagements often center on discussing HTA submission outcomes, evidence packages, and reimbursement implications of HTA decisions. Currently payer_engagement has value_dossier_id but no link to',
    `market_payer_contract_id` BIGINT COMMENT 'Reference to an active or prospective payer contract associated with this engagement, if applicable. Null for pre-contract or exploratory engagements.',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (drug substance or finished dosage form) that is the primary subject of the payer engagement discussion.',
    `payer_account_id` BIGINT COMMENT 'Reference to the payer organization involved in this engagement (e.g., health plan, PBM, GPO, government payer). Links to the payer account master.',
    `value_dossier_id` BIGINT COMMENT 'Reference to the value dossier or HTA submission document that was presented or referenced during this engagement.',
    `commitments_made` STRING COMMENT 'Description of any formal or informal commitments made by either party during the engagement (e.g., data provision, follow-up analysis, contract term adjustments). Confidential negotiation record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payer engagement record was first created in the system, in ISO 8601 format with timezone offset. Supports audit trail and data lineage.',
    `discussion_topics` STRING COMMENT 'Structured summary of the key topics discussed during the engagement, such as formulary positioning, rebate terms, outcomes-based contract parameters, HEOR evidence, or RWE data sharing.',
    `engagement_channel` STRING COMMENT 'Mode of interaction through which the engagement was conducted. Supports channel analytics and compliance documentation requirements.. Valid values are `in_person|virtual|telephone|hybrid`',
    `engagement_code` STRING COMMENT 'Externally referenceable business identifier for the engagement, formatted as PE-{YYYY}-{NNNNNN}. Used in correspondence, CRM records, and meeting minutes.. Valid values are `^PE-[0-9]{4}-[0-9]{6}$`',
    `engagement_date` DATE COMMENT 'The actual calendar date on which the engagement took place (or is scheduled to take place). Principal real-world event date for this transaction.',
    `engagement_end_time` TIMESTAMP COMMENT 'Precise date and time when the engagement session concluded. Used together with start time to compute meeting duration.',
    `engagement_location` STRING COMMENT 'Physical or virtual location of the engagement (e.g., payer headquarters city, conference venue name, or virtual platform name such as Teams or Zoom).',
    `engagement_outcome` STRING COMMENT 'Overall qualitative outcome assessment of the engagement from the market access teams perspective. Used for pipeline scoring and account strategy adjustment.. Valid values are `positive|neutral|negative|pending|inconclusive`',
    `engagement_start_time` TIMESTAMP COMMENT 'Precise date and time when the engagement session began, in ISO 8601 format with timezone offset. Used for scheduling, duration calculation, and audit.',
    `engagement_status` STRING COMMENT 'Current lifecycle state of the engagement record, tracking progression from planning through completion or cancellation.. Valid values are `planned|confirmed|in_progress|completed|cancelled|rescheduled`',
    `engagement_type` STRING COMMENT 'Classification of the engagement by its primary business purpose. Drives workflow, required documentation, and follow-up obligations. [ENUM-REF-CANDIDATE: formulary_committee_meeting|medical_policy_review|rebate_negotiation|outcomes_based_contract_discussion|advisory_board|account_planning_meeting|value_dossier_presentation|hta_discussion|copay_program_review — promote to reference product]. Valid values are `formulary_committee_meeting|medical_policy_review|rebate_negotiation|outcomes_based_contract_discussion|advisory_board|account_planning_meeting`',
    `follow_up_actions` STRING COMMENT 'Documented list of action items arising from the engagement, including owner, description, and target completion date. Drives post-engagement workflow.',
    `follow_up_completed` BOOLEAN COMMENT 'Indicates whether all follow-up actions arising from this engagement have been completed. True = all actions closed; False = open actions remain.',
    `follow_up_due_date` DATE COMMENT 'Target date by which all follow-up actions from this engagement must be completed. Used for SLA tracking and account management reporting.',
    `formulary_tier_discussed` STRING COMMENT 'The formulary tier position (e.g., Tier 1, Tier 2, Preferred Specialty) that was discussed or targeted during this engagement. Supports formulary access tracking.',
    `heor_evidence_presented_flag` BOOLEAN COMMENT 'Indicates whether Health Economics and Outcomes Research (HEOR) evidence (e.g., cost-effectiveness models, budget impact analyses, QoL data) was formally presented during the engagement.',
    `indication` STRING COMMENT 'The specific disease indication or clinical use case being discussed during the engagement (e.g., first-line non-small cell lung cancer). Supports indication-level access tracking.',
    `internal_attendees` STRING COMMENT 'Comma-separated list of company-side attendees including market access managers, medical science liaisons (MSL), HEOR leads, and account directors.',
    `key_messages_delivered` STRING COMMENT 'Summary of the approved value messages and clinical/economic evidence presented to the payer during the engagement. Supports message tracking and compliance review.',
    `meeting_minutes_ref` STRING COMMENT 'Reference identifier or URL to the formal meeting minutes document stored in the document management system (e.g., Veeva Vault). Supports audit trail and compliance documentation.',
    `negotiation_stage` STRING COMMENT 'Current stage of the payer negotiation lifecycle associated with this engagement. Supports pipeline tracking and forecasting of gross-to-net revenue impact. [ENUM-REF-CANDIDATE: pre_engagement|initial_discussion|proposal_presented|counter_proposal|final_negotiation|agreement_reached|closed — 7 candidates stripped; promote to reference product]',
    `next_engagement_planned_date` DATE COMMENT 'Planned date for the next scheduled engagement with this payer account, as agreed or anticipated at the close of this engagement.',
    `outcomes_contract_discussed_flag` BOOLEAN COMMENT 'Indicates whether an outcomes-based or value-based contract arrangement was discussed during this engagement. Supports value-based contracting pipeline tracking.',
    `payer_attendees` STRING COMMENT 'Comma-separated list of names and titles of payer-side attendees (e.g., P&T committee members, medical directors, pharmacy directors). Stored as free text; structured attendee data managed in CRM.',
    `payer_position_summary` STRING COMMENT 'Narrative summary of the payers stated position, concerns, or feedback expressed during the engagement. Confidential negotiation intelligence used for account strategy.',
    `rebate_discussed_flag` BOOLEAN COMMENT 'Indicates whether rebate terms or rebate structures were a topic of discussion during this engagement. True = rebate discussed; False = not discussed.',
    `rwe_data_discussed_flag` BOOLEAN COMMENT 'Indicates whether Real-World Evidence (RWE) or Real-World Data (RWD) was presented or discussed as part of the payer engagement. Supports RWE utilization tracking.',
    `source_system_engagement_code` STRING COMMENT 'Original identifier of this engagement record in the upstream CRM or market access system (e.g., Salesforce Health Cloud activity ID or Veeva CRM call record ID). Supports data lineage and reconciliation.',
    `therapeutic_area` STRING COMMENT 'The therapeutic area (e.g., Oncology, Immunology, Rare Diseases) that is the primary subject of the engagement. Aligns with the companys portfolio segmentation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this payer engagement record. Used for change tracking, data freshness monitoring, and audit compliance.',
    CONSTRAINT pk_payer_engagement PRIMARY KEY(`payer_engagement_id`)
) COMMENT 'Transactional record of formal and informal engagements between the market access team and payer organizations. Captures engagement type (formulary committee meeting, medical policy review, rebate negotiation session, outcomes-based contract discussion, advisory board), payer account, attendees, discussion topics, commitments made, and follow-up actions. Supports payer relationship management and negotiation tracking.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` (
    `reimbursement_policy_id` BIGINT COMMENT 'Unique surrogate identifier for the reimbursement policy record. Primary key for the reimbursement_policy data product within the market access domain.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Reimbursement policies are country-specific with local HTA bodies, regulatory authorities, and reimbursement frameworks tracked in country master for policy interpretation and market access strategy. ',
    `hta_submission_id` BIGINT COMMENT 'Foreign key linking to market.hta_submission. Business justification: Reimbursement policies are informed by HTA submission outcomes. One reimbursement policy may reference one HTA submission (1:N from hta_submission perspective). Columns to remove: hta_body_code and ht',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (drug substance or finished dosage form) to which this reimbursement policy applies.',
    `payer_account_id` BIGINT COMMENT 'Reference to the payer, government health authority, or formulary committee that issued this reimbursement policy. Links to the payer_account master record.',
    `superseded_by_policy_id` BIGINT COMMENT 'Reference to the newer reimbursement policy record that replaces this one when a policy is revised or superseded. Enables policy lineage tracking and coverage change audit trails.',
    `appeal_decision_date` DATE COMMENT 'The date on which the payer or health authority issued a final decision on the appeal of this reimbursement policy. Null if no appeal has been filed or if the appeal is still pending.',
    `appeal_status` STRING COMMENT 'Current status of any formal appeal filed against a negative or restrictive coverage decision under this policy. Tracks the appeal lifecycle for coverage decision audit trails and access gap remediation.. Valid values are `not_appealed|appeal_pending|appeal_granted|appeal_denied|appeal_withdrawn`',
    `coverage_restriction_type` STRING COMMENT 'Categorical classification of the primary access restriction imposed by this policy beyond standard PA or step therapy (e.g., specialty pharmacy dispensing only, site-of-care restriction to hospital outpatient, age or gender restriction). [ENUM-REF-CANDIDATE: specialty_pharmacy|site_of_care|age_restriction|gender_restriction|diagnosis_restriction|prescriber_restriction|none — 7 candidates stripped; promote to reference product]',
    `coverage_status` STRING COMMENT 'Current coverage determination status of the pharmaceutical product under this policy. Indicates whether the product is reimbursed, excluded, conditionally covered, or under review by the payer or health authority.. Valid values are `covered|not_covered|covered_with_restrictions|pending_review|appealed|withdrawn`',
    `covered_indication` STRING COMMENT 'The approved therapeutic indication(s) for which the product is covered under this policy. Specifies the disease, condition, or patient population eligible for reimbursement (e.g., metastatic non-small cell lung cancer, first-line therapy).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this reimbursement policy record was first created in the data platform. Supports audit trail, data lineage, and compliance reporting requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code applicable to the reimbursement rate and any monetary values within this policy (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `decision_authority` STRING COMMENT 'Name of the body, committee, or organization that issued the coverage decision (e.g., CMS, NICE, G-BA, HAS, AIFA, P&T Committee). Identifies the authoritative source of the reimbursement determination.',
    `decision_date` DATE COMMENT 'The date on which the payer, health authority, or formulary committee issued the official coverage determination for this policy. Key audit and compliance timestamp for market access tracking.',
    `effective_from_date` DATE COMMENT 'The date from which this reimbursement policy becomes binding and governs coverage and reimbursement for the product. Used for access gap analysis and policy change monitoring.',
    `effective_until_date` DATE COMMENT 'The date on which this reimbursement policy expires or is superseded. Null for open-ended policies with no defined end date. Used for policy change monitoring and coverage landscape tracking.',
    `excluded_population` STRING COMMENT 'Description of patient subgroups or clinical scenarios explicitly excluded from coverage under this policy (e.g., pediatric patients under 18, patients with prior EGFR mutation therapy). Critical for access gap analysis.',
    `geographic_scope` STRING COMMENT 'The geographic level at which this reimbursement policy applies. Distinguishes national coverage determinations from regional, state/provincial, or plan-level policies for coverage landscape analysis.. Valid values are `national|regional|state_provincial|plan_level|local`',
    `icd_code` STRING COMMENT 'ICD-10 diagnosis code corresponding to the covered indication under this reimbursement policy. Used for claims adjudication, coverage verification, and access gap analysis.. Valid values are `^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$`',
    `line_of_therapy` STRING COMMENT 'The treatment line for which coverage is granted under this policy (e.g., first-line, second-line). Directly impacts patient access and market share for oncology and specialty products.. Valid values are `first_line|second_line|third_line|adjuvant|maintenance|any_line`',
    `patient_access_program_flag` BOOLEAN COMMENT 'Indicates whether a patient access program (e.g., copay assistance, free drug program, hub services) is available to support patients subject to restrictions under this reimbursement policy.',
    `payer_segment` STRING COMMENT 'The payer market segment to which this reimbursement policy belongs. Used for segmented coverage analysis, gross-to-net management, and market access strategy alignment. [ENUM-REF-CANDIDATE: commercial|medicare|medicaid|tricare|va|private_insurance|government — 7 candidates stripped; promote to reference product]',
    `policy_name` STRING COMMENT 'Human-readable name or title of the reimbursement policy as issued by the payer or health authority (e.g., Medicare Part D Coverage Policy for Oncology Agents).',
    `policy_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned by the payer or health authority to uniquely identify this reimbursement policy. Used for cross-referencing with payer portals and regulatory submissions.',
    `policy_status` STRING COMMENT 'Current lifecycle state of the reimbursement policy record. Distinguishes active policies governing current reimbursement from superseded, expired, or draft policies.. Valid values are `active|inactive|superseded|draft|under_review|expired`',
    `policy_type` STRING COMMENT 'Classification of the reimbursement policy by its scope and mechanism. Distinguishes national coverage determinations, regional policies, plan-level formulary decisions, prior authorization criteria, step therapy requirements, and quantity limit policies. [ENUM-REF-CANDIDATE: national_coverage|regional_coverage|plan_level_coverage|formulary_decision|individual_coverage_determination|prior_authorization|step_therapy|quantity_limit — promote to reference product]',
    `policy_version` STRING COMMENT 'Version identifier for this reimbursement policy, used to track revisions and amendments over time. Enables policy change monitoring and historical coverage decision audit trails.',
    `prior_authorization_criteria` STRING COMMENT 'Detailed clinical and administrative criteria that must be satisfied to obtain prior authorization for reimbursement under this policy (e.g., documented failure of two prior lines of therapy, oncologist attestation required).',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required from the payer before the product can be dispensed and reimbursed under this policy. Key utilization management restriction tracked for market access.',
    `quantity_limit_days` STRING COMMENT 'The number of days supply to which the quantity limit applies under this policy (e.g., 30-day supply, 90-day supply). Used in conjunction with quantity_limit_value for adjudication.',
    `quantity_limit_flag` BOOLEAN COMMENT 'Indicates whether this reimbursement policy imposes quantity limits on the amount of product that can be dispensed per fill or per defined time period.',
    `quantity_limit_value` DECIMAL(18,2) COMMENT 'The maximum quantity of product (in dispensing units) permitted per fill or per defined period under this policys quantity limit restriction.',
    `reimbursement_rate` DECIMAL(18,2) COMMENT 'The reimbursement rate or allowed amount established by this policy, expressed as a percentage of list price, a fixed fee schedule amount, or an ASP-based rate. Confidential commercial data used for gross-to-net revenue management.',
    `reimbursement_rate_basis` STRING COMMENT 'The pricing methodology or benchmark used to calculate the reimbursement rate under this policy (e.g., ASP+6%, WAC-based, fee schedule, negotiated price). Critical for gross-to-net revenue management and payer contracting.. Valid values are `asp_plus_pct|wac_pct|fee_schedule|negotiated_price|drg_bundled|capitation`',
    `rems_required` BOOLEAN COMMENT 'Indicates whether the product covered under this policy is subject to an FDA-mandated Risk Evaluation and Mitigation Strategy (REMS), which may impose additional dispensing or monitoring requirements affecting reimbursement.',
    `source_system_policy_code` STRING COMMENT 'The native identifier for this reimbursement policy record in the originating operational system (e.g., Veeva Vault RIM, RIMS, or payer portal). Supports data lineage and reconciliation with source systems.',
    `step_therapy_criteria` STRING COMMENT 'Specification of the required prior therapy steps that must be documented before coverage is granted under this policy (e.g., must fail metformin and a sulfonylurea before coverage of GLP-1 agonist).',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether step therapy (fail-first) requirements apply under this policy, mandating that patients try and fail one or more alternative therapies before the product is covered.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this reimbursement policy record was most recently modified in the data platform. Supports change detection, audit trail, and compliance reporting.',
    CONSTRAINT pk_reimbursement_policy PRIMARY KEY(`reimbursement_policy_id`)
) COMMENT 'Master record for reimbursement policies and coverage decisions issued by payers, government health authorities, and formulary committees for pharmaceutical products. Captures policy type, coverage status, covered indications, excluded populations, prior authorization criteria, step therapy requirements, quantity limits, coverage restrictions, decision authority, decision date, appeal status, policy effective dates, and individual coverage determination records. Records both the ongoing policy framework governing reimbursement and specific point-in-time coverage decisions at national, regional, or plan level. SSOT for all coverage and reimbursement policy data within the market access domain. Enables access gap analysis, policy change monitoring, coverage landscape tracking, and coverage decision audit trails.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` (
    `tender_submission_id` BIGINT COMMENT 'Unique surrogate identifier for each pharmaceutical tender submission record in the silver layer lakehouse.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Tender awards generate receivables from government payers and hospital systems. Finance must track AR by tender contract for payment collection, aging analysis, and revenue recognition under long-term',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: Tender submissions bid brand pricing for government/institutional contracts. Tender management and pricing strategy process requires linking tender records to brands for tracking win rates and competi',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Tender submissions target country-specific procurement authorities and regulatory requirements, requiring regulatory framework, market classification, and compliance standards for competitive bidding ',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Tender authorities evaluate regulatory exclusivity when assessing bid pricing, contract duration alignment, and long-term supply security. Exclusivity periods inform tender evaluation criteria and awa',
    `access_strategy_id` BIGINT COMMENT 'Reference to the market access strategy that governs the pricing, reimbursement, and competitive positioning approach for this tender submission.',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (drug product or drug substance) being submitted in this tender.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Tender submissions reference patent status to justify pricing vs. generic alternatives, demonstrate differentiation, and establish contract duration alignment. Patent protection is a competitive diffe',
    `payer_account_id` BIGINT COMMENT 'Reference to the payer account representing the tender authority, government procurement body, hospital group, or national health system that issued the tender.',
    `pricing_decision_id` BIGINT COMMENT 'Foreign key linking to market.pricing_decision. Business justification: Tender submissions are made at prices that may be informed by formal pricing decisions. One tender submission may reference one pricing decision (1:N from pricing_decision perspective). No columns to ',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Tender submissions to government payers require anti-corruption compliance (FCPA, UK Bribery Act) and third-party due diligence. Compliance program oversight ensures tender processes follow anti-bribe',
    `appeal_deadline_date` DATE COMMENT 'Deadline date by which the company must file an appeal or standstill challenge against a non-award decision. Critical for legal and regulatory compliance in tender-driven markets.',
    `atc_code` STRING COMMENT 'WHO Anatomical Therapeutic Chemical (ATC) classification code assigned to the tendered product, used for formulary positioning, cross-market benchmarking, and regulatory alignment in tender submissions.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `award_decision_date` DATE COMMENT 'Date on which the tender authority communicated the award decision (awarded or not awarded) for this submission. Used for tender cycle time analytics and market access reporting.',
    `award_status` STRING COMMENT 'Outcome of the tender evaluation indicating whether the submission was awarded, not awarded, partially awarded, pending decision, or under appeal. Core field for awarded tender tracking and win/loss analytics.. Valid values are `awarded|not_awarded|partial_award|pending|appealed`',
    `awarded_unit_price` DECIMAL(18,2) COMMENT 'Final unit price confirmed in the tender award, which may differ from the submitted unit price following negotiation or price adjustment by the tender authority. Used for gross-to-net revenue management.',
    `awarded_volume` DECIMAL(18,2) COMMENT 'Actual volume of product units awarded by the tender authority, which may differ from the committed volume in cases of partial awards or volume adjustments. Expressed in the same unit of measure as committed_volume.',
    `committed_volume` DECIMAL(18,2) COMMENT 'Volume of product units committed by the company in the tender submission, expressed in the unit of measure specified by the tender authority (e.g., packs, vials, doses). Used for supply chain planning and awarded tender tracking.',
    `competitor_lowest_price` DECIMAL(18,2) COMMENT 'Lowest competitor unit price identified during tender intelligence gathering, expressed in the tender currency. Used for competitive benchmarking and tender strategy calibration.',
    `contract_duration_months` STRING COMMENT 'Duration of the awarded tender contract expressed in months. Used for tender strategy planning, supply chain forecasting, and revenue recognition scheduling.',
    `contract_end_date` DATE COMMENT 'Expiry date of the awarded tender contract. Defines the end of the supply obligation period and triggers renewal or re-tendering activities.',
    `contract_start_date` DATE COMMENT 'Effective start date of the awarded tender contract. Marks the beginning of the supply obligation period for awarded tenders.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this tender submission record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the prices submitted in the tender (e.g., EUR, USD, BRL, JPY). Required for multi-market tender benchmarking and gross-to-net revenue management.. Valid values are `^[A-Z]{3}$`',
    `dosage_form` STRING COMMENT 'Pharmaceutical dosage form of the tendered product (e.g., tablet, capsule, injection, infusion, patch). Captured as submitted in the tender dossier and aligned with the marketing authorisation.',
    `inn_name` STRING COMMENT 'International Nonproprietary Name (INN) of the active pharmaceutical ingredient (API) as designated by the WHO. Used in tender documents to identify the molecule independent of brand name.',
    `ndc_code` STRING COMMENT 'National Drug Code (NDC) assigned by the FDA to uniquely identify the drug product, labeler, and package configuration submitted in the tender. Applicable for US-market tenders.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `net_submitted_price` DECIMAL(18,2) COMMENT 'Net price per unit after applying any confidential discounts, rebates, or price adjustments included in the tender submission. Represents the effective price used for gross-to-net revenue management and tender strategy analytics.',
    `pack_size` STRING COMMENT 'Pack size or presentation of the tendered product (e.g., 30 tablets, 10 vials x 10 mL). Corresponds to the Stock Keeping Unit (SKU) submitted in the tender and used for volume commitment calculations.',
    `price_benchmark_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the reference country used for international reference pricing (IRP) benchmarking in this tender submission. Supports cross-market price corridor management.. Valid values are `^[A-Z]{3}$`',
    `strength` STRING COMMENT 'Strength or concentration of the active pharmaceutical ingredient (API) in the tendered product (e.g., 10 mg, 500 mg/5 mL). Captured as per the marketing authorisation and tender specification.',
    `submission_date` DATE COMMENT 'Date on which the tender submission was formally submitted to the tender authority. Represents the principal business event timestamp for this transaction.',
    `submission_notes` STRING COMMENT 'Free-text field for capturing additional context, conditions, or qualifications associated with the tender submission, such as supply contingencies, regulatory approval dependencies, or special pricing conditions.',
    `submission_owner` STRING COMMENT 'Name or employee identifier of the market access or tender management professional responsible for preparing and submitting this tender. Supports accountability and escalation workflows.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the tender submission, tracking progression from internal drafting through submission to the tender authority and final award decision. [ENUM-REF-CANDIDATE: draft|submitted|under_review|awarded|not_awarded|withdrawn|disqualified — promote to reference product]',
    `submitted_unit_price` DECIMAL(18,2) COMMENT 'The per-unit price submitted by the company in the tender bid, expressed in the tender currency. This is the gross list price offered to the tender authority before any volume-based adjustments or confidential rebates.',
    `tender_authority_name` STRING COMMENT 'Full legal name of the government procurement authority, national health system, hospital group, or purchasing organization that issued the tender (e.g., NHS England, AIFA, Ministry of Health Brazil).',
    `tender_authority_type` STRING COMMENT 'Classification of the tender-issuing body, distinguishing between national health systems, government ministries, hospital groups, regional procurement authorities, Group Purchasing Organizations (GPO), and Pharmacy Benefit Managers (PBM).. Valid values are `national_health_system|government_ministry|hospital_group|regional_authority|gpo|pbm`',
    `tender_lot_number` STRING COMMENT 'Lot or line number within a multi-lot tender, identifying the specific product or therapeutic category lot to which this submission applies. Enables granular tracking within complex multi-product tenders.',
    `tender_opening_date` DATE COMMENT 'Date on which the tender authority officially opens and evaluates submitted bids. Marks the transition from submission to evaluation phase in the tender lifecycle.',
    `tender_reference_number` STRING COMMENT 'Externally assigned reference number issued by the tender authority to uniquely identify the tender lot or procurement event. Used for cross-referencing with government procurement portals and tender authority communications.',
    `tender_type` STRING COMMENT 'Procurement procedure type used by the tender authority (e.g., open, restricted, negotiated, framework agreement, direct award). Determines the competitive dynamics and submission requirements.. Valid values are `open|restricted|negotiated|framework_agreement|direct_award`',
    `therapeutic_area` STRING COMMENT 'Therapeutic area classification of the product being tendered (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular). Aligns with the companys portfolio segmentation for tender strategy management.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this tender submission record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking, audit compliance, and incremental data loading in the silver layer.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for the committed volume in the tender submission (e.g., pack, vial, dose, unit, kg, liter). Ensures consistent volume reporting across tender markets.. Valid values are `pack|vial|dose|unit|kg|liter`',
    CONSTRAINT pk_tender_submission PRIMARY KEY(`tender_submission_id`)
) COMMENT 'Records pharmaceutical tender submissions made to government procurement authorities, hospital groups, and national health systems in tender-driven markets (e.g., EU, LATAM, APAC). Captures tender authority, product, submitted price, volume commitment, tender award status, contract duration, and tender reference number. Supports tender strategy management and awarded tender tracking.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` (
    `outcomes_based_contract_id` BIGINT COMMENT 'Unique surrogate identifier for the outcomes-based contract record in the Databricks Silver Layer. Primary key for this master agreement entity.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Outcomes-based contracts trigger rebate payables when performance thresholds are not met. Finance must accrue liabilities based on outcome measurements and process payments per contract reconciliation',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Outcomes-based contracts require country-specific legal jurisdiction, regulatory compliance frameworks, and data privacy regulations for contract execution, performance measurement, and data sharing a',
    `market_heor_study_id` BIGINT COMMENT 'Foreign key linking to market.market_heor_study. Business justification: Outcomes-based contracts (value-based agreements, risk-sharing arrangements) are typically supported by HEOR evidence that defines the outcome metrics, thresholds, and measurement methodology. Current',
    `market_payer_contract_id` BIGINT COMMENT 'Reference to the parent commercial payer contract under which this outcomes-based arrangement is structured, enabling linkage to base rebate terms.',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (drug product or biologic) that is the subject of this outcomes-based contract.',
    `payer_account_id` BIGINT COMMENT 'Reference to the payer account (health plan, PBM, GPO, or government payer) that is party to this outcomes-based contract.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Outcomes-based contracts carry compliance risk (off-label promotion, kickback concerns, data sharing). Compliance program review ensures contracts are structured within regulatory boundaries and outco',
    `rwe_dataset_id` BIGINT COMMENT 'Foreign key linking to market.rwe_dataset. Business justification: Outcomes-based contracts rely on RWE datasets for performance measurement and reconciliation. One OBC uses one primary RWE dataset (1:N from rwe_dataset perspective). Column to remove: data_source_nam',
    `base_rebate_pct` DECIMAL(18,2) COMMENT 'Baseline rebate percentage guaranteed to the payer regardless of outcome performance, expressed as a percentage of net sales. Forms the floor of the rebate schedule.',
    `contract_name` STRING COMMENT 'Descriptive business name for this outcomes-based contract, typically referencing the payer, product, and indication (e.g., BlueCross Oncology OBC – Product X 2024).',
    `contract_number` STRING COMMENT 'Externally-known unique alphanumeric identifier assigned to this outcomes-based contract, used in payer communications, reconciliation invoices, and regulatory filings.',
    `contract_owner` STRING COMMENT 'Name or employee identifier of the Market Access or Managed Care team member responsible for managing this outcomes-based contract and overseeing reconciliation.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the outcomes-based contract: draft (being negotiated), active (in force), suspended (temporarily paused), under_reconciliation (measurement period closed, reconciliation in progress), closed (completed), terminated (ended early).. Valid values are `draft|active|suspended|under_reconciliation|closed|terminated`',
    `contract_type` STRING COMMENT 'Classification of the innovative contracting arrangement: outcomes_based (rebate tied to clinical outcome), value_based (rebate tied to economic value), risk_sharing (shared financial risk), pay_for_performance (payment contingent on performance), coverage_with_evidence (conditional coverage pending RWE). [ENUM-REF-CANDIDATE: outcomes_based|value_based|risk_sharing|pay_for_performance|coverage_with_evidence|indication_based — promote to reference product]. Valid values are `outcomes_based|value_based|risk_sharing|pay_for_performance|coverage_with_evidence`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this outcomes-based contract record was first created in the system, used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this contract (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `data_sharing_agreement_flag` BOOLEAN COMMENT 'Indicates whether a formal data sharing agreement (DSA) is in place with the payer to enable access to claims or EHR data required for outcome measurement.',
    `data_source_type` STRING COMMENT 'Type of real-world data source used to measure outcomes: claims_data (medical/pharmacy claims), ehr_data (electronic health records), registry_data (disease registry), rwe_rwd (real-world evidence/data), clinical_trial (trial data), payer_database (payer-specific database).. Valid values are `claims_data|ehr_data|registry_data|rwe_rwd|clinical_trial|payer_database`',
    `effective_end_date` DATE COMMENT 'Date on which the outcomes-based contract expires or is scheduled to terminate. Nullable for open-ended arrangements.',
    `effective_start_date` DATE COMMENT 'Date on which the outcomes-based contract becomes legally binding and outcome measurement obligations commence.',
    `execution_date` DATE COMMENT 'Date on which all parties formally signed and executed the outcomes-based contract, establishing legal enforceability.',
    `governing_law_jurisdiction` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction whose laws govern this contract (e.g., USA, GBR, DEU). Determines applicable regulatory and legal framework.. Valid values are `^[A-Z]{3}$`',
    `icd_code` STRING COMMENT 'ICD-10 diagnosis code corresponding to the target indication for which outcomes are measured, enabling standardized clinical data linkage.. Valid values are `^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$`',
    `max_rebate_pct` DECIMAL(18,2) COMMENT 'Maximum rebate percentage payable to the payer if outcome performance falls to the worst-case scenario, expressed as a percentage of net sales. Forms the ceiling of the rebate schedule.',
    `measurement_methodology` STRING COMMENT 'Detailed description of the methodology used to measure the outcome metric, including patient identification criteria, data collection approach, statistical method, and adjudication process.',
    `measurement_period_end_date` DATE COMMENT 'End date of the current or most recent outcome measurement period, after which observed outcomes are locked for reconciliation.',
    `measurement_period_months` STRING COMMENT 'Duration in months of each outcome measurement period over which patient cohort outcomes are observed and aggregated before reconciliation is triggered.',
    `measurement_period_start_date` DATE COMMENT 'Start date of the current or most recent outcome measurement period for which data collection and patient cohort tracking is active.',
    `most_favored_nation_clause` BOOLEAN COMMENT 'Indicates whether this outcomes-based contract includes a Most Favored Nation (MFN) clause, requiring that the payer receives terms no less favorable than those offered to any other payer.',
    `observed_outcome_rate` DECIMAL(18,2) COMMENT 'Actual measured value of the outcome metric for the patient cohort during the measurement period (e.g., observed ORR of 0.58 or 58%). Compared against performance_threshold_value to determine rebate adjustment.',
    `outcome_metric_name` STRING COMMENT 'Name of the primary clinical or economic outcome metric used to evaluate contract performance (e.g., Overall Response Rate, Progression-Free Survival at 12 months, Hospital Readmission Rate, HbA1c Reduction).',
    `outcome_metric_type` STRING COMMENT 'Classification of the outcome metric: clinical (e.g., ORR, OS, PFS), economic (e.g., cost per QALY, hospitalization cost), patient_reported (e.g., QoL score), or composite (combination of multiple endpoints).. Valid values are `clinical|economic|patient_reported|composite`',
    `patient_cohort_size` STRING COMMENT 'Number of eligible patients included in the outcome measurement cohort for the measurement period, used to validate statistical significance and rebate calculation.',
    `performance_threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value for the outcome metric that triggers rebate adjustments. For example, an ORR threshold of 0.65 (65%) or a PFS threshold of 12.0 months. Compared against observed outcome rate during reconciliation.',
    `rebate_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary value of the rebate adjustment triggered by outcome performance variance, expressed in the contract currency. Used for gross-to-net revenue management and financial accruals.',
    `rebate_adjustment_pct` DECIMAL(18,2) COMMENT 'Incremental rebate percentage adjustment triggered by the observed outcome variance from threshold. Applied on top of the base rebate to compute the total rebate owed for the measurement period.',
    `reconciliation_frequency` STRING COMMENT 'Frequency at which outcome measurements are reconciled and rebate adjustments are calculated and invoiced to the payer (monthly, quarterly, semi-annual, annual).. Valid values are `monthly|quarterly|semi_annual|annual`',
    `reconciliation_lag_days` STRING COMMENT 'Number of days after the measurement period end date allowed for data collection, outcome adjudication, and reconciliation completion before rebate payment is due.',
    `rwe_study_reference` STRING COMMENT 'Reference identifier or protocol number of the Real-World Evidence (RWE) or Real-World Data (RWD) study that underpins the outcome measurement methodology for this contract.',
    `target_indication` STRING COMMENT 'Specific disease indication or approved label for which outcomes are being measured under this contract (e.g., Non-Small Cell Lung Cancer – 1L).',
    `therapeutic_area` STRING COMMENT 'Therapeutic area covered by this contract (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular), aligning with the companys portfolio taxonomy.',
    `threshold_direction` STRING COMMENT 'Specifies whether the observed outcome must be above, below, or equal to the threshold to meet the performance target (e.g., above for ORR, below for readmission rate).. Valid values are `above|below|equal`',
    `threshold_unit` STRING COMMENT 'Unit of measure for the performance threshold value (e.g., percentage, months, score, events_per_100_patients, USD).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this outcomes-based contract record was last modified, supporting audit trail requirements and change management tracking.',
    `variance_from_threshold` DECIMAL(18,2) COMMENT 'Calculated difference between the observed outcome rate and the performance threshold value (observed minus threshold). Positive values indicate outperformance; negative values indicate underperformance triggering rebate adjustment.',
    CONSTRAINT pk_outcomes_based_contract PRIMARY KEY(`outcomes_based_contract_id`)
) COMMENT 'Master record for outcomes-based, value-based, or risk-sharing agreements negotiated with payers where rebates or payments are contingent on demonstrated real-world clinical or economic outcomes. Captures outcome metric definition, measurement methodology, data source, performance thresholds, rebate adjustment schedule, measurement period, and reconciliation process. Also records transactional outcome measurements including observed outcome rates per measurement period, patient cohort sizes, variance from thresholds, and resulting rebate adjustment triggers. Supports the growing portfolio of innovative contracting arrangements with full measurement-to-reconciliation traceability.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` (
    `kol_engagement_plan_id` BIGINT COMMENT 'Unique system-generated identifier for the KOL engagement plan record. Primary key for the association.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to the market access strategy for which this KOL engagement is planned',
    `employee_id` BIGINT COMMENT 'Reference to the employee (typically market access lead or medical affairs director) responsible for managing this KOL engagement plan.',
    `hcp_kol_profile_id` BIGINT COMMENT 'Foreign key linking to the Key Opinion Leader being engaged as part of this access strategy',
    `actual_activity_count` STRING COMMENT 'Actual number of completed engagement activities for this KOL within this access strategy. Used to track execution against plan and calculate engagement effectiveness.',
    `actual_end_date` DATE COMMENT 'Actual date when engagement activities with this KOL for this access strategy were completed or terminated. Nullable for ongoing engagements.',
    `actual_spend_amount` DECIMAL(18,2) COMMENT 'Actual amount spent on this KOL engagement within this access strategy. Used to track budget utilization and ROI.',
    `actual_start_date` DATE COMMENT 'Actual date when engagement activities with this KOL for this access strategy commenced. Used to track execution against plan.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Budget amount allocated for this specific KOL engagement within this access strategy. Covers honoraria, travel, publication support, and other engagement-related expenses.',
    `budget_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the allocated engagement budget.',
    `effectiveness_score` DECIMAL(18,2) COMMENT 'Quantitative assessment of the effectiveness of this KOLs engagement within this specific access strategy, measured on a scale (e.g., 0-100). Based on activity completion, impact on access outcomes, and strategic objective achievement.',
    `engagement_tier` STRING COMMENT 'Strategic priority level for this specific KOL engagement within the context of this access strategy. Tier 1 represents highest strategic importance with dedicated resources and frequent touchpoints.',
    `enrollment_date` DATE COMMENT 'Date when the KOL was formally enrolled or committed to participate in this access strategy. Marks the beginning of the planned engagement relationship.',
    `kol_engagement_plan_status` STRING COMMENT 'Current lifecycle status of this KOL engagement plan. Tracks whether the engagement is in planning, actively executing, paused, successfully completed, or prematurely terminated.',
    `kol_role_in_strategy` STRING COMMENT 'The specific role or function the KOL is expected to fulfill within this access strategy. Defines the nature of the engagement and the type of activities planned.',
    `notes` STRING COMMENT 'Free-text notes capturing strategic rationale, special considerations, or execution details specific to this KOL engagement within this access strategy.',
    `planned_end_date` DATE COMMENT 'Target date for completing planned engagement activities with this KOL for this access strategy. May be extended based on strategy lifecycle.',
    `planned_start_date` DATE COMMENT 'Target date for initiating engagement activities with this KOL for this access strategy. Used for resource planning and timeline coordination.',
    `target_activity_count` STRING COMMENT 'Planned number of engagement activities (advisory boards, speaking engagements, publications, etc.) for this KOL within this access strategy during the planning period.',
    CONSTRAINT pk_kol_engagement_plan PRIMARY KEY(`kol_engagement_plan_id`)
) COMMENT 'This association product represents the strategic engagement plan between a market access strategy and a Key Opinion Leader (KOL). It captures the specific role, engagement tier, activity targets, and effectiveness metrics for each KOLs participation in a given access strategy. Each record links one access_strategy to one hcp_kol_profile with attributes that exist only in the context of this strategic engagement relationship.. Existence Justification: In pharmaceutical market access operations, a single access strategy (e.g., launch strategy for a new oncology drug in Germany) engages multiple KOLs across different roles (advisory board members, HTA expert witnesses, publication authors, congress speakers), and each prominent KOL participates in multiple access strategies across different products, indications, and geographies. The business actively manages these engagements as KOL Engagement Plans with specific roles, activity targets, budgets, and effectiveness tracking for each strategy-KOL combination.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` (
    `study_data_sourcing_id` BIGINT COMMENT 'Unique surrogate identifier for this study-dataset sourcing relationship record',
    `employee_id` BIGINT COMMENT 'Employee identifier of the HEOR analyst or data manager who created this sourcing relationship record.',
    `last_modified_by_employee_id` BIGINT COMMENT 'Employee identifier of the person who last modified this sourcing relationship record.',
    `market_heor_study_id` BIGINT COMMENT 'Foreign key linking to the HEOR study that uses this RWE dataset',
    `rwe_dataset_id` BIGINT COMMENT 'Foreign key linking to the RWE dataset used in this HEOR study',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this study-dataset sourcing relationship record was created in the system.',
    `data_contribution_type` STRING COMMENT 'The type of evidence or data element this dataset contributes to the study (efficacy outcomes, safety data, cost inputs, healthcare utilization patterns, quality of life measures, or epidemiological parameters). Explicitly identified in detection reasoning.',
    `data_extraction_date` DATE COMMENT 'Date on which data was extracted from this RWE dataset for use in the study. Important for regulatory documentation and understanding which data refresh was used.',
    `data_vintage_used` STRING COMMENT 'The specific data vintage or version of the RWE dataset that was used in this study (e.g., 2022Q4, v3.2). Critical for model reproducibility and regulatory compliance, as dataset content changes over time. Explicitly identified in detection reasoning.',
    `exclusion_reason` STRING COMMENT 'If sourcing_status is excluded or replaced, captures the business reason (e.g., insufficient sample size, data quality issues, licensing constraints). Required for audit trail.',
    `inclusion_date` DATE COMMENT 'Date on which this RWE dataset was formally incorporated into the HEOR study protocol or model. Used for audit trail and model version control. Explicitly identified in detection reasoning.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this sourcing relationship record.',
    `patient_count_contributed` STRING COMMENT 'Number of patients from this dataset that were included in the study analysis after applying study-specific inclusion/exclusion criteria. May differ from the total patient count in the dataset. Explicitly identified in detection reasoning.',
    `primary_dataset_flag` BOOLEAN COMMENT 'Indicates whether this is the primary/main dataset for the study (true) or a supplementary/supporting dataset (false). Each study typically has one primary dataset. Explicitly identified in detection reasoning.',
    `sourcing_status` STRING COMMENT 'Current status of this dataset sourcing relationship in the study lifecycle (planned for use, data extraction in progress, completed and incorporated, excluded from final analysis, or replaced by alternative dataset).',
    `study_role` STRING COMMENT 'The role this dataset plays in the HEOR study (primary data source, secondary/supplementary source, validation dataset, sensitivity analysis input, or comparator arm data). Explicitly identified in detection reasoning.',
    CONSTRAINT pk_study_data_sourcing PRIMARY KEY(`study_data_sourcing_id`)
) COMMENT 'This association product represents the data sourcing relationship between HEOR studies and RWE datasets. It captures which real-world evidence datasets are used in which HEOR studies, including the role of the dataset in the study, the specific data vintage used, and the contribution characteristics. Each record links one HEOR study to one RWE dataset with attributes that exist only in the context of this specific data sourcing relationship, enabling tracking of dataset reuse across studies and supporting regulatory compliance requirements for model reproducibility.. Existence Justification: In pharmaceutical market access operations, HEOR studies routinely integrate multiple RWE datasets (claims, EMR, registries) to generate comprehensive evidence, and strategic RWE datasets are reused across multiple studies to maximize ROI on expensive data acquisition costs. The business actively manages this relationship as Study Data Sourcing with specific attributes (dataset role, contribution type, vintage used, patient counts) that belong to neither the study nor the dataset alone but to each specific study-dataset pairing. This is an operational relationship that HEOR teams create, track, and query for regulatory compliance and model reproducibility.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`formulary` (
    `formulary_id` BIGINT COMMENT 'Primary key for formulary',
    `payer_account_id` BIGINT COMMENT 'Reference to the payer organization (health plan, insurance company, government program) that owns or sponsors this formulary.',
    `pbm_id` BIGINT COMMENT 'Reference to the pharmacy benefit manager responsible for administering this formulary on behalf of the payer.',
    `market_payer_contract_id` BIGINT COMMENT 'Reference to the rebate contract governing manufacturer rebates for drugs included in this formulary.',
    `parent_formulary_id` BIGINT COMMENT 'Self-referencing FK on formulary (parent_formulary_id)',
    `compliance_certification_date` DATE COMMENT 'The date on which the formulary was certified as compliant with applicable regulatory and legal requirements.',
    `copay_structure` STRING COMMENT 'The cost-sharing structure applied to drugs in this formulary (e.g., flat copayment, percentage coinsurance, deductible-based, or mixed model).',
    `coverage_region` STRING COMMENT 'Geographic region(s) where the formulary is applicable, represented as comma-separated ISO 3166-1 alpha-3 country codes or state/province codes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this formulary record was first created in the system.',
    `effective_date` DATE COMMENT 'The date on which the formulary becomes active and enforceable for coverage and reimbursement decisions.',
    `exclusion_list_url` STRING COMMENT 'URL link to the published list of drugs excluded from coverage under this formulary.',
    `expiration_date` DATE COMMENT 'The date on which the formulary ceases to be active. Nullable for open-ended formularies.',
    `formulary_code` STRING COMMENT 'Unique alphanumeric code assigned to the formulary for external identification and system integration.',
    `formulary_document_url` STRING COMMENT 'URL link to the official formulary document or drug list published for member and provider access.',
    `formulary_name` STRING COMMENT 'The official name or title of the formulary as recognized by payers, pharmacy benefit managers (PBM), or health systems.',
    `formulary_status` STRING COMMENT 'Current lifecycle status of the formulary indicating whether it is actively in use, pending approval, under review, suspended, or archived.',
    `formulary_type` STRING COMMENT 'Classification of the formulary based on the payer segment or market it serves (e.g., commercial insurance, Medicare Part D, Medicaid, health exchange, employer-sponsored, hospital, specialty pharmacy).',
    `generic_substitution_policy` STRING COMMENT 'Policy governing whether and how generic drugs may be substituted for brand-name drugs under this formulary.',
    `gpo_affiliation` STRING COMMENT 'Name or identifier of the group purchasing organization affiliated with this formulary for negotiating drug pricing and contracting.',
    `gross_to_net_adjustment_rate` DECIMAL(18,2) COMMENT 'The average percentage adjustment rate applied to gross drug prices to calculate net revenue after rebates, discounts, and other deductions for this formulary. Expressed as a percentage.',
    `hta_submission_required` BOOLEAN COMMENT 'Indicates whether health technology assessment submissions are required for drugs to be considered for inclusion in this formulary.',
    `last_review_date` DATE COMMENT 'The date on which the formulary was last reviewed and updated by the pharmacy and therapeutics (P&T) committee or equivalent body.',
    `mail_order_available` BOOLEAN COMMENT 'Indicates whether mail-order pharmacy services are available for drugs covered under this formulary.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this formulary record was last modified or updated.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next formulary review and update cycle.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the formulary.',
    `patient_access_program_linked` BOOLEAN COMMENT 'Indicates whether patient access programs (copay assistance, patient support services) are linked to drugs covered under this formulary.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether prior authorization is required for any drugs on this formulary before coverage is approved.',
    `quantity_limits_applied` BOOLEAN COMMENT 'Indicates whether quantity limits (maximum dispensing quantities per prescription or time period) are enforced on drugs in this formulary.',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval for this formulary by relevant health authorities or government agencies (e.g., CMS approval for Medicare Part D formularies).',
    `rwe_data_considered` BOOLEAN COMMENT 'Indicates whether real-world evidence and real-world data are considered in formulary decision-making and drug evaluations.',
    `specialty_pharmacy_required` BOOLEAN COMMENT 'Indicates whether certain drugs on this formulary must be dispensed through a specialty pharmacy network.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether step therapy (trial of lower-cost alternatives before higher-cost drugs) is mandated by this formulary.',
    `therapeutic_categories_covered` STRING COMMENT 'Comma-separated list of therapeutic categories or drug classes covered by this formulary (e.g., oncology, immunology, cardiovascular, diabetes).',
    `tier_structure` STRING COMMENT 'The tiering model used by the formulary to classify drugs by cost-sharing level (e.g., generic, preferred brand, non-preferred brand, specialty).',
    `value_dossier_required` BOOLEAN COMMENT 'Indicates whether a value dossier (comprehensive evidence package demonstrating clinical and economic value) is required for formulary inclusion.',
    `version_number` STRING COMMENT 'Version identifier for the formulary, following semantic versioning convention (e.g., 1.0, 2.1, 3.0.1) to track changes over time.',
    CONSTRAINT pk_formulary PRIMARY KEY(`formulary_id`)
) COMMENT 'Master reference table for formulary. Referenced by formulary_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`pbm` (
    `pbm_id` BIGINT COMMENT 'Primary key for pbm',
    `parent_pbm_id` BIGINT COMMENT 'Self-referencing FK on pbm (parent_pbm_id)',
    `accumulator_adjustment_program` BOOLEAN COMMENT 'Indicates whether the PBM implements accumulator adjustment programs that exclude manufacturer copay assistance from patient out-of-pocket maximums.',
    `claims_processing_system` STRING COMMENT 'Name of the primary claims adjudication and processing system used by the PBM.',
    `contract_end_date` DATE COMMENT 'The date when the current contract with the PBM is scheduled to expire or terminate.',
    `contract_renewal_date` DATE COMMENT 'The date by which contract renewal negotiations must be completed or the contract will auto-renew.',
    `contract_start_date` DATE COMMENT 'The date when the pharmaceutical companys contractual relationship with the PBM became effective.',
    `copay_assistance_acceptance` STRING COMMENT 'The PBMs policy regarding acceptance of manufacturer copay assistance programs for patients.',
    `covered_lives_count` BIGINT COMMENT 'Total number of individuals covered under pharmacy benefit plans managed by this PBM.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this PBM record was first created in the system.',
    `data_sharing_agreement` BOOLEAN COMMENT 'Indicates whether a data sharing agreement exists between the pharmaceutical company and the PBM for real-world evidence and utilization data.',
    `data_source` STRING COMMENT 'The name of the source system or data provider from which this PBM information was obtained.',
    `electronic_prior_auth_enabled` BOOLEAN COMMENT 'Indicates whether the PBM supports electronic prior authorization submission and processing.',
    `formulary_tier_structure` STRING COMMENT 'The tiering model used by the PBM to categorize drugs and assign patient cost-sharing levels.',
    `headquarters_address` STRING COMMENT 'Primary business address of the PBM headquarters location.',
    `headquarters_city` STRING COMMENT 'City where the PBM headquarters is located.',
    `headquarters_country` STRING COMMENT 'Three-letter ISO country code for the PBM headquarters location.',
    `headquarters_postal_code` STRING COMMENT 'ZIP or postal code for the PBM headquarters address.',
    `headquarters_state` STRING COMMENT 'Two-letter state code for the PBM headquarters location.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this PBM record was most recently modified.',
    `mail_order_service` BOOLEAN COMMENT 'Indicates whether the PBM offers mail order pharmacy services for maintenance medications.',
    `market_share_percentage` DECIMAL(18,2) COMMENT 'Estimated percentage of the total pharmacy benefit management market controlled by this PBM.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the PBM relationship and strategic considerations.',
    `parent_organization` STRING COMMENT 'Name of the parent company or holding organization that owns or controls the PBM.',
    `pbm_code` STRING COMMENT 'Standardized alphanumeric code used to identify the PBM in transactions and reporting systems.',
    `pbm_name` STRING COMMENT 'Official legal name of the pharmacy benefit manager organization.',
    `pbm_type` STRING COMMENT 'Classification of the PBM based on its operational model and service scope.',
    `preferred_network_status` STRING COMMENT 'Classification of the PBMs pharmacy network preference level for the pharmaceutical companys products.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the PBM.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the PBM for pharmaceutical company relations.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the PBM business contact.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether the PBM requires prior authorization for certain drug categories or high-cost medications.',
    `real_time_benefit_check_enabled` BOOLEAN COMMENT 'Indicates whether the PBM supports real-time benefit check functionality at the point of prescribing.',
    `rebate_model` STRING COMMENT 'The rebate structure model used by the PBM for manufacturer rebate negotiations and pass-through to plan sponsors.',
    `specialty_pharmacy_network` BOOLEAN COMMENT 'Indicates whether the PBM operates or contracts with a specialty pharmacy network for high-cost or complex medications.',
    `pbm_status` STRING COMMENT 'Current operational status of the PBM relationship in the pharmaceutical companys market access ecosystem.',
    `step_therapy_program` BOOLEAN COMMENT 'Indicates whether the PBM implements step therapy protocols requiring patients to try lower-cost alternatives before higher-cost drugs.',
    `utilization_management_level` STRING COMMENT 'The intensity of utilization management controls applied by the PBM, including prior authorization, step therapy, and quantity limits.',
    CONSTRAINT pk_pbm PRIMARY KEY(`pbm_id`)
) COMMENT 'Master reference table for pbm. Referenced by pbm_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` (
    `pharmacy_id` BIGINT COMMENT 'Primary key for pharmacy',
    `org_unit_id` BIGINT COMMENT 'Identifier of the parent organization or pharmacy chain to which this pharmacy belongs, if applicable.',
    `pbm_id` BIGINT COMMENT 'Identifier assigned by the pharmacy benefit manager for network participation and claims routing.',
    `parent_pharmacy_id` BIGINT COMMENT 'Self-referencing FK on pharmacy (parent_pharmacy_id)',
    `address_line_1` STRING COMMENT 'Primary street address line of the pharmacy location including street number and name.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, unit, or building information.',
    `city` STRING COMMENT 'City or municipality where the pharmacy is located.',
    `contract_effective_date` DATE COMMENT 'Date when the pharmacy contract or network participation agreement became effective.',
    `contract_expiration_date` DATE COMMENT 'Date when the pharmacy contract or network participation agreement expires or is scheduled for renewal.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the pharmacy is located.',
    `credentialing_status` STRING COMMENT 'Current status of the pharmacys credentialing and verification process for network participation.',
    `dea_number` STRING COMMENT 'DEA registration number authorizing the pharmacy to handle controlled substances. Two letters followed by seven digits.',
    `dispensing_fee_amount` DECIMAL(18,2) COMMENT 'Standard dispensing fee amount paid to the pharmacy per prescription filled, in USD.',
    `doing_business_as_name` STRING COMMENT 'Trade name or DBA name under which the pharmacy operates if different from legal name.',
    `drive_through_available` BOOLEAN COMMENT 'Indicates whether the pharmacy offers drive-through prescription pickup service.',
    `email_address` STRING COMMENT 'Primary email address for pharmacy communications and electronic correspondence.',
    `fax_number` STRING COMMENT 'Fax number for prescription and document transmission.',
    `formulary_participation` BOOLEAN COMMENT 'Indicates whether the pharmacy participates in formulary-based reimbursement programs and accepts formulary restrictions.',
    `gpo_affiliation` STRING COMMENT 'Name or identifier of the group purchasing organization with which the pharmacy is affiliated for procurement advantages.',
    `home_delivery_available` BOOLEAN COMMENT 'Indicates whether the pharmacy offers home delivery service for prescriptions.',
    `immunization_services` BOOLEAN COMMENT 'Indicates whether the pharmacy provides immunization and vaccination services.',
    `last_credentialing_date` DATE COMMENT 'Date when the pharmacy last completed credentialing verification and approval process.',
    `medication_therapy_management` BOOLEAN COMMENT 'Indicates whether the pharmacy offers medication therapy management services for optimizing drug therapy and improving therapeutic outcomes.',
    `ncpdp_number` STRING COMMENT 'Seven-digit unique identifier assigned to each pharmacy by the National Council for Prescription Drug Programs for prescription processing and billing.',
    `network_tier` STRING COMMENT 'Tier classification within the pharmacy benefit network determining reimbursement rates and patient cost-sharing levels.',
    `next_credentialing_date` DATE COMMENT 'Scheduled date for the next credentialing review and renewal.',
    `npi_number` STRING COMMENT 'Ten-digit unique identification number issued by the National Plan and Provider Enumeration System (NPPES) for healthcare providers in the United States.',
    `operating_hours` STRING COMMENT 'Standard operating hours of the pharmacy including days and times of operation.',
    `pharmacy_name` STRING COMMENT 'Legal business name of the pharmacy as registered with regulatory authorities.',
    `pharmacy_status` STRING COMMENT 'Current operational and regulatory status of the pharmacy in the network.',
    `pharmacy_type` STRING COMMENT 'Classification of pharmacy based on operational model and service delivery channel.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the pharmacy.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the pharmacy location. US format supports 5-digit or ZIP+4.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pharmacy record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this pharmacy record was last modified or updated.',
    `reimbursement_rate_schedule` STRING COMMENT 'Code identifying the reimbursement rate schedule or fee schedule applicable to this pharmacy for claims adjudication.',
    `specialty_accreditation` BOOLEAN COMMENT 'Indicates whether the pharmacy holds specialty pharmacy accreditation from recognized bodies such as URAC or ACHC for handling high-cost, complex medications.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the pharmacy is located.',
    `three_forty_b_eligible` BOOLEAN COMMENT 'Indicates whether the pharmacy is eligible to participate in the 340B Drug Pricing Program for discounted pharmaceutical pricing.',
    `twenty_four_hour_service` BOOLEAN COMMENT 'Indicates whether the pharmacy provides 24-hour service availability.',
    CONSTRAINT pk_pharmacy PRIMARY KEY(`pharmacy_id`)
) COMMENT 'Master reference table for pharmacy. Referenced by dispensing_pharmacy_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ADD CONSTRAINT `fk_market_payer_account_parent_payer_account_id` FOREIGN KEY (`parent_payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ADD CONSTRAINT `fk_market_market_formulary_position_coverage_decision_id` FOREIGN KEY (`coverage_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`coverage_decision`(`coverage_decision_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ADD CONSTRAINT `fk_market_market_formulary_position_formulary_id` FOREIGN KEY (`formulary_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`formulary`(`formulary_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ADD CONSTRAINT `fk_market_market_formulary_position_market_payer_contract_id` FOREIGN KEY (`market_payer_contract_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_payer_contract`(`market_payer_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ADD CONSTRAINT `fk_market_market_formulary_position_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ADD CONSTRAINT `fk_market_market_formulary_position_pbm_id` FOREIGN KEY (`pbm_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pbm`(`pbm_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ADD CONSTRAINT `fk_market_hta_submission_market_heor_study_id` FOREIGN KEY (`market_heor_study_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_heor_study`(`market_heor_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ADD CONSTRAINT `fk_market_value_dossier_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ADD CONSTRAINT `fk_market_market_payer_contract_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ADD CONSTRAINT `fk_market_market_payer_contract_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_market_payer_contract_id` FOREIGN KEY (`market_payer_contract_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_payer_contract`(`market_payer_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ADD CONSTRAINT `fk_market_rebate_claim_pbm_id` FOREIGN KEY (`pbm_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pbm`(`pbm_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_pharmacy_id` FOREIGN KEY (`pharmacy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pharmacy`(`pharmacy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_market_payer_contract_id` FOREIGN KEY (`market_payer_contract_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_payer_contract`(`market_payer_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ADD CONSTRAINT `fk_market_gross_to_net_adjustment_rebate_claim_id` FOREIGN KEY (`rebate_claim_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`rebate_claim`(`rebate_claim_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_hta_submission_id` FOREIGN KEY (`hta_submission_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`hta_submission`(`hta_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ADD CONSTRAINT `fk_market_coverage_decision_reimbursement_policy_id` FOREIGN KEY (`reimbursement_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ADD CONSTRAINT `fk_market_patient_access_program_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_hta_submission_id` FOREIGN KEY (`hta_submission_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`hta_submission`(`hta_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ADD CONSTRAINT `fk_market_pricing_decision_preceding_decision_id` FOREIGN KEY (`preceding_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pricing_decision`(`pricing_decision_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ADD CONSTRAINT `fk_market_market_heor_study_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ADD CONSTRAINT `fk_market_market_heor_study_value_dossier_id` FOREIGN KEY (`value_dossier_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`value_dossier`(`value_dossier_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_hta_submission_id` FOREIGN KEY (`hta_submission_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`hta_submission`(`hta_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_market_payer_contract_id` FOREIGN KEY (`market_payer_contract_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_payer_contract`(`market_payer_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ADD CONSTRAINT `fk_market_payer_engagement_value_dossier_id` FOREIGN KEY (`value_dossier_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`value_dossier`(`value_dossier_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ADD CONSTRAINT `fk_market_reimbursement_policy_hta_submission_id` FOREIGN KEY (`hta_submission_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`hta_submission`(`hta_submission_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ADD CONSTRAINT `fk_market_reimbursement_policy_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ADD CONSTRAINT `fk_market_reimbursement_policy_superseded_by_policy_id` FOREIGN KEY (`superseded_by_policy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`reimbursement_policy`(`reimbursement_policy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ADD CONSTRAINT `fk_market_tender_submission_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ADD CONSTRAINT `fk_market_tender_submission_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ADD CONSTRAINT `fk_market_tender_submission_pricing_decision_id` FOREIGN KEY (`pricing_decision_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pricing_decision`(`pricing_decision_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ADD CONSTRAINT `fk_market_outcomes_based_contract_market_heor_study_id` FOREIGN KEY (`market_heor_study_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_heor_study`(`market_heor_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ADD CONSTRAINT `fk_market_outcomes_based_contract_market_payer_contract_id` FOREIGN KEY (`market_payer_contract_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_payer_contract`(`market_payer_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ADD CONSTRAINT `fk_market_outcomes_based_contract_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ADD CONSTRAINT `fk_market_outcomes_based_contract_rwe_dataset_id` FOREIGN KEY (`rwe_dataset_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`rwe_dataset`(`rwe_dataset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ADD CONSTRAINT `fk_market_kol_engagement_plan_access_strategy_id` FOREIGN KEY (`access_strategy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`access_strategy`(`access_strategy_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ADD CONSTRAINT `fk_market_study_data_sourcing_market_heor_study_id` FOREIGN KEY (`market_heor_study_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_heor_study`(`market_heor_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ADD CONSTRAINT `fk_market_study_data_sourcing_rwe_dataset_id` FOREIGN KEY (`rwe_dataset_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`rwe_dataset`(`rwe_dataset_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary` ADD CONSTRAINT `fk_market_formulary_payer_account_id` FOREIGN KEY (`payer_account_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`payer_account`(`payer_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary` ADD CONSTRAINT `fk_market_formulary_pbm_id` FOREIGN KEY (`pbm_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pbm`(`pbm_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary` ADD CONSTRAINT `fk_market_formulary_market_payer_contract_id` FOREIGN KEY (`market_payer_contract_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`market_payer_contract`(`market_payer_contract_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary` ADD CONSTRAINT `fk_market_formulary_parent_formulary_id` FOREIGN KEY (`parent_formulary_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`formulary`(`formulary_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ADD CONSTRAINT `fk_market_pbm_parent_pbm_id` FOREIGN KEY (`parent_pbm_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pbm`(`pbm_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ADD CONSTRAINT `fk_market_pharmacy_pbm_id` FOREIGN KEY (`pbm_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pbm`(`pbm_id`);
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ADD CONSTRAINT `fk_market_pharmacy_parent_pharmacy_id` FOREIGN KEY (`parent_pharmacy_id`) REFERENCES `pharmaceuticals_ecm`.`market`.`pharmacy`(`pharmacy_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`market` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `pharmaceuticals_ecm`.`market` SET TAGS ('dbx_domain' = 'market');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` SET TAGS ('dbx_subdomain' = 'strategy_planning');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Market Access Strategy ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `indication_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Indication ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Target Kol Physician Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `access_barrier_severity` SET TAGS ('dbx_business_glossary_term' = 'Access Barrier Severity');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `access_barrier_severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `access_barrier_summary` SET TAGS ('dbx_business_glossary_term' = 'Access Barrier Summary');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `access_barrier_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `access_objective` SET TAGS ('dbx_business_glossary_term' = 'Market Access Objective');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `access_objective` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `actual_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Commercial Launch Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Strategy Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Strategy Approved By');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `copay_assistance_flag` SET TAGS ('dbx_business_glossary_term' = 'Copay Assistance Program Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Strategy Effective From Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Strategy Effective Until Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `gross_to_net_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Gross-to-Net Revenue Target Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `gross_to_net_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `heor_study_plan` SET TAGS ('dbx_business_glossary_term' = 'Health Economics and Outcomes Research (HEOR) Study Plan');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `heor_study_plan` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `hta_body_code` SET TAGS ('dbx_business_glossary_term' = 'Health Technology Assessment (HTA) Body Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `hta_outcome` SET TAGS ('dbx_business_glossary_term' = 'Health Technology Assessment (HTA) Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `hta_outcome` SET TAGS ('dbx_value_regex' = 'pending|positive|positive_with_restriction|negative|withdrawn|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `hta_strategy` SET TAGS ('dbx_business_glossary_term' = 'Health Technology Assessment (HTA) Strategy');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `hta_strategy` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `hta_submission_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Health Technology Assessment (HTA) Submission Actual Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `hta_submission_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Health Technology Assessment (HTA) Submission Planned Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `icer_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Incremental Cost-Effectiveness Ratio (ICER) Willingness-to-Pay Threshold Amount');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `icer_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `icer_threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Incremental Cost-Effectiveness Ratio (ICER) Threshold Currency');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `icer_threshold_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Market Access Strategy Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `list_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross List Price Amount');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `list_price_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `list_price_currency` SET TAGS ('dbx_business_glossary_term' = 'List Price Currency');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `list_price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `patient_support_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Support Program Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `payer_segment` SET TAGS ('dbx_business_glossary_term' = 'Payer Segment');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `planned_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Commercial Launch Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `reimbursement_pathway` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Pathway');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Access Barrier Remediation Plan');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `rwe_rwd_plan` SET TAGS ('dbx_business_glossary_term' = 'Real-World Evidence (RWE) and Real-World Data (RWD) Generation Plan');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `rwe_rwd_plan` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `strategy_code` SET TAGS ('dbx_business_glossary_term' = 'Market Access Strategy Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `strategy_code` SET TAGS ('dbx_value_regex' = '^MAS-[A-Z0-9]{4,12}-[0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `strategy_name` SET TAGS ('dbx_business_glossary_term' = 'Market Access Strategy Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `strategy_owner` SET TAGS ('dbx_business_glossary_term' = 'Market Access Strategy Owner');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Market Access Strategy Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `strategy_type` SET TAGS ('dbx_value_regex' = 'launch|lifecycle|indication_expansion|line_extension|biosimilar_defense');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `strategy_version` SET TAGS ('dbx_business_glossary_term' = 'Market Access Strategy Version');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `strategy_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `target_formulary_tier` SET TAGS ('dbx_business_glossary_term' = 'Target Formulary Tier');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `target_formulary_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|specialty|non_formulary');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `value_proposition` SET TAGS ('dbx_business_glossary_term' = 'Payer Value Proposition');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`access_strategy` ALTER COLUMN `value_proposition` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` SET TAGS ('dbx_subdomain' = 'payer_relations');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Account ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Owner Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `parent_payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Payer Account ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `third_party_due_diligence_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Due Diligence Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Payer Account Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `cms_payer_code` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Payer ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `cms_payer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,15}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'rebate|fee_for_service|value_based|capitation|net_price');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `contracting_authority` SET TAGS ('dbx_business_glossary_term' = 'Contracting Authority Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `copay_accumulator_policy` SET TAGS ('dbx_business_glossary_term' = 'Copay Accumulator Adjustment Policy Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `copay_assistance_accepted` SET TAGS ('dbx_business_glossary_term' = 'Copay Assistance Accepted Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `covered_lives` SET TAGS ('dbx_business_glossary_term' = 'Covered Lives');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `covered_lives` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Account Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `formulary_decision_cycle` SET TAGS ('dbx_business_glossary_term' = 'Formulary Decision Cycle');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `formulary_decision_cycle` SET TAGS ('dbx_value_regex' = 'annual|semi_annual|quarterly|rolling|ad_hoc');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `formulary_influence_score` SET TAGS ('dbx_business_glossary_term' = 'Formulary Influence Score');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `formulary_influence_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `formulary_tier_position` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier Position');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `formulary_tier_position` SET TAGS ('dbx_value_regex' = 'preferred_brand|non_preferred_brand|specialty|generic|excluded|not_listed');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `geographic_coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Scope');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `geographic_coverage_scope` SET TAGS ('dbx_value_regex' = 'national|regional|state|local|multinational');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `gpo_membership` SET TAGS ('dbx_business_glossary_term' = 'Group Purchasing Organization (GPO) Membership');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `gpo_membership` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `hq_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `hq_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `hta_body` SET TAGS ('dbx_business_glossary_term' = 'Health Technology Assessment (HTA) Body');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `last_contract_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contract Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `naic_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Insurance Commissioners (NAIC) Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `naic_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `payer_account_code` SET TAGS ('dbx_business_glossary_term' = 'Payer Account Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `payer_account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `payer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Organization Legal Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `payer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `payer_subtype` SET TAGS ('dbx_business_glossary_term' = 'Payer Subtype');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `payer_type` SET TAGS ('dbx_value_regex' = 'commercial_health_plan|government_payer|pbm|gpo|integrated_delivery_network|managed_care_organization');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `pbm_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) Affiliation');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `pbm_affiliation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `primary_therapeutic_focus` SET TAGS ('dbx_business_glossary_term' = 'Primary Therapeutic Focus');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `pt_committee_meeting_month` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy and Therapeutics (P&T) Committee Meeting Month');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `rebate_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rebate Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `reimbursement_authority` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Authority');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `rwe_data_sharing_agreement` SET TAGS ('dbx_business_glossary_term' = 'Real-World Evidence (RWE) Data Sharing Agreement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Account Termination Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `tier` SET TAGS ('dbx_business_glossary_term' = 'Payer Tier');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_account` ALTER COLUMN `value_based_contract_eligible` SET TAGS ('dbx_business_glossary_term' = 'Value-Based Contract (VBC) Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` SET TAGS ('dbx_subdomain' = 'payer_relations');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `market_formulary_position_id` SET TAGS ('dbx_business_glossary_term' = 'Market Formulary Position ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `coverage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Decision Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `formulary_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `market_payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `pbm_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `access_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `coinsurance_rate` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Rate');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `coinsurance_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount (USD)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `copay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `formulary_position_code` SET TAGS ('dbx_business_glossary_term' = 'Formulary Position Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `formulary_position_code` SET TAGS ('dbx_value_regex' = '^FP-[A-Z0-9]{6,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `formulary_review_date` SET TAGS ('dbx_business_glossary_term' = 'Formulary Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `hta_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Health Technology Assessment (HTA) Submission Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `hta_submission_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|under_review|approved|rejected|resubmitted');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `lives_covered` SET TAGS ('dbx_business_glossary_term' = 'Lives Covered');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `market_share_impact_pct` SET TAGS ('dbx_business_glossary_term' = 'Market Share Impact Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `market_share_impact_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Formulary Position Notes');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `patient_access_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `payer_segment` SET TAGS ('dbx_business_glossary_term' = 'Payer Segment');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `payer_segment` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|managed_medicaid|exchange|va_dod');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Required');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `quantity_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Days Supply');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `quantity_limit_flag` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `quantity_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Value');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `rebate_tier` SET TAGS ('dbx_business_glossary_term' = 'Rebate Tier');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `rebate_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `specialty_drug_flag` SET TAGS ('dbx_business_glossary_term' = 'Specialty Drug Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `specialty_pharmacy_required` SET TAGS ('dbx_business_glossary_term' = 'Specialty Pharmacy Required');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_formulary_position` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` SET TAGS ('dbx_subdomain' = 'strategy_planning');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `hta_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Health Technology Assessment (HTA) Submission ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `indication_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Indication ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `market_heor_study_id` SET TAGS ('dbx_business_glossary_term' = 'Health Economics and Outcomes Research (HEOR) Study ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `actual_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Actual HTA Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `appeal_filed` SET TAGS ('dbx_business_glossary_term' = 'HTA Decision Appeal Filed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'HTA Appeal Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `appeal_outcome` SET TAGS ('dbx_value_regex' = 'upheld|overturned|partially_upheld|withdrawn|pending');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `benefit_rating` SET TAGS ('dbx_business_glossary_term' = 'Added Therapeutic Benefit Rating');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `comparator_description` SET TAGS ('dbx_business_glossary_term' = 'HTA Comparator Description');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'HTA Decision Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `decision_type` SET TAGS ('dbx_business_glossary_term' = 'HTA Decision Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `decision_type` SET TAGS ('dbx_value_regex' = 'positive|negative|restricted|conditional|deferred|not_recommended');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `dossier_reference` SET TAGS ('dbx_business_glossary_term' = 'HTA Dossier Reference');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `economic_model_type` SET TAGS ('dbx_business_glossary_term' = 'Health Economic Model Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `economic_model_type` SET TAGS ('dbx_value_regex' = 'cost_effectiveness|cost_utility|cost_minimisation|cost_benefit|budget_impact');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `ectd_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Common Technical Document (eCTD) Sequence Number');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `evidence_package_type` SET TAGS ('dbx_business_glossary_term' = 'Clinical Evidence Package Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `evidence_package_type` SET TAGS ('dbx_value_regex' = 'RCT|observational|indirect_comparison|mixed_treatment|single_arm|real_world');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `external_agency` SET TAGS ('dbx_business_glossary_term' = 'External HTA Agency / CRO');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `hta_body_code` SET TAGS ('dbx_business_glossary_term' = 'Health Technology Assessment (HTA) Body Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `icer_currency_code` SET TAGS ('dbx_business_glossary_term' = 'ICER Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `icer_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `icer_submitted` SET TAGS ('dbx_business_glossary_term' = 'Submitted Incremental Cost-Effectiveness Ratio (ICER)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `icer_submitted` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `inn` SET TAGS ('dbx_business_glossary_term' = 'International Nonproprietary Name (INN)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `managed_access_scheme` SET TAGS ('dbx_business_glossary_term' = 'Managed Access Scheme (MAS) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `patient_access_program` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program (PAP) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `planned_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Planned HTA Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `price_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Recommended Price Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `price_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `recommended_price_lower` SET TAGS ('dbx_business_glossary_term' = 'HTA Recommended Price Lower Bound');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `recommended_price_lower` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `recommended_price_upper` SET TAGS ('dbx_business_glossary_term' = 'HTA Recommended Price Upper Bound');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `recommended_price_upper` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `reimbursement_conditions` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Conditions');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `rwe_required` SET TAGS ('dbx_business_glossary_term' = 'Real-World Evidence (RWE) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `submission_lead` SET TAGS ('dbx_business_glossary_term' = 'HTA Submission Lead');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'HTA Submission Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'HTA Submission Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'HTA Submission Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'initial|resubmission|renewal|line_extension|supplemental');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `value_dossier_version` SET TAGS ('dbx_business_glossary_term' = 'Value Dossier Version');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `value_dossier_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`hta_submission` ALTER COLUMN `willingness_to_pay_threshold` SET TAGS ('dbx_business_glossary_term' = 'HTA Body Willingness-to-Pay (WTP) Threshold');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` SET TAGS ('dbx_subdomain' = 'strategy_planning');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `value_dossier_id` SET TAGS ('dbx_business_glossary_term' = 'Value Dossier ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `budget_impact_model_ref` SET TAGS ('dbx_business_glossary_term' = 'Budget Impact Model Reference');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `clinical_evidence_summary` SET TAGS ('dbx_business_glossary_term' = 'Clinical Evidence Summary');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `comparator_description` SET TAGS ('dbx_business_glossary_term' = 'Comparator Landscape Description');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'HTA Decision Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'HTA Decision Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_value_regex' = 'positive|positive_with_restrictions|negative|deferred|withdrawn|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `dossier_code` SET TAGS ('dbx_business_glossary_term' = 'Global Value Dossier (GVD) Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `dossier_code` SET TAGS ('dbx_value_regex' = '^GVD-[A-Z0-9]{3,10}-[0-9]{4}-v[0-9]+$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `dossier_owner` SET TAGS ('dbx_business_glossary_term' = 'Dossier Owner');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `dossier_status` SET TAGS ('dbx_business_glossary_term' = 'Value Dossier Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `dossier_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|published|archived|superseded');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `dossier_type` SET TAGS ('dbx_business_glossary_term' = 'Value Dossier Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `dossier_type` SET TAGS ('dbx_value_regex' = 'global|local_adaptation|payer_specific|hta_submission|reimbursement_dossier|formulary_submission');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `economic_model_type` SET TAGS ('dbx_business_glossary_term' = 'Economic Model Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `economic_model_type` SET TAGS ('dbx_value_regex' = 'cost_effectiveness|cost_utility|cost_minimization|cost_benefit|budget_impact');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `formulary_tier_target` SET TAGS ('dbx_business_glossary_term' = 'Target Formulary Tier');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `formulary_tier_target` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|specialty|non_formulary');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `heor_evidence_summary` SET TAGS ('dbx_business_glossary_term' = 'Health Economics and Outcomes Research (HEOR) Evidence Summary');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `hta_body_name` SET TAGS ('dbx_business_glossary_term' = 'Health Technology Assessment (HTA) Body Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `icd_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `icd_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `icur_currency_code` SET TAGS ('dbx_business_glossary_term' = 'ICUR Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `icur_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `icur_value` SET TAGS ('dbx_business_glossary_term' = 'Incremental Cost-Utility Ratio (ICUR) Value');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `icur_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `legal_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `line_of_therapy` SET TAGS ('dbx_business_glossary_term' = 'Line of Therapy');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `line_of_therapy` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line|adjuvant|neoadjuvant|maintenance');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `medical_affairs_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Medical Affairs Review Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `medical_affairs_reviewed` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `medical_affairs_reviewed` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `patient_population_size` SET TAGS ('dbx_business_glossary_term' = 'Target Patient Population Size');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `primary_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Primary Clinical Endpoint');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `product_inn` SET TAGS ('dbx_business_glossary_term' = 'International Nonproprietary Name (INN)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `qaly_gain` SET TAGS ('dbx_business_glossary_term' = 'Quality-Adjusted Life Year (QALY) Gain');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `reimbursement_scope` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Scope');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `reimbursement_scope` SET TAGS ('dbx_value_regex' = 'full|restricted|step_therapy|prior_authorization|not_reimbursed');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `rwe_included` SET TAGS ('dbx_business_glossary_term' = 'Real-World Evidence (RWE) Included Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `target_indication` SET TAGS ('dbx_business_glossary_term' = 'Target Indication');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `target_payer_type` SET TAGS ('dbx_business_glossary_term' = 'Target Payer Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Value Dossier Title');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `version_date` SET TAGS ('dbx_business_glossary_term' = 'Version Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`value_dossier` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `market_payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Disclosure Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Contracting Entity ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Account Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `admin_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Administrative Fee Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `admin_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `auto_renewal` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `base_rebate_pct` SET TAGS ('dbx_business_glossary_term' = 'Base Rebate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `base_rebate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `book_of_business_lives` SET TAGS ('dbx_business_glossary_term' = 'Book of Business Covered Lives');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `book_of_business_lives` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `contract_owner` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'base_rebate|performance_rebate|outcomes_based|value_based|pbm_formulary_rebate|gpo_commitment');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `copay_assistance_allowed` SET TAGS ('dbx_business_glossary_term' = 'Copay Assistance Allowed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `data_sharing_required` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `data_sharing_scope` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Scope');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `data_sharing_scope` SET TAGS ('dbx_value_regex' = 'claims_data|utilization_data|outcomes_data|adherence_data|full_claims_and_outcomes');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `estimated_annual_rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Rebate Amount');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `estimated_annual_rebate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `exclusivity_provision` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Provision Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `exclusivity_provision` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `execution_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_value_regex' = 'tier_1_preferred|tier_2_non_preferred|tier_3_specialty|tier_4_excluded|tier_5_specialty_preferred');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `incremental_rebate_pct` SET TAGS ('dbx_business_glossary_term' = 'Incremental Rebate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `incremental_rebate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `most_favored_nation_clause` SET TAGS ('dbx_business_glossary_term' = 'Most Favored Nation (MFN) Clause Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `most_favored_nation_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `performance_metric_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Metric Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `performance_metric_type` SET TAGS ('dbx_value_regex' = 'market_share|formulary_tier|patient_outcomes|adherence_rate|cost_per_cure|utilization_management');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `performance_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Performance Threshold Value');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `performance_threshold_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `price_protection_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Clause Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `price_protection_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `price_protection_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Price Protection Threshold Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `price_protection_threshold_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `rebate_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rebate Payment Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `rebate_payment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `rebate_payment_lag_days` SET TAGS ('dbx_business_glossary_term' = 'Rebate Payment Lag Days');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period Days');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `source_system_contract_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Contract ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Reason');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `utilization_management_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Utilization Management (UM) Restrictions');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_payer_contract` ALTER COLUMN `utilization_management_restrictions` SET TAGS ('dbx_value_regex' = 'none|prior_authorization|step_therapy|quantity_limits|step_therapy_and_pa');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `rebate_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Claim ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Accounts Receivable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `market_payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Care Contract ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `pbm_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Benefit Manager (PBM) ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `accrual_period` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `accrual_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-Q[1-4]$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Adjustment Amount');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `claim_direction` SET TAGS ('dbx_business_glossary_term' = 'Rebate Claim Direction');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `claim_direction` SET TAGS ('dbx_value_regex' = 'payable|receivable');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Rebate Claim Number');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_value_regex' = '^RBC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `claim_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `claim_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Rebate Claim Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Rebate Claim Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_value_regex' = 'base_rebate|performance_rebate|market_share_rebate|formulary_rebate|administrative_fee');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_value_regex' = 'unit_count_discrepancy|rate_discrepancy|eligibility_dispute|period_mismatch|data_quality|other');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'no_dispute|dispute_raised|under_negotiation|resolved_accepted|resolved_rejected');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `eligible_units` SET TAGS ('dbx_business_glossary_term' = 'Eligible Units');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_value_regex' = 'preferred_brand|non_preferred_brand|specialty|generic|not_covered');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `gross_rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Rebate Amount');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `gross_rebate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `market_share_pct` SET TAGS ('dbx_business_glossary_term' = 'Market Share Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `medicaid_rebate_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Drug Rebate Program (MDRP) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `net_rebate_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Rebate Amount');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `net_rebate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Rebate Payment Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `payment_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `prior_period_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Adjustment Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `rebate_rate` SET TAGS ('dbx_business_glossary_term' = 'Rebate Rate');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `rebate_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `rebate_tier` SET TAGS ('dbx_business_glossary_term' = 'Rebate Tier');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `rebate_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'prescription|unit_dose|pack|gram|ml');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `wac_price` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Acquisition Cost (WAC) Price');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rebate_claim` ALTER COLUMN `wac_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `gross_to_net_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Gross To Net Adjustment Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `pharmacy_id` SET TAGS ('dbx_business_glossary_term' = 'Dispensing Pharmacy Identifier (NCPDP)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `inventory_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Lot Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `market_payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `rebate_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Rebate Claim Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `accrual_flag` SET TAGS ('dbx_business_glossary_term' = 'Accrual Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'GTN Adjustment Amount');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `adjustment_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'GTN Adjustment Rate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `adjustment_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `adjustment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Gross-to-Net (GTN) Adjustment Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'GTN Adjustment Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|posted|reversed|disputed');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `adjustment_subtype` SET TAGS ('dbx_business_glossary_term' = 'GTN Adjustment Subtype');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'GTN Adjustment Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `claim_date` SET TAGS ('dbx_business_glossary_term' = 'Copay Claim Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `copay_assistance_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Assistance Amount Paid');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `copay_assistance_paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `gross_copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Copay Amount');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `gross_copay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Sales Amount');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `gross_sales_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `medicaid_best_price_flag` SET TAGS ('dbx_business_glossary_term' = 'Medicaid Best Price Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Revenue Amount');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `net_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `patient_deidentified_code` SET TAGS ('dbx_business_glossary_term' = 'De-identified Patient Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `patient_deidentified_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `patient_deidentified_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `patient_remaining_liability` SET TAGS ('dbx_business_glossary_term' = 'Patient Remaining Liability');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `patient_remaining_liability` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Financial Posting Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_SD|SAP_FI|COPAY_PROCESSOR|MEDICAID_PORTAL|CHARGEBACK_SYSTEM|MANUAL');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`gross_to_net_adjustment` ALTER COLUMN `units_sold` SET TAGS ('dbx_business_glossary_term' = 'Units Sold');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` SET TAGS ('dbx_subdomain' = 'payer_relations');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `coverage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Coverage Decision ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `hta_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Hta Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `coverage_restriction_detail` SET TAGS ('dbx_business_glossary_term' = 'Coverage Restriction Detail');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `coverage_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Restriction Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `coverage_restriction_type` SET TAGS ('dbx_value_regex' = 'specialty_pharmacy|restricted_distribution|age_restriction|prescriber_restriction|site_of_care|rems');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `covered_indication` SET TAGS ('dbx_business_glossary_term' = 'Covered Indication');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `decision_code` SET TAGS ('dbx_business_glossary_term' = 'Coverage Decision Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Decision Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `decision_rationale` SET TAGS ('dbx_business_glossary_term' = 'Coverage Decision Rationale');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `decision_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Decision Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `decision_status` SET TAGS ('dbx_value_regex' = 'covered|not_covered|restricted|pending|withdrawn|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `decision_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Decision Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `icd_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `icd_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `inn_name` SET TAGS ('dbx_business_glossary_term' = 'International Nonproprietary Name (INN)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `line_of_therapy` SET TAGS ('dbx_business_glossary_term' = 'Line of Therapy');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `line_of_therapy` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line|adjuvant|neoadjuvant|maintenance');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `lives_covered` SET TAGS ('dbx_business_glossary_term' = 'Lives Covered');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `managed_entry_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Managed Entry Agreement (MEA) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `patient_access_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `prior_authorization_criteria` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `quantity_limit_description` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Description');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `quantity_limit_flag` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Region or State Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `reimbursement_scope` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Scope');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `reimbursement_scope` SET TAGS ('dbx_value_regex' = 'full|partial|conditional|not_reimbursed');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `rwe_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Real-World Evidence (RWE) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Termination Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`coverage_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` SET TAGS ('dbx_subdomain' = 'strategy_planning');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `patient_access_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Physician Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `annual_program_budget` SET TAGS ('dbx_business_glossary_term' = 'Annual Program Budget');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `annual_program_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Program Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `benefit_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefit Cap Amount');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `benefit_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `benefit_cap_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Cap Currency Code (ISO 4217)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `benefit_cap_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `benefit_period` SET TAGS ('dbx_business_glossary_term' = 'Benefit Period');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `benefit_period` SET TAGS ('dbx_value_regex' = 'annual|calendar_year|rolling_12_months|per_treatment_cycle|lifetime');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `benefit_type` SET TAGS ('dbx_value_regex' = 'copay_reduction|free_drug|premium_support|deductible_support|out_of_pocket_cap');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `eligibility_criteria_summary` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria Summary');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'hub|specialty_pharmacy|hcp_portal|patient_portal|phone|field_reimbursement');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'manufacturer|foundation|government|co_funded');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `hub_service_provider` SET TAGS ('dbx_business_glossary_term' = 'Hub Service Provider');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `income_threshold_required` SET TAGS ('dbx_business_glossary_term' = 'Income Threshold Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Approved Indication');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `inn` SET TAGS ('dbx_business_glossary_term' = 'International Nonproprietary Name (INN)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `insurance_status_requirement` SET TAGS ('dbx_business_glossary_term' = 'Insurance Status Requirement');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `insurance_status_requirement` SET TAGS ('dbx_value_regex' = 'insured|uninsured|underinsured|any');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `legal_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `line_of_therapy` SET TAGS ('dbx_business_glossary_term' = 'Line of Therapy');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `line_of_therapy` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line_plus|any_line|maintenance');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `patient_population_description` SET TAGS ('dbx_business_glossary_term' = 'Patient Population Description');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `payer_segment` SET TAGS ('dbx_business_glossary_term' = 'Payer Segment');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `payer_segment` SET TAGS ('dbx_value_regex' = 'commercial|medicare|medicaid|government|uninsured');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `program_notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `program_owner` SET TAGS ('dbx_business_glossary_term' = 'Program Owner');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|suspended|closed');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `regulatory_authorization_ref` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authorization Reference');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `rems_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Program Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `specialty_pharmacy_required` SET TAGS ('dbx_business_glossary_term' = 'Specialty Pharmacy Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `supply_terms` SET TAGS ('dbx_business_glossary_term' = 'Supply Terms');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`patient_access_program` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `pricing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Decision ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `hta_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Hta Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `market_country_id` SET TAGS ('dbx_business_glossary_term' = 'Market ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `preceding_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Preceding Pricing Decision ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `transfer_price_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `ceiling_price` SET TAGS ('dbx_business_glossary_term' = 'Ceiling Price — Approved Price Corridor Maximum');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `ceiling_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `channel_type` SET TAGS ('dbx_business_glossary_term' = 'Channel Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `channel_type` SET TAGS ('dbx_value_regex' = 'retail|hospital|government|tender|specialty_pharmacy|direct');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `corridor_breach_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Price Corridor Breach Alert Threshold Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `decision_code` SET TAGS ('dbx_business_glossary_term' = 'Pricing Decision Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `decision_code` SET TAGS ('dbx_value_regex' = '^PD-[A-Z]{2,3}-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `decision_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `decision_status` SET TAGS ('dbx_business_glossary_term' = 'Pricing Decision Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `decision_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Decision Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `floor_price` SET TAGS ('dbx_business_glossary_term' = 'Floor Price — Approved Price Corridor Minimum');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `floor_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `government_reference_price` SET TAGS ('dbx_business_glossary_term' = 'Government Reference Price');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `government_reference_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `gross_to_net_pct` SET TAGS ('dbx_business_glossary_term' = 'Gross-to-Net Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `gross_to_net_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `irp_basket_countries` SET TAGS ('dbx_business_glossary_term' = 'International Reference Pricing (IRP) Basket Countries');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `irp_basket_countries` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `irp_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'International Reference Pricing (IRP) Constraint Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `irp_reference_price` SET TAGS ('dbx_business_glossary_term' = 'International Reference Pricing (IRP) Reference Price');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `irp_reference_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `launch_sequence_priority` SET TAGS ('dbx_business_glossary_term' = 'Launch Sequence Priority');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `list_price_wac` SET TAGS ('dbx_business_glossary_term' = 'List Price — Wholesale Acquisition Cost (WAC)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `list_price_wac` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'IRP Monitoring Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|event_driven');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `net_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `pack_size_description` SET TAGS ('dbx_business_glossary_term' = 'Pack Size Description');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `price_change_pct` SET TAGS ('dbx_business_glossary_term' = 'Price Change Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `price_change_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `price_per_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `price_per_unit_type` SET TAGS ('dbx_value_regex' = 'per_pack|per_tablet|per_vial|per_mg|per_ml|per_dose');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `pricing_rationale` SET TAGS ('dbx_business_glossary_term' = 'Pricing Rationale');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `pricing_rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `regulatory_submission_ref` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_value_regex' = 'reimbursed|partially_reimbursed|not_reimbursed|pending|restricted');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `target_price` SET TAGS ('dbx_business_glossary_term' = 'Target Price — Approved Price Corridor Midpoint');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `target_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pricing_decision` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` SET TAGS ('dbx_subdomain' = 'evidence_generation');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `market_heor_study_id` SET TAGS ('dbx_business_glossary_term' = 'Health Economics and Outcomes Research (HEOR) Study ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `value_dossier_id` SET TAGS ('dbx_business_glossary_term' = 'Value Dossier Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `budget_impact_year1` SET TAGS ('dbx_business_glossary_term' = 'Budget Impact Year 1');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `budget_impact_year1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `budget_impact_year3` SET TAGS ('dbx_business_glossary_term' = 'Budget Impact Year 3');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `budget_impact_year3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `comparator_description` SET TAGS ('dbx_business_glossary_term' = 'Comparator Description');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `cro_vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Research Organization (CRO) Vendor Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `data_use_agreement_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Reference');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `data_use_agreement_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `hta_body_name` SET TAGS ('dbx_business_glossary_term' = 'Health Technology Assessment (HTA) Body Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `icd_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `icd_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `icur_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Incremental Cost-Utility Ratio (ICUR) Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `icur_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `icur_value` SET TAGS ('dbx_business_glossary_term' = 'Incremental Cost-Utility Ratio (ICUR) Value');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `icur_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `line_of_therapy` SET TAGS ('dbx_business_glossary_term' = 'Line of Therapy');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `line_of_therapy` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line|adjuvant|neoadjuvant|maintenance');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `market_share_assumption_pct` SET TAGS ('dbx_business_glossary_term' = 'Market Share Assumption Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `market_share_assumption_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'HEOR Model Version');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^v[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `model_version_date` SET TAGS ('dbx_business_glossary_term' = 'HEOR Model Version Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `patient_population_description` SET TAGS ('dbx_business_glossary_term' = 'Patient Population Description');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `patient_population_size` SET TAGS ('dbx_business_glossary_term' = 'Patient Population Size');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `product_inn` SET TAGS ('dbx_business_glossary_term' = 'International Nonproprietary Name (INN)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `publication_reference` SET TAGS ('dbx_business_glossary_term' = 'Publication Reference');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `qaly_gain` SET TAGS ('dbx_business_glossary_term' = 'Quality-Adjusted Life Year (QALY) Gain');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `rwd_data_source_type` SET TAGS ('dbx_business_glossary_term' = 'Real-World Data (RWD) Source Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `rwd_data_source_type` SET TAGS ('dbx_value_regex' = 'claims_database|ehr|registry|patient_reported_outcomes|chart_review|administrative_database');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `rwd_data_vendor` SET TAGS ('dbx_business_glossary_term' = 'Real-World Data (RWD) Vendor');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `rwd_data_vintage` SET TAGS ('dbx_business_glossary_term' = 'Real-World Data (RWD) Data Vintage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `rwe_included` SET TAGS ('dbx_business_glossary_term' = 'Real-World Evidence (RWE) Included Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `study_code` SET TAGS ('dbx_business_glossary_term' = 'Health Economics and Outcomes Research (HEOR) Study Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `study_code` SET TAGS ('dbx_value_regex' = '^HEOR-[A-Z0-9]{3,10}-[0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'HEOR Study Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `study_owner` SET TAGS ('dbx_business_glossary_term' = 'HEOR Study Owner');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'HEOR Study Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'HEOR Study Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|under_review|completed|published|archived');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `study_title` SET TAGS ('dbx_business_glossary_term' = 'HEOR Study Title');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'HEOR Study Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'budget_impact_model|cost_effectiveness_analysis|cost_utility_analysis|retrospective_rwd_study|pro_study|indirect_treatment_comparison');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `target_indication` SET TAGS ('dbx_business_glossary_term' = 'Target Indication');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `target_payer_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Payer Audience');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `time_horizon` SET TAGS ('dbx_business_glossary_term' = 'Model Time Horizon');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `treatment_cost_input` SET TAGS ('dbx_business_glossary_term' = 'Treatment Cost Input');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `treatment_cost_input` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`market_heor_study` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` SET TAGS ('dbx_subdomain' = 'evidence_generation');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `rwe_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Real-World Evidence (RWE) Dataset ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Data Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Dataset Owner Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `pass_study_id` SET TAGS ('dbx_business_glossary_term' = 'Pass Study Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `privacy_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Impact Assessment Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `privacy_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `safety_signal_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Signal Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `access_restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Notes');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `access_restriction_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `annual_license_cost` SET TAGS ('dbx_business_glossary_term' = 'Annual License Cost');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `annual_license_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `data_end_date` SET TAGS ('dbx_business_glossary_term' = 'Data End Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `data_quality_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Assessment Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Tier');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `data_quality_tier` SET TAGS ('dbx_value_regex' = 'gold|silver|bronze');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `data_refresh_frequency` SET TAGS ('dbx_business_glossary_term' = 'Data Refresh Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `data_refresh_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|one_time|ad_hoc');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `data_start_date` SET TAGS ('dbx_business_glossary_term' = 'Data Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `dataset_code` SET TAGS ('dbx_business_glossary_term' = 'Real-World Evidence (RWE) Dataset Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `dataset_code` SET TAGS ('dbx_value_regex' = '^RWE-[A-Z0-9]{4,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `dataset_name` SET TAGS ('dbx_business_glossary_term' = 'Real-World Evidence (RWE) Dataset Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `dataset_status` SET TAGS ('dbx_business_glossary_term' = 'Real-World Evidence (RWE) Dataset Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `dataset_status` SET TAGS ('dbx_value_regex' = 'active|archived|under_review|restricted|expired');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `dataset_type` SET TAGS ('dbx_business_glossary_term' = 'Real-World Data (RWD) Dataset Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `de_identification_method` SET TAGS ('dbx_business_glossary_term' = 'De-Identification Method');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `de_identification_method` SET TAGS ('dbx_value_regex' = 'safe_harbor|expert_determination|pseudonymized|aggregated|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `dua_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `dua_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Data Use Agreement (DUA) Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `dua_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|multi_country|global');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `heor_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Health Economics and Outcomes Research (HEOR) Study Reference');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `hta_submission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Health Technology Assessment (HTA) Submission Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `icd_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `icd_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `license_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'License Cost Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `license_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `line_of_therapy` SET TAGS ('dbx_business_glossary_term' = 'Line of Therapy');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `line_of_therapy` SET TAGS ('dbx_value_regex' = '1L|2L|3L+|any|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `linked_value_dossier_code` SET TAGS ('dbx_business_glossary_term' = 'Linked Value Dossier Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `patient_count` SET TAGS ('dbx_business_glossary_term' = 'Patient Count');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `patient_population_description` SET TAGS ('dbx_business_glossary_term' = 'Patient Population Description');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `payer_negotiation_eligible` SET TAGS ('dbx_business_glossary_term' = 'Payer Negotiation Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `permitted_use_scope` SET TAGS ('dbx_business_glossary_term' = 'Permitted Use Scope');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `permitted_use_scope` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `primary_endpoint_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Endpoint Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `publication_allowed` SET TAGS ('dbx_business_glossary_term' = 'Publication Allowed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `rwe_study_design` SET TAGS ('dbx_business_glossary_term' = 'Real-World Evidence (RWE) Study Design');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `rwe_study_design` SET TAGS ('dbx_value_regex' = 'retrospective_cohort|prospective_cohort|case_control|cross_sectional|chart_review|other');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `target_indication` SET TAGS ('dbx_business_glossary_term' = 'Target Indication');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`rwe_dataset` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` SET TAGS ('dbx_subdomain' = 'payer_relations');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `payer_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Engagement ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Market Access Strategy ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Owner Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Disclosure Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `hta_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Hta Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `market_payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Account ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `value_dossier_id` SET TAGS ('dbx_business_glossary_term' = 'Value Dossier ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `commitments_made` SET TAGS ('dbx_business_glossary_term' = 'Commitments Made');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `commitments_made` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `discussion_topics` SET TAGS ('dbx_business_glossary_term' = 'Discussion Topics');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_channel` SET TAGS ('dbx_business_glossary_term' = 'Payer Engagement Channel');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_channel` SET TAGS ('dbx_value_regex' = 'in_person|virtual|telephone|hybrid');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_code` SET TAGS ('dbx_business_glossary_term' = 'Payer Engagement Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_code` SET TAGS ('dbx_value_regex' = '^PE-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Payer Engagement Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_end_time` SET TAGS ('dbx_business_glossary_term' = 'Payer Engagement End Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_location` SET TAGS ('dbx_business_glossary_term' = 'Payer Engagement Location');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_outcome` SET TAGS ('dbx_business_glossary_term' = 'Payer Engagement Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_outcome` SET TAGS ('dbx_value_regex' = 'positive|neutral|negative|pending|inconclusive');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_outcome` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_start_time` SET TAGS ('dbx_business_glossary_term' = 'Payer Engagement Start Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Payer Engagement Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|in_progress|completed|cancelled|rescheduled');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Engagement Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_value_regex' = 'formulary_committee_meeting|medical_policy_review|rebate_negotiation|outcomes_based_contract_discussion|advisory_board|account_planning_meeting');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `follow_up_actions` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Actions');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `follow_up_completed` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `formulary_tier_discussed` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier Discussed');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `heor_evidence_presented_flag` SET TAGS ('dbx_business_glossary_term' = 'Health Economics and Outcomes Research (HEOR) Evidence Presented Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Indication');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `internal_attendees` SET TAGS ('dbx_business_glossary_term' = 'Internal Attendee Names');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `key_messages_delivered` SET TAGS ('dbx_business_glossary_term' = 'Key Messages Delivered');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `meeting_minutes_ref` SET TAGS ('dbx_business_glossary_term' = 'Meeting Minutes Document Reference');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `meeting_minutes_ref` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `negotiation_stage` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Stage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `negotiation_stage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `next_engagement_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Next Engagement Planned Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `outcomes_contract_discussed_flag` SET TAGS ('dbx_business_glossary_term' = 'Outcomes-Based Contract Discussed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `payer_attendees` SET TAGS ('dbx_business_glossary_term' = 'Payer Attendee Names');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `payer_attendees` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `payer_position_summary` SET TAGS ('dbx_business_glossary_term' = 'Payer Position Summary');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `payer_position_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `rebate_discussed_flag` SET TAGS ('dbx_business_glossary_term' = 'Rebate Discussed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `rwe_data_discussed_flag` SET TAGS ('dbx_business_glossary_term' = 'Real-World Evidence (RWE) Data Discussed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `source_system_engagement_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Engagement ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`payer_engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` SET TAGS ('dbx_subdomain' = 'payer_relations');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `hta_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Hta Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Account ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `superseded_by_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Policy ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Decision Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_pending|appeal_granted|appeal_denied|appeal_withdrawn');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `coverage_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Restriction Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'covered|not_covered|covered_with_restrictions|pending_review|appealed|withdrawn');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `covered_indication` SET TAGS ('dbx_business_glossary_term' = 'Covered Indication');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `decision_authority` SET TAGS ('dbx_business_glossary_term' = 'Decision Authority');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Decision Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective From Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Until Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `excluded_population` SET TAGS ('dbx_business_glossary_term' = 'Excluded Patient Population');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|state_provincial|plan_level|local');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `icd_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `icd_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `line_of_therapy` SET TAGS ('dbx_business_glossary_term' = 'Line of Therapy');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `line_of_therapy` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line|adjuvant|maintenance|any_line');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `patient_access_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `payer_segment` SET TAGS ('dbx_business_glossary_term' = 'Payer Segment');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Number');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Policy Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|superseded|draft|under_review|expired');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Policy Version');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `prior_authorization_criteria` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization (PA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `quantity_limit_days` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Days Supply');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `quantity_limit_flag` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `quantity_limit_value` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Value');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `reimbursement_rate` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Rate');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `reimbursement_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `reimbursement_rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Rate Basis');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `reimbursement_rate_basis` SET TAGS ('dbx_value_regex' = 'asp_plus_pct|wac_pct|fee_schedule|negotiated_price|drg_bundled|capitation');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `rems_required` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `source_system_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Policy ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `step_therapy_criteria` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`reimbursement_policy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `tender_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Tender Submission ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Market Access Strategy ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Account ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `pricing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Decision Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Tender Appeal Deadline Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `award_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Tender Award Decision Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Tender Award Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `award_status` SET TAGS ('dbx_value_regex' = 'awarded|not_awarded|partial_award|pending|appealed');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `awarded_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Awarded Unit Price');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `awarded_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `awarded_volume` SET TAGS ('dbx_business_glossary_term' = 'Awarded Volume');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `committed_volume` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `competitor_lowest_price` SET TAGS ('dbx_business_glossary_term' = 'Competitor Lowest Price');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `competitor_lowest_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `contract_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Tender Contract Duration (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Tender Contract End Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Tender Contract Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `inn_name` SET TAGS ('dbx_business_glossary_term' = 'International Nonproprietary Name (INN)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `net_submitted_price` SET TAGS ('dbx_business_glossary_term' = 'Net Submitted Price');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `net_submitted_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `pack_size` SET TAGS ('dbx_business_glossary_term' = 'Pack Size');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `price_benchmark_country_code` SET TAGS ('dbx_business_glossary_term' = 'Price Benchmark Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `price_benchmark_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Product Strength');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Tender Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `submission_notes` SET TAGS ('dbx_business_glossary_term' = 'Tender Submission Notes');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `submission_owner` SET TAGS ('dbx_business_glossary_term' = 'Tender Submission Owner');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Tender Submission Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `submitted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Submitted Unit Price');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `submitted_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `tender_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Tender Authority Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `tender_authority_type` SET TAGS ('dbx_business_glossary_term' = 'Tender Authority Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `tender_authority_type` SET TAGS ('dbx_value_regex' = 'national_health_system|government_ministry|hospital_group|regional_authority|gpo|pbm');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `tender_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Tender Lot Number');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `tender_opening_date` SET TAGS ('dbx_business_glossary_term' = 'Tender Opening Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `tender_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Tender Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `tender_type` SET TAGS ('dbx_business_glossary_term' = 'Tender Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `tender_type` SET TAGS ('dbx_value_regex' = 'open|restricted|negotiated|framework_agreement|direct_award');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`tender_submission` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'pack|vial|dose|unit|kg|liter');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` SET TAGS ('dbx_subdomain' = 'contract_management');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `outcomes_based_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Outcomes-Based Contract ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `market_heor_study_id` SET TAGS ('dbx_business_glossary_term' = 'Market Heor Study Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `market_payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Account ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `rwe_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Rwe Dataset Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `base_rebate_pct` SET TAGS ('dbx_business_glossary_term' = 'Base Rebate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `base_rebate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Outcomes-Based Contract Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Outcomes-Based Contract Number');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `contract_owner` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Outcomes-Based Contract Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|under_reconciliation|closed|terminated');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Outcomes-Based Contract Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'outcomes_based|value_based|risk_sharing|pay_for_performance|coverage_with_evidence');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `data_sharing_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Agreement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `data_source_type` SET TAGS ('dbx_business_glossary_term' = 'Outcome Data Source Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `data_source_type` SET TAGS ('dbx_value_regex' = 'claims_data|ehr_data|registry_data|rwe_rwd|clinical_trial|payer_database');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `icd_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases (ICD) Code');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `icd_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9A-Z]{1,4})?$');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `max_rebate_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Rebate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `max_rebate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `measurement_methodology` SET TAGS ('dbx_business_glossary_term' = 'Outcome Measurement Methodology');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `measurement_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `measurement_period_months` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `measurement_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Measurement Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `most_favored_nation_clause` SET TAGS ('dbx_business_glossary_term' = 'Most Favored Nation (MFN) Clause');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `most_favored_nation_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `observed_outcome_rate` SET TAGS ('dbx_business_glossary_term' = 'Observed Outcome Rate');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `outcome_metric_name` SET TAGS ('dbx_business_glossary_term' = 'Outcome Metric Name');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `outcome_metric_type` SET TAGS ('dbx_business_glossary_term' = 'Outcome Metric Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `outcome_metric_type` SET TAGS ('dbx_value_regex' = 'clinical|economic|patient_reported|composite');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `patient_cohort_size` SET TAGS ('dbx_business_glossary_term' = 'Patient Cohort Size');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `performance_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Performance Threshold Value');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `rebate_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Rebate Adjustment Amount');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `rebate_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `rebate_adjustment_pct` SET TAGS ('dbx_business_glossary_term' = 'Rebate Adjustment Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `rebate_adjustment_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `reconciliation_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `reconciliation_lag_days` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Lag Days');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `rwe_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Real-World Evidence (RWE) Study Reference');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `target_indication` SET TAGS ('dbx_business_glossary_term' = 'Target Indication');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `threshold_direction` SET TAGS ('dbx_business_glossary_term' = 'Performance Threshold Direction');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `threshold_direction` SET TAGS ('dbx_value_regex' = 'above|below|equal');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Performance Threshold Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`outcomes_based_contract` ALTER COLUMN `variance_from_threshold` SET TAGS ('dbx_business_glossary_term' = 'Variance from Performance Threshold');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` SET TAGS ('dbx_subdomain' = 'strategy_planning');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` SET TAGS ('dbx_association_edges' = 'market.access_strategy,hcp.hcp_kol_profile');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `kol_engagement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'KOL Engagement Plan ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Kol Engagement Plan - Access Strategy Id');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Owner');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `hcp_kol_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Kol Engagement Plan - Hcp Kol Profile Id');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `actual_activity_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Activity Count');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Engagement End Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `actual_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Engagement Spend');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Engagement Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Engagement Budget');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Engagement Effectiveness Score');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `engagement_tier` SET TAGS ('dbx_business_glossary_term' = 'Engagement Tier');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Enrollment Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `kol_engagement_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `kol_role_in_strategy` SET TAGS ('dbx_business_glossary_term' = 'KOL Role in Strategy');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Engagement Notes');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Engagement End Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Engagement Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`kol_engagement_plan` ALTER COLUMN `target_activity_count` SET TAGS ('dbx_business_glossary_term' = 'Target Activity Count');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` SET TAGS ('dbx_subdomain' = 'evidence_generation');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` SET TAGS ('dbx_association_edges' = 'market.heor_study,market.rwe_dataset');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `study_data_sourcing_id` SET TAGS ('dbx_business_glossary_term' = 'Study Data Sourcing ID');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `market_heor_study_id` SET TAGS ('dbx_business_glossary_term' = 'Study Data Sourcing - Market Heor Study Id');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `rwe_dataset_id` SET TAGS ('dbx_business_glossary_term' = 'Study Data Sourcing - Rwe Dataset Id');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `data_contribution_type` SET TAGS ('dbx_business_glossary_term' = 'Data Contribution Type');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `data_extraction_date` SET TAGS ('dbx_business_glossary_term' = 'Data Extraction Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `data_vintage_used` SET TAGS ('dbx_business_glossary_term' = 'Data Vintage Used');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Reason');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `inclusion_date` SET TAGS ('dbx_business_glossary_term' = 'Dataset Inclusion Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `patient_count_contributed` SET TAGS ('dbx_business_glossary_term' = 'Patient Count Contributed');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `primary_dataset_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Dataset Flag');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `sourcing_status` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Status');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`study_data_sourcing` ALTER COLUMN `study_role` SET TAGS ('dbx_business_glossary_term' = 'Dataset Study Role');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary` SET TAGS ('dbx_subdomain' = 'payer_relations');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary` ALTER COLUMN `formulary_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary` ALTER COLUMN `parent_formulary_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`formulary` ALTER COLUMN `gross_to_net_adjustment_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` SET TAGS ('dbx_subdomain' = 'payer_relations');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `pbm_id` SET TAGS ('dbx_business_glossary_term' = 'Pbm Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `parent_pbm_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `headquarters_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `market_share_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pbm` ALTER COLUMN `rebate_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` SET TAGS ('dbx_subdomain' = 'revenue_operations');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `pharmacy_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `parent_pharmacy_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `dea_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `dispensing_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`market`.`pharmacy` ALTER COLUMN `reimbursement_rate_schedule` SET TAGS ('dbx_confidential' = 'true');
