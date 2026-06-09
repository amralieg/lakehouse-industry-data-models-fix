-- Schema for Domain: aid | Business: Education | Version: v1_mvm
-- Generated on: 2026-05-06 15:13:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`aid` COMMENT 'Administers federal, state, institutional, and private financial aid programs including FAFSA processing, EFC calculations, COA determination, award packaging, disbursements, SAP monitoring, and Title IV compliance. Tracks scholarships, grants, loans, work-study, and veteran benefits. SSOT for student financial aid eligibility, award history, and R2T4 calculations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`aid`.`aid_application` (
    `aid_application_id` BIGINT COMMENT 'Unique identifier for the financial aid application record. Primary key for the aid application entity.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Aid applications require program context for eligibility determination—program-specific aid rules (STEM grants, nursing scholarships), COA variations by program, and enrollment intensity validation al',
    `award_package_id` BIGINT COMMENT 'Foreign key linking to aid.award_package. Business justification: An aid application results in the creation of an award package. This is a 1:1 or 1:0..1 relationship (application may not result in package if student is ineligible). The aid_application should refere',
    `award_year_id` BIGINT COMMENT 'Identifier of the academic award year for which the student is applying for financial aid (e.g., 2023-2024). Links to the award year reference table.',
    `coa_budget_id` BIGINT COMMENT 'Foreign key linking to aid.coa_budget. Business justification: aid_application carries a coa_amount field representing the Cost of Attendance used for the students financial need calculation. This COA is derived from a specific coa_budget template. Adding coa_bu',
    `employee_id` BIGINT COMMENT 'Identifier of the financial aid staff member or system user who last updated the application record. Used for audit and accountability purposes.',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to faculty.instructor. Business justification: Graduate financial aid processing requires the faculty advisors confirmation of research enrollment and dissertation status. The faculty advisor is a distinct role from the aid counselor (employee_id',
    `isir_record_id` BIGINT COMMENT 'Foreign key linking to aid.isir_record. Business justification: The aid_application is based on a specific ISIR (Institutional Student Information Record) received from CPS. Currently aid_application has isir_transaction_number as a STRING, but should FK to the is',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student submitting the financial aid application. Links to the student master record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Title IV applications must track governing federal regulations (HEA sections, 34 CFR parts) that define eligibility criteria, EFC calculation methodology, and verification requirements. Essential for ',
    `building_id` BIGINT COMMENT 'Foreign key linking to facility.building. Business justification: Financial aid COA budgets vary by housing type (on-campus residence hall vs off-campus). Aid applications capture housing_plan_code but need actual residence building for verification, COA calculation',
    `residency_classification_id` BIGINT COMMENT 'Foreign key linking to student.residency_classification. Business justification: Residency classification determines in-state vs out-of-state tuition rates, directly driving the COA calculation on the aid application. FA offices must reference the official residency determination ',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Aid applications must reference student billing accounts to verify enrollment charges exist, coordinate aid packaging with account balances, and ensure disbursements post correctly. Core operational d',
    `verification_id` BIGINT COMMENT 'Foreign key linking to aid.verification. Business justification: Students selected for federal verification have a verification record that tracks the process. The aid_application should FK to the verification record. Columns verification_selection_flag, verificati',
    `visa_immigration_id` BIGINT COMMENT 'Foreign key linking to student.visa_immigration. Business justification: Visa/immigration status is a direct Title IV eligibility criterion — only eligible non-citizens qualify for federal aid. FA offices must reference the official visa_immigration record for citizenship ',
    `aggregate_loan_limit_flag` BOOLEAN COMMENT 'Indicates whether the student has reached or exceeded federal aggregate loan limits for subsidized and unsubsidized Direct Loans. When true, student cannot borrow additional federal loans.',
    `application_number` STRING COMMENT 'Business identifier for the financial aid application, often used for external reference and student communication.',
    `application_status` STRING COMMENT 'Current processing status of the financial aid application in the institutional workflow. [ENUM-REF-CANDIDATE: submitted|under_review|verified|packaged|awarded|cancelled|incomplete — 7 candidates stripped; promote to reference product]',
    `c_code_flag` STRING COMMENT 'Federal comment codes from the ISIR indicating issues that must be resolved before aid can be disbursed (e.g., conflicting information, missing signatures, data mismatches).',
    `coa_amount` DECIMAL(18,2) COMMENT 'Total Cost of Attendance budget assigned to this application. Includes tuition, fees, room, board, books, supplies, transportation, and personal expenses. Used to calculate financial need.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the aid application record was first created in the Student Information System.',
    `default_overpayment_flag` BOOLEAN COMMENT 'Indicates whether the student is in default on a federal student loan or owes an overpayment on a federal grant. Students with this flag are ineligible for Title IV aid until resolved.',
    `direct_loan_eligible_flag` BOOLEAN COMMENT 'Indicates whether the student is eligible for Federal Direct Loans (subsidized and/or unsubsidized) based on enrollment, citizenship, and loan limit checks.',
    `drug_conviction_flag` BOOLEAN COMMENT 'Indicates whether the student has a federal or state drug conviction that affects Title IV aid eligibility during the period of enrollment.',
    `enrollment_intensity` STRING COMMENT 'Expected enrollment intensity for the award year. Determines eligibility for certain aid programs and affects disbursement amounts.. Valid values are `full_time|three_quarter_time|half_time|less_than_half_time`',
    `fafsa_receipt_date` DATE COMMENT 'Date the institution received the students FAFSA data from the federal processor. Critical for priority deadline determination and aid packaging sequencing.',
    `financial_need_amount` DECIMAL(18,2) COMMENT 'Calculated financial need for the application. Computed as Cost of Attendance minus Expected Family Contribution (or Student Aid Index). Determines eligibility for need-based aid.',
    `housing_plan_code` STRING COMMENT 'Students planned housing arrangement for the award year. Affects Cost of Attendance (COA) calculation as different housing plans have different budget allowances.. Valid values are `on_campus|off_campus|with_parents`',
    `institutional_methodology_efc` DECIMAL(18,2) COMMENT 'Expected Family Contribution calculated using the institutions own methodology (e.g., CSS Profile). Used for awarding institutional need-based aid, separate from federal methodology.',
    `pell_eligible_flag` BOOLEAN COMMENT 'Indicates whether the student is eligible for a Federal Pell Grant based on EFC/SAI and enrollment status.',
    `pell_leu_percentage` DECIMAL(18,2) COMMENT 'Percentage of the students lifetime Pell Grant eligibility used. Students are limited to 600% (equivalent to six years of full-time enrollment). Tracked cumulatively across all institutions.',
    `professional_judgment_flag` BOOLEAN COMMENT 'Indicates whether a financial aid administrator exercised professional judgment to adjust the students EFC/SAI or dependency status based on special circumstances.',
    `professional_judgment_reason` STRING COMMENT 'Documented reason for professional judgment adjustment, such as loss of employment, medical expenses, or dependency override.',
    `selective_service_compliance_flag` BOOLEAN COMMENT 'Indicates whether male students aged 18-25 have registered with Selective Service as required for Title IV aid eligibility.',
    `state_aid_eligible_flag` BOOLEAN COMMENT 'Indicates whether the student is eligible for state-funded financial aid programs based on residency and state-specific requirements.',
    `submitted_date` TIMESTAMP COMMENT 'Timestamp when the student initially submitted the financial aid application to the institution.',
    `unusual_enrollment_history_flag` BOOLEAN COMMENT 'Federal flag indicating the student has an unusual enrollment history pattern (attending multiple institutions in a short period). Requires additional documentation before aid can be disbursed.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the aid application record was last modified. Used for audit trail and data synchronization.',
    `veteran_benefits_flag` BOOLEAN COMMENT 'Indicates whether the student is receiving or eligible for veteran education benefits (e.g., GI Bill, Yellow Ribbon Program). Affects coordination of benefits and COA adjustments.',
    CONSTRAINT pk_aid_application PRIMARY KEY(`aid_application_id`)
) COMMENT 'Master record of a students financial aid application for a specific award year. Captures FAFSA receipt date, dependency status, verification selection flag, EFC/SAI, housing plans, enrollment intensity, citizenship status, SAP status, and application processing stage. Includes Title IV eligibility indicators (selective service, default/overpayment clearance, aggregate loan limits, Pell LEU). SSOT for a students aid eligibility determination and federal eligibility gating for a given award year.';

CREATE OR REPLACE TABLE `education_ecm`.`aid`.`award_package` (
    `award_package_id` BIGINT COMMENT 'Unique identifier for the financial aid award package. Primary key.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Award packaging methodology varies by program—professional programs have different COA structures, program-specific scholarship pools require program identification, and packaging rules often differen',
    `award_year_id` BIGINT COMMENT 'Identifier of the award year for which this package is assembled.',
    `coa_budget_id` BIGINT COMMENT 'Reference to the COA budget used for this award package, defining the total allowable cost for the student.',
    `employee_id` BIGINT COMMENT 'Identifier of the financial aid counselor who assembled this award package.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Award packaging is governed by institutional aid policies (packaging methodology, professional judgment, coordination of aid). Financial aid directors reference specific policy documents when assembli',
    `profile_id` BIGINT COMMENT 'Identifier of the student receiving this award package.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Award packages must comply with federal methodology requirements (34 CFR 668.2 for COA, Pell LEU limits, aggregate loan caps). Tracking regulatory basis ensures packaging decisions are defensible duri',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Award packages reduce billing obligations and appear as anticipated aid on statements. Financial aid officers review account status during packaging; billing systems need award totals to calculate net',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this award package record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this package (typically USD for U.S. institutions).. Valid values are `^[A-Z]{3}$`',
    `default_status_flag` BOOLEAN COMMENT 'Indicates whether the student is in default on any federal student loans, affecting eligibility for additional aid.',
    `demonstrated_need_amount` DECIMAL(18,2) COMMENT 'Calculated financial need for the student, typically COA minus EFC, representing the gap to be filled by aid.',
    `dependency_status` STRING COMMENT 'Student dependency status as determined by FAFSA, affecting eligibility for certain aid types.. Valid values are `dependent|independent`',
    `efc_amount` DECIMAL(18,2) COMMENT 'Expected Family Contribution calculated from FAFSA data, representing the amount the family is expected to contribute toward educational costs.',
    `enrollment_status` STRING COMMENT 'Student enrollment intensity at the time of packaging, affecting aid eligibility and amounts.. Valid values are `full_time|three_quarter_time|half_time|less_than_half_time`',
    `housing_status` STRING COMMENT 'Student housing arrangement used to determine the appropriate COA budget.. Valid values are `on_campus|off_campus|with_parents`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this award package record was last modified.',
    `last_revision_date` DATE COMMENT 'Date of the most recent revision to this award package.',
    `notes` STRING COMMENT 'Free-text notes or comments about this award package, used for internal documentation and communication among financial aid staff.',
    `offer_letter_sent_date` DATE COMMENT 'Date on which the award offer letter was sent to the student.',
    `overaward_amount` DECIMAL(18,2) COMMENT 'Amount by which total awarded aid exceeds the COA or regulatory limits, requiring resolution to maintain Title IV compliance.',
    `overaward_detected_flag` BOOLEAN COMMENT 'Indicates whether an overaward condition has been detected for this package.',
    `overaward_resolution_date` DATE COMMENT 'Date on which the overaward was resolved or waived.',
    `overaward_resolution_status` STRING COMMENT 'Current status of overaward resolution efforts, tracking whether the overaward has been addressed.. Valid values are `none|pending|resolved|waived`',
    `package_number` STRING COMMENT 'Business identifier for the award package, typically used in communications and reporting.',
    `package_status` STRING COMMENT 'Current lifecycle status of the award package indicating its stage in the financial aid workflow.. Valid values are `proposed|accepted|revised|cancelled|disbursed|completed`',
    `packaging_date` DATE COMMENT 'Date on which the award package was initially assembled and packaged by the financial aid office.',
    `packaging_methodology` STRING COMMENT 'The methodology or strategy used to assemble this award package, indicating the basis for aid allocation.. Valid values are `need_based|merit_based|hybrid|athletic|departmental|external`',
    `pell_eligible_flag` BOOLEAN COMMENT 'Indicates whether the student is eligible for Federal Pell Grant based on EFC and enrollment.',
    `pell_lifetime_eligibility_used_percent` DECIMAL(18,2) COMMENT 'Percentage of lifetime Pell Grant eligibility the student has used, capped at 600 percent (equivalent to 6 years).',
    `professional_judgment_applied_flag` BOOLEAN COMMENT 'Indicates whether professional judgment was exercised to adjust the EFC or COA for this student.',
    `professional_judgment_reason` STRING COMMENT 'Explanation of the circumstances that warranted professional judgment adjustment.',
    `revision_number` STRING COMMENT 'Sequential number indicating how many times this award package has been revised.',
    `revision_reason` STRING COMMENT 'Explanation for the most recent revision to the award package, such as change in enrollment status, additional aid received, or correction.',
    `sap_status` STRING COMMENT 'Student Satisfactory Academic Progress status at the time of packaging, required for continued Title IV eligibility.. Valid values are `meeting|warning|suspension|probation|appeal_approved`',
    `student_acceptance_date` DATE COMMENT 'Date on which the student accepted the award package or specific awards within it.',
    `total_awarded_amount` DECIMAL(18,2) COMMENT 'Total amount of financial aid awarded in this package across all aid types (grants, loans, scholarships, work-study).',
    `total_coa_amount` DECIMAL(18,2) COMMENT 'Total cost of attendance amount for the student for this award year, including tuition, fees, room, board, books, and other allowable expenses.',
    `total_grant_amount` DECIMAL(18,2) COMMENT 'Total amount of grant aid (gift aid that does not require repayment) included in this package.',
    `total_loan_amount` DECIMAL(18,2) COMMENT 'Total amount of loan aid (funds requiring repayment) included in this package.',
    `total_scholarship_amount` DECIMAL(18,2) COMMENT 'Total amount of scholarship aid (merit or need-based gift aid) included in this package.',
    `total_work_study_amount` DECIMAL(18,2) COMMENT 'Total amount of work-study aid (earned through part-time employment) included in this package.',
    `unmet_need_amount` DECIMAL(18,2) COMMENT 'Remaining financial need after all awarded aid is applied, representing the gap the student must cover through other means.',
    `verification_completion_date` DATE COMMENT 'Date on which FAFSA verification was completed for this award package.',
    `verification_status` STRING COMMENT 'Status of FAFSA verification process for this student and award year, required for Title IV compliance.. Valid values are `not_selected|selected|in_progress|completed|waived`',
    CONSTRAINT pk_award_package PRIMARY KEY(`award_package_id`)
) COMMENT 'Represents the complete financial aid award package assembled for a student for a specific award year. Tracks total awarded amount, packaging methodology, COA budget reference, unmet need, overaward detection and resolution status, packaging date, counselor, and package status (proposed, accepted, revised, cancelled). SSOT for a students aggregate aid offer and overaward management.';

CREATE OR REPLACE TABLE `education_ecm`.`aid`.`aid_award` (
    `aid_award_id` BIGINT COMMENT 'Primary key for award',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Individual awards frequently have program restrictions—major-specific scholarships (e.g., Computer Science Excellence Award), program-level endowments, and accreditation-driven awards all require dire',
    `aid_fund_id` BIGINT COMMENT 'Unique identifier of the financial aid fund being awarded (e.g., Pell Grant, Direct Subsidized Loan, institutional merit scholarship). Links to the fund master record.',
    `award_package_id` BIGINT COMMENT 'Foreign key linking to aid.award_package. Business justification: Individual awards are components of an award package. This is a standard parent-child relationship (one package contains many awards). The award table should FK to award_package. No columns to remove ',
    `award_year_id` BIGINT COMMENT 'Foreign key linking to aid.award_year. Business justification: aid_award has an aid_year STRING column but no FK to the award_year master reference table. Every individual award is tied to a specific award year for federal reporting, packaging, and disbursement e',
    `coa_budget_id` BIGINT COMMENT 'Unique identifier of the Cost of Attendance (COA) budget used to determine eligibility for this award. Links to the COA master record.',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: Departmental scholarships and work-study awards frequently require enrollment in specific course sections (e.g., Chemistry Lab Assistant Award requires enrollment in CHEM 301L, Music Performance Sc',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student receiving this financial aid award. Links to the student master record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each Title IV award type (Pell, FSEOG, Direct Loan) is governed by specific HEA sections and CFR parts defining eligibility, award limits, and disbursement rules. Required for COD reporting and compli',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Graduate research assistantship stipends and tuition waivers funded by sponsored grants require linking the aid award to the originating research award for Title IV coordination, overaward detection, ',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Individual awards post as anticipated aid credits on billing statements, reducing amounts due. Required for statement generation, payment processing, account holds management, and reconciliation betwe',
    `term_id` BIGINT COMMENT 'Unique identifier of the academic term or period for which this award applies (e.g., Fall 2023, Spring 2024, Academic Year 2023-2024). Links to the academic period master record.',
    `acceptance_date` DATE COMMENT 'The date on which the student accepted this award. Null if the award has not been accepted or was declined.',
    `accepted_amount` DECIMAL(18,2) COMMENT 'The dollar amount the student has accepted for this award. May be less than or equal to the offered amount. Null if award has not been accepted.',
    `award_number` STRING COMMENT 'Business identifier for this award within the students aid package. Human-readable reference number used in communications and reporting.',
    `award_status` STRING COMMENT 'Current lifecycle status of the award. Tracks progression from initial offer through acceptance, disbursement, or cancellation. [ENUM-REF-CANDIDATE: offered|accepted|declined|cancelled|revised|disbursed|completed — 7 candidates stripped; promote to reference product]',
    `cancellation_date` DATE COMMENT 'The date on which this award was cancelled or revoked. Null if the award has not been cancelled.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why this award was cancelled. Common reasons include enrollment changes, SAP failure, over-award corrections, student withdrawal, or fund exhaustion.',
    `cancelled_amount` DECIMAL(18,2) COMMENT 'The dollar amount of this award that has been cancelled or revoked. Used when awards are reduced or eliminated after initial offer.',
    `comments` STRING COMMENT 'Free-text field for additional notes, special conditions, or administrative comments about this award. Used for internal documentation and communication.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this award record was first created in the system. Audit trail for record creation.',
    `disbursed_amount` DECIMAL(18,2) COMMENT 'The cumulative dollar amount that has been disbursed to the student or applied to their account to date for this award. Tracks actual funds distributed.',
    `efc_amount` DECIMAL(18,2) COMMENT 'The Expected Family Contribution (EFC) amount calculated from the students FAFSA (Free Application for Federal Student Aid) at the time this award was packaged. Used to determine need-based aid eligibility.',
    `enrollment_status_requirement` STRING COMMENT 'Minimum enrollment intensity required to receive or maintain this award. Based on credit hour thresholds defined by the institution and federal regulations.. Valid values are `full_time|three_quarter_time|half_time|less_than_half_time|any`',
    `federal_fund_code` STRING COMMENT 'Federal reporting code for Title IV funds as defined by the U.S. Department of Education. Used for FISAP, COD, and other federal reporting. Null for non-federal funds.',
    `first_disbursement_date` DATE COMMENT 'The date of the first disbursement for this award. Null if no disbursements have occurred yet.',
    `interest_rate` DECIMAL(18,2) COMMENT 'For loan awards, the annual interest rate as a decimal (e.g., 0.045 for 4.5%). Null for non-loan awards.',
    `last_disbursement_date` DATE COMMENT 'The date of the most recent disbursement for this award. Null if no disbursements have occurred yet.',
    `loan_period_begin_date` DATE COMMENT 'For loan awards, the start date of the loan period. Defines the enrollment period covered by the loan. Null for non-loan awards.',
    `loan_period_end_date` DATE COMMENT 'For loan awards, the end date of the loan period. Defines the enrollment period covered by the loan. Null for non-loan awards.',
    `need_based_flag` BOOLEAN COMMENT 'Indicates whether this award is need-based (true) or merit-based (false). Need-based awards require demonstrated financial need via FAFSA (Free Application for Federal Student Aid) or institutional methodology.',
    `offer_date` DATE COMMENT 'The date on which this award was officially offered to the student. Marks the beginning of the award lifecycle.',
    `offered_amount` DECIMAL(18,2) COMMENT 'The total dollar amount initially offered to the student for this award. Represents the maximum potential award before student acceptance or adjustments.',
    `origination_fee_amount` DECIMAL(18,2) COMMENT 'For loan awards, the dollar amount of the origination fee deducted by the lender or federal government. Null for non-loan awards.',
    `packaging_group` STRING COMMENT 'Classification code used to group students for aid packaging purposes (e.g., freshman, transfer, graduate, athlete). Determines packaging rules and fund priority.',
    `priority` STRING COMMENT 'Numeric ranking indicating the order in which this award should be applied within the students aid package. Lower numbers indicate higher priority.',
    `remaining_amount` DECIMAL(18,2) COMMENT 'The dollar amount remaining to be disbursed for this award. Calculated as accepted amount minus disbursed amount.',
    `renewable_flag` BOOLEAN COMMENT 'Indicates whether this award is renewable for subsequent academic years if eligibility criteria continue to be met. True for multi-year scholarships and grants.',
    `revision_number` STRING COMMENT 'Sequential counter tracking the number of times this award has been revised or adjusted. Starts at 0 for original award, increments with each change.',
    `sap_requirement_flag` BOOLEAN COMMENT 'Indicates whether this award requires the student to maintain Satisfactory Academic Progress (SAP) as defined by federal Title IV regulations and institutional policy. True if SAP compliance is mandatory.',
    `self_help_flag` BOOLEAN COMMENT 'Indicates whether this award is classified as self-help aid (loans and work-study) as opposed to gift aid (grants and scholarships). Used for packaging and reporting.',
    `subsidized_flag` BOOLEAN COMMENT 'For loan awards, indicates whether the loan is subsidized (true) or unsubsidized (false). Subsidized loans do not accrue interest while the student is enrolled. Null for non-loan awards.',
    `updated_by_user` STRING COMMENT 'Username or identifier of the system user or process that last modified this award record. Audit trail for accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this award record was last modified. Audit trail for record changes.',
    CONSTRAINT pk_aid_award PRIMARY KEY(`aid_award_id`)
) COMMENT 'Individual financial aid award record within a students package, representing a single fund allocation (e.g., Pell Grant, Direct Subsidized Loan, institutional merit scholarship, Federal Work-Study). Tracks fund reference, award amount, accepted amount, disbursed-to-date amount, award status (offered, accepted, declined, cancelled, revised), academic period, enrollment intensity requirement, and SAP eligibility requirement. Supports both need-based and merit-based awards across all fund types (grants, loans, scholarships, work-study). SSOT for individual award decisions and amounts.';

CREATE OR REPLACE TABLE `education_ecm`.`aid`.`disbursement` (
    `disbursement_id` BIGINT COMMENT 'Unique identifier for the financial aid disbursement record. Primary key. Inferred role: TRANSACTION_HEADER.',
    `aid_award_id` BIGINT COMMENT 'Reference to the financial aid award that this disbursement is paying out. Links to the award package that authorized this disbursement.',
    `aid_fund_id` BIGINT COMMENT 'Reference to the fund source providing the disbursement (federal, state, institutional, private). Identifies the origin of the funds.',
    `award_year_id` BIGINT COMMENT 'Reference to the financial aid year for which this disbursement applies. Typically spans July 1 to June 30.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Title IV disbursements must be traced to specific institutional bank accounts for cash management, bank reconciliation, and ED compliance (cash management regulations 34 CFR 668.162). The denormalized',
    `employee_id` BIGINT COMMENT 'The user ID of the financial aid staff member who authorized this disbursement. Used for audit trail and accountability.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Financial aid disbursements must be posted to the correct GL fiscal period for year-end close, Title IV reconciliation, and IPEDS reporting. A higher-ed financial aid director expects every disburseme',
    `hold_id` BIGINT COMMENT 'Foreign key linking to student.hold. Business justification: Student holds directly block Title IV disbursements. The disbursement record must reference the specific hold that triggered a disbursement block — required for FA counselor workflow (hold resolution ',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Each aid disbursement generates a journal entry (debit student AR, credit cash/loan liability). Essential for GL reconciliation, cash management, and audit trail. Standard integration between student ',
    `attendance_record_id` BIGINT COMMENT 'Foreign key linking to instruction.attendance_record. Business justification: R2T4 (Return to Title IV, 34 CFR 668.22) requires the Last Date of Attendance (LDA) to calculate unearned aid. Disbursement must reference the specific attendance_record establishing LDA used in R2T4 ',
    `leave_of_absence_id` BIGINT COMMENT 'Foreign key linking to student.leave_of_absence. Business justification: Student LOA directly triggers Title IV disbursement review, cancellation, or R2T4 calculation. The disbursement record must reference the LOA that caused a hold or cancellation — a named federal regul',
    `loan_record_id` BIGINT COMMENT 'Foreign key linking to aid.loan_record. Business justification: For loan disbursements, the disbursement record should optionally reference the loan_record for loan-specific tracking (COD reporting, NSLDS reporting, servicer information). This is in addition to th',
    `profile_id` BIGINT COMMENT 'Reference to the student receiving the disbursement. The counterparty in this financial transaction.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Title IV disbursements are reported to COD (Common Origination and Disbursement) as regulatory filings. disbursement.cod_reporting_flag, cod_reporting_date, and nslds_reporting_flag confirm this named',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Disbursements must comply with Title IV timing regulations (34 CFR 668.164), enrollment status verification, and SAP requirements. Tracking regulatory basis is critical for COD reporting accuracy and ',
    `statement_id` BIGINT COMMENT 'Foreign key linking to billing.statement. Business justification: Aid disbursements are posted as credits on billing statements (statement.financial_aid_disbursed, loan_disbursement fields confirm this). Financial aid offices must reconcile each disbursement to the ',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Disbursements credit student accounts, reducing billing balances. This is the core transaction linking aid delivery to account management. Essential for daily reconciliation, refund processing, accoun',
    `term_id` BIGINT COMMENT 'Reference to the academic term for which this disbursement is being made. Disbursements are typically term-specific.',
    `amount` DECIMAL(18,2) COMMENT 'The gross amount of funds disbursed to the student or credited to the student account. Represents the actual fund movement.',
    `anticipated_disbursement_flag` BOOLEAN COMMENT 'Indicates whether this disbursement was made in anticipation of future enrollment. Used for early disbursements before term start.',
    `authorization_date` DATE COMMENT 'The date on which the disbursement was authorized by the financial aid office. Precedes the actual disbursement date.',
    `channel` STRING COMMENT 'The system or channel through which the disbursement was processed. Distinguishes internal vs external payment channels.. Valid values are `student_account_system|bank_transfer|third_party_servicer|refund_processor`',
    `coa_amount` DECIMAL(18,2) COMMENT 'The Cost of Attendance used for this disbursement calculation. Represents the maximum aid the student can receive.',
    `cod_reporting_date` DATE COMMENT 'The date on which this disbursement was reported to the federal COD system. Used for compliance tracking.',
    `cod_reporting_flag` BOOLEAN COMMENT 'Indicates whether this disbursement has been reported to the federal COD system. Required for all Title IV disbursements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this disbursement record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the disbursement. Typically USD for U.S. institutions.. Valid values are `USD`',
    `disbursement_date` DATE COMMENT 'The date on which the disbursement was actually released to the student account or paid to the student. Principal business event timestamp for this transaction.',
    `disbursement_method` STRING COMMENT 'The method by which funds were disbursed. Indicates whether funds were credited to student account, sent via EFT, issued as check, or direct deposited.. Valid values are `credit_to_account|electronic_funds_transfer|paper_check|direct_deposit`',
    `disbursement_number` STRING COMMENT 'Business identifier for the disbursement. Human-readable reference number used in communications and reconciliation.',
    `disbursement_status` STRING COMMENT 'Current lifecycle status of the disbursement. Tracks the disbursement through approval, release, and potential return workflows.. Valid values are `pending|approved|released|cancelled|returned|adjusted`',
    `efc_amount` DECIMAL(18,2) COMMENT 'The Expected Family Contribution calculated from FAFSA at the time of disbursement. Used to determine need-based aid eligibility.',
    `hold_flag` BOOLEAN COMMENT 'Indicates whether a hold was placed on this disbursement preventing release. Holds may be due to verification, SAP, or other compliance issues.',
    `hold_release_date` DATE COMMENT 'The date on which any disbursement hold was released, allowing the disbursement to proceed.',
    `late_disbursement_flag` BOOLEAN COMMENT 'Indicates whether this disbursement was made after the normal disbursement window. Requires special processing and documentation.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this disbursement record was last modified. Used for audit trail and change tracking.',
    `net_disbursement_amount` DECIMAL(18,2) COMMENT 'The net amount received by the student after deductions for fees, charges, or institutional holds. May differ from gross disbursement amount.',
    `notes` STRING COMMENT 'Free-text notes regarding special circumstances, processing exceptions, or additional context for this disbursement.',
    `nslds_reporting_flag` BOOLEAN COMMENT 'Indicates whether this disbursement has been reported to NSLDS. Required for federal loan and grant tracking.',
    `origination_fee_amount` DECIMAL(18,2) COMMENT 'Federal loan origination fee deducted from the disbursement. Applicable to Direct Loans and other federal loan programs.',
    `payment_reference_number` STRING COMMENT 'External reference number from the payment processor or bank. Used for reconciliation with financial systems.',
    `period_begin_date` DATE COMMENT 'The start date of the enrollment period covered by this disbursement. Defines the academic period for which aid is being disbursed.',
    `period_end_date` DATE COMMENT 'The end date of the enrollment period covered by this disbursement. Defines the academic period for which aid is being disbursed.',
    `sap_status_at_disbursement` STRING COMMENT 'The students SAP status at the time of disbursement. Students must meet SAP standards to receive Title IV aid.. Valid values are `meeting|warning|suspension|probation`',
    `scheduled_disbursement_date` DATE COMMENT 'The originally planned date for the disbursement. May differ from actual disbursement date due to holds, eligibility changes, or processing delays.',
    `sequence` STRING COMMENT 'Sequential number indicating which disbursement this is for the award (1st, 2nd, 3rd, etc.). Used for multi-disbursement awards.',
    `source_system_code` STRING COMMENT 'Code identifying the source system from which this disbursement record originated. Used for data lineage in multi-system environments.. Valid values are `BANNER|WORKDAY|PEOPLESOFT|MANUAL`',
    `title_iv_eligible_flag` BOOLEAN COMMENT 'Indicates whether the student met all Title IV eligibility requirements at the time of disbursement. Required for federal aid compliance.',
    CONSTRAINT pk_disbursement PRIMARY KEY(`disbursement_id`)
) COMMENT 'Records each actual disbursement of financial aid funds to a students account or directly to the student, including disbursement date, disbursement amount, fund source, disbursement method (credit to student account, EFT, check), disbursement sequence number, period of enrollment covered, Title IV eligibility confirmation flag, and disbursement status. SSOT for actual fund movement. Sourced from Ellucian Banner Disbursement module.';

CREATE OR REPLACE TABLE `education_ecm`.`aid`.`aid_fund` (
    `aid_fund_id` BIGINT COMMENT 'Primary key for fund',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Institutional and endowed aid funds are routinely restricted to students in specific academic programs (e.g., College of Engineering scholarship fund). Financial aid packaging, fund allocation reporti',
    `award_year_id` BIGINT COMMENT 'Foreign key linking to aid.award_year. Business justification: aid_fund has an award_year STRING column but no FK to the award_year master table. Federal and institutional fund allocations (Pell, SEOG, Direct Loan, etc.) are authorized and tracked per award year.',
    `cip_code_id` BIGINT COMMENT 'Foreign key linking to curriculum.cip_code. Business justification: Federal and state aid funds (e.g., TEACH Grant, HRSA nursing grants) carry CIP-code-based field-of-study restrictions per 34 CFR regulations. Fund eligibility determination and compliance reporting re',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Institutional aid funds are administered by specific academic or administrative cost centers. Budget managers need this link for departmental aid fund allocation reporting, annual budget planning, and',
    `donor_id` BIGINT COMMENT 'Foreign key linking to advancement.donor. Business justification: Non-endowed donor-restricted aid funds are established by donors and require direct donor linkage for gift restriction compliance, stewardship reporting, and NACUBO fund administration. The endowment ',
    `endowment_id` BIGINT COMMENT 'Foreign key linking to advancement.endowment. Business justification: Aid funds are often endowed by donors. Financial aid offices must track endowment performance, spending policy compliance, and stewardship reporting requirements. The endowment_principal_amount column',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Every aid fund (Pell, institutional grant, work-study) maps to a finance fund in the GL for budget control and fund balance reporting. Higher-ed controllers require this link to reconcile aid fund exp',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Financial aid funds must map to specific GL accounts for revenue recognition, expense tracking, and GASB/FASB financial reporting. Every aid fund posts to a designated ledger account—this is foundatio',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Federal aid funds require annual regulatory filings: FISAP for campus-based funds (Perkins, SEOG, FWS), G5 drawdown reporting, and CFDA-specific reports. aid_fund.cfda_number and regulatory_program_co',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Federal aid funds are defined by regulatory requirements (CFDA numbers, HEA authorizing sections, program-specific CFR parts). Essential for fund setup, allocation management, and demonstrating regula',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: Federal training grants (NIH T32, NSF GRFP) and sponsored fellowships create aid funds directly sourced from a research award. Linking aid_fund to research_award enables compliance reporting to sponso',
    `academic_level_requirement` STRING COMMENT 'The academic level(s) of students eligible for this fund. Federal Pell Grants are undergraduate-only, while some institutional funds may be graduate-only or open to all levels.. Valid values are `undergraduate|graduate|professional|doctoral|any`',
    `annual_allocation_amount` DECIMAL(18,2) COMMENT 'The total dollar amount allocated to this fund for the current award year. For federal funds, this represents the institutional allocation from the Department of Education. For institutional funds, this is the budgeted amount.',
    `cfda_number` STRING COMMENT 'The five-digit CFDA number assigned to federal financial aid programs for tracking and reporting purposes (e.g., 84.063 for Federal Pell Grant, 84.268 for Federal Direct Loan). Applicable only to federal funds.. Valid values are `^[0-9]{2}.[0-9]{3}$`',
    `citizenship_requirement` STRING COMMENT 'The citizenship or residency status required for eligibility. Federal Title IV aid requires U.S. citizenship or eligible non-citizen status. Some institutional funds may be open to international students.. Valid values are `us_citizen|eligible_noncitizen|permanent_resident|international|any`',
    `coa_component_restriction` STRING COMMENT 'Specifies if this fund can only be applied to specific components of the students Cost of Attendance (e.g., tuition and fees only, room and board only, books and supplies). Null if no restriction exists.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this fund record was first created in the system.',
    `disbursement_frequency` STRING COMMENT 'The frequency with which this fund is disbursed to eligible students: one-time, per academic term, per semester, monthly (for work-study), or biweekly.. Valid values are `one_time|per_term|per_semester|monthly|biweekly`',
    `disbursement_method` STRING COMMENT 'The method by which funds are disbursed: directly to the student, applied to the student account, paid by an employer (for work-study), or paid by a third party.. Valid values are `direct_to_student|applied_to_account|employer_paid|third_party`',
    `donor_restrictions` STRING COMMENT 'Free-text description of any donor-imposed restrictions on fund use, such as major field of study, geographic origin, demographic criteria, or other special conditions.',
    `effective_date` DATE COMMENT 'The date on which this fund becomes available for awarding and disbursement. Typically the start of the award year or the date donor funds are received.',
    `endowed_flag` BOOLEAN COMMENT 'Indicates whether this is an endowed fund where only investment earnings are awarded, preserving the principal in perpetuity.',
    `enrollment_status_requirement` STRING COMMENT 'The minimum enrollment status required for a student to be eligible for this fund. Federal Pell Grants are available at any enrollment status, while some institutional scholarships require full-time enrollment.. Valid values are `full_time|three_quarter_time|half_time|less_than_half_time|any`',
    `expiration_date` DATE COMMENT 'The date on which this fund is no longer available for new awards. For federal funds, this is typically the end of the award year. For endowed funds, this may be null indicating perpetual availability.',
    `fund_category` STRING COMMENT 'The aid category indicating the nature of the financial assistance: grant (gift aid), loan (repayable), scholarship (merit or need-based gift), work-study (earned aid), fellowship, or assistantship.. Valid values are `grant|loan|scholarship|work_study|fellowship|assistantship`',
    `fund_code` STRING COMMENT 'The externally-known unique code identifying this financial aid fund within the institutions fund management system. Used for fund accounting, award packaging, and disbursement processing.. Valid values are `^[A-Z0-9]{4,12}$`',
    `fund_description` STRING COMMENT 'Detailed description of the funds purpose, eligibility criteria, and any special conditions. Used for student communication and financial aid counseling.',
    `fund_name` STRING COMMENT 'The official name of the financial aid fund as it appears in institutional records and student award letters.',
    `fund_status` STRING COMMENT 'Current operational status of the fund indicating whether it is available for awarding, temporarily suspended, depleted of funds, pending approval, or permanently closed.. Valid values are `active|inactive|suspended|depleted|pending_approval|closed`',
    `fund_type` STRING COMMENT 'The primary classification of the fund source indicating whether it is federal, state, institutional, private donor, or external scholarship.. Valid values are `federal|state|institutional|private|external`',
    `gpa_requirement` DECIMAL(18,2) COMMENT 'The minimum cumulative GPA required for initial eligibility or continued eligibility (Satisfactory Academic Progress). Null if no GPA requirement exists.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this fund record was last updated.',
    `matching_percentage` DECIMAL(18,2) COMMENT 'The percentage of institutional funds required to match federal allocation. For example, SEOG requires 25% institutional match. Null if no matching requirement exists.',
    `matching_requirement_flag` BOOLEAN COMMENT 'Indicates whether this fund requires institutional matching funds. True for programs like Federal SEOG and Federal Work-Study that require institutional cost-sharing.',
    `maximum_award_amount` DECIMAL(18,2) COMMENT 'The maximum dollar amount that can be awarded to a single student from this fund per award year. For federal programs, this is the statutory maximum (e.g., Pell maximum).',
    `maximum_years_eligible` STRING COMMENT 'The maximum number of academic years a student may receive this fund. Federal Pell Grant has a 12-semester (6-year) lifetime limit. Null if no limit exists.',
    `merit_based_flag` BOOLEAN COMMENT 'Indicates whether this fund is awarded based on academic merit, talent, or achievement criteria rather than financial need.',
    `minimum_award_amount` DECIMAL(18,2) COMMENT 'The minimum dollar amount that can be awarded to a single student from this fund. Used to ensure awards meet federal or donor-specified minimums.',
    `need_based_flag` BOOLEAN COMMENT 'Indicates whether this fund is need-based (requires demonstrated financial need via FAFSA EFC calculation) or non-need-based (merit or other criteria).',
    `payout_rate` DECIMAL(18,2) COMMENT 'The annual payout rate applied to endowed funds to determine the amount available for awarding, expressed as a decimal (e.g., 0.0450 for 4.5%). Null for non-endowed funds.',
    `refundable_flag` BOOLEAN COMMENT 'Indicates whether disbursed funds can be refunded to the student (creating a credit balance) or must only be applied to institutional charges. Relevant for Return of Title IV (R2T4) calculations.',
    `regulatory_program_code` STRING COMMENT 'The federal or state program code for Title IV or state-regulated aid programs (e.g., PELL for Federal Pell Grant, SEOG for Federal Supplemental Educational Opportunity Grant, DL for Direct Loan, FWSP for Federal Work-Study Program). Empty for non-regulated institutional or private funds.. Valid values are `^[A-Z0-9]{2,10}$`',
    `remaining_balance_amount` DECIMAL(18,2) COMMENT 'The current unawarded or undisbursed balance remaining in the fund. Updated in real-time as awards are packaged and disbursements are processed.',
    `renewable_flag` BOOLEAN COMMENT 'Indicates whether this fund award is renewable for multiple years if eligibility criteria continue to be met. Common for multi-year scholarships.',
    `reporting_category` STRING COMMENT 'The category used for external reporting to IPEDS, state agencies, or accreditation bodies. Maps fund to standardized reporting classifications.',
    `residency_requirement` STRING COMMENT 'State or geographic residency requirement for eligibility. Common for state grants and some institutional scholarships (e.g., must be a resident of California, must be from a specific county).',
    `sap_required_flag` BOOLEAN COMMENT 'Indicates whether students must meet Satisfactory Academic Progress standards to receive this fund. True for all federal Title IV aid; may vary for institutional funds.',
    `self_help_flag` BOOLEAN COMMENT 'Indicates whether this fund is classified as self-help aid (loans and work-study) versus gift aid (grants and scholarships). Used in financial aid packaging strategies.',
    `taxable_flag` BOOLEAN COMMENT 'Indicates whether this fund is considered taxable income to the student. Scholarships exceeding qualified education expenses and work-study earnings are typically taxable.',
    CONSTRAINT pk_aid_fund PRIMARY KEY(`aid_fund_id`)
) COMMENT 'Master record for each financial aid fund administered by the institution, including federal funds (Pell, SEOG, Direct Loan, Perkins, Work-Study), state grants, institutional scholarships, and private/outside scholarships. Captures fund code, fund type, fund category (grant, loan, work-study, scholarship), regulatory program code, annual allocation amount, remaining balance, matching requirement, and fund-specific eligibility rules. Sourced from Ellucian Banner Fund Management.';

CREATE OR REPLACE TABLE `education_ecm`.`aid`.`coa_budget` (
    `coa_budget_id` BIGINT COMMENT 'Unique identifier for the Cost of Attendance budget template record.',
    `academic_program_id` BIGINT COMMENT 'Reference to the specific academic program or major for which this COA budget applies, if program-specific budgets are used.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: COA budget approval is a named compliance process — the approving financial aid administrator (employee) must be traceable for federal audit and institutional methodology documentation. approved_by is',
    `award_year_id` BIGINT COMMENT 'Reference to the financial aid award year for which this COA budget applies (e.g., 2023-2024).',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Cost of Attendance budgets are campus-specific under 34 CFR 668.41 — residential, commuter, and satellite campuses carry distinct COA components (room/board, transportation). Financial aid directors m',
    `dining_plan_id` BIGINT COMMENT 'Foreign key linking to studentlife.dining_plan. Business justification: COA budgets must reflect actual meal plan costs, not estimates. Different dining plans have different costs; aid packaging requires precise room & board component. Business process: COA calculation us',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.fee_schedule. Business justification: COA budgets are constructed directly from institutional fee schedules (tuition_fees_amount in coa_budget derives from fee_schedule rate_amount). Financial aid offices build COA budgets by pulling curr',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: COA budgets must be constructed per federal methodology (34 CFR 668.2) with documented regulatory basis for each component (tuition, room/board, books, transportation). Required for program reviews an',
    `academic_level` STRING COMMENT 'Academic level of students for whom this COA budget applies (undergraduate, graduate, professional, post-baccalaureate, doctoral, certificate).. Valid values are `undergraduate|graduate|professional|post_baccalaureate|doctoral|certificate`',
    `approval_date` DATE COMMENT 'Date when this COA budget template was officially approved for use in financial aid packaging.',
    `books_supplies_amount` DECIMAL(18,2) COMMENT 'Estimated cost of books, course materials, supplies, and equipment required for the academic program.',
    `budget_code` STRING COMMENT 'Institution-defined code uniquely identifying this COA budget template (e.g., UG_DEP_ONCAMPUS, GRAD_IND_OFFCAMPUS).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `budget_description` STRING COMMENT 'Detailed description of the student population and assumptions for this COA budget template, including eligibility criteria and usage notes.',
    `budget_name` STRING COMMENT 'Descriptive name of the COA budget template (e.g., Undergraduate Dependent On-Campus, Graduate Independent Off-Campus with Family).',
    `budget_status` STRING COMMENT 'Current lifecycle status of this COA budget template (draft, active, superseded, archived).. Valid values are `draft|active|superseded|archived`',
    `budget_version` STRING COMMENT 'Version number of this COA budget template, incremented when budget amounts are revised during the award year.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this COA budget template record was first created in the system.',
    `credit_hour_maximum` STRING COMMENT 'Maximum number of credit hours covered by this COA budget template, null if no upper limit applies.',
    `credit_hour_minimum` STRING COMMENT 'Minimum number of credit hours required for students to be eligible for this COA budget template, based on enrollment status.',
    `dependency_status` STRING COMMENT 'FAFSA dependency status assumption for this COA budget (dependent or independent student).. Valid values are `dependent|independent`',
    `dependent_care_amount` DECIMAL(18,2) COMMENT 'Allowance for dependent care expenses (childcare or eldercare) for students with dependents, if applicable to this budget template.',
    `disability_expenses_amount` DECIMAL(18,2) COMMENT 'Allowance for disability-related expenses for students with documented disabilities, if applicable to this budget template.',
    `effective_end_date` DATE COMMENT 'Date when this COA budget template expires or is superseded by a new version, null if currently active.',
    `effective_start_date` DATE COMMENT 'Date when this COA budget template becomes effective for financial aid packaging and need calculations.',
    `enrollment_status` STRING COMMENT 'Expected enrollment intensity for this COA budget (full-time, three-quarter-time, half-time, less-than-half-time) as defined by Title IV regulations.. Valid values are `full_time|three_quarter_time|half_time|less_than_half_time`',
    `federal_methodology_flag` BOOLEAN COMMENT 'Indicates whether this COA budget complies with federal Title IV methodology requirements for need-based aid packaging (True/False).',
    `housing_type` STRING COMMENT 'Expected housing arrangement for students using this COA budget (on-campus, off-campus, with-parents).. Valid values are `on_campus|off_campus|with_parents`',
    `institutional_methodology_flag` BOOLEAN COMMENT 'Indicates whether this COA budget uses institutional methodology for institutional aid packaging, which may differ from federal methodology (True/False).',
    `loan_fees_amount` DECIMAL(18,2) COMMENT 'Allowance for loan origination fees and other costs associated with federal student loans, if applicable.',
    `notes` STRING COMMENT 'Additional notes, assumptions, or special instructions related to this COA budget template for financial aid staff reference.',
    `personal_expenses_amount` DECIMAL(18,2) COMMENT 'Allowance for miscellaneous personal expenses including clothing, laundry, entertainment, and other living costs.',
    `professional_licensure_amount` DECIMAL(18,2) COMMENT 'Allowance for professional licensure exam fees, certification costs, and related expenses for professional programs (e.g., bar exam, medical boards).',
    `residency_status` STRING COMMENT 'Student residency classification for tuition and fee purposes (in-state, out-of-state, international).. Valid values are `in_state|out_of_state|international`',
    `room_board_amount` DECIMAL(18,2) COMMENT 'Allowance for housing and food expenses based on the housing type assumption (on-campus room and board rates or off-campus living allowance).',
    `study_abroad_amount` DECIMAL(18,2) COMMENT 'Additional allowance for study abroad program costs including international travel, visa fees, and higher living expenses, if applicable.',
    `term_type` STRING COMMENT 'Academic term structure for which this COA budget is calculated (academic-year, fall-semester, spring-semester, summer-session, quarter, trimester).. Valid values are `academic_year|fall_semester|spring_semester|summer_session|quarter|trimester`',
    `total_coa_amount` DECIMAL(18,2) COMMENT 'Total Cost of Attendance calculated as the sum of all component amounts in this budget template, representing the maximum financial aid eligibility.',
    `transportation_amount` DECIMAL(18,2) COMMENT 'Allowance for transportation costs including commuting to campus and travel between home and school.',
    `tuition_fees_amount` DECIMAL(18,2) COMMENT 'Standard tuition and mandatory fees component of the COA budget for the award year and enrollment status.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this COA budget template record was last modified in the system.',
    CONSTRAINT pk_coa_budget PRIMARY KEY(`coa_budget_id`)
) COMMENT 'Cost of Attendance (COA) budget template defining standard student expense categories used for financial need calculation under Title IV. Tracks budget components (tuition, fees, room, board, books, transportation, personal expenses), enrollment status assumptions, housing type, academic level, program of study, and component dollar amounts. Supports multiple budget versions per award year for different student populations (dependent on-campus, independent off-campus, etc.). SSOT for COA determination and need-based packaging calculations.';

CREATE OR REPLACE TABLE `education_ecm`.`aid`.`isir_record` (
    `isir_record_id` BIGINT COMMENT 'Unique identifier for the ISIR record. Primary key. Role: TRANSACTION_HEADER (federal need analysis transaction).',
    `award_year_id` BIGINT COMMENT 'Foreign key linking to aid.award_year. Business justification: isir_record has an award_year STRING column but no FK to the award_year master table. Each ISIR is processed for a specific FAFSA award year cycle. Adding award_year_id normalizes this to the master r',
    `profile_id` BIGINT COMMENT 'Identifier of the student to whom this ISIR record belongs.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: ISIR processing follows annual regulatory guidance (HEA Title IV, annual Federal Register notices). Tracking which regulatory version governs each transaction year is essential for audit compliance an',
    `automatic_zero_efc_flag` BOOLEAN COMMENT 'Indicates whether the student qualifies for an automatic zero EFC based on income thresholds and other criteria.',
    `citizenship_status` STRING COMMENT 'Students citizenship status for federal financial aid eligibility purposes.. Valid values are `citizen|eligible_noncitizen|other`',
    `comment_codes` STRING COMMENT 'Comma-separated list of comment codes providing additional information about the students application, eligibility issues, or required actions.',
    `correction_flag` BOOLEAN COMMENT 'Indicates whether this ISIR represents a correction to a previously processed FAFSA application.',
    `cps_version` STRING COMMENT 'Two-digit version number of the CPS software used to process this FAFSA application.. Valid values are `^[0-9]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ISIR record was first loaded into the institutional system.',
    `date_of_birth` DATE COMMENT 'Students date of birth as reported on the FAFSA.',
    `dependency_status` STRING COMMENT 'Indicates whether the student is classified as dependent or independent for federal financial aid purposes based on FAFSA dependency criteria.. Valid values are `dependent|independent`',
    `efc` STRING COMMENT 'Expected Family Contribution calculated by the federal need analysis formula. Represents the amount a family is expected to contribute toward the students education. Used for award years prior to 2024-2025.',
    `fafsa_signature_date` DATE COMMENT 'Date when the student (and parent, if applicable) signed the FAFSA application.',
    `household_size` STRING COMMENT 'Number of people in the students or parents household as reported on the FAFSA. Used in federal need analysis calculation.',
    `isir_source` STRING COMMENT 'Indicates whether this ISIR is from an original FAFSA submission, a correction, or a renewal application.. Valid values are `original|correction|renewal`',
    `marital_status` STRING COMMENT 'Students marital status as of the FAFSA filing date.. Valid values are `single|married|separated|divorced|widowed`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ISIR record was last updated in the institutional system.',
    `number_in_college` STRING COMMENT 'Number of household members who will be enrolled in postsecondary education during the award year. Used in federal need analysis calculation.',
    `parent_agi` DECIMAL(18,2) COMMENT 'Parents adjusted gross income from federal tax return for the base year. Applicable only for dependent students.',
    `parent_cash_savings` DECIMAL(18,2) COMMENT 'Total value of parents cash, savings, and checking account balances as of the FAFSA filing date. Applicable only for dependent students.',
    `parent_income_tax_paid` DECIMAL(18,2) COMMENT 'Amount of U.S. income tax paid by the parent(s) for the base year. Applicable only for dependent students.',
    `parent_investment_net_worth` DECIMAL(18,2) COMMENT 'Net worth of parents investments including stocks, bonds, real estate (excluding primary residence), and other investment assets. Applicable only for dependent students.',
    `parent_marital_status` STRING COMMENT 'Marital status of the parent(s) as of the FAFSA filing date. Applicable only for dependent students.. Valid values are `married|remarried|single|divorced|separated|widowed`',
    `parent_untaxed_income` DECIMAL(18,2) COMMENT 'Total untaxed income and benefits received by the parent(s). Applicable only for dependent students.',
    `pell_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the student is eligible for a Federal Pell Grant based on the calculated EFC/SAI and other eligibility criteria.',
    `processed_date` DATE COMMENT 'Date when the FAFSA application was processed by the Central Processing System (CPS) and the ISIR was generated.',
    `professional_judgment_flag` BOOLEAN COMMENT 'Indicates whether the financial aid office has exercised professional judgment to adjust data elements on this ISIR.',
    `received_date` DATE COMMENT 'Date when the institution received the ISIR record from the CPS.',
    `reject_reason_codes` STRING COMMENT 'Comma-separated list of reject codes indicating data errors or missing information that prevented full processing of the FAFSA. Blank if no rejects.',
    `sai` STRING COMMENT 'Student Aid Index calculated by the federal need analysis formula. Replaces EFC starting with the 2024-2025 award year. Represents the measure of a familys financial strength.',
    `simplified_needs_test_flag` BOOLEAN COMMENT 'Indicates whether the student qualifies for the simplified needs test, which excludes asset information from the need analysis calculation.',
    `ssn` STRING COMMENT 'Students Social Security Number as reported on the FAFSA. Used for federal aid eligibility verification and identity matching.. Valid values are `^[0-9]{3}-[0-9]{2}-[0-9]{4}$`',
    `state_of_legal_residence` STRING COMMENT 'Two-letter state code indicating the students state of legal residence for tuition purposes.. Valid values are `^[A-Z]{2}$`',
    `student_agi` DECIMAL(18,2) COMMENT 'Students adjusted gross income from federal tax return for the base year. Used in federal need analysis calculation.',
    `student_cash_savings` DECIMAL(18,2) COMMENT 'Total value of students cash, savings, and checking account balances as of the FAFSA filing date.',
    `student_income_tax_paid` DECIMAL(18,2) COMMENT 'Amount of U.S. income tax paid by the student for the base year.',
    `student_investment_net_worth` DECIMAL(18,2) COMMENT 'Net worth of students investments including stocks, bonds, real estate (excluding primary residence), and other investment assets.',
    `student_untaxed_income` DECIMAL(18,2) COMMENT 'Total untaxed income and benefits received by the student, including child support, IRA deductions, and other untaxed income sources.',
    `transaction_number` STRING COMMENT 'Sequential transaction number assigned by the Central Processing System (CPS) for each FAFSA submission or correction. Higher numbers indicate more recent submissions.',
    `verification_selection_flag` BOOLEAN COMMENT 'Indicates whether the student has been selected for federal verification by the CPS. True if selected, False if not selected.',
    `verification_tracking_flag` STRING COMMENT 'Two-character code indicating the specific verification tracking group assigned by the CPS (e.g., V1, V4, V5, V6). Blank if not selected for verification.. Valid values are `^[A-Z0-9]{0,2}$`',
    CONSTRAINT pk_isir_record PRIMARY KEY(`isir_record_id`)
) COMMENT 'Institutional Student Information Record (ISIR) received from the Central Processing System (CPS) after FAFSA processing. Stores raw FAFSA data including EFC, dependency status, verification selection flag, comment codes, reject codes, transaction number, processed date, SAI (Student Aid Index), Pell eligibility indicator, and all income/asset fields. SSOT for federal need analysis data. Sourced from Ellucian Banner ISIR Import.';

CREATE OR REPLACE TABLE `education_ecm`.`aid`.`verification` (
    `verification_id` BIGINT COMMENT 'Unique identifier for the federal verification record. Primary key for the verification entity.',
    `award_year_id` BIGINT COMMENT 'Foreign key linking to aid.award_year. Business justification: verification has an aid_year STRING column but no FK to the award_year master table. Federal verification is a process tied to a specific FAFSA award year — students are selected for verification for ',
    `employee_id` BIGINT COMMENT 'The user ID of the financial aid administrator who reviewed and completed the verification process.',
    `isir_record_id` BIGINT COMMENT 'Foreign key linking to aid.isir_record. Business justification: The verification process is performed on a specific ISIR transaction. Currently verification has isir_transaction_number as a STRING; it should FK to isir_record. Columns isir_transaction_number, orig',
    `profile_id` BIGINT COMMENT 'Identifier of the student subject to verification. Links to the student master record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Verification requirements are defined by 34 CFR 668.56 and annual NASFAA guidance. Each verification case must reference applicable regulatory framework to ensure proper documentation standards and tr',
    `child_support_paid_verification_date` DATE COMMENT 'The date documentation of child support paid was received and verified.',
    `comments` STRING COMMENT 'Additional notes or comments regarding the verification process, document review, or special circumstances.',
    `completion_date` DATE COMMENT 'The date verification was completed and all required documents were reviewed and approved.',
    `conflicting_information_description` STRING COMMENT 'Description of the conflicting information identified and how it was resolved.',
    `conflicting_information_indicator` BOOLEAN COMMENT 'Indicates whether conflicting information was identified that requires resolution before verification can be completed.',
    `correction_required_indicator` BOOLEAN COMMENT 'Indicates whether a FAFSA correction is required based on verification findings.',
    `correction_submitted_date` DATE COMMENT 'The date the FAFSA correction was submitted to CPS following verification.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this verification record was first created in the system.',
    `dependency_override_date` DATE COMMENT 'The date the dependency override decision was made and documented.',
    `dependency_override_indicator` BOOLEAN COMMENT 'Indicates whether a dependency override was granted by the financial aid administrator, changing the students dependency status from dependent to independent.',
    `dependency_override_reason` STRING COMMENT 'Narrative explanation of the unusual circumstances justifying the dependency override (e.g., abandonment, abuse, incarceration of parents).',
    `exclusion_reason` STRING COMMENT 'Explanation of why the student was excluded from verification (e.g., received only unsubsidized loans, parent information not required).',
    `high_school_completion_verification_date` DATE COMMENT 'The date high school completion status (diploma, GED, homeschool) was verified.',
    `household_size_verification_date` DATE COMMENT 'The date household size documentation was received and verified.',
    `identity_verification_received_date` DATE COMMENT 'The date identity verification documentation (e.g., copy of drivers license, passport) was received.',
    `income_verification_method` STRING COMMENT 'The method used to verify income information. IRS_DRT=IRS Data Retrieval Tool, TAX_TRANSCRIPT=IRS Tax Return Transcript, W2=W-2 forms, 1099=1099 forms, NOT_REQUIRED=income verification not required for this tracking group.. Valid values are `IRS_DRT|TAX_TRANSCRIPT|W2|1099|NOT_REQUIRED`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this verification record was last updated.',
    `number_in_college_verification_date` DATE COMMENT 'The date documentation verifying the number of household members enrolled in college was received.',
    `professional_judgment_date` DATE COMMENT 'The date the professional judgment adjustment was made.',
    `professional_judgment_indicator` BOOLEAN COMMENT 'Indicates whether professional judgment was exercised to adjust data elements used to calculate the Expected Family Contribution (EFC).',
    `professional_judgment_reason` STRING COMMENT 'Narrative explanation of the special circumstances justifying the professional judgment adjustment (e.g., loss of employment, medical expenses, divorce).',
    `reviewer_name` STRING COMMENT 'The full name of the financial aid administrator who reviewed and completed the verification.',
    `selection_date` DATE COMMENT 'The date the student was selected for verification.',
    `selection_source` STRING COMMENT 'Indicates whether the student was selected for verification by the Central Processing System (CPS) or by the institution.. Valid values are `CPS|INSTITUTIONAL`',
    `snap_benefits_verification_date` DATE COMMENT 'The date documentation of SNAP benefits receipt was verified (applicable for V5 tracking group).',
    `tax_transcript_received_date` DATE COMMENT 'The date the IRS tax return transcript or equivalent tax documentation was received from the student or parent.',
    `tracking_group` STRING COMMENT 'The federal verification tracking group assigned by CPS (Central Processing System) or institutionally. V1=Standard Verification Group, V4=Custom Verification Group, V5=Aggregate Household Resources, V6=IRS Income Tax Return Filers.. Valid values are `V1|V4|V5|V6|CUSTOM`',
    `verification_status` STRING COMMENT 'Current status of the verification process. PENDING=awaiting documents, IN_PROGRESS=documents under review, COMPLETED=verification finished, WAIVED=verification requirement waived, EXCLUDED=student excluded from verification.. Valid values are `PENDING|IN_PROGRESS|COMPLETED|WAIVED|EXCLUDED`',
    `waiver_reason` STRING COMMENT 'Explanation of why the verification requirement was waived (e.g., death of student, natural disaster, student withdrew before verification completed).',
    CONSTRAINT pk_verification PRIMARY KEY(`verification_id`)
) COMMENT 'Tracks the federal verification process for students selected by CPS or institutionally. Records verification tracking group, required documents, document receipt dates, verification status, income verification method (IRS DRT or tax transcript), dependency override decisions, professional judgment adjustments, and verification completion date. SSOT for Title IV verification compliance. Sourced from Ellucian Banner Verification module.';

CREATE OR REPLACE TABLE `education_ecm`.`aid`.`sap_evaluation` (
    `sap_evaluation_id` BIGINT COMMENT 'Primary key for sap_evaluation',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: SAP standards often vary by program—maximum timeframe calculations depend on program published length, some programs have higher GPA requirements, and completion rate thresholds may differ for profess',
    `academic_standing_id` BIGINT COMMENT 'Foreign key linking to student.academic_standing. Business justification: FA SAP evaluations are directly driven by the institutional academic standing record (cumulative GPA, completion rate, title_iv_eligible). FA counselors must trace which academic_standing record was t',
    `advising_assignment_id` BIGINT COMMENT 'Foreign key linking to faculty.advising_assignment. Business justification: When a student fails SAP, federal regulations require an academic plan developed with the faculty advisor. The aid_sap_evaluation tracks academic_plan_conditions and academic_plan_start_term — linking',
    `award_year_id` BIGINT COMMENT 'Foreign key linking to aid.award_year. Business justification: aid_sap_evaluation has no award_year_id FK despite SAP evaluations being conducted at defined checkpoints tied to specific award years. SAP status determines financial aid eligibility for a given awar',
    `degree_progress_id` BIGINT COMMENT 'Foreign key linking to student.degree_progress. Business justification: SAP maximum timeframe status is calculated directly from degree progress data (credits_completed, credits_remaining, total_credits_required). FA offices run SAP evaluations against the degree audit — ',
    `employee_id` BIGINT COMMENT 'Unique identifier of the financial aid staff member who performed or certified the SAP evaluation.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: SAP evaluations are governed by the institutions published SAP policy defining specific GPA thresholds, completion rate requirements, and appeal procedures. aid_sap_evaluation already references the ',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student being evaluated for Satisfactory Academic Progress. Links to the student master record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: SAP policies must comply with 34 CFR 668.34 requirements for qualitative, quantitative, and maximum timeframe standards. Each evaluation should reference the regulatory requirement to demonstrate poli',
    `term_id` BIGINT COMMENT 'Identifier of the academic period (term, payment period, or academic year) for which this SAP evaluation was performed.',
    `academic_plan_conditions` STRING COMMENT 'Detailed conditions and requirements the student must meet under the academic plan, such as minimum term GPA, credit load restrictions, mandatory advising, or tutoring participation.',
    `academic_plan_end_term` STRING COMMENT 'The academic term code when the students academic plan is scheduled to conclude, by which time the student must return to meeting SAP standards.',
    `academic_plan_required_flag` BOOLEAN COMMENT 'Indicates whether the student is required to follow an academic plan as a condition of probation status. True if academic plan is required; false otherwise.',
    `academic_plan_start_term` STRING COMMENT 'The academic term code when the students academic plan begins, typically the term immediately following an approved appeal.',
    `appeal_date` DATE COMMENT 'The date on which the student submitted their SAP appeal. Null if no appeal was submitted.',
    `appeal_decision` STRING COMMENT 'The outcome of the SAP appeal review: approved (student placed on probation with academic plan), denied (suspension upheld), pending review, or withdrawn by student.. Valid values are `approved|denied|pending|withdrawn`',
    `appeal_decision_date` DATE COMMENT 'The date on which the SAP appeal decision was rendered by the financial aid office or appeals committee.',
    `appeal_reason` STRING COMMENT 'The documented reason(s) for the SAP appeal, such as serious illness, death of family member, military deployment, or other mitigating circumstances that affected academic performance.',
    `appeal_reviewer_name` STRING COMMENT 'The name of the financial aid officer, committee chair, or official who reviewed and decided the SAP appeal.',
    `appeal_submitted_flag` BOOLEAN COMMENT 'Indicates whether the student submitted a formal SAP appeal following a suspension or warning status. True if appeal was submitted; false otherwise.',
    `comments` STRING COMMENT 'Additional notes, comments, or documentation related to the SAP evaluation, appeal decision, or special circumstances considered by the evaluator.',
    `completion_rate_percentage` DECIMAL(18,2) COMMENT 'The students pace of progression, calculated as (cumulative earned credits / cumulative attempted credits) * 100. Federal regulation requires minimum 67% completion rate.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this SAP evaluation record was first created in the system.',
    `cumulative_credits_attempted` DECIMAL(18,2) COMMENT 'Total number of credit hours the student has attempted in the program as of this evaluation, including withdrawals, incompletes, and failed courses.',
    `cumulative_credits_earned` DECIMAL(18,2) COMMENT 'Total number of credit hours the student has successfully completed (passed) in the program as of this evaluation.',
    `cumulative_gpa` DECIMAL(18,2) COMMENT 'The students cumulative GPA at the time of this SAP evaluation, calculated across all attempted coursework in the program.',
    `evaluation_date` DATE COMMENT 'The date on which the Satisfactory Academic Progress evaluation was performed. Typically occurs at the end of a term or payment period.',
    `evaluation_type` STRING COMMENT 'The type or trigger of the SAP evaluation: end of term, payment period checkpoint, annual review, mid-term check, appeal review, or reinstatement evaluation.. Valid values are `end_of_term|payment_period|annual|mid_term|appeal_review|reinstatement`',
    `financial_aid_eligibility_status` STRING COMMENT 'The students Title IV financial aid eligibility status resulting from this SAP evaluation: eligible (meeting standards), ineligible (suspended), or conditional (probation with academic plan).. Valid values are `eligible|ineligible|conditional`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this SAP evaluation record was last updated or modified in the system.',
    `maximum_credits_allowed` DECIMAL(18,2) COMMENT 'The maximum number of credit hours the student may attempt to complete the program, calculated as 150% of the published program length per federal regulation.',
    `maximum_timeframe_status` STRING COMMENT 'Status of the maximum timeframe measure. Within_limit indicates the student can complete the program within 150% of published length; exceeded indicates the student cannot.. Valid values are `within_limit|exceeded|not_applicable`',
    `minimum_completion_rate_required` DECIMAL(18,2) COMMENT 'The minimum completion rate percentage required by the institutions SAP policy. Federal regulation mandates at least 67%.',
    `minimum_gpa_required` DECIMAL(18,2) COMMENT 'The minimum cumulative GPA required by the institutions SAP policy for the students program and academic level at the time of evaluation.',
    `notification_method` STRING COMMENT 'The method by which the SAP evaluation results were communicated to the student: email, postal mail, student portal message, in-person meeting, or phone call.. Valid values are `email|postal_mail|student_portal|in_person|phone`',
    `notification_sent_date` DATE COMMENT 'The date on which the institution notified the student of their SAP evaluation results and financial aid eligibility status.',
    `overall_sap_status` STRING COMMENT 'The overall Satisfactory Academic Progress status resulting from this evaluation: meeting standards, warning (first failure), suspension (ineligible for aid), probation (on academic plan after appeal), dismissed, or reinstated.. Valid values are `meeting|warning|suspension|probation|dismissed|reinstated`',
    `prior_sap_status` STRING COMMENT 'The students SAP status from the immediately preceding evaluation period, used to determine progression through warning, suspension, and probation stages. [ENUM-REF-CANDIDATE: meeting|warning|suspension|probation|dismissed|reinstated|first_evaluation — 7 candidates stripped; promote to reference product]',
    `program_published_length` DECIMAL(18,2) COMMENT 'The published length of the students academic program in credit hours, used as the basis for calculating the 150% maximum timeframe.',
    `qualitative_measure_status` STRING COMMENT 'Status of the qualitative measure (cumulative GPA requirement). Pass indicates the student meets the minimum cumulative GPA threshold; fail indicates below threshold.. Valid values are `pass|fail|not_applicable`',
    `quantitative_measure_status` STRING COMMENT 'Status of the quantitative measure (pace/completion rate requirement). Pass indicates the student meets the minimum 67% completion rate; fail indicates below threshold.. Valid values are `pass|fail|not_applicable`',
    CONSTRAINT pk_sap_evaluation PRIMARY KEY(`sap_evaluation_id`)
) COMMENT 'Satisfactory Academic Progress (SAP) evaluation record for a student at a defined checkpoint (end of term, payment period, or academic year). Captures qualitative measure (cumulative GPA vs. minimum), quantitative measure (pace/completion rate vs. 67% threshold), maximum timeframe check (150% of published program length), overall SAP status (meeting, warning, suspension, probation), evaluation date, and evaluation period. Includes appeal tracking (appeal date, appeal reason, appeal decision, approving official) and academic plan terms when students are placed on probation with conditions. SSOT for SAP compliance per 34 CFR 668.34.';

CREATE OR REPLACE TABLE `education_ecm`.`aid`.`loan_record` (
    `loan_record_id` BIGINT COMMENT 'Unique identifier for the student loan record. Primary key for the loan_record product.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Title IV loan records must be tied to the enrolled academic program for COD origination reporting, R2T4 calculations, and gainful employment disclosure under 34 CFR 685. Program-level loan tracking is',
    `aid_award_id` BIGINT COMMENT 'Foreign key linking to aid.award. Business justification: loan_record is a specialized tracking record for student loans, which are a type of financial aid award. The loan_record should reference the parent award record in the general aid system. This allows',
    `ar_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ar_invoice. Business justification: Institutional loans (Perkins, emergency, short-term) generate AR invoices when repayment begins. Loan principal becomes a receivable tracked through student AR system. Essential for loan servicing, co',
    `award_year_id` BIGINT COMMENT 'Foreign key linking to aid.award_year. Business justification: loan_record has an award_year STRING column but no FK to the award_year master table. Student loans are originated for a specific award year, which governs annual loan limits, subsidized eligibility p',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Federal loan origination/certification (COD reporting) requires staff accountability — a specific financial aid officer certifies each loan. Regulatory audits and COD reconciliation reports depend on ',
    `coa_budget_id` BIGINT COMMENT 'Foreign key linking to aid.coa_budget. Business justification: loan_record carries a coa_amount field representing the Cost of Attendance used during loan origination. Adding coa_budget_id provides a direct reference to the COA budget template that governed the l',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Loan originations and disbursements must be attributed to fiscal periods for GL reconciliation, NSLDS reporting, and year-end close. Controllers and financial aid directors require this link to reconc',
    `profile_id` BIGINT COMMENT 'Unique identifier for the student borrower receiving this loan. Links to the student master record in the Student Information System (SIS).',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Loan originations are submitted to COD as regulatory filings. loan_record.cod_transaction_number, cod_accepted_date, and nslds_reported_date confirm this named federal process. Linking loan records to',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Each loan type (Direct Subsidized, Unsubsidized, PLUS) has specific HEA Title IV regulatory requirements for eligibility, annual/aggregate limits, interest rates, and origination fees. Essential for C',
    `statement_id` BIGINT COMMENT 'Foreign key linking to billing.statement. Business justification: Loan disbursements appear as credits on billing statements (statement.loan_disbursement field). Loan servicer reconciliation and R2T4 calculations require tracing each loan record to the billing state',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Loan proceeds credit student accounts when disbursed. Billing systems track which loans have posted to calculate net balance, generate accurate statements, determine refund eligibility, and manage acc',
    `academic_year` STRING COMMENT 'The academic year for which the loan was originated, in format YYYY-YYYY (e.g., 2023-2024). Used for reporting and cohort analysis.. Valid values are `^d{4}-d{4}$`',
    `aggregate_loan_balance` DECIMAL(18,2) COMMENT 'The students total outstanding loan balance across all prior loans at the time of this loan origination, in USD. Used to verify the student has not exceeded aggregate limits.',
    `aggregate_loan_limit` DECIMAL(18,2) COMMENT 'The maximum cumulative loan amount the student is eligible to borrow across all years, in USD. Varies by dependency status, grade level, and loan type.',
    `anticipated_disbursement_date` DATE COMMENT 'The expected date for loan disbursement as reported to COD at origination. Used for planning and student account projections.',
    `borrower_type` STRING COMMENT 'Identifies the type of borrower for this loan. STUDENT=undergraduate student borrower (Direct Subsidized/Unsubsidized), PARENT=parent borrower (Direct PLUS Parent), GRADUATE_STUDENT=graduate/professional student borrower (Direct Unsubsidized or PLUS Grad).. Valid values are `STUDENT|PARENT|GRADUATE_STUDENT`',
    `cancellation_date` DATE COMMENT 'The date on which the loan was cancelled, if applicable. Null if the loan was not cancelled.',
    `cancellation_reason_code` STRING COMMENT 'The reason code for loan cancellation, if applicable. STUDENT_REQUEST=student requested cancellation, ELIGIBILITY_CHANGE=student became ineligible, ENROLLMENT_CHANGE=student dropped below half-time, DUPLICATE=duplicate loan record, OTHER=other reason.. Valid values are `STUDENT_REQUEST|ELIGIBILITY_CHANGE|ENROLLMENT_CHANGE|DUPLICATE|OTHER`',
    `coa_amount` DECIMAL(18,2) COMMENT 'The total Cost of Attendance for the loan period, in USD. Includes tuition, fees, room, board, books, supplies, transportation, and personal expenses. Used to determine loan eligibility.',
    `cod_accepted_date` DATE COMMENT 'The date on which the loan record was accepted by the COD system. Confirms federal approval for loan origination and disbursement.',
    `cod_transaction_number` STRING COMMENT 'The unique transaction identifier assigned by the COD system for this loan origination or disbursement. Used for reconciliation and audit trails.. Valid values are `^[A-Z0-9]{10,30}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this loan record was first created in the Student Information System. Used for audit trail and data lineage.',
    `credit_check_passed_indicator` BOOLEAN COMMENT 'Indicates whether the borrower (parent or graduate student) passed the credit check required for PLUS loans. Not applicable to Direct Subsidized or Unsubsidized loans. True=passed, False=failed or not applicable.',
    `dependency_status` STRING COMMENT 'Indicates whether the student is classified as dependent or independent for federal financial aid purposes. Determines loan eligibility and annual limits.. Valid values are `DEPENDENT|INDEPENDENT`',
    `disbursement_date` DATE COMMENT 'The date on which the net loan amount was disbursed (credited) to the students account. May differ from origination date due to processing delays or scheduled disbursement dates.',
    `disbursement_number` STRING COMMENT 'The sequence number of this disbursement within the loan period (e.g., 1 for first disbursement, 2 for second). Federal loans are typically disbursed in multiple installments per academic year.',
    `efc_amount` DECIMAL(18,2) COMMENT 'The Expected Family Contribution calculated from the FAFSA for the award year, in USD. Used to determine financial need and subsidized loan eligibility. Replaced by SAI (Student Aid Index) starting 2024-2025.',
    `endorser_required_indicator` BOOLEAN COMMENT 'Indicates whether an endorser (co-signer) is required for a PLUS loan due to adverse credit history. True=endorser required, False=not required.',
    `enrollment_status` STRING COMMENT 'The students enrollment intensity at the time of loan origination. Affects loan eligibility and disbursement amounts.. Valid values are `FULL_TIME|THREE_QUARTER_TIME|HALF_TIME|LESS_THAN_HALF_TIME`',
    `entrance_counseling_completed_date` DATE COMMENT 'The date on which the student completed entrance counseling, a federal requirement for first-time borrowers. Must be completed before first disbursement.',
    `financial_need_amount` DECIMAL(18,2) COMMENT 'The calculated financial need for the loan period (COA minus EFC and other aid), in USD. Determines eligibility for subsidized loans.',
    `grade_level` STRING COMMENT 'The students academic grade level at the time of loan origination. Determines annual and aggregate loan limits. UG=Undergraduate, GRAD=Graduate, PROFESSIONAL=Professional (e.g., law, medicine).. Valid values are `UG_FRESHMAN|UG_SOPHOMORE|UG_JUNIOR|UG_SENIOR|GRAD|PROFESSIONAL`',
    `gross_loan_amount` DECIMAL(18,2) COMMENT 'The total loan amount before any fees are deducted, in USD. This is the principal amount the student is authorized to borrow.',
    `interest_rate` DECIMAL(18,2) COMMENT 'The annual interest rate applied to the loan, expressed as a decimal (e.g., 0.045 for 4.5%). Rate is fixed at origination and varies by loan type and award year.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this loan record was last updated in the Student Information System. Used for audit trail and change tracking.',
    `loan_number` STRING COMMENT 'Externally-known unique loan identifier assigned by the institution or federal system. Used for tracking and reporting to COD (Common Origination and Disbursement) and loan servicers.. Valid values are `^[A-Z0-9]{10,20}$`',
    `loan_period_begin_date` DATE COMMENT 'The first date of the academic period (term or payment period) for which the loan is intended to cover costs. Used for COA (Cost of Attendance) and eligibility calculations.',
    `loan_period_end_date` DATE COMMENT 'The last date of the academic period (term or payment period) for which the loan is intended to cover costs. Defines the effective-until boundary for the loan period.',
    `loan_servicer_code` STRING COMMENT 'The code identifying the federal loan servicer assigned to manage this loan after disbursement (e.g., MOHELA, Nelnet, Great Lakes). Used for borrower communication and repayment tracking.. Valid values are `^[A-Z0-9]{4,10}$`',
    `loan_status` STRING COMMENT 'Current lifecycle status of the loan record. ORIGINATED=loan has been originated but not yet disbursed, DISBURSED=funds have been released to student account, CANCELLED=loan was cancelled before disbursement, RETURNED=disbursed funds were returned, ADJUSTED=loan amount or terms were adjusted post-origination.. Valid values are `ORIGINATED|DISBURSED|CANCELLED|RETURNED|ADJUSTED`',
    `loan_type_code` STRING COMMENT 'Classification of the loan product. SUB=Direct Subsidized Loan, UNSUB=Direct Unsubsidized Loan, PLUS_PARENT=Direct PLUS Loan for Parents, PLUS_GRAD=Direct PLUS Loan for Graduate Students, PERKINS=Federal Perkins Loan, PRIVATE=Private/Alternative Loan.. Valid values are `SUB|UNSUB|PLUS_PARENT|PLUS_GRAD|PERKINS|PRIVATE`',
    `mpn_signed_date` DATE COMMENT 'The date on which the student (or parent for PLUS loans) signed the Master Promissory Note. Required before loan disbursement.',
    `net_loan_amount` DECIMAL(18,2) COMMENT 'The actual loan amount disbursed to the student after origination fees are deducted (gross_loan_amount minus origination_fee_amount), in USD.',
    `nslds_reported_date` DATE COMMENT 'The date on which this loan record was reported to the National Student Loan Data System. Required for federal compliance and borrower loan history tracking.',
    `origination_date` DATE COMMENT 'The date on which the loan was officially originated and the borrower became legally obligated. This is the principal business event timestamp for the loan record.',
    `origination_fee_amount` DECIMAL(18,2) COMMENT 'The federal origination fee deducted from the gross loan amount, in USD. Fee percentage varies by loan type and award year.',
    `subsidized_indicator` BOOLEAN COMMENT 'Indicates whether the loan is subsidized (government pays interest during in-school, grace, and deferment periods). True for Direct Subsidized Loans, False for all other loan types.',
    `term_code` STRING COMMENT 'The academic term code (e.g., FALL2023, SPR2024) during which the loan was originated. Links to the institutional term calendar.. Valid values are `^[A-Z0-9]{4,10}$`',
    CONSTRAINT pk_loan_record PRIMARY KEY(`loan_record_id`)
) COMMENT 'Master record for each student loan originated under the institutions financial aid programs, including Direct Subsidized, Direct Unsubsidized, Direct PLUS (Parent and Grad), and Perkins loans. Tracks loan type, loan period, loan amount, origination date, MPN (Master Promissory Note) status, entrance counseling completion, loan servicer, interest rate, and origination fee. SSOT for student loan origination data. Sourced from Ellucian Banner Loan Processing and COD (Common Origination and Disbursement).';

CREATE OR REPLACE TABLE `education_ecm`.`aid`.`scholarship` (
    `scholarship_id` BIGINT COMMENT 'Unique identifier for the scholarship record. Primary key for the scholarship catalog.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Scholarships commonly restrict eligibility by academic program—donor-funded scholarships often specify major requirements, departmental scholarships target specific programs, and scholarship administr',
    `employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Scholarships are administered by a designated staff member (employee) responsible for selection, renewal, and donor reporting. contact_name is a denormalized employee name. Linking to hr.employee enab',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Departmental scholarships are administered by specific academic or administrative org units in higher ed. This link supports departmental scholarship budget reporting, IPEDS reporting, and donor fund ',
    `advancement_fund_id` BIGINT COMMENT 'Foreign key linking to advancement.advancement_fund. Business justification: Scholarships are disbursed from advancement funds; financial aid and advancement offices must reconcile scholarship award totals against advancement fund balances and spending policy distributions. Th',
    `cip_code_id` BIGINT COMMENT 'Foreign key linking to curriculum.cip_code. Business justification: Scholarships are frequently restricted by field of study (CIP code) — e.g., STEM scholarships, TEACH Grant-eligible fields. Financial aid eligibility determination, IPEDS reporting, and scholarship pa',
    `concentration_id` BIGINT COMMENT 'Foreign key linking to curriculum.concentration. Business justification: Some scholarships target specific concentrations within programs (e.g., "Cybersecurity Concentration Scholarship" within Computer Science program). While less common than program-level restrictions, c',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Scholarships are administered by specific academic departments or cost centers. This link supports departmental scholarship budget tracking, NACUBO functional expense reporting, and annual budget allo',
    `donor_id` BIGINT COMMENT 'Foreign key linking to advancement.donor. Business justification: Scholarships are established by donors; gift officers require the donor-to-scholarship link for stewardship reporting, gift restriction compliance, and renewal notifications. Higher-ed advancement off',
    `endowment_id` BIGINT COMMENT 'Foreign key reference to the endowment fund that supports this scholarship, if applicable. Links to the institutional endowment management system.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Scholarships post to specific GL revenue or expense accounts based on fund source (endowed, annual, restricted). Required for fund accounting, donor stewardship reporting, and financial statement prep',
    `instructor_id` BIGINT COMMENT 'Foreign key linking to faculty.instructor. Business justification: Departmental and endowed scholarships in higher education require a faculty nominator or selection committee chair. The scholarship product stores contact_name as a plain-text denormalization of this ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Institutional scholarships must be governed by documented policies defining eligibility criteria, selection process, renewal terms, and coordination rules. Policy reference ensures consistent administ',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Federally-funded scholarships (TEACH grants, state grant programs, SEOG) carry specific regulatory requirements governing eligibility, service obligations, and reporting. scholarship already has polic',
    `student_org_id` BIGINT COMMENT 'Foreign key linking to studentlife.student_org. Business justification: Many scholarships are restricted to members of specific student organizations (Greek life scholarships, club-specific awards, honor society scholarships). Business process: Scholarship eligibility ver',
    `academic_level` STRING COMMENT 'Academic level or degree program for which the scholarship is available. Restricts eligibility to undergraduate, graduate, doctoral, professional, or postdoctoral students, or allows any level.. Valid values are `undergraduate|graduate|doctoral|professional|postdoctoral|any`',
    `application_deadline` DATE COMMENT 'Final date by which students must submit scholarship applications or supporting materials to be considered for the award cycle.',
    `application_required_flag` BOOLEAN COMMENT 'Indicates whether students must submit a separate scholarship application to be considered, or if the scholarship is automatically awarded based on admission or FAFSA data.',
    `award_notification_date` DATE COMMENT 'Date on which scholarship recipients are notified of their award. Used for planning financial aid packaging timelines and student communication.',
    `class_standing` STRING COMMENT 'Specific class year or standing required for scholarship eligibility. May restrict awards to incoming freshmen, continuing sophomores, juniors, seniors, or graduate students.. Valid values are `freshman|sophomore|junior|senior|graduate|any`',
    `contact_email` STRING COMMENT 'Email address for scholarship inquiries and administration. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Phone number for scholarship inquiries and administration. Organizational contact data classified as confidential.. Valid values are `^+?[0-9]{10,15}$`',
    `coordination_rule` STRING COMMENT 'Rule governing how this scholarship interacts with other financial aid in the students award package. Determines whether the scholarship is stackable with other aid, reduces need-based aid, replaces loans, replaces work-study, or has no coordination requirements.. Valid values are `stackable|reduce_need|replace_loan|replace_work_study|no_coordination`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the scholarship record was first created in the system. Audit field for data lineage and compliance.',
    `effective_end_date` DATE COMMENT 'Date on which the scholarship program ends or is no longer available for new awards. Null for perpetual endowed scholarships or ongoing programs.',
    `effective_start_date` DATE COMMENT 'Date on which the scholarship becomes available for awarding. Marks the beginning of the scholarship programs active period.',
    `eligibility_criteria` STRING COMMENT 'Comprehensive description of all eligibility requirements for the scholarship, including academic qualifications, demographic criteria, residency requirements, major or program restrictions, financial need thresholds, and any other donor-specified or institutional criteria.',
    `endowment_flag` BOOLEAN COMMENT 'Indicates whether the scholarship is funded by an endowment with perpetual principal and annual earnings distribution, as opposed to annual or one-time funding.',
    `funding_source` STRING COMMENT 'Origin of the scholarship funds. Indicates whether the scholarship is funded by the institution, federal government, state government, private donor, corporation, foundation, alumni association, or endowment. [ENUM-REF-CANDIDATE: institutional|federal|state|private|corporate|foundation|alumni|endowment — 8 candidates stripped; promote to reference product]',
    `major_restriction` STRING COMMENT 'Academic major, program, or field of study required for scholarship eligibility. May specify a single major, a list of eligible majors, or a broad discipline such as STEM (Science Technology Engineering Mathematics) or business.',
    `maximum_award_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount that can be awarded to a single recipient per academic year or term. Used in financial aid packaging to cap individual awards.',
    `maximum_years_awarded` STRING COMMENT 'Maximum number of academic years a student may receive this scholarship, including initial award and renewals. Typically 4 for undergraduate scholarships, variable for graduate programs.',
    `merit_based_flag` BOOLEAN COMMENT 'Indicates whether the scholarship is awarded based on academic merit, standardized test scores, or other achievement criteria independent of financial need.',
    `minimum_award_amount` DECIMAL(18,2) COMMENT 'Minimum dollar amount that must be awarded if the scholarship is granted. Ensures awards meet donor or program requirements for minimum funding levels.',
    `minimum_credit_hours` STRING COMMENT 'Minimum number of credit hours per term that a student must be enrolled in to be eligible for or retain the scholarship. Typically used to enforce full-time or half-time enrollment requirements.',
    `minimum_gpa` DECIMAL(18,2) COMMENT 'Minimum cumulative or term GPA required for initial eligibility or renewal of the scholarship. Expressed on a 4.0 scale.',
    `need_based_flag` BOOLEAN COMMENT 'Indicates whether the scholarship requires demonstrated financial need as determined by FAFSA (Free Application for Federal Student Aid) and EFC (Expected Family Contribution) calculations.',
    `notes` STRING COMMENT 'Free-text field for internal administrative notes, special instructions, donor preferences, or historical context about the scholarship program. Not visible to students.',
    `renewable_flag` BOOLEAN COMMENT 'Indicates whether the scholarship can be renewed for multiple academic years if the recipient continues to meet eligibility criteria.',
    `renewal_criteria` STRING COMMENT 'Detailed description of the academic, enrollment, and behavioral requirements a student must maintain to renew the scholarship for subsequent years. May include minimum GPA, credit hour requirements, major continuation, and Satisfactory Academic Progress (SAP) standards.',
    `reporting_category` STRING COMMENT 'Classification of the scholarship for IPEDS (Integrated Postsecondary Education Data System) and other regulatory reporting purposes. Aligns with federal financial aid reporting categories.. Valid values are `institutional_grant|federal_grant|state_grant|private_scholarship|athletic_scholarship|other`',
    `residency_requirement` STRING COMMENT 'Geographic or residency restrictions for scholarship eligibility, such as state residency, county of origin, or international student status. May specify in-state, out-of-state, or specific geographic regions.',
    `scholarship_code` STRING COMMENT 'Externally-known unique code or identifier for the scholarship used in financial aid packaging and student communications. Business identifier for the scholarship.. Valid values are `^[A-Z0-9]{4,20}$`',
    `scholarship_name` STRING COMMENT 'Full official name of the scholarship or grant program as it appears in institutional publications and award letters.',
    `scholarship_status` STRING COMMENT 'Current lifecycle status of the scholarship. Indicates whether the scholarship is actively available for awarding, temporarily suspended, permanently discontinued, or pending approval for activation.. Valid values are `active|inactive|suspended|discontinued|pending_approval`',
    `scholarship_type` STRING COMMENT 'Classification of the scholarship by its primary awarding criteria and funding structure. Distinguishes merit-based, need-based, departmental, endowed, external/private, athletic, diversity, research, and service scholarships. [ENUM-REF-CANDIDATE: merit|need_based|departmental|endowed|external|athletic|diversity|research|service — 9 candidates stripped; promote to reference product]',
    `taxable_flag` BOOLEAN COMMENT 'Indicates whether the scholarship is considered taxable income under IRS regulations. Scholarships used for room, board, or non-qualified expenses may be taxable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the scholarship record was last modified. Audit field for tracking changes to scholarship terms, funding, or eligibility criteria.',
    `website_url` STRING COMMENT 'Web address for additional scholarship information, application instructions, and donor recognition. May link to institutional financial aid portal or external scholarship provider site.. Valid values are `^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$`',
    CONSTRAINT pk_scholarship PRIMARY KEY(`scholarship_id`)
) COMMENT 'Master catalog record for institutionally administered and externally sourced scholarships and grants, including merit-based, need-based, departmental, endowed, and outside/private scholarships. Captures scholarship name, funding source, eligibility criteria, renewable flag, renewal criteria, maximum award amount, donor/organization for external awards, and coordination rules for need-based aid packaging. SSOT for the institutional scholarship catalog and external scholarship registry.';

CREATE OR REPLACE TABLE `education_ecm`.`aid`.`veteran_benefit` (
    `veteran_benefit_id` BIGINT COMMENT 'Unique identifier for the veteran benefit record. Primary key for the veteran benefit entity.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: VA certification requires program-level tracking—each program must be VA-approved individually, benefits vary by program approval status, and SCOs must certify enrollment in specific approved programs',
    `award_package_id` BIGINT COMMENT 'Foreign key linking to aid.award_package. Business justification: Veteran education benefits are part of the overall financial aid package and should be coordinated with other aid. The veteran_benefit record should reference the award_package. This allows the instit',
    `award_year_id` BIGINT COMMENT 'Unique identifier for the financial aid award year during which the veteran benefit is active. Links to the award year reference table.',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: GI Bill Chapter 33 Monthly Housing Allowance is calculated using the campus ZIP code/BAH rate. School Certifying Officials must certify enrollment at a specific campus for VA enrollment certification ',
    `term_id` BIGINT COMMENT 'Unique identifier for the academic term for which enrollment was certified to the VA. Links to the term reference table in the Student Information System.',
    `course_section_id` BIGINT COMMENT 'Foreign key linking to instruction.course_section. Business justification: VA enrollment certification (VA Form 22-1999) requires SCOs to certify specific course sections, credit hours, and training time to the VA per term. veteran_benefit.certified_credit_hours and training',
    `employee_id` BIGINT COMMENT 'Unique identifier for the School Certifying Official who certified the students enrollment to the VA. Links to the employee or staff record responsible for VA certification compliance.',
    `enrollment_status_id` BIGINT COMMENT 'Foreign key linking to student.enrollment_status. Business justification: VA benefit certification requires official enrollment verification — the SCO must certify credit hours and training time against the official enrollment_status record. This is a named VA compliance pr',
    `housing_assignment_id` BIGINT COMMENT 'Foreign key linking to studentlife.housing_assignment. Business justification: VA benefits include Basic Allowance for Housing (BAH) calculated based on verified housing status and zip code. VA certification process requires documented housing assignment to determine correct BAH',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: VA benefit payments (Ch. 33, Ch. 30, VR&E) are posted to specific revenue ledger accounts for VA reconciliation, IPEDS revenue reporting, and institutional financial statements. SCOs and controllers r',
    `profile_id` BIGINT COMMENT 'Unique identifier for the student receiving veteran education benefits. Links to the student master record in the Student Information System (SIS).',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: VA enrollment certifications submitted via VA-ONCE are regulatory filings to the VA. veteran_benefit.certification_date and sco_remarks confirm this named filing process. SCOs must track which VA-ONCE',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: VA education benefits (Chapters 30, 33, 35) are governed by 38 CFR federal regulations distinct from Title IV. SCO certification requires compliance with specific VA regulatory requirements. veteran_b',
    `benefit_chapter` STRING COMMENT 'The specific VA education benefit program chapter under which the student is receiving benefits. CH33 = Post-9/11 GI Bill, CH30 = Montgomery GI Bill Active Duty, CH35 = Survivors and Dependents Educational Assistance, CH1606 = Montgomery GI Bill Selected Reserve, VRAP = Veteran Rapid Retraining Assistance Program.. Valid values are `CH33|CH30|CH35|CH1606|VRAP`',
    `benefit_percentage` DECIMAL(18,2) COMMENT 'The percentage of full benefit entitlement the student is eligible to receive, ranging from 0.00 to 100.00. For Post-9/11 GI Bill, determined by length of active duty service (e.g., 90 days = 40%, 36 months = 100%).',
    `benefit_status` STRING COMMENT 'Current lifecycle status of the veteran benefit. Active = currently receiving benefits, Pending = application submitted awaiting approval, Suspended = temporarily paused, Terminated = ended by student or institution, Exhausted = all benefit entitlement used, Denied = application rejected by VA.. Valid values are `active|pending|suspended|terminated|exhausted|denied`',
    `book_stipend_amount` DECIMAL(18,2) COMMENT 'The annual book and supplies stipend amount the student is eligible to receive under Post-9/11 GI Bill (CH33). Typically $1,000 per academic year, prorated based on training time and benefit percentage. Not applicable for other benefit chapters.',
    `certificate_of_eligibility_number` STRING COMMENT 'The unique certificate number issued by the Department of Veterans Affairs confirming the students eligibility for education benefits. Required for enrollment certification and benefit disbursement.',
    `certification_date` DATE COMMENT 'The date on which the School Certifying Official (SCO) certified the students enrollment to the VA for the current term. Required for VA payment processing and compliance tracking.',
    `certified_credit_hours` DECIMAL(18,2) COMMENT 'The number of credit hours certified to the VA for the current enrollment period. Used to determine the students training time (full-time, three-quarter-time, half-time) and corresponding benefit payment rate.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this veteran benefit record was first created in the system. Used for audit trail and data lineage tracking.',
    `delimiting_date` DATE COMMENT 'The final date by which the student must use their veteran education benefits. For Post-9/11 GI Bill, typically 15 years from the date of last discharge from active duty. After this date, unused benefits expire.',
    `eligibility_begin_date` DATE COMMENT 'The date on which the student becomes eligible to receive veteran education benefits under this benefit chapter. Typically corresponds to the service discharge date or eligibility determination date.',
    `eligibility_end_date` DATE COMMENT 'The date on which the students eligibility for veteran education benefits expires. For Post-9/11 GI Bill (CH33), typically 15 years from last discharge date. Null if no expiration or benefit exhausted before expiration.',
    `kicker_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the student is eligible for an additional monthly kicker payment (also known as College Fund) based on their military service agreement. True = kicker eligible, False = not eligible. Kicker is an additional benefit on top of standard GI Bill payments.',
    `kicker_monthly_amount` DECIMAL(18,2) COMMENT 'The additional monthly kicker payment amount the student is eligible to receive based on their military service agreement. Null if student is not kicker eligible.',
    `last_certification_change_date` DATE COMMENT 'The date of the most recent change to the students enrollment certification submitted to the VA. Changes may include enrollment status updates, credit hour adjustments, or program changes that affect benefit eligibility.',
    `last_certification_change_reason` STRING COMMENT 'Description of the reason for the most recent change to the students enrollment certification. Examples include course withdrawal, program change, enrollment status change, or correction of certification error.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this veteran benefit record was most recently updated. Used for audit trail, change tracking, and data synchronization purposes.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'The dollar amount of the most recent benefit payment disbursed by the VA for this student. Includes tuition, housing allowance, and book stipend components as applicable.',
    `last_payment_date` DATE COMMENT 'The date of the most recent benefit payment disbursed by the VA for this student. Used for payment tracking and reconciliation purposes.',
    `monthly_housing_allowance_amount` DECIMAL(18,2) COMMENT 'The monthly housing allowance amount the student is eligible to receive under Post-9/11 GI Bill (CH33). Amount is based on the Basic Allowance for Housing (BAH) rate for an E-5 with dependents at the institutions ZIP code. Not applicable for other benefit chapters.',
    `payment_status` STRING COMMENT 'Current status of the VA benefit payment for the certified enrollment period. Pending = certification submitted awaiting VA processing, In Progress = VA processing payment, Paid = payment completed and disbursed, Denied = payment rejected by VA, Suspended = payment temporarily halted.. Valid values are `pending|in_progress|paid|denied|suspended`',
    `remaining_entitlement_months` DECIMAL(18,2) COMMENT 'The number of months of benefit entitlement remaining for the student. Typically starts at 36 months for full-time enrollment and decreases based on certified enrollment hours. Tracked to two decimal places for partial month usage.',
    `sco_remarks` STRING COMMENT 'Free-text notes and remarks entered by the School Certifying Official regarding the students veteran benefit status, certification issues, special circumstances, or communication with the VA. Used for case management and compliance documentation.',
    `training_time` TIMESTAMP COMMENT 'The enrollment intensity classification for the student based on certified credit hours. Full-time = 12+ credits (undergraduate) or 9+ credits (graduate), Three-quarter-time = 9-11 credits (UG) or 7-8 credits (G), Half-time = 6-8 credits (UG) or 5-6 credits (G), Less-than-half-time = below half-time threshold.',
    `tuition_and_fees_paid_to_school` DECIMAL(18,2) COMMENT 'The total amount of tuition and fees paid directly to the institution by the VA on behalf of the student for the current enrollment period. For Post-9/11 GI Bill, capped at the in-state tuition rate for public institutions or the national maximum for private institutions.',
    `vocational_rehab_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the student is receiving benefits under the Vocational Rehabilitation and Employment (VR&E) program (Chapter 31) in addition to or instead of standard education benefits. True = VR&E participant, False = not VR&E participant.',
    `vr_and_e_counselor_email` STRING COMMENT 'The email address for the VA Vocational Rehabilitation Counselor assigned to the student. Null if student is not a VR&E participant.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vr_and_e_counselor_name` STRING COMMENT 'The name of the VA Vocational Rehabilitation Counselor assigned to the student. Null if student is not a VR&E participant.',
    `vr_and_e_counselor_phone` STRING COMMENT 'The contact phone number for the VA Vocational Rehabilitation Counselor assigned to the student. Null if student is not a VR&E participant.',
    `yellow_ribbon_institution_contribution` DECIMAL(18,2) COMMENT 'The amount the institution has agreed to contribute toward the students tuition and fees under the Yellow Ribbon Program. The VA matches this amount dollar-for-dollar. Null if student is not a Yellow Ribbon participant.',
    `yellow_ribbon_participant_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the student is participating in the Yellow Ribbon Program, which provides additional funding for tuition and fees exceeding the Post-9/11 GI Bill maximum benefit. True = participating, False = not participating. Only applicable to Post-9/11 GI Bill (CH33) recipients at 100% benefit level.',
    `yellow_ribbon_va_contribution` DECIMAL(18,2) COMMENT 'The amount the Department of Veterans Affairs contributes toward the students tuition and fees under the Yellow Ribbon Program, matching the institutions contribution. Null if student is not a Yellow Ribbon participant.',
    CONSTRAINT pk_veteran_benefit PRIMARY KEY(`veteran_benefit_id`)
) COMMENT 'Master record for students receiving veteran education benefits, including VA benefit chapter (Ch. 33 Post-9/11, Ch. 30 Montgomery GI Bill, Ch. 35, Ch. 1606, VR&E), certificate of eligibility, benefit percentage, enrollment certification details (certified hours, training time, certification date, certifying official), housing allowance, book stipend, Yellow Ribbon participation, and VA payment status. SSOT for veteran benefit administration, enrollment certification, and SCO compliance under 38 U.S.C.';

CREATE OR REPLACE TABLE `education_ecm`.`aid`.`award_year` (
    `award_year_id` BIGINT COMMENT 'Primary key for award_year',
    `prior_award_year_id` BIGINT COMMENT 'Self-referencing FK on award_year (prior_award_year_id)',
    `academic_year_end_date` DATE COMMENT 'The end date of the academic calendar year associated with this award year.',
    `academic_year_start_date` DATE COMMENT 'The start date of the academic calendar year associated with this award year, which may differ from the financial aid award year start date.',
    `application_deadline_date` DATE COMMENT 'The priority deadline date for students to submit financial aid applications for this award year.',
    `application_open_date` DATE COMMENT 'The date when financial aid applications open for this award year.',
    `award_year_code` STRING COMMENT 'Business identifier for the award year in format YYYY-YYYY (e.g., 2023-2024). This is the externally-known code used across financial aid operations.',
    `award_year_description` STRING COMMENT 'Detailed description or notes about this award year including any special considerations, policy changes, or operational notes.',
    `award_year_name` STRING COMMENT 'Human-readable name or label for the award year (e.g., Academic Year 2023-2024).',
    `award_year_status` STRING COMMENT 'Current lifecycle status of the award year indicating whether it is currently in use for financial aid processing.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this award year record was first created in the system.',
    `default_cost_of_attendance_amount` DECIMAL(18,2) COMMENT 'The default or baseline cost of attendance amount used for financial aid calculations for this award year before student-specific adjustments.',
    `direct_subsidized_loan_annual_limit` DECIMAL(18,2) COMMENT 'The annual borrowing limit for Direct Subsidized Loans for dependent undergraduate students in this award year.',
    `direct_unsubsidized_loan_annual_limit` DECIMAL(18,2) COMMENT 'The annual borrowing limit for Direct Unsubsidized Loans for undergraduate students in this award year.',
    `disbursement_end_date` DATE COMMENT 'The latest date financial aid disbursements can be made for this award year.',
    `disbursement_start_date` DATE COMMENT 'The earliest date financial aid disbursements can be made for this award year.',
    `end_date` DATE COMMENT 'The date when the award year ends and financial aid processing concludes for this period.',
    `enrollment_end_date` DATE COMMENT 'The latest date students can be enrolled for terms within this award year.',
    `enrollment_start_date` DATE COMMENT 'The earliest date students can begin enrollment for terms within this award year.',
    `fafsa_cycle_code` STRING COMMENT 'FAFSA processing cycle identifier associated with this award year for federal aid application processing.',
    `federal_award_year_code` STRING COMMENT 'Four-digit federal award year code used for Title IV federal student aid reporting and FAFSA processing (e.g., 2024 for the 2023-2024 award year).',
    `federal_pell_maximum_amount` DECIMAL(18,2) COMMENT 'The maximum Federal Pell Grant award amount available for this award year as determined by federal regulations.',
    `is_current_year` BOOLEAN COMMENT 'Boolean flag indicating whether this is the current active award year for financial aid operations.',
    `is_default_year` BOOLEAN COMMENT 'Boolean flag indicating whether this award year should be used as the default selection in financial aid systems.',
    `packaging_end_date` DATE COMMENT 'The date when financial aid packaging operations conclude for this award year.',
    `packaging_start_date` DATE COMMENT 'The date when financial aid packaging operations begin for this award year.',
    `r2t4_calculation_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether Return to Title IV calculations are enabled and required for withdrawals in this award year.',
    `sap_evaluation_required` BOOLEAN COMMENT 'Boolean flag indicating whether Satisfactory Academic Progress evaluation is required for students receiving aid in this award year.',
    `sort_order` STRING COMMENT 'Numeric value used to control the display order of award years in user interfaces and reports, with lower values appearing first.',
    `start_date` DATE COMMENT 'The date when the award year becomes effective and financial aid processing begins for this period.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this award year record was last modified in the system.',
    `verification_deadline_date` DATE COMMENT 'The deadline date by which students must complete verification requirements for this award year.',
    CONSTRAINT pk_award_year PRIMARY KEY(`award_year_id`)
) COMMENT 'Master reference table for award_year. Referenced by award_year_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_award_package_id` FOREIGN KEY (`award_package_id`) REFERENCES `education_ecm`.`aid`.`award_package`(`award_package_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_award_year_id` FOREIGN KEY (`award_year_id`) REFERENCES `education_ecm`.`aid`.`award_year`(`award_year_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_coa_budget_id` FOREIGN KEY (`coa_budget_id`) REFERENCES `education_ecm`.`aid`.`coa_budget`(`coa_budget_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_isir_record_id` FOREIGN KEY (`isir_record_id`) REFERENCES `education_ecm`.`aid`.`isir_record`(`isir_record_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_application` ADD CONSTRAINT `fk_aid_aid_application_verification_id` FOREIGN KEY (`verification_id`) REFERENCES `education_ecm`.`aid`.`verification`(`verification_id`);
ALTER TABLE `education_ecm`.`aid`.`award_package` ADD CONSTRAINT `fk_aid_award_package_award_year_id` FOREIGN KEY (`award_year_id`) REFERENCES `education_ecm`.`aid`.`award_year`(`award_year_id`);
ALTER TABLE `education_ecm`.`aid`.`award_package` ADD CONSTRAINT `fk_aid_award_package_coa_budget_id` FOREIGN KEY (`coa_budget_id`) REFERENCES `education_ecm`.`aid`.`coa_budget`(`coa_budget_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_aid_fund_id` FOREIGN KEY (`aid_fund_id`) REFERENCES `education_ecm`.`aid`.`aid_fund`(`aid_fund_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_award_package_id` FOREIGN KEY (`award_package_id`) REFERENCES `education_ecm`.`aid`.`award_package`(`award_package_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_award_year_id` FOREIGN KEY (`award_year_id`) REFERENCES `education_ecm`.`aid`.`award_year`(`award_year_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_award` ADD CONSTRAINT `fk_aid_aid_award_coa_budget_id` FOREIGN KEY (`coa_budget_id`) REFERENCES `education_ecm`.`aid`.`coa_budget`(`coa_budget_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_aid_award_id` FOREIGN KEY (`aid_award_id`) REFERENCES `education_ecm`.`aid`.`aid_award`(`aid_award_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_aid_fund_id` FOREIGN KEY (`aid_fund_id`) REFERENCES `education_ecm`.`aid`.`aid_fund`(`aid_fund_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_award_year_id` FOREIGN KEY (`award_year_id`) REFERENCES `education_ecm`.`aid`.`award_year`(`award_year_id`);
ALTER TABLE `education_ecm`.`aid`.`disbursement` ADD CONSTRAINT `fk_aid_disbursement_loan_record_id` FOREIGN KEY (`loan_record_id`) REFERENCES `education_ecm`.`aid`.`loan_record`(`loan_record_id`);
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ADD CONSTRAINT `fk_aid_aid_fund_award_year_id` FOREIGN KEY (`award_year_id`) REFERENCES `education_ecm`.`aid`.`award_year`(`award_year_id`);
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ADD CONSTRAINT `fk_aid_coa_budget_award_year_id` FOREIGN KEY (`award_year_id`) REFERENCES `education_ecm`.`aid`.`award_year`(`award_year_id`);
ALTER TABLE `education_ecm`.`aid`.`isir_record` ADD CONSTRAINT `fk_aid_isir_record_award_year_id` FOREIGN KEY (`award_year_id`) REFERENCES `education_ecm`.`aid`.`award_year`(`award_year_id`);
ALTER TABLE `education_ecm`.`aid`.`verification` ADD CONSTRAINT `fk_aid_verification_award_year_id` FOREIGN KEY (`award_year_id`) REFERENCES `education_ecm`.`aid`.`award_year`(`award_year_id`);
ALTER TABLE `education_ecm`.`aid`.`verification` ADD CONSTRAINT `fk_aid_verification_isir_record_id` FOREIGN KEY (`isir_record_id`) REFERENCES `education_ecm`.`aid`.`isir_record`(`isir_record_id`);
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ADD CONSTRAINT `fk_aid_sap_evaluation_award_year_id` FOREIGN KEY (`award_year_id`) REFERENCES `education_ecm`.`aid`.`award_year`(`award_year_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_aid_award_id` FOREIGN KEY (`aid_award_id`) REFERENCES `education_ecm`.`aid`.`aid_award`(`aid_award_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_award_year_id` FOREIGN KEY (`award_year_id`) REFERENCES `education_ecm`.`aid`.`award_year`(`award_year_id`);
ALTER TABLE `education_ecm`.`aid`.`loan_record` ADD CONSTRAINT `fk_aid_loan_record_coa_budget_id` FOREIGN KEY (`coa_budget_id`) REFERENCES `education_ecm`.`aid`.`coa_budget`(`coa_budget_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_award_package_id` FOREIGN KEY (`award_package_id`) REFERENCES `education_ecm`.`aid`.`award_package`(`award_package_id`);
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ADD CONSTRAINT `fk_aid_veteran_benefit_award_year_id` FOREIGN KEY (`award_year_id`) REFERENCES `education_ecm`.`aid`.`award_year`(`award_year_id`);
ALTER TABLE `education_ecm`.`aid`.`award_year` ADD CONSTRAINT `fk_aid_award_year_prior_award_year_id` FOREIGN KEY (`prior_award_year_id`) REFERENCES `education_ecm`.`aid`.`award_year`(`award_year_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`aid` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `education_ecm`.`aid` SET TAGS ('dbx_domain' = 'aid');
ALTER TABLE `education_ecm`.`aid`.`aid_application` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`aid`.`aid_application` SET TAGS ('dbx_subdomain' = 'application_eligibility');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `aid_application_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Application ID');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `award_package_id` SET TAGS ('dbx_business_glossary_term' = 'Award Package Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `award_year_id` SET TAGS ('dbx_business_glossary_term' = 'Award Year ID');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `coa_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Budget Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Faculty Advisor Instructor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `isir_record_id` SET TAGS ('dbx_business_glossary_term' = 'Isir Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `building_id` SET TAGS ('dbx_business_glossary_term' = 'Residence Building Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `residency_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Residency Classification Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `verification_id` SET TAGS ('dbx_business_glossary_term' = 'Verification Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `visa_immigration_id` SET TAGS ('dbx_business_glossary_term' = 'Visa Immigration Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `aggregate_loan_limit_flag` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Loan Limit Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `c_code_flag` SET TAGS ('dbx_business_glossary_term' = 'C-Code (Comment Code) Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `coa_amount` SET TAGS ('dbx_business_glossary_term' = 'COA (Cost of Attendance) Amount');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Created Timestamp');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `default_overpayment_flag` SET TAGS ('dbx_business_glossary_term' = 'Default or Overpayment Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `direct_loan_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Loan Eligible Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `drug_conviction_flag` SET TAGS ('dbx_business_glossary_term' = 'Drug Conviction Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `enrollment_intensity` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Intensity');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `enrollment_intensity` SET TAGS ('dbx_value_regex' = 'full_time|three_quarter_time|half_time|less_than_half_time');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `fafsa_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'FAFSA (Free Application for Federal Student Aid) Receipt Date');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `financial_need_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Need Amount');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `housing_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Housing Plan Code');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `housing_plan_code` SET TAGS ('dbx_value_regex' = 'on_campus|off_campus|with_parents');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `institutional_methodology_efc` SET TAGS ('dbx_business_glossary_term' = 'Institutional Methodology EFC (Expected Family Contribution)');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `pell_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Pell Grant Eligible Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `pell_leu_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pell LEU (Lifetime Eligibility Used) Percentage');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `professional_judgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Professional Judgment Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `professional_judgment_reason` SET TAGS ('dbx_business_glossary_term' = 'Professional Judgment Reason');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `selective_service_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Selective Service Compliance Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `state_aid_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'State Aid Eligible Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submitted Date');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `unusual_enrollment_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Unusual Enrollment History Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Updated Timestamp');
ALTER TABLE `education_ecm`.`aid`.`aid_application` ALTER COLUMN `veteran_benefits_flag` SET TAGS ('dbx_business_glossary_term' = 'Veteran Benefits Flag');
ALTER TABLE `education_ecm`.`aid`.`award_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`aid`.`award_package` SET TAGS ('dbx_subdomain' = 'award_disbursement');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `award_package_id` SET TAGS ('dbx_business_glossary_term' = 'Award Package ID');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `award_year_id` SET TAGS ('dbx_business_glossary_term' = 'Award Year ID');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `coa_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Cost of Attendance (COA) Budget ID');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Counselor ID');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `default_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Default Status Flag');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `demonstrated_need_amount` SET TAGS ('dbx_business_glossary_term' = 'Demonstrated Need Amount');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `dependency_status` SET TAGS ('dbx_business_glossary_term' = 'Dependency Status');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `dependency_status` SET TAGS ('dbx_value_regex' = 'dependent|independent');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `efc_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Family Contribution (EFC) Amount');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'full_time|three_quarter_time|half_time|less_than_half_time');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `housing_status` SET TAGS ('dbx_business_glossary_term' = 'Housing Status');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `housing_status` SET TAGS ('dbx_value_regex' = 'on_campus|off_campus|with_parents');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `last_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Last Revision Date');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `offer_letter_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Letter Sent Date');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `overaward_amount` SET TAGS ('dbx_business_glossary_term' = 'Overaward Amount');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `overaward_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Overaward Detected Flag');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `overaward_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Overaward Resolution Date');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `overaward_resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Overaward Resolution Status');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `overaward_resolution_status` SET TAGS ('dbx_value_regex' = 'none|pending|resolved|waived');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `package_number` SET TAGS ('dbx_business_glossary_term' = 'Package Number');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `package_status` SET TAGS ('dbx_value_regex' = 'proposed|accepted|revised|cancelled|disbursed|completed');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `packaging_date` SET TAGS ('dbx_business_glossary_term' = 'Packaging Date');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `packaging_methodology` SET TAGS ('dbx_business_glossary_term' = 'Packaging Methodology');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `packaging_methodology` SET TAGS ('dbx_value_regex' = 'need_based|merit_based|hybrid|athletic|departmental|external');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `pell_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Pell Eligible Flag');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `pell_lifetime_eligibility_used_percent` SET TAGS ('dbx_business_glossary_term' = 'Pell Lifetime Eligibility Used Percent');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `professional_judgment_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Professional Judgment Applied Flag');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `professional_judgment_reason` SET TAGS ('dbx_business_glossary_term' = 'Professional Judgment Reason');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `sap_status` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Status');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `sap_status` SET TAGS ('dbx_value_regex' = 'meeting|warning|suspension|probation|appeal_approved');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `student_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Student Acceptance Date');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `total_awarded_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Awarded Amount');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `total_coa_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cost of Attendance (COA) Amount');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `total_grant_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Grant Amount');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `total_loan_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Loan Amount');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `total_scholarship_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Scholarship Amount');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `total_work_study_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Work-Study Amount');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `unmet_need_amount` SET TAGS ('dbx_business_glossary_term' = 'Unmet Need Amount');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `verification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Completion Date');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `education_ecm`.`aid`.`award_package` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'not_selected|selected|in_progress|completed|waived');
ALTER TABLE `education_ecm`.`aid`.`aid_award` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`aid`.`aid_award` SET TAGS ('dbx_subdomain' = 'award_disbursement');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `aid_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Identifier');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `aid_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `award_package_id` SET TAGS ('dbx_business_glossary_term' = 'Award Package Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `award_year_id` SET TAGS ('dbx_business_glossary_term' = 'Award Year Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `coa_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Cost of Attendance (COA) ID');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Period ID');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `accepted_amount` SET TAGS ('dbx_business_glossary_term' = 'Accepted Amount');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `award_number` SET TAGS ('dbx_business_glossary_term' = 'Award Number');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `cancelled_amount` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Amount');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Award Comments');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `disbursed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursed Amount');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `efc_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Family Contribution (EFC) Amount');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `enrollment_status_requirement` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status Requirement');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `enrollment_status_requirement` SET TAGS ('dbx_value_regex' = 'full_time|three_quarter_time|half_time|less_than_half_time|any');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `federal_fund_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Fund Code');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `first_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'First Disbursement Date');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `last_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Disbursement Date');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `loan_period_begin_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Period Begin Date');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `loan_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Period End Date');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `need_based_flag` SET TAGS ('dbx_business_glossary_term' = 'Need-Based Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `offered_amount` SET TAGS ('dbx_business_glossary_term' = 'Offered Amount');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `origination_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Origination Fee Amount');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `packaging_group` SET TAGS ('dbx_business_glossary_term' = 'Packaging Group');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Award Priority');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `remaining_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Amount');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `renewable_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `sap_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Requirement Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `self_help_flag` SET TAGS ('dbx_business_glossary_term' = 'Self-Help Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `subsidized_flag` SET TAGS ('dbx_business_glossary_term' = 'Subsidized Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `education_ecm`.`aid`.`aid_award` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`aid`.`disbursement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`aid`.`disbursement` SET TAGS ('dbx_subdomain' = 'award_disbursement');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement ID');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `aid_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `aid_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Source ID');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `award_year_id` SET TAGS ('dbx_business_glossary_term' = 'Aid Year ID');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By User ID');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `hold_id` SET TAGS ('dbx_business_glossary_term' = 'Hold Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `attendance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Lda Attendance Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `leave_of_absence_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Of Absence Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `loan_record_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `statement_id` SET TAGS ('dbx_business_glossary_term' = 'Statement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Term ID');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `anticipated_disbursement_flag` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Disbursement Flag');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Channel');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'student_account_system|bank_transfer|third_party_servicer|refund_processor');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `coa_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Attendance (COA) Amount');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `cod_reporting_date` SET TAGS ('dbx_business_glossary_term' = 'Common Origination and Disbursement (COD) Reporting Date');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `cod_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Common Origination and Disbursement (COD) Reporting Flag');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Method');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_value_regex' = 'credit_to_account|electronic_funds_transfer|paper_check|direct_deposit');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `disbursement_number` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Number');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Status');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_value_regex' = 'pending|approved|released|cancelled|returned|adjusted');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `efc_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Family Contribution (EFC) Amount');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Hold Flag');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `hold_release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `late_disbursement_flag` SET TAGS ('dbx_business_glossary_term' = 'Late Disbursement Flag');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Disbursement Amount');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Notes');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `nslds_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'National Student Loan Data System (NSLDS) Reporting Flag');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `origination_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Origination Fee Amount');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `period_begin_date` SET TAGS ('dbx_business_glossary_term' = 'Period Begin Date');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `sap_status_at_disbursement` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Status at Disbursement');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `sap_status_at_disbursement` SET TAGS ('dbx_value_regex' = 'meeting|warning|suspension|probation');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `scheduled_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Disbursement Date');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `sequence` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Sequence Number');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'BANNER|WORKDAY|PEOPLESOFT|MANUAL');
ALTER TABLE `education_ecm`.`aid`.`disbursement` ALTER COLUMN `title_iv_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Title IV Eligible Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` SET TAGS ('dbx_subdomain' = 'award_disbursement');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `aid_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Identifier');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `award_year_id` SET TAGS ('dbx_business_glossary_term' = 'Award Year Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `cip_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Code Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `endowment_id` SET TAGS ('dbx_business_glossary_term' = 'Endowment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `academic_level_requirement` SET TAGS ('dbx_business_glossary_term' = 'Academic Level Requirement');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `academic_level_requirement` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|professional|doctoral|any');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `annual_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Allocation Amount');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `cfda_number` SET TAGS ('dbx_business_glossary_term' = 'Catalog of Federal Domestic Assistance (CFDA) Number');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `cfda_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}.[0-9]{3}$');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `citizenship_requirement` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Requirement');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `citizenship_requirement` SET TAGS ('dbx_value_regex' = 'us_citizen|eligible_noncitizen|permanent_resident|international|any');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `citizenship_requirement` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `citizenship_requirement` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `coa_component_restriction` SET TAGS ('dbx_business_glossary_term' = 'Cost of Attendance (COA) Component Restriction');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `disbursement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Frequency');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `disbursement_frequency` SET TAGS ('dbx_value_regex' = 'one_time|per_term|per_semester|monthly|biweekly');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Method');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_value_regex' = 'direct_to_student|applied_to_account|employer_paid|third_party');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `donor_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Donor Restrictions');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Effective Date');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `endowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Endowed Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `enrollment_status_requirement` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status Requirement');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `enrollment_status_requirement` SET TAGS ('dbx_value_regex' = 'full_time|three_quarter_time|half_time|less_than_half_time|any');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Fund Expiration Date');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `fund_category` SET TAGS ('dbx_business_glossary_term' = 'Fund Category');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `fund_category` SET TAGS ('dbx_value_regex' = 'grant|loan|scholarship|work_study|fellowship|assistantship');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `fund_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `fund_description` SET TAGS ('dbx_business_glossary_term' = 'Fund Description');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `fund_name` SET TAGS ('dbx_business_glossary_term' = 'Fund Name');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_business_glossary_term' = 'Fund Status');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `fund_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|depleted|pending_approval|closed');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Type');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `fund_type` SET TAGS ('dbx_value_regex' = 'federal|state|institutional|private|external');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `gpa_requirement` SET TAGS ('dbx_business_glossary_term' = 'Grade Point Average (GPA) Requirement');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `matching_percentage` SET TAGS ('dbx_business_glossary_term' = 'Matching Percentage');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `matching_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Matching Requirement Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `maximum_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Award Amount');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `maximum_years_eligible` SET TAGS ('dbx_business_glossary_term' = 'Maximum Years Eligible');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `merit_based_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit-Based Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `minimum_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Award Amount');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `need_based_flag` SET TAGS ('dbx_business_glossary_term' = 'Need-Based Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `payout_rate` SET TAGS ('dbx_business_glossary_term' = 'Payout Rate');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `refundable_flag` SET TAGS ('dbx_business_glossary_term' = 'Refundable Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `regulatory_program_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program Code');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `regulatory_program_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `remaining_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance Amount');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `renewable_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Reporting Category');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `residency_requirement` SET TAGS ('dbx_business_glossary_term' = 'Residency Requirement');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `sap_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Satisfactory Academic Progress (SAP) Required Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `self_help_flag` SET TAGS ('dbx_business_glossary_term' = 'Self-Help Flag');
ALTER TABLE `education_ecm`.`aid`.`aid_fund` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` SET TAGS ('dbx_subdomain' = 'application_eligibility');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `coa_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Cost of Attendance (COA) Budget ID');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program ID');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `award_year_id` SET TAGS ('dbx_business_glossary_term' = 'Award Year ID');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `dining_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Dining Plan Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `academic_level` SET TAGS ('dbx_business_glossary_term' = 'Academic Level');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `academic_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|professional|post_baccalaureate|doctoral|certificate');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `books_supplies_amount` SET TAGS ('dbx_business_glossary_term' = 'Books and Supplies Amount');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `budget_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Description');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `budget_name` SET TAGS ('dbx_business_glossary_term' = 'Budget Name');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|active|superseded|archived');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `credit_hour_maximum` SET TAGS ('dbx_business_glossary_term' = 'Credit Hour (CR) Maximum');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `credit_hour_minimum` SET TAGS ('dbx_business_glossary_term' = 'Credit Hour (CR) Minimum');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `dependency_status` SET TAGS ('dbx_business_glossary_term' = 'Dependency Status');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `dependency_status` SET TAGS ('dbx_value_regex' = 'dependent|independent');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `dependent_care_amount` SET TAGS ('dbx_business_glossary_term' = 'Dependent Care Amount');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `disability_expenses_amount` SET TAGS ('dbx_business_glossary_term' = 'Disability-Related Expenses Amount');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `disability_expenses_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `disability_expenses_amount` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'full_time|three_quarter_time|half_time|less_than_half_time');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `federal_methodology_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Methodology Flag');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `housing_type` SET TAGS ('dbx_business_glossary_term' = 'Housing Type');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `housing_type` SET TAGS ('dbx_value_regex' = 'on_campus|off_campus|with_parents');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `institutional_methodology_flag` SET TAGS ('dbx_business_glossary_term' = 'Institutional Methodology Flag');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `loan_fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Loan Fees Amount');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `personal_expenses_amount` SET TAGS ('dbx_business_glossary_term' = 'Personal Expenses Amount');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `professional_licensure_amount` SET TAGS ('dbx_business_glossary_term' = 'Professional Licensure and Certification Amount');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `residency_status` SET TAGS ('dbx_business_glossary_term' = 'Residency Status');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `residency_status` SET TAGS ('dbx_value_regex' = 'in_state|out_of_state|international');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `room_board_amount` SET TAGS ('dbx_business_glossary_term' = 'Room and Board Amount');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `study_abroad_amount` SET TAGS ('dbx_business_glossary_term' = 'Study Abroad Additional Amount');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `term_type` SET TAGS ('dbx_business_glossary_term' = 'Term Type');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `term_type` SET TAGS ('dbx_value_regex' = 'academic_year|fall_semester|spring_semester|summer_session|quarter|trimester');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `total_coa_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Cost of Attendance (COA) Amount');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `transportation_amount` SET TAGS ('dbx_business_glossary_term' = 'Transportation Amount');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `tuition_fees_amount` SET TAGS ('dbx_business_glossary_term' = 'Tuition and Fees Amount');
ALTER TABLE `education_ecm`.`aid`.`coa_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`aid`.`isir_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`aid`.`isir_record` SET TAGS ('dbx_subdomain' = 'application_eligibility');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `isir_record_id` SET TAGS ('dbx_business_glossary_term' = 'Institutional Student Information Record (ISIR) ID');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `award_year_id` SET TAGS ('dbx_business_glossary_term' = 'Award Year Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `automatic_zero_efc_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Zero Expected Family Contribution (EFC) Flag');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_business_glossary_term' = 'Citizenship Status');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_value_regex' = 'citizen|eligible_noncitizen|other');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `citizenship_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `comment_codes` SET TAGS ('dbx_business_glossary_term' = 'Comment Codes');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `correction_flag` SET TAGS ('dbx_business_glossary_term' = 'Correction Flag');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `cps_version` SET TAGS ('dbx_business_glossary_term' = 'Central Processing System (CPS) Version');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `cps_version` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Student Date of Birth');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `dependency_status` SET TAGS ('dbx_business_glossary_term' = 'Dependency Status');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `dependency_status` SET TAGS ('dbx_value_regex' = 'dependent|independent');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `efc` SET TAGS ('dbx_business_glossary_term' = 'Expected Family Contribution (EFC)');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `fafsa_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Free Application for Federal Student Aid (FAFSA) Signature Date');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `household_size` SET TAGS ('dbx_business_glossary_term' = 'Household Size');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `isir_source` SET TAGS ('dbx_business_glossary_term' = 'ISIR Source Type');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `isir_source` SET TAGS ('dbx_value_regex' = 'original|correction|renewal');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `marital_status` SET TAGS ('dbx_business_glossary_term' = 'Student Marital Status');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `marital_status` SET TAGS ('dbx_value_regex' = 'single|married|separated|divorced|widowed');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `number_in_college` SET TAGS ('dbx_business_glossary_term' = 'Number in College');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_agi` SET TAGS ('dbx_business_glossary_term' = 'Parent Adjusted Gross Income (AGI)');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_agi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_agi` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_cash_savings` SET TAGS ('dbx_business_glossary_term' = 'Parent Cash and Savings');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_cash_savings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_cash_savings` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_income_tax_paid` SET TAGS ('dbx_business_glossary_term' = 'Parent Income Tax Paid');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_income_tax_paid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_income_tax_paid` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_investment_net_worth` SET TAGS ('dbx_business_glossary_term' = 'Parent Investment Net Worth');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_investment_net_worth` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_investment_net_worth` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_marital_status` SET TAGS ('dbx_business_glossary_term' = 'Parent Marital Status');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_marital_status` SET TAGS ('dbx_value_regex' = 'married|remarried|single|divorced|separated|widowed');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_marital_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_marital_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_untaxed_income` SET TAGS ('dbx_business_glossary_term' = 'Parent Untaxed Income');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_untaxed_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `parent_untaxed_income` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `pell_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Pell Grant Eligibility Flag');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `processed_date` SET TAGS ('dbx_business_glossary_term' = 'ISIR Processed Date');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `professional_judgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Professional Judgment Flag');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'ISIR Received Date');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `reject_reason_codes` SET TAGS ('dbx_business_glossary_term' = 'Reject Reason Codes');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `sai` SET TAGS ('dbx_business_glossary_term' = 'Student Aid Index (SAI)');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `simplified_needs_test_flag` SET TAGS ('dbx_business_glossary_term' = 'Simplified Needs Test Flag');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `ssn` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `ssn` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `ssn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `ssn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `state_of_legal_residence` SET TAGS ('dbx_business_glossary_term' = 'State of Legal Residence');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `state_of_legal_residence` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_agi` SET TAGS ('dbx_business_glossary_term' = 'Student Adjusted Gross Income (AGI)');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_agi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_agi` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_cash_savings` SET TAGS ('dbx_business_glossary_term' = 'Student Cash and Savings');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_cash_savings` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_cash_savings` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_income_tax_paid` SET TAGS ('dbx_business_glossary_term' = 'Student Income Tax Paid');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_income_tax_paid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_income_tax_paid` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_investment_net_worth` SET TAGS ('dbx_business_glossary_term' = 'Student Investment Net Worth');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_investment_net_worth` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_investment_net_worth` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_untaxed_income` SET TAGS ('dbx_business_glossary_term' = 'Student Untaxed Income');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_untaxed_income` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `student_untaxed_income` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'ISIR Transaction Number');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `verification_selection_flag` SET TAGS ('dbx_business_glossary_term' = 'Verification Selection Flag');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `verification_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Verification Tracking Flag');
ALTER TABLE `education_ecm`.`aid`.`isir_record` ALTER COLUMN `verification_tracking_flag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{0,2}$');
ALTER TABLE `education_ecm`.`aid`.`verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`aid`.`verification` SET TAGS ('dbx_subdomain' = 'application_eligibility');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `verification_id` SET TAGS ('dbx_business_glossary_term' = 'Verification ID');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `award_year_id` SET TAGS ('dbx_business_glossary_term' = 'Award Year Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer User ID');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `isir_record_id` SET TAGS ('dbx_business_glossary_term' = 'Isir Record Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `child_support_paid_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Child Support Paid Verification Date');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Verification Comments');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Completion Date');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `conflicting_information_description` SET TAGS ('dbx_business_glossary_term' = 'Conflicting Information Description');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `conflicting_information_indicator` SET TAGS ('dbx_business_glossary_term' = 'Conflicting Information Indicator');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `correction_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'FAFSA (Free Application for Federal Student Aid) Correction Required Indicator');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `correction_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'FAFSA (Free Application for Federal Student Aid) Correction Submitted Date');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `dependency_override_date` SET TAGS ('dbx_business_glossary_term' = 'Dependency Override Date');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `dependency_override_indicator` SET TAGS ('dbx_business_glossary_term' = 'Dependency Override Indicator');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `dependency_override_reason` SET TAGS ('dbx_business_glossary_term' = 'Dependency Override Reason');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'Verification Exclusion Reason');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `high_school_completion_verification_date` SET TAGS ('dbx_business_glossary_term' = 'High School Completion Verification Date');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `household_size_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Household Size Verification Date');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `identity_verification_received_date` SET TAGS ('dbx_business_glossary_term' = 'Identity Verification Received Date');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `income_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Income Verification Method');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `income_verification_method` SET TAGS ('dbx_value_regex' = 'IRS_DRT|TAX_TRANSCRIPT|W2|1099|NOT_REQUIRED');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `number_in_college_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Number in College Verification Date');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `professional_judgment_date` SET TAGS ('dbx_business_glossary_term' = 'Professional Judgment (PJ) Date');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `professional_judgment_indicator` SET TAGS ('dbx_business_glossary_term' = 'Professional Judgment (PJ) Indicator');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `professional_judgment_reason` SET TAGS ('dbx_business_glossary_term' = 'Professional Judgment (PJ) Reason');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `selection_date` SET TAGS ('dbx_business_glossary_term' = 'Selection Date');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `selection_source` SET TAGS ('dbx_business_glossary_term' = 'Selection Source');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `selection_source` SET TAGS ('dbx_value_regex' = 'CPS|INSTITUTIONAL');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `snap_benefits_verification_date` SET TAGS ('dbx_business_glossary_term' = 'SNAP (Supplemental Nutrition Assistance Program) Benefits Verification Date');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `tax_transcript_received_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Transcript Received Date');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `tracking_group` SET TAGS ('dbx_business_glossary_term' = 'Verification Tracking Group');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `tracking_group` SET TAGS ('dbx_value_regex' = 'V1|V4|V5|V6|CUSTOM');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'PENDING|IN_PROGRESS|COMPLETED|WAIVED|EXCLUDED');
ALTER TABLE `education_ecm`.`aid`.`verification` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Verification Waiver Reason');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` SET TAGS ('dbx_subdomain' = 'application_eligibility');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `sap_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Sap Evaluation Identifier');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `academic_standing_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Standing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `advising_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Advising Assignment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `award_year_id` SET TAGS ('dbx_business_glossary_term' = 'Award Year Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `degree_progress_id` SET TAGS ('dbx_business_glossary_term' = 'Degree Progress Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Staff ID');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period ID');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `academic_plan_conditions` SET TAGS ('dbx_business_glossary_term' = 'Academic Plan Conditions');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `academic_plan_end_term` SET TAGS ('dbx_business_glossary_term' = 'Academic Plan End Term');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `academic_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Academic Plan Required Flag');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `academic_plan_start_term` SET TAGS ('dbx_business_glossary_term' = 'Academic Plan Start Term');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'SAP Appeal Date');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_business_glossary_term' = 'SAP Appeal Decision');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `appeal_decision` SET TAGS ('dbx_value_regex' = 'approved|denied|pending|withdrawn');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `appeal_decision_date` SET TAGS ('dbx_business_glossary_term' = 'SAP Appeal Decision Date');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `appeal_reason` SET TAGS ('dbx_business_glossary_term' = 'SAP Appeal Reason');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `appeal_reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'SAP Appeal Reviewer Name');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `appeal_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Submitted Flag');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'SAP Evaluation Comments');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `completion_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Rate Percentage');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `cumulative_credits_attempted` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Credits Attempted');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `cumulative_credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Credits Earned');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `cumulative_gpa` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'SAP Evaluation Date');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'SAP Evaluation Type');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_value_regex' = 'end_of_term|payment_period|annual|mid_term|appeal_review|reinstatement');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `financial_aid_eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Eligibility Status');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `financial_aid_eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|conditional');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `maximum_credits_allowed` SET TAGS ('dbx_business_glossary_term' = 'Maximum Credits Allowed');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `maximum_timeframe_status` SET TAGS ('dbx_business_glossary_term' = 'Maximum Timeframe Status');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `maximum_timeframe_status` SET TAGS ('dbx_value_regex' = 'within_limit|exceeded|not_applicable');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `minimum_completion_rate_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Completion Rate Required');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `minimum_gpa_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum GPA Required');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'SAP Notification Method');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|student_portal|in_person|phone');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'SAP Notification Sent Date');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `overall_sap_status` SET TAGS ('dbx_business_glossary_term' = 'Overall SAP Status');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `overall_sap_status` SET TAGS ('dbx_value_regex' = 'meeting|warning|suspension|probation|dismissed|reinstated');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `prior_sap_status` SET TAGS ('dbx_business_glossary_term' = 'Prior SAP Status');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `program_published_length` SET TAGS ('dbx_business_glossary_term' = 'Program Published Length');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `qualitative_measure_status` SET TAGS ('dbx_business_glossary_term' = 'Qualitative Measure Status');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `qualitative_measure_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `quantitative_measure_status` SET TAGS ('dbx_business_glossary_term' = 'Quantitative Measure Status');
ALTER TABLE `education_ecm`.`aid`.`sap_evaluation` ALTER COLUMN `quantitative_measure_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `education_ecm`.`aid`.`loan_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`aid`.`loan_record` SET TAGS ('dbx_subdomain' = 'loan_scholarship');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `loan_record_id` SET TAGS ('dbx_business_glossary_term' = 'Loan Record Identifier (ID)');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `aid_award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `ar_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Invoice Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `award_year_id` SET TAGS ('dbx_business_glossary_term' = 'Award Year Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Certifying Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `coa_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Budget Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `statement_id` SET TAGS ('dbx_business_glossary_term' = 'Statement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^d{4}-d{4}$');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `aggregate_loan_balance` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Loan Balance');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `aggregate_loan_limit` SET TAGS ('dbx_business_glossary_term' = 'Aggregate Loan Limit');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `anticipated_disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Disbursement Date');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `borrower_type` SET TAGS ('dbx_business_glossary_term' = 'Borrower Type');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `borrower_type` SET TAGS ('dbx_value_regex' = 'STUDENT|PARENT|GRADUATE_STUDENT');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_value_regex' = 'STUDENT_REQUEST|ELIGIBILITY_CHANGE|ENROLLMENT_CHANGE|DUPLICATE|OTHER');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `coa_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Attendance (COA) Amount');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `cod_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Common Origination and Disbursement (COD) Accepted Date');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `cod_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Common Origination and Disbursement (COD) Transaction Number');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `cod_transaction_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `credit_check_passed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Credit Check Passed Indicator');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `dependency_status` SET TAGS ('dbx_business_glossary_term' = 'Dependency Status');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `dependency_status` SET TAGS ('dbx_value_regex' = 'DEPENDENT|INDEPENDENT');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `disbursement_number` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Number');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `efc_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Family Contribution (EFC) Amount');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `endorser_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Endorser Required Indicator');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'FULL_TIME|THREE_QUARTER_TIME|HALF_TIME|LESS_THAN_HALF_TIME');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `entrance_counseling_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Entrance Counseling Completed Date');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `financial_need_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Need Amount');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `grade_level` SET TAGS ('dbx_business_glossary_term' = 'Grade Level');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `grade_level` SET TAGS ('dbx_value_regex' = 'UG_FRESHMAN|UG_SOPHOMORE|UG_JUNIOR|UG_SENIOR|GRAD|PROFESSIONAL');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `gross_loan_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Loan Amount');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `loan_number` SET TAGS ('dbx_business_glossary_term' = 'Loan Number');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `loan_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `loan_period_begin_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Period Begin Date');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `loan_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Period End Date');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `loan_servicer_code` SET TAGS ('dbx_business_glossary_term' = 'Loan Servicer Code');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `loan_servicer_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `loan_status` SET TAGS ('dbx_business_glossary_term' = 'Loan Status');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `loan_status` SET TAGS ('dbx_value_regex' = 'ORIGINATED|DISBURSED|CANCELLED|RETURNED|ADJUSTED');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `loan_type_code` SET TAGS ('dbx_business_glossary_term' = 'Loan Type Code');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `loan_type_code` SET TAGS ('dbx_value_regex' = 'SUB|UNSUB|PLUS_PARENT|PLUS_GRAD|PERKINS|PRIVATE');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `mpn_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Master Promissory Note (MPN) Signed Date');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `net_loan_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Loan Amount');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `nslds_reported_date` SET TAGS ('dbx_business_glossary_term' = 'National Student Loan Data System (NSLDS) Reported Date');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `origination_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Origination Date');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `origination_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Origination Fee Amount');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `subsidized_indicator` SET TAGS ('dbx_business_glossary_term' = 'Subsidized Indicator');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Term Code');
ALTER TABLE `education_ecm`.`aid`.`loan_record` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `education_ecm`.`aid`.`scholarship` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`aid`.`scholarship` SET TAGS ('dbx_subdomain' = 'loan_scholarship');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `scholarship_id` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Identifier (ID)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Employee Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Administering Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `advancement_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Advancement Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `cip_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Code Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `concentration_id` SET TAGS ('dbx_business_glossary_term' = 'Concentration Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `donor_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `endowment_id` SET TAGS ('dbx_business_glossary_term' = 'Endowment Identifier (ID)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `instructor_id` SET TAGS ('dbx_business_glossary_term' = 'Nominating Instructor Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `student_org_id` SET TAGS ('dbx_business_glossary_term' = 'Student Org Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `academic_level` SET TAGS ('dbx_business_glossary_term' = 'Academic Level');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `academic_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|doctoral|professional|postdoctoral|any');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `application_deadline` SET TAGS ('dbx_business_glossary_term' = 'Application Deadline');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `application_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Application Required Flag');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `award_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Award Notification Date');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `class_standing` SET TAGS ('dbx_business_glossary_term' = 'Class Standing');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `class_standing` SET TAGS ('dbx_value_regex' = 'freshman|sophomore|junior|senior|graduate|any');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `coordination_rule` SET TAGS ('dbx_business_glossary_term' = 'Coordination Rule');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `coordination_rule` SET TAGS ('dbx_value_regex' = 'stackable|reduce_need|replace_loan|replace_work_study|no_coordination');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `endowment_flag` SET TAGS ('dbx_business_glossary_term' = 'Endowment Flag');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `major_restriction` SET TAGS ('dbx_business_glossary_term' = 'Major or Program Restriction');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `maximum_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Award Amount');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `maximum_years_awarded` SET TAGS ('dbx_business_glossary_term' = 'Maximum Years Awarded');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `merit_based_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit-Based Flag');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `minimum_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Award Amount');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `minimum_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Credit Hours');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `minimum_gpa` SET TAGS ('dbx_business_glossary_term' = 'Minimum Grade Point Average (GPA)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `need_based_flag` SET TAGS ('dbx_business_glossary_term' = 'Need-Based Flag');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Administrative Notes');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `renewable_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Flag');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `renewal_criteria` SET TAGS ('dbx_business_glossary_term' = 'Renewal Criteria');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Reporting Category');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `reporting_category` SET TAGS ('dbx_value_regex' = 'institutional_grant|federal_grant|state_grant|private_scholarship|athletic_scholarship|other');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `residency_requirement` SET TAGS ('dbx_business_glossary_term' = 'Residency Requirement');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `scholarship_code` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Code');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `scholarship_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `scholarship_name` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Name');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `scholarship_status` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Status');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `scholarship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|discontinued|pending_approval');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `scholarship_type` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Type');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website Uniform Resource Locator (URL)');
ALTER TABLE `education_ecm`.`aid`.`scholarship` ALTER COLUMN `website_url` SET TAGS ('dbx_value_regex' = '^https?://[a-zA-Z0-9.-]+.[a-zA-Z]{2,}.*$');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` SET TAGS ('dbx_subdomain' = 'loan_scholarship');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `veteran_benefit_id` SET TAGS ('dbx_business_glossary_term' = 'Veteran Benefit Identifier (ID)');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `award_package_id` SET TAGS ('dbx_business_glossary_term' = 'Award Package Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `award_year_id` SET TAGS ('dbx_business_glossary_term' = 'Award Year Identifier (ID)');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Certification Term Identifier (ID)');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `course_section_id` SET TAGS ('dbx_business_glossary_term' = 'Certified Course Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'School Certifying Official (SCO) Identifier (ID)');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `enrollment_status_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `housing_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Housing Assignment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `benefit_chapter` SET TAGS ('dbx_business_glossary_term' = 'Veterans Affairs (VA) Benefit Chapter');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `benefit_chapter` SET TAGS ('dbx_value_regex' = 'CH33|CH30|CH35|CH1606|VRAP');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `benefit_percentage` SET TAGS ('dbx_business_glossary_term' = 'Benefit Entitlement Percentage');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `benefit_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Benefit Status');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `benefit_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|exhausted|denied');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `book_stipend_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Book Stipend Amount');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `certificate_of_eligibility_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Eligibility (COE) Number');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `certificate_of_eligibility_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `certificate_of_eligibility_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Certification Date');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `certified_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Certified Credit Hours');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `delimiting_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Delimiting Date');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `eligibility_begin_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Eligibility Begin Date');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `eligibility_end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Eligibility End Date');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `kicker_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Kicker Benefit Eligible Flag');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `kicker_monthly_amount` SET TAGS ('dbx_business_glossary_term' = 'Kicker Monthly Payment Amount');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `last_certification_change_date` SET TAGS ('dbx_business_glossary_term' = 'Last Certification Change Date');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `last_certification_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Last Certification Change Reason');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `monthly_housing_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Housing Allowance (MHA) Amount');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Veterans Affairs (VA) Payment Status');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|paid|denied|suspended');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `remaining_entitlement_months` SET TAGS ('dbx_business_glossary_term' = 'Remaining Entitlement Months');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `sco_remarks` SET TAGS ('dbx_business_glossary_term' = 'School Certifying Official (SCO) Remarks');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `training_time` SET TAGS ('dbx_business_glossary_term' = 'Training Time Status');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `tuition_and_fees_paid_to_school` SET TAGS ('dbx_business_glossary_term' = 'Tuition and Fees Paid to School Amount');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `vocational_rehab_flag` SET TAGS ('dbx_business_glossary_term' = 'Vocational Rehabilitation and Employment (VR&E) Flag');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `vr_and_e_counselor_email` SET TAGS ('dbx_business_glossary_term' = 'Vocational Rehabilitation and Employment (VR&E) Counselor Email Address');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `vr_and_e_counselor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `vr_and_e_counselor_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `vr_and_e_counselor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `vr_and_e_counselor_name` SET TAGS ('dbx_business_glossary_term' = 'Vocational Rehabilitation and Employment (VR&E) Counselor Name');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `vr_and_e_counselor_phone` SET TAGS ('dbx_business_glossary_term' = 'Vocational Rehabilitation and Employment (VR&E) Counselor Phone Number');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `vr_and_e_counselor_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `vr_and_e_counselor_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `yellow_ribbon_institution_contribution` SET TAGS ('dbx_business_glossary_term' = 'Yellow Ribbon Institution Contribution Amount');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `yellow_ribbon_participant_flag` SET TAGS ('dbx_business_glossary_term' = 'Yellow Ribbon Program Participant Flag');
ALTER TABLE `education_ecm`.`aid`.`veteran_benefit` ALTER COLUMN `yellow_ribbon_va_contribution` SET TAGS ('dbx_business_glossary_term' = 'Yellow Ribbon Veterans Affairs (VA) Contribution Amount');
ALTER TABLE `education_ecm`.`aid`.`award_year` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`aid`.`award_year` SET TAGS ('dbx_subdomain' = 'award_disbursement');
ALTER TABLE `education_ecm`.`aid`.`award_year` ALTER COLUMN `award_year_id` SET TAGS ('dbx_business_glossary_term' = 'Award Year Identifier');
ALTER TABLE `education_ecm`.`aid`.`award_year` ALTER COLUMN `prior_award_year_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `education_ecm`.`aid`.`award_year` ALTER COLUMN `default_cost_of_attendance_amount` SET TAGS ('dbx_confidential' = 'true');
