-- Schema for Domain: grant | Business: Ngo | Version: v2_mvm
-- Generated on: 2026-06-23 02:07:08

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`grant` COMMENT 'Source systems: SAP S/4HANA (VISION), eTools, donor portals. Grant/award lifecycle from proposal to closeout. Systems of record: SAP GM, Quantum, VISION.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` (
    `sub_award_disbursement_id` DECIMAL(18,2) COMMENT 'Unique system-generated identifier for each sub-award disbursement transaction record in the grant management system.',
    `award_id` BIGINT COMMENT 'Reference to the prime grant award from which this sub-award disbursement is funded. Enables Budget vs. Actual (BvA) tracking at the prime award level.',
    `component_id` BIGINT COMMENT 'Reference to the program or project under which this sub-award disbursement is executed. Enables program-level Budget vs. Actual (BvA) tracking and Monitoring, Evaluation, and Learning (MEL) linkage.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Disbursements are processed and authorized through a country office (banking, approval authority, audit). Country-office-level disbursement reconciliation is a standard NGO finance process; country di',
    `emergency_id` BIGINT COMMENT 'Foreign key linking to field.emergency. Business justification: The `is_emergency_disbursement` flag on sub_award_disbursement signals emergency-specific disbursements exist. Linking to the declared emergency enables CERF/flash appeal financial tracking, emergency',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Disbursements draw down specific restricted donor funds. Fund balance tracking and net asset release calculations require knowing which donor fund each disbursement reduces — a core NGO fund accountin',
    `partner_org_id` BIGINT COMMENT 'Reference to the sub-recipient organization (Community-Based Organization, Civil Society Organization, or other implementing partner) receiving this disbursement.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Post-distribution monitoring and site-level financial accountability require linking disbursements to the project site where funds are deployed. The `post_distribution_monitoring_ref` attribute signal',
    `subaward_id` BIGINT COMMENT 'Reference to the parent sub-award agreement under which this disbursement is made. Links the disbursement to the specific sub-award instrument and implementing partner.',
    `advance_balance_outstanding` DECIMAL(18,2) COMMENT 'Remaining unliquidated advance balance owed by the implementing partner at the time of this disbursement record. Calculated as cumulative advances disbursed minus cumulative liquidations submitted. Supports 2 CFR 200.305 advance payment monitoring and cash management.',
    `approval_date` DATE COMMENT 'Date on which the authorized approver (grants manager, finance director, or designated authority) formally approved the disbursement request for payment processing.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized staff member (grants manager, finance director, or country director) who approved this disbursement. Required for audit trail and segregation of duties compliance.',
    `bank_transfer_reference` STRING COMMENT 'Bank-issued or payment-system-issued reference number for the wire transfer, EFT, or mobile money transaction. Used for bank reconciliation, audit trail, and confirmation of funds receipt by the implementing partner.',
    `board_authorization_reference` STRING COMMENT 'Reference to board authorization for this disbursement.',
    `cost_category` DECIMAL(18,2) COMMENT 'Budget cost category classification for this disbursement per the approved sub-award budget. Supports Budget vs. Actual (BvA) analysis by cost line and compliance with donor-approved budget categories under OMB Uniform Guidance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this disbursement record was first created in the Grant Management System (GMS) or Unit4 ERP. Provides the audit trail creation marker required under OMB Uniform Guidance record retention requirements.',
    `disbursement_amount` DECIMAL(18,2) COMMENT 'Gross amount disbursed to the implementing partner in the transaction currency. Used as the primary monetary value for Budget vs. Actual (BvA) tracking at the sub-award level.',
    `disbursement_amount_usd` DECIMAL(18,2) COMMENT 'Disbursement amount converted to US Dollars (USD) using the applied exchange rate. Used for consolidated Budget vs. Actual (BvA) reporting, donor financial reports, and NICRA/Indirect Cost Rate (ICR) calculations across multi-currency sub-awards.',
    `disbursement_currency` DECIMAL(18,2) COMMENT 'ISO 4217 three-letter currency code of the currency in which the disbursement was made to the implementing partner (e.g., USD, EUR, KES, NGN). Supports multi-currency operations in international humanitarian programs.',
    `disbursement_date` DATE COMMENT 'Actual date on which funds were transferred to the implementing partners bank account or mobile money wallet. This is the principal business event date for Budget vs. Actual (BvA) reporting and cash flow tracking.',
    `disbursement_method` DECIMAL(18,2) COMMENT 'Mechanism by which funds are transferred to the implementing partner. Includes wire transfer for international bank transfers, mobile money for field-based digital payments (e.g., M-Pesa), check, cash for remote/emergency contexts, and electronic funds transfer (EFT) for domestic payments.',
    `disbursement_notes` DECIMAL(18,2) COMMENT 'Free-text field for grants staff to record contextual notes, special conditions, or explanations related to this disbursement, such as reasons for partial payment, exchange rate justification, or emergency authorization rationale.',
    `disbursement_reference_number` DECIMAL(18,2) COMMENT 'Externally-known unique alphanumeric reference number assigned to this disbursement transaction, used in bank transfer instructions, financial records, and audit trails. Corresponds to the payment reference in SAP S/4HANA Accounts Payable.',
    `disbursement_status` DECIMAL(18,2) COMMENT 'Current lifecycle state of the disbursement transaction. Tracks progression from draft request through approval, actual disbursement, and final liquidation or cancellation. Drives workflow routing in the Grant Management System (GMS).',
    `disbursement_type` DECIMAL(18,2) COMMENT 'Classification of the disbursement as an advance payment to the sub-recipient prior to expenditure, a reimbursement for costs already incurred, a direct payment to a third-party vendor on behalf of the sub-recipient, or a letter-of-credit drawdown. Governs compliance with 2 CFR 200.305 advance payment requirements.',
    `donor_reporting_category` STRING COMMENT 'Donor-specific budget category or expenditure classification code required for financial reporting to the prime donor (e.g., USAID, BHA, DFID, CERF). Maps the disbursement to the donors chart of accounts or budget template for Financial Report (SF-425) or equivalent submission. [ENUM-REF-CANDIDATE: promote to reference product as values vary by donor]',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign currency exchange rate applied to convert the disbursement amount from the transaction currency to the base reporting currency (typically USD) at the time of disbursement. Essential for consolidated financial reporting and donor reporting under USAID, BHA, and DFID requirements.',
    `fiscal_period` STRING COMMENT 'Fiscal accounting period (month number 1–12 within the fiscal year) in which this disbursement is posted to the General Ledger. Supports period-level Budget vs. Actual (BvA) reporting and cash flow forecasting.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this disbursement is recorded for financial reporting purposes. Used for annual financial statement preparation, donor reporting, and compliance with FASB ASC 958 and OMB Uniform Guidance reporting periods.',
    `fund_restriction_type` STRING COMMENT 'Indicates whether the disbursed funds are donor-restricted (for a specific purpose or time period), temporarily restricted, or unrestricted. Critical for fund accounting compliance under FASB ASC 958 and donor stewardship reporting.. Valid values are `restricted|unrestricted|temporarily_restricted`',
    `indirect_cost_amount` DECIMAL(18,2) COMMENT 'Calculated indirect cost (Facilities and Administration / F&A) amount included in or associated with this disbursement, based on the NICRA rate applied to the direct cost base. Supports compliance with OMB Uniform Guidance 2 CFR 200.414 and donor budget monitoring.',
    `is_emergency_disbursement` BOOLEAN COMMENT 'Indicates whether this disbursement was processed as an emergency or expedited payment outside the standard approval workflow, such as for rapid-onset disaster response under CERF or BHA emergency funding mechanisms.',
    `is_grantmaking_disbursement` BOOLEAN COMMENT 'Whether this disbursement is for an outbound grant made by the organization.',
    `liquidated_amount` DECIMAL(18,2) COMMENT 'Amount of the advance disbursement that has been accounted for through submission of eligible expenditure documentation by the implementing partner. The difference between disbursement_amount and liquidated_amount represents the outstanding advance balance.',
    `liquidation_date` DATE COMMENT 'Actual date on which the implementing partner submitted the expenditure documentation or financial report fully accounting for the advance disbursement. Null if liquidation is pending or not yet completed.',
    `liquidation_deadline` DATE COMMENT 'Contractual deadline by which the implementing partner must submit expenditure documentation (financial report or liquidation report) to account for advance funds disbursed. Compliance with this date is required under 2 CFR 200.305.',
    `liquidation_status` STRING COMMENT 'Current status of the liquidation (financial accountability reporting) for this advance disbursement. Tracks whether the implementing partner has submitted expenditure documentation to account for advanced funds per 2 CFR 200.305 requirements.. Valid values are `not_required|pending|partial|fully_liquidated|overdue`',
    `net_asset_release_amount` DECIMAL(18,2) COMMENT 'Amount of net assets released from restriction upon disbursement.',
    `net_disbursement_amount` DECIMAL(18,2) COMMENT 'Actual net amount transferred to the implementing partner after deducting any withholding amounts from the gross disbursement amount. This is the amount reflected in the bank transfer instruction.',
    `nicra_rate_applied` DECIMAL(18,2) COMMENT 'Indirect Cost Rate (ICR) percentage applied to this disbursement per the implementing partners Negotiated Indirect Cost Rate Agreement (NICRA) or approved Facilities and Administration (F&A) rate. Used to calculate allowable indirect costs charged to the sub-award.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Contractual payment terms governing when and how disbursements are made under the sub-award, such as immediate advance, net-30 reimbursement, milestone-based release, or payment upon liquidation of prior advance.',
    `post_distribution_monitoring_ref` STRING COMMENT 'Reference identifier linking this disbursement to a Post-Distribution Monitoring (PDM) exercise conducted to verify that funds reached intended beneficiaries and were used for approved purposes. Supports accountability and learning under the Core Humanitarian Standard (CHS).',
    `request_date` DATE COMMENT 'Date on which the implementing partner submitted the disbursement request or the grants team initiated the payment request. Marks the start of the disbursement approval workflow.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or URL to the supporting documentation package for this disbursement, including disbursement request form, bank transfer confirmation, financial report, or liquidation report stored in the document management system.',
    `tranche_number` STRING COMMENT 'Sequential tranche number identifying this disbursement within the overall sub-award payment schedule. Enables tracking of phased funding releases against milestone-based or time-based disbursement plans.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this disbursement record in the source system. Supports data lineage tracking, change detection in the Databricks Silver Layer, and audit compliance under OMB Uniform Guidance.',
    `withholding_amount` DECIMAL(18,2) COMMENT 'Amount withheld from the gross disbursement (e.g., performance-based retention, tax withholding, or compliance hold) before net transfer to the implementing partner. Null or zero if no withholding applies.',
    CONSTRAINT pk_sub_award_disbursement PRIMARY KEY(`sub_award_disbursement_id`)
) COMMENT 'Records individual disbursement transactions to sub-awardees or grantees. Supports both humanitarian IP transfers (HACT modalities) and foundation/501(c)(3) grantmaking-out disbursements with board authorization tracking, net asset release accounting (ASC 958), and endowment-funded grant payments.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award` (
    `award_id` BIGINT COMMENT 'Unique identifier for the grant award record. Primary key for the award entity.',
    `constituent_id` BIGINT COMMENT 'Reference to the institutional donor or funding agency that issued this award (USAID, BHA, DFID, CERF, UN agencies, foundations, corporates).',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Awards are managed and implemented by country offices. Core to operational structure, financial management, country-level portfolio analysis, compliance oversight, and donor relationship management at',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Awards are designated to specific restricted donor funds for FASB ASC 958 net asset classification, fund balance management, and restriction release reporting. Grant accountants require award-to-fund ',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: An award is directly funded by a specific funding source (government donor, foundation, corporate sponsor). This is a fundamental grant management relationship required for financial reporting, IATI c',
    `intervention_id` BIGINT COMMENT 'FK to program.intervention.intervention_id — MUST-HAVE: Cannot link grants to the programs they fund without this join. Essential for BvA reporting, donor reporting, and program-grant traceability.',
    `country_id` BIGINT COMMENT 'The three-letter ISO 3166-1 alpha-3 country code for the primary country of implementation.',
    `program_id` BIGINT COMMENT 'Foreign key linking to program.program. Business justification: Award portfolio management: NGOs must report total funding secured per program for strategic planning and board reporting. Award links to intervention but not the parent program. A grants manager woul',
    `solicitation_id` BIGINT COMMENT 'Foreign key linking to grant.solicitation. Business justification: An award is the result of a successful solicitation/funding opportunity. While the proposal table links award to solicitation indirectly, a direct award.solicitation_id -> solicitation FK is essential',
    `advance_payment_allowed` BOOLEAN COMMENT 'Indicates whether the donor allows advance payments or if reimbursement-only is required.',
    `agreement_signed_date` DATE COMMENT 'The date on which the award agreement was signed by both the donor and the NGO.',
    `amendment_count` STRING COMMENT 'The total number of amendments or modifications made to the original award agreement.',
    `audit_required` BOOLEAN COMMENT 'Indicates whether the award requires a specific audit (e.g., A-133 single audit, donor-specific audit).',
    `audit_threshold_amount` DECIMAL(18,2) COMMENT 'The expenditure threshold that triggers audit requirements under this award.',
    `authorized_amount` DECIMAL(18,2) COMMENT 'The maximum amount authorized for expenditure under this award, which may differ from the obligated amount due to amendments or modifications.',
    `award_number` STRING COMMENT 'The externally-known unique award number assigned by the donor or funding agency. This is the official reference number used in all donor communications and reporting.',
    `award_status` STRING COMMENT 'Current lifecycle status of the award: pipeline (anticipated), active (in execution), no-cost extension (extended without additional funds), suspended, or closed.. Valid values are `pipeline|active|no_cost_extension|suspended|closed`',
    `award_type` STRING COMMENT 'The classification of the funding mechanism: cooperative agreement, contract, grant, sub-award, consortium lead, or consortium member.. Valid values are `cooperative_agreement|contract|grant|sub_award|consortium_lead|consortium_member`',
    `board_approval_date` DATE COMMENT 'Date the board approved the award/outbound grant.',
    `board_approval_required` BOOLEAN COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `board_approval_required_flag` BOOLEAN COMMENT 'True if board governance approval is required for this award.',
    `board_resolution_reference` STRING COMMENT 'Board resolution authorizing the award/grant.',
    `branding_marking_requirements` STRING COMMENT 'Donor-specific requirements for branding, marking, and visibility of donor support in program materials and communications.',
    `closeout_date` DATE COMMENT 'The date on which the award was officially closed out after all financial and programmatic reporting requirements were completed.',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'The total amount of cost-sharing required from the NGO in the award currency.',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of total project costs that must be contributed by the NGO as cost-sharing, expressed as a decimal.',
    `cost_share_required` BOOLEAN COMMENT 'Indicates whether the award requires the NGO to provide cost-sharing or matching funds.',
    `currency` STRING COMMENT 'The three-letter ISO 4217 currency code in which the award amount is denominated.. Valid values are `^[A-Z]{3}$`',
    `dac_sector_code` STRING COMMENT 'The OECD DAC 5-digit sector code classifying the purpose of the award.',
    `direction` STRING COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `donor_reference_number` STRING COMMENT 'The donors internal reference or tracking number for this award, distinct from the award number.',
    `end_date` DATE COMMENT 'The official end date of the award period of performance, including any approved extensions.',
    `endowment_draw_amount` DECIMAL(18,2) COMMENT 'Endowment spending-policy draw applied to fund this award.',
    `endowment_funded_flag` BOOLEAN COMMENT 'True if award is funded from endowment investment returns.',
    `endowment_spending_policy_rate` DECIMAL(18,2) COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `exchange_rate_to_functional` DECIMAL(18,2) COMMENT 'The exchange rate used to convert the award currency to the NGOs functional currency for accounting purposes.',
    `form_990_schedule_reference` STRING COMMENT 'Business justification: ASC 958 (US GAAP for Nonprofits); IRS Form 990',
    `functional_currency` STRING COMMENT 'The three-letter ISO 4217 currency code of the NGOs functional currency for financial reporting.. Valid values are `^[A-Z]{3}$`',
    `fund_restriction_class` STRING COMMENT 'ASC 958 / IPSAS net asset class: unrestricted, temporarily restricted, permanently restricted/endowment.',
    `fund_restriction_type` STRING COMMENT 'Classification of the award funds as unrestricted, temporarily restricted, or permanently restricted per ASC 958 accounting standards.. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `funding_mechanism` STRING COMMENT 'The specific funding instrument or mechanism used by the donor (e.g., bilateral grant, multilateral pooled fund, emergency response fund).',
    `geographic_scope` STRING COMMENT 'The geographic area or countries covered by this award (e.g., single country, regional, global).',
    `grant_direction` STRING COMMENT 'Whether award is grant-in (received) or grant-out (made to grantees) for foundation/grantmaking flows.',
    `grantmaking_program_area` STRING COMMENT 'Foundation/501c3 grantmaking program area for outbound grants.',
    `indirect_cost_ceiling` DECIMAL(18,2) COMMENT 'The maximum indirect cost rate allowed by the donor for this award, expressed as a decimal.',
    `is_endowment_funded` BOOLEAN COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `is_grant_made_out` BOOLEAN COMMENT 'True if this is an outbound grant the org makes to a grantee (grantmaking-out).',
    `last_amendment_date` DATE COMMENT 'The date of the most recent amendment or modification to the award agreement.',
    `net_asset_classification` STRING COMMENT 'Net asset class per ASC 958/IPSAS: without donor restrictions / with donor restrictions.',
    `nicra_icr_rate` DECIMAL(18,2) COMMENT 'The negotiated indirect cost rate applicable to this award, expressed as a decimal (e.g., 0.1500 for 15%).',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the award.',
    `notification_date` DATE COMMENT 'The date on which the NGO received official notification of the award from the donor.',
    `original_end_date` DATE COMMENT 'The original end date specified in the initial award agreement, before any no-cost extensions or amendments.',
    `payment_method` DECIMAL(18,2) COMMENT 'The payment method specified in the award: advance, reimbursement, milestone-based, or hybrid.',
    `period_of_performance_months` STRING COMMENT 'The total duration of the award period of performance expressed in months.',
    `regulatory_framework` STRING COMMENT 'The applicable regulatory framework governing this award (e.g., 2 CFR 200, USAID ADS, DFID Smart Rules, UN Financial Regulations).',
    `reporting_frequency` STRING COMMENT 'The frequency at which financial and programmatic reports must be submitted to the donor.. Valid values are `monthly|quarterly|semi_annual|annual|final_only`',
    `sdg_alignment` STRING COMMENT 'The primary UN Sustainable Development Goal(s) that this award contributes to.',
    `special_conditions` STRING COMMENT 'Any special conditions, restrictions, or requirements imposed by the donor on this award.',
    `start_date` DATE COMMENT 'The official start date of the award period of performance as specified in the award agreement.',
    `tax_exempt_purpose_code` STRING COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `thematic_sector` STRING COMMENT 'The primary thematic sector or focus area of the award (e.g., WASH, health, education, protection, food security).',
    `title` STRING COMMENT 'The official title or name of the grant award as stated in the award agreement.',
    `total_obligated_amount` DECIMAL(18,2) COMMENT 'The total amount of funds obligated by the donor under this award in the award currency.',
    `total_obligated_amount_functional` DECIMAL(18,2) COMMENT 'The total obligated amount converted to the NGOs functional currency using the exchange rate.',
    CONSTRAINT pk_award PRIMARY KEY(`award_id`)
) COMMENT 'Represents a grant or cooperative agreement award (inbound or outbound). Supports humanitarian awards, US 501(c)(3) grantmaking-out flows, foundation program-related investments, board-governed endowment draws, and membership-funded awards. award_direction distinguishes grants-received from grants-made. Covers ASC 958 net asset classification, IPSAS revenue recognition, Form 990 Schedule I/F reporting, and board governance approval workflows.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`proposal` (
    `proposal_id` BIGINT COMMENT 'Unique identifier for the grant proposal or concept note submission. Primary key for the proposal data product.',
    `award_id` BIGINT COMMENT 'Reference to the resulting grant award entity if this proposal was successful. Links the proposal to the executed grant agreement for lifecycle tracking.',
    `component_id` BIGINT COMMENT 'Reference to the program or thematic area this proposal supports. Links to the program master entity for strategic alignment tracking.',
    `constituent_id` BIGINT COMMENT 'Reference to the donor organization or funding body to whom this proposal is submitted. Links to the donor master entity.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Proposals are prepared and submitted by country offices. Fundamental for tracking BD pipeline by geography, country-level win rates, proposal workload management, and resource allocation for proposal ',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Outbound grantmaking proposals reference the donor fund from which the grant will be made. Fund-level grantmaking pipeline reporting requires this link. Development officers need to know which restric',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: A proposal targets a specific funding source. While inbound proposals link to a solicitation (which has funding_source_id), outbound grantmaking proposals (is_outbound_grant_application = true) may no',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Proposals that win awards result in specific interventions. Essential for business development learning, proposal effectiveness tracking, and win/loss analysis. Tracks which proposal led to which impl',
    `major_gift_opportunity_id` BIGINT COMMENT 'Foreign key linking to donor.major_gift_opportunity. Business justification: A major gift opportunity (cultivation/solicitation stage) frequently results in a formal grant proposal. Linking proposal to originating major gift opportunity enables cross-domain pipeline reporting ',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Proposals reference donor-mandated logframes during design phase. Proposal writers must align technical approach with donors results framework and indicator requirements specified in RFP logframe tem',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Business development teams track which implementing partner is named in each proposal. Required for pipeline reporting by partner and consortium proposal management. grantee_organization_name is a den',
    `program_id` BIGINT COMMENT 'Foreign key linking to program.program. Business justification: Business development pipeline management: NGOs track which program each proposal is written for to report funding pipeline by program, prioritize go/no-go decisions, and allocate BD resources. Proposa',
    `solicitation_id` BIGINT COMMENT 'Reference to the donor solicitation or funding opportunity this proposal responds to. Links to the solicitation entity for RFA, RFP, NOFO tracking. Null for unsolicited proposals.',
    `applicant_tax_exempt_status` STRING COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `award_notification_date` DATE COMMENT 'Date the organization was officially notified of the award decision by the donor. Null if proposal was not awarded or decision is still pending.',
    `board_approval_status` STRING COMMENT 'Board/grants committee approval status.',
    `board_committee_review_date` DATE COMMENT 'Date the board/grants committee reviewed the proposal.',
    `board_review_date` DATE COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `board_review_required` BOOLEAN COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `board_review_required_flag` BOOLEAN COMMENT 'True if board/committee review required before grant decision.',
    `business_development_owner` STRING COMMENT 'Name or identifier of the business development staff member responsible for managing this proposal opportunity and donor relationship.',
    `compliance_review_completed` BOOLEAN COMMENT 'Boolean flag indicating whether compliance and risk review was completed before submission. Ensures adherence to donor regulations and organizational policies.',
    `consortium_lead_organization` STRING COMMENT 'Name of the lead organization if this proposal is part of a consortium or joint application. Null if organization is the prime or applying solo.',
    `cost_proposal_summary` DECIMAL(18,2) COMMENT 'Summary of the cost proposal structure, including major budget categories, cost-sharing arrangements, and indirect cost rate applied. Provides financial overview without detailed line items.',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Total cost-sharing or matching contribution committed by the organization or partners, expressed in the proposal currency. Represents non-donor funding sources.',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'Cost-sharing contribution as a percentage of the total project budget. Calculated as cost share amount divided by total project cost.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this proposal record was first created in the system. Audit trail for record creation.',
    `direction` STRING COMMENT 'inbound (we apply) or outbound (grantee applies to us) for grantmaking foundations.',
    `document_reference` STRING COMMENT 'File path, document management system reference, or URL to the submitted proposal document package. Enables retrieval of the full proposal for audit and reference.',
    `geographic_focus` STRING COMMENT 'Primary country or region where the proposed intervention will be implemented. May include multiple countries for regional proposals.',
    `go_no_go_decision` STRING COMMENT 'Internal decision on whether to pursue this funding opportunity. Tracks strategic alignment, capacity assessment, and risk evaluation outcomes.. Valid values are `go|no_go|pending`',
    `go_no_go_decision_date` DATE COMMENT 'Date the internal go/no-go decision was made regarding pursuit of this funding opportunity.',
    `grantmaking_direction` STRING COMMENT 'Direction of grant flow: inbound (received) vs outbound/grantmaking-out (foundation grants to grantees).',
    `grantmaking_focus_area` STRING COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `grantmaking_program_area` STRING COMMENT 'Foundation grantmaking program area for the proposed grant.',
    `indirect_cost_rate_proposed` DECIMAL(18,2) COMMENT 'Indirect cost rate (ICR) or facilities and administration (F&A) rate proposed in the budget, expressed as a percentage. May reference the organizations NICRA (Negotiated Indirect Cost Rate Agreement).',
    `internal_review_date` DATE COMMENT 'Date the proposal completed internal review and was approved for submission by organizational leadership or review committee.',
    `is_outbound_grant_application` BOOLEAN COMMENT 'True if this represents an outbound grantmaking application received from a grantee.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this proposal record was last updated. Audit trail for record modification tracking.',
    `lead_proposal_writer` STRING COMMENT 'Name or identifier of the staff member who served as the lead technical writer for this proposal. Used for workload tracking and expertise mapping.',
    `lead_technical_sector` STRING COMMENT 'Primary technical sector or thematic area for the proposed intervention (e.g., WASH, Health, Education, Protection, Livelihoods, GBV, Nutrition). Aligns with DAC sector codes and organizational program taxonomy.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the proposal submission, donor feedback, or internal lessons learned.',
    `partnership_model` STRING COMMENT 'Organizational role and partnership structure for this proposal. Indicates whether the organization is applying as prime recipient, sub-awardee, consortium member, joint venture partner, or solo applicant.. Valid values are `prime|sub_award|consortium|joint_venture|solo`',
    `program_officer_recommendation` STRING COMMENT 'Program officers recommendation for outbound grant decision.',
    `proposal_status` STRING COMMENT 'Current lifecycle status of the proposal. Tracks progression from draft through internal review, submission, donor review, shortlisting, and final outcome (awarded, rejected, or withdrawn). [ENUM-REF-CANDIDATE: draft|internal_review|submitted|under_review|shortlisted|awarded|rejected|withdrawn — 8 candidates stripped; promote to reference product]',
    `proposal_type` STRING COMMENT 'Classification of the proposal submission format and stage. Indicates whether this is a full application, concept note, expression of interest, unsolicited submission, pre-proposal, or letter of inquiry.. Valid values are `full_application|concept_note|expression_of_interest|unsolicited|pre_proposal|letter_of_inquiry`',
    `proposed_duration_months` STRING COMMENT 'Total duration of the proposed project period of performance expressed in months. Calculated from proposed start and end dates.',
    `proposed_end_date` DATE COMMENT 'Proposed end date for the period of performance if the grant is awarded. Marks the conclusion of the planned implementation timeline.',
    `proposed_start_date` DATE COMMENT 'Proposed start date for the period of performance if the grant is awarded. Marks the beginning of the planned implementation timeline.',
    `reference_number` STRING COMMENT 'Externally-known unique reference number or code assigned to this proposal for tracking and communication with the donor. May include organizational prefix and year.',
    `rejection_reason` STRING COMMENT 'Primary reason provided by the donor for proposal rejection, or internal assessment of why the proposal was not successful. Used for lessons learned and win-rate improvement analysis.',
    `requested_amount` DECIMAL(18,2) COMMENT 'Total funding amount requested from the donor in the proposal currency. Represents the gross budget request before any donor adjustments or negotiations.',
    `requested_amount_usd` DECIMAL(18,2) COMMENT 'Total funding amount requested converted to USD using the exchange rate at submission date. Enables cross-proposal comparison and pipeline analysis in a common currency.',
    `requested_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the requested funding amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `submission_date` DATE COMMENT 'Date the proposal was officially submitted to the donor or funding body. Represents the principal business event timestamp for this transaction.',
    `target_beneficiary_count` STRING COMMENT 'Estimated number of direct beneficiaries the proposed project aims to reach. Used for cost-per-beneficiary analysis and impact projections.',
    `technical_approach_summary` STRING COMMENT 'High-level summary of the proposed technical approach, methodology, and intervention strategy. Captures key elements of the Theory of Change (ToC) and implementation plan.',
    `title` STRING COMMENT 'Full title of the grant proposal or concept note as submitted to the donor. Describes the proposed intervention or project.',
    `win_loss_outcome` STRING COMMENT 'Final outcome of the proposal submission. Indicates whether the proposal was won (awarded), lost (rejected), is still pending donor decision, or was withdrawn by the organization.. Valid values are `won|lost|pending|withdrawn`',
    CONSTRAINT pk_proposal PRIMARY KEY(`proposal_id`)
) COMMENT 'Captures both inbound proposal submissions (responding to solicitations) and outbound grantmaking applications (foundation/501(c)(3) issuing grants). Supports board review workflows, program officer recommendations, grantee due diligence, and tax-exempt status verification for grantmaking-out flows.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award_budget` (
    `award_budget_id` BIGINT COMMENT 'Unique identifier for the award budget record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the parent grant award for which this budget is defined.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Award budgets are managed, reviewed, and approved at the country office level. Country directors sign off on budget submissions and revisions; country-office-level budget reporting is a core NGO finan',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Award budgets are prepared against specific donor funds to enforce spending within fund restrictions. Fund-level budget vs. actual reporting and donor stewardship require this link. NGO finance teams ',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: An award budget is associated with a specific funding source, which governs allowable cost categories, indirect cost rates (NICRA), fund restriction types, and budget flexibility rules. In co-funded a',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Award budget allocation: NGO finance teams structure award budgets by intervention for financial reporting and budget vs. actuals tracking. award_budget_line has intervention_id but the parent award_b',
    `approved_by` STRING COMMENT 'Name or identifier of the internal authority (e.g., Finance Director, Executive Director) who approved this budget for submission to the donor.',
    `award_currency` STRING COMMENT 'Three-letter ISO 4217 currency code in which the budget is denominated (e.g., USD, EUR, GBP). This is the donor-facing currency.. Valid values are `^[A-Z]{3}$`',
    `budget_narrative_reference` DECIMAL(18,2) COMMENT 'Reference identifier or document location for the detailed budget narrative that explains and justifies each budget line item. Typically a document management system reference.',
    `budget_notes` DECIMAL(18,2) COMMENT 'Free-text field for additional notes, clarifications, or special conditions related to this budget version.',
    `budget_period` DECIMAL(18,2) COMMENT 'The budget period this budget covers, typically expressed as Year 1, Year 2, etc., or Period 1, Period 2, etc., or Full Award Period for multi-year consolidated budgets.',
    `budget_period_end_date` DATE COMMENT 'The end date of the budget period covered by this budget.',
    `budget_period_start_date` DATE COMMENT 'The start date of the budget period covered by this budget.',
    `budget_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the budget. Draft indicates internal preparation; Submitted indicates sent to donor; Under Review indicates donor is reviewing; Approved indicates donor has approved; Amended indicates a revision has been made; Superseded indicates replaced by a newer version; Closed indicates budget period has ended. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|amended|superseded|closed — 7 candidates stripped; promote to reference product]',
    `budget_submission_date` DATE COMMENT 'The date this budget version was submitted to the donor for review and approval.',
    `budget_version_number` STRING COMMENT 'Sequential version number of the budget. Increments with each amendment or revision. Version 1 is the original approved budget.',
    `contractual_costs` DECIMAL(18,2) COMMENT 'Approved budget for sub-awards to implementing partners and consultant fees.',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'The total cost share (matching funds) amount committed by the organization for this budget period, if cost sharing is required.',
    `cost_share_required` BOOLEAN COMMENT 'Indicates whether the donor requires cost sharing (matching funds) for this budget period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was first created in the system.',
    `donor_approval_date` DATE COMMENT 'The date the donor officially approved this budget version.',
    `donor_approval_reference` STRING COMMENT 'Reference number or document identifier for the donors formal approval of this budget (e.g., award letter number, amendment approval letter).',
    `endowment_draw_amount` DECIMAL(18,2) COMMENT 'Portion of budget funded by endowment spending draw.',
    `equipment_costs` DECIMAL(18,2) COMMENT 'Approved budget for equipment purchases (typically items with acquisition cost of $5,000 or more and useful life of more than one year, per donor definition).',
    `fringe_benefits_costs` DECIMAL(18,2) COMMENT 'Approved budget for fringe benefits associated with personnel costs (health insurance, retirement, payroll taxes, etc.).',
    `fund_restriction_type` STRING COMMENT 'Classification of the funds according to donor restrictions. Unrestricted funds have no donor-imposed restrictions; Temporarily Restricted funds have purpose or time restrictions; Permanently Restricted funds must be maintained in perpetuity.. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `indirect_cost_base` DECIMAL(18,2) COMMENT 'The cost base to which the NICRA rate is applied. Common bases include Modified Total Direct Costs (MTDC), Total Direct Costs, or Salaries and Wages.',
    `is_amendment` BOOLEAN COMMENT 'Flag indicating whether this budget version is an amendment to a previously approved budget (True) or the original budget (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget record was last updated in the system.',
    `net_asset_classification` STRING COMMENT 'Budget net asset class per ASC 958/IPSAS (with/without donor restrictions).',
    `nicra_rate_applied` DECIMAL(18,2) COMMENT 'The indirect cost rate (expressed as a percentage) applied to calculate F&A costs. This is the rate from the organizations NICRA with the cognizant federal agency.',
    `personnel_costs` DECIMAL(18,2) COMMENT 'Approved budget for salaries and wages of staff directly working on the grant.',
    `prepared_by` STRING COMMENT 'Name or identifier of the staff member who prepared this budget version.',
    `supplies_costs` DECIMAL(18,2) COMMENT 'Approved budget for supplies and consumables used in grant activities (items below equipment threshold).',
    `total_approved_budget` DECIMAL(18,2) COMMENT 'The total approved budget amount for this budget period in the award currency. Sum of all direct and indirect costs.',
    `total_direct_costs` DECIMAL(18,2) COMMENT 'Sum of all direct cost categories (personnel, fringe, travel, equipment, supplies, contractual, other direct costs) approved for this budget period.',
    `total_indirect_costs` DECIMAL(18,2) COMMENT 'Total indirect costs (Facilities and Administration / F&A) approved for this budget period. Calculated by applying the NICRA rate to the approved direct cost base.',
    `travel_costs` DECIMAL(18,2) COMMENT 'Approved budget for domestic and international travel expenses directly related to grant activities.',
    CONSTRAINT pk_award_budget PRIMARY KEY(`award_budget_id`)
) COMMENT 'Budget associated with an award, covering both inbound donor-funded budgets and outbound grantmaking budget allocations. Tracks net asset classification (without donor restrictions, with donor restrictions, board-designated) and endowment draw amounts for foundation grantmaking.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` (
    `award_budget_line_id` BIGINT COMMENT 'Unique identifier for the award budget line item. Primary key for this entity.',
    `award_budget_id` BIGINT COMMENT 'Reference to the budget period (fiscal year or project phase) to which this line item applies.',
    `award_id` BIGINT COMMENT 'Reference to the parent grant award under which this budget line is authorized.',
    `component_id` BIGINT COMMENT 'Reference to the program or project that this budget line supports, enabling program-level budget tracking and reporting.',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: Budget lines allocate resources to indicator data collection activities. MEL budget lines (surveys, assessments, evaluations) are directly tied to specific indicators they measure, enabling cost-per-i',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Award budget lines must map to specific program interventions for cost allocation, financial reporting, and budget vs. actual analysis. Essential for donor financial reports requiring intervention-lev',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Budget lines are allocated to specific project sites for site-level financial management and donor geographic reporting. NGO finance teams track planned vs. actual expenditure per site; this link enab',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Budget lines within an award budget can be allocated to specific subawards/implementing partners. In NGO grant management, the award budget is often broken down by implementing partner (subaward), all',
    `allocability_flag` BOOLEAN COMMENT 'Indicates whether costs charged to this budget line are allocable to the grant award in accordance with relative benefits received, per OMB Uniform Guidance 2 CFR 200.405.',
    `allowability_flag` BOOLEAN COMMENT 'Indicates whether this budget line item is allowable under applicable donor regulations (OMB Uniform Guidance 2 CFR 200 Subpart E, USAID ADS). True if allowable; False if unallowable or requires special approval.',
    `approval_date` DATE COMMENT 'Date on which this budget line was approved by the donor or authorized signatory as part of the award agreement or amendment.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Original approved budget amount for this line item as authorized in the initial grant award agreement.',
    `approved_amount_usd` DECIMAL(18,2) COMMENT 'Approved budget amount converted to United States Dollars for standardized reporting and analysis.',
    `budget_line_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the budget line item within the award budget structure.',
    `cost_category` DECIMAL(18,2) COMMENT 'Primary classification of the budget line according to standard cost categories defined by OMB Uniform Guidance 2 CFR 200 Subpart E and donor regulations. [ENUM-REF-CANDIDATE: personnel|fringe_benefits|travel|equipment|supplies|contractual|other_direct_costs|indirect_costs|subaward — 9 candidates stripped; promote to reference product]',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'Amount of cost sharing or matching contribution committed for this budget line. Null if no cost share is required.',
    `cost_share_required_flag` BOOLEAN COMMENT 'Indicates whether this budget line requires cost sharing or matching funds from the organization or other non-federal sources, per donor agreement terms.',
    `cost_subcategory` DECIMAL(18,2) COMMENT 'Secondary classification providing granular detail within the cost category (e.g., international travel, local travel, office supplies, medical supplies).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget line record was first created in the system.',
    `cumulative_expenditure` DECIMAL(18,2) COMMENT 'Total actual expenditure incurred against this budget line from award inception through the current reporting period.',
    `cumulative_expenditure_usd` DECIMAL(18,2) COMMENT 'Cumulative expenditure converted to United States Dollars for standardized variance analysis and donor reporting.',
    `donor_reporting_category` STRING COMMENT 'Donor-specific classification or reporting code required for financial reports submitted to the funding agency (e.g., BHA, USAID, DFID, CERF).',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert local currency amounts to USD for donor reporting, if applicable. Null for USD-denominated budgets.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month, quarter, or custom period) within the fiscal year to which this budget line applies.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this budget line applies, aligned with the organizations or donors fiscal calendar.',
    `fund_restriction_type` STRING COMMENT 'Classification of donor-imposed restrictions on the use of funds for this budget line, per FASB ASC 958 (Not-for-Profit Entities).. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `indirect_cost_amount` DECIMAL(18,2) COMMENT 'Calculated indirect cost (facilities and administration) amount allocated to this budget line based on the applied NICRA rate.',
    `line_description` STRING COMMENT 'Detailed narrative description of the budget line item, explaining the purpose, scope, and justification for the budgeted expenditure.',
    `line_item_code` STRING COMMENT 'Unique alphanumeric code identifying this budget line within the award budget structure, often aligned with donor or organizational chart of accounts.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this budget line record was last modified in the system.',
    `nicra_rate_applied` DECIMAL(18,2) COMMENT 'Indirect cost rate (ICR) applied to this budget line, as specified in the organizations NICRA or the de minimis rate under 2 CFR 200.414. Expressed as a decimal (e.g., 0.10 for 10%).',
    `notes` STRING COMMENT 'Additional notes, comments, or clarifications related to this budget line item for internal tracking and audit purposes.',
    `quantity` DECIMAL(18,2) COMMENT 'Planned quantity of the unit of measure for this budget line (e.g., 12 person-months, 500 units). Null for non-quantifiable line items.',
    `reasonableness_flag` BOOLEAN COMMENT 'Indicates whether the budgeted amount is reasonable and does not exceed what a prudent person would incur under similar circumstances, per OMB Uniform Guidance 2 CFR 200.404.',
    `revised_amount` DECIMAL(18,2) COMMENT 'Current authorized budget amount for this line item after any approved amendments, budget reallocations, or modifications. Null if no revisions have occurred.',
    `revised_amount_usd` DECIMAL(18,2) COMMENT 'Revised budget amount converted to United States Dollars. Null if no revisions have occurred.',
    `revision_date` DATE COMMENT 'Date of the most recent budget revision or amendment affecting this line item. Null if no revisions have occurred.',
    `revision_reason` STRING COMMENT 'Narrative explanation for the most recent budget revision, including justification and donor approval reference.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation for this budget line (e.g., quotes, justifications, donor correspondence).',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of measure for this budget line. Null for non-quantifiable line items.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantifiable budget line items (e.g., person-months, units, trips, days), if applicable.',
    `variance_amount` DECIMAL(18,2) COMMENT 'Difference between the current authorized budget (revised or approved) and cumulative expenditure. Positive indicates under-spend; negative indicates over-spend.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance expressed as a percentage of the current authorized budget, used for burn-rate monitoring and budget-versus-actual (BvA) analysis.',
    CONSTRAINT pk_award_budget_line PRIMARY KEY(`award_budget_line_id`)
) COMMENT 'Individual line items within an award budget. Supports standard humanitarian cost categories, US federal cost principles (2 CFR 200), and foundation grantmaking line-item tracking with net asset release classification.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`subaward` (
    `subaward_id` BIGINT COMMENT 'Unique identifier for the subaward record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the prime grant award under which this subaward is issued. Links to the parent grant that provides the funding source.',
    `capacity_assessment_id` BIGINT COMMENT 'Foreign key linking to partnership.capacity_assessment. Business justification: The capacity assessment determines subaward type, payment modality, and monitoring requirements. Program and finance teams must trace which capacity assessment informed each subaward structure. Requir',
    `component_id` BIGINT COMMENT 'Foreign key linking to program.component. Business justification: Sub-award structuring: NGOs issue subawards against specific program components (e.g., a protection component funded by a subaward). sub_award_disbursement links component_id but subaward itself does ',
    `country_id` BIGINT COMMENT 'Foreign key linking to field.country. Business justification: Subawards require country-level attribution for FFATA reporting, ODA/DAC classification, and geographic financial tracking. FFATA mandates country-of-performance reporting for subawards; this FK enabl',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Subawards are administered by the responsible country office, which manages partner compliance monitoring, site visits, and reporting. Country-office-level subaward portfolio management is a core NGO ',
    `due_diligence_record_id` BIGINT COMMENT 'Foreign key linking to partnership.due_diligence_record. Business justification: USAID, EU, and UN regulations require NGOs to document which due diligence record authorized each subaward execution. Grants compliance teams must link the specific clearance record to the subaward fo',
    `intervention_id` BIGINT COMMENT 'Reference to the program under which this subaward is executed. Links the subaward to the programmatic context and objectives.',
    `partner_org_id` BIGINT COMMENT 'Reference to the implementing partner organization (CBO, local NGO, contractor) receiving the subaward. The subrecipient entity.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Subawards to local partners are frequently tied to specific geographic sites where the partner implements activities. Critical for consortium management, site-level budget tracking, and partner perfor',
    `amendment_count` STRING COMMENT 'The total number of amendments or modifications issued to this subaward. Tracks the change history of the subaward.',
    `approval_date` DATE COMMENT 'The date when the subaward was approved by the authorized approving authority within the NGO.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the subaward on behalf of the NGO.',
    `board_approval_date` DATE COMMENT 'Board approval date for the outbound grant/subaward.',
    `board_designation` STRING COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `closeout_date` DATE COMMENT 'The date when the subaward was officially closed out after all deliverables, reports, and financial reconciliations were completed.',
    `cost_share_amount` DECIMAL(18,2) COMMENT 'The required cost share or matching contribution amount from the implementing partner, if applicable.',
    `cost_share_required_flag` BOOLEAN COMMENT 'Indicates whether the implementing partner is required to provide cost share or matching funds as a condition of the subaward.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this subaward record was first created in the system. Audit trail for record creation.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the subaward amount. Defines the currency in which the subaward is denominated.. Valid values are `^[A-Z]{3}$`',
    `subaward_description` STRING COMMENT 'Detailed narrative description of the subaward scope, objectives, deliverables, and expected outcomes.',
    `disbursed_amount` DECIMAL(18,2) COMMENT 'The cumulative amount disbursed to the implementing partner to date. Tracks actual cash transferred against the obligated amount.',
    `duns_number` STRING COMMENT 'The nine-digit DUNS number of the implementing partner organization. Required for FFATA reporting and federal subawards.. Valid values are `^[0-9]{9}$`',
    `equivalency_determination_required` BOOLEAN COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `execution_date` DATE COMMENT 'The date when the subaward agreement was signed and executed by both parties. Represents the legal effective date of the subaward.',
    `expenditure_responsibility_flag` BOOLEAN COMMENT 'True if IRS expenditure responsibility applies (private foundation grantmaking).',
    `expenditure_responsibility_required` BOOLEAN COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `ffata_reporting_required_flag` BOOLEAN COMMENT 'Indicates whether this subaward is subject to FFATA reporting requirements (typically subawards of $30,000 or more from federal sources).',
    `flow_down_requirements` STRING COMMENT 'Narrative description of the prime award terms and conditions that must be flowed down to the subrecipient, including compliance obligations, reporting requirements, and audit provisions.',
    `fsrs_report_date` DATE COMMENT 'The date when the subaward was reported to the FFATA Subaward Reporting System (FSRS), if applicable.',
    `fund_restriction_class` STRING COMMENT 'Net asset class of funds disbursed (unrestricted/restricted/endowment).',
    `fund_restriction_type` STRING COMMENT 'Classification of the funding restriction level per ASC 958 nonprofit accounting standards. Indicates donor-imposed restrictions on the use of funds.. Valid values are `unrestricted|temporarily restricted|permanently restricted`',
    `grant_program_area` STRING COMMENT 'Grantmaking program area for the outbound grant.',
    `grant_purpose_statement` STRING COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `grantee_board_attestation_flag` BOOLEAN COMMENT 'Grantee governing board attestation/501c3 status received.',
    `grantee_organization_name` STRING COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `grantee_type` STRING COMMENT 'Type of grantee: nonprofit, fiscal_sponsor, individual, government.',
    `indirect_cost_base` DECIMAL(18,2) COMMENT 'The cost base to which the indirect cost rate is applied (e.g., Modified Total Direct Costs, Total Direct Costs, Salaries and Wages).',
    `indirect_cost_rate` DECIMAL(18,2) COMMENT 'The approved indirect cost rate (ICR) or Negotiated Indirect Cost Rate Agreement (NICRA) rate applicable to the implementing partner for this subaward, expressed as a percentage.',
    `is_charitable_grant_out` BOOLEAN COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `is_grantmaking_out` BOOLEAN COMMENT 'True if this subaward is an outbound grant (grantmaking-out) by a foundation/501c3.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this subaward record was last modified in the system. Audit trail for record updates.',
    `monitoring_frequency` STRING COMMENT 'The required frequency of monitoring activities for this subaward, based on risk rating and donor requirements.. Valid values are `quarterly|semi-annually|annually|as-needed|continuous`',
    `net_asset_release_classification` STRING COMMENT 'Net asset release classification on grant payout per ASC 958/IPSAS.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the subaward. Free-text field for capturing contextual information.',
    `obligated_amount` DECIMAL(18,2) COMMENT 'The current total obligated amount under the subaward, including any amendments. May differ from the original total subaward amount due to modifications.',
    `payment_method` DECIMAL(18,2) COMMENT 'The method by which payments are made to the implementing partner under this subaward.',
    `payment_schedule` DECIMAL(18,2) COMMENT 'The schedule or basis on which payments are made to the implementing partner (e.g., advance, reimbursement, milestone-based).',
    `period_of_performance_end_date` DATE COMMENT 'The date when the subaward period of performance ends. Defines the end of the implementing partners authorized work period.',
    `period_of_performance_start_date` DATE COMMENT 'The date when the subaward period of performance begins. Defines the start of the implementing partners authorized work period.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'The remaining unspent balance of the subaward. Calculated as obligated amount minus disbursed amount.',
    `reporting_frequency` STRING COMMENT 'The required frequency of programmatic and financial reports from the implementing partner.. Valid values are `monthly|quarterly|semi-annually|annually|as-needed`',
    `risk_rating` STRING COMMENT 'The assessed risk level of the implementing partner for this subaward. Determines the level of monitoring and oversight required.. Valid values are `low|medium|high|critical`',
    `single_audit_required_flag` BOOLEAN COMMENT 'Indicates whether the implementing partner is required to undergo a Single Audit per 2 CFR 200 Subpart F based on federal expenditure thresholds.',
    `subaward_number` STRING COMMENT 'The externally-known unique business identifier for this subaward. Used in all legal documents, reporting, and correspondence.',
    `subaward_status` STRING COMMENT 'Current lifecycle status of the subaward. Tracks the subaward from initial draft through active performance to closeout.. Valid values are `draft|pending approval|active|suspended|terminated|closed`',
    `subaward_type` STRING COMMENT 'Classification of the subaward instrument type. Determines the legal and compliance framework applicable to the subaward.. Valid values are `sub-grant|subcontract|fixed-obligation grant|cooperative agreement|cost-reimbursable|other`',
    `termination_date` DATE COMMENT 'The date when the subaward was terminated, if applicable. Used when the subaward is ended prior to the planned end date.',
    `termination_reason` STRING COMMENT 'Narrative explanation of the reason for subaward termination, if applicable. Documents the circumstances and justification for early termination.',
    `title` STRING COMMENT 'Descriptive title of the subaward that summarizes the scope of work or project purpose.',
    `total_subaward_amount` DECIMAL(18,2) COMMENT 'The total obligated amount of the subaward in the subaward currency. Represents the maximum financial obligation to the implementing partner.',
    `total_subaward_amount_usd` DECIMAL(18,2) COMMENT 'The total subaward amount converted to USD for consolidated reporting and analysis. Conversion uses the exchange rate at the time of subaward execution.',
    `uei_number` STRING COMMENT 'The twelve-character alphanumeric Unique Entity Identifier assigned to the implementing partner by SAM.gov. Replaces DUNS for federal reporting.. Valid values are `^[A-Z0-9]{12}$`',
    CONSTRAINT pk_subaward PRIMARY KEY(`subaward_id`)
) COMMENT 'Sub-awards issued to implementing partners or grantee organizations. Supports humanitarian sub-grants, foundation grantmaking-out (charitable grants to 501(c)(3) organizations), expenditure responsibility grants to non-US entities, equivalency determination requirements, and board-designated grant purposes.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`donor_condition` (
    `donor_condition_id` BIGINT COMMENT 'Unique identifier for the donor condition record. Primary key for the donor_condition data product.',
    `award_id` BIGINT COMMENT 'Reference to the grant award to which this donor condition is attached.',
    `constituent_id` BIGINT COMMENT 'Reference to the donor organization that imposed this condition.',
    `evaluation_id` BIGINT COMMENT 'Foreign key linking to mel.evaluation. Business justification: Donor conditions mandate specific evaluations (midterm, endline, impact). Conditions specify evaluation timing, methodology, evaluator qualifications, and deliverable requirements that drive evaluatio',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Donor compliance tracking: Donor conditions (safeguarding requirements, reporting milestones, audit triggers) are frequently scoped to specific interventions. donor_condition links to award but not in',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Donor conditions are frequently partner-specific (e.g., a partner must pass due diligence before funds release). Compliance teams track which partner must fulfill each condition. No existing column on',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Donor conditions (facility standards, site visit requirements, infrastructure benchmarks) are tied to specific project sites. Compliance monitoring teams track site-specific condition status; this FK ',
    `reporting_period_id` BIGINT COMMENT 'Foreign key linking to mel.reporting_period. Business justification: Donor conditions with compliance deadlines are monitored and reported within MEL reporting periods. Linking enables period-based compliance dashboards and automated escalation when conditions are unme',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Donor conditions can be specific to a sub-award through flow-down requirements. When a prime award has conditions (e.g., audit requirements, reporting obligations, expenditure responsibility), these c',
    `actual_completion_date` DATE COMMENT 'The date on which the donor condition was actually met or the required action was completed. Null if the condition is not yet met.',
    `approval_authority` STRING COMMENT 'The entity or role that has the authority to approve or waive this condition (e.g., Donor Grants Officer, Chief Financial Officer, USAID Agreement Officer).',
    `approval_date` DATE COMMENT 'The date on which the required approval was granted by the approval authority. Null if approval is not yet obtained or not applicable.',
    `approval_reference_number` STRING COMMENT 'Reference number or identifier for the formal approval document or communication (e.g., approval letter number, email reference).',
    `compliance_notes` STRING COMMENT 'Free-text field for internal notes, observations, or action items related to the management and fulfillment of this donor condition.',
    `compliance_status` STRING COMMENT 'Current lifecycle status of the donor condition. Values: open (condition active, not yet addressed), in_progress (work underway to meet condition), met (condition fully satisfied), waived (donor formally waived the condition), expired (condition no longer applicable due to grant closure or time lapse), overdue (condition past due date and not met).. Valid values are `open|in_progress|met|waived|expired|overdue`',
    `condition_category` STRING COMMENT 'Broader categorization of the condition by functional area. Values: financial (budget, cost, financial reporting), programmatic (deliverables, milestones, beneficiary targets), administrative (staffing, procurement, subcontracting), compliance (regulatory, legal, policy adherence), safeguarding (protection, GBV prevention, child safeguarding), environmental (environmental impact, WASH standards).. Valid values are `financial|programmatic|administrative|compliance|safeguarding|environmental`',
    `condition_description` STRING COMMENT 'Detailed narrative description of the donor condition, including specific requirements, deliverables, thresholds, and any contextual information provided by the donor.',
    `condition_reference_number` STRING COMMENT 'Externally-known unique identifier or code assigned to this donor condition by the donor or grant management system (e.g., SAC-2024-001, COND-BHA-45).',
    `condition_title` STRING COMMENT 'Short, human-readable title or summary of the donor condition (e.g., Quarterly Financial Report Submission, Prior Approval for Subawards Over $100K).',
    `condition_type` STRING COMMENT 'Classification of the donor condition indicating the nature of the compliance obligation. Values: prior_approval_requirement (donor must approve before action), restricted_cost (specific cost category restrictions), reporting_obligation (scheduled or ad-hoc reporting requirement), key_personnel_approval (approval required for key staff changes), branding_marking_requirement (logo, attribution, visibility requirements), audit_requirement (financial or programmatic audit mandate).. Valid values are `prior_approval_requirement|restricted_cost|reporting_obligation|key_personnel_approval|branding_marking_requirement|audit_requirement`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this donor condition record was first created in the system.',
    `deliverable_description` STRING COMMENT 'Detailed description of the specific deliverable, report, approval, or action required to satisfy this condition.',
    `donor_contact_email` STRING COMMENT 'Email address of the donor representative responsible for this condition.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `donor_contact_name` STRING COMMENT 'Name of the donor representative or grants officer who is the point of contact for questions or clarifications regarding this condition.',
    `due_date` DATE COMMENT 'The date by which the donor condition must be satisfied or the required action must be completed. Null if the condition has no specific deadline.',
    `endowment_restriction_flag` BOOLEAN COMMENT 'True when condition imposes an endowment/permanent restriction.',
    `escalation_threshold_days` STRING COMMENT 'Number of days before the due date when this condition should be escalated to senior management or flagged for urgent attention.',
    `financial_threshold_amount` DECIMAL(18,2) COMMENT 'Monetary threshold associated with this condition (e.g., prior approval required for subawards exceeding $100,000). Null if the condition does not have a financial threshold.',
    `financial_threshold_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial threshold amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `is_board_governance_condition` BOOLEAN COMMENT 'True when condition relates to board governance/oversight requirements.',
    `is_membership_condition` BOOLEAN COMMENT 'True when condition relates to membership/dues obligations.',
    `is_special_award_condition` BOOLEAN COMMENT 'Boolean flag indicating whether this condition is a Special Award Condition (SAC) imposed by the donor due to identified risks or past performance issues. True if this is a SAC, False otherwise.',
    `last_review_date` DATE COMMENT 'The date on which this donor condition was last reviewed by the responsible staff or compliance team.',
    `membership_category` STRING COMMENT 'Membership tier/category associated with the condition for membership-based nonprofits.',
    `membership_dues_related_flag` BOOLEAN COMMENT 'Indicates this condition pertains to membership or dues obligations (membership organizations).',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this donor condition record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this donor condition record was last updated or modified.',
    `monitoring_frequency` STRING COMMENT 'How frequently the organization monitors progress toward meeting this condition. Values: daily, weekly, monthly, quarterly, as_needed.. Valid values are `daily|weekly|monthly|quarterly|as_needed`',
    `net_asset_restriction_implication` STRING COMMENT 'Net asset restriction implication (temporarily/permanently restricted) of the condition.',
    `next_recurrence_date` DATE COMMENT 'For recurring conditions, the date of the next scheduled occurrence or deadline. Null for one-time conditions.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review of this donor condition.',
    `priority_level` STRING COMMENT 'Business priority assigned to this condition based on risk, donor emphasis, or organizational impact. Values: critical (non-compliance could result in grant suspension or termination), high (significant risk or donor focus), medium (standard condition), low (minor or administrative condition).. Valid values are `critical|high|medium|low`',
    `recurrence_frequency` STRING COMMENT 'Indicates whether this condition is a one-time requirement or recurs on a regular schedule. Values: one_time (single occurrence), monthly, quarterly, semi_annually, annually, as_needed (triggered by specific events).. Valid values are `one_time|monthly|quarterly|semi_annually|annually|as_needed`',
    `regulatory_citation` STRING COMMENT 'Reference to the specific regulatory or policy section that mandates or governs this condition (e.g., 2 CFR 200.308, USAID ADS 303.3.10, DFID Smart Rule 4.2.3).',
    `requires_board_action_flag` BOOLEAN COMMENT 'True if condition compliance requires board governance action.',
    `responsible_department` STRING COMMENT 'The organizational department or functional unit responsible for managing and fulfilling this donor condition (e.g., Finance, Programs, Compliance, MEL).',
    `risk_rating` STRING COMMENT 'Assessment of the risk to the organization if this condition is not met. Values: low (minimal impact), medium (moderate impact on grant or reputation), high (significant financial or programmatic risk), critical (could result in grant termination or legal action).. Valid values are `low|medium|high|critical`',
    `sac_justification` STRING COMMENT 'Narrative explanation provided by the donor for why this Special Award Condition was imposed, including any identified risks or deficiencies.',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation related to this condition (e.g., approval letters, waiver memos, compliance evidence, submitted reports).',
    `waiver_date` DATE COMMENT 'The date on which the donor formally waived this condition. Null if the condition was not waived.',
    `waiver_justification` STRING COMMENT 'Narrative explanation provided by the donor or documented by the organization for why the condition was waived.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this donor condition record.',
    CONSTRAINT pk_donor_condition PRIMARY KEY(`donor_condition_id`)
) COMMENT 'Conditions imposed by donors/funders on awards. Extends to board governance conditions, membership-related conditions, endowment restriction requirements, and net asset classification implications for nonprofit compliance.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`donor_report` (
    `donor_report_id` BIGINT COMMENT 'Unique identifier for the donor report submission record. Primary key.',
    `award_id` BIGINT COMMENT 'Reference to the grant award for which this report is submitted.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Donor reports are prepared and submitted by the responsible country office; country directors certify compliance. Country-office-level reporting dashboards and submission tracking are standard NGO gra',
    `distribution_plan_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_plan. Business justification: NGO donor reports for supply/distribution programs must reference the specific distribution plan being reported on — linking planned vs. actual beneficiary counts, distribution modality, and geographi',
    `intervention_id` BIGINT COMMENT 'Foreign key linking to program.intervention. Business justification: Donor reports often cover specific interventions and require intervention-level narrative and results reporting. Essential for programmatic donor reports that must reference the intervention(s) being ',
    `mel_logframe_id` BIGINT COMMENT 'Foreign key linking to mel.mel_logframe. Business justification: Donor narrative reports are structured around the logframe — output/outcome/impact sections map directly to logframe levels. Direct FK enables automated report generation from logframe data and ensure',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Donor reports in multi-partner awards are often partner-specific. Grant managers and auditors need to filter donor reports by implementing partner for compliance reporting and partner performance trac',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to field.project_site. Business justification: Donor narrative reports routinely reference specific implementation sites for activity verification, beneficiary reach validation, and geographic accountability. Essential for site-level performance r',
    `subaward_id` BIGINT COMMENT 'Foreign key linking to grant.subaward. Business justification: Donor reports can be submitted specifically for a sub-award rather than the entire prime award. In humanitarian and development NGO operations, sub-award financial and narrative reports are a distinct',
    `approval_date` DATE COMMENT 'The date on which the donor report was internally approved for submission to the donor.',
    `audit_findings_count` STRING COMMENT 'Number of audit findings or compliance issues identified by internal or external auditors related to this reporting period, if applicable.',
    `beneficiaries_reached` STRING COMMENT 'Total number of unique beneficiaries or persons of concern (PoC) reached or served during the reporting period, as reported to the donor.',
    `board_reported_flag` BOOLEAN COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'The difference between the budgeted amount and the actual expenditure for the reporting period, calculated as actual minus budget (positive indicates overspend, negative indicates underspend).',
    `budget_variance_percentage` DECIMAL(18,2) COMMENT 'The budget variance expressed as a percentage of the budgeted amount, calculated as (actual - budget) / budget * 100.',
    `compliance_certification_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the responsible staff member has certified that this report complies with all donor requirements, grant terms, and applicable regulations (True = certified, False = not certified).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this donor report record was first created in the system.',
    `cumulative_expenditure_to_date` DECIMAL(18,2) COMMENT 'Total cumulative expenditure reported to the donor from the grant start date through the end of this reporting period.',
    `days_overdue` STRING COMMENT 'Number of calendar days by which the report submission was late, calculated as submission date minus due date. Null or zero if submitted on time.',
    `donor_acceptance_date` DATE COMMENT 'The date on which the donor formally accepted or approved this report submission, marking it as satisfactory and compliant.',
    `donor_feedback_summary` DECIMAL(18,2) COMMENT 'Summary of feedback, comments, or recommendations provided by the donor in response to this report submission.',
    `due_date` DATE COMMENT 'The deadline by which this donor report must be submitted to the donor, as specified in the grant agreement or donor compliance schedule.',
    `endowment_draw_reported_amount` DECIMAL(18,2) COMMENT 'Endowment spending draw reported in the period.',
    `exchange_rate_used` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the reported financial amount from the grant currency to USD, if applicable.',
    `financial_amount_reported` DECIMAL(18,2) COMMENT 'Total financial expenditure or disbursement amount reported to the donor for the reporting period, in the grant currency.',
    `financial_amount_reported_usd` DECIMAL(18,2) COMMENT 'Total financial expenditure or disbursement amount reported to the donor, converted to United States Dollars (USD) for standardized reporting and analysis.',
    `financial_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the financial amounts reported in this donor report (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `grantmaking_disbursed_amount` DECIMAL(18,2) COMMENT 'Outbound grant funds disbursed to grantees in the period.',
    `is_final_version` BOOLEAN COMMENT 'Boolean flag indicating whether this version of the donor report is the final, accepted version (True) or an interim/draft version (False).',
    `is_overdue` BOOLEAN COMMENT 'Boolean flag indicating whether this donor report was submitted after its due date (True = overdue, False = submitted on time or not yet due).',
    `key_performance_indicators_met` STRING COMMENT 'Number of Key Performance Indicators (KPIs) or LogFrame indicators that met or exceeded their targets during the reporting period.',
    `key_performance_indicators_total` DECIMAL(18,2) COMMENT 'Total number of Key Performance Indicators (KPIs) or LogFrame indicators being tracked and reported for this grant during the reporting period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this donor report record was last updated or modified in the system.',
    `narrative_summary` STRING COMMENT 'Textual summary of programmatic activities, achievements, challenges, and lessons learned during the reporting period, as required by the donor.',
    `net_asset_release_amount` DECIMAL(18,2) COMMENT 'Amount released from restriction in the reporting period (ASC 958 / IPSAS).',
    `report_notes` STRING COMMENT 'Free-text field for internal notes, special circumstances, or additional context related to this donor report submission.',
    `report_reference_number` STRING COMMENT 'Externally-known unique identifier or tracking number for this donor report submission, often assigned by the donor or grant management system.',
    `report_status` STRING COMMENT 'Current lifecycle status of the donor report: upcoming (not yet started), draft (in preparation), submitted (sent to donor), under review (donor reviewing), accepted (approved by donor), revision requested (donor requested changes), or final (closed and archived). [ENUM-REF-CANDIDATE: Upcoming|Draft|Submitted|Under Review|Accepted|Revision Requested|Final — 7 candidates stripped; promote to reference product]',
    `report_type` STRING COMMENT 'Classification of the donor report by its purpose and format, such as SF-425 Federal Financial Report, quarterly programmatic report, annual narrative, situation report (SitRep), final closeout report, or IATI transparency disclosure.. Valid values are `SF-425 Federal Financial Report|Quarterly Programmatic|Annual Narrative|SitRep|Final Report|IATI Disclosure`',
    `reporting_frequency` STRING COMMENT 'Scheduled frequency at which this type of report must be submitted to the donor, such as monthly, quarterly, semi-annual, annual, ad hoc, or final (one-time closeout).. Valid values are `Monthly|Quarterly|Semi-Annual|Annual|Ad Hoc|Final`',
    `reporting_period_end_date` DATE COMMENT 'The last day of the period covered by this donor report (e.g., end of the quarter or fiscal year).',
    `reporting_period_start_date` DATE COMMENT 'The first day of the period covered by this donor report (e.g., start of the quarter or fiscal year).',
    `revision_reason` STRING COMMENT 'Narrative explanation provided by the donor for why revisions were requested, including specific feedback or areas requiring correction.',
    `revision_requested_date` DATE COMMENT 'The date on which the donor requested revisions or additional information for this report, if applicable.',
    `submission_date` DATE COMMENT 'The actual date on which the donor report was submitted to the donor.',
    `submission_method` STRING COMMENT 'The channel or system through which the donor report was submitted, such as email, donor web portal, USAID ASIST system, DFID ARIES platform, CERF portal, or manual upload.. Valid values are `Email|Donor Portal|USAID ASIST|DFID ARIES|CERF Portal|Manual Upload`',
    `supporting_document_reference` STRING COMMENT 'Reference identifier or file path to supporting documentation attached to this donor report, such as financial statements, beneficiary lists, field photos, or monitoring data.',
    `version_number` STRING COMMENT 'Sequential version number of this donor report submission, incremented each time a revised version is submitted (e.g., 1 for initial submission, 2 for first revision).',
    CONSTRAINT pk_donor_report PRIMARY KEY(`donor_report_id`)
) COMMENT 'Reports submitted to donors/funders or board of directors. Covers humanitarian donor reporting, foundation grantmaking disbursement reports, endowment draw reporting, board-level financial summaries, and Form 990 Schedule I/F data preparation.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`funding_source` (
    `funding_source_id` BIGINT COMMENT 'Unique identifier for the funding source record. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to field.country. Business justification: Funding sources have geographic restrictions tied to specific countries; the `geographic_restriction` attribute signals this. Country-level funding eligibility screening and ODA/DAC classification by ',
    `partner_org_id` BIGINT COMMENT 'Reference to the donor organization that provides this funding source. Links to the institutional donor entity in the donor domain.',
    `advance_payment_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether this funding source permits advance payments or cash advances to be disbursed before costs are incurred. Affects cash flow management and liquidity planning.',
    `allowable_cost_categories` DECIMAL(18,2) COMMENT 'Comma-separated list of cost categories or Chart of Accounts codes that are allowable under this funding source (e.g., personnel, travel, equipment, supplies). Used to enforce budget compliance and prevent unallowable cost charges.',
    `audit_requirement` STRING COMMENT 'The type of audit required by the donor for grants funded by this source. Single audit refers to OMB Uniform Guidance 2 CFR 200 Subpart F audits; program-specific audit refers to audits of individual programs; financial audit refers to organization-wide financial statement audits; no audit required indicates the donor does not mandate an audit.. Valid values are `single_audit|program_specific_audit|financial_audit|no_audit_required`',
    `board_designated_flag` BOOLEAN COMMENT 'True if funds are board-designated (quasi-endowment) rather than donor-restricted.',
    `budget_flexibility` DECIMAL(18,2) COMMENT 'Classification of the degree of budget flexibility allowed by the donor for grants funded by this source. Fixed budgets require donor approval for any changes; flexible within categories allows reallocation within cost categories; flexible with approval allows reallocation with prior donor consent; fully flexible allows unrestricted reallocation.',
    `budget_revision_threshold` DECIMAL(18,2) COMMENT 'The percentage threshold (expressed as a decimal, e.g., 0.1000 for 10%) above which budget revisions or reallocations require prior donor approval. Null if no threshold applies.',
    `funding_source_category` STRING COMMENT 'Category: grant, membership_dues, endowment, individual_gift, foundation, government.',
    `closeout_period_days` STRING COMMENT 'The number of calendar days after the grant end date within which all closeout activities (final reports, financial reconciliation, asset disposition) must be completed for grants funded by this source.',
    `funding_source_code` STRING COMMENT 'The unique alphanumeric code or identifier assigned to this funding source by the donor organization or internal grant management system for tracking and reporting purposes.',
    `compliance_framework` STRING COMMENT 'Comma-separated list of regulatory and compliance frameworks that govern the use of this funding source (e.g., OMB Uniform Guidance 2 CFR 200, USAID Standard Provisions, DFID Terms and Conditions, CERF Grant Agreement). Used to segment compliance obligations by funding source.',
    `contact_email` STRING COMMENT 'The email address of the primary contact person at the donor organization for this funding source. Used for grant administration communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'The name of the primary contact person at the donor organization responsible for this funding source. Used for relationship management and grant administration inquiries.',
    `contact_phone` STRING COMMENT 'The phone number of the primary contact person at the donor organization for this funding source. Used for urgent grant administration inquiries.',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'The percentage of total project costs that must be provided as cost-sharing or matching funds (expressed as a decimal, e.g., 0.2500 for 25%). Null if no cost-sharing is required.',
    `cost_share_required` BOOLEAN COMMENT 'Boolean flag indicating whether this funding source requires the organization to provide cost-sharing or matching funds as a condition of the grant award.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this funding source record was first created in the grant management system. Used for audit trail and data lineage tracking.',
    `funding_source_description` STRING COMMENT 'Detailed narrative description of the funding source, including its purpose, strategic priorities, target beneficiary populations, and any special conditions or donor intent. Used for internal reference and proposal development.',
    `donor_reporting_frequency` STRING COMMENT 'The frequency at which the donor organization requires narrative and financial reports for grants funded by this source. Drives reporting calendar and compliance tracking.. Valid values are `monthly|quarterly|semi_annually|annually|upon_request|milestone_based`',
    `endowment_corpus_amount` DECIMAL(18,2) COMMENT 'Original endowment corpus/principal amount.',
    `endowment_fund_flag` BOOLEAN COMMENT 'Indicates the funding source is an endowment (permanently/temporarily restricted net assets, ASC 958).',
    `endowment_market_value` DECIMAL(18,2) COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `endowment_spending_policy_rate` DECIMAL(18,2) COMMENT 'Annual endowment spending policy draw rate (e.g. 0.0450 for a 4.5% UPMIFA draw).',
    `endowment_spending_rate` DECIMAL(18,2) COMMENT 'Endowment spending policy rate applied to the fund.',
    `fund_restriction_type` STRING COMMENT 'Classification of the funding source according to donor-imposed restrictions per ASC 958 (Not-for-Profit Entities). Unrestricted funds have no donor-imposed restrictions; temporarily restricted funds have time or purpose restrictions that may expire; permanently restricted funds have perpetual restrictions (e.g., endowments).. Valid values are `unrestricted|temporarily_restricted|permanently_restricted`',
    `funding_end_date` DATE COMMENT 'The date on which this funding source expires or is no longer available for new grant awards. Represents the end of the funding period. Nullable for open-ended funding sources.',
    `funding_mechanism_type` STRING COMMENT 'Classification of the funding mechanism through which resources are provided. Distinguishes between Official Development Assistance (ODA) bilateral and multilateral channels, foundation grants, corporate philanthropy, Central Emergency Response Fund (CERF) pooled funds, government contracts, private donations, and endowment income. [ENUM-REF-CANDIDATE: oda_bilateral|oda_multilateral|foundation_grant|corporate_philanthropy|cerf_pooled_fund|government_contract|private_donation|endowment_income — 8 candidates stripped; promote to reference product]',
    `funding_source_status` STRING COMMENT 'Current lifecycle status of the funding source indicating whether it is actively available for grant awards, temporarily suspended, permanently closed, pending activation, or under review.. Valid values are `active|suspended|closed|pending_activation|under_review`',
    `funding_start_date` DATE COMMENT 'The date from which this funding source becomes available for grant awards and disbursements. Represents the beginning of the funding period.',
    `geographic_restriction` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes or regional designations indicating geographic areas where this funding source may be used. Empty if no geographic restrictions apply.',
    `iati_organization_identifier` STRING COMMENT 'The globally unique IATI organization identifier for the donor organization providing this funding source. Enables cross-organizational aid transparency reporting and data exchange.',
    `indirect_cost_rate_type` DECIMAL(18,2) COMMENT 'The type of indirect cost rate mechanism applicable to this funding source. NICRA refers to a formally negotiated rate; de minimis refers to the 10% rate allowed under 2 CFR 200.414(f); cost reimbursement, fixed rate, and negotiated rate represent other donor-specific mechanisms.',
    `is_endowment_source` BOOLEAN COMMENT 'True when the funding source is an endowment/quasi-endowment fund.',
    `is_endowment_source_flag` BOOLEAN COMMENT 'True if this funding source is an endowment corpus or its investment return.',
    `is_membership_dues_flag` BOOLEAN COMMENT 'True if this funding source represents membership dues revenue.',
    `is_membership_dues_source` BOOLEAN COMMENT 'True when funding originates from membership dues/subscriptions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this funding source record was last updated in the grant management system. Used for audit trail and change tracking.',
    `membership_dues_period` STRING COMMENT 'Membership dues recurrence period (annual, monthly).',
    `funding_source_name` STRING COMMENT 'The official name of the funding source or funding mechanism as recognized by the donor organization and used in grant agreements.',
    `net_asset_classification` STRING COMMENT 'Net asset class per ASC 958 / IPSAS framing.',
    `nicra_rate` DECIMAL(18,2) COMMENT 'The negotiated indirect cost rate (expressed as a decimal, e.g., 0.1500 for 15%) applicable to this funding source for recovering facilities and administration costs. Used for US federal grants under OMB Uniform Guidance 2 CFR 200.',
    `oda_dac_classification` STRING COMMENT 'The OECD Development Assistance Committee classification code for this funding source if it qualifies as Official Development Assistance. Used for international aid transparency and reporting to DAC member countries.',
    `payment_method` DECIMAL(18,2) COMMENT 'The standard payment method used by the donor organization to disburse funds from this funding source (e.g., wire transfer, ACH, check, letter of credit, direct deposit, pooled fund transfer).',
    `procurement_standards` STRING COMMENT 'Description of the procurement and contracting standards that must be followed when using this funding source (e.g., OMB Uniform Guidance 2 CFR 200.318-200.326, USAID Mandatory Standard Provisions, DFID Procurement Guidelines). Ensures compliance with donor procurement rules.',
    `program_income_treatment` STRING COMMENT 'The method by which program income earned under grants funded by this source must be treated per OMB Uniform Guidance 2 CFR 200.307. Addition means income is added to the grant; deduction means income reduces the donor share; cost-sharing means income is used to meet cost-share requirements; no program income indicates the funding source does not generate program income.. Valid values are `addition|deduction|cost_sharing|no_program_income`',
    `record_retention_years` STRING COMMENT 'The number of years that financial and programmatic records for grants funded by this source must be retained after grant closeout, as required by the donor or applicable regulations (e.g., OMB Uniform Guidance requires 3 years).',
    `sdg_alignment_codes` STRING COMMENT 'Comma-separated list of United Nations Sustainable Development Goal codes (e.g., SDG 1, SDG 3, SDG 5) that this funding source is aligned with or restricted to support. Enables portfolio analysis by SDG impact area.',
    `source_category` STRING COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `subaward_allowed` BOOLEAN COMMENT 'Boolean flag indicating whether this funding source permits the organization to issue subawards or subgrants to implementing partners and community-based organizations.',
    `subaward_approval_required` BOOLEAN COMMENT 'Boolean flag indicating whether the donor organization must provide prior written approval before the organization can issue subawards using this funding source.',
    `thematic_restriction` STRING COMMENT 'Description of thematic or sectoral restrictions on the use of this funding source (e.g., WASH programs only, education initiatives, health services, emergency response). Empty if no thematic restrictions apply.',
    `total_funding_available` DECIMAL(18,2) COMMENT 'The total amount of funding available from this source across all grant awards, expressed in the funding source currency. May represent a ceiling or allocation limit.',
    `unallowable_cost_categories` DECIMAL(18,2) COMMENT 'Comma-separated list of cost categories or Chart of Accounts codes that are explicitly unallowable under this funding source (e.g., alcohol, entertainment, lobbying). Used to enforce budget compliance and prevent unallowable cost charges.',
    CONSTRAINT pk_funding_source PRIMARY KEY(`funding_source_id`)
) COMMENT 'Master record of funding sources including government donors, private foundations, corporate sponsors, endowment corpus, membership dues revenue, and board-designated funds. Tracks net asset classification (ASC 958), endowment spending policy rates, and membership dues periodicity.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`grant`.`solicitation` (
    `solicitation_id` BIGINT COMMENT 'Unique identifier for the donor solicitation or funding opportunity record. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to field.country. Business justification: Solicitations have country-level geographic eligibility; country-level go/no-go screening and eligibility determination are named business processes in NGO business development. The `geographic_eligib',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Solicitations are identified, tracked, and pursued by country offices as part of business development pipeline. Essential for BD workload allocation, country-level funding forecasts, and proposal prep',
    `fund_id` BIGINT COMMENT 'Foreign key linking to donor.donor_fund. Business justification: Outbound grantmaking solicitations (is_grantmaking_rfp=true) draw from a specific board-designated or restricted donor fund. Linking solicitation to donor_fund enables fund-level grantmaking pipeline ',
    `funding_source_id` BIGINT COMMENT 'Foreign key linking to grant.funding_source. Business justification: Solicitations are issued under specific funding sources/mechanisms. Currently solicitation has issuing_donor_name (string) which should be normalized to a FK relationship. Adding funding_source_id all',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: RFPs/RFAs specify mandatory donor indicators applicants must commit to tracking. Business development teams assess organizational capacity to collect data for required indicators during go/no-go decis',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: Solicitations (RFPs, funding opportunities) issued by specific donor organizations. Links to constituent for tracking issuing donor, managing donor relationships, and analyzing funding opportunity sou',
    `program_id` BIGINT COMMENT 'Foreign key linking to program.program. Business justification: Funding opportunity pipeline: NGOs assign solicitations to programs during business development to track which programs have active funding opportunities. This enables program-level pipeline reporting',
    `anticipated_award_date` DATE COMMENT 'Expected date on which the donor will announce award decisions, as stated in the solicitation or estimated by the organization.',
    `anticipated_start_date` DATE COMMENT 'Expected start date for program implementation if the grant is awarded, as specified in the solicitation.',
    `application_deadline` TIMESTAMP COMMENT 'Date and time by which proposals or applications must be submitted. Critical for proposal pipeline planning and resource allocation.',
    `board_authorized_funding_pool` DECIMAL(18,2) COMMENT 'Board-authorized total funding pool for this solicitation.',
    `competitive_intelligence_notes` STRING COMMENT 'Internal notes on competitive landscape, known competitors, incumbent organizations, partnership opportunities, and strategic considerations for this solicitation. Business-confidential information.',
    `consortium_allowed` BOOLEAN COMMENT 'Indicates whether the solicitation permits or encourages consortium or partnership applications.',
    `contact_email` STRING COMMENT 'Email address of the donor point of contact for solicitation inquiries. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Name of the donor point of contact for questions about the solicitation.',
    `cost_share_percentage` DECIMAL(18,2) COMMENT 'Required percentage of total project cost that must be contributed by the applicant as cost-share or match, if applicable.',
    `cost_share_required` BOOLEAN COMMENT 'Indicates whether the solicitation requires cost-sharing or matching funds from the applicant organization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this solicitation record was first created in the system.',
    `dac_sector_code` STRING COMMENT 'OECD Development Assistance Committee (DAC) sector classification code for this solicitation (e.g., 140 - Water Supply & Sanitation, 120 - Health, 111 - Education).',
    `eligibility_criteria` STRING COMMENT 'Summary of organizational eligibility requirements (e.g., 501(c)(3) status, registration in specific countries, minimum years of operational experience, financial capacity thresholds, consortium requirements).',
    `eligible_org_tax_status` STRING COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `estimated_funding_amount` DECIMAL(18,2) COMMENT 'Total estimated funding available under this solicitation, expressed in the donors currency. May represent a range or ceiling amount.',
    `estimated_number_of_awards` STRING COMMENT 'Expected number of grants or contracts the donor intends to award under this solicitation. Null if not specified.',
    `funding_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated funding amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `geographic_eligibility` STRING COMMENT 'Countries, regions, or geographic areas eligible for funding under this solicitation. Uses ISO 3166-1 alpha-3 country codes where applicable (e.g., SYR, YEM, ETH, Global, Sub-Saharan Africa).',
    `go_no_go_decision_date` DATE COMMENT 'Date on which the internal go/no-go decision was made regarding pursuit of this solicitation.',
    `go_no_go_rationale` DOUBLE COMMENT 'Summary of the strategic rationale for the go or no-go decision, including alignment with organizational mission, capacity, competitive positioning, and resource availability.',
    `grantmaking_focus_area` STRING COMMENT 'Focus area of the grantmaking solicitation.',
    `identified_by` STRING COMMENT 'Name or identifier of the staff member or business development team member who identified this solicitation opportunity.',
    `identified_date` DATE COMMENT 'Date on which this solicitation was first identified and entered into the organizations opportunity tracking system.',
    `indirect_cost_rate_allowed` BOOLEAN COMMENT 'Indicates whether the donor allows recovery of indirect costs (NICRA/ICR/F&A) in the budget.',
    `indirect_cost_rate_cap` DECIMAL(18,2) COMMENT 'Maximum allowable indirect cost rate as a percentage, if the donor imposes a cap (e.g., 10% de minimis rate under 2 CFR 200.414).',
    `internal_priority_score` STRING COMMENT 'Internal scoring or ranking assigned to this solicitation based on strategic fit, likelihood of success, and resource availability. Scale and methodology defined by organizational business development process.',
    `is_grantmaking_rfp` BOOLEAN COMMENT 'Business justification: IATI Activity Standard v2.03 (budget, transaction); 2 CFR 200 Uniform Guidance; ASC 958 (US GAAP); IPSAS 23 Revenue from Non-Exchange Transactions',
    `is_outbound_grantmaking_flag` BOOLEAN COMMENT 'True if the org is issuing this solicitation to prospective grantees (grantmaking-out).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this solicitation record was last updated or modified.',
    `local_partner_requirement` STRING COMMENT 'Description of any requirements for local or national NGO partnership, localization commitments, or sub-award percentages to local organizations.',
    `notes` STRING COMMENT 'General internal notes, observations, or additional context about this solicitation that do not fit other structured fields.',
    `program_duration_months` STRING COMMENT 'Expected duration of the funded program in months, as specified in the solicitation.',
    `publication_date` DATE COMMENT 'Date on which the solicitation was officially published or announced by the donor.',
    `questions_deadline` TIMESTAMP COMMENT 'Deadline by which applicants must submit questions to the donor regarding the solicitation.',
    `sdg_alignment` STRING COMMENT 'Sustainable Development Goals (SDGs) that this solicitation explicitly aligns with or contributes to (e.g., SDG 1, SDG 2, SDG 3, SDG 5, SDG 6). Multiple goals may be listed.',
    `solicitation_number` STRING COMMENT 'External reference number assigned by the donor or issuing agency (e.g., RFA-2024-001, NOFO-BHA-2024-12, RFP-DFID-2024-WASH). This is the official identifier used in all donor communications and proposal submissions.',
    `solicitation_status` STRING COMMENT 'Current status of the solicitation in the organizations business development pipeline: Identified (opportunity discovered), Evaluating (under internal review), Go (decision to pursue), No-Go (decision not to pursue), Submitted (proposal submitted), Closed (deadline passed), Awarded (grant awarded to any organization), Cancelled (donor cancelled solicitation). [ENUM-REF-CANDIDATE: Identified|Evaluating|Go|No-Go|Submitted|Closed|Awarded|Cancelled — 8 candidates stripped; promote to reference product]',
    `solicitation_type` STRING COMMENT 'Classification of the funding opportunity mechanism: Request for Applications (RFA), Request for Proposals (RFP), Notice of Funding Opportunity (NOFO), Invitation to Tender (ITT), Expression of Interest (EOI), Concept Note solicitation, Direct Award notification, or Unsolicited opportunity. [ENUM-REF-CANDIDATE: RFA|RFP|NOFO|ITT|EOI|Concept Note|Direct Award|Unsolicited — 8 candidates stripped; promote to reference product]',
    `submission_method` STRING COMMENT 'Required method for submitting the proposal or application (e.g., Online Portal, Email, Grants.gov, Physical Mail, Courier, Hybrid).. Valid values are `Online Portal|Email|Physical Mail|Grants.gov|Courier|Hybrid`',
    `submission_requirements` STRING COMMENT 'Summary of required documents and formats for proposal submission (e.g., technical proposal, budget narrative, organizational capacity statement, past performance references, certifications, page limits).',
    `thematic_focus_area` STRING COMMENT 'Primary programmatic theme or sector focus of the solicitation (e.g., WASH, Health, Education, Food Security, Protection, GBV Prevention, Livelihoods, Emergency Response). May include multiple themes separated by semicolons.',
    `title` STRING COMMENT 'Full official title of the funding opportunity as published by the donor or issuing agency.',
    `url` STRING COMMENT 'Web link to the official solicitation document or announcement on the donors website or grants portal.',
    CONSTRAINT pk_solicitation PRIMARY KEY(`solicitation_id`)
) COMMENT 'Funding opportunities tracked for pursuit (inbound) or issued as RFPs for grantmaking-out (outbound). Supports foundation program officers issuing calls for proposals, board-authorized funding pools, and eligible organization tax status requirements.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ADD CONSTRAINT `fk_grant_sub_award_disbursement_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ADD CONSTRAINT `fk_grant_award_solicitation_id` FOREIGN KEY (`solicitation_id`) REFERENCES `vibe_ngo_v1`.`grant`.`solicitation`(`solicitation_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ADD CONSTRAINT `fk_grant_proposal_solicitation_id` FOREIGN KEY (`solicitation_id`) REFERENCES `vibe_ngo_v1`.`grant`.`solicitation`(`solicitation_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ADD CONSTRAINT `fk_grant_award_budget_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_award_budget_id` FOREIGN KEY (`award_budget_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award_budget`(`award_budget_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ADD CONSTRAINT `fk_grant_award_budget_line_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ADD CONSTRAINT `fk_grant_subaward_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ADD CONSTRAINT `fk_grant_donor_condition_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_award_id` FOREIGN KEY (`award_id`) REFERENCES `vibe_ngo_v1`.`grant`.`award`(`award_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ADD CONSTRAINT `fk_grant_donor_report_subaward_id` FOREIGN KEY (`subaward_id`) REFERENCES `vibe_ngo_v1`.`grant`.`subaward`(`subaward_id`);
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ADD CONSTRAINT `fk_grant_solicitation_funding_source_id` FOREIGN KEY (`funding_source_id`) REFERENCES `vibe_ngo_v1`.`grant`.`funding_source`(`funding_source_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`grant` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_ngo_v1`.`grant` SET TAGS ('dbx_domain' = 'grant');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `sub_award_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Sub-Award Disbursement ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `award_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `award_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `component_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `component_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `emergency_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Partner ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Sub-Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `subaward_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `subaward_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `advance_balance_outstanding` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Advance Balance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `advance_balance_outstanding` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `advance_balance_outstanding` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `advance_balance_outstanding` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `advance_balance_outstanding` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approval_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approval_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approved_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approved_by` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `approved_by` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `bank_transfer_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Transfer Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `bank_transfer_reference` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `bank_transfer_reference` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `bank_transfer_reference` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `board_authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Board Authorization Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `board_authorization_reference` SET TAGS ('dbx_nonprofit_profile' = 'board_governance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `cost_category` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `cost_category` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_amount_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_amount_usd` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_amount_usd` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_currency` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_currency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_currency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_method` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_notes` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_notes` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_notes` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_reference_number` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_reference_number` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `donor_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `donor_reporting_category` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `donor_reporting_category` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `donor_reporting_category` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_standard_reference' = 'IPSAS 4 Effects of Changes in Foreign Exchange Rates; UN Operational Rate of Exchange (UNORE)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_standard_reference' = 'IPSAS (International Public Sector Accounting Standards)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_value_regex' = 'restricted|unrestricted|temporarily_restricted');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `is_emergency_disbursement` SET TAGS ('dbx_business_glossary_term' = 'Emergency Disbursement Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `is_emergency_disbursement` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `is_emergency_disbursement` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `is_grantmaking_disbursement` SET TAGS ('dbx_business_glossary_term' = 'Grantmaking Disbursement Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `is_grantmaking_disbursement` SET TAGS ('dbx_nonprofit_profile' = 'grantmaking_out');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidated_amount` SET TAGS ('dbx_business_glossary_term' = 'Liquidated Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidated_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidated_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidated_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidated_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_date` SET TAGS ('dbx_business_glossary_term' = 'Liquidation Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_deadline` SET TAGS ('dbx_business_glossary_term' = 'Liquidation Deadline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_deadline` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_deadline` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_status` SET TAGS ('dbx_business_glossary_term' = 'Liquidation Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|partial|fully_liquidated|overdue');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_status` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `liquidation_status` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `net_asset_release_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Asset Release Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `net_asset_release_amount` SET TAGS ('dbx_nonprofit_profile' = 'endowment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Disbursement Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `nicra_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) Rate Applied');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `nicra_rate_applied` SET TAGS ('dbx_standard_reference' = '2 CFR 200 Appendix IV Indirect Cost Rate (NICRA)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `post_distribution_monitoring_ref` SET TAGS ('dbx_business_glossary_term' = 'Post-Distribution Monitoring (PDM) Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `post_distribution_monitoring_ref` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `post_distribution_monitoring_ref` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Request Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `request_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `request_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Documentation Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `tranche_number` SET TAGS ('dbx_business_glossary_term' = 'Tranche Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `tranche_number` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `tranche_number` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`sub_award_disbursement` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Identifier');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `constituent_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `constituent_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `constituent_id` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `country_office_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `country_office_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `intervention_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Country Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `country_id` SET TAGS ('dbx_relationship' = 'lookup_reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `country_id` SET TAGS ('dbx_standard_reference' = 'ISO 3166-1 alpha-3 country codes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `solicitation_id` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `advance_payment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `advance_payment_allowed` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `advance_payment_allowed` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `advance_payment_allowed` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `agreement_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Signed Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `agreement_signed_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `agreement_signed_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `amendment_count` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `amendment_count` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `audit_required` SET TAGS ('dbx_business_glossary_term' = 'Audit Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `audit_required` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `audit_required` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `audit_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Threshold Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `audit_threshold_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `audit_threshold_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `authorized_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `authorized_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `authorized_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_number` SET TAGS ('dbx_business_glossary_term' = 'Award Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_number` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_number` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_status` SET TAGS ('dbx_value_regex' = 'pipeline|active|no_cost_extension|suspended|closed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_status` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_status` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_type` SET TAGS ('dbx_business_glossary_term' = 'Award Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_type` SET TAGS ('dbx_value_regex' = 'cooperative_agreement|contract|grant|sub_award|consortium_lead|consortium_member');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `award_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `board_approval_required` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `board_approval_required` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `board_approval_required_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `board_approval_required_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `board_resolution_reference` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `board_resolution_reference` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `branding_marking_requirements` SET TAGS ('dbx_business_glossary_term' = 'Branding and Marking Requirements');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `branding_marking_requirements` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `branding_marking_requirements` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Award Closeout Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `closeout_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `closeout_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Award Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `currency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `currency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `direction` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `direction` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `donor_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Donor Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `donor_reference_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `donor_reference_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `donor_reference_number` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `donor_reference_number` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `donor_reference_number` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Award End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `end_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `end_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `endowment_draw_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `endowment_draw_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `endowment_funded_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `endowment_funded_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `endowment_spending_policy_rate` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `endowment_spending_policy_rate` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `exchange_rate_to_functional` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate to Functional Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `exchange_rate_to_functional` SET TAGS ('dbx_standard_reference' = 'IPSAS 4 Effects of Changes in Foreign Exchange Rates; UN Operational Rate of Exchange (UNORE)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `form_990_schedule_reference` SET TAGS ('dbx_standard_reference' = 'ASC 958 (US GAAP for Nonprofits); IRS Form 990');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `functional_currency` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `functional_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `functional_currency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `functional_currency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `fund_restriction_class` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `fund_restriction_class` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `funding_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Funding Mechanism');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `funding_mechanism` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `funding_mechanism` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `grant_direction` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `grant_direction` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `grantmaking_program_area` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `grantmaking_program_area` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `indirect_cost_ceiling` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Ceiling');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `indirect_cost_ceiling` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `indirect_cost_ceiling` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `is_endowment_funded` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `is_endowment_funded` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `is_grant_made_out` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `is_grant_made_out` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `net_asset_classification` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `net_asset_classification` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `nicra_icr_rate` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) / Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `nicra_icr_rate` SET TAGS ('dbx_standard_reference' = '2 CFR 200 Appendix IV Indirect Cost Rate (NICRA)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Award Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `notes` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Award Notification Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `notification_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `notification_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `original_end_date` SET TAGS ('dbx_business_glossary_term' = 'Original Award End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `original_end_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `original_end_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `payment_method` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `payment_method` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `payment_method` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `period_of_performance_months` SET TAGS ('dbx_business_glossary_term' = 'Period of Performance in Months');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `period_of_performance_months` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `period_of_performance_months` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|final_only');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_standard_reference' = 'UN Sustainable Development Goals indicator framework (A/RES/71/313)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `special_conditions` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `special_conditions` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Award Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `start_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `start_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `tax_exempt_purpose_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `tax_exempt_purpose_code` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `tax_exempt_purpose_code` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `thematic_sector` SET TAGS ('dbx_business_glossary_term' = 'Thematic Sector');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `thematic_sector` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `thematic_sector` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Award Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `title` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `title` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `total_obligated_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Obligated Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `total_obligated_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `total_obligated_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `total_obligated_amount_functional` SET TAGS ('dbx_business_glossary_term' = 'Total Obligated Amount in Functional Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `total_obligated_amount_functional` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award` ALTER COLUMN `total_obligated_amount_functional` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` SET TAGS ('dbx_subdomain' = 'funding_acquisition');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_id` SET TAGS ('dbx_business_glossary_term' = 'Proposal Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `award_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `award_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `component_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `component_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `constituent_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `constituent_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `constituent_id` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `country_office_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `country_office_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `intervention_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `major_gift_opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Major Gift Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `solicitation_id` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `solicitation_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `solicitation_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `applicant_tax_exempt_status` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `applicant_tax_exempt_status` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `award_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Award Notification Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `award_notification_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `award_notification_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `board_approval_status` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `board_approval_status` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `board_committee_review_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `board_committee_review_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `board_review_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `board_review_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `board_review_required` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `board_review_required` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `board_review_required_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `board_review_required_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `business_development_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Development Owner');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `business_development_owner` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `business_development_owner` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `business_development_owner` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `business_development_owner` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `compliance_review_completed` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `compliance_review_completed` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `compliance_review_completed` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `consortium_lead_organization` SET TAGS ('dbx_business_glossary_term' = 'Consortium Lead Organization');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `consortium_lead_organization` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `consortium_lead_organization` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_proposal_summary` SET TAGS ('dbx_business_glossary_term' = 'Cost Proposal Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_proposal_summary` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_proposal_summary` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `direction` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `direction` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Proposal Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `document_reference` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `document_reference` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `geographic_focus` SET TAGS ('dbx_business_glossary_term' = 'Geographic Focus');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `geographic_focus` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `geographic_focus` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `geographic_focus` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `go_no_go_decision` SET TAGS ('dbx_business_glossary_term' = 'Go No-Go Decision');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `go_no_go_decision` SET TAGS ('dbx_value_regex' = 'go|no_go|pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `go_no_go_decision` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `go_no_go_decision` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `go_no_go_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Go No-Go Decision Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `go_no_go_decision_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `go_no_go_decision_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `grantmaking_direction` SET TAGS ('dbx_grantmaking_out' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `grantmaking_direction` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `grantmaking_direction` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `grantmaking_focus_area` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `grantmaking_focus_area` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `grantmaking_program_area` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `grantmaking_program_area` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `indirect_cost_rate_proposed` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR) Proposed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `indirect_cost_rate_proposed` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `indirect_cost_rate_proposed` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `internal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Internal Review Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `internal_review_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `internal_review_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `is_outbound_grant_application` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `is_outbound_grant_application` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_proposal_writer` SET TAGS ('dbx_business_glossary_term' = 'Lead Proposal Writer');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_proposal_writer` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_proposal_writer` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_proposal_writer` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_proposal_writer` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_technical_sector` SET TAGS ('dbx_business_glossary_term' = 'Lead Technical Sector');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_technical_sector` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `lead_technical_sector` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Proposal Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `notes` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `partnership_model` SET TAGS ('dbx_business_glossary_term' = 'Partnership Model');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `partnership_model` SET TAGS ('dbx_value_regex' = 'prime|sub_award|consortium|joint_venture|solo');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `partnership_model` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `partnership_model` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `program_officer_recommendation` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `program_officer_recommendation` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_status` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Proposal Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_value_regex' = 'full_application|concept_note|expression_of_interest|unsolicited|pre_proposal|letter_of_inquiry');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposal_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Proposed Duration in Months');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_duration_months` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_duration_months` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_end_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_end_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_end_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_start_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_start_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `proposed_start_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Proposal Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `reference_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `reference_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `reference_number` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `reference_number` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Requested Amount in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_amount_usd` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_amount_usd` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_currency` SET TAGS ('dbx_business_glossary_term' = 'Requested Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_currency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `requested_currency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `submission_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `submission_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `target_beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Target Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `target_beneficiary_count` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `target_beneficiary_count` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `target_beneficiary_count` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `technical_approach_summary` SET TAGS ('dbx_business_glossary_term' = 'Technical Approach Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `technical_approach_summary` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `technical_approach_summary` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Proposal Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `title` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `title` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `win_loss_outcome` SET TAGS ('dbx_business_glossary_term' = 'Win Loss Outcome');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `win_loss_outcome` SET TAGS ('dbx_value_regex' = 'won|lost|pending|withdrawn');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `win_loss_outcome` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`proposal` ALTER COLUMN `win_loss_outcome` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Internal)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_currency` SET TAGS ('dbx_business_glossary_term' = 'Award Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_currency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `award_currency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_narrative_reference` SET TAGS ('dbx_business_glossary_term' = 'Budget Narrative Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_narrative_reference` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_notes` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_period` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_period_end_date` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_period_start_date` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_submission_date` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_version_number` SET TAGS ('dbx_business_glossary_term' = 'Budget Version Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `budget_version_number` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `contractual_costs` SET TAGS ('dbx_business_glossary_term' = 'Contractual Costs (Sub-Awards and Consultants)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `contractual_costs` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `contractual_costs` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `donor_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `donor_approval_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `donor_approval_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `donor_approval_date` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `donor_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Donor Approval Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `donor_approval_reference` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `donor_approval_reference` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `donor_approval_reference` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `endowment_draw_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `endowment_draw_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `equipment_costs` SET TAGS ('dbx_business_glossary_term' = 'Equipment Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `equipment_costs` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `equipment_costs` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fringe_benefits_costs` SET TAGS ('dbx_business_glossary_term' = 'Fringe Benefits Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fringe_benefits_costs` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fringe_benefits_costs` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `indirect_cost_base` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Base');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `indirect_cost_base` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `indirect_cost_base` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `is_amendment` SET TAGS ('dbx_business_glossary_term' = 'Is Amendment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `is_amendment` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `is_amendment` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `net_asset_classification` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `net_asset_classification` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `nicra_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) Rate Applied');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `nicra_rate_applied` SET TAGS ('dbx_standard_reference' = '2 CFR 200 Appendix IV Indirect Cost Rate (NICRA)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `personnel_costs` SET TAGS ('dbx_business_glossary_term' = 'Personnel Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `personnel_costs` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `personnel_costs` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `personnel_costs` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `prepared_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `prepared_by` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `prepared_by` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `prepared_by` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `supplies_costs` SET TAGS ('dbx_business_glossary_term' = 'Supplies Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `supplies_costs` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `supplies_costs` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_approved_budget` SET TAGS ('dbx_business_glossary_term' = 'Total Approved Budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_approved_budget` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_approved_budget` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_direct_costs` SET TAGS ('dbx_business_glossary_term' = 'Total Direct Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_direct_costs` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_direct_costs` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_indirect_costs` SET TAGS ('dbx_business_glossary_term' = 'Total Indirect Costs (Facilities and Administration)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_indirect_costs` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `total_indirect_costs` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `travel_costs` SET TAGS ('dbx_business_glossary_term' = 'Travel Costs');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `travel_costs` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget` ALTER COLUMN `travel_costs` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Award Budget Line ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Period ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_budget_id` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `award_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `component_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `component_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `indicator_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `indicator_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `intervention_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `allocability_flag` SET TAGS ('dbx_business_glossary_term' = 'Allocability Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `allocability_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `allocability_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `allowability_flag` SET TAGS ('dbx_business_glossary_term' = 'Allowability Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `allowability_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `allowability_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approval_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approved_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approved_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approved_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approved_amount_usd` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `approved_amount_usd` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `budget_line_status` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_category` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_share_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_share_required_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_share_required_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Cost Subcategory');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_subcategory` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cost_subcategory` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cumulative_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Expenditure to Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cumulative_expenditure` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cumulative_expenditure` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cumulative_expenditure_usd` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Expenditure to Date (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cumulative_expenditure_usd` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `cumulative_expenditure_usd` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `donor_reporting_category` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `donor_reporting_category` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `donor_reporting_category` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `donor_reporting_category` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_standard_reference' = 'IPSAS 4 Effects of Changes in Foreign Exchange Rates; UN Operational Rate of Exchange (UNORE)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_standard_reference' = 'IPSAS (International Public Sector Accounting Standards)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `indirect_cost_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `line_description` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `line_item_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Item Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `line_item_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `line_item_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `line_item_code` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `line_item_code` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `nicra_rate_applied` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) Rate Applied');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `nicra_rate_applied` SET TAGS ('dbx_standard_reference' = '2 CFR 200 Appendix IV Indirect Cost Rate (NICRA)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `notes` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `quantity` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `reasonableness_flag` SET TAGS ('dbx_business_glossary_term' = 'Reasonableness Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `reasonableness_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `reasonableness_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revised_amount` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revised_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revised_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revised_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Revised Budget Amount (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revised_amount_usd` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revised_amount_usd` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Revision Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revision_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revision_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revision_reason` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `revision_reason` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `variance_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`award_budget_line` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `award_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `award_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `capacity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `due_diligence_record_id` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Record Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `intervention_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Implementing Partner Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `project_site_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `project_site_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `amendment_count` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `amendment_count` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approval_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approval_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approved_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approved_by` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `approved_by` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `board_designation` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `board_designation` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `closeout_date` SET TAGS ('dbx_business_glossary_term' = 'Closeout Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `closeout_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `closeout_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `cost_share_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `cost_share_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `cost_share_required_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `cost_share_required_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Subaward Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `currency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `currency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_description` SET TAGS ('dbx_business_glossary_term' = 'Subaward Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_description` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_description` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `disbursed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursed Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `disbursed_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `disbursed_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `duns_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `duns_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `duns_number` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `duns_number` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `equivalency_determination_required` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `equivalency_determination_required` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Execution Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `execution_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `execution_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `expenditure_responsibility_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `expenditure_responsibility_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `expenditure_responsibility_required` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `expenditure_responsibility_required` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `ffata_reporting_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Funding Accountability and Transparency Act (FFATA) Reporting Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `ffata_reporting_required_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `ffata_reporting_required_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `flow_down_requirements` SET TAGS ('dbx_business_glossary_term' = 'Flow-Down Requirements');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `flow_down_requirements` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `flow_down_requirements` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fsrs_report_date` SET TAGS ('dbx_business_glossary_term' = 'FFATA Subaward Reporting System (FSRS) Report Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fsrs_report_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fsrs_report_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fund_restriction_class` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fund_restriction_class` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily restricted|permanently restricted');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `grant_program_area` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `grant_program_area` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `grant_purpose_statement` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `grant_purpose_statement` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `grantee_board_attestation_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `grantee_board_attestation_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `grantee_organization_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `grantee_organization_name` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `grantee_organization_name` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `grantee_organization_name` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `grantee_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `grantee_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `indirect_cost_base` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Base');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `indirect_cost_base` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `indirect_cost_base` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `indirect_cost_rate` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `is_charitable_grant_out` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `is_charitable_grant_out` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `is_grantmaking_out` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `is_grantmaking_out` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'quarterly|semi-annually|annually|as-needed|continuous');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `net_asset_release_classification` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `net_asset_release_classification` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `notes` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `obligated_amount` SET TAGS ('dbx_business_glossary_term' = 'Obligated Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `obligated_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `obligated_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_method` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_method` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_method` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_business_glossary_term' = 'Payment Schedule');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `payment_schedule` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `period_of_performance_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period of Performance (PoP) End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `period_of_performance_end_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `period_of_performance_end_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `period_of_performance_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period of Performance (PoP) Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `period_of_performance_start_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `period_of_performance_start_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually|as-needed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `risk_rating` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `risk_rating` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `single_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Audit Required Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `single_audit_required_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `single_audit_required_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_number` SET TAGS ('dbx_business_glossary_term' = 'Subaward Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_number` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_number` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_status` SET TAGS ('dbx_business_glossary_term' = 'Subaward Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_status` SET TAGS ('dbx_value_regex' = 'draft|pending approval|active|suspended|terminated|closed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_status` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_status` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_type` SET TAGS ('dbx_business_glossary_term' = 'Subaward Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_type` SET TAGS ('dbx_value_regex' = 'sub-grant|subcontract|fixed-obligation grant|cooperative agreement|cost-reimbursable|other');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `subaward_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `termination_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `termination_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `termination_reason` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `termination_reason` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Subaward Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `title` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `title` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `total_subaward_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Subaward Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `total_subaward_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `total_subaward_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `total_subaward_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Subaward Amount United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `total_subaward_amount_usd` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `total_subaward_amount_usd` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `uei_number` SET TAGS ('dbx_business_glossary_term' = 'Unique Entity Identifier (UEI) Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `uei_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `uei_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `uei_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `uei_number` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`subaward` ALTER COLUMN `uei_number` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` SET TAGS ('dbx_subdomain' = 'funding_acquisition');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Condition ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_condition_id` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `award_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `award_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Donor ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `constituent_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `constituent_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `constituent_id` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `evaluation_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `reporting_period_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_authority` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_authority` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|met|waived|expired|overdue');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_category` SET TAGS ('dbx_business_glossary_term' = 'Condition Category');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_category` SET TAGS ('dbx_value_regex' = 'financial|programmatic|administrative|compliance|safeguarding|environmental');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_category` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_category` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_description` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_description` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Condition Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_reference_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_reference_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_reference_number` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_reference_number` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_title` SET TAGS ('dbx_business_glossary_term' = 'Condition Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_title` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_title` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_value_regex' = 'prior_approval_requirement|restricted_cost|reporting_obligation|key_personnel_approval|branding_marking_requirement|audit_requirement');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_business_glossary_term' = 'Deliverable Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `deliverable_description` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Email');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_['confidential'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_'pii_email'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_'pii_de_identified'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_email` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_['confidential'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_'pii_de_identified'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_pii_class' = 'pii_donor');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `donor_contact_name` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `due_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `due_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `endowment_restriction_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `endowment_restriction_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `escalation_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Escalation Threshold Days');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `escalation_threshold_days` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `escalation_threshold_days` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Threshold Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_amount` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Threshold Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_currency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_currency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `financial_threshold_currency` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `is_board_governance_condition` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `is_board_governance_condition` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `is_membership_condition` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `is_membership_condition` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `is_membership_condition` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `is_special_award_condition` SET TAGS ('dbx_business_glossary_term' = 'Is Special Award Condition (SAC)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `is_special_award_condition` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `is_special_award_condition` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `last_review_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `last_review_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `membership_category` SET TAGS ('dbx_membership_dues' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `membership_category` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `membership_category` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `membership_category` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `membership_dues_related_flag` SET TAGS ('dbx_membership_dues' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `membership_dues_related_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `membership_dues_related_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `membership_dues_related_flag` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `modified_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `modified_by` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `modified_by` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `modified_by` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|as_needed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `net_asset_restriction_implication` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `net_asset_restriction_implication` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `next_recurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recurrence Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `next_recurrence_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `next_recurrence_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `next_review_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `next_review_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `priority_level` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `priority_level` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_value_regex' = 'one_time|monthly|quarterly|semi_annually|annually|as_needed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `requires_board_action_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `requires_board_action_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `responsible_department` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `responsible_department` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `risk_rating` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `risk_rating` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `sac_justification` SET TAGS ('dbx_business_glossary_term' = 'Special Award Condition (SAC) Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `sac_justification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `sac_justification` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `sac_justification` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `waiver_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `waiver_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `waiver_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_by` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_condition` ALTER COLUMN `created_by` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` SET TAGS ('dbx_subdomain' = 'award_management');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_report_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Report ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_report_id` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `award_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `award_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `distribution_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `intervention_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `intervention_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `mel_logframe_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Logframe Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `project_site_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `project_site_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `subaward_id` SET TAGS ('dbx_business_glossary_term' = 'Subaward Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Report Approval Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `approval_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `approval_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `audit_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Count');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `audit_findings_count` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `audit_findings_count` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `beneficiaries_reached` SET TAGS ('dbx_business_glossary_term' = 'Beneficiaries Reached');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `beneficiaries_reached` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `beneficiaries_reached` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `board_reported_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `board_reported_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `budget_variance_percentage` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `compliance_certification_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `cumulative_expenditure_to_date` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Expenditure To Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `cumulative_expenditure_to_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `cumulative_expenditure_to_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `days_overdue` SET TAGS ('dbx_business_glossary_term' = 'Days Overdue');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `days_overdue` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `days_overdue` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Acceptance Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_acceptance_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_acceptance_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_acceptance_date` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_feedback_summary` SET TAGS ('dbx_business_glossary_term' = 'Donor Feedback Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_feedback_summary` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_feedback_summary` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `donor_feedback_summary` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Report Due Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `due_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `due_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `endowment_draw_reported_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `endowment_draw_reported_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `exchange_rate_used` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate Used');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `exchange_rate_used` SET TAGS ('dbx_standard_reference' = 'IPSAS 4 Effects of Changes in Foreign Exchange Rates; UN Operational Rate of Exchange (UNORE)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_amount_reported` SET TAGS ('dbx_business_glossary_term' = 'Financial Amount Reported');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_amount_reported` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_amount_reported` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_amount_reported` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_amount_reported_usd` SET TAGS ('dbx_business_glossary_term' = 'Financial Amount Reported in United States Dollars (USD)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_amount_reported_usd` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_amount_reported_usd` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_amount_reported_usd` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_currency` SET TAGS ('dbx_business_glossary_term' = 'Financial Currency Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_currency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_currency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `financial_currency` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `grantmaking_disbursed_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `grantmaking_disbursed_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `is_final_version` SET TAGS ('dbx_business_glossary_term' = 'Is Final Version Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `is_final_version` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `is_final_version` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `is_overdue` SET TAGS ('dbx_business_glossary_term' = 'Is Overdue Flag');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `is_overdue` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `is_overdue` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `key_performance_indicators_met` SET TAGS ('dbx_business_glossary_term' = 'Key Performance Indicators (KPI) Met');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `key_performance_indicators_met` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `key_performance_indicators_met` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `key_performance_indicators_total` SET TAGS ('dbx_business_glossary_term' = 'Total Key Performance Indicators (KPI)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `key_performance_indicators_total` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `key_performance_indicators_total` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `key_performance_indicators_total` SET TAGS ('dbx_type_corrected' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `narrative_summary` SET TAGS ('dbx_business_glossary_term' = 'Narrative Summary');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `narrative_summary` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `narrative_summary` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `net_asset_release_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `net_asset_release_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_notes` SET TAGS ('dbx_business_glossary_term' = 'Report Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_notes` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_notes` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Report Reference Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_reference_number` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_status` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_status` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'SF-425 Federal Financial Report|Quarterly Programmatic|Annual Narrative|SitRep|Final Report|IATI Disclosure');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `report_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'Monthly|Quarterly|Semi-Annual|Annual|Ad Hoc|Final');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_period_end_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `reporting_period_start_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `revision_reason` SET TAGS ('dbx_business_glossary_term' = 'Revision Reason');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `revision_reason` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `revision_reason` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `revision_requested_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Requested Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `revision_requested_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `revision_requested_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'Email|Donor Portal|USAID ASIST|DFID ARIES|CERF Portal|Manual Upload');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `supporting_document_reference` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Report Version Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `version_number` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`donor_report` ALTER COLUMN `version_number` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` SET TAGS ('dbx_subdomain' = 'funding_acquisition');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Organization ID');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `advance_payment_allowed` SET TAGS ('dbx_business_glossary_term' = 'Advance Payment Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `advance_payment_allowed` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `advance_payment_allowed` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `advance_payment_allowed` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `allowable_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Allowable Cost Categories');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `allowable_cost_categories` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `allowable_cost_categories` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `audit_requirement` SET TAGS ('dbx_business_glossary_term' = 'Audit Requirement');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `audit_requirement` SET TAGS ('dbx_value_regex' = 'single_audit|program_specific_audit|financial_audit|no_audit_required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `audit_requirement` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `audit_requirement` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `board_designated_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `board_designated_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `budget_flexibility` SET TAGS ('dbx_business_glossary_term' = 'Budget Flexibility');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `budget_flexibility` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `budget_revision_threshold` SET TAGS ('dbx_business_glossary_term' = 'Budget Revision Threshold');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `budget_revision_threshold` SET TAGS ('dbx_standard_reference' = 'IATI budget element; IPSAS 24 Presentation of Budget Information');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_category` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_category` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `closeout_period_days` SET TAGS ('dbx_business_glossary_term' = 'Closeout Period Days');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `closeout_period_days` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `closeout_period_days` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_code` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_code` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_['confidential'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_'pii_email'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_'pii_de_identified'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_['confidential'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_'pii_de_identified'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_['confidential'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_'pii_phone'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_'pii_de_identified'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_description` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Description');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_description` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_description` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Donor Reporting Frequency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|upon_request|milestone_based');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `donor_reporting_frequency` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_corpus_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_corpus_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_fund_flag` SET TAGS ('dbx_endowment_accounting' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_fund_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_fund_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_market_value` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_market_value` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_spending_policy_rate` SET TAGS ('dbx_endowment_accounting' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_spending_policy_rate` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_spending_policy_rate` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_spending_rate` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `endowment_spending_rate` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Fund Restriction Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_value_regex' = 'unrestricted|temporarily_restricted|permanently_restricted');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `fund_restriction_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_end_date` SET TAGS ('dbx_business_glossary_term' = 'Funding End Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_end_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_end_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_mechanism_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Mechanism Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_mechanism_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_mechanism_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_status` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_activation|under_review');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_status` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_status` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_start_date` SET TAGS ('dbx_business_glossary_term' = 'Funding Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_start_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_start_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `iati_organization_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Organization Identifier');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `iati_organization_identifier` SET TAGS ('dbx_standard_reference' = 'IATI Standard v2.03 (iatistandard.org)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `indirect_cost_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR) Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `indirect_cost_rate_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `indirect_cost_rate_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `is_endowment_source` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `is_endowment_source` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `is_endowment_source_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `is_endowment_source_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `is_membership_dues_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `is_membership_dues_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `is_membership_dues_flag` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `is_membership_dues_source` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `is_membership_dues_source` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `is_membership_dues_source` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `membership_dues_period` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `membership_dues_period` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `membership_dues_period` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_['pii_de_identified'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_'sensitivity' = 'pii]');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `funding_source_name` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `net_asset_classification` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `net_asset_classification` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `nicra_rate` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Indirect Cost Rate Agreement (NICRA) Rate');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `nicra_rate` SET TAGS ('dbx_standard_reference' = '2 CFR 200 Appendix IV Indirect Cost Rate (NICRA)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `oda_dac_classification` SET TAGS ('dbx_business_glossary_term' = 'Official Development Assistance (ODA) Development Assistance Committee (DAC) Classification');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `oda_dac_classification` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `oda_dac_classification` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `payment_method` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `payment_method` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `payment_method` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `procurement_standards` SET TAGS ('dbx_business_glossary_term' = 'Procurement Standards');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `procurement_standards` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `procurement_standards` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_business_glossary_term' = 'Program Income Treatment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_value_regex' = 'addition|deduction|cost_sharing|no_program_income');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `program_income_treatment` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `record_retention_years` SET TAGS ('dbx_business_glossary_term' = 'Record Retention Years');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `record_retention_years` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `record_retention_years` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `sdg_alignment_codes` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment Codes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `sdg_alignment_codes` SET TAGS ('dbx_standard_reference' = 'UN Sustainable Development Goals indicator framework (A/RES/71/313)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `source_category` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `source_category` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `subaward_allowed` SET TAGS ('dbx_business_glossary_term' = 'Subaward Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `subaward_allowed` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `subaward_allowed` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `subaward_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Subaward Approval Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `subaward_approval_required` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `subaward_approval_required` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `thematic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Thematic Restriction');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `thematic_restriction` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `thematic_restriction` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `total_funding_available` SET TAGS ('dbx_business_glossary_term' = 'Total Funding Available');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `total_funding_available` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `total_funding_available` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `unallowable_cost_categories` SET TAGS ('dbx_business_glossary_term' = 'Unallowable Cost Categories');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `unallowable_cost_categories` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`funding_source` ALTER COLUMN `unallowable_cost_categories` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` SET TAGS ('dbx_subdomain' = 'funding_acquisition');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_id` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `country_office_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `country_office_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indicator_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indicator_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Constituent Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `constituent_id` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `constituent_id` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `constituent_id` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `anticipated_award_date` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Award Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `anticipated_award_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `anticipated_award_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `anticipated_start_date` SET TAGS ('dbx_business_glossary_term' = 'Anticipated Program Start Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `anticipated_start_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `anticipated_start_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `application_deadline` SET TAGS ('dbx_business_glossary_term' = 'Application Deadline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `application_deadline` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `application_deadline` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `board_authorized_funding_pool` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `board_authorized_funding_pool` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `competitive_intelligence_notes` SET TAGS ('dbx_business_glossary_term' = 'Competitive Intelligence Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `competitive_intelligence_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `competitive_intelligence_notes` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `competitive_intelligence_notes` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `consortium_allowed` SET TAGS ('dbx_business_glossary_term' = 'Consortium Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `consortium_allowed` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `consortium_allowed` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Email Address');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_['confidential'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_'pii_email'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_'pii_de_identified'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Donor Contact Person Name');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_['restricted'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_'pii_identifier'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_'sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_'pii_de_identified'' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_'pii_classification' = 'pii_staff]');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_class' = 'pii_staff');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_PII' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Percentage');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `cost_share_percentage` SET TAGS ('dbx_pii_classification' = 'pii_de_identified');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Required');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `cost_share_required` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_business_glossary_term' = 'Development Assistance Committee (DAC) Sector Code');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `dac_sector_code` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `eligible_org_tax_status` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `eligible_org_tax_status` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `estimated_funding_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Funding Amount');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `estimated_funding_amount` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `estimated_funding_amount` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `estimated_number_of_awards` SET TAGS ('dbx_business_glossary_term' = 'Estimated Number of Awards');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `estimated_number_of_awards` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `estimated_number_of_awards` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `funding_currency` SET TAGS ('dbx_business_glossary_term' = 'Funding Currency');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `funding_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `funding_currency` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `funding_currency` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `geographic_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Geographic Eligibility');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `geographic_eligibility` SET TAGS ('dbx_sensitivity' = 'phi');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `geographic_eligibility` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `geographic_eligibility` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `go_no_go_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Go/No-Go Decision Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `go_no_go_decision_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `go_no_go_decision_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `go_no_go_rationale` SET TAGS ('dbx_business_glossary_term' = 'Go/No-Go Decision Rationale');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `go_no_go_rationale` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `go_no_go_rationale` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `grantmaking_focus_area` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `grantmaking_focus_area` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `identified_by` SET TAGS ('dbx_business_glossary_term' = 'Identified By');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `identified_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `identified_by` SET TAGS ('dbx_pii_staff' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `identified_by` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `identified_by` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Identified Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `identified_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `identified_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indirect_cost_rate_allowed` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate Allowed');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indirect_cost_rate_allowed` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indirect_cost_rate_allowed` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indirect_cost_rate_cap` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate Cap');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indirect_cost_rate_cap` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `indirect_cost_rate_cap` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `internal_priority_score` SET TAGS ('dbx_business_glossary_term' = 'Internal Priority Score');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `internal_priority_score` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `internal_priority_score` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `is_grantmaking_rfp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `is_grantmaking_rfp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `is_outbound_grantmaking_flag` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `is_outbound_grantmaking_flag` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `local_partner_requirement` SET TAGS ('dbx_business_glossary_term' = 'Local Partner Requirement');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `local_partner_requirement` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `local_partner_requirement` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Notes');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `notes` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `notes` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `program_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Program Duration (Months)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `program_duration_months` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `program_duration_months` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Publication Date');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `publication_date` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `publication_date` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `questions_deadline` SET TAGS ('dbx_business_glossary_term' = 'Questions Deadline');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `questions_deadline` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `questions_deadline` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_standard_reference' = 'UN Sustainable Development Goals indicator framework (A/RES/71/313)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_number` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Number');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_number` SET TAGS ('dbx_reference_code' = 'lookup_pending');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_number` SET TAGS ('dbx_lookup_review' = 'no_target');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_number` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_number` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_status` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Status');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_status` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_status` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_type` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Type');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_type` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `solicitation_type` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'Online Portal|Email|Physical Mail|Grants.gov|Courier|Hybrid');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `submission_method` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `submission_method` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `submission_requirements` SET TAGS ('dbx_business_glossary_term' = 'Submission Requirements');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `submission_requirements` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `submission_requirements` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `thematic_focus_area` SET TAGS ('dbx_business_glossary_term' = 'Thematic Focus Area');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `thematic_focus_area` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `thematic_focus_area` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Title');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `title` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `title` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Solicitation Uniform Resource Locator (URL)');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `url` SET TAGS ('dbx_standard_reference' = 'IATI Activity Standard v2.03 (budget');
ALTER TABLE `vibe_ngo_v1`.`grant`.`solicitation` ALTER COLUMN `url` SET TAGS ('dbx_transaction);_2_CFR_200_Uniform_Guidance;_ASC_958_(US_GAAP);_IPSAS_23_Revenue_from_Non_Exchange_Transactions' = 'true');
