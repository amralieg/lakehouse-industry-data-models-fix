-- Schema for Domain: commercial | Business: Pharmaceuticals | Version: v1_ecm
-- Generated on: 2026-05-05 17:50:33

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`commercial` COMMENT 'Handles commercial operations including sales force management, healthcare professional (HCP) engagement, key opinion leader (KOL) relationships, promotional materials (Veeva PromoMats), territory management, product launch activities, sample distribution, and speaker programs. Integrates with Veeva CRM and Salesforce Health Cloud. Manages compliance with promotional regulations, PhRMA code, and Sunshine Act transparency reporting. Supports brand performance tracking and P&L reporting by brand.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`brand` (
    `brand_id` BIGINT COMMENT 'Unique surrogate identifier for the pharmaceutical brand record in the commercial data product. Primary key for all brand-level analytics, P&L reporting, and commercial activity linkage.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Market access strategies are developed per brand to define formulary positioning, pricing, and payer engagement plans. Core market access planning process requires linking brand to its access strategy',
    `affairs_plan_id` BIGINT COMMENT 'Foreign key linking to medical.medical_affairs_plan. Business justification: Brand commercial strategy must align with medical affairs evidence generation plan, publication roadmap, and scientific platform development for the same compound/indication. Critical for launch readi',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Brand-level budgets track promotional spend, sample distribution, speaker programs. Core commercial finance control for brand P&L management and variance analysis.',
    `compound_id` BIGINT COMMENT 'Foreign key linking to discovery.compound. Business justification: Brands are developed from specific discovery compounds that become the active pharmaceutical ingredient. Required for regulatory submissions (NDA/BLA compound linkage), patent lifecycle management, an',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Brands are often marketed at specific drug product level (strength/dosage form). Sample management, call detailing, and promotional activities operate at drug product granularity. Real business proces',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Brands benefit from regulatory exclusivity (orphan, pediatric, data); commercial forecasting, LOE planning, and pricing strategy require direct exclusivity linkage.',
    `hta_submission_id` BIGINT COMMENT 'Foreign key linking to market.hta_submission. Business justification: HTA submissions are made for specific brands to gain reimbursement approval from health technology assessment bodies. Regulatory/market access requirement links brand to primary HTA submission for tra',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Brands are owned/marketed by specific legal entities. Required for financial consolidation, regulatory submissions (NDA/BLA ownership attribution), transfer pricing, P&L reporting by legal entity, and',
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: Brands map to ATC therapeutic classification. Essential for regulatory submissions, formulary positioning, market access dossiers, competitive intelligence, and HTA submissions requiring standardized ',
    `masterdata_ndc_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.ndc_code. Business justification: Brands have associated NDC codes for US market identification. Required for distribution, pricing submissions to CMS, Medicaid rebate calculations, 340B program compliance, and chargeback processing.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Brands are commercial identities of medicinal products. Brand performance reporting, promotional planning, sales tracking, and launch planning all require linking brand to underlying medicinal product',
    `molecular_target_id` BIGINT COMMENT 'Foreign key linking to discovery.molecular_target. Business justification: Brands mechanism of action is defined by the molecular target validated in discovery. Required for medical affairs content generation, competitive positioning, label claims, promotional material accu',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent_family. Business justification: Brands are covered by patent families; portfolio management, global launch sequencing, and IP strategy require patent family linkage for comprehensive protection view.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Brands are protected by patents; lifecycle management, loss of exclusivity planning, and regulatory strategy require direct patent linkage. Essential for commercial planning in pharmaceuticals.',
    `pricing_decision_id` BIGINT COMMENT 'Foreign key linking to market.pricing_decision. Business justification: Pricing decisions set list prices (WAC) and net prices for brands by market. Fundamental commercial strategy linking brand to primary pricing decision for tracking price positioning and changes.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Brands require assignment to compliance programs (promotional compliance, GxP) for regulatory oversight. Essential for compliance reporting, inspection readiness, and program-level risk management in ',
    `project_id` BIGINT COMMENT 'Foreign key linking to discovery.discovery_project. Business justification: Brands originate from specific discovery projects that identified and advanced the molecule through preclinical development. Required for portfolio tracking, asset genealogy, investment return analysi',
    `royalty_agreement_id` BIGINT COMMENT 'Foreign key linking to finance.royalty_agreement. Business justification: Brands may be licensed-in products requiring royalty payments on net sales. Links brand revenue to royalty obligations for accurate gross-to-net and payment calculations.',
    `sourcing_material_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_material. Business justification: Brand manufacturing requires specific sourced APIs and excipients. Procurement teams source materials for brand-specific formulations. Links brand planning to material availability, lead times, and su',
    `trademark_id` BIGINT COMMENT 'Foreign key linking to intellectual.trademark. Business justification: Brand names are registered trademarks; legal protection, brand strategy, and market exclusivity depend on trademark registration. Core IP protection for commercial brands.',
    `brand_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the brand across commercial systems including Veeva CRM, SAP SD, and Salesforce Health Cloud. Used as the business key for cross-system reconciliation and reporting.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `brand_name` STRING COMMENT 'The proprietary trade name of the pharmaceutical product as approved by the regulatory authority (e.g., FDA, EMA) and used in commercial promotion, packaging, and market-facing communications.',
    `brand_status` STRING COMMENT 'Current operational status of the brand within the commercial organization. Controls whether the brand is eligible for promotional spend, sales force detailing, and market access activities.. Valid values are `active|inactive|discontinued|divested|pending_launch`',
    `controlled_substance_schedule` STRING COMMENT 'The DEA controlled substance schedule classification for the brand, if applicable. Determines distribution controls, sample restrictions, and reporting obligations under the Controlled Substances Act. not_scheduled for non-controlled products.. Valid values are `not_scheduled|schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the brand master record was first created in the commercial data platform. Supports audit trail requirements under 21 CFR Part 11 and SOX data governance controls.',
    `global_brand_owner` STRING COMMENT 'The legal entity name of the global brand owner responsible for the NDA/BLA/MAA and global P&L accountability. Relevant for intercompany transfer pricing, royalty agreements, and IP ownership tracking.',
    `global_launch_sequence` STRING COMMENT 'Numeric sequence indicating the order in which this brand was launched globally relative to other brands in the portfolio. Used for portfolio prioritization, resource allocation, and launch excellence benchmarking.',
    `indication` STRING COMMENT 'The primary approved therapeutic indication for which the brand is commercially promoted, as stated in the approved product label (prescribing information / SmPC). Multiple indications may exist; this captures the lead commercial indication.',
    `is_flagship_brand` BOOLEAN COMMENT 'Indicates whether this brand is designated as a flagship or priority brand by commercial leadership, warranting elevated promotional investment, dedicated sales force, and executive-level performance reporting.',
    `launch_date` DATE COMMENT 'The date on which the brand was first commercially available in its primary market following regulatory approval. Used as the anchor date for launch performance tracking, market share ramp analysis, and P&L reporting.',
    `lifecycle_stage` STRING COMMENT 'Current stage of the brand in its commercial lifecycle. Drives resource allocation, promotional investment levels, and strategic planning. Loss of exclusivity (LOE) stage triggers biosimilar/generic competition response planning.. Valid values are `pre_launch|launch|growth|mature|loss_of_exclusivity|divested`',
    `loss_of_exclusivity_date` DATE COMMENT 'The projected or confirmed date on which the brands market exclusivity expires, enabling generic or biosimilar competition. Critical for long-range financial planning, patent strategy, and lifecycle management decisions.',
    `orphan_drug_designation` BOOLEAN COMMENT 'Indicates whether the brand has received Orphan Drug Designation from the FDA (ODD) or EMA (OMP), conferring 7-year US market exclusivity, 10-year EU exclusivity, and tax incentives. Affects pricing strategy and market access negotiations.',
    `patent_expiry_date` DATE COMMENT 'The expiry date of the primary composition-of-matter or method-of-use patent protecting the brand. Distinct from LOE date as patent term extensions (PTE) and data exclusivity may extend commercial protection beyond patent expiry.',
    `pl_cost_center` STRING COMMENT 'The SAP cost center code to which all brand-level revenues, promotional spend, and COGS are allocated for P&L reporting. Enables brand-level financial performance tracking and budget variance analysis.',
    `primary_competitor_brands` STRING COMMENT 'Comma-separated list of key competitor brand names in the same therapeutic class. Used for competitive intelligence, market share benchmarking, and sales force training. Classified as confidential competitive intelligence.',
    `primary_market` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the brands primary commercial market (e.g., USA, GBR, DEU). Determines the lead regulatory authority, pricing reference, and commercial reporting currency.. Valid values are `^[A-Z]{3}$`',
    `profit_center` STRING COMMENT 'The SAP profit center assigned to the brand for internal management accounting and brand-level P&L reporting. Distinct from cost center; used for contribution margin analysis and brand portfolio performance reporting.',
    `rems_required` BOOLEAN COMMENT 'Indicates whether the FDA has mandated a Risk Evaluation and Mitigation Strategy (REMS) for this brand due to serious safety risks. REMS programs impose specific distribution, prescribing, and patient monitoring requirements that affect commercial operations.',
    `sample_eligible` BOOLEAN COMMENT 'Indicates whether the brand is eligible for distribution of drug samples to healthcare professionals (HCPs) by the sales force. Controlled by PDMA regulations and PhRMA code. DEA scheduled products and REMS products may have restrictions.',
    `sap_material_number` STRING COMMENT 'The SAP material master number assigned to the brands primary commercial SKU in SAP S/4HANA MM/SD modules. Used for order management, COGS tracking, and supply chain integration.',
    `strategy_statement` STRING COMMENT 'The overarching commercial strategy statement for the brand, capturing positioning, differentiation, and value proposition relative to competitors. Classified as confidential business strategy. Sourced from the brand plan approved by commercial leadership.',
    `sunshine_act_reportable` BOOLEAN COMMENT 'Indicates whether transfers of value associated with this brand (samples, speaker fees, meals, educational grants) are subject to Open Payments (Sunshine Act) reporting to CMS. Drives compliance workflows in Veeva CRM and SAP.',
    `target_patient_population` STRING COMMENT 'Description of the intended patient population for the brand, including disease stage, biomarker status, prior treatment history, and demographic criteria. Informs HCP targeting, patient support program design, and HEOR value dossier development.',
    `therapeutic_area` STRING COMMENT 'The primary therapeutic area in which the brand competes (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular, Neuroscience). Drives brand strategy, portfolio allocation, and P&L segmentation. [ENUM-REF-CANDIDATE: oncology|immunology|rare_diseases|cardiovascular|neuroscience|infectious_diseases|metabolic|respiratory|hematology|dermatology — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to the brand master record. Used for change data capture (CDC) in the Databricks Silver layer pipeline and audit trail compliance under 21 CFR Part 11.',
    `veeva_crm_product_code` STRING COMMENT 'The product identifier assigned to this brand in Veeva CRM (Salesforce Health Cloud), used to link brand records to HCP call activity, sample transactions, promotional material approvals (PromoMats), and speaker program events.',
    CONSTRAINT pk_brand PRIMARY KEY(`brand_id`)
) COMMENT 'Master record for each pharmaceutical brand managed by the commercial organization. Captures brand identity, therapeutic area, lifecycle stage (pre-launch, launch, growth, mature, LOE), brand strategy, target patient population, approved indications, ATC classification, INN/USAN, and P&L ownership. Serves as the commercial anchor entity linking all brand-level activities, performance tracking, promotional spend, and market share measurement.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`territory` (
    `territory_id` BIGINT COMMENT 'Unique surrogate identifier for the sales territory record in the Databricks Silver Layer. Primary key for the territory data product.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Territory budgets control field force spending on samples, speaker programs, promotional activities. Standard commercial operations budget allocation and variance tracking.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Territories operate within specific countries with distinct regulatory frameworks. Required for country-specific promotional compliance (PhRMA/EFPIA codes), market segmentation, regional performance r',
    `district_id` BIGINT COMMENT 'FK to commercial.district',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Territories are cost centers for budgeting and expense allocation. Required for promotional spend tracking, sales rep expense allocation, budget vs. actual reporting, and commercial operations P&L by ',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Territories are aligned to patented products; sales planning, quota setting, and resource allocation require patent/exclusivity awareness for strategic territory design.',
    `brand_id` BIGINT COMMENT 'FK to commercial.brand',
    `region_id` BIGINT COMMENT 'FK to commercial.region',
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
    `therapeutic_area` STRING COMMENT 'Primary therapeutic area focus of the territory (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular). Determines which product portfolio the territorys field representatives promote and which HCPs are targeted. [ENUM-REF-CANDIDATE: oncology|immunology|rare_diseases|cardiovascular|neuroscience|infectious_disease|respiratory|other — promote to reference product]',
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
    `district_id` BIGINT COMMENT 'Identifier of the sales district to which this representatives territory belongs. Districts aggregate multiple territories under a District Manager. Used for mid-level performance roll-up and quota management.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Sales reps are assigned to cost centers for expense tracking and budget allocation. Required for headcount planning, promotional spend allocation, IC plan administration, and commercial operations P&L',
    `employee_id` BIGINT COMMENT 'Human Resources (HR) employee identifier sourced from SAP S/4HANA HCM or equivalent HR system of record. Links the commercial field force record to the enterprise workforce master. Used for payroll, benefits, and HR lifecycle cross-referencing.',
    `region_id` BIGINT COMMENT 'Identifier of the sales region encompassing the representatives district. Regions aggregate multiple districts under a Regional Business Director. Used for regional P&L reporting and strategic planning.',
    `territory_id` BIGINT COMMENT 'Unique identifier of the sales territory assigned to this representative, as defined in Veeva CRM territory management. Drives HCP targeting, call planning, sample allocation, and performance reporting. A rep may be assigned to one primary territory.',
    `annual_call_target` STRING COMMENT 'Target number of HCP sales calls (details) the representative is expected to complete within the fiscal year, as set by the commercial operations team. Used for field force productivity tracking and performance management in Veeva CRM.',
    `business_unit` STRING COMMENT 'Commercial business unit to which the sales representative is aligned (e.g., Oncology, Immunology, Rare Disease, Primary Care, Vaccines). Drives brand assignment, promotional material access in Veeva PromoMats, and P&L attribution.',
    `certification_expiry_date` DATE COMMENT 'Date on which the sales representatives current product or compliance certification expires. Triggers re-certification workflows and may restrict sample distribution or promotional activity if expired.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country in which the sales representative operates (e.g., USA, GBR, DEU). Used for regulatory jurisdiction determination, Sunshine Act applicability, and multi-country field force reporting.. Valid values are `^[A-Z]{3}$`',
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
    `therapeutic_area` STRING COMMENT 'Therapeutic area specialization of the sales representative, aligned to the ATC (Anatomical Therapeutic Chemical) classification framework. Determines HCP targeting strategy, scientific training requirements, and KOL engagement scope. [ENUM-REF-CANDIDATE: oncology|immunology|rare_disease|primary_care|vaccines|neuroscience|cardiovascular|infectious_disease — promote to reference product]',
    `veeva_crm_user_code` STRING COMMENT 'Unique user identifier assigned to the sales representative within Veeva CRM (Salesforce Health Cloud / Veeva CRM). Used to link field activity records, call logs, HCP interactions, and sample transactions back to the rep. Critical for CRM data lineage and compliance reporting.',
    `veeva_promomats_access` BOOLEAN COMMENT 'Indicates whether the sales representative has active access to Veeva PromoMats for retrieving approved promotional materials. Access is role-based and tied to brand assignment and certification status. Ensures only MLR-approved content is used in HCP interactions.',
    `work_email` STRING COMMENT 'Corporate email address of the sales representative used for official business communications, Veeva CRM login, and system notifications. Sourced from the enterprise directory (e.g., Active Directory / SAP S/4HANA).. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_phone` STRING COMMENT 'Primary corporate mobile or desk phone number assigned to the sales representative for field communications and HCP engagement. Sourced from HR or CRM system.',
    CONSTRAINT pk_sales_rep PRIMARY KEY(`sales_rep_id`)
) COMMENT 'Commercial field force representative master record. Captures rep identity, employee ID, role (territory manager, specialty rep, MSL, KAM), assigned territory, district, region, business unit, hire date, certification status, Veeva CRM user ID, and current employment status. This is the commercial-specific view of the field force with CRM linkage, territory assignment, and credentialing — distinct from the workforce domain employee record which owns HR lifecycle data.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` (
    `hcp_target_id` BIGINT COMMENT 'Unique surrogate identifier for the HCP targeting and call planning record within the commercial segmentation and planning layer.',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand or product for which this HCP is being targeted. Supports brand-level P&L reporting and promotional resource allocation.',
    `plan_id` BIGINT COMMENT 'Reference to the targeting/planning cycle (e.g., Q1 2025 cycle plan) under which this HCP target record was created. A cycle plan defines the planning period and field force objectives.',
    `market_formulary_position_id` BIGINT COMMENT 'Foreign key linking to market.formulary_position. Business justification: HCP targeting considers formulary position to prioritize physicians where brand has favorable access. Targeting strategy and resource allocation process links targets to formulary status for call plan',
    `master_id` BIGINT COMMENT 'Reference to the HCP master record (owned by the hcp domain) that is being targeted. This is the commercial segmentation layer — the HCP master itself is managed separately.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: HCP targeting strategies are product-specific. Call planning, territory design, and prescriber segmentation require product linkage. Real business process: targeting cycle planning and call plan optim',
    `msl_engagement_id` BIGINT COMMENT 'Foreign key linking to medical.msl_engagement. Business justification: Commercial targeting decisions informed by most recent MSL scientific engagement with same HCP. Enables coordinated field strategy, prevents engagement conflicts, and supports KOL tier assignment base',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to clinical.principal_investigator. Business justification: Commercial targeting identifies KOLs who are clinical investigators. Enables coordinated engagement strategy, speaker recruitment from trial sites, advisory board selection, and transparency reporting',
    `sales_rep_id` BIGINT COMMENT 'Reference to the sales representative (field force employee) assigned to engage this HCP target within the territory for the planning cycle.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory to which this HCP target is assigned for the planning cycle. Drives field force routing and call planning in Veeva CRM.',
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
    `therapeutic_area` STRING COMMENT 'Therapeutic area associated with the targeted brand (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular). Used for cross-brand analytics, field force alignment, and brand P&L reporting. [ENUM-REF-CANDIDATE: oncology|immunology|rare_diseases|cardiovascular|neuroscience|infectious_disease|endocrinology|hematology — promote to reference product]',
    `veeva_crm_record_code` STRING COMMENT 'Source system record identifier from Veeva CRM corresponding to this HCP target record. Used for data lineage, reconciliation, and integration with the Veeva CRM operational system.',
    `ytd_call_count` STRING COMMENT 'Number of completed sales calls (details) made to this HCP for the targeted brand in the current year-to-date period. Tracks field force execution against planned call frequency targets.',
    CONSTRAINT pk_hcp_target PRIMARY KEY(`hcp_target_id`)
) COMMENT 'Commercial targeting and call planning record linking an HCP (owned by the hcp domain) to a brand, territory, and sales rep for a given targeting/planning cycle. Captures target tier (A/B/C), planned call frequency, call type mix (face-to-face vs. remote), specialty segment, prescribing potential decile, targeting rationale, priority rank, effective period, plan approval status, and targeting status. Drives field force activity scheduling, call planning, and promotional resource allocation in Veeva CRM. Distinct from the HCP master (owned by hcp domain) — this is the commercial segmentation and planning layer.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` (
    `call_activity_id` BIGINT COMMENT 'Unique surrogate identifier for each field force call activity record in the Databricks Silver layer. Primary key for the call_activity data product.',
    `drug_product_id` BIGINT COMMENT 'Reference to the primary pharmaceutical product (brand) that was detailed during this call. The first-position detail product is the principal focus of the interaction.',
    `hco_master_id` BIGINT COMMENT 'Reference to the Healthcare Organization (HCO) where the call took place or which is the primary target when the call is at an institutional level. Nullable when the call is exclusively HCP-targeted.',
    `inquiry_id` BIGINT COMMENT 'Foreign key linking to medical.medical_inquiry. Business justification: Commercial sales calls frequently trigger medical information requests that must be routed to medical affairs for compliant response. Direct operational handoff tracked for regulatory compliance and o',
    `investigational_site_id` BIGINT COMMENT 'Foreign key linking to clinical.investigational_site. Business justification: Medical science liaisons (MSLs) conduct site engagement visits for recruitment support, data dissemination, and investigator relations. Tracks commercial-clinical interface at trial sites, essential f',
    `market_formulary_position_id` BIGINT COMMENT 'Foreign key linking to market.formulary_position. Business justification: Call activities capture HCP feedback on formulary access barriers (PA, step therapy). Field intelligence gathering process links call records to formulary positions for tracking access issues and info',
    `master_id` BIGINT COMMENT 'Reference to the Healthcare Professional (HCP) who was the primary target of this detail call. Links to the HCP master record.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Call activities detail medicinal products to HCPs. Call reporting, promotional effectiveness analysis, and reach/frequency metrics require product linkage. Real business process: call reporting and pr',
    `molecular_target_id` BIGINT COMMENT 'Foreign key linking to discovery.molecular_target. Business justification: Sales reps detail mechanism of action referencing specific molecular targets during HCP calls. Required for call content tracking, medical-commercial alignment verification, promotional compliance aud',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Field promotional activities require PhRMA Code compliance monitoring. Links call activities to compliance oversight program for off-label discussion monitoring, sample compliance, and promotional con',
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
    `call_activity_id` BIGINT COMMENT 'Identifier of the sales call activity (HCP visit) in Veeva CRM during which this sample was disbursed. Links sample transactions to call reporting for promotional compliance and field force effectiveness analytics.',
    `cogs_entry_id` BIGINT COMMENT 'Foreign key linking to finance.cogs_entry. Business justification: Sample distribution represents COGS - product given away has cost impact. Required for accurate gross-to-net calculations and inventory valuation.',
    `drug_product_id` BIGINT COMMENT 'Identifier of the pharmaceutical product (drug product / finished dosage form) associated with this sample inventory position. Links to the product master.',
    `market_formulary_position_id` BIGINT COMMENT 'Foreign key linking to market.formulary_position. Business justification: Sample distribution strategies consider formulary position to prioritize sampling where access is favorable. Targeting and resource allocation process links sample transactions to formulary status for',
    `master_id` BIGINT COMMENT 'Identifier of the Healthcare Professional (HCP) who received the sample disbursement. Required for PDMA compliance and Sunshine Act Open Payments reporting. Null for non-disbursement transactions.',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Sample inventory tracks material master records for lot traceability, expiry management, PDMA compliance, and reconciliation with manufacturing batch records. Required for sample accountability audits',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Sample inventory is managed at medicinal product level. Sample accountability, PDMA compliance, and sample utilization analysis require product linkage. Real business process: sample reconciliation an',
    `sales_rep_id` BIGINT COMMENT 'Identifier of the sales representative who holds or is responsible for this sample inventory position. Links to the sales rep master record in Veeva CRM / Salesforce Health Cloud.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to masterdata.storage_location. Business justification: Samples must be stored in GDP-qualified locations. Required for temperature excursion investigations, sample accountability audits, PDMA compliance, and regulatory inspection readiness for sample stor',
    `territory_id` BIGINT COMMENT 'Identifier of the sales territory to which this sample inventory position is assigned. Used for territory-level sample accountability and reconciliation reporting.',
    `adjustment_reason` STRING COMMENT 'Reason code for a sample inventory adjustment. Required for PDMA compliance when quantity_adjusted is non-zero. [ENUM-REF-CANDIDATE: expired|damaged|lost|stolen|count_correction|returned_to_warehouse|destroyed — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sample inventory record was first created in the system. Used for audit trail, data lineage, and 21 CFR Part 11 electronic records compliance.',
    `discrepancy_quantity` STRING COMMENT 'Net difference between the physical count and the system-recorded quantity on hand during reconciliation. Non-zero values trigger a PDMA compliance investigation. Positive = overage; Negative = shortage.',
    `expiration_date` DATE COMMENT 'Expiration date of the sample lot as printed on the package. Samples past this date must not be disbursed and must be removed from inventory per cGMP and PDMA requirements.',
    `hcp_dea_number` STRING COMMENT 'DEA registration number of the HCP, required when distributing controlled substance samples. Validates prescribing authority for scheduled drug samples per DEA regulations.. Valid values are `^[A-Z]{2}[0-9]{7}$`',
    `hcp_license_number` STRING COMMENT 'State medical license number of the HCP at the time of sample disbursement. Required by PDMA to verify the HCP is a licensed practitioner authorized to receive samples. Captured at point of disbursement.',
    `hcp_signature_captured` BOOLEAN COMMENT 'Indicates whether the HCPs electronic signature was captured at the time of sample disbursement, as required by PDMA. True = signature obtained; False = signature not obtained (requires justification).',
    `hcp_signature_timestamp` TIMESTAMP COMMENT 'Date and time when the HCPs electronic signature was captured for the sample disbursement. Required for 21 CFR Part 11 electronic records compliance and PDMA audit trail.',
    `inventory_number` STRING COMMENT 'Externally-known business identifier for this sample inventory position record. Used for PDMA audit trails, reconciliation reports, and regulatory submissions. Generated by the sample management system (Veeva CRM or SAP MM).. Valid values are `^SINV-[0-9]{8,12}$`',
    `inventory_status` STRING COMMENT 'Current lifecycle state of the sample inventory position. Active = open and in use; Reconciled = periodic reconciliation completed; Closed = inventory position closed; Suspended = temporarily frozen pending investigation; Pending Review = flagged for compliance review.. Valid values are `active|reconciled|closed|suspended|pending_review`',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number assigned to the sample units in this inventory position. Critical for product recall management, quality investigations, and PDMA lot-level accountability.',
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
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Promotional materials detail specific drug products with exact strength and dosage form. MLR review for fair balance, indication-specific claims, and field usage tracking require drug product linkage.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Promotional materials are approved and owned by specific legal entities. Required for MLR jurisdiction determination, copyright ownership, regulatory submission attribution, and Sunshine Act reporting',
    `molecular_target_id` BIGINT COMMENT 'Foreign key linking to discovery.molecular_target. Business justification: Promotional materials describe mechanism of action referencing validated molecular targets. Required for MLR review process, fair balance assessment, scientific accuracy verification by medical review',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Promotional materials must reference patent status for compliance; MLR review requires patent information for fair balance and regulatory accuracy in promotional claims.',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: Promotional materials must reference and comply with promotional SOPs and policies. Links materials to governing policy documents for MLR review requirements, fair balance standards, and regulatory co',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Promotional materials are produced by external vendors (printers, digital agencies, video production). Marketing procurement tracks which vendor produced each piece for quality control, compliance ver',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Promotional materials must comply with specific regulatory frameworks (FDA, PhRMA Code). Links materials to governing compliance program for MLR review requirements, audit trails, and inspection readi',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Promotional materials reference product specifications for claims substantiation during MLR (Medical-Legal-Regulatory) review. Ensures promotional claims align with approved product quality attributes',
    `aggregate_decision` STRING COMMENT 'Overall consolidated MLR committee decision for the current review cycle, reflecting the combined outcome of medical, legal, and regulatory reviewer decisions. Drives the approval_status field transition.. Valid values are `approved|approved_with_changes|rejected|pending`',
    `approval_date` DATE COMMENT 'Date on which the promotional material received final aggregate MLR approval and was authorized for use in field force detailing and commercial distribution.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the promotional material within the Medical-Legal-Regulatory (MLR) approval workflow. Only materials in approved status with a valid expiry date may be used in field force detailing per internal PhRMA code compliance policy. [ENUM-REF-CANDIDATE: draft|in_mlr_review|approved|approved_with_changes|rejected|withdrawn|expired|archived — 8 candidates stripped; promote to reference product]',
    `content_owner` STRING COMMENT 'Name or employee identifier of the brand team member or marketing manager who owns and is accountable for the promotional material content, including initiating the MLR submission and managing the approval lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the promotional material record was first created in the Veeva PromoMats system. Supports audit trail requirements under 21 CFR Part 11 electronic records compliance.',
    `distribution_channel` STRING COMMENT 'Primary channel through which the promotional material is distributed to the target audience. Determines field force eligibility, digital deployment rules, and PhRMA code compliance requirements. [ENUM-REF-CANDIDATE: field_force|digital|congress|patient|journal|managed_care|speaker_program — 7 candidates stripped; promote to reference product]',
    `expiry_date` DATE COMMENT 'Date on which the MLR approval for this promotional material expires. Materials must be withdrawn from field use on or before this date. Renewal requires a new MLR submission cycle.',
    `fair_balance_included` BOOLEAN COMMENT 'Indicates whether the promotional material includes the required fair balance statement (risk information) as mandated by FDA 21 CFR Part 202.1 for prescription drug advertising. Must be True for all HCP-directed materials.',
    `indication` STRING COMMENT 'The specific FDA/EMA-approved therapeutic indication for which this promotional material is intended. Promotional materials may only promote on-label indications per 21 CFR Part 202.',
    `isi_included` BOOLEAN COMMENT 'Indicates whether the Important Safety Information (ISI) section is included in the promotional material, as required for HCP-directed promotional pieces under FDA promotional regulations.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (optionally with ISO 3166-1 region subtag) indicating the language of the promotional material content (e.g., en-US, fr-FR, de-DE). Required for multi-market localization tracking.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the promotional material record in the source system. Supports change tracking and audit trail requirements under 21 CFR Part 11.',
    `last_resubmission_date` DATE COMMENT 'Date of the most recent resubmission of this promotional material to the MLR committee after a prior rejection or change request. Null if the material has never been resubmitted.',
    `legal_decision` STRING COMMENT 'Individual decision rendered by the Legal reviewer for the current MLR review cycle. All three reviewer decisions must be approved for aggregate approval.. Valid values are `approved|approved_with_changes|rejected|pending`',
    `legal_reviewer` STRING COMMENT 'Name or employee identifier of the assigned Legal reviewer responsible for evaluating legal risk, intellectual property, and fair balance claims in the promotional material during the MLR review.',
    `market` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the market for which this promotional material is approved and intended for distribution. Drives regulatory jurisdiction applicability (FDA, EMA, MHRA, PMDA, NMPA).. Valid values are `^[A-Z]{3}$`',
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
    `therapeutic_area` STRING COMMENT 'Broad therapeutic area classification (e.g., oncology, immunology, rare diseases) for the promotional material. Used for portfolio-level reporting and brand team assignment.',
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
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Promotional materials detail specific drug products for fair balance verification. MLR review requires drug product linkage for indication-specific claim approval. Real business process: fair balance ',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: MLR reviews ensure compliance with promotional material regulations (FDA 21 CFR 202.1, EMA guidelines). Links review process to specific regulatory obligations for inspection readiness and compliance ',
    `internal_control_id` BIGINT COMMENT 'Foreign key linking to compliance.internal_control. Business justification: MLR reviews are SOX-relevant controls for promotional content approval. Required for control testing, effectiveness assessment, and SOX 404 compliance documentation in pharmaceutical promotional opera',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: MLR review processes may be tracked via internal orders for cost allocation of medical/legal/regulatory reviewer time and promotional material development costs.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: MLR reviews are conducted under specific legal entitys regulatory authority and approval jurisdiction. Required for approval authority determination, regulatory submission attribution, and compliance',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: MLR reviews approve promotional materials for specific medicinal products. Review tracking, approval workflows, and promotional compliance require product linkage. Real business process: MLR review wo',
    `employee_id` BIGINT COMMENT 'Reference to the medical affairs reviewer responsible for evaluating the scientific accuracy and clinical claims within the promotional material.',
    `prior_submission_mlr_review_id` BIGINT COMMENT 'Reference to the previous MLR review record for the same promotional material, enabling resubmission history tracking and cycle lineage. Null for initial submissions (review_cycle_number = 1).',
    `promo_material_id` BIGINT COMMENT 'Reference to the promotional material or communication asset undergoing MLR review. Links to the material record in Veeva Vault PromoMats.',
    `quaternary_mlr_submitter_employee_id` BIGINT COMMENT 'Reference to the individual (typically from the commercial or marketing team) who submitted the promotional material for MLR review.',
    `tertiary_mlr_regulatory_reviewer_employee_id` BIGINT COMMENT 'Reference to the regulatory affairs reviewer responsible for assessing compliance with FDA promotional regulations, labeling requirements, and applicable agency guidance.',
    `approval_date` DATE COMMENT 'Date on which the final MLR approval decision was rendered and the promotional material was formally approved for use. Null if not yet approved.',
    `approval_decision` STRING COMMENT 'Final consolidated approval decision rendered by the MLR committee upon completion of all three review streams (medical, legal, regulatory). Null until the review is concluded.. Valid values are `approved|approved_with_changes|rejected|withdrawn`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the market or jurisdiction for which the promotional material is intended. Determines applicable regulatory authority (FDA, EMA, MHRA, PMDA, NMPA) and review standards.. Valid values are `^[A-Z]{3}$`',
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

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` (
    `commercial_speaker_program_id` BIGINT COMMENT 'Unique surrogate identifier for the speaker program record in the Databricks Silver Layer. Primary key for this entity.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Speaker honoraria, venue costs, catering create AP obligations. Payment tracking required for Sunshine Act compliance and SOX controls on promotional spend.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to quality.audit. Business justification: Speaker programs audited for PhRMA code compliance, Sunshine Act accuracy, and promotional content adherence. Quality audit findings drive program modifications, CAPA generation, and compliance traini',
    `brand_id` BIGINT COMMENT 'Reference to the commercial brand or product being promoted or discussed at the speaker program. Supports brand P&L reporting and promotional compliance tracking.',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Speaker programs present clinical data for specific drug products. Program planning, speaker training materials, and transparency reporting require exact product identification. Real business process:',
    `employee_id` BIGINT COMMENT 'Reference to the internal compliance officer or team member who reviewed and approved or rejected this speaker program for regulatory compliance.',
    `fmv_assessment_id` BIGINT COMMENT 'Reference to the fair market value (FMV) assessment record that validates the honorarium rate paid to the speaker is consistent with FMV for their credentials and specialty. Required for Anti-Kickback Statute compliance.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Speaker programs are discrete cost events requiring internal order for budget control, cost center allocation, Sunshine Act compliance, and SOX audit trail.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Speaker programs are funded and hosted by specific legal entities. Required for Sunshine Act reporting, EFPIA disclosure, transfer of value attribution, tax compliance, and regulatory inspection readi',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Speaker programs use event management, catering, AV, and venue vendors. Commercial operations procurement tracks vendor performance for program logistics, cost management, compliance verification, and',
    `master_id` BIGINT COMMENT 'Reference to the primary Healthcare Professional (HCP) designated as the lead speaker for the program. Used for speaker bureau management, fair market value (FMV) assessment, and Sunshine Act reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Speaker programs are charged to specific cost centers for budget tracking. Required for promotional spend allocation, budget vs. actual analysis, and commercial operations financial reporting by cost ',
    `molecular_target_id` BIGINT COMMENT 'Foreign key linking to discovery.molecular_target. Business justification: Speaker programs educate HCPs on mechanism of action tied to specific molecular targets. Required for content approval, scientific accuracy verification, medical-commercial alignment, and ensuring spe',
    `monitoring_activity_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_monitoring_activity. Business justification: Speaker programs are subject to compliance monitoring audits for PhRMA Code adherence, FMV compliance, and transparency reporting. Links programs to monitoring activities for findings documentation an',
    `msl_profile_id` BIGINT COMMENT 'Foreign key linking to medical.msl_profile. Business justification: MSL scientific support for speaker programs including speaker training verification, scientific content review, and KOL identification/vetting. Standard pharmaceutical practice for ensuring scientific',
    `submission_id` BIGINT COMMENT 'CMS Open Payments system submission identifier assigned upon successful filing of the transfer of value records associated with this program. Used for audit trail and resubmission tracking.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Speaker programs discuss patented products; compliance review and fair balance requirements necessitate patent status awareness for scientific accuracy and regulatory compliance.',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Speaker programs require PhRMA Code and Sunshine Act compliance oversight. Links programs to compliance framework for FMV assessment, transparency reporting, and anti-kickback statute compliance monit',
    `promo_material_id` BIGINT COMMENT 'Reference to the Veeva PromoMats-approved promotional or medical education material used at the speaker program. Ensures only MLR-approved content is presented.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory responsible for organizing and funding the speaker program. Used for territory-level spend tracking and field force accountability.',
    `trial_id` BIGINT COMMENT 'Foreign key linking to clinical.trial. Business justification: Speaker programs feature specific trial results for promotional education. Links promotional activities to evidence source for MLR compliance, fair balance verification, and transparency reporting. Re',
    `attendee_count_actual` STRING COMMENT 'Actual number of HCP attendees who attended the speaker program. Used for per-attendee cost calculation and compliance validation.',
    `attendee_count_planned` STRING COMMENT 'Number of HCP attendees planned for the speaker program at time of approval. Used for venue sizing, meal ordering, and budget estimation.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded reason for cancellation of the speaker program. Populated only when program_status is cancelled. Used for operational analysis and budget recovery.',
    `compliance_review_date` DATE COMMENT 'Date on which the compliance review for this speaker program was completed. Used for audit trail and SOP adherence tracking.',
    `compliance_review_status` STRING COMMENT 'Status of the internal compliance review for this speaker program. Managed through the compliance workflow in Veeva CRM or MasterControl/TrackWise.. Valid values are `pending|approved|rejected|escalated|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this speaker program record was first created in the system. Used for audit trail and data lineage in the Databricks Silver Layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this program record (e.g., USD, EUR, GBP). Ensures consistent financial reporting across geographies.. Valid values are `^[A-Z]{3}$`',
    `delivery_channel` STRING COMMENT 'Indicates whether the speaker program was delivered in-person, virtually (webinar), or as a hybrid event. Affects meal cap applicability and PhRMA code compliance rules.. Valid values are `in_person|virtual|hybrid`',
    `phrm_code_compliant` BOOLEAN COMMENT 'Indicates whether the speaker program was assessed as compliant with the PhRMA Code on Interactions with Healthcare Professionals, including meal cap, venue appropriateness, and educational content requirements.',
    `program_date` DATE COMMENT 'The principal real-world date on which the speaker program event is scheduled or was held. Used as the event date for Sunshine Act Open Payments reporting period assignment.',
    `program_end_time` TIMESTAMP COMMENT 'Precise date and time the speaker program event concludes. Used to calculate event duration and validate meal/entertainment cap compliance.',
    `program_start_time` TIMESTAMP COMMENT 'Precise date and time the speaker program event begins. Used for scheduling, venue booking, and compliance audit trail.',
    `program_status` STRING COMMENT 'Current lifecycle state of the speaker program. Drives workflow routing in Veeva CRM and compliance review queues.. Valid values are `draft|planned|confirmed|completed|cancelled|under_review`',
    `program_type` STRING COMMENT 'Classification of the speaker program format. Drives PhRMA code compliance rules and meal cap applicability. [ENUM-REF-CANDIDATE: dinner_meeting|webinar|symposium|peer_to_peer|advisory_board|stand_alone_exhibit — promote to reference product if additional types are needed]. Valid values are `dinner_meeting|webinar|symposium|peer_to_peer|advisory_board|stand_alone_exhibit`',
    `speaker_training_verified` BOOLEAN COMMENT 'Indicates whether the lead speaker has completed mandatory speaker bureau training and certification prior to the program. Required for speaker bureau eligibility.',
    `sunshine_act_reportable` BOOLEAN COMMENT 'Indicates whether this speaker program generates transfers of value that must be reported under the Sunshine Act (Open Payments) to CMS. True if any reportable payment was made to a covered recipient.',
    `therapeutic_area` STRING COMMENT 'The therapeutic area (e.g., Oncology, Immunology, Rare Diseases) associated with the speaker program. Used for brand P&L attribution and commercial analytics.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this speaker program record was last modified. Used for incremental data pipeline processing and audit trail in the Databricks Silver Layer.',
    `veeva_crm_record_code` STRING COMMENT 'Source system record identifier from Veeva CRM or Salesforce Health Cloud for this speaker program. Used for data lineage, reconciliation, and cross-system traceability.',
    `venue_city` STRING COMMENT 'City where the speaker program venue is located. Used for geographic spend analysis and Sunshine Act reporting.',
    `venue_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the venue location. Determines applicable regulatory reporting framework (e.g., Open Payments for USA, EFPIA Disclosure Code for European countries).. Valid values are `^[A-Z]{3}$`',
    `venue_name` STRING COMMENT 'Name of the physical or virtual venue where the speaker program is held (e.g., restaurant name, hotel, webinar platform). Required for PhRMA code venue appropriateness review.',
    `venue_state_province` STRING COMMENT 'State or province of the speaker program venue. Used for state-level aggregate spend reporting and compliance with state transparency laws.',
    CONSTRAINT pk_commercial_speaker_program PRIMARY KEY(`commercial_speaker_program_id`)
) COMMENT 'Master record and full participation ledger for HCP speaker programs. Program header captures program type (dinner meeting, webinar, symposium, peer-to-peer), venue, date, budget, actual spend, compliance status, and PhRMA code adherence. Participation detail captures each HCPs engagement as speaker or attendee, including HCP ID, participation role, honorarium amount, travel reimbursement, meal value, attendance confirmation, fair market value assessment, and Sunshine Act reportable transfer of value flag. Feeds directly into Open Payments aggregate spend reporting and supports Sunshine Act compliance, speaker bureau management, speaker training tracking, and fair market value documentation.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` (
    `speaker_engagement_id` BIGINT COMMENT 'Unique surrogate identifier for each speaker engagement record in the Databricks Silver layer. Primary key for this transactional entity.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Individual speaker payments (honorarium, travel, meals) create AP entries. Required for transparency reporting (Sunshine Act, EFPIA) and payment reconciliation.',
    `commercial_speaker_program_id` BIGINT COMMENT 'Reference to the parent speaker program event under which this individual engagement occurred. Links to the speaker program master record in Veeva CRM.',
    `conflict_of_interest_id` BIGINT COMMENT 'Foreign key linking to compliance.conflict_of_interest. Business justification: Speaker engagements require COI screening of physicians per FDA and institutional policies. Links engagements to COI declarations for transparency, bias management, and regulatory compliance in promot',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Speaker engagements present specific drug product clinical data. Transparency reporting and program compliance require drug product specificity. Real business process: Open Payments disclosure and spe',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Speaker engagements create transfer of value obligations for specific legal entities. Required for Sunshine Act/EFPIA reporting, tax withholding, payment processing, and compliance audit trails by leg',
    `master_id` BIGINT COMMENT 'Reference to the Healthcare Professional (HCP) who participated in the speaker program, either as a speaker or attendee. Sourced from Veeva CRM / Salesforce Health Cloud HCP master record.',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (brand or molecule) that is the subject of the speaker program. Used for brand-level P&L and promotional compliance tracking.',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Speaker engagements promote patented innovations; honoraria compliance, Sunshine Act reporting, and scientific accuracy require patent awareness for regulatory adherence.',
    `contract_id` BIGINT COMMENT 'Reference identifier for the executed speaker bureau contract or consulting agreement governing this engagement. Links to the contract management system (e.g., Veeva Vault) for fair market value (FMV) validation and compliance documentation.',
    `territory_id` BIGINT COMMENT 'Reference to the commercial sales territory associated with this engagement, used for territory-level performance reporting and Sunshine Act state-level aggregation.',
    `attendance_confirmation_date` DATE COMMENT 'Date on which the HCPs attendance was formally confirmed and recorded in the system. Used for audit trail and compliance documentation.',
    `attendance_confirmed` BOOLEAN COMMENT 'Indicates whether the HCPs physical or virtual attendance at the speaker program has been formally confirmed and documented. Required for compliance validation before processing any transfer of value payment.',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA cost center code to which the speaker engagement expenditure is allocated. Used for brand-level P&L reporting and commercial budget management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this speaker engagement record was first created in the system. Supports audit trail requirements under 21 CFR Part 11 and SOX compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this engagement record (e.g., USD, EUR, GBP). Supports multi-country commercial operations.. Valid values are `^[A-Z]{3}$`',
    `efpia_reportable` BOOLEAN COMMENT 'Indicates whether this engagement is reportable under the EFPIA Disclosure Code for European HCP transparency reporting. Applicable for engagements with HCPs in EU/EEA countries.',
    `engagement_date` DATE COMMENT 'The calendar date on which the speaker program event took place and the HCP participated. This is the principal real-world event date used for Sunshine Act reporting year attribution.',
    `engagement_number` STRING COMMENT 'Externally-known business reference number for this speaker engagement record, as assigned by Veeva CRM or the speaker bureau management system. Used for cross-system reconciliation and audit trail.',
    `engagement_status` STRING COMMENT 'Current lifecycle status of the speaker engagement record. Drives workflow processing, payment eligibility, and Open Payments reportability. completed is required before honorarium disbursement.. Valid values are `scheduled|confirmed|completed|cancelled|no_show`',
    `fmv_compliant` BOOLEAN COMMENT 'Indicates whether the honorarium paid for this engagement is within the pre-approved fair market value (FMV) range for this HCP. A value of False triggers a compliance review workflow. Critical for Anti-Kickback Statute compliance.',
    `fmv_rate` DECIMAL(18,2) COMMENT 'The pre-approved fair market value (FMV) hourly or per-engagement rate for this HCPs speaking services, as determined by an independent FMV assessment. Used to validate that honorarium payments do not exceed FMV, a key anti-kickback compliance requirement.',
    `open_payments_category` STRING COMMENT 'CMS Open Payments program category under which this transfer of value is classified for federal reporting. general_payment covers speaker fees, meals, and travel. Determines the submission record type in the CMS Open Payments system.. Valid values are `general_payment|research_payment|ownership_interest`',
    `open_payments_nature_of_payment` STRING COMMENT 'CMS-defined nature of payment code describing the type of transfer of value (e.g., Speaking Fees, Food and Beverage, Travel and Lodging, Education). Required field for CMS Open Payments submission. [ENUM-REF-CANDIDATE: speaking_fees|food_and_beverage|travel_and_lodging|education|consulting_fees|gift|entertainment|grant — promote to reference product]',
    `open_payments_record_code` STRING COMMENT 'CMS-assigned record identifier returned upon successful submission to the Open Payments system. Used for dispute resolution, correction submissions, and audit trail linking back to the federal database.',
    `open_payments_submission_status` STRING COMMENT 'Status of this engagement records submission to the CMS Open Payments (Sunshine Act) federal reporting system. Tracks the full submission lifecycle from initial filing through dispute resolution and correction.. Valid values are `not_submitted|submitted|accepted|disputed|corrected`',
    `participation_role` STRING COMMENT 'The role of the HCP in the speaker program event. Determines honorarium eligibility, transfer of value category for Sunshine Act reporting, and PhRMA code compliance classification.. Valid values are `speaker|attendee|moderator|panelist|consultant`',
    `phirma_code_compliant` BOOLEAN COMMENT 'Indicates whether this engagement fully complies with the PhRMA Code on Interactions with Healthcare Professionals, including meal value limits, venue appropriateness, and educational content requirements.',
    `program_format` STRING COMMENT 'Delivery format of the speaker program event. Determines applicable PhRMA code meal value caps (in-person only) and influences Sunshine Act reporting requirements for virtual engagements.. Valid values are `in_person|virtual|hybrid`',
    `reporting_year` STRING COMMENT 'Calendar year (YYYY) to which this engagement is attributed for CMS Open Payments annual reporting purposes. May differ from the engagement_date year in cases of late payments or corrections.',
    `sap_vendor_number` STRING COMMENT 'SAP S/4HANA vendor master number assigned to the HCP for accounts payable processing of honorarium and expense reimbursements. Required for payment processing through SAP FI/AP module.',
    `sunshine_act_reportable` BOOLEAN COMMENT 'Indicates whether this engagement constitutes a reportable transfer of value under the U.S. Physician Payments Sunshine Act (42 U.S.C. § 1320a-7h) and must be submitted to CMS Open Payments. True when the HCP is a covered recipient and the value meets reporting thresholds.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this speaker engagement record was most recently modified. Supports change data capture (CDC) in the Databricks Silver layer and audit trail requirements under 21 CFR Part 11.',
    `veeva_crm_activity_code` STRING COMMENT 'Source system identifier from Veeva CRM or Salesforce Health Cloud for the speaker program activity record that generated this engagement. Used for cross-system reconciliation and data lineage tracking.',
    `venue_city` STRING COMMENT 'City where the speaker program venue is located. Used for geographic analysis of speaker program distribution and state-level Sunshine Act reporting.',
    `venue_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the speaker program venue is located. Supports international commercial operations and country-level compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `venue_name` STRING COMMENT 'Name of the physical venue or virtual platform where the speaker program was held. Required for in-person program compliance documentation and PhRMA code venue appropriateness review.',
    `venue_state_code` STRING COMMENT 'Two-letter U.S. state code (or equivalent jurisdiction code) for the venue location. Used for state-level aggregate spend reporting and compliance with state transparency laws (e.g., Massachusetts, Vermont, Minnesota disclosure laws).. Valid values are `^[A-Z]{2}$`',
    CONSTRAINT pk_speaker_engagement PRIMARY KEY(`speaker_engagement_id`)
) COMMENT 'Transactional record of an individual HCPs participation in a speaker program, either as a speaker or attendee. Captures HCP ID, program ID, participation role (speaker, attendee), honorarium amount paid, travel and expense reimbursement, meal value, attendance confirmation, and Sunshine Act reportable transfer of value flag. Feeds directly into Open Payments aggregate spend reporting.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` (
    `sunshine_disclosure_id` BIGINT COMMENT 'Unique surrogate identifier for each Sunshine Act disclosure record in the silver layer lakehouse. Primary key for this entity.',
    `trial_id` BIGINT COMMENT 'Reference to the internal clinical trial record associated with this research payment disclosure. Populated when the transfer of value is linked to a specific clinical trial in the CTMS.',
    `disclosure_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_disclosure. Business justification: Sunshine Act disclosures are a specific type of compliance disclosure submission. Links operational sunshine records to regulatory disclosure filings for CMS Open Payments reporting and audit reconcil',
    `grant_id` BIGINT COMMENT 'Foreign key linking to medical.medical_grant. Business justification: Sunshine Act reporting aggregates transfers of value from both commercial activities (speaker fees, meals) and medical grants to same recipients. Required for complete CMS Open Payments submission.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Sunshine reporting failures, disputes, or corrections are compliance incidents requiring investigation and CAPA. Links disclosure records to incident management for root cause analysis and remediation',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Sunshine Act payments must be recorded in GL. Disclosure records should reference underlying journal entries for audit trail and SOX compliance.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Sunshine Act disclosures are submitted by specific legal entities to CMS. Required for regulatory compliance, EFPIA transparency reporting, and audit trail of reporting entity for each transfer of val',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Sunshine Act disclosures must identify associated medicinal products. CMS Open Payments reporting requires product linkage for compliance. Real business process: Open Payments submission and transpare',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Sunshine Act disclosures for patented products require patent linkage for transparency reporting; CMS submissions must accurately identify IP-protected products for public disclosure.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sunshine Act compliance review tracking is mandatory for CMS Open Payments regulatory audit trail. Reviewed_by currently text; FK enables proper documentation of compliance personnel responsible for d',
    `cms_record_code` STRING COMMENT 'Unique record identifier assigned by CMS upon successful submission to the Open Payments system. Used to track and reconcile submissions with the CMS portal. Null prior to submission.',
    `correction_indicator` BOOLEAN COMMENT 'Indicates whether this record is a corrected re-submission of a previously submitted disclosure. True when the record has been amended following a dispute resolution or internal data quality review.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this disclosure record was first created in the lakehouse silver layer. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the payment amount. Typically USD for US Sunshine Act reporting. Retained for multi-currency source system reconciliation.. Valid values are `^[A-Z]{3}$`',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason provided by the covered recipient for disputing this disclosure record. Populated when dispute_status is not no_dispute.',
    `dispute_status` STRING COMMENT 'Status of any dispute raised by the covered recipient against this disclosure record during the CMS Open Payments review and dispute period. Tracks the resolution lifecycle of recipient-initiated disputes.. Valid values are `no_dispute|disputed_by_recipient|resolved_agreed|resolved_corrected|resolved_deleted`',
    `form_of_payment` STRING COMMENT 'Method by which the transfer of value was delivered to the covered recipient (e.g., cash, check, in-kind goods or services, stock). Required field for CMS Open Payments submission.. Valid values are `cash|check|in_kind|stock|stock_option|other`',
    `internal_reference_number` STRING COMMENT 'Company-assigned internal tracking number for the disclosure record, used to cross-reference with source transactions in Veeva CRM, SAP, or other operational systems prior to CMS submission.',
    `internal_review_status` STRING COMMENT 'Status of the internal compliance review process for this disclosure record prior to CMS submission. Tracks the companys internal approval workflow to ensure accuracy and PhRMA Code compliance before submission.. Valid values are `pending|under_review|approved|rejected|escalated`',
    `is_research_payment` BOOLEAN COMMENT 'Indicates whether this transfer of value is classified as a research payment under the CMS Open Payments research payment program, which has distinct reporting requirements from general payments.',
    `nct_number` STRING COMMENT 'ClinicalTrials.gov registry identifier (NCT number) for the associated clinical study, required by CMS for research payments linked to registered trials.. Valid values are `^NCT[0-9]{8}$`',
    `original_cms_record_code` STRING COMMENT 'CMS-assigned record ID of the original submission that this record corrects or supersedes. Populated only when correction_indicator is True, enabling audit trail linkage between original and corrected records.',
    `payment_category` STRING COMMENT 'CMS-defined category describing the nature of the transfer of value (e.g., consulting fees, honoraria, food and beverage, travel and lodging, education, research). Mandatory field for Open Payments submission. [ENUM-REF-CANDIDATE: consulting_fee|honoraria|food_and_beverage|travel_and_lodging|education|research|gift|entertainment|royalty_or_license|current_or_prospective_ownership — promote to reference product]',
    `payment_date` DATE COMMENT 'Date on which the transfer of value was provided to the covered recipient. This is the real-world event date used for annual program year assignment and CMS reporting.',
    `program_type` STRING COMMENT 'Internal classification of the commercial or medical affairs program under which the transfer of value was made (e.g., speaker program, advisory board, consulting engagement). Used for PhRMA Code compliance and internal spend analytics. [ENUM-REF-CANDIDATE: speaker_program|advisory_board|consulting|clinical_trial|medical_education|promotional_event|research_grant|other — promote to reference product]',
    `publication_date` DATE COMMENT 'Date on which CMS publicly published this disclosure record on the Open Payments website. Marks the point at which the record becomes publicly accessible.',
    `recipient_first_name` STRING COMMENT 'First (given) name of the covered recipient HCP as registered with CMS. Required for physician and non-physician practitioner records; not applicable for teaching hospitals.',
    `recipient_institution_name` STRING COMMENT 'Legal name of the teaching hospital or healthcare organization receiving the transfer of value. Populated when recipient_type is covered_recipient_teaching_hospital; otherwise null.',
    `recipient_last_name` STRING COMMENT 'Last (family) name of the covered recipient HCP as registered with CMS. Required for physician and non-physician practitioner records; not applicable for teaching hospitals.',
    `recipient_npi` STRING COMMENT '10-digit National Provider Identifier (NPI) of the Healthcare Professional (HCP) or teaching hospital receiving the transfer of value. Required field for CMS Open Payments submission and used to uniquely identify covered recipients.. Valid values are `^[0-9]{10}$`',
    `recipient_primary_specialty` STRING COMMENT 'Primary medical specialty of the covered recipient physician or non-physician practitioner as registered with CMS (e.g., Internal Medicine, Oncology, Cardiology). Used for analytics and compliance segmentation.',
    `recipient_state` STRING COMMENT 'Two-letter US state code of the covered recipients primary practice or institution address, as registered with CMS. Used for geographic compliance reporting and territory analytics.. Valid values are `^[A-Z]{2}$`',
    `recipient_type` STRING COMMENT 'Classification of the payment recipient as defined by the Sunshine Act: a covered physician, a teaching hospital, or a non-physician practitioner (e.g., nurse practitioner, physician assistant). Determines applicable reporting rules.. Valid values are `covered_recipient_physician|covered_recipient_teaching_hospital|covered_recipient_non_physician_practitioner`',
    `reporting_year` STRING COMMENT 'Calendar year for which the transfer of value is being reported to CMS Open Payments. Aligns with the annual program year defined under 42 CFR Part 403.',
    `research_study_name` STRING COMMENT 'Name of the clinical study or research project associated with this transfer of value, when is_research_payment is True. Corresponds to the study name as registered with CMS Open Payments research program.',
    `review_date` DATE COMMENT 'Date on which the internal compliance review of this disclosure record was completed. Used for audit trail and compliance reporting.',
    `source_system` STRING COMMENT 'Operational system from which this disclosure record originated (e.g., Veeva CRM, Salesforce Health Cloud, SAP S/4HANA). Used for data lineage tracking and reconciliation in the silver layer.. Valid values are `veeva_crm|salesforce_health_cloud|sap_s4hana|manual_entry|other`',
    `submission_date` DATE COMMENT 'Date on which this disclosure record was submitted to the CMS Open Payments system. Used to confirm compliance with annual submission deadlines.',
    `submission_status` STRING COMMENT 'Current lifecycle status of the disclosure record within the CMS Open Payments submission workflow. [ENUM-REF-CANDIDATE: draft|pending_review|submitted|accepted|disputed|corrected|deleted — promote to reference product]',
    `therapeutic_area` STRING COMMENT 'Therapeutic area classification of the associated product (e.g., Oncology, Immunology, Rare Diseases). Used for brand-level P&L reporting and commercial analytics segmentation.',
    `third_party_entity_name` STRING COMMENT 'Name of the third-party entity that made the payment on behalf of the reporting company, when third_party_payment_flag is True. Required for indirect payment transparency reporting.',
    `third_party_payment_flag` BOOLEAN COMMENT 'Indicates whether the payment was made by a third party (e.g., a CRO or CMO) on behalf of the reporting pharmaceutical company. Relevant for indirect payment disclosure requirements under the Sunshine Act.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this disclosure record was last modified in the lakehouse silver layer. Used to track corrections, status changes, and dispute resolutions over the record lifecycle.',
    CONSTRAINT pk_sunshine_disclosure PRIMARY KEY(`sunshine_disclosure_id`)
) COMMENT 'Aggregated annual disclosure record of transfers of value from the pharmaceutical company to HCPs and teaching hospitals, as required by the Physician Payments Sunshine Act (42 CFR Part 403). Captures reporting year, HCP/HCO NPI, payment category (consulting fees, honoraria, food and beverage, travel, education, research), amount, product associated, submission status, and CMS Open Payments submission ID.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` (
    `brand_plan_id` BIGINT COMMENT 'Unique identifier for the brand plan. Primary key for the brand plan entity.',
    `access_strategy_id` BIGINT COMMENT 'Foreign key linking to market.access_strategy. Business justification: Brand plans incorporate market access strategies as key component defining payer engagement, formulary goals, and pricing approach. Strategic planning integration requires linking brand plan to its ac',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand (Drug Product or DP) that this plan covers. Links to the master brand/product entity.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Brand plans explicitly reference multiple budget categories. Links strategic plan to financial budget for execution tracking, variance analysis, and forecast accuracy.',
    `congress_event_id` BIGINT COMMENT 'Foreign key linking to medical.congress_event. Business justification: Brand plans specify key congress participation strategy, booth presence, satellite symposia, and commercial messaging aligned with medical affairs scientific activities at same congress. Critical for ',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Brand plans are built around regulatory exclusivity periods; commercial strategy, revenue forecasting, and market access planning depend on exclusivity protection timelines.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Brand plans execute through internal orders for campaigns, congress participation, market research. Links strategic plan to financial execution and cost tracking.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Brand plans are executed by specific legal entities with market authorization. Required for regulatory strategy alignment, market authorization ownership, financial consolidation, and intercompany tra',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Brand plans have budget allocations to specific cost centers. Required for financial planning, budget vs. actual tracking, promotional spend allocation, and commercial operations P&L by cost center.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: Brand plans drive profit center performance and revenue targets. Required for segment reporting, brand P&L, strategic portfolio management, and financial consolidation by therapeutic area or product l',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Brand plans are strategic documents for specific medicinal products. Plan execution tracking, milestone monitoring, and performance measurement against plan require direct product linkage. Real busine',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Brand planning depends on patent protection status; LOE planning, lifecycle strategy, and competitive positioning require direct patent linkage for strategic decision-making.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Brand plan ownership tracking is essential for commercial planning accountability and approval workflows. Plan_owner currently stores text name; FK enables proper organizational hierarchy tracking and',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Brand plans must align with promotional compliance requirements and regulatory frameworks. Links strategic plans to compliance oversight for promotional mix approval, budget compliance, and regulatory',
    `rd_capitalization_id` BIGINT COMMENT 'Foreign key linking to finance.rd_capitalization. Business justification: Brand plans for pre-launch products reference capitalized R&D costs that will be amortized post-launch. Required for launch economics and ROI analysis.',
    `approval_date` DATE COMMENT 'The date when the brand plan was formally approved by senior management or the commercial leadership team, authorizing execution and budget release.',
    `brand_positioning` STRING COMMENT 'The core brand positioning statement that defines how the brand is differentiated in the market and the value proposition communicated to Healthcare Professionals (HCPs) and patients.',
    `budget_currency` STRING COMMENT 'The three-letter ISO 4217 currency code for all financial amounts in this brand plan (e.g., USD, EUR, JPY).. Valid values are `^[A-Z]{3}$`',
    `channel_strategy` STRING COMMENT 'The multi-channel engagement strategy defining how the brand will reach HCPs and patients through field force, digital channels, medical science liaisons, patient support programs, and market access initiatives.',
    `competitive_landscape` STRING COMMENT 'Summary of the competitive environment, including key competitor brands, market share dynamics, and competitive threats or opportunities identified for the planning period.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this brand plan record was first created in the system. Audit trail field for data lineage and compliance.',
    `geography` STRING COMMENT 'The geographic market or region covered by this brand plan (e.g., USA, EUR, JPN, Global). Uses ISO 3166-1 alpha-3 country codes or regional groupings.',
    `indication` STRING COMMENT 'The primary disease indication or approved use for which the brand is marketed (e.g., Non-Small Cell Lung Cancer, Rheumatoid Arthritis). May reference ICD-10 or MedDRA coding.',
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
    `therapeutic_area` STRING COMMENT 'The therapeutic area or disease category that the brand addresses (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular, Neuroscience). Aligns with organizational therapeutic area structure.',
    CONSTRAINT pk_brand_plan PRIMARY KEY(`brand_plan_id`)
) COMMENT 'Annual or multi-year commercial brand plan serving as the unified planning, budgeting, and execution tracking entity for a brands commercial strategy. Captures strategic objectives, positioning, competitive differentiation, promotional mix, channel strategy, and KPI targets. Includes detailed promotional spend tracking by tactic (personal promotion, non-personal, digital, samples, speaker programs, congress) with planned budget, actual spend, variance, cost center, and brand P&L line attribution. Also tracks launch activity milestones for new product/indication launches including activity name, launch phase (pre-launch, launch, post-launch), activity type (field force training, formulary pull-through, KOL engagement, patient support activation), planned/actual dates, owner, status, and dependencies on regulatory approval milestones. Serves as the single commercial planning, financial execution, launch management, and brand P&L entity.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` (
    `kol_engagement_id` BIGINT COMMENT 'Unique identifier for the KOL engagement record. Primary key for tracking longitudinal relationships with Key Opinion Leaders across commercial and medical affairs activities.',
    `brand_id` BIGINT COMMENT 'Foreign key reference to the pharmaceutical brand or product associated with this KOL engagement. Links engagement activities to specific commercial products.',
    `conflict_of_interest_id` BIGINT COMMENT 'Foreign key linking to compliance.conflict_of_interest. Business justification: KOL relationships require COI assessment for advisory boards, consultancies, and research collaborations. Essential for bias management, transparency reporting, and compliance with institutional and r',
    `contract_id` BIGINT COMMENT 'Foreign key reference to the consulting or services contract governing this KOL engagement. Links to the legal agreement under which services are provided.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: KOL engagement ownership is critical for medical affairs and commercial collaboration tracking. Engagement_owner currently text; FK enables proper accountability for strategic HCP relationship managem',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: KOL engagements (advisory boards, consulting) are project-based activities requiring internal order for cost tracking, budget control, and transparency reporting compliance.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: KOL engagements create contractual and payment obligations for specific legal entities. Required for transparency reporting, tax compliance, FMV assessment by jurisdiction, and regulatory audit trails',
    `master_id` BIGINT COMMENT 'Foreign key reference to the Healthcare Professional master record who is designated as a Key Opinion Leader. Links to the HCP entity in the master data domain.',
    `medical_kol_profile_id` BIGINT COMMENT 'Foreign key linking to medical.medical_kol_profile. Business justification: Commercial KOL activities must reference medical affairs master KOL profile for strategic tier, influence score, engagement capacity limits, and COI status. Single source of truth for enterprise KOL ',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: KOL engagements focus on specific medicinal products for advisory boards and consulting. Strategic relationship management and transparency reporting require product linkage. Real business process: KO',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: KOL engagements discuss patented innovations; scientific exchange, advisory boards, and publication planning require patent awareness for accurate IP representation and compliance.',
    `payer_engagement_id` BIGINT COMMENT 'Foreign key linking to market.payer_engagement. Business justification: KOL engagements (advisory boards, publications) generate evidence presented in payer negotiations. Evidence generation and deployment process links KOL activities to payer meetings where insights are ',
    `principal_investigator_id` BIGINT COMMENT 'Foreign key linking to clinical.principal_investigator. Business justification: KOL advisory boards and consulting frequently involve trial investigators. Critical for transparency reporting (Sunshine Act/EFPIA), conflict of interest management, strategic medical affairs planning',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: KOL engagements require compliance review for transparency reporting, FMV assessment, and anti-bribery compliance. Links engagements to governing compliance framework for advisory boards, consultancie',
    `project_id` BIGINT COMMENT 'Foreign key linking to discovery.discovery_project. Business justification: KOLs are engaged during discovery phase as scientific advisors, steering committee members, or consultants on specific projects. Required for transparency reporting (Sunshine Act/EFPIA), conflict of i',
    `territory_id` BIGINT COMMENT 'Foreign key reference to the sales or medical affairs territory associated with this KOL engagement. Links engagement to geographic coverage areas.',
    `advisory_board_name` STRING COMMENT 'The name or identifier of the advisory board if the engagement type is advisory board participation. Used to group multiple KOL engagements under a single advisory board event.',
    `business_unit` STRING COMMENT 'The organizational business unit responsible for this KOL engagement (e.g., Commercial, Medical Affairs, Clinical Development). Supports cost allocation and organizational reporting.',
    `compliance_approval_date` DATE COMMENT 'The date on which compliance approval was granted for this KOL engagement. Required for audit trail and regulatory inspection readiness.',
    `compliance_approval_status` STRING COMMENT 'The approval status from the compliance and legal review process. All KOL engagements must receive compliance approval before execution per PhRMA Code and internal policies.. Valid values are `pending|approved|rejected|under_review`',
    `compliance_approver` STRING COMMENT 'Name or identifier of the compliance officer who approved this KOL engagement. Maintains accountability for compliance decisions.',
    `congress_name` STRING COMMENT 'The name of the medical congress or scientific conference associated with this engagement, if applicable. Relevant for congress presentation and advisory board engagements held at conferences.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this KOL engagement record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `engagement_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the engagement occurred. Required for regional compliance reporting and transparency obligations.. Valid values are `^[A-Z]{3}$`',
    `engagement_date` DATE COMMENT 'The date on which the KOL engagement activity occurred. Used for tracking engagement frequency and compliance reporting timelines.',
    `engagement_duration_hours` DECIMAL(18,2) COMMENT 'The total duration of the KOL engagement activity measured in hours. Used for fair market value assessment and resource planning.',
    `engagement_location` STRING COMMENT 'The physical or virtual location where the KOL engagement took place. May include city, venue name, or virtual platform identifier.',
    `engagement_status` STRING COMMENT 'Current lifecycle status of the KOL engagement. Tracks progression from planning through completion or cancellation, including compliance approval gates.. Valid values are `planned|confirmed|completed|cancelled|pending_approval`',
    `engagement_topic` STRING COMMENT 'The specific subject matter or agenda topic discussed during the KOL engagement. Provides context for the scientific or clinical focus of the interaction.',
    `engagement_type` STRING COMMENT 'The category of engagement activity conducted with the KOL. Distinguishes between advisory boards, speaker training sessions, publication reviews, congress presentations, consulting engagements, and investigator meetings.. Valid values are `advisory_board|speaker_training|publication_review|congress_presentation|consulting|investigator_meeting`',
    `fair_market_value_assessment` STRING COMMENT 'Assessment status indicating whether the honorarium and engagement terms comply with fair market value guidelines per PhRMA Code and internal policies.. Valid values are `compliant|under_review|non_compliant|not_applicable`',
    `honorarium_amount` DECIMAL(18,2) COMMENT 'The monetary compensation paid to the KOL for their participation in this engagement activity. Subject to fair market value assessment and transparency reporting.',
    `honorarium_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the honorarium payment (e.g., USD, EUR, GBP). Required for multi-country operations and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `indication` STRING COMMENT 'The specific disease indication or medical condition that is the focus of this KOL engagement. More granular than therapeutic area.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this KOL engagement record was last updated. Supports change tracking and audit requirements.',
    `modified_by` STRING COMMENT 'Identifier of the user or system that last modified this KOL engagement record. Maintains accountability for data changes.',
    `notes` STRING COMMENT 'Free-text field capturing additional context, outcomes, or observations from the KOL engagement. May include key discussion points, action items, or follow-up requirements.',
    `publication_title` STRING COMMENT 'The title of the scientific publication or manuscript being reviewed by the KOL, if the engagement type is publication review. Links engagement to publication planning activities.',
    `strategic_relationship_tier` STRING COMMENT 'Classification of the KOLs strategic importance to the organization. Tier 1 represents national/international thought leaders, Tier 2 regional influencers, Tier 3 local experts, and Emerging represents developing relationships.. Valid values are `tier_1_national|tier_2_regional|tier_3_local|emerging`',
    `therapeutic_area` STRING COMMENT 'The therapeutic area or disease category relevant to this KOL engagement (e.g., oncology, immunology, rare diseases, cardiovascular). Aligns with the companys core business focus areas.',
    `transparency_report_date` DATE COMMENT 'The date on which this KOL engagement was reported to the applicable transparency reporting system or regulatory authority.',
    `transparency_reporting_required` BOOLEAN COMMENT 'Boolean flag indicating whether this KOL engagement must be reported under transparency regulations such as the Sunshine Act (US), EFPIA Code (EU), or similar country-specific requirements.',
    `veeva_crm_activity_code` STRING COMMENT 'The unique activity identifier from Veeva CRM system linking this KOL engagement to the source system record. Enables traceability to operational CRM data.',
    CONSTRAINT pk_kol_engagement PRIMARY KEY(`kol_engagement_id`)
) COMMENT 'Tracks engagement activities with Key Opinion Leaders (KOLs) by the commercial and medical affairs teams. Captures KOL HCP ID, engagement type (advisory board, speaker training, publication review, congress presentation, consulting), engagement date, brand, therapeutic area, honorarium, compliance approval status, and strategic relationship tier. Distinct from speaker_engagement which is program-specific — this is the longitudinal KOL relationship management record.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` (
    `patient_support_program_id` BIGINT COMMENT 'Unique identifier for the patient support program record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: PSPs are administered by third-party hub vendors. While vendor_contract_id exists, direct vendor_id enables operational queries for vendor performance, contact lookup, audit status, and qualification ',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand (drug product) that this patient support program serves.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: PSP programs require budget tracking for gross-to-net impact, vendor payments, and patient benefit costs. Critical for revenue recognition and financial forecasting.',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: PSPs often operate at drug product level for pharmacy claims processing. NDC-level eligibility rules and benefit determination require drug product specificity. Real business process: copay card adjud',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Patient support programs are operated by specific legal entities. Required for program ownership determination, regulatory approval attribution, financial liability tracking, and transparency reportin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Patient support programs have dedicated cost centers for budget tracking. Required for program spend monitoring, gross-to-net accruals, budget vs. actual analysis, and commercial operations P&L.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: PSPs support patient access to specific medicinal products. Program design, eligibility criteria, and ROI analysis require product linkage. Real business process: PSP portfolio management and patient ',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Patient support programs support patented products; program design, duration, and investment decisions depend on patent protection status for strategic resource allocation.',
    `patient_access_program_id` BIGINT COMMENT 'Foreign key linking to market.patient_access_program. Business justification: Patient support programs (commercial) implement patient access programs (market access strategy). Links operational PSP execution to strategic market access program definition for tracking enrollment ',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: PSPs require HIPAA, anti-kickback statute, and transparency compliance. Links programs to compliance framework for patient privacy protection, eligibility verification, and regulatory reporting requir',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Patient support program ownership is essential for operational accountability, budget management, and vendor oversight. Program_owner currently text; FK enables proper tracking of responsible commerci',
    `supply_contract_id` BIGINT COMMENT 'Reference identifier for the legal contract with the administering vendor governing program operations and service level agreements.',
    `active_enrolled_patients` STRING COMMENT 'Current count of patients with active enrollment status in the program.',
    `adherence_rate_actual` DECIMAL(18,2) COMMENT 'Actual medication adherence rate (as percentage) achieved among enrolled patients, measured using prescription refill data or patient-reported outcomes.',
    `adherence_rate_target` DECIMAL(18,2) COMMENT 'Target medication adherence rate (as percentage) that the program aims to achieve among enrolled patients.',
    `benefit_type` STRING COMMENT 'Primary type of benefit or service provided to enrolled patients through this program.. Valid values are `co-pay card|free drug voucher|nurse support|reimbursement assistance|prior authorization support|patient education materials`',
    `business_unit` STRING COMMENT 'Business unit or division responsible for the program, typically aligned with therapeutic area or brand portfolio.',
    `cost_per_enrollment` DECIMAL(18,2) COMMENT 'Average cost to the program per patient enrollment, calculated as total spend divided by total enrollments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the patient support program record was first created in the system.',
    `eligibility_criteria` STRING COMMENT 'Detailed description of the criteria patients must meet to qualify for enrollment in the program, including income thresholds, insurance status, and clinical requirements.',
    `enrollment_channel` STRING COMMENT 'Primary channel through which patients can enroll in the support program.. Valid values are `hcp referral|patient direct|pharmacy|call center|web portal|mobile app`',
    `geography` STRING COMMENT 'Geographic scope of the program using three-letter ISO country codes (e.g., USA, GBR, DEU) or multi-country region if applicable.',
    `hipaa_compliant_flag` BOOLEAN COMMENT 'Indicates whether the program operations and vendor have been certified as compliant with HIPAA Privacy and Security Rules.',
    `income_threshold_amount` DECIMAL(18,2) COMMENT 'Maximum annual household income level for patient eligibility in financial assistance programs. Null if program does not have income restrictions.',
    `income_threshold_currency` STRING COMMENT 'Currency code for the income threshold amount using ISO 4217 three-letter codes.. Valid values are `USD|EUR|GBP|JPY|CNY`',
    `indication` STRING COMMENT 'Specific disease indication or condition for which the program provides support, aligned with the approved drug label.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the patient support program record was last updated in the system.',
    `launch_date` DATE COMMENT 'Date when the patient support program was officially launched and began accepting patient enrollments.',
    `max_benefit_amount` DECIMAL(18,2) COMMENT 'Maximum financial benefit amount per patient per year for co-pay assistance or free drug programs. Null if program does not have a cap.',
    `max_benefit_currency` STRING COMMENT 'Currency code for the maximum benefit amount using ISO 4217 three-letter codes.. Valid values are `USD|EUR|GBP|JPY|CNY`',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the patient support program record.',
    `profit_center` STRING COMMENT 'Profit center code for internal profitability analysis and brand-level profit and loss (P&L) reporting.',
    `program_budget_currency` STRING COMMENT 'Currency code for the program budget amount using ISO 4217 three-letter codes.. Valid values are `USD|EUR|GBP|JPY|CNY`',
    `program_status` STRING COMMENT 'Current operational status of the patient support program indicating whether it is accepting new enrollments.. Valid values are `active|inactive|suspended|pending launch|terminated`',
    `program_type` STRING COMMENT 'Classification of the patient support program based on the primary service provided to patients. [ENUM-REF-CANDIDATE: co-pay assistance|free drug program|nurse navigator|adherence support|hub services|patient education|reimbursement support — 7 candidates stripped; promote to reference product]',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval or notification for the patient support program where required by local health authorities.. Valid values are `approved|pending|not required|conditional`',
    `termination_date` DATE COMMENT 'Date when the patient support program was terminated or is scheduled to be terminated. Null for active programs.',
    `therapeutic_area` STRING COMMENT 'Primary therapeutic area or disease category that the program addresses (e.g., oncology, immunology, rare diseases).',
    `total_enrolled_patients` STRING COMMENT 'Cumulative count of unique patients who have enrolled in the program since launch.',
    `transparency_reporting_required` BOOLEAN COMMENT 'Indicates whether program benefits must be reported under Physician Payments Sunshine Act or equivalent transparency regulations.',
    `vendor_performance_score` DECIMAL(18,2) COMMENT 'Composite performance score (0-100 scale) for the administering vendor based on service level agreement (SLA) metrics including enrollment processing time, patient satisfaction, and compliance.',
    CONSTRAINT pk_patient_support_program PRIMARY KEY(`patient_support_program_id`)
) COMMENT 'Master record and enrollment ledger for patient support programs (PSPs). Program header captures program name, brand, program type (co-pay assistance, free drug, nurse navigator, adherence program, hub services), eligibility criteria, administering vendor, program KPIs, and vendor performance metrics. Enrollment detail captures individual patient enrollments including enrollment date, prescribing HCP, enrollment channel, eligibility verification status, benefit type granted (co-pay card, free drug voucher, nurse call), enrollment status, program exit reason, and adherence milestones. Supports access and adherence analytics, program ROI measurement, patient journey optimization, hub services vendor performance tracking, and HIPAA-compliant de-identified reporting.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` (
    `psp_enrollment_id` BIGINT COMMENT 'Unique identifier for the patient support program enrollment record. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Individual PSP benefit payments to pharmacies or patients create AP entries. Required for benefit payment reconciliation and gross-to-net accrual accuracy.',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand or product associated with this patient support program enrollment.',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Patient enrollments are for specific drug product prescriptions. Prescription fulfillment, adherence monitoring, and benefit utilization tracking require drug product linkage. Real business process: e',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: PSP enrollments create benefit obligations for specific legal entities. Required for financial liability tracking, gross-to-net accrual validation, regulatory compliance, and transparency reporting by',
    `master_id` BIGINT COMMENT 'Reference to the prescribing healthcare professional who enrolled or referred the patient to the program.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PSP enrollment audit trail requires employee tracking for HIPAA compliance and data integrity investigations. Modified_by currently text; FK enables proper audit trail linking to workforce records for',
    `named_patient_request_id` BIGINT COMMENT 'Foreign key linking to medical.named_patient_request. Business justification: Patient support programs may transition patients to named patient/compassionate use pathways for pre-approval access when commercial product unavailable. Operational handoff for continuity of care and',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: PSP enrollments support patented products; program eligibility, benefit design, and enrollment tracking align with IP protection for strategic program management.',
    `patient_id` BIGINT COMMENT 'Anonymized or de-identified patient identifier compliant with HIPAA privacy requirements. Does not contain direct personal identifiers.',
    `patient_support_program_id` BIGINT COMMENT 'Reference to the patient support program in which the patient is enrolled. Links to the master program definition.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory associated with this enrollment for commercial performance tracking.',
    `administering_vendor` STRING COMMENT 'Name of the third-party vendor or Contract Research Organization (CRO) administering the patient support program on behalf of the pharmaceutical company.',
    `benefit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the benefit amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `benefit_end_date` DATE COMMENT 'Date when the patient support program benefits expire or are scheduled to terminate. May be null for open-ended programs.',
    `benefit_start_date` DATE COMMENT 'Date when the patient support program benefits become active and available for use by the patient.',
    `benefit_type` STRING COMMENT 'Type of benefit or support service granted to the patient through this enrollment. May include financial assistance, clinical support, or educational resources.. Valid values are `copay_card|free_drug_voucher|nurse_support|patient_education|financial_assistance|adherence_coaching`',
    `consent_date` DATE COMMENT 'Date when patient consent for program participation was obtained.',
    `consent_obtained_flag` BOOLEAN COMMENT 'Indicates whether patient consent for program participation and data usage was obtained in compliance with HIPAA and privacy regulations.',
    `cost_center` STRING COMMENT 'Cost center code in the financial system (SAP S/4HANA CO module) to which program costs are allocated.',
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
    `profit_center` STRING COMMENT 'Profit center code in the financial system for brand-level P&L reporting and program ROI measurement.',
    `remaining_benefit_amount` DECIMAL(18,2) COMMENT 'Remaining financial benefit amount available to the patient under this enrollment.',
    `therapeutic_area` STRING COMMENT 'Therapeutic area or disease category for which the patient is receiving support (e.g., oncology, immunology, rare diseases).',
    `transparency_report_date` DATE COMMENT 'Date when transparency reporting for this enrollment was submitted to regulatory authorities.',
    `transparency_reporting_required` BOOLEAN COMMENT 'Indicates whether this enrollment requires reporting under Sunshine Act or other transparency regulations for value transfer to healthcare professionals.',
    CONSTRAINT pk_psp_enrollment PRIMARY KEY(`psp_enrollment_id`)
) COMMENT 'Transactional record of a patients enrollment in a patient support program. Captures enrollment date, program ID, patient reference (anonymized or de-identified per HIPAA), prescribing HCP, enrollment channel, eligibility verification status, benefit type granted (co-pay card, free drug voucher, nurse call), enrollment status, and program exit reason. Supports access and adherence analytics and program ROI measurement.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` (
    `contract_account_id` BIGINT COMMENT 'Unique identifier for the commercial contract account. Primary key for institutional customer accounts including hospital systems, IDNs, GPOs, specialty pharmacies, and retail pharmacy chains.',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Contract accounts are business partners in master data. Required for customer master synchronization, credit limit management, payment terms, order-to-cash integration, and ERP-CRM data consistency.',
    `employee_id` BIGINT COMMENT 'Reference to the sales representative or account manager assigned primary responsibility for this institutional account. Used for territory management and account coverage planning.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Contract accounts are customers of specific legal entities. Required for revenue recognition, intercompany transactions, credit management, tax compliance, and order-to-cash processing by legal entity',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Contract accounts may have licensing agreements; commercial terms, royalty obligations, and territory restrictions depend on IP licensing for accurate contract management.',
    `parent_account_contract_account_id` BIGINT COMMENT 'Reference to the parent contract account for hierarchical account structures. Used for IDN systems where individual hospitals roll up to a corporate parent. Null for top-level accounts.',
    `payer_account_id` BIGINT COMMENT 'Foreign key linking to market.payer_account. Business justification: Contract accounts may represent institutional payers (hospitals, health systems) that also have payer contracts. Account classification and contracting process links commercial accounts to payer entit',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory to which this account is assigned. Supports field force planning, quota allocation, and geographic performance tracking.',
    `account_name` STRING COMMENT 'Legal or trading name of the institutional customer account. Primary human-readable identifier for the account.',
    `account_number` STRING COMMENT 'Externally-known unique business identifier for the contract account. Used in commercial operations, invoicing, and customer communications. Typically assigned by ERP system (SAP SD module).. Valid values are `^[A-Z0-9]{8,15}$`',
    `account_status` STRING COMMENT 'Current lifecycle status of the contract account. Active accounts are eligible for orders and promotional activities. Suspended accounts have temporary restrictions. Closed accounts are no longer serviced.. Valid values are `active|inactive|pending|suspended|closed`',
    `account_type` STRING COMMENT 'Classification of the institutional customer account type. IDN = Integrated Delivery Network, GPO = Group Purchasing Organization. Determines sales strategy, pricing tier, and field force coverage model.. Valid values are `hospital_system|idn|gpo|specialty_pharmacy|retail_pharmacy_chain|clinic_network`',
    `annual_revenue_potential` DECIMAL(18,2) COMMENT 'Estimated annual revenue opportunity for this account based on market analysis, historical performance, and account size. Used for territory planning and resource allocation.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address for the institutional account. Used for invoicing and financial correspondence.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (suite, floor, building). Optional field for additional address details.',
    `billing_city` STRING COMMENT 'City name for the billing address of the institutional account.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address. Determines regulatory jurisdiction and tax treatment.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the billing address. Used for tax calculation and geographic analysis.',
    `billing_state_province` STRING COMMENT 'State or province code for the billing address. Used for tax jurisdiction determination and regulatory reporting.',
    `business_unit` STRING COMMENT 'Business unit or division responsible for managing this account. Used for P&L reporting and organizational alignment.',
    `contract_end_date` DATE COMMENT 'Expiration date of the current contract agreement. Triggers contract renewal workflow. Null for evergreen contracts without fixed expiration.',
    `contract_start_date` DATE COMMENT 'Effective start date of the current contract agreement with this institutional account. Pricing and terms become active on this date.',
    `contract_tier` STRING COMMENT 'Pricing and service tier assigned to the account based on volume commitments, GPO affiliation, and negotiated terms. Determines discount levels, rebate structures, and service level agreements.. Valid values are `platinum|gold|silver|bronze|standard`',
    `cost_center` STRING COMMENT 'Cost center code for account management expenses. Used for internal cost allocation and budget tracking.',
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
    `affairs_plan_id` BIGINT COMMENT 'Foreign key linking to medical.medical_affairs_plan. Business justification: Sales performance metrics by geography/therapeutic area inform medical affairs resource allocation, MSL headcount planning, and evidence generation priorities. Closed-loop feedback for medical strateg',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Sales performance approval workflow requires employee tracking for incentive compensation governance and financial controls. Approved_by currently text; FK enables proper manager hierarchy validation,',
    `brand_id` BIGINT COMMENT 'Identifier for the pharmaceutical brand or product for which sales performance is measured.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Commercial sales performance should link to finance budgets for sales budget tracking and variance analysis. This enables integrated financial planning and performance management across commercial and',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Sales performance is tracked by cost center for budget allocation. Required for budget vs. actual analysis, IC plan administration, promotional spend tracking, and commercial operations financial repo',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: Sales performance drives profit center results and revenue targets. Required for segment reporting, brand P&L, portfolio performance management, and financial consolidation by therapeutic area or geog',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Sales performance metrics (TRx, NRx, market share) are tracked at medicinal product level. Incentive compensation calculation and territory performance reporting require product linkage. Real business',
    `payer_account_id` BIGINT COMMENT 'Foreign key linking to market.payer_account. Business justification: Sales performance is tracked by payer account to measure impact of formulary position and contracts. Performance reporting and analytics process links sales metrics to payer accounts for ROI analysis.',
    `sales_rep_id` BIGINT COMMENT 'Identifier for the sales representative whose performance is being tracked. Links to employee or sales rep master data.',
    `territory_id` BIGINT COMMENT 'Identifier for the sales territory where performance is measured. Links to territory master data.',
    `actual_performance_amount` DECIMAL(18,2) COMMENT 'Actual sales performance achieved during the period, measured in the same units as quota (prescription volume or revenue).',
    `approval_date` DATE COMMENT 'Date when the sales performance record was approved by sales management for incentive compensation processing.',
    `business_unit` STRING COMMENT 'Business unit or division responsible for the brand and sales territory.',
    `call_attainment_percent` DECIMAL(18,2) COMMENT 'Percentage of target call frequency achieved, calculated as (call_frequency_achieved / call_frequency_target) * 100.',
    `call_frequency_achieved` STRING COMMENT 'Actual number of Healthcare Professional (HCP) calls completed by the sales representative during the performance period.',
    `call_frequency_target` STRING COMMENT 'Target number of Healthcare Professional (HCP) calls planned for the sales representative during the performance period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sales performance record was first created in the system.',
    `data_source` STRING COMMENT 'Source system or data provider for the sales performance metrics (e.g., Veeva CRM for call data, IQVIA for prescription data).. Valid values are `veeva_crm|iqvia|symphony_health|internal_calculation|manual_entry`',
    `geography` STRING COMMENT 'Three-letter ISO country code representing the geographic market where performance is measured (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
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
    `therapeutic_area` STRING COMMENT 'Therapeutic area or disease category for the brand (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular).',
    `total_prescriptions` BIGINT COMMENT 'Total number of prescriptions (TRx) written for the brand during the performance period, including both new and refill prescriptions.',
    `veeva_crm_record_code` STRING COMMENT 'External identifier linking this performance record to the corresponding record in Veeva CRM system.',
    CONSTRAINT pk_sales_performance PRIMARY KEY(`sales_performance_id`)
) COMMENT 'Periodic (weekly/monthly/quarterly) sales performance record at the territory and rep level by brand. Captures period, territory ID, rep ID, brand, total prescriptions (TRx), new prescriptions (NRx), market share, call frequency achieved vs. target, sample drop rate, and attainment vs. quota. Sourced from CRM and Rx data integration. Supports incentive compensation calculation and field force management.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` (
    `incentive_compensation_id` BIGINT COMMENT 'Unique identifier for the incentive compensation record. Primary key for this entity.',
    `brand_id` BIGINT COMMENT 'Identifier of the pharmaceutical brand for which this incentive compensation is calculated. May be null for multi-brand or territory-level plans.',
    `compensation_plan_id` BIGINT COMMENT 'Identifier of the compensation plan under which this incentive is calculated. Links to the compensation plan master record.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or finance officer who approved this incentive compensation record. Links to employee master data.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Incentive compensation payments are charged to specific cost centers. Required for expense allocation, budget tracking, payroll integration, and commercial operations P&L by cost center.',
    `performance_period_id` BIGINT COMMENT 'Identifier of the performance period for which this compensation is calculated. Links to the performance period reference.',
    `sales_rep_id` BIGINT COMMENT 'Identifier of the sales representative receiving this incentive compensation. Links to the sales representative master record.',
    `territory_id` BIGINT COMMENT 'Identifier of the sales territory assigned to the representative during this performance period.',
    `accelerator_amount` DECIMAL(18,2) COMMENT 'Additional bonus amount earned through accelerators for exceeding quota thresholds. Applied when attainment exceeds predefined levels (e.g., 120%, 150%).',
    `actual_sales_amount` DECIMAL(18,2) COMMENT 'Actual sales achieved by the representative during the performance period. Numerator for attainment percentage calculation.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Manual adjustment amount applied to the calculated bonus. May be positive (additional credit) or negative (deduction). Requires approval and documented reason.',
    `adjustment_reason` STRING COMMENT 'Business justification for any manual adjustment applied to the calculated bonus. Required when adjustment_amount is non-zero. Examples: territory realignment, data correction, special recognition.',
    `approval_date` DATE COMMENT 'Date on which the incentive compensation was approved by the designated approver.',
    `approval_status` STRING COMMENT 'Approval workflow status for this compensation record. Tracks managerial and finance approval before payout authorization.. Valid values are `pending|approved|rejected|escalated`',
    `attainment_percentage` DECIMAL(18,2) COMMENT 'Percentage of quota achieved by the representative. Calculated as (actual_sales_amount / quota_amount) * 100. Determines bonus tier eligibility.',
    `base_bonus_amount` DECIMAL(18,2) COMMENT 'Base incentive bonus amount calculated before any adjustments, accelerators, or deductions. Determined by attainment percentage and compensation plan formula.',
    `bonus_tier` STRING COMMENT 'Bonus tier achieved based on attainment percentage. Each tier corresponds to a different payout multiplier or fixed amount per the compensation plan.. Valid values are `tier_1|tier_2|tier_3|tier_4|tier_5|no_payout`',
    `business_unit` STRING COMMENT 'Business unit or division to which this incentive compensation is charged. Used for financial reporting and cost allocation.',
    `calculation_date` DATE COMMENT 'Date on which the incentive compensation was calculated by the system or compensation analyst.',
    `compensation_status` STRING COMMENT 'Current lifecycle status of the incentive compensation record. Tracks progression from calculation through approval to payout.. Valid values are `draft|calculated|approved|rejected|paid|adjusted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this incentive compensation record was first created in the system. Audit trail field for data lineage and compliance.',
    `crm_record_code` STRING COMMENT 'Identifier of the corresponding record in the CRM system (Veeva CRM or Salesforce Health Cloud) that tracks the sales activities underlying this compensation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record (quota, sales, bonus amounts).. Valid values are `^[A-Z]{3}$`',
    `erp_document_number` STRING COMMENT 'Document number generated in the ERP system (SAP S/4HANA) when this incentive compensation expense was posted to the general ledger.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this incentive compensation expense is posted. Aligns with chart of accounts for financial reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this incentive compensation record was last updated. Audit trail field for tracking changes and data lineage.',
    `modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this record. Audit trail field for compliance and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this incentive compensation record. Used for additional context, special circumstances, or audit trail documentation.',
    `payout_date` DATE COMMENT 'Date on which the incentive compensation was paid or is scheduled to be paid to the representative. Aligns with payroll cycle.',
    `payout_status` STRING COMMENT 'Status of the actual payment disbursement to the sales representative. Tracks integration with payroll or finance systems.. Valid values are `pending|scheduled|processed|paid|failed|cancelled`',
    `payroll_batch_reference` STRING COMMENT 'Identifier of the payroll batch in which this incentive compensation was included for payment processing. Links to HR payroll system.',
    `profit_center` STRING COMMENT 'Profit center code for internal profitability reporting. Used to track incentive compensation expense by profit-responsible unit.',
    `quota_amount` DECIMAL(18,2) COMMENT 'Sales quota target assigned to the representative for this performance period. Denominator for attainment percentage calculation.',
    `rejection_reason` STRING COMMENT 'Explanation provided when the compensation record is rejected during approval workflow. Required when approval_status is rejected.',
    `total_bonus_amount` DECIMAL(18,2) COMMENT 'Final incentive compensation amount payable to the representative. Sum of base_bonus_amount, accelerator_amount, and adjustment_amount.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this record. Audit trail field for compliance and data governance.',
    CONSTRAINT pk_incentive_compensation PRIMARY KEY(`incentive_compensation_id`)
) COMMENT 'Incentive compensation calculation record for each sales representative per performance period. Captures rep ID, performance period, quota, attainment percentage, bonus tier achieved, calculated bonus amount, payout status, adjustment reason, and approval status. Supports field force motivation, HR payroll integration, and commercial operations governance.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` (
    `copay_program_id` BIGINT COMMENT 'Unique identifier for the co-pay assistance program record. Primary key.',
    `accounts_payable_id` BIGINT COMMENT 'Foreign key linking to finance.accounts_payable. Business justification: Copay program vendor administration fees create AP obligations. Links program setup to financial payment tracking for vendor contract management.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Copay programs are administered by third-party pharmacy benefit vendors. While vendor_contract_id exists, direct vendor_id enables operational queries for vendor performance monitoring, contact inform',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand or product associated with this co-pay program.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Copay programs have explicit budgets for manufacturer contributions. Required for gross-to-net accrual accuracy and financial planning of patient access programs.',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Copay programs operate at drug product level for pharmacy claims adjudication. NDC-level eligibility rules and claims processing require drug product linkage. Real business process: pharmacy claims ad',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Copay programs are operated by specific legal entities. Required for gross-to-net accruals, regulatory compliance (anti-kickback safe harbor), financial liability tracking, and transparency reporting ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Copay programs have dedicated cost centers for spend tracking. Required for gross-to-net reconciliation, budget management, accrual validation, and commercial operations P&L by cost center.',
    `medical_heor_study_id` BIGINT COMMENT 'Foreign key linking to medical.medical_heor_study. Business justification: Copay program design (benefit levels, eligibility criteria) informed by HEOR evidence on patient affordability barriers, adherence economics, and willingness-to-pay. Strategic evidence-to-access linka',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: Copay programs reduce patient costs for specific medicinal products. Program design, gross-to-net forecasting, and ROI analysis require product linkage. Real business process: copay program portfolio ',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Copay programs are tied to patented brands; program lifecycle, budget planning, and termination dates align with patent protection status for ROI optimization.',
    `patient_access_program_id` BIGINT COMMENT 'Foreign key linking to market.patient_access_program. Business justification: Copay programs are a specific type of patient access program defined in market access strategy. Links commercial copay program execution to strategic market access program for tracking against access ',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Copay programs require anti-kickback statute compliance oversight and 340B exclusion monitoring. Links programs to compliance framework for regulatory risk management and government payer exclusion en',
    `active_enrolled_patients` STRING COMMENT 'Current count of patients with active enrollment status in the co-pay program.',
    `business_unit` STRING COMMENT 'Business unit or division responsible for managing and funding the co-pay program.',
    `commercial_insurance_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether patients must have commercial insurance coverage to be eligible for the co-pay program.',
    `compliance_approval_date` DATE COMMENT 'Date when the co-pay program received final compliance and legal approval for launch.',
    `compliance_review_status` STRING COMMENT 'Status of legal and compliance review for the co-pay program to ensure adherence to Anti-Kickback Statute, PhRMA Code, and promotional regulations.. Valid values are `approved|pending_review|rejected|not_required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the co-pay program record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this program (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `eligibility_criteria` STRING COMMENT 'Detailed description of patient eligibility requirements for enrollment in the co-pay program, including insurance type restrictions, income thresholds, and other qualifying conditions.',
    `exclusion_340b_flag` BOOLEAN COMMENT 'Boolean flag indicating whether prescriptions filled through 340B covered entities are excluded from this co-pay program to maintain compliance with federal regulations.',
    `exclusion_government_payer_flag` BOOLEAN COMMENT 'Boolean flag indicating whether patients with government-funded insurance (Medicare, Medicaid, TRICARE, VA) are excluded from program eligibility per Anti-Kickback Statute compliance.',
    `geography` STRING COMMENT 'Three-letter ISO country code indicating the geographic market where the co-pay program is available (e.g., USA, CAN, DEU).. Valid values are `^[A-Z]{3}$`',
    `gross_to_net_category` STRING COMMENT 'Gross-to-net deduction category for financial reporting, used to classify co-pay program costs in revenue reconciliation and brand P&L analysis.',
    `indication` STRING COMMENT 'Specific medical indication or condition for which the co-pay program provides assistance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the co-pay program record was last updated or modified.',
    `launch_date` DATE COMMENT 'Date when the co-pay program was officially launched and made available to patients.',
    `max_annual_benefit_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount of co-pay assistance a patient can receive per calendar year under this program.',
    `max_benefit_per_prescription` DECIMAL(18,2) COMMENT 'Maximum dollar amount of co-pay assistance available per individual prescription fill or claim.',
    `modified_by` STRING COMMENT 'User identifier or name of the person who last modified the co-pay program record.',
    `notes` STRING COMMENT 'Free-text field for additional program details, special instructions, or operational notes related to the co-pay program.',
    `profit_center` STRING COMMENT 'SAP profit center code for brand-level P&L reporting and gross-to-net deduction tracking.',
    `program_owner` STRING COMMENT 'Name or identifier of the commercial operations leader or brand manager responsible for the co-pay program strategy and performance.',
    `program_status` STRING COMMENT 'Current lifecycle status of the co-pay program indicating whether it is active, inactive, suspended, pending launch, or terminated.. Valid values are `active|inactive|suspended|pending_launch|terminated`',
    `program_type` STRING COMMENT 'Classification of the co-pay program mechanism (e.g., co-pay card, voucher, free trial, instant savings, rebate, patient assistance).. Valid values are `copay_card|voucher|free_trial|instant_savings|rebate|patient_assistance`',
    `termination_date` DATE COMMENT 'Date when the co-pay program was or will be terminated. Null for ongoing programs.',
    `therapeutic_area` STRING COMMENT 'Therapeutic area or disease category that the co-pay program supports (e.g., oncology, immunology, rare diseases).',
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
    `cogs_entry_id` BIGINT COMMENT 'Foreign key linking to finance.cogs_entry. Business justification: Copay redemptions affect product COGS through gross-to-net impact. Manufacturer contributions reduce net revenue and must be tracked against product cost.',
    `copay_program_id` BIGINT COMMENT 'Reference to the patient support program under which this co-pay card or voucher was issued.',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Copay redemptions are for specific drug products dispensed. Product-level redemption analytics and gross-to-net reconciliation require drug product linkage. Real business process: redemption reporting',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Copay redemptions create financial obligations for specific legal entities. Required for accrual validation, gross-to-net calculation, financial reporting, and audit trail of payment entity for each r',
    `gross_to_net_adjustment_id` BIGINT COMMENT 'Foreign key linking to market.gross_to_net_adjustment. Business justification: Copay redemptions drive gross-to-net adjustments for manufacturer copay contributions. Financial reconciliation process requires linking redemption transactions to GTN accruals for revenue recognition',
    `patient_id` BIGINT COMMENT 'De-identified or tokenized patient identifier used by the co-pay program administrator to track individual patient utilization while maintaining HIPAA compliance.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory in which the pharmacy or prescriber is located, used for sales force performance tracking and territory alignment.',
    `vendor_id` BIGINT COMMENT 'Identifier for the third-party vendor or pharmacy benefit manager administering the co-pay program on behalf of the manufacturer.',
    `cost_center` STRING COMMENT 'SAP cost center code to which the manufacturer contribution expense is allocated for financial reporting and budget tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this transaction (e.g., USD, EUR, CAD).. Valid values are `^[A-Z]{3}$`',
    `days_supply` STRING COMMENT 'Number of days the dispensed quantity is intended to last based on the prescribed dosing regimen.',
    `geography` STRING COMMENT 'Three-letter ISO country code indicating the country where the redemption occurred.. Valid values are `^[A-Z]{3}$`',
    `indication` STRING COMMENT 'The specific medical indication or condition for which the product was prescribed and dispensed.',
    `insurance_paid_amount` DECIMAL(18,2) COMMENT 'The amount paid by the patients insurance plan or pharmacy benefit manager toward the prescription cost.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this redemption record was last updated, reflecting status changes, reversals, or data corrections.',
    `patient_out_of_pocket_amount` DECIMAL(18,2) COMMENT 'The amount the patient paid out-of-pocket after applying insurance coverage and manufacturer co-pay assistance.',
    `payer_adjudication_status` STRING COMMENT 'Status of the insurance claim adjudication by the pharmacy benefit manager or payer, indicating whether the claim was approved, denied, or partially approved.. Valid values are `approved|denied|pending|partial_approval`',
    `pharmacy_chain_code` STRING COMMENT 'Code identifying the pharmacy chain or network to which the dispensing pharmacy belongs (e.g., CVS, Walgreens, independent).',
    `pharmacy_name` STRING COMMENT 'Name of the pharmacy or retail location where the co-pay card was redeemed.',
    `pharmacy_npi` STRING COMMENT 'The 10-digit National Provider Identifier of the pharmacy where the redemption occurred. NPI is the unique identifier for healthcare providers in the United States.. Valid values are `^[0-9]{10}$`',
    `prescriber_npi` STRING COMMENT 'The 10-digit National Provider Identifier of the healthcare professional who wrote the prescription.. Valid values are `^[0-9]{10}$`',
    `prescriber_specialty` STRING COMMENT 'Medical specialty of the prescribing healthcare professional (e.g., oncologist, rheumatologist, endocrinologist).',
    `prescription_number` STRING COMMENT 'Pharmacy-assigned prescription number for the dispensed medication associated with this redemption.',
    `profit_center` STRING COMMENT 'SAP profit center code associated with the brand for which the co-pay assistance was provided, used for P&L segmentation.',
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

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` (
    `commercial_formulary_position_id` BIGINT COMMENT 'Primary key for commercial_formulary_position',
    `brand_id` BIGINT COMMENT 'Foreign key linking to the pharmaceutical brand that is being placed on the payers formulary',
    `position_id` BIGINT COMMENT 'Unique surrogate identifier for this formulary position record',
    `payer_account_id` BIGINT COMMENT 'Foreign key linking to the payer account whose formulary includes this brand',
    `contract_reference_number` STRING COMMENT 'The contract or agreement reference number governing the commercial terms of this formulary position.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this formulary position record was first created in the market access system.',
    `effective_date` DATE COMMENT 'The date on which this formulary position became or will become effective. Explicitly identified in detection phase relationship data.',
    `formulary_status` STRING COMMENT 'Current lifecycle status of this formulary position. Explicitly identified in detection phase relationship data.',
    `formulary_tier` STRING COMMENT 'The tier placement assigned to this brand on this payers formulary, determining patient cost-sharing and access. Explicitly identified in detection phase relationship data.',
    `lives_covered` BIGINT COMMENT 'The number of covered lives under this payer account that have access to this brand under this formulary position. Explicitly identified in detection phase relationship data.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether this payer requires prior authorization for coverage of this specific brand. Explicitly identified in detection phase relationship data. This is relationship-specific and differs from the payer-level attribute which indicates general PA policy.',
    `pt_committee_approval_date` DATE COMMENT 'The date on which the payers Pharmacy and Therapeutics committee approved this formulary position for this brand.',
    `quantity_limit_flag` BOOLEAN COMMENT 'Indicates whether quantity limits apply to this brand under this payers coverage. Explicitly identified in detection phase relationship data.',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'The negotiated rebate percentage paid to this payer for this brand, expressed as a percentage of WAC or other agreed basis. Explicitly identified in detection phase relationship data.',
    `rebate_tier` STRING COMMENT 'The rebate tier classification negotiated for this brand with this payer, determining the rebate structure. Explicitly identified in detection phase relationship data.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether this payer mandates step therapy protocols before covering this specific brand. Explicitly identified in detection phase relationship data. This is relationship-specific and differs from the payer-level attribute which indicates general step therapy policy.',
    `termination_date` DATE COMMENT 'The date on which this formulary position was terminated or is scheduled to terminate. Explicitly identified in detection phase relationship data.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to this formulary position record.',
    CONSTRAINT pk_commercial_formulary_position PRIMARY KEY(`commercial_formulary_position_id`)
) COMMENT 'This association product represents the formulary placement contract between a pharmaceutical brand and a payer account. It captures the negotiated coverage terms, restrictions, and rebate arrangements that govern how the payer will cover the brand for its members. Each record links one brand to one payer account with attributes that exist only in the context of this specific formulary placement relationship.. Existence Justification: In pharmaceutical market access operations, each brand must secure formulary placement with multiple payers to ensure patient access across different health plans, and each payer maintains formularies covering hundreds of brands across therapeutic areas. The formulary position is an actively managed business entity where market access teams negotiate tier placement, utilization management restrictions, and rebate terms with each payer for each brand. This relationship has substantial relationship-specific data including tier, restrictions, rebates, and coverage dates that belong to neither the brand nor the payer alone.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` (
    `brand_supply_agreement_id` BIGINT COMMENT 'Unique identifier for the brand-vendor supply agreement record',
    `brand_id` BIGINT COMMENT 'Foreign key linking to the pharmaceutical brand being supplied',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor supplying materials for the brand',
    `annual_spend_allocation` DECIMAL(18,2) COMMENT 'Planned or actual annual procurement spend allocated to this vendor for this brand in USD. Used for spend analysis, vendor performance tracking, and multi-sourcing strategy optimization.',
    `approval_date` DATE COMMENT 'Date when the vendor was approved to supply materials for this brand following successful completion of qualification activities',
    `approved_material_category` STRING COMMENT 'The category of materials or services this vendor is qualified to supply for this specific brand (e.g., API, excipient, packaging material). A vendor may supply different material categories for different brands based on qualification scope.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this brand-vendor supply agreement record was first created',
    `last_quality_review_date` DATE COMMENT 'Date of the most recent quality review conducted for this vendor in the context of supplying this specific brand',
    `next_quality_review_due_date` DATE COMMENT 'Scheduled date for the next quality review of this vendor for this brand',
    `primary_supplier_flag` BOOLEAN COMMENT 'Indicates whether this vendor is designated as the primary supplier for the approved material category for this brand. Brands typically have one primary and multiple secondary suppliers per material category for supply continuity.',
    `qualification_status` STRING COMMENT 'Current qualification status of this vendor for supplying this specific brand. Reflects the outcome of brand-specific vendor qualification assessments including quality audits, regulatory compliance, and technical capability reviews.',
    `risk_tier` STRING COMMENT 'Risk classification for this brand-vendor supply relationship based on factors including single-source dependency, geopolitical risk, quality history, and business continuity. Used for supply chain risk management and contingency planning at the brand level.',
    `supply_agreement_effective_date` DATE COMMENT 'Date when the supply agreement for this brand-vendor relationship became effective',
    `supply_agreement_expiry_date` DATE COMMENT 'Date when the supply agreement for this brand-vendor relationship expires and requires renewal',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this brand-vendor supply agreement record',
    CONSTRAINT pk_brand_supply_agreement PRIMARY KEY(`brand_supply_agreement_id`)
) COMMENT 'This association product represents the supply contract between a pharmaceutical brand and its approved vendors. It captures the qualification status, approved material categories, risk assessment, and spend allocation for each brand-vendor relationship. Each record links one brand to one vendor with attributes that exist only in the context of this supply relationship, enabling supply chain risk management, multi-sourcing strategy, and procurement planning at the brand level.. Existence Justification: In pharmaceutical operations, brands require materials from multiple vendors across different categories (API suppliers, excipient suppliers, packaging vendors, CMOs), and vendors supply materials for multiple brands in their portfolio. Procurement teams actively manage brand-vendor supply agreements as operational entities, tracking qualification status, approved material categories, risk tier, and spend allocation for each brand-vendor pair. This is a core supply chain management process, not an analytical correlation.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`performance_period` (
    `performance_period_id` BIGINT COMMENT 'Primary key for performance_period',
    `plan_id` BIGINT COMMENT 'Reference to the incentive compensation plan that governs this performance period. Links to the incentive plan master table.',
    `prior_performance_period_id` BIGINT COMMENT 'Self-referencing FK on performance_period (prior_performance_period_id)',
    `brand_focus` STRING COMMENT 'Specific brand or product line that is the focus of this performance period. Null if period applies to all brands.',
    `business_days_count` STRING COMMENT 'The number of business days (excluding weekends and holidays) within the performance period, used for sales activity normalization.',
    `calendar_year` STRING COMMENT 'The calendar year associated with this performance period (e.g., 2024).',
    `compliance_framework` STRING COMMENT 'The regulatory compliance framework(s) applicable to commercial activities during this performance period (e.g., PhRMA Code, Sunshine Act, ABPI Code). Supports audit and transparency reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this performance period record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `crm_system_version` STRING COMMENT 'The version of the CRM system (Veeva CRM or Salesforce Health Cloud) in use during this performance period. Supports data lineage and system integration tracking.',
    `duration_days` STRING COMMENT 'The total number of calendar days in the performance period, calculated from start_date to end_date inclusive.',
    `end_date` DATE COMMENT 'The date when the performance period ends. Format: yyyy-MM-dd.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter within the fiscal year (1, 2, 3, or 4). Null for non-quarterly periods.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this performance period belongs (e.g., 2024).',
    `hcp_engagement_target` STRING COMMENT 'The target number of unique Healthcare Professional (HCP) engagements (calls, meetings, events) to be achieved during this performance period.',
    `is_current_period` BOOLEAN COMMENT 'Boolean flag indicating whether this is the current active performance period (True) or not (False). Only one period should be current at any time.',
    `kol_interaction_target` STRING COMMENT 'The target number of interactions with Key Opinion Leaders (KOLs) during this performance period. Supports strategic relationship management.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or business notes related to this performance period (e.g., market conditions, strategic initiatives).',
    `period_code` STRING COMMENT 'Business identifier code for the performance period, used for external reference and reporting (e.g., Q1-2024, FY2024-H1).',
    `period_name` STRING COMMENT 'Human-readable name or label for the performance period (e.g., Q1 2024 Sales Cycle, FY2024 First Half).',
    `period_type` STRING COMMENT 'Classification of the performance period by duration and business cycle (quarterly, semi-annual, annual, monthly, or custom).',
    `product_launch_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a new product launch occurred during this performance period (True) or not (False). Impacts sales strategy and resource allocation.',
    `promotional_material_version` STRING COMMENT 'The approved version or release of promotional materials (Veeva PromoMats) authorized for use during this performance period. Ensures compliance with promotional regulations.',
    `quota_allocation_method` STRING COMMENT 'The methodology used to allocate sales quotas during this performance period: territory-based, rep-based, team-based, or hybrid.',
    `reporting_region` STRING COMMENT 'Geographic region or market for which this performance period applies (e.g., North America, EMEA, APAC, Global). Supports regional performance tracking.',
    `sales_target_amount` DECIMAL(18,2) COMMENT 'The aggregate sales revenue target set for this performance period, in USD. Used for performance evaluation and incentive compensation.',
    `sample_distribution_quota` STRING COMMENT 'The maximum number of product samples authorized for distribution during this performance period. Supports compliance with sample distribution regulations.',
    `speaker_program_budget` DECIMAL(18,2) COMMENT 'The allocated budget for speaker programs and Key Opinion Leader (KOL) engagements during this performance period, in USD.',
    `start_date` DATE COMMENT 'The date when the performance period begins. Format: yyyy-MM-dd.',
    `performance_period_status` STRING COMMENT 'Current lifecycle status of the performance period: planned (future), active (current), closed (completed), or archived (historical).',
    `territory_realignment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether sales territory realignment occurred at the start of this performance period (True) or not (False). Impacts quota and performance tracking.',
    `therapeutic_area` STRING COMMENT 'Primary therapeutic area focus for this performance period (e.g., Oncology, Immunology, Rare Diseases). Null if period applies across all therapeutic areas.',
    `updated_by` STRING COMMENT 'The username or identifier of the user who last modified this performance period record. Supports audit trail and data governance.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this performance period record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `created_by` STRING COMMENT 'The username or identifier of the user who created this performance period record. Supports audit trail and data governance.',
    CONSTRAINT pk_performance_period PRIMARY KEY(`performance_period_id`)
) COMMENT 'Master reference table for performance_period. Referenced by performance_period_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`district` (
    `district_id` BIGINT COMMENT 'Primary key for district',
    `employee_id` BIGINT COMMENT 'Reference to the employee serving as district manager responsible for this district.',
    `region_id` BIGINT COMMENT 'Reference to the parent region in the sales territory hierarchy.',
    `parent_district_id` BIGINT COMMENT 'Self-referencing FK on district (parent_district_id)',
    `alignment_period` STRING COMMENT 'The planning period for which this district configuration is aligned (e.g., 2024-Q1, 2024-H1, 2024-FY).',
    `annual_sales_target` DECIMAL(18,2) COMMENT 'Annual revenue target assigned to the district in USD.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Annual operating budget allocated to the district for promotional activities and operations in USD.',
    `compliance_certification_date` DATE COMMENT 'Date when the district last completed required compliance training and certification for PhRMA code and promotional regulations.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the district operates.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the district record was first created in the system.',
    `district_code` STRING COMMENT 'Business identifier code for the district used in external systems and reporting.',
    `district_type` STRING COMMENT 'Classification of the district based on therapeutic area or customer segment focus.',
    `effective_end_date` DATE COMMENT 'Date when the district was deactivated or restructured. Null for currently active districts.',
    `effective_start_date` DATE COMMENT 'Date when the district became active in the territory structure.',
    `geographic_coverage` STRING COMMENT 'Description of the geographic area covered by the district, including states, counties, or postal codes.',
    `headquarters_city` STRING COMMENT 'City where the district office or primary meeting location is based.',
    `headquarters_postal_code` STRING COMMENT 'Postal code for the district headquarters location.',
    `headquarters_state` STRING COMMENT 'Two-letter state or province code for the district headquarters location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the district record was last updated.',
    `launch_readiness_status` STRING COMMENT 'Indicates whether the district is prepared for new product launches and promotional campaigns.',
    `district_name` STRING COMMENT 'Full name of the sales district.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special considerations, or operational details about the district.',
    `priority_tier` STRING COMMENT 'Strategic priority classification of the district based on market potential and business importance.',
    `sales_force_size` STRING COMMENT 'Number of sales representatives assigned to this district.',
    `salesforce_territory_code` STRING COMMENT 'External identifier for the district in Salesforce Health Cloud for cross-system alignment.',
    `district_status` STRING COMMENT 'Current operational status of the district in the territory hierarchy.',
    `target_hcp_count` STRING COMMENT 'Total number of healthcare professionals targeted for engagement within this district.',
    `therapeutic_area` STRING COMMENT 'Primary therapeutic area focus for the district aligned with product portfolio.',
    `veeva_crm_territory_code` STRING COMMENT 'External identifier for the district in Veeva CRM system for integration and synchronization.',
    CONSTRAINT pk_district PRIMARY KEY(`district_id`)
) COMMENT 'Master reference table for district. Referenced by district_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`region` (
    `region_id` BIGINT COMMENT 'Primary key for region',
    `parent_region_id` BIGINT COMMENT 'Reference to the parent region in the organizational hierarchy. Null for top-level regions.',
    `annual_revenue_target_usd` DECIMAL(18,2) COMMENT 'Annual sales revenue target for the region in US dollars. Used for performance tracking and incentive compensation.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for single-country regions (e.g., USA, DEU, JPN). Null for multi-country regions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this region record was first created in the system. Used for audit and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial reporting and planning in this region (e.g., USD, EUR, JPY, GBP).',
    `effective_end_date` DATE COMMENT 'Date when the region was or will be retired, merged, or deactivated. Null for currently active regions.',
    `effective_start_date` DATE COMMENT 'Date when the region became or will become operationally active. Used for historical tracking and planning.',
    `geographic_scope` STRING COMMENT 'Textual description of the geographic coverage (e.g., California, Nevada, Arizona, Germany and Austria, Southeast Asia excluding Singapore).',
    `hierarchy_level` STRING COMMENT 'Numeric level in the regional hierarchy (e.g., 1=Global, 2=Theater, 3=Country, 4=Area, 5=Territory). Used for organizational rollup and reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this region record was last updated. Used for change tracking and audit.',
    `market_potential_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) representing the commercial opportunity and growth potential of the region based on patient population, prescriber density, and market access.',
    `notes` STRING COMMENT 'Free-text field for additional context, special considerations, or operational notes about the region (e.g., pending reorganization, special compliance requirements, market access challenges).',
    `phrma_code_applicable` BOOLEAN COMMENT 'Indicates whether the PhRMA Code on Interactions with Healthcare Professionals applies to promotional activities in this region (typically US regions).',
    `region_code` STRING COMMENT 'Short alphanumeric code used to identify the region in operational systems and reports. Externally-known business identifier.',
    `region_name` STRING COMMENT 'Full descriptive name of the commercial region (e.g., Northeast US, EMEA Central, Asia Pacific South).',
    `region_type` STRING COMMENT 'Classification of the region based on its organizational purpose: geographic (territory-based), therapeutic (disease area focus), strategic (key account clusters), hybrid (combination), operational (sales operations), or market_access (payer/reimbursement focus).',
    `regional_manager_email` STRING COMMENT 'Corporate email address of the regional manager for operational communication.',
    `regional_manager_name` STRING COMMENT 'Full name of the regional sales manager or commercial leader responsible for this region.',
    `regulatory_environment` STRING COMMENT 'Classification of the promotional and market access regulatory environment: permissive (minimal restrictions), moderate (standard controls), restrictive (significant limitations), highly_restrictive (severe constraints on promotional activities).',
    `sales_force_size` STRING COMMENT 'Number of field sales representatives assigned to this region. Used for capacity planning and resource allocation.',
    `salesforce_health_cloud_enabled` BOOLEAN COMMENT 'Indicates whether Salesforce Health Cloud is deployed for patient services, case management, or specialty pharmacy support in this region.',
    `sample_distribution_allowed` BOOLEAN COMMENT 'Indicates whether pharmaceutical product sampling to healthcare professionals is permitted by regulation and company policy in this region.',
    `speaker_program_allowed` BOOLEAN COMMENT 'Indicates whether healthcare professional speaker programs and advisory boards are permitted in this region per local regulations and compliance policies.',
    `region_status` STRING COMMENT 'Current lifecycle status of the region. Active regions are operational; planned regions are in setup; suspended regions are temporarily inactive; merged regions have been consolidated; retired regions are no longer in use.',
    `sunshine_act_reporting_required` BOOLEAN COMMENT 'Indicates whether Open Payments (Sunshine Act) transparency reporting is required for transfers of value to healthcare professionals in this region (US only).',
    `target_hco_count` STRING COMMENT 'Number of healthcare organizations (hospitals, clinics, health systems, integrated delivery networks) targeted within this region.',
    `target_hcp_count` STRING COMMENT 'Number of healthcare professionals (physicians, specialists, prescribers) targeted for engagement within this region.',
    `therapeutic_area` STRING COMMENT 'Primary therapeutic area focus for therapeutic or hybrid regions (e.g., Oncology, Immunology, Rare Diseases, Cardiovascular). Null for purely geographic regions.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the regions primary operational time zone (e.g., America/New_York, Europe/Berlin, Asia/Tokyo). Used for scheduling and reporting.',
    `veeva_crm_enabled` BOOLEAN COMMENT 'Indicates whether Veeva CRM is deployed and operational for sales force automation in this region.',
    CONSTRAINT pk_region PRIMARY KEY(`region_id`)
) COMMENT 'Master reference table for region. Referenced by region_id.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` (
    `sales_order_id` BIGINT COMMENT 'Primary key for sales_order',
    `address_id` BIGINT COMMENT 'Reference to the billing address for invoicing purposes.',
    `brand_id` BIGINT COMMENT 'Reference to the pharmaceutical brand or product line associated with this order.',
    `brand_plan_id` BIGINT COMMENT 'Reference to the promotional campaign or marketing initiative associated with this order, if applicable.',
    `contract_account_id` BIGINT COMMENT 'Reference to the customer or healthcare organization that placed the sales order.',
    `contract_contract_account_id` BIGINT COMMENT 'Reference to the pricing contract or agreement under which this order is placed.',
    `master_id` BIGINT COMMENT 'Reference to the healthcare professional associated with this sales order, if applicable.',
    `sales_rep_id` BIGINT COMMENT 'Reference to the sales representative who facilitated or is credited with this order.',
    `ship_to_address_id` BIGINT COMMENT 'Reference to the shipping address where the order should be delivered.',
    `territory_id` BIGINT COMMENT 'Reference to the sales territory in which this order was placed.',
    `reference_sales_order_id` BIGINT COMMENT 'Self-referencing FK on sales_order (reference_sales_order_id)',
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
    `therapeutic_area` STRING COMMENT 'The therapeutic area or disease category that the ordered products address.',
    CONSTRAINT pk_sales_order PRIMARY KEY(`sales_order_id`)
) COMMENT 'Master reference table for sales_order. Referenced by sales_order_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_district_id` FOREIGN KEY (`district_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`district`(`district_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ADD CONSTRAINT `fk_commercial_territory_region_id` FOREIGN KEY (`region_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`region`(`region_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_district_id` FOREIGN KEY (`district_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`district`(`district_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_region_id` FOREIGN KEY (`region_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`region`(`region_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ADD CONSTRAINT `fk_commercial_sales_rep_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ADD CONSTRAINT `fk_commercial_hcp_target_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_promo_material_id` FOREIGN KEY (`promo_material_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`promo_material`(`promo_material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ADD CONSTRAINT `fk_commercial_call_activity_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_call_activity_id` FOREIGN KEY (`call_activity_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`call_activity`(`call_activity_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ADD CONSTRAINT `fk_commercial_sample_management_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ADD CONSTRAINT `fk_commercial_promo_material_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_prior_submission_mlr_review_id` FOREIGN KEY (`prior_submission_mlr_review_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`mlr_review`(`mlr_review_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ADD CONSTRAINT `fk_commercial_mlr_review_promo_material_id` FOREIGN KEY (`promo_material_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`promo_material`(`promo_material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_promo_material_id` FOREIGN KEY (`promo_material_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`promo_material`(`promo_material_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ADD CONSTRAINT `fk_commercial_commercial_speaker_program_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ADD CONSTRAINT `fk_commercial_speaker_engagement_commercial_speaker_program_id` FOREIGN KEY (`commercial_speaker_program_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program`(`commercial_speaker_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ADD CONSTRAINT `fk_commercial_speaker_engagement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ADD CONSTRAINT `fk_commercial_brand_plan_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ADD CONSTRAINT `fk_commercial_kol_engagement_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ADD CONSTRAINT `fk_commercial_patient_support_program_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_patient_support_program_id` FOREIGN KEY (`patient_support_program_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`patient_support_program`(`patient_support_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ADD CONSTRAINT `fk_commercial_psp_enrollment_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_parent_account_contract_account_id` FOREIGN KEY (`parent_account_contract_account_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`contract_account`(`contract_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ADD CONSTRAINT `fk_commercial_contract_account_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ADD CONSTRAINT `fk_commercial_sales_performance_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ADD CONSTRAINT `fk_commercial_incentive_compensation_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ADD CONSTRAINT `fk_commercial_incentive_compensation_performance_period_id` FOREIGN KEY (`performance_period_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`performance_period`(`performance_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ADD CONSTRAINT `fk_commercial_incentive_compensation_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ADD CONSTRAINT `fk_commercial_incentive_compensation_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ADD CONSTRAINT `fk_commercial_copay_program_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_copay_program_id` FOREIGN KEY (`copay_program_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`copay_program`(`copay_program_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ADD CONSTRAINT `fk_commercial_copay_redemption_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ADD CONSTRAINT `fk_commercial_commercial_formulary_position_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ADD CONSTRAINT `fk_commercial_brand_supply_agreement_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`performance_period` ADD CONSTRAINT `fk_commercial_performance_period_prior_performance_period_id` FOREIGN KEY (`prior_performance_period_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`performance_period`(`performance_period_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`district` ADD CONSTRAINT `fk_commercial_district_region_id` FOREIGN KEY (`region_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`region`(`region_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`district` ADD CONSTRAINT `fk_commercial_district_parent_district_id` FOREIGN KEY (`parent_district_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`district`(`district_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`region` ADD CONSTRAINT `fk_commercial_region_parent_region_id` FOREIGN KEY (`parent_region_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`region`(`region_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_brand_id` FOREIGN KEY (`brand_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand`(`brand_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_brand_plan_id` FOREIGN KEY (`brand_plan_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`brand_plan`(`brand_plan_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_contract_account_id` FOREIGN KEY (`contract_account_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`contract_account`(`contract_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_contract_contract_account_id` FOREIGN KEY (`contract_contract_account_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`contract_account`(`contract_account_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_sales_rep_id` FOREIGN KEY (`sales_rep_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_rep`(`sales_rep_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_territory_id` FOREIGN KEY (`territory_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`territory`(`territory_id`);
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ADD CONSTRAINT `fk_commercial_sales_order_reference_sales_order_id` FOREIGN KEY (`reference_sales_order_id`) REFERENCES `pharmaceuticals_ecm`.`commercial`.`sales_order`(`sales_order_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`commercial` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `pharmaceuticals_ecm`.`commercial` SET TAGS ('dbx_domain' = 'commercial');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` SET TAGS ('dbx_subdomain' = 'brand_management');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `affairs_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Affairs Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `compound_id` SET TAGS ('dbx_business_glossary_term' = 'Compound Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `hta_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Hta Submission Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `masterdata_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Ndc Code Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `molecular_target_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Target Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `pricing_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Decision Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Project Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `royalty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Royalty Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `sourcing_material_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Sourcing Material Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Approved Indication');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `primary_market` SET TAGS ('dbx_business_glossary_term' = 'Primary Market Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `primary_market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'SAP Profit Center');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `rems_required` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Required');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `sample_eligible` SET TAGS ('dbx_business_glossary_term' = 'Sample Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `sap_material_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Material Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `strategy_statement` SET TAGS ('dbx_business_glossary_term' = 'Brand Strategy Statement');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `strategy_statement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `sunshine_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `target_patient_population` SET TAGS ('dbx_business_glossary_term' = 'Target Patient Population');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand` ALTER COLUMN `veeva_crm_product_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva CRM Product Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `district_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `region_id` SET TAGS ('dbx_internal' = 'true');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`territory` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `annual_call_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Call Target');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_rep` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Plan ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `market_formulary_position_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Position Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `msl_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Msl Engagement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `veeva_crm_record_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva CRM Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`hcp_target` ALTER COLUMN `ytd_call_count` SET TAGS ('dbx_business_glossary_term' = 'Year-to-Date (YTD) Call Count');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `call_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Call Activity ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Detailed Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `hco_master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Organization (HCO) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `inquiry_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Inquiry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `investigational_site_id` SET TAGS ('dbx_business_glossary_term' = 'Investigational Site Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `market_formulary_position_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Position Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `molecular_target_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Target Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`call_activity` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `call_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Call Activity ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `cogs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cogs Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `market_formulary_position_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Position Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Material Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment Reason');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `discrepancy_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Discrepancy Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Sample Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `hcp_dea_number` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Drug Enforcement Administration (DEA) Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `hcp_dea_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{7}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `hcp_dea_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `hcp_license_number` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) License Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `hcp_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `hcp_signature_captured` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Signature Captured');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `hcp_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) Signature Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `inventory_number` SET TAGS ('dbx_business_glossary_term' = 'Sample Inventory Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `inventory_number` SET TAGS ('dbx_value_regex' = '^SINV-[0-9]{8,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Sample Inventory Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'active|reconciled|closed|suspended|pending_review');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sample_management` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` SET TAGS ('dbx_subdomain' = 'brand_management');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `promo_material_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Material ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `molecular_target_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Target Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Production Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `aggregate_decision` SET TAGS ('dbx_business_glossary_term' = 'Aggregate MLR Decision');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `aggregate_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_changes|rejected|pending');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'MLR Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Medical-Legal-Regulatory (MLR) Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `content_owner` SET TAGS ('dbx_business_glossary_term' = 'Content Owner');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Material Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `fair_balance_included` SET TAGS ('dbx_business_glossary_term' = 'Fair Balance Included Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Approved Therapeutic Indication');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `isi_included` SET TAGS ('dbx_business_glossary_term' = 'Important Safety Information (ISI) Included Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `last_resubmission_date` SET TAGS ('dbx_business_glossary_term' = 'Last Resubmission Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `legal_decision` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Decision');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `legal_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_changes|rejected|pending');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `legal_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Legal Reviewer Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Market / Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `market` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Promotional Material Title');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `vault_document_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `version_lineage` SET TAGS ('dbx_business_glossary_term' = 'Version Lineage');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Material Version Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Material Withdrawal Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Material Withdrawal Reason');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`promo_material` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_value_regex' = 'label_update|safety_update|voluntary_withdrawal|expired|superseded|regulatory_request');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` SET TAGS ('dbx_subdomain' = 'brand_management');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `mlr_review_id` SET TAGS ('dbx_business_glossary_term' = 'Medical-Legal-Regulatory (MLR) Review ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `internal_control_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Control Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Reviewer ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `prior_submission_mlr_review_id` SET TAGS ('dbx_business_glossary_term' = 'Prior MLR Submission ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `promo_material_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Material ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `quaternary_mlr_submitter_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitter ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `quaternary_mlr_submitter_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `quaternary_mlr_submitter_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `tertiary_mlr_regulatory_reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reviewer ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `tertiary_mlr_regulatory_reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `tertiary_mlr_regulatory_reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'MLR Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `approval_decision` SET TAGS ('dbx_business_glossary_term' = 'MLR Approval Decision');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `approval_decision` SET TAGS ('dbx_value_regex' = 'approved|approved_with_changes|rejected|withdrawn');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`mlr_review` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` SET TAGS ('dbx_subdomain' = 'stakeholder_engagement');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `commercial_speaker_program_id` SET TAGS ('dbx_business_glossary_term' = 'Speaker Program ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Record Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reviewer ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `fmv_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV) Assessment ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Speaker Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `molecular_target_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Target Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `monitoring_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Activity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `msl_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Msl Profile Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Open Payments Submission ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `promo_material_id` SET TAGS ('dbx_business_glossary_term' = 'Promotional Material ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Trial Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `attendee_count_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Attendee Count');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `attendee_count_planned` SET TAGS ('dbx_business_glossary_term' = 'Planned Attendee Count');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated|waived');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Program Delivery Channel');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'in_person|virtual|hybrid');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `phrm_code_compliant` SET TAGS ('dbx_business_glossary_term' = 'PhRMA Code Compliant Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `program_date` SET TAGS ('dbx_business_glossary_term' = 'Speaker Program Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `program_end_time` SET TAGS ('dbx_business_glossary_term' = 'Speaker Program End Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `program_start_time` SET TAGS ('dbx_business_glossary_term' = 'Speaker Program Start Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Speaker Program Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|planned|confirmed|completed|cancelled|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Speaker Program Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'dinner_meeting|webinar|symposium|peer_to_peer|advisory_board|stand_alone_exhibit');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `speaker_training_verified` SET TAGS ('dbx_business_glossary_term' = 'Speaker Training Verified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `sunshine_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `veeva_crm_record_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva CRM Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `venue_city` SET TAGS ('dbx_business_glossary_term' = 'Venue City');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_business_glossary_term' = 'Venue Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `venue_name` SET TAGS ('dbx_business_glossary_term' = 'Venue Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_speaker_program` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_business_glossary_term' = 'Venue State or Province');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` SET TAGS ('dbx_subdomain' = 'stakeholder_engagement');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `speaker_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Speaker Engagement ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `commercial_speaker_program_id` SET TAGS ('dbx_business_glossary_term' = 'Speaker Program ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `conflict_of_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Of Interest Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Speaker Contract ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `attendance_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Attendance Confirmation Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `attendance_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Attendance Confirmed Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `efpia_reportable` SET TAGS ('dbx_business_glossary_term' = 'European Federation of Pharmaceutical Industries and Associations (EFPIA) Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `engagement_number` SET TAGS ('dbx_business_glossary_term' = 'Engagement Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'scheduled|confirmed|completed|cancelled|no_show');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `fmv_compliant` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV) Compliant Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `fmv_rate` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV) Rate');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `fmv_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `open_payments_category` SET TAGS ('dbx_business_glossary_term' = 'Open Payments Category');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `open_payments_category` SET TAGS ('dbx_value_regex' = 'general_payment|research_payment|ownership_interest');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `open_payments_nature_of_payment` SET TAGS ('dbx_business_glossary_term' = 'Open Payments Nature of Payment Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `open_payments_record_code` SET TAGS ('dbx_business_glossary_term' = 'CMS Open Payments Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `open_payments_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Open Payments Submission Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `open_payments_submission_status` SET TAGS ('dbx_value_regex' = 'not_submitted|submitted|accepted|disputed|corrected');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `participation_role` SET TAGS ('dbx_business_glossary_term' = 'Participation Role');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `participation_role` SET TAGS ('dbx_value_regex' = 'speaker|attendee|moderator|panelist|consultant');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `phirma_code_compliant` SET TAGS ('dbx_business_glossary_term' = 'PhRMA Code Compliant Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `program_format` SET TAGS ('dbx_business_glossary_term' = 'Program Format');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `program_format` SET TAGS ('dbx_value_regex' = 'in_person|virtual|hybrid');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reporting Year');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `sap_vendor_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Vendor Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `sunshine_act_reportable` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Act Reportable Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `veeva_crm_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva CRM Activity ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `venue_city` SET TAGS ('dbx_business_glossary_term' = 'Venue City');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_business_glossary_term' = 'Venue Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `venue_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `venue_name` SET TAGS ('dbx_business_glossary_term' = 'Venue Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `venue_state_code` SET TAGS ('dbx_business_glossary_term' = 'Venue State Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`speaker_engagement` ALTER COLUMN `venue_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` SET TAGS ('dbx_subdomain' = 'stakeholder_engagement');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `sunshine_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Sunshine Disclosure ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `trial_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Disclosure Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Grant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `cms_record_code` SET TAGS ('dbx_business_glossary_term' = 'Centers for Medicare and Medicaid Services (CMS) Open Payments Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `correction_indicator` SET TAGS ('dbx_business_glossary_term' = 'Correction Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Description');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Recipient Dispute Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'no_dispute|disputed_by_recipient|resolved_agreed|resolved_corrected|resolved_deleted');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `form_of_payment` SET TAGS ('dbx_business_glossary_term' = 'Form of Payment');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `form_of_payment` SET TAGS ('dbx_value_regex' = 'cash|check|in_kind|stock|stock_option|other');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `internal_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `internal_review_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Compliance Review Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `internal_review_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|approved|rejected|escalated');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `is_research_payment` SET TAGS ('dbx_business_glossary_term' = 'Research Payment Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `nct_number` SET TAGS ('dbx_business_glossary_term' = 'ClinicalTrials.gov NCT Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `nct_number` SET TAGS ('dbx_value_regex' = '^NCT[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `original_cms_record_code` SET TAGS ('dbx_business_glossary_term' = 'Original CMS Open Payments Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `payment_category` SET TAGS ('dbx_business_glossary_term' = 'Nature of Payment Category');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Commercial Program Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'CMS Publication Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_first_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient First Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_first_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_institution_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Institution Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_last_name` SET TAGS ('dbx_business_glossary_term' = 'Recipient Last Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_last_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_npi` SET TAGS ('dbx_business_glossary_term' = 'Recipient National Provider Identifier (NPI)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_primary_specialty` SET TAGS ('dbx_business_glossary_term' = 'Recipient Primary Medical Specialty');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_state` SET TAGS ('dbx_business_glossary_term' = 'Recipient State');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_type` SET TAGS ('dbx_business_glossary_term' = 'Covered Recipient Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `recipient_type` SET TAGS ('dbx_value_regex' = 'covered_recipient_physician|covered_recipient_teaching_hospital|covered_recipient_non_physician_practitioner');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `research_study_name` SET TAGS ('dbx_business_glossary_term' = 'Research Study Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'veeva_crm|salesforce_health_cloud|sap_s4hana|manual_entry|other');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'CMS Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Submission Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `third_party_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Third Party Entity Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `third_party_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Third Party Payment Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sunshine_disclosure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` SET TAGS ('dbx_subdomain' = 'brand_management');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `brand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Plan ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `access_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Access Strategy Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `congress_event_id` SET TAGS ('dbx_business_glossary_term' = 'Congress Event Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Profit Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `rd_capitalization_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Capitalization Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `brand_positioning` SET TAGS ('dbx_business_glossary_term' = 'Brand Positioning Statement');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `budget_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `channel_strategy` SET TAGS ('dbx_business_glossary_term' = 'Channel Strategy');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `competitive_landscape` SET TAGS ('dbx_business_glossary_term' = 'Competitive Landscape Summary');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Primary Indication');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_plan` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` SET TAGS ('dbx_subdomain' = 'stakeholder_engagement');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `kol_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Key Opinion Leader (KOL) Engagement ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `conflict_of_interest_id` SET TAGS ('dbx_business_glossary_term' = 'Conflict Of Interest Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Owner Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `medical_kol_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Kol Profile Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `medical_kol_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `medical_kol_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `payer_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Engagement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `principal_investigator_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Discovery Project Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `advisory_board_name` SET TAGS ('dbx_business_glossary_term' = 'Advisory Board Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `compliance_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `compliance_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `compliance_approver` SET TAGS ('dbx_business_glossary_term' = 'Compliance Approver');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `congress_name` SET TAGS ('dbx_business_glossary_term' = 'Congress Name');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `engagement_country` SET TAGS ('dbx_business_glossary_term' = 'Engagement Country');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `engagement_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Indication');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Engagement Notes');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `publication_title` SET TAGS ('dbx_business_glossary_term' = 'Publication Title');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `strategic_relationship_tier` SET TAGS ('dbx_business_glossary_term' = 'Strategic Relationship Tier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `strategic_relationship_tier` SET TAGS ('dbx_value_regex' = 'tier_1_national|tier_2_regional|tier_3_local|emerging');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `transparency_report_date` SET TAGS ('dbx_business_glossary_term' = 'Transparency Report Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `transparency_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Transparency Reporting Required');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`kol_engagement` ALTER COLUMN `veeva_crm_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva Customer Relationship Management (CRM) Activity ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` SET TAGS ('dbx_subdomain' = 'patient_access');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `patient_support_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Support Program (PSP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `patient_access_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `active_enrolled_patients` SET TAGS ('dbx_business_glossary_term' = 'Active Enrolled Patients');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `adherence_rate_actual` SET TAGS ('dbx_business_glossary_term' = 'Adherence Rate Actual');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `adherence_rate_target` SET TAGS ('dbx_business_glossary_term' = 'Adherence Rate Target');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `benefit_type` SET TAGS ('dbx_value_regex' = 'co-pay card|free drug voucher|nurse support|reimbursement assistance|prior authorization support|patient education materials');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `cost_per_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Enrollment');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `enrollment_channel` SET TAGS ('dbx_value_regex' = 'hcp referral|patient direct|pharmacy|call center|web portal|mobile app');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `hipaa_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'HIPAA Compliant Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `income_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Income Threshold Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `income_threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Income Threshold Currency');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `income_threshold_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Indication');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Program Launch Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `max_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `max_benefit_currency` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Currency');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `max_benefit_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `program_budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Currency');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `program_budget_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending launch|terminated');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|not required|conditional');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Program Termination Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `total_enrolled_patients` SET TAGS ('dbx_business_glossary_term' = 'Total Enrolled Patients');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `transparency_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Transparency Reporting Required');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`patient_support_program` ALTER COLUMN `vendor_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Score');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` SET TAGS ('dbx_subdomain' = 'patient_access');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `psp_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Support Program (PSP) Enrollment ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Healthcare Professional (HCP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `named_patient_request_id` SET TAGS ('dbx_business_glossary_term' = 'Named Patient Request Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Reference ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `patient_support_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Support Program (PSP) ID');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `remaining_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Benefit Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `transparency_report_date` SET TAGS ('dbx_business_glossary_term' = 'Transparency Report Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`psp_enrollment` ALTER COLUMN `transparency_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Transparency Reporting Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` SET TAGS ('dbx_subdomain' = 'stakeholder_engagement');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `contract_account_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Account Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `parent_account_contract_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Account Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `contract_tier` SET TAGS ('dbx_business_glossary_term' = 'Contract Tier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `contract_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze|standard');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`contract_account` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` SET TAGS ('dbx_subdomain' = 'performance_incentives');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `sales_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Performance ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `affairs_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Affairs Plan Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Profit Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Account Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `actual_performance_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Performance Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `call_attainment_percent` SET TAGS ('dbx_business_glossary_term' = 'Call Attainment Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `call_frequency_achieved` SET TAGS ('dbx_business_glossary_term' = 'Call Frequency Achieved');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `call_frequency_target` SET TAGS ('dbx_business_glossary_term' = 'Call Frequency Target');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'veeva_crm|iqvia|symphony_health|internal_calculation|manual_entry');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `total_prescriptions` SET TAGS ('dbx_business_glossary_term' = 'Total Prescriptions (TRx)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_performance` ALTER COLUMN `veeva_crm_record_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva CRM Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` SET TAGS ('dbx_subdomain' = 'performance_incentives');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `incentive_compensation_id` SET TAGS ('dbx_business_glossary_term' = 'Incentive Compensation ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `incentive_compensation_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `incentive_compensation_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `performance_period_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Period ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `sales_rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `accelerator_amount` SET TAGS ('dbx_business_glossary_term' = 'Accelerator Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `actual_sales_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Sales Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `attainment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attainment Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `base_bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Bonus Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `bonus_tier` SET TAGS ('dbx_business_glossary_term' = 'Bonus Tier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `bonus_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|tier_5|no_payout');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Calculation Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|approved|rejected|paid|adjusted');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `compensation_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `crm_record_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Record ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `erp_document_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Document Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `payout_date` SET TAGS ('dbx_business_glossary_term' = 'Payout Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `payout_status` SET TAGS ('dbx_business_glossary_term' = 'Payout Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `payout_status` SET TAGS ('dbx_value_regex' = 'pending|scheduled|processed|paid|failed|cancelled');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `payroll_batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Payroll Batch ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `quota_amount` SET TAGS ('dbx_business_glossary_term' = 'Quota Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `total_bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Bonus Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`incentive_compensation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` SET TAGS ('dbx_subdomain' = 'patient_access');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `copay_program_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Pay Program Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Masterdata Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `medical_heor_study_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Heor Study Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `medical_heor_study_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `medical_heor_study_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `patient_access_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Access Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `active_enrolled_patients` SET TAGS ('dbx_business_glossary_term' = 'Active Enrolled Patients');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `gross_to_net_category` SET TAGS ('dbx_business_glossary_term' = 'Gross-to-Net (GTN) Category');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Indication');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Program Launch Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `max_annual_benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Annual Benefit Amount');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `max_benefit_per_prescription` SET TAGS ('dbx_business_glossary_term' = 'Maximum Benefit Per Prescription');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `max_benefit_per_prescription` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `max_benefit_per_prescription` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `program_owner` SET TAGS ('dbx_business_glossary_term' = 'Program Owner');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_launch|terminated');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'copay_card|voucher|free_trial|instant_savings|rebate|patient_assistance');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Program Termination Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `total_enrolled_patients` SET TAGS ('dbx_business_glossary_term' = 'Total Enrolled Patients');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `total_redemptions_count` SET TAGS ('dbx_business_glossary_term' = 'Total Redemptions Count');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `transparency_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Transparency Reporting Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_program` ALTER COLUMN `veeva_crm_record_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva Customer Relationship Management (CRM) Record Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` SET TAGS ('dbx_subdomain' = 'patient_access');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `copay_redemption_id` SET TAGS ('dbx_business_glossary_term' = 'Co-Pay Redemption ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `accounts_payable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `accounts_receivable_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `cogs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cogs Entry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `copay_program_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Support Program ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `gross_to_net_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Gross To Net Adjustment Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `patient_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `patient_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `days_supply` SET TAGS ('dbx_business_glossary_term' = 'Days Supply');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `geography` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Indication');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_business_glossary_term' = 'Prescriber National Provider Identifier (NPI)');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `prescriber_npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `prescriber_specialty` SET TAGS ('dbx_business_glossary_term' = 'Prescriber Specialty');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `prescription_number` SET TAGS ('dbx_business_glossary_term' = 'Prescription Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `prescription_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `prescription_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`copay_redemption` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
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
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` SET TAGS ('dbx_subdomain' = 'brand_management');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` SET TAGS ('dbx_association_edges' = 'commercial.brand,market.payer_account');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `commercial_formulary_position_id` SET TAGS ('dbx_business_glossary_term' = 'commercial_formulary_position Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Position - Brand Id');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Position Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Position - Payer Account Id');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `lives_covered` SET TAGS ('dbx_business_glossary_term' = 'Lives Covered');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `pt_committee_approval_date` SET TAGS ('dbx_business_glossary_term' = 'P&T Committee Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `quantity_limit_flag` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `rebate_tier` SET TAGS ('dbx_business_glossary_term' = 'Rebate Tier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `rebate_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`commercial_formulary_position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` SET TAGS ('dbx_subdomain' = 'brand_management');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` SET TAGS ('dbx_association_edges' = 'commercial.brand,procurement.vendor');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `brand_supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Supply Agreement ID');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `brand_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Supply Agreement - Brand Id');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Brand Supply Agreement - Vendor Id');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `annual_spend_allocation` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Allocation');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `approved_material_category` SET TAGS ('dbx_business_glossary_term' = 'Approved Material Category');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `last_quality_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Quality Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `next_quality_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Quality Review Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `primary_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Supplier Flag');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Tier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `supply_agreement_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `supply_agreement_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`brand_supply_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`performance_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`performance_period` SET TAGS ('dbx_subdomain' = 'performance_incentives');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`performance_period` ALTER COLUMN `performance_period_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`performance_period` ALTER COLUMN `prior_performance_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`performance_period` ALTER COLUMN `sales_target_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`performance_period` ALTER COLUMN `speaker_program_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`district` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`district` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`district` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`district` ALTER COLUMN `parent_district_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`district` ALTER COLUMN `annual_sales_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`district` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`district` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`district` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`region` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`region` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`region` ALTER COLUMN `region_id` SET TAGS ('dbx_business_glossary_term' = 'Region Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`region` ALTER COLUMN `annual_revenue_target_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`region` ALTER COLUMN `market_potential_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`region` ALTER COLUMN `regional_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`region` ALTER COLUMN `regional_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` SET TAGS ('dbx_subdomain' = 'performance_incentives');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`commercial`.`sales_order` ALTER COLUMN `reference_sales_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
