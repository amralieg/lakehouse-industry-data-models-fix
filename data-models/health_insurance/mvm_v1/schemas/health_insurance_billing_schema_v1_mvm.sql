-- Schema for Domain: billing | Business: Health Insurance | Version: v1_mvm
-- Generated on: 2026-05-03 21:25:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `health_insurance_ecm`.`billing` COMMENT 'Single source of truth for premium billing and revenue collection — group invoicing, individual premium statements, payment processing, grace periods, retroactive adjustments, premium reconciliation, refunds, and collections. Owns APR rate structures, PMPM calculations, subsidy and APTC tracking for ACA members, and accounts receivable. Supports CMS premium remittance and state DOI financial reporting. Source system: HealthEdge or custom billing platform.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `health_insurance_ecm`.`billing`.`premium_invoice` (
    `premium_invoice_id` BIGINT COMMENT 'System-generated unique identifier for the premium invoice record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: A premium invoice is issued to a billing account — account is the master financial relationship entity in the billing domain. Every invoice must be traceable to its billing account for AR management, ',
    `cobra_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.cobra_election. Business justification: COBRA premium invoices are generated specifically for COBRA elections with distinct premium amounts (up to 102% of group rate), payment deadlines, and subsidy tracking. COBRA billing operations, DOL c',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.cycle. Business justification: Invoices are generated per billing cycle. Linking premium_invoice to cycle establishes which billing cycle configuration drove the invoice generation, enabling cycle-level reconciliation and reporting',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Premium invoices are generated for specific eligibility spans — billing period, coverage type, and premium amount derive from the span. Retroactive adjustment processing, termination billing, and prem',
    `group_division_id` BIGINT COMMENT 'Foreign key linking to employer.group_division. Business justification: Large employer groups with billing_entity_flag divisions receive separate invoices per division. Divisional billing reconciliation, contribution reporting, and cost allocation reports require invoice-',
    `group_id` BIGINT COMMENT 'Identifier of the employer group billed for group coverage.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health plan or benefit design underlying the premium.',
    `identity_id` BIGINT COMMENT 'Identifier of the individual member associated with the invoice, if applicable.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Required for CMS risk‑adjusted premium reporting linking each invoice to the members risk score at billing time.',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.service_area. Business justification: Invoices are generated per service area to satisfy network adequacy reporting and state filing requirements.',
    `payment_method_id` BIGINT COMMENT 'Foreign key linking to billing.payment_method. Business justification: premium_invoice.payment_method is a denormalized STRING label. payment_method is the master record of authorized payment methods for a billing account. Replacing the STRING with a FK normalizes the re',
    `plan_election_id` BIGINT COMMENT 'Foreign key linking to enrollment.plan_election. Business justification: Individual market and COBRA invoices are generated directly from plan elections — the coverage tier, employee/employer contribution split, and total premium on the invoice derive from the plan electio',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Premium invoices are issued for a specific policy. Policy-level invoice reporting, member portal display, and premium reconciliation all require knowing which policy an invoice covers. A health insura',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Regulatory filing of premium invoices required by state insurance premium reporting obligations.',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Required for premium invoicing: each invoice must reference the enrollment transaction that generated the premium, enabling audit, reporting, and reconciliation.',
    `billing_period_end` DATE COMMENT 'Last day of the coverage period for which the premium is billed.',
    `billing_period_start` DATE COMMENT 'First day of the coverage period for which the premium is billed.',
    `collection_status` STRING COMMENT 'Current state of the collection effort for the invoice.. Valid values are `not_started|in_process|completed|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the invoice record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `delivery_method` STRING COMMENT 'Channel used to deliver the invoice to the recipient.. Valid values are `mail|email|portal`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount (e.g., early‑pay, promotional) applied to the invoice.',
    `due_date` DATE COMMENT 'Date by which payment must be received to avoid delinquency.',
    `grace_period_days` STRING COMMENT 'Number of days after due date before the invoice is considered delinquent.',
    `invoice_number` STRING COMMENT 'External invoice number assigned by the billing system, used for member and regulator reference.. Valid values are `^INV[0-9]{10}$`',
    `invoice_status` STRING COMMENT 'Current processing state of the invoice.. Valid values are `draft|issued|paid|partially_paid|void|delinquent`',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on the recipient and billing arrangement.. Valid values are `group_list_bill|group_self_bill|individual_statement|cobra|government_remittance`',
    `is_eligible_for_subsidy` BOOLEAN COMMENT 'Flag indicating whether the member/group qualifies for a premium subsidy.',
    `issue_timestamp` TIMESTAMP COMMENT 'Exact time the invoice was generated and issued to the recipient.',
    `line_of_business` STRING COMMENT 'Business segment to which the invoice belongs.. Valid values are `medical|dental|vision|pharmacy|wellness`',
    `net_amount_due` DECIMAL(18,2) COMMENT 'Final amount the recipient must pay after adjustments.',
    `notes` STRING COMMENT 'Optional comments or remarks added by billing staff.',
    `payment_channel` STRING COMMENT 'Interface through which the payment was made.. Valid values are `portal|mail|phone`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount returned to the payer for over‑payment or claim reversal.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates if the invoice must be reported to CMS or state DOI for compliance.',
    `retroactive_adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustment for prior‑period premium changes applied to the current invoice.',
    `source_system` STRING COMMENT 'Originating billing system that generated the invoice.. Valid values are `healthedge|custom_billing`',
    `source_system_invoice_reference` STRING COMMENT 'Original invoice identifier from the source billing system.',
    `statement_number` STRING COMMENT 'Unique identifier for an individual member statement when invoice_type is individual_statement.. Valid values are `^STMT[0-9]{8}$`',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Amount of premium assistance applied (e.g., APTC, state subsidy).',
    `subsidy_type` STRING COMMENT 'Classification of the subsidy applied to the premium.. Valid values are `aptc|state_subsidy|none`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax applied to the premium, if applicable.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Gross premium before any subsidies, taxes, or discounts.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the invoice record.',
    CONSTRAINT pk_premium_invoice PRIMARY KEY(`premium_invoice_id`)
) COMMENT 'Core billing document representing a premium invoice or statement issued to an employer group, individual member (IFP/ACA marketplace direct-pay), COBRA qualified beneficiary, or government sponsor for a specific billing period. Captures invoice number, billing period start/end, total premium due, subsidy/APTC amounts applied, net amount due, invoice status (draft, issued, paid, partially paid, void, delinquent), due date, document type (group list-bill invoice, group self-bill invoice, individual member statement, COBRA invoice, government remittance request), delivery method (mail, email, member portal), line-of-business (LOB), statement-specific fields for IFP direct-pay members (statement number, member reference, plan name, statement delivery preference), and source system reference from HealthEdge or custom billing platform. SSOT for ALL premium billing documents — both group invoices and individual member statements — in the billing domain.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'System-generated unique identifier for the invoice line record.',
    `aptc_subsidy_id` BIGINT COMMENT 'Foreign key linking to billing.aptc_subsidy. Business justification: invoice_line has aptc_subsidy_amount and csr_adjustment_amount fields representing APTC/CSR applied to the line. Linking to aptc_subsidy provides traceability to the members APTC subsidy record for C',
    `auth_service_line_id` BIGINT COMMENT 'Foreign key linking to utilization.auth_service_line. Business justification: Auth service lines define authorized CPT codes, quantities, and prices at the service level. Linking invoice lines to auth_service_lines enables authorized-vs-billed quantity and price reconciliation ',
    `contribution_strategy_id` BIGINT COMMENT 'Foreign key linking to employer.contribution_strategy. Business justification: Invoice lines carry employee_contribution and employer_contribution amounts derived from the contribution strategy. ACA affordability compliance audits and contribution reconciliation reports require ',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Each invoice line represents a premium charge for a members specific coverage period defined by the eligibility span. Billing reconciliation, retroactive adjustment line-item processing, and member-l',
    `group_division_id` BIGINT COMMENT 'Foreign key linking to employer.group_division. Business justification: Invoice lines represent per-member charges; each member belongs to a division. Division-level cost allocation reports, contribution reconciliation, and ACA affordability testing by division require in',
    `group_plan_offering_id` BIGINT COMMENT 'Foreign key linking to employer.group_plan_offering. Business justification: Invoice lines are generated from a specific group plan offering defining employee/employer contribution splits, plan year, and coverage tier. Billing reconciliation against offering terms and ACA affo',
    `health_plan_id` BIGINT COMMENT 'Identifier of the health insurance plan or benefit design associated with the charge.',
    `identity_id` BIGINT COMMENT 'Unique identifier of the covered member or subscriber for this premium charge.',
    `premium_invoice_id` BIGINT COMMENT 'Identifier of the parent invoice header to which this line belongs.',
    `premium_rate_id` BIGINT COMMENT 'Foreign key linking to billing.premium_rate. Business justification: invoice_line.rate_type is a denormalized STRING label for the rate applied to the line. premium_rate is the authoritative APR/PMPM rate record with coverage_tier, premium_type, rate_amount, and contri',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Invoice lines represent premium charges for coverage under a specific provider network. Network-level premium revenue reporting, reconciliation, and MLR calculations require invoice lines to be direct',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: Invoice lines for tiered network plans must reference the network tier to apply correct premium differentials and cost-sharing amounts. Tiered billing reconciliation and member-facing premium statemen',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Needed for line‑level reconciliation: each invoice line reflects a specific enrollment transaction (plan tier, coverage), supporting detailed financial reporting.',
    `adjustment_reason_code` STRING COMMENT 'Code indicating the business reason for a premium adjustment.. Valid values are `A|B|C|D|E|F`',
    `adjustment_reason_description` STRING COMMENT 'Human‑readable description of the adjustment reason.',
    `aptc_subsidy_amount` DECIMAL(18,2) COMMENT 'Advanced Premium Tax Credit amount applied to reduce the members premium.',
    `billing_period_end` DATE COMMENT 'End date of the billing period associated with this line.',
    `billing_period_start` DATE COMMENT 'Start date of the billing period associated with this line.',
    `coverage_end_date` DATE COMMENT 'Last day of coverage for which the premium is billed (nullable for open‑ended coverage).',
    `coverage_start_date` DATE COMMENT 'First day of coverage for which the premium is billed.',
    `coverage_tier` STRING COMMENT 'Classification of the coverage level for the member (e.g., employee only, employee + spouse, employee + child, family).. Valid values are `EE|EE+SP|EE+CH|FAM`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the invoice line record was first created in the system.',
    `csr_adjustment_amount` DECIMAL(18,2) COMMENT 'Amount of cost-sharing reduction (CSR) applied to the premium.',
    `employee_contribution` DECIMAL(18,2) COMMENT 'Portion of the premium paid by the employee (or subscriber).',
    `employer_contribution` DECIMAL(18,2) COMMENT 'Portion of the premium paid by the employer on behalf of the member.',
    `is_refund` BOOLEAN COMMENT 'True if this line represents a refund rather than a charge.',
    `line_sequence` STRING COMMENT 'Sequential order of the line within the invoice.',
    `payment_due_date` DATE COMMENT 'Date by which payment for this premium line is due.',
    `payment_status` STRING COMMENT 'Current payment status for the premium line.. Valid values are `due|paid|failed|waived`',
    `premium_amount` DECIMAL(18,2) COMMENT 'Base premium amount before any contributions, subsidies, or adjustments.',
    `premium_currency` STRING COMMENT 'Three‑letter ISO currency code for the premium amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `premium_line_description` STRING COMMENT 'Free‑form description of the premium line (e.g., "Monthly medical premium for employee only").',
    `premium_reconciliation_flag` BOOLEAN COMMENT 'Indicates whether the line has been reconciled to the general ledger.',
    `premium_source_system` STRING COMMENT 'Name of the source system that generated the premium line (e.g., HealthEdge, CustomBilling).',
    `premium_status` STRING COMMENT 'Current processing status of the premium line.. Valid values are `pending|posted|reversed|cancelled`',
    `refund_amount` DECIMAL(18,2) COMMENT 'Amount refunded to the member or employer for this line (if applicable).',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if this line must be included in regulatory reports (e.g., CMS, state DOI).',
    `retroactive_adjustment_flag` BOOLEAN COMMENT 'Flag indicating whether this line reflects a retroactive premium adjustment.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the premium line, if applicable.',
    `total_amount` DECIMAL(18,2) COMMENT 'Final amount after employer/employee contributions, subsidies, adjustments, and taxes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the invoice line record.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Line-item detail within a premium invoice, representing a single member or subscriber coverage charge for a billing period. Captures member/subscriber reference, plan code, coverage tier (EE, EE+SP, EE+CH, FAM), rate type, gross premium, employer contribution, employee contribution, APTC subsidy amount, CSR adjustment, retroactive adjustment indicator, and effective coverage dates. Supports PMPM-level billing reconciliation.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`billing`.`premium_payment` (
    `premium_payment_id` BIGINT COMMENT 'System-generated unique identifier for the premium payment record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Payments are received against a billing account. Linking premium_payment to account enables account-level payment history, AR balance tracking, and collections management. payer_account_number on prem',
    `group_id` BIGINT COMMENT 'Identifier of the employer group responsible for the payment, when applicable.',
    `identity_id` BIGINT COMMENT 'Identifier of the member associated with the premium payment.',
    `payment_method_id` BIGINT COMMENT 'Foreign key linking to billing.payment_method. Business justification: premium_payment.payment_method is a denormalized STRING label. payment_method is the master record of authorized payment methods. Replacing the STRING with a FK normalizes the reference, enables payme',
    `policy_id` BIGINT COMMENT 'Identifier of the insurance policy to which the premium payment applies.',
    `premium_invoice_id` BIGINT COMMENT 'Identifier of the premium invoice that this payment is applied to.',
    `tpa_arrangement_id` BIGINT COMMENT 'Foreign key linking to employer.tpa_arrangement. Business justification: For self-funded groups, premium payments (stop-loss premiums, admin fees) flow under TPA arrangements. The tpa_arrangement defines stop-loss parameters and fee schedules governing payment amounts. TPA',
    `transaction_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_transaction. Business justification: Payments are applied to invoices tied to an enrollment transaction; linking allows tracking payment against the originating enrollment for compliance and financial analysis.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total of fees, discounts, or other adjustments applied to the gross amount.',
    `batch_number` STRING COMMENT 'Identifier of the processing batch that included this payment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code of the payment.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any processing or service fees associated with the payment.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after adjustments, representing the amount applied to the invoice.',
    `nsf_indicator` BOOLEAN COMMENT 'True if the payment was returned due to non‑sufficient funds.',
    `payer_account_number` STRING COMMENT 'Account number or identifier used by the payer for the transaction.',
    `payer_name` STRING COMMENT 'Legal name of the entity making the payment.',
    `payer_type` STRING COMMENT 'Classification of the payer (e.g., employer, individual member, CMS, state Medicaid agency).. Valid values are `employer|member|cms|state_medicaid|other`',
    `payment_amount` DECIMAL(18,2) COMMENT 'Total amount received before any adjustments.',
    `payment_channel` STRING COMMENT 'Interface through which the payment was submitted.. Valid values are `web|mobile|call_center|mail|batch|other`',
    `payment_description` STRING COMMENT 'Free‑form description or notes about the payment.',
    `payment_number` STRING COMMENT 'Unique payment reference number assigned by the billing system.',
    `payment_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was received.',
    `premium_payment_status` STRING COMMENT 'Current lifecycle state of the payment.. Valid values are `pending|posted|failed|cancelled`',
    `reconciliation_status` STRING COMMENT 'Status of the payment in the accounting reconciliation process.. Valid values are `pending|matched|unmatched|exception`',
    `resolution_date` DATE COMMENT 'Date the suspense item was resolved.',
    `resolution_due_date` DATE COMMENT 'Target date by which the suspense item should be resolved.',
    `resolution_outcome` STRING COMMENT 'Result of the suspense investigation.. Valid values are `applied|refunded|written_off|reversed`',
    `source_system` STRING COMMENT 'Originating system that generated the payment record.. Valid values are `HealthEdge|CustomBilling`',
    `suspense_reason_code` STRING COMMENT 'Code indicating why the payment is in suspense (e.g., unidentified payer, amount mismatch).',
    `suspense_resolver` STRING COMMENT 'Name of the employee or system responsible for investigating the suspense item.',
    `suspense_status` STRING COMMENT 'Current status of the payment within the suspense workflow.. Valid values are `in_suspense|resolved|written_off`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the payment, if applicable.',
    `transaction_type` STRING COMMENT 'Classification of the payment transaction.. Valid values are `premium|adjustment|refund|reversal`',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'Portion of the payment that could not be matched to an invoice and is placed in suspense.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment record.',
    CONSTRAINT pk_premium_payment PRIMARY KEY(`premium_payment_id`)
) COMMENT 'Records an actual payment received against a premium invoice, capturing payment date, payment amount, payment method (ACH, check, wire, credit card, EFT), payment reference number, payer type (employer group, individual member, CMS, state Medicaid agency), applied invoice reference, unapplied/suspense balance, NSF/return indicator, reconciliation status, and full suspense management lifecycle (suspense status, suspense reason code — unidentified payer, amount mismatch, duplicate payment, missing invoice reference — received amount, receipt date, payer name, payer account reference, assigned resolver, resolution due date, resolution outcome — applied to invoice, refunded, written off — resolution date). Payments in suspense status are tracked inline with complete resolution workflow rather than in a separate suspense entity. SSOT for all inbound premium cash receipts including suspense items, their investigation, and resolution lifecycle.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`billing`.`payment_allocation` (
    `payment_allocation_id` BIGINT COMMENT 'System-generated unique identifier for each payment allocation record.',
    `invoice_line_id` BIGINT COMMENT 'Identifier of the invoice line to which the payment amount is allocated.',
    `payment_method_id` BIGINT COMMENT 'Foreign key linking to billing.payment_method. Business justification: payment_allocation.payment_method is a denormalized STRING label. payment_method is the master record of authorized payment methods. Replacing the STRING with a FK normalizes the reference for allocat',
    `premium_payment_id` BIGINT COMMENT 'Identifier of the premium payment that is being allocated.',
    `allocated_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the premium that is allocated to the invoice line.',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity of premium units (e.g., member‑months) allocated to the invoice line.',
    `allocation_date` DATE COMMENT 'Calendar date on which the allocation was recorded.',
    `allocation_sequence` STRING COMMENT 'Sequential order of allocation lines within the same payment.',
    `allocation_status` STRING COMMENT 'Current processing status of the allocation record.. Valid values are `allocated|pending|rejected|adjusted|closed`',
    `allocation_type` STRING COMMENT 'Classification of the allocation purpose (e.g., standard payment, partial payment, over‑payment, suspense resolution, adjustment, refund).. Valid values are `standard|partial|overpayment|suspense_resolution|adjustment|refund`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the allocation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for the allocated amount.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount or credit applied to the allocated premium.',
    `effective_from` DATE COMMENT 'Date when the allocation becomes effective for accounting purposes.',
    `effective_until` DATE COMMENT 'Date when the allocation ceases to be effective (null if open‑ended).',
    `is_overpayment` BOOLEAN COMMENT 'Indicates whether the allocation represents an overpayment scenario.',
    `is_suspense_resolution` BOOLEAN COMMENT 'True when the allocation resolves a suspense balance.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the allocation.',
    `payment_channel` STRING COMMENT 'Channel through which the payment was submitted.. Valid values are `web|mobile|call_center|in_person|batch|other`',
    `reconciliation_period` STRING COMMENT 'Period identifier (e.g., 2023-04) for the premium reconciliation cycle.',
    `reconciliation_status` STRING COMMENT 'Current lifecycle state of the reconciliation record.. Valid values are `open|in_review|approved|closed|rejected`',
    `reconciliation_type` STRING COMMENT 'Frequency classification of the reconciliation (e.g., monthly, quarterly).. Valid values are `monthly|quarterly|annual|ad_hoc`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the allocated premium.',
    `total_adjustments` DECIMAL(18,2) COMMENT 'Aggregate of all adjustments (e.g., refunds, credits) applied during the period.',
    `total_billed` DECIMAL(18,2) COMMENT 'Sum of all invoice line amounts billed for the reconciliation period.',
    `total_collected` DECIMAL(18,2) COMMENT 'Sum of all payments collected for the reconciliation period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the allocation record.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between total billed and total collected after adjustments.',
    `variance_reason` STRING COMMENT 'Explanation for any variance observed in the reconciliation.',
    CONSTRAINT pk_payment_allocation PRIMARY KEY(`payment_allocation_id`)
) COMMENT 'Association and reconciliation entity linking premium payments to invoice lines, tracking line-level allocation, and managing periodic premium reconciliation outcomes. For allocation: captures allocated amount, allocation date, allocation type (standard, partial, overpayment, suspense resolution), and line-level reconciliation status. Supports many-to-many payment-to-invoice matching and enables accurate accounts receivable aging. For periodic reconciliation: captures reconciliation period, total billed, total collected, total adjustments, variance amount, variance reason, reconciliation status (open, in review, approved, closed), approver reference, and reconciliation type (monthly, quarterly, annual). Supports MLR calculation inputs, financial close processes, CMS premium reconciliation, and end-to-end premium reconciliation from individual line-level allocation through period-level summary and variance analysis. SSOT for all payment allocation and premium reconciliation in the billing domain.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`billing`.`account` (
    `account_id` BIGINT COMMENT 'System-generated unique identifier for the billing account.',
    `delegation_agreement_id` BIGINT COMMENT 'Foreign key linking to contract.delegation_agreement. Business justification: Billing accounts for TPAs and delegated entities are governed by a delegation agreement that defines financial arrangement type, billing authority, and oversight requirements. Health insurance billing',
    `facility_id` BIGINT COMMENT 'Foreign key linking to provider.facility. Business justification: Institutional providers (hospitals, SNFs, ASCs) require dedicated billing accounts for capitation payments, bundled payment arrangements, and facility fee billing. Health insurance payers maintain fac',
    `group_division_id` BIGINT COMMENT 'Foreign key linking to employer.group_division. Business justification: When group_division.billing_entity_flag is true, a separate billing account is established per division. Division-level account management, separate billing cycles, and contribution tracking require a',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Required for Employer Billing Account Management report linking each billing account to its employer group for contribution tracking and regulatory reporting.',
    `group_practice_id` BIGINT COMMENT 'Foreign key linking to provider.group_practice. Business justification: Group practices receive consolidated reimbursements; the link enables the Group Practice Billing Summary and CMS reporting of provider‑level payments.',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: Billing accounts are reconfigured at each group renewal — new rate schedules, billing cycles, and contribution strategies take effect. Account setup validation against renewal terms and renewal-driven',
    `provider_id` BIGINT COMMENT 'Foreign key linking to provider.provider_provider. Business justification: Needed for Provider Payment Reconciliation report linking each provider to its billing account for electronic fund transfers and regulatory payment tracking.',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Network contract billing – each billing account is tied to a provider network contract for negotiated rates and regulatory reporting.',
    `tpa_arrangement_id` BIGINT COMMENT 'Foreign key linking to employer.tpa_arrangement. Business justification: Self-funded employer groups with TPA arrangements have billing accounts configured under TPA fee schedules (fee_schedule_rate_pmpm, contribution_rate_pmpm). TPA billing reconciliation and administrati',
    `account_number` STRING COMMENT 'External account number assigned to the billing entity for invoicing and payment processing.',
    `account_status` STRING COMMENT 'Current lifecycle status of the billing account.. Valid values are `active|suspended|closed|pending`',
    `account_type` STRING COMMENT 'Classification of the billing entity (e.g., employer group, individual subscriber, government program).. Valid values are `employer_group|individual|government|medicare|medicaid|chip`',
    `aptc_amount` DECIMAL(18,2) COMMENT 'Amount of ACA premium tax credit applied to the account.',
    `auto_pay_authorization_date` DATE COMMENT 'Date when the auto‑pay authorization was granted.',
    `auto_pay_authorization_flag` BOOLEAN COMMENT 'Indicates whether the account holder has authorized automatic payments.',
    `auto_pay_enrollment` BOOLEAN COMMENT 'Indicates whether the account is enrolled in automatic payment processing.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the account automatically renews at the end of its term.',
    `billing_calendar_reference` STRING COMMENT 'Identifier for the calendar configuration governing billing cycles.',
    `billing_cycle_type` STRING COMMENT 'Configuration of the recurring billing cycle for the account.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `billing_frequency` STRING COMMENT 'How often invoices are generated for this account.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `billing_method` STRING COMMENT 'Method used to deliver bills to the account holder.. Valid values are `self_bill|list_bill|direct_bill`',
    `collection_status` STRING COMMENT 'Current status of the collection effort for overdue balances.. Valid values are `not_started|in_progress|completed|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing account record was first created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount authorized for the billing entity.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary amounts on the account.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `current_balance` DECIMAL(18,2) COMMENT 'Outstanding monetary balance on the account as of the latest reconciliation.',
    `effective_from` DATE COMMENT 'Date when the billing account became effective.',
    `effective_until` DATE COMMENT 'Date when the billing account is scheduled to terminate (null if open‑ended).',
    `grace_period_days` STRING COMMENT 'Number of days after the due date before the account is considered delinquent.',
    `invoice_generation_day` STRING COMMENT 'Day of month when the invoice is generated (1‑31).',
    `last_invoice_date` DATE COMMENT 'Date when the most recent invoice was generated.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the most recent payment.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received for the account.',
    `next_invoice_date` DATE COMMENT 'Scheduled date for the next invoice issuance.',
    `notes` STRING COMMENT 'Free‑form text field for internal comments or special instructions related to the account.',
    `payment_due_amount` DECIMAL(18,2) COMMENT 'Total amount currently due on the account, including any pending charges.',
    `payment_due_day` STRING COMMENT 'Day of month by which payment must be received.',
    `payment_terms` STRING COMMENT 'Contractual terms defining when payment is due after invoice issuance.. Valid values are `net_30|net_45|net_60|due_on_receipt`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the account is subject to special regulatory reporting (e.g., CMS, state DOI).',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Total subsidy applied to the account (e.g., employer or government subsidies).',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the account is exempt from sales or other applicable taxes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing account record.',
    CONSTRAINT pk_account PRIMARY KEY(`account_id`)
) COMMENT 'Master billing account representing the financial relationship between the health plan and a billing entity — employer group, individual subscriber, or government program (Medicare, Medicaid, CHIP). Captures account number, account type, billing frequency (monthly, quarterly, annual), billing method (self-bill, list-bill, direct-bill), payment terms, auto-pay enrollment, current balance, credit limit, account status, assigned billing representative, billing cycle configuration (cycle type — monthly/quarterly/semi-annual/annual, invoice generation date, payment due date, grace period days, next/last invoice dates, auto-renewal flag, billing calendar reference), and registered payment methods (payment method type — ACH/EFT, check, wire transfer, credit card, debit card, HSA/FSA — with masked/tokenized bank routing and account numbers, card last four digits, card expiration date, auto-pay authorization flag, authorization date and reference, active/inactive status per method, PCI-DSS compliant storage). SSOT for billing account identity, billing cycle configuration, and authorized payment methods.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`billing`.`premium_rate` (
    `premium_rate_id` BIGINT COMMENT 'System-generated unique identifier for each premium rate record.',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.network_service_area. Business justification: CMS and state DOI require premium rates to be filed by service area (rating area). The premium_rate table currently stores rating_area and rating_area_reference as plain denormalized columns — replaci',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.rate. Business justification: Billing premium rates are derived from plan-filed rates. This FK enables regulatory rate reconciliation, DOI audit trails, and premium accuracy validation — a health insurance billing analyst must tra',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Premium rates are priced and filed per provider network — narrow network plans carry lower rates than broad network plans. Actuarial rate development and DOI regulatory filings require rates to be exp',
    `rate_schedule_id` BIGINT COMMENT 'FK to billing.rate_schedule',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: Individual premium rates are governed by ACA rate review and state DOI filing obligations. Direct FK enables rate-level compliance audit trails and regulatory filing status tracking, replacing denorma',
    `risk_underwriting_case_id` BIGINT COMMENT 'Foreign key linking to risk.risk_underwriting_case. Business justification: Group premium rates are directly authorized by underwriting cases (risk_underwriting_case contains gross_premium_amount, premium_rate, premium_rate_type). Rate filing and group underwriting processes ',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: Tiered network products (Tier 1/Tier 2) carry distinct premium rates per tier. The rating engine must reference the network tier to compute correct member premiums and cost-sharing differentials. Heal',
    `age_band` STRING COMMENT 'Age band classification for age‑rated plans (e.g., 0‑20, 21‑30).',
    `aptc_amount` DECIMAL(18,2) COMMENT 'Amount of APTC applied to the premium for ACA‑eligible members.',
    `cobra_rate` DECIMAL(18,2) COMMENT 'Rate applied to COBRA participants (active employee rate plus 2 % administrative fee).',
    `coverage_tier` STRING COMMENT 'Tier of coverage (e.g., individual, employee + spouse, family) that the rate applies to.. Valid values are `individual|employee_spouse|family|dual`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the premium rate record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the premium rate becomes effective.',
    `employee_contribution_rate` DECIMAL(18,2) COMMENT 'Portion of the premium (as a percentage) that the employee contributes.',
    `employer_contribution_rate` DECIMAL(18,2) COMMENT 'Portion of the premium (as a percentage) that the employer contributes.',
    `expiration_date` DATE COMMENT 'Date on which the premium rate expires; null if open‑ended.',
    `family_tier_structure` STRING COMMENT 'Definition of how family members are tiered for premium calculation (e.g., adult, child, infant).',
    `market_segment` STRING COMMENT 'Business segment to which the rate applies (individual, group, small group, large group).. Valid values are `individual|group|small_group|large_group`',
    `premium_rate_status` STRING COMMENT 'Current lifecycle status of the premium rate record.. Valid values are `active|inactive|pending|retired`',
    `premium_type` STRING COMMENT 'Indicates whether the rate is an Annual Premium Rate (APR) or Per Member Per Month (PMPM) rate.. Valid values are `APR|PMPM`',
    `rate_amount` DECIMAL(18,2) COMMENT 'Base monetary amount (per member per month) before adjustments.',
    `rating_method` STRING COMMENT 'Method used to calculate premiums (e.g., community rated, age‑rated, composite rated, experience rated).. Valid values are `community|age|composite|experience`',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Dollar amount of any subsidy applied to the premium (e.g., employer or government subsidy).',
    `tobacco_surcharge_rate` DECIMAL(18,2) COMMENT 'Additional percentage surcharge applied to members who use tobacco.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the premium rate record.',
    `wellness_discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied for members meeting wellness program criteria.',
    CONSTRAINT pk_premium_rate PRIMARY KEY(`premium_rate_id`)
) COMMENT 'Defines the APR (Annual Premium Rate) and PMPM rate structures for a plan, coverage tier, rating area, and effective date range, including the parent rate schedule configuration that governs how rates are structured and applied. Captures rate schedule name, rating method (community rated, age-rated, composite rated, experience rated), market segment, plan code, coverage tier, rating area, age band (for ACA age-rated plans), tobacco surcharge rate and rules, wellness discount rate and rules, employer contribution rate, employee contribution rate, COBRA rate (active employee rate + 2% admin fee), family tier structure, rate effective/expiration dates, state DOI rate filing reference number, rating area reference, and regulatory filing metadata. SSOT for all premium calculation inputs, rate schedule configurations, rate filing metadata, and rate structure definitions used in invoice generation.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`billing`.`grace_period` (
    `grace_period_id` BIGINT COMMENT 'System-generated unique identifier for the grace period record.',
    `account_id` BIGINT COMMENT 'Identifier of the billing account to which this grace period applies.',
    `care_enrollment_id` BIGINT COMMENT 'Foreign key linking to care.care_enrollment. Business justification: Grace period status directly affects care program enrollment continuity. Care coordinators must verify billing grace period status before authorizing care management services; grace period termination',
    `cycle_id` BIGINT COMMENT 'Foreign key linking to billing.cycle. Business justification: Grace periods are triggered within a specific billing cycle when payment is overdue. Linking grace_period to cycle establishes which billing cycle configuration governs the grace period duration and t',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Grace periods protect a specific active eligibility span from termination during non-payment. ACA mandates a 3-month grace period for APTC enrollees tied to the eligibility span. Grace period outcome ',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: Grace period rules (90-day ACA APTC rule vs. 30-day non-ACA) are plan-specific and jurisdiction-dependent. This FK enables plan-level grace period compliance reporting, termination processing workflow',
    `identity_id` BIGINT COMMENT 'Identifier of the member associated with the account for this grace period.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: ACA mandates a 3-month grace period for APTC recipients tied to a specific policy. CMS regulatory reporting requires grace period tracking at the policy level. A compliance officer would expect grace_',
    `premium_invoice_id` BIGINT COMMENT 'Identifier of the invoice that triggered the grace period.',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: ACA grace periods (45 CFR 156.270) are strictly regulated with mandatory 3-month windows for APTC recipients. This FK links each grace period record to the governing federal/state regulatory obligatio',
    `premium_payment_id` BIGINT COMMENT 'Foreign key linking to billing.premium_payment. Business justification: A grace period is resolved when a payment is received. Linking grace_period to the resolving premium_payment provides a direct audit trail from grace period to the payment that closed it. This FK is n',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the grace period record was first created in the system.',
    `day_count` STRING COMMENT 'Number of days elapsed since the start of the grace period.',
    `end_date` DATE COMMENT 'Date when the grace period is scheduled to end.',
    `extension_end_date` DATE COMMENT 'New end date if the grace period was extended.',
    `extension_flag` BOOLEAN COMMENT 'Indicates whether the original grace period was extended.',
    `grace_period_description` STRING COMMENT 'Free-text description providing additional context for the grace period.',
    `grace_period_number` STRING COMMENT 'External business identifier for the grace period, used in reporting and member communications.',
    `grace_period_status` STRING COMMENT 'Current lifecycle status of the grace period.. Valid values are `active|expired|terminated|reinstated|paid`',
    `grace_period_type` STRING COMMENT 'Classification of the grace period based on product or regulatory rules.. Valid values are `standard|aca_aptc|group|individual`',
    `is_eligible_for_aptc` BOOLEAN COMMENT 'Indicates if the member is eligible for Advanced Premium Tax Credit during this grace period.',
    `jurisdiction` STRING COMMENT 'Regulatory jurisdiction applicable to the grace period.. Valid values are `federal|state`',
    `notes` STRING COMMENT 'Additional free-form notes captured by the billing team.',
    `outcome` STRING COMMENT 'Result of the grace period after it ends.. Valid values are `paid|terminated|reinstated|none`',
    `payment_due_date` DATE COMMENT 'The date by which the premium payment was originally due before the grace period started.',
    `payment_received_date` DATE COMMENT 'Date on which the overdue payment was received, if applicable.',
    `reason_code` STRING COMMENT 'Code indicating why the grace period was initiated.. Valid values are `late_payment|non_payment|billing_error|other`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this grace period must be reported to CMS or state DOI.',
    `start_date` DATE COMMENT 'Date when the grace period began.',
    `state_code` STRING COMMENT 'Two-letter state abbreviation for jurisdictional reporting. [ENUM-REF-CANDIDATE: AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY — promote to reference product]',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Monetary amount of any subsidy applied during the grace period.',
    `termination_warning_issued` BOOLEAN COMMENT 'Indicates whether a termination warning has been sent to the member.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the grace period record.',
    CONSTRAINT pk_grace_period PRIMARY KEY(`grace_period_id`)
) COMMENT 'Tracks the grace period status for a billing account or member when premium payment is overdue. Captures grace period start date, grace period end date (typically 30 days for individual/ACA, 31 days for group), grace period type (ACA APTC grace period is 90 days), triggering invoice reference, current grace period day count, termination warning issued flag, and resolution outcome (paid, terminated, reinstated). Required for ACA compliance and state DOI reporting.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` (
    `retro_adjustment_id` BIGINT COMMENT 'System-generated unique identifier for the retroactive billing adjustment record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: Retroactive adjustments are made against a billing account. Linking retro_adjustment to account enables account-level adjustment history, dispute tracking, and financial reconciliation. retro_adjustme',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.case. Business justification: Appeal case outcomes (e.g., overturned denials, premium corrections) directly trigger retroactive billing adjustments. Linking retro_adjustment to the driving appeal case enables audit trails for regu',
    `condition_registry_id` BIGINT COMMENT 'Foreign key linking to care.condition_registry. Business justification: Condition registry updates (new HCC codes, RAF score changes) are a primary trigger for retroactive premium adjustments in ACA and Medicare risk-adjusted markets. Revenue cycle teams require this FK t',
    `enrollment_eligibility_span_id` BIGINT COMMENT 'Foreign key linking to enrollment.enrollment_eligibility_span. Business justification: Retroactive billing adjustments are caused by retroactive enrollment changes (late termination, retroactive effective date). The retro_adjustment must reference the eligibility span that triggered the',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member to whom the adjustment applies.',
    `member_risk_score_id` BIGINT COMMENT 'Foreign key linking to risk.member_risk_score. Business justification: Risk-score-driven retroactive premium reconciliation is a named CMS process: when HCC/risk scores are corrected (e.g., RAPS/EDPS resubmissions), retroactive billing adjustments are generated. A domain',
    `pa_decision_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_decision. Business justification: PA decision reversals (e.g., appeal outcomes overturning original approvals) directly trigger retro_adjustments without necessarily involving a formal retrospective_review. Linking retro_adjustment to',
    `pa_request_id` BIGINT COMMENT 'Foreign key linking to utilization.pa_request. Business justification: Retroactive billing adjustments are frequently triggered by PA request reversals or late denials. Finance and compliance teams must trace each retro_adjustment to its originating PA request for root-c',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: Retroactive premium adjustments are triggered by policy-level changes (retroactive enrollment/termination). CMS and state DOI reconciliation requires adjustments to reference the exact policy period b',
    `premium_invoice_id` BIGINT COMMENT 'Foreign key linking to billing.premium_invoice. Business justification: retro_adjustment.invoice_reference is a denormalized STRING reference to the invoice being adjusted. Replacing it with a proper FK to premium_invoice normalizes the relationship, enables JOIN-based in',
    `retrospective_review_id` BIGINT COMMENT 'Foreign key linking to utilization.retrospective_review. Business justification: Retrospective UM reviews that result in denial or partial approval directly generate retro_adjustment records to correct previously billed amounts. Linking these enables the standard UM-to-billing fin',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary amount of the adjustment; positive for additional charge, negative for credit.',
    `adjustment_number` STRING COMMENT 'External reference number for the adjustment as used in communications and audit.',
    `adjustment_status` STRING COMMENT 'Current processing status of the adjustment.. Valid values are `pending|approved|rejected|posted|cancelled`',
    `adjustment_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was recorded in the system.',
    `adjustment_type` STRING COMMENT 'Category of the retroactive adjustment indicating the nature of the change.. Valid values are `add|termination|rate_change|tier_change|dispute_credit|dispute_correction`',
    `authorization_reference` STRING COMMENT 'Reference to any prior authorization supporting the adjustment.',
    `credit_memo_reference` STRING COMMENT 'Identifier of the credit memo generated as a result of the adjustment.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the adjustment amount.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `dispute_open_date` DATE COMMENT 'Date when the dispute was initially opened.',
    `dispute_status` STRING COMMENT 'Current status of the dispute lifecycle.. Valid values are `open|under_review|resolved|escalated`',
    `dispute_type` STRING COMMENT 'Classification of the dispute prompting the adjustment.. Valid values are `invoice_amount|payment_misapplication|rate_error|retro_adjustment|aptc_discrepancy`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Amount that is under dispute.',
    `original_billing_period_end` DATE COMMENT 'End date of the billing period to which the original charge applied.',
    `original_billing_period_start` DATE COMMENT 'Start date of the billing period to which the original charge applied.',
    `reason_code` STRING COMMENT 'Standardized code describing the business reason for the adjustment.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the adjustment record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the adjustment record.',
    `resolution_date` DATE COMMENT 'Date when the dispute was resolved.',
    `resolution_notes` STRING COMMENT 'Free-text notes describing the resolution details.',
    `resolution_type` STRING COMMENT 'Outcome of the dispute resolution process.. Valid values are `credit_issued|invoice_corrected|upheld`',
    CONSTRAINT pk_retro_adjustment PRIMARY KEY(`retro_adjustment_id`)
) COMMENT 'Captures retroactive premium adjustments and billing disputes resulting from enrollment changes, eligibility corrections, rate corrections, COB updates, or contested billing amounts applied to prior billing periods. Records adjustment type (add, term, rate change, tier change, dispute credit, dispute correction), original billing period, adjustment amount (positive or negative), reason code, dispute tracking fields (dispute type — invoice amount, payment misapplication, rate error, retro adjustment, APTC discrepancy — disputed amount, dispute open date, dispute status — open, under review, resolved, escalated — resolution type — credit issued, invoice corrected, upheld — resolution date, resolution notes), authorization reference, and resulting invoice or credit memo reference. SSOT for all retroactive billing adjustments and billing dispute resolution in the billing domain. Critical for accurate premium reconciliation, dispute lifecycle management, and financial reporting.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` (
    `aptc_subsidy_id` BIGINT COMMENT 'System-generated unique identifier for the APTC subsidy record.',
    `account_id` BIGINT COMMENT 'Foreign key linking to billing.account. Business justification: APTC subsidies are applied to ACA member billing accounts. Linking aptc_subsidy to account enables account-level subsidy tracking, CMS premium remittance reconciliation, and APTC cap enforcement at th',
    `case_id` BIGINT COMMENT 'Foreign key linking to appeal.case. Business justification: APTC subsidy terminations, incorrect subsidy amounts, and CMS reconciliation discrepancies are common appeal triggers in ACA marketplace plans. Linking aptc_subsidy to the appeal case challenging it s',
    `exchange_enrollment_id` BIGINT COMMENT 'Foreign key linking to enrollment.exchange_enrollment. Business justification: APTC subsidies are issued exclusively for exchange enrollments. CMS APTC reconciliation, 1095-A generation, and CSR variant application all require linking the subsidy record to the specific exchange ',
    `health_plan_id` BIGINT COMMENT 'Foreign key linking to plan.health_plan. Business justification: APTC subsidies are issued for a specific Qualified Health Plan. This FK is required for ACA CMS reconciliation (Form 1095-A), subsidy eligibility validation, and MLR reporting — a compliance analyst m',
    `identity_id` BIGINT COMMENT 'Unique identifier of the member receiving the subsidy.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to member.policy. Business justification: APTC subsidies are tied to a specific QHP policy. IRS Form 8962 reconciliation and CMS annual APTC reporting require matching subsidy amounts to the exact policy. A marketplace operations expert would',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: APTC subsidies are governed by ACA Section 1401 regulatory obligations. The cms_reconciliation_status field reflects a specific CMS compliance process; this FK links each subsidy record to its gover',
    `annual_aptc_cap` DECIMAL(18,2) COMMENT 'Maximum total APTC amount the member may receive in a calendar year.',
    `aptc_monthly_amount` DECIMAL(18,2) COMMENT 'Monthly amount of APTC applied to the members premium.',
    `aptc_subsidy_status` STRING COMMENT 'Overall lifecycle status of the subsidy record.. Valid values are `active|inactive|terminated|pending`',
    `cms_reconciliation_status` STRING COMMENT 'Current status of the subsidy record in CMS premium remittance reconciliation.. Valid values are `pending|reconciled|error`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subsidy record was first created in the system.',
    `csr_variant` STRING COMMENT 'CSR variant percentage (73%, 87%, or 94%) applicable to the member.. Valid values are `73|87|94`',
    `exchange_code` STRING COMMENT 'Identifier of the marketplace exchange where the member enrolled.',
    `source_system` STRING COMMENT 'Name of the source system that supplied the subsidy data.',
    `subsidy_effective_date` DATE COMMENT 'Date when the subsidy becomes effective.',
    `subsidy_number` STRING COMMENT 'External business identifier assigned to the subsidy agreement.',
    `subsidy_termination_date` DATE COMMENT 'Date when the subsidy ends or is terminated; null if still active.',
    `subsidy_type` STRING COMMENT 'Indicates whether the record is an Advance Premium Tax Credit (APTC) or Cost‑Sharing Reduction (CSR) subsidy.. Valid values are `APTC|CSR`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the subsidy record.',
    `ytd_aptc_applied` DECIMAL(18,2) COMMENT 'Cumulative APTC amount applied to the members premiums to date.',
    CONSTRAINT pk_aptc_subsidy PRIMARY KEY(`aptc_subsidy_id`)
) COMMENT 'Tracks Advance Premium Tax Credit (APTC) and Cost-Sharing Reduction (CSR) subsidy amounts for ACA marketplace members. Captures member reference, QHP plan code, marketplace exchange ID, APTC monthly amount, CSR variant level (73%, 87%, 94%), annual APTC cap, year-to-date APTC applied, subsidy effective date, subsidy termination date, and CMS reconciliation status. Required for ACA Section 1401/1402 compliance and CMS premium remittance reporting.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`billing`.`cycle` (
    `cycle_id` BIGINT COMMENT 'Unique system-generated identifier for the billing cycle configuration.',
    `account_id` BIGINT COMMENT 'Identifier of the member or group account to which this cycle applies.',
    `open_enrollment_period_id` BIGINT COMMENT 'Foreign key linking to enrollment.open_enrollment_period. Business justification: Billing cycles are created and aligned to open enrollment periods — the cycle effective dates correspond to the plan year established by the OEP. Billing operations use OEP to initialize new cycles fo',
    `premium_rate_id` BIGINT COMMENT 'Foreign key linking to billing.premium_rate. Business justification: A billing cycle applies specific premium rates for the cycle period. Linking cycle to premium_rate establishes which rate structure governs the cycles default premium calculations. default_premium_am',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: A billing cycle is governed by a rate schedule that defines how premiums are structured and applied. Linking cycle to rate_schedule establishes the governing rate schedule for the cycle, enabling rate',
    `renewal_cycle_id` BIGINT COMMENT 'Identifier of the next billing cycle that follows this one upon renewal.',
    `year_id` BIGINT COMMENT 'Foreign key linking to plan.year. Business justification: Billing cycles are governed by plan year boundaries — open enrollment windows, renewal dates, and premium effective dates are all plan-year-driven. This FK enables billing operations to enforce plan-y',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the billing cycle automatically renews at the end of its term.',
    `billing_frequency_months` STRING COMMENT 'Number of months that define one billing period (e.g., 1 for monthly, 3 for quarterly).',
    `billing_method` STRING COMMENT 'Method used to deliver the invoice to the member or group.. Valid values are `electronic|paper|direct_debit|credit_card`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing cycle record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `cycle_code` STRING COMMENT 'Business-visible code that uniquely identifies the billing cycle configuration.',
    `cycle_description` STRING COMMENT 'Free‑form text describing special rules or notes for the cycle.',
    `cycle_status` STRING COMMENT 'Current lifecycle status of the billing cycle.. Valid values are `active|inactive|suspended|pending|closed`',
    `cycle_type` STRING COMMENT 'Classification of the billing cycle frequency.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `default_premium_amount` DECIMAL(18,2) COMMENT 'Standard premium amount before any adjustments.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the default premium.',
    `effective_end_date` DATE COMMENT 'Date when the billing cycle ends; null for open‑ended cycles.',
    `effective_start_date` DATE COMMENT 'Date when the billing cycle becomes effective.',
    `grace_period_days` STRING COMMENT 'Number of days after the due date before the account is considered delinquent.',
    `invoice_day_of_month` STRING COMMENT 'Calendar day of the month when the invoice is generated (1‑28).',
    `is_pro_rata` BOOLEAN COMMENT 'Indicates whether the cycle amount is prorated based on start/stop dates.',
    `last_invoice_date` DATE COMMENT 'Date when the most recent invoice was generated.',
    `net_premium_amount` DECIMAL(18,2) COMMENT 'Premium amount after discounts but before taxes.',
    `next_invoice_date` DATE COMMENT 'Scheduled date for the next invoice generation.',
    `payment_due_day_offset` STRING COMMENT 'Number of days after the invoice date that payment is due.',
    `prorated_amount` DECIMAL(18,2) COMMENT 'Calculated amount when the cycle is prorated.',
    `source_system` STRING COMMENT 'Name of the upstream system that originated the record (e.g., HealthEdge).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component added to the net premium.',
    `total_amount` DECIMAL(18,2) COMMENT 'Sum of net premium, tax, and any other charges.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing cycle record.',
    CONSTRAINT pk_cycle PRIMARY KEY(`cycle_id`)
) COMMENT 'Defines the billing cycle configuration for a billing account or group, specifying billing frequency, invoice generation date, payment due date, grace period days, billing method, and cycle status. Captures cycle type (monthly, quarterly, semi-annual, annual), next invoice date, last invoice date, auto-renewal flag, and billing calendar reference. Drives the automated invoice generation schedule in HealthEdge.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`billing`.`payment_method` (
    `payment_method_id` BIGINT COMMENT 'System-generated unique identifier for the payment method record.',
    `account_id` BIGINT COMMENT 'Identifier of the billing account to which this payment method is attached.',
    `identity_id` BIGINT COMMENT 'Identifier of the member (policyholder) who owns the payment method.',
    `authorization_date` DATE COMMENT 'Date the payment method was authorized for use.',
    `authorization_reference` STRING COMMENT 'External reference or token returned by the payment processor confirming authorization.',
    `bank_name` STRING COMMENT 'Name of the financial institution that holds the account.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address associated with the payment method.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (optional).',
    `billing_city` STRING COMMENT 'City component of the billing address.',
    `billing_country` STRING COMMENT 'Three‑letter ISO country code for the billing address.',
    `billing_postal_code` STRING COMMENT 'Postal/ZIP code of the billing address.',
    `billing_state` STRING COMMENT 'State/Province component of the billing address.',
    `card_expiration_date` DATE COMMENT 'Expiration date of the credit/debit card.',
    `card_last_four` STRING COMMENT 'Last four digits of the credit/debit card for display purposes.',
    `card_type` STRING COMMENT 'Network brand of the credit/debit card.. Valid values are `Visa|MasterCard|Amex|Discover|Other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment method record was first created in the system.',
    `effective_from` DATE COMMENT 'Date the payment method becomes effective for billing.',
    `effective_until` DATE COMMENT 'Date the payment method expires or is deactivated (null if open‑ended).',
    `holder_name` STRING COMMENT 'Legal name of the individual to whom the card is issued.',
    `is_auto_pay` BOOLEAN COMMENT 'Indicates whether the member has authorized automatic recurring payments using this method.',
    `masked_account_number` STRING COMMENT 'Bank account number with middle digits masked for PCI‑DSS compliance.',
    `masked_routing_number` STRING COMMENT 'Bank routing number with middle digits masked to meet PCI‑DSS requirements.',
    `method_type` STRING COMMENT 'Category of the payment instrument (e.g., ACH, Check, Wire, Credit Card, Debit Card, Health Savings Account).. Valid values are `ACH|Check|Wire|CreditCard|DebitCard|HSA`',
    `notes` STRING COMMENT 'Free‑form text for operational comments or special handling instructions.',
    `payment_method_status` STRING COMMENT 'Current lifecycle state of the payment method.. Valid values are `active|inactive|suspended|pending`',
    `pci_compliance_flag` BOOLEAN COMMENT 'Indicates whether the stored payment method meets PCI‑DSS compliance.',
    `risk_score` DECIMAL(18,2) COMMENT 'Fraud risk score assigned by the payment processor (0.00‑99.99).',
    `source_system` STRING COMMENT 'Name of the source system that originated the payment method record (e.g., HealthEdge).',
    `tokenized_account_number` STRING COMMENT 'PCI‑token representing the full bank account number for secure storage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment method record.',
    `verification_status` STRING COMMENT 'Result of the payment method verification process.. Valid values are `verified|unverified|failed`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date‑time when verification was performed.',
    CONSTRAINT pk_payment_method PRIMARY KEY(`payment_method_id`)
) COMMENT 'Master record of authorized payment methods registered for a billing account, capturing payment method type (ACH/EFT, check, wire transfer, credit card, debit card, HSA/FSA), bank routing number (masked), bank account number (masked/tokenized), card last four digits, card expiration date, auto-pay authorization flag, authorization date, authorization reference, and active/inactive status. Supports PCI-DSS compliant payment processing.';

CREATE OR REPLACE TABLE `health_insurance_ecm`.`billing`.`rate_schedule` (
    `rate_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the rate schedule configuration.',
    `group_renewal_id` BIGINT COMMENT 'Foreign key linking to employer.group_renewal. Business justification: Rate schedules are filed and activated during group renewal cycles. The renewal drives effective dates, rate change percentages, and DOI filing requirements. Regulatory filing reconciliation and renew',
    `network_service_area_id` BIGINT COMMENT 'Foreign key linking to network.network_service_area. Business justification: Rate schedules are filed per service area for state DOI and CMS regulatory compliance. The rate_schedule table currently stores regulatory_state and regulatory_county as denormalized plain columns — a',
    `rate_id` BIGINT COMMENT 'Foreign key linking to plan.rate. Business justification: A billing rate schedule is constructed from plan-approved rates. Linking rate_schedule to plan.rate supports premium rate filing reconciliation, CMS rate review, and ensures billing schedules reflect ',
    `provider_network_id` BIGINT COMMENT 'Foreign key linking to network.provider_network. Business justification: Rate schedules are developed and filed per provider network — actuaries build separate rate schedules for narrow vs. broad network products. State DOI and CMS filings require rate schedules to be asso',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_regulatory_obligation. Business justification: Rate schedules must be filed under specific ACA/state DOI regulatory obligations. This link supports rate filing compliance tracking and regulatory audit processes. Columns state_doi_filing_number a',
    `risk_underwriting_case_id` BIGINT COMMENT 'Foreign key linking to risk.risk_underwriting_case. Business justification: Rate schedules are created as direct outputs of group underwriting decisions. The underwriting case establishes the risk classification and premium parameters that define the entire rate schedule. Reg',
    `tier_id` BIGINT COMMENT 'Foreign key linking to network.tier. Business justification: Tiered network rate schedules are built per tier — Tier 1 and Tier 2 have distinct rate schedules filed with regulators. The rate schedule must reference the applicable network tier to support tiered ',
    `applicable_year` STRING COMMENT 'Plan year to which the rate schedule applies.',
    `aptc_amount` DECIMAL(18,2) COMMENT 'Advance Premium Tax Credit amount applied to the premium.',
    `cobra_rate` DECIMAL(18,2) COMMENT 'Premium rate applied to COBRA continuation coverage participants.',
    `coverage_type` STRING COMMENT 'Type of coverage the schedule governs (medical, dental, vision, pharmacy).. Valid values are `medical|dental|vision|rx`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate schedule record was first created in the system.',
    `effective_date` DATE COMMENT 'Date on which the rate schedule becomes effective.',
    `employee_contribution_rate` DECIMAL(18,2) COMMENT 'Rate at which the employee contributes toward the premium.',
    `employer_contribution_rate` DECIMAL(18,2) COMMENT 'Rate at which an employer contributes toward the members premium.',
    `expiration_date` DATE COMMENT 'Date on which the rate schedule expires or is superseded.',
    `family_tier_structure` STRING COMMENT 'Definition of family tier tiers (e.g., employee only, employee+spouse, employee+children) and associated premium multipliers.',
    `filing_date` DATE COMMENT 'Date the filing was submitted to the state regulator.',
    `filing_status` STRING COMMENT 'Current status of the regulatory filing with the state DOI.. Valid values are `filed|pending|rejected`',
    `is_default_schedule` BOOLEAN COMMENT 'Indicates whether this schedule is the default for its plan and market segment.',
    `last_review_date` DATE COMMENT 'Date when the schedule was last reviewed for compliance or rate updates.',
    `market_segment` STRING COMMENT 'Segment of the market the schedule applies to (individual, group, etc.).. Valid values are `individual|group|small_group|large_group`',
    `premium_type` STRING COMMENT 'Classification of the premium component (base premium, supplemental coverage, discount).. Valid values are `base|supplemental|discount`',
    `rate_amount` DECIMAL(18,2) COMMENT 'Base monetary amount used as the starting point for premium calculations.',
    `rate_schedule_description` STRING COMMENT 'Free‑form description providing additional context or notes about the schedule.',
    `rate_schedule_status` STRING COMMENT 'Current lifecycle status of the rate schedule.. Valid values are `active|inactive|pending|retired`',
    `rating_area` STRING COMMENT 'Geographic rating area code used for premium calculations.',
    `rating_method` STRING COMMENT 'Method used to calculate premiums (e.g., community‑rated, age‑rated, composite‑rated, experience‑rated).. Valid values are `community|age|composite|experience`',
    `rating_methodology_details` STRING COMMENT 'Narrative description of the rating methodology and any special rules.',
    `review_status` STRING COMMENT 'Outcome of the most recent compliance or actuarial review.. Valid values are `pending|approved|rejected`',
    `schedule_name` STRING COMMENT 'Human‑readable name given to the rate schedule for reporting and UI display.',
    `subsidy_amount` DECIMAL(18,2) COMMENT 'Monetary amount of any subsidy applied to the premium under this schedule.',
    `tobacco_surcharge_flag` BOOLEAN COMMENT 'Indicates whether a tobacco surcharge is applicable for this schedule.',
    `tobacco_surcharge_rate` DECIMAL(18,2) COMMENT 'Percentage surcharge applied to members who use tobacco, expressed as a decimal (e.g., 0.1500 for 15%).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rate schedule record.',
    `version_number` STRING COMMENT 'Sequential version identifier for changes to the rate schedule.',
    `wellness_discount_flag` BOOLEAN COMMENT 'Indicates whether a wellness discount is offered under this schedule.',
    `wellness_discount_rate` DECIMAL(18,2) COMMENT 'Discount percentage applied for members meeting wellness criteria.',
    CONSTRAINT pk_rate_schedule PRIMARY KEY(`rate_schedule_id`)
) COMMENT 'Defines the rate schedule configuration governing how premium rates are structured and applied for a plan year, market segment, and rating methodology. Captures rate schedule name, rating method (community rated, age-rated, composite rated, experience rated), effective date, expiration date, rating area reference, tobacco surcharge rules, wellness discount rules, family tier structure, and regulatory filing reference (state DOI rate filing number). Parent configuration for premium_rate records.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_account_id` FOREIGN KEY (`account_id`) REFERENCES `health_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `health_insurance_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ADD CONSTRAINT `fk_billing_premium_invoice_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `health_insurance_ecm`.`billing`.`payment_method`(`payment_method_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_aptc_subsidy_id` FOREIGN KEY (`aptc_subsidy_id`) REFERENCES `health_insurance_ecm`.`billing`.`aptc_subsidy`(`aptc_subsidy_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_premium_rate_id` FOREIGN KEY (`premium_rate_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_rate`(`premium_rate_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_account_id` FOREIGN KEY (`account_id`) REFERENCES `health_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `health_insurance_ecm`.`billing`.`payment_method`(`payment_method_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ADD CONSTRAINT `fk_billing_premium_payment_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `health_insurance_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_payment_method_id` FOREIGN KEY (`payment_method_id`) REFERENCES `health_insurance_ecm`.`billing`.`payment_method`(`payment_method_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ADD CONSTRAINT `fk_billing_payment_allocation_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_payment`(`premium_payment_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ADD CONSTRAINT `fk_billing_premium_rate_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `health_insurance_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_account_id` FOREIGN KEY (`account_id`) REFERENCES `health_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `health_insurance_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ADD CONSTRAINT `fk_billing_grace_period_premium_payment_id` FOREIGN KEY (`premium_payment_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_payment`(`premium_payment_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ADD CONSTRAINT `fk_billing_retro_adjustment_account_id` FOREIGN KEY (`account_id`) REFERENCES `health_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ADD CONSTRAINT `fk_billing_retro_adjustment_premium_invoice_id` FOREIGN KEY (`premium_invoice_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_invoice`(`premium_invoice_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ADD CONSTRAINT `fk_billing_aptc_subsidy_account_id` FOREIGN KEY (`account_id`) REFERENCES `health_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_account_id` FOREIGN KEY (`account_id`) REFERENCES `health_insurance_ecm`.`billing`.`account`(`account_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_premium_rate_id` FOREIGN KEY (`premium_rate_id`) REFERENCES `health_insurance_ecm`.`billing`.`premium_rate`(`premium_rate_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `health_insurance_ecm`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ADD CONSTRAINT `fk_billing_cycle_renewal_cycle_id` FOREIGN KEY (`renewal_cycle_id`) REFERENCES `health_insurance_ecm`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ADD CONSTRAINT `fk_billing_payment_method_account_id` FOREIGN KEY (`account_id`) REFERENCES `health_insurance_ecm`.`billing`.`account`(`account_id`);

-- ========= TAGS =========
ALTER SCHEMA `health_insurance_ecm`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `health_insurance_ecm`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Invoice ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `cobra_election_id` SET TAGS ('dbx_business_glossary_term' = 'Cobra Election Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `group_division_id` SET TAGS ('dbx_business_glossary_term' = 'Group Division Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `plan_election_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Election Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_process|completed|failed');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'mail|email|portal');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period (Days)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number (INV)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^INV[0-9]{10}$');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|issued|paid|partially_paid|void|delinquent');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'group_list_bill|group_self_bill|individual_statement|cobra|government_remittance');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `is_eligible_for_subsidy` SET TAGS ('dbx_business_glossary_term' = 'Eligibility for Subsidy');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Issue Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `line_of_business` SET TAGS ('dbx_business_glossary_term' = 'Line of Business (LOB)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `line_of_business` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|pharmacy|wellness');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `net_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Net Amount Due');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'portal|mail|phone');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `retroactive_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Adjustment Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'healthedge|custom_billing');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `source_system_invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Invoice ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Statement Number');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `statement_number` SET TAGS ('dbx_value_regex' = '^STMT[0-9]{8}$');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount (APTC)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_value_regex' = 'aptc|state_subsidy|none');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `aptc_subsidy_id` SET TAGS ('dbx_business_glossary_term' = 'Aptc Subsidy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `auth_service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Auth Service Line Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `contribution_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Contribution Strategy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `group_division_id` SET TAGS ('dbx_business_glossary_term' = 'Group Division Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `group_plan_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Group Plan Offering Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Plan ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `premium_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `aptc_subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'APTC Subsidy Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `coverage_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `coverage_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Start Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'EE|EE+SP|EE+CH|FAM');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `csr_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'CSR Adjustment Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `employee_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `employer_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `is_refund` SET TAGS ('dbx_business_glossary_term' = 'Refund Indicator');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'due|paid|failed|waived');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Premium Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `premium_currency` SET TAGS ('dbx_business_glossary_term' = 'Premium Currency');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `premium_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `premium_line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `premium_reconciliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `premium_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `premium_status` SET TAGS ('dbx_business_glossary_term' = 'Premium Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `premium_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|cancelled');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Indicator');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `retroactive_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Adjustment Indicator');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `premium_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Payment ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `tpa_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Tpa Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `nsf_indicator` SET TAGS ('dbx_business_glossary_term' = 'NSF Indicator');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payer_account_number` SET TAGS ('dbx_business_glossary_term' = 'Payer Account Number');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payer_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payer_account_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payer_name` SET TAGS ('dbx_business_glossary_term' = 'Payer Name');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payer_type` SET TAGS ('dbx_business_glossary_term' = 'Payer Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payer_type` SET TAGS ('dbx_value_regex' = 'employer|member|cms|state_medicaid|other');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount (Gross)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|call_center|mail|batch|other');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `premium_payment_status` SET TAGS ('dbx_value_regex' = 'pending|posted|failed|cancelled');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|matched|unmatched|exception');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `resolution_due_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Due Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'applied|refunded|written_off|reversed');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'HealthEdge|CustomBilling');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `suspense_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Suspense Reason Code');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `suspense_resolver` SET TAGS ('dbx_business_glossary_term' = 'Suspense Resolver');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `suspense_resolver` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `suspense_resolver` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `suspense_status` SET TAGS ('dbx_business_glossary_term' = 'Suspense Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `suspense_status` SET TAGS ('dbx_value_regex' = 'in_suspense|resolved|written_off');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'premium|adjustment|refund|reversal');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `payment_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `premium_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocated_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_sequence` SET TAGS ('dbx_business_glossary_term' = 'Allocation Sequence');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'allocated|pending|rejected|adjusted|closed');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_business_glossary_term' = 'Allocation Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `allocation_type` SET TAGS ('dbx_value_regex' = 'standard|partial|overpayment|suspense_resolution|adjustment|refund');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `is_overpayment` SET TAGS ('dbx_business_glossary_term' = 'Is Overpayment Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `is_suspense_resolution` SET TAGS ('dbx_business_glossary_term' = 'Is Suspense Resolution Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|call_center|in_person|batch|other');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_period` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Period');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'open|in_review|approved|closed|rejected');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `reconciliation_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|ad_hoc');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `total_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Total Adjustments Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `total_billed` SET TAGS ('dbx_business_glossary_term' = 'Total Billed Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `total_collected` SET TAGS ('dbx_business_glossary_term' = 'Total Collected Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Variance Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_allocation` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `delegation_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Delegation Agreement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `group_division_id` SET TAGS ('dbx_business_glossary_term' = 'Group Division Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `group_practice_id` SET TAGS ('dbx_business_glossary_term' = 'Group Practice Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `provider_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `tpa_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Tpa Arrangement Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number (ACC_NUM)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status (ACC_STATUS)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type (ACC_TYPE)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'employer_group|individual|government|medicare|medicaid|chip');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `aptc_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Premium Tax Credit (APTC) Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `auto_pay_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Pay Authorization Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `auto_pay_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Pay Authorization Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `auto_pay_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Pay Enrollment Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `billing_calendar_reference` SET TAGS ('dbx_business_glossary_term' = 'Billing Calendar Reference');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `billing_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Type (CYCLE_TYPE)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `billing_cycle_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency (BILL_FREQ)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `billing_method` SET TAGS ('dbx_business_glossary_term' = 'Billing Method (BILL_METHOD)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `billing_method` SET TAGS ('dbx_value_regex' = 'self_bill|list_bill|direct_bill');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (CR_LIM)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Account Balance (CUR_BAL)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period (GRACE_DAYS)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `invoice_generation_day` SET TAGS ('dbx_business_glossary_term' = 'Invoice Generation Day');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `last_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `next_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Next Invoice Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `payment_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `payment_due_day` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Day');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAY_TERMS)');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|due_on_receipt');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` SET TAGS ('dbx_subdomain' = 'rate_configuration');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `premium_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Network Service Area Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Rate Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `risk_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Underwriting Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `age_band` SET TAGS ('dbx_business_glossary_term' = 'Age Band');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `aptc_amount` SET TAGS ('dbx_business_glossary_term' = 'Advanced Premium Tax Credit (APTC) Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `cobra_rate` SET TAGS ('dbx_business_glossary_term' = 'COBRA Rate');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'individual|employee_spouse|family|dual');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `employee_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Rate');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `employer_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Rate');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `family_tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Family Tier Structure');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'individual|group|small_group|large_group');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `premium_rate_status` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `premium_rate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `premium_type` SET TAGS ('dbx_business_glossary_term' = 'Premium Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `premium_type` SET TAGS ('dbx_value_regex' = 'APR|PMPM');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `rating_method` SET TAGS ('dbx_business_glossary_term' = 'Rating Method');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `rating_method` SET TAGS ('dbx_value_regex' = 'community|age|composite|experience');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `tobacco_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Surcharge Rate');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`premium_rate` ALTER COLUMN `wellness_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Wellness Discount Rate');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `grace_period_id` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Identifier');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `care_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Care Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `premium_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Resolving Premium Payment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Record Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `day_count` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Day Count');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period End Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `extension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Extended Grace Period End Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `extension_flag` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Extension Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `grace_period_description` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Description');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `grace_period_number` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Number');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `grace_period_status` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `grace_period_status` SET TAGS ('dbx_value_regex' = 'active|expired|terminated|reinstated|paid');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `grace_period_type` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `grace_period_type` SET TAGS ('dbx_value_regex' = 'standard|aca_aptc|group|individual');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `is_eligible_for_aptc` SET TAGS ('dbx_business_glossary_term' = 'ACA APTC Eligibility Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_value_regex' = 'federal|state');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Notes');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Outcome');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'paid|terminated|reinstated|none');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Original Payment Due Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Reason Code');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'late_payment|non_payment|billing_error|other');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Start Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `termination_warning_issued` SET TAGS ('dbx_business_glossary_term' = 'Termination Warning Issued Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`grace_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Record Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` SET TAGS ('dbx_subdomain' = 'invoice_management');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `retro_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Retroactive Adjustment ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `condition_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Registry Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `enrollment_eligibility_span_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Span Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member Identifier (Member ID)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `member_risk_score_id` SET TAGS ('dbx_business_glossary_term' = 'Member Risk Score Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `pa_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Decision Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `pa_request_id` SET TAGS ('dbx_business_glossary_term' = 'Pa Request Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `premium_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Invoice Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `retrospective_review_id` SET TAGS ('dbx_business_glossary_term' = 'Retrospective Review Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number (External)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|posted|cancelled');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'add|termination|rate_change|tier_change|dispute_credit|dispute_correction');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `credit_memo_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Reference');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `dispute_open_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Open Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|under_review|resolved|escalated');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `dispute_type` SET TAGS ('dbx_value_regex' = 'invoice_amount|payment_misapplication|rate_error|retro_adjustment|aptc_discrepancy');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount (USD)');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `original_billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Original Billing Period End Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `original_billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Original Billing Period Start Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`retro_adjustment` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'credit_issued|invoice_corrected|upheld');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` SET TAGS ('dbx_subdomain' = 'rate_configuration');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_subsidy_id` SET TAGS ('dbx_business_glossary_term' = 'APTC Subsidy ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `case_id` SET TAGS ('dbx_business_glossary_term' = 'Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `exchange_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Enrollment Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Health Plan Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `health_plan_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `identity_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `identity_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `annual_aptc_cap` SET TAGS ('dbx_business_glossary_term' = 'Annual APTC Cap');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `annual_aptc_cap` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `annual_aptc_cap` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_monthly_amount` SET TAGS ('dbx_business_glossary_term' = 'Advance Premium Tax Credit (APTC) Monthly Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_monthly_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_monthly_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_subsidy_status` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Record Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `aptc_subsidy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `cms_reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'CMS Reconciliation Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `cms_reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|error');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `csr_variant` SET TAGS ('dbx_business_glossary_term' = 'Cost‑Sharing Reduction (CSR) Variant Level');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `csr_variant` SET TAGS ('dbx_value_regex' = '73|87|94');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `exchange_code` SET TAGS ('dbx_business_glossary_term' = 'Marketplace Exchange Identifier');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Effective Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_number` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Identifier (Subsidy Number)');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Termination Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Type (APTC or CSR)');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `subsidy_type` SET TAGS ('dbx_value_regex' = 'APTC|CSR');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `ytd_aptc_applied` SET TAGS ('dbx_business_glossary_term' = 'Year‑to‑Date APTC Applied');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `ytd_aptc_applied` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`aptc_subsidy` ALTER COLUMN `ytd_aptc_applied` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` SET TAGS ('dbx_subdomain' = 'rate_configuration');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Identifier');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `open_enrollment_period_id` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `premium_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Rate Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `renewal_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Renewal Billing Cycle Identifier');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `year_id` SET TAGS ('dbx_business_glossary_term' = 'Year Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `billing_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency in Months');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `billing_method` SET TAGS ('dbx_business_glossary_term' = 'Billing Method (Electronic, Paper, Direct Debit, Credit Card)');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `billing_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|direct_debit|credit_card');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Description of Billing Cycle Configuration');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Type (Monthly, Quarterly, Semi-Annual, Annual)');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `default_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Default Premium Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount Applied to Premium');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days After Due Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `invoice_day_of_month` SET TAGS ('dbx_business_glossary_term' = 'Invoice Generation Day of Month');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `is_pro_rata` SET TAGS ('dbx_business_glossary_term' = 'Pro Rata Billing Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `last_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Last Invoice Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `net_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Premium Amount After Discounts');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `next_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Next Invoice Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `payment_due_day_offset` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Day Offset');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `prorated_amount` SET TAGS ('dbx_business_glossary_term' = 'Pro Rata Adjusted Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount Applied to Premium');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due for Billing Cycle');
ALTER TABLE `health_insurance_ecm`.`billing`.`cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `payment_method_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Method ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `identity_id` SET TAGS ('dbx_business_glossary_term' = 'Member ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Authorization Reference');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_country` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `card_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Card Expiration Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Card Last Four Digits');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `card_last_four` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `card_type` SET TAGS ('dbx_business_glossary_term' = 'Card Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `card_type` SET TAGS ('dbx_value_regex' = 'Visa|MasterCard|Amex|Discover|Other');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `holder_name` SET TAGS ('dbx_business_glossary_term' = 'Cardholder Name');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `holder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `holder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `is_auto_pay` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Pay Authorization Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `masked_account_number` SET TAGS ('dbx_business_glossary_term' = 'Masked Bank Account Number');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `masked_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `masked_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `masked_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Masked Bank Routing Number');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `masked_routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `masked_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `method_type` SET TAGS ('dbx_value_regex' = 'ACH|Check|Wire|CreditCard|DebitCard|HSA');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Notes');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `payment_method_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `payment_method_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `pci_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'PCI Compliance Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `pci_compliance_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Risk Score');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `tokenized_account_number` SET TAGS ('dbx_business_glossary_term' = 'Tokenized Account Number');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `tokenized_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `tokenized_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|failed');
ALTER TABLE `health_insurance_ecm`.`billing`.`payment_method` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` SET TAGS ('dbx_subdomain' = 'rate_configuration');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule ID');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `group_renewal_id` SET TAGS ('dbx_business_glossary_term' = 'Group Renewal Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `network_service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Network Service Area Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Rate Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `provider_network_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `risk_underwriting_case_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Underwriting Case Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `applicable_year` SET TAGS ('dbx_business_glossary_term' = 'Applicable Plan Year');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `aptc_amount` SET TAGS ('dbx_business_glossary_term' = 'APTC Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `cobra_rate` SET TAGS ('dbx_business_glossary_term' = 'COBRA Rate');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Coverage Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `coverage_type` SET TAGS ('dbx_value_regex' = 'medical|dental|vision|rx');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `employee_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Rate');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `employer_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Rate');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `family_tier_structure` SET TAGS ('dbx_business_glossary_term' = 'Family Tier Structure');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'filed|pending|rejected');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `is_default_schedule` SET TAGS ('dbx_business_glossary_term' = 'Default Schedule Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'individual|group|small_group|large_group');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `premium_type` SET TAGS ('dbx_business_glossary_term' = 'Premium Type');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `premium_type` SET TAGS ('dbx_value_regex' = 'base|supplemental|discount');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rating_area` SET TAGS ('dbx_business_glossary_term' = 'Rating Area');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rating_method` SET TAGS ('dbx_business_glossary_term' = 'Rating Method');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rating_method` SET TAGS ('dbx_value_regex' = 'community|age|composite|experience');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `rating_methodology_details` SET TAGS ('dbx_business_glossary_term' = 'Rating Methodology Details');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `subsidy_amount` SET TAGS ('dbx_business_glossary_term' = 'Subsidy Amount');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `tobacco_surcharge_flag` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Surcharge Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `tobacco_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Tobacco Surcharge Rate');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `wellness_discount_flag` SET TAGS ('dbx_business_glossary_term' = 'Wellness Discount Flag');
ALTER TABLE `health_insurance_ecm`.`billing`.`rate_schedule` ALTER COLUMN `wellness_discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Wellness Discount Rate');
