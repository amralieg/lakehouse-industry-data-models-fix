-- Schema for Domain: program | Business: Ngo | Version: v1_mvm
-- Generated on: 2026-05-07 03:36:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ngo_ecm`.`program` COMMENT 'Owns the design, planning, and lifecycle management of all humanitarian and development interventions including WASH, health, nutrition, education, protection, and livelihood programs. Captures Theory of Change (ToC), LogFrame, SDG alignment, sector classifications, RBM (Results-Based Management) frameworks, and program hierarchies from proposal through closeout.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ngo_ecm`.`program`.`intervention` (
    `intervention_id` BIGINT COMMENT 'Unique identifier for the humanitarian or development intervention/program. Primary key for the intervention entity.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Programs must track which compliance obligations apply (donor reporting deadlines, CHS assessments, regulatory filings). Essential for compliance calendar management and risk mitigation in nonprofit o',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NGO interventions are executed through specific cost centers for NICRA indirect cost compliance and donor financial reporting. intervention already has finance_fund_id but no cost_center FK — a nonpro',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Every NGO intervention is operationally managed and delivered by a specific country office. Country office directors approve interventions, manage field teams, and report to donors. This direct link i',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Emergency-response interventions must be directly linked to the declared emergency that triggered them. This enables emergency-specific program portfolio reporting, CERF/flash appeal tracking, and don',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Programs are funded by specific restricted or unrestricted funds. Essential for donor compliance reporting, financial tracking, and ensuring expenditures align with fund restrictions. Nonprofit domain',
    `governance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.governance_policy. Business justification: Interventions must reference the specific governance policy governing safeguarding, do-no-harm, and CHS compliance. The existing denormalized fields (safeguarding_policy_applied, sphere_standards_appl',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit (country office, regional office, or headquarters division) responsible for implementing this intervention.',
    `program_id` BIGINT COMMENT 'Foreign key linking to program.program. Business justification: The `program` product is explicitly described as Master reference table for program. Referenced by program_id. Interventions are specific humanitarian/development instances that belong to a parent p',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member serving as the primary program manager or chief of party for this intervention, accountable for overall delivery and results.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Primary warehouse designation for intervention: NGO field interventions are assigned a primary/designated warehouse for commodity storage and distribution. This link enables logistics planning, wareho',
    `actual_end_date` DATE COMMENT 'Actual date when intervention activities concluded. May differ from planned end date due to extensions, early termination, or operational adjustments.',
    `actual_start_date` DATE COMMENT 'Actual date when intervention activities commenced in the field. May differ from planned start date due to delays in funding, security clearances, or operational readiness.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total budget amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `chs_compliant` BOOLEAN COMMENT 'Indicates whether the intervention design and implementation plan adhere to the Core Humanitarian Standard on Quality and Accountability, covering nine commitments from needs assessment through accountability to affected populations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this intervention record was first created in the system, representing when the intervention was registered or entered into the program management system.',
    `disability_inclusion_marker_score` STRING COMMENT 'Score indicating the level of disability inclusion in the intervention design and implementation. 0: not disability inclusive; 1: disability visible; 2: disability integrated; 3: disability targeted; 4: disability transformative.. Valid values are `0|1|2|3|4`',
    `do_no_harm_assessment_completed` BOOLEAN COMMENT 'Indicates whether a Do No Harm analysis was conducted to identify and mitigate potential negative impacts of the intervention on conflict dynamics, social cohesion, or vulnerable groups.',
    `environmental_impact_assessment_completed` BOOLEAN COMMENT 'Indicates whether an environmental impact assessment was conducted to evaluate and mitigate potential environmental harm from intervention activities (e.g., water extraction, waste disposal, construction).',
    `gender_marker_score` STRING COMMENT 'IASC Gender Marker score indicating the extent to which the intervention integrates gender equality. 0: no gender integration; 1: contributes to gender equality; 2a: has gender equality as a significant objective; 2b: has gender equality as the principal objective.. Valid values are `0|1|2a|2b`',
    `geographic_scope` STRING COMMENT 'Geographic coverage level of the intervention. National: entire country; Regional: multiple provinces/states; District: specific administrative districts; Community: village or neighborhood level; Multi-country: cross-border or regional program.. Valid values are `national|regional|district|community|multi_country`',
    `intervention_code` STRING COMMENT 'Externally-known unique business identifier for the intervention, used in donor reporting, grant proposals, and field operations. Often follows organizational or donor-specific coding conventions.. Valid values are `^[A-Z0-9]{3,20}$`',
    `intervention_name` STRING COMMENT 'Full descriptive name of the intervention as it appears in grant proposals, donor reports, and public communications.',
    `intervention_status` STRING COMMENT 'Current lifecycle status of the intervention. Pipeline: concept or proposal stage; Approved: funding secured, not yet started; Active: implementation underway; Suspended: temporarily paused; Completed: activities finished, closeout pending; Closed: fully closed out with final reports submitted.. Valid values are `pipeline|approved|active|suspended|completed|closed`',
    `intervention_type` STRING COMMENT 'Classification of the intervention based on its primary purpose and timeframe. Emergency response interventions address immediate humanitarian crises; development interventions focus on long-term sustainable change; recovery interventions bridge emergency and development; resilience interventions build capacity to withstand future shocks; advocacy interventions influence policy and systems; capacity building interventions strengthen partner organizations.. Valid values are `emergency_response|development|recovery|resilience|advocacy|capacity_building`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this intervention record was last updated, capturing any changes to intervention details, status, or metadata.',
    `logframe_document_url` STRING COMMENT 'URL or file path to the interventions Logical Framework Matrix document, which details the intervention logic, indicators, means of verification, and assumptions.',
    `logic` STRING COMMENT 'Structured description of the interventions logical framework (LogFrame): how activities will produce outputs, how outputs will lead to outcomes, and how outcomes will contribute to impact. Includes key assumptions and risks at each level.',
    `mel_plan_document_url` STRING COMMENT 'URL or file path to the interventions MEL plan, which outlines the monitoring framework, evaluation schedule, data collection methods, and learning agenda.',
    `phase` STRING COMMENT 'Current operational phase within the intervention lifecycle. Design: developing ToC, LogFrame, and proposal; Startup: mobilizing resources, recruiting staff, establishing field presence; Implementation: delivering activities and services; Closeout: finalizing activities, conducting evaluations, submitting final reports.. Valid values are `design|startup|implementation|closeout`',
    `planned_end_date` DATE COMMENT 'Originally planned end date for intervention activities as documented in the grant agreement or project proposal.',
    `planned_start_date` DATE COMMENT 'Originally planned start date for intervention activities as documented in the grant agreement or project proposal.',
    `rbm_framework_applied` BOOLEAN COMMENT 'Indicates whether the intervention applies a formal Results-Based Management framework with defined inputs, activities, outputs, outcomes, and impact, along with indicators and targets at each level.',
    `sdg_alignment_type` STRING COMMENT 'Nature of the interventions contribution to the SDG. Direct: intervention activities directly advance the SDG indicator; Indirect: intervention creates conditions that support SDG progress; Enabling: intervention builds capacity or systems that enable others to advance the SDG.. Valid values are `direct|indirect|enabling`',
    `sdg_contribution_narrative` STRING COMMENT 'Qualitative description of how the intervention contributes to the identified SDG goal, target, and indicator. Articulates the causal pathway and expected magnitude of contribution.',
    `sdg_goal_primary` STRING COMMENT 'Primary UN Sustainable Development Goal that this intervention contributes to, expressed as SDG number (e.g., SDG1 for No Poverty, SDG3 for Good Health and Well-being, SDG6 for Clean Water and Sanitation).. Valid values are `^SDG[0-9]{1,2}$`',
    `sdg_indicator_primary` STRING COMMENT 'Specific SDG indicator used to measure the interventions contribution to the primary target (e.g., 6.1.1 for proportion of population using safely managed drinking water services).. Valid values are `^[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}$`',
    `sdg_target_primary` STRING COMMENT 'Specific SDG target within the primary goal that this intervention addresses (e.g., 6.1 for universal access to safe drinking water, 3.8 for universal health coverage).. Valid values are `^[0-9]{1,2}.[0-9]{1,2}$`',
    `sector` STRING COMMENT 'Primary humanitarian or development sector of the intervention. WASH (Water Sanitation and Hygiene), health, nutrition, education, protection (including GBV and child protection), shelter/NFI, livelihoods, and food security are the most common sectors aligned with Sphere standards and cluster coordination mechanisms. [ENUM-REF-CANDIDATE: wash|health|nutrition|education|protection|shelter|livelihoods|food_security — 8 candidates stripped; promote to reference product]',
    `short_name` STRING COMMENT 'Abbreviated or acronym version of the intervention name used for internal reference and field operations.',
    `situation_analysis` STRING COMMENT 'Detailed analysis of the humanitarian or development context that justifies the intervention. Includes needs assessment findings, vulnerability analysis, root causes of the problem, and gaps in existing services or coverage.',
    `sub_sector` STRING COMMENT 'Detailed sub-classification within the primary sector. For example, within WASH: water supply, sanitation facilities, hygiene promotion; within health: primary health care, maternal health, mental health and PSS; within protection: GBV prevention and response, child protection, mine action.',
    `sustainability_plan` STRING COMMENT 'Strategy for ensuring that intervention benefits and capacities endure beyond the project period. Includes plans for local ownership, capacity building, resource mobilization, policy advocacy, and transition or exit strategies.',
    `target_beneficiary_count` STRING COMMENT 'Total number of direct beneficiaries the intervention aims to reach, as documented in the project proposal and LogFrame. Represents unique individuals or households, depending on the interventions unit of analysis.',
    `target_beneficiary_unit` STRING COMMENT 'Unit of measurement for target beneficiaries. Individuals: unique persons; Households: family units; Communities: villages or settlements; Institutions: schools, health facilities, or organizations.. Valid values are `individuals|households|communities|institutions`',
    `targeting_strategy` STRING COMMENT 'Methodology and criteria for identifying and selecting beneficiaries. Describes vulnerability criteria, geographic targeting, inclusion/exclusion criteria, and mechanisms to ensure equitable access and prevent exclusion errors.',
    `theory_of_change_narrative` STRING COMMENT 'Comprehensive narrative describing the interventions Theory of Change: the causal pathway from inputs and activities through outputs, outcomes, and impact. Articulates assumptions, preconditions, and the logic connecting intervention activities to intended long-term change.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget for the intervention across all funding sources, expressed in the organizations reporting currency. Includes direct program costs, indirect costs, and any cost-sharing or in-kind contributions.',
    CONSTRAINT pk_intervention PRIMARY KEY(`intervention_id`)
) COMMENT 'Core master entity representing a humanitarian or development program/intervention (e.g., WASH, health, nutrition, education, protection, livelihoods). Captures the full program lifecycle from design through closeout, including program type (emergency vs. development), phase, status, start/end dates, geographic scope, target population summary, organizational ownership, and SDG alignment mappings (goal, target, indicator, alignment type, contribution narrative). This is the primary anchor entity for the program domain and the SSOT for all program-level identity, metadata, design narrative (situation analysis, intervention logic, targeting strategy, sustainability plan), and strategic framework alignment. All other program domain entities reference this as their parent.';

CREATE OR REPLACE TABLE `ngo_ecm`.`program`.`component` (
    `component_id` BIGINT COMMENT 'Unique identifier for the program component. Primary key.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: NGO program components are directly tied to finance budgets for burn-rate monitoring and donor financial reporting. Component budget_envelope_amount must reconcile against the finance budget — a nonpr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NGO program components are mapped to finance cost centers for expenditure tracking, NICRA indirect cost allocation, and donor financial reporting. A nonprofit finance controller expects each component',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Program components implement donor-funded activities governed by specific donor requirements (reporting frequency, visibility rules, procurement thresholds). Compliance officers must link components t',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: NGO components draw from specific restricted or unrestricted finance funds. Linking component to finance_fund enables fund balance monitoring, restriction compliance, and donor fund utilization report',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: In NGO sub-award structures, individual components are assigned to specific implementing partner orgs. This link supports component-level partner accountability tracking, sub-award financial reporting',
    `intervention_id` BIGINT COMMENT 'Reference to the parent program intervention that this component belongs to. Links component to its overarching program structure.',
    `parent_component_id` BIGINT COMMENT 'Reference to the parent component if this is a sub-component or workstream. Null for top-level components. Supports hierarchical program navigation.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: NGO component accountability reporting and donor audits require identifying the specific staff member responsible for each component. responsible_manager is a denormalized name string; a proper FK e',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Organizational accountability for component delivery is a core NGO management requirement. responsible_team is a denormalized string; linking to org_unit enables budget-by-unit reporting, field offi',
    `amendment_count` STRING COMMENT 'Number of formal amendments or revisions made to the component design, scope, or budget since initial approval. Tracks change management history.',
    `approval_date` DATE COMMENT 'Date when the component design and budget received formal approval to proceed with implementation.',
    `approval_status` STRING COMMENT 'Current approval state of the component design and budget within internal governance processes (draft, pending review, approved, revision required, rejected).. Valid values are `draft|pending_review|approved|revision_required|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual or committee that approved this component for implementation.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget envelope amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `budget_envelope_amount` DECIMAL(18,2) COMMENT 'Total allocated budget for this component in the programs base currency. Represents the financial ceiling for component activities and procurement.',
    `component_code` STRING COMMENT 'Externally-known unique business identifier for the component, used in donor reporting, grant management systems, and field operations documentation.. Valid values are `^[A-Z0-9]{3,20}$`',
    `component_description` STRING COMMENT 'Detailed narrative describing the components objectives, scope, target beneficiaries, and expected outcomes. Supports Theory of Change (ToC) articulation.',
    `component_name` STRING COMMENT 'Human-readable name of the program component (e.g., Water Supply Infrastructure, Hygiene Promotion, Community Health Worker Training).',
    `component_status` STRING COMMENT 'Current lifecycle status of the component (planned, active, on hold, completed, closed, cancelled). Tracks component progression through implementation phases.. Valid values are `planned|active|on_hold|completed|closed|cancelled`',
    `component_type` STRING COMMENT 'Classification of the component within the program structure (component, sub-component, workstream, activity cluster, pilot, scale-up).. Valid values are `component|sub-component|workstream|activity_cluster|pilot|scale_up`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this component record was first created in the system. Supports audit trail and data lineage.',
    `cross_cutting_themes` STRING COMMENT 'Cross-cutting priorities integrated into this component (e.g., gender equality, disability inclusion, environmental sustainability, conflict sensitivity, accountability to affected populations).',
    `dac_sector_code` STRING COMMENT 'Five-digit OECD DAC sector code for standardized sector classification and donor reporting (e.g., 14010 for Water Resources Policy, 12220 for Basic Health Care).. Valid values are `^[0-9]{5}$`',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this component requires explicit donor branding, acknowledgment, or public visibility per grant agreement terms (True) or not (False).',
    `end_date` DATE COMMENT 'Planned or actual end date for component implementation. Marks the completion or closeout of the component lifecycle.',
    `funding_source` STRING COMMENT 'Primary donor, grant, or funding mechanism supporting this component (e.g., USAID BHA, CERF, DFID, private foundation). Enables fund accounting and donor visibility.',
    `geographic_focus` STRING COMMENT 'Primary geographic area(s) where this component is implemented (country, region, district, camp, or community names). Supports spatial analysis and field coordination.',
    `grant_requirement_flag` BOOLEAN COMMENT 'Indicates whether this component is mandated by a specific grant agreement or donor requirement (True) or is discretionary within the program design (False).',
    `hierarchy_level` STRING COMMENT 'Numeric level in the program decomposition hierarchy (1=top-level component, 2=sub-component, 3=workstream, etc.). Enables multi-tier program structuring.',
    `implementation_modality` STRING COMMENT 'Delivery approach for this component (direct implementation by NGO staff, partner-led, consortium, sub-award, community-based organization). Affects partnership and compliance requirements.. Valid values are `direct|partner|consortium|sub_award|community_based`',
    `integration_flag` BOOLEAN COMMENT 'Indicates whether this component is part of an integrated multi-sector program (True) or a standalone single-sector intervention (False). Supports integrated programming analysis.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent formal amendment to the component. Null if no amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this component record was most recently updated. Supports change tracking and audit trail.',
    `mitigation_strategy` STRING COMMENT 'Summary of key risk mitigation measures and contingency plans in place for this component. Supports program risk management and donor assurance.',
    `monitoring_frequency` STRING COMMENT 'Scheduled frequency for Monitoring Evaluation and Learning (MEL) data collection and progress reporting for this component. [ENUM-REF-CANDIDATE: weekly|biweekly|monthly|quarterly|semi_annual|annual|event_based — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional context, implementation notes, lessons learned, or special considerations relevant to this component.',
    `reporting_frequency` STRING COMMENT 'Required frequency for formal progress and financial reporting to donors and stakeholders for this component.. Valid values are `monthly|quarterly|semi_annual|annual|final_only`',
    `risk_level` STRING COMMENT 'Overall risk rating for this component based on security, operational, financial, and reputational risk assessments (low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `sdg_alignment` STRING COMMENT 'Primary United Nations Sustainable Development Goal(s) that this component contributes to (e.g., SDG 6: Clean Water and Sanitation, SDG 3: Good Health and Well-being). Supports impact reporting.',
    `sector` STRING COMMENT 'Primary humanitarian or development sector for this component (e.g., WASH, Health, Nutrition, Education, Protection, Livelihoods, Shelter). [ENUM-REF-CANDIDATE: wash|health|nutrition|education|protection|livelihoods|shelter|food_security|early_recovery|camp_management — promote to reference product]',
    `start_date` DATE COMMENT 'Planned or actual start date for component implementation activities. Marks the beginning of the component lifecycle.',
    `sub_sector` STRING COMMENT 'Detailed sub-sector classification within the primary sector (e.g., for WASH: water supply, sanitation, hygiene promotion; for Health: primary care, maternal health, immunization).',
    `target_beneficiary_count` STRING COMMENT 'Planned number of direct beneficiaries (individuals or households) that this component aims to reach. Used for Monitoring Evaluation and Learning (MEL) target tracking.',
    `theory_of_change_reference` STRING COMMENT 'Reference to the specific pathway or outcome in the programs Theory of Change framework that this component addresses.',
    CONSTRAINT pk_component PRIMARY KEY(`component_id`)
) COMMENT 'Hierarchical decomposition of a program intervention into components, sub-components, or workstreams (e.g., a WASH program broken into water supply, sanitation, and hygiene promotion components). Captures component name, description, sector, sub-sector, responsible team, geographic focus, budget envelope, start/end dates, and status. Supports multi-sector and integrated programming models. Enables program hierarchy navigation from intervention down to activity level.';

CREATE OR REPLACE TABLE `ngo_ecm`.`program`.`target_population` (
    `target_population_id` BIGINT COMMENT 'Unique identifier for the target population definition. Primary key for this entity.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Target populations are often defined at the component level in multi-sector interventions. For example, a WASH component may target IDPs while a nutrition component targets children under 5 within the',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Donor requirements define beneficiary eligibility criteria (e.g., USAID targeting rules, EU vulnerability thresholds). Compliance officers must trace which donor requirement governs each target popula',
    `intervention_id` BIGINT COMMENT 'Reference to the parent program or intervention that this target population definition belongs to.',
    `age_range_max` STRING COMMENT 'Maximum age in years for individuals in the target population. Null if no maximum age restriction applies.',
    `age_range_min` STRING COMMENT 'Minimum age in years for individuals in the target population. Null if no minimum age restriction applies.',
    `approval_date` DATE COMMENT 'Date when this target population definition was formally approved for use in program planning and implementation.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or role who approved this target population definition for program implementation.',
    `baseline_date` DATE COMMENT 'Date when the baseline data or needs assessment for this target population was collected or published.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the target population is located (e.g., NGA for Nigeria, BGD for Bangladesh).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this target population record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'OECD DAC 5-digit sector code for international aid classification and reporting (e.g., 12220 for Basic Health Care).',
    `data_collection_method` STRING COMMENT 'Primary method or approach used to collect data about the target population (e.g., Household Survey, Key Informant Interview (KII), Focus Group Discussion (FGD), Secondary Data Analysis).',
    `data_source` STRING COMMENT 'Source of the population data or needs assessment used to define this target population (e.g., OCHA Humanitarian Needs Overview 2024, Baseline Survey March 2024, Government Census 2023).',
    `displacement_status` STRING COMMENT 'Displacement or residency status of the target population (IDP = Internally Displaced Person, PoC = Person of Concern).. Valid values are `idp|refugee|returnee|host_community|mixed|not_applicable`',
    `do_no_harm_considerations` STRING COMMENT 'Documentation of potential risks and mitigation strategies to ensure the targeting approach does not inadvertently cause harm, stigma, or conflict within communities.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this target population definition is visible to donors and included in external reporting and proposals.',
    `effective_end_date` DATE COMMENT 'Date when this target population definition is no longer active or applicable. Null for ongoing or open-ended target populations.',
    `effective_start_date` DATE COMMENT 'Date when this target population definition becomes active and applicable for program planning and beneficiary selection.',
    `estimated_population_size` STRING COMMENT 'Estimated total number of individuals in the target population based on needs assessment, census data, or other planning sources.',
    `exclusion_criteria` STRING COMMENT 'Criteria that explicitly exclude individuals or households from the target population, ensuring appropriate targeting and avoiding duplication with other programs.',
    `gender_integration_approach` STRING COMMENT 'Description of how gender considerations and gender-based vulnerabilities are integrated into the targeting and selection of this population.',
    `geographic_scope` STRING COMMENT 'Geographic area or administrative boundaries where the target population resides (e.g., Borno State, Nigeria, Coxs Bazar District, Bangladesh, Urban Khartoum).',
    `host_community_population_count` STRING COMMENT 'Estimated number of host community members (non-displaced local population) within the target population. Null if not applicable.',
    `idp_population_count` STRING COMMENT 'Estimated number of Internally Displaced Persons (IDPs) within the target population. Null if not applicable.',
    `inclusion_criteria` STRING COMMENT 'Detailed criteria that define who is eligible to be included in the target population (e.g., Children aged 6-59 months with MUAC < 12.5 cm, Households with female head and 3+ dependents).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this target population record was most recently updated or modified.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or contextual information about this target population definition.',
    `planned_reach` STRING COMMENT 'Number of individuals the program plans to reach or serve from this target population, considering resource constraints and program scope.',
    `population_code` STRING COMMENT 'Short alphanumeric code or identifier used in reporting and documentation to reference this target population (e.g., TP-001, WASH-IDPs-2024).',
    `population_description` STRING COMMENT 'Detailed narrative description of the target population, including demographic characteristics, vulnerability profile, and rationale for targeting.',
    `population_name` STRING COMMENT 'Human-readable name or label for this target population segment (e.g., Malnourished Children Under 5 in Borno State, IDP Women Heads of Household).',
    `protection_mainstreaming_flag` BOOLEAN COMMENT 'Indicates whether protection principles and safeguarding measures are integrated into the targeting and service delivery for this population.',
    `refugee_population_count` STRING COMMENT 'Estimated number of refugees within the target population. Null if not applicable.',
    `revision_number` STRING COMMENT 'Sequential version number tracking revisions to this target population definition over time.',
    `revision_reason` STRING COMMENT 'Explanation or justification for the most recent revision to this target population definition (e.g., Updated based on new needs assessment, Expanded geographic scope).',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of SDG goals and targets that this target population intervention contributes to (e.g., SDG 2.2, SDG 3.2).',
    `sector_classification` STRING COMMENT 'Primary humanitarian or development sector that this target population is associated with, aligned with cluster coordination frameworks. [ENUM-REF-CANDIDATE: wash|health|nutrition|education|protection|shelter|livelihoods|food_security|multi_sector — 9 candidates stripped; promote to reference product]',
    `sex_disaggregation` STRING COMMENT 'Sex or gender composition of the target population (e.g., female for women-only programs, all for mixed populations).. Valid values are `all|male|female|other|mixed`',
    `target_population_status` STRING COMMENT 'Current lifecycle status of the target population definition within the program planning and execution workflow.. Valid values are `draft|approved|active|suspended|closed`',
    `targeting_methodology` STRING COMMENT 'Primary approach or method used to identify and select beneficiaries from the target population (e.g., MUAC screening for malnutrition, vulnerability scoring, community-based targeting). [ENUM-REF-CANDIDATE: community_based|vulnerability_scoring|muac_screening|household_economy_approach|geographic|categorical|self_targeting|mixed_methods — 8 candidates stripped; promote to reference product]',
    `vulnerability_category` STRING COMMENT 'Primary vulnerability classification or category that defines this target population (e.g., Severely Malnourished, GBV Survivors, Unaccompanied Minors, Persons with Disabilities).',
    CONSTRAINT pk_target_population PRIMARY KEY(`target_population_id`)
) COMMENT 'Defines the intended beneficiary population for a program intervention or component, capturing targeting criteria, geographic scope, demographic profile (age, sex, vulnerability category), estimated population size, targeting methodology (e.g., MUAC screening, vulnerability scoring, community-based targeting), inclusion/exclusion criteria, and IDP/PoC/host community breakdown. Distinct from individual beneficiary registration (owned by beneficiary domain) — this is the program-level population planning entity.';

CREATE OR REPLACE TABLE `ngo_ecm`.`program`.`program_amendment` (
    `program_amendment_id` BIGINT COMMENT 'Unique identifier for the program amendment record. Primary key.',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: Amendment approval audit trail: Donor constituents (bilateral donors, foundations) must formally approve program amendments. program_amendment.donor_approving_authority is a denormalized text field; r',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: Program amendments require donor approval and must reference the specific grant award being amended. Essential for amendment approval workflow, donor coordination, and compliance tracking. Award-level',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to program.budget_plan. Business justification: Program amendments almost always involve budget changes (budget_change_amount field exists on program_amendment). Adding budget_plan_id to program_amendment links the amendment to the specific budget ',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Amendment audit trails require staff linkage for compliance, donor reporting, and internal controls. Standard practice in grant-funded nonprofit program management.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Program amendments are triggered by or must satisfy specific donor requirements (e.g., USAID prior approval requirements for budget realignments >10%, scope changes). Grants compliance officers must l',
    `grant_amendment_id` BIGINT COMMENT 'Foreign key linking to grant.grant_amendment. Business justification: NGO compliance: program amendments must align with donor-approved grant amendments. Linking program_amendment to grant_amendment enables traceability between internal programmatic changes and formal d',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: NGO program amendments (no-cost extensions, budget realignments) trigger grant budget modifications. Linking program_amendment to grant_budget enables tracking which grant budget version was modified ',
    `implementation_plan_id` BIGINT COMMENT 'Foreign key linking to program.implementation_plan. Business justification: Program amendments frequently trigger revisions to the implementation plan (e.g., a no-cost extension amendment requires updating the work plan timeline). Adding implementation_plan_id to program_amen',
    `intervention_id` BIGINT COMMENT 'Reference to the parent program intervention being amended.',
    `logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Program amendments with logframe_revision_flag=true directly modify the logframe. Linking program_amendment to mel_logframe creates an audit trail of which amendment version corresponds to which logfr',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Program amendments often require regulatory filing (donor material change notifications, grant amendment submissions, board resolution filings). Essential for tracking amendment compliance in nonprofi',
    `amendment_number` STRING COMMENT 'Sequential or coded identifier for this amendment within the program (e.g., AMD-001, Amendment 1).',
    `amendment_status` STRING COMMENT 'Current lifecycle state of the amendment: draft (being prepared), submitted (sent for approval), under review (being evaluated), approved (accepted and effective), rejected (denied), or withdrawn (cancelled by submitter).. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `amendment_type` STRING COMMENT 'Classification of the amendment nature: no-cost extension (timeline only), scope change (activities/deliverables), budget reallocation (financial redistribution), geographic expansion (new locations), target population adjustment (beneficiary changes), or LogFrame revision (results framework update).. Valid values are `no_cost_extension|scope_change|budget_reallocation|geographic_expansion|target_population_adjustment|logframe_revision`',
    `approval_date` DATE COMMENT 'Date when the amendment received final approval from all required authorities (internal and donor).',
    `audit_trail_notes` STRING COMMENT 'Additional notes for audit and compliance purposes, including process deviations, special approvals, or historical context.',
    `budget_change_amount` DECIMAL(18,2) COMMENT 'Net financial change resulting from the amendment (positive for increases, negative for decreases, zero for reallocations with no net change).',
    `budget_change_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget change amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `compliance_impact_assessment` STRING COMMENT 'Assessment of how this amendment affects compliance with donor requirements, regulatory obligations, and organizational policies.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this amendment record was first created in the system.',
    `donor_approval_reference` STRING COMMENT 'Official reference number or document identifier issued by the donor confirming their approval of the amendment.',
    `effective_date` DATE COMMENT 'Date from which the amendment terms become binding and operational, may differ from approval date based on donor or contractual requirements.',
    `geographic_coverage_change` STRING COMMENT 'Description of changes to geographic scope, including new districts, provinces, or countries added or removed from program coverage.',
    `grant_requirement_flag` BOOLEAN COMMENT 'Indicates whether this amendment is required by grant agreement terms or donor mandate. True if donor-required, False if organization-initiated.',
    `internal_approving_authority` STRING COMMENT 'Name or title of the internal organizational authority (e.g., Program Director, Country Director, Chief Executive Officer) who approved the amendment.',
    `justification_narrative` STRING COMMENT 'Detailed business rationale and context explaining why the amendment is necessary, including operational, programmatic, or external factors driving the change.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the staff member who most recently updated this amendment record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this amendment record was most recently updated.',
    `logframe_revision_flag` BOOLEAN COMMENT 'Indicates whether this amendment includes changes to the program LogFrame (results framework, indicators, targets, or assumptions). True if LogFrame is revised, False otherwise.',
    `logframe_revision_summary` STRING COMMENT 'Summary of changes made to the LogFrame, including modified indicators, revised targets, new outputs, or updated assumptions.',
    `original_end_date` DATE COMMENT 'The program end date before this amendment was applied, captured for audit trail and before/after comparison.',
    `original_target_beneficiaries` STRING COMMENT 'The planned number of direct beneficiaries before this amendment, captured for before/after comparison.',
    `rejection_reason` STRING COMMENT 'Explanation provided by approving authority if the amendment was rejected, including specific concerns or required modifications.',
    `revised_end_date` DATE COMMENT 'The new program end date after this amendment is applied, null if the amendment does not affect timeline.',
    `revised_target_beneficiaries` STRING COMMENT 'The new planned number of direct beneficiaries after this amendment is applied, null if the amendment does not affect beneficiary targets.',
    `risk_assessment` STRING COMMENT 'Assessment of risks introduced or mitigated by this amendment, including operational, financial, reputational, or compliance risks.',
    `scope_change_description` STRING COMMENT 'Detailed description of changes to program scope, including modifications to activities, deliverables, outputs, or intervention strategies.',
    `sdg_alignment_change` STRING COMMENT 'Description of changes to SDG alignment resulting from this amendment, including new SDG targets added or removed.',
    `sector_classification_change` STRING COMMENT 'Description of changes to sector classifications (e.g., WASH, Health, Nutrition, Education, Protection) resulting from scope modifications.',
    `stakeholder_consultation_summary` STRING COMMENT 'Summary of consultations conducted with beneficiaries, partners, local authorities, and other stakeholders regarding the proposed amendment.',
    `submission_date` DATE COMMENT 'Date when the amendment was formally submitted for approval to internal and/or donor authorities.',
    `supporting_documentation_reference` STRING COMMENT 'Reference to supporting documents (e.g., revised budget, updated LogFrame, donor correspondence) stored in document management system.',
    `target_population_change` STRING COMMENT 'Description of changes to target beneficiary population, including adjustments to demographic criteria, vulnerability profiles, or total beneficiary numbers.',
    `timeline_extension_days` STRING COMMENT 'Number of calendar days by which the program implementation period is extended (positive for extensions, negative for reductions, zero if no timeline change).',
    `withdrawal_reason` STRING COMMENT 'Explanation for why the amendment was withdrawn by the submitting organization before approval decision.',
    CONSTRAINT pk_program_amendment PRIMARY KEY(`program_amendment_id`)
) COMMENT 'Formal amendment or modification record for a program intervention, capturing changes to scope, budget, timeline, geographic coverage, target population, or LogFrame. Stores amendment number, type (no-cost extension, scope change, budget reallocation, geographic expansion), justification narrative, approval date, approving authority (internal and donor), effective date, and before/after comparison of key parameters. Critical for grant compliance and audit trail.';

CREATE OR REPLACE TABLE `ngo_ecm`.`program`.`risk_register` (
    `risk_register_id` BIGINT COMMENT 'Unique identifier for the risk register entry. Primary key for the risk register product.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Risk register approval authority must be linked to staff for governance, escalation workflows, and donor risk management reporting requirements.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Risks in humanitarian programs are frequently component-specific (e.g., supply chain risk for a health component, access risk for a protection component). Adding component_id to risk_register allows r',
    `governance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.governance_policy. Business justification: NGO risk registers must reference the governance policy mandating the risk management framework (e.g., anti-fraud policy, safeguarding policy). Compliance officers verify that risk entries align with ',
    `grant_amendment_id` BIGINT COMMENT 'Foreign key linking to grant.grant_amendment. Business justification: NGO risk management: when a registered risk materializes (security incident, funding shortfall), it triggers a formal grant amendment. Risk-to-amendment traceability is required for donor accountabili',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: When program risks materialize, they become compliance incidents requiring investigation and corrective action. Essential for linking risk management to incident response in nonprofit operations.',
    `intervention_id` BIGINT COMMENT 'Reference to the program intervention to which this risk applies. Links risk to the specific humanitarian or development program.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: NGO risk registers routinely identify specific implementing partner orgs as risk sources (e.g., partner financial mismanagement, safeguarding failures). This link supports partner risk monitoring repo',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Organizational risk escalation and CHS compliance require identifying which org unit owns each risk. risk_owner and risk_owner_email are denormalized strings; linking to org_unit enables risk aggr',
    `affected_sdg` STRING COMMENT 'Reference to the Sustainable Development Goal(s) that may be impacted if this risk materializes. Supports alignment with global development frameworks and donor reporting.',
    `affected_sector` STRING COMMENT 'Program sector(s) that would be impacted by the risk (e.g., WASH, Health, Nutrition, Education, Protection, Livelihoods). Supports sector-specific risk analysis and reporting.',
    `approval_date` DATE COMMENT 'Date when the risk assessment and mitigation plan were formally approved. Supports governance and audit trail requirements.',
    `closure_date` DATE COMMENT 'Date when the risk was formally closed, either because it was fully mitigated, no longer relevant, or the program ended. Supports risk lifecycle completion tracking.',
    `contingency_plan` STRING COMMENT 'Detailed response plan to be activated if the risk materializes. Includes trigger points, escalation procedures, alternative delivery mechanisms, and resource reallocation strategies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register record was first created in the system. Supports audit trail and data lineage.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this risk must be reported to donors as part of grant compliance requirements. True if donor reporting is required; false otherwise.',
    `effective_end_date` DATE COMMENT 'Date until which this version of the risk assessment is effective. Null for the current active version. Supports temporal tracking and historical risk analysis.',
    `effective_start_date` DATE COMMENT 'Date from which this version of the risk assessment is effective. Supports temporal tracking and historical risk analysis.',
    `escalation_required_flag` BOOLEAN COMMENT 'Indicates whether the risk requires escalation to senior management or board level due to its severity or potential organizational impact. True if escalation is required; false otherwise.',
    `geographic_scope` STRING COMMENT 'Geographic area(s) affected by the risk (country, region, district, project site). Supports location-based risk mapping and field operations planning.',
    `identification_date` DATE COMMENT 'Date when the risk was first identified and entered into the risk register. Supports risk lifecycle tracking and audit trails.',
    `impact_rating` STRING COMMENT 'Qualitative assessment of the severity of consequences if the risk materializes. Considers impact on beneficiaries, program objectives, organizational reputation, and donor relations.. Valid values are `very low|low|medium|high|very high`',
    `impact_score` STRING COMMENT 'Numeric score representing the severity of impact if the risk occurs, typically on a scale of 1-5 where 1 is very low and 5 is very high. Used for quantitative risk prioritization.',
    `inherent_risk_score` STRING COMMENT 'Calculated risk score before mitigation measures are applied, typically the product of likelihood_score and impact_score. Represents the raw exposure level.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk register record was most recently updated. Supports audit trail and change tracking.',
    `last_review_date` DATE COMMENT 'Date when the risk was most recently reviewed and assessed. Supports compliance with donor requirements for periodic risk review (typically quarterly or semi-annually).',
    `likelihood_rating` STRING COMMENT 'Qualitative assessment of the probability that the risk will materialize during the program lifecycle. Typically rated on a five-point scale aligned with organizational risk appetite.. Valid values are `very low|low|medium|high|very high`',
    `likelihood_score` STRING COMMENT 'Numeric score representing the likelihood of risk occurrence, typically on a scale of 1-5 where 1 is very low and 5 is very high. Used for quantitative risk prioritization.',
    `mitigation_strategy` STRING COMMENT 'Detailed description of the measures, controls, and actions planned or implemented to reduce the likelihood or impact of the risk. Includes preventive and detective controls.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of the risk. Ensures timely reassessment and supports proactive risk management.',
    `notes` STRING COMMENT 'Additional free-text notes, observations, or context related to the risk. Captures supplementary information not covered in structured fields.',
    `residual_risk_score` STRING COMMENT 'Calculated risk score after mitigation measures are applied. Represents the remaining exposure after controls are in place. Used to assess whether risk is within acceptable tolerance.',
    `revision_reason` STRING COMMENT 'Explanation for why the risk assessment was updated or revised. Captures the business rationale for changes in likelihood, impact, or mitigation strategy.',
    `risk_category` STRING COMMENT 'Classification of the risk type. Operational risks relate to program delivery; contextual risks relate to external environment (security, political); institutional risks relate to organizational capacity; fiduciary risks relate to financial management and compliance; programmatic risks relate to program design and effectiveness; reputational risks relate to organizational standing.. Valid values are `operational|contextual|institutional|fiduciary|programmatic|reputational`',
    `risk_code` STRING COMMENT 'Unique business identifier for the risk entry, typically following organizational risk coding standards (e.g., OPR-001, CTX-045). Used for cross-referencing in donor reports and internal risk management systems.. Valid values are `^[A-Z]{2,4}-[0-9]{3,5}$`',
    `risk_description` STRING COMMENT 'Detailed narrative description of the risk, including the nature of the threat, potential triggers, and context. Captures the full scope of the risk scenario.',
    `risk_level` STRING COMMENT 'Overall risk classification based on the combination of likelihood and impact, determining the priority and urgency of response. Critical risks require immediate escalation and board-level attention.. Valid values are `low|moderate|high|critical`',
    `risk_status` STRING COMMENT 'Current lifecycle state of the risk. Open indicates newly identified; monitoring indicates active tracking; mitigated indicates controls are effective; closed indicates risk no longer relevant; materialized indicates risk has occurred.. Valid values are `open|monitoring|mitigated|closed|materialized`',
    `risk_subcategory` STRING COMMENT 'More granular classification within the risk category (e.g., security incident, supply chain disruption, fraud, partner capacity, beneficiary access). Allows for detailed risk taxonomy alignment.',
    `risk_title` STRING COMMENT 'Short, descriptive title of the risk for quick identification and reporting purposes.',
    `version_number` STRING COMMENT 'Sequential version number of the risk register entry. Incremented each time the risk assessment is updated, supporting risk evolution tracking across the program lifecycle.',
    CONSTRAINT pk_risk_register PRIMARY KEY(`risk_register_id`)
) COMMENT 'Risk register entry for a program intervention, capturing risk description, category (operational, contextual, institutional, fiduciary), likelihood rating, impact rating, risk score, mitigation measures, contingency plan, risk owner, review date, and current status. Supports program design quality, donor compliance (many donors require risk registers), and adaptive management. Versioned to track risk evolution across the program lifecycle.';

CREATE OR REPLACE TABLE `ngo_ecm`.`program`.`implementation_plan` (
    `implementation_plan_id` BIGINT COMMENT 'Unique identifier for the implementation plan record. Primary key.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Implementation plan approval requires staff linkage for accountability, delegation of authority tracking, and compliance with nonprofit internal controls.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: NGO award compliance: implementation plans are formal deliverables submitted to donors under specific awards. Grant managers must link implementation plans to awards for donor compliance verification,',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to program.budget_plan. Business justification: An implementation plan (work plan) is operationally inseparable from its funding budget plan. The work plan defines activities and milestones; the budget plan defines the financial envelope. Linking i',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Implementation plans (work plans) in NGO programs are frequently designed at the component or workstream level, not just at the intervention level. A WASH component may have its own detailed work plan',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NGO implementation plans are executed through specific cost centers for financial accountability and NICRA compliance. The plans budget_allocated_amount must be tracked against a cost center — a nonp',
    `distribution_plan_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_plan. Business justification: Implementation plan to distribution plan linkage: NGO implementation plans specify distribution activities that generate distribution plans. Direct linkage enables integrated program-logistics monitor',
    `donor_fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Restricted fund utilization reporting: Implementation plans execute against donor-restricted funds with specific allowable activities and geographic restrictions. NGOs must demonstrate that implementa',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Implementation plans fulfill specific donor compliance requirements (detailed work plans, milestone schedules, activity timelines). Essential for tracking donor deliverable compliance in grant managem',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: NGO implementation plans are structured around fiscal periods for annual work planning and financial accountability. implementation_plan has planning_period_start/end_date but no fiscal_period FK — li',
    `governance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.governance_policy. Business justification: Implementation plans must conform to organizational governance policies (procurement policy, safeguarding policy, anti-fraud policy). Compliance officers verify that implementation plans reference and',
    `grant_amendment_id` BIGINT COMMENT 'Foreign key linking to grant.grant_amendment. Business justification: NGO grant management: when a grant amendment changes scope, timeline, or budget, the implementation plan must be formally revised. Linking the revised plan to the triggering amendment is required for ',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: NGO implementation plans are executed against specific grant budgets — the plans budget_allocated_amount must reconcile with the grant budget for donor financial reporting and prior approval complian',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Implementation plans in NGOs are frequently executed by a primary implementing partner org. This link enables partner-specific implementation tracking, partner performance dashboards, and sub-award im',
    `intervention_id` BIGINT COMMENT 'Reference to the parent program intervention that this implementation plan operationalizes.',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: NGO implementation plans are formally paired with MEAL plans — the implementation_plan defines activities while the meal_plan defines how they are monitored. Donors and cluster systems require this li',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Implementation plans are executed by specific org units (field offices, technical departments). responsible_unit is a denormalized string; a proper FK to org_unit enables workload planning, capacity',
    `volunteer_team_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_team. Business justification: Implementation plans designate responsible execution units; in NGO field operations, volunteer teams are formally assigned to implement specific plans. Program managers need this link to track team ac',
    `approval_date` DATE COMMENT 'Date on which this implementation plan was formally approved for execution.',
    `assumptions` STRING COMMENT 'Key assumptions underlying the implementation plan, including security conditions, partner capacity, beneficiary access, and external dependencies.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget amount allocated to this implementation plan for the planning period.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget allocated amount.. Valid values are `^[A-Z]{3}$`',
    `coordination_mechanism` STRING COMMENT 'Description of coordination mechanisms with partners, clusters, local authorities, and other stakeholders for implementation plan execution.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this implementation plan record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'Five-digit OECD DAC sector code classifying the implementation plan for international aid transparency and reporting.. Valid values are `^[0-9]{5}$`',
    `disaggregation_approach` STRING COMMENT 'Description of how beneficiary data will be disaggregated (by gender, age, disability, displacement status, etc.) for equity and accountability.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this implementation plan is visible to donors for transparency and reporting purposes.',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the implementation plan, listing countries, regions, districts, or project sites where activities will be executed.',
    `grant_requirement_flag` BOOLEAN COMMENT 'Indicates whether this implementation plan is a mandatory deliverable under a specific grant agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this implementation plan record was last modified in the system.',
    `last_revision_date` DATE COMMENT 'Date of the most recent revision or amendment to this implementation plan.',
    `logframe_reference` STRING COMMENT 'Reference identifier linking this implementation plan to specific outputs and activities in the program LogFrame.',
    `monitoring_approach` STRING COMMENT 'Description of the monitoring and evaluation approach for tracking implementation plan progress, including data collection methods and frequency.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information relevant to this implementation plan.',
    `plan_code` STRING COMMENT 'Externally-known unique business identifier for the implementation plan, used in donor reporting and field communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `plan_manager_name` STRING COMMENT 'Full name of the staff member serving as the implementation plan manager or work plan coordinator.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the implementation plan indicating approval and execution state. [ENUM-REF-CANDIDATE: draft|submitted|approved|active|on_hold|revised|completed|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `plan_title` STRING COMMENT 'Descriptive title of the implementation plan, summarizing the intervention scope and geographic focus.',
    `plan_type` STRING COMMENT 'Classification of the implementation plan by temporal scope and purpose (annual work plan, quarterly plan, emergency response plan, etc.).. Valid values are `annual|quarterly|project_phase|emergency_response|pilot|scale_up`',
    `plan_version` STRING COMMENT 'Version number of the implementation plan following semantic versioning (e.g., 1.0, 1.1, 2.0) to track revisions and amendments.. Valid values are `^[0-9]+.[0-9]+$`',
    `planning_period_end_date` DATE COMMENT 'End date of the planning period covered by this implementation plan, marking the scheduled completion of all activities.',
    `planning_period_start_date` DATE COMMENT 'Start date of the planning period covered by this implementation plan, marking the beginning of scheduled activities.',
    `reporting_frequency` STRING COMMENT 'Frequency at which progress reports on this implementation plan will be generated for internal management and donor reporting. [ENUM-REF-CANDIDATE: weekly|biweekly|monthly|quarterly|semi_annual|annual|ad_hoc — 7 candidates stripped; promote to reference product]',
    `resource_requirements_summary` STRING COMMENT 'Summary of human resources, equipment, supplies, and other resources required to execute this implementation plan.',
    `revision_reason` STRING COMMENT 'Explanation of why the implementation plan was revised, including changes in context, donor requirements, or operational constraints.',
    `risk_level` STRING COMMENT 'Overall risk level assessment for successful execution of this implementation plan, considering security, access, capacity, and external factors.. Valid values are `low|medium|high|critical`',
    `risk_mitigation_summary` STRING COMMENT 'Summary of key risks identified and mitigation strategies planned to ensure implementation plan success.',
    `sector_classification` STRING COMMENT 'Primary humanitarian or development sector that this implementation plan addresses, aligned with cluster coordination system. [ENUM-REF-CANDIDATE: WASH|health|nutrition|education|protection|livelihoods|shelter|food_security|multi_sector — 9 candidates stripped; promote to reference product]',
    `target_beneficiary_count` STRING COMMENT 'Total number of direct beneficiaries (individuals or households) targeted by this implementation plan.',
    `target_beneficiary_type` STRING COMMENT 'Unit of measurement for target beneficiaries (individuals, households, communities, or institutions).. Valid values are `individuals|households|communities|institutions`',
    `toc_reference` STRING COMMENT 'Reference identifier linking this implementation plan to the program Theory of Change pathway and assumptions.',
    `total_planned_activities` STRING COMMENT 'Total number of discrete activities scheduled in this implementation plan.',
    `total_planned_milestones` STRING COMMENT 'Total number of key milestones defined in this implementation plan for progress tracking and donor reporting.',
    CONSTRAINT pk_implementation_plan PRIMARY KEY(`implementation_plan_id`)
) COMMENT 'Detailed implementation plan (work plan) for a program intervention or component, serving as the operational roadmap for field teams and the baseline for progress tracking. Captures planned activities at the task level including activity name, description, type, responsible parties, timelines (Gantt-style), resource requirements, geographic phasing, target beneficiary counts, status tracking, and linkage to LogFrame outputs. Includes comprehensive milestone tracking (program launch, mid-term review, final evaluation, closeout, donor reporting deadlines) with milestone type, planned/actual dates, completion status, deliverable description, sign-off authority, and dependency sequencing. Stores plan version, planning period, approval status, and last revision date. This is the SSOT for all program scheduling, activity sequencing, and milestone management — the schedule authority for donor reporting timelines and grant compliance.';

CREATE OR REPLACE TABLE `ngo_ecm`.`program`.`budget_plan` (
    `budget_plan_id` BIGINT COMMENT 'Unique identifier for the program budget plan record.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Budget plans for partner-implemented programs must reference the governing partnership agreement for compliance tracking, allowable cost verification, financial reconciliation, and donor audit trails.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Budget approval authority must be traceable to specific staff for financial controls, donor compliance, audit trails, and delegation of authority documentation.',
    `award_id` BIGINT COMMENT 'Reference to the grant funding this budget plan, if applicable.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Program budget plans must reference the master finance budget for reconciliation, variance analysis, and donor reporting. Critical for ensuring program budgets align with organizational financial plan',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Budget plans in NGO programs are commonly structured at the component level (e.g., a separate budget plan for the WASH component vs. the livelihoods component within one intervention). Adding componen',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NGO program budget plans are managed at cost center level for financial control and indirect cost allocation. budget_plan has budget_owner/finance_contact but no cost_center FK — a nonprofit finance m',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Budget plans are directly owned and executed by country offices, which are accountable for financial utilization and donor financial reporting. Country offices submit budget plans to headquarters and ',
    `donor_fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Budget plans must allocate expenses to specific donor funds for restriction compliance and fund accounting. Critical for budget-to-fund allocation, grant financial reporting, restricted fund managemen',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Budget plans are directly constrained by donor requirements specifying allowable costs, indirect cost rate caps, and prior approval thresholds. Finance-compliance officers must link budget plans to th',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: NGO program budget plans are aligned to fiscal periods for annual financial planning and period-close reporting. budget_plan has budget_period_start/end_date but no fiscal_period FK — a nonprofit fina',
    `grant_amendment_id` BIGINT COMMENT 'Foreign key linking to grant.grant_amendment. Business justification: NGO financial management: each budget plan version corresponds to a specific grant amendment that authorized the budget revision. Linking budget plans to grant amendments is required for financial aud',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: NGO program budget plans must reconcile with finance grant budgets for donor financial reporting and audit compliance. This link enables budget plan vs. grant budget variance analysis — a core require',
    `intervention_id` BIGINT COMMENT 'Reference to the program intervention this budget plan supports.',
    `amendment_date` DATE COMMENT 'Date on which this budget plan amendment was executed.',
    `amendment_reason` STRING COMMENT 'Explanation of why this budget plan was amended or revised, if applicable.',
    `approval_date` DATE COMMENT 'Date on which this budget plan was formally approved.',
    `budget_assumptions` STRING COMMENT 'Key assumptions underlying the budget plan, such as exchange rates, inflation rates, beneficiary numbers, or activity volumes.',
    `budget_narrative` STRING COMMENT 'Detailed narrative justification and explanation of the budget plan, including assumptions, methodologies, and cost calculations.',
    `budget_owner` STRING COMMENT 'Name or identifier of the program manager or budget holder responsible for this budget plan.',
    `budget_period_end_date` DATE COMMENT 'End date of the budget period this plan covers.',
    `budget_period_start_date` DATE COMMENT 'Start date of the budget period this plan covers.',
    `budget_plan_name` STRING COMMENT 'Descriptive name or title of the budget plan, typically aligned with program or grant phase.',
    `budget_plan_number` STRING COMMENT 'Externally-known unique identifier or code for this budget plan, used in donor reporting and financial communications.',
    `budget_status` STRING COMMENT 'Current lifecycle status of the budget plan in the approval and execution workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|active|amended|closed|rejected — 8 candidates stripped; promote to reference product]',
    `budget_type` STRING COMMENT 'Classification of the budget plan indicating whether it is the original approved budget, a revision, supplemental funding, or closeout budget.. Valid values are `original|revised|supplemental|no_cost_extension|closeout`',
    `budget_version_number` STRING COMMENT 'Version number of this budget plan, incremented with each revision or amendment.',
    `compliance_notes` STRING COMMENT 'Notes regarding compliance requirements, restrictions, or special conditions attached to this budget plan.',
    `contractual_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for contractual services, consultants, and sub-awards.',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Total budgeted amount of cost sharing or matching funds contributed by the organization or other sources.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this budget plan.. Valid values are `^[A-Z]{3}$`',
    `dac_sector_code` STRING COMMENT 'OECD DAC sector classification code for this budget plan, used for international aid transparency and reporting.',
    `donor_budget_code` STRING COMMENT 'Donor-specific budget classification code or identifier required for reporting and compliance.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this budget plan is visible to the donor in reporting portals or dashboards.',
    `equipment_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for equipment purchases with unit cost exceeding capitalization threshold.',
    `finance_contact` STRING COMMENT 'Name or identifier of the finance team member responsible for financial oversight of this budget plan.',
    `fringe_benefits_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for fringe benefits associated with personnel costs.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'Approved indirect cost rate percentage applied to the direct cost base, as negotiated in NICRA or per de minimis rate.',
    `indirect_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for indirect costs (Facilities and Administration), calculated by applying the indirect cost rate to the direct cost base.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget plan record was last updated or modified.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about this budget plan.',
    `personnel_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for personnel salaries and wages.',
    `sdg_alignment` STRING COMMENT 'Sustainable Development Goal(s) this budget plan contributes to, typically represented as SDG numbers (e.g., SDG 1, SDG 3).',
    `sector_classification` STRING COMMENT 'Humanitarian or development sector classification for this budget plan. [ENUM-REF-CANDIDATE: wash|health|nutrition|education|protection|livelihoods|shelter|food_security|emergency_response|capacity_building — 10 candidates stripped; promote to reference product]',
    `submitted_date` DATE COMMENT 'Date on which this budget plan was submitted for approval or to the donor.',
    `supplies_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for supplies and consumable materials.',
    `total_approved_budget_amount` DECIMAL(18,2) COMMENT 'Total approved budget amount for this plan, representing the sum of all cost categories.',
    `total_direct_costs` DECIMAL(18,2) COMMENT 'Sum of all direct cost categories before indirect costs are applied.',
    `travel_costs` DECIMAL(18,2) COMMENT 'Total budgeted amount for travel expenses including international and domestic travel.',
    CONSTRAINT pk_budget_plan PRIMARY KEY(`budget_plan_id`)
) COMMENT 'Program-level budget plan capturing the approved budget envelope for a program intervention, including line-item detail by cost category (personnel, fringe, travel, equipment, supplies, contractual, other direct costs, indirect costs). Stores total approved budget, currency, budget period, budget version, donor-specific budget codes, indirect cost rate (ICR/NICRA), F&A allocation, unit costs, quantities, and budget status. Distinct from the finance domains GL and BvA tracking — this is the program-level planning budget owned by program management.';

CREATE OR REPLACE TABLE `ngo_ecm`.`program`.`budget_plan_line` (
    `budget_plan_line_id` BIGINT COMMENT 'Unique identifier for the budget plan line item. Primary key for this entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Individual budget line items in partner-executed programs must trace to the partnership agreement for line-item allowability verification, indirect cost rate application, cost-sharing validation, and ',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Line-level budget approval tracking enables granular financial controls, threshold-based approval workflows, and audit compliance in nonprofit grant management.',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding award that finances this budget line. Enables donor-specific budget reporting and compliance tracking.',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Line-level linkage between program and finance budgets enables detailed variance analysis, actual-vs-budget reporting, and financial statement preparation. Essential for grant compliance and donor rep',
    `budget_plan_id` BIGINT COMMENT 'Reference to the parent budget plan document that contains this line item. Links to the overall program budget structure.',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Budget line items in NGO programs are attributed to specific components for activity-based costing and component-level financial reporting. For example, personnel costs for a WASH engineer belong to t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget lines are allocated to cost centers for departmental and program-level cost tracking. Essential for indirect cost allocation, NICRA compliance, and management reporting on program efficiency an',
    `donor_fund_id` BIGINT COMMENT 'Foreign key linking to donor.fund. Business justification: Individual budget line items allocated to specific donor funds enable granular restriction tracking and line-item fund accounting. Required for detailed financial reporting, multi-fund budget allocati',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Program budget lines must map to GL accounts for financial posting, trial balance preparation, and financial statement generation. Required for GAAP compliance and ensuring program expenses are correc',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: NGO budget plan lines map to grant budget lines for donor financial reporting and allowable cost compliance. budget_plan_line already has award_id and budget_line_id — adding grant_budget_id completes',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project to which this budget line belongs. Enables program-level budget rollup and tracking.',
    `activity_code` STRING COMMENT 'Program activity or intervention code that this budget line supports. Links budget to program implementation activities.',
    `allowable_cost_flag` BOOLEAN COMMENT 'Indicates whether this cost is allowable under the grant or donor regulations. Used for budget review and compliance validation.',
    `approval_date` DATE COMMENT 'Date when this budget line was formally approved. Critical for compliance and audit documentation.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this budget line requires explicit donor or management approval before execution. Used for budget control and governance.',
    `budget_period_end_date` DATE COMMENT 'The end date of the budget period for which this line item is planned. Defines the timeframe for budget execution and BvA analysis.',
    `budget_period_start_date` DATE COMMENT 'The start date of the budget period for which this line item is planned. Enables multi-year and phased budget tracking.',
    `budget_plan_line_status` STRING COMMENT 'Current lifecycle status of the budget line item. Tracks approval workflow and execution state. [ENUM-REF-CANDIDATE: draft|submitted|approved|active|revised|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `budget_version_number` STRING COMMENT 'Version number of the budget plan to track revisions and amendments. Incremented with each budget modification.',
    `chart_of_accounts_code` STRING COMMENT 'General Ledger account code from the organizations Chart of Accounts. Links budget planning to financial accounting and enables BvA tracking.',
    `cost_category` STRING COMMENT 'Primary budget classification category following standard nonprofit and federal grant budget structures. Used for donor reporting and financial compliance. [ENUM-REF-CANDIDATE: personnel|fringe_benefits|travel|equipment|supplies|contractual|subawards|other_direct_costs|indirect_costs — 9 candidates stripped; promote to reference product]',
    `cost_sharing_amount` DECIMAL(18,2) COMMENT 'The portion of the total planned amount that represents cost sharing or matching contribution. Used for grant compliance reporting.',
    `cost_sharing_flag` BOOLEAN COMMENT 'Indicates whether this budget line includes cost sharing or matching funds from the organization or other sources. Critical for grant compliance.',
    `cost_sharing_source` STRING COMMENT 'The source of cost sharing funds (e.g., organizational reserves, other grants, in-kind contributions, partner contributions).',
    `cost_subcategory` STRING COMMENT 'Detailed subcategory within the primary cost category for granular budget tracking (e.g., international travel, local travel, office supplies, medical supplies).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was first created in the system. Required for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget line amounts (e.g., USD, EUR, GBP). Enables multi-currency budget management.. Valid values are `^[A-Z]{3}$`',
    `dac_sector_code` STRING COMMENT 'OECD DAC 5-digit sector classification code for international development reporting and sector-based budget analysis.',
    `direct_cost_flag` BOOLEAN COMMENT 'Indicates whether this budget line is a direct cost (true) or an indirect/overhead cost (false). Used for indirect cost rate calculations and compliance.',
    `donor_budget_code` STRING COMMENT 'Donor-specific budget line code or reference number required for grant reporting and financial compliance. Maps to donor financial systems.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this budget line belongs. Enables fiscal year-based budget reporting and analysis.',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The indirect cost rate applied to this budget line if it is a direct cost base. Expressed as a decimal (e.g., 0.1500 for 15%). Links to NICRA.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system that last modified this budget line record. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this budget line record was last updated. Critical for audit trail and version control.',
    `line_description` STRING COMMENT 'Detailed narrative description of the budget line item explaining the purpose, justification, and planned use of funds.',
    `line_number` STRING COMMENT 'Sequential or hierarchical line number within the budget plan for ordering and reference purposes (e.g., 1.1, 1.2, 2.1).',
    `notes` STRING COMMENT 'Additional notes, comments, or clarifications about this budget line item for internal reference and donor communication.',
    `quantity` DECIMAL(18,2) COMMENT 'The number of units planned for this budget line item. Used with unit cost to calculate total planned amount.',
    `revision_reason` STRING COMMENT 'Explanation for any revision or amendment to this budget line. Required for donor reporting and audit trail.',
    `sdg_alignment` STRING COMMENT 'United Nations Sustainable Development Goal number(s) that this budget line contributes to (e.g., SDG 1, SDG 3, SDG 6). Supports impact reporting.',
    `total_planned_amount` DECIMAL(18,2) COMMENT 'The total budgeted amount for this line item, typically calculated as quantity multiplied by unit cost. Primary financial value for budget versus actual (BvA) tracking.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per single unit of measure. Multiplied by quantity to derive the total planned amount for this line.',
    `unit_of_measure` STRING COMMENT 'The unit by which the budget item is measured (e.g., person-months, trips, units, days, hours, items, sessions).',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this budget line record. Supports audit trail and data governance.',
    CONSTRAINT pk_budget_plan_line PRIMARY KEY(`budget_plan_line_id`)
) COMMENT 'Individual budget line item within a program budget, capturing cost category (personnel, fringe, travel, equipment, supplies, contractual, other direct costs, indirect costs), budget line description, unit cost, quantity, unit of measure, total planned amount, donor budget code, and cost-sharing flag. Enables granular budget management, BvA tracking linkage to finance domain, and donor financial reporting by budget category.';

CREATE OR REPLACE TABLE `ngo_ecm`.`program`.`partner_linkage` (
    `partner_linkage_id` BIGINT COMMENT 'Unique identifier for the program-partner linkage record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Partner linkage records must reference the formal partnership agreement governing the relationship for legal compliance, obligation tracking, performance assessment against MOU terms, and dispute reso',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: NGO sub-award compliance: FFATA and donor regulations require tracking which implementing partners are funded under each award. Partner linkages must be tied to specific awards for sub-award reporting',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: NGO sub-award activation requires a completed capacity assessment. Linking partner_linkage directly to capacity_assessment replaces denormalized score/date/status fields and enables direct retrieval o',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Implementing partners in humanitarian programs are frequently assigned to specific components or workstreams rather than the entire intervention. For example, a local NGO partner may implement only th',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NGO sub-award partner expenditures are posted to specific cost centers for financial reporting and indirect cost allocation. partner_linkage has budget_allocated_amount requiring cost center assignmen',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Sub-award partner linkages must comply with donor-specific flow-down requirements (USAID ADS 303, EU sub-contracting rules). Compliance officers must trace which donor requirement governs each partner',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: NGO sub-award partner allocations consume grant budgets. Linking partner_linkage to grant_budget enables sub-award budget utilization tracking, donor financial reporting, and pass-through funding comp',
    `internal_review_id` BIGINT COMMENT 'Foreign key linking to compliance.internal_review. Business justification: NGO compliance teams conduct internal reviews (sub-recipient monitoring visits, financial spot-checks) on implementing partners. Linking partner_linkage to the most recent internal_review enables comp',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program intervention to which this partner is linked.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: In NGO operations, specific field offices or country teams manage partner relationships. Linking partner_linkage to the managing org_unit enables field office accountability reporting, partner monitor',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: Partner organizations may also be donors/funders. Tracks dual-role relationships where implementing partners are also funding partners. Essential for relationship management, conflict-of-interest trac',
    `partner_org_id` BIGINT COMMENT 'Reference to the implementing partner organization (local NGO, CBO, INGO, government counterpart) assigned to this program.',
    `staff_member_id` BIGINT COMMENT 'FK to workforce.staff_member',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: Partners must be screened against sanctions lists before engagement (OFAC, UN, EU sanctions). Essential for nonprofit due diligence and counter-terrorism financing compliance.',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: NGO sub-award management: partner_linkage.sub_award_reference is a plain-text denormalization of the formal subaward agreement. A proper FK to subaward enforces referential integrity and enables direc',
    `beneficiary_reached_count` STRING COMMENT 'Actual number of beneficiaries reached by this partner to date within this program.',
    `beneficiary_target_count` STRING COMMENT 'Target number of beneficiaries this partner is responsible for reaching within this program.',
    `budget_allocated_amount` DECIMAL(18,2) COMMENT 'Total budget amount allocated to this partner for implementation of their scope of work within the program.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget allocated amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `capacity_building_required_flag` BOOLEAN COMMENT 'Indicates whether capacity building or technical assistance is required for this partner to successfully implement the program (True/False).',
    `community_based_organization_flag` BOOLEAN COMMENT 'Indicates whether this partner is a community-based organization (CBO) operating at grassroots level (True/False).',
    `compliance_status` STRING COMMENT 'Current compliance status of the partner with donor requirements, regulatory standards, and organizational policies for this program (e.g., compliant, non-compliant, conditional, under review, not assessed).. Valid values are `compliant|non_compliant|conditional|under_review|not_assessed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner linkage record was first created in the system.',
    `end_date` DATE COMMENT 'Planned or actual date when the partners implementation responsibilities for this program conclude.',
    `geographic_scope` STRING COMMENT 'Description of the geographic area or administrative regions where this partner is responsible for program implementation (e.g., specific districts, provinces, or communities).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this partner linkage record was last updated or modified.',
    `last_monitoring_visit_date` DATE COMMENT 'Date of the most recent field monitoring visit to the partners implementation sites for this program.',
    `last_report_submission_date` DATE COMMENT 'Date when the partner last submitted a progress or financial report for this program.',
    `local_partner_flag` BOOLEAN COMMENT 'Indicates whether this partner is a local or national organization (as opposed to an international organization) (True/False).',
    `monitoring_visit_count` STRING COMMENT 'Total number of field monitoring visits conducted to this partners implementation sites for this program.',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or context about this program-partner linkage.',
    `partnership_role` STRING COMMENT 'The functional role the partner organization plays in this program intervention (e.g., lead implementer, sub-grantee, technical partner, government counterpart, consortium member, capacity building partner).. Valid values are `lead_implementer|sub_grantee|technical_partner|government_counterpart|consortium_member|capacity_building_partner`',
    `partnership_status` STRING COMMENT 'Current lifecycle status of the program-partner linkage (e.g., active, pending, suspended, terminated, completed, under review).. Valid values are `active|pending|suspended|terminated|completed|under_review`',
    `partnership_type` STRING COMMENT 'Classification of the partnership arrangement (e.g., direct implementation, sub-award, technical assistance, coordination, joint implementation, government collaboration).. Valid values are `direct_implementation|sub_award|technical_assistance|coordination|joint_implementation|government_collaboration`',
    `performance_rating` STRING COMMENT 'Overall performance rating of the partner for this program implementation (e.g., outstanding, exceeds expectations, meets expectations, needs improvement, unsatisfactory, not rated).. Valid values are `outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated`',
    `performance_review_date` DATE COMMENT 'Date of the most recent performance review or evaluation of the partners implementation activities.',
    `reporting_frequency` STRING COMMENT 'Required frequency for the partner to submit progress reports for this program (e.g., weekly, biweekly, monthly, quarterly, semi-annual, annual, ad-hoc). [ENUM-REF-CANDIDATE: weekly|biweekly|monthly|quarterly|semi_annual|annual|ad_hoc — 7 candidates stripped; promote to reference product]',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to this partnership based on capacity assessment, due diligence, and operational context (e.g., low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `sector_focus` STRING COMMENT 'Primary humanitarian or development sector(s) this partner is responsible for within the program (e.g., WASH, health, nutrition, education, protection, livelihoods). May be multi-sector.',
    `start_date` DATE COMMENT 'Date when the partner officially began implementation activities for this program.',
    `termination_reason` STRING COMMENT 'Explanation or reason for termination if the partnership was ended prematurely (e.g., non-compliance, performance issues, security concerns, mutual agreement).',
    CONSTRAINT pk_partner_linkage PRIMARY KEY(`partner_linkage_id`)
) COMMENT 'Association entity capturing the relationship between a program intervention and its implementing partners (local NGOs, CBOs, INGOs, government counterparts). Stores partner role (lead implementer, sub-grantee, technical partner, government counterpart), partnership type, geographic scope of partnership, capacity assessment status, sub-award reference, start/end dates, and performance rating. Distinct from the partnership domains MoU/LoA/SoW records which own the legal agreement — this product owns the program-specific partner assignment, role definition, and implementation performance tracking for each intervention.';

CREATE OR REPLACE TABLE `ngo_ecm`.`program`.`review_event` (
    `review_event_id` BIGINT COMMENT 'Unique identifier for the program review, reporting, or learning event. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Program review events for partner-implemented interventions must reference the partnership agreement to assess compliance with MOU obligations, deliverable achievement, reporting requirements, and per',
    `award_id` BIGINT COMMENT 'Reference to the grant funding this program, if the review event is tied to donor reporting requirements.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: NGO review events (mid-term reviews, evaluations, donor reports) reference the finance budget for financial summary sections. review_event has denormalized financial_summary_budget_amount — a proper F',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to program.budget_plan. Business justification: Review events include financial summaries (financial_summary_budget_amount, financial_summary_expenditure_amount) that must be contextualized against the approved budget plan. Adding budget_plan_id to',
    `donor_fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Donor fund reporting process: NGOs produce review events (mid-term reviews, final reports) to satisfy specific donor fund reporting requirements. Program officers must pull all review events per donor',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Review events (mid-term reviews, final evaluations) are mandated by specific donor requirements in grant agreements. Compliance officers must trace which donor requirement obligates each review event ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: NGO review events (quarterly/annual donor reports, mid-term reviews) are tied to fiscal periods for financial reporting alignment. review_event has reporting_period_start/end_date but no fiscal_period',
    `grant_amendment_id` BIGINT COMMENT 'Foreign key linking to grant.grant_amendment. Business justification: NGO program governance: mid-term reviews and evaluations frequently inform or are required by grant amendments. Linking review events to the amendment they triggered or resulted from enables grant off',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: NGO donor review events and progress reports must reference the specific grant budget for financial accountability sections. Linking review_event to grant_budget enables direct grant financial perform',
    `implementation_plan_id` BIGINT COMMENT 'Foreign key linking to program.implementation_plan. Business justification: Review events (mid-term reviews, final evaluations, progress reviews) assess performance against the implementation plan. Adding implementation_plan_id to review_event creates a direct link between th',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Program review events (field monitoring visits, after-action reviews) frequently surface compliance incidents (fraud, safeguarding violations, misuse of funds). Linking review_event to compliance_inci',
    `intervention_id` BIGINT COMMENT 'Reference to the program or intervention being reviewed or reported on.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Donor reporting and CHS compliance require identifying the accountable staff member who authored each review/evaluation. lead_author_name is a denormalized string; a proper FK enables staff performa',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Program review events (mid-term reviews, evaluations, field visits) in NGOs frequently target a specific partner org as the subject. This link supports partner-specific review tracking, performance re',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: Donor report submission tracking: Review events (donor reports, evaluations) are submitted to specific donor constituent organizations. NGOs track which constituent received each report for stewardshi',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: NGO review events (mid-term reviews, annual reviews, donor reporting events) are always scoped to a formal reporting period. Linking review_event to reporting_period enables period-based aggregation o',
    `internal_review_id` BIGINT COMMENT 'Foreign key linking to compliance.internal_review. Business justification: Program review events (mid-term evaluations, after-action reviews) are often triggered by or conducted alongside compliance internal reviews. NGO compliance officers need to trace which internal revie',
    `approval_date` DATE COMMENT 'Date the review event or report was formally approved by the designated authority.',
    `approved_by_name` STRING COMMENT 'Name of the individual or role who formally approved this review event or report.',
    `beneficiary_reach_children` BIGINT COMMENT 'Number of children (under 18) reached during the reporting period.',
    `beneficiary_reach_female` BIGINT COMMENT 'Number of female beneficiaries reached during the reporting period.',
    `beneficiary_reach_male` BIGINT COMMENT 'Number of male beneficiaries reached during the reporting period.',
    `beneficiary_reach_total` BIGINT COMMENT 'Total number of beneficiaries reached during the reporting period, as reported in this review event.',
    `challenges_narrative` STRING COMMENT 'Narrative description of challenges, constraints, and obstacles encountered during the reporting period.',
    `chs_compliance_flag` BOOLEAN COMMENT 'Indicates whether this review event assessed or confirmed compliance with the Core Humanitarian Standard.',
    `cluster_submission_flag` BOOLEAN COMMENT 'Indicates whether this report was submitted to a humanitarian cluster coordination mechanism (e.g., WASH cluster, Health cluster).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this review event record was first created in the system.',
    `dissemination_date` DATE COMMENT 'Date the report or learning output was published or disseminated to stakeholders.',
    `document_url` STRING COMMENT 'URL or file path to the full review report or learning document stored in the document management system.',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this review event or report is intended for donor visibility and external dissemination.',
    `event_code` STRING COMMENT 'Business identifier or reference code for the review event, often used in donor correspondence and internal tracking systems.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `event_status` STRING COMMENT 'Current lifecycle status of the review event or report. Tracks progression from draft through submission, approval, and dissemination. [ENUM-REF-CANDIDATE: draft|in_progress|submitted|under_review|approved|published|archived|cancelled — 8 candidates stripped; promote to reference product]',
    `event_type` STRING COMMENT 'Classification of the review or reporting event. Includes formal reviews (mid-term, annual, after-action, donor missions), periodic reports (quarterly, semi-annual, annual, final, SitRep, flash), and structured learning outputs (lessons learned, best practices, innovations, failure analyses). [ENUM-REF-CANDIDATE: mid_term_review|annual_review|after_action_review|donor_review_mission|quarterly_progress_report|semi_annual_report|annual_report|final_report|sitrep|flash_report|lessons_learned|best_practice_documentation|innovation_case_study|failure_analysis — 14 candidates stripped; promote to reference product]',
    `executive_summary` STRING COMMENT 'High-level summary of the review event or report, capturing key messages for senior management and donors.',
    `follow_up_actions` STRING COMMENT 'List or narrative of follow-up actions agreed upon in response to the review findings and recommendations.',
    `key_findings` STRING COMMENT 'Summary of the key findings from the review, assessment, or reporting period. Captures evidence-based observations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this review event record was last updated.',
    `lessons_learned_summary` STRING COMMENT 'Summary of lessons learned during the reporting period or review, intended to inform future programming and organizational learning.',
    `management_response` STRING COMMENT 'Formal response from program management to the findings and recommendations, including acceptance, rejection, or modification of recommendations.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to this review event.',
    `progress_narrative` STRING COMMENT 'Detailed narrative describing progress against planned outputs, outcomes, and activities during the reporting period.',
    `recommendations` STRING COMMENT 'List or narrative of recommendations arising from the review or report, intended to inform future program design and implementation.',
    `reporting_period_end_date` DATE COMMENT 'End date of the period covered by this review or report.',
    `reporting_period_start_date` DATE COMMENT 'Start date of the period covered by this review or report.',
    `review_date` DATE COMMENT 'The date on which the review event or mission took place, or the date the report was finalized. Represents the principal business event timestamp for this record.',
    `review_team_members` STRING COMMENT 'Comma-separated list or narrative description of the review team members or contributors.',
    `scope_description` STRING COMMENT 'Narrative description of the scope of the review or report, including geographic areas, program components, and thematic focus.',
    `sphere_standards_applied_flag` BOOLEAN COMMENT 'Indicates whether Sphere Humanitarian Charter and Minimum Standards were applied or assessed in this review event.',
    `submission_date` DATE COMMENT 'Date the report or review findings were formally submitted to the intended audience (donor, management, cluster).',
    CONSTRAINT pk_review_event PRIMARY KEY(`review_event_id`)
) COMMENT 'Unified record for all formal program review, reporting, and learning events including mid-term reviews, annual reviews, after-action reviews, donor review missions, progress reports (quarterly, semi-annual, annual, final, SitRep, flash report), and structured learning outputs (lessons learned, best practices, innovations, failure analyses). Captures event/report type, reporting period, date range, review team/author, scope, key findings, narrative sections (progress against outputs, challenges, beneficiary reach figures, financial summary), recommendations, management response, follow-up actions, submission date, submission status, approval workflow, and dissemination status. Serves as the SSOT for all program knowledge events, donor/cluster reporting submissions, and internal governance reporting. Distinct from MEL domain evaluations (which own evaluation methodology, TOR, and evaluator management) — this product owns the program management reporting and review lifecycle.';

CREATE OR REPLACE TABLE `ngo_ecm`.`program`.`program` (
    `program_id` BIGINT COMMENT 'Primary key for program',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: NGO programs are managed through designated cost centers for organizational financial reporting, indirect cost allocation, and functional expense classification. A nonprofit CFO expects each program t',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Programs are anchored to and managed by country offices. Country offices own program budgets, staff, and donor relationships. This link is fundamental for country-level program portfolio management, a',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: Emergency response programs are directly triggered by declared emergencies. Linking program to emergency enables emergency-specific program portfolio tracking, HRP progress reporting, and CERF/flash a',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Programs are owned and managed by specific org units (country offices, regional offices, HQ departments). This link is fundamental to organizational accountability reporting, budget allocation by unit',
    `approval_date` DATE COMMENT 'Date when the program proposal was formally approved by internal governance or donor.',
    `closeout_date` DATE COMMENT 'Date when all program activities, financial reconciliation, and final reporting were completed.',
    `cluster_code` STRING COMMENT 'Code identifying the humanitarian cluster or sector coordination mechanism the program is aligned with (e.g., WASH, Health, Protection).',
    `compliance_status` STRING COMMENT 'Current compliance standing with donor requirements, regulatory obligations, and internal policies.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 code for the primary country of program implementation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `end_date` DATE COMMENT 'Planned or actual end date when program activities conclude and closeout begins.',
    `geographic_scope` STRING COMMENT 'Spatial scale of program implementation indicating coverage area.',
    `grant_number` STRING COMMENT 'Unique grant or award number assigned by the donor for tracking and reporting purposes.',
    `is_emergency` BOOLEAN COMMENT 'Indicates whether the program is classified as an emergency response intervention requiring expedited procedures.',
    `is_multi_year` BOOLEAN COMMENT 'Indicates whether the program spans multiple fiscal years requiring multi-year budgeting and planning.',
    `logframe_reference` STRING COMMENT 'Reference identifier or document link to the programs Logical Framework Matrix defining objectives, indicators, and assumptions.',
    `modified_by` STRING COMMENT 'Username or identifier of the user who last modified the program record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was last updated in the system.',
    `monitoring_frequency` STRING COMMENT 'Scheduled frequency for program monitoring and evaluation activities.',
    `program_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the program for identification across systems and donor reporting.',
    `program_description` STRING COMMENT 'Comprehensive narrative describing the programs objectives, scope, target population, and expected outcomes.',
    `program_name` STRING COMMENT 'Official name of the humanitarian or development program as registered with donors and governing bodies.',
    `program_status` STRING COMMENT 'Current lifecycle status of the program indicating its operational state.',
    `program_type` STRING COMMENT 'Classification of the program based on its primary intervention approach and duration.',
    `region` STRING COMMENT 'Geographic region or administrative area within the country where the program operates.',
    `reporting_frequency` STRING COMMENT 'Required frequency for submitting progress and financial reports to donors and stakeholders.',
    `risk_rating` STRING COMMENT 'Overall risk assessment level for the program considering contextual, operational, financial, and reputational risks.',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of SDG goal numbers (1-17) and targets that the program contributes to.',
    `sector_code` STRING COMMENT 'Five-digit code identifying the primary humanitarian or development sector (WASH, Health, Nutrition, Education, Protection, Livelihood, Shelter, etc.).',
    `sector_name` STRING COMMENT 'Human-readable name of the primary sector in which the program operates.',
    `start_date` DATE COMMENT 'Official start date when program implementation begins as per the approved proposal or agreement.',
    `subsector` STRING COMMENT 'More granular classification within the primary sector (e.g., Water Supply, Sanitation, Hygiene Promotion under WASH).',
    `target_beneficiaries` STRING COMMENT 'Planned total number of direct beneficiaries the program aims to reach.',
    `target_population` STRING COMMENT 'Description of the intended beneficiary population including demographic characteristics, vulnerability criteria, and geographic scope.',
    `theory_of_change` STRING COMMENT 'Narrative or structured description of the causal pathway linking program inputs, activities, outputs, outcomes, and impact.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created the program record.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Master reference table for program. Referenced by program_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ngo_ecm`.`program`.`intervention` ADD CONSTRAINT `fk_program_intervention_program_id` FOREIGN KEY (`program_id`) REFERENCES `ngo_ecm`.`program`.`program`(`program_id`);
ALTER TABLE `ngo_ecm`.`program`.`component` ADD CONSTRAINT `fk_program_component_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`program`.`component` ADD CONSTRAINT `fk_program_component_parent_component_id` FOREIGN KEY (`parent_component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`program`.`target_population` ADD CONSTRAINT `fk_program_target_population_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`program`.`target_population` ADD CONSTRAINT `fk_program_target_population_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `ngo_ecm`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_implementation_plan_id` FOREIGN KEY (`implementation_plan_id`) REFERENCES `ngo_ecm`.`program`.`implementation_plan`(`implementation_plan_id`);
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ADD CONSTRAINT `fk_program_program_amendment_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ADD CONSTRAINT `fk_program_risk_register_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `ngo_ecm`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ADD CONSTRAINT `fk_program_implementation_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ADD CONSTRAINT `fk_program_budget_plan_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `ngo_ecm`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ADD CONSTRAINT `fk_program_budget_plan_line_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_component_id` FOREIGN KEY (`component_id`) REFERENCES `ngo_ecm`.`program`.`component`(`component_id`);
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ADD CONSTRAINT `fk_program_partner_linkage_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_budget_plan_id` FOREIGN KEY (`budget_plan_id`) REFERENCES `ngo_ecm`.`program`.`budget_plan`(`budget_plan_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_implementation_plan_id` FOREIGN KEY (`implementation_plan_id`) REFERENCES `ngo_ecm`.`program`.`implementation_plan`(`implementation_plan_id`);
ALTER TABLE `ngo_ecm`.`program`.`review_event` ADD CONSTRAINT `fk_program_review_event_intervention_id` FOREIGN KEY (`intervention_id`) REFERENCES `ngo_ecm`.`program`.`intervention`(`intervention_id`);

-- ========= TAGS =========
ALTER SCHEMA `ngo_ecm`.`program` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `ngo_ecm`.`program` SET TAGS ('dbx_domain' = 'program');
ALTER TABLE `ngo_ecm`.`program`.`intervention` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`program`.`intervention` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention ID');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `governance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Governance Policy Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Organizational Unit (Org Unit) ID');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager ID');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `chs_compliant` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Compliant');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `disability_inclusion_marker_score` SET TAGS ('dbx_business_glossary_term' = 'Disability Inclusion Marker Score');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `disability_inclusion_marker_score` SET TAGS ('dbx_value_regex' = '0|1|2|3|4');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `disability_inclusion_marker_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `disability_inclusion_marker_score` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `do_no_harm_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'Do No Harm Assessment Completed');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `environmental_impact_assessment_completed` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment Completed');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `gender_marker_score` SET TAGS ('dbx_business_glossary_term' = 'Gender Marker Score');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `gender_marker_score` SET TAGS ('dbx_value_regex' = '0|1|2a|2b');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `gender_marker_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `gender_marker_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'national|regional|district|community|multi_country');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `intervention_code` SET TAGS ('dbx_business_glossary_term' = 'Intervention Code');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `intervention_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `intervention_name` SET TAGS ('dbx_business_glossary_term' = 'Intervention Name');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `intervention_status` SET TAGS ('dbx_business_glossary_term' = 'Intervention Status');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `intervention_status` SET TAGS ('dbx_value_regex' = 'pipeline|approved|active|suspended|completed|closed');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `intervention_type` SET TAGS ('dbx_business_glossary_term' = 'Intervention Type');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `intervention_type` SET TAGS ('dbx_value_regex' = 'emergency_response|development|recovery|resilience|advocacy|capacity_building');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `logframe_document_url` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Document URL');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `logic` SET TAGS ('dbx_business_glossary_term' = 'Intervention Logic');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `mel_plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Plan Document URL');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Intervention Phase');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'design|startup|implementation|closeout');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `rbm_framework_applied` SET TAGS ('dbx_business_glossary_term' = 'Results-Based Management (RBM) Framework Applied');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `sdg_alignment_type` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment Type');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `sdg_alignment_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|enabling');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `sdg_contribution_narrative` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Contribution Narrative');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `sdg_goal_primary` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Primary Goal');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `sdg_goal_primary` SET TAGS ('dbx_value_regex' = '^SDG[0-9]{1,2}$');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `sdg_indicator_primary` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Primary Indicator');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `sdg_indicator_primary` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}.[0-9]{1,2}.[0-9]{1,2}$');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `sdg_target_primary` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Primary Target');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `sdg_target_primary` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}.[0-9]{1,2}$');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Sector');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Intervention Short Name');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `situation_analysis` SET TAGS ('dbx_business_glossary_term' = 'Situation Analysis');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `sub_sector` SET TAGS ('dbx_business_glossary_term' = 'Sub-Sector');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `sustainability_plan` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Plan');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `target_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `target_beneficiary_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Unit');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `target_beneficiary_unit` SET TAGS ('dbx_value_regex' = 'individuals|households|communities|institutions');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `targeting_strategy` SET TAGS ('dbx_business_glossary_term' = 'Targeting Strategy');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `theory_of_change_narrative` SET TAGS ('dbx_business_glossary_term' = 'Theory of Change (ToC) Narrative');
ALTER TABLE `ngo_ecm`.`program`.`intervention` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `ngo_ecm`.`program`.`component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`program`.`component` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component ID');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `parent_component_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Component ID');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|revision_required|rejected');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `budget_envelope_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Envelope Amount');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `component_code` SET TAGS ('dbx_business_glossary_term' = 'Component Code');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `component_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `component_name` SET TAGS ('dbx_business_glossary_term' = 'Component Name');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `component_status` SET TAGS ('dbx_business_glossary_term' = 'Component Status');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `component_status` SET TAGS ('dbx_value_regex' = 'planned|active|on_hold|completed|closed|cancelled');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'component|sub-component|workstream|activity_cluster|pilot|scale_up');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `cross_cutting_themes` SET TAGS ('dbx_business_glossary_term' = 'Cross-Cutting Themes');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Component End Date');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `geographic_focus` SET TAGS ('dbx_business_glossary_term' = 'Geographic Focus');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `grant_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Grant Requirement Flag');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `implementation_modality` SET TAGS ('dbx_business_glossary_term' = 'Implementation Modality');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `implementation_modality` SET TAGS ('dbx_value_regex' = 'direct|partner|consortium|sub_award|community_based');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Integration Flag');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Component Notes');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|final_only');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Sector');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Component Start Date');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `sub_sector` SET TAGS ('dbx_business_glossary_term' = 'Sub-Sector');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `target_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `ngo_ecm`.`program`.`component` ALTER COLUMN `theory_of_change_reference` SET TAGS ('dbx_business_glossary_term' = 'Theory of Change (ToC) Reference');
ALTER TABLE `ngo_ecm`.`program`.`target_population` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`program`.`target_population` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `target_population_id` SET TAGS ('dbx_business_glossary_term' = 'Target Population Identifier (ID)');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `age_range_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Age Range');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `age_range_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Range');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Displacement Status');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `displacement_status` SET TAGS ('dbx_value_regex' = 'idp|refugee|returnee|host_community|mixed|not_applicable');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `do_no_harm_considerations` SET TAGS ('dbx_business_glossary_term' = 'Do No Harm Considerations');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `estimated_population_size` SET TAGS ('dbx_business_glossary_term' = 'Estimated Population Size');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `exclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exclusion Criteria');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `gender_integration_approach` SET TAGS ('dbx_business_glossary_term' = 'Gender Integration Approach');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `gender_integration_approach` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `gender_integration_approach` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `host_community_population_count` SET TAGS ('dbx_business_glossary_term' = 'Host Community Population Count');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `idp_population_count` SET TAGS ('dbx_business_glossary_term' = 'Internally Displaced Person (IDP) Population Count');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `inclusion_criteria` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Criteria');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `planned_reach` SET TAGS ('dbx_business_glossary_term' = 'Planned Reach');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `population_code` SET TAGS ('dbx_business_glossary_term' = 'Target Population Code');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `population_description` SET TAGS ('dbx_business_glossary_term' = 'Target Population Description');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `population_name` SET TAGS ('dbx_business_glossary_term' = 'Target Population Name');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `protection_mainstreaming_flag` SET TAGS ('dbx_business_glossary_term' = 'Protection Mainstreaming Flag');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `refugee_population_count` SET TAGS ('dbx_business_glossary_term' = 'Refugee Population Count');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `sector_classification` SET TAGS ('dbx_business_glossary_term' = 'Sector Classification');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `sex_disaggregation` SET TAGS ('dbx_business_glossary_term' = 'Sex Disaggregation');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `sex_disaggregation` SET TAGS ('dbx_value_regex' = 'all|male|female|other|mixed');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `target_population_status` SET TAGS ('dbx_business_glossary_term' = 'Target Population Status');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `target_population_status` SET TAGS ('dbx_value_regex' = 'draft|approved|active|suspended|closed');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `targeting_methodology` SET TAGS ('dbx_business_glossary_term' = 'Targeting Methodology');
ALTER TABLE `ngo_ecm`.`program`.`target_population` ALTER COLUMN `vulnerability_category` SET TAGS ('dbx_business_glossary_term' = 'Vulnerability Category');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` SET TAGS ('dbx_subdomain' = 'operational_planning');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `program_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Amendment Identifier (ID)');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Donor Constituent Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `grant_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `implementation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_business_glossary_term' = 'Amendment Status');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `amendment_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Amendment Type');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `amendment_type` SET TAGS ('dbx_value_regex' = 'no_cost_extension|scope_change|budget_reallocation|geographic_expansion|target_population_adjustment|logframe_revision');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Approval Date');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `budget_change_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Change Amount');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `budget_change_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Change Currency Code');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `budget_change_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `compliance_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Compliance Impact Assessment');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Amendment Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `donor_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Donor Approval Reference Number');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Effective Date');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `geographic_coverage_change` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage Change Description');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `grant_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Grant Requirement Flag');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `internal_approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Internal Approving Authority');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `justification_narrative` SET TAGS ('dbx_business_glossary_term' = 'Amendment Justification Narrative');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Amendment Last Modified By User');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Amendment Record Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `logframe_revision_flag` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Revision Flag');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `logframe_revision_summary` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Revision Summary');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `original_end_date` SET TAGS ('dbx_business_glossary_term' = 'Original Program End Date');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `original_target_beneficiaries` SET TAGS ('dbx_business_glossary_term' = 'Original Target Beneficiaries Count');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Rejection Reason');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `revised_end_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Program End Date');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `revised_target_beneficiaries` SET TAGS ('dbx_business_glossary_term' = 'Revised Target Beneficiaries Count');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Amendment Risk Assessment');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `scope_change_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Description');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `sdg_alignment_change` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment Change');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `sector_classification_change` SET TAGS ('dbx_business_glossary_term' = 'Sector Classification Change Description');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `stakeholder_consultation_summary` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Consultation Summary');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Submission Date');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `supporting_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `target_population_change` SET TAGS ('dbx_business_glossary_term' = 'Target Population Change Description');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `timeline_extension_days` SET TAGS ('dbx_business_glossary_term' = 'Timeline Extension Days');
ALTER TABLE `ngo_ecm`.`program`.`program_amendment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Withdrawal Reason');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` SET TAGS ('dbx_subdomain' = 'operational_planning');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `risk_register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register ID');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `governance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Governance Policy Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `grant_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `affected_sdg` SET TAGS ('dbx_business_glossary_term' = 'Affected Sustainable Development Goal (SDG)');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `affected_sector` SET TAGS ('dbx_business_glossary_term' = 'Affected Sector');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `contingency_plan` SET TAGS ('dbx_business_glossary_term' = 'Contingency Plan');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Date');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Impact Rating');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `impact_rating` SET TAGS ('dbx_value_regex' = 'very low|low|medium|high|very high');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `impact_score` SET TAGS ('dbx_business_glossary_term' = 'Impact Score');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Rating');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `likelihood_rating` SET TAGS ('dbx_value_regex' = 'very low|low|medium|high|very high');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `likelihood_score` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Score');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'operational|contextual|institutional|fiduciary|programmatic|reputational');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `risk_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Code');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `risk_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{3,5}$');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'open|monitoring|mitigated|closed|materialized');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `risk_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `risk_title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title');
ALTER TABLE `ngo_ecm`.`program`.`risk_register` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` SET TAGS ('dbx_subdomain' = 'operational_planning');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `implementation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan ID');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `distribution_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `donor_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `governance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Governance Policy Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `grant_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `volunteer_team_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Team Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `assumptions` SET TAGS ('dbx_business_glossary_term' = 'Implementation Assumptions');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `coordination_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Coordination Mechanism');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `disaggregation_approach` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation Approach');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `grant_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Grant Requirement Flag');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `last_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revision Date');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `logframe_reference` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Reference');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `monitoring_approach` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Approach');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Notes');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Code');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `plan_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Manager Name');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Status');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `plan_title` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Title');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Type');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|project_phase|emergency_response|pilot|scale_up');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `resource_requirements_summary` SET TAGS ('dbx_business_glossary_term' = 'Resource Requirements Summary');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Implementation Risk Level');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `risk_mitigation_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Summary');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `sector_classification` SET TAGS ('dbx_business_glossary_term' = 'Sector Classification');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `target_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `target_beneficiary_type` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Type');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `target_beneficiary_type` SET TAGS ('dbx_value_regex' = 'individuals|households|communities|institutions');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `toc_reference` SET TAGS ('dbx_business_glossary_term' = 'Theory of Change (ToC) Reference');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `total_planned_activities` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Activities Count');
ALTER TABLE `ngo_ecm`.`program`.`implementation_plan` ALTER COLUMN `total_planned_milestones` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Milestones Count');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` SET TAGS ('dbx_subdomain' = 'operational_planning');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan ID');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `donor_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `grant_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Amendment Reason');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `budget_assumptions` SET TAGS ('dbx_business_glossary_term' = 'Budget Assumptions');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `budget_narrative` SET TAGS ('dbx_business_glossary_term' = 'Budget Narrative');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `budget_owner` SET TAGS ('dbx_business_glossary_term' = 'Budget Owner');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `budget_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `budget_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `budget_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Name');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `budget_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Number');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `budget_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Type');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `budget_type` SET TAGS ('dbx_value_regex' = 'original|revised|supplemental|no_cost_extension|closeout');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `budget_version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `contractual_costs` SET TAGS ('dbx_business_glossary_term' = 'Contractual Costs');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `donor_budget_code` SET TAGS ('dbx_business_glossary_term' = 'Donor Budget Code');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `equipment_costs` SET TAGS ('dbx_business_glossary_term' = 'Equipment Costs');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `finance_contact` SET TAGS ('dbx_business_glossary_term' = 'Finance Contact');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `fringe_benefits_costs` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefits Costs');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `indirect_costs` SET TAGS ('dbx_business_glossary_term' = 'Indirect Costs (F&A)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `personnel_costs` SET TAGS ('dbx_business_glossary_term' = 'Personnel Costs');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `sector_classification` SET TAGS ('dbx_business_glossary_term' = 'Sector Classification');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Submitted Date');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `supplies_costs` SET TAGS ('dbx_business_glossary_term' = 'Supplies Costs');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `total_approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Budget Amount');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `total_direct_costs` SET TAGS ('dbx_business_glossary_term' = 'Total Direct Costs');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan` ALTER COLUMN `travel_costs` SET TAGS ('dbx_business_glossary_term' = 'Travel Costs');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` SET TAGS ('dbx_subdomain' = 'operational_planning');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `budget_plan_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Line ID');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan ID');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `donor_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `activity_code` SET TAGS ('dbx_business_glossary_term' = 'Activity Code');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `allowable_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Allowable Cost Flag');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `budget_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `budget_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `budget_plan_line_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `budget_version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `chart_of_accounts_code` SET TAGS ('dbx_business_glossary_term' = 'Chart of Accounts (CoA) Code');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `cost_sharing_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Amount');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `cost_sharing_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Flag');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `cost_sharing_source` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Source');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `cost_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Cost Subcategory');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `direct_cost_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Cost Flag');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `donor_budget_code` SET TAGS ('dbx_business_glossary_term' = 'Donor Budget Code');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Number');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `total_planned_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Amount');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `ngo_ecm`.`program`.`budget_plan_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `partner_linkage_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Linkage Identifier (ID)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `internal_review_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Review Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Managing Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Constituent Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization Identifier (ID)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `beneficiary_reached_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Reached Count');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `beneficiary_target_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Target Count');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `budget_allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocated Amount');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `capacity_building_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Building Required Flag');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `community_based_organization_flag` SET TAGS ('dbx_business_glossary_term' = 'Community-Based Organization (CBO) Flag');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|under_review|not_assessed');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership End Date');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope of Partnership');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `last_monitoring_visit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Monitoring Visit Date');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `last_report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Last Report Submission Date');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `local_partner_flag` SET TAGS ('dbx_business_glossary_term' = 'Local Partner Flag');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `monitoring_visit_count` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Visit Count');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Partnership Notes');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `partnership_role` SET TAGS ('dbx_business_glossary_term' = 'Partnership Role');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `partnership_role` SET TAGS ('dbx_value_regex' = 'lead_implementer|sub_grantee|technical_partner|government_counterpart|consortium_member|capacity_building_partner');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `partnership_status` SET TAGS ('dbx_business_glossary_term' = 'Partnership Status');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `partnership_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|completed|under_review');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `partnership_type` SET TAGS ('dbx_business_glossary_term' = 'Partnership Type');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `partnership_type` SET TAGS ('dbx_value_regex' = 'direct_implementation|sub_award|technical_assistance|coordination|joint_implementation|government_collaboration');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Partner Performance Rating');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'outstanding|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Date');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Partnership Risk Rating');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `sector_focus` SET TAGS ('dbx_business_glossary_term' = 'Sector Focus');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Partnership Start Date');
ALTER TABLE `ngo_ecm`.`program`.`partner_linkage` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Partnership Termination Reason');
ALTER TABLE `ngo_ecm`.`program`.`review_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`program`.`review_event` SET TAGS ('dbx_subdomain' = 'operational_planning');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `review_event_id` SET TAGS ('dbx_business_glossary_term' = 'Review Event ID');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `donor_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `grant_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Amendment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `implementation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Implementation Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Author Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Constituent Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `internal_review_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Internal Review Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `beneficiary_reach_children` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Reach Children');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `beneficiary_reach_female` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Reach Female');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `beneficiary_reach_male` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Reach Male');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `beneficiary_reach_total` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Reach Total');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `challenges_narrative` SET TAGS ('dbx_business_glossary_term' = 'Challenges Narrative');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `chs_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Compliance Flag');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `cluster_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Cluster Submission Flag');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `dissemination_date` SET TAGS ('dbx_business_glossary_term' = 'Dissemination Date');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `event_code` SET TAGS ('dbx_business_glossary_term' = 'Review Event Code');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `event_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Review Event Status');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Review Event Type');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `executive_summary` SET TAGS ('dbx_business_glossary_term' = 'Executive Summary');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `follow_up_actions` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Actions');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `key_findings` SET TAGS ('dbx_business_glossary_term' = 'Key Findings');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `lessons_learned_summary` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned Summary');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `progress_narrative` SET TAGS ('dbx_business_glossary_term' = 'Progress Narrative');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Recommendations');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `review_team_members` SET TAGS ('dbx_business_glossary_term' = 'Review Team Members');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `sphere_standards_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Sphere Standards Applied Flag');
ALTER TABLE `ngo_ecm`.`program`.`review_event` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `ngo_ecm`.`program`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`program`.`program` SET TAGS ('dbx_subdomain' = 'program_design');
ALTER TABLE `ngo_ecm`.`program`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `ngo_ecm`.`program`.`program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`program` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`program` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`program`.`program` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
