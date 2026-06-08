-- Schema for Domain: billing | Business: Education | Version: v1_mvm
-- Generated on: 2026-05-06 15:14:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `education_ecm`.`billing` COMMENT 'Administers student accounts, tuition and fee assessment, payment processing, refunds, collections, and 1098-T tax reporting. Manages billing cycles, payment plans, third-party billing, sponsor invoicing, account holds, and receivables management. SSOT for student financial obligations and payment history.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `education_ecm`.`billing`.`student_account` (
    `student_account_id` BIGINT COMMENT 'Unique identifier for the student account record within the bursar/student accounts office. Primary key for the student account entity. Serves as the parent identifier for all charges, payments, refunds, holds, and billing statements.',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Higher-ed AR control account reconciliation: each student account maps to a specific AR ledger account for GL aging reports, period-end AR reconciliation, and NACUBO financial reporting. Bursar and co',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Universities assign student accounts to a home campus for campus-differentiated billing rates, campus-specific fee assessment, and IPEDS enrollment reporting. A higher-ed billing expert would expect s',
    `payment_plan_id` BIGINT COMMENT 'Reference to the active payment plan record if the student is enrolled in an installment plan. Nullable if not enrolled in a payment plan.',
    `profile_id` BIGINT COMMENT 'Reference to the student who owns this financial account. Links to the student master record in the Student domain.',
    `sponsor_id` BIGINT COMMENT 'Reference to the third-party sponsor or employer organization that is responsible for paying charges on this account. Nullable if no third-party billing arrangement exists.',
    `vendor_id` BIGINT COMMENT 'Reference to the external collections agency assigned to this account if in external collections. Nullable if not in external collections.',
    `account_closed_date` DATE COMMENT 'Date when the student account was closed. Nullable for active accounts. Closed when student graduates, withdraws, or account is otherwise terminated.',
    `account_number` STRING COMMENT 'Externally-visible unique account number assigned to the student for billing and payment purposes. Used on billing statements, payment portals, and correspondence.. Valid values are `^[A-Z0-9]{8,12}$`',
    `account_opened_date` DATE COMMENT 'Date when the student account was first established in the student accounts system. Typically corresponds to the students initial enrollment or admission acceptance.',
    `account_status` STRING COMMENT 'Current lifecycle status of the student account. Active accounts are in good standing; suspended accounts have restrictions; closed accounts are no longer active; collections accounts are in debt recovery.. Valid values are `active|inactive|suspended|closed|hold|collections`',
    `account_type` STRING COMMENT 'Classification of the student account based on the students enrollment category. Determines applicable tuition rates, fee structures, and billing policies.. Valid values are `undergraduate|graduate|professional|continuing_education|non_degree|consortium`',
    `anticipated_balance` DECIMAL(18,2) COMMENT 'Projected account balance after all pending charges and pending financial aid are applied. Used for payment planning and financial counseling.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address where statements and correspondence are sent. Typically contains street number and name.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address for apartment, suite, or unit information. Nullable if not applicable.',
    `billing_city` STRING COMMENT 'City name for the billing address where statements and correspondence are sent.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO country code for the billing address. Uses ISO 3166-1 alpha-3 standard.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the billing address where statements and correspondence are sent.',
    `billing_state_province` STRING COMMENT 'State or province code for the billing address. Uses standard postal abbreviations.',
    `collections_placement_date` DATE COMMENT 'Date when the account was placed with an external collections agency. Nullable if never placed in external collections.',
    `collections_status` STRING COMMENT 'Current status of debt collection efforts for delinquent accounts. Tracks progression from internal collections through external agency placement and legal action.. Valid values are `not_in_collections|internal_collections|external_collections|legal_action|settled|written_off`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this student account record was first created in the system. Used for audit trail and data lineage.',
    `cumulative_adjustments` DECIMAL(18,2) COMMENT 'Total sum of all adjustments applied to the student account since inception. Includes waivers, write-offs, refunds, reversals, and other balance modifications.',
    `cumulative_charges` DECIMAL(18,2) COMMENT 'Total sum of all charges posted to the student account since inception. Includes tuition, fees, housing, meal plans, fines, and other assessments.',
    `cumulative_payments` DECIMAL(18,2) COMMENT 'Total sum of all payments received and applied to the student account since inception. Includes cash, check, credit card, electronic payments, and financial aid disbursements.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary amounts on this account. Uses ISO 4217 standard. Typically USD for U.S. institutions.. Valid values are `^[A-Z]{3}$`',
    `current_balance` DECIMAL(18,2) COMMENT 'Current outstanding balance on the student account. Positive values indicate amounts owed by the student; negative values indicate credit balances owed to the student. Calculated as cumulative charges minus cumulative payments and adjustments.',
    `has_graduation_hold` BOOLEAN COMMENT 'Indicates whether the student account has an active hold that prevents graduation or diploma issuance. True if graduation is blocked; false otherwise.',
    `has_registration_hold` BOOLEAN COMMENT 'Indicates whether the student account has an active hold that prevents course registration. True if registration is blocked; false otherwise.',
    `has_transcript_hold` BOOLEAN COMMENT 'Indicates whether the student account has an active hold that prevents transcript release. True if transcript release is blocked; false otherwise.',
    `hold_count` STRING COMMENT 'Number of active holds currently placed on the student account. Holds may prevent registration, transcript release, or graduation based on hold type.',
    `last_1098t_tax_year` STRING COMMENT 'Most recent tax year for which a 1098-T form was generated for this student account. Nullable if no 1098-T has been issued.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this student account record was most recently updated. Used for audit trail and change tracking.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment received and posted to the student account. Nullable if no payments have been received.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received and posted to the student account. Nullable if no payments have been received.',
    `last_statement_date` DATE COMMENT 'Date when the most recent billing statement was generated for this student account. Used to track billing cycle history.',
    `next_statement_date` DATE COMMENT 'Scheduled date for the next billing statement to be generated for this student account. Used for billing cycle planning and communication.',
    `payment_plan_enrolled` BOOLEAN COMMENT 'Indicates whether the student is currently enrolled in an installment payment plan. True if enrolled; false otherwise.',
    `pending_charges` DECIMAL(18,2) COMMENT 'Sum of charges that have been assessed but not yet posted to the account. Includes anticipated tuition and fees for upcoming terms that are in pre-billing status.',
    `pending_financial_aid` DECIMAL(18,2) COMMENT 'Sum of financial aid awards that have been packaged but not yet disbursed to the student account. Includes anticipated grants, loans, scholarships, and work-study.',
    `tax_form_1098t_eligible` BOOLEAN COMMENT 'Indicates whether the student account is eligible for IRS Form 1098-T reporting of qualified tuition and related expenses. True if eligible; false otherwise.',
    `third_party_billing_flag` BOOLEAN COMMENT 'Indicates whether charges on this account are billed to a third-party sponsor or employer rather than directly to the student. True if third-party billing is active; false otherwise.',
    CONSTRAINT pk_student_account PRIMARY KEY(`student_account_id`)
) COMMENT 'Master record for each students financial account within the bursar/student accounts office. Tracks account status, current balance, cumulative charges, cumulative payments, billing address, account type (undergraduate, graduate, professional), and overall financial standing. Serves as the parent entity for all charges, payments, refunds, holds, and billing statements. SSOT for student financial obligations and payment history in the billing domain.';

CREATE OR REPLACE TABLE `education_ecm`.`billing`.`tuition_charge` (
    `tuition_charge_id` BIGINT COMMENT 'Unique identifier for the tuition charge record. Primary key for the tuition charge entity.',
    `academic_program_id` BIGINT COMMENT 'Unique identifier of the academic program in which the student is enrolled. Used to determine program-specific tuition rates and fees.',
    `alumnus_id` BIGINT COMMENT 'Foreign key linking to advancement.alumnus. Business justification: Tuition charges for alumni taking non-degree courses, certificates, professional development, or lifelong learning programs. Essential for alumni program revenue tracking and continuing education bill',
    `benefit_plan_id` BIGINT COMMENT 'Foreign key linking to hr.benefit_plan. Business justification: When an employee or dependent uses a tuition waiver benefit, the resulting tuition_charge must reference the authorizing HR benefit plan for audit, reconciliation, and IRS reporting (waiver_amount on ',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Campus-specific tuition rates are standard in higher-ed (main campus vs. satellite campus pricing). tuition_charge.campus_id → campus supports campus-differentiated rate assessment, campus-level reven',
    `cost_center_id` BIGINT COMMENT 'Unique identifier of the college or school within the institution to which the charge is attributed. Used for revenue allocation and reporting.',
    `course_id` BIGINT COMMENT 'Unique identifier of the specific course for which a course-specific fee is charged. Applicable for lab fees, course fees, or other course-related charges.',
    `dining_enrollment_id` BIGINT COMMENT 'Foreign key linking to studentlife.dining_enrollment. Business justification: Dining plan charge posting process: meal plan charges are posted as tuition_charge records to student accounts. Linking the charge to the specific dining_enrollment enables billing reconciliation, din',
    `employee_id` BIGINT COMMENT 'System user identifier of the person or automated process that assessed the charge. Used for audit trail and accountability.',
    `enrollment_status_id` BIGINT COMMENT 'Foreign key linking to student.enrollment_status. Business justification: Tuition charges are assessed based on the enrollment_status record (credit hours enrolled, enrollment intensity, full-time/part-time). Direct FK enables charge dispute resolution and enrollment-to-bil',
    `fee_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.fee_schedule. Business justification: Tuition charges are assessed based on fee schedules. The fee_schedule defines the rates and rules; tuition_charge is the application of those rules to a specific student. This is critical for rate tra',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Fund accounting revenue allocation: tuition revenue in higher-ed is allocated across multiple funds (general, restricted, endowment income). This link enables fund-level revenue reporting, budget-to-a',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Revenue recognition period: tuition charges must be assigned to a fiscal period for deferred revenue calculation, period-end GL close, and IPEDS revenue reporting. The term_id provides academic contex',
    `graduation_application_id` BIGINT COMMENT 'Foreign key linking to student.graduation_application. Business justification: Graduation application fees are assessed as tuition_charge records. Bursar reconciliation reports must confirm the graduation fee charge corresponds to a specific graduation_application. A higher-ed d',
    `grant_account_id` BIGINT COMMENT 'Foreign key linking to finance.grant_account. Business justification: Training grant and fellowship tuition remission: federal training grants (NIH T32, NSF GRFP) pay tuition directly; the tuition charge must reference the grant account for sponsored program billing, F&',
    `health_visit_id` BIGINT COMMENT 'Foreign key linking to studentlife.health_visit. Business justification: Student health billing process: copays and health center service charges are posted as tuition_charge records to student accounts. Linking the charge to the specific health_visit enables itemized bill',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Tuition charges post to general ledger accounts for financial reporting and reconciliation. This FK links billing.tuition_charge to the finance ledger_account master, enabling unified financial report',
    `org_unit_id` BIGINT COMMENT 'Unique identifier of the academic department to which the charge is attributed. Used for revenue allocation and departmental reporting.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Tuition charge assessment is governed by institutional policies (residency classification policy, tuition waiver policy, differential tuition policy). Higher-ed billing auditors trace each charge to i',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student to whom this tuition charge is assessed. Links to the student master record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Tuition charge assessment must comply with specific regulatory requirements (Title IV cost-of-attendance rules, state tuition-setting regulations, IPEDS allowable charges). Higher-ed billing officers ',
    `residency_classification_id` BIGINT COMMENT 'Foreign key linking to student.residency_classification. Business justification: Residency classification (in-state vs. out-of-state) directly determines the tuition rate applied to each charge. tuition_charge.residency_classification is a plain-text denormalization of student.res',
    `section_id` BIGINT COMMENT 'Foreign key linking to curriculum.section. Business justification: Tuition charges are assessed at the section level in higher-ed (lab fees, online section surcharges, per-section enrollment billing). Linking charge to section enables section-level revenue reporting,',
    `statement_id` BIGINT COMMENT 'Foreign key linking to billing.billing_statement. Business justification: Tuition charges appear ON billing statements. A charge may be assessed in one period and appear on the next statement. This link tracks which statement a charge was included in for billing and reconci',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Tuition charges are posted TO a student account. Currently tuition_charge links to profile and term, but not to the student_account master record. This is the authoritative account for charge posting ',
    `term_id` BIGINT COMMENT 'Unique identifier of the academic term for which this tuition charge applies. Links to the term master record.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of any adjustment applied to the original charge. Positive for additional charges, negative for reductions or credits.',
    `adjustment_reason` STRING COMMENT 'Free-text explanation of why an adjustment was made to the original charge. Provides context for billing office and audit purposes.',
    `assessment_date` DATE COMMENT 'Date on which the charge was assessed to the student account. Represents the business event date for billing purposes.',
    `billing_method` STRING COMMENT 'Method used to calculate and assess the tuition charge. Determines whether per-credit-hour rates or flat fees are applied.. Valid values are `per_credit_hour|flat_rate|cohort|contract|consortium`',
    `charge_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of the charge assessed to the student account. Calculated based on credit hours, rate, or flat fee depending on billing model.',
    `charge_code` STRING COMMENT 'System-generated or manually assigned code identifying the specific type of charge. Used for billing categorization and financial reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `charge_description` STRING COMMENT 'Human-readable description of the charge providing context for the student and billing office. May include course title, fee purpose, or program name.',
    `charge_status` STRING COMMENT 'Current lifecycle status of the charge indicating whether it has been assessed, posted to the student account, adjusted, reversed, waived, or cancelled.. Valid values are `assessed|posted|adjusted|reversed|waived|cancelled`',
    `charge_type` STRING COMMENT 'Classification of the charge indicating whether it is tuition or a specific mandatory or course-related fee. Determines billing rules and revenue allocation. [ENUM-REF-CANDIDATE: tuition|technology_fee|health_fee|activity_fee|lab_fee|course_fee|program_fee|registration_fee — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tuition charge record was first created in the system. Used for audit trail and data lineage.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of credit hours for which the student is enrolled and upon which tuition is calculated. Used for per-credit-hour billing models.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the charge is denominated. Typically USD for U.S. institutions.. Valid values are `^[A-Z]{3}$`',
    `due_date` DATE COMMENT 'Date by which the charge must be paid to avoid late fees or account holds. Determined by institutional billing policy and term calendar.',
    `flat_rate_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount charged for tuition when a flat-rate billing model is applied (e.g., full-time students above a credit hour threshold).',
    `is_refundable` BOOLEAN COMMENT 'Indicates whether the charge is eligible for refund if the student drops the course or withdraws from the term. Determined by institutional refund policy and timing.',
    `is_reportable_1098t` BOOLEAN COMMENT 'Indicates whether the charge is reportable on the IRS Form 1098-T for qualified tuition and related expenses. Required for federal tax reporting compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the tuition charge record was last updated. Used for audit trail and change tracking.',
    `net_charge_amount` DECIMAL(18,2) COMMENT 'Final dollar amount of the charge after all adjustments have been applied. Represents the amount owed by the student.',
    `posted_date` DATE COMMENT 'Date on which the charge was officially posted to the student account and became due. May differ from assessment date due to billing cycle timing.',
    `program_level` STRING COMMENT 'Academic level of the program for which the student is enrolled and charged. Determines applicable tuition rate and fee structure.. Valid values are `undergraduate|graduate|doctoral|professional|certificate|non_degree`',
    `rate_per_credit_hour` DECIMAL(18,2) COMMENT 'Dollar amount charged per credit hour for tuition. Rate varies by program level, residency classification, and student type.',
    `refund_percentage` DECIMAL(18,2) COMMENT 'Percentage of the charge that is refundable based on the date of withdrawal or drop. Decreases over time according to institutional refund schedule.',
    `revenue_category` STRING COMMENT 'High-level classification of the revenue type for financial reporting purposes. Aligns with institutional chart of accounts and GASB/FASB standards.. Valid values are `tuition_revenue|fee_revenue|auxiliary_revenue|other_revenue`',
    `reversal_reason` STRING COMMENT 'Free-text explanation of why the charge was reversed. Required for audit trail and financial reconciliation.',
    `student_type` STRING COMMENT 'Classification of the students enrollment type. Affects billing model, fee assessment, and eligibility for certain charges.. Valid values are `full_time|part_time|visiting|exchange|dual_enrollment|continuing_education`',
    `waiver_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the waiver applied to the charge. Reduces the net amount owed by the student.',
    `waiver_code` STRING COMMENT 'Code identifying the type of waiver applied to reduce or eliminate the charge. Examples include employee tuition waiver, athletic scholarship waiver, or graduate assistant waiver.. Valid values are `^[A-Z0-9]{2,10}$`',
    CONSTRAINT pk_tuition_charge PRIMARY KEY(`tuition_charge_id`)
) COMMENT 'Individual tuition and mandatory fee charges assessed to a student account for a given term. Captures charge type (tuition, technology fee, health fee, activity fee), credit hour basis, rate applied, assessed amount, term, program level, residency classification (in-state/out-of-state), and charge status. Generated during automated fee assessment based on enrollment and fee schedule rules.';

CREATE OR REPLACE TABLE `education_ecm`.`billing`.`statement` (
    `statement_id` BIGINT COMMENT 'Unique identifier for the billing statement. Primary key.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Period-end AR close process: statements must be associated with a fiscal period for GL period-end close, AR aging by period, and IPEDS/NACUBO financial reporting. Controllers require this link to clos',
    `payment_plan_id` BIGINT COMMENT 'Reference to an active payment plan arrangement if the student is enrolled in an installment payment program.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Billing statement generation and delivery is governed by institutional policy (e-statement consent policy, billing cycle policy, statement content policy). Higher-ed billing compliance reporting requi',
    `profile_id` BIGINT COMMENT 'Reference to the student who is the primary account holder for this billing statement.',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Billing statements are generated FOR a student account. This is the master account-to-statement relationship. Currently billing_statement links to profile and term, but not to the student_account mast',
    `term_id` BIGINT COMMENT 'Reference to the academic term for which this billing statement was generated.',
    `account_hold_indicator` BOOLEAN COMMENT 'Indicates whether an account hold has been placed due to unpaid balance, preventing registration or transcript release.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total adjustments applied to this statement including billing corrections, charge reversals, or administrative credits.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address to which paper statements are mailed or used for payment processing.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address for apartment, suite, or additional address details.',
    `billing_city` STRING COMMENT 'City component of the billing address.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_cycle` STRING COMMENT 'The billing cycle period for which this statement was generated (e.g., fall semester, spring semester, monthly).. Valid values are `fall|spring|summer|monthly|quarterly|annual`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code component of the billing address.',
    `billing_state_province` STRING COMMENT 'State or province component of the billing address.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this billing statement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this statement (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Method by which the billing statement was delivered to the student or authorized payer.. Valid values are `email|portal|paper|electronic`',
    `delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the billing statement was delivered or made available to the student.',
    `due_date` DATE COMMENT 'Date by which payment is due to avoid late fees or account holds.',
    `fee_charges` DECIMAL(18,2) COMMENT 'Total mandatory and optional fees assessed including technology fees, student activity fees, lab fees, and course-specific fees.',
    `financial_aid_disbursed` DECIMAL(18,2) COMMENT 'Total financial aid disbursements applied to this statement including federal, state, and institutional aid.',
    `grant_amount` DECIMAL(18,2) COMMENT 'Total grant awards applied as credits including federal Pell grants, state grants, and institutional grants.',
    `housing_charges` DECIMAL(18,2) COMMENT 'Total charges for on-campus housing or university-managed residential facilities.',
    `is_1098t_eligible` BOOLEAN COMMENT 'Indicates whether charges and payments on this statement are eligible for inclusion in IRS Form 1098-T tuition statement reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this billing statement record was last updated or modified.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Late payment fees assessed if payment was not received by the due date.',
    `loan_disbursement` DECIMAL(18,2) COMMENT 'Total student loan disbursements applied to this statement including federal direct loans, PLUS loans, and private loans.',
    `meal_plan_charges` DECIMAL(18,2) COMMENT 'Total charges for dining services and meal plan subscriptions.',
    `minimum_payment_due` DECIMAL(18,2) COMMENT 'Minimum payment amount required by the due date to avoid late fees or account holds, applicable when payment plans are in effect.',
    `net_balance` DECIMAL(18,2) COMMENT 'Net amount due calculated as total charges minus total credits and payments. Positive indicates amount owed; negative indicates credit balance.',
    `notes` STRING COMMENT 'Free-text notes or messages included on the statement for student communication regarding special circumstances, payment instructions, or account alerts.',
    `previous_balance` DECIMAL(18,2) COMMENT 'Balance carried forward from the previous billing statement, if applicable.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Total refunds issued to the student for overpayment or credit balance, typically disbursed after financial aid exceeds charges.',
    `scholarship_amount` DECIMAL(18,2) COMMENT 'Total scholarship awards applied as credits to this statement from institutional, external, or donor-funded sources.',
    `statement_date` DATE COMMENT 'Date on which the billing statement was generated and issued to the student or authorized payer.',
    `statement_number` STRING COMMENT 'Externally-visible unique statement number used for reference in communications and payment processing.. Valid values are `^[A-Z0-9]{8,20}$`',
    `statement_status` STRING COMMENT 'Current lifecycle status of the billing statement indicating payment and processing state. [ENUM-REF-CANDIDATE: draft|issued|paid|partially_paid|overdue|cancelled|adjusted — 7 candidates stripped; promote to reference product]',
    `tax_year` STRING COMMENT 'Calendar year for which charges and payments on this statement apply for IRS Form 1098-T reporting purposes.',
    `third_party_sponsor_amount` DECIMAL(18,2) COMMENT 'Total payments or credits from third-party sponsors such as employers, government agencies, or external organizations.',
    `total_charges` DECIMAL(18,2) COMMENT 'Sum of all charges assessed on this statement including tuition, fees, housing, meal plans, and other institutional charges.',
    `total_credits` DECIMAL(18,2) COMMENT 'Sum of all credits applied to this statement including financial aid disbursements, scholarships, grants, refunds, and adjustments.',
    `total_payments` DECIMAL(18,2) COMMENT 'Sum of all payments received and applied to this statement from student, sponsor, or third-party sources.',
    `tuition_charges` DECIMAL(18,2) COMMENT 'Total tuition charges assessed for enrolled courses during this billing cycle.',
    CONSTRAINT pk_statement PRIMARY KEY(`statement_id`)
) COMMENT 'Periodic billing statement issued to a student or authorized payer summarizing charges, credits, payments, financial aid disbursements, and balance due for a billing cycle. Tracks statement date, due date, total charges, total credits, net balance, delivery method (email, portal, paper), and statement status. Generated during scheduled billing cycle processing.';

CREATE OR REPLACE TABLE `education_ecm`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction. Primary key for the payment record.',
    `ar_receipt_id` BIGINT COMMENT 'Foreign key linking to finance.ar_receipt. Business justification: Cash reconciliation: student payments in the billing sub-ledger must be matched to AR receipts in the GL for bursar-to-controller daily cash reconciliation, bank deposit verification, and audit trail.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Bank reconciliation: student payments are deposited into specific institutional bank accounts; the bursars office must reconcile each payment to a bank account for daily deposit reporting, positive p',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Period-end cash close: student payments must be assigned to a fiscal period for GL period-end close, cash basis reporting, and IPEDS cash flow reporting. The existing journal_entry FK does not directl',
    `journal_entry_id` BIGINT COMMENT 'Identifier of the payment batch or deposit group to which this payment belongs. Used for reconciliation of daily deposits and batch processing.',
    `payment_plan_id` BIGINT COMMENT 'Identifier of the payment plan to which this payment is applied, if the payment is part of an installment or deferred payment arrangement.',
    `payment_plan_installment_id` BIGINT COMMENT 'Foreign key linking to billing.payment_plan_installment. Business justification: A payment made under a payment plan is applied to a specific installment. The payment table currently carries installment_number (INT) as a denormalized weak reference. Replacing this with payment.pay',
    `primary_reversed_by_payment_id` BIGINT COMMENT 'Identifier of the reversal payment transaction that reversed this payment. Creates an audit trail linking original payments to their reversals.',
    `profile_id` BIGINT COMMENT 'Identifier of the student whose account this payment is applied to. Links payment to the student master record.',
    `room_booking_id` BIGINT COMMENT 'Foreign key linking to facility.room_booking. Business justification: Room bookings with billing_required=true generate payment obligations. Linking payment.room_booking_id → room_booking supports reconciliation of room rental revenue, accounts receivable aging for faci',
    `statement_id` BIGINT COMMENT 'Foreign key linking to billing.statement. Business justification: A payment is frequently made in response to a specific billing statement. Linking payment.statement_id → statement.statement_id formalizes the reconciliation relationship, enabling the bursars office',
    `student_account_id` BIGINT COMMENT 'Identifier of the student account to which this payment is applied. Links payment to the billing account.',
    `term_id` BIGINT COMMENT 'Identifier of the academic term to which this payment is applied. Used for term-specific payment allocation and reporting.',
    `amount` DECIMAL(18,2) COMMENT 'The total monetary amount of the payment received, in the institutions base currency. Represents the gross payment before any adjustments or allocations.',
    `authorization_code` STRING COMMENT 'The authorization code provided by the credit card issuer or payment processor confirming approval of the transaction. Applicable to credit and debit card payments.',
    `bank_account_last_four` STRING COMMENT 'The last four digits of the bank account number used for the payment. Stored for payment verification while maintaining PCI compliance by not storing full account numbers.. Valid values are `^[0-9]{4}$`',
    `bank_routing_number` STRING COMMENT 'The nine-digit ABA routing number of the bank from which the payment originated. Applicable to ACH and check payments. Used for payment verification and reconciliation.. Valid values are `^[0-9]{9}$`',
    `base_currency_amount` DECIMAL(18,2) COMMENT 'The payment amount converted to the institutions base currency using the exchange rate. Used for financial reporting and account reconciliation.',
    `card_last_four` STRING COMMENT 'The last four digits of the credit or debit card number used for the payment. Stored for payment verification while maintaining PCI compliance.. Valid values are `^[0-9]{4}$`',
    `card_type` STRING COMMENT 'The brand or type of credit or debit card used for the payment. Applicable only to card-based payments.. Valid values are `visa|mastercard|amex|discover`',
    `channel` STRING COMMENT 'The interface or channel through which the payment was submitted. Indicates where the payer initiated the transaction (e.g., web portal, mobile app, in-person at cashier, mail, phone).. Valid values are `web_portal|mobile_app|in_person|mail|phone|third_party`',
    `check_number` STRING COMMENT 'The check number from the physical check or money order used for payment. Used for tracking and reconciliation of check payments.',
    `cleared_date` DATE COMMENT 'The date on which the payment cleared the bank or payment processor and funds were confirmed as available. Applicable to checks, ACH, and credit card payments.',
    `confirmation_number` STRING COMMENT 'Externally-visible confirmation or receipt number provided to the payer upon successful payment processing. Used for payment lookup and reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the payment was made. Supports international student payments in foreign currencies.. Valid values are `^[A-Z]{3}$`',
    `deposit_date` DATE COMMENT 'The date on which the payment was deposited to the institutions bank account. Used for cash flow management and bank reconciliation.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the payment from the original currency to the institutions base currency. Applicable only for foreign currency payments.',
    `is_refundable` BOOLEAN COMMENT 'Indicates whether this payment is eligible for refund based on institutional policy and payment timing. Used to enforce refund eligibility rules.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The net amount received by the institution after deducting processing fees. Represents the actual funds available for application to the student account.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the payment transaction. Used to capture special instructions, payment purpose, or other contextual information.',
    `payer_email` STRING COMMENT 'The email address of the payer. Used for sending payment confirmations, receipts, and communication regarding the payment transaction.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `payer_name` STRING COMMENT 'The full name of the individual or organization making the payment. Used for payment reconciliation and third-party billing verification.',
    `payer_phone` STRING COMMENT 'The contact phone number of the payer. Used for payment verification and follow-up communication if issues arise with the payment.',
    `payer_type` STRING COMMENT 'The category or relationship of the party making the payment. Indicates whether the payment is from the student, parent, sponsor, employer, or other third party.. Valid values are `student|parent|guardian|sponsor|employer|third_party`',
    `payment_date` DATE COMMENT 'The date on which the payment was received or initiated by the payer. This is the business event date for the payment transaction.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to make the payment. Indicates how the funds were transferred (e.g., check, ACH, credit card, wire transfer, cash). [ENUM-REF-CANDIDATE: check|ach|credit_card|debit_card|wire_transfer|cash|money_order — 7 candidates stripped; promote to reference product]',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Indicates whether the payment has been received, cleared by the bank, posted to the student account, or reversed.. Valid values are `pending|cleared|posted|reversed|voided|failed`',
    `payment_timestamp` TIMESTAMP COMMENT 'The precise date and time when the payment transaction was received or processed by the institution. Used for audit trail and reconciliation.',
    `posted_date` DATE COMMENT 'The date on which the payment was officially posted to the student account ledger. May differ from payment_date due to processing delays or batch posting cycles.',
    `processing_fee` DECIMAL(18,2) COMMENT 'The fee charged by the payment processor or merchant service provider for processing the payment. May be absorbed by the institution or passed to the payer.',
    `processor_reference` STRING COMMENT 'The unique transaction identifier or reference number assigned by the payment processor or gateway. Used for reconciliation with processor settlement reports.',
    `reversal_reason` STRING COMMENT 'The reason for reversing or voiding the payment, if applicable. Includes reasons such as insufficient funds, duplicate payment, student withdrawal, or payer request.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this payment record was last modified. Used for audit trail and change tracking.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Record of a payment received against a student account. Captures payment method (check, ACH, credit card, wire transfer, cash), payment amount, payment date, payer type (student, parent, sponsor, employer), confirmation number, processor reference, applied term, and payment status (pending, cleared, reversed). SSOT for all inbound monetary receipts in the billing domain.';

CREATE OR REPLACE TABLE `education_ecm`.`billing`.`payment_plan` (
    `payment_plan_id` BIGINT COMMENT 'Unique identifier for the payment plan agreement. Primary key.',
    `employee_id` BIGINT COMMENT 'System user identifier of the financial aid or student accounts staff member who approved the payment plan enrollment.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Payment plans are offered under institutional policies defining eligibility criteria, enrollment fees, installment terms, interest rates, and default consequences. Policy reference is required for pla',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student who enrolled in this payment plan.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Interest-bearing payment plans must comply with Truth in Lending Act (Reg Z) regulatory requirements; all plans must comply with Title IV cash management rules. This is a distinct regulatory complianc',
    `term_id` BIGINT COMMENT 'Unique identifier of the academic term for which this payment plan applies.',
    `approval_date` DATE COMMENT 'Date when the payment plan was officially approved by the institution.',
    `auto_pay_enabled_flag` BOOLEAN COMMENT 'Indicates whether automatic payment processing is enabled for this payment plan (True if auto-pay is active, False otherwise).',
    `cancellation_date` DATE COMMENT 'Date when the payment plan was cancelled by the student or institution. Null if the plan has not been cancelled.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the payment plan was cancelled (e.g., student withdrawal, full payment received, financial hardship, administrative error).',
    `completion_date` DATE COMMENT 'Date when all scheduled installment payments were successfully received and the payment plan obligations were fully satisfied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment plan record was first created in the system.',
    `default_date` DATE COMMENT 'Date when the payment plan was declared in default due to missed payments exceeding the grace period. Null if the plan has not defaulted.',
    `down_payment_amount` DECIMAL(18,2) COMMENT 'Initial payment amount required at the time of payment plan enrollment, paid before the first installment.',
    `effective_end_date` DATE COMMENT 'Date when the payment plan obligations are scheduled to be fully satisfied and the agreement concludes.',
    `effective_start_date` DATE COMMENT 'Date when the payment plan obligations and installment schedule officially begin.',
    `enrollment_date` DATE COMMENT 'Date when the student enrolled in and the payment plan agreement became effective.',
    `enrollment_fee_amount` DECIMAL(18,2) COMMENT 'Non-refundable administrative fee charged to the student for enrolling in the payment plan.',
    `final_installment_due_date` DATE COMMENT 'Date when the final scheduled installment payment is due, marking the completion of the payment plan.',
    `first_installment_due_date` DATE COMMENT 'Date when the first scheduled installment payment is due.',
    `grace_period_days` STRING COMMENT 'Number of days after the installment due date before late fees are assessed or the plan is considered in default.',
    `installment_amount` DECIMAL(18,2) COMMENT 'Standard amount due for each scheduled installment payment. May vary for the final installment if the total does not divide evenly.',
    `installment_frequency` STRING COMMENT 'Frequency at which installment payments are scheduled (monthly, biweekly, weekly, or custom schedule).. Valid values are `monthly|biweekly|weekly|custom`',
    `installments_missed_count` STRING COMMENT 'Number of scheduled installment payments that were not received by their due date.',
    `installments_paid_count` STRING COMMENT 'Number of installment payments that have been successfully received and applied to the payment plan.',
    `interest_rate_percent` DECIMAL(18,2) COMMENT 'Annual interest rate percentage applied to the payment plan balance, if applicable. Zero for interest-free plans.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payment plan record was most recently updated in the system.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Standard late fee amount charged when an installment payment is not received by the due date.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or administrative notes related to the payment plan agreement.',
    `number_of_installments` STRING COMMENT 'Total count of scheduled installment payments in the payment plan agreement.',
    `outstanding_balance_amount` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on the payment plan, calculated as total plan amount minus total paid amount plus any accrued fees or interest.',
    `payment_method_type` STRING COMMENT 'Primary payment instrument type used for installment payments (ACH bank transfer, credit card, debit card, check, cash, wire transfer).. Valid values are `ach|credit_card|debit_card|check|cash|wire_transfer`',
    `plan_number` STRING COMMENT 'Externally visible unique business identifier for the payment plan agreement, typically formatted as PP followed by 8 digits.. Valid values are `^PP[0-9]{8}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the payment plan: active (in good standing), completed (all payments made), defaulted (missed payments beyond grace period), cancelled (terminated by student or institution), suspended (temporarily on hold), pending (awaiting approval or first payment).. Valid values are `active|completed|defaulted|cancelled|suspended|pending`',
    `plan_type` STRING COMMENT 'Classification of the payment plan based on institutional offerings (standard multi-month plan, extended plan with more installments, custom negotiated plan, emergency short-term plan, deferred payment plan).. Valid values are `standard|extended|custom|emergency|short_term|deferred`',
    `source_system` STRING COMMENT 'Name of the operational system from which this payment plan record originated (e.g., Ellucian Banner Student Accounts, Nelnet Payment Plans, Cashnet).',
    `total_paid_amount` DECIMAL(18,2) COMMENT 'Cumulative total of all payments received against this payment plan to date, including down payment and installments.',
    `total_plan_amount` DECIMAL(18,2) COMMENT 'Total amount of tuition, fees, and other charges covered by this payment plan agreement, excluding enrollment fees and interest.',
    CONSTRAINT pk_payment_plan PRIMARY KEY(`payment_plan_id`)
) COMMENT 'Installment payment plan agreement established for a student to spread tuition and fee obligations across multiple scheduled payments within a term. Tracks plan type, enrollment date, total plan amount, number of installments, enrollment fee, down payment amount, plan status (active, completed, defaulted, cancelled), and the administering term.';

CREATE OR REPLACE TABLE `education_ecm`.`billing`.`payment_plan_installment` (
    `payment_plan_installment_id` BIGINT COMMENT 'Unique identifier for the payment plan installment. Primary key for this entity.',
    `payment_plan_id` BIGINT COMMENT 'Reference to the parent payment plan under which this installment is scheduled. Links to the payment_plan product for plan-level terms and conditions.',
    `actual_payment_date` DATE COMMENT 'The date on which the installment was actually paid by the student or sponsor. Null if the installment has not yet been paid.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Dollar amount of any manual adjustment applied to this installment after initial scheduling. Positive values increase the installment amount, negative values decrease it. Used for institutional corrections or student-specific modifications.',
    `adjustment_authorized_by` STRING COMMENT 'Name or identifier of the institutional staff member who authorized the adjustment to this installment. Used for audit trail and accountability.',
    `adjustment_date` DATE COMMENT 'The date on which the adjustment to this installment was authorized and applied. Used for audit trail and financial reconciliation.',
    `adjustment_reason` STRING COMMENT 'Explanation or justification for any adjustment applied to the installment amount. Examples include billing error correction, financial aid disbursement, or institutional credit.',
    `amount_paid` DECIMAL(18,2) COMMENT 'The actual dollar amount paid toward this installment. May differ from scheduled_amount if partial payments or overpayments occur. Null if unpaid.',
    `auto_pay_attempt_date` DATE COMMENT 'The date on which an automatic payment attempt was made for this installment. Populated only if auto_pay_enabled is True and an attempt has been processed.',
    `auto_pay_enabled` BOOLEAN COMMENT 'Indicates whether automatic payment processing is enabled for this installment. True if the installment is scheduled for automatic deduction from a stored payment method, False otherwise.',
    `auto_pay_failure_reason` STRING COMMENT 'Explanation or error message describing why an automatic payment attempt failed. Examples include insufficient funds, expired card, or payment method declined. Populated only when auto_pay_status is failed.',
    `auto_pay_status` STRING COMMENT 'Status of the automatic payment attempt for this installment. Pending: scheduled but not yet processed. Successful: payment processed successfully. Failed: payment attempt declined or failed. Not Attempted: auto pay not enabled or not yet due.. Valid values are `pending|successful|failed|not_attempted`',
    `collections_agency` STRING COMMENT 'Name of the external collections agency to which this overdue installment was referred. Populated only if collections_referral_date is not null.',
    `collections_referral_date` DATE COMMENT 'The date on which this overdue installment was referred to a collections agency or internal collections process. Indicates escalation of delinquent payment.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this installment record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_due_date` DATE COMMENT 'The actual date by which payment must be received to avoid late fees, calculated as scheduled_due_date plus grace_period_days. Used for late fee assessment logic.',
    `grace_period_days` STRING COMMENT 'Number of days after the scheduled due date during which payment can be made without incurring a late fee. Typically set at the plan level but may be overridden at the installment level.',
    `hold_applied` BOOLEAN COMMENT 'Indicates whether an account hold has been applied to the student account due to this installment being overdue. True if hold is active, False otherwise. Holds may prevent registration or transcript release.',
    `hold_applied_date` DATE COMMENT 'The date on which an account hold was applied due to this overdue installment. Populated only when hold_applied is True.',
    `installment_number` STRING COMMENT 'Sequential number of this installment within the parent payment plan (e.g., 1, 2, 3). Determines the order of scheduled payments.',
    `installment_status` STRING COMMENT 'Current lifecycle status of the installment. Scheduled: not yet due or paid. Paid: fully satisfied. Overdue: past due date and unpaid. Partial: partially paid but not fully satisfied. Waived: obligation removed by institutional action. Cancelled: installment voided due to plan cancellation.. Valid values are `scheduled|paid|overdue|partial|waived|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this installment record was last updated. Captures any change to status, amounts, or other attributes. Used for audit trail and change tracking.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'The dollar amount of late fee assessed on this installment if payment was received after the due date. Null or zero if no late fee applies.',
    `late_fee_assessed` BOOLEAN COMMENT 'Indicates whether a late fee has been assessed on this installment due to payment past the scheduled due date. True if late fee applied, False otherwise.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user or automated process that last modified this installment record. Used for audit trail and accountability.',
    `notification_method` STRING COMMENT 'The communication channel used to notify the student of the upcoming or overdue installment. Examples include email, SMS text, postal mail, student portal alert, or phone call.. Valid values are `email|sms|postal_mail|portal_alert|phone`',
    `notification_sent_date` DATE COMMENT 'The date on which a payment reminder or due date notification was sent to the student for this installment. Used to track communication and compliance with notification policies.',
    `payment_method` STRING COMMENT 'The payment instrument or method used to satisfy this installment. Examples include credit card, ACH bank transfer, check, cash, wire transfer, or third-party sponsor payment. [ENUM-REF-CANDIDATE: credit_card|debit_card|ach|check|cash|wire_transfer|third_party — 7 candidates stripped; promote to reference product]',
    `payment_reference_number` STRING COMMENT 'External reference number or transaction identifier from the payment processing system that fulfilled this installment. Links to payment records when installment is paid.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'The outstanding balance remaining on this installment after applying payments. Calculated as scheduled_amount plus any late fees minus amount_paid.',
    `scheduled_amount` DECIMAL(18,2) COMMENT 'The dollar amount scheduled to be paid for this installment. Represents the planned payment obligation before any adjustments or late fees.',
    `scheduled_due_date` DATE COMMENT 'The date on which this installment payment is scheduled to be due. Established at the time the payment plan is created or modified.',
    `term_code` STRING COMMENT 'The academic term or semester to which this installment applies. Examples include Fall 2024, Spring 2025. Used for term-specific billing and financial aid coordination.',
    `waiver_authorized_by` STRING COMMENT 'Name or identifier of the institutional staff member who authorized the waiver of this installment. Populated only when installment_status is waived.',
    `waiver_date` DATE COMMENT 'The date on which the installment waiver was authorized and applied. Populated only when installment_status is waived.',
    `waiver_reason` STRING COMMENT 'Explanation or justification for waiving this installment obligation. Populated only when installment_status is waived. Examples include financial hardship, institutional error, or administrative adjustment.',
    CONSTRAINT pk_payment_plan_installment PRIMARY KEY(`payment_plan_installment_id`)
) COMMENT 'Individual scheduled installment within a student payment plan. Captures installment sequence number, scheduled due date, scheduled amount, actual payment date, amount paid, remaining balance, late fee assessed flag, and installment status (scheduled, paid, overdue, waived). Links to the parent payment_plan for plan-level terms and references payment records when fulfilled via payment application.';

CREATE OR REPLACE TABLE `education_ecm`.`billing`.`refund` (
    `refund_id` BIGINT COMMENT 'Unique identifier for the refund transaction. Primary key for the refund record.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Refund disbursement reconciliation: student refunds (EFT/check) are disbursed from specific institutional bank accounts; the bursar must reconcile refund disbursements to bank accounts for positive pa',
    `disbursement_id` BIGINT COMMENT 'Foreign key linking to aid.disbursement. Business justification: Title IV R2T4 returns must be traced to the specific disbursement being returned (refund.is_title_iv_refund, title_iv_return_calculation_date confirm this regulatory requirement). The existing refund→',
    `aid_award_id` BIGINT COMMENT 'Identifier of the financial aid award that generated the refund, if the refund resulted from financial aid disbursement exceeding charges.',
    `graduation_application_id` BIGINT COMMENT 'Foreign key linking to student.graduation_application. Business justification: Graduation application fee refunds (application withdrawal or denial) must reference the originating graduation_application. Bursar reconciliation and graduation fee audit reports require this link. g',
    `housing_assignment_id` BIGINT COMMENT 'Foreign key linking to studentlife.studentlife_housing_assignment. Business justification: Housing cancellation refund process: when a student cancels housing mid-term, a pro-rated refund is issued. The refund record must reference the specific housing assignment to calculate the refund amo',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Title IV return and refund GL posting: every student refund (especially Title IV R2T4 returns) generates a journal entry for credit memo posting, fund liability reduction, and federal audit compliance',
    `leave_of_absence_id` BIGINT COMMENT 'Foreign key linking to student.leave_of_absence. Business justification: Leave of absence triggers tuition refund calculations per institutional refund policy and Title IV return-of-funds requirements. billing.refund must reference the leave_of_absence that initiated the r',
    `payment_id` BIGINT COMMENT 'Foreign key linking to billing.payment. Business justification: A refund frequently originates from an overpayment or returned payment. Formalizing refund.originating_payment_id → payment.payment_id enables traceability from refund back to the source payment trans',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Refund processing is governed by institutional refund policies (withdrawal refund schedule, institutional refund policy) distinct from the federal regulatory_requirement already linked. Higher-ed fina',
    `profile_id` BIGINT COMMENT 'Identifier of the student receiving the refund. Links to the student master record.',
    `employee_id` BIGINT COMMENT 'System user identifier of the staff member who approved the refund for processing.',
    `refund_processed_by_user_employee_id` BIGINT COMMENT 'System user identifier of the staff member who processed the refund disbursement.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Title IV refunds must comply with federal Return of Title IV Funds (R2T4) regulations. Tracking the specific regulatory requirement enables audit trails, ensures correct calculation methodology, and s',
    `research_award_id` BIGINT COMMENT 'Foreign key linking to research.research_award. Business justification: When research-funded students receive financial aid exceeding charges, refunds are issued from award funds. Universities track which awards generate refunds for sponsor reporting, award budget reconci',
    `room_booking_id` BIGINT COMMENT 'Foreign key linking to facility.room_booking. Business justification: Cancelled room bookings trigger refund processing for prepaid facility charges. refund.room_booking_id → room_booking enables the refund workflow to trace the originating booking, supports cancellatio',
    `student_account_id` BIGINT COMMENT 'Identifier of the student account from which the refund originates. Links to the student account billing record.',
    `tuition_charge_id` BIGINT COMMENT 'Foreign key linking to billing.tuition_charge. Business justification: A refund can result directly from a reversed or adjusted tuition charge (e.g., withdrawal refund, course drop). Linking refund.tuition_charge_id → tuition_charge.tuition_charge_id enables charge-level',
    `academic_year` STRING COMMENT 'Academic year during which the refund was issued, in YYYY-YYYY format (e.g., 2023-2024).. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary amount of the refund issued to the student or payer, in US dollars.',
    `approved_date` DATE COMMENT 'The date on which the refund was approved by authorized personnel or automated business rules.',
    `bank_account_number` STRING COMMENT 'Bank account number for ACH direct deposit refunds. Encrypted in storage.',
    `bank_account_type` STRING COMMENT 'Type of bank account for ACH direct deposit refunds (checking or savings).. Valid values are `checking|savings`',
    `bank_routing_number` STRING COMMENT 'Nine-digit ABA routing number for ACH direct deposit refunds.. Valid values are `^[0-9]{9}$`',
    `check_cleared_date` DATE COMMENT 'Date on which the refund check was cashed or cleared through the banking system.',
    `check_issue_date` DATE COMMENT 'Date printed on the paper check for refund disbursement.',
    `check_number` STRING COMMENT 'Sequential check number assigned to paper check refunds for tracking and reconciliation.. Valid values are `^[0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the refund record was first created in the system.',
    `eft_trace_number` STRING COMMENT 'Unique 15-digit trace number assigned by the ACH system for tracking electronic refund transactions.. Valid values are `^[0-9]{15}$`',
    `fund_code` STRING COMMENT 'Fund accounting code identifying the institutional fund from which the refund is disbursed.. Valid values are `^[A-Z0-9]{2,6}$`',
    `is_reportable_1098t` BOOLEAN COMMENT 'Flag indicating whether this refund must be reported on the students IRS Form 1098-T as a reduction in qualified tuition and related expenses.',
    `is_title_iv_refund` BOOLEAN COMMENT 'Flag indicating whether this refund is subject to Title IV federal financial aid return of funds regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the refund record was most recently updated in the system.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the refund transaction, used for internal documentation and audit trail.',
    `originating_credit_source` STRING COMMENT 'The source of the credit balance or funds that generated the refund, identifying where the excess payment originated. [ENUM-REF-CANDIDATE: tuition_payment|financial_aid|scholarship|grant|loan|sponsor_payment|third_party|other — 8 candidates stripped; promote to reference product]',
    `payee_address_line1` STRING COMMENT 'First line of the mailing address where the refund check or correspondence is sent.',
    `payee_address_line2` STRING COMMENT 'Second line of the mailing address (apartment, suite, building number) for refund delivery.',
    `payee_city` STRING COMMENT 'City name of the payee mailing address for refund delivery.',
    `payee_country_code` STRING COMMENT 'Three-letter ISO country code of the payee mailing address for refund delivery.. Valid values are `^[A-Z]{3}$`',
    `payee_name` STRING COMMENT 'Full legal name of the individual or entity receiving the refund payment.',
    `payee_postal_code` STRING COMMENT 'Postal or ZIP code of the payee mailing address for refund delivery.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `payee_state_province` STRING COMMENT 'Two-letter state or province code of the payee mailing address for refund delivery.. Valid values are `^[A-Z]{2}$`',
    `processed_date` DATE COMMENT 'The date on which the refund was fully processed and sent to the payment processor or disbursement system.',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific reason for the refund issuance, used for reporting and compliance tracking.. Valid values are `^[A-Z]{2,6}$`',
    `reason_description` STRING COMMENT 'Detailed textual explanation of the reason for the refund, providing context beyond the reason code.',
    `refund_date` DATE COMMENT 'The date on which the refund was officially issued or disbursed to the student or payer.',
    `refund_method` STRING COMMENT 'The payment instrument or mechanism used to disburse the refund to the recipient.. Valid values are `ach_direct_deposit|paper_check|wire_transfer|original_payment_method|debit_card|credit_to_account`',
    `refund_number` STRING COMMENT 'Human-readable business identifier for the refund transaction, typically displayed on student statements and correspondence.. Valid values are `^REF-[0-9]{8}$`',
    `refund_status` STRING COMMENT 'Current processing status of the refund in its lifecycle workflow.. Valid values are `pending|approved|processed|cancelled|failed|reversed`',
    `refund_type` STRING COMMENT 'Classification of the refund based on the originating business event or reason for issuance.. Valid values are `credit_balance|financial_aid_excess|course_drop|withdrawal|overpayment|adjustment`',
    `requested_date` DATE COMMENT 'The date on which the refund was initially requested or triggered in the system.',
    `tax_year` STRING COMMENT 'Calendar year for which this refund is reportable on IRS Form 1098-T for tax purposes.',
    `term_code` STRING COMMENT 'Academic term code for which the refund was issued, typically in YYYYMM format where MM represents the term (01=Spring, 05=Summer, 09=Fall).. Valid values are `^[0-9]{6}$`',
    `title_iv_return_calculation_date` DATE COMMENT 'Date on which the Title IV return of funds calculation was performed for withdrawal refunds.',
    CONSTRAINT pk_refund PRIMARY KEY(`refund_id`)
) COMMENT 'Record of a refund issued to a student or payer resulting from credit balances, financial aid disbursements exceeding charges, dropped courses, or withdrawal. Captures refund amount, refund method (ACH direct deposit, check, original payment method), refund date, reason code, originating credit source, processing status, and EFT trace number.';

CREATE OR REPLACE TABLE `education_ecm`.`billing`.`third_party_contract` (
    `third_party_contract_id` BIGINT COMMENT 'Unique identifier for the third-party billing contract record. Primary key for the third-party contract entity.',
    `academic_program_id` BIGINT COMMENT 'Foreign key linking to curriculum.academic_program. Business justification: Third-party contracts (employer TA, VA benefits, military tuition assistance) in higher-ed are routinely scoped to specific academic programs. Billing staff use this FK to auto-apply contract coverage',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Third-party billing contracts (employer tuition reimbursement, military tuition assistance, government agency contracts) are routinely scoped to specific campuses. Campus-scoped contract administratio',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Third-party billing contracts must align with institutional policies on sponsor agreements, data sharing, FERPA compliance, and payment terms. Policy reference is required during contract approval wor',
    `employee_id` BIGINT COMMENT 'Reference to the institutional staff member responsible for managing this third-party billing contract.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Contracts with federal agencies (VA, DoD tuition assistance, workforce grants) must reference specific regulatory requirements. This link supports compliance verification, federal audit trails, and en',
    `vendor_id` BIGINT COMMENT 'Reference to the external sponsor organization (employer, government agency, tribal organization, vocational rehabilitation agency) that is party to this billing contract.',
    `auto_apply_to_eligible_students` BOOLEAN COMMENT 'Indicates whether the contract should automatically apply to all students meeting eligibility criteria, or whether manual assignment is required.',
    `billing_address_line1` STRING COMMENT 'First line of the sponsor organization billing address where invoices should be sent.',
    `billing_address_line2` STRING COMMENT 'Second line of the sponsor organization billing address (suite, department, building number). Optional field.',
    `billing_city` STRING COMMENT 'City name for the sponsor organization billing address.',
    `billing_contact_email` STRING COMMENT 'Primary email address for the billing contact at the sponsor organization. Used for invoice delivery and payment communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `billing_contact_name` STRING COMMENT 'Full name of the primary billing contact person at the sponsor organization responsible for invoice receipt and payment processing.',
    `billing_contact_phone` STRING COMMENT 'Primary phone number for the billing contact at the sponsor organization for invoice and payment inquiries.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO country code for the sponsor organization billing address.. Valid values are `^[A-Z]{3}$`',
    `billing_frequency` STRING COMMENT 'Frequency at which invoices are generated and sent to the sponsor organization under this contract.. Valid values are `per_term|monthly|quarterly|annual|upon_enrollment|custom`',
    `billing_postal_code` STRING COMMENT 'Postal or ZIP code for the sponsor organization billing address.',
    `billing_state_province` STRING COMMENT 'State or province code for the sponsor organization billing address. Use standard two-letter state abbreviations for US addresses.',
    `contract_name` STRING COMMENT 'Descriptive name or title of the third-party billing contract for easy identification and reporting purposes.',
    `contract_number` STRING COMMENT 'Externally-known unique contract number or agreement identifier assigned by the institution or sponsor organization. Used for reference in communications and invoicing.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the third-party billing contract. Determines whether the contract is available for student enrollment and billing.. Valid values are `draft|active|suspended|expired|terminated|pending_renewal`',
    `coverage_limit_amount` DECIMAL(18,2) COMMENT 'Maximum dollar amount the sponsor will pay per student per term or academic year under this contract. Nullable if no cap applies.',
    `coverage_limit_period` STRING COMMENT 'Time period over which the coverage limit amount applies. Defines the billing cycle for cap enforcement.. Valid values are `per_term|per_academic_year|per_calendar_year|lifetime|none`',
    `coverage_scope` STRING COMMENT 'Defines what charges the sponsor agrees to pay under this contract. Determines which student account charges are eligible for third-party billing.. Valid values are `tuition_only|tuition_and_fees|tuition_fees_books|full_cost_of_attendance|custom`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this third-party contract record was first created in the system. Used for audit trail and data lineage.',
    `default_purchase_order_number` STRING COMMENT 'Standing purchase order number provided by the sponsor for use on all invoices under this contract. Nullable if PO numbers vary by invoice.',
    `effective_date` DATE COMMENT 'Date when the third-party billing contract becomes active and eligible for student enrollment and billing. Contract terms apply from this date forward.',
    `eligible_student_criteria` STRING COMMENT 'Business rules or criteria defining which students are eligible for billing under this contract. May include employment status, program enrollment, veteran status, or other sponsor-specific requirements.',
    `expiration_date` DATE COMMENT 'Date when the third-party billing contract expires and is no longer valid for new enrollments or billing. Nullable for open-ended contracts.',
    `federal_contract_indicator` BOOLEAN COMMENT 'Indicates whether this is a federal government contract subject to federal regulations and reporting requirements (VA, DoD, etc.).',
    `invoice_delivery_method` STRING COMMENT 'Method by which invoices are delivered to the sponsor organization.. Valid values are `email|postal_mail|electronic_portal|edi|fax`',
    `invoice_format` STRING COMMENT 'Preferred invoice format specified by the sponsor organization. Determines level of detail included in billing statements.. Valid values are `summary|detailed|itemized|custom`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this third-party contract record was last updated. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional contract terms, special instructions, billing notes, or administrative comments relevant to contract management and billing operations.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which the sponsor is expected to remit payment. Standard net payment terms.',
    `purchase_order_required` BOOLEAN COMMENT 'Indicates whether the sponsor requires a purchase order number on all invoices for payment processing.',
    `renewal_notification_days` STRING COMMENT 'Number of days before contract expiration that renewal notification should be sent to the sponsor and contract administrator.',
    `requires_enrollment_verification` BOOLEAN COMMENT 'Indicates whether the sponsor requires enrollment verification or certification before payment. Common for VA, DoD, and vocational rehabilitation contracts.',
    `requires_student_authorization` BOOLEAN COMMENT 'Indicates whether individual student authorization or consent is required before billing the sponsor under this contract. Important for FERPA compliance.',
    `sponsor_type` STRING COMMENT 'Classification of the sponsor organization type. Determines applicable regulations and billing procedures. [ENUM-REF-CANDIDATE: employer|government_agency|vocational_rehabilitation|tribal_organization|military|consortium|other — 7 candidates stripped; promote to reference product]',
    `termination_date` DATE COMMENT 'Date when the contract was terminated prior to its natural expiration date. Nullable if contract was not terminated early.',
    `termination_reason` STRING COMMENT 'Explanation or reason code for early contract termination. Nullable if contract was not terminated early.',
    CONSTRAINT pk_third_party_contract PRIMARY KEY(`third_party_contract_id`)
) COMMENT 'Master agreement record for third-party billing arrangements with sponsors, employers, government agencies (VA, DoD, vocational rehabilitation), or tribal organizations that pay tuition and fees on behalf of enrolled students. Captures sponsor organization, contract number, billing contact, authorized coverage scope (tuition only, tuition and fees, capped dollar amount), eligible student criteria, billing frequency, contract effective dates, and status. Governs sponsor invoice generation.';

CREATE OR REPLACE TABLE `education_ecm`.`billing`.`account_hold` (
    `account_hold_id` BIGINT COMMENT 'Unique identifier for the account hold record. Primary key.',
    `alumnus_id` BIGINT COMMENT 'Foreign key linking to advancement.alumnus. Business justification: Alumni account holds (unpaid balances blocking transcript release, diploma access) require advancement visibility for donor prospect qualification and stewardship impact assessment. Critical business ',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to hr.org_unit. Business justification: Hold management and release workflows in higher-ed require knowing which org_unit (bursar, registrar, library) placed the hold. The existing plain-text originating_office column is a denormalized repr',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Account holds are placed based on institutional policies defining payment deadlines, minimum payment thresholds, and hold release criteria. Policy reference is essential for student appeals, hold just',
    `employee_id` BIGINT COMMENT 'System user identifier of the staff member or automated process that placed the hold.',
    `profile_id` BIGINT COMMENT 'Unique identifier of the student whose account has the hold placed. Links to the student master record.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Account holds are often mandated by regulatory requirements (Title IV holds pending R2T4 calculation, state-mandated collection holds, FERPA-related access restrictions). Higher-ed compliance officers',
    `sap_evaluation_id` BIGINT COMMENT 'Foreign key linking to aid.aid_sap_evaluation. Business justification: SAP failures directly trigger financial aid holds on student accounts (account_hold.restricts_financial_aid). The hold record must reference the SAP evaluation that caused it for audit trails, appeal ',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: Account holds are placed ON a student account. Currently account_hold only links to profile, but the hold is actually placed on the account entity itself. This is critical for hold management and acco',
    `tertiary_account_last_modified_by_user_employee_id` BIGINT COMMENT 'System user identifier of the staff member or automated process that last modified the hold record.',
    `academic_year` STRING COMMENT 'Academic year associated with the hold in YYYY-YYYY format (e.g., 2023-2024). Null for holds not tied to a specific academic year.. Valid values are `^[0-9]{4}-[0-9]{4}$`',
    `collections_flag` BOOLEAN COMMENT 'Indicates whether the hold is associated with an account that has been referred to collections for outstanding debt recovery.',
    `contact_email` STRING COMMENT 'Email address of the originating office that the student should contact to resolve the hold.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Phone number of the originating office that the student should contact to resolve the hold.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hold record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary amounts (e.g., USD, CAD, GBP). Applicable for financial holds.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'Date when the hold becomes active and begins restricting student services. May differ from placed_date for scheduled holds.',
    `expiration_date` DATE COMMENT 'Date when the hold automatically expires if not released earlier. Null indicates no automatic expiration.',
    `hold_code` STRING COMMENT 'Institution-defined code representing the type of hold (e.g., BURSAR, LIBRARY, PARKING, HEALTH, ACADEMIC). Used for system processing and reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `hold_reason` STRING COMMENT 'Detailed explanation of why the hold was placed on the student account (e.g., outstanding tuition balance, unreturned library materials, missing immunization records, unpaid parking fines).',
    `hold_status` STRING COMMENT 'Current lifecycle status of the hold indicating whether it is currently in effect or has been resolved.. Valid values are `active|released|expired|waived|pending`',
    `hold_type` STRING COMMENT 'Categorical classification of the hold indicating the functional area responsible for the hold.. Valid values are `financial|academic|administrative|health|disciplinary|library`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hold record was last updated in the system.',
    `minimum_payment_amount` DECIMAL(18,2) COMMENT 'Minimum payment amount required to release the hold, applicable for financial holds. Null for non-financial holds or holds with no minimum payment option.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, context, or special circumstances related to the hold.',
    `notification_sent_date` DATE COMMENT 'Date when the hold notification was sent to the student. Null if no notification has been sent.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a notification has been sent to the student informing them of the hold placement.',
    `placed_date` DATE COMMENT 'Date when the hold was originally placed on the student account.',
    `placed_timestamp` TIMESTAMP COMMENT 'Precise date and time when the hold was placed on the student account, including time zone information.',
    `priority_level` STRING COMMENT 'Numeric priority ranking of the hold, used when multiple holds exist on an account to determine processing order. Lower numbers indicate higher priority.',
    `release_date` DATE COMMENT 'Date when the hold was released or removed from the student account. Null if hold is still active.',
    `release_reason` STRING COMMENT 'Explanation of why the hold was released (e.g., balance paid in full, materials returned, documentation submitted, administrative waiver granted). Null if hold is still active.',
    `release_timestamp` TIMESTAMP COMMENT 'Precise date and time when the hold was released, including time zone information. Null if hold is still active.',
    `resolution_instructions` STRING COMMENT 'Detailed instructions provided to the student on how to resolve the hold and have it released.',
    `restricts_diploma` BOOLEAN COMMENT 'Indicates whether this hold prevents the conferral or release of the diploma to the student.',
    `restricts_financial_aid` BOOLEAN COMMENT 'Indicates whether this hold prevents the disbursement of financial aid funds to the student account.',
    `restricts_grades` BOOLEAN COMMENT 'Indicates whether this hold prevents the student from viewing their grades online or receiving grade reports.',
    `restricts_registration` BOOLEAN COMMENT 'Indicates whether this hold prevents the student from registering for courses.',
    `restricts_transcript` BOOLEAN COMMENT 'Indicates whether this hold prevents the release of official transcripts to the student or third parties.',
    `returned_payment_flag` BOOLEAN COMMENT 'Indicates whether the hold was triggered by a returned or dishonored payment (e.g., NSF check, declined credit card).',
    `severity_level` STRING COMMENT 'Categorical severity classification indicating the urgency and impact of the hold on student services.. Valid values are `critical|high|medium|low`',
    `term_code` STRING COMMENT 'Academic term code associated with the hold, if the hold is term-specific (e.g., 202401 for Spring 2024). Null for holds that span multiple terms.. Valid values are `^[0-9]{6}$`',
    `waiver_eligible_flag` BOOLEAN COMMENT 'Indicates whether this hold is eligible for administrative waiver under institutional policies.',
    CONSTRAINT pk_account_hold PRIMARY KEY(`account_hold_id`)
) COMMENT 'Financial hold placed on a student account that restricts registration, transcript release, diploma conferral, or other services due to outstanding balances, returned payments, or collections activity. Captures hold type, hold reason, originating office, date placed, release date, release reason, minimum payment required for release, and hold status.';

CREATE OR REPLACE TABLE `education_ecm`.`billing`.`tax_form_1098t` (
    `tax_form_1098t_id` BIGINT COMMENT 'Unique identifier for the IRS Form 1098-T record. Primary key for the tax form entity.',
    `alumnus_id` BIGINT COMMENT 'Foreign key linking to advancement.alumnus. Business justification: 1098-T forms issued to alumni taking post-graduation courses (continuing education, certificates) require alumni record linkage for IRS compliance reporting and comprehensive alumni education history ',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: IRS 1098-T filing compliance: 1098-T forms must align to the fiscal period for year-end tax reporting, IRS submission reconciliation, and NACUBO financial statement footnotes. Tax year alone is insuff',
    `original_form_tax_form_1098t_id` BIGINT COMMENT 'Reference to the original 1098-T form ID that this corrected form is replacing. Populated only when correction_indicator is true.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: 1098-T form generation and delivery is governed by institutional policies (electronic consent policy, 1098-T delivery and correction policy). The existing regulatory_requirement_id covers IRS rules; i',
    `profile_id` BIGINT COMMENT 'Identifier of the student for whom this 1098-T form is generated. Links to the student master record.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Individual 1098-T forms are aggregated into IRS regulatory filings (IRS Form 1098-T submission). Higher-ed tax compliance officers must trace each student form to the aggregate regulatory filing submi',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: 1098-T forms are mandated by IRS regulations under IRC Section 6050S. Each form must reference the specific regulatory requirement for audit verification, IRS compliance reviews, and to document the l',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to billing.student_account. Business justification: 1098-T forms are generated based on student account transaction history. Currently tax_form_1098t only links to profile, but the form is actually generated from the student_account charge and payment ',
    `box10_insurance_contract_reimbursement` DECIMAL(18,2) COMMENT 'Amounts billed for qualified tuition and related expenses that were reimbursed or refunded under an insurance contract. Reported in Box 10. Rare field, typically zero.',
    `box1_payments_received` DECIMAL(18,2) COMMENT 'Total payments received during the tax year for qualified tuition and related expenses. Reported in Box 1 of Form 1098-T. Represents amounts actually paid by or on behalf of the student.',
    `box2_amounts_billed` DECIMAL(18,2) COMMENT 'Total amounts billed during the tax year for qualified tuition and related expenses. Reported in Box 2 of Form 1098-T. Used by institutions that report amounts billed rather than amounts received. Mutually exclusive with Box 1 reporting method.',
    `box3_change_reporting_method` BOOLEAN COMMENT 'Indicates whether the institution changed its reporting method from prior year amounts billed (Box 2) to amounts received (Box 1) or vice versa. Checked if true.',
    `box4_adjustments_prior_year` DECIMAL(18,2) COMMENT 'Adjustments to qualified tuition and related expenses reported on a prior year 1098-T. May be positive (additional charges) or negative (refunds/reductions). Reported in Box 4.',
    `box5_scholarships_grants` DECIMAL(18,2) COMMENT 'Total amount of scholarships and grants administered and processed by the institution during the tax year. Reported in Box 5. Includes Title IV federal aid, state grants, and institutional scholarships.',
    `box6_adjustments_scholarships_prior_year` DECIMAL(18,2) COMMENT 'Adjustments to scholarships or grants reported on a prior year 1098-T. May be positive or negative. Reported in Box 6.',
    `box7_checked_amount_includes_expenses` BOOLEAN COMMENT 'Indicates whether the amounts reported in Box 1 or Box 2 include expenses for an academic period that begins in the first three months of the following calendar year. Checked if true.',
    `box8_half_time_student` BOOLEAN COMMENT 'Indicates whether the student was enrolled at least half-time for at least one academic period that began during the tax year. Checked if true. Used to determine eligibility for certain education tax credits.',
    `box9_graduate_student` BOOLEAN COMMENT 'Indicates whether the student was enrolled in a graduate-level program during the tax year. Checked if true. Affects eligibility for certain education tax benefits.',
    `correction_indicator` BOOLEAN COMMENT 'Indicates whether this 1098-T is a corrected form replacing a previously filed form for the same student and tax year. True if this is a correction.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this 1098-T form record was first created in the system. Part of audit trail.',
    `delivery_method` STRING COMMENT 'Method by which the 1098-T form is delivered to the student: electronic (via secure portal), paper (mailed), or both. Institutions must obtain student consent for electronic delivery.. Valid values are `electronic|paper|both`',
    `electronic_consent_date` DATE COMMENT 'Date on which the student provided consent to receive the 1098-T form electronically. Required if delivery_method is electronic. Must be obtained prior to electronic delivery.',
    `eligibility_reason` STRING COMMENT 'Reason why the student is eligible (or not eligible) for a 1098-T form. Students must be enrolled in credit courses and have qualifying transactions to receive a form.. Valid values are `enrolled_credit_courses|received_qtre_payment|received_scholarship_grant|not_eligible`',
    `filer_address_line1` STRING COMMENT 'Primary street address line for the educational institution filing the 1098-T form.',
    `filer_city` STRING COMMENT 'City name for the educational institutions address.',
    `filer_ein` STRING COMMENT 'The institutions federal Employer Identification Number (EIN) as registered with the IRS. Appears on all 1098-T forms filed by the institution.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `filer_name` STRING COMMENT 'Legal name of the educational institution filing the 1098-T form. Must match the name on file with the IRS for the filer EIN.',
    `filer_phone` STRING COMMENT 'Contact phone number for the educational institutions bursar or student accounts office. Used for student inquiries regarding the 1098-T form.. Valid values are `^+?[0-9]{10,15}$`',
    `filer_postal_code` STRING COMMENT 'ZIP code for the educational institutions address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `filer_state` STRING COMMENT 'Two-letter state code for the educational institutions address.. Valid values are `^[A-Z]{2}$`',
    `form_number` STRING COMMENT 'Unique form number assigned to this 1098-T instance for tracking and reference purposes. Typically includes tax year and student identifier components.. Valid values are `^1098T-[0-9]{4}-[0-9]{6,10}$`',
    `form_status` STRING COMMENT 'Current lifecycle status of the 1098-T form. Tracks progression from draft through IRS filing and any subsequent corrections or voids.. Valid values are `draft|pending_review|approved|filed|corrected|voided`',
    `irs_confirmation_number` STRING COMMENT 'Confirmation number received from the IRS FIRE system upon successful submission of the 1098-T form. Serves as proof of filing.',
    `irs_submission_date` DATE COMMENT 'Date on which the 1098-T form was electronically filed with the IRS via the FIRE (Filing Information Returns Electronically) system. Required for Title IV compliance tracking.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special circumstances related to this 1098-T form. Used for internal documentation and audit trail purposes.',
    `reporting_method` STRING COMMENT 'Indicates whether the institution reports qualified tuition and related expenses using the payments received method (Box 1) or the amounts billed method (Box 2). Institutions must use one method consistently.. Valid values are `payments_received|amounts_billed`',
    `student_address_line1` STRING COMMENT 'Primary street address line for the students mailing address as of the tax year end. Required for IRS Form 1098-T mailing.',
    `student_address_line2` STRING COMMENT 'Secondary address line (apartment, suite, unit number) for the students mailing address. Optional field.',
    `student_city` STRING COMMENT 'City name for the students mailing address as of the tax year end.',
    `student_country` STRING COMMENT 'Three-letter ISO country code for the students mailing address. Defaults to USA for domestic students.. Valid values are `^[A-Z]{3}$`',
    `student_delivery_date` DATE COMMENT 'Date on which the 1098-T form was delivered to the student (electronically posted or mailed). Must be on or before January 31 following the tax year.',
    `student_legal_name` STRING COMMENT 'The full legal name of the student as it appears on their tax records and must match IRS records. Used for 1098-T reporting.',
    `student_postal_code` STRING COMMENT 'ZIP code or ZIP+4 code for the students mailing address. Five-digit or nine-digit format.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `student_state` STRING COMMENT 'Two-letter state or territory code for the students mailing address (e.g., CA, NY, TX). Uses USPS standard abbreviations.. Valid values are `^[A-Z]{2}$`',
    `student_tin` STRING COMMENT 'The students Social Security Number (SSN) or Individual Taxpayer Identification Number (ITIN) as reported to the IRS. Required for IRS filing.. Valid values are `^[0-9]{3}-[0-9]{2}-[0-9]{4}$|^[0-9]{2}-[0-9]{7}$`',
    `tax_year` STRING COMMENT 'The calendar year for which qualified tuition and related expenses (QTRE) and scholarships/grants are being reported to the IRS. Four-digit year (e.g., 2023).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this 1098-T form record was last modified. Updated whenever any field changes. Part of audit trail.',
    CONSTRAINT pk_tax_form_1098t PRIMARY KEY(`tax_form_1098t_id`)
) COMMENT 'IRS Form 1098-T record generated annually for each eligible student reporting qualified tuition and related expenses (QTRE) and scholarships/grants for federal tax purposes. Captures tax year, Box 1 (payments received), Box 5 (scholarships/grants), Box 8 (at least half-time enrollment), Box 9 (graduate student), TIN, delivery consent (electronic/paper), and IRS submission status. Required for Title IV compliance.';

CREATE OR REPLACE TABLE `education_ecm`.`billing`.`fee_schedule` (
    `fee_schedule_id` BIGINT COMMENT 'Unique identifier for the fee schedule record. Primary key for the fee schedule entity.',
    `academic_program_id` BIGINT COMMENT 'Reference to the academic program to which this fee schedule applies. Links to curriculum program master data.',
    `benefit_plan_id` BIGINT COMMENT 'Foreign key linking to hr.benefit_plan. Business justification: Employee tuition waiver administration in higher-ed requires linking the fee schedule (defining waiver rates and credit-hour limits) to the HR benefit plan that grants the waiver. benefit_plan.tuition',
    `campus_id` BIGINT COMMENT 'Foreign key linking to facility.campus. Business justification: Fee schedules in higher-ed are campus-specific: technology fees, parking fees, and facility use fees vary by campus. fee_schedule.campus_id → campus supports campus-differentiated fee assessment, boar',
    `concentration_id` BIGINT COMMENT 'Foreign key linking to curriculum.concentration. Business justification: Higher-ed institutions assess concentration-specific surcharges (e.g., nursing clinical fees, MBA program fees). Fee schedule must be linkable to a specific concentration to support concentration-leve',
    `course_id` BIGINT COMMENT 'Reference to a specific course for course-specific fees such as lab fees, materials fees, or studio fees. Nullable for program-level or institution-wide fees.',
    `dining_plan_id` BIGINT COMMENT 'Foreign key linking to studentlife.dining_plan. Business justification: Dining plan rate configuration process: fee schedules define the charge rates applied when students enroll in dining plans. Linking fee_schedule to dining_plan enables automated charge assessment at e',
    `employee_id` BIGINT COMMENT 'User identifier of the person who last modified this fee schedule record. Maintains accountability for changes.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Fund accounting for fee revenue: in higher-ed fund accounting, each fee schedule allocates revenue to a specific fund (general, auxiliary, restricted). The plain fund_code attribute is a denormalizati',
    `ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.ledger_account. Business justification: Revenue recognition and GL posting rules: fee schedules must reference a ledger account so that assessed fees auto-post to the correct GL revenue account. The plain gl_account_code attribute is a deno',
    `org_unit_id` BIGINT COMMENT 'Reference to the college or school within the institution to which this fee schedule applies. Enables college-specific tuition and fee structures.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Fee schedules are established through board-approved tuition and fee policies. Policy reference links rates to governance approval, supports audit verification of authorized rates, and ensures complia',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: Fee schedules must comply with regulatory requirements (state tuition-setting regulations, Title IV allowable fee rules, IPEDS fee reporting requirements). This is a distinct regulatory compliance dim',
    `term_id` BIGINT COMMENT 'Reference to the academic term for which this fee schedule is effective. Links to the term master data.',
    `approval_reference_number` STRING COMMENT 'Reference number or resolution identifier from the board meeting minutes approving this fee schedule. Supports audit trail and governance compliance.',
    `assessment_rule` STRING COMMENT 'Defines how the fee is applied to student accounts. Automatic fees are assessed by the billing engine based on enrollment data. Manual fees require staff intervention. Conditional fees are assessed based on specific business rules.. Valid values are `automatic|manual|conditional`',
    `board_approval_date` DATE COMMENT 'Date on which the institutional governing board approved this fee schedule. Required for compliance with institutional governance policies and state regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fee schedule record was first created in the system. Part of the audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the rate amount. Typically USD for U.S. institutions but supports international campuses and programs.. Valid values are `^[A-Z]{3}$`',
    `department_code` STRING COMMENT 'Academic or administrative department code responsible for this fee. Used for revenue attribution and departmental budget management.. Valid values are `^[A-Z0-9]{2,8}$`',
    `effective_date` DATE COMMENT 'Date on which this fee schedule becomes active and eligible for use in billing calculations. Supports temporal versioning of rate structures.',
    `enrollment_intensity` STRING COMMENT 'Method by which tuition is calculated based on enrollment load. Determines whether charges are assessed per credit hour, as a flat rate for full-time enrollment, or using tiered brackets.. Valid values are `per_credit_hour|flat_rate|per_course|tiered`',
    `expiration_date` DATE COMMENT 'Date on which this fee schedule ceases to be active. Nullable for open-ended schedules. Enables historical rate tracking and audit compliance.',
    `fee_category` STRING COMMENT 'Classification of the fee type. Categorizes charges for reporting, financial aid packaging, and COA (Cost of Attendance) calculations. [ENUM-REF-CANDIDATE: tuition|technology|health|activity|lab|course_specific|facility|parking|housing|meal_plan|library|graduation|application|late_payment|other — 15 candidates stripped; promote to reference product]',
    `fee_schedule_description` STRING COMMENT 'Detailed description of the fee schedule including applicability rules, special conditions, and business context. Used for staff reference and audit documentation.',
    `financial_aid_eligible` BOOLEAN COMMENT 'Indicates whether this fee is included in the Cost of Attendance (COA) calculation for financial aid packaging and Title IV eligibility.',
    `maximum_credit_hours` DECIMAL(18,2) COMMENT 'Maximum number of credit hours for which this fee schedule applies. Defines the upper bound of tiered billing brackets or flat-rate caps.',
    `minimum_credit_hours` DECIMAL(18,2) COMMENT 'Minimum number of credit hours required for this fee schedule to apply. Used for tiered billing and flat-rate eligibility thresholds.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fee schedule record was last updated. Tracks the most recent change for audit and data quality purposes.',
    `notes` STRING COMMENT 'Free-text field for administrative notes, special instructions, or contextual information about this fee schedule. Used by billing staff for operational guidance.',
    `priority_sequence` STRING COMMENT 'Numeric sequence defining the order in which fee schedules are evaluated when multiple schedules could apply to a student. Lower numbers indicate higher priority.',
    `program_level` STRING COMMENT 'Level of academic program to which this fee schedule applies. Determines tuition rate structure and eligibility for specific fees. [ENUM-REF-CANDIDATE: undergraduate|graduate|doctoral|professional|certificate|non_degree|continuing_education — 7 candidates stripped; promote to reference product]',
    `proration_allowed` BOOLEAN COMMENT 'Indicates whether this fee can be prorated based on enrollment changes or late registration. Critical for refund and adjustment calculations.',
    `rate_amount` DECIMAL(18,2) COMMENT 'The monetary amount charged per unit as defined by the enrollment intensity method. For per-credit-hour schedules, this is the rate per credit hour. For flat-rate schedules, this is the total charge.',
    `refundable` BOOLEAN COMMENT 'Indicates whether this fee is eligible for refund under institutional refund policies. Non-refundable fees are excluded from drop/withdrawal refund calculations.',
    `residency_status` STRING COMMENT 'Residency classification determining tuition rate eligibility. Critical for differential tuition pricing and state funding calculations.. Valid values are `in_state|out_of_state|international|regional_exchange|military|employee`',
    `schedule_code` STRING COMMENT 'Business identifier code for the fee schedule. Used for external reference and reporting. Typically follows institutional coding standards.. Valid values are `^[A-Z0-9]{4,12}$`',
    `schedule_name` STRING COMMENT 'Descriptive name of the fee schedule. Human-readable label used in billing communications and student account statements.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the fee schedule. Controls whether the schedule is available for automated charge assessment in the billing engine.. Valid values are `draft|active|inactive|superseded|archived`',
    `tax_reportable_1098t` BOOLEAN COMMENT 'Indicates whether this fee must be reported on IRS Form 1098-T for qualified tuition and related expenses. Critical for tax compliance and student tax reporting.',
    `version_number` STRING COMMENT 'Version number of this fee schedule record. Incremented with each modification to support change tracking and historical analysis.',
    CONSTRAINT pk_fee_schedule PRIMARY KEY(`fee_schedule_id`)
) COMMENT 'Comprehensive reference catalog defining all tuition rates and fee schedules used for automated charge assessment. Defines rates by term, program level (undergraduate, graduate, doctoral, professional), residency status (in-state, out-of-state, international), enrollment intensity (per credit hour, flat rate), college/school, and fee category (tuition, technology, health, activity, lab, course-specific). Effective-dated to support rate changes across terms. Serves as the single source of truth for all billing rate data and drives the fee assessment rules engine.';

CREATE OR REPLACE TABLE `education_ecm`.`billing`.`sponsorship_authorization` (
    `sponsorship_authorization_id` BIGINT COMMENT 'Primary key for the sponsorship_authorization association',
    `student_account_id` BIGINT COMMENT 'Foreign key linking to the student financial account of the student authorized under this sponsor contract.',
    `third_party_contract_id` BIGINT COMMENT 'Foreign key linking to the third-party billing contract under which this student is authorized for sponsor payment.',
    `amount_billed_to_sponsor` DECIMAL(18,2) COMMENT 'The actual dollar amount invoiced to the sponsor for this student under this contract for the billing period. May differ from coverage_amount_per_student if charges were less than the authorized maximum or if partial billing occurred.',
    `authorization_date` DATE COMMENT 'The date on which the bursars office formally authorized this student for billing under this third-party contract. Marks the start of the authorization lifecycle for this student-contract pairing.',
    `authorization_status` STRING COMMENT 'Current lifecycle status of this sponsorship authorization record. Tracks the authorization from initial creation through eligibility verification, invoicing, and payment resolution.',
    `billing_period_end` DATE COMMENT 'The end date of the academic term or billing period for which this sponsorship authorization is valid. Together with billing_period_start, defines the window during which charges may be billed to the sponsor for this student.',
    `billing_period_start` DATE COMMENT 'The start date of the academic term or billing period for which this sponsorship authorization is valid. Scopes the authorization to a specific period, enabling per-term sponsor billing.',
    `coverage_amount_per_student` DECIMAL(18,2) COMMENT 'The dollar amount the sponsor has authorized to pay for this specific student under this contract for the applicable billing period. Belongs to the authorization, not to the contract (which may have a global cap) nor to the student account (which aggregates all charges).',
    `eligibility_verified_flag` BOOLEAN COMMENT 'Indicates whether the students eligibility criteria have been confirmed against the contracts eligible_student_criteria for this authorization record. Must be true before invoicing the sponsor for this student.',
    CONSTRAINT pk_sponsorship_authorization PRIMARY KEY(`sponsorship_authorization_id`)
) COMMENT 'This association product represents the Contract between third_party_contract and student_account. It captures the per-student, per-contract authorization record that the bursars office creates when a specific student is approved for billing under a specific third-party sponsor contract. Each record links one third_party_contract to one student_account and carries the coverage amount, billing period, eligibility verification status, and amounts billed — data that exists only in the context of this specific student-contract pairing.. Existence Justification: In higher education, third-party billing is an operational process where a single sponsor contract (e.g., VA Chapter 33, an employer tuition benefit program) covers many students simultaneously, and a single student can legitimately have multiple sponsors in the same or different terms (e.g., a veteran receiving VA benefits AND an employer tuition reimbursement). The bursars office actively creates, manages, and terminates individual sponsorship authorizations — each with its own coverage amount, billing period, eligibility verification status, and amount billed — making this a genuine operational M:N with rich relationship-level data.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `education_ecm`.`billing`.`student_account` ADD CONSTRAINT `fk_billing_student_account_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `education_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_fee_schedule_id` FOREIGN KEY (`fee_schedule_id`) REFERENCES `education_ecm`.`billing`.`fee_schedule`(`fee_schedule_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_statement_id` FOREIGN KEY (`statement_id`) REFERENCES `education_ecm`.`billing`.`statement`(`statement_id`);
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ADD CONSTRAINT `fk_billing_tuition_charge_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `education_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `education_ecm`.`billing`.`statement` ADD CONSTRAINT `fk_billing_statement_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `education_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_plan_installment_id` FOREIGN KEY (`payment_plan_installment_id`) REFERENCES `education_ecm`.`billing`.`payment_plan_installment`(`payment_plan_installment_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_primary_reversed_by_payment_id` FOREIGN KEY (`primary_reversed_by_payment_id`) REFERENCES `education_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_statement_id` FOREIGN KEY (`statement_id`) REFERENCES `education_ecm`.`billing`.`statement`(`statement_id`);
ALTER TABLE `education_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ADD CONSTRAINT `fk_billing_payment_plan_installment_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `education_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `education_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`billing`.`refund` ADD CONSTRAINT `fk_billing_refund_tuition_charge_id` FOREIGN KEY (`tuition_charge_id`) REFERENCES `education_ecm`.`billing`.`tuition_charge`(`tuition_charge_id`);
ALTER TABLE `education_ecm`.`billing`.`account_hold` ADD CONSTRAINT `fk_billing_account_hold_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ADD CONSTRAINT `fk_billing_tax_form_1098t_original_form_tax_form_1098t_id` FOREIGN KEY (`original_form_tax_form_1098t_id`) REFERENCES `education_ecm`.`billing`.`tax_form_1098t`(`tax_form_1098t_id`);
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ADD CONSTRAINT `fk_billing_tax_form_1098t_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` ADD CONSTRAINT `fk_billing_sponsorship_authorization_student_account_id` FOREIGN KEY (`student_account_id`) REFERENCES `education_ecm`.`billing`.`student_account`(`student_account_id`);
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` ADD CONSTRAINT `fk_billing_sponsorship_authorization_third_party_contract_id` FOREIGN KEY (`third_party_contract_id`) REFERENCES `education_ecm`.`billing`.`third_party_contract`(`third_party_contract_id`);

-- ========= TAGS =========
ALTER SCHEMA `education_ecm`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `education_ecm`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `education_ecm`.`billing`.`student_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`billing`.`student_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account ID');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan ID');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `profile_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `sponsor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor ID');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Collections Agency ID');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `account_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Account Closed Date');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Student Account Number');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `account_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Account Opened Date');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Student Account Status');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|hold|collections');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Student Account Type');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|professional|continuing_education|non_degree|consortium');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `anticipated_balance` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Account Balance');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `collections_placement_date` SET TAGS ('dbx_business_glossary_term' = 'Collections Placement Date');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `collections_status` SET TAGS ('dbx_business_glossary_term' = 'Collections Status');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `collections_status` SET TAGS ('dbx_value_regex' = 'not_in_collections|internal_collections|external_collections|legal_action|settled|written_off');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `cumulative_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Adjustments');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `cumulative_charges` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Charges');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `cumulative_payments` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Payments');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Account Balance');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `has_graduation_hold` SET TAGS ('dbx_business_glossary_term' = 'Graduation Hold Flag');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `has_registration_hold` SET TAGS ('dbx_business_glossary_term' = 'Registration Hold Flag');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `has_transcript_hold` SET TAGS ('dbx_business_glossary_term' = 'Transcript Hold Flag');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `hold_count` SET TAGS ('dbx_business_glossary_term' = 'Account Hold Count');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `last_1098t_tax_year` SET TAGS ('dbx_business_glossary_term' = 'Last 1098-T Tax Year');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `last_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Statement Date');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `next_statement_date` SET TAGS ('dbx_business_glossary_term' = 'Next Statement Date');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `payment_plan_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Enrolled Flag');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `pending_charges` SET TAGS ('dbx_business_glossary_term' = 'Pending Charges');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `pending_financial_aid` SET TAGS ('dbx_business_glossary_term' = 'Pending Financial Aid');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `tax_form_1098t_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tax Form 1098-T Eligible Flag');
ALTER TABLE `education_ecm`.`billing`.`student_account` ALTER COLUMN `third_party_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Billing Flag');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `tuition_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Tuition Charge Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'College Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `dining_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Dining Enrollment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessed By User Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `enrollment_status_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `graduation_application_id` SET TAGS ('dbx_business_glossary_term' = 'Graduation Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `grant_account_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `health_visit_id` SET TAGS ('dbx_business_glossary_term' = 'Health Visit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `health_visit_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `health_visit_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `residency_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Residency Classification Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `section_id` SET TAGS ('dbx_business_glossary_term' = 'Section Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `statement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Statement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `billing_method` SET TAGS ('dbx_business_glossary_term' = 'Billing Method');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `billing_method` SET TAGS ('dbx_value_regex' = 'per_credit_hour|flat_rate|cohort|contract|consortium');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `charge_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Code');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `charge_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `charge_description` SET TAGS ('dbx_business_glossary_term' = 'Charge Description');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `charge_status` SET TAGS ('dbx_business_glossary_term' = 'Charge Status');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `charge_status` SET TAGS ('dbx_value_regex' = 'assessed|posted|adjusted|reversed|waived|cancelled');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours (CR)');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `flat_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Flat Rate Amount');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `is_refundable` SET TAGS ('dbx_business_glossary_term' = 'Is Refundable Flag');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `is_reportable_1098t` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable on 1098-T Flag');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `net_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Charge Amount');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `posted_date` SET TAGS ('dbx_business_glossary_term' = 'Posted Date');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `program_level` SET TAGS ('dbx_business_glossary_term' = 'Program Level');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `program_level` SET TAGS ('dbx_value_regex' = 'undergraduate|graduate|doctoral|professional|certificate|non_degree');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `rate_per_credit_hour` SET TAGS ('dbx_business_glossary_term' = 'Rate Per Credit Hour');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `refund_percentage` SET TAGS ('dbx_business_glossary_term' = 'Refund Percentage');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `revenue_category` SET TAGS ('dbx_business_glossary_term' = 'Revenue Category');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `revenue_category` SET TAGS ('dbx_value_regex' = 'tuition_revenue|fee_revenue|auxiliary_revenue|other_revenue');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `student_type` SET TAGS ('dbx_business_glossary_term' = 'Student Type');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `student_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|visiting|exchange|dual_enrollment|continuing_education');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `waiver_amount` SET TAGS ('dbx_business_glossary_term' = 'Waiver Amount');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `waiver_code` SET TAGS ('dbx_business_glossary_term' = 'Waiver Code');
ALTER TABLE `education_ecm`.`billing`.`tuition_charge` ALTER COLUMN `waiver_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`billing`.`statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`billing`.`statement` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `statement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Statement Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `account_hold_indicator` SET TAGS ('dbx_business_glossary_term' = 'Account Hold Indicator');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'fall|spring|summer|monthly|quarterly|annual');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Statement Delivery Method');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'email|portal|paper|electronic');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `fee_charges` SET TAGS ('dbx_business_glossary_term' = 'Fee Charges');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `financial_aid_disbursed` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Disbursed');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `grant_amount` SET TAGS ('dbx_business_glossary_term' = 'Grant Amount');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `housing_charges` SET TAGS ('dbx_business_glossary_term' = 'Housing Charges');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `is_1098t_eligible` SET TAGS ('dbx_business_glossary_term' = '1098-T Eligibility Indicator');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `loan_disbursement` SET TAGS ('dbx_business_glossary_term' = 'Loan Disbursement Amount');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `meal_plan_charges` SET TAGS ('dbx_business_glossary_term' = 'Meal Plan Charges');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `minimum_payment_due` SET TAGS ('dbx_business_glossary_term' = 'Minimum Payment Due');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `net_balance` SET TAGS ('dbx_business_glossary_term' = 'Net Balance Due');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Statement Notes');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `previous_balance` SET TAGS ('dbx_business_glossary_term' = 'Previous Statement Balance');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `scholarship_amount` SET TAGS ('dbx_business_glossary_term' = 'Scholarship Amount');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `statement_date` SET TAGS ('dbx_business_glossary_term' = 'Statement Date');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Statement Number');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `statement_status` SET TAGS ('dbx_business_glossary_term' = 'Statement Status');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `third_party_sponsor_amount` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Sponsor Amount');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `total_charges` SET TAGS ('dbx_business_glossary_term' = 'Total Charges Amount');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `total_credits` SET TAGS ('dbx_business_glossary_term' = 'Total Credits Amount');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `total_payments` SET TAGS ('dbx_business_glossary_term' = 'Total Payments Amount');
ALTER TABLE `education_ecm`.`billing`.`statement` ALTER COLUMN `tuition_charges` SET TAGS ('dbx_business_glossary_term' = 'Tuition Charges');
ALTER TABLE `education_ecm`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `ar_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Receipt Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payment_plan_installment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Installment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `primary_reversed_by_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed By Payment Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `room_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Room Booking Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `statement_id` SET TAGS ('dbx_business_glossary_term' = 'Statement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `authorization_code` SET TAGS ('dbx_business_glossary_term' = 'Authorization Code');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Last Four Digits');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `base_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Currency Amount');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Card Type');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web_portal|mobile_app|in_person|mail|phone|third_party');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Confirmation Number');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Date');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `is_refundable` SET TAGS ('dbx_business_glossary_term' = 'Is Refundable Flag');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payer_email` SET TAGS ('dbx_business_glossary_term' = 'Payer Email Address');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Name');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payer_phone` SET TAGS ('dbx_business_glossary_term' = 'Payer Phone Number');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payer_type` SET TAGS ('dbx_value_regex' = 'student|parent|guardian|sponsor|employer|third_party');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|posted|reversed|voided|failed');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `posted_date` SET TAGS ('dbx_business_glossary_term' = 'Posted Date');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `processing_fee` SET TAGS ('dbx_business_glossary_term' = 'Processing Fee');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `processor_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Reference Number');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `education_ecm`.`billing`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `auto_pay_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Pay Enabled Flag');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Cancellation Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Plan Cancellation Reason');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Completion Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `default_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Default Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `down_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Amount');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective End Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Start Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Enrollment Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `enrollment_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Fee Amount');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `final_installment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Final Installment Due Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `first_installment_due_date` SET TAGS ('dbx_business_glossary_term' = 'First Installment Due Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Installment Payment Amount');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Installment Payment Frequency');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_value_regex' = 'monthly|biweekly|weekly|custom');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `installments_missed_count` SET TAGS ('dbx_business_glossary_term' = 'Installments Missed Count');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `installments_paid_count` SET TAGS ('dbx_business_glossary_term' = 'Installments Paid Count');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `interest_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Percentage');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Notes');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `number_of_installments` SET TAGS ('dbx_business_glossary_term' = 'Number of Installments');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `payment_method_type` SET TAGS ('dbx_value_regex' = 'ach|credit_card|debit_card|check|cash|wire_transfer');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Number');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^PP[0-9]{8}$');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Status');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|completed|defaulted|cancelled|suspended|pending');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Type');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'standard|extended|custom|emergency|short_term|deferred');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `total_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Paid');
ALTER TABLE `education_ecm`.`billing`.`payment_plan` ALTER COLUMN `total_plan_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Plan Amount');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `payment_plan_installment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Installment ID');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan ID');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `actual_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Payment Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `adjustment_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Authorized By');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `auto_pay_attempt_date` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Attempt Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `auto_pay_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Enabled Flag');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `auto_pay_failure_reason` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Failure Reason');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `auto_pay_status` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Status');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `auto_pay_status` SET TAGS ('dbx_value_regex' = 'pending|successful|failed|not_attempted');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `collections_agency` SET TAGS ('dbx_business_glossary_term' = 'Collections Agency');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `collections_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Collections Referral Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `effective_due_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Due Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `hold_applied` SET TAGS ('dbx_business_glossary_term' = 'Hold Applied Flag');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `hold_applied_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Applied Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `installment_number` SET TAGS ('dbx_business_glossary_term' = 'Installment Sequence Number');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `installment_status` SET TAGS ('dbx_business_glossary_term' = 'Installment Status');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `installment_status` SET TAGS ('dbx_value_regex' = 'scheduled|paid|overdue|partial|waived|cancelled');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `late_fee_assessed` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Assessed Flag');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'email|sms|postal_mail|portal_alert|phone');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Installment Balance');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `scheduled_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Installment Amount');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `scheduled_due_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Due Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Code');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `waiver_authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Authorized By');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `education_ecm`.`billing`.`payment_plan_installment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `education_ecm`.`billing`.`refund` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`billing`.`refund` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `refund_id` SET TAGS ('dbx_business_glossary_term' = 'Refund Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Bank Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `aid_award_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Award Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `graduation_application_id` SET TAGS ('dbx_business_glossary_term' = 'Graduation Application Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `housing_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Studentlife Housing Assignment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `leave_of_absence_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Of Absence Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Payment Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `refund_processed_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Processed By User Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `refund_processed_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `refund_processed_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `research_award_id` SET TAGS ('dbx_business_glossary_term' = 'Research Award Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `room_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Room Booking Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `tuition_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Tuition Charge Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Approved Date');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Type');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_value_regex' = 'checking|savings');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `bank_account_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `check_cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Check Cleared Date');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `check_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Check Issue Date');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `check_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `eft_trace_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Funds Transfer (EFT) Trace Number');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `eft_trace_number` SET TAGS ('dbx_value_regex' = '^[0-9]{15}$');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `fund_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `is_reportable_1098t` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable on 1098-T');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `is_title_iv_refund` SET TAGS ('dbx_business_glossary_term' = 'Is Title IV Refund');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Refund Notes');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `originating_credit_source` SET TAGS ('dbx_business_glossary_term' = 'Originating Credit Source');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Payee Address Line 1');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Payee Address Line 2');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_city` SET TAGS ('dbx_business_glossary_term' = 'Payee City');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_country_code` SET TAGS ('dbx_business_glossary_term' = 'Payee Country Code');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Payee Postal Code');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_state_province` SET TAGS ('dbx_business_glossary_term' = 'Payee State or Province');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `payee_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `processed_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Processed Date');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Code');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Refund Reason Description');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `refund_method` SET TAGS ('dbx_business_glossary_term' = 'Refund Method');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `refund_method` SET TAGS ('dbx_value_regex' = 'ach_direct_deposit|paper_check|wire_transfer|original_payment_method|debit_card|credit_to_account');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `refund_number` SET TAGS ('dbx_business_glossary_term' = 'Refund Number');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `refund_number` SET TAGS ('dbx_value_regex' = '^REF-[0-9]{8}$');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `refund_status` SET TAGS ('dbx_value_regex' = 'pending|approved|processed|cancelled|failed|reversed');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_business_glossary_term' = 'Refund Type');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `refund_type` SET TAGS ('dbx_value_regex' = 'credit_balance|financial_aid_excess|course_drop|withdrawal|overpayment|adjustment');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `requested_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Requested Date');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Term Code');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`billing`.`refund` ALTER COLUMN `title_iv_return_calculation_date` SET TAGS ('dbx_business_glossary_term' = 'Title IV Return Calculation Date');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` SET TAGS ('dbx_subdomain' = 'sponsorship_billing');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `third_party_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Contract Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Administrator Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Organization Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `auto_apply_to_eligible_students` SET TAGS ('dbx_business_glossary_term' = 'Auto-Apply to Eligible Students Flag');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Email Address');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Name');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Billing Contact Phone Number');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'per_term|monthly|quarterly|annual|upon_enrollment|custom');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Name');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|pending_renewal');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `coverage_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Amount');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `coverage_limit_period` SET TAGS ('dbx_business_glossary_term' = 'Coverage Limit Period');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `coverage_limit_period` SET TAGS ('dbx_value_regex' = 'per_term|per_academic_year|per_calendar_year|lifetime|none');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Coverage Scope');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_value_regex' = 'tuition_only|tuition_and_fees|tuition_fees_books|full_cost_of_attendance|custom');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `default_purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Default Purchase Order Number');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `eligible_student_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligible Student Criteria');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `federal_contract_indicator` SET TAGS ('dbx_business_glossary_term' = 'Federal Contract Indicator');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|postal_mail|electronic_portal|edi|fax');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `invoice_format` SET TAGS ('dbx_business_glossary_term' = 'Invoice Format');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `invoice_format` SET TAGS ('dbx_value_regex' = 'summary|detailed|itemized|custom');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `purchase_order_required` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Required Flag');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `renewal_notification_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Days');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `requires_enrollment_verification` SET TAGS ('dbx_business_glossary_term' = 'Requires Enrollment Verification Flag');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `requires_student_authorization` SET TAGS ('dbx_business_glossary_term' = 'Requires Student Authorization Flag');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `sponsor_type` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Type');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `education_ecm`.`billing`.`third_party_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Reason');
ALTER TABLE `education_ecm`.`billing`.`account_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`billing`.`account_hold` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `account_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Account Hold Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Office Org Unit Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Placed By User Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `sap_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Aid Sap Evaluation Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `tertiary_account_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `tertiary_account_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `tertiary_account_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `academic_year` SET TAGS ('dbx_business_glossary_term' = 'Academic Year');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `academic_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-[0-9]{4}$');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `collections_flag` SET TAGS ('dbx_business_glossary_term' = 'Collections Activity Flag');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Effective Date');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Date');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `hold_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Code');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `hold_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|expired|waived|pending');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Hold Type');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'financial|academic|administrative|health|disciplinary|library');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `minimum_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Payment Amount');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hold Notes');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `placed_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Date');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Placed Timestamp');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Hold Priority Level');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Date');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Reason');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `resolution_instructions` SET TAGS ('dbx_business_glossary_term' = 'Resolution Instructions');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `restricts_diploma` SET TAGS ('dbx_business_glossary_term' = 'Restricts Diploma Conferral Flag');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `restricts_financial_aid` SET TAGS ('dbx_business_glossary_term' = 'Restricts Financial Aid Disbursement Flag');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `restricts_grades` SET TAGS ('dbx_business_glossary_term' = 'Restricts Grade Access Flag');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `restricts_registration` SET TAGS ('dbx_business_glossary_term' = 'Restricts Registration Flag');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `restricts_transcript` SET TAGS ('dbx_business_glossary_term' = 'Restricts Transcript Release Flag');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `returned_payment_flag` SET TAGS ('dbx_business_glossary_term' = 'Returned Payment Flag');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Hold Severity Level');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `term_code` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Code');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `term_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6}$');
ALTER TABLE `education_ecm`.`billing`.`account_hold` ALTER COLUMN `waiver_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Eligible Flag');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `tax_form_1098t_id` SET TAGS ('dbx_business_glossary_term' = 'Tax Form 1098-T (Tuition Statement) ID');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `alumnus_id` SET TAGS ('dbx_business_glossary_term' = 'Alumnus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `original_form_tax_form_1098t_id` SET TAGS ('dbx_business_glossary_term' = 'Original Form ID');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Student ID');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Student Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `box10_insurance_contract_reimbursement` SET TAGS ('dbx_business_glossary_term' = 'Box 10 Amounts Billed for Insurance Contract Reimbursement or Refund');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `box1_payments_received` SET TAGS ('dbx_business_glossary_term' = 'Box 1 Payments Received for Qualified Tuition and Related Expenses (QTRE)');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `box2_amounts_billed` SET TAGS ('dbx_business_glossary_term' = 'Box 2 Amounts Billed for Qualified Tuition and Related Expenses (QTRE)');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `box3_change_reporting_method` SET TAGS ('dbx_business_glossary_term' = 'Box 3 Change in Reporting Method Indicator');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `box4_adjustments_prior_year` SET TAGS ('dbx_business_glossary_term' = 'Box 4 Adjustments Made for a Prior Year');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `box5_scholarships_grants` SET TAGS ('dbx_business_glossary_term' = 'Box 5 Scholarships or Grants');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `box6_adjustments_scholarships_prior_year` SET TAGS ('dbx_business_glossary_term' = 'Box 6 Adjustments to Scholarships or Grants for a Prior Year');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `box7_checked_amount_includes_expenses` SET TAGS ('dbx_business_glossary_term' = 'Box 7 Checked if Amount Includes Expenses for Academic Period Beginning January Through March');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `box8_half_time_student` SET TAGS ('dbx_business_glossary_term' = 'Box 8 At Least Half-Time Student Indicator');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `box9_graduate_student` SET TAGS ('dbx_business_glossary_term' = 'Box 9 Graduate Student Indicator');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `correction_indicator` SET TAGS ('dbx_business_glossary_term' = 'Correction Indicator');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|both');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `electronic_consent_date` SET TAGS ('dbx_business_glossary_term' = 'Electronic Consent Date');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `eligibility_reason` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Reason');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `eligibility_reason` SET TAGS ('dbx_value_regex' = 'enrolled_credit_courses|received_qtre_payment|received_scholarship_grant|not_eligible');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Filer Address Line 1');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_city` SET TAGS ('dbx_business_glossary_term' = 'Filer City');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_ein` SET TAGS ('dbx_business_glossary_term' = 'Filer Employer Identification Number (EIN)');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_ein` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_ein` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_name` SET TAGS ('dbx_business_glossary_term' = 'Filer Name');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_phone` SET TAGS ('dbx_business_glossary_term' = 'Filer Phone Number');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Filer Postal Code');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_state` SET TAGS ('dbx_business_glossary_term' = 'Filer State');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `filer_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `form_number` SET TAGS ('dbx_business_glossary_term' = 'Form Number');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `form_number` SET TAGS ('dbx_value_regex' = '^1098T-[0-9]{4}-[0-9]{6,10}$');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `form_status` SET TAGS ('dbx_business_glossary_term' = 'Form Status');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `form_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|filed|corrected|voided');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `irs_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'IRS (Internal Revenue Service) Confirmation Number');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `irs_submission_date` SET TAGS ('dbx_business_glossary_term' = 'IRS (Internal Revenue Service) Submission Date');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `reporting_method` SET TAGS ('dbx_business_glossary_term' = 'Reporting Method');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `reporting_method` SET TAGS ('dbx_value_regex' = 'payments_received|amounts_billed');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Student Address Line 1');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Student Address Line 2');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_city` SET TAGS ('dbx_business_glossary_term' = 'Student City');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_country` SET TAGS ('dbx_business_glossary_term' = 'Student Country');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Student Delivery Date');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_legal_name` SET TAGS ('dbx_business_glossary_term' = 'Student Legal Name');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_legal_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_legal_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Student Postal Code');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_state` SET TAGS ('dbx_business_glossary_term' = 'Student State');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_tin` SET TAGS ('dbx_business_glossary_term' = 'Student Taxpayer Identification Number (TIN)');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_tin` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{2}-[0-9]{4}$|^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_tin` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `student_tin` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `education_ecm`.`billing`.`tax_form_1098t` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `fee_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `academic_program_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `campus_id` SET TAGS ('dbx_business_glossary_term' = 'Campus Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `concentration_id` SET TAGS ('dbx_business_glossary_term' = 'Concentration Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `dining_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Dining Plan Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Account Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'College or School Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `term_id` SET TAGS ('dbx_business_glossary_term' = 'Academic Term Identifier (ID)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Reference Number');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `assessment_rule` SET TAGS ('dbx_business_glossary_term' = 'Fee Assessment Rule');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `assessment_rule` SET TAGS ('dbx_value_regex' = 'automatic|manual|conditional');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board of Trustees Approval Date');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `enrollment_intensity` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Intensity Billing Method');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `enrollment_intensity` SET TAGS ('dbx_value_regex' = 'per_credit_hour|flat_rate|per_course|tiered');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `fee_category` SET TAGS ('dbx_business_glossary_term' = 'Fee Category');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `fee_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Description');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `financial_aid_eligible` SET TAGS ('dbx_business_glossary_term' = 'Financial Aid Eligible Flag');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `maximum_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Maximum Credit Hours');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `minimum_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Credit Hours');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Administrative Notes');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `priority_sequence` SET TAGS ('dbx_business_glossary_term' = 'Priority Sequence Number');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `program_level` SET TAGS ('dbx_business_glossary_term' = 'Academic Program Level');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `proration_allowed` SET TAGS ('dbx_business_glossary_term' = 'Proration Allowed Flag');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Rate Amount');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `refundable` SET TAGS ('dbx_business_glossary_term' = 'Refundable Fee Flag');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `residency_status` SET TAGS ('dbx_business_glossary_term' = 'Student Residency Status');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `residency_status` SET TAGS ('dbx_value_regex' = 'in_state|out_of_state|international|regional_exchange|military|employee');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Code');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Name');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Schedule Status');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|superseded|archived');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `tax_reportable_1098t` SET TAGS ('dbx_business_glossary_term' = 'Tax Reportable on Form 1098-T Flag');
ALTER TABLE `education_ecm`.`billing`.`fee_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` SET TAGS ('dbx_subdomain' = 'sponsorship_billing');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` SET TAGS ('dbx_association_edges' = 'billing.third_party_contract,billing.student_account');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` ALTER COLUMN `sponsorship_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Authorization - Sponsorship Authorization Id');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` ALTER COLUMN `student_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Authorization - Student Account Id');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` ALTER COLUMN `third_party_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsorship Authorization - Third Party Contract Id');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` ALTER COLUMN `amount_billed_to_sponsor` SET TAGS ('dbx_business_glossary_term' = 'Amount Billed to Sponsor');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` ALTER COLUMN `amount_billed_to_sponsor` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` ALTER COLUMN `coverage_amount_per_student` SET TAGS ('dbx_business_glossary_term' = 'Authorized Coverage Amount');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` ALTER COLUMN `coverage_amount_per_student` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `education_ecm`.`billing`.`sponsorship_authorization` ALTER COLUMN `eligibility_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Verified');
