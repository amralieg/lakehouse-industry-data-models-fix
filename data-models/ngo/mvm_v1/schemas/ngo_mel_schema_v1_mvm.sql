-- Schema for Domain: mel | Business: Ngo | Version: v1_mvm
-- Generated on: 2026-05-07 03:36:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `ngo_ecm`.`mel` COMMENT 'Owns all Monitoring, Evaluation, and Learning (MEL) and MEAL framework data. Manages indicator libraries, LogFrame targets vs. actuals, KPI tracking, PDM (Post-Distribution Monitoring) results, FGD and KII records, DHIS2 aggregate reporting, outcome measurement, impact assessments, and Results-Based Management (RBM) evidence. Supports DAC evaluation criteria and donor performance reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `ngo_ecm`.`mel`.`indicator` (
    `indicator_id` BIGINT COMMENT 'Unique identifier for the MEL (Monitoring Evaluation and Learning) indicator. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Indicators are agreement-specific reporting obligations. Business need: agreement compliance monitoring, donor reporting, performance-based payment triggers.',
    `award_id` BIGINT COMMENT 'Foreign key reference to the grant or award that mandates or funds the tracking of this indicator. Null if the indicator is used across multiple grants or is organization-wide.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: MEL indicators are often defined to satisfy specific donor reporting obligations (e.g., USAID F indicators, ECHO visibility requirements). Linking indicator definitions to the compliance obligations t',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: In NGO results frameworks, indicators are assigned at the component level — each funded component has distinct indicators for donor reporting. indicator currently links only to intervention_id, making',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Indicators are often mandated by specific donor requirements beyond the obligation level (e.g., a donor requires specific WASH indicators as grant conditions). indicator already has compliance_obligat',
    `intervention_id` BIGINT COMMENT 'Foreign key reference to the program that owns or primarily uses this indicator. An indicator may be used across multiple programs but typically has a primary owning program.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: NGO MEAL systems assign indicators to specific org units (country offices, departments) for reporting accountability and data ownership. Indicator performance dashboards and donor reports require org ',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Indicators frequently track partner-specific performance metrics in sub-award agreements. Business need: partner accountability reporting, disaggregated results by implementing partner, performance-ba',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: NGO MEAL accountability requires a named staff member responsible for each indicators data collection and reporting. The plain-text responsible_role is a denormalization of staff_member. Indicator ',
    `role_id` BIGINT COMMENT 'Foreign key linking to volunteer.role. Business justification: NGO MEL systems assign specific volunteer roles as responsible data collectors for each indicator (e.g., community health volunteer role for health indicators). This drives training compliance checks ',
    `baseline_date` DATE COMMENT 'The date when the baseline value was measured or established.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The initial measured value of the indicator at the start of the program or project, used as the reference point for measuring change and progress.',
    `calculation_method` STRING COMMENT 'Formula or methodology used to calculate the indicator value. For ratio indicators, includes numerator and denominator definitions. For count indicators, specifies aggregation rules.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this indicator record was first created in the system.',
    `dac_criteria_alignment` STRING COMMENT 'The OECD DAC (Development Assistance Committee) evaluation criteria that this indicator addresses: relevance, coherence, effectiveness, efficiency, impact, or sustainability. Multiple criteria may be comma-separated.',
    `data_collection_frequency` STRING COMMENT 'How often data for this indicator is collected and reported (e.g., monthly, quarterly, annually, one-time baseline/endline). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi-annually|annually|one-time|event-based — 8 candidates stripped; promote to reference product]',
    `data_collection_method` STRING COMMENT 'The methodology used to collect data for this indicator (e.g., household survey, key informant interview, direct observation, facility records, mobile data collection). [ENUM-REF-CANDIDATE: survey|interview|observation|administrative-records|focus-group|sensor|mobile-app|registry — 8 candidates stripped; promote to reference product]',
    `data_source` STRING COMMENT 'The primary source(s) from which data for this indicator is collected (e.g., DHIS2, KoboToolbox surveys, PDM (Post-Distribution Monitoring), FGD (Focus Group Discussion), KII (Key Informant Interview), administrative records, CommCare).',
    `definition` STRING COMMENT 'Detailed technical definition of what the indicator measures, including scope, boundaries, and any specific criteria or conditions that must be met.',
    `denominator_description` STRING COMMENT 'Definition of the denominator for percentage or ratio indicators. Describes the total population or base being measured. Null for count-based indicators.',
    `dhis2_indicator_code` STRING COMMENT 'The unique identifier for this indicator in the DHIS2 (District Health Information System 2) platform, used for integration and data synchronization.',
    `direction_of_change` STRING COMMENT 'The desired direction of change for this indicator to represent positive program impact (increase for positive indicators like vaccination coverage, decrease for negative indicators like malnutrition rates).. Valid values are `increase|decrease|maintain|not-applicable`',
    `disaggregation_dimensions` STRING COMMENT 'Comma-separated list of dimensions by which this indicator should be disaggregated for analysis (e.g., age, gender, location, disability status, IDP/refugee status). Critical for equity and inclusion analysis.',
    `effective_end_date` DATE COMMENT 'The date after which this indicator definition is no longer active. Null for currently active indicators.',
    `effective_start_date` DATE COMMENT 'The date from which this indicator definition became active and applicable for data collection and reporting.',
    `indicator_category` STRING COMMENT 'Measurement category of the indicator: quantitative (numeric), qualitative (descriptive), or composite (combination of multiple measures).. Valid values are `quantitative|qualitative|composite`',
    `indicator_code` STRING COMMENT 'Unique business identifier code for the indicator used across programs and grants. Often follows organizational or donor-specific coding conventions.. Valid values are `^[A-Z0-9]{3,20}$`',
    `indicator_name` STRING COMMENT 'Full descriptive name of the indicator as it appears in LogFrames (Logical Frameworks), donor reports, and MEL (Monitoring Evaluation and Learning) dashboards.',
    `indicator_status` STRING COMMENT 'Current lifecycle status of the indicator in the MEL (Monitoring Evaluation and Learning) system.. Valid values are `active|inactive|draft|archived|under-review`',
    `indicator_type` STRING COMMENT 'Classification of the indicator within the Results-Based Management (RBM) results chain: input (resources), process (activities), output (deliverables), outcome (short-term change), or impact (long-term change).. Valid values are `output|outcome|impact|process|input`',
    `is_custom` BOOLEAN COMMENT 'Flag indicating whether this is a custom indicator developed specifically for this organization or program (true) or a standard indicator from an external framework (false).',
    `is_mandatory` BOOLEAN COMMENT 'Flag indicating whether this indicator is mandatory for reporting to donors or governing bodies (true) or optional/supplementary (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this indicator record was last updated or modified.',
    `logframe_level` STRING COMMENT 'The level in the LogFrame (Logical Framework) hierarchy where this indicator is positioned: goal (impact), purpose (outcome), output (deliverable), or activity (process).. Valid values are `goal|purpose|output|activity`',
    `notes` STRING COMMENT 'Additional notes, guidance, or context for data collectors and analysts regarding this indicator, including any special considerations, limitations, or interpretation guidance.',
    `numerator_description` STRING COMMENT 'Definition of the numerator for percentage or ratio indicators. Describes what is being counted in the top of the fraction. Null for count-based indicators.',
    `reporting_frequency` STRING COMMENT 'How often this indicator must be reported to donors, management, or external stakeholders. May differ from collection frequency.. Valid values are `monthly|quarterly|semi-annually|annually|ad-hoc`',
    `sdg_alignment` STRING COMMENT 'The specific SDG (Sustainable Development Goal) goal and target numbers that this indicator contributes to (e.g., SDG 2.1, SDG 3.2). Multiple goals may be comma-separated.',
    `sector` STRING COMMENT 'The humanitarian or development sector this indicator belongs to (e.g., WASH (Water Sanitation and Hygiene), Health, Nutrition, Education, Protection, Shelter, Food Security, Livelihoods).',
    `target_date` DATE COMMENT 'The date by which the target value is expected to be achieved.',
    `target_value` DECIMAL(18,2) COMMENT 'The planned or target value that the program aims to achieve for this indicator by the end of the reporting period or project lifecycle.',
    `theme` STRING COMMENT 'Cross-cutting theme or focus area this indicator addresses (e.g., Gender Equality, Child Protection, Climate Adaptation, Disability Inclusion, GBV (Gender-Based Violence) Prevention).',
    `unit_of_measure` STRING COMMENT 'The unit in which the indicator is measured (e.g., number of people, percentage, households, liters, kilograms, days, sessions).',
    `verification_method` STRING COMMENT 'The method used to verify the accuracy and reliability of the indicator data (e.g., spot checks, third-party evaluation, beneficiary feedback, document review, field monitoring visits).',
    `version_number` STRING COMMENT 'Version identifier for this indicator definition, used to track changes to calculation methods, definitions, or disaggregation requirements over time.. Valid values are `^[0-9]+.[0-9]+$`',
    CONSTRAINT pk_indicator PRIMARY KEY(`indicator_id`)
) COMMENT 'Master library of all MEL indicators used across programs and grants. Each record defines one measurable indicator with its definition, calculation method, numerator/denominator (for percentage indicators), unit of measure, data collection frequency, disaggregation dimensions, baseline value, and alignment to SDG goals, DAC criteria, and LogFrame output/outcome levels. Serves as the single source of truth for indicator metadata referenced by targets, results, DHIS2 reporting, and donor performance frameworks.';

CREATE OR REPLACE TABLE `ngo_ecm`.`mel`.`logframe` (
    `logframe_id` BIGINT COMMENT 'Unique identifier for the logical framework record. Primary key for the MEL LogFrame entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Logframes are core agreement annexes defining results frameworks. Business need: agreement results tracking, donor reporting compliance, partnership performance monitoring.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Donor logframes are governed by specific compliance obligations (IATI publication, CHS commitments, statutory reporting). Linking logframe to the obligation that mandates its structure enables complia',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: NGO logframes are structured around components — each component (output, outcome workstream) has its own logframe section. mel_logframe links to intervention_id but not component_id, preventing compon',
    `consortium_id` BIGINT COMMENT 'Foreign key linking to partnership.consortium. Business justification: Consortium programs operate under a shared logframe that governs all member organizations results. NGOs develop consortium-level logframes for joint donor reporting and collective results measurement',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Logframe hierarchies (impact/outcome/output levels) are directly dictated by specific donor requirements. Linking logframe to the donor_requirement that mandated its structure enables traceability fro',
    `award_id` BIGINT COMMENT 'Reference to the grant or award that this logical framework supports. Links the LogFrame to the funding source and donor requirements.',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: Logframes are the programmatic framework for a grant and must align with the grant budget structure for results-based management. Linking logframe to grant_budget enables budget-to-results framework a',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that this logical framework defines. Links the LogFrame to operational program delivery.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: NGO logframes are owned and managed by specific org units (country offices, program departments). Logframe approval workflows, reporting hierarchies, and donor submissions require org unit attribution',
    `parent_logframe_mel_logframe_id` BIGINT COMMENT 'Self-referencing foreign key to the parent LogFrame entry in the hierarchy. Enables nested results chains where outputs roll up to outcomes, outcomes to goals.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Logframes track partner-implemented results in sub-award/consortium contexts. Business need: partner performance reporting against logframe indicators, disaggregated results tracking by implementing p',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: NGO logframe management assigns accountability to positions (not just individuals) for continuity during staff turnover. The plain-text responsible_party denormalizes position data. Logframe account',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Logframes track responsible_party as text but MEL accountability frameworks and donor reporting (USAID, FCDO) require linking to actual staff member for performance management and results framework ow',
    `role_id` BIGINT COMMENT 'Foreign key linking to volunteer.role. Business justification: Logframe result levels in community programs assign volunteer roles as responsible parties (e.g., community health volunteer role responsible for output-level results). mel_logframe.responsible_party ',
    `actual_date` DATE COMMENT 'Date of the most recent actual measurement. Used to track reporting currency and identify data staleness.',
    `actual_value` DECIMAL(18,2) COMMENT 'Most recent measured or reported value for the indicator. Updated through Monitoring Evaluation and Learning (MEL) data collection activities such as Post-Distribution Monitoring (PDM), Focus Group Discussions (FGD), or District Health Information System 2 (DHIS2) reporting.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or committee that approved this LogFrame. Critical for governance and donor compliance.',
    `approved_date` DATE COMMENT 'Date when this LogFrame was formally approved. Establishes the baseline for performance tracking and donor reporting.',
    `assumptions` STRING COMMENT 'External conditions or factors that must hold true for the intervention logic to succeed. Critical for risk management and Theory of Change (ToC) validation.',
    `baseline_date` DATE COMMENT 'Date when the baseline measurement was taken. Critical for establishing the temporal reference point for all subsequent measurements.',
    `baseline_value` DECIMAL(18,2) COMMENT 'Measured value of the indicator at the start of the program or intervention. Provides the starting point for measuring change and impact.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this LogFrame record was first created in the system. Audit trail for data governance.',
    `dac_evaluation_criterion` STRING COMMENT 'Development Assistance Committee (DAC) evaluation criterion that this LogFrame element addresses. Used to align program design with international evaluation standards.. Valid values are `Relevance|Coherence|Effectiveness|Efficiency|Impact|Sustainability`',
    `data_collection_method` STRING COMMENT 'Primary method used to collect data for this indicator. Examples include household surveys, Key Informant Interviews (KII), Focus Group Discussions (FGD), Post-Distribution Monitoring (PDM), or District Health Information System 2 (DHIS2) aggregate reporting.',
    `disaggregation_dimensions` STRING COMMENT 'Dimensions by which the indicator should be disaggregated for equity and inclusion analysis. Common dimensions include gender, age group, disability status, geographic location, and vulnerability category.',
    `donor_template_type` STRING COMMENT 'Identifies the donor-specific logical framework template or format used. Different donors require different LogFrame structures and terminology. [ENUM-REF-CANDIDATE: DFID|FCDO|USAID|EU|ECHO|UN|World Bank|Generic|Other — 9 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when this LogFrame version was superseded or the program ended. Null for currently active LogFrames.',
    `effective_start_date` DATE COMMENT 'Date when this LogFrame version became effective. Used to track LogFrame amendments and revisions over the program lifecycle.',
    `hierarchy_sequence` STRING COMMENT 'Numeric ordering within the results chain hierarchy. Used to maintain the logical sequence of goals, outcomes, outputs, and activities.',
    `intervention_statement` STRING COMMENT 'Narrative description of the intervention logic at this level of the results chain. Describes what the program intends to achieve or deliver.',
    `is_custom_indicator` BOOLEAN COMMENT 'Flag indicating whether this is a custom indicator defined by the implementing organization rather than a standard donor or sector indicator.',
    `is_mandatory_donor_indicator` BOOLEAN COMMENT 'Flag indicating whether this indicator is a mandatory reporting requirement from the donor. Mandatory indicators cannot be modified without prior approval.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this LogFrame record was last updated. Audit trail for tracking changes and amendments.',
    `last_review_date` DATE COMMENT 'Date of the most recent review or evaluation of this LogFrame element. Used to track adaptive management cycles and mid-term reviews.',
    `logframe_code` STRING COMMENT 'Business identifier or reference code for the logical framework, often aligned with donor proposal numbering or internal program codes.',
    `logframe_name` STRING COMMENT 'Descriptive name or title of the logical framework, typically reflecting the program or intervention name.',
    `means_of_verification` STRING COMMENT 'Data source or method by which the indicator will be measured and verified. Examples include surveys, administrative records, Post-Distribution Monitoring (PDM), or District Health Information System 2 (DHIS2) reports.',
    `mel_logframe_status` STRING COMMENT 'Current status of this LogFrame element in its lifecycle. Tracks whether targets are being met and whether the intervention logic remains valid. [ENUM-REF-CANDIDATE: Draft|Active|On Track|At Risk|Behind Schedule|Achieved|Closed|Cancelled — 8 candidates stripped; promote to reference product]',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or evaluation of this LogFrame element. Drives Monitoring Evaluation and Learning (MEL) planning and resource allocation.',
    `notes` STRING COMMENT 'Free-text field for additional context, lessons learned, or adaptive management decisions related to this LogFrame element.',
    `objectively_verifiable_indicator` STRING COMMENT 'The measurable indicator that will be used to verify achievement of this results chain level. Links to the indicator library for tracking.',
    `reporting_frequency` STRING COMMENT 'Frequency at which this indicator must be measured and reported to donors. Drives Monitoring Evaluation and Learning (MEL) data collection schedules.. Valid values are `Monthly|Quarterly|Semi-Annual|Annual|Ad-Hoc|Milestone-Based`',
    `results_chain_level` STRING COMMENT 'Hierarchical level within the results chain that this LogFrame row represents. Defines whether this is a goal, outcome, output, or activity level entry. [ENUM-REF-CANDIDATE: Goal|Impact|Purpose|Outcome|Output|Activity|Input — 7 candidates stripped; promote to reference product]',
    `risks` STRING COMMENT 'Identified risks or threats that could prevent achievement of this results chain level. Used for risk mitigation planning and adaptive management.',
    `sdg_alignment` STRING COMMENT 'Sustainable Development Goal (SDG) and target that this LogFrame element contributes to. Enables SDG reporting and impact mapping.',
    `target_date` DATE COMMENT 'Date by which the target value is expected to be achieved. Aligns with program end date or milestone dates.',
    `target_value` DECIMAL(18,2) COMMENT 'Planned or target value for the indicator at the end of the program period. Used for performance tracking and variance analysis.',
    `theory_of_change_component` STRING COMMENT 'Identifies which component of the Theory of Change (ToC) this LogFrame row represents. Links the LogFrame to the broader causal pathway and intervention logic.',
    `unit_of_measure` STRING COMMENT 'Unit in which the indicator is measured. Examples include count, percentage, ratio, households, beneficiaries, or Mid-Upper Arm Circumference (MUAC) measurements.',
    `version` STRING COMMENT 'Version identifier for the logical framework. LogFrames are often revised during program amendments or mid-term reviews.',
    CONSTRAINT pk_logframe PRIMARY KEY(`logframe_id`)
) COMMENT 'Logical Framework (LogFrame) master records defining the results chain hierarchy for each program or grant. Each logframe captures the full intervention logic: goal (impact), purpose (outcome), outputs, activities, assumptions, risks, and objectively verifiable indicators (OVIs) at each level. Includes Theory of Change (ToC) components as embedded rows within the hierarchy. Aligns with DAC evaluation criteria, RBM standards, and donor-specific logframe templates (DFID/FCDO, USAID, EU, ECHO). Links to indicator targets for performance tracking and supports results framework reporting.';

CREATE OR REPLACE TABLE `ngo_ecm`.`mel`.`indicator_target` (
    `indicator_target_id` BIGINT COMMENT 'Unique identifier for the indicator target record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Targets set in partnership agreements as performance benchmarks. Business need: agreement milestone tracking, performance-based disbursement triggers, compliance verification.',
    `award_id` BIGINT COMMENT 'Reference to the grant or award funding this indicator target.',
    `distribution_plan_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_plan. Business justification: NGO indicator targets for distribution-related indicators (e.g., target beneficiaries to receive NFIs) are set against specific distribution plans. This link supports target-setting against distribut',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Specific indicator targets are often set to satisfy explicit donor compliance requirements (e.g., contractual deliverables, earmark requirements, congressional directives). This link enables tracking ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Indicator targets are time-bound to fiscal periods for integrated financial and programmatic donor reporting. Finance teams reconcile indicator targets against fiscal period closings; this link is req',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: Indicator targets must be reconciled against grant budgets during budget realignment and donor reporting. NGO MEL officers cross-reference programmatic targets with funded grant budgets to ensure targ',
    `indicator_id` BIGINT COMMENT 'Reference to the indicator definition in the MEL indicator library for which this target is set.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project under which this indicator target is tracked.',
    `logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: The indicator_target product description explicitly states it defines Planned targets for each indicator within a specific logframe. Every target belongs to a specific LogFrame results chain. Withou',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit, team, or country office responsible for achieving this target.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Targets are set at partner level in sub-award agreements as performance benchmarks. Business need: partner-specific target setting, milestone tracking, performance-based disbursement triggers.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or MEL officer accountable for tracking and reporting on this target.',
    `reporting_period_id` BIGINT COMMENT 'Reference to the specific reporting period (quarterly, annual, etc.) for which this target applies.',
    `role_id` BIGINT COMMENT 'Foreign key linking to volunteer.role. Business justification: Indicator targets in community health and development programs assign specific volunteer roles as accountable for achieving them. indicator_target has primary_indicator_staff_member_id for staff accou',
    `target_population_id` BIGINT COMMENT 'Foreign key linking to program.target_population. Business justification: NGO indicator targets are set per population group (e.g., 500 female refugees, 300 male IDPs). indicator_target has disaggregation fields but no FK to target_population, preventing population-specific',
    `approval_date` DATE COMMENT 'The date when this indicator target was formally approved by the responsible authority or donor.',
    `assumptions` STRING COMMENT 'Key assumptions underlying the achievement of this target, including external factors and preconditions.',
    `baseline_date` DATE COMMENT 'The date when the baseline value was measured or established.',
    `baseline_value` DECIMAL(18,2) COMMENT 'The baseline measurement value at the start of the program or reporting period, used as the starting point for target setting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this indicator target record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'The OECD DAC sector classification code for this target, used for international aid transparency and reporting.',
    `data_collection_method` STRING COMMENT 'The primary method used to collect data for this target (e.g., household survey, FGD, KII, PDM, administrative records, DHIS2 aggregate).',
    `disaggregation_age_group` STRING COMMENT 'Age group category for this target (e.g., 0-5, 6-17, 18-59, 60+). Supports age-sensitive programming and reporting.',
    `disaggregation_disability_status` STRING COMMENT 'Disability status disaggregation for this target, supporting inclusive programming and Washington Group standards.. Valid values are `with_disability|without_disability|not_specified`',
    `disaggregation_displacement_status` STRING COMMENT 'Displacement or migration status disaggregation (e.g., IDP, refugee, returnee, host community, Person of Concern).',
    `disaggregation_sex` STRING COMMENT 'Sex-based disaggregation category for this target (male, female, other, not specified). Used for gender-sensitive monitoring.. Valid values are `male|female|other|not_specified`',
    `donor_reporting_requirement` STRING COMMENT 'Specific donor reporting requirement or framework that this target must satisfy (e.g., USAID F indicator, DFID logframe output 2.1).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this indicator target record was last updated or modified.',
    `measurement_frequency` STRING COMMENT 'How often this indicator target is measured and reported (daily, weekly, monthly, quarterly, semi-annually, annually, one-time, continuous). [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|semi_annually|annually|one_time|continuous — 8 candidates stripped; promote to reference product]',
    `mitigation_strategy` STRING COMMENT 'Planned strategies or actions to mitigate identified risks and ensure target achievement.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about this indicator target.',
    `revision_date` DATE COMMENT 'The date when the target was last revised or amended.',
    `revision_reason` STRING COMMENT 'Explanation for any revision to the original target value or date, including contextual changes or donor amendments.',
    `risks` STRING COMMENT 'Identified risks that may prevent the achievement of this target, including contextual, operational, and external risks.',
    `sdg_alignment` STRING COMMENT 'The SDG goal and target number(s) that this indicator target contributes to (e.g., SDG 1.1, SDG 3.2).',
    `target_code` STRING COMMENT 'Business identifier or code for this indicator target, often used in donor reports and LogFrame documentation.',
    `target_date` DATE COMMENT 'The date by which the target value is expected to be achieved.',
    `target_description` STRING COMMENT 'Detailed narrative description of what this target represents, including context and rationale.',
    `target_name` STRING COMMENT 'Human-readable name or label for this indicator target.',
    `target_status` STRING COMMENT 'Current lifecycle status of the indicator target: draft (being defined), approved (validated by stakeholders), active (currently being tracked), on_track (progressing as planned), at_risk (may not be achieved), off_track (unlikely to be achieved), achieved (target met), not_achieved (target not met), revised (target has been modified), cancelled (target no longer applicable). [ENUM-REF-CANDIDATE: draft|approved|active|on_track|at_risk|off_track|achieved|not_achieved|revised|cancelled — 10 candidates stripped; promote to reference product]',
    `target_type` STRING COMMENT 'Classification of the target based on the results chain level: output (direct deliverables), outcome (intermediate results), impact (long-term change), process (operational efficiency), or input (resources).. Valid values are `output|outcome|impact|process|input`',
    `target_value` DECIMAL(18,2) COMMENT 'The planned or target value to be achieved for this indicator within the specified period and geographic scope.',
    `unit_of_measure` STRING COMMENT 'The unit in which the target and baseline values are measured (e.g., number of beneficiaries, percentage, households, liters).',
    `verification_source` STRING COMMENT 'The source or means of verification for this target (e.g., program records, beneficiary surveys, third-party evaluation, DHIS2 reports).',
    CONSTRAINT pk_indicator_target PRIMARY KEY(`indicator_target_id`)
) COMMENT 'Planned targets for each indicator within a specific logframe, grant reporting period, and geographic scope. Stores baseline, target value, target date, disaggregation breakdowns (sex, age, location), and the responsible program unit. Supports BvA-style target vs. actual tracking and donor performance reporting.';

CREATE OR REPLACE TABLE `ngo_ecm`.`mel`.`indicator_result` (
    `indicator_result_id` BIGINT COMMENT 'Unique identifier for the indicator result record. Primary key for the indicator result entity.',
    `award_id` BIGINT COMMENT 'Reference to the grant award funding this indicator. Enables donor-specific performance reporting and compliance.',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Activity-level cost-per-result analysis requires linking results to specific budget lines. NGO finance and MEL teams track which budget line funded each result for activity-based costing, donor budget',
    `capacity_building_plan_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_building_plan. Business justification: Indicator results measure progress against capacity building plan targets. NGOs report CBP indicator results to donors and in partner performance reviews to demonstrate whether capacity improvements a',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Data quality assessments and MEAL audits require traceability to the staff member who collected indicator data. Currently tracked as collection_team text; FK enables accountability audits and capacity',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: Distribution-focused indicators (e.g., hygiene kits distributed) require linking results to specific commodities to verify what was actually distributed. Standard MEL practice in humanitarian progra',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Results are collected at cost center level (field offices, program units). Cost center managers review indicator results alongside expenditure to assess program cost-effectiveness. Financial reports a',
    `distribution_order_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_order. Business justification: NGO indicator results (e.g., beneficiaries reached, rations distributed) are directly generated by specific distribution orders. This link supports the results attribution to distribution process re',
    `donor_report_id` BIGINT COMMENT 'Reference to the specific donor report in which this indicator result was included. Enables traceability from report to source data.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Indicator results must be matched to fiscal periods for cost-per-result analysis and donor financial reporting. NGO finance and MEL teams jointly produce period-specific results-vs-expenditure reports',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: Linking results to grant budgets enables cost-per-result analysis and budget performance reporting — a core NGO donor accountability requirement. Finance teams need to attribute actual results to spec',
    `indicator_id` BIGINT COMMENT 'Reference to the indicator definition from the indicator library. Links this result to the specific KPI or outcome measure being tracked.',
    `indicator_target_id` BIGINT COMMENT 'Foreign key linking to mel.indicator_target. Business justification: Indicator results measure actual achievement against specific planned targets. Each indicator_result should reference the indicator_target it is measuring against. This creates proper traceability fro',
    `intervention_id` BIGINT COMMENT 'Reference to the program under which this indicator result was achieved. Enables program-level performance aggregation.',
    `needs_assessment_id` BIGINT COMMENT 'Foreign key linking to beneficiary.beneficiary_needs_assessment. Business justification: Evidence traceability for indicator results: MEL teams must trace reported indicator values (nutrition scores, protection scores, WASH access) back to the specific needs assessments that generated the',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: NGO results reporting requires org unit attribution for aggregation across country offices and departments. Donor performance reports, organizational scorecards, and results frameworks require org uni',
    `partner_org_id` BIGINT COMMENT 'Reference to the implementing partner organization that collected or contributed this indicator result. Used for partner performance tracking.',
    `partner_performance_review_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_performance_review. Business justification: Indicator results are core evidence for partner performance assessment. Business need: performance rating calculation, milestone achievement verification, target vs actual analysis.',
    `partner_report_submission_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_report_submission. Business justification: Partner reports contain indicator results as core content. Business need: report completeness verification, results validation, donor reporting compilation.',
    `project_site_id` BIGINT COMMENT 'Reference to the geographic project site where this result was achieved. Enables location-based performance analysis.',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: indicator_result currently stores reporting_period_start_date and reporting_period_end_date as raw date columns, but has no FK to the reporting_period master table. The product description states resu',
    `volunteer_deployment_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_deployment. Business justification: Indicator results collected by volunteers must be traceable to the specific deployment for data quality audits and performance attribution. indicator_result has collected_by_staff_member_id for staff ',
    `baseline_value` DECIMAL(18,2) COMMENT 'Baseline measurement recorded at program start. Enables calculation of change over time and impact assessment.',
    `beneficiary_count` STRING COMMENT 'Number of unique beneficiaries reached or served in achieving this indicator result. Critical for reach and coverage analysis.',
    `collection_date` DATE COMMENT 'Date when the indicator data was physically collected in the field or extracted from source systems. Distinct from reporting period dates.',
    `contributing_factors` STRING COMMENT 'Description of key factors that contributed to achievement or non-achievement of the indicator target. Supports learning and adaptive management.',
    `corrective_actions` STRING COMMENT 'Documented corrective actions planned or taken in response to under-performance. Part of adaptive management and continuous improvement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this indicator result record was first created in the system. Part of audit trail.',
    `cumulative_result` DECIMAL(18,2) COMMENT 'Cumulative total of indicator results from program start through current reporting period. Used for life-of-project performance tracking.',
    `data_collection_method` STRING COMMENT 'Method used to collect the indicator data. Includes surveys, Focus Group Discussions (FGD), Key Informant Interviews (KII), Post-Distribution Monitoring (PDM), and administrative records. [ENUM-REF-CANDIDATE: survey|fgd|kii|observation|administrative_records|pdm|mobile_data_collection|remote_sensing — 8 candidates stripped; promote to reference product]',
    `data_quality_notes` STRING COMMENT 'Free-text notes documenting data quality issues, limitations, or contextual factors affecting the reliability of this indicator result.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Composite data quality score (0.00 to 1.00) assessing completeness, accuracy, timeliness, and consistency of the indicator result per MEAL standards.',
    `data_source` STRING COMMENT 'Specific source system or document from which the indicator data was extracted. Examples include DHIS2, KoboToolbox, beneficiary registration system, or partner reports.',
    `disaggregation_age_group` STRING COMMENT 'Age group disaggregation of the indicator result. Enables age-sensitive analysis and compliance with Sustainable Development Goal (SDG) reporting.. Valid values are `0-5|6-17|18-59|60+|not_applicable`',
    `disaggregation_disability` STRING COMMENT 'Disability status disaggregation per Washington Group Short Set. Required for inclusive programming and disability-focused donor reporting.. Valid values are `with_disability|without_disability|unknown|not_applicable`',
    `disaggregation_displacement_status` STRING COMMENT 'Displacement status disaggregation. Distinguishes Internally Displaced Persons (IDP), refugees, returnees, and host community members per UNHCR standards.. Valid values are `idp|refugee|returnee|host_community|not_applicable`',
    `disaggregation_sex` STRING COMMENT 'Sex disaggregation of the indicator result. Required by most donors for gender-sensitive programming and reporting.. Valid values are `male|female|other|unknown|not_applicable`',
    `evidence_file_path` STRING COMMENT 'File path or document reference to supporting evidence for this indicator result. Includes photos, survey data files, or verification reports.',
    `geographic_level` STRING COMMENT 'Administrative level at which this indicator result was measured. Enables hierarchical geographic aggregation and sub-national analysis.. Valid values are `national|regional|district|community|facility`',
    `household_count` STRING COMMENT 'Number of unique households reached in achieving this indicator result. Used when household is the unit of analysis.',
    `indicator_level` STRING COMMENT 'Level of the indicator in the results chain per Theory of Change (ToC). Distinguishes between immediate outputs, medium-term outcomes, and long-term impact.. Valid values are `output|outcome|impact|process`',
    `is_milestone` BOOLEAN COMMENT 'Indicates whether this indicator result represents a contractual milestone or critical deliverable per grant agreement terms.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified this indicator result record. Supports accountability and audit trail.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this indicator result record was last updated. Tracks data currency and change history.',
    `narrative_description` STRING COMMENT 'Qualitative narrative describing the context, achievements, challenges, and lessons learned related to this indicator result. Used in donor reports.',
    `reported_to_donor` BOOLEAN COMMENT 'Indicates whether this indicator result has been included in formal donor reporting. Tracks reporting compliance and audit trail.',
    `result_status` STRING COMMENT 'Current workflow status of the indicator result record. Tracks approval and review lifecycle.. Valid values are `draft|submitted|approved|rejected|archived`',
    `result_value` DECIMAL(18,2) COMMENT 'Actual achieved value recorded for the indicator during the reporting period. The primary quantitative outcome measurement.',
    `target_value` DECIMAL(18,2) COMMENT 'Planned target value for the indicator during this reporting period. Used for variance analysis and performance assessment.',
    `unit_of_measure` STRING COMMENT 'Unit in which the indicator result is measured. Critical for correct interpretation and aggregation of performance data. [ENUM-REF-CANDIDATE: number|percentage|ratio|count|households|individuals|facilities|days|hours|liters|kilograms|metric_tons — 12 candidates stripped; promote to reference product]',
    `variance_from_target` DECIMAL(18,2) COMMENT 'Calculated difference between actual result and target value. Positive values indicate over-achievement, negative values indicate under-achievement.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance from target, calculated as (actual - target) / target * 100. Key metric for donor performance reporting.',
    `verification_date` DATE COMMENT 'Date when the indicator result was verified by MEL staff or external evaluators. Critical for audit trail and data quality documentation.',
    `verification_status` STRING COMMENT 'Current verification state of the indicator result. Tracks data quality assurance workflow per Core Humanitarian Standard (CHS) requirements.. Valid values are `unverified|verified|rejected|pending_review`',
    `verified_by` STRING COMMENT 'Name or identifier of the MEL officer or evaluator who verified this indicator result. Supports accountability and quality assurance.',
    CONSTRAINT pk_indicator_result PRIMARY KEY(`indicator_result_id`)
) COMMENT 'Actual achieved values recorded against indicator targets for a given reporting period, program, and geographic unit. Captures reported value, disaggregation breakdowns (sex, age, disability, location), data source, collection method, verification status, variance from target, and outcome-level change measurements (KAB changes, condition improvements). Covers all indicator levels from output through outcome and impact. Core transactional record for MEL performance tracking, donor reporting, and ToC validation.';

CREATE OR REPLACE TABLE `ngo_ecm`.`mel`.`meal_plan` (
    `meal_plan_id` BIGINT COMMENT 'Unique identifier for the MEAL plan document. Primary key for the MEAL plan entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: MEAL plans are agreement-specific deliverables and annexes. Business need: agreement compliance tracking, donor reporting obligation fulfillment, partnership performance framework definition.',
    `award_id` BIGINT COMMENT 'Reference to the grant or award that funds this MEAL plan. Links the MEAL plan to the funding source and donor reporting requirements.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: MEL plans define data collection, monitoring, and evaluation activities requiring budget allocation (surveys, tools, staff time, external evaluators). Annual budgeting process allocates funds for MEL ',
    `budget_plan_id` BIGINT COMMENT 'Foreign key linking to program.budget_plan. Business justification: MEL budget reconciliation requires linking meal_plan.budget_allocated to source program.budget_plan for variance analysis, donor reporting, and financial compliance. Real business process: quarterly M',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: MEAL plans document how the organization will meet specific donor MEL reporting obligations (e.g., USAID Performance Management Plan requirements, ECHO visibility obligations, DFID results measurement',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: MEAL plans are structured to satisfy specific donor requirements for monitoring methodology and reporting frequency. meal_plan already has compliance_obligation_id but lacks a direct link to the speci',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: MEAL plans are costed against grant budgets; the MEAL budget allocation must tie to the specific grant budget for donor-specific MEAL cost tracking and compliance. meal_plan.budget_id links to the gen',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that this MEAL plan governs. Links the MEAL plan to the operational program it monitors.',
    `logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: MEAL plans implement specific logframes. Currently meal_plan has logframe_reference (STRING) which should be replaced with a proper FK to mel_logframe. This establishes the authoritative link between ',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: NGO MEAL plans are scoped to specific org units for resource allocation, budget planning, and reporting. MEAL capacity assessments and donor reporting require org unit scoping. No existing org_unit FK',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: MEAL plans are designed to monitor specific partner-implemented programs. NGOs track which implementing partner org a MEAL plan covers for partner oversight, donor reporting, and partner performance m',
    `staff_member_id` BIGINT COMMENT 'Reference to the MEL staff member who is the lead or primary responsible party for implementing this MEAL plan.',
    `accountability_mechanisms` STRING COMMENT 'Description of accountability mechanisms embedded in the MEAL plan, including beneficiary feedback channels, complaint response mechanisms, and Core Humanitarian Standard (CHS) commitments.',
    `approval_date` DATE COMMENT 'Date when the MEAL plan was formally approved by program management and/or the donor. Marks the transition from draft to active status.',
    `baseline_completion_date` DATE COMMENT 'Date when the baseline assessment was completed. Baseline data provides the starting point for measuring program outcomes and impact.',
    `beneficiary_feedback_channels` STRING COMMENT 'Description of channels through which beneficiaries can provide feedback, complaints, and suggestions, including hotlines, suggestion boxes, community meetings, and digital platforms.',
    `budget_allocated` DECIMAL(18,2) COMMENT 'Total budget allocated for implementing this MEAL plan, including costs for data collection, evaluation, staff time, tools, and analysis.',
    `chs_commitment_alignment` STRING COMMENT 'Description of how this MEAL plan aligns with and monitors the nine Core Humanitarian Standard commitments to communities and people affected by crisis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this MEAL plan record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget allocated amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dac_criteria_coverage` STRING COMMENT 'Description of which DAC evaluation criteria (relevance, coherence, effectiveness, efficiency, impact, sustainability) are addressed in this MEAL plan and how they will be assessed.',
    `data_collection_methods` STRING COMMENT 'Enumeration and description of data collection methods to be used, including surveys, Key Informant Interviews (KII), Focus Group Discussions (FGD), Post-Distribution Monitoring (PDM), and direct observation.',
    `data_collection_tools` STRING COMMENT 'List of digital and paper-based tools and platforms to be used for data collection, such as KoboToolbox, CommCare, ODK, DHIS2, mobile data collection apps, and paper forms.',
    `data_disaggregation_plan` STRING COMMENT 'Description of how data will be disaggregated for analysis, including by age, gender, disability status, geographic location, and other relevant demographic and vulnerability factors.',
    `data_management_protocols` STRING COMMENT 'Description of data management protocols, including data storage, security, privacy, access controls, backup procedures, and compliance with data protection regulations.',
    `data_quality_protocols` STRING COMMENT 'Description of data quality assurance and quality control protocols, including validation rules, data cleaning procedures, inter-rater reliability checks, and data verification processes.',
    `donor_reporting_requirements` STRING COMMENT 'Description of specific donor reporting requirements that this MEAL plan must satisfy, including report formats, indicators, frequency, and submission deadlines.',
    `effective_end_date` DATE COMMENT 'Date when this MEAL plan ends and monitoring activities conclude. Typically aligns with program end date or grant closeout date.',
    `effective_start_date` DATE COMMENT 'Date when this MEAL plan becomes effective and monitoring activities begin. Typically aligns with program start date or grant award date.',
    `endline_planned_date` DATE COMMENT 'Planned date for the endline evaluation. Endline evaluations measure final outcomes and impact at the conclusion of the program cycle.',
    `ethical_considerations` STRING COMMENT 'Description of ethical considerations and safeguards in data collection and evaluation, including informed consent procedures, do-no-harm principles, and protection of vulnerable populations.',
    `evaluation_strategy` STRING COMMENT 'Description of the evaluation strategy, including planned evaluations (baseline, midline, endline), evaluation questions, methodologies, and timing aligned with DAC criteria.',
    `indicator_count` STRING COMMENT 'Total number of Key Performance Indicators (KPI) and monitoring indicators defined in the indicator matrix for this MEAL plan.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this MEAL plan record was last modified in the system. Used for audit trail and change tracking.',
    `learning_agenda` STRING COMMENT 'Description of the learning agenda, including key learning questions, knowledge management activities, and how learning will be captured and disseminated to inform adaptive management.',
    `midline_planned_date` DATE COMMENT 'Planned date for the midline evaluation. Midline evaluations assess progress toward outcomes at the midpoint of the program cycle.',
    `monitoring_strategy` STRING COMMENT 'Comprehensive description of the monitoring strategy, including frequency, methods, data sources, and responsible parties for ongoing program monitoring.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the MEAL plan. Indicates whether the plan is in development, approved for use, actively being implemented, or closed. [ENUM-REF-CANDIDATE: draft|under_review|approved|active|suspended|closed|archived — 7 candidates stripped; promote to reference product]',
    `plan_title` STRING COMMENT 'The official title or name of the MEAL plan document. Used for identification and reference in donor reports and internal documentation.',
    `plan_version` STRING COMMENT 'Version number or identifier for this iteration of the MEAL plan. Tracks revisions and updates to the plan over the program lifecycle.',
    `rbm_framework_alignment` STRING COMMENT 'Description of how this MEAL plan aligns with the organizations Results-Based Management framework and donor RBM requirements.',
    `reporting_calendar` STRING COMMENT 'Description of the reporting calendar, including frequency and timing of internal reports, donor reports, Situation Reports (SitRep), and other MEL deliverables.',
    `revision_history` STRING COMMENT 'Summary of major revisions and amendments to the MEAL plan over its lifecycle, including dates and reasons for changes.',
    `risk_mitigation_plan` STRING COMMENT 'Description of risks to MEL implementation (e.g., access constraints, security incidents, data quality issues) and mitigation strategies.',
    `sdg_alignment` STRING COMMENT 'Description of which Sustainable Development Goals and targets this MEAL plan monitors and how program indicators align with SDG indicators.',
    `toc_narrative` STRING COMMENT 'Narrative description of the Theory of Change that underpins this MEAL plan. Explains the causal pathway from inputs to impact and the assumptions being tested.',
    CONSTRAINT pk_meal_plan PRIMARY KEY(`meal_plan_id`)
) COMMENT 'MEAL (Monitoring, Evaluation, Accountability, and Learning) plan document for a program or grant cycle. Defines the overall monitoring strategy, indicator matrix, data collection schedule and methods, responsible MEL staff, tools to be used (KoboToolbox, CommCare, ODK, DHIS2), learning agenda linkage, accountability mechanisms (CHS commitments, feedback channels), reporting calendar, and data management protocols. Serves as the governing MEL framework document that all other MEL products operationalize.';

CREATE OR REPLACE TABLE `ngo_ecm`.`mel`.`evaluation` (
    `evaluation_id` BIGINT COMMENT 'Unique identifier for the evaluation record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Evaluations triggered by agreement milestones or donor requirements. Business need: agreement performance assessment, renewal decision support, donor reporting compliance.',
    `award_id` BIGINT COMMENT 'Reference to the grant funding this evaluation, if applicable.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Evaluations are budgeted activities with dedicated allocations. Finance tracks evaluation costs (consultants, travel, data collection) against approved evaluation budget. Procurement requisitions for ',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: NGO evaluations frequently assess partner capacity and reference the formal capacity assessment record as baseline evidence. Evaluators use capacity assessment scores to measure improvement. This is a',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Evaluation management requires tracking internal staff who commissioned and oversee evaluations (distinct from external lead_evaluator_name). Essential for budget accountability, management response t',
    `consortium_id` BIGINT COMMENT 'Foreign key linking to partnership.consortium. Business justification: Consortium-level evaluations are standard NGO practice — evaluating the collective performance of a consortium. NGOs commission evaluations scoped to a specific consortium. No existing FK links evalua',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Evaluations are conducted by or for specific cost centers (country offices, program units). Cost center budget holders approve evaluation scope and funding. Evaluation costs are allocated to the cost ',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Evaluations are frequently mandated by specific donor requirements (e.g., USAID requires mid-term and final evaluations as grant conditions). Linking evaluation to the donor_requirement that commissio',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Evaluations must be anchored to fiscal periods for expenditure tracking and audit trail purposes. NGO finance teams need to record evaluation costs within specific fiscal periods; this FK enables peri',
    `governance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.governance_policy. Business justification: Evaluations must adhere to organizational ethics and data governance policies. The evaluation has `ethics_approval_obtained` field indicating policy compliance relevance. Linking to the specific gover',
    `grant_budget_id` BIGINT COMMENT 'Foreign key linking to finance.grant_budget. Business justification: Evaluations are commissioned against specific grant budgets; evaluation costs and findings must tie to the grant budget for donor financial reporting and single audit compliance. evaluation.budget_id ',
    `intervention_id` BIGINT COMMENT 'Reference to the program being evaluated.',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Community-led and peer evaluations in NGOs are conducted by volunteer evaluators. evaluation.lead_evaluator_name is plain text denormalization. Linking to volunteer.volunteer_id enables evaluation qua',
    `logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Evaluations assess program performance against the logframes results chain. This FK links the evaluation to the specific logframe being assessed, enabling analysis of achievement against planned resu',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: Evaluations (baseline, midterm, endline) are planned and executed as part of MEAL plans. This FK links the evaluation to the MEAL plan under which it was conducted, enabling tracking of MEAL plan eval',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: NGO evaluations are commissioned by and reported to specific org units. Evaluation management, management response tracking, and learning dissemination require org unit attribution. No existing org_un',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Evaluations routinely assess partner performance, capacity, and implementation quality. Business need: partner performance evaluation, due diligence validation, partnership renewal decisions, capacity',
    `partner_report_submission_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_report_submission. Business justification: Evaluation reports are a type of partner report submission. Business need: evaluation deliverable tracking, donor reporting, agreement compliance verification.',
    `single_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.single_audit. Business justification: Single audits (OMB Uniform Guidance requirement for US federal awards >$750K) often trigger or reference program evaluations as part of compliance testing. Evaluations provide evidence for audit asser',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for conducting the evaluation.',
    `actual_end_date` DATE COMMENT 'Actual date when the evaluation was completed and final report delivered.',
    `actual_start_date` DATE COMMENT 'Actual date when the evaluation fieldwork or data collection commenced.',
    `beneficiary_sample_size` STRING COMMENT 'Number of beneficiaries or respondents included in the evaluation sample for primary data collection.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total budget allocated for conducting the evaluation, including consultant fees, travel, data collection, and report production costs.',
    `coherence_rating` STRING COMMENT 'Rating of the programs coherence (compatibility with other interventions, internal consistency) per DAC criteria (2019 revision).. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the evaluation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for budget and cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dac_criteria_assessed` STRING COMMENT 'Comma-separated list of DAC evaluation criteria assessed: relevance, coherence, effectiveness, efficiency, impact, sustainability. May include all or a subset depending on evaluation design.',
    `data_collection_methods` STRING COMMENT 'Comma-separated list of data collection methods used: household surveys, FGD (Focus Group Discussion), KII (Key Informant Interview), PDM (Post-Distribution Monitoring), direct observation, secondary data review, etc.',
    `dissemination_date` DATE COMMENT 'Date when the evaluation findings were formally disseminated to stakeholders, donors, and internal teams.',
    `effectiveness_rating` STRING COMMENT 'Rating of the programs effectiveness (extent to which objectives were achieved) per DAC criteria.. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `efficiency_rating` STRING COMMENT 'Rating of the programs efficiency (value for money, resource utilization) per DAC criteria.. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `ethics_approval_obtained` BOOLEAN COMMENT 'Indicates whether ethics approval or institutional review board clearance was obtained for the evaluation, particularly for studies involving vulnerable populations (true/false).',
    `evaluation_code` STRING COMMENT 'Externally-known unique code or reference number for the evaluation, used in donor reports and internal tracking.. Valid values are `^[A-Z0-9]{6,20}$`',
    `evaluation_scope` STRING COMMENT 'Detailed description of the evaluation scope, including geographic coverage, beneficiary segments, program components, and time period covered.',
    `evaluation_status` STRING COMMENT 'Current lifecycle status of the evaluation: planned (scheduled but not started), inception (terms of reference development), fieldwork (data collection in progress), analysis (data analysis phase), draft_report (draft under review), final_report (completed), disseminated (findings shared with stakeholders), or cancelled. [ENUM-REF-CANDIDATE: planned|inception|fieldwork|analysis|draft_report|final_report|disseminated|cancelled — 8 candidates stripped; promote to reference product]',
    `evaluation_type` STRING COMMENT 'Type of evaluation conducted: baseline (pre-intervention), midterm (mid-cycle), endline (post-intervention), impact (long-term outcomes), formative (process improvement), summative (final judgment), or real-time (during crisis). [ENUM-REF-CANDIDATE: baseline|midterm|endline|impact|formative|summative|real-time — 7 candidates stripped; promote to reference product]',
    `evaluator_type` STRING COMMENT 'Type of evaluator conducting the assessment: internal (staff-led), external (independent consultant or firm), joint (internal and external collaboration), or participatory (beneficiary-led).. Valid values are `internal|external|joint|participatory`',
    `findings_summary` STRING COMMENT 'Executive summary of key evaluation findings, including strengths, weaknesses, and evidence against DAC criteria.',
    `geographic_coverage` STRING COMMENT 'Geographic areas covered by the evaluation, including countries, regions, districts, or project sites. Comma-separated list or descriptive text.',
    `impact_rating` STRING COMMENT 'Rating of the programs impact (long-term changes and contribution to higher-level goals) per DAC criteria.. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `lead_evaluator_name` STRING COMMENT 'Name of the lead evaluator or evaluation firm responsible for conducting the evaluation.',
    `lessons_learned` STRING COMMENT 'Key lessons learned from the evaluation that can inform future program design, implementation, and organizational learning.',
    `management_response_date` DATE COMMENT 'Date when the management response to evaluation recommendations was formally completed and approved.',
    `management_response_status` STRING COMMENT 'Status of the management response to evaluation recommendations: pending (not yet started), in_progress (being drafted), completed (response finalized and action plan developed), or not_required.. Valid values are `pending|in_progress|completed|not_required`',
    `methodology` STRING COMMENT 'Description of the evaluation methodology, including data collection methods (surveys, FGD, KII, PDM, secondary data review), sampling approach, analytical techniques, and any limitations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the evaluation record was last modified.',
    `overall_rating` STRING COMMENT 'Overall performance rating assigned by the evaluation, typically on a six-point scale aligned with donor standards (e.g., USAID, DFID).. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `planned_end_date` DATE COMMENT 'Planned date when the evaluation is scheduled to be completed and final report delivered.',
    `planned_start_date` DATE COMMENT 'Planned date when the evaluation fieldwork or data collection is scheduled to begin.',
    `purpose` STRING COMMENT 'Primary purpose of the evaluation: accountability (donor reporting), learning (organizational improvement), decision_making (strategic planning), or compliance (regulatory requirement).. Valid values are `accountability|learning|decision_making|compliance`',
    `quality_assurance_conducted` BOOLEAN COMMENT 'Indicates whether independent quality assurance review of the evaluation was conducted (true/false).',
    `recommendations_summary` STRING COMMENT 'Summary of actionable recommendations arising from the evaluation, including strategic, operational, and programmatic improvements.',
    `relevance_rating` STRING COMMENT 'Rating of the programs relevance (alignment with beneficiary needs, country priorities, and organizational strategy) per DAC criteria.. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `report_url` STRING COMMENT 'URL or file path to the final evaluation report document, stored in document management system or public repository.',
    `sustainability_rating` STRING COMMENT 'Rating of the programs sustainability (likelihood that benefits will continue after program closure) per DAC criteria.. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `team_size` STRING COMMENT 'Number of evaluators or team members involved in conducting the evaluation.',
    `title` STRING COMMENT 'Full descriptive title of the evaluation.',
    CONSTRAINT pk_evaluation PRIMARY KEY(`evaluation_id`)
) COMMENT 'Formal evaluation records including baseline, midterm, endline, and impact evaluations. Captures evaluation type (formative, summative, real-time), DAC criteria assessed (relevance, coherence, effectiveness, efficiency, impact, sustainability), methodology, evaluator (internal/external), scope, findings summary, and recommendations. Supports organizational learning and donor accountability.';

CREATE OR REPLACE TABLE `ngo_ecm`.`mel`.`evaluation_finding` (
    `evaluation_finding_id` BIGINT COMMENT 'Unique identifier for the evaluation finding record. Primary key.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Management response tracking and corrective action monitoring require linking findings to accountable staff member. Currently text field responsible_person_name; FK enables performance tracking, workl',
    `award_id` BIGINT COMMENT 'Reference to the grant or award that this finding pertains to, if applicable.',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: Evaluation findings directly reference capacity assessment results — e.g., a finding that partner financial management is weak cites the formal capacity assessment score. NGOs use this link in managem',
    `capacity_building_plan_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_building_plan. Business justification: Evaluation findings trigger capacity building activities. Business need: corrective action planning, capacity gap closure, finding remediation tracking.',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Evaluation findings in NGOs directly trigger corrective action plans — this is a core accountability mechanism in CHS and donor frameworks. Linking evaluation_finding to the CAP it generated enables m',
    `evaluation_id` BIGINT COMMENT 'Reference to the parent evaluation from which this finding was extracted.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project that this finding pertains to.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: NGO management response processes assign evaluation findings to responsible org units for action. The plain-text responsible_unit denormalizes org_unit data. Finding implementation tracking and acco',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Findings identify partner-specific issues requiring corrective action. Business need: partner accountability tracking, corrective action planning, performance review evidence, risk management escalati',
    `partner_performance_review_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_performance_review. Business justification: Evaluation findings inform performance review ratings and corrective actions. Business need: performance review evidence, improvement plan development, rating justification.',
    `risk_register_id` BIGINT COMMENT 'Foreign key linking to program.risk_register. Business justification: Evaluation findings in NGOs frequently identify risks that must be entered into the program risk register. evaluation_finding has risk_implication as a plain attribute (denormalization signal). Formal',
    `agreement_amendment_id` BIGINT COMMENT 'Foreign key linking to partnership.agreement_amendment. Business justification: Evaluation findings trigger agreement amendments (scope changes, budget reallocations, no-cost extensions). NGOs formally track which amendment was triggered by which evaluation finding as part of man',
    `action_plan` STRING COMMENT 'Detailed plan outlining the steps, resources, and timeline for implementing the recommendation.',
    `actual_completion_date` DATE COMMENT 'Actual date when the recommendation was fully implemented or the issue was resolved.',
    `beneficiary_category` STRING COMMENT 'Category or segment of beneficiaries affected by or relevant to this finding (e.g., IDP, refugee, host community, women, children).',
    `closure_notes` STRING COMMENT 'Final notes or comments documenting the closure or resolution of this finding or recommendation.',
    `confidentiality_level` STRING COMMENT 'Data classification level for this finding: public, internal, confidential, or restricted.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this evaluation finding record was first created in the system.',
    `cross_cutting_theme` STRING COMMENT 'Cross-cutting themes addressed by this finding (e.g., gender equality, disability inclusion, environmental sustainability, accountability).',
    `dac_criterion` STRING COMMENT 'The DAC evaluation criterion this finding relates to: relevance, coherence, effectiveness, efficiency, impact, or sustainability.. Valid values are `relevance|coherence|effectiveness|efficiency|impact|sustainability`',
    `data_collection_method` STRING COMMENT 'Primary method(s) used to collect evidence for this finding (e.g., Focus Group Discussion, Key Informant Interview, survey, document review, observation).',
    `donor_visibility_flag` BOOLEAN COMMENT 'Indicates whether this finding should be included in donor-facing reports and communications (True/False).',
    `evaluator_name` STRING COMMENT 'Name of the lead evaluator or evaluation team member who documented this finding.',
    `evidence_base` STRING COMMENT 'Summary of the data sources and evidence that support this finding (e.g., FGD results, KII transcripts, PDM data, program records).',
    `finding_date` DATE COMMENT 'Date when the finding was formally documented or recorded in the evaluation report.',
    `finding_number` STRING COMMENT 'Sequential or hierarchical identifier for the finding within the evaluation report (e.g., F1, F2.1, Finding-03).',
    `finding_statement` STRING COMMENT 'The full text of the finding, conclusion, or recommendation as documented in the evaluation report.',
    `finding_type` STRING COMMENT 'Classification of the evaluation output: finding (observation), conclusion (interpretation), recommendation (action), lesson learned, or good practice.. Valid values are `finding|conclusion|recommendation|lesson_learned|good_practice`',
    `geographic_scope` STRING COMMENT 'Geographic area or location(s) to which this finding applies (country, region, field office, project site).',
    `implementation_progress_percentage` DECIMAL(18,2) COMMENT 'Percentage completion of the recommendation implementation (0.00 to 100.00).',
    `implementation_status` STRING COMMENT 'Current status of the recommendation or corrective action: not started, in progress, partially implemented, fully implemented, closed, or rejected.. Valid values are `not_started|in_progress|partially_implemented|fully_implemented|closed|rejected`',
    `last_review_date` DATE COMMENT 'Date when the implementation status of this finding was last reviewed or updated.',
    `management_response` STRING COMMENT 'Official response from management regarding acceptance, rejection, or modification of the recommendation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this evaluation finding record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or follow-up on this finding or recommendation.',
    `priority_level` STRING COMMENT 'Urgency and importance assigned to the finding or recommendation: critical, high, medium, or low.. Valid values are `critical|high|medium|low`',
    `rating` STRING COMMENT 'Qualitative rating assigned to the finding where applicable, using standard evaluation rating scales.. Valid values are `highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory`',
    `risk_implication` STRING COMMENT 'Description of risks or potential negative consequences if the finding or recommendation is not addressed.',
    `sdg_alignment` STRING COMMENT 'Sustainable Development Goal(s) that this finding relates to or impacts (e.g., SDG 1, SDG 3, SDG 5).',
    `sector` STRING COMMENT 'Humanitarian or development sector this finding relates to (e.g., WASH, health, education, protection, food security).',
    `target_completion_date` DATE COMMENT 'Planned or agreed date by which the recommendation should be implemented or the issue addressed.',
    CONSTRAINT pk_evaluation_finding PRIMARY KEY(`evaluation_finding_id`)
) COMMENT 'Individual findings, conclusions, and recommendations extracted from formal evaluations. Each record captures the finding statement, DAC criterion it relates to, evidence base, rating (if applicable), responsible unit for follow-up, and implementation status of the recommendation. Enables systematic learning and accountability tracking.';

CREATE OR REPLACE TABLE `ngo_ecm`.`mel`.`qualitative_record` (
    `qualitative_record_id` BIGINT COMMENT 'Primary key for qualitative_record',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Qualitative data collection (FGDs, KIIs) is scoped to specific partnership agreement implementation areas. NGOs track which partnership agreement a qualitative record belongs to for partner narrative ',
    `community_id` BIGINT COMMENT 'Foreign key linking to beneficiary.community. Business justification: Community-level qualitative data collection tracking: FGDs and KIIs are conducted within specific communities. qualitative_record.community_name is a denormalized plain-text field. Proper FK enables c',
    `data_collection_tool_id` BIGINT COMMENT 'Foreign key linking to mel.data_collection_tool. Business justification: Qualitative records (FGDs, KIIs) reference data_collection_tool as a STRING field containing the tool name/identifier. This should be normalized to a FK for proper tool tracking, version control, and ',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: Volunteers frequently conduct KIIs, FGDs, community consultations as trained data collectors. MEL quality assurance requires tracking collector identity for verification, bias assessment, and data qua',
    `distribution_order_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_order. Business justification: Post-Distribution Monitoring (PDM) is a named NGO business process where qualitative records (FGDs, KIIs, satisfaction surveys) are conducted referencing specific distribution orders. This link is ess',
    `evaluation_id` BIGINT COMMENT 'Foreign key linking to mel.evaluation. Business justification: Qualitative records (FGDs, KIIs, PDM sessions) are frequently conducted as part of formal evaluations (baseline, midterm, endline). The qualitative_record product captures the raw data collection even',
    `intervention_id` BIGINT COMMENT 'Identifier of the program under which this qualitative data collection was conducted.',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: Qualitative data collection events (FGDs, KIIs) are conducted as part of MEAL plan implementation. This FK links the qualitative record to the MEAL plan under which it was collected, enabling tracking',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: NGO qualitative data collection is conducted by specific org units. Data quality management, accountability to affected populations reporting, and learning synthesis require org unit attribution of qu',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: KIIs/FGDs conducted with partner staff or at partner sites. Business need: partner implementation quality assessment, beneficiary feedback on partner services, safeguarding incident documentation.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who facilitated the FGD or conducted the KII.',
    `project_site_id` BIGINT COMMENT 'Identifier of the project site or field location where the qualitative data collection took place.',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: Key informant interviews and focus group discussions with beneficiaries require linking participant identity for informed consent tracking, follow-up verification, and data triangulation with quantita',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Qualitative data collection events (FGDs, KIIs) occur within defined reporting periods for MEL tracking and donor reporting. qualitative_record has collection_date (a specific event date) but no FK to',
    `tertiary_qualitative_translator_staff_staff_member_id` BIGINT COMMENT 'Identifier of the staff member or volunteer who provided translation services during the session.',
    `volunteer_deployment_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_deployment. Business justification: Qualitative records (FGDs, KIIs) are produced during specific volunteer deployments. Linking to volunteer_deployment enables deployment-level data quality audits, performance attribution, and donor re',
    `admin_level_1` STRING COMMENT 'First-level administrative division (e.g., state, province, region) where the collection took place.',
    `admin_level_2` STRING COMMENT 'Second-level administrative division (e.g., district, county) where the collection took place.',
    `collection_date` DATE COMMENT 'Date when the qualitative data collection event took place.',
    `collection_end_time` TIMESTAMP COMMENT 'Timestamp when the qualitative data collection session ended.',
    `collection_method_type` STRING COMMENT 'Type of qualitative data collection method used. FGD = Focus Group Discussion, KII = Key Informant Interview, MSC = Most Significant Change.. Valid values are `FGD|KII|Case Study|MSC Story|Observation|Participatory Assessment`',
    `collection_start_time` TIMESTAMP COMMENT 'Timestamp when the qualitative data collection session began.',
    `consent_form_version` STRING COMMENT 'Version identifier of the informed consent form used for this qualitative data collection event.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the qualitative data collection occurred.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualitative data collection record was first created in the system.',
    `data_quality_rating` STRING COMMENT 'Assessment of the quality of the qualitative data collected, based on completeness, clarity, and reliability.. Valid values are `Excellent|Good|Fair|Poor`',
    `findings_summary` STRING COMMENT 'Summary of the main findings, conclusions, or insights from the qualitative data collection event.',
    `informant_organization` STRING COMMENT 'Organization or institution the key informant represents (for KIIs), e.g., Ministry of Health, local CBO, partner NGO.',
    `informant_role` STRING COMMENT 'Role or position of the key informant (for KIIs), e.g., community leader, health worker, teacher, local government official.',
    `informed_consent_obtained` BOOLEAN COMMENT 'Indicates whether informed consent was obtained from all participants prior to the qualitative data collection.',
    `key_themes_emerging` STRING COMMENT 'Summary of key themes, patterns, or insights that emerged from the qualitative data collection session.',
    `language_used` STRING COMMENT 'Primary language used during the qualitative data collection session.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualitative data collection record was last modified.',
    `participant_age_group_distribution` STRING COMMENT 'Distribution of participants by age group (e.g., 0-5: 2, 6-17: 5, 18-59: 8, 60+: 3). Free-text summary of age disaggregation.',
    `participant_count` STRING COMMENT 'Total number of participants in the qualitative data collection event (for FGDs) or 1 for KIIs.',
    `participant_female_count` STRING COMMENT 'Number of female participants in the qualitative data collection event.',
    `participant_male_count` STRING COMMENT 'Number of male participants in the qualitative data collection event.',
    `participant_other_gender_count` STRING COMMENT 'Number of participants identifying as other gender in the qualitative data collection event.',
    `primary_theme` STRING COMMENT 'Primary theme or topic area explored in the qualitative data collection (e.g., access to services, community perceptions, program satisfaction).',
    `qualitative_record_status` STRING COMMENT 'Current lifecycle status of the qualitative data collection record.. Valid values are `Draft|Completed|Reviewed|Approved|Archived`',
    `recommendations` STRING COMMENT 'Recommendations for program improvement or action based on the qualitative findings.',
    `recording_consent_obtained` BOOLEAN COMMENT 'Indicates whether explicit consent was obtained from participants to record the session (audio or video).',
    `recording_method` STRING COMMENT 'Method used to record the qualitative data collection session (e.g., audio recording, written notes, digital form).. Valid values are `Audio Recording|Video Recording|Written Notes|Digital Form`',
    `review_date` DATE COMMENT 'Date when the qualitative data collection record was reviewed and validated.',
    `topic_guide_used` STRING COMMENT 'Name or identifier of the topic guide, interview protocol, or discussion guide used for the qualitative data collection.',
    `translation_required` BOOLEAN COMMENT 'Indicates whether translation or interpretation services were required during the qualitative data collection.',
    `verbatim_quotes` STRING COMMENT 'Selected verbatim quotes from participants or key informants that illustrate key findings or themes. Confidential to protect participant identity.',
    CONSTRAINT pk_qualitative_record PRIMARY KEY(`qualitative_record_id`)
) COMMENT 'Qualitative data collection event records capturing Focus Group Discussions (FGDs), Key Informant Interviews (KIIs), case studies, and Most Significant Change (MSC) stories. Each record stores the collection method type, date, location, facilitator/interviewer, participants (count and disaggregation for FGDs, or informant role/organization for KIIs), topic guide or interview protocol used, key themes emerging, verbatim quotes, findings, consent status, and linked indicator or evaluation. Supports qualitative MEL evidence generation and triangulation with quantitative indicator data for robust program learning.';

CREATE OR REPLACE TABLE `ngo_ecm`.`mel`.`data_collection_tool` (
    `data_collection_tool_id` BIGINT COMMENT 'Unique identifier for the data collection tool. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Data collection tools are authorized and deployed within specific partnership agreement scopes. NGOs track tool authorization per agreement for compliance, partner oversight, and ensuring tools meet a',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to field.assessment. Business justification: Data collection tools are deployed in specific assessments. Essential for tool version control, data quality audits, and linking assessment responses to the correct tool version. Assessment has unlink',
    `role_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_role. Business justification: Data collection tools specify which volunteer roles are authorized to administer them (e.g., community health workers for health surveys, enumerators for household surveys). Required for training plan',
    `award_id` BIGINT COMMENT 'Identifier of the grant funding the use of this data collection tool.',
    `budget_line_id` BIGINT COMMENT 'Foreign key linking to finance.budget_line. Business justification: Tool development, software licensing (KoBoToolbox, ODK, SurveyCTO), and deployment costs are budgeted line items. Procurement requisitions for data collection tools and services reference specific bud',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: Capacity assessment tools are a type of data collection tool. Business need: assessment standardization, tool version control, methodology documentation.',
    `governance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.governance_policy. Business justification: Data collection tools must comply with organizational data protection and ethics governance policies (GDPR, informed consent policies). The tool has `data_protection_compliance` and `ethical_review_st',
    `intervention_id` BIGINT COMMENT 'Identifier of the program to which this data collection tool is linked.',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: Data collection tools (KoboToolbox forms, CommCare modules) are designed and deployed as part of MEAL plans. This FK links the tool to the MEAL plan it serves, enabling tracking of MEAL plan data coll',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: NGO data collection tools are owned and deployed by specific org units. Tool approval workflows, deployment authorization, and data governance require org unit ownership tracking. No existing org_unit',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Tools deployed by/for partners in sub-award contexts. Business need: partner data collection coordination, tool standardization across partners, data quality protocol enforcement.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who approved the data collection tool.',
    `training_id` BIGINT COMMENT 'Foreign key linking to volunteer.training. Business justification: NGO data quality protocols require volunteers to complete specific training before using data collection tools (e.g., ODK training before deploying a household survey tool). This link enforces trainin',
    `approval_date` DATE COMMENT 'Date on which the data collection tool was approved for deployment.',
    `approval_status` STRING COMMENT 'Current approval status of the data collection tool by MEL or program management.. Valid values are `pending|approved|rejected|revision_required`',
    `consent_mechanism` STRING COMMENT 'Method by which informed consent is obtained from respondents using this tool.. Valid values are `verbal|written|digital_signature|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this data collection tool record was first created in the system.',
    `data_collection_method` STRING COMMENT 'Primary methodology employed by this tool. FGD (Focus Group Discussion), PDM (Post-Distribution Monitoring). [ENUM-REF-CANDIDATE: survey|interview|fgd|observation|pdm|assessment|other — 7 candidates stripped; promote to reference product]',
    `data_protection_compliance` STRING COMMENT 'Data protection and privacy framework to which this tool adheres. GDPR (General Data Protection Regulation), DPA (Data Protection Act), CHS (Core Humanitarian Standard).. Valid values are `gdpr|local_dpa|chs|none|other`',
    `data_quality_validation_rules` STRING COMMENT 'Description or reference to validation rules embedded in the tool to ensure data quality at point of collection.',
    `deployment_end_date` DATE COMMENT 'Date on which the data collection tool was retired or deactivated from field use.',
    `deployment_start_date` DATE COMMENT 'Date on which the data collection tool was first deployed or made active in the field.',
    `estimated_completion_time_minutes` STRING COMMENT 'Expected time in minutes required to complete the data collection tool.',
    `ethical_review_status` STRING COMMENT 'Status of ethical review or institutional review board (IRB) approval for the data collection tool.. Valid values are `not_required|pending|approved|exempt`',
    `external_tool_url` STRING COMMENT 'URL or hyperlink to the external platform where the tool is hosted or accessed.',
    `geographic_scope` STRING COMMENT 'Geographic deployment scope of the tool, such as country, region, or project site identifiers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this data collection tool record was last updated or modified.',
    `notes` STRING COMMENT 'Additional free-text notes or comments about the data collection tool.',
    `primary_language` STRING COMMENT 'ISO 639 language code for the primary language of the data collection tool.. Valid values are `^[a-z]{2,3}$`',
    `question_count` STRING COMMENT 'Total number of questions or data fields in the collection tool.',
    `respondent_type` STRING COMMENT 'Classification of the target respondent or data subject for this collection tool. [ENUM-REF-CANDIDATE: beneficiary|household|community_leader|key_informant|staff|partner|other — 7 candidates stripped; promote to reference product]',
    `revision_reason` STRING COMMENT 'Explanation or justification for the most recent revision or version update of the tool.',
    `tool_code` STRING COMMENT 'Unique business identifier code for the data collection tool, used for external reference and integration.. Valid values are `^[A-Z0-9]{6,20}$`',
    `tool_documentation_url` STRING COMMENT 'URL or reference to documentation, user guides, or training materials for the data collection tool.',
    `tool_name` STRING COMMENT 'Human-readable name of the data collection tool or instrument.',
    `tool_status` STRING COMMENT 'Current lifecycle status of the data collection tool.. Valid values are `draft|under_review|approved|active|retired|archived`',
    `tool_type` STRING COMMENT 'Classification of the data collection tool by format and platform.. Valid values are `kobo_form|odk_form|commcare_module|dhis2_form|paper_survey|interview_guide`',
    `version_number` STRING COMMENT 'Version identifier of the data collection tool following semantic versioning convention.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    CONSTRAINT pk_data_collection_tool PRIMARY KEY(`data_collection_tool_id`)
) COMMENT 'Registry of MEL data collection instruments including KoboToolbox/ODK forms, CommCare modules, DHIS2 data entry forms, and structured interview guides. Each record captures tool name, version number, linked indicator(s), deployment platform, language(s), target respondent type, geographic deployment scope, approval status, and active/retired lifecycle state. Ensures instrument governance, version control, and traceability from collected data back to the authorized collection tool.';

CREATE OR REPLACE TABLE `ngo_ecm`.`mel`.`data_quality_assessment` (
    `data_quality_assessment_id` BIGINT COMMENT 'Unique identifier for the data quality assessment record. Primary key for the data quality assessment entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: DQAs are conducted within the scope of specific partnership agreements — the agreement defines data quality requirements and reporting obligations. NGOs link DQAs to agreements for compliance verifica',
    `audit_finding_id` BIGINT COMMENT 'Foreign key linking to compliance.audit_finding. Business justification: Data quality assessments are frequently conducted in direct response to audit findings that question the accuracy, completeness, or timeliness of reported MEL data. This link enables tracking which DQ',
    `award_id` BIGINT COMMENT 'Reference to the grant or award associated with this data quality assessment.',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: DQAs inform partner capacity scores, especially MEL capacity domain. Business need: capacity assessment validation, MEL score calibration, risk rating evidence.',
    `data_collection_tool_id` BIGINT COMMENT 'Foreign key linking to mel.data_collection_tool. Business justification: Data Quality Assessments audit the quality of data collected through specific tools (KoboToolbox, ODK, CommCare, DHIS2 forms). The data_source_audited field is currently a STRING, but should be normal',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer. Business justification: DQA audits data collected by volunteers, must track collector identity for accountability, corrective action targeting, and retraining decisions. Essential for volunteer data quality management and do',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: DQAs are mandated by specific donor requirements (e.g., USAID ADS 203 requires periodic DQAs). Linking DQA to the donor_requirement that mandated it enables compliance tracking of whether DQA obligati',
    `followup_data_quality_assessment_id` BIGINT COMMENT 'Self-referencing FK on data_quality_assessment (followup_data_quality_assessment_id)',
    `indicator_id` BIGINT COMMENT 'Reference to the specific MEL indicator that was reviewed or audited during this data quality assessment.',
    `indicator_result_id` BIGINT COMMENT 'Foreign key linking to mel.indicator_result. Business justification: DQAs and RDQAs systematically verify actual result records for accuracy, completeness, timeliness, and consistency. Linking data_quality_assessment to indicator_result enables direct traceability from',
    `indicator_target_id` BIGINT COMMENT 'Foreign key linking to mel.indicator_target. Business justification: Data Quality Assessments (DQAs/RDQAs) are conducted to verify the quality of data reported against specific indicator targets. data_quality_assessment already has indicator_id -> indicator (library-le',
    `internal_review_id` BIGINT COMMENT 'Foreign key linking to compliance.internal_review. Business justification: Internal compliance reviews routinely commission or incorporate DQAs as part of their scope. Linking DQA to the internal_review that triggered it enables compliance officers to track DQA findings with',
    `intervention_id` BIGINT COMMENT 'Reference to the program under which this data quality assessment was conducted.',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: Data Quality Assessments (DQAs) are conducted as part of MEAL plan implementation to verify data quality protocols. This FK links the DQA to the MEAL plan under which it was conducted, enabling tracki',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: NGO DQA processes are scoped to specific org units for corrective action follow-up and accountability. Donor-required DQA reporting and organizational learning require org unit attribution. No existin',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: DQAs audit partner-reported data. Business need: partner data quality oversight, fiduciary risk management, partner performance scoring, enhanced monitoring triggers.',
    `partner_performance_review_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_performance_review. Business justification: DQA results feed into partner performance ratings. Business need: performance review evidence base, reporting compliance scoring, data quality rating component.',
    `partner_report_submission_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_report_submission. Business justification: DQAs validate data in partner reports. Business need: report acceptance decision, data quality scoring, verification evidence for donor reporting.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member who conducted or led the data quality assessment.',
    `project_site_id` BIGINT COMMENT 'Reference to the specific project site or field location where the data quality assessment was conducted.',
    `qualitative_record_id` BIGINT COMMENT 'Foreign key linking to mel.qualitative_record. Business justification: DQAs assess not only quantitative indicator results but also qualitative data collection records (FGDs, KIIs). The data_quality_assessment product description mentions systematic verification of dat',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: DQAs and RDQAs are conducted on a periodic basis aligned to reporting cycles (quarterly, annual, donor reporting deadlines). data_quality_assessment has assessment_date, assessment_start_date, assessm',
    `reviewer_staff_staff_member_id` BIGINT COMMENT 'Reference to the staff member who reviewed or approved the data quality assessment findings.',
    `single_audit_id` BIGINT COMMENT 'Foreign key linking to compliance.single_audit. Business justification: DQAs are often required as part of single audit preparation (to verify data before auditor testing) or follow-up (to address audit findings). This link enables tracking DQA activities within the singl',
    `accuracy_score_percentage` DECIMAL(18,2) COMMENT 'The percentage score representing the accuracy of the data assessed, calculated as the proportion of verified records that matched source documentation.',
    `assessment_code` STRING COMMENT 'Business identifier or reference code for the data quality assessment, used for external tracking and reporting.',
    `assessment_date` DATE COMMENT 'The date on which the data quality assessment was conducted or completed. Principal business event timestamp for the assessment.',
    `assessment_end_date` DATE COMMENT 'The date when the data quality assessment activities concluded.',
    `assessment_start_date` DATE COMMENT 'The date when the data quality assessment activities began.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the data quality assessment (e.g., planned, in progress, completed, reviewed, approved, cancelled).. Valid values are `planned|in_progress|completed|reviewed|approved|cancelled`',
    `assessment_type` STRING COMMENT 'Type or category of data quality assessment conducted (e.g., routine DQA, RDQA, spot-check, comprehensive audit, verification, triangulation). [ENUM-REF-CANDIDATE: routine_dqa|rdqa|spot_check|comprehensive_audit|verification|triangulation|baseline_dqa — 7 candidates stripped; promote to reference product]',
    `assessor_name` STRING COMMENT 'The full name of the staff member or consultant who conducted the data quality assessment.',
    `assessor_organization` STRING COMMENT 'The name of the organization or unit to which the assessor belongs (e.g., internal MEL team, external auditor, donor verification team).',
    `completeness_score_percentage` DECIMAL(18,2) COMMENT 'The percentage score representing the completeness of the data assessed, calculated as the proportion of required fields that were populated.',
    `consistency_score_percentage` DECIMAL(18,2) COMMENT 'The percentage score representing the consistency of the data assessed, calculated as the proportion of records that were internally consistent and aligned across systems.',
    `corrective_action_completion_date` DATE COMMENT 'The actual date when corrective actions were completed.',
    `corrective_action_due_date` DATE COMMENT 'The target date by which corrective actions should be completed.',
    `corrective_action_status` STRING COMMENT 'Current status of the implementation of corrective actions (e.g., not started, in progress, completed, verified, overdue).. Valid values are `not_started|in_progress|completed|verified|overdue`',
    `corrective_actions` STRING COMMENT 'Detailed description of the corrective actions recommended or taken to address the data quality issues identified during the assessment.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country where the data quality assessment was conducted.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this data quality assessment record was first created in the system.',
    `dac_criteria_assessed` STRING COMMENT 'The DAC evaluation criteria that were assessed during the data quality review (e.g., relevance, effectiveness, efficiency, impact, sustainability, coherence).',
    `data_source_type` STRING COMMENT 'The type or category of the data source audited (e.g., DHIS2, KoboToolbox, CommCare, field register, paper form, Excel, ERP, CRM). [ENUM-REF-CANDIDATE: dhis2|kobo|commcare|field_register|paper_form|excel|erp|crm|other — 9 candidates stripped; promote to reference product]',
    `discrepancy_count` STRING COMMENT 'The total number of discrepancies or errors identified during the data quality assessment.',
    `discrepancy_findings` STRING COMMENT 'Detailed narrative description of the discrepancies, errors, or data quality issues identified during the assessment.',
    `donor_reporting_requirement` STRING COMMENT 'Indicates whether this data quality assessment was conducted to meet a specific donor reporting or verification requirement (e.g., USAID DQA, Global Fund LFA, DFID verification, BHA audit).. Valid values are `usaid_dqa|global_fund_lfa|dfid_verification|bha_audit|other|none`',
    `geographic_scope` STRING COMMENT 'Description of the geographic scope or coverage area of the data quality assessment (e.g., national, regional, district, project site).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this data quality assessment record was last updated or modified in the system.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information related to the data quality assessment.',
    `overall_dqa_score_percentage` DECIMAL(18,2) COMMENT 'The overall composite data quality score, typically calculated as a weighted average of accuracy, completeness, timeliness, and consistency scores.',
    `priority_level` STRING COMMENT 'The priority level assigned to the data quality issues identified, indicating the urgency of corrective actions (e.g., critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `records_verified` STRING COMMENT 'The total number of records that were successfully verified during the assessment.',
    `report_url` STRING COMMENT 'The URL or file path to the full data quality assessment report document.',
    `review_date` DATE COMMENT 'The date when the data quality assessment findings were reviewed or approved.',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying root causes of the data quality issues identified, including systemic, process, or capacity-related factors.',
    `sample_size` STRING COMMENT 'The number of records, cases, or data points sampled and reviewed during the data quality assessment.',
    `timeliness_score_percentage` DECIMAL(18,2) COMMENT 'The percentage score representing the timeliness of the data assessed, calculated as the proportion of records submitted or updated within required timeframes.',
    `verification_method` STRING COMMENT 'The method used to verify data quality during the assessment (e.g., spot-check, recount, triangulation, source document review, system audit, beneficiary interview, observation). [ENUM-REF-CANDIDATE: spot_check|recount|triangulation|source_document_review|system_audit|beneficiary_interview|observation — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_data_quality_assessment PRIMARY KEY(`data_quality_assessment_id`)
) COMMENT 'Data Quality Assessment (DQA) and Routine Data Quality Audit (RDQA) records capturing systematic verification of MEL data accuracy, completeness, timeliness, and consistency. Stores assessment date, data source audited, indicator(s) reviewed, verification method (spot-check, recount, triangulation), discrepancy findings, corrective actions, and assessor. Supports USAID DQA requirements, Global Fund LFA verification, and internal data governance standards.';

CREATE OR REPLACE TABLE `ngo_ecm`.`mel`.`reporting_period` (
    `reporting_period_id` BIGINT COMMENT 'Primary key for reporting_period',
    `component_id` BIGINT COMMENT 'Reference to the program or project for which this reporting period is defined. Links the period to specific humanitarian or development interventions.',
    `constituent_id` BIGINT COMMENT 'Reference to the primary donor or funding organization whose reporting requirements this period serves. Used for donor-specific reporting cycles.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Reporting period cadence is defined by donor requirements (e.g., quarterly reporting requirement sets the period structure). Linking reporting_period to the donor_requirement that defines its frequenc',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: MEL reporting periods must align to finance fiscal periods for integrated financial and results reporting — a core NGO requirement for donor reports combining financial and programmatic data. Without ',
    `logframe_id` BIGINT COMMENT 'Reference to the specific version of the Logical Framework (LogFrame) that is active during this reporting period. Ensures indicator targets and actuals are measured against the correct framework version.',
    `parent_period_reporting_period_id` BIGINT COMMENT 'Reference to a parent reporting period for hierarchical period structures (e.g., monthly periods rolling up to quarterly periods, quarterly to annual). Null for top-level periods.',
    `primary_prior_reporting_period_id` BIGINT COMMENT 'Self-referencing FK on reporting_period (prior_reporting_period_id)',
    `baseline_period_flag` BOOLEAN COMMENT 'Indicates whether this reporting period represents a baseline measurement period for program indicators (True) or not (False). Baseline periods establish the starting point for impact measurement.',
    `calendar_year` STRING COMMENT 'The calendar year in which the reporting period falls, used for temporal analysis and trend reporting.',
    `closed_date` DATE COMMENT 'The date on which the reporting period was officially closed and locked for further data entry. Null if the period is still open or in draft status.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this reporting period record was first created in the system. Used for audit trail and data lineage tracking.',
    `dac_criteria_focus` STRING COMMENT 'The primary DAC evaluation criteria focus for this period (e.g., Relevance, Effectiveness, Efficiency, Impact, Sustainability, Coherence). Multiple criteria may be listed as comma-separated values.',
    `data_collection_deadline` DATE COMMENT 'The deadline date by which all data collection activities for this reporting period must be completed. Used for MEL workflow management.',
    `data_quality_audit_flag` BOOLEAN COMMENT 'Indicates whether a data quality audit or verification exercise is scheduled for this reporting period (True) or not (False). Ensures data integrity and reliability.',
    `dhis2_period_code` STRING COMMENT 'The period identifier used in DHIS2 system for aggregate health data reporting. Enables integration with DHIS2 for health program monitoring.',
    `donor_reporting_cycle` STRING COMMENT 'The specific donor reporting cycle or phase that this period supports (e.g., Year 1 Q2, Mid-term Review, Final Report). Used to align with donor contractual obligations.',
    `duration_days` STRING COMMENT 'The total number of calendar days covered by this reporting period, calculated from start_date to end_date inclusive.',
    `end_date` DATE COMMENT 'The last date of the reporting period when data collection and monitoring activities conclude.',
    `endline_period_flag` BOOLEAN COMMENT 'Indicates whether this reporting period represents an endline measurement period for program indicators (True) or not (False). Endline periods capture final outcomes and impact.',
    `evaluation_type` STRING COMMENT 'The type of evaluation activity conducted during this reporting period, aligned with DAC evaluation criteria (formative, process, outcome, impact, ex-post, real-time). Null if no formal evaluation is scheduled.',
    `fgd_scheduled_flag` BOOLEAN COMMENT 'Indicates whether Focus Group Discussions (FGDs) are scheduled to be conducted during this reporting period (True) or not (False). Used for qualitative data collection planning.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this reporting period belongs (e.g., FY2024, FY2023-24). Used for budget alignment and annual donor reporting.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this reporting period record is currently active and available for use (True) or has been soft-deleted/deactivated (False). Used for logical deletion without physical removal.',
    `kii_scheduled_flag` BOOLEAN COMMENT 'Indicates whether Key Informant Interviews (KIIs) are scheduled to be conducted during this reporting period (True) or not (False). Used for qualitative data collection planning.',
    `midline_period_flag` BOOLEAN COMMENT 'Indicates whether this reporting period represents a midline measurement period for program indicators (True) or not (False). Midline periods assess progress at the program midpoint.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this reporting period record was last modified. Used for audit trail and change tracking.',
    `month_number` STRING COMMENT 'The month number (1-12) within the year, applicable for monthly reporting periods. Null for non-monthly periods.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or contextual information about the reporting period, including any anomalies, challenges, or special circumstances affecting data collection.',
    `pdm_cycle_flag` BOOLEAN COMMENT 'Indicates whether this reporting period includes a Post-Distribution Monitoring (PDM) cycle for assessing the effectiveness and impact of distributed aid (True) or not (False).',
    `period_code` STRING COMMENT 'Business identifier code for the reporting period, used in external communications and donor reports (e.g., Q1-2024, FY2024, JAN2024).',
    `period_description` STRING COMMENT 'Detailed description of the reporting period, including any special characteristics, contextual information, or notes about data collection activities during this period.',
    `period_name` STRING COMMENT 'Human-readable name or label for the reporting period (e.g., First Quarter 2024, January 2024, Fiscal Year 2024).',
    `period_status` STRING COMMENT 'Current lifecycle status of the reporting period (draft: not yet started, active: currently open for data collection, closed: finalized and locked, archived: historical record).',
    `period_type` STRING COMMENT 'Classification of the reporting period by its duration or frequency (daily, weekly, monthly, quarterly, semi-annual, annual, or custom).',
    `quarter_number` STRING COMMENT 'The quarter number (1-4) within the fiscal or calendar year, applicable for quarterly reporting periods. Null for non-quarterly periods.',
    `report_submission_deadline` DATE COMMENT 'The deadline date by which the final report for this period must be submitted to donors or stakeholders. Critical for compliance with donor agreements.',
    `reporting_frequency` STRING COMMENT 'The frequency at which data is expected to be reported during this period, aligned with donor requirements and MEL framework schedules.',
    `start_date` DATE COMMENT 'The first date of the reporting period when data collection and monitoring activities begin.',
    `week_number` STRING COMMENT 'The ISO week number (1-53) within the year, applicable for weekly reporting periods. Null for non-weekly periods.',
    CONSTRAINT pk_reporting_period PRIMARY KEY(`reporting_period_id`)
) COMMENT 'Master reference table for reporting_period. Referenced by reporting_period_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ADD CONSTRAINT `fk_mel_logframe_parent_logframe_mel_logframe_id` FOREIGN KEY (`parent_logframe_mel_logframe_id`) REFERENCES `ngo_ecm`.`mel`.`logframe`(`logframe_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `ngo_ecm`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_logframe_id` FOREIGN KEY (`logframe_id`) REFERENCES `ngo_ecm`.`mel`.`logframe`(`logframe_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ADD CONSTRAINT `fk_mel_indicator_target_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `ngo_ecm`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_indicator_target_id` FOREIGN KEY (`indicator_target_id`) REFERENCES `ngo_ecm`.`mel`.`indicator_target`(`indicator_target_id`);
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ADD CONSTRAINT `fk_mel_indicator_result_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ADD CONSTRAINT `fk_mel_meal_plan_logframe_id` FOREIGN KEY (`logframe_id`) REFERENCES `ngo_ecm`.`mel`.`logframe`(`logframe_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_logframe_id` FOREIGN KEY (`logframe_id`) REFERENCES `ngo_ecm`.`mel`.`logframe`(`logframe_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ADD CONSTRAINT `fk_mel_evaluation_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `ngo_ecm`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ADD CONSTRAINT `fk_mel_evaluation_finding_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `ngo_ecm`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `ngo_ecm`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_evaluation_id` FOREIGN KEY (`evaluation_id`) REFERENCES `ngo_ecm`.`mel`.`evaluation`(`evaluation_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `ngo_ecm`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ADD CONSTRAINT `fk_mel_qualitative_record_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ADD CONSTRAINT `fk_mel_data_collection_tool_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `ngo_ecm`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_data_collection_tool_id` FOREIGN KEY (`data_collection_tool_id`) REFERENCES `ngo_ecm`.`mel`.`data_collection_tool`(`data_collection_tool_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_followup_data_quality_assessment_id` FOREIGN KEY (`followup_data_quality_assessment_id`) REFERENCES `ngo_ecm`.`mel`.`data_quality_assessment`(`data_quality_assessment_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_indicator_id` FOREIGN KEY (`indicator_id`) REFERENCES `ngo_ecm`.`mel`.`indicator`(`indicator_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_indicator_result_id` FOREIGN KEY (`indicator_result_id`) REFERENCES `ngo_ecm`.`mel`.`indicator_result`(`indicator_result_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_indicator_target_id` FOREIGN KEY (`indicator_target_id`) REFERENCES `ngo_ecm`.`mel`.`indicator_target`(`indicator_target_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_meal_plan_id` FOREIGN KEY (`meal_plan_id`) REFERENCES `ngo_ecm`.`mel`.`meal_plan`(`meal_plan_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_qualitative_record_id` FOREIGN KEY (`qualitative_record_id`) REFERENCES `ngo_ecm`.`mel`.`qualitative_record`(`qualitative_record_id`);
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ADD CONSTRAINT `fk_mel_data_quality_assessment_reporting_period_id` FOREIGN KEY (`reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `ngo_ecm`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_logframe_id` FOREIGN KEY (`logframe_id`) REFERENCES `ngo_ecm`.`mel`.`logframe`(`logframe_id`);
ALTER TABLE `ngo_ecm`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_parent_period_reporting_period_id` FOREIGN KEY (`parent_period_reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);
ALTER TABLE `ngo_ecm`.`mel`.`reporting_period` ADD CONSTRAINT `fk_mel_reporting_period_primary_prior_reporting_period_id` FOREIGN KEY (`primary_prior_reporting_period_id`) REFERENCES `ngo_ecm`.`mel`.`reporting_period`(`reporting_period_id`);

-- ========= TAGS =========
ALTER SCHEMA `ngo_ecm`.`mel` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `ngo_ecm`.`mel` SET TAGS ('dbx_domain' = 'mel');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` SET TAGS ('dbx_subdomain' = 'indicator_management');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Volunteer Role Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `dac_criteria_alignment` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Criteria Alignment');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `data_collection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Frequency');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `definition` SET TAGS ('dbx_business_glossary_term' = 'Indicator Definition');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `denominator_description` SET TAGS ('dbx_business_glossary_term' = 'Denominator Description');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `dhis2_indicator_code` SET TAGS ('dbx_business_glossary_term' = 'DHIS2 Indicator ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `direction_of_change` SET TAGS ('dbx_business_glossary_term' = 'Direction of Change');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `direction_of_change` SET TAGS ('dbx_value_regex' = 'increase|decrease|maintain|not-applicable');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `disaggregation_dimensions` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation Dimensions');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `indicator_category` SET TAGS ('dbx_business_glossary_term' = 'Indicator Category');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `indicator_category` SET TAGS ('dbx_value_regex' = 'quantitative|qualitative|composite');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `indicator_code` SET TAGS ('dbx_business_glossary_term' = 'Indicator Code');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `indicator_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `indicator_name` SET TAGS ('dbx_business_glossary_term' = 'Indicator Name');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `indicator_status` SET TAGS ('dbx_business_glossary_term' = 'Indicator Status');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `indicator_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|under-review');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `indicator_type` SET TAGS ('dbx_business_glossary_term' = 'Indicator Type');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `indicator_type` SET TAGS ('dbx_value_regex' = 'output|outcome|impact|process|input');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `is_custom` SET TAGS ('dbx_business_glossary_term' = 'Is Custom Indicator');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Indicator');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `logframe_level` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Level');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `logframe_level` SET TAGS ('dbx_value_regex' = 'goal|purpose|output|activity');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Indicator Notes');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `numerator_description` SET TAGS ('dbx_business_glossary_term' = 'Numerator Description');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually|ad-hoc');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Sector');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Date');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `theme` SET TAGS ('dbx_business_glossary_term' = 'Theme');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ngo_ecm`.`mel`.`indicator` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` SET TAGS ('dbx_subdomain' = 'indicator_management');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Logical Framework (LogFrame) ID');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `consortium_id` SET TAGS ('dbx_business_glossary_term' = 'Consortium Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Award ID');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `parent_logframe_mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Logical Framework (LogFrame) ID');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Position Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Volunteer Role Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `assumptions` SET TAGS ('dbx_business_glossary_term' = 'Assumptions');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `dac_evaluation_criterion` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Evaluation Criterion');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `dac_evaluation_criterion` SET TAGS ('dbx_value_regex' = 'Relevance|Coherence|Effectiveness|Efficiency|Impact|Sustainability');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `disaggregation_dimensions` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation Dimensions');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `donor_template_type` SET TAGS ('dbx_business_glossary_term' = 'Donor Template Type');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `hierarchy_sequence` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Sequence Number');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `intervention_statement` SET TAGS ('dbx_business_glossary_term' = 'Intervention Statement');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `is_custom_indicator` SET TAGS ('dbx_business_glossary_term' = 'Is Custom Indicator Flag');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `is_mandatory_donor_indicator` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Donor Indicator Flag');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `logframe_code` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Code');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `logframe_name` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Name');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `means_of_verification` SET TAGS ('dbx_business_glossary_term' = 'Means of Verification (MoV)');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `mel_logframe_status` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Status');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `objectively_verifiable_indicator` SET TAGS ('dbx_business_glossary_term' = 'Objectively Verifiable Indicator (OVI)');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'Monthly|Quarterly|Semi-Annual|Annual|Ad-Hoc|Milestone-Based');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `results_chain_level` SET TAGS ('dbx_business_glossary_term' = 'Results Chain Level');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `risks` SET TAGS ('dbx_business_glossary_term' = 'Risks');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Date');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `theory_of_change_component` SET TAGS ('dbx_business_glossary_term' = 'Theory of Change (ToC) Component');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `ngo_ecm`.`mel`.`logframe` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Logical Framework (LogFrame) Version');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` SET TAGS ('dbx_subdomain' = 'indicator_management');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `indicator_target_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Target ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `distribution_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Unit ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Volunteer Role Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `target_population_id` SET TAGS ('dbx_business_glossary_term' = 'Target Population Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `assumptions` SET TAGS ('dbx_business_glossary_term' = 'Assumptions');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_age_group` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Age Group');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Disability Status');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_disability_status` SET TAGS ('dbx_value_regex' = 'with_disability|without_disability|not_specified');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Displacement Status');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_sex` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Sex');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `disaggregation_sex` SET TAGS ('dbx_value_regex' = 'male|female|other|not_specified');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `donor_reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Requirement');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `measurement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Measurement Frequency');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `risks` SET TAGS ('dbx_business_glossary_term' = 'Risks');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `target_code` SET TAGS ('dbx_business_glossary_term' = 'Target Code');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `target_date` SET TAGS ('dbx_business_glossary_term' = 'Target Date');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `target_description` SET TAGS ('dbx_business_glossary_term' = 'Target Description');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `target_name` SET TAGS ('dbx_business_glossary_term' = 'Target Name');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `target_status` SET TAGS ('dbx_business_glossary_term' = 'Target Status');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `target_type` SET TAGS ('dbx_business_glossary_term' = 'Target Type');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `target_type` SET TAGS ('dbx_value_regex' = 'output|outcome|impact|process|input');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_target` ALTER COLUMN `verification_source` SET TAGS ('dbx_business_glossary_term' = 'Verification Source');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` SET TAGS ('dbx_subdomain' = 'indicator_management');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `indicator_result_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Result ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `capacity_building_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Building Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Collected By Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `distribution_order_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `donor_report_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Report ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `indicator_target_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Target Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `needs_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Needs Assessment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `partner_performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Performance Review Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `partner_report_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Report Submission Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `volunteer_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Deployment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `baseline_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Count');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `contributing_factors` SET TAGS ('dbx_business_glossary_term' = 'Contributing Factors');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `cumulative_result` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Result');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `data_quality_notes` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Notes');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_age_group` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Age Group');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_age_group` SET TAGS ('dbx_value_regex' = '0-5|6-17|18-59|60+|not_applicable');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_disability` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Disability Status');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_disability` SET TAGS ('dbx_value_regex' = 'with_disability|without_disability|unknown|not_applicable');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_disability` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_disability` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_displacement_status` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Displacement Status');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_displacement_status` SET TAGS ('dbx_value_regex' = 'idp|refugee|returnee|host_community|not_applicable');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_sex` SET TAGS ('dbx_business_glossary_term' = 'Disaggregation by Sex');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `disaggregation_sex` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown|not_applicable');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `evidence_file_path` SET TAGS ('dbx_business_glossary_term' = 'Evidence File Path');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `geographic_level` SET TAGS ('dbx_business_glossary_term' = 'Geographic Level');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `geographic_level` SET TAGS ('dbx_value_regex' = 'national|regional|district|community|facility');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `household_count` SET TAGS ('dbx_business_glossary_term' = 'Household Count');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `indicator_level` SET TAGS ('dbx_business_glossary_term' = 'Indicator Level');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `indicator_level` SET TAGS ('dbx_value_regex' = 'output|outcome|impact|process');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `is_milestone` SET TAGS ('dbx_business_glossary_term' = 'Is Milestone Flag');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `narrative_description` SET TAGS ('dbx_business_glossary_term' = 'Narrative Description');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `reported_to_donor` SET TAGS ('dbx_business_glossary_term' = 'Reported to Donor Flag');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `result_status` SET TAGS ('dbx_business_glossary_term' = 'Result Status');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `result_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|archived');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `target_value` SET TAGS ('dbx_business_glossary_term' = 'Target Value');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `variance_from_target` SET TAGS ('dbx_business_glossary_term' = 'Variance from Target');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|verified|rejected|pending_review');
ALTER TABLE `ngo_ecm`.`mel`.`indicator_result` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` SET TAGS ('dbx_subdomain' = 'indicator_management');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Evaluation Accountability and Learning (MEAL) Plan Identifier');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `budget_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Evaluation and Learning (MEL) Staff Lead Identifier');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `accountability_mechanisms` SET TAGS ('dbx_business_glossary_term' = 'Accountability Mechanisms Description');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Approval Date');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `baseline_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Assessment Completion Date');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `beneficiary_feedback_channels` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Feedback Channels Description');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Budget Allocated Amount');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `budget_allocated` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `chs_commitment_alignment` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Commitment Alignment');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `dac_criteria_coverage` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Criteria Coverage');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `data_collection_methods` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Methods');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `data_collection_tools` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Tools and Platforms');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `data_disaggregation_plan` SET TAGS ('dbx_business_glossary_term' = 'Data Disaggregation Plan');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `data_management_protocols` SET TAGS ('dbx_business_glossary_term' = 'Data Management Protocols');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `data_quality_protocols` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Assurance Protocols');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `donor_reporting_requirements` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Requirements Description');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Effective End Date');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Effective Start Date');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `endline_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Endline Evaluation Planned Date');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `ethical_considerations` SET TAGS ('dbx_business_glossary_term' = 'Ethical Considerations and Safeguards');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `evaluation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Strategy Description');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `indicator_count` SET TAGS ('dbx_business_glossary_term' = 'Total Indicator Count');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `learning_agenda` SET TAGS ('dbx_business_glossary_term' = 'Learning Agenda Description');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `midline_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Midline Evaluation Planned Date');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `monitoring_strategy` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Strategy Description');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Status');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `plan_title` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Title');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Version Number');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `rbm_framework_alignment` SET TAGS ('dbx_business_glossary_term' = 'Results-Based Management (RBM) Framework Alignment');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `reporting_calendar` SET TAGS ('dbx_business_glossary_term' = 'Reporting Calendar Description');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `revision_history` SET TAGS ('dbx_business_glossary_term' = 'MEAL Plan Revision History');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `risk_mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'MEL Risk Mitigation Plan');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `ngo_ecm`.`mel`.`meal_plan` ALTER COLUMN `toc_narrative` SET TAGS ('dbx_business_glossary_term' = 'Theory of Change (ToC) Narrative');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` SET TAGS ('dbx_subdomain' = 'evaluation_learning');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation ID');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Commissioned By Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `consortium_id` SET TAGS ('dbx_business_glossary_term' = 'Consortium Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `governance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Governance Policy Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `grant_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Budget Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Evaluator Volunteer Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `partner_report_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Report Submission Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `single_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Single Audit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `beneficiary_sample_size` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Sample Size');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Budget Amount');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `coherence_rating` SET TAGS ('dbx_business_glossary_term' = 'Coherence Rating');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `coherence_rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `dac_criteria_assessed` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Criteria Assessed');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `data_collection_methods` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Methods');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `dissemination_date` SET TAGS ('dbx_business_glossary_term' = 'Dissemination Date');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Rating');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `efficiency_rating` SET TAGS ('dbx_business_glossary_term' = 'Efficiency Rating');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `efficiency_rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `ethics_approval_obtained` SET TAGS ('dbx_business_glossary_term' = 'Ethics Approval Obtained');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `evaluation_code` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Code');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `evaluation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `evaluation_scope` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Scope');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `evaluator_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Type');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `evaluator_type` SET TAGS ('dbx_value_regex' = 'internal|external|joint|participatory');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Impact Rating');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `impact_rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `lead_evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Evaluator Name');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `lead_evaluator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `management_response_date` SET TAGS ('dbx_business_glossary_term' = 'Management Response Date');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `management_response_status` SET TAGS ('dbx_business_glossary_term' = 'Management Response Status');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `management_response_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|not_required');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Methodology');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Purpose');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `purpose` SET TAGS ('dbx_value_regex' = 'accountability|learning|decision_making|compliance');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `quality_assurance_conducted` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Conducted');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `recommendations_summary` SET TAGS ('dbx_business_glossary_term' = 'Recommendations Summary');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `relevance_rating` SET TAGS ('dbx_business_glossary_term' = 'Relevance Rating');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `relevance_rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Report URL');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `team_size` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Team Size');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Title');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` SET TAGS ('dbx_subdomain' = 'evaluation_learning');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `evaluation_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Finding Identifier (ID)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Action Owner Staff Member Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Grant Identifier (ID)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `capacity_building_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Building Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Identifier (ID)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Program Identifier (ID)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `partner_performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Performance Review Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `risk_register_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Register Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `agreement_amendment_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered Agreement Amendment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `action_plan` SET TAGS ('dbx_business_glossary_term' = 'Action Plan');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `beneficiary_category` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Category');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Closure Notes');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `cross_cutting_theme` SET TAGS ('dbx_business_glossary_term' = 'Cross-Cutting Theme');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `dac_criterion` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Criterion');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `dac_criterion` SET TAGS ('dbx_value_regex' = 'relevance|coherence|effectiveness|efficiency|impact|sustainability');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `donor_visibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Visibility Flag');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `evidence_base` SET TAGS ('dbx_business_glossary_term' = 'Evidence Base');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `finding_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Date');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `finding_statement` SET TAGS ('dbx_business_glossary_term' = 'Finding Statement');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'finding|conclusion|recommendation|lesson_learned|good_practice');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `implementation_progress_percentage` SET TAGS ('dbx_business_glossary_term' = 'Implementation Progress Percentage');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `implementation_status` SET TAGS ('dbx_business_glossary_term' = 'Implementation Status');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `implementation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|partially_implemented|fully_implemented|closed|rejected');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `rating` SET TAGS ('dbx_business_glossary_term' = 'Finding Rating');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `rating` SET TAGS ('dbx_value_regex' = 'highly_satisfactory|satisfactory|moderately_satisfactory|moderately_unsatisfactory|unsatisfactory|highly_unsatisfactory');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `risk_implication` SET TAGS ('dbx_business_glossary_term' = 'Risk Implication');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `sector` SET TAGS ('dbx_business_glossary_term' = 'Sector');
ALTER TABLE `ngo_ecm`.`mel`.`evaluation_finding` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` SET TAGS ('dbx_subdomain' = 'evaluation_learning');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `qualitative_record_id` SET TAGS ('dbx_business_glossary_term' = 'Qualitative Record Identifier');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `community_id` SET TAGS ('dbx_business_glossary_term' = 'Community Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `data_collection_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Tool Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Data Collector Volunteer Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `distribution_order_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Staff ID');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `tertiary_qualitative_translator_staff_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Translator Staff ID');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `tertiary_qualitative_translator_staff_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `tertiary_qualitative_translator_staff_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `volunteer_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Deployment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `admin_level_1` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 1');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `admin_level_2` SET TAGS ('dbx_business_glossary_term' = 'Administrative Level 2');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `collection_end_time` SET TAGS ('dbx_business_glossary_term' = 'Collection End Time');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `collection_method_type` SET TAGS ('dbx_business_glossary_term' = 'Collection Method Type');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `collection_method_type` SET TAGS ('dbx_value_regex' = 'FGD|KII|Case Study|MSC Story|Observation|Participatory Assessment');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `collection_start_time` SET TAGS ('dbx_business_glossary_term' = 'Collection Start Time');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `consent_form_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Form Version');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Rating');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `data_quality_rating` SET TAGS ('dbx_value_regex' = 'Excellent|Good|Fair|Poor');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `informant_organization` SET TAGS ('dbx_business_glossary_term' = 'Informant Organization');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `informant_role` SET TAGS ('dbx_business_glossary_term' = 'Informant Role');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `informed_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Informed Consent Obtained');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `key_themes_emerging` SET TAGS ('dbx_business_glossary_term' = 'Key Themes Emerging');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `language_used` SET TAGS ('dbx_business_glossary_term' = 'Language Used');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `participant_age_group_distribution` SET TAGS ('dbx_business_glossary_term' = 'Participant Age Group Distribution');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Count');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `participant_female_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Female Count');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `participant_male_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Male Count');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `participant_other_gender_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Other Gender Count');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `participant_other_gender_count` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `participant_other_gender_count` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `primary_theme` SET TAGS ('dbx_business_glossary_term' = 'Primary Theme');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `qualitative_record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `qualitative_record_status` SET TAGS ('dbx_value_regex' = 'Draft|Completed|Reviewed|Approved|Archived');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `recommendations` SET TAGS ('dbx_business_glossary_term' = 'Recommendations');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `recording_consent_obtained` SET TAGS ('dbx_business_glossary_term' = 'Recording Consent Obtained');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `recording_method` SET TAGS ('dbx_business_glossary_term' = 'Recording Method');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `recording_method` SET TAGS ('dbx_value_regex' = 'Audio Recording|Video Recording|Written Notes|Digital Form');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `topic_guide_used` SET TAGS ('dbx_business_glossary_term' = 'Topic Guide Used');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `translation_required` SET TAGS ('dbx_business_glossary_term' = 'Translation Required');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `verbatim_quotes` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Quotes');
ALTER TABLE `ngo_ecm`.`mel`.`qualitative_record` ALTER COLUMN `verbatim_quotes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` SET TAGS ('dbx_subdomain' = 'data_quality');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `data_collection_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Tool ID');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized Volunteer Role Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `governance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Governance Policy Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Required Training Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|revision_required');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `consent_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Consent Mechanism');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `consent_mechanism` SET TAGS ('dbx_value_regex' = 'verbal|written|digital_signature|none');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `data_collection_method` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Method');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `data_protection_compliance` SET TAGS ('dbx_business_glossary_term' = 'Data Protection Compliance');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `data_protection_compliance` SET TAGS ('dbx_value_regex' = 'gdpr|local_dpa|chs|none|other');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `data_quality_validation_rules` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Validation Rules');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `deployment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment End Date');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `deployment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Start Date');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `estimated_completion_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Time (Minutes)');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `ethical_review_status` SET TAGS ('dbx_business_glossary_term' = 'Ethical Review Status');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `ethical_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|exempt');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `external_tool_url` SET TAGS ('dbx_business_glossary_term' = 'External Tool URL');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `question_count` SET TAGS ('dbx_business_glossary_term' = 'Question Count');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `respondent_type` SET TAGS ('dbx_business_glossary_term' = 'Respondent Type');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `tool_code` SET TAGS ('dbx_business_glossary_term' = 'Tool Code');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `tool_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `tool_documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Tool Documentation URL');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `tool_name` SET TAGS ('dbx_business_glossary_term' = 'Tool Name');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `tool_status` SET TAGS ('dbx_business_glossary_term' = 'Tool Status');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `tool_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|retired|archived');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `tool_type` SET TAGS ('dbx_business_glossary_term' = 'Tool Type');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `tool_type` SET TAGS ('dbx_value_regex' = 'kobo_form|odk_form|commcare_module|dhis2_form|paper_survey|interview_guide');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `ngo_ecm`.`mel`.`data_collection_tool` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` SET TAGS ('dbx_subdomain' = 'data_quality');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `data_quality_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Assessment (DQA) Identifier');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `data_collection_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Data Collection Tool Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Data Collector Volunteer Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `followup_data_quality_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Identifier');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `indicator_result_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Result Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `indicator_target_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Target Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `internal_review_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Review Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `partner_performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Performance Review Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `partner_report_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Report Submission Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Staff Identifier');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Identifier');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `qualitative_record_id` SET TAGS ('dbx_business_glossary_term' = 'Qualitative Record Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `reviewer_staff_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Staff Identifier');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `reviewer_staff_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `reviewer_staff_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `single_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Single Audit Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `accuracy_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Accuracy Score Percentage');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Assessment Code');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `assessment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment End Date');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `assessment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Start Date');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|reviewed|approved|cancelled');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `assessor_organization` SET TAGS ('dbx_business_glossary_term' = 'Assessor Organization');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `completeness_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completeness Score Percentage');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `consistency_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Consistency Score Percentage');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `corrective_action_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completion Date');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|overdue');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `dac_criteria_assessed` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Criteria Assessed');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `data_source_type` SET TAGS ('dbx_business_glossary_term' = 'Data Source Type');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `discrepancy_count` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Count');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `discrepancy_findings` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Findings');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `donor_reporting_requirement` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Requirement');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `donor_reporting_requirement` SET TAGS ('dbx_value_regex' = 'usaid_dqa|global_fund_lfa|dfid_verification|bha_audit|other|none');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `overall_dqa_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overall Data Quality Assessment (DQA) Score Percentage');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `records_verified` SET TAGS ('dbx_business_glossary_term' = 'Records Verified');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Report Uniform Resource Locator (URL)');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `timeliness_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Timeliness Score Percentage');
ALTER TABLE `ngo_ecm`.`mel`.`data_quality_assessment` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `ngo_ecm`.`mel`.`reporting_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `ngo_ecm`.`mel`.`reporting_period` SET TAGS ('dbx_subdomain' = 'data_quality');
ALTER TABLE `ngo_ecm`.`mel`.`reporting_period` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Identifier');
ALTER TABLE `ngo_ecm`.`mel`.`reporting_period` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`reporting_period` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `ngo_ecm`.`mel`.`reporting_period` ALTER COLUMN `primary_prior_reporting_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
