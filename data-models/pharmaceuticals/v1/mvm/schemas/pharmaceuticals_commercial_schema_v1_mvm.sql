-- Schema for Domain: commercial | Business: Pharmaceuticals | Version: v1_mvm
-- Generated on: 2026-05-05 21:10:57

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`commercial` COMMENT 'Handles commercial operations including sales force management, healthcare professional (HCP) engagement, key opinion leader (KOL) relationships, promotional materials (Veeva PromoMats), territory management, product launch activities, sample distribution, and speaker programs. Integrates with Veeva CRM and Salesforce Health Cloud. Manages compliance with promotional regulations, PhRMA code, and Sunshine Act transparency reporting. Supports brand performance tracking and P&L reporting by brand.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`brand` (
    `brand_id` BIGINT COMMENT 'Unique surrogate identifier for the pharmaceutical brand record in the commercial data product. Primary key for all brand-level analytics, P&L reporting, and commercial activity linkage.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Market access strategies are developed per brand to define formulary positioning, pricing, and payer engagement plans. Core market access planning process requires linking brand to its access strategy',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Brands are often marketed at specific drug product level (strength/dosage form). Sample management, call detailing, and promotional activities operate at drug product granularity. Real business proces',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Brands benefit from regulatory exclusivity (orphan, pediatric, data); commercial forecasting, LOE planning, and pricing strategy require direct exclusivity linkage.',
    `fto_analysis_id` BIGINT COMMENT 'Foreign key linking to intellectual.fto_analysis. Business justification: Freedom-to-Operate analyses are conducted per brand before commercial launch to assess third-party IP risk. Commercial and IP teams reference FTO analysis results in launch readiness reviews and brand',
    `indication_id` BIGINT COMMENT 'Foreign key linking to product.indication. Business justification: Brands are commercially positioned for specific approved indications. brand.indication is plain text. FK to indication supports indication-level revenue forecasting, regulatory designation tracking, a',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: Brands are the commercial name for a drug whose active ingredient is registered under an INN. Pharma commercial teams link brands to INN for HTA dossiers, biosimilar competition tracking, and global t',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Brands are owned/marketed by specific legal entities. Required for financial consolidation, regulatory submissions (NDA/BLA ownership attribution), transfer pricing, P&L reporting by legal entity, and',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Brands built on in-licensed compounds must reference the licensing agreement governing commercialization rights, royalty obligations, and territory restrictions. Brand management teams need this link ',
    `lifecycle_id` BIGINT COMMENT 'Foreign key linking to product.lifecycle. Business justification: Brand commercial strategy (launch, growth, LOE defense, generic entry) is directly gated by product lifecycle stage. FK to lifecycle supports portfolio investment decisions, LOE strategy planning, and',
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: Brands map to ATC therapeutic classification. Essential for regulatory submissions, formulary positioning, market access dossiers, competitive intelligence, and HTA submissions requiring standardized ',
    `masterdata_ndc_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.ndc_code. Business justification: Brands have associated NDC codes for US market identification. Required for distribution, pricing submissions to CMS, Medicaid rebate calculations, 340B program compliance, and chargeback processing.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Brands are commercial identities of medicinal products. Brand performance reporting, promotional planning, sales tracking, and launch planning all require linking brand to underlying medicinal product',
    `molecular_target_id` BIGINT COMMENT 'Foreign key linking to discovery.molecular_target. Business justification: Brands mechanism of action is defined by the molecular target validated in discovery. Required for medical affairs content generation, competitive positioning, label claims, promotional material accu',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent_family. Business justification: Brands are covered by patent families; portfolio management, global launch sequencing, and IP strategy require patent family linkage for comprehensive protection view.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Brands are protected by patents; lifecycle management, loss of exclusivity planning, and regulatory strategy require direct patent linkage. Essential for commercial planning in pharmaceuticals.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Brands are approved and launched in a primary market country; this drives launch sequencing, market access strategy, and regulatory tracking. primary_market is a denormalized country name. A pharma co',
    `project_id` BIGINT COMMENT 'Foreign key linking to discovery.discovery_project. Business justification: Brands originate from specific discovery projects that identified and advanced the molecule through preclinical development. Required for portfolio tracking, asset genealogy, investment return analysi',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Brand portfolio management, P&L reporting, and commercial strategy are organized by therapeutic area. brand.therapeutic_area is a plain-text denormalization; a proper FK to therapeutic_area supports T',
    `trademark_id` BIGINT COMMENT 'Foreign key linking to intellectual.trademark. Business justification: Brand names are registered trademarks; legal protection, brand strategy, and market exclusivity depend on trademark registration. Core IP protection for commercial brands.',
    `transfer_price_id` BIGINT COMMENT 'Foreign key linking to finance.transfer_price. Business justification: Each pharma brand has an applicable intercompany transfer price for cross-border supply. The brand P&L, intercompany reconciliation, and tax compliance (OECD transfer pricing) process requires linking',
    `brand_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the brand across commercial systems including Veeva CRM, SAP SD, and Salesforce Health Cloud. Used as the business key for cross-system reconciliation and reporting.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `brand_name` STRING COMMENT 'The proprietary trade name of the pharmaceutical product as approved by the regulatory authority (e.g., FDA, EMA) and used in commercial promotion, packaging, and market-facing communications.',
    `brand_status` STRING COMMENT 'Current operational status of the brand within the commercial organization. Controls whether the brand is eligible for promotional spend, sales force detailing, and market access activities.. Valid values are `active|inactive|discontinued|divested|pending_launch`',
    `controlled_substance_schedule` STRING COMMENT 'The DEA controlled substance schedule classification for the brand, if applicable. Determines distribution controls, sample restrictions, and reporting obligations under the Controlled Substances Act. not_scheduled for non-controlled products.. Valid values are `not_scheduled|schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the brand master record was first created in the commercial data platform. Supports audit trail requirements under 21 CFR Part 11 and SOX data governance controls.',
    `global_brand_owner` STRING COMMENT 'The legal entity name of the global brand owner responsible for the NDA/BLA/MAA and global P&L accountability. Relevant for intercompany transfer pricing, royalty agreements, and IP ownership tracking.',
    `global_launch_sequence` STRING COMMENT 'Numeric sequence indicating the order in which this brand was launched globally relative to other brands in the portfolio. Used for portfolio prioritization, resource allocation, and launch excellence benchmarking.',
    `is_flagship_brand` BOOLEAN COMMENT 'Indicates whether this brand is designated as a flagship or priority brand by commercial leadership, warranting elevated promotional investment, dedicated sales force, and executive-level performance reporting.',
    `launch_date` DATE COMMENT 'The date on which the brand was first commercially available in its primary market following regulatory approval. Used as the anchor date for launch performance tracking, market share ramp analysis, and P&L reporting.',
    `lifecycle_stage` STRING COMMENT 'Current stage of the brand in its commercial lifecycle. Drives resource allocation, promotional investment levels, and strategic planning. Loss of exclusivity (LOE) stage triggers biosimilar/generic competition response planning.. Valid values are `pre_launch|launch|growth|mature|loss_of_exclusivity|divested`',
    `loss_of_exclusivity_date` DATE COMMENT 'The projected or confirmed date on which the brands market exclusivity expires, enabling generic or biosimilar competition. Critical for long-range financial planning, patent strategy, and lifecycle management decisions.',
    `orphan_drug_designation` BOOLEAN COMMENT 'Indicates whether the brand has received Orphan Drug Designation from the FDA (ODD) or EMA (OMP), conferring 7-year US market exclusivity, 10-year EU exclusivity, and tax incentives. Affects pricing strategy and market access negotiations.',
    `patent_expiry_date` DATE COMMENT 'The expiry date of the primary composition-of-matter or method-of-use patent protecting the brand. Distinct from LOE date as patent term extensions (PTE) and data exclusivity may extend commercial protection beyond patent expiry.',
    `pl_cost_center` STRING COMMENT 'The SAP cost center code to which all brand-level revenues, promotional spend, and COGS are allocated for P&L reporting. Enables brand-level financial performance tracking and budget variance analysis.',
    `primary_competitor_brands` STRING COMMENT 'Comma-separated list of key competitor brand names in the same therapeutic class. Used for competitive intelligence, market share benchmarking, and sales force training. Classified as confidential competitive intelligence.',
    `profit_center` STRING COMMENT 'The SAP profit center assigned to the brand for internal management accounting and brand-level P&L reporting. Distinct from cost center; used for contribution margin analysis and brand portfolio performance reporting.',
    `rems_required` BOOLEAN COMMENT 'Indicates whether the FDA has mandated a Risk Evaluation and Mitigation Strategy (REMS) for this brand due to serious safety risks. REMS programs impose specific distribution, prescribing, and patient monitoring requirements that affect commercial operations.',
    `sample_eligible` BOOLEAN COMMENT 'Indicates whether the brand is eligible for distribution of drug samples to healthcare professionals (HCPs) by the sales force. Controlled by PDMA regulations and PhRMA code. DEA scheduled products and REMS products may have restrictions.',
    `sap_material_number` STRING COMMENT 'The SAP material master number assigned to the brands primary commercial SKU in SAP S/4HANA MM/SD modules. Used for order management, COGS tracking, and supply chain integration.',
    `strategy_statement` STRING COMMENT 'The overarching commercial strategy statement for the brand, capturing positioning, differentiation, and value proposition relative to competitors. Classified as confidential business strategy. Sourced from the brand plan approved by commercial leadership.',
    `sunshine_act_reportable` BOOLEAN COMMENT 'Indicates whether transfers of value associated with this brand (samples, speaker fees, meals, educational grants) are subject to Open Payments (Sunshine Act) reporting to CMS. Drives compliance workflows in Veeva CRM and SAP.',
    `target_patient_population` STRING COMMENT 'Description of the intended patient population for the brand, including disease stage, biomarker status, prior treatment history, and demographic criteria. Informs HCP targeting, patient support program design, and HEOR value dossier development.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to the brand master record. Used for change data capture (CDC) in the Databricks Silver layer pipeline and audit trail compliance under 21 CFR Part 11.',
    `veeva_crm_product_code` STRING COMMENT 'The product identifier assigned to this brand in Veeva CRM (Salesforce Health Cloud), used to link brand records to HCP call activity, sample transactions, promotional material approvals (PromoMats), and speaker program events.',
    CONSTRAINT pk_brand PRIMARY KEY(`brand_id`)
) COMMENT 'Master record for each pharmaceutical brand managed by the commercial organization. Captures brand identity, therapeutic area, lifecycle stage (pre-launch, launch, growth, mature, LOE), brand strategy, target patient population, approved indications, ATC classification, INN/USAN, and P&L ownership. Serves as the commercial anchor entity linking all brand-level activities, performance tracking, promotional spend, and market share measurement.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique surrogate identifier for the sales territory record in the Databricks Silver Layer. Primary key for the territory data product.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Territory budgets control field force spending on samples, speaker programs, promotional activities. Standard commercial operations budget allocation and variance tracking.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Territories operate within specific countries with distinct regulatory frameworks. Required for country-specific promotional compliance (PhRMA/EFPIA codes), market segmentation, regional performance r',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Territories operate under a specific legal entity for Sunshine Act reporting, PDMA compliance, and transfer-of-value transparency. territory has sunshine_act_reporting_required flag but no legal entit',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Territory commercialization rights are often defined by licensing agreement territorial grants. For in-licensed or co-promoted products, territories must be validated against licensing agreement geogr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Territories are cost centers for budgeting and expense allocation. Required for promotional spend tracking, sales rep expense allocation, budget vs. actual reporting, and commercial operations P&L by ',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Territories are aligned to org_units (business units/regions) in pharma field force management for headcount reporting, budget allocation, and sales force effectiveness analysis. A commercial operatio',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Territories are aligned to patented products; sales planning, quota setting, and resource allocation require patent/exclusivity awareness for strategic territory design.',
    `brand_id` BIGINT COMMENT 'FK to commercial.brand',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Sales territories in pharma are aligned to therapeutic areas (oncology vs. immunology sales forces). territory.therapeutic_area is plain text. FK supports territory alignment reporting, sales force si',
    `alignment_version` STRING COMMENT 'Version identifier of the territory alignment cycle that produced this territory definition (e.g., FY2024-Q1, ALIGN-2024-H2). Enables tracking of territory changes across realignment cycles and supports historical performance attribution.. Valid values are `^[A-Z0-9._-]{1,30}$`',
    `area_code` STRING COMMENT 'Code identifying the sales area (highest-level geographic grouping above region) to which this territory belongs. Supports national-level roll-up reporting and executive P&L attribution.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `brick_count` STRING COMMENT 'Number of geographic bricks (smallest geographic unit used in pharmaceutical territory alignment, typically a ZIP+4 or sub-ZIP unit) assigned to this territory. Used to measure territory size and workload balance during alignment planning.',
    `call_plan_frequency` STRING COMMENT 'Target number of calls (HCP visits) per representative per cycle (typically quarterly) for this territory as defined in the call plan. Used for field force productivity measurement and compliance tracking in Veeva CRM.',
    `county_list` STRING COMMENT 'Semicolon-delimited list of county names or FIPS county codes included within this territorys geographic boundary. Complements ZIP code alignment for rural territory definitions and Sunshine Act county-level reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory record was first created in the data platform. Supports audit trail, data lineage, and bi-temporal modeling requirements.',
    `crm_territory_code` STRING COMMENT 'Native territory identifier from the source CRM system (Veeva CRM or Salesforce Health Cloud). Used for cross-system reconciliation, data lineage tracing, and integration with call activity and sample distribution records.. Valid values are `^[A-Za-z0-9_-]{1,50}$`',
    `decile_rank` STRING COMMENT 'Decile ranking (1–10) of the territory based on market potential or historical sales performance relative to all territories in the same alignment. Decile 1 represents the highest-potential territories. Used for resource allocation and call frequency prioritization.',
    `effective_end_date` DATE COMMENT 'Date on which this territory definition ceases to be operationally active. Null indicates an open-ended, currently active territory. Used for historical alignment queries and performance period attribution.',
    `effective_start_date` DATE COMMENT 'Date from which this territory definition becomes operationally active for call planning, target assignment, and performance attribution. Supports bi-temporal modeling of territory changes.',
    `geographic_area_sq_miles` DECIMAL(18,2) COMMENT 'Total geographic area of the territory in square miles. Used to assess travel burden for field representatives and to balance territory workload during alignment planning.',
    `is_open_territory` BOOLEAN COMMENT 'Indicates whether the territory is currently unassigned (open) with no active field representative. Open territories require coverage planning and may be temporarily covered by adjacent representatives or district managers.',
    `is_specialty_overlay` BOOLEAN COMMENT 'Indicates whether this territory is a specialty overlay territory that operates in conjunction with a primary territory (e.g., an oncology specialist overlay on top of a primary care territory). Used to manage co-promotion and dual-rep call planning.',
    `last_realignment_date` DATE COMMENT 'Date on which this territorys boundaries, targets, or assignments were last modified as part of a formal territory realignment exercise. Used to track alignment cycle history and assess the currency of territory definitions.',
    `market_potential_index` DECIMAL(18,2) COMMENT 'Normalized index score (typically 0.0000–9.9999) representing the estimated prescribing potential of the territory based on IQVIA/IQVIA data, patient population, and payer mix. Used for territory sizing, quota setting, and alignment optimization.',
    `state_province_code` STRING COMMENT 'ISO 3166-2 state or province code for the primary state/province covered by this territory (e.g., NY, CA, ON). Used for geographic boundary definition, Sunshine Act state-level reporting, and call planning.. Valid values are `^[A-Z]{2,5}$`',
    `sunshine_act_reporting_required` BOOLEAN COMMENT 'Indicates whether HCP engagement activities within this territory are subject to mandatory Open Payments (Sunshine Act) transparency reporting to CMS. Typically true for US territories; false for territories outside US jurisdiction.',
    `target_account_count` STRING COMMENT 'Number of institutional accounts (hospitals, clinics, group practices, IDNs) designated as call targets within this territory. Used for key account planning and workload analysis.',
    `target_hcp_count` STRING COMMENT 'Number of Healthcare Professionals (HCPs) designated as call targets within this territory for the current alignment cycle. Used for workload balancing, call planning, and field force sizing analysis.',
    `territory_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the territory within the field force alignment system. Used as the business key in Veeva CRM and Salesforce Health Cloud for call planning and target assignment.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `territory_name` STRING COMMENT 'Human-readable name of the sales territory (e.g., Northeast Oncology Zone 3). Used for display in CRM dashboards, call planning tools, and performance reporting.',
    `territory_status` STRING COMMENT 'Current lifecycle status of the territory record. Active territories are in use for call planning and performance attribution; inactive territories have been decommissioned; pending territories are awaiting activation in a future alignment cycle; archived territories are retained for historical reporting.. Valid values are `active|inactive|pending|archived`',
    `territory_type` STRING COMMENT 'Classification of the territory by its role in the field force structure. Primary territories are standard rep assignments; secondary territories represent overlapping coverage; specialty territories cover specific therapeutic areas; managed_care and key_account types address payer and institutional customers.. Valid values are `primary|secondary|specialty|managed_care|key_account`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this territory record was last modified in the data platform. Used for incremental data loading, change detection, and audit trail compliance.',
    `urban_rural_classification` STRING COMMENT 'Classification of the territorys geographic character as urban, suburban, rural, or mixed. Influences call planning strategy, travel time estimates, and field force resource allocation decisions.. Valid values are `urban|suburban|rural|mixed`',
    `workload_index` DECIMAL(18,2) COMMENT 'Composite index score measuring the estimated field representative workload for this territory, factoring in target HCP count, call frequency, geographic travel burden, and account complexity. Used for territory balancing during alignment cycles.',
    `zip_code_list` STRING COMMENT 'Semicolon-delimited list of US ZIP codes (or equivalent postal codes) that define the geographic boundary of this territory. Used for HCP target assignment, call planning, and territory alignment in Veeva CRM. Stored as a delimited string per Silver Layer conventions; spatial decomposition occurs in the Gold Layer.',
    CONSTRAINT pk_territory PRIMARY KEY(`territory_id`)
) COMMENT 'Defines the geographic and organizational sales territories used to structure the field force. Captures territory code, name, geographic boundaries (zip codes, counties, states, regions), territory type (primary, secondary, specialty), alignment version, effective dates, and assigned district and region hierarchy. Used for call planning, target assignment, and performance attribution in Veeva CRM and Salesforce Health Cloud.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` (
    `sales_rep_id` BIGINT COMMENT 'Unique surrogate identifier for the commercial field force representative record in the Pharmaceuticals data lakehouse. Primary key for the sales_rep master entity.',
    `brand_id` BIGINT COMMENT 'Identifier of the primary pharmaceutical brand or product the sales representative is responsible for promoting. Used for brand performance tracking, promotional compliance, and sample authorization. A rep may promote multiple brands but one is designated primary.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Rep-level expense budgets for samples, meals, promotional materials. Required for field force cost control and Sunshine Act spend tracking.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Sales reps operate in a specific country for regulatory compliance, Sunshine Act jurisdiction determination, and field force deployment reporting. country_code is a denormalized country reference. A c',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Sales rep costs (salary allocation, T&E, sample costs) are tracked against internal orders in pharma SAP environments. The sales force cost management, headcount reporting, and incentive compensation ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Sales reps are employed by a specific legal entity, which is critical for Sunshine Act reporting, employment law compliance, and transfer-of-value transparency. sales_rep has sunshine_act_reportable f',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Sales reps are assigned to cost centers for expense tracking and budget allocation. Required for headcount planning, promotional spend allocation, IC plan administration, and commercial operations P&L',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Sales reps belong to an org_unit (business unit) for headcount management, budget allocation, and sales force effectiveness reporting. business_unit is a denormalized org_unit name. A field force mana',
    `territory_id` BIGINT COMMENT 'Foreign key linking to the territory to which the sales representative is assigned',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Sales reps are hired, certified, and deployed by therapeutic area. sales_rep.therapeutic_area is plain text. FK supports rep certification tracking, TA-specific training compliance, incentive compensa',
    `annual_call_target` STRING COMMENT 'Target number of HCP sales calls (details) the representative is expected to complete within the fiscal year, as set by the commercial operations team. Used for field force productivity tracking and performance management in Veeva CRM.',
    `call_plan_frequency_target` STRING COMMENT 'Target number of HCP calls per cycle for this specific rep-territory assignment. Differs by rep role and territory type — an overlay rep may have a lower target than the primary rep for the same territory. Identified in detection phase as relationship-level data.',
    `certification_expiry_date` DATE COMMENT 'Date on which the sales representatives current product or compliance certification expires. Triggers re-certification workflows and may restrict sample distribution or promotional activity if expired.',
    `effective_end_date` DATE COMMENT 'Date on which the current territory, role, and business unit assignment for this sales representative ceases to be effective. Null indicates the current active assignment. Supports SCD Type 2 history tracking for territory realignments and role changes.',
    `effective_start_date` DATE COMMENT 'Date from which the current territory, role, and business unit assignment for this sales representative is effective. Supports slowly changing dimension (SCD) Type 2 history tracking for territory and role changes over time.',
    `employment_status` STRING COMMENT 'Current employment lifecycle status of the sales representative. Drives CRM access provisioning, territory assignment eligibility, sample authorization, and Sunshine Act reporting inclusion. Active = currently employed and field-active; On Leave = temporary absence (FMLA, medical, parental); Terminated = employment ended; Suspended = temporarily restricted from field activity; Pending Start = hired but not yet active.. Valid values are `active|on_leave|terminated|suspended|pending_start`',
    `first_name` STRING COMMENT 'Legal given name of the sales representative as recorded in the HR system of record. Used for display, communication, and identity verification.',
    `gcp_certified` BOOLEAN COMMENT 'Indicates whether the sales representative holds a current Good Clinical Practice (GCP) certification. Required for MSLs and reps supporting clinical trial site engagement or investigator-initiated study discussions. Sourced from the Learning Management System (LMS).',
    `hcp_engagement_tier` STRING COMMENT 'Classification of the sales representatives HCP engagement level based on the complexity and strategic importance of their account portfolio. Tier 1 = high-value specialist/KOL accounts; Tier 2 = mid-level specialist accounts; Tier 3 = primary care/general accounts. Drives call frequency targets and resource allocation.. Valid values are `tier_1|tier_2|tier_3`',
    `hire_date` DATE COMMENT 'Official date on which the sales representative was hired by the organization, as recorded in the HR system of record (SAP S/4HANA). Used for tenure calculations, vesting schedules, and compliance reporting.',
    `job_title` STRING COMMENT 'Official job title of the sales representative as recorded in the HR system (e.g., Senior Specialty Sales Representative, Oncology Territory Manager, Medical Science Liaison). Used for organizational reporting and external business card / signature purposes.',
    `last_name` STRING COMMENT 'Legal family name of the sales representative as recorded in the HR system of record. Used for display, reporting, and identity verification.',
    `product_certification_status` STRING COMMENT 'Current status of the sales representatives product knowledge certification for their assigned brand(s). Reps must be certified before being authorized to promote a product or distribute samples. Sourced from the LMS or MasterControl/TrackWise training records.. Valid values are `certified|in_progress|expired|not_started`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales representative master record was first created in the data lakehouse Silver layer. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit trail, and record lifecycle management per 21 CFR Part 11.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the sales representative master record in the data lakehouse Silver layer. Used for change data capture (CDC), audit trail, and data freshness monitoring per 21 CFR Part 11.',
    `rep_role` STRING COMMENT 'Commercial field force role classification defining the reps function and engagement model. Territory Manager (TM) handles primary care accounts; Specialty Rep focuses on specialist HCPs; Key Account Manager (KAM) manages institutional/payer accounts; Medical Science Liaison (MSL) provides scientific exchange; Managed Care Specialist handles formulary access; National Account Manager handles national-level payer/GPO relationships. [ENUM-REF-CANDIDATE: territory_manager|specialty_rep|key_account_manager|medical_science_liaison|managed_care_specialist|national_account_manager — promote to reference product]. Valid values are `territory_manager|specialty_rep|key_account_manager|medical_science_liaison|managed_care_specialist|national_account_manager`',
    `sample_authorization_status` STRING COMMENT 'Current authorization status of the sales representative to distribute drug samples to HCPs. Governed by the Prescription Drug Marketing Act (PDMA) and PhRMA Code. Suspended or revoked status prevents sample transactions in Veeva CRM.. Valid values are `authorized|suspended|revoked|pending`',
    `speaker_program_eligible` BOOLEAN COMMENT 'Indicates whether the sales representative is authorized to organize or facilitate HCP speaker programs on behalf of the company. Eligibility requires completion of speaker program compliance training and manager approval. Governed by PhRMA Code and OIG guidelines.',
    `state_province_code` STRING COMMENT 'ISO 3166-2 state or province code for the primary operating geography of the sales representative (e.g., NY, CA, TX). Used for state-level compliance reporting, state Sunshine Act equivalents, and territory boundary management.. Valid values are `^[A-Z]{2,3}$`',
    `sunshine_act_reportable` BOOLEAN COMMENT 'Indicates whether this sales representatives HCP interactions and transfers of value are subject to Open Payments (Sunshine Act) reporting requirements under 42 U.S.C. § 1320a-7h. MSLs and reps engaging in speaker programs or providing meals/gifts to HCPs are typically reportable.',
    `termination_date` DATE COMMENT 'Date on which the sales representatives employment was formally terminated. Null if currently employed. Used to deactivate CRM access, close territory assignments, finalize Sunshine Act reporting periods, and trigger sample reconciliation processes.',
    `veeva_crm_user_code` STRING COMMENT 'Unique user identifier assigned to the sales representative within Veeva CRM (Salesforce Health Cloud / Veeva CRM). Used to link field activity records, call logs, HCP interactions, and sample transactions back to the rep. Critical for CRM data lineage and compliance reporting.',
    `veeva_promomats_access` BOOLEAN COMMENT 'Indicates whether the sales representative has active access to Veeva PromoMats for retrieving approved promotional materials. Access is role-based and tied to brand assignment and certification status. Ensures only MLR-approved content is used in HCP interactions.',
    `work_email` STRING COMMENT 'Corporate email address of the sales representative used for official business communications, Veeva CRM login, and system notifications. Sourced from the enterprise directory (e.g., Active Directory / SAP S/4HANA).. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_phone` STRING COMMENT 'Primary corporate mobile or desk phone number assigned to the sales representative for field communications and HCP engagement. Sourced from HR or CRM system.',
    CONSTRAINT pk_sales_rep PRIMARY KEY(`sales_rep_id`)
) COMMENT 'Commercial field force representative master record. Captures rep identity, employee ID, role (territory manager, specialty rep, MSL, KAM), assigned territory, district, region, business unit, hire date, certification status, Veeva CRM user ID, and current employment status. This is the commercial-specific view of the field force with CRM linkage, territory assignment, and credentialing — distinct from the workforce domain employee record which owns HR lifecycle data.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` (
    `hcp_target_id` BIGINT COMMENT 'Unique surrogate identifier for the HCP targeting and call planning record within the commercial segmentation and planning layer.',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand or product for which this HCP is being targeted. Supports brand-level P&L reporting and promotional resource allocation.',
    `brand_plan_id` BIGINT COMMENT 'Foreign key linking to commercial.brand_plan. Business justification: hcp_target is the call planning record that operationalizes the brand_plans targeting strategy. HCP targets are created as part of brand plan execution — the brand_plan defines target_hcp_segment, ca',
    `formulary_position_id` BIGINT COMMENT 'Foreign key linking to market.formulary_position. Business justification: HCP targeting considers formulary position to prioritize physicians where brand has favorable access. Targeting strategy and resource allocation process links targets to formulary status for call plan',
    `master_id` BIGINT COMMENT 'Reference to the HCP master record (owned by the hcp domain) that is being targeted. This is the commercial segmentation layer — the HCP master itself is managed separately.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: HCP targeting strategies are product-specific. Call planning, territory design, and prescriber segmentation require product linkage. Real business process: targeting cycle planning and call plan optim',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to clinical.principal_investigator. Business justification: Commercial targeting identifies KOLs who are clinical investigators. Enables coordinated engagement strategy, speaker recruitment from trial sites, advisory board selection, and transparency reporting',
    `sales_rep_id` BIGINT COMMENT 'Reference to the sales representative (field force employee) assigned to engage this HCP target within the territory for the planning cycle.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory to which this HCP target is assigned for the planning cycle. Drives field force routing and call planning in Veeva CRM.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: HCP targeting lists are built by therapeutic area for specialty segmentation and call planning. hcp_target.therapeutic_area is plain text. FK supports TA-level HCP segmentation reports, targeting anal',
    `trial_id` BIGINT COMMENT 'Foreign key linking to clinical.trial. Business justification: Trial participation is a primary HCP targeting criterion in pharma — investigators and trial-aware physicians are high-priority targets for commercial engagement post-approval. CRM targeting rationale',
    `approval_status` STRING COMMENT 'Workflow approval status of the targeting plan record. Tracks whether the target assignment has been reviewed and approved by the regional or national sales manager before field force execution.. Valid values are `draft|submitted|approved|rejected|withdrawn`',
    `approved_by` STRING COMMENT 'Name or identifier of the sales manager or commercial operations approver who authorized this HCP target plan record. Supports audit trail and compliance review.',
    `approved_date` DATE COMMENT 'Date on which the targeting plan record was formally approved by the authorized sales manager or commercial operations team. Marks the transition from planning to execution.',
    `call_type_mix_pct_f2f` DECIMAL(18,2) COMMENT 'Percentage of total planned calls that are designated as face-to-face interactions (0.00–100.00). Used to monitor adherence to brand-level call mix strategy and field force deployment guidelines.',
    `competitor_prescriber` BOOLEAN COMMENT 'Indicates whether the HCP is known to prescribe a competing product in the same therapeutic class. Used to prioritize conversion-focused engagement strategies and messaging.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this HCP target record was first created in the system. Supports audit trail, data lineage, and compliance with 21 CFR Part 11 electronic records requirements.',
    `current_brand_prescriber` BOOLEAN COMMENT 'Indicates whether the HCP is currently an active prescriber of the targeted brand based on the most recent prescribing data. Distinguishes new-to-brand targets from existing prescribers for tailored engagement strategies.',
    `cycle_call_count` STRING COMMENT 'Number of completed sales calls made to this HCP for the targeted brand within the current cycle plan period. Used to measure in-cycle execution progress against planned_call_frequency.',
    `do_not_contact_flag` BOOLEAN COMMENT 'Indicates that this HCP has requested no promotional contact or has been placed on a do-not-contact list. When true, field force must not initiate promotional calls. Critical for compliance with HCP opt-out preferences and applicable privacy regulations.',
    `effective_end_date` DATE COMMENT 'Date on which this HCP target assignment expires or is no longer active. Nullable for open-ended targeting. Defines the end of the targeting period for the cycle.',
    `effective_start_date` DATE COMMENT 'Date from which this HCP target assignment is active and the field force is authorized to engage the HCP for the specified brand and territory. Defines the start of the targeting period.',
    `engagement_channel_preference` STRING COMMENT 'HCPs preferred channel for sales representative engagement as captured in Veeva CRM or Salesforce Health Cloud. Informs call type mix planning and omnichannel engagement strategy.. Valid values are `face_to_face|remote|email|hybrid|no_preference`',
    `is_kol` BOOLEAN COMMENT 'Indicates whether this HCP is designated as a Key Opinion Leader (KOL) for the targeted brand or therapeutic area. KOL status influences engagement strategy, speaker program eligibility, and medical affairs coordination.',
    `is_sample_eligible` BOOLEAN COMMENT 'Indicates whether this HCP is eligible to receive drug samples for the targeted brand. Governed by the Prescription Drug Marketing Act (PDMA) and internal sample distribution policies.',
    `is_speaker_eligible` BOOLEAN COMMENT 'Indicates whether this HCP is eligible to participate in brand speaker programs. Eligibility is governed by PhRMA Code compliance, Sunshine Act reporting requirements, and internal speaker bureau criteria.',
    `last_detail_date` DATE COMMENT 'Date of the most recent promotional detail (sales call) made to this HCP for the targeted brand. Used to monitor call recency, identify lapsed targets, and prioritize field force scheduling.',
    `market_potential_segment` STRING COMMENT 'Categorical assessment of the HCPs overall market potential for the brand, derived from prescribing volume, patient panel size, and payer mix. Used alongside prescribing_potential_decile for targeting decisions.. Valid values are `high|medium|low`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this HCP target record was most recently updated. Supports change tracking, audit trail, and incremental data pipeline processing in the Databricks Silver layer.',
    `planned_call_frequency` STRING COMMENT 'Target number of sales calls (details) planned for this HCP during the cycle plan period. Drives field force scheduling and activity quotas in Veeva CRM.',
    `planned_f2f_calls` STRING COMMENT 'Number of planned in-person (face-to-face) sales calls for this HCP within the cycle. Part of the call type mix alongside remote calls. Supports field force activity planning and compliance with call mix targets.',
    `planned_remote_calls` STRING COMMENT 'Number of planned remote (virtual/telephone) sales calls for this HCP within the cycle. Complements planned_f2f_calls to define the full call type mix for the planning period.',
    `prescribing_potential_decile` STRING COMMENT 'Decile ranking (1–10) of the HCPs estimated prescribing potential for the targeted brands therapeutic area, derived from claims data or market research. Decile 10 = highest prescribing potential. Key input to target tier assignment.',
    `priority_rank` STRING COMMENT 'Numeric rank of this HCP target within the territory for the given brand and cycle plan. Lower rank = higher priority. Used to sequence call planning when field force capacity is constrained.',
    `specialty_segment` STRING COMMENT 'Medical specialty segment of the HCP as used for commercial targeting purposes (e.g., Oncology, Cardiology, Immunology, Primary Care). May differ from the HCP master specialty if the brand targets a sub-specialty. [ENUM-REF-CANDIDATE: oncology|cardiology|immunology|primary_care|neurology|endocrinology|rheumatology|hematology|gastroenterology|pulmonology — promote to reference product]',
    `sunshine_act_reportable` BOOLEAN COMMENT 'Indicates whether interactions and transfers of value with this HCP target are subject to mandatory reporting under the U.S. Physician Payments Sunshine Act (Open Payments). Drives downstream aggregation for CMS Open Payments reporting.',
    `target_record_number` STRING COMMENT 'Business-facing unique identifier for this HCP target record, used in Veeva CRM and downstream reporting. Distinct from the surrogate hcp_target_id.',
    `target_tier` STRING COMMENT 'Segmentation tier assigned to the HCP for this brand and cycle, reflecting strategic priority for field force engagement. Tier A = highest priority, Tier D = lowest. Drives call frequency and resource allocation.. Valid values are `A|B|C|D`',
    `targeting_rationale` STRING COMMENT 'Free-text or structured justification for why this HCP has been selected and tiered for this brand and cycle. May reference prescribing behavior, patient population, KOL status, or market development opportunity.',
    `targeting_status` STRING COMMENT 'Current lifecycle status of this HCP target record within the planning cycle. Active = currently targeted; Inactive = de-prioritized; Pending = awaiting approval; Suspended = temporarily paused; Removed = excluded from targeting.. Valid values are `active|inactive|pending|suspended|removed`',
    `veeva_crm_record_code` STRING COMMENT 'Source system record identifier from Veeva CRM corresponding to this HCP target record. Used for data lineage, reconciliation, and integration with the Veeva CRM operational system.',
    `ytd_call_count` STRING COMMENT 'Number of completed sales calls (details) made to this HCP for the targeted brand in the current year-to-date period. Tracks field force execution against planned call frequency targets.',
    CONSTRAINT pk_hcp_target PRIMARY KEY(`hcp_target_id`)
) COMMENT 'Commercial targeting and call planning record linking an HCP (owned by the hcp domain) to a brand, territory, and sales rep for a given targeting/planning cycle. Captures target tier (A/B/C), planned call frequency, call type mix (face-to-face vs. remote), specialty segment, prescribing potential decile, targeting rationale, priority rank, effective period, plan approval status, and targeting status. Drives field force activity scheduling, call planning, and promotional resource allocation in Veeva CRM. Distinct from the HCP master (owned by hcp domain) — this is the commercial segmentation and planning layer.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` (
    `call_activity_id` BIGINT COMMENT 'Unique surrogate identifier for each field force call activity record in the Databricks Silver layer. Primary key for the call_activity data product.',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: call_activity records field force detail calls which are always conducted for a specific brand in pharma commercial operations. While drug_product_id and medicinal_product_id exist as product-level FK',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to hcp.consent_record. Business justification: GDPR/HIPAA compliance requires call records to reference a valid HCP consent record. Pharma CRM audit trails must prove consent was active at time of engagement. A pharma compliance officer would expe',
    `drug_product_id` BIGINT COMMENT 'Reference to the primary pharmaceutical product (brand) that was detailed during this call. The first-position detail product is the principal focus of the interaction.',
    `hco_master_id` BIGINT COMMENT 'Reference to the Healthcare Organization (HCO) where the call took place or which is the primary target when the call is at an institutional level. Nullable when the call is exclusively HCP-targeted.',
    `hcp_target_id` BIGINT COMMENT 'Foreign key linking to commercial.hcp_target. Business justification: A call_activity record is the execution of a planned interaction against an hcp_target (call planning record). Linking call_activity to hcp_target enables measurement of call plan attainment — how man',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Call activities generate transfer-of-value costs (meals, samples) tracked against internal orders for Sunshine Act reporting and promotional spend management. The HCP transfer-of-value reporting and p',
    `investigational_site_id` BIGINT COMMENT 'Foreign key linking to clinical.investigational_site. Business justification: Medical science liaisons (MSLs) conduct site engagement visits for recruitment support, data dissemination, and investigator relations. Tracks commercial-clinical interface at trial sites, essential f',
    `master_id` BIGINT COMMENT 'Reference to the Healthcare Professional (HCP) who was the primary target of this detail call. Links to the HCP master record.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Call activities detail medicinal products to HCPs. Call reporting, promotional effectiveness analysis, and reach/frequency metrics require product linkage. Real business process: call reporting and pr',
    `promo_material_id` BIGINT COMMENT 'Reference to the primary promotional material (detail aid, leave-behind, or digital asset) presented during the call, as approved in Veeva PromoMats. Supports promotional compliance auditing.',
    `sales_rep_id` BIGINT COMMENT 'Reference to the field sales representative (Medical Science Liaison, Sales Rep, or Key Account Manager) who conducted the call.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory in which this call activity occurred. Used for field force effectiveness measurement and territory performance reporting.',
    `call_date` DATE COMMENT 'The calendar date on which the field force interaction (detail call) took place. Principal business event date used for field force effectiveness reporting and Sunshine Act transparency reporting.',
    `call_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the call interaction concluded, as recorded in Veeva CRM. Used together with call_start_timestamp to derive call duration for field force effectiveness analytics.',
    `call_notes` STRING COMMENT 'Free-text narrative entered by the sales representative summarizing the content and outcome of the interaction. Classified as confidential due to potential inclusion of commercially sensitive HCP engagement details.',
    `call_objective` STRING COMMENT 'Pre-call stated objective or purpose of the interaction as entered by the sales representative in Veeva CRM. Supports pre-call planning analytics and coaching.',
    `call_outcome` STRING COMMENT 'Result of the call attempt as recorded by the sales representative. No_see indicates the HCP was unavailable. Used for field force effectiveness and access rate analytics.. Valid values are `completed|no_see|left_message|gatekeeper_only|cancelled`',
    `call_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the call interaction began, as recorded in Veeva CRM. Used for call duration calculation and scheduling compliance.',
    `call_status` STRING COMMENT 'Current lifecycle state of the call activity record within Veeva CRM workflow. Submitted indicates the rep has locked the record; Approved indicates manager sign-off has been completed.. Valid values are `planned|submitted|approved|rejected|cancelled`',
    `call_type` STRING COMMENT 'Classification of the interaction channel used for the detail call. Drives field force effectiveness segmentation and PhRMA code compliance checks. [ENUM-REF-CANDIDATE: face_to_face|remote_video|phone|email|congress|group_meeting|medical_education_event — promote to reference product if additional types are needed]. Valid values are `face_to_face|remote_video|phone|email|congress|group_meeting`',
    `channel_mix_code` STRING COMMENT 'Categorizes the call within the omnichannel engagement model (field, inside sales, digital, or hybrid). Supports channel mix optimization analytics and commercial strategy reporting.. Valid values are `field|inside_sales|digital|hybrid`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the call activity record was first created in Veeva CRM by the sales representative. Serves as the audit trail creation marker per 21 CFR Part 11 requirements.',
    `crm_sync_timestamp` TIMESTAMP COMMENT 'Timestamp when the call record was last synchronized from Veeva CRM into the Databricks Silver layer. Used for data freshness monitoring and pipeline audit.',
    `detail_priority_1_product` STRING COMMENT 'Brand name of the first-priority product detailed during the call, as recorded in Veeva CRM. Retained as a denormalized field for reporting convenience and Sunshine Act submission.',
    `detail_priority_2_product` STRING COMMENT 'Brand name of the second-priority product detailed during the call, if applicable. Supports multi-product detailing analysis and share-of-voice reporting.',
    `detail_priority_3_product` STRING COMMENT 'Brand name of the third-priority product detailed during the call, if applicable. Supports multi-product detailing analysis and share-of-voice reporting.',
    `hcp_reaction` STRING COMMENT 'Sales representatives assessment of the Healthcare Professionals reaction to the product detail during the call. Used for HCP engagement scoring and brand sentiment analytics.. Valid values are `very_positive|positive|neutral|negative|very_negative`',
    `kol_flag` BOOLEAN COMMENT 'Indicates whether the HCP visited during this call is classified as a Key Opinion Leader (KOL). Used for KOL engagement tracking and Medical Affairs coordination.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the call activity record in Veeva CRM. Required for audit trail compliance under 21 CFR Part 11 and change tracking in the Silver layer.',
    `meal_cost_usd` DECIMAL(18,2) COMMENT 'Actual cost in US dollars of the meal or refreshment provided during the call. Used for PhRMA Code per-person meal cap compliance monitoring and Sunshine Act reporting.',
    `meal_provided_flag` BOOLEAN COMMENT 'Indicates whether a meal or refreshment was provided to the HCP or HCO staff during this call. Required for PhRMA Code compliance and Sunshine Act transfer-of-value reporting.',
    `next_best_action` STRING COMMENT 'Recommended follow-up action for the sales representative as determined by the CRM system or rep input (e.g., schedule follow-up call, send clinical reprint, invite to speaker program). Supports field force coaching and CRM-driven engagement planning.',
    `off_label_discussion_flag` BOOLEAN COMMENT 'Indicates whether any off-label (unapproved indication) discussion occurred during the call. Classified as confidential due to regulatory sensitivity. Triggers compliance review workflow when True.',
    `phrma_code_compliant_flag` BOOLEAN COMMENT 'Indicates whether the call activity was conducted in full compliance with the PhRMA Code on Interactions with Healthcare Professionals. Used for internal compliance monitoring and audit reporting.',
    `promo_material_version` STRING COMMENT 'Version identifier of the promotional material presented during the call, as tracked in Veeva PromoMats. Ensures only current, approved versions are used in the field.',
    `sample_lot_number` STRING COMMENT 'Manufacturing lot number of the drug samples distributed during the call. Required for PDMA sample accountability and product recall traceability.',
    `sample_quantity` STRING COMMENT 'Total number of drug sample units distributed to the HCP during this call. Used for PDMA sample accountability reconciliation and Sunshine Act transfer-of-value reporting.',
    `samples_dropped_flag` BOOLEAN COMMENT 'Indicates whether drug samples were distributed to the HCP during this call. Drives sample accountability reporting and Prescription Drug Marketing Act (PDMA) compliance.',
    `signature_captured_flag` BOOLEAN COMMENT 'Indicates whether the HCPs electronic signature was captured during this call, as required for sample distribution under PDMA. A value of True confirms regulatory signature compliance.',
    `speaker_program_flag` BOOLEAN COMMENT 'Indicates whether this call activity is associated with or resulted from a speaker program event. Links commercial call data to speaker program compliance and Sunshine Act reporting.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales representative locked and submitted the call record in Veeva CRM, transitioning it from draft to submitted status. Key lifecycle event for field force compliance monitoring.',
    `sunshine_act_reportable_flag` BOOLEAN COMMENT 'Indicates whether this call activity constitutes a reportable transfer of value under the Physician Payments Sunshine Act (Open Payments). Drives inclusion in the annual CMS Open Payments submission.',
    `transfer_of_value_usd` DECIMAL(18,2) COMMENT 'Monetary value in US dollars of any transfer of value (e.g., meals, samples, educational materials) provided to the HCP during this call, as required for Sunshine Act Open Payments reporting.',
    `veeva_call_code` STRING COMMENT 'Source system identifier for the call record as assigned by Veeva CRM. Used for lineage tracing and deduplication against the operational system of record.',
    CONSTRAINT pk_call_activity PRIMARY KEY(`call_activity_id`)
) COMMENT 'Transactional record of each field force interaction (detail call) with an HCP or HCO, sourced from Veeva CRM. Captures call date, call type (face-to-face, remote, phone), HCP/HCO visited, products detailed, samples dropped, promotional materials presented, call outcome, next best action, signature captured flag, off-label discussion flag, and PhRMA code compliance status. Core to field force effectiveness measurement and Sunshine Act reporting.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` (
    `sample_management_id` BIGINT COMMENT 'Primary key for sample_management',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: PDMA and FDA require sample lot traceability to the manufactured batch. Sample management already stores lot_number as a denormalized text field; replacing with batch_record_id enables proper GMP lot ',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: sample_management tracks sample inventory and disbursement transactions which are always brand-specific in pharma commercial operations. While drug_product_id and medicinal_product_id exist, brand_id ',
    `call_activity_id` BIGINT COMMENT 'Identifier of the sales call activity (HCP visit) in Veeva CRM during which this sample was disbursed. Links sample transactions to call reporting for promotional compliance and field force effectiveness analytics.',
    `consent_record_id` BIGINT COMMENT 'Foreign key linking to hcp.consent_record. Business justification: PDMA compliance mandates that sample disbursements are linked to a valid HCP consent record. Pharma sample reconciliation audits verify consent was obtained before dispensing. sample_management has pd',
    `drug_product_id` BIGINT COMMENT 'Identifier of the pharmaceutical product (drug product / finished dosage form) associated with this sample inventory position. Links to the product master.',
    `formulary_position_id` BIGINT COMMENT 'Foreign key linking to market.formulary_position. Business justification: Sample distribution strategies consider formulary position to prioritize sampling where access is favorable. Targeting and resource allocation process links sample transactions to formulary status for',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Sample inventory costs and disbursements are tracked against internal orders in pharma finance. The PDMA sample compliance reporting, sample cost management, and brand promotional spend reporting proc',
    `license_id` BIGINT COMMENT 'Foreign key linking to hcp.license. Business justification: DEA and state regulations require verifying HCP license validity before dispensing samples. sample_management stores hcp_license_number as a denormalized string; linking to hcp.license.license_id enab',
    `master_id` BIGINT COMMENT 'Identifier of the Healthcare Professional (HCP) who received the sample disbursement. Required for PDMA compliance and Sunshine Act Open Payments reporting. Null for non-disbursement transactions.',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Sample inventory tracks material master records for lot traceability, expiry management, PDMA compliance, and reconciliation with manufacturing batch records. Required for sample accountability audits',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Sample inventory is managed at medicinal product level. Sample accountability, PDMA compliance, and sample utilization analysis require product linkage. Real business process: sample reconciliation an',
    `sales_rep_id` BIGINT COMMENT 'Identifier of the sales representative who holds or is responsible for this sample inventory position. Links to the sales rep master record in Veeva CRM / Salesforce Health Cloud.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Sample management tracks specific SKUs (lot number, NDC, strength, package size are all SKU-level attributes). FK to sku supports PDMA compliance, sample reconciliation, DEA reporting, and sunshine ac',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.storage_location. Business justification: Samples must be stored in GDP-qualified locations. Required for temperature excursion investigations, sample accountability audits, PDMA compliance, and regulatory inspection readiness for sample stor',
    `territory_id` BIGINT COMMENT 'Identifier of the sales territory to which this sample inventory position is assigned. Used for territory-level sample accountability and reconciliation reporting.',
    `adjustment_reason` STRING COMMENT 'Reason code for a sample inventory adjustment. Required for PDMA compliance when quantity_adjusted is non-zero. [ENUM-REF-CANDIDATE: expired|damaged|lost|stolen|count_correction|returned_to_warehouse|destroyed — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sample inventory record was first created in the system. Used for audit trail, data lineage, and 21 CFR Part 11 electronic records compliance.',
    `discrepancy_quantity` STRING COMMENT 'Net difference between the physical count and the system-recorded quantity on hand during reconciliation. Non-zero values trigger a PDMA compliance investigation. Positive = overage; Negative = shortage.',
    `expiration_date` DATE COMMENT 'Expiration date of the sample lot as printed on the package. Samples past this date must not be disbursed and must be removed from inventory per cGMP and PDMA requirements.',
    `hcp_dea_number` STRING COMMENT 'DEA registration number of the HCP, required when distributing controlled substance samples. Validates prescribing authority for scheduled drug samples per DEA regulations.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `hcp_signature_captured` BOOLEAN COMMENT 'Indicates whether the HCPs electronic signature was captured at the time of sample disbursement, as required by PDMA. True = signature obtained; False = signature not obtained (requires justification).',
    `hcp_signature_timestamp` TIMESTAMP COMMENT 'Date and time when the HCPs electronic signature was captured for the sample disbursement. Required for 21 CFR Part 11 electronic records compliance and PDMA audit trail.',
    `inventory_number` STRING COMMENT 'Externally-known business identifier for this sample inventory position record. Used for PDMA audit trails, reconciliation reports, and regulatory submissions. Generated by the sample management system (Veeva CRM or SAP MM).. Valid values are `^SINV-[0-9]{8,12}$`',
    `inventory_status` STRING COMMENT 'Current lifecycle state of the sample inventory position. Active = open and in use; Reconciled = periodic reconciliation completed; Closed = inventory position closed; Suspended = temporarily frozen pending investigation; Pending Review = flagged for compliance review.. Valid values are `active|reconciled|closed|suspended|pending_review`',
    `ndc_code` STRING COMMENT 'FDA-assigned National Drug Code uniquely identifying the drug product, dosage form, and package size of the sample. Required for PDMA compliance reporting and lot-level traceability.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    `package_size` STRING COMMENT 'Number of units (tablets, capsules, vials, etc.) contained in each sample package. Used to calculate total units disbursed and for PDMA annual accountability reporting.',
    `pdma_compliant` BOOLEAN COMMENT 'Indicates whether this sample transaction meets all PDMA compliance requirements (HCP signature captured, valid license verified, request form on file, quantity within limits). True = compliant; False = non-compliant, requires remediation.',
    `quantity_adjusted` STRING COMMENT 'Net quantity adjustment applied to the inventory position (positive = increase, negative = decrease). Used for inventory corrections, expired sample write-offs, and reconciliation discrepancy resolution.',
    `quantity_disbursed` STRING COMMENT 'Number of sample units disbursed to a Healthcare Professional (HCP) in this transaction. Zero for non-disbursement transaction types. Used for PDMA annual sample accountability and Sunshine Act reporting.',
    `quantity_on_hand` STRING COMMENT 'Current physical inventory count of sample units held by the sales representative for this product/lot combination at the time of this record. Used for reconciliation and PDMA compliance.',
    `quantity_received` STRING COMMENT 'Number of sample units received by the sales representative from the warehouse, CMO, or another rep in this transaction. Zero for non-receipt transaction types.',
    `reconciliation_period` STRING COMMENT 'The fiscal quarter (e.g., 2024-Q1) to which this inventory reconciliation record belongs. PDMA requires periodic reconciliation of sample inventories. Used for compliance reporting and audit.. Valid values are `^[0-9]{4}-Q[1-4]$`',
    `reconciliation_status` STRING COMMENT 'Current status of the PDMA sample reconciliation process for this inventory position and period. Discrepancy Identified = physical count does not match system records; Resolved = discrepancy investigated and closed.. Valid values are `pending|in_progress|completed|discrepancy_identified|resolved`',
    `sample_form_type` STRING COMMENT 'Finished dosage form (FDF) type of the sample product (e.g., tablet, capsule, injectable). Used for inventory categorization, storage planning, and regulatory reporting. [ENUM-REF-CANDIDATE: tablet|capsule|injectable|topical|inhaler|liquid|patch|other — promote to reference product]',
    `sample_request_form_number` STRING COMMENT 'Reference number of the HCPs written or electronic sample request form (SRF) associated with this disbursement. PDMA requires a signed request for each sample disbursement. Links to the eTMF or Veeva Vault document.',
    `source_system` STRING COMMENT 'Operational system of record from which this sample inventory record originated. Supports data lineage tracking and reconciliation between Veeva CRM, SAP MM, and Salesforce Health Cloud in the Silver layer.. Valid values are `veeva_crm|sap_mm|salesforce_health_cloud|manual_entry`',
    `storage_condition` STRING COMMENT 'Required storage condition for the sample as specified in the product labeling and CoA. Used to ensure samples are stored appropriately by the sales rep and to flag potential quality deviations.. Valid values are `room_temperature|refrigerated|frozen|controlled_room_temperature|protect_from_light`',
    `strength` STRING COMMENT 'Dosage strength of the sample product (e.g., 10 mg, 500 mg/5 mL). Distinguishes between different strength variants of the same product for inventory tracking and PDMA reporting.',
    `sunshine_act_reportable` BOOLEAN COMMENT 'Indicates whether this sample disbursement transaction must be reported under the Physician Payments Sunshine Act (Open Payments Program) to CMS. True = reportable transfer of value to HCP.',
    `therapeutic_area` STRING COMMENT 'Therapeutic area classification of the sample product (e.g., Oncology, Immunology, Rare Diseases). Used for brand performance tracking, sample budget allocation, and commercial analytics.',
    `transaction_date` DATE COMMENT 'The real-world business date on which the sample transaction (disbursement, receipt, transfer, etc.) occurred. Used as the principal event date for PDMA reporting and Sunshine Act transparency reporting.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Precise date and time when the sample transaction was recorded in the system (Veeva CRM or SAP). Provides sub-day precision for audit trail and compliance investigations.',
    `transaction_type` STRING COMMENT 'Classification of the sample movement or inventory event. Disbursement = sample given to HCP; Receipt = samples received by rep; Transfer = rep-to-rep or warehouse transfer; Adjustment = inventory correction; Reconciliation = periodic count reconciliation; Return = samples returned to warehouse; Destruction = samples destroyed per policy. [ENUM-REF-CANDIDATE: disbursement|receipt|transfer|adjustment|reconciliation|return|destruction — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this sample inventory record was last modified. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks Silver layer.',
    CONSTRAINT pk_sample_management PRIMARY KEY(`sample_management_id`)
) COMMENT 'Unified sample management product tracking sample inventory positions, all transaction movements (disbursements, receipts, transfers, adjustments, reconciliations), and PDMA compliance for each sales representative';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` (
    `promo_material_id` BIGINT COMMENT 'Unique system-generated identifier for each promotional material record in the master catalog. Primary key for the promo_material data product.',
    `brand_id` BIGINT COMMENT 'FK to commercial.brand',
    `brand_plan_id` BIGINT COMMENT 'Foreign key linking to commercial.brand_plan. Business justification: promo_material is created in support of the brand_plans promotional_mix_strategy and channel_strategy. In pharma commercial operations, promotional materials are developed and approved within the con',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Promotional materials detail specific drug products with exact strength and dosage form. MLR review for fair balance, indication-specific claims, and field usage tracking require drug product linkage.',
    `indication_id` BIGINT COMMENT 'Foreign key linking to product.indication. Business justification: FDA requires promotional materials to be indication-specific with accurate fair balance. promo_material.indication is plain text. FK to indication supports MLR review compliance, ensures materials ali',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Promotional material production costs (agency fees, printing, digital) are tracked against internal orders in pharma brand finance. The promotional spend tracking, MLR cost management, and brand budge',
    `labeling_id` BIGINT COMMENT 'Foreign key linking to product.labeling. Business justification: FDA requires promotional materials to be consistent with the current approved product labeling. FK to labeling supports MLR review (reviewers verify claims against the approved label), regulatory subm',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Promotional materials are approved and owned by specific legal entities. Required for MLR jurisdiction determination, copyright ownership, regulatory submission attribution, and Sunshine Act reporting',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: For co-promoted or in-licensed products, promotional materials must comply with licensing agreement terms governing promotional rights, co-promotion obligations, and approved claims. Legal reviewers i',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Promotional materials require country-specific MLR regulatory approval; distribution is jurisdiction-controlled. market is a denormalized country name. A regulatory affairs expert expects a structured',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Promotional materials must reference patent status for compliance; MLR review requires patent information for fair balance and regulatory accuracy in promotional claims.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Promotional materials are organized by TA for MLR review routing, vault management, and regulatory compliance reporting. promo_material.therapeutic_area is plain text. FK supports TA-level promotional',
    `trademark_id` BIGINT COMMENT 'Foreign key linking to intellectual.trademark. Business justification: Promotional materials must display registered trademarks correctly with proper ® or ™ symbols — a core legal compliance requirement in pharma MLR review. Legal teams verify trademark registration stat',
    `trial_id` BIGINT COMMENT 'Foreign key linking to clinical.trial. Business justification: Promotional materials (detail aids, journal ads) reference specific clinical trial results to substantiate label claims. FDA requires promotional materials to be consistent with approved labeling deri',
    `aggregate_decision` STRING COMMENT 'Overall consolidated MLR committee decision for the current review cycle, reflecting the combined outcome of medical, legal, and regulatory reviewer decisions. Drives the approval_status field transition.. Valid values are `approved|approved_with_changes|rejected|pending`',
    `approval_date` DATE COMMENT 'Date on which the promotional material received final aggregate MLR approval and was authorized for use in field force detailing and commercial distribution.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the promotional material within the Medical-Legal-Regulatory (MLR) approval workflow. Only materials in approved status with a valid expiry date may be used in field force detailing per internal PhRMA code compliance policy. [ENUM-REF-CANDIDATE: draft|in_mlr_review|approved|approved_with_changes|rejected|withdrawn|expired|archived — 8 candidates stripped; promote to reference product]',
    `content_owner` STRING COMMENT 'Name or employee identifier of the brand team member or marketing manager who owns and is accountable for the promotional material content, including initiating the MLR submission and managing the approval lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotional material record was first created in the Veeva PromoMats system. Supports audit trail requirements under 21 CFR Part 11 electronic records compliance.',
    `distribution_channel` STRING COMMENT 'Primary channel through which the promotional material is distributed to the target audience. Determines field force eligibility, digital deployment rules, and PhRMA code compliance requirements. [ENUM-REF-CANDIDATE: field_force|digital|congress|patient|journal|managed_care|speaker_program — 7 candidates stripped; promote to reference product]',
    `expiry_date` DATE COMMENT 'Date on which the MLR approval for this promotional material expires. Materials must be withdrawn from field use on or before this date. Renewal requires a new MLR submission cycle.',
    `fair_balance_included` BOOLEAN COMMENT 'Indicates whether the promotional material includes the required fair balance statement (risk information) as mandated by FDA 21 CFR Part 202.1 for prescription drug advertising. Must be True for all HCP-directed materials.',
    `isi_included` BOOLEAN COMMENT 'Indicates whether the Important Safety Information (ISI) section is included in the promotional material, as required for HCP-directed promotional pieces under FDA promotional regulations.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 region subtag) indicating the language of the promotional material content (e.g., en-US, fr-FR, de-DE). Required for multi-market localization tracking.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the promotional material record in the source system. Supports change tracking and audit trail requirements under 21 CFR Part 11.',
    `last_resubmission_date` DATE COMMENT 'Date of the most recent resubmission of this promotional material to the MLR committee after a prior rejection or change request. Null if the material has never been resubmitted.',
    `legal_decision` STRING COMMENT 'Individual decision rendered by the Legal reviewer for the current MLR review cycle. All three reviewer decisions must be approved for aggregate approval.. Valid values are `approved|approved_with_changes|rejected|pending`',
    `legal_reviewer` STRING COMMENT 'Name or employee identifier of the assigned Legal reviewer responsible for evaluating legal risk, intellectual property, and fair balance claims in the promotional material during the MLR review.',
    `material_number` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the promotional material across commercial operations, field force systems, and print/digital distribution. Used on physical materials and in Veeva CRM detailing records.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `material_type` STRING COMMENT 'Classification of the promotional material by format and intended use. Drives distribution channel eligibility and MLR review routing. [ENUM-REF-CANDIDATE: detail_aid|leave_behind|patient_brochure|digital_asset|journal_ad|video|banner_ad|email_template|sales_aid|speaker_slide_deck|website_content|social_media_post — promote to reference product]',
    `medical_decision` STRING COMMENT 'Individual decision rendered by the Medical Affairs reviewer for the current MLR review cycle. All three reviewer decisions (medical, legal, regulatory) must be approved for aggregate approval.. Valid values are `approved|approved_with_changes|rejected|pending`',
    `medical_reviewer` STRING COMMENT 'Name or employee identifier of the assigned Medical Affairs reviewer responsible for evaluating scientific accuracy and clinical claims in the promotional material during the MLR review.',
    `mlr_submission_date` DATE COMMENT 'Date on which the promotional material was formally submitted to the MLR review committee for the current review cycle. Triggers the review SLA clock.',
    `pi_reference_included` BOOLEAN COMMENT 'Indicates whether a reference to the full Prescribing Information (PI) or a brief summary thereof is included in the promotional material, as required by FDA 21 CFR Part 202.1(e).',
    `regulatory_decision` STRING COMMENT 'Individual decision rendered by the Regulatory Affairs reviewer for the current MLR review cycle. All three reviewer decisions must be approved for aggregate approval.. Valid values are `approved|approved_with_changes|rejected|pending`',
    `regulatory_reviewer` STRING COMMENT 'Name or employee identifier of the assigned Regulatory Affairs reviewer responsible for evaluating compliance with FDA labeling, 21 CFR Part 202, and applicable EMA/MHRA promotional guidelines during the MLR review.',
    `resubmission_count` STRING COMMENT 'Total number of times this promotional material has been resubmitted to the MLR committee following a rejection or request for changes. Tracks review efficiency and content quality metrics.',
    `review_comments` STRING COMMENT 'Consolidated reviewer comments and required changes from the current MLR review cycle. Captured from Veeva PromoMats annotations and used to guide content revisions prior to resubmission.',
    `review_cycle_number` STRING COMMENT 'Sequential integer indicating which review cycle this version of the material is in. Increments with each resubmission following a rejection or request for changes. Cycle 1 is the initial submission.',
    `sample_piece` BOOLEAN COMMENT 'Indicates whether this material is a sample or specimen piece used for internal review, training, or regulatory submission purposes, as opposed to a commercially distributed piece.',
    `sunshine_act_reportable` BOOLEAN COMMENT 'Indicates whether distribution of this promotional material to HCPs constitutes a reportable transfer of value under the Physician Payments Sunshine Act (Open Payments Program), requiring CMS reporting.',
    `target_audience` STRING COMMENT 'Intended recipient audience for the promotional material. Drives compliance review requirements — HCP-directed materials require full MLR review; patient materials require additional plain-language review.. Valid values are `hcp|patient|payer|internal|kol|pharmacist`',
    `title` STRING COMMENT 'Official human-readable title of the promotional material as registered in the MLR approval workflow and displayed in the Veeva PromoMats catalog.',
    `vault_document_code` STRING COMMENT 'The native document identifier assigned by Veeva Vault PromoMats, used to cross-reference the record in the source system of record.',
    `version_lineage` STRING COMMENT 'Pipe-delimited or comma-separated list of predecessor material numbers and version identifiers representing the full version history chain for this material. Supports audit trail and content genealogy tracking in Veeva PromoMats.',
    `version_number` STRING COMMENT 'Version identifier of the promotional material (e.g., 1.0, 2.1) tracking content revisions through the MLR lifecycle. Incremented on each resubmission or approved change.. Valid values are `^d+.d+$`',
    `withdrawal_date` DATE COMMENT 'Date on which the promotional material was formally withdrawn from commercial use, either due to expiry, safety update, label change, or voluntary withdrawal. Null if the material has not been withdrawn.',
    `withdrawal_reason` STRING COMMENT 'Reason code explaining why the promotional material was withdrawn from commercial use. Required for regulatory audit trail and field force recall notifications.. Valid values are `label_update|safety_update|voluntary_withdrawal|expired|superseded|regulatory_request`',
    CONSTRAINT pk_promo_material PRIMARY KEY(`promo_material_id`)
) COMMENT 'Master catalog, content lifecycle, and MLR approval workflow for all promotional materials managed in Veeva PromoMats. Captures material ID, title, material type (detail aid, leave-behind, patient brochure, digital asset, journal ad, video), brand, indication, distribution channel, and current approval status. Includes full Medical-Legal-Regulatory (MLR) review workflow tracking: submission date, review cycle number, reviewer assignments (medical, legal, regulatory), individual reviewer decisions, review comments, aggregate approval decision, approval date, expiry date, resubmission history, and version lineage. Ensures compliance with FDA promotional regulations (21 CFR Part 202) and internal PhRMA code. Only MLR-approved materials with valid expiry dates may be used in field force detailing.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` (
    `mlr_review_id` BIGINT COMMENT 'Unique system-generated identifier for each MLR review record. Primary key for the mlr_review data product.',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand or product associated with the promotional material under review. Supports brand-level compliance tracking and P&L reporting.',
    `brand_plan_id` BIGINT COMMENT 'Foreign key linking to commercial.brand_plan. Business justification: mlr_review tracks the Medical-Legal-Regulatory approval workflow for promotional materials. MLR reviews are initiated for materials created under a specific brand plan cycle. Linking mlr_review to bra',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.quality_change_control. Business justification: MLR reviews must be re-initiated when a change control modifies product labeling, approved claims, or promotional content. Regulatory requirement: labeling changes trigger mandatory MLR re-review. Pha',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: MLR reviews are jurisdiction-specific; regulatory authority, approval requirements, and expiry rules vary by country. country_code is a denormalized country reference. A regulatory/medical affairs exp',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Promotional materials detail specific drug products for fair balance verification. MLR review requires drug product linkage for indication-specific claim approval. Real business process: fair balance ',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: MLR review processes may be tracked via internal orders for cost allocation of medical/legal/regulatory reviewer time and promotional material development costs.',
    `labeling_id` BIGINT COMMENT 'Foreign key linking to product.labeling. Business justification: MLR reviews validate promotional materials against the current approved product labeling. FK to labeling enables reviewers to reference the exact label version in force at review time, supporting regu',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: MLR reviews are conducted under specific legal entitys regulatory authority and approval jurisdiction. Required for approval authority determination, regulatory submission attribution, and compliance',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: MLR reviews approve promotional materials for specific medicinal products. Review tracking, approval workflows, and promotional compliance require product linkage. Real business process: MLR review wo',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: MLR (Medical-Legal-Regulatory) review must verify promotional content does not make claims beyond patent scope or coverage. IP counsel participates in MLR to confirm patent-supported claims. A pharma ',
    `prior_submission_mlr_review_id` BIGINT COMMENT 'Reference to the previous MLR review record for the same promotional material, enabling resubmission history tracking and cycle lineage. Null for initial submissions (review_cycle_number = 1).',
    `promo_material_id` BIGINT COMMENT 'Reference to the promotional material or communication asset undergoing MLR review. Links to the material record in Veeva Vault PromoMats.',
    `trademark_id` BIGINT COMMENT 'Foreign key linking to intellectual.trademark. Business justification: MLR review verifies correct trademark usage in promotional materials — a core legal compliance requirement. Legal reviewers must confirm the brand trademark is registered and properly displayed. Pharm',
    `trial_id` BIGINT COMMENT 'Foreign key linking to clinical.trial. Business justification: MLR (Medical-Legal-Regulatory) review of promotional materials requires tracing every efficacy/safety claim to the supporting clinical trial. FDA OPDP and EMA require substantiation of promotional cla',
    `approval_date` DATE COMMENT 'Date on which the final MLR approval decision was rendered and the promotional material was formally approved for use. Null if not yet approved.',
    `approval_decision` STRING COMMENT 'Final consolidated approval decision rendered by the MLR committee upon completion of all three review streams (medical, legal, regulatory). Null until the review is concluded.. Valid values are `approved|approved_with_changes|rejected|withdrawn`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the MLR review record was first created in the system. Used for audit trail and data lineage purposes.',
    `distribution_channel` STRING COMMENT 'The intended distribution channel through which the approved promotional material will be disseminated to the target audience. Informs channel-specific compliance requirements.. Valid values are `print|digital|rep_delivered|congress|direct_mail|email_broadcast`',
    `expiry_date` DATE COMMENT 'Date on which the MLR approval expires and the promotional material must be retired or resubmitted for re-review. Supports proactive compliance management and material lifecycle governance.',
    `fair_balance_verified` BOOLEAN COMMENT 'Indicates whether the promotional material includes adequate fair balance presentation of risks and benefits as required by FDA regulations for prescription drug advertising.',
    `legal_review_date` DATE COMMENT 'Date on which the legal reviewer completed their review and rendered a decision for this review cycle.',
    `legal_review_status` STRING COMMENT 'Current decision status from the legal reviewer for this review cycle. Tracks the legal component of the MLR tripartite review process.. Valid values are `pending|in_review|approved|approved_with_changes|rejected`',
    `medical_review_date` DATE COMMENT 'Date on which the medical affairs reviewer completed their review and rendered a decision for this review cycle.',
    `medical_review_status` STRING COMMENT 'Current decision status from the medical affairs reviewer for this review cycle. Tracks the medical component of the MLR tripartite review process.. Valid values are `pending|in_review|approved|approved_with_changes|rejected`',
    `phrama_code_compliant` BOOLEAN COMMENT 'Indicates whether the promotional material has been assessed and confirmed as compliant with the PhRMA Code on Interactions with Healthcare Professionals. Set to True upon successful regulatory review.',
    `regulatory_authority` STRING COMMENT 'The regulatory authority whose promotional guidelines govern this MLR review, determined by the target market. Drives applicable review standards and compliance requirements.. Valid values are `FDA|EMA|MHRA|PMDA|NMPA|WHO`',
    `regulatory_review_date` DATE COMMENT 'Date on which the regulatory affairs reviewer completed their review and rendered a decision for this review cycle.',
    `regulatory_review_status` STRING COMMENT 'Current decision status from the regulatory affairs reviewer for this review cycle. Tracks the regulatory component of the MLR tripartite review process.. Valid values are `pending|in_review|approved|approved_with_changes|rejected`',
    `rejection_reason` STRING COMMENT 'Documented rationale for rejection of the promotional material during the MLR review cycle. Populated when approval_decision is rejected. Required for resubmission guidance and compliance audit.',
    `resubmission_deadline` DATE COMMENT 'Date by which a revised version of the rejected promotional material must be resubmitted for the next review cycle. Populated when approval_decision is rejected or approved_with_changes.',
    `review_comments` STRING COMMENT 'Consolidated reviewer comments, change requests, and annotations captured during the MLR review cycle. Includes feedback from medical, legal, and regulatory reviewers requiring action by the submitter.',
    `review_cycle_number` STRING COMMENT 'Sequential integer indicating which review cycle this record represents for the associated promotional material. A value of 1 indicates the initial submission; values greater than 1 indicate resubmission cycles following prior rejection or revision.',
    `review_due_date` DATE COMMENT 'Target date by which the MLR review must be completed, based on internal SLA commitments and commercial launch timelines. Used for workflow prioritization and escalation management.',
    `review_status` STRING COMMENT 'Current lifecycle state of the MLR review workflow. Tracks progression from initial submission through final approval or rejection decision. [ENUM-REF-CANDIDATE: draft|submitted|in_review|approved|rejected|withdrawn|expired — promote to reference product]',
    `submission_date` DATE COMMENT 'The date on which the promotional material was formally submitted to the MLR review committee for evaluation. Represents the principal business event timestamp for the review lifecycle.',
    `submission_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned to the MLR review submission, used for cross-functional tracking and audit trail purposes within Veeva Vault PromoMats.. Valid values are `^MLR-[0-9]{4}-[0-9]{6}$`',
    `sunshine_act_applicable` BOOLEAN COMMENT 'Indicates whether the promotional activity associated with this material is subject to Open Payments (Sunshine Act) reporting requirements under 42 CFR Part 403.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the MLR review record. Supports audit trail requirements and change tracking under 21 CFR Part 11.',
    `veeva_vault_doc_code` STRING COMMENT 'The document identifier assigned by Veeva Vault PromoMats to the promotional material record. Used for cross-system traceability between the lakehouse silver layer and the source system of record.',
    CONSTRAINT pk_mlr_review PRIMARY KEY(`mlr_review_id`)
) COMMENT 'Tracks the Medical-Legal-Regulatory (MLR) review and approval workflow for promotional materials and communications. Captures submission date, review cycle number, reviewer roles (medical, legal, regulatory), review status, comments, approval decision, approval date, expiry date, and resubmission history. Ensures compliance with FDA promotional regulations (21 CFR Part 202) and internal PhRMA code adherence.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` (
    `brand_plan_id` BIGINT COMMENT 'Unique identifier for the brand plan. Primary key for the brand plan entity.',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand (Drug Product or DP) that this plan covers. Links to the master brand/product entity.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Brand plans explicitly reference multiple budget categories. Links strategic plan to financial budget for execution tracking, variance analysis, and forecast accuracy.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Brand plans are developed per country/geography for market access strategy, launch planning, and commercial investment decisions. geography is a denormalized country reference. A brand management expe',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Brand plans are built around regulatory exclusivity periods; commercial strategy, revenue forecasting, and market access planning depend on exclusivity protection timelines.',
    `indication_id` BIGINT COMMENT 'Foreign key linking to product.indication. Business justification: Brand plans are written per indication (e.g., NSCLC first-line vs. second-line). brand_plan.indication is plain text. FK to indication supports indication-level revenue targets, regulatory approval de',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Brand plans execute through internal orders for campaigns, congress participation, market research. Links strategic plan to financial execution and cost tracking.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Brand plans are executed by specific legal entities with market authorization. Required for regulatory strategy alignment, market authorization ownership, financial consolidation, and intercompany tra',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Brand plans for in-licensed products must reference the licensing agreement governing commercialization rights, territory restrictions, and royalty obligations. Commercial teams need this link to ensu',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Brand plans have budget allocations to specific cost centers. Required for financial planning, budget vs. actual tracking, promotional spend allocation, and commercial operations P&L by cost center.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: Brand plans drive profit center performance and revenue targets. Required for segment reporting, brand P&L, strategic portfolio management, and financial consolidation by therapeutic area or product l',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Brand plans are strategic documents for specific medicinal products. Plan execution tracking, milestone monitoring, and performance measurement against plan require direct product linkage. Real busine',
    `molecular_target_id` BIGINT COMMENT 'Foreign key linking to discovery.molecular_target. Business justification: Brand plans are built around a specific molecular target for MOA-based competitive positioning, market analysis, and indication strategy. Medical Affairs and commercial teams segment brand plans by ta',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent_family. Business justification: Brand planning requires portfolio-level patent family analysis for multi-jurisdictional LOE planning and lifecycle management strategy. Brand teams use patent family data to model revenue cliffs acros',
    `pricing_decision_id` BIGINT COMMENT 'Foreign key linking to market.pricing_decision. Business justification: Brand plans explicitly incorporate approved pricing decisions as a foundational input — launch price, gross-to-net targets, and revenue forecasts are all anchored to the pricing decision. A brand plan',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to market.reimbursement_policy. Business justification: Brand plans are built around reimbursement policy outcomes — channel strategy, patient support design, and promotional mix are directly shaped by the reimbursement policy in each market. Market access',
    `royalty_agreement_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_agreement. Business justification: Brand plans incorporate royalty obligations into financial forecasts and P&L projections. The brand financial planning, royalty accrual forecasting, and licensing cost management process requires link',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Brand plans are structured by therapeutic area for TA-level budgeting, strategic planning, and portfolio investment decisions. brand_plan.therapeutic_area is plain text. FK supports TA-level brand pla',
    `trademark_id` BIGINT COMMENT 'Foreign key linking to intellectual.trademark. Business justification: Brand plans govern brand identity strategy including trademark usage and protection. Brand planning teams must reference the registered trademark to ensure launch plans align with trademark registrati',
    `transfer_price_id` BIGINT COMMENT 'Foreign key linking to finance.transfer_price. Business justification: Brand plans incorporate intercompany transfer pricing assumptions for cross-border product P&L. The brand financial planning and intercompany reconciliation process requires the applicable transfer pr',
    `value_dossier_id` BIGINT COMMENT 'Foreign key linking to market.value_dossier. Business justification: Brand plans in pharma are directly supported by value dossiers — the HEOR evidence package underpinning payer negotiations and market access strategy. A market access expert would expect brand_plan to',
    `approval_date` DATE COMMENT 'The date when the brand plan was formally approved by senior management or the commercial leadership team, authorizing execution and budget release.',
    `brand_positioning` STRING COMMENT 'The core brand positioning statement that defines how the brand is differentiated in the market and the value proposition communicated to Healthcare Professionals (HCPs) and patients.',
    `budget_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for all financial amounts in this brand plan (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `channel_strategy` STRING COMMENT 'The multi-channel engagement strategy defining how the brand will reach HCPs and patients through field force, digital channels, medical science liaisons, patient support programs, and market access initiatives.',
    `competitive_landscape` STRING COMMENT 'Summary of the competitive environment, including key competitor brands, market share dynamics, and competitive threats or opportunities identified for the planning period.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand plan record was first created in the system. Audit trail field for data lineage and compliance.',
    `last_review_date` DATE COMMENT 'The date when the brand plan was last reviewed or updated. Brand plans are typically reviewed quarterly or semi-annually to assess progress and adjust tactics.',
    `launch_phase` STRING COMMENT 'The current phase of the product launch lifecycle covered by this brand plan: pre-launch (preparation before regulatory approval), launch (initial market introduction), post-launch (ongoing commercialization), or not applicable (for established brands).. Valid values are `pre_launch|launch|post_launch|not_applicable`',
    `market_share_target` DECIMAL(18,2) COMMENT 'The target market share percentage (by volume or value) that the brand aims to achieve in its therapeutic category during the plan period. Expressed as a percentage (e.g., 25.50 for 25.5%).',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand plan record was last modified or updated. Audit trail field for change tracking and data lineage.',
    `plan_code` STRING COMMENT 'Unique business identifier or code for the brand plan used in financial and commercial systems (e.g., BP-2024-ONCX-US).',
    `plan_end_date` DATE COMMENT 'The date when the brand plan period concludes. For annual plans, typically one year from start date. May be extended for multi-year plans.',
    `plan_name` STRING COMMENT 'The official name or title of the brand plan, typically including brand name, year, and geography (e.g., Oncology Brand X US Commercial Plan 2024).',
    `plan_start_date` DATE COMMENT 'The date when the brand plan becomes effective and execution begins. Typically aligns with fiscal year start or product launch date.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the brand plan: draft (in development), submitted (under review), approved (finalized and authorized), active (currently executing), on hold (temporarily suspended), or closed (completed or archived).. Valid values are `draft|submitted|approved|active|on_hold|closed`',
    `plan_type` STRING COMMENT 'Classification of the brand plan by its strategic purpose: annual (standard yearly plan), multi-year (strategic multi-year roadmap), launch (new product launch plan), lifecycle management (mature product optimization), indication expansion (new therapeutic indication), or line extension (new formulation/strength).. Valid values are `annual|multi_year|launch|lifecycle_management|indication_expansion|line_extension`',
    `plan_year` STRING COMMENT 'The fiscal or calendar year for which this brand plan is effective (e.g., 2024). For multi-year plans, this represents the start year.',
    `prescription_volume_target` BIGINT COMMENT 'The target number of prescriptions (Total Prescriptions or TRx) or New-to-Brand (NTB) prescriptions the brand aims to generate during the plan period. Sourced from prescription data providers (e.g., IQVIA).',
    `promotional_mix_strategy` STRING COMMENT 'Description of the promotional mix strategy, including the balance and integration of personal promotion (field force), non-personal promotion (advertising, digital), medical education, congress participation, and speaker programs.',
    `regulatory_approval_dependency` STRING COMMENT 'Description of any regulatory approval milestones or dependencies that impact the brand plan execution, such as pending New Drug Application (NDA), Biologics License Application (BLA), or Marketing Authorization Application (MAA) approvals, or supplemental indication approvals.',
    `revenue_target` DECIMAL(18,2) COMMENT 'The target revenue or net sales goal for the brand during the plan period. Key Performance Indicator (KPI) for commercial success and P&L performance.',
    `strategic_objective` STRING COMMENT 'The overarching strategic goal or objective for the brand during this plan period (e.g., Achieve market leadership in NSCLC, Maximize peak sales before LOE, Establish brand in rare disease segment).',
    `target_hcp_segment` STRING COMMENT 'The primary Healthcare Professional (HCP) segment or specialty targeted by this brand plan (e.g., Oncologists, Rheumatologists, Primary Care Physicians). May include sub-segmentation by prescribing behavior or Key Opinion Leader (KOL) status.',
    `target_patient_population` STRING COMMENT 'Description of the target patient population for the brand, including demographic, clinical, and epidemiological characteristics (e.g., Adults with advanced NSCLC, EGFR mutation positive).',
    CONSTRAINT pk_brand_plan PRIMARY KEY(`brand_plan_id`)
) COMMENT 'Annual or multi-year commercial brand plan serving as the unified planning, budgeting, and execution tracking entity for a brands commercial strategy. Captures strategic objectives, positioning, competitive differentiation, promotional mix, channel strategy, and KPI targets. Includes detailed promotional spend tracking by tactic (personal promotion, non-personal, digital, samples, speaker programs, congress) with planned budget, actual spend, variance, cost center, and brand P&L line attribution. Also tracks launch activity milestones for new product/indication launches including activity name, launch phase (pre-launch, launch, post-launch), activity type (field force training, formulary pull-through, KOL engagement, patient support activation), planned/actual dates, owner, status, and dependencies on regulatory approval milestones. Serves as the single commercial planning, financial execution, launch management, and brand P&L entity.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` (
    `kol_engagement_id` BIGINT COMMENT 'Unique identifier for the KOL engagement record. Primary key for tracking longitudinal relationships with Key Opinion Leaders across commercial and medical affairs activities.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: KOL honoraria, advisory board fees, and speaker payments generate AP records in pharma. The HCP payment transparency reporting (Sunshine Act/EFPIA) and financial compliance process require linking KOL',
    `brand_id` BIGINT COMMENT 'Foreign key reference to the pharmaceutical brand or product associated with this KOL engagement. Links engagement activities to specific commercial products.',
    `brand_plan_id` BIGINT COMMENT 'Foreign key linking to commercial.brand_plan. Business justification: kol_engagement activities are planned and budgeted within the brand_plans KOL strategy and channel_strategy. In pharma commercial operations, KOL engagement plans (advisory boards, speaker programs, ',
    `candidate_nomination_id` BIGINT COMMENT 'Foreign key linking to discovery.candidate_nomination. Business justification: KOL advisory boards are convened around specific candidate nominations to review candidate profiles, provide input on development strategy, and support IND-enabling activities. Medical Affairs tracks ',
    `contract_id` BIGINT COMMENT 'Foreign key reference to the consulting or services contract governing this KOL engagement. Links to the legal agreement under which services are provided.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: KOL engagements are country-specific for global transparency reporting (Sunshine Act equivalents, EMA disclosure requirements). engagement_country is a denormalized country name. A medical affairs com',
    `indication_id` BIGINT COMMENT 'Foreign key linking to product.indication. Business justification: KOL engagements are topic-specific, tied to a particular indication for advisory boards, speaker programs, and publication planning. kol_engagement.indication is plain text. FK supports indication-lev',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: KOL engagements (advisory boards, consulting) are project-based activities requiring internal order for cost tracking, budget control, and transparency reporting compliance.',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: KOL honoraria and speaker fees are paid via invoices in pharma. The HCP payment transparency reporting (Sunshine Act), financial audit trail, and vendor payment process require linking KOL engagement ',
    `kol_profile_id` BIGINT COMMENT 'Foreign key linking to hcp.hcp_kol_profile. Business justification: KOL engagement activities must reference the HCPs KOL profile to align engagement strategy with tier, publication history, and MSL interaction count. Pharma medical affairs KOL mapping reports depend',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: KOL engagements create contractual and payment obligations for specific legal entities. Required for transparency reporting, tax compliance, FMV assessment by jurisdiction, and regulatory audit trails',
    `master_id` BIGINT COMMENT 'Foreign key reference to the Healthcare Professional master record who is designated as a Key Opinion Leader. Links to the HCP entity in the master data domain.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: KOL engagements focus on specific medicinal products for advisory boards and consulting. Strategic relationship management and transparency reporting require product linkage. Real business process: KO',
    `molecular_target_id` BIGINT COMMENT 'Foreign key linking to discovery.molecular_target. Business justification: KOL engagements in Medical Affairs are frequently organized by molecular target — advisory boards, scientific exchange, and publications are target-specific. A KOL expert in PD-1 or EGFR may be engage',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: KOL engagements are sponsored by a specific business unit/org_unit for budget accountability and transparency reporting. business_unit is a denormalized org_unit name. A medical affairs expert expects',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent_family. Business justification: KOL engagements on pipeline and portfolio scientific topics reference patent families for IP-sensitive discussions. Medical affairs teams track which patent families are discussed with KOLs for IP pro',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: KOL engagements discuss patented innovations; scientific exchange, advisory boards, and publication planning require patent awareness for accurate IP representation and compliance.',
    `payer_engagement_id` BIGINT COMMENT 'Foreign key linking to market.payer_engagement. Business justification: KOL engagements (advisory boards, publications) generate evidence presented in payer negotiations. Evidence generation and deployment process links KOL activities to payer meetings where insights are ',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to clinical.principal_investigator. Business justification: KOL advisory boards and consulting frequently involve trial investigators. Critical for transparency reporting (Sunshine Act/EFPIA), conflict of interest management, strategic medical affairs planning',
    `project_id` BIGINT COMMENT 'Foreign key linking to discovery.discovery_project. Business justification: KOLs are engaged during discovery phase as scientific advisors, steering committee members, or consultants on specific projects. Required for transparency reporting (Sunshine Act/EFPIA), conflict of i',
    `sales_rep_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_rep. Business justification: kol_engagement tracks engagement activities with Key Opinion Leaders managed by the commercial field force. Sales reps are the primary relationship owners for KOL engagements in pharma commercial oper',
    `territory_id` BIGINT COMMENT 'Foreign key reference to the sales or medical affairs territory associated with this KOL engagement. Links engagement to geographic coverage areas.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: KOL engagements are organized by therapeutic area for medical affairs planning and sunshine act transparency reporting. kol_engagement.therapeutic_area is plain text. FK supports TA-level KOL spend re',
    `trial_id` BIGINT COMMENT 'Foreign key linking to clinical.trial. Business justification: KOL advisory boards and speaker programs are organized around specific trial data readouts and publications. Medical affairs tracks which trials data is the basis for each engagement topic — required',
    `advisory_board_name` STRING COMMENT 'The name or identifier of the advisory board if the engagement type is advisory board participation. Used to group multiple KOL engagements under a single advisory board event.',
    `compliance_approval_date` DATE COMMENT 'The date on which compliance approval was granted for this KOL engagement. Required for audit trail and regulatory inspection readiness.',
    `compliance_approval_status` STRING COMMENT 'The approval status from the compliance and legal review process. All KOL engagements must receive compliance approval before execution per PhRMA Code and internal policies.. Valid values are `pending|approved|rejected|under_review`',
    `compliance_approver` STRING COMMENT 'Name or identifier of the compliance officer who approved this KOL engagement. Maintains accountability for compliance decisions.',
    `congress_name` STRING COMMENT 'The name of the medical congress or scientific conference associated with this engagement, if applicable. Relevant for congress presentation and advisory board engagements held at conferences.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this KOL engagement record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `engagement_date` DATE COMMENT 'The date on which the KOL engagement activity occurred. Used for tracking engagement frequency and compliance reporting timelines.',
    `engagement_duration_hours` DECIMAL(18,2) COMMENT 'The total duration of the KOL engagement activity measured in hours. Used for fair market value assessment and resource planning.',
    `engagement_location` STRING COMMENT 'The physical or virtual location where the KOL engagement took place. May include city, venue name, or virtual platform identifier.',
    `engagement_status` STRING COMMENT 'Current lifecycle status of the KOL engagement. Tracks progression from planning through completion or cancellation, including compliance approval gates.. Valid values are `planned|confirmed|completed|cancelled|pending_approval`',
    `engagement_topic` STRING COMMENT 'The specific subject matter or agenda topic discussed during the KOL engagement. Provides context for the scientific or clinical focus of the interaction.',
    `engagement_type` STRING COMMENT 'The category of engagement activity conducted with the KOL. Distinguishes between advisory boards, speaker training sessions, publication reviews, congress presentations, consulting engagements, and investigator meetings.. Valid values are `advisory_board|speaker_training|publication_review|congress_presentation|consulting|investigator_meeting`',
    `fair_market_value_assessment` STRING COMMENT 'Assessment status indicating whether the honorarium and engagement terms comply with fair market value guidelines per PhRMA Code and internal policies.. Valid values are `compliant|under_review|non_compliant|not_applicable`',
    `honorarium_amount` DECIMAL(18,2) COMMENT 'The monetary compensation paid to the KOL for their participation in this engagement activity. Subject to fair market value assessment and transparency reporting.',
    `honorarium_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the honorarium payment (e.g., USD, EUR, GBP). Required for multi-country operations and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this KOL engagement record was last updated. Supports change tracking and audit requirements.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this KOL engagement record. Maintains accountability for data changes.',
    `notes` STRING COMMENT 'Free-text field capturing additional context, outcomes, or observations from the KOL engagement. May include key discussion points, action items, or follow-up requirements.',
    `publication_title` STRING COMMENT 'The title of the scientific publication or manuscript being reviewed by the KOL, if the engagement type is publication review. Links engagement to publication planning activities.',
    `strategic_relationship_tier` STRING COMMENT 'Classification of the KOLs strategic importance to the organization. Tier 1 represents national/international thought leaders, Tier 2 regional influencers, Tier 3 local experts, and Emerging represents developing relationships.. Valid values are `tier_1_national|tier_2_regional|tier_3_local|emerging`',
    `transparency_report_date` DATE COMMENT 'The date on which this KOL engagement was reported to the applicable transparency reporting system or regulatory authority.',
    `transparency_reporting_required` BOOLEAN COMMENT 'Boolean flag indicating whether this KOL engagement must be reported under transparency regulations such as the Sunshine Act (US), EFPIA Code (EU), or similar country-specific requirements.',
    `veeva_crm_activity_code` STRING COMMENT 'The unique activity identifier from Veeva CRM system linking this KOL engagement to the source system record. Enables traceability to operational CRM data.',
    CONSTRAINT pk_kol_engagement PRIMARY KEY(`kol_engagement_id`)
) COMMENT 'Tracks engagement activities with Key Opinion Leaders (KOLs) by the commercial and medical affairs teams. Captures KOL HCP ID, engagement type (advisory board, speaker training, publication review, congress presentation, consulting), engagement date, brand, therapeutic area, honorarium, compliance approval status, and strategic relationship tier. Distinct from speaker_engagement which is program-specific — this is the longitudinal KOL relationship management record.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` (
    `patient_support_program_id` BIGINT COMMENT 'Unique identifier for the patient support program record. Primary key.',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand (drug product) that this patient support program serves.',
    `brand_plan_id` BIGINT COMMENT 'Foreign key linking to commercial.brand_plan. Business justification: patient_support_program is planned and budgeted within the brand_plan. PSP launch dates, eligibility criteria, and budget allocations are defined as part of the annual brand planning process. Linking ',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: PSP programs require budget tracking for gross-to-net impact, vendor payments, and patient benefit costs. Critical for revenue recognition and financial forecasting.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Patient support programs require country-specific regulatory approval and compliance (HIPAA in US, GDPR in EU, local health authority rules). geography is a denormalized country reference. A market ac',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: PSPs often operate at drug product level for pharmacy claims processing. NDC-level eligibility rules and benefit determination require drug product specificity. Real business process: copay card adjud',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: PSP viability and planning horizon are directly governed by exclusivity period; programs are designed to support patients during the branded exclusivity window. Commercial and patient access teams pla',
    `indication_id` BIGINT COMMENT 'Foreign key linking to product.indication. Business justification: PSPs are designed for specific approved indications (e.g., a copay program scoped to a specific cancer indication). patient_support_program.indication is plain text. FK supports indication-level patie',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Patient support programs are tracked as internal orders in pharma finance for hub service costs, vendor payments, and program accruals. The PSP financial management and cost center reporting process r',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Patient support programs are operated by specific legal entities. Required for program ownership determination, regulatory approval attribution, financial liability tracking, and transparency reportin',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: For in-licensed products, licensing agreements may restrict or define terms for patient support programs including territory, indication scope, and co-pay assistance eligibility. Compliance teams must',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Patient support programs have dedicated cost centers for budget tracking. Required for program spend monitoring, gross-to-net accruals, budget vs. actual analysis, and commercial operations P&L.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: PSPs support patient access to specific medicinal products. Program design, eligibility criteria, and ROI analysis require product linkage. Real business process: PSP portfolio management and patient ',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Patient support programs are owned and funded by a specific business unit/org_unit for budget accountability and P&L reporting. business_unit is a denormalized org_unit name. A commercial operations e',
    `patient_access_program_id` BIGINT COMMENT 'Foreign key linking to market.patient_access_program. Business justification: Patient support programs (commercial) implement patient access programs (market access strategy). Links operational PSP execution to strategic market access program definition for tracking enrollment ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: PSP costs are tracked to a profit center for brand-level P&L reporting and gross-to-net accounting. profit_center is a denormalized profit center name. A finance expert expects a structured profit_cen',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to market.reimbursement_policy. Business justification: Patient support programs are designed to bridge reimbursement gaps — the program type, benefit cap, and eligibility criteria are directly determined by the reimbursement policy landscape. Market acces',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Patient support programs are TA-specific and managed within TA commercial teams. patient_support_program.therapeutic_area is plain text. FK supports TA-level patient access reporting, program performa',
    `trial_id` BIGINT COMMENT 'Foreign key linking to clinical.trial. Business justification: PSPs for rare diseases and oncology are frequently designed as extensions of clinical trial populations (expanded access, compassionate use transitioning to commercial PSP). Linking PSP to the origina',
    `active_enrolled_patients` STRING COMMENT 'Current count of patients with active enrollment status in the program.',
    `adherence_rate_actual` DECIMAL(18,2) COMMENT 'Actual medication adherence rate (as percentage) achieved among enrolled patients, measured using prescription refill data or patient-reported outcomes.',
    `adherence_rate_target` DECIMAL(18,2) COMMENT 'Target medication adherence rate (as percentage) that the program aims to achieve among enrolled patients.',
    `benefit_type` STRING COMMENT 'Primary type of benefit or service provided to enrolled patients through this program.. Valid values are `co-pay card|free drug voucher|nurse support|reimbursement assistance|prior authorization support|patient education materials`',
    `cost_per_enrollment` DECIMAL(18,2) COMMENT 'Average cost to the program per patient enrollment, calculated as total spend divided by total enrollments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the patient support program record was first created in the system.',
    `eligibility_criteria` STRING COMMENT 'Detailed description of the criteria patients must meet to qualify for enrollment in the program, including income thresholds, insurance status, and clinical requirements.',
    `enrollment_channel` STRING COMMENT 'Primary channel through which patients can enroll in the support program.. Valid values are `hcp referral|patient direct|pharmacy|call center|web portal|mobile app`',
    `hipaa_compliant_flag` BOOLEAN COMMENT 'Indicates whether the program operations and vendor have been certified as compliant with HIPAA Privacy and Security Rules.',
    `income_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum annual household income level for patient eligibility in financial assistance programs. Null if program does not have income restrictions.',
    `income_threshold_currency` STRING COMMENT 'Currency code for the income threshold amount using ISO 4217 three-letter codes.. Valid values are `USD|EUR|GBP|JPY|CNY`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the patient support program record was last updated in the system.',
    `launch_date` DATE COMMENT 'Date when the patient support program was officially launched and began accepting patient enrollments.',
    `max_benefit_amount` DECIMAL(18,2) COMMENT 'Maximum financial benefit amount per patient per year for co-pay assistance or free drug programs. Null if program does not have a cap.',
    `max_benefit_currency` STRING COMMENT 'Currency code for the maximum benefit amount using ISO 4217 three-letter codes.. Valid values are `USD|EUR|GBP|JPY|CNY`',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the patient support program record.',
    `program_budget_currency` STRING COMMENT 'Currency code for the program budget amount using ISO 4217 three-letter codes.. Valid values are `USD|EUR|GBP|JPY|CNY`',
    `program_status` STRING COMMENT 'Current operational status of the patient support program indicating whether it is accepting new enrollments.. Valid values are `active|inactive|suspended|pending launch|terminated`',
    `program_type` STRING COMMENT 'Classification of the patient support program based on the primary service provided to patients. [ENUM-REF-CANDIDATE: co-pay assistance|free drug program|nurse navigator|adherence support|hub services|patient education|reimbursement support — 7 candidates stripped; promote to reference product]',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval or notification for the patient support program where required by local health authorities.. Valid values are `approved|pending|not required|conditional`',
    `termination_date` DATE COMMENT 'Date when the patient support program was terminated or is scheduled to be terminated. Null for active programs.',
    `total_enrolled_patients` STRING COMMENT 'Cumulative count of unique patients who have enrolled in the program since launch.',
    `transparency_reporting_required` BOOLEAN COMMENT 'Indicates whether program benefits must be reported under Physician Payments Sunshine Act or equivalent transparency regulations.',
    `vendor_performance_score` DECIMAL(18,2) COMMENT 'Composite performance score (0-100 scale) for the administering vendor based on service level agreement (SLA) metrics including enrollment processing time, patient satisfaction, and compliance.',
    CONSTRAINT pk_patient_support_program PRIMARY KEY(`patient_support_program_id`)
) COMMENT 'Master record and enrollment ledger for patient support programs (PSPs). Program header captures program name, brand, program type (co-pay assistance, free drug, nurse navigator, adherence program, hub services), eligibility criteria, administering vendor, program KPIs, and vendor performance metrics. Enrollment detail captures individual patient enrollments including enrollment date, prescribing HCP, enrollment channel, eligibility verification status, benefit type granted (co-pay card, free drug voucher, nurse call), enrollment status, program exit reason, and adherence milestones. Supports access and adherence analytics, program ROI measurement, patient journey optimization, hub services vendor performance tracking, and HIPAA-compliant de-identified reporting.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` (
    `psp_enrollment_id` BIGINT COMMENT 'Unique identifier for the patient support program enrollment record. Primary key.',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand or product associated with this patient support program enrollment.',
    `clinical_enrollment_id` BIGINT COMMENT 'Foreign key linking to clinical.clinical_enrollment. Business justification: Patients transitioning from clinical trial enrollment to commercial PSP enrollment is a standard pharma patient journey scenario (e.g., post-trial access programs). This link enables patient journey a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: PSP enrollment costs are tracked to a cost center for financial accounting and budget management. cost_center is a denormalized cost center reference. A finance expert expects a structured cost_center',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Patient enrollments are for specific drug product prescriptions. Prescription fulfillment, adherence monitoring, and benefit utilization tracking require drug product linkage. Real business process: e',
    `hco_master_id` BIGINT COMMENT 'Foreign key linking to hcp.hco_master. Business justification: Patient support program enrollments are administered through specific healthcare organizations (specialty pharmacies, infusion centers, clinics). Pharma hub services teams track which HCO is managing ',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: PSP enrollments generate invoices from hub service vendors and specialty pharmacies. The PSP vendor payment management, program cost tracking, and patient assistance financial reporting process requir',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: PSP enrollments create benefit obligations for specific legal entities. Required for financial liability tracking, gross-to-net accrual validation, regulatory compliance, and transparency reporting by',
    `master_id` BIGINT COMMENT 'Reference to the prescribing healthcare professional who enrolled or referred the patient to the program.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: PSP enrollments support patented products; program eligibility, benefit design, and enrollment tracking align with IP protection for strategic program management.',
    `patient_access_program_id` BIGINT COMMENT 'Foreign key linking to market.patient_access_program. Business justification: Individual PSP enrollment records must reference the market-level patient access program governing eligibility, benefit terms, and regulatory authorization. Required for benefit adjudication, transpar',
    `patient_id` BIGINT COMMENT 'Anonymized or de-identified patient identifier compliant with HIPAA privacy requirements. Does not contain direct personal identifiers.',
    `patient_support_program_id` BIGINT COMMENT 'Reference to the patient support program in which the patient is enrolled. Links to the master program definition.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: PSP enrollment benefits are tracked to a profit center for brand-level P&L and gross-to-net reporting. profit_center is a denormalized profit center reference. A finance expert expects a structured pr',
    `sales_rep_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_rep. Business justification: psp_enrollment tracks patient enrollments in patient support programs. The prescribing rep (identified by prescribing_npi as a STRING) is a key attribution field for PSP enrollments in pharma commerci',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory associated with this enrollment for commercial performance tracking.',
    `administering_vendor` STRING COMMENT 'Name of the third-party vendor or Contract Research Organization (CRO) administering the patient support program on behalf of the pharmaceutical company.',
    `benefit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the benefit amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `benefit_end_date` DATE COMMENT 'Date when the patient support program benefits expire or are scheduled to terminate. May be null for open-ended programs.',
    `benefit_start_date` DATE COMMENT 'Date when the patient support program benefits become active and available for use by the patient.',
    `benefit_type` STRING COMMENT 'Type of benefit or support service granted to the patient through this enrollment. May include financial assistance, clinical support, or educational resources.. Valid values are `copay_card|free_drug_voucher|nurse_support|patient_education|financial_assistance|adherence_coaching`',
    `consent_date` DATE COMMENT 'Date when patient consent for program participation was obtained.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether patient consent for program participation and data usage was obtained in compliance with HIPAA and privacy regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was first created in the system. Audit trail field.',
    `eligibility_verification_date` DATE COMMENT 'Date when patient eligibility for the program was verified or determined.',
    `eligibility_verification_status` STRING COMMENT 'Status of the eligibility verification process to determine if patient qualifies for program benefits based on income, insurance, or other criteria.. Valid values are `not_verified|verified|failed|pending|waived`',
    `enrollment_channel` STRING COMMENT 'Channel or method through which the patient enrolled in the support program. Supports channel effectiveness analysis.. Valid values are `hcp_referral|patient_direct|call_center|web_portal|mobile_app|field_representative`',
    `enrollment_date` DATE COMMENT 'Date when the patient was officially enrolled in the patient support program. Represents the business event timestamp for enrollment initiation.',
    `enrollment_number` STRING COMMENT 'Business-facing enrollment confirmation number provided to patient and HCP for reference and tracking purposes.',
    `enrollment_source_record_reference` STRING COMMENT 'Unique identifier of the enrollment record in the source system for traceability and reconciliation.',
    `enrollment_source_system` STRING COMMENT 'Source system or application from which the enrollment record originated (e.g., Veeva CRM, Salesforce Health Cloud, vendor portal).',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the patient enrollment in the support program. Tracks progression from application through completion or exit.. Valid values are `pending|active|suspended|completed|cancelled|denied`',
    `exit_date` DATE COMMENT 'Date when the patient exited or was terminated from the patient support program. Null if enrollment is still active.',
    `exit_reason` STRING COMMENT 'Reason for patient exit from the support program. Supports program retention and adherence analysis.. Valid values are `benefit_exhausted|patient_request|treatment_discontinued|insurance_change|program_ended|non_compliance`',
    `indication` STRING COMMENT 'Specific medical indication or condition for which the patient is enrolled in the support program.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this enrollment record was last updated. Audit trail field for change tracking.',
    `max_benefit_amount` DECIMAL(18,2) COMMENT 'Maximum financial benefit amount available to the patient under this enrollment, if applicable. Null for non-financial benefits.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the enrollment, including special circumstances, exceptions, or follow-up actions.',
    `prescribing_npi` STRING COMMENT 'National Provider Identifier of the prescribing healthcare professional. Used for Sunshine Act transparency reporting.. Valid values are `^[0-9]{10}$`',
    `remaining_benefit_amount` DECIMAL(18,2) COMMENT 'Remaining financial benefit amount available to the patient under this enrollment.',
    `therapeutic_area` STRING COMMENT 'Therapeutic area or disease category for which the patient is receiving support (e.g., oncology, immunology, rare diseases).',
    `transparency_report_date` DATE COMMENT 'Date when transparency reporting for this enrollment was submitted to regulatory authorities.',
    `transparency_reporting_required` BOOLEAN COMMENT 'Indicates whether this enrollment requires reporting under Sunshine Act or other transparency regulations for value transfer to healthcare professionals.',
    CONSTRAINT pk_psp_enrollment PRIMARY KEY(`psp_enrollment_id`)
) COMMENT 'Transactional record of a patients enrollment in a patient support program. Captures enrollment date, program ID, patient reference (anonymized or de-identified per HIPAA), prescribing HCP, enrollment channel, eligibility verification status, benefit type granted (co-pay card, free drug voucher, nurse call), enrollment status, and program exit reason. Supports access and adherence analytics and program ROI measurement.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` (
    `contract_account_id` BIGINT COMMENT 'Unique identifier for the commercial contract account. Primary key for institutional customer accounts including hospital systems, IDNs, GPOs, specialty pharmacies, and retail pharmacy chains.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Contract accounts (wholesalers, distributors) carry AR balances in pharma trade operations. Credit management, collections, and DSO reporting require linking AR records to the contract account. Standa',
    `address_id` BIGINT COMMENT 'Foreign key linking to masterdata.address. Business justification: Contract accounts have structured billing addresses used for invoice generation, tax determination, and regulatory compliance. The five billing address columns are denormalized masterdata.address fiel',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Contract accounts (GPOs, hospitals, pharmacies) have a billing country that determines VAT, tax treatment, and regulatory compliance for invoicing. billing_country_code is a denormalized country refer',
    `brand_id` BIGINT COMMENT 'Foreign key linking to commercial.brand. Business justification: contract_account is a commercial contract account for institutional customers (hospital systems, IDNs, GPOs). In pharma commercial operations, institutional contracts are typically brand-specific or b',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Contract accounts are business partners in master data. Required for customer master synchronization, credit limit management, payment terms, order-to-cash integration, and ERP-CRM data consistency.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Contract accounts are assigned to cost centers for financial tracking of account management costs and rebate accruals. cost_center is a denormalized cost center reference. A finance expert expects a s',
    `hco_master_id` BIGINT COMMENT 'Foreign key linking to hcp.hco_master. Business justification: Commercial contract accounts in pharma represent healthcare organizations (hospitals, IDNs, GPOs). Linking to hco_master enables account managers to tie contract terms to HCO master data for formulary',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Contract accounts are customers of specific legal entities. Required for revenue recognition, intercompany transactions, credit management, tax compliance, and order-to-cash processing by legal entity',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Contract accounts may have licensing agreements; commercial terms, royalty obligations, and territory restrictions depend on IP licensing for accurate contract management.',
    `parent_account_contract_account_id` BIGINT COMMENT 'Reference to the parent contract account for hierarchical account structures. Used for IDN systems where individual hospitals roll up to a corporate parent. Null for top-level accounts.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: GPO and payer contracts reference specific patents for authorized generic provisions, patent linkage clauses, and step-down pricing at patent expiry. Contracting teams must link accounts to relevant p',
    `payer_account_id` BIGINT COMMENT 'Foreign key linking to market.payer_account. Business justification: Contract accounts may represent institutional payers (hospitals, health systems) that also have payer contracts. Account classification and contracting process links commercial accounts to payer entit',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to market.market_payer_contract. Business justification: Contract accounts (GPOs, PBMs, health plans) are governed by specific payer contracts. A direct link enables contract term enforcement, rebate eligibility verification, and contract compliance reporti',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory to which this account is assigned. Supports field force planning, quota allocation, and geographic performance tracking.',
    `account_name` STRING COMMENT 'Legal or trading name of the institutional customer account. Primary human-readable identifier for the account.',
    `account_number` STRING COMMENT 'Externally-known unique business identifier for the contract account. Used in commercial operations, invoicing, and customer communications. Typically assigned by ERP system (SAP SD module).. Valid values are `^[A-Z0-9]{8,15}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the contract account. Active accounts are eligible for orders and promotional activities. Suspended accounts have temporary restrictions. Closed accounts are no longer serviced.. Valid values are `active|inactive|pending|suspended|closed`',
    `account_type` STRING COMMENT 'Classification of the institutional customer account type. IDN = Integrated Delivery Network, GPO = Group Purchasing Organization. Determines sales strategy, pricing tier, and field force coverage model.. Valid values are `hospital_system|idn|gpo|specialty_pharmacy|retail_pharmacy_chain|clinic_network`',
    `annual_revenue_potential` DECIMAL(18,2) COMMENT 'Estimated annual revenue opportunity for this account based on market analysis, historical performance, and account size. Used for territory planning and resource allocation.',
    `business_unit` STRING COMMENT 'Business unit or division responsible for managing this account. Used for P&L reporting and organizational alignment.',
    `contract_end_date` DATE COMMENT 'Expiration date of the current contract agreement. Triggers contract renewal workflow. Null for evergreen contracts without fixed expiration.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current contract agreement with this institutional account. Pricing and terms become active on this date.',
    `contract_tier` STRING COMMENT 'Pricing and service tier assigned to the account based on volume commitments, GPO affiliation, and negotiated terms. Determines discount levels, rebate structures, and service level agreements.. Valid values are `platinum|gold|silver|bronze|standard`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this contract account record was first created in the system. Audit field for data lineage and compliance.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit exposure allowed for this account. Enforced during order processing to manage financial risk. Set by credit management team based on financial assessment.',
    `credit_limit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit limit amount. Typically matches the accounts primary transaction currency.. Valid values are `^[A-Z]{3}$`',
    `dea_number` STRING COMMENT 'DEA registration number for accounts authorized to handle controlled substances. Required for distribution of Schedule II-V medications. Format: 2 letters followed by 7 digits.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `gpo_affiliation` STRING COMMENT 'Name of the Group Purchasing Organization (GPO) that this account is affiliated with, if applicable. GPO affiliation determines contract pricing tier and rebate eligibility. Null if account is not GPO-affiliated.',
    `hin_number` STRING COMMENT 'Health Industry Number assigned by GS1 for healthcare supply chain identification. Used for EDI transactions and supply chain traceability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this contract account record was last updated. Audit field for change tracking and data quality monitoring.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this record. Audit field for accountability and compliance.',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the account. Defines invoice due date calculation and early payment discount eligibility. Format examples: net_30 (payment due in 30 days), 2_10_net_30 (2% discount if paid within 10 days, otherwise net 30).. Valid values are `net_30|net_45|net_60|net_90|due_on_receipt|2_10_net_30`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact. Used for contract communications, order confirmations, and account notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary business contact at the institutional account. Typically the procurement director, pharmacy director, or contracting officer.',
    `primary_contact_phone` STRING COMMENT 'Primary phone number for the institutional account contact. Used for urgent communications and relationship management.',
    `profit_center` STRING COMMENT 'Profit center code for revenue and margin reporting. Enables P&L analysis by account segment.',
    `shipping_address_line1` STRING COMMENT 'First line of the primary shipping address for product deliveries. May differ from billing address for multi-site organizations.',
    `shipping_address_line2` STRING COMMENT 'Second line of the shipping address (dock, receiving department). Optional field for delivery instructions.',
    `shipping_city` STRING COMMENT 'City name for the primary shipping address of the institutional account.',
    `shipping_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the shipping address. Determines export compliance requirements and GDP regulations.. Valid values are `^[A-Z]{3}$`',
    `shipping_postal_code` STRING COMMENT 'Postal or ZIP code for the shipping address. Used for freight calculation and delivery routing.',
    `shipping_state_province` STRING COMMENT 'State or province code for the shipping address. Used for logistics planning and distribution compliance.',
    `strategic_classification` STRING COMMENT 'Strategic importance tier of the account based on revenue potential, market influence, and relationship depth. Tier 1 accounts receive dedicated account management and customized engagement programs.. Valid values are `tier_1_strategic|tier_2_key|tier_3_standard|tier_4_emerging`',
    `tax_identification_number` STRING COMMENT 'Tax identification number (TIN, VAT number, or equivalent) for the institutional account. Required for tax-compliant invoicing and regulatory reporting.',
    CONSTRAINT pk_contract_account PRIMARY KEY(`contract_account_id`)
) COMMENT 'Commercial contract account master for institutional customers including hospital systems, IDNs (Integrated Delivery Networks), GPOs (Group Purchasing Organizations), specialty pharmacies, and retail pharmacy chains. Captures account name, account type, GPO affiliation, contract tier, account manager assignment, strategic classification, and key contact information. Supports institutional selling, account-based marketing, and field force account coverage planning. Distinct from hcp domain (individual practitioners) and market domain (payer contracts).';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` (
    `sales_performance_id` BIGINT COMMENT 'Unique identifier for the sales performance record. Primary key for the sales performance data product.',
    `brand_id` BIGINT COMMENT 'Identifier for the pharmaceutical brand or product for which sales performance is measured.',
    `brand_plan_id` BIGINT COMMENT 'Foreign key linking to commercial.brand_plan. Business justification: sales_performance is a periodic performance record that measures actual results against targets. brand_plan defines the quota_amount, market_share_target, and prescription_volume_target that sales_per',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Sales performance reporting is country-specific for market share analysis, quota setting, and incentive compensation calculations. geography is a denormalized country reference. A commercial analytics',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Sales performance reporting tracks revenue relative to exclusivity windows; LOE events are critical business milestones that trigger performance benchmarks and quota resets. Finance and commercial tea',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Commercial sales performance should link to finance budgets for sales budget tracking and variance analysis. This enables integrated financial planning and performance management across commercial and',
    `formulary_position_id` BIGINT COMMENT 'Foreign key linking to market.market_formulary_position. Business justification: Sales performance metrics (quota attainment, market share) are interpreted in the context of formulary position — a rep in a territory with preferred formulary status has different benchmarks than one',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Sales force costs (incentive compensation, T&E, samples) are tracked against internal orders in pharma SAP environments. The sales force cost reporting and incentive compensation accrual process requi',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: For in-licensed products, sales performance data directly feeds royalty calculation reports under licensing agreements. Finance and commercial teams must link performance records to licensing agreemen',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Sales performance is tracked by cost center for budget allocation. Required for budget vs. actual analysis, IC plan administration, promotional spend tracking, and commercial operations financial repo',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: Sales performance drives profit center results and revenue targets. Required for segment reporting, brand P&L, portfolio performance management, and financial consolidation by therapeutic area or geog',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Sales performance metrics (TRx, NRx, market share) are tracked at medicinal product level. Incentive compensation calculation and territory performance reporting require product linkage. Real business',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Sales performance is reported by org_unit/business_unit for organizational P&L, incentive compensation management, and sales force effectiveness benchmarking. business_unit is a denormalized org_unit ',
    `payer_account_id` BIGINT COMMENT 'Foreign key linking to market.payer_account. Business justification: Sales performance is tracked by payer account to measure impact of formulary position and contracts. Performance reporting and analytics process links sales metrics to payer accounts for ROI analysis.',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to market.reimbursement_policy. Business justification: Sales performance in a territory is directly affected by reimbursement policy status — covered vs. restricted vs. excluded status drives prescribing behavior and quota-setting. Commercial analytics an',
    `sales_rep_id` BIGINT COMMENT 'Identifier for the sales representative whose performance is being tracked. Links to employee or sales rep master data.',
    `territory_id` BIGINT COMMENT 'Identifier for the sales territory where performance is measured. Links to territory master data.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: TA-level sales performance reporting is a core commercial analytics use case for quota setting, incentive compensation design, and portfolio performance dashboards. sales_performance.therapeutic_area ',
    `actual_performance_amount` DECIMAL(18,2) COMMENT 'Actual sales performance achieved during the period, measured in the same units as quota (prescription volume or revenue).',
    `approval_date` DATE COMMENT 'Date when the sales performance record was approved by sales management for incentive compensation processing.',
    `call_attainment_percent` DECIMAL(18,2) COMMENT 'Percentage of target call frequency achieved, calculated as (call_frequency_achieved / call_frequency_target) * 100.',
    `call_frequency_achieved` STRING COMMENT 'Actual number of Healthcare Professional (HCP) calls completed by the sales representative during the performance period.',
    `call_frequency_target` STRING COMMENT 'Target number of Healthcare Professional (HCP) calls planned for the sales representative during the performance period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales performance record was first created in the system.',
    `data_source` STRING COMMENT 'Source system or data provider for the sales performance metrics (e.g., Veeva CRM for call data, IQVIA for prescription data).. Valid values are `veeva_crm|iqvia|symphony_health|internal_calculation|manual_entry`',
    `incentive_compensation_amount` DECIMAL(18,2) COMMENT 'Calculated incentive compensation earned by the sales representative for the performance period based on quota attainment.',
    `incentive_compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the incentive compensation amount.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales performance record was last updated or modified.',
    `market_share_percent` DECIMAL(18,2) COMMENT 'Brand market share as a percentage of total prescriptions in the therapeutic category within the territory during the performance period.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the sales performance record.',
    `new_prescriptions` BIGINT COMMENT 'Number of new prescriptions (NRx) written for the brand during the performance period, excluding refills.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the sales performance record, including explanations for variances or disputes.',
    `performance_period_end_date` DATE COMMENT 'End date of the performance measurement period (weekly, monthly, or quarterly cycle).',
    `performance_period_start_date` DATE COMMENT 'Start date of the performance measurement period (weekly, monthly, or quarterly cycle).',
    `performance_status` STRING COMMENT 'Current status of the sales performance record in the review and approval workflow.. Valid values are `draft|submitted|approved|finalized|disputed`',
    `period_type` STRING COMMENT 'Type of performance measurement period: weekly, monthly, quarterly, or annual.. Valid values are `weekly|monthly|quarterly|annual`',
    `quota_amount` DECIMAL(18,2) COMMENT 'Sales quota or target assigned to the sales representative for the brand during the performance period, typically measured in prescription volume or revenue.',
    `quota_attainment_percent` DECIMAL(18,2) COMMENT 'Percentage of quota achieved, calculated as (actual_performance_amount / quota_amount) * 100. Used for incentive compensation calculation.',
    `quota_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the quota amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `sample_drop_rate` DECIMAL(18,2) COMMENT 'Average number of sample units distributed per HCP call during the performance period.',
    `sample_units_distributed` BIGINT COMMENT 'Total number of product sample units distributed by the sales representative during the performance period.',
    `total_prescriptions` BIGINT COMMENT 'Total number of prescriptions (TRx) written for the brand during the performance period, including both new and refill prescriptions.',
    `veeva_crm_record_code` STRING COMMENT 'External identifier linking this performance record to the corresponding record in Veeva CRM system.',
    CONSTRAINT pk_sales_performance PRIMARY KEY(`sales_performance_id`)
) COMMENT 'Periodic (weekly/monthly/quarterly) sales performance record at the territory and rep level by brand. Captures period, territory ID, rep ID, brand, total prescriptions (TRx), new prescriptions (NRx), market share, call frequency achieved vs. target, sample drop rate, and attainment vs. quota. Sourced from CRM and Rx data integration. Supports incentive compensation calculation and field force management.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` (
    `copay_program_id` BIGINT COMMENT 'Unique identifier for the co-pay assistance program record. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Copay program vendor administration fees create AP obligations. Links program setup to financial payment tracking for vendor contract management.',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand or product associated with this co-pay program.',
    `brand_plan_id` BIGINT COMMENT 'Foreign key linking to commercial.brand_plan. Business justification: copay_program is a patient affordability program planned and budgeted within the brand_plan. Co-pay program parameters (max_annual_benefit_amount, eligibility_criteria, launch_date) are defined during',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Copay programs have explicit budgets for manufacturer contributions. Required for gross-to-net accrual accuracy and financial planning of patient access programs.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Copay programs are country-specific for regulatory compliance (340B exclusions, government payer rules vary by country). geography is a denormalized country reference. A market access expert expects a',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Copay programs operate at drug product level for pharmacy claims adjudication. NDC-level eligibility rules and claims processing require drug product linkage. Real business process: pharmacy claims ad',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Copay programs are commercially viable only during exclusivity; programs must be designed, budgeted, and terminated relative to exclusivity expiry dates. Market access teams explicitly plan copay prog',
    `indication_id` BIGINT COMMENT 'FK to product.indication',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Copay assistance programs are managed as internal orders in pharma finance for accrual, cost tracking, and gross-to-net reporting. The program financial management and period-end accrual process requi',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Copay programs are operated by specific legal entities. Required for gross-to-net accruals, regulatory compliance (anti-kickback safe harbor), financial liability tracking, and transparency reporting ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Copay programs have dedicated cost centers for spend tracking. Required for gross-to-net reconciliation, budget management, accrual validation, and commercial operations P&L by cost center.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Copay programs reduce patient costs for specific medicinal products. Program design, gross-to-net forecasting, and ROI analysis require product linkage. Real business process: copay program portfolio ',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Copay programs are owned by a specific business unit/org_unit for budget accountability and P&L reporting. business_unit is a denormalized org_unit name. A market access expert expects a structured or',
    `patient_access_program_id` BIGINT COMMENT 'Foreign key linking to market.patient_access_program. Business justification: Copay programs are a specific type of patient access program defined in market access strategy. Links commercial copay program execution to strategic market access program for tracking against access ',
    `profit_center_id` BIGINT COMMENT 'FK to masterdata.profit_center',
    `reimbursement_policy_id` BIGINT COMMENT 'Foreign key linking to market.reimbursement_policy. Business justification: Copay programs are designed specifically to address reimbursement policy barriers — step therapy, prior authorization, and quantity limits in reimbursement policies directly drive copay program design',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Copay programs are TA-specific for gross-to-net management and commercial budget allocation. copay_program.therapeutic_area is plain text. FK supports TA-level GTN reporting, payer strategy analytics,',
    `active_enrolled_patients` STRING COMMENT 'Current count of patients with active enrollment status in the co-pay program.',
    `commercial_insurance_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether patients must have commercial insurance coverage to be eligible for the co-pay program.',
    `compliance_approval_date` DATE COMMENT 'Date when the co-pay program received final compliance and legal approval for launch.',
    `compliance_review_status` STRING COMMENT 'Status of legal and compliance review for the co-pay program to ensure adherence to Anti-Kickback Statute, PhRMA Code, and promotional regulations.. Valid values are `approved|pending_review|rejected|not_required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the co-pay program record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this program (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `eligibility_criteria` STRING COMMENT 'Detailed description of patient eligibility requirements for enrollment in the co-pay program, including insurance type restrictions, income thresholds, and other qualifying conditions.',
    `exclusion_340b_flag` BOOLEAN COMMENT 'Boolean flag indicating whether prescriptions filled through 340B covered entities are excluded from this co-pay program to maintain compliance with federal regulations.',
    `exclusion_government_payer_flag` BOOLEAN COMMENT 'Boolean flag indicating whether patients with government-funded insurance (Medicare, Medicaid, TRICARE, VA) are excluded from program eligibility per Anti-Kickback Statute compliance.',
    `gross_to_net_category` STRING COMMENT 'Gross-to-net deduction category for financial reporting, used to classify co-pay program costs in revenue reconciliation and brand P&L analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the co-pay program record was last updated or modified.',
    `launch_date` DATE COMMENT 'Date when the co-pay program was officially launched and made available to patients.',
    `max_annual_benefit_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount of co-pay assistance a patient can receive per calendar year under this program.',
    `max_benefit_per_prescription` DECIMAL(18,2) COMMENT 'Maximum dollar amount of co-pay assistance available per individual prescription fill or claim.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the co-pay program record.',
    `notes` STRING COMMENT 'Free-text field for additional program details, special instructions, or operational notes related to the co-pay program.',
    `program_owner` STRING COMMENT 'Name or identifier of the commercial operations leader or brand manager responsible for the co-pay program strategy and performance.',
    `program_status` STRING COMMENT 'Current lifecycle status of the co-pay program indicating whether it is active, inactive, suspended, pending launch, or terminated.. Valid values are `active|inactive|suspended|pending_launch|terminated`',
    `program_type` STRING COMMENT 'Classification of the co-pay program mechanism (e.g., co-pay card, voucher, free trial, instant savings, rebate, patient assistance).. Valid values are `copay_card|voucher|free_trial|instant_savings|rebate|patient_assistance`',
    `termination_date` DATE COMMENT 'Date when the co-pay program was or will be terminated. Null for ongoing programs.',
    `total_enrolled_patients` STRING COMMENT 'Cumulative count of unique patients who have enrolled in the co-pay program since launch.',
    `total_redemptions_count` STRING COMMENT 'Cumulative count of co-pay card or voucher redemptions processed under this program since launch.',
    `transparency_reporting_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether co-pay program benefits must be reported under Physician Payments Sunshine Act or other transparency regulations.',
    `veeva_crm_record_code` STRING COMMENT 'External system identifier linking this co-pay program to the corresponding record in Veeva CRM for commercial operations tracking.',
    CONSTRAINT pk_copay_program PRIMARY KEY(`copay_program_id`)
) COMMENT 'Master record and transactional redemption ledger for co-pay assistance and patient affordability programs. Program header captures program name, brand, program type (co-pay card, voucher, free trial), maximum annual benefit, eligibility rules, administering hub vendor, program status, and 340B exclusion rules. Redemption detail captures each individual co-pay card or voucher redemption including redemption date, pharmacy NPI, product NDC, patient out-of-pocket amount, manufacturer contribution, payer adjudication status, claim reference, and gross-to-net impact. Supports patient access strategy, program utilization analytics, brand P&L gross-to-net deduction reporting, and 340B program exclusion tracking.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` (
    `copay_redemption_id` BIGINT COMMENT 'Unique identifier for each co-pay card or voucher redemption transaction. Primary key for the copay_redemption product.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Copay redemptions create manufacturer payment obligations to pharmacies/PBMs. Required for payment reconciliation, chargeback processing, and gross-to-net accuracy.',
    `accounts_receivable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_receivable. Business justification: Copay transactions may generate receivables from payers or require chargeback processing affecting AR. Links redemption to revenue recognition and payer reconciliation.',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand for which the co-pay assistance was provided.',
    `copay_program_id` BIGINT COMMENT 'Reference to the patient support program under which this co-pay card or voucher was issued.',
    `cost_center_id` BIGINT COMMENT 'FK to masterdata.cost_center',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Copay redemptions are jurisdiction-specific for gross-to-net accounting, Medicaid best price calculations, and transparency reporting. geography is a denormalized country reference. A finance/complian',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Copay redemptions are for specific drug products dispensed. Product-level redemption analytics and gross-to-net reconciliation require drug product linkage. Real business process: redemption reporting',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Copay redemptions are gross-to-net adjustments that post to specific GL accounts (contra-revenue). The gross-to-net reporting, revenue recognition, and SOX-compliant financial close process require li',
    `indication_id` BIGINT COMMENT 'FK to product.indication',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Each copay redemption posts a journal entry as a gross-to-net contra-revenue adjustment. The revenue recognition, gross-to-net financial close, and SOX audit trail process require linking individual r',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Copay redemptions create financial obligations for specific legal entities. Required for accrual validation, gross-to-net calculation, financial reporting, and audit trail of payment entity for each r',
    `gross_to_net_adjustment_id` BIGINT COMMENT 'Foreign key linking to market.gross_to_net_adjustment. Business justification: Copay redemptions drive gross-to-net adjustments for manufacturer copay contributions. Financial reconciliation process requires linking redemption transactions to GTN accruals for revenue recognition',
    `patient_id` BIGINT COMMENT 'De-identified or tokenized patient identifier used by the co-pay program administrator to track individual patient utilization while maintaining HIPAA compliance.',
    `master_id` BIGINT COMMENT 'Foreign key linking to hcp.master. Business justification: Copay redemptions must be linked to the prescribing HCP for Sunshine Act gross-to-net reporting and prescriber-level analytics. copay_redemption stores prescriber_npi as a denormalized string; role-pr',
    `profit_center_id` BIGINT COMMENT 'FK to masterdata.profit_center',
    `sales_rep_id` BIGINT COMMENT 'Foreign key linking to commercial.sales_rep. Business justification: copay_redemption tracks individual co-pay card redemptions at the pharmacy. In pharma commercial operations, redemptions are attributed to the sales rep responsible for the prescriber relationship (id',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Copay redemptions are processed at the NDC/SKU level during pharmacy adjudication. FK to sku supports GTN analytics at the SKU level, payer contract compliance, and gross-to-net reconciliation — pharm',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory in which the pharmacy or prescriber is located, used for sales force performance tracking and territory alignment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this transaction (e.g., USD, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `days_supply` STRING COMMENT 'Number of days the dispensed quantity is intended to last based on the prescribed dosing regimen.',
    `insurance_paid_amount` DECIMAL(18,2) COMMENT 'The amount paid by the patients insurance plan or pharmacy benefit manager toward the prescription cost.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was last updated, reflecting status changes, reversals, or data corrections.',
    `patient_out_of_pocket_amount` DECIMAL(18,2) COMMENT 'The amount the patient paid out-of-pocket after applying insurance coverage and manufacturer co-pay assistance.',
    `payer_adjudication_status` STRING COMMENT 'Status of the insurance claim adjudication by the pharmacy benefit manager or payer, indicating whether the claim was approved, denied, or partially approved.. Valid values are `approved|denied|pending|partial_approval`',
    `pharmacy_chain_code` STRING COMMENT 'Code identifying the pharmacy chain or network to which the dispensing pharmacy belongs (e.g., CVS, Walgreens, independent).',
    `pharmacy_name` STRING COMMENT 'Name of the pharmacy or retail location where the co-pay card was redeemed.',
    `pharmacy_npi` STRING COMMENT 'The 10-digit National Provider Identifier of the pharmacy where the redemption occurred. NPI is the unique identifier for healthcare providers in the United States.. Valid values are `^[0-9]{10}$`',
    `prescriber_specialty` STRING COMMENT 'Medical specialty of the prescribing healthcare professional (e.g., oncologist, rheumatologist, endocrinologist).',
    `prescription_number` STRING COMMENT 'Pharmacy-assigned prescription number for the dispensed medication associated with this redemption.',
    `program_utilization_count` STRING COMMENT 'Sequential count of how many times this patient has utilized the co-pay program, used to track adherence and program engagement.',
    `quantity_dispensed` DECIMAL(18,2) COMMENT 'The quantity of drug product dispensed to the patient, measured in the unit appropriate for the dosage form (e.g., tablets, milliliters, grams).',
    `redemption_date` DATE COMMENT 'The date on which the patient redeemed the co-pay card or voucher at the pharmacy. This is the principal business event date for this transaction.',
    `redemption_number` STRING COMMENT 'Externally-known unique transaction number assigned to this redemption event by the co-pay program administrator or pharmacy benefit manager.',
    `redemption_status` STRING COMMENT 'Current lifecycle status of the redemption transaction indicating whether the claim has been submitted, approved, rejected, reversed, or paid.. Valid values are `submitted|approved|rejected|reversed|pending_adjudication|paid`',
    `redemption_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the redemption transaction was processed at the pharmacy point-of-sale or submitted to the pharmacy benefit manager.',
    `rejection_code` STRING COMMENT 'Standard rejection code returned by the pharmacy benefit manager if the claim was denied, indicating the reason for rejection (e.g., prior authorization required, plan limitations exceeded).',
    `retail_price_amount` DECIMAL(18,2) COMMENT 'The full retail price of the prescription before any discounts, insurance, or co-pay assistance.',
    `reversal_date` DATE COMMENT 'Date on which the redemption transaction was reversed, if applicable.',
    `reversal_flag` BOOLEAN COMMENT 'Boolean indicator of whether this redemption transaction has been reversed or voided due to prescription return, billing correction, or other adjustment.',
    `state_province` STRING COMMENT 'State or province where the pharmacy is located and the redemption occurred.',
    `therapeutic_area` STRING COMMENT 'The therapeutic area or disease category for which the dispensed product is indicated (e.g., oncology, immunology, rare diseases).',
    `total_transaction_amount` DECIMAL(18,2) COMMENT 'The total amount paid for the prescription, including patient out-of-pocket, manufacturer contribution, and insurance payment.',
    CONSTRAINT pk_copay_redemption PRIMARY KEY(`copay_redemption_id`)
) COMMENT 'Transactional record of each co-pay card or voucher redemption by a patient at a pharmacy. Captures redemption date, program ID, product NDC, pharmacy NPI, patient out-of-pocket amount, manufacturer contribution amount, payer adjudication status, and gross-to-net impact. Feeds into brand P&L gross-to-net deduction reporting and program utilization tracking.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` (
    `sales_order_id` BIGINT COMMENT 'Primary key for sales_order',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand or product line associated with this order.',
    `brand_plan_id` BIGINT COMMENT 'Reference to the promotional campaign or marketing initiative associated with this order, if applicable.',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Sales orders are placed for specific drug products (formulation, strength, dosage form). A direct sales_order → drug_product FK supports order management, revenue recognition at the drug product level',
    `hco_master_id` BIGINT COMMENT 'Foreign key linking to hcp.hco_master. Business justification: Sales orders in pharma are frequently placed by or shipped to healthcare organizations. Linking to hco_master enables order-to-HCO tracking for institutional account management, 340B compliance verifi',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Sales orders are booked under a specific legal entity for revenue recognition (ASC 606/IFRS 15), VAT determination, and intercompany transfer pricing. A finance expert considers legal_entity_id on sal',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Sales orders for in-licensed or co-promoted products must reference the licensing agreement governing territory rights and commercialization permissions. Order management teams verify licensing agreem',
    `master_id` BIGINT COMMENT 'Reference to the healthcare professional associated with this sales order, if applicable.',
    `patient_enrollment_id` BIGINT COMMENT 'Foreign key linking to patient.patient_enrollment. Business justification: In specialty pharma (oncology, rare disease), sales orders for patient-specific dispensing are tied to a patient enrollment record for hub/specialty pharmacy fulfillment, prior authorization tracking,',
    `payer_contract_id` BIGINT COMMENT 'Foreign key linking to market.market_payer_contract. Business justification: Sales orders to GPOs, PBMs, and hospital systems are executed under payer/channel contracts that govern pricing, rebate eligibility, and terms. Contract compliance reporting and gross-to-net accrual r',
    `pricing_decision_id` BIGINT COMMENT 'Foreign key linking to market.pricing_decision. Business justification: Sales orders are executed at WAC or contract prices established by pricing decisions. Linking sales_order to pricing_decision enables price compliance audits, gross-to-net reconciliation, and IRP (int',
    `address_id` BIGINT COMMENT 'Reference to the billing address for invoicing purposes.',
    `contract_account_id` BIGINT COMMENT 'Reference to the customer or healthcare organization that placed the sales order.',
    `reference_sales_order_id` BIGINT COMMENT 'Self-referencing FK on sales_order (reference_sales_order_id)',
    `sales_rep_id` BIGINT COMMENT 'Reference to the sales representative who facilitated or is credited with this order.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Sales orders in pharma are fulfilled at the SKU level (specific NDC, GTIN, packaging configuration). FK to sku supports order fulfillment, serialization compliance (DSCSA), revenue recognition at the ',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory in which this order was placed.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: Sales orders are TA-segmented for revenue reporting, gross-to-net calculations, and commercial finance reconciliation. sales_order.therapeutic_area is plain text. FK supports TA-level revenue analytic',
    `actual_delivery_date` DATE COMMENT 'The actual date when the order was delivered to the customer location.',
    `cancellation_reason` STRING COMMENT 'Reason provided for order cancellation, if the order status is cancelled.',
    `confirmed_delivery_date` DATE COMMENT 'The date confirmed by logistics for delivery of the order to the customer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order monetary values.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the order, including volume discounts, promotional discounts, and contract-based reductions.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross value of the sales order before any discounts, rebates, or adjustments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales order record was last updated or modified.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net value of the sales order after all discounts, rebates, and taxes have been applied.',
    `order_channel` STRING COMMENT 'The commercial channel or route to market through which the order was placed.',
    `order_date` DATE COMMENT 'The date when the sales order was placed or created by the customer or sales representative.',
    `order_number` STRING COMMENT 'Externally visible unique business identifier for the sales order, used in customer communications and invoicing.',
    `order_source` STRING COMMENT 'The system or channel through which the sales order was originally captured.',
    `order_status` STRING COMMENT 'Current lifecycle status of the sales order in the fulfillment workflow.',
    `order_type` STRING COMMENT 'Classification of the sales order based on its business purpose and regulatory context.',
    `payment_terms` STRING COMMENT 'The agreed payment terms for this sales order, defining when payment is due.',
    `phrma_code_compliant_flag` BOOLEAN COMMENT 'Indicates whether this order and its associated activities comply with PhRMA Code on Interactions with Healthcare Professionals.',
    `priority_level` STRING COMMENT 'The priority classification of the order for fulfillment and shipping purposes.',
    `purchase_order_number` STRING COMMENT 'The purchase order number provided by the customer for their internal procurement tracking.',
    `rebate_amount` DECIMAL(18,2) COMMENT 'Estimated or accrued rebate amount associated with this order, typically for government or managed care contracts.',
    `requested_delivery_date` DATE COMMENT 'The date by which the customer has requested delivery of the order.',
    `return_authorization_number` STRING COMMENT 'Authorization number for product returns associated with this order, if applicable.',
    `sample_distribution_flag` BOOLEAN COMMENT 'Indicates whether this order includes or is exclusively for pharmaceutical sample distribution to healthcare professionals.',
    `shipping_method` STRING COMMENT 'The logistics method used to ship the order, particularly important for temperature-sensitive pharmaceutical products.',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling, storage, or delivery instructions for the order, particularly for controlled substances or temperature-sensitive products.',
    `sunshine_act_reportable_flag` BOOLEAN COMMENT 'Indicates whether this order involves a transfer of value that must be reported under the Physician Payments Sunshine Act transparency requirements.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the order based on applicable tax jurisdictions and rates.',
    CONSTRAINT pk_sales_order PRIMARY KEY(`sales_order_id`)
) COMMENT 'Master reference table for sales_order. Referenced by sales_order_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_hcp_target_id` FOREIGN KEY (`hcp_target_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`hcp_target`(`hcp_target_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_promo_material_id` FOREIGN KEY (`promo_material_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`promo_material`(`promo_material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_call_activity_id` FOREIGN KEY (`call_activity_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`call_activity`(`call_activity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_prior_submission_mlr_review_id` FOREIGN KEY (`prior_submission_mlr_review_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`mlr_review`(`mlr_review_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_promo_material_id` FOREIGN KEY (`promo_material_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`promo_material`(`promo_material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_patient_support_program_id` FOREIGN KEY (`patient_support_program_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`patient_support_program`(`patient_support_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_parent_account_contract_account_id` FOREIGN KEY (`parent_account_contract_account_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`contract_account`(`contract_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_copay_program_id` FOREIGN KEY (`copay_program_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`copay_program`(`copay_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_contract_account_id` FOREIGN KEY (`contract_account_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`contract_account`(`contract_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_reference_sales_order_id` FOREIGN KEY (`reference_sales_order_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_order`(`sales_order_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`commercial` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `pharmaceuticals_ecm`.`commercial` SET TAGS ('dbx_domain' = 'commercial');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `fto_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Fto Analysis Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `indication_id` SET TAGS ('dbx_business_glossary_term' = 'Indication Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `lifecycle_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `masterdata_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Ndc Code Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `molecular_target_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Target Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Market Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Project Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `transfer_price_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `brand_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name (Trade Name)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `brand_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Commercial Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `brand_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|divested|pending_launch');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'DEA Controlled Substance Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'not_scheduled|schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `global_brand_owner` SET TAGS ('dbx_business_glossary_term' = 'Global Brand Owner (Legal Entity)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `global_launch_sequence` SET TAGS ('dbx_business_glossary_term' = 'Global Launch Sequence Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `is_flagship_brand` SET TAGS ('dbx_business_glossary_term' = 'Flagship Brand Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Launch Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Brand Lifecycle Stage');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'pre_launch|launch|growth|mature|loss_of_exclusivity|divested');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `loss_of_exclusivity_date` SET TAGS ('dbx_business_glossary_term' = 'Loss of Exclusivity (LOE) Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `orphan_drug_designation` SET TAGS ('dbx_business_glossary_term' = 'Orphan Drug Designation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `patent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lead Patent Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `pl_cost_center` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Cost Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `primary_competitor_brands` SET TAGS ('dbx_business_glossary_term' = 'Primary Competitor Brands');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `primary_competitor_brands` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'SAP Profit Center');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `rems_required` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Required');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `sample_eligible` SET TAGS ('dbx_business_glossary_term' = 'Sample Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `sap_material_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Material Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `strategy_statement` SET TAGS ('dbx_business_glossary_term' = 'Brand Strategy Statement');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `strategy_statement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `sunshine_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `target_patient_population` SET TAGS ('dbx_business_glossary_term' = 'Target Patient Population');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `veeva_crm_product_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva CRM Product Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `alignment_version` SET TAGS ('dbx_business_glossary_term' = 'Alignment Version');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `alignment_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,30}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `area_code` SET TAGS ('dbx_business_glossary_term' = 'Area Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `brick_count` SET TAGS ('dbx_business_glossary_term' = 'Brick Count');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `call_plan_frequency` SET TAGS ('dbx_business_glossary_term' = 'Call Plan Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `county_list` SET TAGS ('dbx_business_glossary_term' = 'County List');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `crm_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `crm_territory_code` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_-]{1,50}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `decile_rank` SET TAGS ('dbx_business_glossary_term' = 'Decile Rank');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `geographic_area_sq_miles` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area (Square Miles)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `is_open_territory` SET TAGS ('dbx_business_glossary_term' = 'Is Open Territory Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `is_specialty_overlay` SET TAGS ('dbx_business_glossary_term' = 'Is Specialty Overlay Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `last_realignment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Realignment Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `market_potential_index` SET TAGS ('dbx_business_glossary_term' = 'Market Potential Index');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State / Province Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,5}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `sunshine_act_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reporting Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `target_account_count` SET TAGS ('dbx_business_glossary_term' = 'Target Account Count');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `target_hcp_count` SET TAGS ('dbx_business_glossary_term' = 'Target Healthcare Professional (HCP) Count');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Territory Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|archived');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_business_glossary_term' = 'Territory Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `territory_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|specialty|managed_care|key_account');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `urban_rural_classification` SET TAGS ('dbx_business_glossary_term' = 'Urban / Rural Classification');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `urban_rural_classification` SET TAGS ('dbx_value_regex' = 'urban|suburban|rural|mixed');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `workload_index` SET TAGS ('dbx_business_glossary_term' = 'Workload Index');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `zip_code_list` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code List');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `zip_code_list` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `zip_code_list` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Assignment - Territory Id');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `annual_call_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Call Target');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `call_plan_frequency_target` SET TAGS ('dbx_business_glossary_term' = 'Call Plan Frequency Target');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|terminated|suspended|pending_start');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `gcp_certified` SET TAGS ('dbx_business_glossary_term' = 'Good Clinical Practice (GCP) Certified');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `hcp_engagement_tier` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Engagement Tier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `hcp_engagement_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `product_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Product Certification Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `product_certification_status` SET TAGS ('dbx_value_regex' = 'certified|in_progress|expired|not_started');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `rep_role` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Role');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `rep_role` SET TAGS ('dbx_value_regex' = 'territory_manager|specialty_rep|key_account_manager|medical_science_liaison|managed_care_specialist|national_account_manager');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `sample_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Authorization Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `sample_authorization_status` SET TAGS ('dbx_value_regex' = 'authorized|suspended|revoked|pending');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `speaker_program_eligible` SET TAGS ('dbx_business_glossary_term' = 'Speaker Program Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `state_province_code` SET TAGS ('dbx_business_glossary_term' = 'State / Province Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `state_province_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `sunshine_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `veeva_crm_user_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva CRM User ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `veeva_crm_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `veeva_crm_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `veeva_promomats_access` SET TAGS ('dbx_business_glossary_term' = 'Veeva PromoMats Access Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Work Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `work_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `hcp_target_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Target ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `brand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `formulary_position_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Position Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|withdrawn');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `call_type_mix_pct_f2f` SET TAGS ('dbx_business_glossary_term' = 'Face-to-Face (F2F) Call Type Mix Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `competitor_prescriber` SET TAGS ('dbx_business_glossary_term' = 'Competitor Prescriber Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `current_brand_prescriber` SET TAGS ('dbx_business_glossary_term' = 'Current Brand Prescriber Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `cycle_call_count` SET TAGS ('dbx_business_glossary_term' = 'Cycle Call Count');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `do_not_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Contact (DNC) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `engagement_channel_preference` SET TAGS ('dbx_business_glossary_term' = 'Engagement Channel Preference');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `engagement_channel_preference` SET TAGS ('dbx_value_regex' = 'face_to_face|remote|email|hybrid|no_preference');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `is_kol` SET TAGS ('dbx_business_glossary_term' = 'Key Opinion Leader (KOL) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `is_sample_eligible` SET TAGS ('dbx_business_glossary_term' = 'Sample Distribution Eligibility Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `is_speaker_eligible` SET TAGS ('dbx_business_glossary_term' = 'Speaker Program Eligibility Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `last_detail_date` SET TAGS ('dbx_business_glossary_term' = 'Last Detail Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `market_potential_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Potential Segment');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `market_potential_segment` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `planned_call_frequency` SET TAGS ('dbx_business_glossary_term' = 'Planned Call Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `planned_f2f_calls` SET TAGS ('dbx_business_glossary_term' = 'Planned Face-to-Face (F2F) Call Count');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `planned_remote_calls` SET TAGS ('dbx_business_glossary_term' = 'Planned Remote Call Count');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `prescribing_potential_decile` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Potential Decile');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `specialty_segment` SET TAGS ('dbx_business_glossary_term' = 'Specialty Segment');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `sunshine_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `target_record_number` SET TAGS ('dbx_business_glossary_term' = 'Target Record Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `target_tier` SET TAGS ('dbx_business_glossary_term' = 'Target Tier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `target_tier` SET TAGS ('dbx_value_regex' = 'A|B|C|D');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `targeting_rationale` SET TAGS ('dbx_business_glossary_term' = 'Targeting Rationale');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `targeting_status` SET TAGS ('dbx_business_glossary_term' = 'Targeting Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `targeting_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|removed');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `veeva_crm_record_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva CRM Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `ytd_call_count` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Call Count');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `call_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Call Activity ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Detailed Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Organization (HCO) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `hcp_target_id` SET TAGS ('dbx_business_glossary_term' = 'Hcp Target Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `investigational_site_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `promo_material_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Material ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `call_date` SET TAGS ('dbx_business_glossary_term' = 'Call Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `call_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Call End Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `call_notes` SET TAGS ('dbx_business_glossary_term' = 'Call Notes');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `call_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `call_objective` SET TAGS ('dbx_business_glossary_term' = 'Call Objective');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `call_outcome` SET TAGS ('dbx_business_glossary_term' = 'Call Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `call_outcome` SET TAGS ('dbx_value_regex' = 'completed|no_see|left_message|gatekeeper_only|cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `call_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Call Start Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `call_status` SET TAGS ('dbx_business_glossary_term' = 'Call Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `call_status` SET TAGS ('dbx_value_regex' = 'planned|submitted|approved|rejected|cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `call_type` SET TAGS ('dbx_business_glossary_term' = 'Call Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `call_type` SET TAGS ('dbx_value_regex' = 'face_to_face|remote_video|phone|email|congress|group_meeting');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `channel_mix_code` SET TAGS ('dbx_business_glossary_term' = 'Channel Mix Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `channel_mix_code` SET TAGS ('dbx_value_regex' = 'field|inside_sales|digital|hybrid');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `crm_sync_timestamp` SET TAGS ('dbx_business_glossary_term' = 'CRM Synchronization Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `detail_priority_1_product` SET TAGS ('dbx_business_glossary_term' = 'First Position Detail Product Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `detail_priority_2_product` SET TAGS ('dbx_business_glossary_term' = 'Second Position Detail Product Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `detail_priority_3_product` SET TAGS ('dbx_business_glossary_term' = 'Third Position Detail Product Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `hcp_reaction` SET TAGS ('dbx_business_glossary_term' = 'HCP Reaction');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `hcp_reaction` SET TAGS ('dbx_value_regex' = 'very_positive|positive|neutral|negative|very_negative');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `kol_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Opinion Leader (KOL) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `meal_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Meal Cost (USD)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `meal_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Meal Provided Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `next_best_action` SET TAGS ('dbx_business_glossary_term' = 'Next Best Action');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `off_label_discussion_flag` SET TAGS ('dbx_business_glossary_term' = 'Off-Label Discussion Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `off_label_discussion_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `phrma_code_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'PhRMA Code Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `promo_material_version` SET TAGS ('dbx_business_glossary_term' = 'Promotional Material Version');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `sample_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Lot Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `sample_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sample Quantity Distributed');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `samples_dropped_flag` SET TAGS ('dbx_business_glossary_term' = 'Samples Dropped Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `signature_captured_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `speaker_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Speaker Program Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Call Submitted Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `sunshine_act_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `transfer_of_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Transfer of Value Amount (USD)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `veeva_call_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva CRM Call ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `sample_management_id` SET TAGS ('dbx_business_glossary_term' = 'Sample Management Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `call_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Call Activity ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `consent_record_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `formulary_position_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Position Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `license_id` SET TAGS ('dbx_business_glossary_term' = 'License Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Material Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment Reason');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `discrepancy_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Discrepancy Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `hcp_dea_number` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Drug Enforcement Administration (DEA) Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `hcp_dea_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `hcp_dea_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `hcp_signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Signature Captured');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `hcp_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Signature Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `inventory_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Inventory Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `inventory_number` SET TAGS ('dbx_value_regex' = '^SINV-[0-9]{8,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Inventory Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|reconciled|closed|suspended|pending_review');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Package Size');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `pdma_compliant` SET TAGS ('dbx_business_glossary_term' = 'Prescription Drug Marketing Act (PDMA) Compliant Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `quantity_adjusted` SET TAGS ('dbx_business_glossary_term' = 'Quantity Adjusted');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `quantity_disbursed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Disbursed');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `reconciliation_period` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `reconciliation_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-Q[1-4]$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|discrepancy_identified|resolved');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `sample_form_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Dosage Form Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `sample_request_form_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Request Form Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'veeva_crm|sap_mm|salesforce_health_cloud|manual_entry');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Sample Storage Condition');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'room_temperature|refrigerated|frozen|controlled_room_temperature|protect_from_light');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Sample Product Strength');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `sunshine_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Transaction Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sample Transaction Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Sample Transaction Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `promo_material_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Material ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `brand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `indication_id` SET TAGS ('dbx_business_glossary_term' = 'Indication Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `labeling_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Market Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `aggregate_decision` SET TAGS ('dbx_business_glossary_term' = 'Aggregate MLR Decision');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `aggregate_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_changes|rejected|pending');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'MLR Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Medical-Legal-Regulatory (MLR) Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `content_owner` SET TAGS ('dbx_business_glossary_term' = 'Content Owner');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Material Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `fair_balance_included` SET TAGS ('dbx_business_glossary_term' = 'Fair Balance Included Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `isi_included` SET TAGS ('dbx_business_glossary_term' = 'Important Safety Information (ISI) Included Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `last_resubmission_date` SET TAGS ('dbx_business_glossary_term' = 'Last Resubmission Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `legal_decision` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Decision');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `legal_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_changes|rejected|pending');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `legal_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Promotional Material Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Promotional Material Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `medical_decision` SET TAGS ('dbx_business_glossary_term' = 'Medical Reviewer Decision');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `medical_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_changes|rejected|pending');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `medical_decision` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `medical_decision` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `medical_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Medical Reviewer Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `medical_reviewer` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `medical_reviewer` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `mlr_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Medical-Legal-Regulatory (MLR) Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `pi_reference_included` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Information (PI) Reference Included Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `regulatory_decision` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Affairs Reviewer Decision');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `regulatory_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_changes|rejected|pending');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `regulatory_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Affairs Reviewer Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `resubmission_count` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Count');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'MLR Review Comments');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `review_cycle_number` SET TAGS ('dbx_business_glossary_term' = 'MLR Review Cycle Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `sample_piece` SET TAGS ('dbx_business_glossary_term' = 'Sample Piece Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `sunshine_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `target_audience` SET TAGS ('dbx_value_regex' = 'hcp|patient|payer|internal|kol|pharmacist');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Promotional Material Title');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `vault_document_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `version_lineage` SET TAGS ('dbx_business_glossary_term' = 'Version Lineage');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Material Version Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Material Withdrawal Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Material Withdrawal Reason');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_value_regex' = 'label_update|safety_update|voluntary_withdrawal|expired|superseded|regulatory_request');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `mlr_review_id` SET TAGS ('dbx_business_glossary_term' = 'Medical-Legal-Regulatory (MLR) Review ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `brand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Change Control Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `labeling_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `prior_submission_mlr_review_id` SET TAGS ('dbx_business_glossary_term' = 'Prior MLR Submission ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `promo_material_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Material ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'MLR Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `approval_decision` SET TAGS ('dbx_business_glossary_term' = 'MLR Approval Decision');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `approval_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_changes|rejected|withdrawn');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'print|digital|rep_delivered|congress|direct_mail|email_broadcast');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'MLR Approval Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `fair_balance_verified` SET TAGS ('dbx_business_glossary_term' = 'Fair Balance Verification Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `legal_review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|approved_with_changes|rejected');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `medical_review_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Review Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `medical_review_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `medical_review_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `medical_review_status` SET TAGS ('dbx_business_glossary_term' = 'Medical Review Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `medical_review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|approved_with_changes|rejected');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `medical_review_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `medical_review_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `phrama_code_compliant` SET TAGS ('dbx_business_glossary_term' = 'PhRMA Code Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_value_regex' = 'FDA|EMA|MHRA|PMDA|NMPA|WHO');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `regulatory_review_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_value_regex' = 'pending|in_review|approved|approved_with_changes|rejected');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `resubmission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Deadline');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `review_comments` SET TAGS ('dbx_business_glossary_term' = 'MLR Review Comments');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `review_cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'MLR Review Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'MLR Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'MLR Submission Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `submission_number` SET TAGS ('dbx_value_regex' = '^MLR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `sunshine_act_applicable` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Applicability Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `veeva_vault_doc_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `brand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Plan ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `indication_id` SET TAGS ('dbx_business_glossary_term' = 'Indication Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Profit Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `molecular_target_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Target Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `pricing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Decision Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `transfer_price_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `value_dossier_id` SET TAGS ('dbx_business_glossary_term' = 'Value Dossier Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `brand_positioning` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Statement');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `budget_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `channel_strategy` SET TAGS ('dbx_business_glossary_term' = 'Channel Strategy');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `competitive_landscape` SET TAGS ('dbx_business_glossary_term' = 'Competitive Landscape Summary');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `launch_phase` SET TAGS ('dbx_business_glossary_term' = 'Product Launch Phase');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `launch_phase` SET TAGS ('dbx_value_regex' = 'pre_launch|launch|post_launch|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `market_share_target` SET TAGS ('dbx_business_glossary_term' = 'Market Share Target Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `market_share_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Brand Plan Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Plan Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Brand Plan Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|on_hold|closed');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Brand Plan Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual|multi_year|launch|lifecycle_management|indication_expansion|line_extension');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `prescription_volume_target` SET TAGS ('dbx_business_glossary_term' = 'Prescription Volume Target');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `prescription_volume_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `promotional_mix_strategy` SET TAGS ('dbx_business_glossary_term' = 'Promotional Mix Strategy');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `regulatory_approval_dependency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Dependency');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `revenue_target` SET TAGS ('dbx_business_glossary_term' = 'Revenue Target');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `revenue_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `strategic_objective` SET TAGS ('dbx_business_glossary_term' = 'Strategic Objective');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `target_hcp_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Healthcare Professional (HCP) Segment');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `target_patient_population` SET TAGS ('dbx_business_glossary_term' = 'Target Patient Population');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` SET TAGS ('dbx_subdomain' = 'brand_strategy');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `kol_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Key Opinion Leader (KOL) Engagement ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `brand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `candidate_nomination_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate Nomination Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `indication_id` SET TAGS ('dbx_business_glossary_term' = 'Indication Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `kol_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Hcp Kol Profile Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `molecular_target_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Target Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `payer_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Engagement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Project Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `advisory_board_name` SET TAGS ('dbx_business_glossary_term' = 'Advisory Board Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `compliance_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `compliance_approver` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approver');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `congress_name` SET TAGS ('dbx_business_glossary_term' = 'Congress Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `engagement_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Engagement Duration Hours');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `engagement_location` SET TAGS ('dbx_business_glossary_term' = 'Engagement Location');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|completed|cancelled|pending_approval');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `engagement_topic` SET TAGS ('dbx_business_glossary_term' = 'Engagement Topic');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_value_regex' = 'advisory_board|speaker_training|publication_review|congress_presentation|consulting|investigator_meeting');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `fair_market_value_assessment` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV) Assessment');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `fair_market_value_assessment` SET TAGS ('dbx_value_regex' = 'compliant|under_review|non_compliant|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `honorarium_amount` SET TAGS ('dbx_business_glossary_term' = 'Honorarium Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `honorarium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `honorarium_currency` SET TAGS ('dbx_business_glossary_term' = 'Honorarium Currency');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `honorarium_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Engagement Notes');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `publication_title` SET TAGS ('dbx_business_glossary_term' = 'Publication Title');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `strategic_relationship_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Relationship Tier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `strategic_relationship_tier` SET TAGS ('dbx_value_regex' = 'tier_1_national|tier_2_regional|tier_3_local|emerging');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `transparency_report_date` SET TAGS ('dbx_business_glossary_term' = 'Transparency Report Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `transparency_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Transparency Reporting Required');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `veeva_crm_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva Customer Relationship Management (CRM) Activity ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` SET TAGS ('dbx_subdomain' = 'patient_affordability');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `patient_support_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Support Program (PSP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `brand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `indication_id` SET TAGS ('dbx_business_glossary_term' = 'Indication Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `patient_access_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `active_enrolled_patients` SET TAGS ('dbx_business_glossary_term' = 'Active Enrolled Patients');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `adherence_rate_actual` SET TAGS ('dbx_business_glossary_term' = 'Adherence Rate Actual');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `adherence_rate_target` SET TAGS ('dbx_business_glossary_term' = 'Adherence Rate Target');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `benefit_type` SET TAGS ('dbx_value_regex' = 'co-pay card|free drug voucher|nurse support|reimbursement assistance|prior authorization support|patient education materials');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `cost_per_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Enrollment');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'hcp referral|patient direct|pharmacy|call center|web portal|mobile app');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `hipaa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Compliant Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `income_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Income Threshold Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `income_threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Income Threshold Currency');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `income_threshold_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Program Launch Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `max_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `max_benefit_currency` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Currency');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `max_benefit_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `program_budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Currency');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `program_budget_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending launch|terminated');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|not required|conditional');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Program Termination Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `total_enrolled_patients` SET TAGS ('dbx_business_glossary_term' = 'Total Enrolled Patients');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `transparency_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Transparency Reporting Required');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `vendor_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Score');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` SET TAGS ('dbx_subdomain' = 'patient_affordability');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `psp_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Support Program (PSP) Enrollment ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `clinical_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Enrollment Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Hco Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `patient_access_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Reference ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `patient_support_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Support Program (PSP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `administering_vendor` SET TAGS ('dbx_business_glossary_term' = 'Administering Vendor');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `benefit_currency` SET TAGS ('dbx_business_glossary_term' = 'Benefit Currency');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `benefit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `benefit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit End Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `benefit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `benefit_type` SET TAGS ('dbx_value_regex' = 'copay_card|free_drug_voucher|nurse_support|patient_education|financial_assistance|adherence_coaching');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `consent_obtained_flag` SET TAGS ('dbx_business_glossary_term' = 'Consent Obtained Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `eligibility_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `eligibility_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verification Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `eligibility_verification_status` SET TAGS ('dbx_value_regex' = 'not_verified|verified|failed|pending|waived');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'hcp_referral|patient_direct|call_center|web_portal|mobile_app|field_representative');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `enrollment_source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `enrollment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source System');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|completed|cancelled|denied');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `exit_date` SET TAGS ('dbx_business_glossary_term' = 'Program Exit Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `exit_reason` SET TAGS ('dbx_business_glossary_term' = 'Program Exit Reason');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `exit_reason` SET TAGS ('dbx_value_regex' = 'benefit_exhausted|patient_request|treatment_discontinued|insurance_change|program_ended|non_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Indication');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `indication` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `max_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `prescribing_npi` SET TAGS ('dbx_business_glossary_term' = 'Prescribing National Provider Identifier (NPI)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `prescribing_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `remaining_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Benefit Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `transparency_report_date` SET TAGS ('dbx_business_glossary_term' = 'Transparency Report Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `transparency_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Transparency Reporting Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` SET TAGS ('dbx_subdomain' = 'market_access');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `contract_account_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Account Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Hco Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `parent_account_contract_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Account Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Market Payer Contract Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|closed');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'hospital_system|idn|gpo|specialty_pharmacy|retail_pharmacy_chain|clinic_network');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `annual_revenue_potential` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Potential');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `annual_revenue_potential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `contract_tier` SET TAGS ('dbx_business_glossary_term' = 'Contract Tier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `contract_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `credit_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Currency');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `credit_limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `dea_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `dea_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `dea_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `gpo_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Group Purchasing Organization (GPO) Affiliation');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `hin_number` SET TAGS ('dbx_business_glossary_term' = 'Health Industry Number (HIN)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `hin_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|net_90|due_on_receipt|2_10_net_30');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Line 1');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Line 2');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_city` SET TAGS ('dbx_business_glossary_term' = 'Shipping City');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Postal Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_business_glossary_term' = 'Shipping State or Province');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `strategic_classification` SET TAGS ('dbx_business_glossary_term' = 'Strategic Classification');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `strategic_classification` SET TAGS ('dbx_value_regex' = 'tier_1_strategic|tier_2_key|tier_3_standard|tier_4_emerging');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` SET TAGS ('dbx_subdomain' = 'market_access');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `sales_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Performance ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `brand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `formulary_position_id` SET TAGS ('dbx_business_glossary_term' = 'Market Formulary Position Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Profit Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Account Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `actual_performance_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Performance Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `call_attainment_percent` SET TAGS ('dbx_business_glossary_term' = 'Call Attainment Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `call_frequency_achieved` SET TAGS ('dbx_business_glossary_term' = 'Call Frequency Achieved');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `call_frequency_target` SET TAGS ('dbx_business_glossary_term' = 'Call Frequency Target');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'veeva_crm|iqvia|symphony_health|internal_calculation|manual_entry');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `incentive_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Compensation Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `incentive_compensation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `incentive_compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Incentive Compensation Currency');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `incentive_compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `incentive_compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `incentive_compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `market_share_percent` SET TAGS ('dbx_business_glossary_term' = 'Market Share Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `new_prescriptions` SET TAGS ('dbx_business_glossary_term' = 'New Prescriptions (NRx)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `performance_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period End Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `performance_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `performance_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `performance_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|finalized|disputed');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|annual');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Quota Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `quota_attainment_percent` SET TAGS ('dbx_business_glossary_term' = 'Quota Attainment Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `quota_currency` SET TAGS ('dbx_business_glossary_term' = 'Quota Currency');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `quota_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `sample_drop_rate` SET TAGS ('dbx_business_glossary_term' = 'Sample Drop Rate');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `sample_units_distributed` SET TAGS ('dbx_business_glossary_term' = 'Sample Units Distributed');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `total_prescriptions` SET TAGS ('dbx_business_glossary_term' = 'Total Prescriptions (TRx)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `veeva_crm_record_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva CRM Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` SET TAGS ('dbx_subdomain' = 'patient_affordability');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `copay_program_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Pay Program Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `brand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `indication_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `patient_access_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `reimbursement_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Policy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `active_enrolled_patients` SET TAGS ('dbx_business_glossary_term' = 'Active Enrolled Patients');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `commercial_insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Insurance Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `compliance_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'approved|pending_review|rejected|not_required');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `exclusion_340b_flag` SET TAGS ('dbx_business_glossary_term' = '340B Program Exclusion Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `exclusion_government_payer_flag` SET TAGS ('dbx_business_glossary_term' = 'Government Payer Exclusion Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `gross_to_net_category` SET TAGS ('dbx_business_glossary_term' = 'Gross-to-Net (GTN) Category');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Program Launch Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `max_annual_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Annual Benefit Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `max_benefit_per_prescription` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Per Prescription');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `max_benefit_per_prescription` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `max_benefit_per_prescription` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `program_owner` SET TAGS ('dbx_business_glossary_term' = 'Program Owner');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_launch|terminated');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'copay_card|voucher|free_trial|instant_savings|rebate|patient_assistance');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Program Termination Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `total_enrolled_patients` SET TAGS ('dbx_business_glossary_term' = 'Total Enrolled Patients');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `total_redemptions_count` SET TAGS ('dbx_business_glossary_term' = 'Total Redemptions Count');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `transparency_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Transparency Reporting Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `veeva_crm_record_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva Customer Relationship Management (CRM) Record Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` SET TAGS ('dbx_subdomain' = 'patient_affordability');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `copay_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Pay Redemption ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `copay_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Support Program ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `indication_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `gross_to_net_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Gross To Net Adjustment Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `days_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Supply');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `insurance_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Paid Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `patient_out_of_pocket_amount` SET TAGS ('dbx_business_glossary_term' = 'Patient Out-of-Pocket Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `payer_adjudication_status` SET TAGS ('dbx_business_glossary_term' = 'Payer Adjudication Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `payer_adjudication_status` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|partial_approval');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `pharmacy_chain_code` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Chain Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `pharmacy_name` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `pharmacy_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `pharmacy_npi` SET TAGS ('dbx_business_glossary_term' = 'Pharmacy National Provider Identifier (NPI)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `pharmacy_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `pharmacy_npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `prescriber_specialty` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Specialty');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `prescription_number` SET TAGS ('dbx_business_glossary_term' = 'Prescription Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `prescription_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `prescription_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `program_utilization_count` SET TAGS ('dbx_business_glossary_term' = 'Program Utilization Count');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `quantity_dispensed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Dispensed');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `redemption_date` SET TAGS ('dbx_business_glossary_term' = 'Redemption Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `redemption_number` SET TAGS ('dbx_business_glossary_term' = 'Redemption Transaction Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_business_glossary_term' = 'Redemption Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `redemption_status` SET TAGS ('dbx_value_regex' = 'submitted|approved|rejected|reversed|pending_adjudication|paid');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `redemption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Redemption Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `rejection_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `retail_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Retail Price Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `total_transaction_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Transaction Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` SET TAGS ('dbx_subdomain' = 'market_access');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Hco Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `patient_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Enrollment Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Market Payer Contract Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `pricing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Decision Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `reference_sales_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
