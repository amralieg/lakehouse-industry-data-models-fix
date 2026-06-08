-- Schema for Domain: billing | Business: Staffing Hr | Version: v1_ecm
-- Generated on: 2026-05-02 15:53:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `staffing_hr_ecm`.`billing` COMMENT 'SSOT for all revenue and financial transaction data. Owns client invoice generation, bill rates, spread calculations (bill rate minus pay rate), markup calculations, gross margin tracking, payment terms, accounts receivable, payment processing, collections, credit memos, and dispute management sourced from Salesforce Revenue Cloud and Oracle NetSuite ERP. Supports various billing models including hourly time-and-materials, per-diem, project-based, SOW-based, and direct placement fee billing.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique surrogate identifier for the invoice record in the Staffing Hr billing system. Primary key for the billing.invoice data product.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Invoices must be assigned to accounting periods for revenue recognition, period close, and financial statement preparation.',
    `ar_account_id` BIGINT COMMENT 'FK to finance.ar_account.ar_account_id — Critical for order-to-cash: billing invoices must trace to AR sub-ledger accounts for financial close, aging reports, and revenue recognition. Without this FK, finance cannot reconcile invoiced amount',
    `assignment_id` BIGINT COMMENT 'Reference to the staffing placement or assignment that generated this invoice. Applicable for time-and-materials and per-diem billing models. Null for SOW-based or direct placement fee invoices.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account being billed. Links the invoice to the client master record in the Client domain.',
    `msa_id` BIGINT COMMENT 'Foreign key linking to contract.msa. Business justification: Invoices must reference governing MSA for payment terms, liability caps, dispute resolution, and indemnification scope. Critical for AR collections, legal disputes, and payment processing. MSA defines',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Invoices issued by specific legal entities for tax reporting, regulatory compliance, and consolidated financial statements.',
    `original_invoice_id` BIGINT COMMENT 'Reference to the original invoice that this invoice replaces in a void-and-rebill scenario. Populated on the replacement invoice to maintain the audit chain linking corrected invoices back to their originals. Null for original invoices not created as part of a rebill.',
    `pay_run_id` BIGINT COMMENT 'Reference to the payroll pay run associated with this invoice, enabling reconciliation between billing and payroll for spread and gross margin analysis.',
    `sourcing_campaign_id` BIGINT COMMENT 'Foreign key linking to recruitment.sourcing_campaign. Business justification: In RPO/MSP models, sourcing campaign costs are billed back to clients. Invoice references campaign for cost recovery, ROI analysis, and campaign budget reconciliation. Real business need in managed pr',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Invoices for vendor-supplied contingent workers must track supplier for vendor performance analysis, dispute resolution, supplier payment reconciliation, and margin reporting by supplier—core MSP/VMS ',
    `amount_paid` DECIMAL(18,2) COMMENT 'Total amount received from the client against this invoice to date. May be less than net_amount for partially paid invoices. Used to calculate the outstanding balance and drive collections workflows.',
    `bill_rate` DECIMAL(18,2) COMMENT 'The hourly or daily rate charged to the client for the staffing services on this invoice. For time-and-materials billing, this is the agreed bill rate per hour. For per-diem billing, this is the daily rate. Core input for spread and gross margin calculations. Sourced from the client rate card or VMS rate schedule.',
    `billing_model` STRING COMMENT 'Classification of the billing methodology used for this invoice. Determines how line items are calculated and how revenue is recognized. time_and_materials = hourly bill rate x hours worked; per_diem = daily flat rate; project_based = milestone or deliverable-based; sow_based = Statement of Work (SOW) fixed-fee; direct_placement_fee = one-time permanent placement fee.. Valid values are `time_and_materials|per_diem|project_based|sow_based|direct_placement_fee`',
    `billing_period_end` DATE COMMENT 'The last date of the service period covered by this invoice. Together with billing_period_start, defines the billing window for which staffing services are being charged.',
    `billing_period_start` DATE COMMENT 'The first date of the service period covered by this invoice. For time-and-materials invoices, this is the start of the timesheet week or pay period. Used for revenue recognition period alignment and client billing reconciliation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time this invoice record was first created in the billing system. Audit trail field capturing when the invoice was generated, whether in draft or final form. Sourced from Salesforce Revenue Cloud system timestamp.',
    `credit_memo_number` STRING COMMENT 'Reference number of the credit memo issued against this invoice, if applicable. Populated when a credit adjustment is applied to resolve a dispute, correct a billing error, or process a void-and-rebill. Links to the corresponding credit memo record in Oracle NetSuite ERP.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this invoice (e.g., USD, CAD, GBP). Supports multi-currency billing for international staffing engagements. Defaults to USD for domestic US operations.. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'The channel through which this invoice was or will be delivered to the client. Determines the transmission workflow in Salesforce Revenue Cloud. VMS portal delivery is required for clients using Beeline or similar VMS platforms.. Valid values are `email|vms_portal|edi|mail|fax`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount or credit applied to the invoice, such as volume discounts, contractual rate adjustments, or promotional credits negotiated in the Master Service Agreement (MSA). Reduces the net amount payable.',
    `dispute_reason` STRING COMMENT 'Description of the reason provided by the client for disputing this invoice. Populated when status is disputed. Common reasons include rate discrepancies, unauthorized hours, missing PO number, or timesheet approval issues. Used for dispute resolution tracking and root cause analysis.',
    `due_date` DATE COMMENT 'The date by which full payment is expected from the client, calculated from invoice_date plus the agreed payment terms (e.g., Net 30, Net 45). Drives accounts receivable aging buckets and collections escalation workflows.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total pre-tax, pre-discount invoice amount representing the sum of all billable charges before adjustments. Calculated as the sum of all line item bill rate charges for the billing period. Core component of the monetary triplet for revenue reporting.',
    `invoice_date` DATE COMMENT 'The date the invoice was formally issued to the client. Represents the principal business event timestamp for the invoice. Used as the basis for payment due date calculation and revenue recognition period assignment.',
    `invoice_number` STRING COMMENT 'Externally-visible, human-readable invoice identifier issued to the client. Unique across all billing periods and client accounts. Used on client-facing documents and referenced in payment remittances. Sourced from Salesforce Revenue Cloud invoice numbering sequence.. Valid values are `^INV-[0-9]{8,12}$`',
    `invoice_status` STRING COMMENT 'Current lifecycle state of the invoice. Drives accounts receivable workflows, collections actions, and revenue recognition. draft = not yet issued; sent = delivered to client; paid = fully settled; partially_paid = partial payment received; disputed = client has raised a dispute; void = cancelled, typically triggering a rebill.. Valid values are `draft|sent|paid|partially_paid|disputed|void`',
    `is_void` BOOLEAN COMMENT 'Indicates whether this invoice has been voided. True when the invoice has been cancelled and is no longer collectible. Voided invoices are retained for audit trail purposes and typically trigger a replacement invoice in void-and-rebill workflows.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied over the pay rate to arrive at the bill rate, expressed as a decimal (e.g., 0.45 = 45%). Calculated as (bill_rate - pay_rate) / pay_rate. A standard staffing industry profitability metric used in client pricing negotiations and margin analysis.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount due from the client after applying taxes and discounts. Calculated as gross_amount + tax_amount - discount_amount. This is the amount the client is expected to remit. Core component of the monetary triplet.',
    `notes` STRING COMMENT 'Free-text notes or special billing instructions associated with this invoice. May include client-specific billing requirements, dispute resolution comments, or internal processing notes. Not transmitted to the client unless explicitly included in the invoice document.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Remaining unpaid amount on the invoice, calculated as net_amount minus amount_paid. Drives accounts receivable aging reports and collections prioritization. Zero when invoice is fully paid.',
    `overtime_hours_billed` DECIMAL(18,2) COMMENT 'Number of overtime (OT) hours included in the total hours billed on this invoice. Overtime hours are billed at a premium rate per FLSA regulations (typically 1.5x the regular bill rate). Tracked separately for compliance reporting and client billing transparency.',
    `paid_timestamp` TIMESTAMP COMMENT 'Date and time full payment was received and confirmed for this invoice. Populated when status transitions to paid. Used for Days Sales Outstanding (DSO) calculation, cash flow reporting, and accounts receivable closure.',
    `pay_rate` DECIMAL(18,2) COMMENT 'The hourly or daily rate paid to the temporary worker for the services billed on this invoice. Used in conjunction with bill_rate to calculate the spread (bill rate minus pay rate) and gross margin. Sourced from TempWorks Payroll and the candidate pay rate agreement.',
    `payment_terms` STRING COMMENT 'Contractual payment terms agreed with the client, defining the number of days from invoice date within which payment is due. Sourced from the clients Master Service Agreement (MSA). Drives due_date calculation and accounts receivable aging classification.. Valid values are `net_15|net_30|net_45|net_60|due_on_receipt`',
    `po_number` STRING COMMENT 'Client-issued Purchase Order (PO) number that authorizes the staffing services billed on this invoice. Required by many enterprise clients and Vendor Management System (VMS) programs for invoice approval and payment processing. Must match the PO number in the clients procurement system.',
    `revenue_recognition_date` DATE COMMENT 'The date on which revenue from this invoice is recognized in the general ledger per GAAP ASC 606 revenue recognition standards. May differ from invoice_date for milestone-based or deferred revenue scenarios. Critical for accurate financial period reporting.',
    `sent_timestamp` TIMESTAMP COMMENT 'Date and time the invoice was transmitted to the client via email, VMS portal, or EDI. Marks the transition from draft to sent status. Used for SLA measurement of billing cycle time and for dispute resolution (proof of delivery).',
    `sow_number` STRING COMMENT 'Reference to the Statement of Work (SOW) document governing project-based or SOW-based billing engagements. Populated only when billing_model is sow_based or project_based. Links to the specific SOW deliverables being invoiced.',
    `spread_amount` DECIMAL(18,2) COMMENT 'The difference between the bill rate and the pay rate (bill_rate minus pay_rate), representing the gross margin per unit before burden costs. A key profitability metric in staffing known as the Spread. Stored at the invoice level for aggregate reporting; detailed spread is tracked at the line item level.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax charges applied to the invoice, including applicable state and local taxes on staffing services. Varies by jurisdiction and service type. Some staffing services may be tax-exempt depending on client tax status and state regulations.',
    `total_hours_billed` DECIMAL(18,2) COMMENT 'Total number of hours billed to the client on this invoice across all workers and assignments in the billing period. Applicable for time-and-materials billing models. Sourced from approved timesheets in Kronos Workforce Ready. Used for billing reconciliation and workforce utilization reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time this invoice record was last modified in the billing system. Tracks any changes to invoice amounts, status, payment terms, or other fields. Essential for data lineage, audit compliance, and incremental data pipeline processing.',
    `vms_invoice_number` STRING COMMENT 'External invoice identifier assigned by the clients Vendor Management System (VMS), such as Beeline. Required for VMS-managed programs where the VMS controls invoice approval workflows. Used for cross-system reconciliation between Staffing Hrs billing system and the clients VMS.',
    `void_reason` STRING COMMENT 'Reason code explaining why this invoice was voided. Required when is_void is True to support audit trail and financial controls. Drives void-and-rebill workflow routing and financial restatement processes.. Valid values are `billing_error|rate_correction|duplicate_invoice|client_request|contract_termination`',
    `worker_count` STRING COMMENT 'Number of distinct temporary workers or contractors included in this invoice. Provides headcount context for the billing period. Used for workforce analytics, client reporting, and Full-Time Equivalent (FTE) calculations.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Core billing document issued to a client for staffing services rendered during a billing period. Captures invoice number, date, due date, billing period, total amount, tax amount, net amount, payment terms, status (draft, sent, paid, partially paid, disputed, void), billing model (time-and-materials, per-diem, project-based, SOW-based, direct placement fee), currency, PO number, and client billing account reference. SSOT for all client-facing billing documents across all staffing engagement types. Supports void-and-rebill workflows for retroactive billing corrections.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique surrogate identifier for each invoice line item record in the billing system. Primary key for the invoice_line data product. Role: TRANSACTION_LINE.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Invoice lines posted to periods for detailed revenue tracking and revenue recognition by service line.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to candidate.assessment. Business justification: Assessment costs (background checks, drug screens, skills tests) are frequently billed as separate line items to clients in staffing. Direct link enables assessment-specific billing, cost recovery tra',
    `assignment_id` BIGINT COMMENT 'Reference to the worker placement or assignment that generated this billable line item. Links the billing record to the specific temporary or permanent placement in Bullhorn ATS/CRM. Satisfies RESOURCE_REFERENCE minimum category for TRANSACTION_LINE role.',
    `bill_rate_id` BIGINT COMMENT 'Foreign key linking to billing.bill_rate. Business justification: Each invoice line is billed at a specific bill rate. The invoice_line currently has bill_rate and pay_rate as scalar values, but these should reference the authoritative bill_rate master record. The b',
    `client_account_id` BIGINT COMMENT 'Reference to the client account being billed for this line item. Links to the client account record in Bullhorn ATS/CRM and Salesforce Revenue Cloud.',
    `location_id` BIGINT COMMENT 'Reference to the specific client work site or location where the worker performed services billed on this line. Used for multi-site billing, tax jurisdiction determination, and workforce analytics.',
    `msa_id` BIGINT COMMENT 'Foreign key linking to contract.msa. Business justification: Line items inherit MSA commercial terms when billed directly under MSA without SOW (common for temp staffing). Enables rate validation, markup cap enforcement, and compliance reporting by MSA.',
    `contract_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_schedule. Business justification: Line items validate against contract rate schedules for VMS compliance and rate variance reporting. Required for invoice approval workflows, rate audit trails, and ensuring billed rates match contract',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `credential_instance_id` BIGINT COMMENT 'Foreign key linking to credentialing.credential_instance. Business justification: Staffing firms bill clients for credential procurement services (background checks, drug screens, license verifications) as invoice line items. Finance teams need to track which specific credential in',
    `direct_hire_id` BIGINT COMMENT 'Foreign key linking to placement.direct_hire. Business justification: Invoice lines bill direct hire placement fees (one-time or installment). Staffing firms invoice direct hire fees separately from temp billing; finance teams reconcile fee revenue to placements. Essent',
    `gl_account_id` BIGINT COMMENT 'FK to finance.gl_account',
    `invoice_id` BIGINT COMMENT 'Foreign key reference to the parent invoice header (TRANSACTION_HEADER). Satisfies HEADER_REFERENCE minimum category for TRANSACTION_LINE role. Links this line item to its parent client invoice document in Salesforce Revenue Cloud and Oracle NetSuite ERP.',
    `job_category_id` BIGINT COMMENT 'Foreign key linking to joborder.job_category. Business justification: Revenue reporting by job category is a core P&L metric in staffing. Enables skill vertical profitability analysis, supports market demand forecasting, and drives strategic decisions on which job categ',
    `onboarding_engagement_id` BIGINT COMMENT 'Foreign key linking to onboarding.onboarding_engagement. Business justification: Line-level tracking of which onboarding enabled specific billing. Supports onboarding ROI analysis (time-to-bill by onboarding type), cost allocation (onboarding expenses vs. revenue), and client repo',
    `order_header_id` BIGINT COMMENT 'Reference to the job order or requisition (Req) associated with this billing line. Links the invoice line to the originating client staffing request managed in Bullhorn ATS/CRM.',
    `pay_rate_id` BIGINT COMMENT 'Foreign key linking to payroll.pay_rate. Business justification: Margin compliance and rate reconciliation reports require comparing billed rates against approved pay rates per assignment. Staffing operations must validate invoice lines dont bill below cost. Criti',
    `profile_id` BIGINT COMMENT 'Reference to the candidate or worker whose labor or services are being billed on this line item. Links to the candidate profile in Bullhorn ATS/CRM.',
    `req_pipeline_id` BIGINT COMMENT 'Foreign key linking to recruitment.req_pipeline. Business justification: Pipeline records track candidate progression through stages; invoice lines reference pipeline for sourcing attribution, recruiter commission allocation, and time-to-fill analysis tied to billing event',
    `sow_engagement_id` BIGINT COMMENT 'Foreign key linking to placement.sow_engagement. Business justification: Invoice lines bill SOW engagements (hourly, milestone, or deliverable-based). SOW billing differs from standard temp assignments; requires linking invoice lines to specific SOW placements for revenue ',
    `sow_id` BIGINT COMMENT 'Reference to the Statement of Work (SOW) contract under which this line item is billed, applicable for project-based or SOW-based billing models. Links to the SOW document managed in DocuSign CLM.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Line-level supplier tracking enables blended-rate invoicing where multiple suppliers provide workers on same engagement; critical for supplier scorecarding, margin analysis by supplier, and VMS progra',
    `timesheet_id` BIGINT COMMENT 'Reference to the approved timesheet record from Kronos Workforce Ready that substantiates the hours billed on this line item. Applicable for time-and-materials and per-diem billing types.',
    `worker_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.worker_classification. Business justification: Each invoice lines billing model, rate structure, and markup depend on worker classification (W2 vs IC affects billing structure, burden inclusion, markup applicability). Core billing logic requires ',
    `billing_model` STRING COMMENT 'The contractual billing model under which this line item is invoiced. Time and Materials = hourly billing; Per Diem = daily rate; Project Based = milestone deliverable; SOW (Statement of Work) Based = fixed-scope contract; Direct Placement = permanent hire fee; Temp-to-Perm = conversion fee billing. [ENUM-REF-CANDIDATE: time_and_materials|per_diem|project_based|sow_based|direct_placement|temp_to_perm|contract_to_hire|rpo — promote to reference product]. Valid values are `time_and_materials|per_diem|project_based|sow_based|direct_placement|temp_to_perm`',
    `billing_type` STRING COMMENT 'Classification of the billable service type on this line item. Regular = standard hours; OT (Overtime) = hours exceeding FLSA thresholds billed at OT rate; DT (Double Time) = hours billed at double rate; Per Diem = daily allowance billing; Expense = reimbursable expense; Placement Fee = direct hire or temp-to-perm conversion fee.. Valid values are `regular|overtime|double_time|per_diem|expense|placement_fee`',
    `burden_rate_amount` DECIMAL(18,2) COMMENT 'The employer burden cost allocated to this line item, representing the employer-side payroll taxes and benefits costs (FICA, FUTA, SUTA, Workers Comp, benefits) associated with the worker hours billed. Sourced from TempWorks Payroll burden rate configuration.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice line item record was first created in the billing system. Supports audit trail, data lineage, and compliance requirements.',
    `credit_memo_reference` STRING COMMENT 'The credit memo document number issued against this invoice line item when a billing dispute is resolved or an adjustment is required. Populated when line_status is credited. Enables accounts receivable reconciliation in Oracle NetSuite ERP.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this line item (e.g., USD, CAD, GBP). Supports multi-currency billing for international staffing operations.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any contractual discount or credit applied to this invoice line item, reducing the extended amount. May reflect volume discounts, promotional credits, or negotiated rate adjustments per the client MSA.',
    `extended_amount` DECIMAL(18,2) COMMENT 'The total billable amount for this line item, calculated as quantity multiplied by bill rate. Represents the gross revenue for this line before any adjustments, credits, or taxes. Satisfies LINE_VALUE_OR_RESULT minimum category for TRANSACTION_LINE role.',
    `gross_margin_amount` DECIMAL(18,2) COMMENT 'The net gross margin for this line item after subtracting the burden rate from the spread amount. Gross Margin = Spread Amount - Burden Rate Amount. Core financial performance metric for staffing profitability reporting.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this line item is billable to the client (True) or is a non-billable internal cost line (False). Non-billable lines may represent internal adjustments, write-offs, or courtesy credits that are tracked but not invoiced.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether this invoice line item is subject to sales tax or use tax (True) or is tax-exempt (False). Drives tax calculation logic in Oracle NetSuite ERP based on client tax exemption certificates and service type.',
    `line_number` STRING COMMENT 'Sequential line item number within the parent invoice, used for ordering and referencing individual line items on the invoice document. Satisfies LINE_SEQUENCE minimum category for TRANSACTION_LINE role.',
    `line_status` STRING COMMENT 'Current workflow status of this invoice line item. Draft = pending finalization; Approved = validated and ready for client billing; Disputed = client has raised a dispute; Credited = a credit memo has been issued; Voided = line cancelled; Paid = payment received and applied.. Valid values are `draft|approved|disputed|credited|voided|paid`',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The markup percentage applied to the pay rate to derive the bill rate for this line item, expressed as a decimal (e.g., 0.35 = 35%). Markup Percentage = (Bill Rate - Pay Rate) / Pay Rate. Key profitability metric tracked in Salesforce Revenue Cloud.',
    `net_amount` DECIMAL(18,2) COMMENT 'The final net billable amount for this line item after applying discounts and adding taxes. Net Amount = Extended Amount - Discount Amount + Tax Amount. Represents the actual amount due from the client for this line.',
    `ot_multiplier` DECIMAL(18,2) COMMENT 'The rate multiplier applied to the base bill rate for overtime (OT) or double time (DT) billing lines. Standard OT multiplier is 1.5x; DT multiplier is 2.0x. Applicable only when billing_type is overtime or double_time.',
    `pay_period_end_date` DATE COMMENT 'The end date of the pay period or work period covered by this invoice line item. Defines the end of the billable service window. Together with pay_period_start_date, establishes the billing period for compliance and audit purposes.',
    `pay_period_start_date` DATE COMMENT 'The start date of the pay period or work period covered by this invoice line item. Defines the beginning of the billable service window for time-and-materials and per-diem billing.',
    `po_number` STRING COMMENT 'The clients purchase order number associated with this invoice line item. Required by many enterprise clients for accounts payable processing and invoice matching. Sourced from the clients ERP or VMS.',
    `quantity` DECIMAL(18,2) COMMENT 'The billable quantity for this line item. Represents hours worked for time-and-materials billing, number of days for per-diem billing, or a count of 1 for placement fee billing. Satisfies LINE_QUANTITY minimum category for TRANSACTION_LINE role.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the quantity field. Hours for time-and-materials, days for per-diem, units for deliverable-based SOW billing, flat for fixed-fee placement fees.. Valid values are `hours|days|units|flat`',
    `revenue_recognition_date` DATE COMMENT 'The date on which revenue for this invoice line item is recognized in the General Ledger per ASC 606 revenue recognition standards. May differ from the invoice date or pay period end date for deferred or accrued revenue scenarios.',
    `service_description` STRING COMMENT 'Human-readable description of the billable service or work performed on this line item, as it appears on the client invoice. Examples: Temporary Staffing Services - IT, Direct Placement Fee - Software Engineer, Per Diem - Travel Assignment.',
    `spread_amount` DECIMAL(18,2) COMMENT 'The gross margin contribution for this line item, calculated as (bill_rate minus pay_rate) multiplied by quantity. Spread is a core staffing industry profitability metric representing the difference between what the client is billed and what the worker is paid.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount applied to this invoice line item based on the applicable tax code and jurisdiction. Represents sales tax, use tax, or VAT charged to the client.',
    `tax_code` STRING COMMENT 'The tax jurisdiction or tax treatment code applied to this invoice line item in Oracle NetSuite ERP. Determines applicable sales tax, use tax, or VAT rates based on the clients billing location and service type.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice line item record was last modified. Tracks changes to billing amounts, status updates, dispute resolutions, and credit memo applications for audit and compliance purposes.',
    `vms_req_number` STRING COMMENT 'The requisition or purchase order number assigned by the clients Vendor Management System (VMS), such as Beeline, for this billing line. Required for VMS-managed programs to match invoices to approved requisitions and enable straight-through processing.',
    `work_date` DATE COMMENT 'The specific date on which the work was performed, applicable for daily billing lines or per-diem entries. Used for detailed labor analytics and compliance reporting.',
    `worker_type` STRING COMMENT 'Classification of the workers employment arrangement for this billing line. W-2 Temp = temporary employee on agency payroll; 1099 IC (Independent Contractor) = self-employed contractor; C2C = corp-to-corp contractor; EOR (Employer of Record) = worker employed by EOR entity; Direct Hire = permanent placement.. Valid values are `w2_temp|1099_ic|c2c|eor|direct_hire`',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Line-item detail within a client invoice representing a single billable unit of work. Each line ties to a specific worker assignment, timesheet period, or deliverable. Captures line number, service description, billing type (regular, OT, DT, per diem, expense, placement fee), quantity, bill rate, extended amount, pay period dates, worker and job order references, cost center, GL account, tax code, and markup/spread values.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`bill_rate` (
    `bill_rate_id` BIGINT COMMENT 'Unique system-generated surrogate key identifying a bill rate record. Primary key for the bill_rate data product in the billing domain.',
    `assignment_id` BIGINT COMMENT 'Reference to the placement record this bill rate governs. Ties the negotiated rate to the specific worker assignment for timesheet-to-invoice processing.',
    `billing_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Bill rates are often derived from or reference rate schedules (rate cards). A bill_rate record represents a specific negotiated rate, which may be based on a rate_schedule template. This FK allows tra',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for which this bill rate applies. Establishes the client-rate relationship for invoice generation and profitability reporting.',
    `client_rate_card_id` BIGINT COMMENT 'Reference to the client rate card from which this bill rate is derived. Links to the negotiated rate card established under the clients Master Service Agreement (MSA).',
    `msa_id` BIGINT COMMENT 'Foreign key linking to contract.msa. Business justification: Bill rates must comply with MSA markup caps, rate escalation terms, and pricing frameworks. Essential for rate approval workflows, margin analysis, and contract compliance audits in staffing operation',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: SOW-specific rates for project-based work with fixed pricing or milestone billing. Required for SOW rate validation, project margin analysis, and ensuring rates match SOW pricing model.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Bill rates often vary by cost center for internal cost allocation and departmental P&L tracking in staffing operations.',
    `direct_hire_id` BIGINT COMMENT 'Foreign key linking to placement.direct_hire. Business justification: Direct hire placements have negotiated fee rates (percentage of salary or flat fee). Rate cards track direct hire fee structures by client/job category. Essential for fee calculation, client rate audi',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Bill rates may specify GL accounts for revenue classification by service type or billing model.',
    `job_category_id` BIGINT COMMENT 'Foreign key linking to joborder.job_category. Business justification: Bill rates in staffing are structured by job category/skill tier within rate cards. Enables rate card analysis by job family, supports pricing strategy by vertical, and facilitates market rate benchma',
    `location_id` BIGINT COMMENT 'Reference to the specific client work site or location for which this bill rate applies. Supports location-based rate differentiation (e.g., higher rates for high cost-of-living markets or specialized facilities).',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: Managed programs (MSP/RPO) have distinct rate governance separate from VMS and general client rates. Program managers need to track program-specific rate approvals, enforce program markup caps, and ge',
    `order_header_id` BIGINT COMMENT 'Reference to the specific job order (requisition) to which this bill rate is associated. Enables rate traceability at the requisition level for billing and margin analysis.',
    `pay_rate_id` BIGINT COMMENT 'Foreign key linking to payroll.pay_rate. Business justification: Bill rate cards must reference corresponding pay rates to calculate spread and markup percentages. Pricing teams set bill rates based on pay rates plus target margin. Core relationship in staffing pri',
    `previous_rate_bill_rate_id` BIGINT COMMENT 'Self-referencing identifier pointing to the prior version of this bill rate record. Enables rate lineage tracking and audit trail for rate changes over the engagement lifecycle.',
    `recruitment_sla_target_id` BIGINT COMMENT 'Foreign key linking to recruitment.recruitment_sla_target. Business justification: SLA targets define rate structures (premium rates for expedited fills, volume discounts). Bill rates reference SLA targets for pricing compliance, rate card enforcement, and contractual rate validatio',
    `sow_engagement_id` BIGINT COMMENT 'Foreign key linking to placement.sow_engagement. Business justification: SOW engagements require specific rate cards (project-based, milestone, or deliverable rates). Bill rates for SOW differ from standard temp rates; linking enables SOW billing accuracy, rate change trac',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Bill rates in MSP/VMS programs are often negotiated per supplier tier; tracking supplier enables rate card compliance auditing, supplier-specific pricing analysis, and automated rate validation during',
    `vms_program_id` BIGINT COMMENT 'Foreign key linking to client.vms_program. Business justification: VMS programs enforce platform-specific rate structures, markup caps, and supplier tier pricing rules that differ from general client rates. VMS compliance reporting requires direct rate-to-program lin',
    `rate_id` BIGINT COMMENT 'The external rate identifier assigned by the clients Vendor Management System (VMS), such as Beeline. Required for VMS-managed programs where bill rates are governed by the clients contingent workforce program.',
    `wage_hour_determination_id` BIGINT COMMENT 'Foreign key linking to compliance.wage_hour_determination. Business justification: Bill rates must comply with wage-hour determinations (prevailing wage requirements, FLSA exemption status, minimum wage laws). Rate-setting cannot proceed without wage-hour compliance validation. Regu',
    `amount` DECIMAL(18,2) COMMENT 'The agreed-upon rate charged to the client per unit (hour, day, or project) for the specified job category and skill level. This is the authoritative rate used for invoice generation. Expressed in the currency defined by currency_code.',
    `approval_status` STRING COMMENT 'Current workflow state of the bill rate record. Pending = awaiting authorization; Approved = active and usable for invoicing; Rejected = declined by approver; Expired = past expiration_date; Superseded = replaced by a newer rate version.. Valid values are `pending|approved|rejected|expired|superseded`',
    `approved_by` STRING COMMENT 'Name or identifier of the internal manager or executive who authorized this bill rate. Required for audit trail and SOC 2 Type II compliance controls on financial data.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the bill rate was formally approved. Provides a precise audit trail for rate authorization events, supporting SOC 2 Type II and internal financial controls.',
    `billing_model` STRING COMMENT 'The commercial billing model under which this rate is applied. Determines invoice generation logic: Time-and-Materials (T&M) bills actuals; Per Diem bills daily flat rates; Project-Based bills milestones; SOW (Statement of Work)-Based bills deliverables; Direct Placement bills one-time placement fees; Temp-to-Perm bills conversion fees.. Valid values are `time_and_materials|per_diem|project_based|sow_based|direct_placement|temp_to_perm`',
    `burden_included` BOOLEAN COMMENT 'Indicates whether employer burden costs (FICA, FUTA, SUTA, Workers Compensation, benefits) are factored into the bill rate amount. When True, the bill rate is all-inclusive; when False, burden is billed separately or absorbed by the staffing firm.',
    `burden_rate_percentage` DECIMAL(18,2) COMMENT 'The employer burden rate percentage applied to the pay rate, covering FICA, FUTA, SUTA, Workers Compensation, and benefits costs. Used to calculate true gross margin when burden_included is True.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this bill rate record was first created in the system. Provides the audit trail entry point for the record lifecycle, required for SOC 2 Type II compliance.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the bill rate amount (e.g., USD, CAD, GBP). Required for multi-currency client engagements and international staffing operations.. Valid values are `^[A-Z]{3}$`',
    `dt_bill_rate_amount` DECIMAL(18,2) COMMENT 'The negotiated bill rate for double-time hours (holiday, weekend, or contractually defined premium hours). Applied when timesheet entries are classified as DT per the client MSA terms.',
    `effective_date` DATE COMMENT 'The date from which this bill rate becomes active and applicable for invoice generation. Supports rate versioning and ensures correct rate application across the engagement lifecycle.',
    `expiration_date` DATE COMMENT 'The date after which this bill rate is no longer valid. Null indicates an open-ended rate with no defined expiry. Used to enforce rate card validity windows and trigger rate renegotiation workflows.',
    `flsa_exempt` BOOLEAN COMMENT 'Indicates whether the job category associated with this bill rate is classified as FLSA-exempt (True) or non-exempt (False). Exempt positions are not subject to overtime billing rules; non-exempt positions trigger OT bill rates beyond 40 hours.',
    `gross_margin_percentage` DECIMAL(18,2) COMMENT 'Gross margin expressed as a percentage of the bill rate: ((Bill Rate - Pay Rate - Burden) / Bill Rate) * 100. Represents the profitability of the engagement after direct labor costs. Key KPI for financial reporting and Power BI dashboards.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied over the pay rate to arrive at the bill rate, expressed as ((Bill Rate - Pay Rate) / Pay Rate) * 100. Used for rate card negotiations, competitive benchmarking, and profitability analysis.',
    `max_bill_rate_amount` DECIMAL(18,2) COMMENT 'The ceiling rate above which this bill rate cannot be set, as defined by the client rate card or VMS program constraints. Used in rate cap enforcement for MSP/VMS-managed programs.',
    `min_bill_rate_amount` DECIMAL(18,2) COMMENT 'The floor rate below which this bill rate cannot be negotiated, as defined by the rate card or internal pricing policy. Enforces minimum margin thresholds during rate negotiations and VMS submissions.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context about this bill rate, such as special negotiation terms, client-specific exceptions, or rate justification notes. Supports account management and audit review.',
    `ot_bill_rate_amount` DECIMAL(18,2) COMMENT 'The negotiated bill rate for overtime hours (hours exceeding the FLSA standard 40-hour workweek threshold). Stored separately from the standard rate to support accurate invoice generation for OT hours on timesheets.',
    `pay_rate_amount` DECIMAL(18,2) COMMENT 'The corresponding pay rate for the worker associated with this bill rate. Stored alongside the bill rate to enable real-time spread and gross margin calculations without joining to the payroll domain.',
    `per_diem_amount` DECIMAL(18,2) COMMENT 'Daily flat-rate allowance billed to the client for travel, lodging, or subsistence expenses associated with the worker assignment. Applicable for travel-intensive placements and project-based engagements.',
    `rate_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this bill rate record within the rate card or billing system. Used for cross-system reconciliation between Salesforce Revenue Cloud and Oracle NetSuite ERP.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `rate_name` STRING COMMENT 'Human-readable label for this bill rate record (e.g., Senior Java Developer - Standard, Registered Nurse - OT Rate). Used in rate card displays, client-facing documents, and reporting.',
    `rate_source` STRING COMMENT 'Indicates the origin of this bill rate: Manual = entered directly by a recruiter or account manager; VMS Imported = sourced from Beeline VMS; Rate Card = derived from the client rate card; MSA Negotiated = established during MSA contract execution; Market Benchmark = set based on SIA market data.. Valid values are `manual|vms_imported|rate_card|msa_negotiated|market_benchmark`',
    `rate_type` STRING COMMENT 'Classification of the bill rate by pay period or billing model. Standard = regular hours; OT (Overtime) = hours beyond FLSA threshold; DT (Double Time) = premium holiday/weekend rate; Per Diem = daily flat allowance; Blended = composite rate across multiple rate types; Project = fixed-fee project billing.. Valid values are `standard|overtime|double_time|per_diem|blended|project`',
    `rate_version` STRING COMMENT 'Sequential version number for this bill rate record, incremented each time the rate is renegotiated or updated. Supports rate history tracking and ensures the correct version is applied to invoices within the effective date range.',
    `skill_level` STRING COMMENT 'The experience or seniority tier for which this bill rate is negotiated. Drives rate differentiation within a job category on the client rate card. [ENUM-REF-CANDIDATE: entry|junior|mid|senior|lead|principal|executive — 7 candidates stripped; promote to reference product]',
    `source_system_code` STRING COMMENT 'The native record identifier from the originating system of record (Salesforce Revenue Cloud or Oracle NetSuite ERP). Enables cross-system reconciliation and data lineage tracing in the Databricks Silver Layer.',
    `spread_amount` DECIMAL(18,2) COMMENT 'The gross spread calculated as bill rate minus pay rate (Bill Rate - Pay Rate = Spread). Represents the raw revenue contribution before burden costs. A core profitability metric in staffing operations tracked per ASA and SIA standards.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this bill rate record was last modified. Tracks the most recent change for audit trail purposes and supports incremental data loading in the Databricks Silver Layer.',
    `work_state_code` STRING COMMENT 'Two-letter US state code for the work location associated with this bill rate. Drives state-specific tax, SUTA, and Workers Compensation rate calculations that affect gross margin.. Valid values are `^[A-Z]{2}$`',
    `workers_comp_code` STRING COMMENT 'The NCCI (National Council on Compensation Insurance) workers compensation class code applicable to this bill rates job category. Determines the workers comp premium rate included in burden calculations.',
    CONSTRAINT pk_bill_rate PRIMARY KEY(`bill_rate_id`)
) COMMENT 'Master record of negotiated bill rates for client engagements. Stores the agreed-upon rate for a specific job category, skill level, client, and contract. Includes rate amount, rate type (standard, OT, DT, per diem, blended), effective dates, currency, rate card reference, markup percentage, spread amount (bill minus pay rate), gross margin percentage, burden inclusion flag, and approval status. Authoritative rate source for invoice generation and profitability calculations.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` (
    `billing_rate_schedule_id` BIGINT COMMENT 'Unique identifier for the rate schedule. Primary key for this entity.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for which this rate schedule is defined. Links to the client master data to associate rates with specific customer engagements.',
    `msa_id` BIGINT COMMENT 'Foreign key linking to contract.msa. Business justification: Rate schedules implement MSA-negotiated pricing frameworks, markup percentages, and burden rate terms. Required for rate card approval, client rate negotiations, and MSA compliance validation in staff',
    `contract_rate_schedule_id` BIGINT COMMENT 'Foreign key linking to contract.contract_rate_schedule. Business justification: Operational rate schedules implement contract rate schedules negotiated in MSAs/SOWs. Essential for ensuring billing rates comply with contract terms, VMS rate validation, and client rate card synchro',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: SOW-specific rate schedules for project deliverables, skill tiers, and milestone-based pricing. Essential for project billing, SOW budget management, and rate approval workflows in project staffing.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rate schedules may be cost-center specific for departmental P&L and internal cost allocation in multi-division staffing firms.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Rate schedules may define GL accounts for revenue streams by client program or service line.',
    `job_category_id` BIGINT COMMENT 'Foreign key linking to joborder.job_category. Business justification: MSA/SOW rate schedules define pricing tiers by job category and skill level. Critical for contract pricing management, enables validation that billed rates comply with contracted schedules, and suppor',
    `managed_program_id` BIGINT COMMENT 'Foreign key linking to client.managed_program. Business justification: Managed Service Provider (MSP) programs require dedicated rate schedules with program-specific pricing governance, markup caps, and SLA-linked rate structures. MSP account managers need to enforce pro',
    `requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_requirement. Business justification: Rate schedules must incorporate compliance requirements (prevailing wage rules, state-specific wage laws, federal contractor requirements). Pricing strategy and rate card design depend on applicable c',
    `superseded_by_schedule_billing_rate_schedule_id` BIGINT COMMENT 'Reference to the rate schedule that replaces this one when status is Superseded. Nullable for active schedules. Used to maintain rate schedule lineage and version history.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Rate schedules in VMS programs are frequently supplier-specific or tier-specific; linking enables automated rate validation when suppliers submit candidates, supports supplier tier-based pricing enfor',
    `vms_program_id` BIGINT COMMENT 'Reference to the VMS program under which this rate schedule operates. Nullable for non-VMS engagements. Links to Beeline VMS program configuration.',
    `approval_date` DATE COMMENT 'The date on which this rate schedule was approved by authorized personnel (finance, sales leadership, or client). Used for compliance and audit purposes.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved this rate schedule. Used for accountability and audit trail in rate governance.',
    `base_bill_rate` DECIMAL(18,2) COMMENT 'The standard hourly bill rate charged to the client for regular hours worked under this rate schedule. Expressed in the contract currency. Foundation for markup and margin calculations.',
    `base_pay_rate` DECIMAL(18,2) COMMENT 'The standard hourly pay rate paid to the worker for regular hours worked under this rate schedule. Used to calculate spread and gross margin. Expressed in the contract currency.',
    `billing_frequency` STRING COMMENT 'The frequency at which invoices are generated for placements under this rate schedule. Aligns with client payment terms and payroll cycles.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `billing_rate_schedule_status` STRING COMMENT 'Current lifecycle status of the rate schedule. Active schedules are in use, Inactive are retired, Draft are under development, Pending Approval await authorization, Expired have passed their end date, and Superseded have been replaced by newer versions.. Valid values are `active|inactive|draft|pending_approval|expired|superseded`',
    `burden_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage of pay rate representing employer-paid taxes and benefits (FICA, FUTA, SUTA, Workers Comp, health insurance). Used to calculate fully-loaded labor cost and net margin.',
    `conversion_fee_percentage` DECIMAL(18,2) COMMENT 'The percentage of annual salary charged as a conversion fee if the client hires a temporary worker as a permanent employee (temp-to-perm conversion). Nullable for direct hire or non-convertible placements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this rate schedule record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which all monetary amounts in this rate schedule are denominated (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `direct_placement_fee_percentage` DECIMAL(18,2) COMMENT 'The percentage of first-year salary charged for direct hire placements under this rate schedule. Typically ranges from 15% to 25% depending on role complexity and market conditions.',
    `dt_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to the base bill rate for double-time hours (typically 2.0). Used for hours worked on holidays, weekends, or beyond daily overtime thresholds per state law or contract terms.',
    `effective_end_date` DATE COMMENT 'The date on which this rate schedule expires and can no longer be applied to new placements. Nullable for open-ended schedules. Used for contract renewals and rate card versioning.',
    `effective_start_date` DATE COMMENT 'The date from which this rate schedule becomes valid and can be applied to new placements and assignments. Aligns with contract effective dates and fiscal periods.',
    `geographic_market` STRING COMMENT 'The geographic region, metro area, or market zone to which this rate schedule applies. Used for cost-of-living adjustments and regional rate differentiation.',
    `gross_margin_percentage` DECIMAL(18,2) COMMENT 'The gross margin as a percentage of the bill rate. Calculated as ((Bill Rate - Pay Rate) / Bill Rate) * 100. Primary profitability indicator for client engagements.',
    `holiday_rate_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to the base bill rate for hours worked on designated holidays. Varies by client contract and may differ from standard overtime or double-time rates.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied to the pay rate to derive the bill rate. Calculated as ((Bill Rate - Pay Rate) / Pay Rate) * 100. Key profitability metric for staffing operations.',
    `maximum_hours_per_week` DECIMAL(18,2) COMMENT 'The maximum number of hours per week allowed under this rate schedule before requiring special approval or triggering overtime. Used for compliance with client budgets and labor law thresholds.',
    `minimum_hours_per_week` DECIMAL(18,2) COMMENT 'The minimum number of hours per week guaranteed or required under this rate schedule. Used for part-time, full-time, and contract-to-hire classifications.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this rate schedule record was last updated. Used for change tracking and audit compliance.',
    `notes` STRING COMMENT 'Free-text field for additional context, special terms, exceptions, or instructions related to this rate schedule. Used for operational guidance and client-specific requirements.',
    `ot_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to the base bill rate for overtime hours (typically 1.5 for time-and-a-half). Defines the premium rate for hours worked beyond standard weekly hours as defined by FLSA.',
    `payment_terms_days` STRING COMMENT 'The number of days from invoice date within which payment is due from the client. Standard terms include Net 30, Net 45, or Net 60. Used for accounts receivable aging and cash flow forecasting.',
    `per_diem_allowance` DECIMAL(18,2) COMMENT 'The daily allowance amount provided for meals, lodging, and incidental expenses for travel assignments. Nullable for non-travel roles. Expressed in the contract currency.',
    `schedule_code` STRING COMMENT 'Short alphanumeric code used as a unique business identifier for the rate schedule in billing systems and client contracts.',
    `schedule_name` STRING COMMENT 'Business-friendly name of the rate schedule used for identification and reference in client engagements and internal reporting.',
    `schedule_type` STRING COMMENT 'Classification of the rate schedule indicating the billing model and engagement structure. Standard for general placements, Premium for specialized skills, MSP-Managed for Managed Service Provider programs, VMS-Driven for Vendor Management System engagements, SOW-Based for Statement of Work contracts, and Project-Based for fixed-scope deliverables.. Valid values are `standard|premium|msp_managed|vms_driven|sow_based|project_based`',
    `skill_tier` STRING COMMENT 'The proficiency or seniority level for which this rate schedule is designed. Entry for junior roles, Intermediate for mid-level, Advanced for senior, Expert for specialized, and Executive for leadership positions.. Valid values are `entry|intermediate|advanced|expert|executive`',
    `sla_fill_time_days` STRING COMMENT 'The maximum number of days committed to fill a requisition under this rate schedule as defined in the client SLA. Used for Time to Fill (TTF) performance tracking.',
    `sla_submittal_count` STRING COMMENT 'The minimum number of qualified candidate submittals guaranteed per requisition under this rate schedule. Used for Quality of Submission (QoS) performance measurement.',
    `spread_amount` DECIMAL(18,2) COMMENT 'The dollar difference between the bill rate and pay rate (Bill Rate minus Pay Rate). Represents the gross margin per hour before burden costs. Expressed in the contract currency.',
    `version_number` STRING COMMENT 'Sequential version number for this rate schedule. Incremented when rates are renegotiated or terms are amended. Used for audit trail and historical rate analysis.',
    CONSTRAINT pk_billing_rate_schedule PRIMARY KEY(`billing_rate_schedule_id`)
) COMMENT 'Reference entity defining structured rate schedules and rate card templates used across client engagements. Captures rate schedule name, schedule type (standard, premium, MSP-managed, VMS-driven, SOW), applicable job categories, skill tiers, geographic market, effective date range, markup percentage tiers, OT multiplier, DT multiplier, per diem allowance, holiday rate multiplier, and associated MSA or contract reference. Used as the template from which individual bill rates are instantiated for specific worker assignments.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique identifier for the payment transaction. Primary key for the payment entity.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Payments must be posted to correct accounting periods for period close, cash flow reporting, and financial statement accuracy.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: Payments update AR account balances and aging buckets. Essential for AR management, DSO tracking, and reconciliation between billing and finance systems.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Payments deposited to specific bank accounts. Essential for cash management, bank reconciliation, and lockbox processing.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account that made this payment. Identifies the paying party.',
    `msa_id` BIGINT COMMENT 'Foreign key linking to contract.msa. Business justification: Payments processed under MSA payment terms (net days, early payment discounts, dispute resolution). Critical for cash application, payment term enforcement, and dispute escalation per MSA provisions.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice against which this payment is applied. Links payment to the billing document.',
    `amount` DECIMAL(18,2) COMMENT 'The total monetary amount of the payment received from the client. Gross payment value before any allocation or adjustments.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has been applied to outstanding invoices. May be less than payment_amount if payment is partially unapplied.',
    `bank_account_last_four` STRING COMMENT 'Last four digits of the bank account number used for the payment. Masked for security and PCI compliance.. Valid values are `^[0-9]{4}$`',
    `cash_account_code` STRING COMMENT 'The general ledger cash account code to which this payment is deposited. Used for financial reporting and reconciliation.',
    `channel` STRING COMMENT 'The interface or channel through which the payment was submitted (e.g., online portal, mobile app, mail, in-person). [ENUM-REF-CANDIDATE: Online Portal|Mobile App|Mail|In-Person|Phone|Bank Transfer|Lockbox — 7 candidates stripped; promote to reference product]',
    `check_number` STRING COMMENT 'The check number if payment was made by check. Used for tracking and reconciliation of paper-based payments.. Valid values are `^[0-9]{4,10}$`',
    `cleared_date` DATE COMMENT 'The date on which the payment cleared the banking system and funds became available. Null if payment has not yet cleared.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the payment record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the payment was made (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `deposit_date` DATE COMMENT 'The date on which the payment was deposited into the company bank account. May differ from payment_date for checks or delayed processing.',
    `discount_taken` DECIMAL(18,2) COMMENT 'The amount of early payment discount taken by the client if payment was made within discount terms. Reduces the amount due.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The exchange rate applied to convert the payment amount to the base currency if the payment was made in a foreign currency. Null if payment is in base currency.',
    `is_overpayment` BOOLEAN COMMENT 'Flag indicating whether this payment exceeds the amount due, resulting in a credit balance on the client account.',
    `is_partial_payment` BOOLEAN COMMENT 'Flag indicating whether this payment represents a partial payment against an invoice (true) or full payment (false).',
    `lockbox_batch_number` STRING COMMENT 'The batch identifier from the lockbox service if payment was received through a lockbox arrangement. Used for reconciliation of bulk payment processing.',
    `modified_by` STRING COMMENT 'The name or identifier of the user or system that last modified the payment record. Used for audit trail purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the payment record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text notes or comments about the payment. May include special instructions, dispute information, or reconciliation details.',
    `payment_date` DATE COMMENT 'The date on which the payment was received or processed. Principal business event timestamp for the payment transaction.',
    `payment_method` STRING COMMENT 'The financial instrument or mechanism used to make the payment (e.g., ACH, wire transfer, check, credit card).. Valid values are `ACH|Wire Transfer|Check|Credit Card|Debit Card|Electronic Funds Transfer`',
    `payment_number` STRING COMMENT 'Externally visible unique payment reference number used for tracking and reconciliation. Business identifier for the payment transaction.. Valid values are `^PAY-[0-9]{8,12}$`',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction indicating its processing state and validity.. Valid values are `Pending|Cleared|Applied|Returned|Voided|Reversed`',
    `processor` STRING COMMENT 'The name of the payment processor or gateway that handled the transaction (e.g., Stripe, PayPal, Authorize.Net, bank name for ACH/wire).',
    `reconciled_by` STRING COMMENT 'The name or identifier of the user who performed the payment reconciliation. Used for audit trail purposes.',
    `reconciled_date` DATE COMMENT 'The date on which the payment was reconciled with bank statements and invoice applications. Null if not yet reconciled.',
    `reconciliation_status` STRING COMMENT 'Status indicating whether the payment has been reconciled with bank statements and invoice applications.. Valid values are `Unreconciled|Reconciled|Disputed|Under Review`',
    `remittance_reference` STRING COMMENT 'Reference number or identifier from the remittance advice document provided by the client indicating which invoices the payment covers.',
    `reversal_date` DATE COMMENT 'The date on which the payment was reversed or returned. Null if payment has not been reversed.',
    `reversal_reason` STRING COMMENT 'The reason for payment reversal or return if the payment was voided or returned (e.g., insufficient funds, stop payment, account closed).',
    `routing_number` STRING COMMENT 'Nine-digit ABA routing number identifying the financial institution for ACH or wire transfers. Stored for reconciliation purposes.. Valid values are `^[0-9]{9}$`',
    `source_system` STRING COMMENT 'The name of the source system from which the payment record originated (e.g., Salesforce Revenue Cloud, Oracle NetSuite ERP, payment gateway).',
    `source_system_code` STRING COMMENT 'The unique identifier of the payment record in the source system. Used for data lineage and reconciliation with source systems.',
    `terms` STRING COMMENT 'The payment terms applicable to this payment (e.g., Net 30, 2/10 Net 30). Indicates the agreed-upon payment schedule and discount eligibility.',
    `transaction_reference` STRING COMMENT 'External transaction identifier from the payment processor or banking system. Used for reconciliation and dispute resolution.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that has not yet been applied to any invoice. Represents credit on account or overpayment.',
    `created_by` STRING COMMENT 'The name or identifier of the user or system that created the payment record. Used for audit trail purposes.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Transactional record of client payments received against outstanding invoices. Captures payment date, payment amount, payment method (ACH, wire, check, credit card), payment reference number, bank account details (masked), remittance advice reference, applied invoice references, unapplied amount, currency, exchange rate, payment status (pending, cleared, returned, voided), and source transaction identifier. SSOT for all client payment receipts in the billing domain.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`payment_application` (
    `payment_application_id` BIGINT COMMENT 'Unique identifier for the payment application record. Primary key.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Payment applications posted to periods for cash application tracking and period close reconciliation.',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank account into which the payment was deposited. Used for cash management and bank reconciliation.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account that made the payment. Denormalized from invoice for reporting convenience and to support cross-invoice payment applications.',
    `invoice_id` BIGINT COMMENT 'Reference to the client invoice to which this payment is being applied. Links to the invoice header record.',
    `invoice_line_id` BIGINT COMMENT 'Reference to the specific invoice line item to which this payment is applied. Null if payment is applied at invoice header level rather than line level.',
    `payment_id` BIGINT COMMENT 'Reference to the client payment that is being applied to invoices. Links to the payment transaction record.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the user who performed the payment application. Used for audit trail and accountability in cash application processes.',
    `reversed_by_application_payment_application_id` BIGINT COMMENT 'Reference to the payment application record that reversed this application. Null if this application has not been reversed. Creates audit trail for reversal transactions.',
    `reverses_application_id` BIGINT COMMENT 'Reference to the original payment application record that this record reverses. Null if this is not a reversal transaction. Creates audit trail linking reversals to original applications.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Additional adjustment amount applied to the invoice, such as currency exchange adjustments, rounding differences, or other reconciliation adjustments not classified as discount or write-off.',
    `aging_bucket` STRING COMMENT 'The accounts receivable aging category of the invoice at the time of payment application. Used for AR aging analysis and collection effectiveness reporting.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `application_date` DATE COMMENT 'The business date on which the payment was applied to the invoice. This is the accounting effective date for accounts receivable (AR) reduction and may differ from the payment receipt date.',
    `application_number` STRING COMMENT 'Human-readable business identifier for the payment application record. Externally visible reference number used in financial reporting and reconciliation.. Valid values are `^PA-[0-9]{8}$`',
    `application_status` STRING COMMENT 'Current lifecycle status of the payment application. Pending = awaiting approval, Applied = successfully applied to AR, Reversed = application has been reversed, Disputed = under dispute investigation, Reconciled = confirmed and closed, Voided = cancelled before application.. Valid values are `pending|applied|reversed|disputed|reconciled|voided`',
    `application_type` STRING COMMENT 'Classification of how the payment is being applied. Full = entire invoice paid, Partial = portion of invoice paid, Prepayment = payment applied before invoice due date, Credit Memo Offset = credit memo applied against invoice, Overpayment = payment exceeds invoice amount, Underpayment = payment less than invoice amount.. Valid values are `full|partial|prepayment|credit_memo_offset|overpayment|underpayment`',
    `applied_amount` DECIMAL(18,2) COMMENT 'The monetary amount from the payment that is allocated to this specific invoice or invoice line. This is the gross amount before any discounts or write-offs.',
    `approval_date` DATE COMMENT 'The date when the payment application was approved. Null if no approval required or still pending approval.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment application record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment application amounts. Must match the currency of the associated invoice and payment.. Valid values are `^[A-Z]{3}$`',
    `days_to_payment` STRING COMMENT 'Number of days between invoice date and payment application date. Used for Days Sales Outstanding (DSO) calculation and payment performance analysis.',
    `discount_amount` DECIMAL(18,2) COMMENT 'The amount of early payment discount or settlement discount taken by the client on this application. Reduces the net amount applied to accounts receivable.',
    `dispute_flag` BOOLEAN COMMENT 'Flag indicating whether this payment application is associated with a disputed invoice or payment. Used to track disputed receivables and resolution processes.',
    `dispute_reason` STRING COMMENT 'Description of the reason for dispute if dispute_flag is true. Examples include billing error, service quality issue, rate disagreement, or timesheet discrepancy.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate used to convert payment amounts to the invoice currency if currencies differ. Null if payment and invoice are in the same currency.',
    `gl_batch_number` STRING COMMENT 'Reference to the general ledger batch in which this payment application was posted. Used for audit trail and GL reconciliation.',
    `gl_posting_date` DATE COMMENT 'The accounting period date when this payment application was posted to the general ledger. Used for financial period close and reporting.',
    `is_deleted` BOOLEAN COMMENT 'Soft delete flag indicating whether this payment application record has been logically deleted. Used for audit trail preservation while excluding from active reporting.',
    `is_early_payment` BOOLEAN COMMENT 'Flag indicating whether the payment was received before the invoice due date. Used to track early payment discount eligibility and client payment behavior.',
    `is_late_payment` BOOLEAN COMMENT 'Flag indicating whether the payment was received after the invoice due date. Used to track collection effectiveness and client payment behavior.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment application record was last modified. Used for audit trail and change tracking.',
    `net_applied_amount` DECIMAL(18,2) COMMENT 'The net amount applied to accounts receivable after all discounts, write-offs, and adjustments. Calculated as applied_amount minus discount_amount minus writeoff_amount plus/minus adjustment_amount.',
    `notes` STRING COMMENT 'Free-form text notes or comments about the payment application. Used to capture special circumstances, manual adjustments, or reconciliation details.',
    `payment_reference_number` STRING COMMENT 'External reference number from the payment transaction, such as check number, wire confirmation number, ACH trace number, or credit card authorization code. Used for payment reconciliation and audit.',
    `reconciliation_status` STRING COMMENT 'Status of the reconciliation process for this payment application. Tracks whether the application has been matched and confirmed in the accounts receivable aging and bank reconciliation processes.. Valid values are `unreconciled|reconciled|exception|pending_review`',
    `reversal_reason` STRING COMMENT 'Business reason for reversing this payment application if status is reversed. Examples include payment returned, incorrect application, duplicate application, or client dispute.',
    `source_system` STRING COMMENT 'The system or process that originated this payment application record. Used for data lineage tracking and reconciliation.. Valid values are `salesforce_revenue_cloud|netsuite_erp|manual_entry|bank_feed|lockbox`',
    `source_system_code` STRING COMMENT 'The unique identifier of this payment application record in the source system. Used for data lineage and cross-system reconciliation.',
    `writeoff_amount` DECIMAL(18,2) COMMENT 'The amount written off as uncollectible or forgiven on this invoice application. Represents bad debt or goodwill adjustment that reduces accounts receivable without cash receipt.',
    CONSTRAINT pk_payment_application PRIMARY KEY(`payment_application_id`)
) COMMENT 'Association record linking client payments to specific invoices or invoice lines, capturing the allocation of a payment across one or more outstanding invoices. Stores applied amount, discount taken, write-off amount, application date, application type (full, partial, prepayment, credit memo offset), and reconciliation status. Enables accurate accounts receivable aging and cash application tracking.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`credit_memo` (
    `credit_memo_id` BIGINT COMMENT 'Unique system-generated identifier for the credit memo record. Primary key for the billing.credit_memo data product in the Staffing Hr lakehouse silver layer.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Credit memos must be posted to correct periods for revenue adjustments and financial statement accuracy.',
    `approved_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the internal user who approved the credit memo prior to issuance. Supports segregation of duties, financial controls, and SOC 2 Type II audit requirements. Nullable if approval is not required for the credit amount tier.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: Credit memos reduce AR account balances. Required for AR aging reports, bad debt reserve calculations, and financial statement accuracy.',
    `assignment_id` BIGINT COMMENT 'Reference to the staffing placement associated with this credit memo, applicable when the credit is related to a specific worker assignment (e.g., timesheet rebilling, fall-off adjustment, temp-to-perm conversion fee reversal). Nullable for non-placement-specific credits.',
    `billing_dispute_id` BIGINT COMMENT 'Reference to the billing dispute record that triggered this credit memo, when applicable. Links the credit memo to the dispute resolution workflow for tracking dispute-to-resolution cycle time and client satisfaction (NPS) impact. Nullable for proactive credits not tied to a formal dispute.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account to whom the credit memo is issued. Identifies the billing counterparty for accounts receivable balance correction and client financial reporting. Sourced from Salesforce Revenue Cloud client account.',
    `msa_id` BIGINT COMMENT 'Foreign key linking to contract.msa. Business justification: Credits issued under MSA adjustment provisions, liability caps, and indemnification terms. Required for credit approval workflows, MSA compliance, and tracking adjustments against MSA financial limits',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Credits for SOW milestone rejections, scope changes, or deliverable non-acceptance. Required for SOW budget adjustments, change order tracking, and project billing corrections in staffing.',
    `conversion_id` BIGINT COMMENT 'Foreign key linking to placement.conversion. Business justification: Conversion fall-offs (converted employee leaves before minimum tenure) trigger conversion fee credit memos per MSA terms. Credit memos track fee reversals or prorated adjustments. Essential for conver',
    `direct_hire_id` BIGINT COMMENT 'Foreign key linking to placement.direct_hire. Business justification: Direct hire fall-offs within guarantee period trigger fee credit memos (refund or replacement obligation). Credit memos track fee adjustments for early terminations. Essential for guarantee period man',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Credit memos issued by legal entities for tax reporting and financial statement accuracy.',
    `invoice_id` BIGINT COMMENT 'Reference to the originating invoice that this credit memo offsets or reduces. Links the credit memo to the specific billing transaction being corrected, reversed, or adjusted. Core to void-and-rebill workflows and accounts receivable reconciliation.',
    `regulatory_violation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_violation. Business justification: Credit memos remediate billing errors caused by regulatory violations (incorrect classification leading to wrong bill rates, wage-hour violations requiring rate corrections). Direct operational link f',
    `sla_breach_id` BIGINT COMMENT 'Foreign key linking to recruitment.sla_breach. Business justification: SLA breaches trigger contractual penalties or client credits per MSA terms. Credit memos reference the specific breach for penalty enforcement, compliance tracking, and client dispute resolution. Crea',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal user (billing specialist or accounts receivable manager) who created and issued the credit memo. Supports audit trail and approval workflow tracking.',
    `timesheet_id` BIGINT COMMENT 'Reference to the specific timesheet record being corrected or rebilled by this credit memo. Applicable for timesheet_rebilling and rate_correction reason codes. Enables end-to-end traceability from timesheet correction through credit memo to rebilled invoice.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the credit memo amount that has been applied against one or more outstanding invoices or open balances to date. Enables tracking of partial application and remaining unapplied credit balance. Applied amount must not exceed credit_amount.',
    `applied_date` DATE COMMENT 'Date on which the credit memo was fully applied against outstanding invoice balances. Populated when applied_status transitions to fully_applied. Used for accounts receivable close-out and cash flow reporting.',
    `applied_status` STRING COMMENT 'Indicates the application state of the credit memo against outstanding invoices. unapplied: no amount applied yet; partially_applied: some amount applied, remainder open; fully_applied: entire credit amount has been applied; expired: credit memo passed expiration date without full application.. Valid values are `unapplied|partially_applied|fully_applied|expired`',
    `approval_date` DATE COMMENT 'Date on which the credit memo was approved by the authorized approver. Supports financial controls audit trail and SLA measurement for credit memo processing turnaround time.',
    `approval_status` STRING COMMENT 'Current workflow approval state of the credit memo. Controls whether the credit memo can be applied to invoices. draft: created but not submitted; pending_approval: submitted for review; approved: authorized for application; rejected: denied by approver; voided: cancelled after issuance.. Valid values are `draft|pending_approval|approved|rejected|voided`',
    `billing_model` STRING COMMENT 'The billing model under which the originating invoice and this credit memo were generated. Determines the calculation methodology for the credit amount. Values: time_and_materials (hourly bill rate × hours), per_diem (daily rate), project_based (milestone or fixed-fee), sow_based (Statement of Work deliverable billing), direct_placement (permanent placement fee).. Valid values are `time_and_materials|per_diem|project_based|sow_based|direct_placement`',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period to which the credit memo applies. Paired with billing_period_start_date to define the scope of the adjustment. Critical for timesheet rebilling and retroactive rate correction workflows.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period to which the credit memo applies. Used when the credit relates to a specific timesheet week, pay period, or project billing cycle. Enables period-specific accounts receivable adjustments and retroactive rate correction scoping.',
    `client_notification_date` DATE COMMENT 'Date on which the client was formally notified of the credit memo. Populated when client_notified is True. Used for SLA measurement of credit memo communication turnaround and client relationship management.',
    `client_notified` BOOLEAN COMMENT 'Indicates whether the client has been formally notified of the credit memo issuance (True) or not yet notified (False). Supports client communication tracking and SLA compliance for credit memo notification turnaround.',
    `corrected_bill_rate` DECIMAL(18,2) COMMENT 'The revised bill rate that should have been applied, used in retroactive rate correction credit memos. The difference between original_bill_rate and corrected_bill_rate, multiplied by the applicable hours, drives the credit_amount calculation. Supports rate card compliance validation.',
    `cost_center_code` STRING COMMENT 'Internal cost center or profit center code associated with the credit memo for management accounting and P&L attribution. Enables gross margin and spread analysis by business unit or division within Oracle NetSuite ERP.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the credit memo record was first created in the source system or lakehouse. Conforms to yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trail, data lineage, and SOC 2 Type II compliance.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Gross monetary value of the credit memo in the billing currency. Represents the total amount to be credited against the clients outstanding accounts receivable balance. Always expressed as a positive value; the credit direction is implied by the document type.',
    `credit_memo_number` STRING COMMENT 'Externally visible, human-readable credit memo reference number assigned by the billing system (e.g., CM-2024-000123). Used on client-facing documents, remittance advice, and accounts receivable reconciliation. Sourced from Salesforce Revenue Cloud or Oracle NetSuite ERP.. Valid values are `^CM-[0-9]{4}-[0-9]{6}$`',
    `credited_hours` DECIMAL(18,2) COMMENT 'Number of hours being credited in this memo, applicable for time-and-materials billing model credits (timesheet rebilling, rate corrections). Multiplied by the rate differential to derive credit_amount. Nullable for non-hourly billing models.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the credit memo amount (e.g., USD, CAD, GBP). Supports multi-currency billing for international staffing operations. Defaults to USD for domestic U.S. operations.. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'Date after which the unapplied credit memo balance expires and can no longer be applied to invoices. Supports credit memo lifecycle management and accounts receivable cleanup. Nullable for credits with no expiration policy.',
    `gl_account_code` STRING COMMENT 'General Ledger account code to which the credit memo is posted in Oracle NetSuite ERP. Determines the financial statement impact of the credit (e.g., revenue reversal, accounts receivable reduction, allowance for doubtful accounts). Required for period-close and financial reporting.',
    `is_void_and_rebill` BOOLEAN COMMENT 'Flag indicating whether this credit memo is part of a formal void-and-rebill workflow (True) or a standalone partial credit (False). When True, the credit memo fully offsets the originating invoice and a rebill_invoice_id should be populated with the replacement invoice.',
    `issue_date` DATE COMMENT 'The calendar date on which the credit memo was formally issued to the client. Used as the principal business event date for accounts receivable aging, revenue recognition adjustments, and period-close reporting. Conforms to yyyy-MM-dd format.',
    `notes` STRING COMMENT 'Additional free-text notes or internal comments associated with the credit memo. Used by billing specialists to document special circumstances, client communications, or processing instructions not captured in structured fields.',
    `original_bill_rate` DECIMAL(18,2) COMMENT 'The bill rate (hourly or per-diem) that was originally invoiced and is being corrected by this credit memo. Applicable for rate_correction and timesheet_rebilling reason codes. Expressed in the billing currency per unit (hour or day). Supports spread and markup recalculation.',
    `payment_terms` STRING COMMENT 'Payment terms governing how the credit will be applied or refunded to the client (e.g., Net 30, apply to next invoice, immediate refund). Inherited from the clients Master Service Agreement (MSA) or overridden at the credit memo level. [ENUM-REF-CANDIDATE: net_30|net_45|net_60|apply_next_invoice|immediate_refund|custom — promote to reference product]',
    `reason_code` STRING COMMENT 'Standardized reason code classifying the business cause for issuing the credit memo. Drives workflow routing, GL account mapping, and analytics. Values: billing_error (incorrect invoice amount), rate_correction (retroactive bill rate adjustment), timesheet_rebilling (timesheet correction requiring rebill), service_credit (service quality or SLA failure credit), fall_off_adjustment (candidate fall-off fee reversal), conversion_fee_reversal (temp-to-perm or contract-to-hire conversion fee reversal).. Valid values are `billing_error|rate_correction|timesheet_rebilling|service_credit|fall_off_adjustment|conversion_fee_reversal`',
    `reason_description` STRING COMMENT 'Free-text narrative providing detailed explanation of why the credit memo was issued. Supplements the reason_code with specific context such as the nature of the billing error, the corrected bill rate, or the timesheet period being rebilled. Required for audit and dispute documentation.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this credit memo record originated. Supports data lineage, reconciliation, and audit trail requirements. Values: salesforce_revenue_cloud (primary billing system), netsuite_erp (ERP-originated credit), manual (manually entered adjustment).. Valid values are `salesforce_revenue_cloud|netsuite_erp|manual`',
    `source_system_ref` STRING COMMENT 'The native identifier of this credit memo in the originating source system (e.g., NetSuite internal ID or Salesforce Credit Note ID). Enables cross-system reconciliation between the lakehouse silver layer and operational systems of record.',
    `tax_adjustment_amount` DECIMAL(18,2) COMMENT 'Tax amount being reversed or adjusted as part of this credit memo, where applicable. Represents the tax component of the original invoice that is being credited back to the client. Required for accurate tax liability reporting and IRS compliance. Nullable when no tax was applied to the original invoice.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'Remaining credit balance not yet applied to any invoice (credit_amount minus applied_amount). Represents open credit available for future invoice offset. Used in accounts receivable aging and client balance reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the credit memo record. Conforms to yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for change data capture (CDC), incremental ETL processing, and audit trail in the Databricks lakehouse silver layer.',
    `void_date` DATE COMMENT 'Date on which the credit memo was voided. Populated only when approval_status is voided. Used in void-and-rebill workflows and accounts receivable audit trails.',
    CONSTRAINT pk_credit_memo PRIMARY KEY(`credit_memo_id`)
) COMMENT 'Transactional record of credit memos issued to clients to offset or reduce outstanding invoice balances. Captures credit memo number, issue date, credit amount, reason code (billing error, retroactive rate correction, timesheet rebilling, service credit, fall-off adjustment, conversion fee reversal), originating invoice reference, approval status, applied status, expiration date, and issuing user. Supports dispute resolution, retroactive rate adjustments, timesheet correction rebilling, and accounts receivable balance corrections. Used in conjunction with invoice void-and-rebill workflows for full retroactive billing adjustments.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` (
    `billing_dispute_id` BIGINT COMMENT 'Unique system-generated identifier for the billing dispute record. Primary key for the dispute data product in the billing domain.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Disputes tracked by period for aging analysis, reserve calculations, and period-over-period dispute trend reporting.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: Disputes affect AR aging buckets and collection status. Tracked at AR account level for DSO analysis and collection prioritization.',
    `assignment_id` BIGINT COMMENT 'Reference to the staffing placement associated with the disputed charge, when the dispute relates to a specific worker assignment. Supports root cause analysis linking disputes back to placement records.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account that raised the billing dispute. Used to track dispute frequency and patterns by client for relationship management and collections hold logic.',
    `msa_id` BIGINT COMMENT 'Foreign key linking to contract.msa. Business justification: Disputes escalated per MSA dispute resolution clauses (mediation, arbitration, jurisdiction). Essential for legal escalation, SLA breach tracking, and enforcing MSA remedy provisions in staffing billi',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Disputes reference SOW acceptance criteria, deliverables, and milestone completion terms. Critical for resolving billing disputes on project-based work, validating deliverable completion, and SOW comp',
    `conversion_id` BIGINT COMMENT 'Foreign key linking to placement.conversion. Business justification: Conversion fee disputes occur (tenure hours calculation, fee basis disagreement, conversion date disputes). Dispute resolution requires linking to specific conversion records. Essential for conversion',
    `direct_hire_id` BIGINT COMMENT 'Foreign key linking to placement.direct_hire. Business justification: Direct hire fee disputes are common (salary verification, start date discrepancies, guarantee period interpretation). Dispute tracking links to specific direct hire placements for resolution. Essentia',
    `invoice_id` BIGINT COMMENT 'Reference to the parent invoice against which this dispute was raised. Links the dispute to the specific billing document in the accounts receivable ledger.',
    `invoice_line_id` BIGINT COMMENT 'Reference to the specific invoice line item being disputed, when the dispute is scoped to a single line rather than the full invoice. Null when the dispute covers the entire invoice.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Disputes may trigger manual journal entries for revenue adjustments or reserve postings.',
    `order_header_id` BIGINT COMMENT 'Reference to the job order (requisition) associated with the disputed placement or charge. Enables traceability from the billing dispute back to the original client requisition and agreed job requirements including bill rate and worker specifications.',
    `staff_profile_id` BIGINT COMMENT 'Foreign key linking to employee.staff_profile. Business justification: Dispute resolution requires assigned staff owner for accountability and workload tracking. Critical operational metric for AR management and dispute aging reports. New FK replaces plain-text resolutio',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Billing disputes often involve supplier-related issues (worker no-show, quality problems, timesheet discrepancies); tracking supplier enables dispute pattern analysis, supplier performance scorecardin',
    `timesheet_dispute_id` BIGINT COMMENT 'Foreign key linking to timesheet.timesheet_dispute. Business justification: Billing disputes frequently originate from or reference worker-initiated timesheet disputes. This link enables end-to-end dispute resolution workflow tracking, root cause analysis, and ensures billing',
    `timesheet_id` BIGINT COMMENT 'Reference to the specific timesheet record that is the subject of an hours_mismatch dispute. Links the dispute directly to the Kronos Workforce Ready timesheet for reconciliation of approved versus billed hours.',
    `worker_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.worker_classification. Business justification: Invoice disputes frequently arise from worker classification disagreements (client disputes IC vs W2 billing rates, markup applicability). Dispute resolution requires referencing the official classifi',
    `agreed_bill_rate` DECIMAL(18,2) COMMENT 'The contractually agreed bill rate per the client rate card, MSA, or VMS program at the time of the disputed invoice. Used to calculate the rate variance driving the dispute and to validate the correct rate for invoice adjustment.',
    `approved_credit_amount` DECIMAL(18,2) COMMENT 'The dollar amount approved for credit or adjustment as the outcome of dispute resolution. May be equal to, less than, or zero relative to the disputed_amount depending on resolution type. Feeds credit memo generation in Oracle NetSuite ERP.',
    `approved_hours` DECIMAL(18,2) COMMENT 'The number of hours the client acknowledges as correctly approved and billable, as determined during dispute investigation. Used to calculate the hours variance and determine the correct invoice adjustment amount.',
    `bill_rate_disputed` DECIMAL(18,2) COMMENT 'The bill rate (hourly or per-diem) that the client is contesting as incorrect on the disputed invoice. Captured specifically for rate_discrepancy dispute types to enable direct comparison against the agreed rate on the client rate card or MSA.',
    `billing_model` STRING COMMENT 'The billing model under which the disputed charge was generated. Determines the applicable rate structure and dispute resolution approach. Hourly applies to time-and-materials temp staffing; per_diem applies to daily rate assignments; project applies to milestone-based billing; sow applies to Statement of Work engagements; direct_placement applies to permanent placement fee billing.. Valid values are `hourly|per_diem|project|sow|direct_placement`',
    `channel` STRING COMMENT 'The channel through which the client submitted the dispute. VMS portal disputes originate from Beeline or similar vendor management systems; client portal disputes come through the staffing firms self-service portal; written notice includes formal letters or legal correspondence.. Valid values are `email|vms_portal|phone|written_notice|client_portal`',
    `client_contact_email` STRING COMMENT 'Email address of the client contact responsible for the dispute. Used for dispute notification, resolution communication, and audit trail of client correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `client_contact_name` STRING COMMENT 'Full name of the client-side contact person who raised or is the primary point of contact for the dispute. Used for communication tracking and dispute correspondence.',
    `collections_hold_flag` BOOLEAN COMMENT 'Indicates whether the disputed invoice or invoice line has been placed on collections hold pending dispute resolution. True prevents collections activity on the disputed amount; False allows normal collections processing to proceed.',
    `credit_memo_number` STRING COMMENT 'The reference number of the credit memo issued in Oracle NetSuite ERP as the financial resolution of the dispute. Populated only when resolution_type is credit_issued or partial_credit. Links the dispute outcome to the accounts receivable credit transaction.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this dispute record (disputed_amount, approved_credit_amount). Supports multi-currency client billing for international staffing engagements.. Valid values are `^[A-Z]{3}$`',
    `dispute_description` STRING COMMENT 'Free-text narrative describing the nature of the billing dispute as submitted by the client or captured by the billing operations team. Provides context beyond the structured dispute_type classification for investigation and resolution purposes.',
    `dispute_number` STRING COMMENT 'Externally visible, human-readable business identifier for the dispute, used in client communications, collections correspondence, and dispute tracking. Sourced from Salesforce Revenue Cloud case numbering.. Valid values are `^DSP-[0-9]{8,12}$`',
    `dispute_status` STRING COMMENT 'Current workflow state of the dispute through its resolution lifecycle. Drives collections hold logic — invoices with open or under_review disputes are typically placed on collections hold pending resolution.. Valid values are `open|under_review|escalated|resolved|closed`',
    `dispute_type` STRING COMMENT 'Classification of the nature of the billing dispute. Rate discrepancy indicates bill rate vs. agreed rate mismatch; hours mismatch indicates timesheet vs. billed hours variance; unauthorized charge indicates a charge not covered by the MSA or SOW; duplicate invoice indicates the same charge was billed twice; worker eligibility indicates the worker did not meet client-specified credential or compliance requirements. [ENUM-REF-CANDIDATE: rate_discrepancy|hours_mismatch|unauthorized_charge|duplicate_invoice|worker_eligibility|other — promote to reference product]. Valid values are `rate_discrepancy|hours_mismatch|unauthorized_charge|duplicate_invoice|worker_eligibility|other`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'The gross dollar amount the client is contesting on the invoice or invoice line. Represents the full value under dispute before any partial credit or adjustment is determined. Used in accounts receivable aging and collections hold logic.',
    `disputed_hours` DECIMAL(18,2) COMMENT 'The number of hours the client is contesting as incorrectly billed. Captured specifically for hours_mismatch dispute types to enable reconciliation against approved timesheet records in Kronos Workforce Ready.',
    `escalation_date` DATE COMMENT 'The date on which the dispute was escalated to a higher resolution tier. Null when escalation_flag is False. Used to measure escalation response time and SLA compliance at the escalated tier.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the dispute has been formally escalated to senior management or a specialized resolution team due to complexity, high value, or SLA breach. True when escalated; False when being handled at standard tier.',
    `invoice_period_end` DATE COMMENT 'End date of the billing period covered by the disputed invoice. Used alongside invoice_period_start to define the exact work period under dispute for timesheet reconciliation and billing audit purposes.',
    `invoice_period_start` DATE COMMENT 'Start date of the billing period covered by the disputed invoice. Provides temporal context for the dispute, enabling correlation with timesheet records, placement assignments, and pay period data.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the dispute record was most recently modified, including status changes, amount adjustments, or resolution updates. Supports audit trail and change tracking requirements.',
    `open_date` DATE COMMENT 'The calendar date on which the client formally raised the billing dispute. Used as the start point for SLA measurement, aging calculations, and dispute-to-resolution cycle time reporting.',
    `priority` STRING COMMENT 'Business priority level assigned to the dispute, typically based on disputed amount, client tier, or SLA requirements. Drives resolution queue ordering and escalation thresholds within the billing operations workflow.. Valid values are `low|medium|high|critical`',
    `received_timestamp` TIMESTAMP COMMENT 'Precise date and time when the dispute was first captured in the system of record. Serves as the RECORD_AUDIT_CREATED anchor for SLA tracking and audit trail purposes.',
    `resolution_date` DATE COMMENT 'The calendar date on which the dispute was formally resolved and closed. Used to calculate dispute cycle time (open_date to resolution_date) and to measure SLA compliance for dispute resolution.',
    `resolution_notes` STRING COMMENT 'Free-text notes documenting the investigation findings, resolution rationale, and any client communication outcomes. Captured by the resolution owner upon closing the dispute. Supports audit trail and process improvement analysis.',
    `resolution_type` STRING COMMENT 'The outcome category of the dispute resolution. Credit issued means a credit memo was generated; invoice adjusted means the original invoice was corrected; dispute rejected means the client claim was denied; partial credit means a portion of the disputed amount was credited; write_off means the amount was written off to bad debt.. Valid values are `credit_issued|invoice_adjusted|dispute_rejected|partial_credit|write_off`',
    `root_cause_category` STRING COMMENT 'Categorization of the underlying cause of the billing dispute after investigation. Used for process improvement analytics, identifying systemic billing errors, and reducing future dispute rates. Billing error indicates internal invoicing mistake; timesheet error indicates incorrect hours submitted; rate setup error indicates incorrect bill rate configured in the system; worker compliance indicates the worker did not meet eligibility requirements; system error indicates a technical processing failure; client error indicates the dispute was raised in error by the client.. Valid values are `billing_error|timesheet_error|rate_setup_error|worker_compliance|system_error|client_error`',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the dispute resolution exceeded the sla_target_days threshold. True when the dispute remained unresolved beyond the SLA target; False when resolved within the target. Drives SLA compliance reporting and client relationship management alerts.',
    `sla_target_days` STRING COMMENT 'The contractually or operationally defined target number of calendar days within which the dispute must be resolved, per the client SLA or internal KPI standard. Used to calculate SLA compliance and flag at-risk disputes.',
    `vms_dispute_reference` STRING COMMENT 'The dispute or case reference number assigned by the clients Vendor Management System (VMS) such as Beeline, when the dispute was initiated through a VMS program. Enables cross-system reconciliation between the staffing firms billing system and the clients VMS.',
    `worker_name` STRING COMMENT 'Full name of the temporary or contract worker whose assignment is the subject of the billing dispute. Captured for worker_eligibility and hours_mismatch dispute types to enable direct investigation of the specific workers timesheet and credentialing records.',
    CONSTRAINT pk_billing_dispute PRIMARY KEY(`billing_dispute_id`)
) COMMENT 'Operational record tracking client billing disputes raised against invoices or invoice lines. Captures dispute number, dispute open date, dispute type (rate discrepancy, hours mismatch, unauthorized charge, duplicate invoice, worker eligibility), disputed amount, client contact, assigned resolution owner, dispute status (open, under review, resolved, escalated, closed), resolution date, resolution type (credit issued, invoice adjusted, dispute rejected), and root cause category. Drives the dispute-to-resolution workflow and feeds collections hold logic.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`collection_activity` (
    `collection_activity_id` BIGINT COMMENT 'Unique identifier for the collection activity record. Primary key.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Collection activities tracked by period for AR aging reports and collector performance metrics.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: Collection activities logged against AR accounts for DSO tracking, dunning level management, and collector performance reporting.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account for which collection activity is being performed. Enables account-level collections tracking.',
    `client_contact_id` BIGINT COMMENT 'Reference to the specific client contact person reached during the collection activity. Tracks which decision-maker or accounts payable contact was engaged.',
    `created_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who created this collection activity record. Audit trail for accountability and data governance.',
    `credit_memo_id` BIGINT COMMENT 'Reference to the credit memo issued as a result of this collection activity, if applicable. Links collection outcome to financial adjustment.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice associated with this collection activity. Links to the primary invoice being pursued for payment.',
    `modified_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who last modified this collection activity record. Audit trail for accountability and data governance.',
    `payment_plan_id` BIGINT COMMENT 'Reference to the payment plan established during this collection activity, if applicable. Links to structured payment arrangement details.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the employee or user who performed the collection activity. Enables performance tracking and workload distribution analysis.',
    `activity_date` DATE COMMENT 'The date on which the collection activity was performed. Used for tracking collections timeline and aging analysis.',
    `activity_type` STRING COMMENT 'The type of collection action taken. Categorizes the nature of the collection effort for workflow management and effectiveness analysis.. Valid values are `phone_call|email|demand_letter|escalation|legal_referral|payment_plan_setup`',
    `aging_bucket` STRING COMMENT 'The accounts receivable aging category of the invoice at the time of the collection activity. Used for prioritization and DSO analysis.. Valid values are `current|1_30_days|31_60_days|61_90_days|over_90_days`',
    `collection_activity_status` STRING COMMENT 'The current status of the collection activity record. Tracks whether the activity is complete or requires further action.. Valid values are `open|completed|cancelled|pending_follow_up`',
    `contact_email_address` STRING COMMENT 'The email address used to reach the client contact during this activity, if applicable. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_method` STRING COMMENT 'The communication channel used for the collection activity. Distinct from activity_type; tracks the medium of contact for effectiveness analysis.. Valid values are `phone|email|mail|fax|in_person|portal`',
    `contact_phone_number` STRING COMMENT 'The phone number used to reach the client contact during this activity, if applicable. Organizational contact data classified as confidential.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this collection activity record was first created in the system. Audit trail for record creation.',
    `credit_memo_issued_flag` BOOLEAN COMMENT 'Indicates whether a credit memo was issued as a result of this collection activity, typically due to a validated dispute. Impacts revenue recognition and accounts receivable.',
    `dispute_reason` STRING COMMENT 'The reason provided by the client for disputing the invoice, if a dispute was raised. Enables dispute categorization and root cause analysis for billing quality improvement.',
    `duration_minutes` STRING COMMENT 'The duration of the collection activity in minutes, particularly for phone calls or in-person meetings. Used for resource allocation and efficiency analysis.',
    `escalation_level` STRING COMMENT 'The escalation tier to which the collection activity has been elevated. Tracks progression through collections workflow from initial contact through legal action or write-off recommendation.. Valid values are `level_1|level_2|level_3|legal|write_off`',
    `follow_up_date` DATE COMMENT 'The scheduled date for the next collection action or follow-up. Drives collections workflow and ensures timely pursuit of outstanding receivables.',
    `legal_action_flag` BOOLEAN COMMENT 'Indicates whether this activity involved or resulted in legal action or referral to legal counsel. Critical for compliance and risk management tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this collection activity record was last modified. Audit trail for record updates.',
    `notes` STRING COMMENT 'Free-text notes documenting the details of the collection activity, including conversation summary, client responses, objections raised, and any commitments made. Provides audit trail and context for future actions.',
    `outcome` STRING COMMENT 'The result of the collection activity. Drives next-action workflow and measures collection effectiveness. Critical for Days Sales Outstanding (DSO) reduction tracking.. Valid values are `promise_to_pay|dispute_raised|payment_received|no_response|escalated|payment_plan_agreed`',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'The total amount outstanding on the invoice at the time of the collection activity. Provides context for collection priority and effort allocation.',
    `payment_received_amount` DECIMAL(18,2) COMMENT 'The dollar amount of payment received as a direct result of this collection activity, if applicable. Links collection effort to revenue realization.',
    `payment_received_date` DATE COMMENT 'The date payment was received as a result of this collection activity, if applicable. Used for measuring time-to-payment and collection effectiveness.',
    `promise_to_pay_amount` DECIMAL(18,2) COMMENT 'The dollar amount the client committed to pay, if a promise to pay was obtained. May be partial or full invoice amount.',
    `promise_to_pay_date` DATE COMMENT 'The date the client committed to making payment, if a promise to pay was obtained. Used for follow-up scheduling and commitment tracking.',
    `write_off_reason` STRING COMMENT 'The business justification for recommending write-off, if applicable. Supports bad debt analysis and collections process improvement.',
    `write_off_recommended_flag` BOOLEAN COMMENT 'Indicates whether the collector recommended writing off the outstanding balance as uncollectible. Triggers approval workflow and financial reporting.',
    CONSTRAINT pk_collection_activity PRIMARY KEY(`collection_activity_id`)
) COMMENT 'Operational record of collections actions taken against past-due client billing accounts. Captures activity date, type (phone call, email, demand letter, escalation, legal referral, payment plan setup, write-off recommendation), collector, client contact, outcome (promise to pay, dispute raised, payment received, no response, escalated, payment plan agreed), follow-up date, notes, and associated invoice references. Drives the collections workflow, DSO reduction efforts, and aging bucket management.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`spread_record` (
    `spread_record_id` BIGINT COMMENT 'Unique identifier for the spread record. Primary key for the spread transaction.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Spread calculations posted to periods for gross margin reporting and period close reconciliation.',
    `assignment_id` BIGINT COMMENT 'Reference to the worker assignment for which this spread is calculated.',
    `bill_rate_id` BIGINT COMMENT 'Foreign key linking to billing.bill_rate. Business justification: Spread records calculate the difference between bill rate and pay rate for margin analysis. Each spread_record should reference the specific bill_rate master record used for the calculation. The sprea',
    `client_account_id` BIGINT COMMENT 'Reference to the client being billed for this assignment.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Spread/margin calculations post to GL accounts for gross margin reporting. Essential for profitability analysis and financial statements.',
    `invoice_id` BIGINT COMMENT 'Reference to the client invoice that includes this spread record as a line item.',
    `job_category_id` BIGINT COMMENT 'Foreign key linking to joborder.job_category. Business justification: Margin analysis by job category identifies high-margin vs. low-margin skill verticals. Drives recruiting resource allocation, pricing strategy adjustments, and vertical market focus decisions—fundamen',
    `order_header_id` BIGINT COMMENT 'Reference to the job order (requisition) associated with this billable assignment.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the recruiter responsible for this placement. Used for commission calculations based on gross margin.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate/worker performing the billable work.',
    `sow_engagement_id` BIGINT COMMENT 'Foreign key linking to placement.sow_engagement. Business justification: SOW engagements with hourly billing track bill/pay spread for margin analysis. Spread records calculate gross margin on SOW hourly work. Essential for SOW profitability reporting, margin variance anal',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Spread/margin records must track supplier to calculate supplier-specific profitability, support supplier scorecarding with financial metrics, enable accurate commission calculations for supplier-sourc',
    `tertiary_spread_approved_by_user_staff_profile_id` BIGINT COMMENT 'Reference to the user who approved this spread record for billing and revenue recognition.',
    `timesheet_id` BIGINT COMMENT 'Reference to the approved timesheet that serves as the source document for billable units.',
    `worker_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.worker_classification. Business justification: Spread/markup calculations differ by worker classification type (IC spread vs W2 burden and markup). Financial reporting and margin analysis require classification context. Standard practice for accur',
    `approval_status` STRING COMMENT 'Current approval status of the spread record. Must be approved before revenue recognition and commission calculation.. Valid values are `pending|approved|rejected|under-review`',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this spread record was approved.',
    `billable_units` DECIMAL(18,2) COMMENT 'The quantity of billable units (hours, days, or other unit of measure) worked during the billing period. Sourced from approved timesheets.',
    `billing_model` STRING COMMENT 'The billing arrangement type for this assignment. Determines how revenue is recognized and invoiced.. Valid values are `time-and-materials|per-diem|project-based|SOW-based|direct-placement-fee|retainer`',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period for which this spread is calculated.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period for which this spread is calculated.',
    `burden_rate` DECIMAL(18,2) COMMENT 'The per-unit cost of employer taxes, benefits, workers compensation, and other statutory costs associated with the worker. Includes FICA, FUTA, SUTA, workers comp premiums.',
    `burdened_cost` DECIMAL(18,2) COMMENT 'Total cost per unit including pay rate plus burden rate. Represents the true all-in cost to employ the worker.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when this spread record was calculated and created in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this spread record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `double_time_flag` BOOLEAN COMMENT 'Indicates whether this spread record includes double-time hours subject to premium pay rates per state or contract requirements.',
    `gross_margin_amount` DECIMAL(18,2) COMMENT 'Net profit per unit after deducting burdened cost from bill rate. Calculated as bill_rate minus burdened_cost.',
    `gross_margin_percentage` DECIMAL(18,2) COMMENT 'Gross margin expressed as a percentage of bill rate. Calculated as (gross_margin_amount / bill_rate) * 100. Key profitability KPI.',
    `is_commission_eligible` BOOLEAN COMMENT 'Indicates whether this spread record is eligible for recruiter and account manager commission calculations.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied to the pay rate to arrive at the bill rate. Calculated as ((bill_rate - pay_rate) / pay_rate) * 100.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this spread record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this spread calculation, including adjustments, exceptions, or special billing arrangements.',
    `overtime_flag` BOOLEAN COMMENT 'Indicates whether this spread record includes overtime hours subject to premium pay rates per FLSA regulations.',
    `revenue_recognition_date` DATE COMMENT 'The date on which revenue for this spread record is recognized in the general ledger per accounting standards.',
    `spread_amount` DECIMAL(18,2) COMMENT 'The calculated difference between bill rate and pay rate (bill rate minus pay rate). Represents gross profit per unit before burden costs.',
    `total_bill_amount` DECIMAL(18,2) COMMENT 'Total amount billed to the client for this period. Calculated as bill_rate multiplied by billable_units.',
    `total_gross_margin_amount` DECIMAL(18,2) COMMENT 'Total gross margin for the billing period after burden costs. Calculated as gross_margin_amount multiplied by billable_units.',
    `total_pay_amount` DECIMAL(18,2) COMMENT 'Total amount paid to the worker for this period before burden. Calculated as pay_rate multiplied by billable_units.',
    `total_spread_amount` DECIMAL(18,2) COMMENT 'Total spread for the billing period. Calculated as spread_amount multiplied by billable_units, or total_bill_amount minus total_pay_amount.',
    `unit_of_measure` STRING COMMENT 'The unit by which billable work is measured and billed (hourly, daily, weekly, monthly, project-based, or per-unit).. Valid values are `hour|day|week|month|project|unit`',
    CONSTRAINT pk_spread_record PRIMARY KEY(`spread_record_id`)
) COMMENT 'Transactional record capturing the calculated spread (bill rate minus pay rate) and gross margin for each billable worker-assignment-period combination. Stores bill rate, pay rate, spread amount, markup percentage, burden rate, burdened cost, gross margin amount and percentage, billing period, assignment and job order references, client reference, and worker classification (W-2, 1099, corp-to-corp). SSOT for staffing profitability analytics at the transaction level. Supports real-time margin monitoring, client profitability reporting, and recruiter commission calculations.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`billing_account` (
    `billing_account_id` BIGINT COMMENT 'Unique surrogate identifier for the billing account record in the Staffing Hr data lakehouse. Primary key for the billing_account product.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: Billing accounts map to AR accounts for financial reporting. Fundamental structure linking operational billing to financial AR management.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Billing accounts belong to legal entities for consolidated reporting, tax compliance, and intercompany eliminations.',
    `account_name` STRING COMMENT 'Legal or trade name of the client entity to which invoices are issued. Reflects the billing entity name as it appears on invoices and AR records. May differ from the CRM client profile name if the billing entity is a subsidiary or parent.',
    `account_number` STRING COMMENT 'Externally-known, human-readable billing account number assigned to the clients financial billing entity. Used on invoices, statements, and AR correspondence. Sourced from Salesforce Revenue Cloud or Oracle NetSuite ERP customer record.. Valid values are `^BA-[0-9]{8}$`',
    `account_status` STRING COMMENT 'Current lifecycle state of the billing account. Controls whether new invoices can be generated and whether payments are being accepted. on_hold indicates a credit or collections hold. suspended indicates a temporary freeze pending resolution.. Valid values are `active|inactive|suspended|on_hold|pending_approval|closed`',
    `account_type` STRING COMMENT 'Classification of the billing account by the nature of the client engagement model. Drives billing rules, markup structures, and invoice formats. [ENUM-REF-CANDIDATE: direct_client|msp_program|vms_program|peo_client|eor_client|rpo_client — promote to reference product]. Valid values are `direct_client|msp_program|vms_program|peo_client|eor_client|rpo_client`',
    `ar_contact_email` STRING COMMENT 'Email address of the primary Accounts Receivable (AR) contact at the client. Used for invoice delivery (when method is email), payment reminders, and collections correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `ar_contact_name` STRING COMMENT 'Full name of the primary Accounts Receivable (AR) contact at the client organization. This is the individual responsible for processing invoices and remitting payments on behalf of the billing account.',
    `ar_contact_phone` STRING COMMENT 'Direct phone number of the primary Accounts Receivable (AR) contact at the client. Used for collections calls, payment dispute resolution, and urgent billing communications.. Valid values are `^+?[0-9-s().]{7,20}$`',
    `billing_address_line1` STRING COMMENT 'Primary street address line of the billing entity. Used on invoice headers, statements, and AR correspondence. Must match the legal billing address on the Master Service Agreement (MSA).',
    `billing_address_line2` STRING COMMENT 'Secondary address line for the billing entity (suite, floor, department, PO Box). Supplementary to billing_address_line1 for complete invoice address formatting.',
    `billing_city` STRING COMMENT 'City of the billing entitys legal billing address. Used on invoice headers and for state/local tax jurisdiction determination.',
    `billing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code of the billing entitys legal billing address (e.g., USA, CAN, GBR). Determines currency, tax regime, and regulatory compliance requirements including GDPR for international clients.. Valid values are `^[A-Z]{3}$`',
    `billing_cycle` STRING COMMENT 'Frequency at which invoices are generated and issued to this billing account. Aligns with the timesheet submission and payroll cycle cadence. Weekly is most common for temporary staffing; monthly for SOW and project-based engagements.. Valid values are `weekly|bi_weekly|semi_monthly|monthly`',
    `billing_model` STRING COMMENT 'Primary billing model applied to this account. Determines how invoices are calculated and structured. time_and_materials is standard for temporary staffing (hourly bill rate × hours). sow_based applies to Statement of Work (SOW) engagements. direct_placement_fee applies to permanent placement.. Valid values are `time_and_materials|per_diem|project_based|sow_based|direct_placement_fee`',
    `billing_postal_code` STRING COMMENT 'ZIP or postal code of the billing entitys legal billing address. Used for tax jurisdiction lookup and invoice address formatting.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `billing_state` STRING COMMENT 'Two-letter US state or territory code of the billing entitys legal billing address. Drives state tax applicability, SUTA jurisdiction, and invoice compliance requirements.. Valid values are `^[A-Z]{2}$`',
    `consolidated_invoicing` BOOLEAN COMMENT 'Indicates whether multiple job orders or work locations should be consolidated into a single invoice per billing cycle, rather than generating separate invoices per placement or location. Common for enterprise MSP clients.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing account record was first created in the system. Represents the audit trail creation event. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum outstanding AR balance (in account currency) that Staffing Hr will extend to this billing account before requiring payment or placing the account on hold. Enforced during invoice generation and placement approval workflows.',
    `credit_status` STRING COMMENT 'Current credit standing of the billing account as assessed by the AR/credit team. Determines whether new placements and invoices can be extended to this client. probationary indicates reduced credit terms are in effect.. Valid values are `approved|under_review|probationary|suspended|denied`',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which invoices are denominated and payments are received for this billing account (e.g., USD, CAD, GBP). Drives multi-currency AR processing and FX conversion in Oracle NetSuite ERP.. Valid values are `^[A-Z]{3}$`',
    `early_payment_discount_days` STRING COMMENT 'Number of days from invoice date within which the client must pay to qualify for the early payment discount percentage. For example, 10 in a 2/10 Net 30 arrangement. Null if no early payment discount applies.',
    `early_payment_discount_pct` DECIMAL(18,2) COMMENT 'Percentage discount offered to the client if payment is received within the early payment discount window (e.g., 0.0200 = 2% discount). Supports 2/10 Net 30 and similar early payment incentive structures common in staffing billing.',
    `effective_date` DATE COMMENT 'Date on which the billing account became active and eligible to receive invoices. Marks the start of the billing relationship with this client entity. Used for AR aging calculations and contract alignment.',
    `external_customer_code` STRING COMMENT 'The clients own internal account or vendor number assigned to Staffing Hr within the clients ERP or VMS system (e.g., Beeline VMS supplier ID, client SAP vendor number). Used for cross-system reconciliation and remittance matching.',
    `gl_account_code` STRING COMMENT 'Oracle NetSuite ERP General Ledger (GL) account code to which AR transactions for this billing account are posted. Ensures correct revenue and receivables classification in the financial statements.',
    `invoice_delivery_method` STRING COMMENT 'Preferred method by which invoices are delivered to the clients AR department. vms_portal indicates delivery through the clients Vendor Management System (VMS) such as Beeline. edi indicates Electronic Data Interchange transmission.. Valid values are `email|vms_portal|edi|mail|client_portal`',
    `invoice_format` STRING COMMENT 'Format template used when generating invoices for this billing account. detailed includes line-level timesheet and worker detail. summary provides consolidated totals only. custom indicates a client-specific format defined in the MSA.. Valid values are `standard|detailed|summary|custom`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the billing account record. Used for change data capture (CDC), data lineage tracking, and audit compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `late_fee_pct` DECIMAL(18,2) COMMENT 'Monthly percentage fee applied to overdue invoice balances beyond the payment terms net days. For example, 0.0150 = 1.5% per month. Defined in the Master Service Agreement (MSA). Null if no late fee applies.',
    `msa_reference_number` STRING COMMENT 'Reference number of the executed Master Service Agreement (MSA) governing the billing relationship with this account. Links the billing account to the contractual terms managed in DocuSign CLM. Used for audit and compliance validation.',
    `netsuite_customer_code` STRING COMMENT 'Oracle NetSuite ERP internal customer record identifier for this billing account. Used for GL posting, AR sub-ledger reconciliation, and revenue recognition alignment between the billing domain and the ERP general ledger.',
    `payment_terms_net_days` STRING COMMENT 'Number of calendar days from invoice date within which the client is contractually obligated to remit payment (e.g., Net 30, Net 45, Net 60). Drives AR aging buckets, dunning schedules, and cash flow forecasting.',
    `preferred_payment_method` STRING COMMENT 'Clients preferred method for remitting payment against invoices. ach (Automated Clearing House) is most common for enterprise staffing clients. vms_payment indicates payment processed through the clients VMS platform.. Valid values are `ach|wire_transfer|check|credit_card|vms_payment`',
    `purchase_order_required` BOOLEAN COMMENT 'Indicates whether a valid Purchase Order (PO) number must be present on all invoices issued to this billing account. When True, invoices without a PO number will be rejected by the clients AP department.',
    `salesforce_account_code` STRING COMMENT 'Salesforce Revenue Cloud account record identifier linked to this billing account. Enables traceability between the billing domain SSOT and the upstream CRM/revenue system for invoice generation and client financial management.',
    `tax_exempt` BOOLEAN COMMENT 'Indicates whether the billing account holds a valid tax exemption certificate, meaning sales tax or applicable taxes should not be applied to invoices. When True, tax_exempt_certificate_number must be populated.',
    `tax_exempt_certificate_number` STRING COMMENT 'Certificate number of the clients tax exemption documentation. Required when tax_exempt is True. Used to substantiate tax-exempt invoice treatment during audits and state tax authority reviews.',
    `tax_identifier` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax Identification Number (TIN) of the billing entity. Required for IRS 1099 reporting, tax exemption validation, and invoice compliance. Format: XX-XXXXXXX (EIN format).. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `termination_date` DATE COMMENT 'Date on which the billing account was closed or terminated. Null for active accounts. Once set, no new invoices should be generated against this account. Supports AR close-out and final billing reconciliation.',
    `vms_billing_enabled` BOOLEAN COMMENT 'Indicates whether this billing account is managed through a clients Vendor Management System (VMS) such as Beeline, requiring invoice submission and payment processing through the VMS portal rather than direct billing.',
    `vms_program_name` STRING COMMENT 'Name of the VMS program through which this billing account is managed (e.g., Beeline - Acme Corp MSP Program). Populated only when vms_billing_enabled is True. Used for VMS fee calculation and program-level reporting.',
    CONSTRAINT pk_billing_account PRIMARY KEY(`billing_account_id`)
) COMMENT 'Master record representing a clients financial billing entity — the account to which invoices are issued and against which payments and credits are tracked. Distinct from the CRM client profile (owned by client domain). Captures billing account number, billing address, AR contact, payment terms (net days, early payment discount percentage, discount window), credit limit, credit status, preferred payment method, tax ID, tax exemption status, invoice delivery method, currency, billing cycle (weekly, bi-weekly, monthly), and external customer account identifier. SSOT for client billing identity and payment terms within the billing domain.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`placement_fee` (
    `placement_fee_id` BIGINT COMMENT 'Unique surrogate identifier for the placement fee record. Primary key for the billing.placement_fee data product. TRANSACTION_HEADER role — represents a discrete direct placement or permanent hire fee billing event with its own lifecycle.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Placement fees recognized in specific accounting periods for revenue recognition and financial statement preparation.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: Placement fees are receivables tracked in AR accounts. Required for revenue recognition, aging analysis, and collection management.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account that is being billed for the direct placement or permanent hire fee. The primary counterparty (PARTY_REFERENCE) for this billing transaction. Sourced from Bullhorn ATS/CRM client record.',
    `msa_id` BIGINT COMMENT 'Foreign key linking to contract.msa. Business justification: Direct placement fees governed by MSA conversion fee percentages and guarantee periods. Essential for fee calculation, guarantee tracking, and MSA compliance in perm placement billing.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Placement fees tied to SOW headcount commitments and project staffing targets. Required for SOW fulfillment tracking, fee calculation against SOW terms, and project-based perm placement billing.',
    `conversion_id` BIGINT COMMENT 'Foreign key linking to placement.conversion. Business justification: Temp-to-perm conversions generate conversion fees (contractual fee when temp converts to permanent). Placement_fee tracks conversion fee invoicing, payment terms, and guarantee periods. Essential for ',
    `direct_hire_id` BIGINT COMMENT 'Foreign key linking to placement.direct_hire. Business justification: Direct hire placements generate placement fees (core revenue for perm placement business). Placement_fee tracks fee invoicing, payment, guarantee period, and fall-off credits. Essential for direct hir',
    `hiring_decision_id` BIGINT COMMENT 'Foreign key linking to recruitment.hiring_decision. Business justification: Direct placement fees are triggered by hiring decisions (offer accepted). Links fee calculation, guarantee period tracking, and revenue recognition to the specific hiring event. No existing column fit',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice record in the billing system under which this placement fee was billed to the client. Supports accounts receivable reconciliation.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Placement fees earned by specific legal entities for revenue recognition and consolidated reporting.',
    `onboarding_engagement_id` BIGINT COMMENT 'Foreign key linking to onboarding.onboarding_engagement. Business justification: Direct placement fees are contingent on successful onboarding through guarantee period. Critical for revenue recognition (cant recognize until onboarding complete), guarantee tracking (fall-off durin',
    `order_header_id` BIGINT COMMENT 'Reference to the job order (requisition) that originated the placement for which this fee is being billed. Links fee revenue to the originating client requirement.',
    `assignment_id` BIGINT COMMENT 'Reference to the replacement placement record created when a fall-off occurs and the client exercises their guarantee replacement right. Links the original fee record to the replacement placement for tracking and reporting.',
    `profile_id` BIGINT COMMENT 'Reference to the candidate who was placed in the direct hire or permanent position for which this fee is being charged. Links to the candidate profile in the ATS.',
    `recruiter_assignment_id` BIGINT COMMENT 'Foreign key linking to recruitment.recruiter_assignment. Business justification: Placement fees must reference recruiter assignments to calculate split fees, determine commission eligibility, and track recruiter performance. Essential for commission payout and split fee allocation',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal recruiter or account manager responsible for the placement that generated this fee. Used for commission calculation, recruiter performance reporting, and fall-off rate attribution.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Direct placement fees are often paid to recruiting suppliers/agencies; tracking supplier enables fee reconciliation, supplier ROI analysis, accounts payable matching, and evaluation of supplier effect',
    `worker_classification_id` BIGINT COMMENT 'Foreign key linking to compliance.worker_classification. Business justification: Placement fee structure and eligibility depend on worker classification (direct hire fees vs contract-to-hire, W2 conversion fees). Fee calculation logic and guarantee terms require classification dat',
    `candidate_annual_salary` DECIMAL(18,2) COMMENT 'The candidates agreed first-year annual base salary for the placed position, used as the basis for percentage-based fee calculations. Expressed in the billing currency. Sourced from the placement record in Bullhorn ATS/CRM.',
    `cost_center_code` STRING COMMENT 'The organizational cost center or profit center code to which this placement fee revenue is attributed. Supports divisional P&L reporting and recruiter/branch performance analytics in Oracle NetSuite ERP and Power BI.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the placement fee record was first created in the system. Audit trail field sourced from Salesforce Revenue Cloud or Oracle NetSuite ERP record creation event.',
    `credit_memo_amount` DECIMAL(18,2) COMMENT 'The monetary value of the credit memo issued to the client, representing the fee amount credited back due to a fall-off within the guarantee period or a billing dispute resolution. Expressed as a positive value; applied as a reduction to the clients AR balance.',
    `credit_memo_number` STRING COMMENT 'The reference number of any credit memo issued to the client as a result of a fall-off, fee dispute, or negotiated adjustment. Sourced from Salesforce Revenue Cloud or Oracle NetSuite ERP. Null if no credit memo was issued.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this placement fee record (e.g., USD, CAD, GBP). Supports multi-currency billing for international staffing operations.. Valid values are `^[A-Z]{3}$`',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason the client disputed the placement fee invoice. Captured during dispute intake in Salesforce Revenue Cloud. Used for dispute pattern analysis and client relationship management.',
    `dispute_status` STRING COMMENT 'Current status of any billing dispute raised by the client against this placement fee invoice. Tracks the dispute lifecycle from initial client challenge through resolution. Drives collections hold and escalation workflows.. Valid values are `none|open|under_review|resolved|escalated`',
    `fall_off_date` DATE COMMENT 'The date on which the placed candidate left or was terminated from the clients position within the guarantee period, triggering a fall-off event. Null if no fall-off occurred. A fall-off within the guarantee period may require fee reversal, credit memo issuance, or replacement candidate sourcing.',
    `fall_off_reason` STRING COMMENT 'The reason code explaining why the placed candidate left the position within the guarantee period. Used for fall-off rate analytics, recruiter performance tracking, and quality-of-submission (QoS) reporting. Null if no fall-off occurred.. Valid values are `candidate_resigned|client_terminated|performance|role_eliminated|personal_reasons|other`',
    `fee_adjustment_amount` DECIMAL(18,2) COMMENT 'Any negotiated discount, credit memo, or adjustment applied to the gross fee amount. Negative values represent discounts or credits. Supports scenarios such as volume discounts, client concessions, or partial credit for guarantee period replacements.',
    `fee_amount` DECIMAL(18,2) COMMENT 'The gross calculated placement fee amount billed to the client before any adjustments, credits, or discounts. For percentage-based fees, this equals candidate_annual_salary multiplied by fee_percentage. For flat fees, this is the agreed fixed amount. Primary revenue figure for direct placement billing.',
    `fee_basis` STRING COMMENT 'Indicates whether the placement fee is calculated as a percentage of the candidates first-year annual salary, a flat fixed fee amount, or a hybrid of both. Drives fee calculation logic in Salesforce Revenue Cloud.. Valid values are `percentage_of_salary|flat_fee|hybrid`',
    `fee_date` DATE COMMENT 'The principal real-world business event date on which the placement fee was earned, typically aligned to the candidates confirmed start date or the date the direct placement was finalized and accepted by the client. Used as the revenue recognition date.',
    `fee_number` STRING COMMENT 'Externally-known business identifier for the placement fee transaction, used in client communications, invoices, and reconciliation. Format: PF-{YYYY}-{NNNNNN}. Sourced from Salesforce Revenue Cloud opportunity/order object.. Valid values are `^PF-[0-9]{4}-[0-9]{6}$`',
    `fee_percentage` DECIMAL(18,2) COMMENT 'The agreed-upon percentage of the candidates first-year annual salary used to calculate the placement fee when fee_basis is percentage_of_salary or hybrid. Typically ranges from 15% to 30% for direct placement. Stored as a decimal (e.g., 20.00 = 20%). Sourced from the client rate card or MSA.',
    `fee_type` STRING COMMENT 'Classification of the placement fee by the nature of the engagement model. Direct Placement: one-time fee for permanent hire. Temp-to-Perm: conversion fee when a temporary worker converts to permanent. RPO Fee: fee under a Recruitment Process Outsourcing (RPO) engagement. Retained Search: upfront retainer-based executive search fee. Contingency Search: fee paid only upon successful placement.. Valid values are `direct_placement|temp_to_perm|rpo_fee|retained_search|contingency_search`',
    `gl_account_code` STRING COMMENT 'The General Ledger (GL) account code in Oracle NetSuite ERP to which this placement fee revenue is posted. Used for financial reporting, revenue categorization by fee type, and P&L attribution.',
    `guarantee_end_date` DATE COMMENT 'The calculated date on which the guarantee period expires, derived from the candidates start date plus guarantee_period_days. After this date, the placement fee is fully earned with no replacement obligation. Used for fall-off risk monitoring and revenue recognition.',
    `guarantee_period_days` STRING COMMENT 'The number of days from the candidates start date during which the staffing firm guarantees the placement. If the candidate leaves or is terminated within this window (fall-off), the client is entitled to a replacement or fee credit. Industry standard ranges from 30 to 90 days. Critical to direct hire operations and fall-off risk management.',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'The net amount actually invoiced to the client after applying any adjustments (fee_amount + fee_adjustment_amount). This is the amount reflected on the client invoice and tracked in accounts receivable. Supports revenue recognition and AR aging reporting.',
    `is_fall_off` BOOLEAN COMMENT 'Boolean flag indicating whether this placement experienced a fall-off event within the guarantee period. True when fall_off_date is populated and falls within the guarantee window. Drives fall-off rate KPI calculations and revenue reversal workflows.',
    `paid_amount` DECIMAL(18,2) COMMENT 'The total amount received from the client against this placement fee invoice. May be less than invoiced_amount if partially paid or disputed. Used for AR reconciliation and cash application in Oracle NetSuite ERP.',
    `payment_due_date` DATE COMMENT 'The contractual date by which the client must remit payment for the placement fee invoice, calculated from invoice_date based on the agreed payment terms (e.g., Net 30, Net 45). Drives collections and overdue status transitions.',
    `payment_received_date` DATE COMMENT 'The date on which payment was received from the client for this placement fee. Used for cash application, days-sales-outstanding (DSO) calculation, and AR aging reporting in Oracle NetSuite ERP.',
    `payment_status` STRING COMMENT 'Current lifecycle state of the placement fee billing transaction, tracking progression from fee generation through collection. Drives accounts receivable workflows and collections activity. [ENUM-REF-CANDIDATE: pending|invoiced|partially_paid|paid|overdue|disputed|written_off — promote to reference product]',
    `payment_terms` STRING COMMENT 'The agreed payment terms governing when the client must pay the placement fee invoice. Sourced from the clients Master Service Agreement (MSA) or rate card. Drives payment_due_date calculation and collections SLA.. Valid values are `net_15|net_30|net_45|net_60|due_on_receipt`',
    `replacement_eligible` BOOLEAN COMMENT 'Indicates whether the client is eligible to receive a replacement candidate at no additional fee charge following a fall-off event within the guarantee period. Determined by the terms of the clients MSA and the nature of the fall-off.',
    `revenue_recognition_date` DATE COMMENT 'The date on which the placement fee revenue is recognized in the general ledger per ASC 606 / IFRS 15 revenue recognition standards. For direct placement, typically the candidates confirmed start date or guarantee period expiry, depending on the firms accounting policy.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this placement fee record originated. Supports data lineage, reconciliation, and audit trail requirements across Bullhorn ATS/CRM, Salesforce Revenue Cloud, and Oracle NetSuite ERP.. Valid values are `bullhorn|salesforce_revenue_cloud|netsuite|manual`',
    `source_system_fee_code` STRING COMMENT 'The native identifier of this placement fee record in the originating source system (Bullhorn, Salesforce Revenue Cloud, or NetSuite). Enables bidirectional traceability between the lakehouse silver layer and operational systems for reconciliation and support.',
    `split_fee_indicator` BOOLEAN COMMENT 'Indicates whether this placement fee is shared between multiple recruiters or offices (split placement). When true, the fee revenue and commission are divided according to the split arrangement. Common in executive search and cross-office placements.',
    `split_fee_percentage` DECIMAL(18,2) COMMENT 'The percentage of the total placement fee allocated to this recruiter or office in a split placement arrangement. Applicable only when split_fee_indicator is true. Used for commission calculation and revenue attribution.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the placement fee record. Supports audit trail, change detection, and incremental data pipeline processing.',
    CONSTRAINT pk_placement_fee PRIMARY KEY(`placement_fee_id`)
) COMMENT 'Transactional record for direct placement and permanent hire fee billing. Captures fee type (direct placement, temp-to-perm conversion, RPO fee, retained search), fee amount, fee percentage of first-year salary, guarantee period (fall-off window in days), fall-off date, replacement eligibility, invoiced amount, invoice reference, payment status, and associated job order and candidate references. SSOT for permanent placement revenue, distinct from time-and-materials billing. Supports fall-off tracking and guarantee period management critical to direct hire operations.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`expense_charge` (
    `expense_charge_id` BIGINT COMMENT 'Unique system-generated identifier for each billable expense charge record in the billing domain. Primary key for the expense_charge data product. Entity role: TRANSACTION_HEADER — represents a discrete billable expense event with its own lifecycle.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Expense charges posted to accounting periods for expense recognition and period close processes.',
    `assignment_id` BIGINT COMMENT 'Reference to the worker assignment or placement under which this expense was incurred. Links the expense charge to the specific temporary or contract engagement. Satisfies PARTY_REFERENCE category for TRANSACTION_HEADER role.',
    `bgc_order_id` BIGINT COMMENT 'Foreign key linking to credentialing.bgc_order. Business justification: Background check costs are routinely passed through to clients as billable expense charges. Billing operations require linking each expense charge to the specific BGC order for accurate cost recovery,',
    `client_account_id` BIGINT COMMENT 'Reference to the client account to which this expense charge is billed. Used for accounts receivable tracking, invoice generation, and client-level expense reporting.',
    `sow_id` BIGINT COMMENT 'Foreign key linking to contract.sow. Business justification: Reimbursable expenses tied to SOW scope, budget caps, and expense policies. Critical for SOW budget tracking, expense approval workflows, and client billing validation in project-based staffing.',
    `credential_instance_id` BIGINT COMMENT 'Foreign key linking to credentialing.credential_instance. Business justification: General credential-related expenses (license verification fees, skills assessment costs, training charges, immunization records) are often billed as pass-through charges. Billing operations require li',
    `drug_screen_id` BIGINT COMMENT 'Foreign key linking to credentialing.drug_screen. Business justification: Drug screening costs are frequently billable expenses in staffing contracts. Finance teams need to link expense charges to specific drug screen orders for client billing, vendor payment reconciliation',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Expense charges post to GL accounts for P&L reporting. Essential for expense classification, departmental reporting, and financial statement preparation.',
    `invoice_line_id` BIGINT COMMENT 'Reference to the invoice line item on which this expense charge appears once billed. Null until the expense is included in a client invoice. Supports reconciliation between expense charges and billed amounts.',
    `onboarding_engagement_id` BIGINT COMMENT 'Foreign key linking to onboarding.onboarding_engagement. Business justification: Onboarding-related expenses (background checks, drug screens, orientation, equipment) are often billable to client. Direct linkage supports expense recovery, client billing transparency (itemized onbo',
    `order_header_id` BIGINT COMMENT 'Reference to the job order or requisition associated with the worker assignment for which this expense was incurred. Enables expense tracking at the requisition level for project-based and SOW engagements.',
    `per_diem_claim_id` BIGINT COMMENT 'Foreign key linking to timesheet.per_diem_claim. Business justification: Expense charges for per diem reference specific worker-submitted per diem claims. This link enables reconciliation of claimed vs billed per diem amounts, supports IRS compliance audits, validates bill',
    `sow_engagement_id` BIGINT COMMENT 'Foreign key linking to placement.sow_engagement. Business justification: SOW engagements incur billable expenses (travel, materials, equipment). Expense charges must link to specific SOW placements for client billing and project cost tracking. Essential for SOW profitabili',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: Reimbursable expenses (travel, per diem, equipment) for vendor-supplied workers must track supplier for proper client billing markup, expense policy compliance verification, supplier invoice reconcili',
    `approval_status` STRING COMMENT 'The current approval workflow state of the expense charge, distinct from the overall charge_status. Tracks whether the expense has been reviewed and authorized by the appropriate approver (client manager, internal supervisor, or VMS workflow). Required for SOX-compliant expense approval controls.. Valid values are `pending|approved|rejected|escalated`',
    `approved_by` STRING COMMENT 'Name or identifier of the individual (client manager, staffing supervisor, or VMS approver) who approved this expense charge. Supports audit trail and compliance reporting requirements.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the expense charge was approved by the designated approver. Used for SLA measurement on expense approval turnaround and audit trail compliance.',
    `billable_amount` DECIMAL(18,2) COMMENT 'The total amount charged to the client for this expense, equal to expense_amount plus markup_amount. This is the net total included on the client invoice. Part of the MONETARY_TRIPLET net total component.',
    `billing_model` STRING COMMENT 'The billing arrangement under which this expense charge is processed. Determines invoice format, markup applicability, and revenue recognition method. Aligns with the engagement type: hourly time-and-materials, per diem, project-based, SOW (Statement of Work)-based, or direct placement fee billing.. Valid values are `time_and_materials|per_diem|project_based|sow_based|direct_placement`',
    `billing_period_end` DATE COMMENT 'The end date of the billing period in which this expense charge is included for client invoicing. Together with billing_period_start, defines the invoice cycle window for revenue recognition.',
    `billing_period_start` DATE COMMENT 'The start date of the billing period in which this expense charge is included for client invoicing. Aligns expense charges to invoice cycles for time-and-materials and SOW-based engagements.',
    `charge_status` STRING COMMENT 'Current workflow state of the expense charge record. Drives approval routing, invoice inclusion eligibility, and collections processing. Satisfies LIFECYCLE_STATUS category for TRANSACTION_HEADER role.. Valid values are `pending|approved|rejected|billed|voided|disputed`',
    `client_po_number` STRING COMMENT 'The client-issued Purchase Order number authorizing this expense charge. Required for invoice processing by many enterprise clients and VMS-managed programs. Used for client-side accounts payable matching.',
    `cost_center_code` STRING COMMENT 'The client or internal cost center code to which this expense charge is allocated. Used for client-side cost allocation reporting, internal P&L tracking, and GL journal entry generation in Oracle NetSuite ERP.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this expense charge record was first created in the system. Satisfies RECORD_AUDIT_CREATED category for TRANSACTION_HEADER role. Used for aging analysis and audit trail compliance.',
    `credit_memo_reference` STRING COMMENT 'Reference number of the credit memo issued to the client if this expense charge was disputed, rejected, or reversed after billing. Links the expense charge to the corresponding credit memo in Oracle NetSuite ERP or Salesforce Revenue Cloud.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this expense charge record (e.g., USD, CAD, GBP). Required for multi-currency client engagements and international staffing operations. Part of the MONETARY_TRIPLET currency component.. Valid values are `^[A-Z]{3}$`',
    `dispute_reason` STRING COMMENT 'Description of the reason for a client or internal dispute on this expense charge. Populated when charge_status transitions to disputed. Used for dispute management, credit memo processing, and client relationship management.',
    `expense_amount` DECIMAL(18,2) COMMENT 'The gross base amount of the expense as incurred, before any markup or adjustment. Represents the raw cost passed through from the worker or vendor. Part of the MONETARY_TRIPLET for TRANSACTION_HEADER role.',
    `expense_date` DATE COMMENT 'The calendar date on which the expense was incurred by the worker or staffing operation. Used for period matching, per diem eligibility, and invoice period alignment. Satisfies BUSINESS_EVENT_TIMESTAMP category for TRANSACTION_HEADER role.',
    `expense_description` STRING COMMENT 'Free-text description of the expense charge providing additional context about the nature, purpose, or business justification of the expense. Appears on client invoices and expense reports for transparency.',
    `expense_number` STRING COMMENT 'Externally-visible, human-readable identifier for the expense charge record, used in client communications, invoice line references, and dispute management. Sourced from Salesforce Revenue Cloud or Oracle NetSuite ERP. Satisfies BUSINESS_IDENTIFIER category for TRANSACTION_HEADER role.. Valid values are `^EXP-[0-9]{4}-[0-9]{6}$`',
    `expense_type` STRING COMMENT 'Classification of the expense category incurred by the worker or staffing operation. Drives billing rules, markup applicability, and GL account mapping. Standard types include Per Diem (daily allowance), travel, lodging, mileage reimbursement, equipment, and training costs. Satisfies CLASSIFICATION_OR_TYPE category for TRANSACTION_HEADER role. [ENUM-REF-CANDIDATE: per_diem|travel|lodging|mileage|equipment|training|meals|parking|communication|relocation — promote to reference product]. Valid values are `per_diem|travel|lodging|mileage|equipment|training`',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this expense charge is eligible to be passed through and billed to the client. Non-billable expenses are absorbed by the staffing firm and excluded from client invoices. Critical for revenue recognition and invoice generation logic.',
    `is_reimbursable` BOOLEAN COMMENT 'Indicates whether the worker is entitled to reimbursement for this expense from the staffing firm, independent of whether it is billed to the client. Drives payroll reimbursement processing in TempWorks Payroll.',
    `markup_amount` DECIMAL(18,2) COMMENT 'The calculated dollar value of the markup applied to the base expense amount (expense_amount × markup_percentage / 100). Stored as a discrete field for audit and invoice line transparency. Part of the MONETARY_TRIPLET adjustment component.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'The percentage applied on top of the base expense amount to calculate the billable amount charged to the client. Represents the staffing firms margin on pass-through expenses. Part of the MONETARY_TRIPLET adjustment component.',
    `mileage_rate` DECIMAL(18,2) COMMENT 'The per-mile or per-kilometer reimbursement rate applied to mileage expense charges. May reflect the IRS standard mileage rate or a client-negotiated rate. Used to validate that expense_amount equals mileage_units × mileage_rate.',
    `mileage_units` DECIMAL(18,2) COMMENT 'Number of miles or kilometers driven for mileage-type expense charges. Used to calculate reimbursement at the applicable IRS standard mileage rate or client-negotiated rate. Applicable only when expense_type is mileage.',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'The daily allowance rate applied for per diem expense charges, representing the authorized daily amount for meals, incidentals, or lodging. May reflect GSA federal per diem rates or client-negotiated rates. Applicable when expense_type is per_diem.',
    `receipt_date` DATE COMMENT 'The date shown on the supporting receipt or expense documentation. May differ from expense_date in cases of delayed submission. Used for IRS substantiation compliance and audit purposes.',
    `receipt_reference` STRING COMMENT 'Document reference number or identifier for the supporting receipt or proof of expense. Used for audit trail, FCRA-compliant recordkeeping, and expense dispute resolution. May reference a document stored in DocuSign CLM or an external document management system.',
    `source_system` STRING COMMENT 'The operational system of record from which this expense charge record originated. Supports data lineage, reconciliation, and audit trail requirements across the billing domains multi-system architecture.. Valid values are `salesforce_revenue_cloud|netsuite_erp|beeline_vms|tempworks_payroll|manual`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the expense charge was submitted for approval by the worker or staffing coordinator. Used for aging analysis, SLA tracking, and expense cycle time reporting.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount applied to the billable expense charge based on the applicable tax code and jurisdiction. Included on client invoices where tax applies. Supports tax remittance and compliance reporting.',
    `tax_code` STRING COMMENT 'Tax jurisdiction or tax treatment code applicable to this expense charge. Determines whether sales tax, VAT, or GST applies to the billable amount based on client location and expense type. Used for tax compliance reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this expense charge record was last modified. Satisfies RECORD_AUDIT_UPDATED category for TRANSACTION_HEADER role. Used for change tracking, data lineage, and Silver layer incremental processing in Databricks.',
    `vendor_name` STRING COMMENT 'Name of the external vendor or supplier from whom the expense was incurred (e.g., hotel chain, airline, equipment supplier). Used for vendor spend analysis, preferred vendor compliance, and accounts payable matching in Oracle NetSuite ERP.',
    `worker_name` STRING COMMENT 'Full name of the worker (temporary employee, contractor, or W-2 employee) who incurred the expense. Retained on the expense record for audit trail and dispute resolution purposes. Classified as restricted PII per GDPR, CCPA, and FCRA.',
    CONSTRAINT pk_expense_charge PRIMARY KEY(`expense_charge_id`)
) COMMENT 'Transactional record of billable expenses incurred by workers or staffing operations and passed through to client invoices. Captures expense type (per diem, travel, lodging, mileage, equipment, training), date, amount, currency, receipt reference, approval status, billable flag, markup percentage, client PO reference, cost center, GL account, and associated assignment and invoice line references. Supports pass-through expense billing in project-based and SOW engagements.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` (
    `sow_billing_milestone_id` BIGINT COMMENT 'Unique surrogate identifier for each SOW billing milestone record in the Staffing Hr billing domain. Primary key for this transactional entity. Entity role: TRANSACTION_HEADER — represents a discrete billing event within a SOW engagement lifecycle.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Milestones recognized in specific periods for project-based revenue recognition and financial reporting.',
    `client_account_id` BIGINT COMMENT 'Reference to the client account being billed for this SOW milestone. Serves as the PARTY_REFERENCE for this transaction, linking the billing event to the client in the CRM. Sourced from Salesforce Revenue Cloud and Bullhorn CRM.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: SOW milestones recognize revenue to specific GL accounts. Required for project-based revenue recognition and financial reporting.',
    `invoice_id` BIGINT COMMENT 'Reference to the invoice record generated for this milestone once it has been approved and invoiced. Null until the milestone reaches invoiced status.',
    `sow_engagement_id` BIGINT COMMENT 'Foreign key linking to placement.sow_engagement. Business justification: SOW engagements are billed via milestones (deliverable-based or phase-based billing). Milestone billing links to specific SOW placements for revenue recognition and project billing. Essential for SOW ',
    `sow_id` BIGINT COMMENT 'Reference to the parent Statement of Work (SOW) engagement under which this billing milestone is defined. Links the milestone to its governing SOW contract.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to vendor.supplier. Business justification: SOW-based project billing often involves vendor-supplied project teams; tracking supplier enables milestone-based vendor payment coordination, project margin analysis by supplier, vendor performance e',
    `actual_billing_date` DATE COMMENT 'Date on which the invoice for this milestone was actually generated and sent to the client. Compared against scheduled_billing_date to measure billing timeliness and SLA adherence. Serves as the BUSINESS_EVENT_TIMESTAMP (date precision) for this transaction.',
    `adjusted_amount` DECIMAL(18,2) COMMENT 'Revised billing amount after any approved adjustments, credits, or change orders applied to the original milestone amount. Reflects the net billable value after modifications. Part of the MONETARY_TRIPLET adjustment component.',
    `approval_date` DATE COMMENT 'Date on which the milestone completion was formally approved by the designated approver, authorizing invoice generation. Distinct from completion_date as approval may follow completion after a review period.',
    `approval_status` STRING COMMENT 'Current state of the internal and/or client approval workflow for this milestone. Distinct from milestone_status as it tracks the approval sub-process specifically. Values: pending_review, approved, rejected, escalated.. Valid values are `pending_review|approved|rejected|escalated`',
    `approver_email` STRING COMMENT 'Email address of the designated approver for this milestone. Used for approval workflow notifications and audit trail. Classified as confidential PII as it identifies a specific individual.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `approver_name` STRING COMMENT 'Full name of the individual (internal manager or client contact) who approved or is designated to approve this milestone. Retained for audit trail and dispute resolution purposes.',
    `billing_model` STRING COMMENT 'Billing model applied to this milestone, indicating how charges are structured within the SOW. Supports fixed-fee, time-and-materials, per-diem, and milestone-based billing variants.. Valid values are `sow_fixed_fee|sow_time_materials|sow_per_diem|sow_milestone`',
    `client_approver_name` STRING COMMENT 'Name of the client-side contact who provided formal acceptance or approval of the milestone deliverable. Required for SOW engagements where client sign-off is a billing prerequisite.',
    `completion_date` DATE COMMENT 'Date on which the deliverable or work associated with this milestone was confirmed as complete by the delivery team. Triggers the approval and billing workflow.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of work completed for this milestone at the time of last update, expressed as a value between 0.00 and 100.00. Used for percent-complete milestone types and progress reporting to clients and project managers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SOW billing milestone record was first created in the system. Serves as the RECORD_AUDIT_CREATED field for audit trail and data lineage purposes. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credit_memo_amount` DECIMAL(18,2) COMMENT 'Dollar value of any credit memo issued against this milestone invoice, representing adjustments, concessions, or dispute resolutions. Negative value reduces the net receivable for this milestone.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts on this milestone record (e.g., USD, CAD, GBP). Supports multi-currency SOW engagements for international staffing clients. Part of the MONETARY_TRIPLET currency component.. Valid values are `^[A-Z]{3}$`',
    `dispute_date` DATE COMMENT 'Date on which the billing dispute for this milestone was formally raised. Used to track dispute aging and SLA compliance for dispute resolution.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason provided by the client or internal team when a milestone billing is placed in disputed status. Populated only when milestone_status is disputed. Supports dispute resolution and collections workflows.',
    `due_date` DATE COMMENT 'Contractual deadline by which the milestone deliverable must be completed per the SOW terms. Used for project tracking, SLA measurement, and identifying at-risk milestones.',
    `internal_notes` STRING COMMENT 'Free-text field for internal billing team notes regarding this milestone, such as special handling instructions, escalation context, or coordination notes. Not included on client-facing invoices.',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'Actual amount included on the invoice generated for this milestone. May differ from milestone_amount or adjusted_amount due to partial billing, credit memos, or dispute resolutions. Represents the net total in the MONETARY_TRIPLET.',
    `is_retainage` BOOLEAN COMMENT 'Indicates whether this milestone represents a retainage billing — a withheld portion of the SOW contract value released upon final project acceptance. Common in project-based staffing and consulting SOW engagements.',
    `milestone_amount` DECIMAL(18,2) COMMENT 'Gross contractual billing amount for this milestone as defined in the SOW. Represents the base amount to be invoiced to the client upon milestone completion and approval. Part of the MONETARY_TRIPLET for this transaction.',
    `milestone_description` STRING COMMENT 'Detailed narrative description of the deliverable, work product, or condition that must be met for this milestone to be considered complete and billable. Sourced from the SOW document and used in invoice line item descriptions.',
    `milestone_name` STRING COMMENT 'Descriptive name of the billing milestone as defined in the SOW (e.g., Phase 1 Completion, Go-Live Delivery, Final Acceptance). Used in client-facing invoices and project tracking.',
    `milestone_number` STRING COMMENT 'Externally-known business identifier for the milestone, typically formatted as MS-XXXXXXXX. Used in client communications, invoices, and SOW documentation to uniquely reference a specific billing milestone. Serves as the BUSINESS_IDENTIFIER for this transaction.. Valid values are `^MS-[0-9]{4,10}$`',
    `milestone_sequence` STRING COMMENT 'Ordinal position of this milestone within the SOW billing schedule (e.g., 1, 2, 3). Enables ordered display and sequential billing logic across all milestones in a SOW.',
    `milestone_status` STRING COMMENT 'Current lifecycle state of the billing milestone. Drives workflow routing and revenue recognition. Values: pending (not yet completed), approved (completion confirmed), invoiced (invoice generated and sent), disputed (client has raised a dispute), cancelled (milestone removed from billing schedule). Serves as the LIFECYCLE_STATUS for this transaction.. Valid values are `pending|approved|invoiced|disputed|cancelled`',
    `milestone_type` STRING COMMENT 'Classification of the billing trigger for this milestone. Determines how completion is measured and billing is initiated. Values: deliverable (specific output delivered), phase_completion (project phase finished), time_based (calendar-driven), percent_complete (percentage of work done), acceptance (client formal sign-off). [ENUM-REF-CANDIDATE: deliverable|phase_completion|time_based|percent_complete|acceptance — promote to reference product if additional types emerge]. Valid values are `deliverable|phase_completion|time_based|percent_complete|acceptance`',
    `payment_due_date` DATE COMMENT 'Calculated date by which client payment for this milestone invoice is due, derived from actual_billing_date plus payment_terms. Used for accounts receivable aging and collections management.',
    `payment_terms` STRING COMMENT 'Contractual payment terms applicable to this milestone invoice, defining the number of days the client has to remit payment after invoice date (e.g., Net30, Net45). Sourced from the MSA or SOW payment terms.. Valid values are `Net15|Net30|Net45|Net60|Due_on_receipt`',
    `po_number` STRING COMMENT 'Client-issued Purchase Order number associated with this milestone billing event. Required by many enterprise clients for invoice processing and accounts payable matching.',
    `retainage_percentage` DECIMAL(18,2) COMMENT 'Percentage of the milestone amount withheld as retainage per the SOW contract terms. Applicable only when is_retainage is True. Expressed as a value between 0.00 and 100.00.',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue for this milestone is recognized in the general ledger per ASC 606 / IFRS 15 revenue recognition standards. May differ from actual_billing_date based on performance obligation completion.',
    `scheduled_billing_date` DATE COMMENT 'Contractually planned date on which this milestone is expected to be billed to the client, as defined in the SOW billing schedule. Used for cash flow forecasting and accounts receivable planning.',
    `source_system` STRING COMMENT 'Operational system of record from which this milestone record was sourced or originated. Supports data lineage tracking in the Databricks Silver Layer lakehouse.. Valid values are `Salesforce_Revenue_Cloud|Oracle_NetSuite|DocuSign_CLM|Manual`',
    `source_system_milestone_code` STRING COMMENT 'Native identifier of this milestone record in the originating operational system (e.g., Salesforce Revenue Cloud opportunity milestone ID or NetSuite project task ID). Enables reconciliation between the lakehouse Silver Layer and source systems.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this SOW billing milestone record. Serves as the RECORD_AUDIT_UPDATED field for change tracking and audit compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_sow_billing_milestone PRIMARY KEY(`sow_billing_milestone_id`)
) COMMENT 'Transactional record tracking billing milestones for Statement of Work (SOW) engagements. Captures milestone name, milestone number, SOW reference, milestone type (deliverable, phase completion, time-based, percent-complete), scheduled billing date, actual billing date, milestone amount, completion percentage, approval status, approver, invoice reference, and milestone status (pending, approved, invoiced, disputed). Enables project-based and SOW billing models distinct from time-and-materials hourly billing.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`write_off` (
    `write_off_id` BIGINT COMMENT 'Unique system-generated identifier for the write-off transaction record. Primary key for the billing.write_off data product.',
    `accounting_period_id` BIGINT COMMENT 'Foreign key linking to finance.accounting_period. Business justification: Write-offs must be recorded in correct periods for financial reporting, bad debt expense recognition, and tax reporting.',
    `ar_account_id` BIGINT COMMENT 'Foreign key linking to finance.ar_account. Business justification: Write-offs reduce AR account balances and affect bad debt reserve calculations. Essential for AR reconciliation and financial reporting.',
    `assignment_id` BIGINT COMMENT 'Reference to the staffing placement associated with the original invoice being written off. Enables write-off analysis by placement type, recruiter, and business unit.',
    `billing_dispute_id` BIGINT COMMENT 'Reference to the billing dispute record that led to this write-off, if the write-off reason is disputed_settled. Links the write-off to the dispute resolution workflow.',
    `client_account_id` BIGINT COMMENT 'FK to client.client_account',
    `billing_account_id` BIGINT COMMENT 'Reference to the client billing account whose outstanding accounts receivable balance is being written off. Identifies the debtor entity in the AR ledger.',
    `conversion_id` BIGINT COMMENT 'Foreign key linking to placement.conversion. Business justification: Uncollectible conversion fees require write-offs (client disputes, bankruptcy, bad debt). Write-off tracking links to specific conversions for financial reporting and revenue adjustments. Essential fo',
    `credit_memo_id` BIGINT COMMENT 'Reference to an associated credit memo issued in connection with this write-off, if applicable. Relevant for disputed-and-settled write-offs where a credit memo was issued as part of the resolution.',
    `direct_hire_id` BIGINT COMMENT 'Foreign key linking to placement.direct_hire. Business justification: Uncollectible direct hire fees require write-offs (client bankruptcy, disputed fees, bad debt). Write-off tracking links to specific direct hire placements for financial reporting. Essential for bad d',
    `invoice_id` BIGINT COMMENT 'Reference to the original invoice record against which this write-off is being applied. Links the write-off to the source billing transaction.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Write-offs recorded at legal entity level for financial statements and tax reporting.',
    `staff_profile_id` BIGINT COMMENT 'Reference to the internal user or authority who approved the write-off. Supports segregation of duties and audit trail requirements.',
    `amount` DECIMAL(18,2) COMMENT 'The gross dollar amount of the accounts receivable balance being written off. Represents the full uncollectible amount before any partial recovery adjustments.',
    `approval_date` DATE COMMENT 'The date on which the write-off was formally approved by the designated approval authority. Required for audit trail and segregation of duties compliance.',
    `approval_level` STRING COMMENT 'The organizational authority level required and obtained to approve this write-off. Write-off approval thresholds typically escalate based on dollar amount per internal financial controls policy.. Valid values are `manager|director|vp|cfo|board`',
    `ar_aging_bucket` STRING COMMENT 'Aging classification of the invoice at the time of write-off, based on days outstanding. Used for bad debt reserve analysis, financial reporting, and write-off policy compliance.. Valid values are `0-30|31-60|61-90|91-120|121-180|180_plus`',
    `billing_model` STRING COMMENT 'The billing model under which the original invoice was generated. Supports segmentation of write-off analysis by revenue type (e.g., hourly T&M vs. direct placement fee vs. SOW-based).. Valid values are `time_and_materials|per_diem|project_based|sow_based|direct_placement_fee`',
    `branch_code` STRING COMMENT 'Code identifying the staffing branch or office that originated the client relationship and associated billing. Supports geographic and branch-level bad debt analysis.',
    `business_unit` STRING COMMENT 'The internal business unit or division responsible for the client relationship and original billing. Used for P&L attribution of bad debt expense and write-off reporting by division.',
    `collection_agency_name` STRING COMMENT 'Name of the third-party collection agency engaged to pursue recovery of the written-off balance. Populated when the account has been referred to external collections.',
    `collection_referral_date` DATE COMMENT 'Date on which the written-off account was referred to a third-party collection agency. Supports collections lifecycle tracking and agency performance measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the write-off record was first created in the data platform. Supports audit trail, data lineage, and SLA compliance for financial record creation.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the write-off amount (e.g., USD, CAD, GBP). Supports multi-currency operations for international staffing engagements.. Valid values are `^[A-Z]{3}$`',
    `days_outstanding_at_write_off` STRING COMMENT 'Number of days the invoice was outstanding (unpaid) at the time the write-off decision was made. Key metric for AR aging analysis and write-off policy compliance validation.',
    `gl_account_code` STRING COMMENT 'The General Ledger account code to which the write-off expense is posted. Typically maps to a bad debt expense or allowance for doubtful accounts GL account in the chart of accounts.',
    `gl_period` STRING COMMENT 'The accounting period (YYYY-MM) in which the write-off is recognized in the General Ledger. Determines the financial reporting period for bad debt expense recognition.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `netsuite_transaction_code` STRING COMMENT 'The internal transaction identifier assigned by Oracle NetSuite ERP when the write-off journal entry is posted. Enables direct traceability between the data lakehouse record and the ERP source system.',
    `notes` STRING COMMENT 'General free-text notes field for additional context, internal communications, or supplementary documentation related to the write-off. May include collection correspondence summaries, legal counsel notes, or management commentary.',
    `original_invoice_amount` DECIMAL(18,2) COMMENT 'The total billed amount on the original invoice at the time of issuance. Provides baseline for calculating the proportion of the invoice being written off versus any partial payments received.',
    `partial_payment_received` DECIMAL(18,2) COMMENT 'Total amount previously collected against the original invoice prior to the write-off decision. Used to confirm the net uncollectible balance and validate the write-off amount.',
    `reason` STRING COMMENT 'Categorical reason code explaining why the accounts receivable balance is being written off. Drives bad debt classification, tax treatment, and financial reporting segmentation. [ENUM-REF-CANDIDATE: bad_debt|client_bankruptcy|disputed_settled|aged_beyond_policy|small_balance_adjustment|client_insolvency — promote to reference product]. Valid values are `bad_debt|client_bankruptcy|disputed_settled|aged_beyond_policy|small_balance_adjustment|client_insolvency`',
    `reason_detail` STRING COMMENT 'Free-text narrative providing additional context and justification for the write-off beyond the categorical reason code. Captures case-specific circumstances such as dispute resolution outcomes, bankruptcy case numbers, or collection agency notes.',
    `recovered_amount` DECIMAL(18,2) COMMENT 'Dollar amount subsequently collected after the write-off was posted. Populated when recovery_status is partially_recovered or fully_recovered. Triggers a bad debt recovery journal entry in the GL.',
    `recovery_date` DATE COMMENT 'The date on which a subsequent payment was received against a previously written-off balance. Used to record the bad debt recovery accounting entry in the correct GL period.',
    `recovery_status` STRING COMMENT 'Current status of any subsequent collection efforts against a previously written-off balance. Tracks whether the written-off amount has been partially or fully recovered after the write-off was posted.. Valid values are `not_recovered|partially_recovered|fully_recovered|in_collections`',
    `reversal_date` DATE COMMENT 'The date on which the write-off was reversed in the General Ledger. Populated only when reversal_flag is True. Used for GL period reconciliation.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this write-off has been reversed (True) due to subsequent full payment, error correction, or management override. A reversed write-off requires a corresponding GL reversal entry.',
    `reversal_reason` STRING COMMENT 'Reason code explaining why the write-off was reversed. Supports audit trail and financial control documentation for reversed write-off transactions.. Valid values are `full_payment_received|data_entry_error|management_override|legal_settlement`',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this write-off record originated. Supports data lineage tracking and reconciliation between the lakehouse silver layer and source systems.. Valid values are `netsuite|salesforce_revenue_cloud|manual`',
    `tax_impact_flag` BOOLEAN COMMENT 'Indicates whether this write-off has a tax deductibility impact (True) or is a non-deductible write-off (False). Drives IRS bad debt deduction eligibility assessment and tax reporting workflows.',
    `tax_year` STRING COMMENT 'The fiscal tax year in which the bad debt deduction is claimed for IRS reporting purposes. May differ from the GL accounting period in cases of year-end timing differences.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording the most recent modification to the write-off record. Tracks changes to status, recovery amounts, reversal flags, and other mutable fields for audit compliance.',
    `write_off_date` DATE COMMENT 'The business event date on which the accounts receivable balance was formally written off. This is the accounting date used for GL period recognition, distinct from the system record creation timestamp.',
    `write_off_number` STRING COMMENT 'Externally-visible, human-readable business identifier for the write-off transaction. Used in financial reporting, audit correspondence, and GL reconciliation. Format: WO-YYYY-NNNNNN.. Valid values are `^WO-[0-9]{4}-[0-9]{6}$`',
    `write_off_status` STRING COMMENT 'Current lifecycle state of the write-off transaction. Tracks progression from initial submission through approval, GL posting, and potential reversal or recovery.. Valid values are `pending_approval|approved|posted|reversed|recovered`',
    CONSTRAINT pk_write_off PRIMARY KEY(`write_off_id`)
) COMMENT 'Transactional record documenting the write-off of uncollectible accounts receivable balances. Captures write-off date, write-off amount, write-off reason (bad debt, client bankruptcy, disputed and settled, aged beyond policy, small balance), original invoice reference, client billing account reference, approval authority, GL account code, tax impact flag, and recovery status (in case of subsequent collection). Supports bad debt management, financial reporting, and AR balance accuracy.';

CREATE OR REPLACE TABLE `staffing_hr_ecm`.`billing`.`payment_plan` (
    `payment_plan_id` BIGINT COMMENT 'Primary key for payment_plan',
    `restructured_payment_plan_id` BIGINT COMMENT 'Self-referencing FK on payment_plan (restructured_payment_plan_id)',
    `approval_required` BOOLEAN COMMENT 'Indicates whether management approval is required before assigning a client to this payment plan.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this payment plan for use. Nullable if no approval required or pending approval.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the payment plan was approved for use. Nullable if no approval required or pending approval.',
    `auto_payment_enabled` BOOLEAN COMMENT 'Indicates whether automatic payment processing is enabled for this payment plan.',
    `billing_frequency` STRING COMMENT 'Frequency at which invoices are generated under this payment plan.',
    `client_facing_terms` STRING COMMENT 'Client-facing description of payment terms and conditions displayed on invoices and client portals.',
    `client_tier` STRING COMMENT 'Client tier or segment classification for which this payment plan is intended.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the payment plan record was first created in the system.',
    `credit_check_required` BOOLEAN COMMENT 'Indicates whether a credit check is required before a client can be assigned to this payment plan.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code in which payments under this plan are denominated.',
    `payment_plan_description` STRING COMMENT 'Detailed description of the payment plan terms, conditions, and intended use cases.',
    `discount_days` STRING COMMENT 'Number of days from invoice date within which payment must be received to qualify for early payment discount. Nullable if no early payment discount offered.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied if payment is received before early payment discount deadline. Nullable if no early payment discount offered.',
    `down_payment_percentage` DECIMAL(18,2) COMMENT 'Percentage of total amount required as initial down payment before installment schedule begins. Nullable if no down payment required.',
    `dunning_process_enabled` BOOLEAN COMMENT 'Indicates whether automated dunning and collections process is enabled for overdue payments under this plan.',
    `effective_end_date` DATE COMMENT 'Date when the payment plan expires or is no longer available for new assignments. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the payment plan becomes active and available for use in billing arrangements.',
    `grace_period_days` STRING COMMENT 'Number of days after payment due date before late fees are assessed.',
    `industry_segment` STRING COMMENT 'Target industry segment or client type for which this payment plan is designed. Nullable for general-purpose plans. [ENUM-REF-CANDIDATE: healthcare|technology|manufacturing|finance|retail|government|education|professional_services — promote to reference product]',
    `installment_count` STRING COMMENT 'Total number of installment payments defined for installment-based payment plans. Nullable for non-installment plans.',
    `internal_notes` STRING COMMENT 'Internal notes and comments about the payment plan for finance team reference. Not visible to clients.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this is the default payment plan automatically assigned to new clients when no specific plan is selected.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Fixed monetary amount charged as late fee when payment is not received within payment terms. Nullable if late fees are percentage-based or not applicable.',
    `late_fee_percentage` DECIMAL(18,2) COMMENT 'Percentage of outstanding balance charged as late fee when payment is not received within payment terms. Nullable if late fees are fixed amount or not applicable.',
    `maximum_outstanding_balance` DECIMAL(18,2) COMMENT 'Maximum total outstanding balance allowed under this payment plan before additional invoicing is suspended. Nullable for unlimited credit plans.',
    `minimum_credit_score` STRING COMMENT 'Minimum credit score required for client eligibility for this payment plan. Nullable if no credit score requirement.',
    `modified_by` STRING COMMENT 'Identifier or name of the user who last modified the payment plan record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the payment plan record was last modified.',
    `payment_method` STRING COMMENT 'Default payment instrument or mechanism associated with this payment plan.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due under this plan.',
    `plan_code` STRING COMMENT 'Externally-known unique business identifier code for the payment plan used in contracts and invoicing systems.',
    `plan_name` STRING COMMENT 'Human-readable name of the payment plan displayed to clients and internal users.',
    `plan_type` STRING COMMENT 'Classification of the payment plan structure indicating the billing and payment schedule model.',
    `revenue_recognition_method` STRING COMMENT 'Accounting method for revenue recognition associated with this payment plan.',
    `payment_plan_status` STRING COMMENT 'Current lifecycle status of the payment plan indicating availability for assignment to client agreements.',
    `created_by` STRING COMMENT 'Identifier or name of the user who created the payment plan record.',
    CONSTRAINT pk_payment_plan PRIMARY KEY(`payment_plan_id`)
) COMMENT 'Master reference table for payment_plan. Referenced by payment_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_original_invoice_id` FOREIGN KEY (`original_invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_bill_rate_id` FOREIGN KEY (`bill_rate_id`) REFERENCES `staffing_hr_ecm`.`billing`.`bill_rate`(`bill_rate_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_billing_rate_schedule_id` FOREIGN KEY (`billing_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ADD CONSTRAINT `fk_billing_bill_rate_previous_rate_bill_rate_id` FOREIGN KEY (`previous_rate_bill_rate_id`) REFERENCES `staffing_hr_ecm`.`billing`.`bill_rate`(`bill_rate_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ADD CONSTRAINT `fk_billing_billing_rate_schedule_superseded_by_schedule_billing_rate_schedule_id` FOREIGN KEY (`superseded_by_schedule_billing_rate_schedule_id`) REFERENCES `staffing_hr_ecm`.`billing`.`billing_rate_schedule`(`billing_rate_schedule_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_payment_id` FOREIGN KEY (`payment_id`) REFERENCES `staffing_hr_ecm`.`billing`.`payment`(`payment_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_reversed_by_application_payment_application_id` FOREIGN KEY (`reversed_by_application_payment_application_id`) REFERENCES `staffing_hr_ecm`.`billing`.`payment_application`(`payment_application_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ADD CONSTRAINT `fk_billing_payment_application_reverses_application_id` FOREIGN KEY (`reverses_application_id`) REFERENCES `staffing_hr_ecm`.`billing`.`payment_application`(`payment_application_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `staffing_hr_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ADD CONSTRAINT `fk_billing_credit_memo_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ADD CONSTRAINT `fk_billing_billing_dispute_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ADD CONSTRAINT `fk_billing_collection_activity_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `staffing_hr_ecm`.`billing`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ADD CONSTRAINT `fk_billing_collection_activity_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ADD CONSTRAINT `fk_billing_collection_activity_payment_plan_id` FOREIGN KEY (`payment_plan_id`) REFERENCES `staffing_hr_ecm`.`billing`.`payment_plan`(`payment_plan_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_bill_rate_id` FOREIGN KEY (`bill_rate_id`) REFERENCES `staffing_hr_ecm`.`billing`.`bill_rate`(`bill_rate_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ADD CONSTRAINT `fk_billing_spread_record_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ADD CONSTRAINT `fk_billing_placement_fee_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ADD CONSTRAINT `fk_billing_expense_charge_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ADD CONSTRAINT `fk_billing_sow_billing_milestone_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_billing_dispute_id` FOREIGN KEY (`billing_dispute_id`) REFERENCES `staffing_hr_ecm`.`billing`.`billing_dispute`(`billing_dispute_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `staffing_hr_ecm`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_credit_memo_id` FOREIGN KEY (`credit_memo_id`) REFERENCES `staffing_hr_ecm`.`billing`.`credit_memo`(`credit_memo_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ADD CONSTRAINT `fk_billing_write_off_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `staffing_hr_ecm`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_plan` ADD CONSTRAINT `fk_billing_payment_plan_restructured_payment_plan_id` FOREIGN KEY (`restructured_payment_plan_id`) REFERENCES `staffing_hr_ecm`.`billing`.`payment_plan`(`payment_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `staffing_hr_ecm`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `staffing_hr_ecm`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Msa Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `original_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `pay_run_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Run ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `sourcing_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Campaign Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Amount Paid');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `amount_paid` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `amount_paid` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `bill_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'time_and_materials|per_diem|project_based|sow_based|direct_placement_fee');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'email|vms_portal|edi|mail|fax');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Discount Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Invoice Dispute Reason');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Gross Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^INV-[0-9]{8,12}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_value_regex' = 'draft|sent|paid|partially_paid|disputed|void');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `is_void` SET TAGS ('dbx_business_glossary_term' = 'Is Void Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Net Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Notes');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `overtime_hours_billed` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Hours Billed');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Paid Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `pay_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|due_on_receipt');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Invoice Sent Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `sow_number` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `spread_amount` SET TAGS ('dbx_business_glossary_term' = 'Spread Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `spread_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `spread_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Tax Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `total_hours_billed` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Billed');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `vms_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `void_reason` SET TAGS ('dbx_value_regex' = 'billing_error|rate_correction|duplicate_invoice|client_request|contract_termination');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice` ALTER COLUMN `worker_count` SET TAGS ('dbx_business_glossary_term' = 'Worker Count');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `bill_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Client Location ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Msa Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `contract_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Schedule Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `credential_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Instance Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `direct_hire_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Job Category Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `onboarding_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order (Req) ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `pay_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Worker (Candidate) ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `req_pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Req Pipeline Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `sow_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Placement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `worker_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'time_and_materials|per_diem|project_based|sow_based|direct_placement|temp_to_perm');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Type');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `billing_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|double_time|per_diem|expense|placement_fee');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `burden_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Burden Rate Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `burden_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `credit_memo_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Reference Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `extended_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `extended_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|approved|disputed|credited|voided|paid');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `ot_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Multiplier');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'hours|days|units|flat');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `spread_amount` SET TAGS ('dbx_business_glossary_term' = 'Spread Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `spread_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `vms_req_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Requisition Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `worker_type` SET TAGS ('dbx_business_glossary_term' = 'Worker Type');
ALTER TABLE `staffing_hr_ecm`.`billing`.`invoice_line` ALTER COLUMN `worker_type` SET TAGS ('dbx_value_regex' = 'w2_temp|1099_ic|c2c|eor|direct_hire');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `bill_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `client_rate_card_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Card ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Msa Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `direct_hire_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Job Category Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Client Location ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `pay_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `previous_rate_bill_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Bill Rate ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `recruitment_sla_target_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Sla Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `sow_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Placement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vms Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `rate_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Rate ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `wage_hour_determination_id` SET TAGS ('dbx_business_glossary_term' = 'Wage Hour Determination Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `wage_hour_determination_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `wage_hour_determination_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|expired|superseded');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'time_and_materials|per_diem|project_based|sow_based|direct_placement|temp_to_perm');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `burden_included` SET TAGS ('dbx_business_glossary_term' = 'Burden Included Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `burden_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Burden Rate Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `burden_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `dt_bill_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Double Time (DT) Bill Rate Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `dt_bill_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `flsa_exempt` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Exempt Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `gross_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `gross_margin_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `max_bill_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bill Rate Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `max_bill_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `min_bill_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Bill Rate Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `min_bill_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate Notes');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `ot_bill_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Bill Rate Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `ot_bill_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `pay_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `pay_rate_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `per_diem_amount` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `per_diem_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `rate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `rate_name` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate Name');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'manual|vms_imported|rate_card|msa_negotiated|market_benchmark');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate Type');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'standard|overtime|double_time|per_diem|blended|project');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `rate_version` SET TAGS ('dbx_business_glossary_term' = 'Rate Version Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `spread_amount` SET TAGS ('dbx_business_glossary_term' = 'Spread Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `spread_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `work_state_code` SET TAGS ('dbx_business_glossary_term' = 'Work State Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `work_state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`bill_rate` ALTER COLUMN `workers_comp_code` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation (Workers Comp) Class Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Msa Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `contract_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Rate Schedule Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Job Category Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `managed_program_id` SET TAGS ('dbx_business_glossary_term' = 'Managed Program Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `superseded_by_schedule_billing_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate Schedule ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `vms_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `base_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `base_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `base_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Pay Rate');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `base_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Frequency');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_rate_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `billing_rate_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|pending_approval|expired|superseded');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `burden_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Burden Rate Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `burden_rate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `conversion_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Conversion Fee Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `conversion_fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `direct_placement_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Direct Placement Fee Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `direct_placement_fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `dt_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Double Time (DT) Multiplier');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `geographic_market` SET TAGS ('dbx_business_glossary_term' = 'Geographic Market');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `gross_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `gross_margin_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `holiday_rate_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Holiday Rate Multiplier');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `maximum_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Maximum Hours Per Week');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `minimum_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Minimum Hours Per Week');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Notes');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `ot_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Multiplier');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `per_diem_allowance` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Allowance');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Type');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'standard|premium|msp_managed|vms_driven|sow_based|project_based');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `skill_tier` SET TAGS ('dbx_business_glossary_term' = 'Skill Tier');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `skill_tier` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|expert|executive');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `sla_fill_time_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Fill Time Days');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `sla_submittal_count` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Submittal Count');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `spread_amount` SET TAGS ('dbx_business_glossary_term' = 'Spread Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `spread_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_rate_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Version Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Msa Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Last Four Digits');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `bank_account_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `cash_account_code` SET TAGS ('dbx_business_glossary_term' = 'Cash Account Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `cleared_date` SET TAGS ('dbx_business_glossary_term' = 'Cleared Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `discount_taken` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Taken');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `is_overpayment` SET TAGS ('dbx_business_glossary_term' = 'Is Overpayment');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `is_partial_payment` SET TAGS ('dbx_business_glossary_term' = 'Is Partial Payment');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `lockbox_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Lockbox Batch ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|Wire Transfer|Check|Credit Card|Debit Card|Electronic Funds Transfer');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_value_regex' = '^PAY-[0-9]{8,12}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'Pending|Cleared|Applied|Returned|Voided|Reversed');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `reconciled_by` SET TAGS ('dbx_business_glossary_term' = 'Reconciled By');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `reconciled_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciled Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'Unreconciled|Reconciled|Disputed|Under Review');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `remittance_reference` SET TAGS ('dbx_business_glossary_term' = 'Remittance Advice Reference');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `payment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Application ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Applied By User ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `reversed_by_application_payment_application_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed By Payment Application ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `reverses_application_id` SET TAGS ('dbx_business_glossary_term' = 'Reverses Payment Application ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Application Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Application Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^PA-[0-9]{8}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Application Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'pending|applied|reversed|disputed|reconciled|voided');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Application Type');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'full|partial|prepayment|credit_memo_offset|overpayment|underpayment');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `days_to_payment` SET TAGS ('dbx_business_glossary_term' = 'Days to Payment');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `gl_batch_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Batch ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `is_early_payment` SET TAGS ('dbx_business_glossary_term' = 'Is Early Payment');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `is_late_payment` SET TAGS ('dbx_business_glossary_term' = 'Is Late Payment');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `net_applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Applied Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Application Notes');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'unreconciled|reconciled|exception|pending_review');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_revenue_cloud|netsuite_erp|manual_entry|bank_feed|lockbox');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_application` ALTER COLUMN `writeoff_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `approved_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `approved_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `approved_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Msa Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `direct_hire_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `regulatory_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Violation Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `sla_breach_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Breach Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Issued By User ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Applied Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `applied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `applied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `applied_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Applied Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `applied_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Applied Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `applied_status` SET TAGS ('dbx_value_regex' = 'unapplied|partially_applied|fully_applied|expired');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Approval Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Approval Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|voided');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'time_and_materials|per_diem|project_based|sow_based|direct_placement');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `client_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Client Notification Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `client_notified` SET TAGS ('dbx_business_glossary_term' = 'Client Notified Indicator');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `corrected_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Corrected Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `corrected_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `corrected_bill_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_value_regex' = '^CM-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `credited_hours` SET TAGS ('dbx_business_glossary_term' = 'Credited Hours');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Expiration Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `is_void_and_rebill` SET TAGS ('dbx_business_glossary_term' = 'Void and Rebill Indicator');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Issue Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Notes');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `original_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Original Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `original_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `original_bill_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Reason Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'billing_error|rate_correction|timesheet_rebilling|service_credit|fall_off_adjustment|conversion_fee_reversal');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Reason Description');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_revenue_cloud|netsuite_erp|manual');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `tax_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Adjustment Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `tax_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `tax_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Unapplied Credit Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`credit_memo` ALTER COLUMN `void_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Void Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Msa Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `direct_hire_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Resolution Owner Staff Profile Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `timesheet_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Dispute Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `worker_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `agreed_bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Agreed Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `agreed_bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `approved_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Credit Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `approved_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `approved_credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `approved_hours` SET TAGS ('dbx_business_glossary_term' = 'Approved Hours');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `bill_rate_disputed` SET TAGS ('dbx_business_glossary_term' = 'Disputed Bill Rate');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `bill_rate_disputed` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'hourly|per_diem|project|sow|direct_placement');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Dispute Submission Channel');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|vms_portal|phone|written_notice|client_portal');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `client_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Email Address');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `client_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `client_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `client_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `client_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Client Contact Name');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `client_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `client_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `collections_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Collections Hold Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_value_regex' = '^DSP-[0-9]{8,12}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|under_review|escalated|resolved|closed');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_value_regex' = 'rate_discrepancy|hours_mismatch|unauthorized_charge|duplicate_invoice|worker_eligibility|other');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `disputed_hours` SET TAGS ('dbx_business_glossary_term' = 'Disputed Hours');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Escalation Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Escalation Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `invoice_period_end` SET TAGS ('dbx_business_glossary_term' = 'Invoice Period End Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `invoice_period_start` SET TAGS ('dbx_business_glossary_term' = 'Invoice Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Last Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Open Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Dispute Priority');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Received Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Notes');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Type');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'credit_issued|invoice_adjusted|dispute_rejected|partial_credit|write_off');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Dispute Root Cause Category');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'billing_error|timesheet_error|rate_setup_error|worker_compliance|system_error|client_error');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute SLA Breach Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'Dispute SLA Target Days');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `vms_dispute_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Dispute Reference');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `worker_name` SET TAGS ('dbx_business_glossary_term' = 'Worker Name');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `worker_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_dispute` ALTER COLUMN `worker_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `collection_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Activity ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `client_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Client Contact ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `created_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `credit_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `modified_by_user_staff_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Collector ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `activity_date` SET TAGS ('dbx_business_glossary_term' = 'Activity Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'phone_call|email|demand_letter|escalation|legal_referral|payment_plan_setup');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current|1_30_days|31_60_days|61_90_days|over_90_days');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `collection_activity_status` SET TAGS ('dbx_business_glossary_term' = 'Activity Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `collection_activity_status` SET TAGS ('dbx_value_regex' = 'open|completed|cancelled|pending_follow_up');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `contact_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `contact_method` SET TAGS ('dbx_business_glossary_term' = 'Contact Method');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|mail|fax|in_person|portal');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `contact_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `credit_memo_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Issued Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Activity Duration Minutes');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|legal|write_off');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `legal_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Activity Notes');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Activity Outcome');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'promise_to_pay|dispute_raised|payment_received|no_response|escalated|payment_plan_agreed');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `payment_received_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `promise_to_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Promise to Pay Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `promise_to_pay_date` SET TAGS ('dbx_business_glossary_term' = 'Promise to Pay Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `staffing_hr_ecm`.`billing`.`collection_activity` ALTER COLUMN `write_off_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Recommended Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `spread_record_id` SET TAGS ('dbx_business_glossary_term' = 'Spread Record ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `bill_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Rate Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `job_category_id` SET TAGS ('dbx_business_glossary_term' = 'Job Category Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `sow_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Placement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `tertiary_spread_approved_by_user_staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `worker_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under-review');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `billable_units` SET TAGS ('dbx_business_glossary_term' = 'Billable Units');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'time-and-materials|per-diem|project-based|SOW-based|direct-placement-fee|retainer');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `burden_rate` SET TAGS ('dbx_business_glossary_term' = 'Burden Rate');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `burdened_cost` SET TAGS ('dbx_business_glossary_term' = 'Burdened Cost');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `double_time_flag` SET TAGS ('dbx_business_glossary_term' = 'Double Time (DT) Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `gross_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `gross_margin_percentage` SET TAGS ('dbx_business_glossary_term' = 'Gross Margin Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `is_commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Spread Record Notes');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `spread_amount` SET TAGS ('dbx_business_glossary_term' = 'Spread Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `total_bill_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Bill Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `total_gross_margin_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Margin Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `total_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Pay Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `total_spread_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spread Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `staffing_hr_ecm`.`billing`.`spread_record` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'hour|day|week|month|project|unit');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Name');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `account_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^BA-[0-9]{8}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|on_hold|pending_approval|closed');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Type');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'direct_client|msp_program|vms_program|peo_client|eor_client|rpo_client');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `ar_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Contact Email');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `ar_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `ar_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `ar_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `ar_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Contact Name');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `ar_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `ar_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Contact Phone');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `ar_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9-s().]{7,20}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `ar_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `ar_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'weekly|bi_weekly|semi_monthly|monthly');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'time_and_materials|per_diem|project_based|sow_based|direct_placement_fee');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `consolidated_invoicing` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Invoicing Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'approved|under_review|probationary|suspended|denied');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `credit_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `early_payment_discount_days` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Window Days');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `early_payment_discount_pct` SET TAGS ('dbx_business_glossary_term' = 'Early Payment Discount Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `early_payment_discount_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Effective Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `external_customer_code` SET TAGS ('dbx_business_glossary_term' = 'External Customer Account Identifier');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Invoice Delivery Method');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `invoice_delivery_method` SET TAGS ('dbx_value_regex' = 'email|vms_portal|edi|mail|client_portal');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `invoice_format` SET TAGS ('dbx_business_glossary_term' = 'Invoice Format');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `invoice_format` SET TAGS ('dbx_value_regex' = 'standard|detailed|summary|custom');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `late_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Late Payment Fee Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `late_fee_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `msa_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Master Service Agreement (MSA) Reference Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `netsuite_customer_code` SET TAGS ('dbx_business_glossary_term' = 'NetSuite Customer ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `payment_terms_net_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Net Days');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `payment_terms_net_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `preferred_payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|vms_payment');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `purchase_order_required` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Required Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `salesforce_account_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Revenue Cloud Account ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Certificate Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_exempt_certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Termination Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `vms_billing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Billing Enabled Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`billing_account` ALTER COLUMN `vms_program_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Management System (VMS) Program Name');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `placement_fee_id` SET TAGS ('dbx_business_glossary_term' = 'Placement Fee ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `msa_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Msa Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `direct_hire_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `hiring_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Decision Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `onboarding_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Placement ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `recruiter_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Assignment Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `worker_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `candidate_annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Candidate Annual Salary');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `candidate_annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `candidate_annual_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `credit_memo_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `credit_memo_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'none|open|under_review|resolved|escalated');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fall_off_date` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fall_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Fall-Off Reason');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fall_off_reason` SET TAGS ('dbx_value_regex' = 'candidate_resigned|client_terminated|performance|role_eliminated|personal_reasons|other');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fee_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Adjustment Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fee_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Placement Fee Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fee_basis` SET TAGS ('dbx_business_glossary_term' = 'Fee Basis');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fee_basis` SET TAGS ('dbx_value_regex' = 'percentage_of_salary|flat_fee|hybrid');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fee_date` SET TAGS ('dbx_business_glossary_term' = 'Placement Fee Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fee_number` SET TAGS ('dbx_business_glossary_term' = 'Placement Fee Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fee_number` SET TAGS ('dbx_value_regex' = '^PF-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fee Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fee_type` SET TAGS ('dbx_business_glossary_term' = 'Placement Fee Type');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `fee_type` SET TAGS ('dbx_value_regex' = 'direct_placement|temp_to_perm|rpo_fee|retained_search|contingency_search');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `guarantee_end_date` SET TAGS ('dbx_business_glossary_term' = 'Guarantee End Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `guarantee_period_days` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Period (Days)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `is_fall_off` SET TAGS ('dbx_business_glossary_term' = 'Is Fall-Off Indicator');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Paid Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `paid_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `payment_received_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_15|net_30|net_45|net_60|due_on_receipt');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `replacement_eligible` SET TAGS ('dbx_business_glossary_term' = 'Replacement Eligible Indicator');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'bullhorn|salesforce_revenue_cloud|netsuite|manual');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `source_system_fee_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Fee ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `split_fee_indicator` SET TAGS ('dbx_business_glossary_term' = 'Split Fee Indicator');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `split_fee_percentage` SET TAGS ('dbx_business_glossary_term' = 'Split Fee Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `split_fee_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`placement_fee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `expense_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Expense Charge ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `bgc_order_id` SET TAGS ('dbx_business_glossary_term' = 'Bgc Order Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sow Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `credential_instance_id` SET TAGS ('dbx_business_glossary_term' = 'Credential Instance Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `drug_screen_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `onboarding_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Record Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `order_header_id` SET TAGS ('dbx_business_glossary_term' = 'Job Order ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `per_diem_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Claim Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `sow_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Placement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `billable_amount` SET TAGS ('dbx_business_glossary_term' = 'Billable Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `billable_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `billable_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'time_and_materials|per_diem|project_based|sow_based|direct_placement');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `charge_status` SET TAGS ('dbx_business_glossary_term' = 'Expense Charge Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `charge_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|billed|voided|disputed');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `client_po_number` SET TAGS ('dbx_business_glossary_term' = 'Client Purchase Order (PO) Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `credit_memo_reference` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Reference');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `expense_amount` SET TAGS ('dbx_business_glossary_term' = 'Expense Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `expense_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `expense_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `expense_date` SET TAGS ('dbx_business_glossary_term' = 'Expense Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `expense_description` SET TAGS ('dbx_business_glossary_term' = 'Expense Description');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `expense_number` SET TAGS ('dbx_business_glossary_term' = 'Expense Charge Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `expense_number` SET TAGS ('dbx_value_regex' = '^EXP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `expense_type` SET TAGS ('dbx_business_glossary_term' = 'Expense Type');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `expense_type` SET TAGS ('dbx_value_regex' = 'per_diem|travel|lodging|mileage|equipment|training');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `is_reimbursable` SET TAGS ('dbx_business_glossary_term' = 'Is Reimbursable Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `markup_amount` SET TAGS ('dbx_business_glossary_term' = 'Markup Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `markup_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `markup_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `markup_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `mileage_rate` SET TAGS ('dbx_business_glossary_term' = 'Mileage Rate');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `mileage_units` SET TAGS ('dbx_business_glossary_term' = 'Mileage Units');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `per_diem_rate` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `receipt_reference` SET TAGS ('dbx_business_glossary_term' = 'Receipt Reference');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'salesforce_revenue_cloud|netsuite_erp|beeline_vms|tempworks_payroll|manual');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `worker_name` SET TAGS ('dbx_business_glossary_term' = 'Worker Name');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `worker_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`expense_charge` ALTER COLUMN `worker_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` SET TAGS ('dbx_subdomain' = 'revenue_recognition');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `sow_billing_milestone_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) Billing Milestone ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `client_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `sow_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'Sow Placement Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `sow_id` SET TAGS ('dbx_business_glossary_term' = 'Statement of Work (SOW) ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `actual_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Billing Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `adjusted_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Milestone Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `adjusted_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Approval Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_review|approved|rejected|escalated');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `approver_email` SET TAGS ('dbx_business_glossary_term' = 'Approver Email Address');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `approver_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `approver_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `approver_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'SOW Billing Model');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'sow_fixed_fee|sow_time_materials|sow_per_diem|sow_milestone');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `client_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Client Approver Name');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Completion Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `credit_memo_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `credit_memo_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Due Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Billing Notes');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Milestone Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `is_retainage` SET TAGS ('dbx_business_glossary_term' = 'Retainage Indicator');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `milestone_amount` SET TAGS ('dbx_business_glossary_term' = 'Milestone Billing Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `milestone_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `milestone_description` SET TAGS ('dbx_business_glossary_term' = 'Milestone Description');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Milestone Name');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `milestone_number` SET TAGS ('dbx_business_glossary_term' = 'Milestone Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `milestone_number` SET TAGS ('dbx_value_regex' = '^MS-[0-9]{4,10}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `milestone_sequence` SET TAGS ('dbx_business_glossary_term' = 'Milestone Sequence Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_business_glossary_term' = 'Milestone Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `milestone_status` SET TAGS ('dbx_value_regex' = 'pending|approved|invoiced|disputed|cancelled');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_business_glossary_term' = 'Milestone Type');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `milestone_type` SET TAGS ('dbx_value_regex' = 'deliverable|phase_completion|time_based|percent_complete|acceptance');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'Net15|Net30|Net45|Net60|Due_on_receipt');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `retainage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retainage Percentage');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `scheduled_billing_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Billing Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Salesforce_Revenue_Cloud|Oracle_NetSuite|DocuSign_CLM|Manual');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `source_system_milestone_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Milestone ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`sow_billing_milestone` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_id` SET TAGS ('dbx_business_glossary_term' = 'Write-Off ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `accounting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Accounting Period Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `ar_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ar Account Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Placement ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `billing_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `client_account_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Billing Account ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `conversion_id` SET TAGS ('dbx_business_glossary_term' = 'Conversion Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `credit_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `direct_hire_id` SET TAGS ('dbx_business_glossary_term' = 'Direct Hire Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `staff_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `approval_level` SET TAGS ('dbx_value_regex' = 'manager|director|vp|cfo|board');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `ar_aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Accounts Receivable (AR) Aging Bucket');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `ar_aging_bucket` SET TAGS ('dbx_value_regex' = '0-30|31-60|61-90|91-120|121-180|180_plus');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `billing_model` SET TAGS ('dbx_business_glossary_term' = 'Billing Model');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `billing_model` SET TAGS ('dbx_value_regex' = 'time_and_materials|per_diem|project_based|sow_based|direct_placement_fee');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `branch_code` SET TAGS ('dbx_business_glossary_term' = 'Branch Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `collection_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency Name');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `collection_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Referral Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `days_outstanding_at_write_off` SET TAGS ('dbx_business_glossary_term' = 'Days Outstanding at Write-Off');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `gl_period` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Accounting Period');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `gl_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `netsuite_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'NetSuite Transaction ID');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Notes');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `original_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Invoice Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `original_invoice_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `original_invoice_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `partial_payment_received` SET TAGS ('dbx_business_glossary_term' = 'Partial Payment Received');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `partial_payment_received` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `partial_payment_received` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `reason` SET TAGS ('dbx_value_regex' = 'bad_debt|client_bankruptcy|disputed_settled|aged_beyond_policy|small_balance_adjustment|client_insolvency');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `reason_detail` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason Detail');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Recovered Amount');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `recovered_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `recovery_status` SET TAGS ('dbx_business_glossary_term' = 'Recovery Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `recovery_status` SET TAGS ('dbx_value_regex' = 'not_recovered|partially_recovered|fully_recovered|in_collections');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_value_regex' = 'full_payment_received|data_entry_error|management_override|legal_settlement');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'netsuite|salesforce_revenue_cloud|manual');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `tax_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Impact Flag');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_number` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Number');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Status');
ALTER TABLE `staffing_hr_ecm`.`billing`.`write_off` ALTER COLUMN `write_off_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|posted|reversed|recovered');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_plan` SET TAGS ('dbx_subdomain' = 'payment_processing');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_plan` ALTER COLUMN `payment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Identifier');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_plan` ALTER COLUMN `restructured_payment_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `staffing_hr_ecm`.`billing`.`payment_plan` ALTER COLUMN `internal_notes` SET TAGS ('dbx_confidential' = 'true');
