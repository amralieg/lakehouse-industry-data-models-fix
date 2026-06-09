-- Schema for Domain: compliance | Business: Construction | Version: v1_mvm
-- Generated on: 2026-05-07 09:27:04

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `construction_ecm`.`compliance` COMMENT 'Regulatory compliance domain owning permit registers, environmental impact assessments, LEED certification tracking, building permit records, and regulatory reporting submissions to OSHA, EPA, and local authorities. Manages GDPR/privacy obligations for workforce and client data and PCI DSS controls for financial transactions. Distinct from safety (which owns incident data) and quality (which owns NCRs).';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `construction_ecm`.`compliance`.`permit` (
    `permit_id` BIGINT COMMENT 'Unique identifier for the permit.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Permit issuance requires linking each permit to the client company that holds it for reporting and compliance tracking.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project associated with the permit.',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: A construction permit is frequently issued based on or conditional upon an approved Environmental Impact Assessment. Linking compliance_permit to env_impact_assessment formalizes this dependency, enab',
    `regulatory_authority_id` BIGINT COMMENT 'FK to compliance.regulatory_authority',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Required for Permit Management to record which vendor holds the permit, enabling compliance tracking of contractor responsibilities.',
    `compliance_evidence_url` STRING COMMENT 'Link to stored evidence satisfying permit conditions.',
    `compliance_permit_status` STRING COMMENT 'Current lifecycle status of the permit.. Valid values are `applied|under_review|approved|issued|expired|revoked`',
    `compliance_status` STRING COMMENT 'Aggregated compliance status of all permit conditions.. Valid values are `compliant|non_compliant|partial|pending`',
    `condition_count` STRING COMMENT 'Number of conditions attached to the permit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit record was first created.',
    `documents_attached_count` STRING COMMENT 'Number of supporting documents attached to the permit application.',
    `effective_from` DATE COMMENT 'Date from which the permit becomes effective (may differ from issue date).',
    `effective_until` DATE COMMENT 'Date until which the permit remains in effect (nullable for open-ended).',
    `expiry_date` DATE COMMENT 'Date the permit expires or must be renewed.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee associated with the permit.',
    `fee_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the fee.',
    `fee_paid_date` DATE COMMENT 'Date the permit fee was paid.',
    `fee_paid_flag` BOOLEAN COMMENT 'Indicates whether the permit fee has been paid.',
    `is_active` BOOLEAN COMMENT 'Indicates if the permit is currently active (not expired, revoked, or suspended).',
    `issue_date` DATE COMMENT 'Date the permit was officially issued.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the permit record.',
    `next_condition_due_date` DATE COMMENT 'Earliest due date among pending permit conditions.',
    `notes` STRING COMMENT 'Free-text field for internal comments or observations.',
    `permit_category` STRING COMMENT 'Category of the permit based on ownership or project type.. Valid values are `public|private|joint_venture|government`',
    `permit_number` STRING COMMENT 'Official permit number assigned by issuing authority.',
    `permit_type` STRING COMMENT 'Classifies the kind of permit.. Valid values are `building|excavation|environmental|utility|demolition|occupancy`',
    `renewal_date` DATE COMMENT 'Date by which renewal must be submitted.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the permit requires renewal.',
    `revocation_date` DATE COMMENT 'Date the permit was revoked, if applicable.',
    `risk_level` STRING COMMENT 'Risk assessment level associated with the permit.. Valid values are `low|medium|high|critical`',
    `submission_date` DATE COMMENT 'Date the permit application was submitted to the authority.',
    `suspension_flag` BOOLEAN COMMENT 'Indicates if the permit is currently suspended.',
    `suspension_reason` STRING COMMENT 'Reason for permit suspension.',
    CONSTRAINT pk_permit PRIMARY KEY(`permit_id`)
) COMMENT 'Master register of all construction permits across the full lifecycle from application through expiry, including building permits, excavation permits, environmental permits, utility connection permits, demolition permits, and occupancy permits. Tracks application submissions (applicant details, supporting documents, authority response, resubmissions, appeals), authority review and approval/rejection, issuance, individual conditions attached (each with due date, responsible party, fulfilment status, and compliance evidence), condition compliance monitoring, renewal, expiry, revocation, and suspension. Captures permit number, issuing authority, permit type, project association, submission date, issue date, expiry date, renewal requirements, and current status. Serves as the SSOT for permit identity, permit application history, and permit condition compliance across all project sites.';

CREATE OR REPLACE TABLE `construction_ecm`.`compliance`.`permit_application` (
    `permit_application_id` BIGINT COMMENT 'Unique identifier for the permit application record.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project associated with the permit.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Permit application fees and associated preparation costs are coded to specific cost codes in construction job costing. Finance teams require permit applications to reference cost codes for accurate co',
    `env_impact_assessment_id` BIGINT COMMENT 'Reference to the associated environmental impact assessment record.',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Permit applications are submitted with design packages as supporting documentation (e.g., a building permit application includes the structural design package). Linking permit_application to design pa',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Permit applications result in a compliance permit; linking them avoids data duplication. Overlapping columns are removed from permit_application.',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Permit application fees are budgeted line items in construction project budgets. Linking permit applications to project budgets enables budget vs. actual tracking of compliance costs, supports cost-to',
    `appeal_deadline` DATE COMMENT 'Last date on which an appeal against a decision can be filed.',
    `appeal_filed_timestamp` TIMESTAMP COMMENT 'Date and time when an appeal was submitted.',
    `application_number` STRING COMMENT 'External reference number assigned to the permit application by the submitting organization.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the authority approved the permit.',
    `compliance_requirements_met` BOOLEAN COMMENT 'Indicates whether the application satisfies all regulatory compliance requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit application record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the fee.',
    `decision` STRING COMMENT 'Final decision made by the authority on the application.. Valid values are `approved|rejected|withdrawn|pending`',
    `decision_reason` STRING COMMENT 'Reason or justification provided for the authoritys decision.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time when the approved permit expires.',
    `fee_adjustment` DECIMAL(18,2) COMMENT 'Additional adjustments to the base fee such as taxes, surcharges, or discounts.',
    `fee_total` DECIMAL(18,2) COMMENT 'Total amount payable after applying adjustments.',
    `is_resubmission` BOOLEAN COMMENT 'Flag indicating whether the application is a resubmission after a prior rejection or withdrawal.',
    `leeds_certification_level` STRING COMMENT 'LEED sustainability certification level applicable to the project.. Valid values are `certified|silver|gold|platinum`',
    `permit_application_description` STRING COMMENT 'Narrative description of the work or activity for which the permit is sought.',
    `permit_application_status` STRING COMMENT 'Current lifecycle state of the permit application.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `resubmission_reason` STRING COMMENT 'Explanation provided for why the application is being resubmitted.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the application was formally submitted to the authority.',
    `supporting_document_count` STRING COMMENT 'Number of supporting documents attached to the application.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the permit application record.',
    `validity_end_date` DATE COMMENT 'Last day the permit remains valid.',
    `validity_start_date` DATE COMMENT 'First day the permit becomes effective.',
    `work_scope` STRING COMMENT 'Brief description of the work scope covered by the permit.',
    CONSTRAINT pk_permit_application PRIMARY KEY(`permit_application_id`)
) COMMENT 'Transactional record of each permit application submitted to a regulatory or municipal authority, capturing application reference, submission date, applicant details, supporting documents submitted, application status, authority response, and approval or rejection outcome. Tracks the full lifecycle from initial submission through approval, including resubmissions and appeals.';

CREATE OR REPLACE TABLE `construction_ecm`.`compliance`.`permit_condition` (
    `permit_condition_id` BIGINT COMMENT 'Unique identifier for the permit condition record.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: Managing permit conditions assigns a specific client contact as the responsible party, needed for condition monitoring and notifications.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Each permit condition belongs to a specific permit; adding permit_id creates the required parent link and eliminates the silo.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Permit conditions are individual obligations attached to a permit by the regulatory authority. These conditions often derive directly from or correspond to entries in the regulatory_obligation master ',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Permit conditions restrict specific construction work packages (e.g., noise limits on pile-driving WBS, working-hours restrictions on specific activities). Condition-gated work scheduling and permit c',
    `compliance_deadline` DATE COMMENT 'Date by which the condition must be satisfied.',
    `compliance_evidence_url` STRING COMMENT 'Link to digital evidence supporting compliance.',
    `compliance_status_detail` STRING COMMENT 'Detailed description of the current compliance status.',
    `condition_action_required` STRING COMMENT 'Specific action(s) required to satisfy the condition.',
    `condition_category` STRING COMMENT 'Higher-level grouping of the condition (e.g., environmental, safety).',
    `condition_code` STRING COMMENT 'External code or identifier assigned to the condition by the regulatory authority.',
    `condition_document_reference` STRING COMMENT 'Reference to the official document where the condition is recorded.',
    `condition_fine_amount` DECIMAL(18,2) COMMENT 'Monetary fine associated with non‑compliance, if applicable.',
    `condition_fine_currency` STRING COMMENT 'Currency of the fine amount.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `condition_is_mandatory` BOOLEAN COMMENT 'Indicates whether the condition is mandatory (cannot be waived).',
    `condition_is_waivable` BOOLEAN COMMENT 'Indicates whether the condition can be waived under certain circumstances.',
    `condition_last_updated_by` STRING COMMENT 'User or system that performed the most recent update.',
    `condition_last_updated_by_role` STRING COMMENT 'Role of the user or system that performed the most recent update (e.g., compliance_officer, system).',
    `condition_priority` STRING COMMENT 'Priority level indicating the importance of the condition.. Valid values are `low|medium|high|critical`',
    `condition_reference_number` STRING COMMENT 'Alternate reference number for the condition, if used by the authority.',
    `condition_resolution_date` DATE COMMENT 'Date when the condition was resolved or closed.',
    `condition_resolution_notes` STRING COMMENT 'Notes describing how the condition was resolved.',
    `condition_review_date` DATE COMMENT 'Scheduled date for periodic review of the condition.',
    `condition_status_reason` STRING COMMENT 'Explanation for the current status of the condition.',
    `condition_type` STRING COMMENT 'Category of the condition, such as environmental, safety, financial, schedule, or quality.. Valid values are `environmental|safety|financial|schedule|quality`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the condition record was created.',
    `effective_date` DATE COMMENT 'Date when the condition becomes effective.',
    `evidence_required` STRING COMMENT 'Description of documentation or evidence needed to prove compliance.',
    `expiry_date` DATE COMMENT 'Date when the condition expires or is no longer applicable (nullable).',
    `inspection_last_date` DATE COMMENT 'Date of the most recent inspection related to the condition.',
    `inspection_next_date` DATE COMMENT 'Planned date for the next required inspection.',
    `inspection_required` BOOLEAN COMMENT 'Indicates whether a physical inspection is required for this condition.',
    `last_report_date` DATE COMMENT 'Date of the most recent compliance report submitted.',
    `next_report_date` DATE COMMENT 'Planned date for the next compliance report.',
    `notes` STRING COMMENT 'Free-form notes related to the condition.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount if the condition is not met.',
    `penalty_currency` STRING COMMENT 'Currency of the penalty amount.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `permit_condition_description` STRING COMMENT 'Full textual description of the condition and its obligations.',
    `permit_condition_status` STRING COMMENT 'Current lifecycle status of the condition.. Valid values are `pending|compliant|non_compliant|waived|closed`',
    `reporting_frequency` STRING COMMENT 'How often compliance evidence must be reported.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `source_agency` STRING COMMENT 'Regulatory authority that issued the condition (e.g., OSHA, EPA).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the condition record.',
    CONSTRAINT pk_permit_condition PRIMARY KEY(`permit_condition_id`)
) COMMENT 'Records individual conditions, restrictions, and obligations attached to an issued permit by the regulatory authority. Each condition has its own compliance obligation, due date, responsible party, and fulfilment status. Enables tracking of permit condition compliance separately from the permit itself, supporting audit readiness and authority inspections.';

CREATE OR REPLACE TABLE `construction_ecm`.`compliance`.`env_impact_assessment` (
    `env_impact_assessment_id` BIGINT COMMENT 'Primary key for env_impact_assessment',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which this assessment belongs.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Environmental impact assessments are commissioned and funded through specific cost centers in construction. Finance departments track EIA consultant costs, study fees, and review costs against cost ce',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: EIA costs (environmental studies, third-party consultant fees, regulatory review fees) are posted to specific cost codes in construction job costing. Cost controllers require this link to classify and',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.site. Business justification: EIAs are conducted for specific physical sites, not just projects. A site may have multiple EIAs over its lifecycle. Site-level environmental history tracking and due diligence reporting require linki',
    `approval_date` DATE COMMENT 'Date on which the assessment received formal approval.',
    `approval_status` STRING COMMENT 'Current approval state of the assessment with the regulator.. Valid values are `pending|approved|rejected|withdrawn`',
    `assessment_date` DATE COMMENT 'Date on which the environmental impact assessment was formally conducted.',
    `assessment_number` STRING COMMENT 'External reference number or code assigned to the assessment by the organization or regulator.',
    `assessment_type` STRING COMMENT 'Classification of the assessment (e.g., baseline, impact, post‑construction, ongoing monitoring).. Valid values are `baseline|impact|post_construction|monitoring`',
    `assessment_version` STRING COMMENT 'Version identifier for the assessment document (e.g., v1.0, v2.1).',
    `consultant_email` STRING COMMENT 'Primary email address of the environmental consultant for correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `consultant_name` STRING COMMENT 'Full legal name of the external environmental consultant or firm responsible for the assessment.',
    `corrective_action_taken` STRING COMMENT 'Description of any corrective action triggered by the last exceedance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `environmental_category` STRING COMMENT 'Primary environmental domain(s) addressed by the assessment.. Valid values are `air|water|soil|noise|biodiversity|waste`',
    `epa_report_submitted` BOOLEAN COMMENT 'Flag indicating whether the required EPA report for this assessment has been submitted.',
    `findings_summary` STRING COMMENT 'Concise summary of the key findings and conclusions of the assessment.',
    `iso_14001_compliant` BOOLEAN COMMENT 'Indicates compliance with ISO 14001 environmental management system standards.',
    `leeds_certified` BOOLEAN COMMENT 'True if the project has achieved LEED certification related to the assessment.',
    `mitigation_measures` STRING COMMENT 'List of required mitigation actions to address identified environmental impacts.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next mandatory review of the assessment.',
    `overall_status` STRING COMMENT 'Current operational status of the assessment record.. Valid values are `active|inactive|closed|on_hold`',
    `project_phase` STRING COMMENT 'Current phase of the construction project associated with the assessment.. Valid values are `planning|design|construction|operation|decommission`',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory review cycles for the assessment.',
    `risk_level` STRING COMMENT 'Risk rating assigned to the assessment based on potential environmental impact.. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Narrative description of the geographic and functional scope covered by the assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    CONSTRAINT pk_env_impact_assessment PRIMARY KEY(`env_impact_assessment_id`)
) COMMENT 'Master record for Environmental Impact Assessments (EIA), Environmental Management Plans (EMP), and ongoing environmental monitoring programs for construction projects. Captures assessment type, scope, environmental consultant, assessment date, findings summary, mitigation measures required, regulatory submission reference, approval status, and review cycle. Includes full environmental monitoring history: air quality measurements, noise level readings, water discharge sampling, soil contamination checks, dust suppression monitoring, with monitoring date, location, parameter measured, recorded value, regulatory threshold, exceedance flag, and corrective action triggered for each monitoring event. Supports EPA reporting, ISO 14001 surveillance, and demonstrates ongoing environmental compliance through continuous monitoring evidence.';

CREATE OR REPLACE TABLE `construction_ecm`.`compliance`.`env_monitoring` (
    `env_monitoring_id` BIGINT COMMENT 'Primary key for env_monitoring',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Environmental monitoring activities (air quality, noise, water discharge) are ongoing costs coded to specific cost codes in construction job costing. This link enables cost tracking of monitoring obli',
    `daily_log_id` BIGINT COMMENT 'Foreign key linking to site.daily_log. Business justification: Environmental monitoring readings are recorded as part of daily site activities and must be traceable to the daily log for that date. Environmental compliance audits and superintendent sign-off proces',
    `env_impact_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.env_impact_assessment. Business justification: Environmental monitoring events are performed against a specific impact assessment. Adding env_impact_assessment_id to env_monitoring captures this link.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project associated with the monitoring activity.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.site. Business justification: Environmental monitoring (air quality, noise, water) is conducted at specific physical site locations. env_monitoring has location_description/lat/long but no FK to site. Site-level environmental moni',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Environmental monitoring activities are conducted to fulfill specific regulatory obligations (e.g., EPA-mandated air quality monitoring, water discharge monitoring). Linking env_monitoring to regulato',
    `shift_report_id` BIGINT COMMENT 'Foreign key linking to site.shift_report. Business justification: Environmental monitoring readings (noise, dust, vibration) are taken during specific shifts and must be reconciled against the shift report for that period. Environmental compliance audits require thi',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Environmental monitoring (dust, noise, vibration) is conducted at specific work fronts. Regulators and environmental managers require monitoring results linked to the exact work front generating the i',
    `audit_created_by` BIGINT COMMENT 'Employee identifier who initially created the record.',
    `batch_number` STRING COMMENT 'Identifier for the batch of samples or readings, if applicable.',
    `comments` STRING COMMENT 'Free‑text notes or observations related to the monitoring event.',
    `compliance_status` STRING COMMENT 'Overall compliance determination for the measurement.. Valid values are `compliant|non_compliant|pending`',
    `corrective_action` STRING COMMENT 'Description of any corrective action triggered by an exceedance.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action.. Valid values are `pending|completed|not_required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the monitoring record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Indicates the quality assessment of the recorded data.. Valid values are `good|questionable|bad`',
    `env_monitoring_status` STRING COMMENT 'Lifecycle status of the monitoring record.. Valid values are `recorded|reviewed|closed`',
    `equipment_serial_number` STRING COMMENT 'Serial number of the equipment used for the measurement.',
    `exceedance_flag` BOOLEAN COMMENT 'Indicates whether the measured value exceeds the regulatory threshold.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the measurement location.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the measurement location.',
    `measured_value` DECIMAL(18,2) COMMENT 'Numeric result of the measurement.',
    `measurement_method` STRING COMMENT 'Technique used to obtain the measurement.. Valid values are `sensor|manual|lab`',
    `measurement_unit` STRING COMMENT 'Unit of measure for the recorded value (e.g., µg/m³, dB, pH).',
    `monitoring_timestamp` TIMESTAMP COMMENT 'Date and time when the environmental measurement was taken.',
    `monitoring_type` STRING COMMENT 'Category of environmental parameter being monitored.. Valid values are `air|noise|water|soil|dust|vibration`',
    `parameter` STRING COMMENT 'Specific environmental parameter measured (e.g., PM2.5, dB, pH).',
    `regulatory_body` STRING COMMENT 'Authority whose regulations apply to the measurement.. Valid values are `EPA|OSHA|ISO14001|local|state|federal`',
    `sample_reference` STRING COMMENT 'Unique identifier for the individual sample taken.',
    `sensor_code` BIGINT COMMENT 'Identifier of the sensor or instrument that captured the measurement.',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Regulatory or project-specific limit for the parameter.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the monitoring record.',
    `weather_conditions` STRING COMMENT 'Brief description of weather at the time of measurement (e.g., sunny, windy).',
    CONSTRAINT pk_env_monitoring PRIMARY KEY(`env_monitoring_id`)
) COMMENT 'Transactional records of environmental monitoring activities conducted on construction sites, including air quality measurements, noise level readings, water discharge sampling, soil contamination checks, and dust suppression monitoring. Captures monitoring date, location, parameter measured, recorded value, regulatory threshold, exceedance flag, and corrective action triggered. Supports EPA reporting and ISO 14001 surveillance.';

CREATE OR REPLACE TABLE `construction_ecm`.`compliance`.`regulatory_submission` (
    `regulatory_submission_id` BIGINT COMMENT 'System-generated unique identifier for the regulatory submission record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Regulatory submissions (environmental, planning, safety) in construction are filed on behalf of the client as the legal proponent. Linking to client.account enables client-level submission tracking, s',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Regulatory submissions (EIA reports, permit applications, compliance reports) are made on behalf of specific construction projects. Project-level regulatory submission tracking, reporting registers, a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Regulatory submissions incur costs (filing fees, consultant preparation costs, translation fees) charged to cost centers. Construction finance teams track submission costs by cost center for complianc',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Regulatory submission costs are coded to specific cost codes in construction job costing (regulatory filing, environmental reporting, statutory returns). Required for compliance cost allocation within',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Regulatory filing fees are recorded in the general ledger; linking submission to a GL account enables proper financial posting.',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Regulatory submissions (OSHA reports, EPA filings, permit renewal submissions) are frequently made in relation to a specific permit. Linking regulatory_submission to compliance_permit enables permit-l',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: Regulatory submissions are made to a specific authority; adding regulatory_authority_id captures this relationship and allows removal of duplicated authority fields.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: A regulatory submission fulfills a specific regulatory obligation (e.g., annual EPA report, OSHA incident submission). Linking regulatory_submission to regulatory_obligation enables obligation-level t',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: Regulatory submissions (discharge monitoring reports, noise reports, EPA returns) are made for a specific site. Compliance managers and site environmental officers need to retrieve all regulatory subm',
    `acknowledgement_date` TIMESTAMP COMMENT 'Timestamp of the acknowledgement receipt, if any.',
    `acknowledgement_received` BOOLEAN COMMENT 'Indicates whether an acknowledgement was received from the regulator.',
    `attachment_flag` BOOLEAN COMMENT 'True if any supporting documents are attached.',
    `compliance_category` STRING COMMENT 'High‑level compliance domain the submission addresses.. Valid values are `environmental|safety|quality|financial|privacy`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the fee amount.',
    `document_count` STRING COMMENT 'Number of supporting documents attached to the submission.',
    `external_reference_number` STRING COMMENT 'Reference number assigned by the regulatory body.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged by the regulatory body for processing the submission.',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the submission contains confidential information.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `regulatory_submission_status` STRING COMMENT 'Current lifecycle status of the submission.. Valid values are `draft|submitted|acknowledged|rejected|approved|closed`',
    `reporting_period_end` DATE COMMENT 'Last day of the period covered by the submission.',
    `reporting_period_start` DATE COMMENT 'First day of the period covered by the submission.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status, e.g., reason for rejection.',
    `submission_date` TIMESTAMP COMMENT 'Timestamp when the submission was sent to the regulatory body.',
    `submission_description` STRING COMMENT 'Narrative description of the submission content.',
    `submission_method` STRING COMMENT 'Channel used to deliver the submission.. Valid values are `electronic|paper|portal|email`',
    `submission_notes` STRING COMMENT 'Additional free‑form notes captured at submission time.',
    `submission_number` STRING COMMENT 'External reference number assigned to the submission by the originating system.',
    `submission_type` STRING COMMENT 'Category of regulatory filing, such as annual report or incident notification.. Valid values are `annual_report|incident_notification|permit_renewal|compliance_certificate|other`',
    `submitter_role` STRING COMMENT 'Role of the submitter within the project organization.. Valid values are `contractor|subcontractor|project_manager|safety_officer|engineer`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the submission record.',
    `version_number` STRING COMMENT 'Incremental version for optimistic concurrency control.',
    CONSTRAINT pk_regulatory_submission PRIMARY KEY(`regulatory_submission_id`)
) COMMENT 'Transactional record of formal regulatory submissions made to governing bodies including OSHA, EPA, local building authorities, and environmental agencies. Captures submission type (annual report, incident notification, permit renewal, compliance certificate), submission date, regulatory body, submission reference number, reporting period, submission method, acknowledgement received, and submission status. Serves as the SSOT for all outbound regulatory filings.';

CREATE OR REPLACE TABLE `construction_ecm`.`compliance`.`regulatory_obligation` (
    `regulatory_obligation_id` BIGINT COMMENT 'Unique identifier for the regulatory obligation record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Regulatory reporting tracks which client accounts are subject to each obligation, enabling account‑level compliance dashboards.',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Regulatory obligations are scoped to specific construction projects (scope_projects plain text column is a denormalization signal). Project-level obligation registers and compliance gap analysis repor',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Obligation‑related expenses are allocated to a cost center, supporting cost‑center level compliance cost analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Penalties or costs arising from obligations are posted to a GL account for accurate financial impact tracking.',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: regulatory_obligation.regulatory_body is a denormalized STRING field holding the name of the governing body that mandates the obligation. Normalizing to regulatory_authority_id creates a proper FK to ',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Obligations are assigned to specific vendors; linking allows monitoring vendor compliance with regulatory requirements.',
    `compliance_evidence_status` STRING COMMENT 'Current status of the compliance evidence submission.. Valid values are `submitted|approved|rejected|not_started`',
    `compliance_status` STRING COMMENT 'Current compliance status of the obligation.. Valid values are `compliant|non_compliant|pending|exempt|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the obligation record was created in the system.',
    `data_classification` STRING COMMENT 'Classification level of the obligation data per organizational policy.. Valid values are `public|internal|confidential|restricted`',
    `effective_date` DATE COMMENT 'Date when the obligation becomes effective.',
    `evidence_required` STRING COMMENT 'Description of documentation or evidence needed to demonstrate compliance.',
    `expiration_date` DATE COMMENT 'Date when the obligation expires or is no longer applicable, if applicable.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the obligation is currently active (true) or retired (false).',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether compliance with the obligation is mandatory (true) or optional (false).',
    `jurisdiction` STRING COMMENT 'Geographic jurisdiction (country or region) where the obligation applies.',
    `last_review_date` DATE COMMENT 'Date when the obligation was last reviewed for compliance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next compliance review.',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations about the obligation.',
    `obligation_code` STRING COMMENT 'External reference code or number assigned by the regulatory body or contract.',
    `obligation_title` STRING COMMENT 'Short descriptive title of the regulatory requirement.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount for non-compliance, if applicable.',
    `penalty_currency` STRING COMMENT 'Currency of the penalty amount.. Valid values are `USD|EUR|GBP|CAD|AUD`',
    `penalty_type` STRING COMMENT 'Type of penalty associated with the obligation.. Valid values are `fine|stop_work|license_revocation|other`',
    `review_frequency_months` STRING COMMENT 'Number of months between mandatory compliance reviews.',
    `risk_level` STRING COMMENT 'Risk level associated with non-compliance of the obligation.. Valid values are `low|medium|high|critical`',
    `scope_business_units` STRING COMMENT 'Business units or divisions affected by the obligation.',
    `source_document_reference` STRING COMMENT 'Reference to the original legal or contractual document that defines the obligation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the obligation record.',
    CONSTRAINT pk_regulatory_obligation PRIMARY KEY(`regulatory_obligation_id`)
) COMMENT 'Master register of all regulatory obligations applicable to the organization and its construction projects, derived from applicable laws, standards, permits, and contractual requirements. Captures obligation source (OSHA 29 CFR, EPA Clean Water Act, IBC/IRC, ISO 45001, GDPR, PCI DSS, FIDIC, local building codes), obligation description, applicable jurisdiction, effective date, review frequency, responsible owner, compliance evidence required, current compliance status, and organizational scope mapping (projects, business units, jurisdictions). Serves as the single compliance obligation inventory underpinning all compliance activities, assessments, calendar deadlines, and regulatory change impact analysis.';

CREATE OR REPLACE TABLE `construction_ecm`.`compliance`.`assessment` (
    `assessment_id` BIGINT COMMENT 'System-generated unique identifier for the compliance assessment record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Client prequalification (account.prequalification_status) in construction requires a compliance assessment portfolio per client account. Linking assessment to client.account enables client-level compl',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project to which the assessment applies.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compliance assessments and audits incur costs (external auditor fees, internal resource costs) charged to cost centers. Construction finance teams track audit costs by cost center for overhead allocat',
    `package_id` BIGINT COMMENT 'Foreign key linking to design.package. Business justification: Compliance assessments are scoped to specific design packages (assessing whether a civil works package meets regulatory requirements, reviewing an environmental management package). Package-level comp',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: A compliance assessment is frequently conducted against a specific permit to verify adherence to permit conditions and requirements. Linking assessment to compliance_permit enables traceability from p',
    `phase_id` BIGINT COMMENT 'Foreign key linking to project.phase. Business justification: Compliance assessments in construction are phase-specific (pre-construction audit, construction phase audit, commissioning audit). Phase-gate compliance reporting and gate approval workflows require l',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: assessment.regulatory_body is a denormalized STRING reference to the governing body conducting or overseeing the assessment. Normalizing to regulatory_authority_id creates a proper FK to the regulator',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: Compliance assessments (environmental audits, regulatory audits) are conducted at a specific physical site. Site managers and compliance teams need site-level assessment registers — a standard constru',
    `assessment_code` STRING COMMENT 'Human‑readable code assigned to the assessment (e.g., CA‑2023‑001).',
    `assessment_date` DATE COMMENT 'Date on which the compliance assessment was conducted.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the assessment.. Valid values are `draft|in_progress|completed|approved|rejected`',
    `assessment_type` STRING COMMENT 'Type of compliance assessment performed.. Valid values are `regulatory|internal|external|audit`',
    `assessor_name` STRING COMMENT 'Full legal name of the assessor.',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the assessment.',
    `audit_trail_notes` STRING COMMENT 'Free‑form notes capturing audit trail information.',
    `compliance_category` STRING COMMENT 'Primary category of compliance (e.g., environmental, safety).. Valid values are `environment|safety|quality|financial|privacy`',
    `compliance_rating` STRING COMMENT 'Overall compliance result based on the assessment.. Valid values are `compliant|non_compliant|partial|not_applicable`',
    `compliance_status_overall` STRING COMMENT 'Aggregated compliance status across all obligations.. Valid values are `compliant|non_compliant|partial`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the assessment record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for any monetary values.. Valid values are `[A-Z]{3}`',
    `document_reference` STRING COMMENT 'Reference identifier for supporting documentation (e.g., file ID).',
    `external_audit_firm` STRING COMMENT 'Name of the external firm that conducted the audit.',
    `findings_summary` STRING COMMENT 'High‑level summary of key findings from the assessment.',
    `gaps_identified` STRING COMMENT 'Specific compliance gaps or deficiencies discovered.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the assessment result is considered critical for the project.',
    `is_external_audit` BOOLEAN COMMENT 'True if the assessment was performed by an external auditor.',
    `jurisdiction` STRING COMMENT 'ISO 3166‑1 alpha‑3 country code of the jurisdiction.. Valid values are `[A-Z]{3}`',
    `last_reviewed_by` BIGINT COMMENT 'Identifier of the party who performed the most recent review of the assessment.',
    `last_reviewed_date` DATE COMMENT 'Date of the most recent review.',
    `mitigation_plan` STRING COMMENT 'Planned actions to mitigate identified compliance risks.',
    `next_assessment_due_date` DATE COMMENT 'Planned date for the subsequent compliance assessment.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed for non‑compliance, if applicable.',
    `rating_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing the degree of compliance.',
    `recommended_actions` STRING COMMENT 'Suggested remediation steps to close identified gaps.',
    `risk_level` STRING COMMENT 'Risk classification associated with the assessment findings.. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Narrative describing the scope and boundaries of the compliance assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assessment record.',
    CONSTRAINT pk_assessment PRIMARY KEY(`assessment_id`)
) COMMENT 'Periodic compliance assessment records evaluating the organizations or a projects adherence to regulatory obligations, internal policies, and permit conditions. Captures assessment date, scope, assessor, obligations assessed, findings, compliance rating, gaps identified, and recommended actions. Distinct from quality NCRs (owned by quality domain) and safety audits (owned by safety domain) — this covers regulatory and legal compliance only.';

CREATE OR REPLACE TABLE `construction_ecm`.`compliance`.`action` (
    `action_id` BIGINT COMMENT 'System-generated unique identifier for the compliance action record.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.assessment. Business justification: The compliance_action product description explicitly states actions are raised as a result of compliance assessments. This is a direct parent-child relationship where the assessment is the triggerin',
    `authority_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.authority_notice. Business justification: compliance_action has external_notice_date and external_authority_name attributes indicating actions triggered by external authority notices. Formalizing this as a FK to authority_notice enables full ',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Compliance Action Tracking Report requires linking each corrective action to the project it addresses.',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to quality.corrective_action. Business justification: When an NCR has regulatory implications, both a quality corrective_action and a compliance_action are raised. Linking them enables integrated remediation tracking — compliance managers verify that the',
    `document_register_id` BIGINT COMMENT 'Reference to the document or file that provides proof of action completion.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Compliance actions incur costs that must be posted to a GL account for financial reporting; linking ensures accurate expense accounting.',
    `ncr_id` BIGINT COMMENT 'Foreign key linking to quality.ncr. Business justification: NCRs with regulatory implications (structural failures, environmental breaches) directly trigger compliance actions. Compliance managers need compliance_action-to-NCR linkage to track which quality no',
    `permit_id` BIGINT COMMENT 'Identifier of the permit whose condition was breached, if applicable.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Compliance actions address regulatory obligations; many actions can belong to one obligation. Adding regulatory_obligation_id to compliance_action enables this relationship.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to project.wbs_element. Business justification: Compliance corrective actions (permit condition remediation, regulatory violations) are tied to specific WBS work packages. Work-package-level compliance cost tracking and corrective action scheduling',
    `work_front_id` BIGINT COMMENT 'Foreign key linking to site.work_front. Business justification: Compliance corrective actions (stop-work, remediation) are directed at specific work fronts. Site managers and compliance officers need this link to identify which active work front is subject to a co',
    `action_number` STRING COMMENT 'Human‑readable identifier assigned to the corrective or preventive action, often used in reports and communications.',
    `action_type` STRING COMMENT 'Classifies the action as corrective, preventive, or improvement.. Valid values are `corrective|preventive|improvement`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the action was formally approved.',
    `closure_evidence_url` STRING COMMENT 'Web link or path to the evidence confirming action closure.',
    `comments` STRING COMMENT 'Free‑form notes or remarks added by stakeholders.',
    `completed_date` DATE COMMENT 'Actual date when the corrective or preventive work was finished.',
    `compliance_action_description` STRING COMMENT 'Detailed description of the corrective or preventive work to be performed.',
    `compliance_action_status` STRING COMMENT 'Current lifecycle state of the compliance action.. Valid values are `open|in_progress|closed|cancelled|deferred`',
    `compliance_area` STRING COMMENT 'Domain of compliance impacted (e.g., safety, environment, quality).. Valid values are `safety|environment|quality|financial|legal|ethics`',
    `corrective_measure` STRING COMMENT 'Specific steps or measures that will address the identified non‑conformance.',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual monetary cost incurred after action completion.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Projected monetary cost to implement the action.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the compliance action was initially recorded.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `due_date` DATE COMMENT 'Target date by which the action must be completed to satisfy the compliance requirement.',
    `external_authority_name` STRING COMMENT 'Name of the external regulatory body or agency.',
    `external_notice_date` DATE COMMENT 'Date the external authority issued the notice or citation.',
    `is_external` BOOLEAN COMMENT 'True if the action is driven by an external regulator or agency.',
    `is_repeat_action` BOOLEAN COMMENT 'True if this action is a repeat of a previously recorded issue.',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time when the action record was last reviewed for relevance or accuracy.',
    `mitigation_plan` STRING COMMENT 'Long‑term plan to prevent recurrence of the issue.',
    `monitoring_end_date` DATE COMMENT 'Date when the monitoring period ends.',
    `monitoring_frequency` STRING COMMENT 'How often the post‑action monitoring should occur.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    `monitoring_required` BOOLEAN COMMENT 'True if ongoing monitoring is required after closure.',
    `monitoring_start_date` DATE COMMENT 'Date when the monitoring period begins.',
    `priority` STRING COMMENT 'Business‑defined priority level indicating urgency.. Valid values are `low|medium|high|critical`',
    `regulatory_reference` STRING COMMENT 'Citation of the specific regulation, standard, or permit clause that triggered the action (e.g., OSHA 1910.120).',
    `repeat_action_count` STRING COMMENT 'Number of times the same issue has been recorded.',
    `risk_level` STRING COMMENT 'Assessed risk severity associated with the non‑compliance.. Valid values are `low|medium|high|critical`',
    `root_cause` STRING COMMENT 'Narrative explaining the underlying cause that triggered the compliance action.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the action record.',
    `verification_date` DATE COMMENT 'Date when the completed action was verified as effective and compliant.',
    CONSTRAINT pk_action PRIMARY KEY(`action_id`)
) COMMENT 'Corrective and preventive actions raised as a result of compliance assessments, regulatory findings, permit condition breaches, or authority notices. Tracks action description, root cause, responsible party, due date, priority, completion status, evidence of closure, and verification date. Distinct from safety corrective actions (owned by safety domain via Intelex) — this covers regulatory compliance remediation only.';

CREATE OR REPLACE TABLE `construction_ecm`.`compliance`.`authority_notice` (
    `authority_notice_id` BIGINT COMMENT 'System-generated unique identifier for the authority notice record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: In construction, authority notices (stop-work orders, penalty notices) are issued against the client as the legal entity. Linking to client.account enables regulatory exposure reporting, feeds account',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project affected by the notice.',
    `contact_id` BIGINT COMMENT 'Foreign key linking to client.contact. Business justification: In construction, formal authority notices are legally served on a named client representative (e.g., clients legal counsel or project director). Tracking which client contact received and responded t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Authority notices (fines, enforcement penalties, stop-work orders) result in financial charges and remediation costs posted to cost centers. Construction finance teams track penalty costs by cost cent',
    `document_register_id` BIGINT COMMENT 'Reference to a stored document (e.g., scanned notice) linked to this record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Penalty amounts from authority notices must be posted to specific GL accounts (fines and penalties expense, provisions for regulatory risk). Construction accountants require this link for accurate fin',
    `inspection_record_id` BIGINT COMMENT 'Foreign key linking to equipment.inspection_record. Business justification: Regulatory authority notices in construction are frequently issued citing a specific failed equipment inspection (e.g., regulator issues stop-work notice after crane inspection failure). Linking autho',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_permit. Business justification: Authority notices (stop-work orders, infringement notices, improvement notices) are typically issued in relation to a specific permit or permit condition. Linking authority_notice to compliance_permit',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.site. Business justification: Regulatory authority notices (stop-work orders, violation notices) are issued against specific physical sites. Site-level compliance violation tracking and site inspection history reports require link',
    `regulatory_authority_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_authority. Business justification: authority_notice.issuing_authority is a denormalized STRING field holding the name of the issuing regulatory body. Normalizing to regulatory_authority_id creates a proper FK to the regulatory_authorit',
    `appeal_date` DATE COMMENT 'Date on which the appeal was lodged.',
    `appeal_lodged_flag` BOOLEAN COMMENT 'Indicates whether an appeal against the notice has been filed.',
    `authority_notice_status` STRING COMMENT 'Current lifecycle status of the notice.. Valid values are `open|closed|appealed|resolved|dismissed`',
    `authority_type` STRING COMMENT 'Classification of the issuing authority by jurisdiction level.. Valid values are `federal|state|local|private`',
    `compliance_category` STRING COMMENT 'High‑level category of the compliance issue.. Valid values are `safety|environment|building|financial`',
    `compliance_officer` STRING COMMENT 'Name of the internal officer responsible for managing the notice response.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the notice record was first captured in the system.',
    `notes` STRING COMMENT 'Free-text field for any supplemental information or comments.',
    `notice_date` TIMESTAMP COMMENT 'Date and time when the regulatory authority issued the notice.',
    `notice_number` STRING COMMENT 'External reference number assigned by the issuing authority to the notice.',
    `notice_type` STRING COMMENT 'Category of the notice describing its nature.. Valid values are `infringement|improvement|prohibition|stop_work|directive`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty imposed by the authority, if any.',
    `penalty_currency` STRING COMMENT 'Three‑letter ISO currency code for the penalty amount.',
    `penalty_due_date` DATE COMMENT 'Date by which the penalty must be paid.',
    `regulation_breached` STRING COMMENT 'Specific regulation, code, or standard that was violated.',
    `remediation_required` STRING COMMENT 'Actions required by the authority to remediate the violation.',
    `resolution_date` DATE COMMENT 'Date on which the notice was formally resolved.',
    `resolution_outcome` STRING COMMENT 'Final outcome after the notice was addressed.. Valid values are `complied|non_complied|settled|dismissed`',
    `response_deadline` DATE COMMENT 'Date by which a formal response to the notice must be submitted.',
    `response_submitted_date` DATE COMMENT 'Date on which the response was submitted.',
    `response_submitted_flag` BOOLEAN COMMENT 'Indicates whether a response has been submitted to the authority.',
    `severity_level` STRING COMMENT 'Risk severity assigned to the notice by the authority.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the notice record.',
    `violation_description` STRING COMMENT 'Detailed description of the regulatory violation cited in the notice.',
    CONSTRAINT pk_authority_notice PRIMARY KEY(`authority_notice_id`)
) COMMENT 'Records formal notices, orders, infringement notices, improvement notices, prohibition notices, stop-work orders, and directives received from regulatory authorities including OSHA, EPA, local councils, fire marshals, and building inspectors. Captures notice type, severity level, issuing authority, notice date, project or site affected, violation described, applicable regulation breached, required remediation, response deadline, response submitted, appeal lodged flag, and resolution outcome. Critical for legal risk management, regulatory relationship tracking, and insurance notification obligations.';

CREATE OR REPLACE TABLE `construction_ecm`.`compliance`.`regulatory_authority` (
    `regulatory_authority_id` BIGINT COMMENT 'Unique system-generated identifier for the regulatory authority.',
    `abbreviation` STRING COMMENT 'Common short name or acronym of the authority.',
    `address` STRING COMMENT 'Physical mailing address of the authority.',
    `classification` STRING COMMENT 'Category type of the authority.. Valid values are `regulatory|environmental|safety|building|utility`',
    `compliance_status` STRING COMMENT 'Overall compliance status of the organization with respect to this authority.. Valid values are `compliant|non_compliant|under_review|not_applicable`',
    `contact_person` STRING COMMENT 'Name of the primary contact person at the authority.',
    `contact_role` STRING COMMENT 'Role of the primary contact person within the authority.. Valid values are `director|manager|officer|coordinator|representative`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the authority record was created in the system.',
    `effective_from` DATE COMMENT 'Date when the authority record became effective for use.',
    `effective_until` DATE COMMENT 'Date when the authority record is no longer effective, if applicable.',
    `email` STRING COMMENT 'Primary contact email address for the authority.',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the authoritys regulatory reach.. Valid values are `global|national|state|city|county`',
    `is_primary` BOOLEAN COMMENT 'Indicates if this authority is the primary regulator for the organization.',
    `jurisdiction_type` STRING COMMENT 'Level of jurisdiction the authority operates under.. Valid values are `federal|state|local|regional|international`',
    `last_contact_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent communication with the authority.',
    `notes` STRING COMMENT 'Free-text notes or comments about the authority.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the authority.',
    `portal_url` STRING COMMENT 'URL of the electronic portal used for submissions to the authority.',
    `regulatory_authority_name` STRING COMMENT 'Official full name of the regulatory authority.',
    `regulatory_authority_status` STRING COMMENT 'Current operational status of the authority record.. Valid values are `active|inactive|suspended|pending`',
    `regulatory_frameworks` STRING COMMENT 'Comma-separated list of regulatory frameworks the authority enforces (e.g., OSHA, EPA, ISO 45001).',
    `relationship_owner` STRING COMMENT 'Internal department or owner responsible for managing the relationship with the authority.. Valid values are `compliance|legal|procurement|project_management|safety`',
    `submission_system` STRING COMMENT 'Name of the electronic submission system or platform used by the authority.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the authority record.',
    `website_url` STRING COMMENT 'Public website URL for the authority.',
    CONSTRAINT pk_regulatory_authority PRIMARY KEY(`regulatory_authority_id`)
) COMMENT 'Reference master of regulatory and governing bodies with whom the organization interacts, including OSHA, EPA, local building departments, environmental agencies, fire marshals, and utility authorities. Captures authority name, jurisdiction type, geographic scope, contact details, applicable regulatory frameworks, portal or submission system reference, and relationship owner. Enables consistent authority identification across permit applications, submissions, and notices.';

CREATE OR REPLACE TABLE `construction_ecm`.`compliance`.`compliance_calendar` (
    `compliance_calendar_id` BIGINT COMMENT 'Unique identifier for the compliance calendar entry.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.assessment. Business justification: The compliance_calendar tracks assessment due dates and next assessment dates. Linking calendar entries to assessment records enables tracking of scheduled vs. completed assessments. The FK is nullabl',
    `authority_notice_id` BIGINT COMMENT 'Foreign key linking to compliance.authority_notice. Business justification: The compliance_calendar tracks response deadlines and remediation deadlines for authority notices. Linking calendar entries to authority_notice records enables deadline management for notice responses',
    `construction_project_id` BIGINT COMMENT 'Foreign key linking to project.construction_project. Business justification: Compliance calendar deadlines (permit renewals, regulatory reporting deadlines, condition due dates) are project-specific. Project-level compliance deadline dashboards and PMO compliance status report',
    `parent_compliance_calendar_id` BIGINT COMMENT 'Self-referencing FK on compliance_calendar (parent_compliance_calendar_id)',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: The compliance_calendar tracks obligation review dates, reporting deadlines, and compliance milestones. Linking calendar entries to specific regulatory_obligation records enables obligation-level dead',
    `regulatory_submission_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_submission. Business justification: The compliance_calendar tracks submission due dates. Linking calendar entries to regulatory_submission records enables tracking of whether a scheduled submission has been completed. The FK is nullable',
    `site_id` BIGINT COMMENT 'Foreign key linking to site.site. Business justification: Compliance calendar deadlines (monthly reporting, permit renewals, inspection dates) are site-specific obligations. Site managers need a site-filtered compliance calendar view — a standard constructio',
    `attachment_count` STRING COMMENT 'Number of supporting documents attached to the calendar entry.',
    `completion_date` DATE COMMENT 'Date on which the compliance action was completed.',
    `compliance_calendar_status` STRING COMMENT 'Current lifecycle status of the calendar entry.. Valid values are `pending|completed|overdue|cancelled`',
    `compliance_category` STRING COMMENT 'Broad category of compliance (e.g., Safety, Environment, Quality).. Valid values are `safety|environment|quality|financial|privacy|security`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calendar entry record was first created.',
    `deadline_date` DATE COMMENT 'Calendar date on which the compliance obligation must be satisfied.',
    `deadline_type` STRING COMMENT 'Classification of the deadline, indicating the nature of the compliance requirement.. Valid values are `permit|certification|audit|report|inspection|training`',
    `entry_code` STRING COMMENT 'Business identifier code for the calendar entry, used for external reference.',
    `escalation_path` STRING COMMENT 'Textual description of the escalation procedure if the deadline is missed.',
    `escalation_triggered_flag` BOOLEAN COMMENT 'Indicates whether the escalation process has been activated.',
    `escalation_triggered_timestamp` TIMESTAMP COMMENT 'Timestamp when the escalation was triggered.',
    `jurisdiction` STRING COMMENT 'Three‑letter country code indicating the jurisdiction governing the obligation.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the calendar entry.',
    `overdue_flag` BOOLEAN COMMENT 'Indicates whether the deadline is past due and not yet completed.',
    `priority` STRING COMMENT 'Business priority assigned to the deadline for resource planning.. Valid values are `low|medium|high|critical`',
    `regulatory_body` STRING COMMENT 'Name of the regulatory agency or body that issued the obligation.',
    `reminder_lead_days` STRING COMMENT 'Number of days prior to the deadline when a reminder should be issued.',
    `reminder_sent_flag` BOOLEAN COMMENT 'Indicates whether the pre‑deadline reminder has been sent.',
    `reminder_sent_timestamp` TIMESTAMP COMMENT 'Timestamp when the reminder was sent to the responsible owner.',
    `risk_level` STRING COMMENT 'Risk rating associated with missing the deadline.. Valid values are `low|medium|high|critical`',
    `source_reference` STRING COMMENT 'Reference code or identifier of the originating regulatory obligation, permit, or certification.',
    `title` STRING COMMENT 'Human‑readable title describing the compliance deadline or event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the calendar entry.',
    CONSTRAINT pk_compliance_calendar PRIMARY KEY(`compliance_calendar_id`)
) COMMENT 'Operational calendar of compliance deadlines, renewal dates, submission due dates, permit expiry dates, ISO audit schedules, LEED submission windows, and regulatory filing deadlines. Aggregates key dates from permits, certifications, regulatory obligations, and authority notices into a single actionable timeline. Captures deadline date, deadline type, source obligation or permit reference, responsible owner, reminder lead time, escalation path, completion status, and overdue flag. The primary daily operational tool for construction compliance managers ensuring no regulatory deadline is missed across multiple project sites and jurisdictions.';

CREATE OR REPLACE TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` (
    `obligation_assessment_result_id` BIGINT COMMENT 'Primary key for the obligation_assessment_result association',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to the parent compliance assessment in which this obligation was evaluated.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to the specific regulatory obligation evaluated in this assessment result.',
    `compliance_rating` STRING COMMENT 'Compliance result for this specific obligation within this assessment. Distinct from the aggregate compliance_rating on the assessment record, which rolls up all obligations.',
    `evaluated_date` DATE COMMENT 'Date on which this specific obligation was evaluated within the assessment. May differ from the overall assessment_date when assessments span multiple days or phases. Sourced from detection phase (obligation_assessment_date).',
    `findings` STRING COMMENT 'Specific audit findings or observations recorded for this obligation during this assessment. Belongs to the intersection, not to the assessment summary or the obligation master record.',
    `gap_status` STRING COMMENT 'Whether a compliance gap was identified for this specific obligation in this assessment. Sourced directly from detection phase relationship data.',
    `obligations_assessed` STRING COMMENT 'List or description of regulatory obligations evaluated during the assessment. [Moved from assessment: This STRING field is a denormalized, multi-value representation of the M:N relationship between assessment and regulatory_obligation. It must be removed and replaced by the obligation_assessment_result association table, which properly normalizes each obligation-assessment intersection as a discrete record.]',
    `remediation_required` BOOLEAN COMMENT 'Indicates whether remediation action is required for this obligation as a result of this assessment finding. Sourced directly from detection phase relationship data (remediation_required_flag).',
    CONSTRAINT pk_obligation_assessment_result PRIMARY KEY(`obligation_assessment_result_id`)
) COMMENT 'This association product represents the per-obligation outcome Event between assessment and regulatory_obligation. It captures the specific compliance result, findings, gap status, and remediation requirement for each regulatory obligation evaluated within a given compliance assessment. Each record links one assessment to one regulatory_obligation with attributes that exist only in the context of this intersection — a named operational concept used in ISO 14001, OSHA VPP, and EPA audit frameworks.. Existence Justification: In construction compliance management, a single assessment (e.g., an EPA audit or OSHA inspection) evaluates multiple regulatory obligations simultaneously, and each regulatory obligation is evaluated across multiple assessments over its lifecycle. This is not an analytical correlation — compliance teams actively create, manage, and report on per-obligation findings within each assessment as a named operational concept (obligation assessment result). The relationship carries its own data (per-obligation compliance rating, findings, gap status, remediation flag) that belongs to neither the assessment nor the obligation alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `construction_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`compliance`.`permit` ADD CONSTRAINT `fk_compliance_permit_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ADD CONSTRAINT `fk_compliance_permit_application_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ADD CONSTRAINT `fk_compliance_permit_application_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ADD CONSTRAINT `fk_compliance_permit_condition_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_env_impact_assessment_id` FOREIGN KEY (`env_impact_assessment_id`) REFERENCES `construction_ecm`.`compliance`.`env_impact_assessment`(`env_impact_assessment_id`);
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ADD CONSTRAINT `fk_compliance_env_monitoring_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ADD CONSTRAINT `fk_compliance_regulatory_submission_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ADD CONSTRAINT `fk_compliance_regulatory_obligation_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ADD CONSTRAINT `fk_compliance_assessment_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `construction_ecm`.`compliance`.`action` ADD CONSTRAINT `fk_compliance_action_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `construction_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `construction_ecm`.`compliance`.`action` ADD CONSTRAINT `fk_compliance_action_authority_notice_id` FOREIGN KEY (`authority_notice_id`) REFERENCES `construction_ecm`.`compliance`.`authority_notice`(`authority_notice_id`);
ALTER TABLE `construction_ecm`.`compliance`.`action` ADD CONSTRAINT `fk_compliance_action_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`compliance`.`action` ADD CONSTRAINT `fk_compliance_action_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_permit_id` FOREIGN KEY (`permit_id`) REFERENCES `construction_ecm`.`compliance`.`permit`(`permit_id`);
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ADD CONSTRAINT `fk_compliance_authority_notice_regulatory_authority_id` FOREIGN KEY (`regulatory_authority_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_authority`(`regulatory_authority_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `construction_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_authority_notice_id` FOREIGN KEY (`authority_notice_id`) REFERENCES `construction_ecm`.`compliance`.`authority_notice`(`authority_notice_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_parent_compliance_calendar_id` FOREIGN KEY (`parent_compliance_calendar_id`) REFERENCES `construction_ecm`.`compliance`.`compliance_calendar`(`compliance_calendar_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ADD CONSTRAINT `fk_compliance_compliance_calendar_regulatory_submission_id` FOREIGN KEY (`regulatory_submission_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_submission`(`regulatory_submission_id`);
ALTER TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` ADD CONSTRAINT `fk_compliance_obligation_assessment_result_assessment_id` FOREIGN KEY (`assessment_id`) REFERENCES `construction_ecm`.`compliance`.`assessment`(`assessment_id`);
ALTER TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` ADD CONSTRAINT `fk_compliance_obligation_assessment_result_regulatory_obligation_id` FOREIGN KEY (`regulatory_obligation_id`) REFERENCES `construction_ecm`.`compliance`.`regulatory_obligation`(`regulatory_obligation_id`);

-- ========= TAGS =========
ALTER SCHEMA `construction_ecm`.`compliance` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `construction_ecm`.`compliance` SET TAGS ('dbx_domain' = 'compliance');
ALTER TABLE `construction_ecm`.`compliance`.`permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`compliance`.`permit` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit ID');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Env Impact Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `compliance_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evidence URL');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `compliance_permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `compliance_permit_status` SET TAGS ('dbx_value_regex' = 'applied|under_review|approved|issued|expired|revoked');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Status');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|pending');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `condition_count` SET TAGS ('dbx_business_glossary_term' = 'Condition Count');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `documents_attached_count` SET TAGS ('dbx_business_glossary_term' = 'Attached Documents Count');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Amount');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `fee_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Fee Paid Date');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `fee_paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Fee Paid Flag');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `next_condition_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Condition Due Date');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `permit_category` SET TAGS ('dbx_business_glossary_term' = 'Permit Category');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `permit_category` SET TAGS ('dbx_value_regex' = 'public|private|joint_venture|government');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type (e.g., Building, Excavation, Environmental, Utility, Demolition, Occupancy)');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'building|excavation|environmental|utility|demolition|occupancy');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Permit Risk Level');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `suspension_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspension Flag');
ALTER TABLE `construction_ecm`.`compliance`.`permit` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `permit_application_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Application ID');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier (PID)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment Identifier (EIAI)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `appeal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date (ADD)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `appeal_filed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Timestamp (AFT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Application Number (PAN)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Approval Timestamp (PAT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `compliance_requirements_met` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements Met Flag (CRM)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `decision` SET TAGS ('dbx_business_glossary_term' = 'Authority Decision (ADec)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|withdrawn|pending');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `decision_reason` SET TAGS ('dbx_business_glossary_term' = 'Decision Reason (DR)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Timestamp (PET)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `fee_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Adjustment (PFAJ)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `fee_adjustment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `fee_total` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Total (PFT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `fee_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `is_resubmission` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Indicator (RI)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `leeds_certification_level` SET TAGS ('dbx_business_glossary_term' = 'LEED Certification Level (LCL)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `leeds_certification_level` SET TAGS ('dbx_value_regex' = 'certified|silver|gold|platinum');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `permit_application_description` SET TAGS ('dbx_business_glossary_term' = 'Application Description (AD)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `permit_application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Lifecycle Status (ALS)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `permit_application_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `resubmission_reason` SET TAGS ('dbx_business_glossary_term' = 'Resubmission Reason (RR)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Timestamp (AST)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `supporting_document_count` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Count (SDC)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (RUT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Validity End Date (VED)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Validity Start Date (VSD)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_application` ALTER COLUMN `work_scope` SET TAGS ('dbx_business_glossary_term' = 'Work Scope Description (WSD)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `permit_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition ID');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline (COMP_DEADLINE)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `compliance_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evidence URL (EVID_URL)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `compliance_status_detail` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status Detail (COMP_STATUS_DETAIL)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_action_required` SET TAGS ('dbx_business_glossary_term' = 'Action Required (ACTION_REQ)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_category` SET TAGS ('dbx_business_glossary_term' = 'Condition Category (COND_CAT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code (COND_CD)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference (DOC_REF)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_fine_amount` SET TAGS ('dbx_business_glossary_term' = 'Fine Amount (FINE_AMT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_fine_currency` SET TAGS ('dbx_business_glossary_term' = 'Fine Currency (FINE_CURR)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_fine_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Condition Flag (MANDATORY_FLAG)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_is_waivable` SET TAGS ('dbx_business_glossary_term' = 'Waivable Condition Flag (WAIVABLE_FLAG)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By (LAST_UPDATED_BY)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_last_updated_by_role` SET TAGS ('dbx_business_glossary_term' = 'Updater Role (UPDATER_ROLE)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_priority` SET TAGS ('dbx_business_glossary_term' = 'Condition Priority (COND_PRIORITY)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Number (REF_NUM)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date (RESOLUTION_DT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes (RESOLUTION_NOTES)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date (REVIEW_DT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Condition Status Reason (STATUS_REASON)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type (COND_TYPE)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_value_regex' = 'environmental|safety|financial|schedule|quality');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence Required (EVID_REQ)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date (EXP_DT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `inspection_last_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date (LAST_INSP_DT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `inspection_next_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date (NEXT_INSP_DT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag (INSP_REQ)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `last_report_date` SET TAGS ('dbx_business_glossary_term' = 'Last Report Date (LAST_RPT_DT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `next_report_date` SET TAGS ('dbx_business_glossary_term' = 'Next Report Date (NEXT_RPT_DT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount (PENALTY_AMT)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency (PENALTY_CURR)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `permit_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description (COND_DESC)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `permit_condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status (COND_STATUS)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `permit_condition_status` SET TAGS ('dbx_value_regex' = 'pending|compliant|non_compliant|waived|closed');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency (REPORT_FREQ)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `source_agency` SET TAGS ('dbx_business_glossary_term' = 'Source Regulatory Agency (SRC_AGENCY)');
ALTER TABLE `construction_ecm`.`compliance`.`permit_condition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` SET TAGS ('dbx_subdomain' = 'environmental_oversight');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Env Impact Assessment Identifier');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|withdrawn');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'baseline|impact|post_construction|monitoring');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `assessment_version` SET TAGS ('dbx_business_glossary_term' = 'Assessment Version');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `consultant_email` SET TAGS ('dbx_business_glossary_term' = 'Environmental Consultant Email');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `consultant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `consultant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `consultant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `consultant_name` SET TAGS ('dbx_business_glossary_term' = 'Environmental Consultant Name');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `consultant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `consultant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `environmental_category` SET TAGS ('dbx_business_glossary_term' = 'Environmental Category');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `environmental_category` SET TAGS ('dbx_value_regex' = 'air|water|soil|noise|biodiversity|waste');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `epa_report_submitted` SET TAGS ('dbx_business_glossary_term' = 'EPA Report Submitted');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `iso_14001_compliant` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Compliant');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `leeds_certified` SET TAGS ('dbx_business_glossary_term' = 'LEED Certified');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `mitigation_measures` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Measures');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `overall_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Status');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `overall_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|on_hold');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `project_phase` SET TAGS ('dbx_business_glossary_term' = 'Project Phase');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `project_phase` SET TAGS ('dbx_value_regex' = 'planning|design|construction|operation|decommission');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `construction_ecm`.`compliance`.`env_impact_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` SET TAGS ('dbx_subdomain' = 'environmental_oversight');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `env_monitoring_id` SET TAGS ('dbx_business_glossary_term' = 'Env Monitoring Identifier');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `daily_log_id` SET TAGS ('dbx_business_glossary_term' = 'Daily Log Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `env_impact_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Env Impact Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `audit_created_by` SET TAGS ('dbx_business_glossary_term' = 'Audit Created By Employee ID');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `audit_created_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `audit_created_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|completed|not_required');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `env_monitoring_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `env_monitoring_status` SET TAGS ('dbx_value_regex' = 'recorded|reviewed|closed');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Exceedance Flag');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `measured_value` SET TAGS ('dbx_business_glossary_term' = 'Measured Value');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'sensor|manual|lab');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `monitoring_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `monitoring_type` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Type (MT)');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `monitoring_type` SET TAGS ('dbx_value_regex' = 'air|noise|water|soil|dust|vibration');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `parameter` SET TAGS ('dbx_business_glossary_term' = 'Measured Parameter');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'EPA|OSHA|ISO14001|local|state|federal');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `sample_reference` SET TAGS ('dbx_business_glossary_term' = 'Sample ID');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `sensor_code` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Sensor ID');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Threshold Value');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`env_monitoring` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission ID');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date (ACK_DT)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `acknowledgement_received` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Received (ACK_RCVD)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag (ATTACH_FLG)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category (COMP_CAT)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'environmental|safety|quality|financial|privacy');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count (DOC_CNT)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number (EXT_REF)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Submission Fee Amount (FEE_AMT)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential (CONF_FLG)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By (MOD_BY)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status (STATUS)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `regulatory_submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|acknowledged|rejected|approved|closed');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date (RPT_END)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date (RPT_START)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason (STATUS_RSN)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date (SUB_DT)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_description` SET TAGS ('dbx_business_glossary_term' = 'Submission Description (SUB_DESC)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method (SUB_METHOD)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal|email');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes (SUB_NOTES)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number (SUB_NUM)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type (SUB_TYPE)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'annual_report|incident_notification|permit_renewal|compliance_certificate|other');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submitter_role` SET TAGS ('dbx_business_glossary_term' = 'Submitter Role (SUBMIT_ROLE)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `submitter_role` SET TAGS ('dbx_value_regex' = 'contractor|subcontractor|project_manager|safety_officer|engineer');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_submission` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VER_NUM)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation ID');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_evidence_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence Status');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_evidence_status` SET TAGS ('dbx_value_regex' = 'submitted|approved|rejected|not_started');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt|under_review');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `data_classification` SET TAGS ('dbx_business_glossary_term' = 'Data Classification');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `data_classification` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence Required');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (Country/Region)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code (CODE)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `obligation_title` SET TAGS ('dbx_business_glossary_term' = 'Obligation Title');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount (USD)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency (ISO 4217)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|AUD');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Penalty Type');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `penalty_type` SET TAGS ('dbx_value_regex' = 'fine|stop_work|license_revocation|other');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `scope_business_units` SET TAGS ('dbx_business_glossary_term' = 'Scope Business Units');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment ID');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `package_id` SET TAGS ('dbx_business_glossary_term' = 'Package Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `phase_id` SET TAGS ('dbx_business_glossary_term' = 'Phase Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `assessment_code` SET TAGS ('dbx_business_glossary_term' = 'Assessment Code');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|approved|rejected');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'regulatory|internal|external|audit');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Full Name');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'environment|safety|quality|financial|privacy');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rating');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `compliance_rating` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|not_applicable');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `compliance_status_overall` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Status');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `compliance_status_overall` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `external_audit_firm` SET TAGS ('dbx_business_glossary_term' = 'External Audit Firm');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `gaps_identified` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gaps Identified');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Assessment Flag');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `is_external_audit` SET TAGS ('dbx_business_glossary_term' = 'External Audit Flag');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `last_reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed By ID');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `rating_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rating Score');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `recommended_actions` SET TAGS ('dbx_business_glossary_term' = 'Recommended Corrective Actions');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Assessment Scope Description');
ALTER TABLE `construction_ecm`.`compliance`.`assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`compliance`.`action` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `action_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Action ID');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `authority_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Authority Notice Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `document_register_id` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document ID');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `ncr_id` SET TAGS ('dbx_business_glossary_term' = 'Ncr Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Related Permit ID');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `work_front_id` SET TAGS ('dbx_business_glossary_term' = 'Work Front Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Action Number (ACT_NO)');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Action Type');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|improvement');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `closure_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Closure Evidence URL');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Action Comments');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `completed_date` SET TAGS ('dbx_business_glossary_term' = 'Action Completion Date');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `compliance_action_description` SET TAGS ('dbx_business_glossary_term' = 'Action Description');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `compliance_action_status` SET TAGS ('dbx_business_glossary_term' = 'Action Status');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `compliance_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|cancelled|deferred');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `compliance_area` SET TAGS ('dbx_business_glossary_term' = 'Compliance Area');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `compliance_area` SET TAGS ('dbx_value_regex' = 'safety|environment|quality|financial|legal|ethics');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `corrective_measure` SET TAGS ('dbx_business_glossary_term' = 'Corrective Measure');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Action Creation Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Action Due Date');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `external_authority_name` SET TAGS ('dbx_business_glossary_term' = 'External Authority Name');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `external_notice_date` SET TAGS ('dbx_business_glossary_term' = 'External Notice Date');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `is_external` SET TAGS ('dbx_business_glossary_term' = 'External Authority Indicator');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `is_repeat_action` SET TAGS ('dbx_business_glossary_term' = 'Repeat Action Indicator');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `mitigation_plan` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `monitoring_end_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring End Date');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `monitoring_required` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Required Indicator');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `monitoring_start_date` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Start Date');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Action Priority');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `repeat_action_count` SET TAGS ('dbx_business_glossary_term' = 'Repeat Action Count');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Action Last Updated Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Action Verification Date');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `authority_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Authority Notice ID');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID (PROJECT_ID)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `document_register_id` SET TAGS ('dbx_business_glossary_term' = 'Attached Document ID (DOC_ID)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `inspection_record_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Record Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Date (APPEAL_DT)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `appeal_lodged_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Lodged Flag (APPEAL_LODGED)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `authority_notice_status` SET TAGS ('dbx_business_glossary_term' = 'Notice Status (STATUS)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `authority_notice_status` SET TAGS ('dbx_value_regex' = 'open|closed|appealed|resolved|dismissed');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `authority_type` SET TAGS ('dbx_business_glossary_term' = 'Authority Type (AUTH_TYPE)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `authority_type` SET TAGS ('dbx_value_regex' = 'federal|state|local|private');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category (COMPLIANCE_CAT)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'safety|environment|building|financial');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `compliance_officer` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer (COMPLIANCE_OFFICER)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `notice_date` SET TAGS ('dbx_business_glossary_term' = 'Notice Date (NOTICE_DT)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `notice_number` SET TAGS ('dbx_business_glossary_term' = 'Notice Number (NOTICE_NO)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `notice_type` SET TAGS ('dbx_business_glossary_term' = 'Notice Type (NOTICE_TYPE)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `notice_type` SET TAGS ('dbx_value_regex' = 'infringement|improvement|prohibition|stop_work|directive');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount (PENALTY_AMT)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency (PENALTY_CURR)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `penalty_due_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Due Date (PENALTY_DUE)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `regulation_breached` SET TAGS ('dbx_business_glossary_term' = 'Regulation Breached (REG_BREACH)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `remediation_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required (REMEDIATION)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date (RES_DATE)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome (RES_OUTCOME)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'complied|non_complied|settled|dismissed');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Response Deadline (RESP_DEADLINE)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `response_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Date (RESP_SUBMIT_DT)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `response_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Submitted Flag (RESP_SUBMITTED)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (SEVERITY)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `construction_ecm`.`compliance`.`authority_notice` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description (VIOL_DESC)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `regulatory_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Identifier');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `abbreviation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Abbreviation');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Address');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Classification');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'regulatory|environmental|safety|building|utility');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Compliance Status');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|not_applicable');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_person` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Contact Person');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Contact Role');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `contact_role` SET TAGS ('dbx_value_regex' = 'director|manager|officer|coordinator|representative');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Email Address');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope (Coverage)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|national|state|city|county');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `is_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Authority Indicator');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Type (Level)');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_value_regex' = 'federal|state|local|regional|international');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `last_contact_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Notes');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Phone Number');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `portal_url` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Portal URL');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `regulatory_authority_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `regulatory_authority_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Status');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `regulatory_authority_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `regulatory_frameworks` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Frameworks');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `relationship_owner` SET TAGS ('dbx_business_glossary_term' = 'Internal Relationship Owner');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `relationship_owner` SET TAGS ('dbx_value_regex' = 'compliance|legal|procurement|project_management|safety');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `submission_system` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Submission System');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`regulatory_authority` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Website URL');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` SET TAGS ('dbx_subdomain' = 'permit_management');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `compliance_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Calendar Entry ID');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `authority_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Authority Notice Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Project Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `parent_compliance_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `regulatory_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `compliance_calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Entry Status');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `compliance_calendar_status` SET TAGS ('dbx_value_regex' = 'pending|completed|overdue|cancelled');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'safety|environment|quality|financial|privacy|security');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Deadline Date');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `deadline_type` SET TAGS ('dbx_business_glossary_term' = 'Deadline Type (e.g., Permit, Certification, Audit, Report, Inspection, Training)');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `deadline_type` SET TAGS ('dbx_value_regex' = 'permit|certification|audit|report|inspection|training');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `entry_code` SET TAGS ('dbx_business_glossary_term' = 'Calendar Entry Code');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `escalation_path` SET TAGS ('dbx_business_glossary_term' = 'Escalation Path Description');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `escalation_triggered_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Triggered Flag');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `escalation_triggered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Triggered Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `overdue_flag` SET TAGS ('dbx_business_glossary_term' = 'Overdue Flag');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Name');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `reminder_lead_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Lead Time (Days)');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `reminder_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Reminder Sent Flag');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `reminder_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reminder Sent Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `source_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Obligation or Permit Reference');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Calendar Entry Title');
ALTER TABLE `construction_ecm`.`compliance`.`compliance_calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` SET TAGS ('dbx_subdomain' = 'regulatory_obligations');
ALTER TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` SET TAGS ('dbx_association_edges' = 'compliance.assessment,compliance.regulatory_obligation');
ALTER TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` ALTER COLUMN `obligation_assessment_result_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Assessment Result - Obligation Assessment Result Id');
ALTER TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Assessment Result - Assessment Id');
ALTER TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Assessment Result - Regulatory Obligation Id');
ALTER TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` ALTER COLUMN `compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Per-Obligation Compliance Rating');
ALTER TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` ALTER COLUMN `evaluated_date` SET TAGS ('dbx_business_glossary_term' = 'Obligation Evaluation Date');
ALTER TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` ALTER COLUMN `findings` SET TAGS ('dbx_business_glossary_term' = 'Per-Obligation Findings');
ALTER TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` ALTER COLUMN `gap_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Gap Status');
ALTER TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` ALTER COLUMN `obligations_assessed` SET TAGS ('dbx_business_glossary_term' = 'Obligations Assessed');
ALTER TABLE `construction_ecm`.`compliance`.`obligation_assessment_result` ALTER COLUMN `remediation_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
