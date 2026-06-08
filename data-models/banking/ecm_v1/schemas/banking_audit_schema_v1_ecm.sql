-- Schema for Domain: audit | Business: Banking | Version: v1_ecm
-- Generated on: 2026-05-02 22:53:25

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `banking_ecm`.`audit` COMMENT 'Internal audit management covering audit planning, audit engagements, audit findings, remediation tracking, continuous monitoring, and regulatory audit coordination. Manages the three lines of defense model and audit committee reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`plan` (
    `plan_id` BIGINT COMMENT 'Unique identifier for the audit plan. Primary key for the audit plan entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the Chief Audit Executive responsible for this audit plan. The CAE has ultimate accountability for plan development and execution.',
    `prior_plan_id` BIGINT COMMENT 'Reference to the previous audit plan that this plan supersedes or follows. Enables year-over-year comparison and continuity tracking.',
    `regulatory_calendar_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_calendar. Business justification: Audit plans must coordinate with regulatory filing deadlines to ensure pre-submission validation. Auditors schedule engagements around critical filings (Call Reports, CCAR, AML certifications) to prov',
    `previous_audit_plan_id` BIGINT COMMENT 'Self-referencing FK on plan (previous_audit_plan_id)',
    `advisory_hours` DECIMAL(18,2) COMMENT 'The number of hours allocated to advisory and consulting services. Represents non-assurance activities where internal audit provides guidance on risk, control, and governance matters.',
    `approval_committee` STRING COMMENT 'The name of the committee or board that approved the audit plan, typically the Audit Committee of the Board of Directors. Documents governance oversight.',
    `assurance_hours` DECIMAL(18,2) COMMENT 'The number of hours allocated to assurance engagements. Represents traditional audit activities that provide independent assessment of risk management, control, and governance processes.',
    `audit_committee_approval_date` DATE COMMENT 'The date when the Audit Committee or Board formally approved this audit plan. Required for governance and independence of the internal audit function.',
    `audit_universe_count` STRING COMMENT 'The total number of auditable entities in the audit universe for this plan. Represents the complete population of business units, processes, systems, and functions that could be audited.',
    `combined_assurance_approach` BOOLEAN COMMENT 'Indicates whether the audit plan incorporates a combined assurance approach that integrates assurance activities across all three lines of defense to optimize coverage and reduce duplication.',
    `contingency_hours` DECIMAL(18,2) COMMENT 'The number of audit hours reserved for unplanned or emerging risk audits. Provides flexibility to respond to unexpected events, regulatory requests, or management concerns during the plan period.',
    `coverage_percentage` DECIMAL(18,2) COMMENT 'The percentage of the audit universe covered by planned audits, calculated as (planned_audit_count / audit_universe_count) * 100. Key metric for assessing adequacy of audit coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit plan record was first created in the system. Supports audit trail and data lineage.',
    `end_date` DATE COMMENT 'The effective end date of the audit plan execution period. Typically aligns with the end of the fiscal year.',
    `external_audit_coordination` BOOLEAN COMMENT 'Indicates whether the audit plan includes coordination with external auditors to leverage their work and avoid duplication of effort.',
    `financial_coverage_percentage` DECIMAL(18,2) COMMENT 'The percentage of planned audit hours allocated to financial and accounting audits. Supports financial statement audit coordination and SOX compliance.',
    `it_coverage_percentage` DECIMAL(18,2) COMMENT 'The percentage of planned audit hours allocated to information technology and cybersecurity audits. Critical for digital banking risk management.',
    `key_risk_themes` STRING COMMENT 'Summary of the primary risk themes driving audit plan prioritization, such as cybersecurity, regulatory change, credit risk, operational resilience, or digital transformation. Communicates risk focus to the Audit Committee.',
    `last_revision_date` DATE COMMENT 'The date when the audit plan was last revised or updated. Material changes to the approved plan require Audit Committee notification or re-approval.',
    `operational_coverage_percentage` DECIMAL(18,2) COMMENT 'The percentage of planned audit hours allocated to operational and process audits. Balances regulatory focus with operational effectiveness and efficiency objectives.',
    `plan_description` STRING COMMENT 'Detailed narrative description of the audit plan scope, objectives, key focus areas, and strategic alignment. Provides context for stakeholders reviewing the plan.',
    `plan_name` STRING COMMENT 'The formal name or title of the audit plan, typically including the year and scope (e.g., FY2024 Enterprise Internal Audit Plan).',
    `plan_status` STRING COMMENT 'Current lifecycle status of the audit plan. Draft indicates initial development, submitted means awaiting approval, approved indicates board/committee endorsement, active means currently in execution, completed means all planned audits finished, superseded means replaced by a newer plan, and cancelled means plan was terminated. [ENUM-REF-CANDIDATE: draft|submitted|approved|active|completed|superseded|cancelled — 7 candidates stripped; promote to reference product]',
    `plan_type` STRING COMMENT 'The type or duration scope of the audit plan. Annual plans cover a single fiscal year, multi-year plans span multiple years, quarterly plans are short-term tactical plans, ad-hoc plans address emerging risks, and continuous plans support ongoing monitoring programs.. Valid values are `annual|multi_year|quarterly|ad_hoc|continuous`',
    `planned_audit_count` STRING COMMENT 'The number of individual audit engagements planned for execution during this plan period. Subset of the audit universe selected based on risk assessment and resource availability.',
    `planning_methodology` STRING COMMENT 'The methodology used to develop the audit plan. Risk-based prioritizes high-risk areas, cyclical ensures periodic coverage of all areas, regulatory-driven focuses on compliance requirements, hybrid combines multiple approaches, continuous monitoring emphasizes real-time assurance, and combined assurance integrates three lines of defense.. Valid values are `risk_based|cyclical|regulatory_driven|hybrid|continuous_monitoring|combined_assurance`',
    `regulatory_coverage_percentage` DECIMAL(18,2) COMMENT 'The percentage of planned audit hours allocated to regulatory and compliance audits. Key metric for demonstrating adequate coverage of regulatory obligations to supervisory authorities.',
    `regulatory_exam_coordination` BOOLEAN COMMENT 'Indicates whether the audit plan considers timing and scope of regulatory examinations to support preparation and follow-up activities.',
    `resource_constraint_notes` STRING COMMENT 'Documentation of any resource constraints or limitations that affected plan development, such as staffing shortages, budget limitations, or skill gaps. Important for managing stakeholder expectations.',
    `risk_assessment_date` DATE COMMENT 'The date when the enterprise risk assessment was completed to inform audit plan prioritization. Critical input for risk-based audit planning.',
    `start_date` DATE COMMENT 'The effective start date of the audit plan execution period. Typically aligns with the beginning of the fiscal year.',
    `strategic_alignment_notes` STRING COMMENT 'Explanation of how the audit plan aligns with the organizations strategic objectives and priorities. Demonstrates value-add of internal audit to enterprise strategy execution.',
    `submitted_date` DATE COMMENT 'The date when the audit plan was formally submitted to the Audit Committee or Board for approval. Tracks governance process timeline.',
    `three_lines_model_alignment` STRING COMMENT 'Indicates whether the audit plan is aligned with the three lines of defense governance model. Aligned means plan coordinates with first line (business) and second line (risk/compliance) activities, partial means some coordination, not aligned means independent planning.. Valid values are `aligned|partial|not_aligned`',
    `total_planned_hours` DECIMAL(18,2) COMMENT 'The total number of audit hours allocated across all engagements in this plan. Used for resource capacity planning and workload management.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit plan record was last updated in the system. Supports audit trail and change tracking.',
    `version` STRING COMMENT 'Version number of the audit plan. Incremented when material changes are made to the approved plan, supporting change control and audit trail.',
    `year` STRING COMMENT 'The fiscal or calendar year for which this audit plan is defined. Represents the primary planning horizon for internal audit activities.',
    CONSTRAINT pk_plan PRIMARY KEY(`plan_id`)
) COMMENT 'Annual and multi-year internal audit plan defining the universe of auditable entities, risk-based prioritization, resource allocation, and coverage strategy approved by the Audit Committee. Captures plan year, planning methodology (risk-based, cyclical, regulatory-driven), total planned audit hours, coverage percentage of audit universe, board/committee approval date, and plan version history. Serves as the master governance document for the internal audit functions annual work program.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`universe` (
    `universe_id` BIGINT COMMENT 'Unique identifier for each auditable entity in the audit universe registry.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Compliance obligations define mandatory audit coverage. Audit universe entities must be mapped to obligations they satisfy (SOX, BSA/AML, CCAR) to determine audit frequency, scope, and methodology. Fu',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Funds are auditable entities in the audit universe for risk-based audit planning. Each fund requires risk assessment, audit frequency determination, and coverage tracking per IIA standards and regulat',
    `geographic_region_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_region. Business justification: Audit universe entities are organized by geographic regions for risk assessment, resource allocation, and regulatory coordination. Fundamental dimension for banking audit planning. Replaces text geogr',
    `industry_code_id` BIGINT COMMENT 'Foreign key linking to reference.industry_code. Business justification: Audit universe includes counterparties and clients classified by industry for concentration risk assessment and industry-specific audit procedures. Required for credit risk audits and regulatory stres',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Audit universe includes issuer-level risk assessments: counterparty credit risk, issuer concentration exposure, rating migration trends, sanctioned entity monitoring. Enterprise risk assessment and au',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Audit universe entities operate under specific regulatory jurisdictions determining applicable audit standards, regulatory requirements, and examination scope. Fundamental dimension for banking audit ',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Audit universe entities are legal entities requiring LEI for regulatory reporting, consolidated audit reporting, and entity identification. Mandatory for banking regulatory compliance and audit docume',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Audit universe includes banking product lines (loans, deposits, derivatives, securities) requiring product-specific risk assessment and audit procedures. Banking audits are fundamentally organized by ',
    `regulatory_change_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_change. Business justification: Regulatory changes trigger risk reassessment of audit universe entities. Audit planning must document which regulatory changes necessitate coverage of specific entities, driving audit frequency, scope',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_taxonomy. Business justification: Audit universe entities must comply with specific regulatory taxonomies (Basel III, IFRS 9, CCAR) determining audit procedures and reporting requirements. Core dimension for banking regulatory audits.',
    `parent_universe_id` BIGINT COMMENT 'Self-referencing FK on universe (parent_universe_id)',
    `aml_bsa_scope_flag` BOOLEAN COMMENT 'Indicator of whether this entity is subject to AML/BSA compliance requirements and monitoring (True/False).',
    `annual_revenue_impact` DECIMAL(18,2) COMMENT 'Estimated annual revenue in USD associated with or generated by this auditable entity, used for risk prioritization.',
    `asset_value` DECIMAL(18,2) COMMENT 'Total asset value in USD under management or control of this auditable entity, relevant for risk assessment.',
    `audit_committee_reporting_flag` BOOLEAN COMMENT 'Indicator of whether audit results for this entity are regularly reported to the Audit Committee of the Board of Directors (True/False).',
    `audit_coverage_status` STRING COMMENT 'Current status of audit coverage for this entity indicating whether it is current, overdue for audit, upcoming, or not yet scheduled.. Valid values are `current|overdue|upcoming|not_scheduled`',
    `audit_frequency_months` STRING COMMENT 'The standard audit cycle frequency in months for this entity based on its risk rating (e.g., 12, 24, 36 months).',
    `ccar_dfast_scope_flag` BOOLEAN COMMENT 'Indicator of whether this entity is within the scope of CCAR or DFAST stress testing and capital planning requirements (True/False).',
    `continuous_monitoring_flag` BOOLEAN COMMENT 'Indicator of whether this entity is subject to continuous audit monitoring through automated controls testing and data analytics (True/False).',
    `control_environment_rating` STRING COMMENT 'Assessment of the overall control environment maturity and effectiveness for this entity (strong, adequate, weak, not assessed).. Valid values are `strong|adequate|weak|not_assessed`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit universe record was first created in the system.',
    `entity_code` STRING COMMENT 'Standardized code or identifier used to reference the auditable entity across audit documentation and systems.',
    `entity_description` STRING COMMENT 'Detailed description of the auditable entity including its scope, purpose, and key characteristics relevant to audit planning.',
    `entity_name` STRING COMMENT 'The official name or title of the auditable entity (business unit, process, system, legal entity, or product line).',
    `entity_status` STRING COMMENT 'Current operational status of the auditable entity within the organization (active, inactive, merged, divested, under review).. Valid values are `active|inactive|merged|divested|under_review`',
    `entity_type` STRING COMMENT 'Classification of the auditable entity indicating whether it is a business process, IT system, legal entity, product line, business unit, or control framework.. Valid values are `process|system|legal_entity|product_line|business_unit|control`',
    `external_audit_coordination_flag` BOOLEAN COMMENT 'Indicator of whether internal audit activities for this entity are coordinated with external auditors to ensure coverage and avoid duplication (True/False).',
    `high_priority_findings_count` STRING COMMENT 'The current number of high-priority or critical audit findings associated with this entity requiring immediate management attention.',
    `inherent_risk_score` DECIMAL(18,2) COMMENT 'Quantitative assessment of the inherent risk level of the auditable entity before considering controls, typically on a scale of 0-100.',
    `key_risk_indicators` STRING COMMENT 'List or description of key risk indicators monitored for this auditable entity to support continuous monitoring and early warning.',
    `last_audit_date` DATE COMMENT 'The date when the most recent internal audit of this entity was completed.',
    `last_audit_rating` STRING COMMENT 'The overall audit rating or opinion issued in the most recent audit (satisfactory, needs improvement, unsatisfactory, not rated).. Valid values are `satisfactory|needs_improvement|unsatisfactory|not_rated`',
    `last_audit_type` STRING COMMENT 'The type or scope of the most recent audit conducted (comprehensive, focused, follow-up, advisory, continuous monitoring).. Valid values are `comprehensive|focused|follow_up|advisory|continuous`',
    `last_risk_assessment_date` DATE COMMENT 'The date when the most recent risk assessment was performed for this auditable entity.',
    `lob` STRING COMMENT 'The primary line of business associated with the auditable entity (e.g., Retail Banking, Investment Banking, Wealth Management, Treasury).',
    `materiality_threshold_amount` DECIMAL(18,2) COMMENT 'The financial materiality threshold in USD used to assess the significance of findings and risks for this auditable entity.',
    `next_risk_assessment_date` DATE COMMENT 'The scheduled date for the next risk assessment of this auditable entity.',
    `next_scheduled_audit_date` DATE COMMENT 'The planned date for the next scheduled audit of this entity based on the risk-based audit plan.',
    `open_findings_count` STRING COMMENT 'The current number of open audit findings or issues associated with this auditable entity that are pending remediation.',
    `overdue_findings_count` STRING COMMENT 'The current number of audit findings for this entity where the agreed remediation date has passed without closure.',
    `owning_division` STRING COMMENT 'The business division, department, or organizational unit that owns and is accountable for the auditable entity.',
    `regulatory_relevance_flag` BOOLEAN COMMENT 'Indicator of whether the auditable entity is subject to specific regulatory oversight or compliance requirements (True/False).',
    `residual_risk_score` DECIMAL(18,2) COMMENT 'Quantitative assessment of the residual risk level after considering the effectiveness of existing controls, typically on a scale of 0-100.',
    `risk_rating` STRING COMMENT 'Categorical risk rating assigned to the auditable entity based on inherent and residual risk assessments (critical, high, medium, low, minimal).. Valid values are `critical|high|medium|low|minimal`',
    `rwa_allocation` DECIMAL(18,2) COMMENT 'The amount of risk-weighted assets in USD allocated to this auditable entity under Basel III capital adequacy framework.',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicator of whether this entity is within the scope of SOX Section 404 internal control over financial reporting requirements (True/False).',
    `three_lines_position` STRING COMMENT 'Classification of the entity within the three lines of defense model (first line operations, second line risk/compliance, third line internal audit, or not applicable).. Valid values are `first_line|second_line|third_line|not_applicable`',
    `updated_by` STRING COMMENT 'The user ID or system identifier of the person or process that last updated this audit universe record.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit universe record was last modified or updated.',
    CONSTRAINT pk_universe PRIMARY KEY(`universe_id`)
) COMMENT 'Comprehensive registry of all auditable entities within the bank — business units, processes, legal entities, systems, and regulatory obligations that are subject to internal audit coverage. Captures auditable entity name, entity type (process, system, legal entity, product line), risk rating, last audit date, next scheduled audit date, inherent risk score, residual risk score, regulatory relevance flag, and owning business division. Forms the foundation for risk-based audit planning and coverage gap analysis.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`engagement` (
    `engagement_id` BIGINT COMMENT 'Unique identifier for the internal audit engagement. Primary key for the engagement record.',
    `alco_meeting_id` BIGINT COMMENT 'Foreign key linking to treasury.alco_meeting. Business justification: Audit engagements are triggered by ALCO resolutions (e.g., FTP methodology review, hedge effectiveness audit). Auditors reference the specific ALCO meeting that mandated the engagement.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to risk.risk_assessment. Business justification: Audit engagements frequently scope and test risk assessments performed by first/second lines. Links engagement to the specific risk assessment under audit review, supporting audit planning and workpap',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Audit engagements examine specific customers/legal entities for AML, KYC, credit risk, or operational reviews. Tracks which customer is the subject of the audit for regulatory reporting, risk assessme',
    `capital_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.capital_plan. Business justification: Capital planning (CCAR/DFAST) is a mandatory audit area. Audit engagements directly audit specific capital plan submissions for methodology, assumptions, stress testing, and regulatory compliance.',
    `capital_ratio_id` BIGINT COMMENT 'Foreign key linking to treasury.capital_ratio. Business justification: Capital ratio calculation, RWA methodology, and regulatory reporting are mandatory audit subjects. Engagements audit specific ratio calculation periods for Basel III compliance and regulatory submissi',
    `cash_flow_forecast_id` BIGINT COMMENT 'Foreign key linking to treasury.cash_flow_forecast. Business justification: Cash flow forecasting models, assumptions, and CCAR/DFAST projections are audit engagement subjects. Auditors audit specific forecast versions for model risk, assumption reasonableness, and regulatory',
    `consent_order_id` BIGINT COMMENT 'Foreign key linking to compliance.consent_order. Business justification: Consent orders mandate specific audit engagements with defined scope and timelines. Auditors must track which engagements satisfy consent order requirements for regulatory reporting and board oversigh',
    `contingency_funding_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.contingency_funding_plan. Business justification: Contingency funding plan adequacy, testing, and governance are regulatory audit requirements. Engagements audit specific CFP versions for liquidity stress preparedness and regulatory compliance (Basel',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Audit engagements often focus on specific deposit accounts for operational, compliance, or fraud investigations. Enables traceability from audit findings back to specific accounts examined, required f',
    `employee_id` BIGINT COMMENT 'Identifier of the user or auditor who created the engagement record in the audit management system.',
    `engagement_employee_id` BIGINT COMMENT 'Identifier of the senior auditor responsible for leading the engagement, supervising the audit team, and signing off on the audit report. Links to the auditor or employee master.',
    `engagement_manager_employee_id` BIGINT COMMENT 'Identifier of the audit manager or director overseeing the engagement, responsible for quality review and stakeholder communication. Links to the auditor or employee master.',
    `engagement_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the user or auditor who last modified the engagement record, used for accountability and audit trail purposes.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: Audit engagements often scope to specific credit facilities (e.g., syndicated loan audits, revolving credit line reviews). Auditors test facility-level controls, covenant compliance, and utilization. ',
    `fund_administrator_id` BIGINT COMMENT 'Foreign key linking to asset.fund_administrator. Business justification: Third-party administrator audits review SOC reports, operational controls, NAV calculation procedures, SLA compliance. Required for outsourcing risk management and regulatory expectations (OCC Bulleti',
    `fund_audit_id` BIGINT COMMENT 'Foreign key linking to asset.fund_audit. Business justification: Fund_audit records document external auditor engagements (financial statement audits, SOC reports). Internal audit engagement must reference external audit for coordination, reliance decisions, and co',
    `fund_id` BIGINT COMMENT 'Foreign key linking to asset.fund. Business justification: Fund audits are core banking audit activity covering NAV calculation, expense allocation, performance reporting, regulatory compliance (40 Act, UCITS). Every fund audit engagement must reference the a',
    `fund_lifecycle_event_id` BIGINT COMMENT 'Foreign key linking to asset.fund_lifecycle_event. Business justification: Lifecycle event audits (fund mergers, liquidations, reorganizations) verify board approval, shareholder notification, NAV calculation accuracy, tax treatment. Required for 40 Act compliance and fiduci',
    `fund_mandate_id` BIGINT COMMENT 'Foreign key linking to asset.fund_mandate. Business justification: Mandate compliance audits verify adherence to investment restrictions, benchmark tracking, ESG constraints per IMA/prospectus. Required for fiduciary oversight and regulatory examinations (SEC Rule 38',
    `fund_performance_id` BIGINT COMMENT 'Foreign key linking to asset.fund_performance. Business justification: Performance calculation audits verify GIPS compliance, benchmark selection appropriateness, fee impact disclosure accuracy. Required for prospectus accuracy (SEC advertising rules) and investor protec',
    `fund_regulatory_report_id` BIGINT COMMENT 'Foreign key linking to asset.fund_regulatory_report. Business justification: Regulatory report audits (Form N-PORT liquidity classifications, N-CEN operational data) are mandated pre-filing reviews. Links engagement to specific report filing for audit trail, deficiency trackin',
    `funding_plan_id` BIGINT COMMENT 'Foreign key linking to treasury.funding_plan. Business justification: Funding plan execution, ALCO limit compliance, and issuance governance are audit engagement subjects. Auditors audit specific funding plan versions for adherence to approved strategy and risk limits.',
    `geographic_region_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_region. Business justification: Engagements cover specific geographic regions determining resource allocation, travel requirements, and regional regulatory coordination. Required for banking audit planning and execution.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Audit engagements frequently examine specific securities for valuation accuracy, classification compliance, IFRS 9 staging, FRTB capital adequacy, and trading book reviews. Banking auditors routinely ',
    `interest_rate_risk_position_id` BIGINT COMMENT 'Foreign key linking to treasury.interest_rate_risk_position. Business justification: Interest rate risk measurement, EVE/NII sensitivity, and limit compliance are audit engagement subjects. Auditors audit specific IRR position snapshots for model validation and ALCO limit adherence.',
    `investor_account_id` BIGINT COMMENT 'Foreign key linking to asset.investor_account. Business justification: Investor account audits cover AML/KYC compliance, suitability reviews, FATCA/CRS reporting accuracy. Regulatory exams (FinCEN, SEC) require account-level audit trails. Distinct from fund-level audits.',
    `irb_model_id` BIGINT COMMENT 'Foreign key linking to risk.irb_model. Business justification: Model validation audits target specific IRB models for regulatory capital. Links engagement to the model under audit, supporting model risk management, validation tracking, and regulatory approval pro',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Audits examine issuer credit quality, exposure concentration, issuer monitoring controls, and counterparty risk management. Issuer-focused audits (e.g., single-name concentration, sovereign exposure) ',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Engagements must comply with jurisdiction-specific audit requirements, regulatory frameworks, and reporting standards. Critical for regulatory audit planning and determining applicable audit procedure',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Audit engagements are scoped to specific legal entities for regulatory reporting, audit planning, and risk assessment. Legal entity is fundamental dimension for audit scoping in banking operations.',
    `lei_registry_id` BIGINT COMMENT 'Foreign key linking to reference.lei_registry. Business justification: Engagements audit specific legal entities identified by LEI. Essential for consolidated audit reporting, regulatory filings, and legal entity governance in banking operations.',
    `liquidity_ratio_id` BIGINT COMMENT 'Foreign key linking to treasury.liquidity_ratio. Business justification: LCR/NSFR calculation methodology, data quality, and regulatory reporting are mandatory audit subjects. Engagements audit specific ratio calculation periods for Basel III compliance and regulatory subm',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Audit engagements establish materiality thresholds denominated in specific currencies. Essential for international banking audits where materiality must be assessed in local or reporting currency. Sta',
    `plan_id` BIGINT COMMENT 'Identifier of the annual or multi-year audit plan under which this engagement was scheduled and approved. Links to the strategic audit planning cycle.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Policy compliance testing is a primary audit objective. Engagements must reference specific policies being tested for scope definition, workpaper organization, and audit reporting. Essential for polic',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_taxonomy. Business justification: Engagements validate compliance with regulatory taxonomies (Basel, IFRS, Dodd-Frank). Core objective of regulatory audits in banking. Links engagement to specific regulatory framework being assessed.',
    `transfer_pricing_curve_id` BIGINT COMMENT 'Foreign key linking to treasury.transfer_pricing_curve. Business justification: FTP curve methodology, rate-setting governance, and ALCO approval are common audit engagement subjects. Auditors directly audit specific curve versions for model validation and governance compliance.',
    `universe_id` BIGINT COMMENT 'Identifier of the business unit, process, system, or legal entity that is the subject of this audit engagement. Links to the audit universe of auditable entities.',
    `previous_audit_engagement_id` BIGINT COMMENT 'Self-referencing FK on engagement (previous_audit_engagement_id)',
    `actual_end_date` DATE COMMENT 'Actual date when the audit engagement was completed and the final report was issued, used for tracking schedule adherence and cycle time metrics.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Total number of audit hours actually expended on the engagement, used for variance analysis and future planning accuracy.',
    `actual_start_date` DATE COMMENT 'Actual date when fieldwork or engagement execution commenced, used for tracking schedule adherence and resource utilization.',
    `audit_committee_presentation_date` DATE COMMENT 'Date when the engagement results were presented to the audit committee of the board of directors.',
    `audit_objectives` STRING COMMENT 'Specific objectives and goals of the audit engagement, articulating what the audit intends to evaluate, assess, or provide assurance on.',
    `audit_opinion` STRING COMMENT 'Overall audit opinion or rating issued by the internal audit function on the adequacy and effectiveness of controls, governance, and risk management in the audited area. Satisfactory indicates effective controls; needs improvement indicates control gaps requiring management attention; unsatisfactory indicates significant control deficiencies; no opinion indicates advisory or limited-scope engagements.. Valid values are `satisfactory|needs_improvement|unsatisfactory|no_opinion`',
    `audit_period_end_date` DATE COMMENT 'End date of the business period or timeframe being audited (the period under review), distinct from the engagement execution dates.',
    `audit_period_start_date` DATE COMMENT 'Start date of the business period or timeframe being audited (the period under review), distinct from the engagement execution dates.',
    `continuous_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this engagement is part of a continuous monitoring program with ongoing automated testing and exception reporting (True) or is a traditional point-in-time audit (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the engagement record was first created in the audit management system.',
    `data_analytics_used_flag` BOOLEAN COMMENT 'Indicates whether advanced data analytics, machine learning, or automated testing tools were employed during the engagement (True) or traditional manual audit procedures were used (False).',
    `engagement_number` STRING COMMENT 'Business-facing unique identifier or reference number for the audit engagement, used in audit committee reporting and external communication.. Valid values are `^[A-Z0-9]{6,20}$`',
    `engagement_status` STRING COMMENT 'Current lifecycle status of the audit engagement: planning (scoping and preparation), fieldwork (evidence gathering and testing), reporting (draft and final report preparation), management response (awaiting or reviewing management action plans), closed (engagement complete), or cancelled (engagement terminated before completion).. Valid values are `planning|fieldwork|reporting|management_response|closed|cancelled`',
    `engagement_type` STRING COMMENT 'Classification of the audit engagement by its primary purpose: assurance (independent evaluation), advisory (consulting), regulatory (mandated review), SOX compliance (Sarbanes-Oxley Act internal controls), IT audit (technology systems and controls), or AML/BSA review (Anti-Money Laundering/Bank Secrecy Act compliance).. Valid values are `assurance|advisory|regulatory|sox_compliance|it_audit|aml_bsa_review`',
    `external_auditor_coordination_flag` BOOLEAN COMMENT 'Indicates whether the engagement was coordinated with or relied upon by external auditors for financial statement audit purposes (True) or was independent of external audit (False).',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up audit procedures to verify implementation of management action plans and closure of findings.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether the engagement requires formal follow-up audit procedures to validate that management has implemented agreed-upon action plans (True) or no follow-up is needed (False).',
    `inherent_risk_rating` STRING COMMENT 'Risk rating of the auditable entity or process before considering the effectiveness of controls, based on factors such as financial materiality, regulatory exposure, complexity, and change activity.. Valid values are `low|moderate|high|critical`',
    `management_response_due_date` DATE COMMENT 'Date by which management is required to provide formal responses and action plans to address audit findings.',
    `management_response_received_date` DATE COMMENT 'Actual date when management submitted their formal responses and remediation action plans to the audit findings.',
    `overall_risk_rating` STRING COMMENT 'Aggregate risk rating assigned to the engagement based on the severity and number of findings, the inherent risk of the audited area, and the residual risk after considering management action plans.. Valid values are `low|moderate|high|critical`',
    `planned_end_date` DATE COMMENT 'Scheduled completion date for the audit engagement execution as defined in the audit plan or engagement letter.',
    `planned_hours` DECIMAL(18,2) COMMENT 'Total number of audit hours budgeted for the engagement, used for resource planning and capacity management.',
    `planned_start_date` DATE COMMENT 'Scheduled start date for the audit engagement execution as defined in the audit plan or engagement letter.',
    `priority` STRING COMMENT 'Priority level assigned to the engagement based on risk assessment, regulatory requirements, and strategic importance, used for resource allocation and scheduling decisions.. Valid values are `critical|high|medium|low`',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority or governing body that mandated or oversees the engagement, if applicable (e.g., Federal Reserve, OCC, SEC, FINRA).',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether the engagement is mandated by a regulatory requirement, consent order, or supervisory agreement (True) or is discretionary based on risk assessment (False).',
    `report_distribution_list` STRING COMMENT 'List of stakeholders, executives, and audit committee members to whom the audit report was distributed, typically stored as a delimited list or reference to a distribution group.',
    `report_issue_date` DATE COMMENT 'Date when the final audit report was formally issued to management and the audit committee.',
    `residual_risk_rating` STRING COMMENT 'Risk rating after considering the design and operating effectiveness of controls and management action plans to remediate identified findings.. Valid values are `low|moderate|high|critical`',
    `scope_statement` STRING COMMENT 'Detailed description of the audit scope, including the processes, controls, systems, locations, and time periods covered by the engagement. Defines boundaries and exclusions.',
    `sox_section` STRING COMMENT 'Specific section of the Sarbanes-Oxley Act that this engagement addresses, if the engagement is SOX-related (e.g., Section 302, Section 404, Section 906).',
    `three_lines_of_defense_line` STRING COMMENT 'Classification of the engagement within the three lines of defense model: first line (operational management and controls), second line (risk management and compliance oversight), or third line (internal audit providing independent assurance).. Valid values are `first_line|second_line|third_line`',
    `title` STRING COMMENT 'Descriptive title of the audit engagement that clearly identifies the subject matter and scope of the audit project.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the engagement record was last modified, used for audit trail and change tracking.',
    CONSTRAINT pk_engagement PRIMARY KEY(`engagement_id`)
) COMMENT 'Core master record for each individual internal audit engagement (audit project) executed against an auditable entity. Captures engagement title, engagement type (assurance, advisory, regulatory, SOX, IT audit, AML/BSA review), scope statement, audit period covered, planned start and end dates, actual start and end dates, engagement status (planning, fieldwork, reporting, closed), lead auditor, engagement manager, audit opinion (satisfactory, needs improvement, unsatisfactory), and overall risk rating. The primary operational unit of the internal audit function.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`engagement_scope` (
    `engagement_scope_id` BIGINT COMMENT 'Unique identifier for the audit engagement scope record.',
    `engagement_id` BIGINT COMMENT 'Reference to the parent audit engagement for which this scope is defined.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Cost center audits assess operational efficiency, budget compliance, and control effectiveness. Cost center scoping enables targeted audit procedures for organizational units.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Scope items specify country coverage determining regulatory requirements, audit procedures, and local compliance. Fundamental geographic dimension for banking audits. Replaces text country_code.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO currency code for the materiality threshold (e.g., USD, EUR, GBP).',
    `geographic_region_id` BIGINT COMMENT 'Foreign key linking to reference.geographic_region. Business justification: Scope items specify geographic coverage for audit testing. Standard audit scoping practice in banking. Replaces text geographic_region field with proper reference.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Auditors scope specific GL accounts for substantive testing, control testing, and account reconciliation validation. Account-level scoping is standard audit practice in financial statement audits.',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Audit scope definitions include specific instruments or instrument portfolios for targeted testing (e.g., high-risk derivatives, illiquid securities, new product types). Enables precise scope document',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Engagement scope items target specific legal entities for audit coverage tracking, regulatory coordination, and entity-level risk assessment. Replaces denormalized legal_entity_name with proper FK.',
    `product_type_id` BIGINT COMMENT 'Foreign key linking to reference.product_type. Business justification: Engagement scope specifies which banking products are covered (retail lending, investment banking, treasury). Standard audit scoping dimension. Replaces denormalized product_name with proper reference',
    `previous_engagement_scope_id` BIGINT COMMENT 'Self-referencing FK on engagement_scope (previous_engagement_scope_id)',
    `audit_committee_reported_flag` BOOLEAN COMMENT 'Indicates whether this scope item was specifically reported to the Audit Committee as part of engagement planning or scope changes (True if reported, False otherwise).',
    `continuous_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this scope item is subject to continuous monitoring controls in addition to periodic audit testing (True if continuously monitored, False otherwise).',
    `control_framework` STRING COMMENT 'The control framework or standard against which this scope item will be audited (e.g., COSO, SOX, Basel III, GDPR).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this engagement scope record was first created in the system.',
    `inclusion_flag` BOOLEAN COMMENT 'Indicates whether this scope item is included (True) or explicitly excluded (False) from the audit engagement.',
    `lob` STRING COMMENT 'The line of business to which this scope item belongs (e.g., Retail Banking, Investment Banking, Wealth Management, Treasury).',
    `materiality_threshold` DECIMAL(18,2) COMMENT 'The monetary materiality threshold applied to this scope item for determining audit significance and testing depth.',
    `modified_by` STRING COMMENT 'The identifier or name of the user who last modified this engagement scope record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this engagement scope record was last modified.',
    `process_name` STRING COMMENT 'The name of the business process included in or excluded from the audit scope (e.g., Loan Origination, Trade Settlement, AML Transaction Monitoring).',
    `regulatory_driver` STRING COMMENT 'The specific regulatory requirement, examination request, or compliance mandate that necessitated inclusion of this scope item (e.g., Federal Reserve, OCC, SEC, FINRA requirement).',
    `regulatory_examination_flag` BOOLEAN COMMENT 'Indicates whether this scope item was included in response to a regulatory examination request or finding (True if regulatory-driven, False otherwise).',
    `risk_justification` STRING COMMENT 'Risk-based rationale for the scope decision, linking to the risk assessment that drove inclusion or exclusion of this item.',
    `risk_rating` STRING COMMENT 'The assessed risk level of the scope item that influenced its inclusion or exclusion from the audit.. Valid values are `critical|high|medium|low|minimal`',
    `sample_size` STRING COMMENT 'The planned number of items or transactions to be tested for this scope item during the audit engagement.',
    `sampling_approach` STRING COMMENT 'The sampling methodology to be applied to this scope item during audit testing (statistical, judgmental, full population review, or risk-based).. Valid values are `statistical|judgmental|full_population|risk_based`',
    `scope_change_approved_by` STRING COMMENT 'The name or identifier of the person who approved the scope change (e.g., Chief Audit Executive, Audit Committee Chair).',
    `scope_change_date` DATE COMMENT 'The date on which this scope item was added, modified, or removed from the engagement scope.',
    `scope_change_flag` BOOLEAN COMMENT 'Indicates whether this scope item was added, modified, or removed after the initial scope definition (True if changed, False if original).',
    `scope_change_reason` STRING COMMENT 'The business or regulatory reason for changing the scope after initial definition (e.g., new risk identified, regulatory request, resource constraint).',
    `scope_item_code` STRING COMMENT 'The standardized code or identifier for the scope item as used in operational systems (e.g., GL account code, system ID, country code).',
    `scope_item_name` STRING COMMENT 'The name or identifier of the specific process, system, geography, product, legal entity, or business unit included in or excluded from the audit scope.',
    `scope_item_type` STRING COMMENT 'The category of scope item being defined (process, system, geography, product, legal entity, or business unit).. Valid values are `process|system|geography|product|legal_entity|business_unit`',
    `scope_notes` STRING COMMENT 'Additional notes, clarifications, or context regarding this scope item that support audit quality and regulatory examination responses.',
    `scope_period_end_date` DATE COMMENT 'The ending date of the time period covered by this scope item for the audit engagement.',
    `scope_period_start_date` DATE COMMENT 'The beginning date of the time period covered by this scope item for the audit engagement.',
    `scope_rationale` STRING COMMENT 'Business justification for including or excluding this item from the audit scope, documenting the decision-making process.',
    `scope_status` STRING COMMENT 'The current lifecycle status of this scope item within the audit engagement (draft, approved, in progress, completed, or superseded).. Valid values are `draft|approved|in_progress|completed|superseded`',
    `system_name` STRING COMMENT 'The name of the operational system or application included in or excluded from the audit scope (e.g., Temenos T24, Murex, SAS Risk Management).',
    `three_lines_of_defense_level` STRING COMMENT 'The line of defense level to which this scope item belongs in the three lines of defense model (first line operations, second line risk/compliance, third line internal audit).. Valid values are `first_line|second_line|third_line`',
    `created_by` STRING COMMENT 'The identifier or name of the user who created this engagement scope record.',
    CONSTRAINT pk_engagement_scope PRIMARY KEY(`engagement_scope_id`)
) COMMENT 'Detailed scope definition record for an audit engagement, capturing the specific processes, systems, legal entities, geographies, and time periods included in or excluded from the audit. Captures scope item type (process, system, geography, product), inclusion/exclusion flag, scope rationale, risk justification, regulatory driver, and scope change history. Enables precise documentation of what was and was not examined during an engagement, supporting audit quality and regulatory examination responses.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`program` (
    `program_id` BIGINT COMMENT 'Unique identifier for the audit program. Primary key for the audit program entity.',
    `engagement_id` BIGINT COMMENT 'Reference to the parent audit engagement that this program supports. Links the detailed test program to the broader audit engagement scope.',
    `compliance_sox_control_id` BIGINT COMMENT 'Foreign key linking to compliance.sox_control. Business justification: Audit programs test specific SOX controls for design and operating effectiveness. This is the fundamental link between control documentation (compliance) and control testing (audit), required for SOX ',
    `employee_id` BIGINT COMMENT 'Reference to the audit manager or director who approved this audit program for execution. Establishes accountability for program design.',
    `program_employee_id` BIGINT COMMENT 'Reference to the staff member assigned as lead auditor responsible for executing this audit program and coordinating fieldwork.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the senior auditor or manager assigned to review the work performed under this audit program for quality assurance.',
    `previous_audit_program_id` BIGINT COMMENT 'Self-referencing FK on program (previous_audit_program_id)',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual number of audit hours spent executing this program. Compared against estimated hours for variance analysis and future planning.',
    `approval_date` DATE COMMENT 'Date when the audit program was formally approved by the audit manager or director for execution. Marks transition from planning to fieldwork phase.',
    `audit_committee_reporting_flag` BOOLEAN COMMENT 'Indicates whether results from this audit program will be reported to the Audit Committee of the Board of Directors. True for high-risk or material programs.',
    `automated_control_flag` BOOLEAN COMMENT 'Indicates whether this audit program tests automated controls (system-enforced controls). True if program includes testing of IT general controls or application controls.',
    `completion_date` DATE COMMENT 'Date when all testing procedures in this audit program were completed and documented. Marks the end of fieldwork phase.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of audit program steps completed (0.00 to 100.00). Calculated as (completed steps / total steps) * 100. Used for progress tracking and reporting.',
    `control_objective` STRING COMMENT 'High-level control objective that the audit program is designed to test (e.g., Ensure all loan disbursements are properly authorized and recorded). Aligns with COSO framework control objectives.',
    `coso_component` STRING COMMENT 'COSO Internal Control Framework component addressed by this program: control_environment (tone at the top), risk_assessment (risk identification), control_activities (policies and procedures), information_communication (data flow), or monitoring (ongoing evaluation).. Valid values are `control_environment|risk_assessment|control_activities|information_communication|monitoring`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit program record was first created in the system. Supports audit trail and data lineage.',
    `data_analytics_flag` BOOLEAN COMMENT 'Indicates whether this audit program employs data analytics techniques (e.g., full population testing, trend analysis, anomaly detection). True if program uses advanced analytical methods.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Planned number of audit hours required to complete this program. Used for resource planning and budget tracking.',
    `expected_evidence_type` STRING COMMENT 'Description of the evidence expected to be collected during program execution (e.g., signed approval forms, system reports, reconciliation worksheets, email confirmations). Guides auditor documentation requirements.',
    `external_auditor_reliance_flag` BOOLEAN COMMENT 'Indicates whether external auditors plan to rely on the work performed under this audit program for their financial statement audit. True if program meets external audit standards.',
    `findings_count` STRING COMMENT 'Number of audit findings (control deficiencies, exceptions, observations) identified during execution of this audit program. Updated as testing progresses.',
    `high_risk_findings_count` STRING COMMENT 'Number of high-risk or material findings identified during execution of this audit program. Subset of total findings requiring immediate management attention.',
    `key_control_flag` BOOLEAN COMMENT 'Indicates whether this audit program tests key controls (controls that are critical to mitigating significant risks). True if program focuses on key controls per risk assessment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit program record was last updated. Tracks the most recent change to any field in the record.',
    `notes` STRING COMMENT 'Free-text field for auditor notes, observations, or special instructions related to this audit program. Captures contextual information not covered by structured fields.',
    `population_size` STRING COMMENT 'Total number of items or transactions in the population from which the sample is drawn. Used to calculate sampling risk and extrapolate findings.',
    `program_code` STRING COMMENT 'Standardized code for the audit program following organizational taxonomy (e.g., CR-2024, TRS-1001). Used for tracking and reporting.. Valid values are `^[A-Z]{2,4}-[0-9]{4}$`',
    `program_name` STRING COMMENT 'Descriptive name of the audit program identifying the area or process being tested (e.g., Loan Origination Controls Testing, Treasury Operations Review).',
    `program_status` STRING COMMENT 'Current lifecycle status of the audit program: draft (under development), approved (ready for execution), in_progress (fieldwork underway), completed (testing finished), on_hold (temporarily suspended), or cancelled (discontinued).. Valid values are `draft|approved|in_progress|completed|on_hold|cancelled`',
    `program_type` STRING COMMENT 'Classification of the audit program by focus area: operational (process efficiency), financial (accounting controls), compliance (regulatory adherence), IT (technology controls), fraud (investigative), or regulatory (external examination support).. Valid values are `operational|financial|compliance|IT|fraud|regulatory`',
    `regulatory_framework` STRING COMMENT 'Applicable regulatory framework or standard that this audit program addresses (e.g., SOX Section 404, Basel III Pillar 1, CCAR, DFAST, CECL, IFRS 9). Multiple frameworks may be listed comma-separated.',
    `risk_area` STRING COMMENT 'Primary risk category addressed by this audit program per Basel III risk taxonomy: credit risk, market risk, operational risk, liquidity risk, compliance risk, or reputational risk.. Valid values are `credit|market|operational|liquidity|compliance|reputational`',
    `sample_size` STRING COMMENT 'Number of items or transactions selected for testing in this audit program. Determined based on risk assessment, population size, and desired confidence level.',
    `sampling_method` STRING COMMENT 'Sampling approach used for test selection: judgmental (risk-based selection), statistical (probability-based), random (unbiased selection), stratified (segmented population), monetary_unit (dollar-weighted), or full_population (100% testing).. Valid values are `judgmental|statistical|random|stratified|monetary_unit|full_population`',
    `scope_description` STRING COMMENT 'Detailed description of the audit program scope including processes, systems, business units, and time periods covered. Defines boundaries of the testing effort.',
    `sox_relevant_flag` BOOLEAN COMMENT 'Indicates whether this audit program supports SOX Section 404 internal control testing over financial reporting. True if program tests key controls for SOX compliance.',
    `start_date` DATE COMMENT 'Date when fieldwork execution of this audit program began. Marks the commencement of testing activities.',
    `test_approach` STRING COMMENT 'Primary testing methodology employed in this program: walkthrough (process understanding), substantive (transaction testing), controls_testing (design and operating effectiveness), data_analytics (population analysis), inquiry (interviews), observation (process witnessing), inspection (document review), or reperformance (independent execution). [ENUM-REF-CANDIDATE: walkthrough|substantive|controls_testing|data_analytics|inquiry|observation|inspection|reperformance — 8 candidates stripped; promote to reference product]',
    `test_period_end_date` DATE COMMENT 'Ending date of the period covered by this audit program testing (e.g., 2024-12-31). Defines the temporal scope of audit procedures.',
    `test_period_start_date` DATE COMMENT 'Beginning date of the period covered by this audit program testing (e.g., 2024-01-01). Defines the temporal scope of audit procedures.',
    `three_lines_model_line` STRING COMMENT 'Identifies which line of defense this audit program evaluates per the IIA Three Lines Model: first_line (operational management), second_line (risk and compliance oversight), or third_line (internal audit).. Valid values are `first_line|second_line|third_line`',
    `version` STRING COMMENT 'Version number of the audit program template or instance (e.g., 1.0, 2.3). Tracks revisions and updates to the program over time.. Valid values are `^[0-9]+.[0-9]+$`',
    `workpaper_reference` STRING COMMENT 'Reference code or identifier linking this audit program to the corresponding audit workpapers and documentation repository (e.g., WP-CR-2024-001). Supports audit trail and evidence management.',
    CONSTRAINT pk_program PRIMARY KEY(`program_id`)
) COMMENT 'Detailed audit test program and work plan for an engagement, defining the specific audit procedures, test steps, control objectives, and testing methodologies to be executed. Captures program step sequence, control objective, test procedure description, test type (walkthrough, substantive, controls testing, data analytics), expected evidence, assigned auditor, estimated hours, and completion status. Serves as the operational blueprint for fieldwork execution and quality assurance review.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`workpaper` (
    `workpaper_id` BIGINT COMMENT 'Unique identifier for the audit workpaper record. Primary key for the workpaper entity.',
    `account_transaction_id` BIGINT COMMENT 'Foreign key linking to account.account_transaction. Business justification: Transaction testing is core audit procedure. Workpapers document sample transactions tested for accuracy, authorization, AML screening, and regulatory compliance. Links workpaper to specific transacti',
    `alm_hedge_id` BIGINT COMMENT 'Foreign key linking to treasury.alm_hedge. Business justification: Auditors test hedge designation, effectiveness testing, and hedge accounting treatment. Workpapers reference specific hedge records as audit evidence for ASC 815 compliance and ALM strategy execution.',
    `assessment_id` BIGINT COMMENT 'Reference to the risk that this workpaper addresses. Links audit evidence to the risk universe and risk assessment.',
    `engagement_id` BIGINT COMMENT 'Reference to the parent audit engagement under which this workpaper was created. Links workpaper to the broader audit project.',
    `program_step_id` BIGINT COMMENT 'Reference to the specific audit program step that this workpaper documents. Links workpaper to the planned audit procedure.',
    `business_process_id` BIGINT COMMENT 'Reference to the business process under audit that this workpaper documents. Links workpaper to the process hierarchy.',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.trade_capture. Business justification: Workpapers reference specific trades tested for booking accuracy, valuation methodology, and regulatory reporting. Links workpaper to tested trade for SOX testing evidence and valuation audit trail.',
    `compliance_sox_control_id` BIGINT COMMENT 'Reference to the specific internal control being tested or evaluated in this workpaper. Applicable for control walkthrough and test of controls workpapers.',
    `corporate_action_id` BIGINT COMMENT 'Foreign key linking to security.corporate_action. Business justification: Workpapers document corporate action processing testing: entitlement calculation accuracy, payment timeliness, event capture completeness, mandatory vs. voluntary treatment. Audit evidence trail requi',
    `counterparty_rating_id` BIGINT COMMENT 'Foreign key linking to risk.counterparty_rating. Business justification: Audit workpapers testing credit risk controls reference specific counterparty ratings as evidence. Links workpaper to rating for audit trail, supporting credit risk governance, rating model validation',
    `currency_id` BIGINT COMMENT 'Foreign key linking to reference.currency. Business justification: Workpapers document testing of currency-denominated transactions, balances, and exposures. Core audit evidence in banking requires proper currency reference for foreign exchange and multi-currency tes',
    `debt_issuance_id` BIGINT COMMENT 'Foreign key linking to treasury.debt_issuance. Business justification: Auditors test debt issuance authorization, pricing, use of proceeds, and accounting treatment. Workpapers reference specific issuance records as transaction-level audit evidence for funding and capita',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Balance confirmation testing is standard audit procedure for deposit accounts. Workpapers document accounts selected for confirmation, responses received, and reconciliation. Essential for financial s',
    `direct_debit_mandate_id` BIGINT COMMENT 'Foreign key linking to account.direct_debit_mandate. Business justification: Direct debit mandate testing validates customer authorization, signature verification, and regulatory compliance (NACHA rules, Reg E). Workpapers link to specific mandates tested, essential for operat',
    `execution_id` BIGINT COMMENT 'Foreign key linking to trade.execution. Business justification: Workpapers contain execution samples tested for price reasonableness, venue selection, and timestamp accuracy. Links workpaper to tested execution for transaction testing evidence and regulatory exami',
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: Workpapers document testing of credit facilities (e.g., covenant compliance testing, syndication agreement review, facility limit monitoring). Auditors must link workpapers to tested facilities for au',
    `finding_id` BIGINT COMMENT 'Reference to the audit finding record that was raised based on this workpaper. Links workpaper evidence to formal audit findings and recommendations.',
    `ftp_rate_id` BIGINT COMMENT 'Foreign key linking to treasury.ftp_rate. Business justification: Auditors test FTP rate calculations, approval workflows, and rate application accuracy. Workpapers reference specific rate records as audit evidence for transfer pricing governance and NIM allocation ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Account testing workpapers document procedures performed on specific GL accounts. This link is fundamental for substantive testing, analytical procedures, and account reconciliation validation in fina',
    `hqla_inventory_id` BIGINT COMMENT 'Foreign key linking to treasury.hqla_inventory. Business justification: Auditors test HQLA eligibility, valuation, haircut application, and encumbrance status. Workpapers reference specific securities as substantive testing evidence for LCR calculation and liquidity risk ',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Workpapers document audit testing of specific instruments: independent price verification, credit rating validation, collateral valuation, classification accuracy. Essential for audit evidence trail l',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Auditors test journal entries for authorization, accuracy, and completeness. Linking workpapers to specific journal entries provides audit trail and evidence documentation for SOX compliance and finan',
    `lc_id` BIGINT COMMENT 'Foreign key linking to loan.lc. Business justification: Trade finance audits test specific letters of credit for UCP 600 compliance, document examination accuracy, and sanctions screening. Workpapers must reference the LC tested for audit trail and regulat',
    `loan_account_id` BIGINT COMMENT 'Foreign key linking to loan.loan_account. Business justification: Workpapers document testing of individual loan accounts (e.g., ECL calculation review, repayment testing, collateral valuation). Auditors must link workpapers to tested loans for audit trail, quality ',
    `order_id` BIGINT COMMENT 'Foreign key linking to trade.order. Business justification: Workpapers document testing of specific order samples for best execution analysis, market abuse surveillance, and regulatory compliance. Links workpaper to tested order for audit trail and evidence re',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: Workpapers document price testing: independent price verification (IPV), fair value hierarchy validation, pricing source review, stale price identification. Audit evidence requires linkage to specific',
    `employee_id` BIGINT COMMENT 'Reference to the senior auditor or manager who reviewed this workpaper. Establishes supervisory review chain.',
    `credit_rating_id` BIGINT COMMENT 'Foreign key linking to security.credit_rating. Business justification: Workpapers document credit rating validation: rating accuracy vs. agency sources, timely updates, regulatory capital impact, IFRS 9 staging alignment. Audit testing requires linkage to specific rating',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Workpapers document audit evidence about specific customers (transaction testing, KYC verification, credit file reviews). Links evidence to customer for regulatory exam support, audit trail completene',
    `document_id` BIGINT COMMENT 'Foreign key linking to account.account_document. Business justification: Audit workpapers reference supporting documents as evidence (account opening forms, KYC documents, authorization records). Links workpaper to specific documents reviewed, required for audit trail comp',
    `standing_order_id` BIGINT COMMENT 'Foreign key linking to account.standing_order. Business justification: Auditors test standing orders for proper authorization, AML screening, and execution accuracy. Workpapers document sample orders tested and results. Required for operational audit evidence and payment',
    `workpaper_employee_id` BIGINT COMMENT 'Reference to the auditor or staff member who prepared this workpaper. Establishes accountability for workpaper creation.',
    `yield_curve_id` BIGINT COMMENT 'Foreign key linking to security.yield_curve. Business justification: Workpapers document yield curve validation: construction methodology review, data input accuracy, interpolation method appropriateness, model back-testing. Valuation model audit testing requires linka',
    `previous_workpaper_id` BIGINT COMMENT 'Self-referencing FK on workpaper (previous_workpaper_id)',
    `audit_conclusion` STRING COMMENT 'Summary conclusion reached by the auditor based on the evidence documented in this workpaper. Articulates the auditors professional judgment on the control effectiveness, risk level, or compliance status tested.',
    `audit_objective` STRING COMMENT 'Specific audit objective that this workpaper addresses, articulating what the auditor is testing or evaluating (e.g., Verify segregation of duties in payment processing, Assess adequacy of credit risk controls).',
    `confidentiality_level` STRING COMMENT 'Data classification level of the workpaper content: public (no restrictions), internal (internal use only), confidential (sensitive business information), or restricted (highly sensitive, PII/PHI/PCI). Drives access controls and handling procedures.. Valid values are `public|internal|confidential|restricted`',
    `control_effectiveness_rating` STRING COMMENT 'Auditors assessment of the controls operating effectiveness based on testing: effective (control operating as designed with no exceptions), partially effective (control operating with minor exceptions), ineffective (control not operating or significant exceptions identified), not applicable (control not in scope), or not tested (control not evaluated in this workpaper).. Valid values are `effective|partially_effective|ineffective|not_applicable|not_tested`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the workpaper record was first created in the audit management system. Audit trail for record creation.',
    `data_extraction_date` DATE COMMENT 'Date when data was extracted from the source system for analysis in this workpaper. Establishes data currency and as-of date for testing.',
    `data_extraction_query` STRING COMMENT 'SQL query, report parameters, or extraction criteria used to obtain data from the source system. Documents reproducibility of data extraction.',
    `data_source_system` STRING COMMENT 'Name of the source system from which data was extracted for this workpaper (e.g., Temenos T24, Murex, SAP S4HANA). Applicable for data extract workpapers.',
    `document_format` STRING COMMENT 'File format of the stored workpaper document: pdf (portable document format), excel (spreadsheet), word (text document), powerpoint (presentation), email (email correspondence), image (scanned document or screenshot), video (recorded interview or observation), audio (recorded interview), or other (miscellaneous format). [ENUM-REF-CANDIDATE: pdf|excel|word|powerpoint|email|image|video|audio|other — 9 candidates stripped; promote to reference product]',
    `document_page_count` STRING COMMENT 'Number of pages in the workpaper document. Used for workpaper inventory and completeness verification.',
    `document_storage_reference` STRING COMMENT 'File path, URL, or document management system reference to the physical workpaper document (e.g., SharePoint URL, network path, document ID in audit management system). Enables retrieval of supporting documentation.',
    `exception_rate_percentage` DECIMAL(18,2) COMMENT 'Calculated exception rate as a percentage of sample size (exceptions / sample size * 100). Used to assess materiality and control deficiency severity.',
    `exceptions_identified_count` STRING COMMENT 'Number of exceptions or deviations identified during testing documented in this workpaper. Used to assess control reliability and determine if findings should be raised.',
    `finding_raised_flag` BOOLEAN COMMENT 'Indicates whether a formal audit finding was raised based on the evidence in this workpaper. True if finding was escalated to audit report, false otherwise.',
    `interview_date` DATE COMMENT 'Date when the interview was conducted. Applicable for interview notes workpapers.',
    `interviewee_name` STRING COMMENT 'Name of the individual interviewed for this workpaper. Applicable for interview notes workpapers. Classified as confidential to protect interview participant identity.',
    `interviewee_title` STRING COMMENT 'Job title or role of the individual interviewed (e.g., VP Credit Risk, Senior Loan Officer). Provides context for interview responses.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the workpaper record was last updated. Audit trail for record modifications and version control.',
    `population_size` STRING COMMENT 'Total number of items or transactions in the population from which the sample was drawn. Used to assess sampling adequacy and representativeness.',
    `preparation_date` DATE COMMENT 'Date when the workpaper was prepared or completed by the auditor. Establishes timeline of audit work performed.',
    `reference_number` STRING COMMENT 'Unique business identifier for the workpaper following organizational indexing convention (e.g., AU-001234, RK-002-01). Used for cross-referencing within audit documentation.. Valid values are `^[A-Z0-9]{2,4}-[0-9]{3,6}(-[0-9]{1,3})?$`',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory requirement, standard, or compliance obligation that this workpaper addresses (e.g., SOX Section 404, Basel III Pillar 1, GDPR Article 32). Links audit work to regulatory mandates.',
    `retention_period_years` STRING COMMENT 'Number of years this workpaper must be retained per organizational policy and regulatory requirements. Drives records management and archival processes.',
    `review_date` DATE COMMENT 'Date when the workpaper was reviewed and approved by the reviewer. Establishes completion of quality review process.',
    `review_notes` STRING COMMENT 'Comments and feedback provided by the reviewer during the quality review process. Documents review points, questions raised, and resolution of review comments.',
    `review_status` STRING COMMENT 'Current state of the workpaper in the review workflow: draft (being prepared), submitted for review (awaiting reviewer), review in progress (under active review), returned for revision (requires preparer updates), approved (review complete and accepted), or archived (final state post-engagement).. Valid values are `draft|submitted_for_review|review_in_progress|returned_for_revision|approved|archived`',
    `sample_size` STRING COMMENT 'Number of items or transactions selected for testing in this workpaper. Applicable for test of controls and substantive test workpapers.',
    `sampling_method` STRING COMMENT 'Statistical or non-statistical sampling approach used to select items for testing: random (statistical random selection), systematic (every nth item), stratified (population divided into strata), judgmental (auditor discretion), monetary unit (probability proportional to size), haphazard (informal selection), or complete population (100% testing). [ENUM-REF-CANDIDATE: random|systematic|stratified|judgmental|monetary_unit|haphazard|complete_population — 7 candidates stripped; promote to reference product]',
    `testing_period_end_date` DATE COMMENT 'Ending date of the period covered by the audit testing documented in this workpaper (e.g., 2024-03-31 for Q1 testing).',
    `testing_period_start_date` DATE COMMENT 'Beginning date of the period covered by the audit testing documented in this workpaper (e.g., 2024-01-01 for Q1 testing).',
    `title` STRING COMMENT 'Descriptive title of the workpaper summarizing the audit procedure or evidence documented (e.g., Loan Approval Control Testing - Q3 2024, KYC Process Walkthrough).',
    `workpaper_description` STRING COMMENT 'Detailed description of the audit work performed, methodology applied, scope of testing, and any relevant context for understanding the workpaper content.',
    `workpaper_type` STRING COMMENT 'Classification of the workpaper by its audit purpose: planning memo (audit planning documentation), control walkthrough (process and control documentation), test of controls (control effectiveness testing), substantive test (detailed transaction testing), interview notes (stakeholder interview documentation), or data extract (system data analysis).. Valid values are `planning_memo|control_walkthrough|test_of_controls|substantive_test|interview_notes|data_extract`',
    CONSTRAINT pk_workpaper PRIMARY KEY(`workpaper_id`)
) COMMENT 'Audit workpaper record documenting the evidence, testing performed, and conclusions reached for each audit procedure step. Captures workpaper reference number, associated program step, workpaper type (planning memo, control walkthrough, test of controls, substantive test, interview notes, data extract), preparer, reviewer, preparation date, review date, review status, conclusion, and document storage reference. Constitutes the evidentiary record supporting audit findings and opinions, subject to quality assurance review and regulatory inspection.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`finding` (
    `finding_id` BIGINT COMMENT 'Unique identifier for the audit finding record. Primary key.',
    `alco_resolution_id` BIGINT COMMENT 'Foreign key linking to treasury.alco_resolution. Business justification: Audit findings cite ALCO resolutions that established the policy, limit, or control that was breached. Essential for compliance verification and root cause analysis in treasury audits.',
    `employee_id` BIGINT COMMENT 'Reference to the lead auditor or audit team member who identified and documented the finding.',
    `compliance_sox_control_id` BIGINT COMMENT 'Reference to the specific internal control or control activity that failed or was found deficient, typically from the organizations control framework or RCSA.',
    `corporate_action_id` BIGINT COMMENT 'Foreign key linking to security.corporate_action. Business justification: Findings relate to corporate action processing errors: incorrect entitlements, missed events, late payments, election processing failures. Event-level issue tracking enables root cause analysis and pr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Findings assign remediation responsibility to specific cost centers. Cost center linkage enables accountability tracking, management action assignment, and organizational performance assessment.',
    `counterparty_agreement_id` BIGINT COMMENT 'Foreign key linking to trade.counterparty_agreement. Business justification: Findings may reference specific ISDA/CSA agreements with inadequate collateral terms, missing legal opinions, or non-compliant margin calculations. Links finding to specific agreement for remediation ',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the financial impact amount (e.g., USD, EUR, GBP).',
    `engagement_id` BIGINT COMMENT 'Reference to the audit engagement during which this finding was identified.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to loan.facility. Business justification: Audit findings may relate to specific facilities (e.g., syndication documentation deficiency, facility limit breach, collateral coverage shortfall). Findings must reference the facility for management',
    `finding_employee_id` BIGINT COMMENT 'Reference to the business owner or manager responsible for remediating the finding, typically from the Human Resources or Employee master data.',
    `fund_expense_id` BIGINT COMMENT 'Foreign key linking to asset.fund_expense. Business justification: Expense findings (unauthorized charges, allocation errors, TER breaches) require direct linkage to specific expense records for remediation tracking, board reporting, and regulatory disclosure (Form N',
    `fund_valuation_adjustment_id` BIGINT COMMENT 'Foreign key linking to asset.fund_valuation_adjustment. Business justification: Valuation adjustment findings address swing pricing methodology, dilution levy calculations, fair value hierarchy breaches. Direct linkage enables tracking of pricing policy compliance, board approval',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Audit findings often identify issues with specific instruments: mispricing, misclassification, control failures, limit breaches. Tracking the specific instrument enables targeted remediation and trend',
    `issuer_id` BIGINT COMMENT 'Foreign key linking to security.issuer. Business justification: Findings relate to issuer concentration risk breaches, credit deterioration not escalated, issuer monitoring control failures, sanctioned entity exposure. Issuer-level issue tracking enables aggregate',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Findings may cite specific problematic journal entries as evidence (e.g., unauthorized adjustments, policy violations). Direct JE linkage provides audit trail and supports finding validation and remed',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Findings are issued against specific legal entities for regulatory reporting, board reporting, and remediation tracking. Legal entity attribution is mandatory for audit committee reporting and regulat',
    `loan_account_id` BIGINT COMMENT 'Foreign key linking to loan.loan_account. Business justification: Audit findings often cite specific loan accounts as evidence (e.g., ECL provision error on loan #12345, covenant breach not escalated). Findings must be traceable to source records for management acti',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Audit findings may trigger operational risk event logging or reference existing events as evidence. Links finding to event for integrated risk/audit reporting, root cause analysis, and regulatory repo',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Audit findings often relate to specific customer accounts (AML violations, credit underwriting deficiencies, KYC gaps). Tracks customer context for regulatory reporting (SAR filings), relationship exi',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: Findings identify pricing errors, stale prices not escalated, pricing source failures, fair value hierarchy misclassification. Price-level issue tracking enables root cause analysis and pricing contro',
    `prior_finding_id` BIGINT COMMENT 'Reference to the original finding identifier if this is a repeat finding, enabling tracking of recurring issues across audit cycles.',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Audit findings frequently identify issues with specific deposit accounts (dormancy, escheatment, fee assessment errors, interest calculation). Links finding to account enables root cause analysis, rem',
    `hold_id` BIGINT COMMENT 'Foreign key linking to account.account_hold. Business justification: Regulatory audits and compliance reviews identify improper holds (incorrect legal authority, expired holds, customer notification failures). Links finding to specific hold enables remediation validati',
    `restriction_breach_id` BIGINT COMMENT 'Foreign key linking to asset.restriction_breach. Business justification: Restriction breaches are audit findings requiring root cause analysis, remediation plans, board notification. Direct linkage enables tracking of breach resolution, waiver justifications, and repeat oc',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Audit findings often identify risk limit breaches, inadequate monitoring, or control weaknesses around specific limits. Links finding to the limit in question, supporting risk limit governance and bre',
    `credit_rating_id` BIGINT COMMENT 'Foreign key linking to security.credit_rating. Business justification: Findings identify rating data quality issues: stale ratings, missing updates, rating source discrepancies, capital calculation errors. Rating-level issue tracking enables targeted remediation of credi',
    `trading_book_id` BIGINT COMMENT 'Foreign key linking to trade.trading_book. Business justification: Audit findings often cite specific trading books where control deficiencies were identified (e.g., limit breaches, P&L reconciliation failures, Volcker violations). Links finding to audited book for r',
    `nostro_reconciliation_id` BIGINT COMMENT 'Foreign key linking to treasury.nostro_reconciliation. Business justification: Unreconciled nostro breaks, aging exceptions, and control failures generate audit findings. Findings reference specific reconciliation records as evidence of operational risk and control deficiencies ',
    `yield_curve_id` BIGINT COMMENT 'Foreign key linking to security.yield_curve. Business justification: Findings relate to yield curve construction errors, model validation weaknesses, data input failures, methodology documentation gaps. Curve-level issue tracking enables model risk remediation and valu',
    `superseded_finding_id` BIGINT COMMENT 'Self-referencing FK on finding (superseded_finding_id)',
    `actual_remediation_date` DATE COMMENT 'The date when remediation was actually completed and validated by audit, marking the closure of the finding.',
    `audit_committee_reported_flag` BOOLEAN COMMENT 'Indicator of whether this finding was escalated and reported to the Audit Committee of the Board of Directors. True indicates it was reported.',
    `business_process` STRING COMMENT 'The business process or functional area where the finding was identified (e.g., Commercial Lending, Securities Trading, Payment Processing, Risk Management).',
    `cause` STRING COMMENT 'Root cause analysis explaining why the condition occurred - the underlying reason for the control deficiency or gap.',
    `condition` STRING COMMENT 'Detailed description of what was found during the audit - the actual state or situation observed that represents a deviation from expected standards.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the finding record was first created in the audit management system.',
    `criteria` STRING COMMENT 'The standard, policy, regulation, or best practice that should have been followed - what the correct state or control should be.',
    `effect` STRING COMMENT 'Description of the actual or potential impact and risk to the organization if the finding is not remediated - the business consequence of the control gap.',
    `external_auditor_shared_flag` BOOLEAN COMMENT 'Indicator of whether this finding was shared with external auditors as part of coordination and reliance activities. True indicates it was shared.',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Quantified financial impact of the finding in the organizations reporting currency, including actual losses, potential exposure, or remediation costs.',
    `finding_number` STRING COMMENT 'Business-facing unique identifier or reference number for the finding, often used in audit reports and management communications.',
    `finding_status` STRING COMMENT 'Current lifecycle status of the finding: draft (being documented), open (issued to management), in remediation (action plan underway), pending validation (awaiting audit verification), closed (remediated and validated), reopened (recurred after closure).. Valid values are `draft|open|in remediation|pending validation|closed|reopened`',
    `finding_type` STRING COMMENT 'Classification of the finding severity and nature: control deficiency (minor gap), significant deficiency (important gap requiring attention), material weakness (critical gap with material impact), observation (informational note), or best practice (improvement opportunity).. Valid values are `control deficiency|significant deficiency|material weakness|observation|best practice`',
    `geography` STRING COMMENT 'Geographic region, country, or jurisdiction where the finding was identified, using three-letter ISO country codes where applicable.',
    `identified_date` DATE COMMENT 'The date when the finding was first identified during audit fieldwork.',
    `impact` STRING COMMENT 'Assessment of the magnitude of potential loss or harm if the risk materializes - financial, reputational, regulatory, or operational impact.. Valid values are `very high|high|medium|low|very low`',
    `issued_date` DATE COMMENT 'The date when the finding was formally issued to management in the audit report or finding memo.',
    `likelihood` STRING COMMENT 'Assessment of the probability that the risk will materialize or the control failure will occur.. Valid values are `very high|high|medium|low|very low`',
    `line_of_business` STRING COMMENT 'The business unit, division, or line of business where the finding was identified (e.g., Retail Banking, Investment Banking, Wealth Management, Treasury).',
    `management_agrees_flag` BOOLEAN COMMENT 'Indicator of whether management agrees with the finding. True indicates agreement, False indicates disagreement or partial agreement.',
    `management_response` STRING COMMENT 'Formal written response from management acknowledging the finding and outlining their agreement, disagreement, or planned corrective actions.',
    `recommendation` STRING COMMENT 'Detailed recommendation from internal audit on how to remediate the finding and strengthen controls.',
    `regulatory_citation` STRING COMMENT 'Reference to the specific regulatory requirement, statute, or rule that was violated or not met (e.g., Basel III Article 123, SOX Section 404, Regulation CC Section 229.10).',
    `regulatory_reported_flag` BOOLEAN COMMENT 'Indicator of whether this finding was required to be reported to regulatory authorities (Fed, OCC, SEC, etc.). True indicates regulatory reporting occurred.',
    `remediation_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost to remediate the finding, including technology investments, process redesign, training, and resource allocation.',
    `repeat_finding_flag` BOOLEAN COMMENT 'Indicator of whether this finding is a recurrence of a previously identified and supposedly remediated issue. True indicates a repeat finding.',
    `risk_rating` STRING COMMENT 'Overall risk severity rating assigned to the finding based on likelihood and impact assessment: critical (immediate action required), high (priority remediation), medium (planned remediation), low (monitor or accept).. Valid values are `critical|high|medium|low`',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause: process design (flawed procedure), execution failure (not following procedure), resource constraint (insufficient staffing or budget), technology limitation (system gap), training gap (knowledge deficiency), oversight weakness (inadequate supervision).. Valid values are `process design|execution failure|resource constraint|technology limitation|training gap|oversight weakness`',
    `sox_relevant_flag` BOOLEAN COMMENT 'Indicator of whether this finding relates to SOX internal controls over financial reporting. True indicates SOX relevance.',
    `target_remediation_date` DATE COMMENT 'The date by which management has committed to complete remediation of the finding, as agreed in the management action plan.',
    `three_lines_position` STRING COMMENT 'Classification of which line of defense the finding relates to: first line (business operations), second line (risk and compliance oversight), third line (internal audit).. Valid values are `first line|second line|third line`',
    `title` STRING COMMENT 'Concise title or summary of the audit finding that clearly communicates the issue identified.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the finding record was last modified, supporting audit trail and change tracking.',
    `validation_date` DATE COMMENT 'The date when internal audit validated and confirmed that the remediation actions were effective and the finding could be closed.',
    CONSTRAINT pk_finding PRIMARY KEY(`finding_id`)
) COMMENT 'Audit finding record representing an identified control deficiency, gap, or exception discovered during an engagement. Captures finding title, finding type (control deficiency, significant deficiency, material weakness, observation, best practice), root cause category, condition (what was found), criteria (what should be), cause (why it occurred), effect/risk (potential impact), risk rating (critical, high, medium, low), regulatory citation if applicable, repeat finding flag, prior finding reference, and management response. The primary output of audit fieldwork and the driver of remediation activity.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`recommendation` (
    `recommendation_id` BIGINT COMMENT 'Unique identifier for the audit recommendation record. Primary key.',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the estimated cost amount. Supports multi-currency operations for global banking institutions.',
    `finding_id` BIGINT COMMENT 'Reference to the audit finding that this recommendation addresses. Links recommendation to the underlying control deficiency or issue identified during the audit engagement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Recommendations are implemented by specific cost centers. Cost center linkage assigns accountability, enables progress tracking, and supports escalation. Replaces denormalized responsible_department w',
    `employee_id` BIGINT COMMENT 'System identifier linking to the employee record of the responsible business owner in the Human Capital Management (HCM) system for accountability tracking and escalation workflows.',
    `superseded_recommendation_id` BIGINT COMMENT 'Self-referencing FK on recommendation (superseded_recommendation_id)',
    `acceptance_status` STRING COMMENT 'Management decision on whether to accept and implement the recommendation as proposed. Rejected recommendations require escalation to audit committee and documentation of risk acceptance.. Valid values are `accepted|rejected|partially_accepted|under_negotiation`',
    `actual_implementation_date` DATE COMMENT 'Date when management completed implementation of the recommendation. Subject to validation testing by internal audit before final closure.',
    `alternative_action_proposed` STRING COMMENT 'Description of alternative corrective action proposed by management when the original recommendation is rejected or modified. Subject to audit review and approval.',
    `audit_committee_report_date` DATE COMMENT 'Date when the recommendation was presented to the audit committee. Used for tracking board-level governance and oversight of critical audit issues.',
    `audit_committee_reported_flag` BOOLEAN COMMENT 'Indicator whether the recommendation has been reported to the audit committee. True for high-risk recommendations, regulatory issues, and overdue items requiring board-level visibility.',
    `closure_date` DATE COMMENT 'Date when the recommendation was formally closed after successful validation by internal audit. Used for calculating aging metrics and audit committee reporting.',
    `control_framework_reference` STRING COMMENT 'Reference to the specific control framework component addressed by the recommendation, such as COSO Internal Control Framework principles, Basel III operational risk controls, or ISO 27001 information security controls.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the recommendation record was first created in the audit management system. Audit trail field for record lifecycle tracking.',
    `escalation_date` DATE COMMENT 'Date when the recommendation was escalated to senior management or audit committee. Used for tracking escalation aging and governance oversight.',
    `escalation_flag` BOOLEAN COMMENT 'Indicator whether the recommendation has been escalated to senior management or audit committee due to overdue status, rejection, or critical risk rating. Triggers enhanced monitoring and reporting.',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Projected financial cost to implement the recommendation, including technology investments, consulting fees, training costs, and ongoing operational expenses. Used for budgeting and cost-benefit analysis.',
    `estimated_implementation_effort` STRING COMMENT 'Assessment of the resources, time, and complexity required to implement the recommendation. Used for prioritization and resource allocation decisions by management.. Valid values are `minimal|low|moderate|high|extensive`',
    `implementation_progress_percentage` DECIMAL(18,2) COMMENT 'Percentage completion of recommendation implementation as reported by management. Used for continuous monitoring and Key Risk Indicator (KRI) dashboards.',
    `is_active` BOOLEAN COMMENT 'Indicator whether the recommendation record is currently active. False for closed, cancelled, or archived recommendations. Used for filtering active remediation tracking.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the recommendation record. Audit trail field for accountability and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the recommendation record was last updated. Audit trail field for tracking changes to status, target dates, or management responses.',
    `management_response` STRING COMMENT 'Formal written response from the responsible business owner addressing the recommendation. Includes acceptance or rejection rationale, proposed alternative actions, and implementation plan details.',
    `management_response_date` DATE COMMENT 'Date when management formally responded to the recommendation. Used to track Service Level Agreement (SLA) compliance for audit response timelines.',
    `original_target_date` DATE COMMENT 'Initial target remediation date established when the recommendation was first issued. Preserved for audit trail and variance analysis when target dates are extended.',
    `priority_level` STRING COMMENT 'Urgency and importance classification of the recommendation based on risk severity, regulatory impact, and business criticality. Critical recommendations require immediate executive attention.. Valid values are `critical|high|medium|low`',
    `recommendation_number` STRING COMMENT 'Business-facing unique identifier for the recommendation, typically formatted as REC-YYYY-#### for external communication and tracking in audit committee reports.. Valid values are `^REC-[0-9]{4}-[0-9]{4}$`',
    `recommendation_status` STRING COMMENT 'Current lifecycle state of the recommendation. Tracks progression from initial issuance through management acceptance, implementation, validation by audit, and final closure. [ENUM-REF-CANDIDATE: draft|issued|accepted|rejected|in_progress|implemented|validated|closed|overdue — 9 candidates stripped; promote to reference product]',
    `recommendation_text` STRING COMMENT 'Detailed description of the specific corrective action proposed by internal audit to remediate the identified control deficiency. Includes the rationale, expected outcome, and implementation guidance.',
    `recommendation_type` STRING COMMENT 'Classification of the recommendation based on the nature of corrective action required: process improvement, control enhancement, policy update, system change, training, or organizational change.. Valid values are `process_improvement|control_enhancement|policy_update|system_change|training|organizational_change`',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicator whether the recommendation addresses a regulatory compliance gap or supervisory concern. True if linked to regulatory examination findings, consent orders, or mandatory compliance frameworks.',
    `regulatory_requirement_reference` STRING COMMENT 'Citation of specific regulatory requirement, statute, or supervisory guidance that the recommendation addresses. Examples include Basel III capital requirements, Sarbanes-Oxley Act (SOX) controls, Bank Secrecy Act (BSA) compliance, or Dodd-Frank Act Stress Testing (DFAST) requirements.',
    `rejection_rationale` STRING COMMENT 'Detailed explanation provided by management when a recommendation is rejected or partially accepted. Must include risk acceptance justification and alternative mitigation strategies if applicable.',
    `responsible_business_owner` STRING COMMENT 'Name and title of the executive or manager accountable for implementing the recommendation. Typically a Line of Business (LOB) leader or control function head within the three lines of defense model.',
    `risk_rating` STRING COMMENT 'Assessment of the residual risk level if the recommendation is not implemented. Aligns with the enterprise risk management framework and regulatory risk appetite statements.. Valid values are `critical|high|medium|low`',
    `sox_control_flag` BOOLEAN COMMENT 'Indicator whether the recommendation relates to a Sarbanes-Oxley Act (SOX) internal control over financial reporting. True if the recommendation impacts SOX 302 or SOX 404 compliance.',
    `target_remediation_date` DATE COMMENT 'Agreed-upon date by which management commits to complete implementation of the recommendation. Subject to negotiation between audit and business owner during the audit response process.',
    `three_lines_defense_line` STRING COMMENT 'Classification of which defense line the recommendation targets within the three lines of defense model: first line (business operations), second line (risk and compliance), or third line (internal audit).. Valid values are `first_line|second_line|third_line`',
    `validation_auditor` STRING COMMENT 'Name of the internal auditor who performed validation testing of the implemented recommendation. Ensures independence and accountability in the validation process.',
    `validation_date` DATE COMMENT 'Date when internal audit completed validation testing and confirmed effective implementation of the recommendation.',
    `validation_notes` STRING COMMENT 'Detailed findings from internal audit validation testing, including evidence reviewed, testing procedures performed, and assessment of control effectiveness post-implementation.',
    `validation_status` STRING COMMENT 'Status of internal audit validation testing to confirm effective implementation of the recommendation. Validated status is required before recommendation can be closed.. Valid values are `pending|in_progress|validated|not_validated|retest_required`',
    CONSTRAINT pk_recommendation PRIMARY KEY(`recommendation_id`)
) COMMENT 'Formal audit recommendation record associated with a finding, capturing the specific corrective action proposed by internal audit to remediate the identified control deficiency. Captures recommendation text, recommendation type (process improvement, control enhancement, policy update, system change, training), priority level, target remediation date, responsible business owner, estimated implementation effort, and linkage to regulatory requirements. Distinct from the finding itself as recommendations may be modified through management negotiation and have their own acceptance/rejection lifecycle.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`management_action` (
    `management_action_id` BIGINT COMMENT 'Unique identifier for the management action plan record. Primary key for the management action entity.',
    `employee_id` BIGINT COMMENT 'Employee identifier for the action owner, linking to the human capital management system for accountability tracking.',
    `engagement_id` BIGINT COMMENT 'Reference to the parent audit engagement that generated the finding requiring this management action.',
    `finding_id` BIGINT COMMENT 'Reference to the specific audit finding or recommendation that this management action addresses.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Management actions are owned and executed by cost centers. Cost center linkage provides precise accountability, budget tracking, and organizational performance assessment. Replaces denormalized respon',
    `currency_id` BIGINT COMMENT 'Three-letter ISO 4217 currency code for the estimated cost amount, supporting multi-currency operations and consolidated reporting.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Management actions are executed within specific legal entities for regulatory compliance, board reporting, and entity-level remediation tracking. Legal entity attribution is required for audit committ',
    `related_management_action_id` BIGINT COMMENT 'Self-referencing FK on management_action (related_management_action_id)',
    `action_description` STRING COMMENT 'Detailed description of the remediation action that management commits to implement in response to the audit finding or recommendation.',
    `action_notes` STRING COMMENT 'Additional notes, comments, or context regarding the management action plan, supporting communication between management and internal audit.',
    `action_owner_name` STRING COMMENT 'Full name of the individual accountable for executing and completing the management action plan.',
    `action_owner_title` STRING COMMENT 'Job title or position of the action owner, establishing their authority and accountability level within the organization.',
    `action_priority` STRING COMMENT 'Priority level assigned to the management action based on the severity and risk rating of the underlying audit finding.. Valid values are `critical|high|medium|low`',
    `action_status` STRING COMMENT 'Current lifecycle status of the management action plan tracking progress from commitment through validation and closure.. Valid values are `open|in_progress|completed|overdue|closed|cancelled`',
    `action_type` STRING COMMENT 'Classification of the type of remediation action being implemented, supporting analysis of remediation patterns and resource planning.. Valid values are `process_enhancement|policy_update|system_change|training|control_implementation|other`',
    `actual_completion_date` DATE COMMENT 'Date when management reported that the remediation action was fully implemented and ready for internal audit validation.',
    `audit_committee_report_date` DATE COMMENT 'Date when this management action was most recently reported to the audit committee, supporting governance oversight and escalation tracking.',
    `audit_committee_reported_flag` BOOLEAN COMMENT 'Boolean indicator of whether this management action has been reported to the audit committee due to its significance, risk rating, or aging status.',
    `closure_date` DATE COMMENT 'Date when the management action plan was formally closed after successful validation by internal audit, marking the end of the remediation lifecycle.',
    `completion_evidence_description` STRING COMMENT 'Description of the evidence provided by management to demonstrate that the remediation action has been completed as committed.',
    `control_framework` STRING COMMENT 'Identification of the internal control framework or standard that the management action supports, such as COSO, SOX, Basel III operational risk, or bank-specific control library.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the management action plan record was first created in the audit management system, marking the start of the remediation lifecycle.',
    `days_open` STRING COMMENT 'Number of calendar days the management action has been open, calculated from the action creation date to closure date or current date if still open.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated financial cost to implement the management action, including labor, technology, and other resource costs, used for budgeting and prioritization.',
    `extension_approval_date` DATE COMMENT 'Date when the extension to the target completion date was formally approved by the designated authority.',
    `extension_approved_by` STRING COMMENT 'Name or identifier of the authority who approved the extension request, typically senior management or audit committee.',
    `extension_count` STRING COMMENT 'Number of times the target completion date has been extended, used to track management action aging and escalation triggers.',
    `extension_reason` STRING COMMENT 'Business justification provided by management for requesting an extension to the original target completion date.',
    `lob` STRING COMMENT 'Line of business classification for the management action, aligning with the banks organizational and reporting structure.',
    `map_number` STRING COMMENT 'Business-facing unique identifier or reference number for the management action plan, used in audit committee reporting and tracking.',
    `modified_by` STRING COMMENT 'User identifier or name of the individual who most recently modified the management action plan record, supporting accountability and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the management action plan record, supporting change tracking and audit trail requirements.',
    `original_target_completion_date` DATE COMMENT 'Initial target date committed by management for completing the remediation action, established at the time of management response.',
    `overdue_flag` BOOLEAN COMMENT 'Boolean indicator of whether the management action is past its target completion date without being closed, triggering escalation and reporting requirements.',
    `regulatory_driver` STRING COMMENT 'Identification of the specific regulatory requirement, examination finding, or compliance framework that drives this management action if applicable.',
    `regulatory_examination_flag` BOOLEAN COMMENT 'Boolean indicator of whether this management action originated from or is related to a regulatory examination finding requiring formal response to regulators.',
    `revised_target_completion_date` DATE COMMENT 'Updated target completion date if the original deadline was extended due to legitimate business reasons, requiring approval and justification.',
    `risk_rating` STRING COMMENT 'Risk severity rating of the underlying audit finding that this management action addresses, inherited from the audit finding risk assessment.. Valid values are `critical|high|medium|low`',
    `three_lines_of_defense_level` STRING COMMENT 'Classification of which defense line owns the remediation action: first line (business operations), second line (risk and compliance), or third line (internal audit).. Valid values are `first_line|second_line|third_line`',
    `validated_by` STRING COMMENT 'Name or identifier of the internal auditor who performed the validation testing and confirmed action closure.',
    `validation_date` DATE COMMENT 'Date when internal audit completed the validation testing and confirmed the effectiveness of the implemented management action.',
    `validation_notes` STRING COMMENT 'Internal audit observations and comments from the validation testing, documenting the basis for the validation conclusion.',
    `validation_status` STRING COMMENT 'Status of internal audits independent validation of whether the management action was implemented effectively and addresses the original finding.. Valid values are `pending_validation|validated|not_validated|partially_validated`',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created the management action plan record, typically an internal auditor or audit management system administrator.',
    CONSTRAINT pk_management_action PRIMARY KEY(`management_action_id`)
) COMMENT 'Management action plan (MAP) record capturing the business units formal response and committed remediation actions in response to an audit recommendation. Captures action description, action owner name and title, target completion date, revised target date (if extended), completion evidence description, action status (open, in progress, completed, overdue, closed), closure date, and internal audit validation status. Tracks the full remediation lifecycle from management commitment through audit validation of closure.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`issue_validation` (
    `issue_validation_id` BIGINT COMMENT 'Unique identifier for the issue validation record.',
    `finding_id` BIGINT COMMENT 'Reference to the audit finding that is being validated for closure.',
    `management_action_id` BIGINT COMMENT 'Reference to the management action plan that was implemented to remediate the finding.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the auditor who performed the validation.',
    `previous_issue_validation_id` BIGINT COMMENT 'Self-referencing FK on issue_validation (previous_issue_validation_id)',
    `approval_date` DATE COMMENT 'Date when the validation conclusion was formally approved.',
    `approved_by` STRING COMMENT 'Name of the audit manager or Chief Audit Executive (CAE) who approved the validation conclusion.',
    `audit_committee_report_date` DATE COMMENT 'Date when the validation result was reported to the Audit Committee.',
    `audit_committee_reported_flag` BOOLEAN COMMENT 'Indicates whether this validation result has been reported to the Audit Committee of the Board of Directors.',
    `control_effectiveness_rating` STRING COMMENT 'Rating of the effectiveness of the remediated control based on validation testing results.. Valid values are `effective|partially effective|ineffective|not tested`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the validation record was first created in the system.',
    `evidence_location` STRING COMMENT 'File path, document repository location, or system reference where validation evidence is stored.',
    `evidence_reviewed` STRING COMMENT 'Description of the evidence and documentation reviewed during the validation process to confirm remediation.',
    `exception_count` STRING COMMENT 'Number of exceptions identified during the validation testing.',
    `exceptions_identified` STRING COMMENT 'Description of any exceptions or deficiencies identified during validation testing that indicate incomplete remediation.',
    `follow_up_due_date` DATE COMMENT 'Target date for completing any required follow-up validation or remediation activities.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether additional follow-up validation or management action is required.',
    `modified_by` STRING COMMENT 'User identifier of the person who last modified the validation record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the validation record was last modified.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory body or examiner requesting validation evidence, if applicable.',
    `regulatory_examination_flag` BOOLEAN COMMENT 'Indicates whether this validation supports a regulatory examination response or inquiry.',
    `reopen_date` DATE COMMENT 'Date when the finding was reopened based on validation results.',
    `reopen_flag` BOOLEAN COMMENT 'Indicates whether the finding was reopened due to validation testing revealing incomplete or ineffective remediation.',
    `reopen_reason` STRING COMMENT 'Explanation of why the finding was reopened after validation testing.',
    `residual_risk_accepted_flag` BOOLEAN COMMENT 'Indicates whether management has formally accepted the residual risk.',
    `residual_risk_assessment` STRING COMMENT 'Assessment of any remaining risk after the management action has been implemented, including likelihood and impact.',
    `residual_risk_rating` STRING COMMENT 'Categorical rating of the residual risk remaining after remediation.. Valid values are `critical|high|medium|low|minimal`',
    `sample_population` STRING COMMENT 'Total population size from which the validation sample was drawn.',
    `sample_size` STRING COMMENT 'Number of items or transactions tested during the validation process.',
    `testing_period_end_date` DATE COMMENT 'End date of the period covered by the validation testing.',
    `testing_period_start_date` DATE COMMENT 'Start date of the period covered by the validation testing.',
    `three_lines_of_defense_level` STRING COMMENT 'Identifies which line of defense performed the validation within the three lines of defense governance model.. Valid values are `first line|second line|third line`',
    `validation_conclusion` STRING COMMENT 'Final conclusion of the validation testing indicating whether the finding has been effectively remediated.. Valid values are `validated closed|partially remediated|not remediated|pending additional evidence|deferred|superseded`',
    `validation_date` DATE COMMENT 'Date when the validation testing and evidence review was performed.',
    `validation_method` STRING COMMENT 'Method used to validate the effectiveness of the management action implementation. [ENUM-REF-CANDIDATE: document review|re-testing|walkthrough|data analysis|observation|inquiry|inspection|recalculation — 8 candidates stripped; promote to reference product]',
    `validation_notes` STRING COMMENT 'Detailed notes and observations from the validation testing, including any exceptions or concerns identified.',
    `validation_number` STRING COMMENT 'Business identifier for the validation record, used for tracking and reporting purposes.',
    `validation_status` STRING COMMENT 'Current status of the validation record in its lifecycle.. Valid values are `draft|in progress|completed|approved|rejected`',
    `validation_team` STRING COMMENT 'Name of the audit team or unit responsible for performing the validation.',
    `validator_name` STRING COMMENT 'Name of the internal auditor or audit team member who performed the validation testing.',
    `created_by` STRING COMMENT 'User identifier of the person who created the validation record.',
    CONSTRAINT pk_issue_validation PRIMARY KEY(`issue_validation_id`)
) COMMENT 'Internal audit validation record documenting the testing and evidence review performed to confirm that a management action has been effectively implemented and the underlying finding has been remediated. Captures validation date, validation method (document review, re-testing, walkthrough, data analysis), evidence reviewed, validation conclusion (validated closed, partially remediated, not remediated), validator name, and any residual risk assessment. Provides the formal audit sign-off on finding closure and supports regulatory examination responses.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`audit_report` (
    `audit_report_id` BIGINT COMMENT 'Unique identifier for the audit report record. Primary key for the audit report entity.',
    `engagement_id` BIGINT COMMENT 'Reference to the parent audit engagement that this report documents. Links the report to the underlying audit work performed.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Audit reports are issued for specific legal entities for board reporting, regulatory filing, and entity-level audit opinion. Legal entity linkage is fundamental for audit reporting structure.',
    `superseded_audit_report_id` BIGINT COMMENT 'Self-referencing FK on audit_report (superseded_audit_report_id)',
    `audit_committee_presentation_date` DATE COMMENT 'Date the audit report was formally presented to the Audit Committee of the Board of Directors. Critical for governance oversight and regulatory compliance documentation.',
    `audit_director_name` STRING COMMENT 'Name of the audit director or Chief Audit Executive (CAE) who reviewed and approved the audit report. Accountable for audit quality and independence.',
    `audit_objective` STRING COMMENT 'Statement of the specific goals and intended outcomes of the audit engagement. Defines what the audit was designed to accomplish and the questions it sought to answer.',
    `audit_period_end_date` DATE COMMENT 'Ending date of the time period covered by the audit examination. Defines the cutoff for transactions and activities included in the audit scope.',
    `audit_period_start_date` DATE COMMENT 'Beginning date of the time period covered by the audit examination. Defines the temporal scope of transactions and activities reviewed.',
    `background_context` STRING COMMENT 'Descriptive information about the audited area including business processes, organizational structure, regulatory environment, and prior audit history. Provides context for understanding the audit scope and findings.',
    `confidentiality_level` STRING COMMENT 'Data classification level governing distribution and handling of the audit report. Restricted reports contain sensitive findings requiring limited distribution, confidential reports are for management only, internal reports are for employee access, and public reports may be disclosed externally.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the audit report record was first created in the audit management system. Used for audit trail and data lineage purposes.',
    `critical_findings_count` STRING COMMENT 'Number of critical-severity findings identified in the audit. Critical findings represent significant control deficiencies with high likelihood and impact that require immediate management attention and Board notification.',
    `distribution_list` STRING COMMENT 'List of individuals and roles who received the audit report including business unit management, executive leadership, Audit Committee members, and regulatory examiners. Documents report dissemination for governance and compliance purposes.',
    `executive_summary` STRING COMMENT 'High-level overview of the audit objectives, scope, key findings, and conclusions. Provides senior management and the Audit Committee with a concise understanding of the engagement results without requiring detailed review.',
    `follow_up_due_date` DATE COMMENT 'Target date for conducting follow-up audit procedures to verify remediation of findings. Typically set based on managements committed action plan completion dates.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicator of whether this audit report requires formal follow-up audit work to validate implementation of management action plans. True indicates follow-up audit is scheduled.',
    `high_findings_count` STRING COMMENT 'Number of high-severity findings identified in the audit. High findings represent material control weaknesses that could result in significant financial, operational, or reputational impact.',
    `issuance_date` DATE COMMENT 'Official date the audit report was formally issued to management and the Audit Committee. Marks the beginning of management response and remediation tracking timelines.',
    `lead_auditor_name` STRING COMMENT 'Name of the senior auditor who led the engagement and is responsible for the report content and conclusions. Primary point of contact for questions and follow-up.',
    `lob` STRING COMMENT 'Business segment or division that was the subject of the audit (e.g., Commercial Lending, Investment Banking, Wealth Management, Retail Banking). Used for risk-based audit planning and reporting.',
    `low_findings_count` STRING COMMENT 'Number of low-severity findings identified in the audit. Low findings represent minor control weaknesses or opportunities for process improvement.',
    `management_agreement_flag` BOOLEAN COMMENT 'Indicator of whether management agrees with the audit findings and conclusions. True indicates full agreement, false indicates disagreement requiring escalation and documentation of differing views.',
    `management_response_summary` STRING COMMENT 'Consolidated summary of managements formal responses to audit findings including agreement or disagreement with findings, planned corrective actions, responsible parties, and target completion dates.',
    `medium_findings_count` STRING COMMENT 'Number of medium-severity findings identified in the audit. Medium findings represent control weaknesses that should be addressed but do not pose immediate significant risk.',
    `methodology_description` STRING COMMENT 'Explanation of the audit approach, techniques, and procedures employed including interviews, walkthroughs, testing, data analytics, and sampling methods. Documents how the audit work was performed.',
    `modified_by` STRING COMMENT 'User identifier of the individual who last modified the audit report record. Used for accountability and change tracking purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the audit report record was last updated. Tracks the most recent change to any field in the record for version control and audit trail purposes.',
    `notes` STRING COMMENT 'Additional comments, context, or supplementary information about the audit report that does not fit in other structured fields. May include special circumstances, scope limitations, or coordination notes.',
    `overall_audit_opinion` STRING COMMENT 'Summary assessment of the adequacy and effectiveness of governance, risk management, and control processes within the audited area. Satisfactory indicates effective controls, needs improvement indicates control weaknesses requiring attention, unsatisfactory indicates significant deficiencies, and no opinion indicates scope limitations prevented a conclusion.. Valid values are `satisfactory|needs_improvement|unsatisfactory|no_opinion`',
    `positive_observations` STRING COMMENT 'Documentation of effective controls, best practices, and areas of strong performance identified during the audit. Provides balanced reporting and recognizes effective risk management.',
    `quality_assurance_review_flag` BOOLEAN COMMENT 'Indicator of whether this audit report underwent independent quality assurance review by a senior auditor not involved in the engagement. True indicates QA review was performed per IIA standards.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority that requested or coordinated with this audit (e.g., Federal Reserve, OCC, FDIC, SEC, FINRA). Applicable when regulatory_examination_flag is true.',
    `regulatory_examination_flag` BOOLEAN COMMENT 'Indicator of whether this audit report was prepared in response to or coordination with a regulatory examination by Federal Reserve, OCC, FDIC, SEC, or other banking supervisory authority.',
    `report_number` STRING COMMENT 'Business identifier for the audit report, typically following organizational numbering conventions (e.g., IA-2024-001). Used for external reference and tracking.',
    `report_status` STRING COMMENT 'Current lifecycle state of the audit report. In progress indicates drafting, under review indicates management or quality assurance review, issued indicates formal distribution, and archived indicates retention for historical reference.. Valid values are `in_progress|under_review|issued|archived`',
    `report_type` STRING COMMENT 'Classification of the report format and purpose. Draft reports are preliminary versions for management review, final reports are official deliverables, management letters communicate control weaknesses, advisory memos provide consulting guidance, regulatory responses address examiner findings, and follow-up reports track remediation progress.. Valid values are `draft|final|management_letter|advisory_memo|regulatory_response|follow_up`',
    `risk_rating` STRING COMMENT 'Overall risk assessment of the audited area based on inherent risk, control effectiveness, and residual risk. Used for prioritizing audit resources and management attention.. Valid values are `critical|high|medium|low`',
    `scope_description` STRING COMMENT 'Detailed description of the boundaries of the audit including processes, systems, locations, time periods, and organizational units examined. Also documents any scope limitations or exclusions.',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicator of whether this audit report covers controls within the scope of Sarbanes-Oxley Act Section 404 internal control over financial reporting requirements. True indicates SOX-relevant controls were examined.',
    `three_lines_of_defense_level` STRING COMMENT 'Classification of which defense line the audited area belongs to in the three lines of defense model. First line is operational management, second line is risk and compliance oversight, third line is internal audit.. Valid values are `first_line|second_line|third_line`',
    `title` STRING COMMENT 'Formal title of the audit report that describes the subject matter and scope of the engagement (e.g., Commercial Lending Credit Underwriting Process Audit).',
    `total_findings_count` STRING COMMENT 'Total number of audit findings across all severity levels. Provides an aggregate measure of control deficiencies identified during the engagement.',
    `version` STRING COMMENT 'Sequential version number tracking iterations of the report through draft, review, and final stages. Increments with each substantive revision.',
    `created_by` STRING COMMENT 'User identifier of the individual who created the audit report record in the system. Used for accountability and audit trail purposes.',
    CONSTRAINT pk_audit_report PRIMARY KEY(`audit_report_id`)
) COMMENT 'Formal audit report record representing the official communication of engagement results to management and the Audit Committee. Captures report title, report type (draft, final, management letter, advisory memo, regulatory response), issuance date, distribution list, overall audit opinion, executive summary, number of findings by rating, management response summary, and report version. The primary deliverable of each engagement and the basis for Audit Committee reporting and regulatory examination responses.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`resource` (
    `resource_id` BIGINT COMMENT 'Unique identifier for the audit resource record. Primary key for the audit resource master data.',
    `engagement_id` BIGINT COMMENT 'Foreign key reference to the current active audit engagement the resource is assigned to. Null if the resource is currently unassigned or on administrative leave.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee master record in the Human Resources (HR) domain. Links the audit resource to their core HR profile for payroll, benefits, and organizational hierarchy.',
    `resource_reporting_line_manager_employee_id` BIGINT COMMENT 'Foreign key reference to the employee ID of the auditors direct line manager within the internal audit function. Used for performance management and organizational hierarchy reporting.',
    `supervisor_resource_id` BIGINT COMMENT 'Self-referencing FK on resource (supervisor_resource_id)',
    `audit_grade` STRING COMMENT 'Hierarchical grade or level of the auditor within the internal audit organization. Used for resource planning, assignment complexity matching, and career progression tracking.. Valid values are `junior|intermediate|senior|manager|director|executive`',
    `auditor_name` STRING COMMENT 'Full legal name of the internal auditor. Used for audit report attribution, engagement assignment, and audit committee reporting.',
    `availability_status` STRING COMMENT 'Current availability status of the audit resource for new engagement assignments. Critical for real-time resource planning and audit plan execution.. Valid values are `available|assigned|partially_available|on_leave|training|administrative`',
    `available_capacity_percentage` DECIMAL(18,2) COMMENT 'Percentage of the auditors time currently available for new audit assignments (0-100). Calculated based on current engagement workload, administrative duties, and planned time off.',
    `background_check_date` DATE COMMENT 'Date of the most recent background check performed on the auditor. Required for regulatory compliance and audit committee reporting. Typically refreshed every 3-5 years.',
    `cfe_certified_flag` BOOLEAN COMMENT 'Indicates whether the auditor holds the Certified Fraud Examiner (CFE) professional certification from the Association of Certified Fraud Examiners (ACFE). Critical for fraud investigation, Anti-Money Laundering (AML) audit, and forensic audit assignments.',
    `cia_certified_flag` BOOLEAN COMMENT 'Indicates whether the auditor holds the Certified Internal Auditor (CIA) professional certification from the Institute of Internal Auditors (IIA). Critical for regulatory audit assignments and audit committee credibility.',
    `cisa_certified_flag` BOOLEAN COMMENT 'Indicates whether the auditor holds the Certified Information Systems Auditor (CISA) professional certification from ISACA. Essential for IT audit, cybersecurity audit, and technology risk assessment engagements.',
    `continuous_professional_education_hours` STRING COMMENT 'Total number of Continuous Professional Education (CPE) hours completed by the auditor in the current reporting period. Required for maintaining professional certifications (CIA, CPA, CISA) and regulatory compliance.',
    `cost_center` STRING COMMENT 'General Ledger (GL) cost center code to which the auditors salary and expenses are allocated. Used for internal audit budget tracking and financial reporting.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the auditors home office location. Used for regulatory reporting, cross-border audit coordination, and jurisdictional compliance tracking.. Valid values are `^[A-Z]{3}$`',
    `cpa_certified_flag` BOOLEAN COMMENT 'Indicates whether the auditor holds the Certified Public Accountant (CPA) professional certification. Relevant for financial statement audits, Sarbanes-Oxley Act (SOX) compliance, and General Ledger (GL) audits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit resource record was first created in the system. Part of the audit trail for data lineage and compliance reporting.',
    `current_engagement_role` STRING COMMENT 'Role the auditor is performing on their current engagement (e.g., Lead Auditor, Team Member, Subject Matter Expert). Used for workload balancing and engagement oversight.. Valid values are `lead_auditor|co_lead|team_member|subject_matter_expert|quality_reviewer|observer`',
    `frm_certified_flag` BOOLEAN COMMENT 'Indicates whether the auditor holds the Financial Risk Manager (FRM) professional certification from the Global Association of Risk Professionals (GARP). Relevant for market risk, credit risk, operational risk, and Basel III compliance audit engagements.',
    `hire_date` DATE COMMENT 'Date the auditor was hired into the internal audit function at the institution. Used for tenure calculations, anniversary recognition, and retention analytics.',
    `home_office_location` STRING COMMENT 'Primary office location or city where the auditor is based. Used for travel planning, regional audit coverage, and cost center allocation.',
    `independence_attestation_date` DATE COMMENT 'Date of the most recent independence attestation signed by the auditor. Required annually per Institute of Internal Auditors (IIA) Standards to confirm the auditor has no conflicts of interest with audit subjects.',
    `job_title` STRING COMMENT 'Official job title of the audit resource within the internal audit function (e.g., Senior Auditor, Audit Manager, Chief Audit Executive, IT Audit Specialist).',
    `language_capabilities` STRING COMMENT 'Comma-separated list of languages the auditor is proficient in (e.g., English, Spanish, Mandarin, French). Critical for international audit assignments and cross-border regulatory examinations.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance review for the auditor. Used for talent management, promotion decisions, and audit quality assurance.',
    `modified_by` STRING COMMENT 'User ID or system account that last modified the audit resource record. Part of the audit trail for data governance and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit resource record was last modified. Used for change tracking, data quality monitoring, and audit trail purposes.',
    `notes` STRING COMMENT 'Free-text field for capturing additional information about the audit resource, such as special skills, project preferences, development goals, or assignment restrictions.',
    `other_certifications` STRING COMMENT 'Comma-separated list of additional professional certifications held by the auditor (e.g., CISM, CRISC, CFE, CFA, PMP). Supports specialized audit assignment matching and continuous professional development tracking.',
    `performance_rating` STRING COMMENT 'Most recent performance rating assigned to the auditor. Used for resource allocation decisions, bonus calculations, and succession planning within the internal audit function.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `primary_expertise_area` STRING COMMENT 'Primary domain of audit expertise for the resource. Used for skills-based engagement assignment and capacity planning. Aligns with the banks Lines of Business (LOB) and risk taxonomy. [ENUM-REF-CANDIDATE: credit_risk|market_risk|operational_risk|aml|kyc|it_audit|cybersecurity|trading|regulatory_compliance|sox|basel|ifrs|treasury|wealth_management|retail_banking|investment_banking|payments|fraud|data_privacy|model_validation — 20 candidates stripped; promote to reference product]',
    `resource_status` STRING COMMENT 'Current employment status of the audit resource. Active resources are available for engagement assignment; terminated/retired resources are retained for historical audit trail purposes.. Valid values are `active|on_leave|terminated|retired|seconded`',
    `secondary_expertise_areas` STRING COMMENT 'Comma-separated list of secondary or supporting areas of audit expertise. Enables cross-functional audit assignments and resource flexibility during peak audit periods.',
    `security_clearance_level` STRING COMMENT 'Level of security clearance granted to the auditor for accessing sensitive systems, data, and facilities. Determines which audit engagements the resource is eligible for (e.g., board-level audits, cybersecurity audits).. Valid values are `standard|elevated|executive|board`',
    `termination_date` DATE COMMENT 'Date the auditor left the internal audit function, either through resignation, retirement, or termination. Null for active employees. Used for historical audit engagement tracking and knowledge retention analysis.',
    `three_lines_of_defense_level` STRING COMMENT 'Indicates whether the audit resource operates in the second line of defense (risk management, compliance) or third line of defense (internal audit). Most internal audit resources are third line; some may have dual roles.. Valid values are `second_line|third_line`',
    `years_at_institution` DECIMAL(18,2) COMMENT 'Number of years the auditor has been employed at the current banking institution. Reflects institutional knowledge and familiarity with internal controls, systems, and culture.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of professional audit experience, including both internal audit and external audit roles. Used for engagement complexity matching and mentorship program assignment.',
    `created_by` STRING COMMENT 'User ID or system account that created the audit resource record. Part of the audit trail for data governance and access control.',
    CONSTRAINT pk_resource PRIMARY KEY(`resource_id`)
) COMMENT 'Internal audit staff and resource master record capturing the human capital available to the audit function. Captures auditor name, employee ID (FK to hr domain), job title, audit grade/level, professional certifications (CIA, CPA, CISA, CFE, FRM), areas of expertise (credit risk, AML, IT, trading, regulatory), language capabilities, years of experience, current engagement assignments, and availability status. Supports resource planning, skills-based assignment, and capacity management for the audit function.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`engagement_assignment` (
    `engagement_assignment_id` BIGINT COMMENT 'Unique identifier for the engagement assignment record linking an audit resource to a specific audit engagement.',
    `engagement_id` BIGINT COMMENT 'Reference to the audit engagement to which the resource is assigned.',
    `employee_id` BIGINT COMMENT 'Reference to the audit staff member or resource assigned to the engagement.',
    `primary_engagement_employee_id` BIGINT COMMENT 'Human resources employee identifier for the assigned auditor, used for cross-referencing with HR systems.',
    `previous_engagement_assignment_id` BIGINT COMMENT 'Self-referencing FK on engagement_assignment (previous_engagement_assignment_id)',
    `actual_hours` DECIMAL(18,2) COMMENT 'The actual number of hours the auditor has logged or worked on the engagement, used for resource utilization tracking.',
    `assignment_approved_by` STRING COMMENT 'Name or identifier of the audit leader or Chief Audit Executive (CAE) who approved this resource assignment.',
    `assignment_approved_date` DATE COMMENT 'The date when the assignment was formally approved by audit management.',
    `assignment_change_reason` STRING COMMENT 'Documentation of the reason for any changes to the assignment, such as scope modifications, resource reallocation, or timeline adjustments.',
    `assignment_end_date` DATE COMMENT 'The date when the auditor completes or is scheduled to complete their work on the engagement.',
    `assignment_notes` STRING COMMENT 'General notes and comments about the assignment, including special instructions, scope clarifications, or coordination requirements.',
    `assignment_priority` STRING COMMENT 'The priority level of this assignment relative to other work assigned to the auditor, used for workload balancing and resource allocation.. Valid values are `critical|high|medium|low`',
    `assignment_start_date` DATE COMMENT 'The date when the auditor begins work on the engagement, marking the start of their assignment period.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the assignment indicating whether the auditor is actively working on the engagement.. Valid values are `planned|active|completed|suspended|cancelled`',
    `assignment_type` STRING COMMENT 'Classification of the assignment indicating whether the auditor is a primary team member, secondary support, advisory consultant, quality reviewer, or trainee.. Valid values are `primary|secondary|advisory|quality_assurance|training`',
    `auditor_name` STRING COMMENT 'Full legal name of the auditor assigned to the engagement for reporting and documentation purposes.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether the hours worked on this assignment are billable to a specific business unit or cost center.',
    `certification_held` STRING COMMENT 'Professional certifications held by the auditor relevant to this assignment, such as Certified Internal Auditor (CIA), Certified Information Systems Auditor (CISA), Certified Public Accountant (CPA), or Certified Fraud Examiner (CFE).',
    `charge_code` STRING COMMENT 'The financial charge code or cost center code to which the auditors time on this engagement is allocated for budgeting and cost tracking.',
    `competency_requirement` STRING COMMENT 'The specific skills, certifications, or competencies required for the auditor to fulfill this assignment effectively.',
    `conflict_of_interest_notes` STRING COMMENT 'Documentation of any potential or actual conflicts of interest identified and how they are being managed or mitigated.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this engagement assignment record was first created in the system.',
    `engagement_role` STRING COMMENT 'The specific role the auditor performs within the engagement team, defining responsibilities and authority level.. Valid values are `lead_auditor|in_charge|staff_auditor|subject_matter_expert|it_auditor|quality_reviewer`',
    `independence_confirmation_date` DATE COMMENT 'The date on which the auditor formally confirmed their independence for this engagement.',
    `independence_confirmation_flag` BOOLEAN COMMENT 'Indicates whether the auditor has confirmed their independence and absence of conflicts of interest for this engagement, as required by audit standards.',
    `modified_by` STRING COMMENT 'The user or system identifier of the person who last modified this engagement assignment record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this engagement assignment record was last modified or updated.',
    `performance_notes` STRING COMMENT 'Detailed notes and feedback on the auditors performance, contributions, and areas for development during this engagement.',
    `performance_rating` STRING COMMENT 'The performance evaluation rating for the auditors work on this specific engagement, used for professional development and resource planning.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `planned_hours` DECIMAL(18,2) COMMENT 'The estimated number of hours allocated for the auditor to complete their assigned work on the engagement.',
    `remote_work_flag` BOOLEAN COMMENT 'Indicates whether the auditor is performing this assignment remotely rather than on-site.',
    `training_hours_earned` DECIMAL(18,2) COMMENT 'The number of Continuing Professional Education (CPE) or training hours earned by the auditor through participation in this engagement.',
    `travel_required_flag` BOOLEAN COMMENT 'Indicates whether the assignment requires the auditor to travel to remote locations or client sites.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'The percentage of the auditors available time allocated to this engagement, calculated as planned hours divided by total available hours.',
    `workpaper_access_level` STRING COMMENT 'The level of access the auditor has to engagement workpapers and documentation based on their role and responsibilities.. Valid values are `full|read_only|restricted|no_access`',
    `created_by` STRING COMMENT 'The user or system identifier of the person who created this engagement assignment record.',
    CONSTRAINT pk_engagement_assignment PRIMARY KEY(`engagement_assignment_id`)
) COMMENT 'Association record linking audit resources (staff) to specific engagements, capturing the role, time allocation, and contribution of each team member. Captures assigned auditor, engagement role (lead auditor, in-charge, staff auditor, subject matter expert, IT auditor), planned hours, actual hours logged, assignment start date, assignment end date, and performance notes. Enables resource utilization tracking, workload balancing, and engagement staffing management across the audit portfolio.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`continuous_monitoring` (
    `continuous_monitoring_id` BIGINT COMMENT 'Unique identifier for the continuous monitoring program record.',
    `benchmark_id` BIGINT COMMENT 'Foreign key linking to security.benchmark. Business justification: Automated monitoring tracks benchmark rate changes, benchmark transition compliance (LIBOR to SOFR), fallback provision triggers, and benchmark discontinuation events. Regulatory compliance monitoring',
    `deposit_account_id` BIGINT COMMENT 'Foreign key linking to account.deposit_account. Business justification: Continuous monitoring programs track account limit breaches (withdrawal limits, transaction limits) for fraud prevention and regulatory compliance. Links monitoring program to accounts being monitored',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Continuous monitoring programs track instrument-level metrics: price movements exceeding thresholds, rating downgrades, concentration limit breaches, liquidity deterioration. Real-time control monitor',
    `compliance_sox_control_id` BIGINT COMMENT 'Identifier of the specific control or process being monitored by this program.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Continuous monitoring programs target specific GL accounts for automated control testing, threshold monitoring, and exception detection. Account linkage is fundamental for continuous auditing and real',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: Automated monitoring detects pricing anomalies: stale prices, price source failures, bid-ask spread violations, price change thresholds. Real-time price quality monitoring requires direct price record',
    `risk_limit_id` BIGINT COMMENT 'Foreign key linking to risk.risk_limit. Business justification: Continuous monitoring programs track risk limit utilization and breaches in real-time. Links monitoring program to the limit being monitored, supporting automated breach detection, escalation, and aud',
    `previous_continuous_monitoring_id` BIGINT COMMENT 'Self-referencing FK on continuous_monitoring (previous_continuous_monitoring_id)',
    `aml_bsa_scope_flag` BOOLEAN COMMENT 'Indicates whether the monitored control is within the scope of AML or BSA compliance requirements (True/False).',
    `audit_committee_reporting_flag` BOOLEAN COMMENT 'Indicates whether exceptions from this monitoring program are reported to the audit committee (True/False).',
    `automation_level` STRING COMMENT 'Degree of automation in the continuous monitoring program (e.g., Fully Automated, Semi-Automated, Manual).. Valid values are `Fully Automated|Semi-Automated|Manual`',
    `ccar_dfast_scope_flag` BOOLEAN COMMENT 'Indicates whether the monitored control is within the scope of CCAR or DFAST regulatory stress testing (True/False).',
    `control_framework` STRING COMMENT 'The control framework or standard under which the monitored control is defined (e.g., COSO, COBIT, ISO 27001, Basel III, SOX). [ENUM-REF-CANDIDATE: COSO|COBIT|ISO 27001|NIST|Basel III|SOX|Custom — 7 candidates stripped; promote to reference product]',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the primary country of operation for the monitored control.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this continuous monitoring program record was first created in the system.',
    `data_source_system` STRING COMMENT 'Name of the source system or application from which monitoring data is extracted (e.g., Core Banking System, Trading System, GL System).',
    `data_source_table` STRING COMMENT 'Specific table, view, or data object within the source system used for monitoring.',
    `escalation_rule` STRING COMMENT 'Business rule defining when and to whom exceptions are escalated (e.g., escalate to senior management if exception count exceeds 10).',
    `escalation_threshold` STRING COMMENT 'Numeric threshold for exception count or severity that triggers escalation to higher management or audit committee.',
    `exception_count_last_run` STRING COMMENT 'Number of exceptions or control breaches detected during the most recent execution of the monitoring program.',
    `exception_criteria` STRING COMMENT 'Detailed business rules or conditions that define when an exception is raised by the monitoring program.',
    `exception_severity` STRING COMMENT 'Severity classification of exceptions raised by this monitoring program (e.g., Critical, High, Medium, Low).. Valid values are `Critical|High|Medium|Low|Informational`',
    `geographic_region` STRING COMMENT 'Geographic region or jurisdiction where the monitored control or process operates (e.g., North America, EMEA, APAC).',
    `last_execution_date` DATE COMMENT 'Date when the continuous monitoring routine was last executed.',
    `last_execution_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the continuous monitoring routine was last executed.',
    `last_review_date` DATE COMMENT 'Date when the continuous monitoring program was last reviewed or validated for effectiveness.',
    `legal_entity_name` STRING COMMENT 'Name of the legal entity to which the monitored control or process belongs.',
    `lob` STRING COMMENT 'Line of business or business unit to which the monitored control or process belongs (e.g., Retail Banking, Investment Banking, Wealth Management).',
    `modified_by` STRING COMMENT 'User ID or name of the individual who last modified this continuous monitoring program record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this continuous monitoring program record was last modified.',
    `monitored_control_name` STRING COMMENT 'Name or description of the control or business process under continuous monitoring.',
    `monitoring_frequency` STRING COMMENT 'Frequency at which the continuous monitoring routine is executed (e.g., Real-Time, Daily, Weekly, Monthly).. Valid values are `Real-Time|Hourly|Daily|Weekly|Monthly|Quarterly`',
    `monitoring_tool` STRING COMMENT 'Name of the software tool or platform used to execute the continuous monitoring routine (e.g., ACL, IDEA, Tableau, custom script).',
    `next_review_date` DATE COMMENT 'Date when the continuous monitoring program is scheduled for its next review or validation.',
    `next_scheduled_execution_date` DATE COMMENT 'Date when the continuous monitoring routine is next scheduled to run.',
    `program_code` STRING COMMENT 'Unique business identifier or code assigned to the continuous monitoring program for reference and tracking.',
    `program_effective_date` DATE COMMENT 'Date when the continuous monitoring program became effective and operational.',
    `program_end_date` DATE COMMENT 'Date when the continuous monitoring program is scheduled to end or was retired (nullable for ongoing programs).',
    `program_name` STRING COMMENT 'Business name of the continuous monitoring program or routine.',
    `program_notes` STRING COMMENT 'Free-text notes or comments about the continuous monitoring program, including special considerations, recent changes, or known issues.',
    `program_owner_email` STRING COMMENT 'Email address of the continuous monitoring program owner for notifications and escalations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `program_owner_name` STRING COMMENT 'Name of the individual or role responsible for the continuous monitoring program.',
    `program_status` STRING COMMENT 'Current operational status of the continuous monitoring program (e.g., Active, Inactive, Suspended, Under Review, Retired).. Valid values are `Active|Inactive|Suspended|Under Review|Retired`',
    `regulatory_driver` STRING COMMENT 'Regulatory requirement or compliance mandate driving the need for continuous monitoring (e.g., SOX Section 404, Basel III, CCAR, AML/BSA).',
    `risk_rating` STRING COMMENT 'Risk rating of the control or process being monitored, reflecting its importance to the overall control environment.. Valid values are `Critical|High|Medium|Low|Minimal`',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether the monitored control is within the scope of SOX Section 404 compliance (True/False).',
    `three_lines_of_defense_level` STRING COMMENT 'The line of defense responsible for the monitored control: First Line (operational management), Second Line (risk and compliance), or Third Line (internal audit).. Valid values are `First Line|Second Line|Third Line`',
    `threshold_operator` STRING COMMENT 'Comparison operator applied to the threshold (e.g., Greater Than, Less Than, Equal To, Between).. Valid values are `Greater Than|Less Than|Equal To|Not Equal To|Between|Outside Range`',
    `threshold_type` STRING COMMENT 'Type of threshold used to define exceptions (e.g., Absolute value, Percentage, Rate, Count, Variance from baseline).. Valid values are `Absolute|Percentage|Rate|Count|Variance`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value that triggers an exception when exceeded or not met.',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this continuous monitoring program record.',
    CONSTRAINT pk_continuous_monitoring PRIMARY KEY(`continuous_monitoring_id`)
) COMMENT 'Continuous auditing and monitoring program record defining automated control monitoring routines executed between formal audit engagements. Captures monitoring program name, monitored control or process, data source, monitoring frequency (daily, weekly, monthly), threshold and exception criteria, last execution date, next scheduled execution date, exception count from last run, escalation rules, and program owner. Supports the shift from periodic to continuous assurance and enables real-time risk signal detection across the banks control environment.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`monitoring_exception` (
    `monitoring_exception_id` BIGINT COMMENT 'Unique identifier for the monitoring exception record. Primary key.',
    `account_transaction_id` BIGINT COMMENT 'Foreign key linking to account.account_transaction. Business justification: Continuous monitoring systems flag suspicious transactions for AML, fraud, or policy violations. Exception records must link to specific transactions for investigation, case management, and regulatory',
    `capture_id` BIGINT COMMENT 'Foreign key linking to trade.trade_capture. Business justification: Continuous monitoring identifies trade booking errors, valuation discrepancies, and regulatory reporting failures. Links exception to flagged trade for investigation, correction, and control remediati',
    `continuous_monitoring_id` BIGINT COMMENT 'Reference to the continuous monitoring program that identified this exception.',
    `employee_id` BIGINT COMMENT 'Identifier of the audit staff member or investigator assigned to review and investigate this exception.',
    `finding_id` BIGINT COMMENT 'Reference to the formal audit finding record if this exception was escalated to a finding, establishing traceability.',
    `execution_id` BIGINT COMMENT 'Foreign key linking to trade.execution. Business justification: Continuous monitoring detects execution anomalies (price outliers, timing violations, venue selection errors) for trade surveillance. Links exception to flagged execution for investigation and best ex',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to ledger.journal_entry. Business justification: Monitoring exceptions flag specific journal entries that violate thresholds or control rules. Direct JE linkage provides audit trail, enables investigation, and supports exception resolution and contr',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to ledger.gl_account. Business justification: Monitoring exceptions relate to specific GL accounts for account-level exception tracking, trend analysis, and control effectiveness assessment. Account linkage enables targeted remediation and thresh',
    `instrument_id` BIGINT COMMENT 'Foreign key linking to security.instrument. Business justification: Monitoring exceptions flag specific instruments violating control thresholds: concentration limits, credit quality deterioration, valuation anomalies, stale pricing. Investigation and disposition trac',
    `loan_account_id` BIGINT COMMENT 'Foreign key linking to loan.loan_account. Business justification: Continuous monitoring exceptions flag specific loan accounts that breach thresholds (e.g., covenant violation, ECL under-provision, NPL misclassification). Exceptions must link to the loan account for',
    `market_risk_position_id` BIGINT COMMENT 'Foreign key linking to risk.market_risk_position. Business justification: Monitoring exceptions flag unusual market risk positions for investigation. Links exception to the specific position, supporting trading desk oversight, VaR breach analysis, and FRTB capital charge va',
    `monitoring_rule_id` BIGINT COMMENT 'Identifier of the specific monitoring rule or control test that detected this exception.',
    `order_id` BIGINT COMMENT 'Foreign key linking to trade.order. Business justification: Continuous monitoring flags suspicious orders (wash trades, spoofing, layering) for market abuse surveillance. Links exception to flagged order for investigation, escalation to compliance, and regulat',
    `price_id` BIGINT COMMENT 'Foreign key linking to security.price. Business justification: Exceptions flag specific price records with quality issues: stale timestamps, missing sources, outlier values, confidence score failures. Investigation workflow requires direct price record identifica',
    `previous_monitoring_exception_id` BIGINT COMMENT 'Self-referencing FK on monitoring_exception (previous_monitoring_exception_id)',
    `actual_value` DECIMAL(18,2) COMMENT 'The actual value observed in the data that triggered the exception, allowing comparison against the threshold.',
    `assigned_investigator_name` STRING COMMENT 'Full name of the investigator assigned to this exception for tracking and accountability purposes.',
    `audit_committee_reported_flag` BOOLEAN COMMENT 'Indicates whether this exception was reported to the audit committee due to its severity or materiality (True/False).',
    `business_unit` STRING COMMENT 'The business unit or division where the exception occurred, enabling organizational segmentation and accountability.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code where the exception occurred, supporting jurisdiction-specific compliance tracking.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this exception record was first created in the system.',
    `data_record_reference` STRING COMMENT 'Reference to the specific data record or transaction that triggered the exception (e.g., transaction ID, account ID, GL entry ID, trade ID).',
    `data_record_type` STRING COMMENT 'Type of data record referenced (e.g., transaction, account, loan, payment, trade, GL entry) to provide context for the data_record_reference.',
    `disposition` STRING COMMENT 'Final disposition or outcome of the exception investigation (escalated to formal audit finding, determined to be false positive, accepted as risk by management, remediated, or pending review).. Valid values are `escalated_to_finding|false_positive|management_accepted_risk|remediated|pending_review`',
    `disposition_date` DATE COMMENT 'The date when the final disposition decision was made for this exception.',
    `disposition_rationale` STRING COMMENT 'Explanation and business justification for the disposition decision, documenting why the exception was classified as it was.',
    `exception_category` STRING COMMENT 'High-level category grouping exceptions by business domain (operational, financial, compliance, security, data integrity, fraud indicator).. Valid values are `operational|financial|compliance|security|data_integrity|fraud_indicator`',
    `exception_date` DATE COMMENT 'The date when the exception or anomaly was identified by the continuous monitoring program.',
    `exception_description` STRING COMMENT 'Detailed narrative description of the exception, including what was detected, the context, and why it was flagged as an anomaly.',
    `exception_number` STRING COMMENT 'Business identifier for the exception, typically a human-readable reference number used in reporting and tracking.',
    `exception_severity` STRING COMMENT 'Severity rating of the exception based on potential impact and risk exposure (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `exception_status` STRING COMMENT 'Current lifecycle status of the exception (open, under investigation, escalated to finding, closed as false positive, closed as accepted risk, closed as remediated).. Valid values are `open|under_investigation|escalated_to_finding|closed_false_positive|closed_accepted_risk|closed_remediated`',
    `exception_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the exception was detected by the monitoring system.',
    `exception_type` STRING COMMENT 'Classification of the exception based on the nature of the anomaly detected (e.g., control failure, policy violation, threshold breach, data quality issue, segregation of duties conflict, unauthorized access).. Valid values are `control_failure|policy_violation|threshold_breach|data_quality_issue|segregation_of_duties_conflict|unauthorized_access`',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the exception in monetary terms, if quantifiable.',
    `financial_impact_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `geographic_region` STRING COMMENT 'Geographic region where the exception occurred (e.g., North America, EMEA, APAC), enabling regional risk analysis.',
    `investigation_notes` STRING COMMENT 'Detailed notes and findings from the investigation process, documenting analysis, evidence reviewed, and preliminary conclusions.',
    `investigation_start_date` DATE COMMENT 'The date when investigation of the exception formally began.',
    `legal_entity_name` STRING COMMENT 'The legal entity within the banking organization where the exception was identified, supporting regulatory and compliance reporting.',
    `lob` STRING COMMENT 'The line of business associated with the exception (e.g., Retail Banking, Investment Banking, Wealth Management, Treasury).',
    `modified_by` STRING COMMENT 'User ID or system identifier that last modified this exception record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this exception record was last modified.',
    `regulatory_framework` STRING COMMENT 'The regulatory framework or compliance requirement relevant to this exception (e.g., SOX, Basel III, AML/BSA, GDPR, CCAR).',
    `regulatory_impact_flag` BOOLEAN COMMENT 'Indicates whether this exception has potential regulatory reporting or compliance implications (True/False).',
    `resolution_action` STRING COMMENT 'Description of the corrective or remedial action taken to resolve the exception, if applicable.',
    `resolution_date` DATE COMMENT 'The date when the exception was fully resolved and closed, marking the end of its lifecycle.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the exception based on likelihood and impact assessment.. Valid values are `critical|high|medium|low|negligible`',
    `source_system_name` STRING COMMENT 'Name of the operational system from which the exception data originated (e.g., Core Banking System, Trading System, Payment Hub).',
    `three_lines_position` STRING COMMENT 'Identifies which line of defense in the three lines of defense model is responsible for this exception (first line operations, second line risk/compliance, third line internal audit).. Valid values are `first_line|second_line|third_line`',
    `threshold_value` DECIMAL(18,2) COMMENT 'The threshold or limit value defined in the monitoring rule that was breached, if applicable.',
    `variance_amount` DECIMAL(18,2) COMMENT 'The calculated difference between the actual value and the threshold value, representing the magnitude of the breach.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'The variance expressed as a percentage of the threshold value, providing relative context for the exception severity.',
    `created_by` STRING COMMENT 'User ID or system identifier that created this exception record.',
    CONSTRAINT pk_monitoring_exception PRIMARY KEY(`monitoring_exception_id`)
) COMMENT 'Transactional record of each exception or anomaly identified by a continuous monitoring program. Captures exception date, monitoring program reference, exception type, exception description, data record reference (transaction ID, account ID, etc.), exception severity, assigned investigator, investigation status, disposition (escalated to finding, false positive, management accepted risk), and resolution date. Provides the operational event log for continuous monitoring activity and feeds the finding pipeline when exceptions warrant formal audit action.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`regulatory_audit` (
    `regulatory_audit_id` BIGINT COMMENT 'Unique identifier for the regulatory audit examination record. Primary key for the regulatory audit entity.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Regulatory audits are country-specific examinations determining regulatory authority and framework. Essential for banking regulatory compliance. Replaces existing country_code with proper FK.',
    `fund_regulatory_report_id` BIGINT COMMENT 'Foreign key linking to asset.fund_regulatory_report. Business justification: External regulator examinations (SEC, FCA) review filed regulatory reports for accuracy and completeness. Direct linkage enables tracking of examination scope, findings related to specific filings, an',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Regulatory audits are conducted under specific jurisdictional frameworks defining examination scope, standards, and regulatory authority. Replaces country_code with proper jurisdiction reference for b',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Regulatory examinations target specific legal entities for regulatory compliance assessment, CAMELS rating, and supervisory coordination. Legal entity linkage is mandatory for regulatory response and ',
    `plan_id` BIGINT COMMENT 'Foreign key linking to audit.plan. Business justification: Regulatory examinations are coordinated with internal audit planning cycles to ensure coverage alignment and avoid duplication. The plan provides the strategic context for how internal audit will coor',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_taxonomy. Business justification: Regulatory audits assess compliance with specific taxonomies defining examination scope and reporting requirements. Replaces text regulatory_framework with proper reference for banking regulatory exam',
    `stress_scenario_id` BIGINT COMMENT 'Foreign key linking to risk.stress_scenario. Business justification: Regulatory audits (CCAR/DFAST) examine specific stress scenarios prescribed by regulators. Links exam to scenario, supporting regulatory response, scenario validation, and capital planning governance.',
    `universe_id` BIGINT COMMENT 'Foreign key linking to audit.audit_universe. Business justification: regulatory_audit captures external regulatory examinations conducted by OCC, Fed, FDIC, etc. These examinations target specific business units or legal entities within the bank. audit_universe is the ',
    `previous_regulatory_audit_id` BIGINT COMMENT 'Self-referencing FK on regulatory_audit (previous_regulatory_audit_id)',
    `asset_quality_rating` STRING COMMENT 'CAMELS component rating for asset quality. Evaluates the quality of loan and investment portfolios, credit risk management, and adequacy of loan loss reserves. Ratings range from 1 (strongest) to 5 (weakest).. Valid values are `1|2|3|4|5`',
    `audit_committee_report_date` DATE COMMENT 'Date when the regulatory examination results were formally presented to the board audit committee. Documents when board-level oversight was engaged.',
    `audit_committee_reported_flag` BOOLEAN COMMENT 'Indicates whether this regulatory examination has been formally reported to the board audit committee. True if reported, false if not yet reported.',
    `capital_adequacy_rating` STRING COMMENT 'CAMELS component rating for capital adequacy. Assesses the quantity and quality of capital relative to the institutions risk profile. Ratings range from 1 (strongest) to 5 (weakest).. Valid values are `1|2|3|4|5`',
    `composite_rating` STRING COMMENT 'Overall composite rating assigned by the regulator based on the CAMELS rating system (Capital adequacy, Asset quality, Management, Earnings, Liquidity, Sensitivity to market risk). Ratings range from 1 (strongest) to 5 (weakest).. Valid values are `1|2|3|4|5`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory audit record was first created in the system. Audit trail for record creation.',
    `earnings_rating` STRING COMMENT 'CAMELS component rating for earnings performance. Evaluates the quality, quantity, and sustainability of earnings. Ratings range from 1 (strongest) to 5 (weakest).. Valid values are `1|2|3|4|5`',
    `examination_end_date` DATE COMMENT 'Date when the regulatory examination fieldwork officially concluded. Marks the completion of on-site or remote examination activities by the regulatory team.',
    `examination_notes` STRING COMMENT 'Additional notes, observations, or context regarding the regulatory examination. Captures supplementary information not covered in structured fields.',
    `examination_number` STRING COMMENT 'Official examination reference number assigned by the regulatory body conducting the examination. This is the externally-known identifier used in all regulatory correspondence and documentation.',
    `examination_period_end_date` DATE COMMENT 'Ending date of the period under examination. Defines the end of the timeframe for which business activities, transactions, and controls are being reviewed by the regulator.',
    `examination_period_start_date` DATE COMMENT 'Beginning date of the period under examination. Defines the start of the timeframe for which business activities, transactions, and controls are being reviewed by the regulator.',
    `examination_scope_description` STRING COMMENT 'Comprehensive narrative description of the examination scope including specific business lines, legal entities, geographic regions, systems, processes, and risk areas covered during the regulatory review.',
    `examination_start_date` DATE COMMENT 'Date when the regulatory examination fieldwork officially commenced. Marks the beginning of on-site or remote examination activities by the regulatory team.',
    `examination_status` STRING COMMENT 'Current lifecycle status of the regulatory examination. Tracks the examination from initial scheduling through final closure and response submission. [ENUM-REF-CANDIDATE: scheduled|in progress|fieldwork complete|preliminary findings issued|final report issued|response submitted|closed — 7 candidates stripped; promote to reference product]',
    `examination_type` STRING COMMENT 'Classification of the regulatory examination based on its primary focus area. Determines the scope and nature of the supervisory review being conducted.. Valid values are `safety and soundness|BSA/AML|consumer compliance|capital adequacy|IT examination|operational risk`',
    `final_findings_count` STRING COMMENT 'Number of final findings, matters requiring attention, or supervisory recommendations documented in the final examination report. Represents confirmed regulatory concerns requiring remediation.',
    `final_report_received_date` DATE COMMENT 'Date when the final examination report was officially received from the regulatory body. Marks the formal conclusion of the examination process.',
    `geographic_region` STRING COMMENT 'Geographic region or market area covered by the examination scope. Identifies the territorial boundaries of the regulatory review.',
    `internal_audit_liaison_email` STRING COMMENT 'Email address of the internal audit liaison coordinating the regulatory examination response. Primary internal contact for examination coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `internal_audit_liaison_name` STRING COMMENT 'Full name of the internal audit staff member designated as the primary liaison and coordinator for this regulatory examination. Responsible for coordinating internal responses and documentation requests.',
    `lead_examiner_email` STRING COMMENT 'Official email address of the lead examiner from the regulatory body. Used for formal examination correspondence and information requests.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `lead_examiner_name` STRING COMMENT 'Full name of the lead examiner from the regulatory body who is responsible for directing the examination. Primary point of contact from the regulatory authority.',
    `lead_examiner_phone` STRING COMMENT 'Direct contact phone number for the lead examiner from the regulatory body. Enables direct communication during the examination process.',
    `liquidity_rating` STRING COMMENT 'CAMELS component rating for liquidity position. Assesses the adequacy of liquidity sources relative to present and future needs, and the ability to meet obligations. Ratings range from 1 (strongest) to 5 (weakest).. Valid values are `1|2|3|4|5`',
    `management_rating` STRING COMMENT 'CAMELS component rating for management capability. Assesses the competence of management and the board of directors, compliance with laws and regulations, and overall governance. Ratings range from 1 (strongest) to 5 (weakest).. Valid values are `1|2|3|4|5`',
    `matter_requiring_attention_count` STRING COMMENT 'Number of Matters Requiring Attention (MRA) formally issued by the regulator. MRAs are supervisory concerns that require prompt corrective action and board-level attention.',
    `matter_requiring_immediate_attention_count` STRING COMMENT 'Number of Matters Requiring Immediate Attention (MRIA) formally issued by the regulator. MRIAs are the most severe supervisory concerns requiring urgent corrective action and heightened board oversight.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this regulatory audit record. Audit trail for accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this regulatory audit record was last modified. Audit trail for record updates.',
    `preliminary_findings_count` STRING COMMENT 'Number of preliminary findings, observations, or matters requiring attention identified by the regulatory examiners during the examination. Indicates the volume of issues discovered.',
    `regulator_name` STRING COMMENT 'Name of the regulatory body or supervisory authority conducting the examination. Identifies which governing body is performing the regulatory review. [ENUM-REF-CANDIDATE: OCC|Federal Reserve|FDIC|CFPB|FinCEN|SEC|FINRA|CFTC|EBA|PRA — 10 candidates stripped; promote to reference product]',
    `response_due_date` DATE COMMENT 'Date by which the institution must submit its formal written response to the regulatory examination findings. Deadline for providing remediation plans and management responses.',
    `response_submitted_date` DATE COMMENT 'Date when the institutions formal written response to the regulatory examination findings was submitted to the regulator. Documents compliance with response deadlines.',
    `scope_areas` STRING COMMENT 'Detailed description of the business areas, processes, systems, and controls included within the scope of the regulatory examination. Defines what will be reviewed during the examination.',
    `sensitivity_to_market_risk_rating` STRING COMMENT 'CAMELS component rating for sensitivity to market risk. Evaluates the degree to which changes in interest rates, foreign exchange rates, commodity prices, or equity prices can adversely affect earnings or capital. Ratings range from 1 (strongest) to 5 (weakest).. Valid values are `1|2|3|4|5`',
    `created_by` STRING COMMENT 'User identifier or system account that created this regulatory audit record. Audit trail for accountability.',
    CONSTRAINT pk_regulatory_audit PRIMARY KEY(`regulatory_audit_id`)
) COMMENT 'Master record for external regulatory examinations and supervisory reviews conducted by governing bodies (OCC, Federal Reserve, FDIC, CFPB, FinCEN, SEC, FINRA) that require internal audit coordination and response. Captures regulator name, examination type (safety and soundness, BSA/AML, consumer compliance, capital adequacy, IT examination), examination period, examination start and end dates, lead examiner, internal audit liaison, scope areas, preliminary findings count, and examination status. Distinct from internal audit engagements as these are externally driven and carry regulatory consequence.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`regulatory_finding` (
    `regulatory_finding_id` BIGINT COMMENT 'Unique identifier for the regulatory finding record issued by an external regulator during a supervisory examination.',
    `party_id` BIGINT COMMENT 'Foreign key linking to customer.party. Business justification: Regulatory findings may cite specific customer cases as examples of control failures (AML violations, BSA deficiencies, fair lending issues). Links finding to customer for remediation tracking, relati',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: Regulatory findings are issued under country-specific regulations and regulatory authorities. Essential for compliance tracking, remediation planning, and regulatory reporting in banking.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to reference.jurisdiction. Business justification: Regulatory findings cite jurisdiction-specific violations and regulatory frameworks. Essential for compliance tracking, remediation planning, and regulatory reporting in banking operations.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Regulatory findings are issued against specific legal entities for regulatory response, board escalation, and enforcement action tracking. Legal entity attribution is mandatory for regulatory complian',
    `regulatory_audit_id` BIGINT COMMENT 'Foreign key linking to audit.regulatory_audit. Business justification: Each regulatory finding is issued within the context of a specific regulatory examination. The regulatory_audit provides the examination metadata (regulator, scope, dates, ratings). Currently regulato',
    `regulatory_exam_id` BIGINT COMMENT 'Reference to the regulatory examination or supervisory review during which this finding was issued.',
    `regulatory_taxonomy_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_taxonomy. Business justification: Regulatory findings cite specific taxonomy violations and regulatory requirements. Required for remediation tracking and regulatory reporting. Replaces text regulatory_framework with proper FK.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Regulatory findings assign remediation responsibility to cost centers. Cost center linkage enables accountability tracking, budget allocation for remediation, and organizational performance assessment',
    `stress_test_run_id` BIGINT COMMENT 'Foreign key linking to risk.stress_test_run. Business justification: Regulatory findings from CCAR/DFAST examinations reference specific stress test runs. Links examiner finding to the run under review, supporting regulatory response, remediation tracking, and capital ',
    `superseded_regulatory_finding_id` BIGINT COMMENT 'Self-referencing FK on regulatory_finding (superseded_regulatory_finding_id)',
    `board_escalation_flag` BOOLEAN COMMENT 'Indicates whether the finding was escalated to the Board of Directors or Audit Committee due to severity, regulatory consequence, or materiality (True/False).',
    `board_reporting_date` DATE COMMENT 'Date on which the finding was reported to the Board of Directors or Audit Committee.',
    `business_line` STRING COMMENT 'Line of business or business unit to which the finding applies (e.g., Retail Banking, Commercial Lending, Investment Banking, Wealth Management, Treasury).',
    `closure_date` DATE COMMENT 'Date on which the regulatory finding was formally closed, either by regulator acceptance of remediation or by internal closure after validation.',
    `closure_status` STRING COMMENT 'Current closure status of the regulatory finding (Open, Closed, Pending Validation by regulator, Reopened due to ineffective remediation).. Valid values are `Open|Closed|Pending Validation|Reopened`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory finding record was first created in the system.',
    `enforcement_action_flag` BOOLEAN COMMENT 'Indicates whether the finding resulted in or is associated with a formal enforcement action by the regulator (e.g., consent order, cease and desist order, civil money penalty) (True/False).',
    `enforcement_action_reference` STRING COMMENT 'Reference number or citation of the formal enforcement action if applicable (e.g., consent order number, docket number).',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial impact of the finding, including potential fines, penalties, restitution, or remediation costs.',
    `financial_impact_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the financial impact amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `finding_description` STRING COMMENT 'Detailed description of the regulatory finding, including the deficiency identified, the control weakness, and the regulatory concern as documented by the examiner.',
    `finding_number` STRING COMMENT 'Unique finding number or identifier assigned by the regulator within the examination report (e.g., Finding 2023-001, MRA-2023-05).',
    `finding_title` STRING COMMENT 'Short title or summary of the regulatory finding as stated in the examination report.',
    `finding_type` STRING COMMENT 'Classification of the regulatory finding: MRA (Matter Requiring Attention), MRIA (Matter Requiring Immediate Attention), Violation (regulatory breach), Informal Action (supervisory letter or commitment), Recommendation, or Observation.. Valid values are `MRA|MRIA|Violation|Informal Action|Recommendation|Observation`',
    `geographic_scope` STRING COMMENT 'Geographic region, country, or jurisdiction to which the finding applies (e.g., United States, United Kingdom, Asia-Pacific, Global).',
    `issue_date` DATE COMMENT 'Date on which the regulatory finding was formally issued or communicated to the bank by the regulator.',
    `modified_by` STRING COMMENT 'User ID or name of the individual who last modified the regulatory finding record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory finding record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or context regarding the regulatory finding, remediation progress, or regulator interactions.',
    `prior_finding_reference` STRING COMMENT 'Reference to the prior regulatory finding or examination number if this is a repeat finding.',
    `regulator_closure_confirmation_flag` BOOLEAN COMMENT 'Indicates whether the regulator has formally confirmed closure of the finding (True) or whether closure is internal only pending regulator review (False).',
    `regulator_name` STRING COMMENT 'Name of the external regulatory body that issued the finding (e.g., Office of the Comptroller of the Currency, Federal Reserve, Federal Deposit Insurance Corporation, Consumer Financial Protection Bureau, Financial Crimes Enforcement Network). [ENUM-REF-CANDIDATE: OCC|Federal Reserve|FDIC|CFPB|FinCEN|SEC|FINRA|State Banking Authority|Other — 9 candidates stripped; promote to reference product]',
    `regulator_office` STRING COMMENT 'Specific office, district, or regional division of the regulator that conducted the examination (e.g., OCC District Office, Federal Reserve Bank of New York).',
    `regulatory_citation` STRING COMMENT 'Specific regulation, statute, guidance, or supervisory standard cited by the regulator as the basis for the finding (e.g., 12 CFR 30, Federal Reserve SR 11-7, BSA/AML requirements).',
    `remediation_commitment` STRING COMMENT 'Summary of the banks committed remediation actions and corrective measures as documented in the formal response to the regulator.',
    `remediation_due_date` DATE COMMENT 'Target date by which the bank has committed to complete all remediation actions and close the finding, as agreed with the regulator.',
    `remediation_owner` STRING COMMENT 'Name or title of the executive, business unit head, or control function owner responsible for executing the remediation plan and closing the finding.',
    `remediation_status` STRING COMMENT 'Current status of remediation activities (Not Started, In Progress, Completed, Validated by internal audit or compliance, Overdue).. Valid values are `Not Started|In Progress|Completed|Validated|Overdue`',
    `repeat_finding_flag` BOOLEAN COMMENT 'Indicates whether this finding is a repeat or recurring issue previously identified in a prior examination (True/False). Repeat findings typically carry higher regulatory scrutiny.',
    `response_due_date` DATE COMMENT 'Date by which the bank is required to submit a formal written response to the regulator addressing the finding and outlining remediation plans.',
    `response_status` STRING COMMENT 'Current status of the banks formal response to the regulator (Not Started, In Progress, Submitted, Accepted by regulator, Rejected by regulator, Resubmitted).. Valid values are `Not Started|In Progress|Submitted|Accepted|Rejected|Resubmitted`',
    `response_submitted_date` DATE COMMENT 'Date on which the bank submitted its formal written response to the regulator.',
    `root_cause_analysis` STRING COMMENT 'Summary of the root cause analysis conducted by the bank to identify the underlying cause of the deficiency (e.g., process gap, control weakness, resource constraint, system limitation).',
    `severity_level` STRING COMMENT 'Internal severity classification assigned to the finding based on risk impact, regulatory consequence, and remediation urgency (Critical, High, Moderate, Low).. Valid values are `Critical|High|Moderate|Low`',
    `three_lines_of_defense_level` STRING COMMENT 'Classification of which line of defense is primarily responsible for addressing the finding: First Line (business unit), Second Line (risk/compliance), or Third Line (internal audit).. Valid values are `First Line|Second Line|Third Line`',
    `validation_date` DATE COMMENT 'Date on which internal audit, compliance, or risk management validated that the remediation actions were completed and effective.',
    `created_by` STRING COMMENT 'User ID or name of the individual who created the regulatory finding record.',
    CONSTRAINT pk_regulatory_finding PRIMARY KEY(`regulatory_finding_id`)
) COMMENT 'Finding record issued by an external regulator (OCC, Fed, FDIC, CFPB, FinCEN) during a supervisory examination, requiring formal bank response and remediation tracking. Captures regulator name, examination reference, finding type (MRA – Matter Requiring Attention, MRIA – Matter Requiring Immediate Attention, violation, informal action), finding description, regulatory citation, severity, bank response due date, response submitted date, remediation commitment, and closure status. Tracked separately from internal audit findings due to regulatory consequence, formal response obligations, and board-level escalation requirements.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`committee_report` (
    `committee_report_id` BIGINT COMMENT 'Unique identifier for the audit committee report record.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual who approved this report for submission to the audit committee.',
    `committee_prepared_by_employee_id` BIGINT COMMENT 'Identifier of the internal audit staff member who prepared this report.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Audit committee reports often cover specific legal entities for board governance, regulatory oversight, and entity-level risk assessment. Legal entity linkage enables entity-specific board reporting.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to audit.audit_plan. Business justification: audit_committee_report presents periodic reporting to the audit committee covering plan execution status, findings, and budget performance. Each report should reference the audit_plan for that reporti',
    `primary_committee_employee_id` BIGINT COMMENT 'Identifier of the audit committee chair to whom this report was presented.',
    `previous_committee_report_id` BIGINT COMMENT 'Self-referencing FK on committee_report (previous_committee_report_id)',
    `actual_hours` DECIMAL(18,2) COMMENT 'Total actual audit hours consumed during the reporting period.',
    `aml_bsa_audit_status` STRING COMMENT 'Status of audit activities related to Anti-Money Laundering and Bank Secrecy Act compliance programs.. Valid values are `not_started|in_progress|completed|not_applicable`',
    `budgeted_hours` DECIMAL(18,2) COMMENT 'Total budgeted audit hours for the reporting period.',
    `cae_independence_attestation` BOOLEAN COMMENT 'Boolean flag indicating whether the Chief Audit Executive has attested to organizational independence and objectivity for the reporting period.',
    `ccar_dfast_audit_status` STRING COMMENT 'Status of audit activities related to CCAR and DFAST stress testing processes and capital planning.. Valid values are `not_started|in_progress|completed|not_applicable`',
    `committee_feedback` STRING COMMENT 'Feedback, questions, or directives provided by the audit committee in response to this report.',
    `committee_meeting_date` DATE COMMENT 'The date on which the audit committee meeting was held to review this report.',
    `continuous_monitoring_summary` STRING COMMENT 'Summary of continuous monitoring activities, including automated control testing and real-time risk indicators.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit committee report record was first created in the system.',
    `external_auditor_coordination` STRING COMMENT 'Summary of coordination activities with external auditors, including reliance on internal audit work and joint planning efforts.',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter (1-4) to which this audit committee report pertains, if applicable.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this audit committee report pertains.',
    `high_risk_findings_count` STRING COMMENT 'Number of open audit findings rated as high risk or critical.',
    `key_risk_indicators_summary` STRING COMMENT 'Summary of key risk indicators monitored during the reporting period and any threshold breaches or trends.',
    `low_risk_findings_count` STRING COMMENT 'Number of open audit findings rated as low risk.',
    `medium_risk_findings_count` STRING COMMENT 'Number of open audit findings rated as medium risk.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit committee report record was last modified.',
    `next_report_due_date` DATE COMMENT 'The scheduled due date for the next audit committee report.',
    `notes` STRING COMMENT 'Additional notes, context, or commentary related to this audit committee report.',
    `open_findings_count` STRING COMMENT 'Total number of audit findings that remain open as of the report date.',
    `overdue_actions_count` STRING COMMENT 'Number of remediation actions that are past their target completion date.',
    `plan_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of the annual audit plan completed as of the report date, expressed as a decimal (e.g., 75.50 for 75.5%).',
    `quality_assurance_results` STRING COMMENT 'Results of internal quality assurance reviews or external quality assessments of the internal audit function, including ratings and improvement recommendations.',
    `regulatory_examination_status` STRING COMMENT 'Current status of regulatory examinations by bodies such as Federal Reserve, OCC, FDIC, or SEC.. Valid values are `no_active_exams|in_progress|completed|pending_response`',
    `regulatory_examination_summary` STRING COMMENT 'Summary of findings, observations, and action items from recent regulatory examinations.',
    `report_approval_date` DATE COMMENT 'The date on which the audit committee formally approved this report.',
    `report_document_reference` STRING COMMENT 'Reference identifier or file path to the formal audit committee report document stored in the document management system.',
    `report_period_end_date` DATE COMMENT 'The ending date of the reporting period covered by this audit committee report.',
    `report_period_start_date` DATE COMMENT 'The beginning date of the reporting period covered by this audit committee report.',
    `report_presentation_date` DATE COMMENT 'The date on which this report was presented to the audit committee during the meeting.',
    `report_status` STRING COMMENT 'Current status of the audit committee report in its lifecycle (draft, submitted, presented, approved, archived).. Valid values are `draft|submitted|presented|approved|archived`',
    `report_submission_date` DATE COMMENT 'The date on which this report was formally submitted to the audit committee.',
    `report_type` STRING COMMENT 'The type of audit committee report being submitted (e.g., quarterly update, annual plan approval, Chief Audit Executive assessment, special review, regulatory coordination, quality assurance).. Valid values are `quarterly_update|annual_plan_approval|cae_assessment|special_review|regulatory_coordination|quality_assurance`',
    `significant_findings_summary` STRING COMMENT 'Executive summary of the most significant audit findings identified during the reporting period, including key risks and control deficiencies.',
    `sox_compliance_status` STRING COMMENT 'Status of Sarbanes-Oxley Act compliance activities and internal control over financial reporting (ICFR) testing.. Valid values are `compliant|non_compliant|remediation_in_progress|not_applicable`',
    `three_lines_model_assessment` STRING COMMENT 'Assessment of the effectiveness of the three lines of defense model (business line controls, risk management and compliance, internal audit) during the reporting period.',
    `variance_hours` DECIMAL(18,2) COMMENT 'Variance between budgeted and actual audit hours (actual minus budgeted).',
    CONSTRAINT pk_committee_report PRIMARY KEY(`committee_report_id`)
) COMMENT 'Formal Audit Committee reporting package record capturing the periodic (quarterly/annual) reporting delivered to the Board Audit Committee. Captures reporting period, meeting date, report type (quarterly update, annual plan approval, CAE assessment), key metrics (open findings by rating, overdue actions, plan completion percentage, budget vs. actual hours), significant findings summary, regulatory examination status, quality assurance results, and CAE independence attestation. Supports board-level governance oversight of the internal audit function.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique identifier for the audit risk assessment record.',
    `employee_id` BIGINT COMMENT 'Reference to the internal auditor or risk analyst who performed this risk assessment.',
    `reviewer_employee_id` BIGINT COMMENT 'Reference to the senior auditor or Chief Audit Executive (CAE) who reviewed and approved this risk assessment.',
    `universe_id` BIGINT COMMENT 'Reference to the auditable entity in the audit universe being assessed.',
    `previous_risk_assessment_id` BIGINT COMMENT 'Self-referencing FK on risk_assessment (previous_risk_assessment_id)',
    `aml_bsa_scope_flag` BOOLEAN COMMENT 'Indicates whether this auditable entity is within the scope of AML/BSA compliance and monitoring programs.',
    `approval_date` DATE COMMENT 'The date on which this risk assessment was formally approved by the Chief Audit Executive or designated reviewer.',
    `assessment_cycle` STRING COMMENT 'The frequency or trigger for this risk assessment (annual, semi-annual, quarterly, event-driven, ad-hoc, continuous).. Valid values are `annual|semi-annual|quarterly|event-driven|ad-hoc|continuous`',
    `assessment_date` DATE COMMENT 'The date on which this risk assessment was performed.',
    `assessment_methodology` STRING COMMENT 'The methodology used to perform this risk assessment (quantitative scoring, qualitative judgment, hybrid, scenario-based, heat-map).. Valid values are `quantitative|qualitative|hybrid|scenario-based|heat-map`',
    `assessment_notes` STRING COMMENT 'Free-text notes capturing additional context, rationale, or observations from the risk assessment process.',
    `assessment_period_end_date` DATE COMMENT 'The end date of the period covered by this risk assessment.',
    `assessment_period_start_date` DATE COMMENT 'The start date of the period covered by this risk assessment.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of this risk assessment record (draft, in-review, approved, superseded, archived).. Valid values are `draft|in-review|approved|superseded|archived`',
    `audit_committee_reporting_flag` BOOLEAN COMMENT 'Indicates whether this risk assessment and associated audit plan coverage must be reported to the Audit Committee of the Board of Directors.',
    `ccar_dfast_scope_flag` BOOLEAN COMMENT 'Indicates whether this auditable entity is within the scope of CCAR or DFAST stress testing and capital planning processes.',
    `cecl_ifrs9_scope_flag` BOOLEAN COMMENT 'Indicates whether this auditable entity is within the scope of CECL or IFRS 9 expected credit loss modeling and reporting.',
    `change_activity_score` DECIMAL(18,2) COMMENT 'Risk score component reflecting the volume and significance of recent changes (system upgrades, process redesigns, organizational restructuring) affecting the entity.',
    `complexity_factor_score` DECIMAL(18,2) COMMENT 'Risk score component reflecting the operational and organizational complexity of the auditable entity.',
    `continuous_monitoring_flag` BOOLEAN COMMENT 'Indicates whether this auditable entity is subject to continuous monitoring or continuous auditing processes rather than periodic audits.',
    `control_environment_rating` STRING COMMENT 'Qualitative assessment of the strength and maturity of the control environment for this auditable entity.. Valid values are `strong|adequate|needs-improvement|weak|not-assessed`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit risk assessment record was first created in the system.',
    `external_audit_coordination_flag` BOOLEAN COMMENT 'Indicates whether this auditable entity requires coordination with external auditors for reliance or joint testing.',
    `financial_materiality_score` DECIMAL(18,2) COMMENT 'Risk score component reflecting the financial significance of the entity in terms of revenue, assets, or risk-weighted assets (RWA).',
    `inherent_risk_score` DECIMAL(18,2) COMMENT 'The calculated inherent risk score before considering controls, typically on a scale of 0-100 or 1-5.',
    `key_risk_indicators` STRING COMMENT 'Comma-separated list or description of key risk indicators monitored for this auditable entity to track risk trends.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this audit risk assessment record was last modified.',
    `next_assessment_due_date` DATE COMMENT 'The scheduled date for the next risk assessment of this auditable entity based on the assessment cycle.',
    `prior_findings_score` DECIMAL(18,2) COMMENT 'Risk score component reflecting the severity and volume of findings from prior audits, regulatory examinations, or continuous monitoring.',
    `recommended_audit_frequency` STRING COMMENT 'The recommended frequency for auditing this entity based on the risk assessment results.. Valid values are `quarterly|semi-annual|annual|biennial|triennial|as-needed`',
    `recommended_audit_scope` STRING COMMENT 'The recommended scope or depth of audit coverage for this entity based on risk assessment.. Valid values are `comprehensive|targeted|limited|continuous-monitoring|advisory`',
    `regulatory_examination_flag` BOOLEAN COMMENT 'Indicates whether this auditable entity is subject to periodic regulatory examinations by banking supervisors (Fed, OCC, FDIC, etc.).',
    `regulatory_exposure_score` DECIMAL(18,2) COMMENT 'Risk score component reflecting the degree of regulatory scrutiny and compliance requirements applicable to the entity.',
    `regulatory_framework` STRING COMMENT 'Primary regulatory framework or standard applicable to this auditable entity (e.g., Basel III, Dodd-Frank, SOX, GDPR, AML/BSA).',
    `residual_risk_score` DECIMAL(18,2) COMMENT 'The calculated residual risk score after considering the control environment, used for audit prioritization.',
    `risk_appetite_alignment` STRING COMMENT 'Indicates whether the residual risk for this entity is within the organizations stated risk appetite or tolerance levels.. Valid values are `within-appetite|near-limit|exceeds-appetite|not-applicable`',
    `risk_ranking` STRING COMMENT 'The ordinal ranking of this auditable entity within the audit universe based on residual risk score, used for audit plan prioritization.',
    `risk_rating` STRING COMMENT 'Categorical risk rating (critical, high, medium, low, minimal) derived from the residual risk score.. Valid values are `critical|high|medium|low|minimal`',
    `risk_trend` STRING COMMENT 'The observed trend in risk level for this auditable entity compared to prior assessments (increasing, stable, decreasing, new-risk, emerging).. Valid values are `increasing|stable|decreasing|new-risk|emerging`',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this auditable entity is within the scope of SOX Section 404 internal control testing.',
    `three_lines_of_defense_level` STRING COMMENT 'The line of defense responsible for primary oversight of this entity (first-line operations, second-line risk/compliance, third-line internal audit, or combined assurance).. Valid values are `first-line|second-line|third-line|combined-assurance`',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Audit risk assessment record capturing the periodic evaluation of inherent and residual risk for each auditable entity in the audit universe, used to prioritize the annual audit plan. Captures assessment date, assessment cycle (annual, semi-annual, event-driven), auditable entity reference, inherent risk factors (complexity, regulatory exposure, financial materiality, change activity, prior findings), control environment rating, residual risk score, risk ranking, and recommended audit frequency. The primary input to risk-based audit planning and universe prioritization.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`three_lines_assignment` (
    `three_lines_assignment_id` BIGINT COMMENT 'Unique identifier for the three lines of defense assignment record.',
    `appetite_id` BIGINT COMMENT 'Foreign key linking to risk.risk_appetite. Business justification: Three lines assignments define accountability for risk appetite metrics across defense lines. Links assignment to appetite statement, supporting governance clarity, risk appetite monitoring, and audit',
    `compliance_sox_control_id` BIGINT COMMENT 'Unique identifier for the control within the banks control framework, linking to the control library or risk and control matrix.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Three lines model assigns control ownership to cost centers for accountability, governance, and control effectiveness assessment. Cost center linkage defines control ownership and enables organization',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Three lines assignments are scoped to legal entities for governance structure, control ownership, and accountability framework. Legal entity linkage defines assignment scope and replaces denormalized ',
    `universe_id` BIGINT COMMENT 'Foreign key linking to audit.audit_universe. Business justification: three_lines_assignment maps business units, processes, and control activities to the three lines of defense model. audit_universe is the comprehensive registry of auditable entities (business units, p',
    `related_three_lines_assignment_id` BIGINT COMMENT 'Self-referencing FK on three_lines_assignment (related_three_lines_assignment_id)',
    `accountability_clarity_score` DECIMAL(18,2) COMMENT 'A score (0-100) representing the clarity and completeness of accountability mapping for this assignment, used to identify gaps or overlaps in the three lines model.',
    `aml_bsa_scope_flag` BOOLEAN COMMENT 'Indicates whether this assignment is part of the banks AML/BSA compliance program and financial crime prevention framework.',
    `approval_date` DATE COMMENT 'The date on which this assignment was formally approved by the designated authority.',
    `approved_by_name` STRING COMMENT 'Name of the individual who approved this three lines assignment (e.g., Chief Audit Executive, Chief Risk Officer, Audit Committee Chair).',
    `assigned_line_of_defense` STRING COMMENT 'The line of defense to which this control activity is assigned: first line (business management and operational controls), second line (risk management and compliance oversight), or third line (internal audit independent assurance).. Valid values are `first_line|second_line|third_line`',
    `assignment_code` STRING COMMENT 'Business identifier code for the three lines assignment, used for external reference and reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `assignment_rationale` STRING COMMENT 'Business justification and rationale for assigning this control activity to the designated line of defense, including risk considerations and organizational structure.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the three lines assignment record (e.g., active, inactive, under review, pending approval, superseded).. Valid values are `active|inactive|under_review|pending_approval|superseded`',
    `audit_committee_reporting_flag` BOOLEAN COMMENT 'Indicates whether this assignment is included in regular reporting to the audit committee or board of directors.',
    `audit_coverage_responsibility` STRING COMMENT 'The internal audit team or function responsible for providing independent assurance over this control domain (e.g., Financial Audit, Operational Audit, IT Audit, Compliance Audit).',
    `audit_lead_name` STRING COMMENT 'Name of the audit lead or senior auditor responsible for third line assurance activities related to this assignment.',
    `business_unit` STRING COMMENT 'The business unit or organizational division to which this three lines assignment applies (e.g., Retail Banking, Investment Banking, Treasury).',
    `ccar_dfast_scope_flag` BOOLEAN COMMENT 'Indicates whether this assignment is relevant to CCAR or DFAST stress testing and capital planning processes.',
    `control_activity` STRING COMMENT 'The specific control activity or control process being assigned to a line of defense (e.g., loan approval process, trade reconciliation, KYC verification).',
    `control_framework` STRING COMMENT 'The control framework or standard under which this assignment is governed (e.g., COSO, COBIT, Basel III, SOX, GDPR).',
    `control_owner_email` STRING COMMENT 'Email address of the control owner for communication and escalation purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `control_owner_name` STRING COMMENT 'Name of the individual or role responsible for owning and executing the control activity within the assigned line of defense.',
    `control_owner_title` STRING COMMENT 'Job title or role designation of the control owner (e.g., Credit Risk Manager, Compliance Officer, Business Unit Head).',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this three lines assignment record was first created in the system.',
    `effective_date` DATE COMMENT 'The date from which this three lines assignment becomes effective and operational.',
    `escalation_protocol` STRING COMMENT 'Defined escalation path and protocol for issues or breaches identified within this control domain, specifying communication channels and decision authority.',
    `expiration_date` DATE COMMENT 'The date on which this assignment expires or is scheduled for review and renewal. Null if the assignment is ongoing without a defined end date.',
    `gap_flag` BOOLEAN COMMENT 'Indicates whether this assignment has identified gaps in coverage where no line of defense has clear accountability.',
    `last_review_date` DATE COMMENT 'The date when this three lines assignment was last reviewed and validated by governance or audit committee.',
    `lob` STRING COMMENT 'The specific line of business within the business unit (e.g., Commercial Lending, Wealth Management, Trading).',
    `modified_by` STRING COMMENT 'The user ID or name of the individual who last modified this assignment record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this three lines assignment record was last modified or updated.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this assignment to ensure continued accuracy and relevance.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to this three lines assignment, including special considerations or historical changes.',
    `overlap_flag` BOOLEAN COMMENT 'Indicates whether this assignment has identified overlaps or conflicts with other three lines assignments, requiring resolution or clarification.',
    `oversight_function` STRING COMMENT 'The second line oversight function responsible for monitoring and challenging the control (e.g., Enterprise Risk Management, Compliance, Legal, Financial Control).',
    `oversight_owner_name` STRING COMMENT 'Name of the individual or role responsible for second line oversight of this control activity.',
    `regulatory_driver` STRING COMMENT 'The primary regulatory requirement or mandate driving this three lines assignment (e.g., Basel III Pillar 2, Dodd-Frank, MiFID II, AML/BSA, GDPR).',
    `review_frequency_months` STRING COMMENT 'The frequency in months at which this assignment should be reviewed (e.g., 6, 12, 24 months).',
    `risk_category` STRING COMMENT 'The primary risk category addressed by this assignment (e.g., credit risk, market risk, operational risk, liquidity risk, compliance risk, strategic risk).. Valid values are `credit_risk|market_risk|operational_risk|liquidity_risk|compliance_risk|strategic_risk`',
    `risk_subcategory` STRING COMMENT 'More granular risk subcategory or risk type within the primary risk category (e.g., counterparty credit risk, interest rate risk, fraud risk, AML risk).',
    `sox_scope_flag` BOOLEAN COMMENT 'Indicates whether this assignment falls within the scope of SOX compliance and financial reporting controls.',
    `created_by` STRING COMMENT 'The user ID or name of the individual who created this assignment record.',
    CONSTRAINT pk_three_lines_assignment PRIMARY KEY(`three_lines_assignment_id`)
) COMMENT 'Three Lines of Defense model assignment record mapping business functions, risk types, and control activities to their designated line of defense (1st line – business management, 2nd line – risk and compliance functions, 3rd line – internal audit). Captures business unit, risk category, control activity, assigned line of defense, control owner, oversight function, and audit coverage responsibility. Provides the governance framework for accountability mapping and ensures clarity on who owns, monitors, and independently assures each control domain across the bank.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`quality_assurance_review` (
    `quality_assurance_review_id` BIGINT COMMENT 'Unique identifier for the quality assurance review record. Primary key for the quality assurance review entity.',
    `prior_review_quality_assurance_review_id` BIGINT COMMENT 'Reference to the previous quality assurance review record, enabling tracking of improvement trends and follow-up on prior recommendations.',
    `previous_quality_assurance_review_id` BIGINT COMMENT 'Self-referencing FK on quality_assurance_review (previous_quality_assurance_review_id)',
    `action_plan_due_date` DATE COMMENT 'Target date by which the internal audit function commits to implementing corrective actions and improvements identified in the quality assurance review.',
    `assessment_methodology` STRING COMMENT 'Description of the methodology and approach used to conduct the quality assurance review, including sampling techniques, interview protocols, workpaper reviews, and benchmarking frameworks applied.',
    `audit_committee_approval_flag` BOOLEAN COMMENT 'Indicates whether the Audit Committee formally approved and accepted the quality assurance review findings and the Chief Audit Executives action plan.',
    `audit_committee_presentation_date` DATE COMMENT 'Date when the quality assurance review results were presented to the Audit Committee of the Board of Directors, as required by IIA Standards and regulatory expectations.',
    `cae_response` STRING COMMENT 'Formal response from the Chief Audit Executive to the quality assurance review findings and recommendations, including acceptance, planned actions, and implementation timelines for improvement initiatives.',
    `cae_response_date` DATE COMMENT 'Date when the Chief Audit Executive formally responded to the quality assurance review findings and recommendations.',
    `conformance_rating` STRING COMMENT 'Overall assessment rating indicating the degree to which the internal audit activity conforms with the IIA Standards and Code of Ethics. Generally Conforms is the top rating indicating the internal audit activity is judged to achieve the fundamental requirements; Partially Conforms indicates deficiencies in practice; Does Not Conform indicates the internal audit activity has not achieved many or all of the fundamental requirements.. Valid values are `generally_conforms|partially_conforms|does_not_conform`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality assurance review record was first created in the system.',
    `external_assessment_frequency_years` STRING COMMENT 'Required frequency in years for external quality assessments as mandated by IIA Standards (minimum once every five years) and regulatory expectations.',
    `follow_up_review_date` DATE COMMENT 'Scheduled date for follow-up quality assurance review to assess progress on implementing recommendations and corrective actions.',
    `follow_up_review_required_flag` BOOLEAN COMMENT 'Indicates whether a follow-up quality assurance review is required to validate implementation of corrective actions and improvements, typically triggered by partially conforms or does not conform ratings.',
    `high_priority_recommendations_count` STRING COMMENT 'Number of high-priority or critical recommendations requiring immediate management attention and remediation to address significant gaps in conformance with IIA Standards.',
    `iia_standards_scope` STRING COMMENT 'Specific IIA Standards and principles evaluated during this quality assurance review, including attribute standards (1000-1300 series) and performance standards (2000-2600 series) assessed for conformance.',
    `improvement_opportunities` STRING COMMENT 'Areas identified for enhancement and improvement in the internal audit functions practices, methodologies, or conformance with IIA Standards, including specific recommendations for remediation.',
    `key_observations` STRING COMMENT 'Summary of the principal findings and observations from the quality assurance review, highlighting strengths, areas of conformance, and opportunities for improvement in audit practices and methodologies.',
    `lead_reviewer_name` STRING COMMENT 'Full name of the individual leading the quality assurance review, whether internal quality assurance manager or external assessment partner.',
    `modified_by` STRING COMMENT 'User identifier or name of the individual who last modified this quality assurance review record in the system.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this quality assurance review record was last modified or updated in the system.',
    `recommendations_count` STRING COMMENT 'Total number of formal recommendations issued as part of the quality assurance review for improving audit practices and conformance with professional standards.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority or supervisory body that mandated or oversees this quality assurance review (e.g., Federal Reserve, OCC, FDIC, EBA, PRA).',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this quality assurance review was mandated by regulatory requirements or supervisory expectations (e.g., Federal Reserve, OCC, EBA guidance on internal audit effectiveness).',
    `report_distribution_list` STRING COMMENT 'List of stakeholders and recipients who received the quality assurance review report, typically including the Chief Audit Executive, Audit Committee, senior management, and regulatory examiners as appropriate.',
    `report_document_reference` STRING COMMENT 'Document management system reference or file path to the formal quality assurance review report and supporting documentation.',
    `review_completion_date` DATE COMMENT 'Date when the quality assurance review fieldwork and assessment activities were completed and final report issued.',
    `review_notes` STRING COMMENT 'Additional notes, context, or commentary regarding the quality assurance review process, findings, or special circumstances affecting the assessment.',
    `review_number` STRING COMMENT 'Business identifier for the quality assurance review, typically following organizational numbering conventions (e.g., QA-2024-001).',
    `review_period_end_date` DATE COMMENT 'Ending date of the audit activity period being assessed by this quality assurance review. Defines the temporal scope of audit work subject to quality evaluation.',
    `review_period_start_date` DATE COMMENT 'Beginning date of the audit activity period being assessed by this quality assurance review. Defines the temporal scope of audit work subject to quality evaluation.',
    `review_start_date` DATE COMMENT 'Date when the quality assurance review fieldwork and assessment activities commenced.',
    `review_status` STRING COMMENT 'Current lifecycle status of the quality assurance review indicating progression from planning through completion and closure.. Valid values are `planned|in_progress|fieldwork_complete|draft_report|final_report|closed`',
    `review_type` STRING COMMENT 'Classification of the quality assurance review distinguishing between internal self-assessments conducted by the audit function, external assessments by independent qualified reviewers, regulatory peer reviews mandated by supervisory authorities, ongoing monitoring activities, and periodic internal reviews.. Valid values are `internal_self_assessment|external_assessment|regulatory_peer_review|ongoing_monitoring|periodic_internal_review`',
    `reviewer_organization_name` STRING COMMENT 'Name of the organization or firm conducting the external quality assurance review. Populated for external assessments and regulatory peer reviews; null for internal reviews.',
    `reviewer_qualifications` STRING COMMENT 'Professional certifications and qualifications of the review team (e.g., CIA, CPA, CRMA) demonstrating competence and independence required for quality assessments.',
    `reviewer_type` STRING COMMENT 'Classification of the party conducting the quality assurance review, distinguishing between internal quality assurance teams, external independent assessors, regulatory examiners, and peer reviewers from other institutions.. Valid values are `internal_qa_team|external_assessor|regulatory_examiner|peer_reviewer`',
    `sample_size` STRING COMMENT 'Number of audit engagements, workpapers, or audit activities sampled and reviewed as part of the quality assurance assessment.',
    `strengths_identified` STRING COMMENT 'Specific strengths and best practices identified during the quality assurance review where the internal audit function demonstrates excellence or leading practices in conformance with professional standards.',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created this quality assurance review record in the system.',
    CONSTRAINT pk_quality_assurance_review PRIMARY KEY(`quality_assurance_review_id`)
) COMMENT 'Internal audit quality assurance and improvement program (QAIP) review record capturing both internal ongoing assessments and periodic external quality assessments. Captures review type (internal self-assessment, external assessment, regulatory peer review), review period, reviewer identity (internal QA team or external assessor), conformance rating (generally conforms, partially conforms, does not conform) against IIA Standards, key observations, improvement recommendations, and CAE response. Required by IIA Standards 1300 and increasingly scrutinized by bank regulators.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`issue_tracker` (
    `issue_tracker_id` BIGINT COMMENT 'Unique identifier for the audit issue tracking record. Primary key for the audit issue tracker.',
    `engagement_id` BIGINT COMMENT 'Reference to the audit engagement that identified this issue. Applicable when issue_source_type is internal_audit. Links to the engagement table for full audit context.',
    `finding_id` BIGINT COMMENT 'Reference to the detailed audit finding record that describes the control deficiency or observation. Provides linkage to the full finding documentation including root cause analysis and detailed testing results.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to ledger.legal_entity. Business justification: Issues are tracked by legal entity for entity-level issue management, board reporting, and regulatory coordination. Legal entity linkage enables entity-specific issue aging, escalation, and remediatio',
    `loan_account_id` BIGINT COMMENT 'Foreign key linking to loan.loan_account. Business justification: Issue tracker consolidates findings from audits, regulatory exams, and continuous monitoring; issues often relate to specific loan accounts (e.g., ECL error on loan #12345). Linking issues to loan acc',
    `operational_risk_event_id` BIGINT COMMENT 'Foreign key linking to risk.operational_risk_event. Business justification: Issue tracker consolidates audit findings and operational risk events for integrated remediation tracking. Links issue to event, supporting root cause analysis, corrective action planning, and regulat',
    `employee_id` BIGINT COMMENT 'Identifier of the individual assigned day-to-day responsibility for coordinating remediation activities and providing status updates. Typically a manager or director within the business unit.',
    `prior_issue_issue_tracker_id` BIGINT COMMENT 'Reference to the previous audit issue tracker record if this is a repeat finding. Enables tracking of recurring issues and remediation effectiveness over time.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to ledger.cost_center. Business justification: Issues are assigned to cost centers for remediation accountability, budget allocation, and organizational performance tracking. Cost center linkage replaces denormalized business_unit_owner with prope',
    `tertiary_issue_validated_by_employee_id` BIGINT COMMENT 'Identifier of the auditor who performed the validation testing. Links to employee or auditor table for contact information and credentials.',
    `related_issue_tracker_id` BIGINT COMMENT 'Self-referencing FK on issue_tracker (related_issue_tracker_id)',
    `aging_bucket` STRING COMMENT 'Categorization of issue age based on days since identification. Used for aging analysis and audit committee reporting. Buckets typically align with escalation thresholds.. Valid values are `0_30_days|31_60_days|61_90_days|91_180_days|over_180_days`',
    `audit_committee_report_date` DATE COMMENT 'Date when the issue was presented to the Audit Committee. Null if not yet reported or if audit_committee_reported_flag is false.',
    `audit_committee_reported_flag` BOOLEAN COMMENT 'Indicates whether this issue has been reported to the Audit Committee of the Board of Directors. True for high-risk issues, material weaknesses, significant deficiencies, and regulatory findings that require board-level awareness.',
    `closure_date` DATE COMMENT 'Date when the issue was officially closed after successful validation. Used to calculate time-to-remediate metrics and track closure rates.',
    `control_framework` STRING COMMENT 'The control or regulatory framework that the issue relates to. Examples include COSO Internal Control, SOX Section 404, Basel III, AML/BSA, CCAR, DFAST, IFRS 9, CECL.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit issue tracker record was first created in the system. Used for audit trail and data lineage purposes.',
    `current_due_date` DATE COMMENT 'Current target date for completing remediation after any approved extensions. This is the active due date used for overdue calculations and escalation triggers.',
    `days_overdue` STRING COMMENT 'Number of calendar days the issue is past the current due date. Calculated as current date minus current_due_date when status is overdue. Zero or null when not overdue.',
    `escalation_date` DATE COMMENT 'Date when the issue was escalated to a higher level of management or governance. Null if no escalation has occurred.',
    `escalation_status` STRING COMMENT 'Current escalation level based on overdue status, risk rating, and extension count. None indicates no escalation. Higher levels indicate increasing senior management and governance body involvement.. Valid values are `none|management|executive|audit_committee|board`',
    `extension_count` STRING COMMENT 'Number of times the due date has been extended since the issue was opened. High extension counts trigger escalation and audit committee attention.',
    `external_auditor_coordination_flag` BOOLEAN COMMENT 'Indicates whether the issue has been shared with or identified by the external auditor. True for SOX-relevant issues and material weaknesses that impact the financial statement audit.',
    `identification_date` DATE COMMENT 'Date when the issue was first identified or reported. Used to calculate aging metrics and track time from identification to closure.',
    `issue_description` STRING COMMENT 'Detailed description of the audit issue, control deficiency, or regulatory finding. Includes the condition observed, the criteria or standard that was not met, and the context of the deficiency.',
    `issue_reference_number` STRING COMMENT 'Business-facing unique reference number assigned to the issue for tracking and communication purposes. Used in audit committee reports and management communications.',
    `issue_source_type` STRING COMMENT 'The origin or source that identified the issue. Distinguishes between internal audit findings, regulatory examination findings, external audit observations, self-identified issues by business units, management reviews, and continuous monitoring alerts.. Valid values are `internal_audit|regulatory_exam|external_audit|self_identified|management_review|continuous_monitoring`',
    `issue_status` STRING COMMENT 'Current lifecycle status of the issue. Open indicates newly identified and not yet started. In_progress indicates remediation activities underway. Pending_validation indicates remediation complete and awaiting audit validation. Closed indicates validated and closed. Overdue indicates past due date.. Valid values are `open|in_progress|pending_validation|closed|overdue`',
    `issue_title` STRING COMMENT 'Concise title or summary of the audit issue or finding. Used in executive dashboards and audit committee reporting for quick identification.',
    `lob` STRING COMMENT 'Specific Line of Business (LOB) code or name where the issue was identified. Examples include Commercial Lending, Investment Banking, Wealth Management, Retail Banking, Treasury, Risk Management.',
    `management_action_plan` STRING COMMENT 'Detailed description of the corrective actions management has committed to implement to remediate the issue. Includes specific steps, milestones, and resource commitments.',
    `material_weakness_flag` BOOLEAN COMMENT 'Indicates whether the issue constitutes a material weakness in internal control over financial reporting as defined by SOX and PCAOB standards. Material weaknesses must be disclosed in the annual 10-K filing.',
    `modified_by` STRING COMMENT 'User ID or name of the individual who last modified this audit issue tracker record. Used for audit trail and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this audit issue tracker record was last updated. Used for audit trail and tracking changes to issue status, due dates, and remediation progress.',
    `original_due_date` DATE COMMENT 'Initial target date agreed upon for completing remediation when the issue was first opened. Serves as baseline for tracking extensions and delays.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory authority that issued the finding when issue_source_type is regulatory_exam. Examples include Federal Reserve (Fed), Office of the Comptroller of the Currency (OCC), Federal Deposit Insurance Corporation (FDIC), Securities and Exchange Commission (SEC), Financial Industry Regulatory Authority (FINRA), Consumer Financial Protection Bureau (CFPB).',
    `regulatory_exam_reference` STRING COMMENT 'Official examination reference number or Matter Requiring Attention (MRA) number assigned by the regulatory body. Used for tracking and correspondence with regulators.',
    `remediation_approach` STRING COMMENT 'High-level category describing the primary remediation strategy. Process redesign for fundamental process changes, control enhancement for strengthening existing controls, system implementation for technology solutions, policy update for governance changes, training for capability building, resource addition for staffing or budget increases.. Valid values are `process_redesign|control_enhancement|system_implementation|policy_update|training|resource_addition`',
    `remediation_progress_percentage` DECIMAL(18,2) COMMENT 'Estimated percentage completion of the management action plan. Ranges from 0.00 to 100.00. Used for tracking progress and identifying stalled remediation efforts.',
    `repeat_finding_flag` BOOLEAN COMMENT 'Indicates whether this issue is a repeat of a previously identified and closed finding. Repeat findings indicate ineffective remediation or control sustainability issues and trigger heightened scrutiny.',
    `risk_category` STRING COMMENT 'Primary risk category that the issue impacts. Aligns with the enterprise risk taxonomy and Basel III risk classifications for banking institutions. [ENUM-REF-CANDIDATE: credit_risk|market_risk|operational_risk|liquidity_risk|compliance_risk|strategic_risk|reputational_risk — 7 candidates stripped; promote to reference product]',
    `risk_rating` STRING COMMENT 'Severity rating of the issue based on potential impact to the organization. Critical issues pose immediate threat to safety, soundness, or regulatory compliance. High issues represent significant control deficiencies. Medium and low represent lesser degrees of risk.. Valid values are `critical|high|medium|low`',
    `significant_deficiency_flag` BOOLEAN COMMENT 'Indicates whether the issue constitutes a significant deficiency in internal control over financial reporting. Less severe than a material weakness but important enough to merit attention by those charged with governance.',
    `sox_relevant_flag` BOOLEAN COMMENT 'Indicates whether the issue impacts a SOX-relevant control over financial reporting. True if the issue affects a key control supporting financial statement assertions under SOX Section 404.',
    `three_lines_position` STRING COMMENT 'Indicates which line of defense in the Three Lines Model is responsible for remediation. First line (business operations), second line (risk and compliance oversight), or third line (internal audit).. Valid values are `first_line|second_line|third_line`',
    `validation_date` DATE COMMENT 'Date when audit validation testing was completed. Null if validation has not yet occurred.',
    `validation_status` STRING COMMENT 'Status of audit validation testing to confirm remediation effectiveness. Not_started indicates remediation not yet complete. In_progress indicates validation testing underway. Passed indicates successful validation. Failed indicates remediation did not address the issue. Deferred indicates validation postponed.. Valid values are `not_started|in_progress|passed|failed|deferred`',
    `created_by` STRING COMMENT 'User ID or name of the individual who created this audit issue tracker record. Used for audit trail and accountability.',
    CONSTRAINT pk_issue_tracker PRIMARY KEY(`issue_tracker_id`)
) COMMENT 'Consolidated issue tracking register providing a real-time inventory of all open audit findings, regulatory findings, and management actions across the enterprise. Captures issue source (internal audit, regulatory exam, external audit, self-identified), issue reference, business unit owner, risk rating, original due date, current due date, number of extensions granted, days overdue, escalation status, and aging bucket. Serves as the single operational dashboard for audit management, business line accountability, and Audit Committee reporting on remediation progress.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`cae_charter` (
    `cae_charter_id` BIGINT COMMENT 'Unique identifier for the Chief Audit Executive charter record. Primary key for the charter governance document.',
    `superseded_charter_cae_charter_id` BIGINT COMMENT 'Reference to the previous charter version that this charter supersedes, maintaining version lineage and governance history.',
    `previous_cae_charter_id` BIGINT COMMENT 'Self-referencing FK on cae_charter (previous_cae_charter_id)',
    `administrative_reporting_line` STRING COMMENT 'Defines the administrative reporting relationship of the Chief Audit Executive, typically to the Chief Executive Officer (CEO) or Chief Financial Officer (CFO), for day-to-day operational matters.',
    `annual_review_requirement_flag` BOOLEAN COMMENT 'Indicates whether the charter requires annual review and reaffirmation by the Audit Committee and Board, per IIA Standards and regulatory guidance.',
    `approval_date` DATE COMMENT 'Date on which the charter was formally approved by the Audit Committee and Board of Directors, establishing its authority.',
    `approving_body` STRING COMMENT 'Name of the governing body that approved the charter, typically the Audit Committee of the Board of Directors, establishing the independence and authority of the internal audit function.',
    `assurance_services_scope` STRING COMMENT 'Description of the scope of assurance services the internal audit function is authorized to provide, including risk management, control, and governance processes.',
    `audit_committee_chair_name` STRING COMMENT 'Name of the Audit Committee Chair who signed or approved the charter on behalf of the Board, establishing accountability for oversight.',
    `audit_committee_reporting_frequency` STRING COMMENT 'Defines the frequency and nature of reporting by the Chief Audit Executive to the Audit Committee, typically quarterly or as needed for significant matters.',
    `audit_universe_coverage` STRING COMMENT 'Defines the comprehensive audit universe that falls within the scope of the internal audit function, including all entities, operations, functions, and processes subject to audit.',
    `board_approval_resolution_number` STRING COMMENT 'Board resolution or meeting minute reference number documenting the formal approval of the charter by the Board of Directors.',
    `budget_authority` STRING COMMENT 'Defines the Chief Audit Executives authority over the internal audit budget, staffing, and resource allocation, ensuring adequate resources to fulfill the audit mandate.',
    `charter_number` STRING COMMENT 'Business identifier for the charter document, typically assigned by the Audit Committee or Board for tracking and reference purposes.',
    `charter_status` STRING COMMENT 'Current lifecycle status of the charter document indicating its approval and operational state within the governance framework.. Valid values are `draft|pending_approval|approved|active|superseded|archived`',
    `charter_title` STRING COMMENT 'Official title of the charter document as approved by the Audit Committee and Board, typically Internal Audit Charter or Chief Audit Executive Charter.',
    `charter_version` STRING COMMENT 'Version identifier for the charter document, incremented with each revision or amendment approved by the Audit Committee or Board.',
    `consulting_services_scope` STRING COMMENT 'Description of the scope of consulting and advisory services the internal audit function is authorized to provide to management, with appropriate safeguards to independence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this charter record was first created in the system, supporting audit trail and data lineage requirements.',
    `document_storage_location` STRING COMMENT 'Physical or electronic storage location of the official signed charter document, ensuring accessibility for reference and regulatory examination.',
    `effective_date` DATE COMMENT 'Date on which the charter becomes effective and binding, establishing the authority and responsibility of the internal audit function.',
    `expiration_date` DATE COMMENT 'Date on which the charter expires or is scheduled for mandatory review, typically set annually per IIA Standards requiring annual review and reaffirmation.',
    `external_assessment_frequency_years` STRING COMMENT 'Frequency in years for external quality assessments of the internal audit function, typically every five years per IIA Standards.',
    `fraud_investigation_authority` STRING COMMENT 'Authority granted to the internal audit function to investigate suspected fraud, misconduct, and violations of laws, regulations, or policies, including coordination with legal and compliance functions.',
    `functional_reporting_line` STRING COMMENT 'Defines the functional reporting relationship of the Chief Audit Executive, typically to the Audit Committee of the Board, ensuring organizational independence.',
    `independence_provisions` STRING COMMENT 'Detailed provisions ensuring the independence and objectivity of the internal audit function, including safeguards against conflicts of interest and impairments to independence.',
    `last_review_date` DATE COMMENT 'Date of the most recent review of the charter by the Audit Committee and Board, tracking compliance with annual review requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this charter record was last modified in the system, supporting audit trail and change tracking requirements.',
    `next_review_date` DATE COMMENT 'Date scheduled for the next mandatory review of the charter by the Audit Committee and Board, typically annually.',
    `private_session_requirement_flag` BOOLEAN COMMENT 'Indicates whether the charter mandates private sessions between the Chief Audit Executive and the Audit Committee without management present, a key independence safeguard.',
    `purpose_statement` STRING COMMENT 'Formal statement defining the purpose of the internal audit function, typically to provide independent, objective assurance and consulting services designed to add value and improve operations.',
    `quality_assurance_requirement` STRING COMMENT 'Requirement for the internal audit function to develop and maintain a Quality Assurance and Improvement Program (QAIP) including internal and external assessments.',
    `regulatory_coordination_authority` STRING COMMENT 'Authority granted to the internal audit function to coordinate with external auditors and regulatory examiners, including the Federal Reserve, Office of the Comptroller of the Currency (OCC), and other banking regulators.',
    `regulatory_filing_flag` BOOLEAN COMMENT 'Indicates whether the charter or its key provisions must be filed with banking regulators such as the Federal Reserve or Office of the Comptroller of the Currency (OCC).',
    `revision_history` STRING COMMENT 'Summary of significant revisions and amendments made to the charter over time, providing audit trail of governance evolution.',
    `risk_assessment_methodology` STRING COMMENT 'Approved methodology for conducting risk assessments to develop the annual audit plan, ensuring audit resources are allocated to highest-risk areas.',
    `scope_of_authority` STRING COMMENT 'Comprehensive description of the scope and boundaries of the internal audit functions authority, including access rights, audit universe coverage, and limitations.',
    `staffing_authority` STRING COMMENT 'Authority granted to the Chief Audit Executive to hire, terminate, and manage internal audit staff, ensuring the function has appropriate skills and competencies.',
    `standards_conformance_requirement` STRING COMMENT 'Requirement for the internal audit function to conform to the Institute of Internal Auditors (IIA) International Standards for the Professional Practice of Internal Auditing and Code of Ethics.',
    `three_lines_model_position` STRING COMMENT 'Position of the internal audit function within the Three Lines of Defense governance model, typically designated as the third line providing independent assurance.. Valid values are `first_line|second_line|third_line`',
    `unrestricted_access_flag` BOOLEAN COMMENT 'Indicates whether the charter grants unrestricted access to all records, personnel, and physical properties relevant to the performance of audit engagements, a key independence provision.',
    `whistleblower_coordination_flag` BOOLEAN COMMENT 'Indicates whether the internal audit function has a role in coordinating or overseeing the organizations whistleblower and ethics hotline programs.',
    CONSTRAINT pk_cae_charter PRIMARY KEY(`cae_charter_id`)
) COMMENT 'Chief Audit Executive (CAE) charter and mandate record defining the purpose, authority, independence, and responsibility of the internal audit function as approved by the Audit Committee and Board. Captures charter version, effective date, approval date, approving body, scope of internal audit authority, reporting lines (functional to Audit Committee, administrative to CEO/CFO), independence provisions, access rights to records and personnel, and budget authority. The foundational governance document for the internal audit function, reviewed annually per IIA Standards.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`audit_budget` (
    `audit_budget_id` BIGINT COMMENT 'Unique identifier for the audit budget record.',
    `employee_id` BIGINT COMMENT 'Identifier of the Chief Audit Executive responsible for this budget.',
    `plan_id` BIGINT COMMENT 'Reference to the annual audit plan this budget supports.',
    `previous_audit_budget_id` BIGINT COMMENT 'Self-referencing FK on audit_budget (previous_audit_budget_id)',
    `advisory_hours_actual` DECIMAL(18,2) COMMENT 'Actual hours consumed on advisory and consulting activities.',
    `advisory_hours_planned` DECIMAL(18,2) COMMENT 'Planned hours allocated to advisory and consulting activities.',
    `approval_date` DATE COMMENT 'Date when the budget was formally approved by the Audit Committee or Chief Audit Executive.',
    `approval_status` STRING COMMENT 'Approval status of the budget by the Audit Committee or Chief Audit Executive (CAE).. Valid values are `pending|approved|rejected|conditionally_approved`',
    `approved_by_name` STRING COMMENT 'Name of the executive or committee that approved the budget (typically Chief Audit Executive or Audit Committee Chair).',
    `assurance_hours_actual` DECIMAL(18,2) COMMENT 'Actual hours consumed on assurance audit engagements.',
    `assurance_hours_planned` DECIMAL(18,2) COMMENT 'Planned hours allocated to assurance audit engagements.',
    `audit_committee_presentation_date` DATE COMMENT 'Date when the budget was presented to the Audit Committee for review and approval.',
    `budget_status` STRING COMMENT 'Current approval and execution status of the budget.. Valid values are `draft|submitted|approved|active|closed|revised`',
    `co_sourcing_actual` DECIMAL(18,2) COMMENT 'Actual expenditure on third-party audit support and co-sourcing services during the period.',
    `co_sourcing_budget` DECIMAL(18,2) COMMENT 'Budget allocated for third-party audit support and co-sourcing services.',
    `co_sourcing_hours_actual` DECIMAL(18,2) COMMENT 'Actual hours delivered by third-party audit support providers.',
    `co_sourcing_hours_planned` DECIMAL(18,2) COMMENT 'Planned hours to be delivered by third-party audit support providers (co-sourcing partners).',
    `contingency_hours_actual` DECIMAL(18,2) COMMENT 'Actual hours consumed from the contingency reserve.',
    `contingency_hours_planned` DECIMAL(18,2) COMMENT 'Planned hours reserved for unplanned audits, special investigations, and emerging risks.',
    `cost_per_audit_day` DECIMAL(18,2) COMMENT 'Average cost per audit day, calculated as total expenditure divided by total hours (converted to days). Used for benchmarking against industry peers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all budget amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cycle_type` STRING COMMENT 'The planning cycle granularity for this budget record (annual plan, quarterly allocation, monthly tracking, or engagement-specific).. Valid values are `annual|quarterly|monthly|engagement_specific`',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this budget record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last modified.',
    `notes` STRING COMMENT 'Additional notes, assumptions, constraints, or commentary related to the budget planning and execution.',
    `period_end_date` DATE COMMENT 'The end date of the budget period (typically fiscal year or quarter end).',
    `period_start_date` DATE COMMENT 'The start date of the budget period (typically fiscal year or quarter start).',
    `resource_adequacy_assessment` STRING COMMENT 'Chief Audit Executive assessment of whether the budget provides adequate resources to fulfill the audit mandate and cover the audit universe.. Valid values are `adequate|constrained|insufficient|over_resourced`',
    `technology_actual` DECIMAL(18,2) COMMENT 'Actual expenditure on audit technology and tools during the period.',
    `technology_budget` DECIMAL(18,2) COMMENT 'Budget allocated for audit technology tools, software licenses, data analytics platforms, and IT infrastructure.',
    `total_actual_expenditure` DECIMAL(18,2) COMMENT 'Total actual financial expenditure incurred during the budget period.',
    `total_actual_hours` DECIMAL(18,2) COMMENT 'Total audit hours actually consumed during the budget period.',
    `total_budget_amount` DECIMAL(18,2) COMMENT 'Total financial budget allocated for the audit function during this period, including salaries, travel, technology, and training.',
    `total_planned_hours` DECIMAL(18,2) COMMENT 'Total audit hours planned for the budget period across all engagements and activities.',
    `training_actual` DECIMAL(18,2) COMMENT 'Actual expenditure on audit staff training and professional development during the period.',
    `training_budget` DECIMAL(18,2) COMMENT 'Budget allocated for audit staff training, professional development, certifications, and continuing education.',
    `travel_expense_actual` DECIMAL(18,2) COMMENT 'Actual expenditure on audit team travel and expenses during the period.',
    `travel_expense_budget` DECIMAL(18,2) COMMENT 'Budget allocated for audit team travel, lodging, meals, and related expenses.',
    `variance_hours` DECIMAL(18,2) COMMENT 'Variance between planned and actual hours (actual minus planned). Positive indicates over-budget, negative indicates under-budget.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between planned and actual hours, calculated as (actual - planned) / planned * 100.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this budget record.',
    CONSTRAINT pk_audit_budget PRIMARY KEY(`audit_budget_id`)
) COMMENT 'Internal audit function budget and resource capacity record tracking planned versus actual expenditure of audit hours and financial resources by engagement, quarter, and annual plan cycle. Captures budget period, total planned hours, total actual hours, budget variance, co-sourcing hours (third-party audit support), travel and expense budget, technology budget, training budget, and budget approval status. Supports CAE reporting to the Audit Committee on resource adequacy and enables cost-per-audit-day benchmarking against industry peers.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` (
    `cosourcing_arrangement_id` BIGINT COMMENT 'Unique identifier for the co-sourcing arrangement record. Primary key for tracking third-party audit support engagements.',
    `engagement_id` BIGINT COMMENT 'Foreign key linking to audit.engagement. Business justification: cosourcing_arrangement captures engagements where external audit firms or specialists are brought in. These arrangements are FOR specific audit engagements. Currently no FK exists from cosourcing_arra',
    `employee_id` BIGINT COMMENT 'Employee identifier for the supervising CAE staff member, linking to the human resources system for organizational hierarchy and accountability tracking.',
    `lead_cosourcing_arrangement_id` BIGINT COMMENT 'Self-referencing FK on cosourcing_arrangement (lead_cosourcing_arrangement_id)',
    `actual_hours` DECIMAL(18,2) COMMENT 'Total hours actually worked by the external service provider on the co-sourcing engagement, tracked for billing reconciliation and performance evaluation.',
    `approval_date` DATE COMMENT 'Date when the co-sourcing arrangement was formally approved by the Chief Audit Executive or designated authority.',
    `approved_by` STRING COMMENT 'Name of the executive or authority who approved the co-sourcing arrangement, typically the Chief Audit Executive or Audit Committee Chair.',
    `arrangement_number` STRING COMMENT 'Business identifier for the co-sourcing arrangement, used for external reference and tracking in audit committee reports and vendor management systems.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `arrangement_status` STRING COMMENT 'Current lifecycle status of the co-sourcing arrangement, tracking progression from planning through completion or termination. [ENUM-REF-CANDIDATE: draft|approved|active|completed|suspended|terminated|cancelled — 7 candidates stripped; promote to reference product]',
    `audit_committee_report_date` DATE COMMENT 'Date when the co-sourcing arrangement was presented to or discussed with the Audit Committee.',
    `audit_committee_reported_flag` BOOLEAN COMMENT 'Indicator showing whether this co-sourcing arrangement has been reported to the Audit Committee as part of audit plan execution or third-party risk oversight.',
    `billing_method` STRING COMMENT 'Contractual billing structure defining how the external service provider charges for co-sourcing services.. Valid values are `fixed_fee|time_and_materials|milestone_based|retainer|capped_hourly`',
    `contract_reference_number` STRING COMMENT 'Reference identifier linking this co-sourcing arrangement to the master services agreement or statement of work in the procurement system.. Valid values are `^[A-Z0-9-]{8,25}$`',
    `cosourcing_type` STRING COMMENT 'Category of co-sourcing engagement defining the scope and nature of external support provided to the internal audit function. [ENUM-REF-CANDIDATE: full_cosource|specialist_support|it_audit|regulatory_specialist|sox_compliance|model_validation|cybersecurity — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp capturing when this co-sourcing arrangement record was first created in the audit management system.',
    `engagement_end_date` DATE COMMENT 'Planned or actual completion date for the co-sourcing arrangement, marking the end of the external providers active involvement.',
    `engagement_scope` STRING COMMENT 'Detailed description of the work scope, deliverables, and areas of responsibility assigned to the external service provider within the audit engagement.',
    `engagement_start_date` DATE COMMENT 'Date when the co-sourcing arrangement becomes effective and the external provider begins work on the audit engagement.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total contracted fee or cost for the co-sourcing arrangement, including all professional services charges and expenses.',
    `fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the fee amount, supporting multi-currency co-sourcing arrangements across global operations.. Valid values are `^[A-Z]{3}$`',
    `independence_confirmation_date` DATE COMMENT 'Date when the external service provider submitted their independence attestation and conflict of interest disclosure.',
    `independence_confirmation_flag` BOOLEAN COMMENT 'Indicator confirming that the external service provider has provided written attestation of independence and absence of conflicts of interest per IIA standards and regulatory requirements.',
    `modified_by` STRING COMMENT 'User identifier or name of the internal audit staff member who last modified this co-sourcing arrangement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp capturing the most recent update to this co-sourcing arrangement record, supporting audit trail and change tracking requirements.',
    `notes` STRING COMMENT 'Additional comments, observations, or contextual information about the co-sourcing arrangement, including lessons learned and recommendations for future engagements.',
    `performance_evaluation_date` DATE COMMENT 'Date when the formal performance evaluation of the external service provider was completed by the supervising internal audit staff.',
    `performance_rating` STRING COMMENT 'Overall performance evaluation of the external service provider based on work quality, timeliness, communication, and adherence to audit standards.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `planned_hours` DECIMAL(18,2) COMMENT 'Estimated total hours allocated for the external service provider to complete the co-sourcing engagement scope, used for budget planning and resource allocation.',
    `quality_oversight_procedures` STRING COMMENT 'Description of the quality assurance and oversight controls implemented by internal audit to monitor the external providers work quality, methodology adherence, and deliverable standards.',
    `regulatory_driver` STRING COMMENT 'Specific regulatory requirement, examination finding, or compliance mandate that necessitated or influenced the decision to engage external co-sourcing support.',
    `renewal_flag` BOOLEAN COMMENT 'Indicator showing whether this co-sourcing arrangement is eligible for or planned for renewal in the next audit planning cycle.',
    `risk_rating` STRING COMMENT 'Third-party risk assessment rating assigned to the external service provider based on vendor due diligence, criticality of services, and potential impact on audit quality.. Valid values are `low|moderate|high|critical`',
    `service_provider_name` STRING COMMENT 'Legal name of the external audit firm, specialist consultant, or third-party provider engaged to supplement internal audit capacity.',
    `service_provider_type` STRING COMMENT 'Classification of the external service provider based on firm size, specialization, and market positioning.. Valid values are `big_four|regional_firm|boutique_specialist|independent_consultant|technology_auditor|regulatory_specialist`',
    `termination_reason` STRING COMMENT 'Explanation for early termination or cancellation of the co-sourcing arrangement, if applicable, including performance issues, scope changes, or budget constraints.',
    `three_lines_of_defense_level` STRING COMMENT 'Classification of where this co-sourcing arrangement operates within the three lines of defense model, typically third line for internal audit co-sourcing.. Valid values are `first_line|second_line|third_line`',
    `vendor_due_diligence_date` DATE COMMENT 'Date when vendor due diligence assessment was completed for the external service provider, including background checks, financial stability review, and capability validation.',
    `created_by` STRING COMMENT 'User identifier or name of the internal audit staff member who created this co-sourcing arrangement record.',
    CONSTRAINT pk_cosourcing_arrangement PRIMARY KEY(`cosourcing_arrangement_id`)
) COMMENT 'Co-sourcing and guest auditor arrangement record capturing engagements where external audit firms or specialist consultants are engaged to supplement internal audit capacity or provide specialized expertise. Captures service provider name, engagement scope, co-sourcing type (full co-source, specialist support, IT audit, regulatory specialist), contract reference, engagement period, planned hours, actual hours, fee amount, supervising CAE staff member, quality oversight procedures, and independence confirmation. Manages the third-party audit support relationships that supplement the internal audit function.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`notification` (
    `notification_id` BIGINT COMMENT 'Unique identifier for the audit notification record. Primary key.',
    `engagement_id` BIGINT COMMENT 'Reference to the audit engagement that this notification pertains to.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the primary recipient.',
    `notification_sender_employee_id` BIGINT COMMENT 'Employee identifier of the individual issuing the notification.',
    `previous_audit_notification_id` BIGINT COMMENT 'Self-referencing FK on notification (previous_audit_notification_id)',
    `acknowledgement_date` DATE COMMENT 'Date on which the recipient formally acknowledged receipt of the notification.',
    `acknowledgement_received_flag` BOOLEAN COMMENT 'Indicator of whether acknowledgement of receipt has been received from the recipient.',
    `acknowledgement_required_flag` BOOLEAN COMMENT 'Indicator of whether formal acknowledgement of receipt is required from the recipient.',
    `attachment_count` STRING COMMENT 'Number of attachments or supporting documents included with the notification.',
    `audit_committee_report_date` DATE COMMENT 'Date on which the notification was reported to the Audit Committee.',
    `audit_committee_reported_flag` BOOLEAN COMMENT 'Indicator of whether this notification was reported to the Audit Committee of the Board of Directors.',
    `body` STRING COMMENT 'Full text content of the audit notification message or letter body.',
    `business_unit_notified` STRING COMMENT 'Name of the business unit, department, or division that is the subject of the audit notification.',
    `cc_recipients` STRING COMMENT 'Comma-separated list of additional recipients copied on the notification, including names and email addresses.',
    `communication_channel` STRING COMMENT 'Channel or medium through which the notification was delivered: email, postal mail, secure portal, hand delivery, registered mail, or electronic signature platform.. Valid values are `email|postal_mail|secure_portal|hand_delivery|registered_mail|electronic_signature_platform`',
    `confidentiality_level` STRING COMMENT 'Data classification level of the notification content, determining access controls and distribution restrictions.. Valid values are `restricted|confidential|internal|public`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the jurisdiction relevant to the notification.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the notification record was first created in the system.',
    `days_to_respond` STRING COMMENT 'Number of calendar days between notification issuance and response receipt, used for performance tracking.',
    `delivery_confirmation_date` DATE COMMENT 'Date on which delivery confirmation was received.',
    `delivery_confirmation_flag` BOOLEAN COMMENT 'Indicator of whether delivery confirmation was received for the notification.',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the stored notification document in the document management system.',
    `geographic_region` STRING COMMENT 'Geographic region or jurisdiction relevant to the notification, such as North America, EMEA, APAC.',
    `legal_entity_name` STRING COMMENT 'Legal entity name to which the notification applies, relevant for multi-entity banking organizations.',
    `lob` STRING COMMENT 'Line of business associated with the notification, such as Retail Banking, Investment Banking, Wealth Management, or Treasury.',
    `modified_by` STRING COMMENT 'User identifier or name of the individual who last modified the notification record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the notification record was last modified.',
    `notes` STRING COMMENT 'Additional notes, comments, or context related to the notification for internal audit team reference.',
    `notification_date` DATE COMMENT 'Date on which the audit notification was officially issued or sent to the recipient.',
    `notification_number` STRING COMMENT 'Business-facing unique reference number for the audit notification, used for tracking and correspondence.',
    `notification_status` STRING COMMENT 'Current lifecycle status of the notification: draft, pending approval, approved, issued, acknowledged by recipient, overdue response, or cancelled. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|issued|acknowledged|overdue|cancelled — 7 candidates stripped; promote to reference product]',
    `notification_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the notification was issued, supporting audit trail and time-zone tracking.',
    `notification_type` STRING COMMENT 'Type of audit communication being issued: engagement announcement letter, information request list (IRL), draft report issuance, management response request, final report distribution, or follow-up notice.. Valid values are `engagement_announcement|information_request_list|draft_report|management_response_request|final_report|follow_up_notice`',
    `overdue_flag` BOOLEAN COMMENT 'Indicator of whether the response is overdue based on the response due date.',
    `priority_level` STRING COMMENT 'Priority classification of the notification based on urgency and business impact.. Valid values are `critical|high|medium|low`',
    `recipient_email` STRING COMMENT 'Email address of the primary recipient.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recipient_name` STRING COMMENT 'Name of the primary recipient of the audit notification, typically the business unit head or process owner.',
    `recipient_title` STRING COMMENT 'Job title or role of the primary recipient.',
    `regulatory_body` STRING COMMENT 'Name of the regulatory body or external auditor involved, if applicable (e.g., Federal Reserve, OCC, SEC, external audit firm).',
    `regulatory_examination_flag` BOOLEAN COMMENT 'Indicator of whether this notification is related to a regulatory examination or external audit coordination.',
    `response_due_date` DATE COMMENT 'Date by which the recipient is required to respond to the notification, applicable for information requests and management response requests.',
    `response_received_date` DATE COMMENT 'Date on which the response to the notification was received from the recipient.',
    `response_received_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the response was received, supporting Service Level Agreement (SLA) tracking.',
    `sender_email` STRING COMMENT 'Email address of the notification sender for correspondence and replies.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `sender_name` STRING COMMENT 'Name of the individual or role issuing the notification, typically the lead auditor or Chief Audit Executive (CAE).',
    `sender_title` STRING COMMENT 'Job title or role of the individual issuing the notification.',
    `subject_line` STRING COMMENT 'Subject line or title of the audit notification communication.',
    `three_lines_of_defense_level` STRING COMMENT 'The line of defense within the three lines model that this notification pertains to: first line (business operations), second line (risk and compliance), or third line (internal audit).. Valid values are `first_line|second_line|third_line`',
    `created_by` STRING COMMENT 'User identifier or name of the individual who created the notification record.',
    CONSTRAINT pk_notification PRIMARY KEY(`notification_id`)
) COMMENT 'Formal audit notification and communication event record capturing all official communications issued during the audit lifecycle — engagement announcement letters, information request lists (IRLs), draft report issuances, management response requests, and final report distributions. Captures notification type, sender, recipient(s), business unit notified, notification date, response due date, response received date, and communication channel. Provides the complete audit communication audit trail supporting regulatory examination responses and dispute resolution.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`program_step` (
    `program_step_id` BIGINT COMMENT 'Primary key for program_step',
    `predecessor_step_id` BIGINT COMMENT 'Reference to another program step that should be completed before this step can begin.',
    `superseded_by_step_id` BIGINT COMMENT 'Reference to the newer program step that replaces this step when it becomes deprecated.',
    `previous_program_step_id` BIGINT COMMENT 'Self-referencing FK on program_step (previous_program_step_id)',
    `applicable_regulations` STRING COMMENT 'List of specific regulations, laws, or compliance frameworks that this audit step addresses.',
    `approval_authority` STRING COMMENT 'The role or position responsible for approving this audit program step for use in audit engagements.',
    `automation_eligible_flag` BOOLEAN COMMENT 'Indicates whether this audit step can be automated through continuous monitoring or audit analytics tools.',
    `control_objective` STRING COMMENT 'The specific control objective that this audit step is designed to test or validate.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this audit program step record was first created in the system.',
    `data_analytics_script_reference` STRING COMMENT 'Reference to automated data analytics scripts or queries that support execution of this audit step.',
    `documentation_requirements` STRING COMMENT 'Specific documentation and evidence requirements that must be collected and retained when performing this audit step.',
    `effective_date` DATE COMMENT 'The date from which this audit program step became effective and available for use in audit programs.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'The estimated number of hours required to complete this audit program step under normal circumstances.',
    `expiration_date` DATE COMMENT 'The date on which this audit program step is no longer valid or has been superseded by a newer version.',
    `frequency_recommendation` STRING COMMENT 'Recommended frequency with which this audit step should be performed based on risk and regulatory requirements.',
    `key_risk_indicator` STRING COMMENT 'The key risk indicator or metric that this audit step monitors or evaluates.',
    `last_review_date` DATE COMMENT 'The date when this audit program step was last reviewed and validated for continued relevance and accuracy.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this audit step is mandatory for all audit engagements or optional based on risk assessment.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this audit program step record was last modified or updated.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this audit program step.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this audit step is required to meet specific regulatory or compliance obligations.',
    `risk_rating` STRING COMMENT 'The inherent risk level associated with the area covered by this audit program step.',
    `sample_size_guidance` STRING COMMENT 'Recommended sample size or sampling methodology for testing activities within this audit step.',
    `sequence_number` STRING COMMENT 'The recommended order in which this step should be performed within an audit program.',
    `skill_level_required` STRING COMMENT 'The minimum skill level or competency required for an auditor to perform this program step effectively.',
    `program_step_status` STRING COMMENT 'Current lifecycle status of this audit program step in the master reference table.',
    `step_category` STRING COMMENT 'The audit methodology category that this step belongs to, defining the nature of audit work performed.',
    `step_code` STRING COMMENT 'Unique business identifier code for the audit program step, used for external reference and reporting.',
    `step_description` STRING COMMENT 'Detailed description of the audit program step, including its purpose, scope, and expected outcomes.',
    `step_name` STRING COMMENT 'The official name of the audit program step as recognized in audit documentation and planning materials.',
    `step_type` STRING COMMENT 'Classification of the audit program step based on its phase in the audit lifecycle.',
    `testing_approach` STRING COMMENT 'Description of the recommended testing methodology or approach to be used when executing this audit step.',
    `three_lines_of_defense_line` STRING COMMENT 'Identifies which line of defense in the three lines of defense model this audit step primarily evaluates.',
    `version_number` STRING COMMENT 'Version identifier for this audit program step, used to track changes and updates over time.',
    `workpaper_template_reference` STRING COMMENT 'Reference to the standard workpaper template or documentation format to be used for this audit step.',
    CONSTRAINT pk_program_step PRIMARY KEY(`program_step_id`)
) COMMENT 'Master reference table for program_step. Referenced by audit_program_step_id.';

CREATE OR REPLACE TABLE `banking_ecm`.`audit`.`business_process` (
    `business_process_id` BIGINT COMMENT 'Primary key for business_process',
    `approved_by_employee_id` BIGINT COMMENT 'Identifier of the individual who formally approved this business process definition.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the primary business unit or division that owns or executes this business process.',
    `employee_id` BIGINT COMMENT 'Identifier of the individual or role responsible for the overall management and performance of the business process.',
    `parent_process_id` BIGINT COMMENT 'Identifier of the parent business process if this process is a sub-process within a larger process hierarchy.',
    `parent_business_process_id` BIGINT COMMENT 'Self-referencing FK on business_process (parent_business_process_id)',
    `approval_date` DATE COMMENT 'The date when this business process definition was formally approved by governance or management.',
    `audit_frequency` STRING COMMENT 'The scheduled frequency at which this business process undergoes internal or external audit review.',
    `automation_level` STRING COMMENT 'Degree to which the business process is automated versus requiring manual intervention.',
    `control_environment_rating` STRING COMMENT 'Assessment of the effectiveness of internal controls established for this business process.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this business process record was first created in the system.',
    `critical_process_flag` BOOLEAN COMMENT 'Indicates whether this business process is deemed critical to the organizations operations or regulatory compliance.',
    `customer_facing_flag` BOOLEAN COMMENT 'Indicates whether this business process directly interacts with or impacts external customers.',
    `data_privacy_impact_flag` BOOLEAN COMMENT 'Indicates whether this business process handles personally identifiable information or is subject to data privacy regulations.',
    `effective_date` DATE COMMENT 'The date from which this business process definition became or will become effective.',
    `end_date` DATE COMMENT 'The date on which this business process was or will be retired or replaced. Null for active processes.',
    `key_controls_count` STRING COMMENT 'The number of key controls identified and documented for this business process.',
    `last_audit_date` DATE COMMENT 'The date when the most recent audit of this business process was completed.',
    `last_review_date` DATE COMMENT 'The date when this business process was last reviewed for accuracy, relevance, and effectiveness.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review of this business process.',
    `next_scheduled_audit_date` DATE COMMENT 'The planned date for the next audit engagement covering this business process.',
    `process_category` STRING COMMENT 'High-level categorization of the business process by functional area within the banking organization.',
    `process_code` STRING COMMENT 'Unique alphanumeric code assigned to the business process for external reference and reporting.',
    `process_complexity` STRING COMMENT 'Assessment of the complexity of the business process based on number of steps, dependencies, and decision points.',
    `process_description` STRING COMMENT 'Detailed description of the business process, including its purpose, scope, and key activities.',
    `process_documentation_url` STRING COMMENT 'Link to the detailed process documentation, standard operating procedures, or process maps.',
    `process_name` STRING COMMENT 'The official name of the business process as recognized across the organization.',
    `process_status` STRING COMMENT 'Current lifecycle status of the business process indicating whether it is actively in use or has been retired.',
    `process_type` STRING COMMENT 'Classification of the process by its nature and purpose within the organization.',
    `regulatory_scope_flag` BOOLEAN COMMENT 'Indicates whether this business process is subject to specific regulatory oversight or reporting requirements.',
    `risk_rating` STRING COMMENT 'Overall risk assessment of the business process based on inherent and residual risk analysis.',
    `sox_applicable_flag` BOOLEAN COMMENT 'Indicates whether this business process falls within the scope of Sarbanes-Oxley Act compliance requirements.',
    `three_lines_of_defense_position` STRING COMMENT 'Classification of the business process within the three lines of defense risk management model.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this business process record was last modified.',
    `version_number` STRING COMMENT 'Version identifier for the business process definition, following semantic versioning conventions.',
    CONSTRAINT pk_business_process PRIMARY KEY(`business_process_id`)
) COMMENT 'Master reference table for business_process. Referenced by business_process_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `banking_ecm`.`audit`.`plan` ADD CONSTRAINT `fk_audit_plan_prior_plan_id` FOREIGN KEY (`prior_plan_id`) REFERENCES `banking_ecm`.`audit`.`plan`(`plan_id`);
ALTER TABLE `banking_ecm`.`audit`.`plan` ADD CONSTRAINT `fk_audit_plan_previous_audit_plan_id` FOREIGN KEY (`previous_audit_plan_id`) REFERENCES `banking_ecm`.`audit`.`plan`(`plan_id`);
ALTER TABLE `banking_ecm`.`audit`.`universe` ADD CONSTRAINT `fk_audit_universe_parent_universe_id` FOREIGN KEY (`parent_universe_id`) REFERENCES `banking_ecm`.`audit`.`universe`(`universe_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `banking_ecm`.`audit`.`plan`(`plan_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_universe_id` FOREIGN KEY (`universe_id`) REFERENCES `banking_ecm`.`audit`.`universe`(`universe_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement` ADD CONSTRAINT `fk_audit_engagement_previous_audit_engagement_id` FOREIGN KEY (`previous_audit_engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ADD CONSTRAINT `fk_audit_engagement_scope_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ADD CONSTRAINT `fk_audit_engagement_scope_previous_engagement_scope_id` FOREIGN KEY (`previous_engagement_scope_id`) REFERENCES `banking_ecm`.`audit`.`engagement_scope`(`engagement_scope_id`);
ALTER TABLE `banking_ecm`.`audit`.`program` ADD CONSTRAINT `fk_audit_program_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`audit`.`program` ADD CONSTRAINT `fk_audit_program_previous_audit_program_id` FOREIGN KEY (`previous_audit_program_id`) REFERENCES `banking_ecm`.`audit`.`program`(`program_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_program_step_id` FOREIGN KEY (`program_step_id`) REFERENCES `banking_ecm`.`audit`.`program_step`(`program_step_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_business_process_id` FOREIGN KEY (`business_process_id`) REFERENCES `banking_ecm`.`audit`.`business_process`(`business_process_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_finding_id` FOREIGN KEY (`finding_id`) REFERENCES `banking_ecm`.`audit`.`finding`(`finding_id`);
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ADD CONSTRAINT `fk_audit_workpaper_previous_workpaper_id` FOREIGN KEY (`previous_workpaper_id`) REFERENCES `banking_ecm`.`audit`.`workpaper`(`workpaper_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_prior_finding_id` FOREIGN KEY (`prior_finding_id`) REFERENCES `banking_ecm`.`audit`.`finding`(`finding_id`);
ALTER TABLE `banking_ecm`.`audit`.`finding` ADD CONSTRAINT `fk_audit_finding_superseded_finding_id` FOREIGN KEY (`superseded_finding_id`) REFERENCES `banking_ecm`.`audit`.`finding`(`finding_id`);
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ADD CONSTRAINT `fk_audit_recommendation_finding_id` FOREIGN KEY (`finding_id`) REFERENCES `banking_ecm`.`audit`.`finding`(`finding_id`);
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ADD CONSTRAINT `fk_audit_recommendation_superseded_recommendation_id` FOREIGN KEY (`superseded_recommendation_id`) REFERENCES `banking_ecm`.`audit`.`recommendation`(`recommendation_id`);
ALTER TABLE `banking_ecm`.`audit`.`management_action` ADD CONSTRAINT `fk_audit_management_action_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`audit`.`management_action` ADD CONSTRAINT `fk_audit_management_action_finding_id` FOREIGN KEY (`finding_id`) REFERENCES `banking_ecm`.`audit`.`finding`(`finding_id`);
ALTER TABLE `banking_ecm`.`audit`.`management_action` ADD CONSTRAINT `fk_audit_management_action_related_management_action_id` FOREIGN KEY (`related_management_action_id`) REFERENCES `banking_ecm`.`audit`.`management_action`(`management_action_id`);
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ADD CONSTRAINT `fk_audit_issue_validation_finding_id` FOREIGN KEY (`finding_id`) REFERENCES `banking_ecm`.`audit`.`finding`(`finding_id`);
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ADD CONSTRAINT `fk_audit_issue_validation_management_action_id` FOREIGN KEY (`management_action_id`) REFERENCES `banking_ecm`.`audit`.`management_action`(`management_action_id`);
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ADD CONSTRAINT `fk_audit_issue_validation_previous_issue_validation_id` FOREIGN KEY (`previous_issue_validation_id`) REFERENCES `banking_ecm`.`audit`.`issue_validation`(`issue_validation_id`);
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ADD CONSTRAINT `fk_audit_audit_report_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ADD CONSTRAINT `fk_audit_audit_report_superseded_audit_report_id` FOREIGN KEY (`superseded_audit_report_id`) REFERENCES `banking_ecm`.`audit`.`audit_report`(`audit_report_id`);
ALTER TABLE `banking_ecm`.`audit`.`resource` ADD CONSTRAINT `fk_audit_resource_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`audit`.`resource` ADD CONSTRAINT `fk_audit_resource_supervisor_resource_id` FOREIGN KEY (`supervisor_resource_id`) REFERENCES `banking_ecm`.`audit`.`resource`(`resource_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ADD CONSTRAINT `fk_audit_engagement_assignment_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ADD CONSTRAINT `fk_audit_engagement_assignment_previous_engagement_assignment_id` FOREIGN KEY (`previous_engagement_assignment_id`) REFERENCES `banking_ecm`.`audit`.`engagement_assignment`(`engagement_assignment_id`);
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ADD CONSTRAINT `fk_audit_continuous_monitoring_previous_continuous_monitoring_id` FOREIGN KEY (`previous_continuous_monitoring_id`) REFERENCES `banking_ecm`.`audit`.`continuous_monitoring`(`continuous_monitoring_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_continuous_monitoring_id` FOREIGN KEY (`continuous_monitoring_id`) REFERENCES `banking_ecm`.`audit`.`continuous_monitoring`(`continuous_monitoring_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_finding_id` FOREIGN KEY (`finding_id`) REFERENCES `banking_ecm`.`audit`.`finding`(`finding_id`);
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ADD CONSTRAINT `fk_audit_monitoring_exception_previous_monitoring_exception_id` FOREIGN KEY (`previous_monitoring_exception_id`) REFERENCES `banking_ecm`.`audit`.`monitoring_exception`(`monitoring_exception_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ADD CONSTRAINT `fk_audit_regulatory_audit_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `banking_ecm`.`audit`.`plan`(`plan_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ADD CONSTRAINT `fk_audit_regulatory_audit_universe_id` FOREIGN KEY (`universe_id`) REFERENCES `banking_ecm`.`audit`.`universe`(`universe_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ADD CONSTRAINT `fk_audit_regulatory_audit_previous_regulatory_audit_id` FOREIGN KEY (`previous_regulatory_audit_id`) REFERENCES `banking_ecm`.`audit`.`regulatory_audit`(`regulatory_audit_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ADD CONSTRAINT `fk_audit_regulatory_finding_regulatory_audit_id` FOREIGN KEY (`regulatory_audit_id`) REFERENCES `banking_ecm`.`audit`.`regulatory_audit`(`regulatory_audit_id`);
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ADD CONSTRAINT `fk_audit_regulatory_finding_superseded_regulatory_finding_id` FOREIGN KEY (`superseded_regulatory_finding_id`) REFERENCES `banking_ecm`.`audit`.`regulatory_finding`(`regulatory_finding_id`);
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ADD CONSTRAINT `fk_audit_committee_report_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `banking_ecm`.`audit`.`plan`(`plan_id`);
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ADD CONSTRAINT `fk_audit_committee_report_previous_committee_report_id` FOREIGN KEY (`previous_committee_report_id`) REFERENCES `banking_ecm`.`audit`.`committee_report`(`committee_report_id`);
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ADD CONSTRAINT `fk_audit_risk_assessment_universe_id` FOREIGN KEY (`universe_id`) REFERENCES `banking_ecm`.`audit`.`universe`(`universe_id`);
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ADD CONSTRAINT `fk_audit_risk_assessment_previous_risk_assessment_id` FOREIGN KEY (`previous_risk_assessment_id`) REFERENCES `banking_ecm`.`audit`.`risk_assessment`(`risk_assessment_id`);
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ADD CONSTRAINT `fk_audit_three_lines_assignment_universe_id` FOREIGN KEY (`universe_id`) REFERENCES `banking_ecm`.`audit`.`universe`(`universe_id`);
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ADD CONSTRAINT `fk_audit_three_lines_assignment_related_three_lines_assignment_id` FOREIGN KEY (`related_three_lines_assignment_id`) REFERENCES `banking_ecm`.`audit`.`three_lines_assignment`(`three_lines_assignment_id`);
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ADD CONSTRAINT `fk_audit_quality_assurance_review_prior_review_quality_assurance_review_id` FOREIGN KEY (`prior_review_quality_assurance_review_id`) REFERENCES `banking_ecm`.`audit`.`quality_assurance_review`(`quality_assurance_review_id`);
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ADD CONSTRAINT `fk_audit_quality_assurance_review_previous_quality_assurance_review_id` FOREIGN KEY (`previous_quality_assurance_review_id`) REFERENCES `banking_ecm`.`audit`.`quality_assurance_review`(`quality_assurance_review_id`);
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ADD CONSTRAINT `fk_audit_issue_tracker_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ADD CONSTRAINT `fk_audit_issue_tracker_finding_id` FOREIGN KEY (`finding_id`) REFERENCES `banking_ecm`.`audit`.`finding`(`finding_id`);
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ADD CONSTRAINT `fk_audit_issue_tracker_prior_issue_issue_tracker_id` FOREIGN KEY (`prior_issue_issue_tracker_id`) REFERENCES `banking_ecm`.`audit`.`issue_tracker`(`issue_tracker_id`);
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ADD CONSTRAINT `fk_audit_issue_tracker_related_issue_tracker_id` FOREIGN KEY (`related_issue_tracker_id`) REFERENCES `banking_ecm`.`audit`.`issue_tracker`(`issue_tracker_id`);
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ADD CONSTRAINT `fk_audit_cae_charter_superseded_charter_cae_charter_id` FOREIGN KEY (`superseded_charter_cae_charter_id`) REFERENCES `banking_ecm`.`audit`.`cae_charter`(`cae_charter_id`);
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ADD CONSTRAINT `fk_audit_cae_charter_previous_cae_charter_id` FOREIGN KEY (`previous_cae_charter_id`) REFERENCES `banking_ecm`.`audit`.`cae_charter`(`cae_charter_id`);
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ADD CONSTRAINT `fk_audit_audit_budget_plan_id` FOREIGN KEY (`plan_id`) REFERENCES `banking_ecm`.`audit`.`plan`(`plan_id`);
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ADD CONSTRAINT `fk_audit_audit_budget_previous_audit_budget_id` FOREIGN KEY (`previous_audit_budget_id`) REFERENCES `banking_ecm`.`audit`.`audit_budget`(`audit_budget_id`);
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ADD CONSTRAINT `fk_audit_cosourcing_arrangement_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ADD CONSTRAINT `fk_audit_cosourcing_arrangement_lead_cosourcing_arrangement_id` FOREIGN KEY (`lead_cosourcing_arrangement_id`) REFERENCES `banking_ecm`.`audit`.`cosourcing_arrangement`(`cosourcing_arrangement_id`);
ALTER TABLE `banking_ecm`.`audit`.`notification` ADD CONSTRAINT `fk_audit_notification_engagement_id` FOREIGN KEY (`engagement_id`) REFERENCES `banking_ecm`.`audit`.`engagement`(`engagement_id`);
ALTER TABLE `banking_ecm`.`audit`.`notification` ADD CONSTRAINT `fk_audit_notification_previous_audit_notification_id` FOREIGN KEY (`previous_audit_notification_id`) REFERENCES `banking_ecm`.`audit`.`notification`(`notification_id`);
ALTER TABLE `banking_ecm`.`audit`.`program_step` ADD CONSTRAINT `fk_audit_program_step_predecessor_step_id` FOREIGN KEY (`predecessor_step_id`) REFERENCES `banking_ecm`.`audit`.`program_step`(`program_step_id`);
ALTER TABLE `banking_ecm`.`audit`.`program_step` ADD CONSTRAINT `fk_audit_program_step_superseded_by_step_id` FOREIGN KEY (`superseded_by_step_id`) REFERENCES `banking_ecm`.`audit`.`program_step`(`program_step_id`);
ALTER TABLE `banking_ecm`.`audit`.`program_step` ADD CONSTRAINT `fk_audit_program_step_previous_program_step_id` FOREIGN KEY (`previous_program_step_id`) REFERENCES `banking_ecm`.`audit`.`program_step`(`program_step_id`);
ALTER TABLE `banking_ecm`.`audit`.`business_process` ADD CONSTRAINT `fk_audit_business_process_parent_process_id` FOREIGN KEY (`parent_process_id`) REFERENCES `banking_ecm`.`audit`.`business_process`(`business_process_id`);
ALTER TABLE `banking_ecm`.`audit`.`business_process` ADD CONSTRAINT `fk_audit_business_process_parent_business_process_id` FOREIGN KEY (`parent_business_process_id`) REFERENCES `banking_ecm`.`audit`.`business_process`(`business_process_id`);

-- ========= TAGS =========
ALTER SCHEMA `banking_ecm`.`audit` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `banking_ecm`.`audit` SET TAGS ('dbx_domain' = 'audit');
ALTER TABLE `banking_ecm`.`audit`.`plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`plan` SET TAGS ('dbx_subdomain' = 'planning_operations');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Chief Audit Executive (CAE) Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `prior_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Audit Plan Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `regulatory_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Calendar Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `previous_audit_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `advisory_hours` SET TAGS ('dbx_business_glossary_term' = 'Advisory Service Hours');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `approval_committee` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Committee Name');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `assurance_hours` SET TAGS ('dbx_business_glossary_term' = 'Assurance Service Hours');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `audit_committee_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Approval Date');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `audit_universe_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Universe Count');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `combined_assurance_approach` SET TAGS ('dbx_business_glossary_term' = 'Combined Assurance Approach Flag');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `contingency_hours` SET TAGS ('dbx_business_glossary_term' = 'Contingency Audit Hours');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Audit Universe Coverage Percentage');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `external_audit_coordination` SET TAGS ('dbx_business_glossary_term' = 'External Audit Coordination Flag');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `financial_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Financial Coverage Percentage');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `it_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Information Technology (IT) Coverage Percentage');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `key_risk_themes` SET TAGS ('dbx_business_glossary_term' = 'Key Risk Themes');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `last_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revision Date');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `operational_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Operational Coverage Percentage');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Description');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Name');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Status');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Type');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'annual|multi_year|quarterly|ad_hoc|continuous');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `planned_audit_count` SET TAGS ('dbx_business_glossary_term' = 'Planned Audit Count');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `planning_methodology` SET TAGS ('dbx_business_glossary_term' = 'Planning Methodology');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `planning_methodology` SET TAGS ('dbx_value_regex' = 'risk_based|cyclical|regulatory_driven|hybrid|continuous_monitoring|combined_assurance');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `regulatory_coverage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Coverage Percentage');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `regulatory_exam_coordination` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Coordination Flag');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `resource_constraint_notes` SET TAGS ('dbx_business_glossary_term' = 'Resource Constraint Notes');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Start Date');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `strategic_alignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Strategic Alignment Notes');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Submitted Date');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `three_lines_model_alignment` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Model Alignment');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `three_lines_model_alignment` SET TAGS ('dbx_value_regex' = 'aligned|partial|not_aligned');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `total_planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Audit Hours');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
ALTER TABLE `banking_ecm`.`audit`.`plan` ALTER COLUMN `year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `banking_ecm`.`audit`.`universe` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`universe` SET TAGS ('dbx_subdomain' = 'planning_operations');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `universe_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Universe Identifier');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `geographic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `industry_code_id` SET TAGS ('dbx_business_glossary_term' = 'Industry Code Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `regulatory_change_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Taxonomy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `parent_universe_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `aml_bsa_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) / Bank Secrecy Act (BSA) Scope Flag');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `annual_revenue_impact` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Impact');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `annual_revenue_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `asset_value` SET TAGS ('dbx_business_glossary_term' = 'Asset Value');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `asset_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `audit_committee_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reporting Flag');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `audit_coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Coverage Status');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `audit_coverage_status` SET TAGS ('dbx_value_regex' = 'current|overdue|upcoming|not_scheduled');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency in Months');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `ccar_dfast_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review (CCAR) / Dodd-Frank Act Stress Testing (DFAST) Scope Flag');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `continuous_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuous Monitoring Flag');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `control_environment_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Environment Rating');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `control_environment_rating` SET TAGS ('dbx_value_regex' = 'strong|adequate|weak|not_assessed');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `entity_code` SET TAGS ('dbx_business_glossary_term' = 'Auditable Entity Code');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `entity_description` SET TAGS ('dbx_business_glossary_term' = 'Auditable Entity Description');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `entity_name` SET TAGS ('dbx_business_glossary_term' = 'Auditable Entity Name');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `entity_status` SET TAGS ('dbx_business_glossary_term' = 'Auditable Entity Status');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `entity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|merged|divested|under_review');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Auditable Entity Type');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'process|system|legal_entity|product_line|business_unit|control');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `external_audit_coordination_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Coordination Flag');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `high_priority_findings_count` SET TAGS ('dbx_business_glossary_term' = 'High Priority Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `key_risk_indicators` SET TAGS ('dbx_business_glossary_term' = 'Key Risk Indicators (KRI)');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `last_audit_rating` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Rating');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `last_audit_rating` SET TAGS ('dbx_value_regex' = 'satisfactory|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `last_audit_type` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Type');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `last_audit_type` SET TAGS ('dbx_value_regex' = 'comprehensive|focused|follow_up|advisory|continuous');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `last_risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Risk Assessment Date');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `materiality_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Materiality Threshold Amount');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `materiality_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `next_risk_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Risk Assessment Date');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `next_scheduled_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Audit Date');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `open_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Open Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `overdue_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Overdue Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `owning_division` SET TAGS ('dbx_business_glossary_term' = 'Owning Business Division');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `regulatory_relevance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Relevance Flag');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|minimal');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `rwa_allocation` SET TAGS ('dbx_business_glossary_term' = 'Risk-Weighted Assets (RWA) Allocation');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `rwa_allocation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scope Flag');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `three_lines_position` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Position');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `three_lines_position` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line|not_applicable');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `banking_ecm`.`audit`.`universe` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`engagement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`engagement` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement ID');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `alco_meeting_id` SET TAGS ('dbx_business_glossary_term' = 'Alco Meeting Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `capital_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `capital_ratio_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Ratio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `cash_flow_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Cash Flow Forecast Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `consent_order_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Order Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `contingency_funding_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Contingency Funding Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor ID');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Manager ID');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `fund_administrator_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Administrator Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `fund_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Audit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `fund_lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Lifecycle Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `fund_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `fund_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Performance Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `fund_regulatory_report_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Regulatory Report Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `funding_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `geographic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `interest_rate_risk_position_id` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Risk Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `investor_account_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `irb_model_id` SET TAGS ('dbx_business_glossary_term' = 'Irb Model Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `lei_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Lei Registry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `liquidity_ratio_id` SET TAGS ('dbx_business_glossary_term' = 'Lcr Ratio Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Materiality Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan ID');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Taxonomy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `transfer_pricing_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Pricing Curve Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `universe_id` SET TAGS ('dbx_business_glossary_term' = 'Auditable Entity ID');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `previous_audit_engagement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `audit_committee_presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Presentation Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `audit_objectives` SET TAGS ('dbx_business_glossary_term' = 'Audit Objectives');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `audit_opinion` SET TAGS ('dbx_business_glossary_term' = 'Audit Opinion');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `audit_opinion` SET TAGS ('dbx_value_regex' = 'satisfactory|needs_improvement|unsatisfactory|no_opinion');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `continuous_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuous Monitoring Flag');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `data_analytics_used_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Analytics Used Flag');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_number` SET TAGS ('dbx_business_glossary_term' = 'Engagement Number');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_value_regex' = 'planning|fieldwork|reporting|management_response|closed|cancelled');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Type');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `engagement_type` SET TAGS ('dbx_value_regex' = 'assurance|advisory|regulatory|sox_compliance|it_audit|aml_bsa_review');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `external_auditor_coordination_flag` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Coordination Flag');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `management_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Management Response Due Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `management_response_received_date` SET TAGS ('dbx_business_glossary_term' = 'Management Response Received Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `overall_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `overall_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `planned_end_date` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Engagement Priority');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `report_distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Report Distribution List');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `report_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Report Issue Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `scope_statement` SET TAGS ('dbx_business_glossary_term' = 'Scope Statement');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `sox_section` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Section');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `three_lines_of_defense_line` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Line');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `three_lines_of_defense_line` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Engagement Title');
ALTER TABLE `banking_ecm`.`audit`.`engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `engagement_scope_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Scope ID');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement ID');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Materiality Currency');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `geographic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `product_type_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Product Type Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `previous_engagement_scope_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `audit_committee_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reported Flag');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `continuous_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuous Monitoring Flag');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `control_framework` SET TAGS ('dbx_business_glossary_term' = 'Control Framework');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Inclusion Flag');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `materiality_threshold` SET TAGS ('dbx_business_glossary_term' = 'Materiality Threshold');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `process_name` SET TAGS ('dbx_business_glossary_term' = 'Process Name');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `regulatory_examination_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Flag');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `risk_justification` SET TAGS ('dbx_business_glossary_term' = 'Risk Justification');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|minimal');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `sampling_approach` SET TAGS ('dbx_business_glossary_term' = 'Sampling Approach');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `sampling_approach` SET TAGS ('dbx_value_regex' = 'statistical|judgmental|full_population|risk_based');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `scope_change_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Approved By');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `scope_change_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `scope_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Flag');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `scope_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Scope Change Reason');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `scope_item_code` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Code');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `scope_item_name` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Name');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `scope_item_type` SET TAGS ('dbx_business_glossary_term' = 'Scope Item Type');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `scope_item_type` SET TAGS ('dbx_value_regex' = 'process|system|geography|product|legal_entity|business_unit');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `scope_notes` SET TAGS ('dbx_business_glossary_term' = 'Scope Notes');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `scope_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Period End Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `scope_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scope Period Start Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `scope_rationale` SET TAGS ('dbx_business_glossary_term' = 'Scope Rationale');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_business_glossary_term' = 'Scope Status');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `scope_status` SET TAGS ('dbx_value_regex' = 'draft|approved|in_progress|completed|superseded');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `system_name` SET TAGS ('dbx_business_glossary_term' = 'System Name');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Level');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line');
ALTER TABLE `banking_ecm`.`audit`.`engagement_scope` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`audit`.`program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`program` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program ID');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement ID');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Sox Control Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor ID');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `program_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer ID');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `previous_audit_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Program Approval Date');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `audit_committee_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reporting Flag');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `automated_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Automated Control Flag');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Program Completion Date');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `control_objective` SET TAGS ('dbx_business_glossary_term' = 'Control Objective');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `coso_component` SET TAGS ('dbx_business_glossary_term' = 'COSO (Committee of Sponsoring Organizations) Component');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `coso_component` SET TAGS ('dbx_value_regex' = 'control_environment|risk_assessment|control_activities|information_communication|monitoring');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `data_analytics_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Analytics Flag');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `expected_evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Expected Evidence Type');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `external_auditor_reliance_flag` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Reliance Flag');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `high_risk_findings_count` SET TAGS ('dbx_business_glossary_term' = 'High Risk Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `key_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Key Control Flag');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `population_size` SET TAGS ('dbx_business_glossary_term' = 'Population Size');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Code');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}$');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Name');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|approved|in_progress|completed|on_hold|cancelled');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Type');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'operational|financial|compliance|IT|fraud|regulatory');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `risk_area` SET TAGS ('dbx_business_glossary_term' = 'Risk Area');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `risk_area` SET TAGS ('dbx_value_regex' = 'credit|market|operational|liquidity|compliance|reputational');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Methodology');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `sampling_method` SET TAGS ('dbx_value_regex' = 'judgmental|statistical|random|stratified|monetary_unit|full_population');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope Description');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `sox_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'SOX (Sarbanes-Oxley Act) Relevant Flag');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `test_approach` SET TAGS ('dbx_business_glossary_term' = 'Test Approach Methodology');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `test_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Test Period End Date');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `test_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Test Period Start Date');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `three_lines_model_line` SET TAGS ('dbx_business_glossary_term' = 'Three Lines Model Line');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `three_lines_model_line` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Program Version Number');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `banking_ecm`.`audit`.`program` ALTER COLUMN `workpaper_reference` SET TAGS ('dbx_business_glossary_term' = 'Workpaper Reference');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `workpaper_id` SET TAGS ('dbx_business_glossary_term' = 'Workpaper Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Tested Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `alm_hedge_id` SET TAGS ('dbx_business_glossary_term' = 'Alm Hedge Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `program_step_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program Step Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `business_process_id` SET TAGS ('dbx_business_glossary_term' = 'Business Process Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Control Tested Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `counterparty_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `debt_issuance_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Issuance Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Balance Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `direct_debit_mandate_id` SET TAGS ('dbx_business_glossary_term' = 'Tested Mandate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `execution_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Finding Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `ftp_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Ftp Rate Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `hqla_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Hqla Inventory Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `lc_id` SET TAGS ('dbx_business_glossary_term' = 'Lc Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `credit_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Security Credit Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `standing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Tested Standing Order Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `workpaper_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Preparer Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `workpaper_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `workpaper_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `previous_workpaper_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `audit_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Audit Conclusion');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `audit_objective` SET TAGS ('dbx_business_glossary_term' = 'Audit Objective');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective|not_applicable|not_tested');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `data_extraction_date` SET TAGS ('dbx_business_glossary_term' = 'Data Extraction Date');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `data_extraction_query` SET TAGS ('dbx_business_glossary_term' = 'Data Extraction Query');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `document_page_count` SET TAGS ('dbx_business_glossary_term' = 'Document Page Count');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `document_storage_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Reference');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `exception_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Exception Rate Percentage');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `exceptions_identified_count` SET TAGS ('dbx_business_glossary_term' = 'Exceptions Identified Count');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `finding_raised_flag` SET TAGS ('dbx_business_glossary_term' = 'Finding Raised Flag');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `interview_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Date');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `interviewee_name` SET TAGS ('dbx_business_glossary_term' = 'Interviewee Name');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `interviewee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `interviewee_title` SET TAGS ('dbx_business_glossary_term' = 'Interviewee Title');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `population_size` SET TAGS ('dbx_business_glossary_term' = 'Population Size');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `preparation_date` SET TAGS ('dbx_business_glossary_term' = 'Preparation Date');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Workpaper Reference Number');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}-[0-9]{3,6}(-[0-9]{1,3})?$');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Years');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Review Notes');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|submitted_for_review|review_in_progress|returned_for_revision|approved|archived');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `sampling_method` SET TAGS ('dbx_business_glossary_term' = 'Sampling Method');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `testing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Testing Period End Date');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `testing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Testing Period Start Date');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Workpaper Title');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `workpaper_description` SET TAGS ('dbx_business_glossary_term' = 'Workpaper Description');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `workpaper_type` SET TAGS ('dbx_business_glossary_term' = 'Workpaper Type');
ALTER TABLE `banking_ecm`.`audit`.`workpaper` ALTER COLUMN `workpaper_type` SET TAGS ('dbx_value_regex' = 'planning_memo|control_walkthrough|test_of_controls|substantive_test|interview_notes|data_extract');
ALTER TABLE `banking_ecm`.`audit`.`finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`audit`.`finding` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Finding Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `alco_resolution_id` SET TAGS ('dbx_business_glossary_term' = 'Alco Resolution Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Control Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `corporate_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corporate Action Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `counterparty_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Agreement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `finding_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Finding Owner Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `finding_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `finding_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `fund_expense_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Expense Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `fund_valuation_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Valuation Adjustment Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `issuer_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Related Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `prior_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Finding Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Related Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Related Hold Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `restriction_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Restriction Breach Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `credit_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Security Credit Rating Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `trading_book_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Book Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `nostro_reconciliation_id` SET TAGS ('dbx_business_glossary_term' = 'Treasury Nostro Reconciliation Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `yield_curve_id` SET TAGS ('dbx_business_glossary_term' = 'Yield Curve Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `superseded_finding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `actual_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Remediation Date');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `audit_committee_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reported Flag');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `business_process` SET TAGS ('dbx_business_glossary_term' = 'Business Process');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `cause` SET TAGS ('dbx_business_glossary_term' = 'Finding Cause');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `condition` SET TAGS ('dbx_business_glossary_term' = 'Finding Condition');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `criteria` SET TAGS ('dbx_business_glossary_term' = 'Finding Criteria');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `effect` SET TAGS ('dbx_business_glossary_term' = 'Finding Effect');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `external_auditor_shared_flag` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Shared Flag');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `finding_status` SET TAGS ('dbx_value_regex' = 'draft|open|in remediation|pending validation|closed|reopened');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'control deficiency|significant deficiency|material weakness|observation|best practice');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `geography` SET TAGS ('dbx_business_glossary_term' = 'Geography');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `impact` SET TAGS ('dbx_business_glossary_term' = 'Impact Rating');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `impact` SET TAGS ('dbx_value_regex' = 'very high|high|medium|low|very low');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Issued Date');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `likelihood` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Rating');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `likelihood` SET TAGS ('dbx_value_regex' = 'very high|high|medium|low|very low');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `management_agrees_flag` SET TAGS ('dbx_business_glossary_term' = 'Management Agrees Flag');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `recommendation` SET TAGS ('dbx_business_glossary_term' = 'Audit Recommendation');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `regulatory_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reported Flag');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `remediation_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Remediation Cost Estimate');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'process design|execution failure|resource constraint|technology limitation|training gap|oversight weakness');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `sox_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Relevant Flag');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `target_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Remediation Date');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `three_lines_position` SET TAGS ('dbx_business_glossary_term' = 'Three Lines Position');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `three_lines_position` SET TAGS ('dbx_value_regex' = 'first line|second line|third line');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`finding` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `recommendation_id` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Finding Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `superseded_recommendation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|partially_accepted|under_negotiation');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `actual_implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Implementation Date');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `alternative_action_proposed` SET TAGS ('dbx_business_glossary_term' = 'Alternative Action Proposed');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `alternative_action_proposed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `audit_committee_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Report Date');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `audit_committee_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reported Flag');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `control_framework_reference` SET TAGS ('dbx_business_glossary_term' = 'Control Framework Reference');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Amount');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `estimated_implementation_effort` SET TAGS ('dbx_business_glossary_term' = 'Estimated Implementation Effort');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `estimated_implementation_effort` SET TAGS ('dbx_value_regex' = 'minimal|low|moderate|high|extensive');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `implementation_progress_percentage` SET TAGS ('dbx_business_glossary_term' = 'Implementation Progress Percentage');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `management_response` SET TAGS ('dbx_business_glossary_term' = 'Management Response');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `management_response` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `management_response_date` SET TAGS ('dbx_business_glossary_term' = 'Management Response Date');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `original_target_date` SET TAGS ('dbx_business_glossary_term' = 'Original Target Remediation Date');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `recommendation_number` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Number');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `recommendation_number` SET TAGS ('dbx_value_regex' = '^REC-[0-9]{4}-[0-9]{4}$');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `recommendation_status` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Status');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `recommendation_text` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Text');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `recommendation_text` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `recommendation_type` SET TAGS ('dbx_business_glossary_term' = 'Recommendation Type');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `recommendation_type` SET TAGS ('dbx_value_regex' = 'process_improvement|control_enhancement|policy_update|system_change|training|organizational_change');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `rejection_rationale` SET TAGS ('dbx_business_glossary_term' = 'Rejection Rationale');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `rejection_rationale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `responsible_business_owner` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Owner');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `responsible_business_owner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Control Flag');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `target_remediation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Remediation Date');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `three_lines_defense_line` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Line');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `three_lines_defense_line` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `validation_auditor` SET TAGS ('dbx_business_glossary_term' = 'Validation Auditor');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `validation_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `banking_ecm`.`audit`.`recommendation` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|validated|not_validated|retest_required');
ALTER TABLE `banking_ecm`.`audit`.`management_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`audit`.`management_action` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `management_action_id` SET TAGS ('dbx_business_glossary_term' = 'Management Action Plan (MAP) ID');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Action Owner Employee ID');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement ID');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `currency_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `related_management_action_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `action_notes` SET TAGS ('dbx_business_glossary_term' = 'Action Notes');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `action_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Action Owner Name');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `action_owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `action_owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `action_owner_title` SET TAGS ('dbx_business_glossary_term' = 'Action Owner Title');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `action_priority` SET TAGS ('dbx_business_glossary_term' = 'Action Priority');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `action_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|overdue|closed|cancelled');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'process_enhancement|policy_update|system_change|training|control_implementation|other');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `audit_committee_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Report Date');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `audit_committee_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reported Flag');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `completion_evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Completion Evidence Description');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `control_framework` SET TAGS ('dbx_business_glossary_term' = 'Control Framework');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `days_open` SET TAGS ('dbx_business_glossary_term' = 'Days Open');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `extension_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Extension Approval Date');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `extension_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Extension Approved By');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `extension_count` SET TAGS ('dbx_business_glossary_term' = 'Extension Count');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `map_number` SET TAGS ('dbx_business_glossary_term' = 'Management Action Plan (MAP) Number');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `original_target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Original Target Completion Date');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdue Flag');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `regulatory_examination_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Flag');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `revised_target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Revised Target Completion Date');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Level');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `validated_by` SET TAGS ('dbx_business_glossary_term' = 'Validated By');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Internal Audit Validation Status');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending_validation|validated|not_validated|partially_validated');
ALTER TABLE `banking_ecm`.`audit`.`management_action` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `issue_validation_id` SET TAGS ('dbx_business_glossary_term' = 'Issue Validation ID');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `management_action_id` SET TAGS ('dbx_business_glossary_term' = 'Management Action ID');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validator Employee ID');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `previous_issue_validation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `audit_committee_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Report Date');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `audit_committee_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reported Flag');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Effectiveness Rating');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `control_effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|partially effective|ineffective|not tested');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `evidence_location` SET TAGS ('dbx_business_glossary_term' = 'Evidence Location');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `evidence_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Evidence Reviewed');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Exception Count');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `exceptions_identified` SET TAGS ('dbx_business_glossary_term' = 'Exceptions Identified');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `regulatory_examination_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Flag');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `reopen_date` SET TAGS ('dbx_business_glossary_term' = 'Reopen Date');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `reopen_flag` SET TAGS ('dbx_business_glossary_term' = 'Reopen Flag');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `reopen_reason` SET TAGS ('dbx_business_glossary_term' = 'Reopen Reason');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `residual_risk_accepted_flag` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Accepted Flag');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `residual_risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Assessment');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|minimal');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `sample_population` SET TAGS ('dbx_business_glossary_term' = 'Sample Population');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `testing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Testing Period End Date');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `testing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Testing Period Start Date');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Level');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_value_regex' = 'first line|second line|third line');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `validation_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Validation Conclusion');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `validation_conclusion` SET TAGS ('dbx_value_regex' = 'validated closed|partially remediated|not remediated|pending additional evidence|deferred|superseded');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `validation_method` SET TAGS ('dbx_business_glossary_term' = 'Validation Method');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `validation_notes` SET TAGS ('dbx_business_glossary_term' = 'Validation Notes');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `validation_number` SET TAGS ('dbx_business_glossary_term' = 'Validation Number');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'draft|in progress|completed|approved|rejected');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `validation_team` SET TAGS ('dbx_business_glossary_term' = 'Validation Team');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `validator_name` SET TAGS ('dbx_business_glossary_term' = 'Validator Name');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `validator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`issue_validation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `audit_report_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `superseded_audit_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `audit_committee_presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Presentation Date');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `audit_director_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Director Name');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `audit_objective` SET TAGS ('dbx_business_glossary_term' = 'Audit Objective');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `audit_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `audit_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `background_context` SET TAGS ('dbx_business_glossary_term' = 'Background and Context');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Report Confidentiality Level');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Report Distribution List');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `distribution_list` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `executive_summary` SET TAGS ('dbx_business_glossary_term' = 'Executive Summary');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `high_findings_count` SET TAGS ('dbx_business_glossary_term' = 'High Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Report Issuance Date');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `low_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Low Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `management_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Management Agreement Flag');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `management_response_summary` SET TAGS ('dbx_business_glossary_term' = 'Management Response Summary');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `medium_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Medium Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `methodology_description` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology Description');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Report Notes');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `overall_audit_opinion` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Opinion');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `overall_audit_opinion` SET TAGS ('dbx_value_regex' = 'satisfactory|needs_improvement|unsatisfactory|no_opinion');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `positive_observations` SET TAGS ('dbx_business_glossary_term' = 'Positive Observations');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `quality_assurance_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Review Flag');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `regulatory_examination_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Flag');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `report_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Number');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Status');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'in_progress|under_review|issued|archived');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Type');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'draft|final|management_letter|advisory_memo|regulatory_response|follow_up');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scope Flag');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Level');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Title');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Version Number');
ALTER TABLE `banking_ecm`.`audit`.`audit_report` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `banking_ecm`.`audit`.`resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`resource` SET TAGS ('dbx_subdomain' = 'resource_allocation');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Resource ID');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Current Audit Engagement ID');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `resource_reporting_line_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Line Manager ID');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `resource_reporting_line_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `resource_reporting_line_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `supervisor_resource_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `audit_grade` SET TAGS ('dbx_business_glossary_term' = 'Audit Grade Level');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `audit_grade` SET TAGS ('dbx_value_regex' = 'junior|intermediate|senior|manager|director|executive');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Full Name');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `auditor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|assigned|partially_available|on_leave|training|administrative');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `available_capacity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Percentage');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `cfe_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Certified Fraud Examiner (CFE) Certification Flag');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `cia_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Certified Internal Auditor (CIA) Certification Flag');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `cisa_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Certified Information Systems Auditor (CISA) Certification Flag');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `continuous_professional_education_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuous Professional Education (CPE) Hours');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `cpa_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Certified Public Accountant (CPA) Certification Flag');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `current_engagement_role` SET TAGS ('dbx_business_glossary_term' = 'Current Engagement Role');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `current_engagement_role` SET TAGS ('dbx_value_regex' = 'lead_auditor|co_lead|team_member|subject_matter_expert|quality_reviewer|observer');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `frm_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Financial Risk Manager (FRM) Certification Flag');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `home_office_location` SET TAGS ('dbx_business_glossary_term' = 'Home Office Location');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `independence_attestation_date` SET TAGS ('dbx_business_glossary_term' = 'Independence Attestation Date');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `language_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Language Capabilities');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Resource Notes');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `other_certifications` SET TAGS ('dbx_business_glossary_term' = 'Other Professional Certifications');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `performance_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `primary_expertise_area` SET TAGS ('dbx_business_glossary_term' = 'Primary Expertise Area');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `resource_status` SET TAGS ('dbx_business_glossary_term' = 'Resource Status');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `resource_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|terminated|retired|seconded');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `secondary_expertise_areas` SET TAGS ('dbx_business_glossary_term' = 'Secondary Expertise Areas');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'standard|elevated|executive|board');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Level');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_value_regex' = 'second_line|third_line');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `years_at_institution` SET TAGS ('dbx_business_glossary_term' = 'Years at Institution');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Audit Experience');
ALTER TABLE `banking_ecm`.`audit`.`resource` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `engagement_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Assignment Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `primary_engagement_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `primary_engagement_employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `primary_engagement_employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `previous_engagement_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Logged');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `assignment_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approved By');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `assignment_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approved Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `assignment_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Assignment Change Reason');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|suspended|cancelled');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|advisory|quality_assurance|training');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Full Name');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `auditor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `certification_held` SET TAGS ('dbx_business_glossary_term' = 'Certification Held');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `charge_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Code');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `competency_requirement` SET TAGS ('dbx_business_glossary_term' = 'Competency Requirement');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `conflict_of_interest_notes` SET TAGS ('dbx_business_glossary_term' = 'Conflict of Interest Notes');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `conflict_of_interest_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `engagement_role` SET TAGS ('dbx_business_glossary_term' = 'Engagement Role');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `engagement_role` SET TAGS ('dbx_value_regex' = 'lead_auditor|in_charge|staff_auditor|subject_matter_expert|it_auditor|quality_reviewer');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `independence_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Independence Confirmation Date');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `independence_confirmation_flag` SET TAGS ('dbx_business_glossary_term' = 'Independence Confirmation Flag');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `performance_notes` SET TAGS ('dbx_business_glossary_term' = 'Performance Notes');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `performance_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `performance_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `remote_work_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Flag');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `training_hours_earned` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Earned');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `travel_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Travel Required Flag');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `workpaper_access_level` SET TAGS ('dbx_business_glossary_term' = 'Workpaper Access Level');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `workpaper_access_level` SET TAGS ('dbx_value_regex' = 'full|read_only|restricted|no_access');
ALTER TABLE `banking_ecm`.`audit`.`engagement_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `continuous_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Continuous Monitoring ID');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `benchmark_id` SET TAGS ('dbx_business_glossary_term' = 'Benchmark Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `deposit_account_id` SET TAGS ('dbx_business_glossary_term' = 'Monitored Limit Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Monitored Control Identifier');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Monitored Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `previous_continuous_monitoring_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `aml_bsa_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) / Bank Secrecy Act (BSA) Scope Flag');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `audit_committee_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reporting Flag');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'Fully Automated|Semi-Automated|Manual');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `ccar_dfast_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review (CCAR) / Dodd-Frank Act Stress Testing (DFAST) Scope Flag');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `control_framework` SET TAGS ('dbx_business_glossary_term' = 'Control Framework');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `data_source_table` SET TAGS ('dbx_business_glossary_term' = 'Data Source Table or Object');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `escalation_rule` SET TAGS ('dbx_business_glossary_term' = 'Escalation Rule');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `escalation_threshold` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `exception_count_last_run` SET TAGS ('dbx_business_glossary_term' = 'Exception Count from Last Run');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `exception_criteria` SET TAGS ('dbx_business_glossary_term' = 'Exception Criteria');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `exception_severity` SET TAGS ('dbx_business_glossary_term' = 'Exception Severity Level');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `exception_severity` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low|Informational');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `last_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Date');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `last_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Execution Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `monitored_control_name` SET TAGS ('dbx_business_glossary_term' = 'Monitored Control Name');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'Real-Time|Hourly|Daily|Weekly|Monthly|Quarterly');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `monitoring_tool` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Tool or Platform');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `next_scheduled_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Execution Date');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Program Code');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `program_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Date');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `program_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Program Name');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `program_notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `program_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Email Address');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `program_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `program_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `program_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `program_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Name');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Program Status');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Under Review|Retired');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low|Minimal');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Scope Flag');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Level');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_value_regex' = 'First Line|Second Line|Third Line');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_business_glossary_term' = 'Threshold Operator');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `threshold_operator` SET TAGS ('dbx_value_regex' = 'Greater Than|Less Than|Equal To|Not Equal To|Between|Outside Range');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `threshold_type` SET TAGS ('dbx_business_glossary_term' = 'Threshold Type');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `threshold_type` SET TAGS ('dbx_value_regex' = 'Absolute|Percentage|Rate|Count|Variance');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `banking_ecm`.`audit`.`continuous_monitoring` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` SET TAGS ('dbx_subdomain' = 'execution_management');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `monitoring_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Exception ID');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `account_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Flagged Transaction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `capture_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Capture Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `continuous_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Program ID');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator ID');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Escalated Finding ID');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `execution_id` SET TAGS ('dbx_business_glossary_term' = 'Execution Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Flagged Journal Entry Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `market_risk_position_id` SET TAGS ('dbx_business_glossary_term' = 'Market Risk Position Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `monitoring_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Rule ID');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `price_id` SET TAGS ('dbx_business_glossary_term' = 'Price Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `previous_monitoring_exception_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `actual_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Value');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `assigned_investigator_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Investigator Name');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `audit_committee_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reported Flag');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `data_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Data Record Reference');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `data_record_type` SET TAGS ('dbx_business_glossary_term' = 'Data Record Type');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Exception Disposition');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'escalated_to_finding|false_positive|management_accepted_risk|remediated|pending_review');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `disposition_rationale` SET TAGS ('dbx_business_glossary_term' = 'Disposition Rationale');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `exception_category` SET TAGS ('dbx_business_glossary_term' = 'Exception Category');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `exception_category` SET TAGS ('dbx_value_regex' = 'operational|financial|compliance|security|data_integrity|fraud_indicator');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `exception_date` SET TAGS ('dbx_business_glossary_term' = 'Exception Date');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `exception_severity` SET TAGS ('dbx_business_glossary_term' = 'Exception Severity');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `exception_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|escalated_to_finding|closed_false_positive|closed_accepted_risk|closed_remediated');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `exception_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_value_regex' = 'control_failure|policy_violation|threshold_breach|data_quality_issue|segregation_of_duties_conflict|unauthorized_access');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `regulatory_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Impact Flag');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `source_system_name` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `three_lines_position` SET TAGS ('dbx_business_glossary_term' = 'Three Lines Position');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `three_lines_position` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `banking_ecm`.`audit`.`monitoring_exception` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `regulatory_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Audit Identifier');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `fund_regulatory_report_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Regulatory Report Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Taxonomy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `stress_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Scenario Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `universe_id` SET TAGS ('dbx_business_glossary_term' = 'Auditable Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `previous_regulatory_audit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `asset_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Quality Rating');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `asset_quality_rating` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `asset_quality_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `audit_committee_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Report Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `audit_committee_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reported Flag');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `capital_adequacy_rating` SET TAGS ('dbx_business_glossary_term' = 'Capital Adequacy Rating');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `capital_adequacy_rating` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `capital_adequacy_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `composite_rating` SET TAGS ('dbx_business_glossary_term' = 'Composite Rating');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `composite_rating` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `composite_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `earnings_rating` SET TAGS ('dbx_business_glossary_term' = 'Earnings Rating');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `earnings_rating` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `earnings_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `examination_end_date` SET TAGS ('dbx_business_glossary_term' = 'Examination End Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `examination_notes` SET TAGS ('dbx_business_glossary_term' = 'Examination Notes');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `examination_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `examination_number` SET TAGS ('dbx_business_glossary_term' = 'Examination Number');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `examination_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Examination Period End Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `examination_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Examination Period Start Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `examination_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Examination Scope Description');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `examination_start_date` SET TAGS ('dbx_business_glossary_term' = 'Examination Start Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `examination_status` SET TAGS ('dbx_business_glossary_term' = 'Examination Status');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `examination_type` SET TAGS ('dbx_business_glossary_term' = 'Examination Type');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `examination_type` SET TAGS ('dbx_value_regex' = 'safety and soundness|BSA/AML|consumer compliance|capital adequacy|IT examination|operational risk');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `final_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Final Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `final_report_received_date` SET TAGS ('dbx_business_glossary_term' = 'Final Report Received Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `internal_audit_liaison_email` SET TAGS ('dbx_business_glossary_term' = 'Internal Audit Liaison Email Address');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `internal_audit_liaison_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `internal_audit_liaison_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `internal_audit_liaison_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `internal_audit_liaison_name` SET TAGS ('dbx_business_glossary_term' = 'Internal Audit Liaison Name');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `lead_examiner_email` SET TAGS ('dbx_business_glossary_term' = 'Lead Examiner Email Address');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `lead_examiner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `lead_examiner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `lead_examiner_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Examiner Name');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `lead_examiner_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `lead_examiner_phone` SET TAGS ('dbx_business_glossary_term' = 'Lead Examiner Phone Number');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `lead_examiner_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `liquidity_rating` SET TAGS ('dbx_business_glossary_term' = 'Liquidity Rating');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `liquidity_rating` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `liquidity_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `management_rating` SET TAGS ('dbx_business_glossary_term' = 'Management Rating');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `management_rating` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `management_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `matter_requiring_attention_count` SET TAGS ('dbx_business_glossary_term' = 'Matter Requiring Attention (MRA) Count');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `matter_requiring_immediate_attention_count` SET TAGS ('dbx_business_glossary_term' = 'Matter Requiring Immediate Attention (MRIA) Count');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `preliminary_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Preliminary Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `regulator_name` SET TAGS ('dbx_business_glossary_term' = 'Regulator Name');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `scope_areas` SET TAGS ('dbx_business_glossary_term' = 'Scope Areas');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `sensitivity_to_market_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Sensitivity to Market Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `sensitivity_to_market_risk_rating` SET TAGS ('dbx_value_regex' = '1|2|3|4|5');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `sensitivity_to_market_risk_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_audit` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `regulatory_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Finding Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Cited Party Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `regulatory_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Audit Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `regulatory_exam_id` SET TAGS ('dbx_business_glossary_term' = 'Examination Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `regulatory_taxonomy_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Taxonomy Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `stress_test_run_id` SET TAGS ('dbx_business_glossary_term' = 'Stress Test Run Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `superseded_regulatory_finding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `board_escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Escalation Flag');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `board_reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Board Reporting Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `business_line` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Closure Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Closure Status');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'Open|Closed|Pending Validation|Reopened');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `enforcement_action_reference` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Reference');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Currency');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `financial_impact_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `finding_title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'MRA|MRIA|Violation|Informal Action|Recommendation|Observation');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Issue Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Finding Notes');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `prior_finding_reference` SET TAGS ('dbx_business_glossary_term' = 'Prior Finding Reference');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `regulator_closure_confirmation_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulator Closure Confirmation Flag');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `regulator_name` SET TAGS ('dbx_business_glossary_term' = 'Regulator Name');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `regulator_office` SET TAGS ('dbx_business_glossary_term' = 'Regulator Office or District');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `remediation_commitment` SET TAGS ('dbx_business_glossary_term' = 'Remediation Commitment');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `remediation_owner` SET TAGS ('dbx_business_glossary_term' = 'Remediation Owner');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Completed|Validated|Overdue');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Response Due Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Submitted|Accepted|Rejected|Resubmitted');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Bank Response Submitted Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'Critical|High|Moderate|Low');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Level');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_value_regex' = 'First Line|Second Line|Third Line');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Validation Date');
ALTER TABLE `banking_ecm`.`audit`.`regulatory_finding` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `committee_report_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Report ID');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Report Approved By ID');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `committee_prepared_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Report Prepared By ID');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `committee_prepared_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `committee_prepared_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `primary_committee_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Chair ID');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `primary_committee_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `primary_committee_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `previous_committee_report_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `aml_bsa_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) and Bank Secrecy Act (BSA) Audit Status');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `aml_bsa_audit_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|not_applicable');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `budgeted_hours` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Hours');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `cae_independence_attestation` SET TAGS ('dbx_business_glossary_term' = 'Chief Audit Executive (CAE) Independence Attestation');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `ccar_dfast_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review (CCAR) and Dodd-Frank Act Stress Testing (DFAST) Audit Status');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `ccar_dfast_audit_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|not_applicable');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `committee_feedback` SET TAGS ('dbx_business_glossary_term' = 'Committee Feedback');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `committee_feedback` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `committee_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Committee Meeting Date');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `continuous_monitoring_summary` SET TAGS ('dbx_business_glossary_term' = 'Continuous Monitoring Summary');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `external_auditor_coordination` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Coordination');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `high_risk_findings_count` SET TAGS ('dbx_business_glossary_term' = 'High Risk Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `key_risk_indicators_summary` SET TAGS ('dbx_business_glossary_term' = 'Key Risk Indicators (KRI) Summary');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `low_risk_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Low Risk Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `medium_risk_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Medium Risk Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `next_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Report Due Date');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `open_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Open Findings Count');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `overdue_actions_count` SET TAGS ('dbx_business_glossary_term' = 'Overdue Actions Count');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `plan_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Plan Completion Percentage');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `quality_assurance_results` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Results');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `regulatory_examination_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Status');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `regulatory_examination_status` SET TAGS ('dbx_value_regex' = 'no_active_exams|in_progress|completed|pending_response');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `regulatory_examination_summary` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Summary');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `regulatory_examination_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `report_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Report Approval Date');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Report Document Reference');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `report_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Report Period End Date');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `report_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Report Period Start Date');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `report_presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Report Presentation Date');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|presented|approved|archived');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `report_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'quarterly_update|annual_plan_approval|cae_assessment|special_review|regulatory_coordination|quality_assurance');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `significant_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Significant Findings Summary');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `significant_findings_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `sox_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Compliance Status');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `sox_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|remediation_in_progress|not_applicable');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `three_lines_model_assessment` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Model Assessment');
ALTER TABLE `banking_ecm`.`audit`.`committee_report` ALTER COLUMN `variance_hours` SET TAGS ('dbx_business_glossary_term' = 'Variance Hours');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'planning_operations');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Risk Assessment Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `universe_id` SET TAGS ('dbx_business_glossary_term' = 'Auditable Entity Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `previous_risk_assessment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `aml_bsa_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) / Bank Secrecy Act (BSA) Scope Flag');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `assessment_cycle` SET TAGS ('dbx_business_glossary_term' = 'Assessment Cycle');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `assessment_cycle` SET TAGS ('dbx_value_regex' = 'annual|semi-annual|quarterly|event-driven|ad-hoc|continuous');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Assessment Methodology');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_value_regex' = 'quantitative|qualitative|hybrid|scenario-based|heat-map');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `assessment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period End Date');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `assessment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Period Start Date');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in-review|approved|superseded|archived');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `audit_committee_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reporting Flag');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `ccar_dfast_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review (CCAR) / Dodd-Frank Act Stress Testing (DFAST) Scope Flag');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `cecl_ifrs9_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Current Expected Credit Losses (CECL) / International Financial Reporting Standard 9 (IFRS 9) Scope Flag');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `change_activity_score` SET TAGS ('dbx_business_glossary_term' = 'Change Activity Score');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `complexity_factor_score` SET TAGS ('dbx_business_glossary_term' = 'Complexity Factor Score');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `continuous_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuous Monitoring Flag');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `control_environment_rating` SET TAGS ('dbx_business_glossary_term' = 'Control Environment Rating');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `control_environment_rating` SET TAGS ('dbx_value_regex' = 'strong|adequate|needs-improvement|weak|not-assessed');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `external_audit_coordination_flag` SET TAGS ('dbx_business_glossary_term' = 'External Audit Coordination Flag');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `financial_materiality_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Materiality Score');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `inherent_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Score');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `key_risk_indicators` SET TAGS ('dbx_business_glossary_term' = 'Key Risk Indicators (KRI)');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `prior_findings_score` SET TAGS ('dbx_business_glossary_term' = 'Prior Findings Score');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `recommended_audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recommended Audit Frequency');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `recommended_audit_frequency` SET TAGS ('dbx_value_regex' = 'quarterly|semi-annual|annual|biennial|triennial|as-needed');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `recommended_audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Recommended Audit Scope');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `recommended_audit_scope` SET TAGS ('dbx_value_regex' = 'comprehensive|targeted|limited|continuous-monitoring|advisory');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `regulatory_examination_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Flag');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `regulatory_exposure_score` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Exposure Score');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `residual_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Score');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `risk_appetite_alignment` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Alignment');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `risk_appetite_alignment` SET TAGS ('dbx_value_regex' = 'within-appetite|near-limit|exceeds-appetite|not-applicable');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `risk_ranking` SET TAGS ('dbx_business_glossary_term' = 'Risk Ranking');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|minimal');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `risk_trend` SET TAGS ('dbx_business_glossary_term' = 'Risk Trend');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `risk_trend` SET TAGS ('dbx_value_regex' = 'increasing|stable|decreasing|new-risk|emerging');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Scope Flag');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Level');
ALTER TABLE `banking_ecm`.`audit`.`risk_assessment` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_value_regex' = 'first-line|second-line|third-line|combined-assurance');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` SET TAGS ('dbx_subdomain' = 'planning_operations');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `three_lines_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Three Lines Assignment Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `appetite_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Appetite Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `compliance_sox_control_id` SET TAGS ('dbx_business_glossary_term' = 'Control Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `universe_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Universe Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `related_three_lines_assignment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `accountability_clarity_score` SET TAGS ('dbx_business_glossary_term' = 'Accountability Clarity Score');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `aml_bsa_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Anti-Money Laundering (AML) / Bank Secrecy Act (BSA) Scope Flag');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `assigned_line_of_defense` SET TAGS ('dbx_business_glossary_term' = 'Assigned Line of Defense');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `assigned_line_of_defense` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Code');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `assignment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `assignment_rationale` SET TAGS ('dbx_business_glossary_term' = 'Assignment Rationale');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|pending_approval|superseded');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `audit_committee_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reporting Flag');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `audit_coverage_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Audit Coverage Responsibility');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `audit_lead_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Lead Name');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `ccar_dfast_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Comprehensive Capital Analysis and Review (CCAR) / Dodd-Frank Act Stress Testing (DFAST) Scope Flag');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `control_activity` SET TAGS ('dbx_business_glossary_term' = 'Control Activity');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `control_framework` SET TAGS ('dbx_business_glossary_term' = 'Control Framework');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `control_owner_email` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Email Address');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `control_owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `control_owner_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `control_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Name');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `control_owner_title` SET TAGS ('dbx_business_glossary_term' = 'Control Owner Title');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `escalation_protocol` SET TAGS ('dbx_business_glossary_term' = 'Escalation Protocol');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `gap_flag` SET TAGS ('dbx_business_glossary_term' = 'Gap Flag');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `overlap_flag` SET TAGS ('dbx_business_glossary_term' = 'Overlap Flag');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `oversight_function` SET TAGS ('dbx_business_glossary_term' = 'Oversight Function');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `oversight_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Oversight Owner Name');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency in Months');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'credit_risk|market_risk|operational_risk|liquidity_risk|compliance_risk|strategic_risk');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `risk_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `sox_scope_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley Act (SOX) Scope Flag');
ALTER TABLE `banking_ecm`.`audit`.`three_lines_assignment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `quality_assurance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Review ID');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `prior_review_quality_assurance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Quality Assurance Review ID');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `previous_quality_assurance_review_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Improvement Action Plan Due Date');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Quality Assessment Methodology');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `audit_committee_approval_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Approval Flag');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `audit_committee_presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Presentation Date');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `cae_response` SET TAGS ('dbx_business_glossary_term' = 'CAE (Chief Audit Executive) Response');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `cae_response_date` SET TAGS ('dbx_business_glossary_term' = 'CAE (Chief Audit Executive) Response Date');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `conformance_rating` SET TAGS ('dbx_business_glossary_term' = 'Conformance Rating');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `conformance_rating` SET TAGS ('dbx_value_regex' = 'generally_conforms|partially_conforms|does_not_conform');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `external_assessment_frequency_years` SET TAGS ('dbx_business_glossary_term' = 'External Assessment Frequency Years');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `follow_up_review_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Review Date');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `follow_up_review_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Review Required Flag');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `high_priority_recommendations_count` SET TAGS ('dbx_business_glossary_term' = 'High Priority Quality Assurance Recommendations Count');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `iia_standards_scope` SET TAGS ('dbx_business_glossary_term' = 'IIA (Institute of Internal Auditors) Standards Scope');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `improvement_opportunities` SET TAGS ('dbx_business_glossary_term' = 'Quality Improvement Opportunities');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `key_observations` SET TAGS ('dbx_business_glossary_term' = 'Key Quality Assurance Observations');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `lead_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Reviewer Name');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `recommendations_count` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Recommendations Count');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `report_distribution_list` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Report Distribution List');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Report Document Reference');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Review Completion Date');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Review Notes');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Review Number');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `review_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Review Start Date');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Review Status');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|fieldwork_complete|draft_report|final_report|closed');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Review Type');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'internal_self_assessment|external_assessment|regulatory_peer_review|ongoing_monitoring|periodic_internal_review');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `reviewer_organization_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Organization Name');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `reviewer_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Qualifications');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `reviewer_type` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Type');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `reviewer_type` SET TAGS ('dbx_value_regex' = 'internal_qa_team|external_assessor|regulatory_examiner|peer_reviewer');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Review Sample Size');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `strengths_identified` SET TAGS ('dbx_business_glossary_term' = 'Audit Function Strengths Identified');
ALTER TABLE `banking_ecm`.`audit`.`quality_assurance_review` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `issue_tracker_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Issue Tracker ID');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement ID');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `finding_id` SET TAGS ('dbx_business_glossary_term' = 'Finding ID');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `loan_account_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Account Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `operational_risk_event_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Risk Event Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issue Owner ID');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `prior_issue_issue_tracker_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Issue ID');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Cost Center Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `tertiary_issue_validated_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validated By ID');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `tertiary_issue_validated_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `tertiary_issue_validated_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `related_issue_tracker_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = '0_30_days|31_60_days|61_90_days|91_180_days|over_180_days');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `audit_committee_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Report Date');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `audit_committee_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reported Flag');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `control_framework` SET TAGS ('dbx_business_glossary_term' = 'Control Framework');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `current_due_date` SET TAGS ('dbx_business_glossary_term' = 'Current Due Date');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `escalation_status` SET TAGS ('dbx_business_glossary_term' = 'Escalation Status');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `escalation_status` SET TAGS ('dbx_value_regex' = 'none|management|executive|audit_committee|board');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `extension_count` SET TAGS ('dbx_business_glossary_term' = 'Extension Count');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `external_auditor_coordination_flag` SET TAGS ('dbx_business_glossary_term' = 'External Auditor Coordination Flag');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `identification_date` SET TAGS ('dbx_business_glossary_term' = 'Identification Date');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `issue_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Issue Reference Number');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `issue_source_type` SET TAGS ('dbx_business_glossary_term' = 'Issue Source Type');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `issue_source_type` SET TAGS ('dbx_value_regex' = 'internal_audit|regulatory_exam|external_audit|self_identified|management_review|continuous_monitoring');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `issue_status` SET TAGS ('dbx_business_glossary_term' = 'Issue Status');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `issue_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|pending_validation|closed|overdue');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `issue_title` SET TAGS ('dbx_business_glossary_term' = 'Issue Title');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `management_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Management Action Plan');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `material_weakness_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Weakness Flag');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `original_due_date` SET TAGS ('dbx_business_glossary_term' = 'Original Due Date');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `regulatory_exam_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Reference');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `remediation_approach` SET TAGS ('dbx_business_glossary_term' = 'Remediation Approach');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `remediation_approach` SET TAGS ('dbx_value_regex' = 'process_redesign|control_enhancement|system_implementation|policy_update|training|resource_addition');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `remediation_progress_percentage` SET TAGS ('dbx_business_glossary_term' = 'Remediation Progress Percentage');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `significant_deficiency_flag` SET TAGS ('dbx_business_glossary_term' = 'Significant Deficiency Flag');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `sox_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Relevant Flag');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `three_lines_position` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Position');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `three_lines_position` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|passed|failed|deferred');
ALTER TABLE `banking_ecm`.`audit`.`issue_tracker` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `cae_charter_id` SET TAGS ('dbx_business_glossary_term' = 'Chief Audit Executive (CAE) Charter ID');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `superseded_charter_cae_charter_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Charter ID');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `previous_cae_charter_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `administrative_reporting_line` SET TAGS ('dbx_business_glossary_term' = 'Administrative Reporting Line');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `annual_review_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Annual Charter Review Requirement Flag');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Charter Approval Date');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `approving_body` SET TAGS ('dbx_business_glossary_term' = 'Charter Approving Body');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `assurance_services_scope` SET TAGS ('dbx_business_glossary_term' = 'Assurance Services Scope');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `audit_committee_chair_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Chair Name');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `audit_committee_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reporting Frequency');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `audit_universe_coverage` SET TAGS ('dbx_business_glossary_term' = 'Audit Universe Coverage');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `board_approval_resolution_number` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Resolution Number');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `budget_authority` SET TAGS ('dbx_business_glossary_term' = 'Budget Authority and Resource Control');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `charter_number` SET TAGS ('dbx_business_glossary_term' = 'Charter Document Number');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `charter_status` SET TAGS ('dbx_business_glossary_term' = 'Charter Lifecycle Status');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `charter_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|active|superseded|archived');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `charter_title` SET TAGS ('dbx_business_glossary_term' = 'Charter Document Title');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `charter_version` SET TAGS ('dbx_business_glossary_term' = 'Charter Version Number');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `consulting_services_scope` SET TAGS ('dbx_business_glossary_term' = 'Consulting Services Scope');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Charter Document Storage Location');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `document_storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Charter Effective Date');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Charter Expiration Date');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `external_assessment_frequency_years` SET TAGS ('dbx_business_glossary_term' = 'External Assessment Frequency in Years');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `fraud_investigation_authority` SET TAGS ('dbx_business_glossary_term' = 'Fraud Investigation Authority');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `functional_reporting_line` SET TAGS ('dbx_business_glossary_term' = 'Functional Reporting Line');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `independence_provisions` SET TAGS ('dbx_business_glossary_term' = 'Independence and Objectivity Provisions');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Charter Review Date');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Charter Review Date');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `private_session_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Session Requirement Flag');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `purpose_statement` SET TAGS ('dbx_business_glossary_term' = 'Internal Audit Purpose Statement');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `quality_assurance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance and Improvement Program (QAIP) Requirement');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `regulatory_coordination_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Coordination Authority');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `regulatory_filing_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Requirement Flag');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `revision_history` SET TAGS ('dbx_business_glossary_term' = 'Charter Revision History');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `risk_assessment_methodology` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Methodology');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `scope_of_authority` SET TAGS ('dbx_business_glossary_term' = 'Scope of Internal Audit Authority');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `staffing_authority` SET TAGS ('dbx_business_glossary_term' = 'Staffing and Hiring Authority');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `standards_conformance_requirement` SET TAGS ('dbx_business_glossary_term' = 'Professional Standards Conformance Requirement');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `three_lines_model_position` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Model Position');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `three_lines_model_position` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `unrestricted_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Unrestricted Access Rights Flag');
ALTER TABLE `banking_ecm`.`audit`.`cae_charter` ALTER COLUMN `whistleblower_coordination_flag` SET TAGS ('dbx_business_glossary_term' = 'Whistleblower Program Coordination Flag');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` SET TAGS ('dbx_subdomain' = 'planning_operations');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `audit_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Budget ID');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Chief Audit Executive (CAE) ID');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Plan ID');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `previous_audit_budget_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `advisory_hours_actual` SET TAGS ('dbx_business_glossary_term' = 'Advisory Hours Actual');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `advisory_hours_planned` SET TAGS ('dbx_business_glossary_term' = 'Advisory Hours Planned');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditionally_approved');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `assurance_hours_actual` SET TAGS ('dbx_business_glossary_term' = 'Assurance Hours Actual');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `assurance_hours_planned` SET TAGS ('dbx_business_glossary_term' = 'Assurance Hours Planned');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `audit_committee_presentation_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Presentation Date');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|closed|revised');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `co_sourcing_actual` SET TAGS ('dbx_business_glossary_term' = 'Co-Sourcing Actual Expenditure');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `co_sourcing_actual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `co_sourcing_budget` SET TAGS ('dbx_business_glossary_term' = 'Co-Sourcing Budget');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `co_sourcing_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `co_sourcing_hours_actual` SET TAGS ('dbx_business_glossary_term' = 'Co-Sourcing Hours Actual');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `co_sourcing_hours_planned` SET TAGS ('dbx_business_glossary_term' = 'Co-Sourcing Hours Planned');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `contingency_hours_actual` SET TAGS ('dbx_business_glossary_term' = 'Contingency Hours Actual');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `contingency_hours_planned` SET TAGS ('dbx_business_glossary_term' = 'Contingency Hours Planned');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `cost_per_audit_day` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Audit Day');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `cost_per_audit_day` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Budget Cycle Type');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `cycle_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|engagement_specific');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `resource_adequacy_assessment` SET TAGS ('dbx_business_glossary_term' = 'Resource Adequacy Assessment');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `resource_adequacy_assessment` SET TAGS ('dbx_value_regex' = 'adequate|constrained|insufficient|over_resourced');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `technology_actual` SET TAGS ('dbx_business_glossary_term' = 'Technology Actual Expenditure');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `technology_actual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `technology_budget` SET TAGS ('dbx_business_glossary_term' = 'Technology Budget');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `technology_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `total_actual_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Expenditure');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `total_actual_expenditure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `total_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Hours');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Budget Amount');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `total_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `total_planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Hours');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `training_actual` SET TAGS ('dbx_business_glossary_term' = 'Training Actual Expenditure');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `training_actual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `training_budget` SET TAGS ('dbx_business_glossary_term' = 'Training Budget');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `training_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `travel_expense_actual` SET TAGS ('dbx_business_glossary_term' = 'Travel and Expense Actual');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `travel_expense_actual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `travel_expense_budget` SET TAGS ('dbx_business_glossary_term' = 'Travel and Expense Budget');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `travel_expense_budget` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `variance_hours` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Hours');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `banking_ecm`.`audit`.`audit_budget` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `cosourcing_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Co-sourcing Arrangement Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Engagement Id (Foreign Key)');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervising Staff Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `lead_cosourcing_arrangement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Co-sourcing Arrangement Number');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Status');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `audit_committee_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Report Date');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `audit_committee_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reported Flag');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `billing_method` SET TAGS ('dbx_business_glossary_term' = 'Billing Method');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `billing_method` SET TAGS ('dbx_value_regex' = 'fixed_fee|time_and_materials|milestone_based|retainer|capped_hourly');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,25}$');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `cosourcing_type` SET TAGS ('dbx_business_glossary_term' = 'Co-sourcing Type');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `engagement_scope` SET TAGS ('dbx_business_glossary_term' = 'Engagement Scope Description');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `independence_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Independence Confirmation Date');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `independence_confirmation_flag` SET TAGS ('dbx_business_glossary_term' = 'Independence Confirmation Flag');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By User');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `modified_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Notes');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `performance_evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Evaluation Date');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `quality_oversight_procedures` SET TAGS ('dbx_business_glossary_term' = 'Quality Oversight Procedures');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Driver');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `service_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Name');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `service_provider_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `service_provider_type` SET TAGS ('dbx_business_glossary_term' = 'Service Provider Type');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `service_provider_type` SET TAGS ('dbx_value_regex' = 'big_four|regional_firm|boutique_specialist|independent_consultant|technology_auditor|regulatory_specialist');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Level');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `vendor_due_diligence_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Due Diligence Date');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `banking_ecm`.`audit`.`cosourcing_arrangement` ALTER COLUMN `created_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`notification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `banking_ecm`.`audit`.`notification` SET TAGS ('dbx_subdomain' = 'resource_allocation');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `notification_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Notification Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Engagement Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recipient Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `notification_sender_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sender Employee Identifier (ID)');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `notification_sender_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `notification_sender_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `previous_audit_notification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `acknowledgement_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Received Flag');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `acknowledgement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Required Flag');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `audit_committee_report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Report Date');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `audit_committee_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Committee Reported Flag');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `body` SET TAGS ('dbx_business_glossary_term' = 'Notification Body Content');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `business_unit_notified` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Notified');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `cc_recipients` SET TAGS ('dbx_business_glossary_term' = 'Carbon Copy (CC) Recipients');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Communication Channel');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `communication_channel` SET TAGS ('dbx_value_regex' = 'email|postal_mail|secure_portal|hand_delivery|registered_mail|electronic_signature_platform');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `days_to_respond` SET TAGS ('dbx_business_glossary_term' = 'Days to Respond');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `delivery_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Date');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `delivery_confirmation_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Flag');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `lob` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notification Notes');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Issuance Date');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `notification_number` SET TAGS ('dbx_business_glossary_term' = 'Notification Reference Number');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Notification Status');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Issuance Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_business_glossary_term' = 'Notification Type');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `notification_type` SET TAGS ('dbx_value_regex' = 'engagement_announcement|information_request_list|draft_report|management_response_request|final_report|follow_up_notice');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdue Response Flag');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `recipient_email` SET TAGS ('dbx_business_glossary_term' = 'Recipient Email Address');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `recipient_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `recipient_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `recipient_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Recipient Name');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `recipient_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `recipient_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `recipient_title` SET TAGS ('dbx_business_glossary_term' = 'Recipient Job Title');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `regulatory_examination_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Examination Flag');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `response_received_date` SET TAGS ('dbx_business_glossary_term' = 'Response Received Date');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `response_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Received Timestamp');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `sender_email` SET TAGS ('dbx_business_glossary_term' = 'Sender Email Address');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `sender_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `sender_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `sender_name` SET TAGS ('dbx_business_glossary_term' = 'Sender Name');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `sender_title` SET TAGS ('dbx_business_glossary_term' = 'Sender Job Title');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `subject_line` SET TAGS ('dbx_business_glossary_term' = 'Notification Subject Line');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_business_glossary_term' = 'Three Lines of Defense Level');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `three_lines_of_defense_level` SET TAGS ('dbx_value_regex' = 'first_line|second_line|third_line');
ALTER TABLE `banking_ecm`.`audit`.`notification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `banking_ecm`.`audit`.`program_step` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`program_step` SET TAGS ('dbx_subdomain' = 'planning_operations');
ALTER TABLE `banking_ecm`.`audit`.`program_step` ALTER COLUMN `program_step_id` SET TAGS ('dbx_business_glossary_term' = 'Program Step Identifier');
ALTER TABLE `banking_ecm`.`audit`.`program_step` ALTER COLUMN `previous_program_step_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `banking_ecm`.`audit`.`business_process` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `banking_ecm`.`audit`.`business_process` SET TAGS ('dbx_subdomain' = 'planning_operations');
ALTER TABLE `banking_ecm`.`audit`.`business_process` ALTER COLUMN `business_process_id` SET TAGS ('dbx_business_glossary_term' = 'Business Process Identifier');
ALTER TABLE `banking_ecm`.`audit`.`business_process` ALTER COLUMN `parent_business_process_id` SET TAGS ('dbx_self_ref_fk' = 'true');
