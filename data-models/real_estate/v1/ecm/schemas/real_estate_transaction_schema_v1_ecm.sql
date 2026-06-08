-- Schema for Domain: transaction | Business: Real Estate | Version: v1_ecm
-- Generated on: 2026-05-02 01:46:59

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `real_estate_ecm`.`transaction` COMMENT 'Records all property acquisition, disposition, and sale events — purchase agreements, closing statements, title transfers (ALTA), REO transactions, 1031 exchanges, and financing transactions. Tracks deal economics including PSF pricing, LTV ratios, earnest money, cash flows, and settlement details. Integrates with MLS and CoStar comparable sales data.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`property_sale` (
    `property_sale_id` BIGINT COMMENT 'Unique surrogate identifier for each property sale or disposition transaction record. Primary key of the property_sale data product.',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: Lender underwriting and investment committee approval for every property sale requires a formal appraisal. Post-close audit reports compare appraised value to sale price. Real estate professionals uni',
    `asset_id` BIGINT COMMENT 'Reference to the property asset involved in this sale or disposition transaction.',
    `brokerage_deal_id` BIGINT COMMENT 'Reference to the brokerage deal record associated with this property sale, linking to the deal pipeline tracked in Salesforce CRM.',
    `claim_id` BIGINT COMMENT 'Foreign key linking to insurance.claim. Business justification: Casualty sale workflow: properties sold following a casualty event (fire, flood, storm) may have open insurance claims that must be assigned or resolved at closing. Linking property_sale to the associ',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Multi-currency portfolio reporting and FX conversion for cross-border sales require a normalized currency reference. Every financial amount on the sale record (purchase_price, net_sale_price, loan_amo',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Development disposition reporting: when a developer sells a newly constructed asset, the property_sale must reference the dev_project for proforma-vs-actual variance analysis and GAAP cost basis recon',
    `fund_id` BIGINT COMMENT 'Foreign key linking to investment.fund. Business justification: Fund-level disposition reporting, IRR calculations, and LP capital account updates require knowing which funds asset was sold. Investment managers and fund administrators need this link for fund perf',
    `investment_deal_id` BIGINT COMMENT 'Foreign key linking to investment.investment_deal. Business justification: When an investment deal closes, it produces a property_sale record. Linking property_sale to investment_deal closes the pipeline-to-execution loop, enabling deal-level performance tracking, pipeline c',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to investment.vehicle. Business justification: Property sales are executed through specific investment vehicles (SPEs/LLCs). Linking property_sale to investment_vehicle enables legal-entity-level transaction reporting, tax filing attribution, and ',
    `noi_statement_id` BIGINT COMMENT 'Foreign key linking to finance.noi_statement. Business justification: The trailing NOI statement is the primary underwriting document used to validate cap rate and purchase price at closing. Real estate investment analysts and appraisers reference the NOI statement dire',
    `ops_inspection_id` BIGINT COMMENT 'Foreign key linking to maintenance.ops_inspection. Business justification: Property sales require certificate of occupancy, fire/life safety, and regulatory inspections as closing conditions. Transaction managers track which ops_inspection record satisfies the COO closing co',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: A property sale is legally tied to a specific parcel (APN). Linking to property.parcel enables sales comp analysis by parcel, tax record reconciliation, MLS/CoStar parcel-level reporting, and transfer',
    `portfolio_asset_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio_asset. Business justification: Disposition reporting and realized IRR/equity-multiple calculation require linking the sale transaction to the portfolio asset record. Investment managers reconcile net sale proceeds against acquisiti',
    `proforma_id` BIGINT COMMENT 'Foreign key linking to development.proforma. Business justification: Development performance reporting: actual sale price, cap_rate, and net_sale_price on property_sale are compared against proformas projected_sale_proceeds_usd and exit_cap_rate_pct. Investment commit',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: MLS reporting, CoStar comp categorization, cap rate benchmarking, and transfer tax calculation all require structured property type classification on the sale record. A real estate analyst expects eve',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Property sales trigger mandatory regulatory filings: FIRPTA withholding (IRS Form 8288), FinCEN Geographic Targeting Orders, transfer tax returns, and 1099-S. Compliance officers and closing attorneys',
    `sale_type_id` BIGINT COMMENT 'Foreign key linking to transaction.sale_type. Business justification: property_sale has deal_type: STRING which is a free-text classification of the transaction type. sale_type is the reference classification table defining standardized transaction type taxonomy (acquis',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Property sales are executed by legal entities (SPEs, REITs, LLCs). The selling entity determines consolidation treatment, gain/loss recognition, and REIT distribution requirements. Role-prefixed sell',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Owner disposition reporting, capital gains analysis, and 1031 exchange eligibility checks require linking a property sale directly to the selling owner entity. Portfolio-level sale history and owner t',
    `tenure_type_id` BIGINT COMMENT 'Foreign key linking to reference.tenure_type. Business justification: Tenure type (fee simple, leasehold, condominium) on a sale drives title insurance policy selection, deed type, ALTA policy type, and financing eligibility. Every real estate transaction must classify ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each property sale is managed by an internal transaction coordinator or manager. This link supports deal volume reporting per employee, performance reviews, commission attribution, and workload manage',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Condo and multifamily unit sales require a unit-level sale record. Linking property_sale.unit_id → property.unit enables unit-level sales comp tracking, condo closing workflows, HOA transfer fee calcu',
    `buyer_name` STRING COMMENT 'Legal name of the purchasing party (individual, entity, or trust) as recorded on the executed purchase and sale agreement and ALTA closing statement.',
    `cap_rate` DECIMAL(18,2) COMMENT 'Capitalization Rate (CAP Rate) implied by the transaction, calculated as Net Operating Income (NOI) divided by the purchase price. Core deal economics metric used in Argus Enterprise investment analysis and portfolio benchmarking.',
    `closing_date` DATE COMMENT 'Date on which the property sale transaction was legally closed, title transferred, and funds settled. Critical for revenue recognition under FASB ASC 606 and IFRS 15.',
    `contingency_removed` BOOLEAN COMMENT 'Indicates whether all contractual contingencies have been formally waived or satisfied, making the transaction firm and non-refundable. True = all contingencies removed; False = contingencies still active.',
    `contingency_type` STRING COMMENT 'Primary contingency type governing the buyers right to terminate the purchase agreement without penalty. Common types include financing, inspection, appraisal, title, and environmental contingencies.. Valid values are `financing|inspection|appraisal|title|environmental|none`',
    `contract_date` DATE COMMENT 'Date on which the purchase and sale agreement (PSA) was fully executed by all parties. Represents the principal business event timestamp for the transaction lifecycle.',
    `costar_comp_code` STRING COMMENT 'CoStar Suite comparable sale identifier linking this transaction to the CoStar market database for benchmarking, comparable sales analysis, and market research.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the property sale record was first created in the system, used for audit trail and data lineage tracking per SOX Section 404 controls.',
    `deed_recorded_date` DATE COMMENT 'Date on which the deed was officially recorded with the county recorder or registrar of deeds, establishing the public record of title transfer.',
    `deed_type` STRING COMMENT 'Type of deed instrument used to convey title from seller to buyer. Determines the scope of title warranties provided. Common types include warranty, special warranty, quitclaim, grant, and bargain and sale deeds.. Valid values are `warranty|special_warranty|quitclaim|grant|bargain_sale`',
    `due_diligence_end_date` DATE COMMENT 'Contractual deadline by which the buyer must complete all due diligence inspections, reviews, and investigations and either proceed with or terminate the transaction.',
    `earnest_money_amount` DECIMAL(18,2) COMMENT 'Dollar amount of earnest money deposit submitted by the buyer upon execution of the purchase and sale agreement (PSA), held in escrow pending closing.',
    `earnest_money_due_date` DATE COMMENT 'Date by which the earnest money deposit must be received and confirmed in escrow per the terms of the purchase and sale agreement.',
    `earnest_money_received` BOOLEAN COMMENT 'Indicates whether the earnest money deposit has been received and confirmed in escrow. True = received; False = not yet received.',
    `escrow_company` STRING COMMENT 'Name of the escrow company or closing agent holding funds and documents in trust during the transaction period between contract execution and closing.',
    `exchange_deadline_date` DATE COMMENT 'Statutory deadline by which the replacement property must be identified and acquired to qualify for 1031 like-kind exchange tax deferral treatment. Applicable only when is_1031_exchange is True.',
    `expected_closing_date` DATE COMMENT 'Projected date on which the transaction is anticipated to close, as tracked in the deal pipeline. Used for cash flow forecasting and portfolio planning in Argus Enterprise.',
    `financing_type` STRING COMMENT 'Classification of the financing structure used to fund the acquisition. Includes all-cash, conventional, Adjustable Rate Mortgage (ARM), Fixed Rate Mortgage (FRM), Commercial Mortgage-Backed Securities (CMBS), seller financing, loan assumption, or bridge financing. [ENUM-REF-CANDIDATE: all_cash|conventional|arm|frm|cmbs|seller_financing|assumption|bridge — promote to reference product]',
    `gla_sqft` DECIMAL(18,2) COMMENT 'Gross Leasable Area (GLA) of the property in square feet (SQF) at the time of sale, used as the denominator for PSF pricing calculations and CoStar comparable benchmarking.',
    `is_1031_exchange` BOOLEAN COMMENT 'Indicates whether this transaction is structured as a 1031 like-kind exchange under IRS Section 1031, deferring capital gains tax recognition. True = 1031 exchange; False = standard sale.',
    `loan_amount` DECIMAL(18,2) COMMENT 'Total debt financing amount secured for the property acquisition. Used in conjunction with LTV ratio and DSCR calculations for investment underwriting.',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'Loan-to-Value (LTV) ratio at the time of sale, calculated as the total debt financing divided by the purchase price. Key underwriting metric for lenders and investment committees.',
    `mls_number` STRING COMMENT 'The Multiple Listing Service (MLS) identifier assigned to the property listing associated with this sale, enabling cross-referencing with MLS and CoStar comparable sales data.',
    `net_sale_price` DECIMAL(18,2) COMMENT 'Net proceeds from the property sale after deducting seller concessions, credits, prorations, and closing cost adjustments from the gross purchase price.',
    `noi_at_sale` DECIMAL(18,2) COMMENT 'Net Operating Income (NOI) of the property at the time of sale, used to derive the implied CAP Rate and support investment return analysis in Argus Enterprise.',
    `price_psf` DECIMAL(18,2) COMMENT 'Executed sale price expressed on a Per Square Foot (PSF) basis, calculated as purchase price divided by the propertys gross leasable area. Key benchmarking metric for CoStar comparable sales analysis.',
    `purchase_price` DECIMAL(18,2) COMMENT 'Gross executed purchase price of the property as agreed in the purchase and sale agreement (PSA). Represents the total consideration paid before adjustments, credits, or prorations.',
    `recording_number` STRING COMMENT 'Official document recording number assigned by the county recorder upon deed recordation, serving as the public record reference for the title transfer.',
    `seller_concessions_amount` DECIMAL(18,2) COMMENT 'Total dollar value of concessions granted by the seller to the buyer, including closing cost credits, repair allowances, and price reductions negotiated post-inspection.',
    `title_company` STRING COMMENT 'Name of the title insurance company responsible for conducting the title search, issuing the ALTA title commitment, and facilitating the closing and deed recordation.',
    `transaction_notes` STRING COMMENT 'Free-text field for capturing material deal notes, special conditions, negotiation context, or other qualitative information relevant to the property sale transaction.',
    `transaction_number` STRING COMMENT 'Externally-known alphanumeric identifier for the property sale transaction, used across Yardi Voyager, CoStar, and MLS systems for cross-referencing and audit trail purposes.. Valid values are `^TXN-[0-9]{4}-[0-9]{6}$`',
    `transaction_status` STRING COMMENT 'Current lifecycle state of the property sale transaction. Drives workflow routing in Yardi Voyager and Salesforce CRM deal pipeline. [ENUM-REF-CANDIDATE: pending|under_contract|closed|cancelled|on_hold|terminated — promote to reference product]. Valid values are `pending|under_contract|closed|cancelled|on_hold|terminated`',
    `transfer_tax_amount` DECIMAL(18,2) COMMENT 'Total real estate transfer tax or documentary stamp tax assessed on the property sale transaction by state and local taxing authorities.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the property sale record was last modified, supporting change data capture, audit trail, and incremental ETL processing in the Databricks Silver Layer.',
    `yardi_transaction_ref` STRING COMMENT 'Source system transaction reference identifier from Yardi Voyager, used for data lineage, reconciliation, and audit trail back to the system of record.',
    CONSTRAINT pk_property_sale PRIMARY KEY(`property_sale_id`)
) COMMENT 'Core master record for every property sale or disposition transaction — acquisition, disposition, REO sale, short sale, portfolio trade, or sale-leaseback — capturing executed purchase price, PSF pricing, earnest money terms, closing date, deal type classification, transaction status, and key deal economics (price, PSF, cap rate). Serves as the SSOT hub to which all transaction detail entities (PSA, closing statement, title, deed, financing, escrow, due diligence, parties, offers, documents) are linked via FK. Sourced from Yardi Voyager and CoStar comparable sales data.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` (
    `purchase_agreement_id` BIGINT COMMENT 'Unique system-generated identifier for the purchase and sale agreement (PSA) record. Primary key for this entity.',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: purchase_agreement explicitly tracks appraisal_contingency_date and appraisal_contingency_flag. The appraisal that satisfies or triggers removal of the appraisal contingency must be linked for conting',
    `asset_id` BIGINT COMMENT 'Reference to the property being acquired or disposed of under this purchase agreement.',
    `bpo_id` BIGINT COMMENT 'Foreign key linking to valuation.bpo. Business justification: In short sales and distressed acquisitions, the lender requires a BPO to approve the purchase price before executing the purchase agreement. The BPO-approved value is a named condition precedent in th',
    `brokerage_deal_id` BIGINT COMMENT 'Reference to the brokerage deal or Salesforce CRM opportunity record that originated this purchase agreement.',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Owner acquisition pipeline reporting, KYC pre-closing verification, and accredited investor confirmation for PSA execution require linking the purchase agreement buyer to a tracked owner entity. Inves',
    `certificate_of_insurance_id` BIGINT COMMENT 'Foreign key linking to insurance.certificate_of_insurance. Business justification: PSA compliance: purchase agreements require sellers to maintain insurance through closing and buyers to provide proof of insurance before closing. A COI is a standard PSA closing condition. Transactio',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Cross-border PSA transactions require normalized currency reference for offer price, earnest money, and loan amount comparisons. Multi-currency portfolio tracking and FX reporting depend on this link.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Land acquisition workflow: developers execute PSAs to acquire land for development projects. Development teams track which PSA governs their land acquisition. The PSA is the legal instrument initiatin',
    `entitlement_id` BIGINT COMMENT 'Foreign key linking to development.entitlement. Business justification: Development land acquisition: PSAs for development sites include zoning/entitlement contingencies. Developers tie PSA contingency removal (zoning_contingency_flag, expiration_date) directly to entitle',
    `investment_deal_id` BIGINT COMMENT 'Foreign key linking to investment.investment_deal. Business justification: The PSA is the contractual execution of an IC-approved investment deal. Linking PSA to investment_deal allows investment teams to verify PSA contract price and terms match IC-approved underwriting, a ',
    `lease_agreement_id` BIGINT COMMENT 'Foreign key linking to lease.agreement. Business justification: In sale-leaseback transactions, the purchase agreement and lease agreement are executed simultaneously and are legally interdependent. Buyers, lenders, and title companies must cross-reference both do',
    `listing_id` BIGINT COMMENT 'Reference to the Multiple Listing Service (MLS) or internal brokerage listing associated with this purchase agreement.',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to transaction.property_sale. Business justification: A purchase agreement (PSA) is the contractual basis for a property sale transaction. purchase_agreement currently has no FK to property_sale despite being the primary contractual document for the sale',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: PSA due diligence checklists, financing contingency rules, environmental review requirements, and regulatory disclosure obligations are all property-type-driven. Brokers and attorneys expect the PSA t',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: PSA disclosure obligations, cooling-off periods, and contingency rules are jurisdiction-specific regulatory requirements (e.g., state consumer protection laws, RESPA). Compliance teams must link each ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Purchase agreements include contingencies tied to specific regulatory obligations (environmental review, zoning compliance, ADA, lead paint disclosure). Real estate attorneys need to link PSA continge',
    `sale_type_id` BIGINT COMMENT 'Foreign key linking to transaction.sale_type. Business justification: purchase_agreement has transaction_type: STRING which is a free-text classification. sale_type provides the authoritative reference taxonomy. Adding transaction_transaction_type_id to purchase_agreeme',
    `tenure_type_id` BIGINT COMMENT 'Foreign key linking to reference.tenure_type. Business justification: PSA terms differ materially by tenure type — leasehold PSAs require ground lessor consent, SNDA, and different financing contingency language. Title attorneys and lenders require tenure type classific',
    `offer_id` BIGINT COMMENT 'Foreign key linking to transaction.offer. Business justification: A purchase agreement (PSA) is the formal contractual document that formalizes an accepted offer. The PSA is directly derived from the accepted offer terms. Adding transaction_offer_id to purchase_agre',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: Condo and multifamily purchase agreements are executed at the unit level. Linking purchase_agreement.unit_id → property.unit enables unit-level PSA tracking for condo developments, pre-sale absorption',
    `actual_closing_date` DATE COMMENT 'The actual date on which the property transaction closed and title was transferred. Populated upon successful closing; null if not yet closed.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the purchase agreement. Tracks progression from Letter of Intent (LOI) through execution, closing, or termination. [ENUM-REF-CANDIDATE: loi|under_contract|executed|terminated|expired|closed — promote to reference product if additional states are needed]. Valid values are `loi|under_contract|executed|terminated|expired|closed`',
    `amendment_count` STRING COMMENT 'The total number of amendments and addenda executed against this purchase agreement, tracking the modification history of the PSA.',
    `appraisal_contingency_date` DATE COMMENT 'The deadline by which a formal property appraisal must be completed and the appraisal contingency resolved. Protects the buyer if the appraised value is below the contract price.',
    `appraisal_contingency_flag` BOOLEAN COMMENT 'Indicates whether the purchase agreement includes an appraisal contingency (True = appraisal contingency is present and active).',
    `contingency_status` STRING COMMENT 'Overall status of all contingencies in the purchase agreement. Tracks whether contingencies are pending resolution, have been waived by the buyer, satisfied, exercised to terminate, or have expired.. Valid values are `pending|waived|satisfied|exercised|expired`',
    `contract_price` DECIMAL(18,2) COMMENT 'The final negotiated and agreed purchase price as recorded in the executed PSA, which may differ from the initial offer price following negotiations.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this purchase agreement record was first created in the system, used for audit trail and data lineage purposes.',
    `docusign_envelope_code` STRING COMMENT 'The unique envelope identifier from DocuSign CLM for the digitally executed purchase agreement, enabling traceability to the contract lifecycle management system.',
    `down_payment_amount` DECIMAL(18,2) COMMENT 'The equity portion of the purchase price to be paid by the buyer at closing, calculated as contract price minus loan amount.',
    `due_diligence_end_date` DATE COMMENT 'The contractual deadline by which the buyer must complete all due diligence activities and either proceed with or terminate the transaction.',
    `due_diligence_start_date` DATE COMMENT 'The start date of the contractual due diligence period during which the buyer may conduct inspections, environmental reviews, title searches, and financial analysis.',
    `earnest_money_amount` DECIMAL(18,2) COMMENT 'The good-faith deposit amount paid by the buyer upon execution of the PSA, held in escrow until closing or returned/forfeited per contingency terms.',
    `earnest_money_due_date` DATE COMMENT 'The contractual deadline by which the buyer must deliver the earnest money deposit to the escrow agent.',
    `earnest_money_received` BOOLEAN COMMENT 'Indicates whether the earnest money deposit has been received and confirmed by the escrow agent (True) or is still outstanding (False).',
    `effective_date` DATE COMMENT 'The date on which the purchase agreement becomes legally effective and binding, which may differ from the execution date if a future effective date is specified in the agreement.',
    `environmental_contingency_date` DATE COMMENT 'The deadline by which environmental due diligence (Phase I/II ESA) must be completed and the environmental contingency resolved.',
    `execution_date` DATE COMMENT 'The date on which all parties executed (signed) the Purchase and Sale Agreement (PSA), making it a binding contract. This is the principal business event date for this transaction.',
    `expiration_date` DATE COMMENT 'The date on which the purchase agreement expires if not executed or extended. Applicable to Letters of Intent (LOI) and conditional offers.',
    `financing_contingency_date` DATE COMMENT 'The deadline by which the buyer must secure mortgage or financing commitment. If financing is not secured by this date, the buyer may terminate the agreement per contingency terms.',
    `financing_contingency_flag` BOOLEAN COMMENT 'Indicates whether the purchase agreement includes a financing contingency (True = financing contingency is present and active).',
    `inspection_contingency_date` DATE COMMENT 'The deadline by which the buyer must complete physical property inspections and either waive or exercise the inspection contingency.',
    `inspection_contingency_flag` BOOLEAN COMMENT 'Indicates whether the purchase agreement includes a physical inspection contingency (True = inspection contingency is present and active).',
    `is_1031_exchange` BOOLEAN COMMENT 'Indicates whether this transaction is structured as a tax-deferred 1031 exchange under IRS Section 1031, allowing the seller to defer capital gains taxes by reinvesting proceeds into a like-kind property.',
    `latest_amendment_date` DATE COMMENT 'The date of the most recent amendment or addendum executed against this purchase agreement.',
    `loan_amount` DECIMAL(18,2) COMMENT 'The principal loan amount committed or applied for by the buyer to finance this property acquisition, in the transaction currency.',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'The Loan-to-Value (LTV) ratio for the financing associated with this transaction, expressed as a decimal (e.g., 0.75 = 75% LTV). Key underwriting metric used by lenders and investment analysts.',
    `offer_price` DECIMAL(18,2) COMMENT 'The initial purchase price offered by the buyer as stated in the purchase agreement or Letter of Intent (LOI), in the transaction currency.',
    `price_psf` DECIMAL(18,2) COMMENT 'The contract purchase price expressed on a Per Square Foot (PSF) basis, calculated from the contract price divided by the propertys gross leasable or building area. Key metric for CRE deal benchmarking.',
    `psa_number` STRING COMMENT 'Externally-known alphanumeric reference number assigned to the executed Purchase and Sale Agreement (PSA), used for cross-system identification and legal reference.. Valid values are `^PSA-[0-9]{4}-[0-9]{6}$`',
    `sale_of_home_contingency` BOOLEAN COMMENT 'Indicates whether the purchase agreement includes a contingency requiring the buyer to sell their existing property before this transaction can close (True = contingency present).',
    `seller_concessions_amount` DECIMAL(18,2) COMMENT 'The total dollar value of concessions agreed to by the seller, such as closing cost credits, repair allowances, or Tenant Improvement (TI) contributions, reducing the net proceeds to the seller.',
    `target_closing_date` DATE COMMENT 'The contractually agreed target date for closing the property transaction and transferring title, as specified in the PSA.',
    `termination_date` DATE COMMENT 'The date on which the purchase agreement was terminated, if applicable. Populated when agreement_status is terminated. Null for active or closed agreements.',
    `termination_reason` STRING COMMENT 'The reason the purchase agreement was terminated. Captures whether termination was due to a contingency exercise, mutual agreement, buyer or seller default, or specific failure (financing, inspection, appraisal gap). [ENUM-REF-CANDIDATE: contingency_exercised|mutual_agreement|buyer_default|seller_default|financing_failed|inspection_failed|appraisal_gap — promote to reference product]',
    `title_company_name` STRING COMMENT 'The name of the title company or escrow agent responsible for conducting the title search, issuing title insurance, and managing the closing process per ALTA standards.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this purchase agreement record was most recently modified, supporting audit trail, change tracking, and incremental data pipeline processing.',
    `zoning_contingency_flag` BOOLEAN COMMENT 'Indicates whether the purchase agreement includes a zoning or entitlement contingency, allowing the buyer to terminate if required zoning approvals are not obtained.',
    CONSTRAINT pk_purchase_agreement PRIMARY KEY(`purchase_agreement_id`)
) COMMENT 'Records the executed purchase and sale agreement (PSA) for a property transaction, including offer price, contingency terms and deadlines (inspection, financing, appraisal, environmental, zoning, sale of existing home), earnest money terms, due diligence period, closing timeline, and agreement status (LOI, under contract, executed, terminated). Tracks all amendments, addenda, and contingency resolutions through the PSA lifecycle. Integrates with DocuSign CLM for digital execution.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`closing_statement` (
    `closing_statement_id` BIGINT COMMENT 'Unique system-generated identifier for the closing statement record. Primary key for the closing_statement data product in the transaction domain.',
    `asset_id` BIGINT COMMENT 'Reference to the property being conveyed in this closing transaction.',
    `brokerage_deal_id` BIGINT COMMENT 'Reference to the brokerage deal or purchase agreement that culminated in this closing statement.',
    `capital_call_id` BIGINT COMMENT 'Foreign key linking to investment.capital_call. Business justification: The equity portion of cash-to-close on the closing statement is funded by a specific capital call. Investment accounting requires this link to reconcile deployed equity against called capital and upda',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Closing statements verify Certificate of Occupancy (COO) status as a closing condition. The closing_statement has a denormalized coo_status field; linking to compliance.permit normalizes this to the a',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: ALTA/HUD settlement statements for cross-border transactions require normalized currency reference for all financial line items. Multi-currency closing reconciliation and regulatory reporting depend o',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Development cost basis and GAAP capitalization: closing statements for development acquisitions and dispositions must be reconciled against the dev_project for cost basis tracking, investor reporting,',
    `financial_period_close_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period_close. Business justification: Closing statements must be posted within a specific financial period. The financial_period_close controls GL posting windows and sign-off requirements. Real estate controllers require this link to enf',
    `policy_id` BIGINT COMMENT 'Foreign key linking to insurance.policy. Business justification: Closing cost reconciliation: title and hazard insurance premiums are line items on the ALTA/HUD-1 closing statement. Closing agents must verify active policy coverage before disbursement. A real estat',
    `portfolio_asset_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio_asset. Business justification: Investment accounting teams reconcile closing statement net proceeds against the portfolio assets book value to record realized gain/loss entries. This link is required for GAAP/IFRS disposition acco',
    `property_sale_id` BIGINT COMMENT 'Reference to the parent property transaction (acquisition, disposition, or sale event) that this closing statement settles.',
    `property_type_id` BIGINT COMMENT 'Foreign key linking to reference.property_type. Business justification: Transfer tax calculation rules, title insurance premium schedules, and regulatory reporting requirements on the closing statement are property-type-dependent. Settlement agents require normalized prop',
    `purchase_agreement_id` BIGINT COMMENT 'Foreign key linking to transaction.purchase_agreement. Business justification: The closing statement (HUD-1/ALTA) settles the financial terms established in the purchase agreement. Adding purchase_agreement_id to closing_statement creates a direct link between the settlement sta',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Closing statements generate FIRPTA withholding filings (Form 8288-A), 1099-S information returns, and transfer tax returns. Closing attorneys and compliance officers need to link the closing statement',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: ALTA/HUD closing statements are governed by RESPA and state-specific settlement laws that mandate required line items and disclosure formats. Compliance audits require each closing statement to refere',
    `sale_type_id` BIGINT COMMENT 'Foreign key linking to transaction.sale_type. Business justification: closing_statement has transaction_type: STRING which is a free-text classification. sale_type provides the authoritative reference taxonomy for transaction types. Adding transaction_transaction_type_i',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: 1099-S tax reporting, capital gains tracking, and owner transaction history reporting all require identifying which owner entity was the seller at closing. Real estate accountants and compliance offic',
    `tax_assessment_id` BIGINT COMMENT 'Foreign key linking to valuation.tax_assessment. Business justification: Tax proration at closing is computed from the current tax assessment (assessed value, millage rate, installment schedule). The closing statements proration_amount and transfer_tax_amount are derived ',
    `buyer_broker_commission` DECIMAL(18,2) COMMENT 'Portion of the total brokerage commission allocated to the buyers broker (cooperating broker) at closing.',
    `buyer_credit_amount` DECIMAL(18,2) COMMENT 'Total monetary credits applied in favor of the buyer at closing, including lender credits, prorated rents, and security deposit transfers from seller to buyer.',
    `buyer_entity_name` STRING COMMENT 'Legal name of the purchasing party (individual, LLC, corporation, REIT, or trust) as it appears on the closing statement and deed.',
    `cap_rate_at_closing` DECIMAL(18,2) COMMENT 'Implied capitalization rate at the time of closing, calculated as the propertys net operating income (NOI) divided by the gross sale price. Core investment performance metric for CRE transactions.',
    `cash_to_close` DECIMAL(18,2) COMMENT 'Total cash amount the buyer must bring to closing, calculated as the gross sale price less the new loan amount, earnest money deposit, and buyer credits, plus buyer-side closing costs and prorations.',
    `closing_date` DATE COMMENT 'The actual date on which the property transaction closed — funds were disbursed, title transferred, and deed recorded. This is the principal business event date for the closing.',
    `closing_status` STRING COMMENT 'Current lifecycle state of the closing statement. DRAFT indicates preparation; PENDING indicates awaiting execution; EXECUTED indicates signed by all parties; FUNDED indicates funds disbursed; RECORDED indicates deed recorded with county; VOIDED indicates cancelled.. Valid values are `DRAFT|PENDING|EXECUTED|FUNDED|RECORDED|VOIDED`',
    `costar_property_code` STRING COMMENT 'CoStar Suite unique property identifier enabling integration with CoStar comparable sales and market analytics data for benchmarking this transaction against market comps.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this closing statement record was first created in the system. Audit trail field aligned with SOX financial controls.',
    `disbursement_date` DATE COMMENT 'Date on which funds were actually disbursed by the title company or escrow agent to all parties. May differ from closing_date in some jurisdictions or transaction types.',
    `earnest_money_deposit` DECIMAL(18,2) COMMENT 'Good-faith deposit paid by the buyer at contract execution, credited against the purchase price at closing. Held in escrow until closing or contract termination.',
    `escrow_number` STRING COMMENT 'Unique escrow file number assigned by the title company or escrow agent to track this closing transaction through the settlement process.',
    `gl_account_code` STRING COMMENT 'General Ledger account code in Yardi Voyager or SAP S/4HANA to which the net proceeds or acquisition cost from this closing is posted for financial consolidation and reporting.',
    `gross_sale_price` DECIMAL(18,2) COMMENT 'The total contracted purchase price for the property as agreed between buyer and seller before any adjustments, prorations, or credits. The top-line transaction value on the closing statement.',
    `is_1031_exchange` BOOLEAN COMMENT 'Indicates whether this closing is part of an IRS Section 1031 like-kind exchange, allowing the seller to defer capital gains taxes by reinvesting proceeds into a replacement property.',
    `is_reo_transaction` BOOLEAN COMMENT 'Indicates whether this closing involves a Real Estate Owned (REO) property — a property acquired by a lender through foreclosure. REO transactions have distinct pricing, disclosure, and title requirements.',
    `listing_broker_commission` DECIMAL(18,2) COMMENT 'Portion of the total brokerage commission allocated to the listing (sellers) broker at closing.',
    `loan_payoff_amount` DECIMAL(18,2) COMMENT 'Total amount required to fully satisfy and discharge the sellers existing mortgage(s) or deed(s) of trust at closing, including outstanding principal, accrued interest, and prepayment penalties.',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'Ratio of the new loan amount to the gross sale price, expressed as a decimal (e.g., 0.75 = 75% LTV). Key underwriting metric used by lenders and investment analysts to assess leverage risk.',
    `mls_number` STRING COMMENT 'MLS listing identifier associated with this transaction, enabling cross-reference with MLS comparable sales data and CoStar market analytics.',
    `net_proceeds_to_seller` DECIMAL(18,2) COMMENT 'Final net amount disbursed to the seller at closing after deducting loan payoffs, commissions, transfer taxes, title fees, prorations, and all other seller-side charges from the gross sale price. The authoritative seller disbursement figure.',
    `new_loan_amount` DECIMAL(18,2) COMMENT 'Principal amount of the new mortgage or financing obtained by the buyer to fund the acquisition, as reflected on the closing statement. Used to compute Loan-to-Value (LTV) ratio.',
    `notes` STRING COMMENT 'Free-text field for capturing special conditions, contingencies, post-closing obligations, or other material notes related to this closing statement that do not fit structured fields.',
    `proration_amount` DECIMAL(18,2) COMMENT 'Net proration adjustment on the closing statement covering property taxes, HOA dues, prepaid rents, and utility charges apportioned between buyer and seller based on the closing date. Positive value indicates net credit to buyer; negative indicates net debit.',
    `recording_date` DATE COMMENT 'Date on which the deed or title transfer instrument was officially recorded with the county recorder or register of deeds, establishing public notice of ownership transfer.',
    `recording_fee_amount` DECIMAL(18,2) COMMENT 'Fees paid to the county recorder or register of deeds for recording the deed, mortgage, and other closing instruments in the public record.',
    `sale_price_psf` DECIMAL(18,2) COMMENT 'Gross sale price divided by the propertys net leasable area (NLA) or gross leasable area (GLA), expressed in price per square foot (PSF). Key comparable sales metric used in CoStar and appraisal analysis.',
    `seller_credit_amount` DECIMAL(18,2) COMMENT 'Total monetary credits granted by the seller to the buyer at closing, including repair credits, closing cost concessions, and tenant improvement (TI) allowances negotiated in the purchase agreement.',
    `settlement_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged by the title company or escrow agent for conducting the closing and settlement services, separate from title insurance premiums.',
    `statement_number` STRING COMMENT 'Externally-known reference number assigned by the title company or escrow agent to uniquely identify this closing/settlement statement (e.g., HUD-1 file number or ALTA statement reference).',
    `statement_type` STRING COMMENT 'Classification of the settlement statement form used at closing. HUD-1 is the legacy form; ALTA Settlement Statement is the current standard. 1031 Exchange denotes a tax-deferred exchange closing.. Valid values are `HUD-1|ALTA_SETTLEMENT|ALTA_COMBINED|CASH_CLOSING|1031_EXCHANGE`',
    `title_company_name` STRING COMMENT 'Name of the title company or escrow agent responsible for conducting the closing, issuing title insurance, and disbursing funds.',
    `title_insurance_premium` DECIMAL(18,2) COMMENT 'Total premium paid for owners and/or lenders title insurance policies at closing, protecting against title defects, liens, and encumbrances. Governed by ALTA standards.',
    `total_commission_amount` DECIMAL(18,2) COMMENT 'Total brokerage commission paid at closing, typically expressed as a percentage of the gross sale price and split between listing and buyers brokers. Charged to the seller on the closing statement.',
    `transfer_tax_amount` DECIMAL(18,2) COMMENT 'Total real estate transfer taxes, documentary stamp taxes, or deed taxes levied by state and/or local government on the conveyance of the property at closing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this closing statement record was last modified. Supports audit trail and change tracking for SOX compliance.',
    CONSTRAINT pk_closing_statement PRIMARY KEY(`closing_statement_id`)
) COMMENT 'Captures the final settlement statement (HUD-1 / ALTA Settlement Statement) for a property transaction at closing, including gross sale price, prorations, credits, commissions, title insurance premiums, transfer taxes, loan payoffs, net proceeds to seller, and cash to close for buyer. Represents the authoritative financial record of the closing event. Sourced from title company and Yardi Voyager.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` (
    `closing_statement_line_id` BIGINT COMMENT 'Unique surrogate identifier for each individual line item within a closing statement. Primary key for this entity. Entity role: TRANSACTION_LINE.',
    `closing_statement_id` BIGINT COMMENT 'Reference to the parent closing statement (TRANSACTION_HEADER) that this line item belongs to. Establishes the header/detail relationship for closing statement reconciliation. [TRANSACTION_LINE: HEADER_REFERENCE]',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this closing statement line item. Used for financial allocation and reporting in SAP S/4HANA and Yardi Voyager. Enables property-level or portfolio-level cost attribution.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Line-level currency reference is required for multi-currency disbursement reconciliation, GL posting in multi-currency accounting systems, and FIRPTA withholding calculations on individual closing sta',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: GL posting reconciliation: each closing statement line is posted as a journal entry line. Real estate accountants reconcile closing statement lines to journal entries during period-close and audit. Th',
    `security_deposit_id` BIGINT COMMENT 'Foreign key linking to lease.security_deposit. Business justification: Security deposit assumption credits are standard closing statement line items in property sales — the buyer receives a credit for deposits they assume liability for. Linking the closing statement line',
    `premium_id` BIGINT COMMENT 'Foreign key linking to insurance.premium. Business justification: Closing cost GL reconciliation: insurance premium charges (title insurance, hazard insurance prorations) appear as individual closing statement lines. Linking the line item to the insurance premium re',
    `property_sale_id` BIGINT COMMENT 'Reference to the parent property acquisition, disposition, or sale transaction that this closing statement line is associated with. Links line-level economics to the deal record. [TRANSACTION_LINE: RESOURCE_REFERENCE]',
    `buyer_credit_amount` DECIMAL(18,2) COMMENT 'Portion of the credit amount allocated specifically to the buyer on this closing statement line. Captures buyer-side credits such as earnest money applied, seller concessions, or deposit credits.',
    `buyer_debit_amount` DECIMAL(18,2) COMMENT 'Portion of the debit amount allocated specifically to the buyer on this closing statement line. Enables split-party reconciliation where a single line item has distinct buyer and seller components (e.g., prorated property taxes).',
    `charge_category` STRING COMMENT 'High-level category classifying the nature of this closing statement line item. Supports analytics, benchmarking, and PSF (Per Square Foot) cost analysis across transactions. [ENUM-REF-CANDIDATE: commission|title|tax|escrow|financing|insurance|recording|inspection|other — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this closing statement line item record was first created in the system. Used for audit trail, data lineage, and SOX compliance tracking.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Monetary amount credited to the responsible party for this line item, expressed in the transaction currency. Represents reductions, refunds, deposits applied, or amounts received. Used in conjunction with debit_amount for net settlement calculation.',
    `daily_rate` DECIMAL(18,2) COMMENT 'Per-day monetary rate used to calculate the prorated amount for this line item (e.g., annual property tax divided by 365). Stored for audit trail and reconciliation verification of proration calculations.',
    `debit_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged (debited) to the responsible party for this line item, expressed in the transaction currency. Represents costs, fees, or obligations owed. Used in conjunction with credit_amount for net settlement calculation. [TRANSACTION_LINE: LINE_VALUE_OR_RESULT]',
    `disbursement_date` DATE COMMENT 'Date on which the funds for this closing statement line item were or are scheduled to be disbursed to the payee. Supports AP payment scheduling and cash flow management in Yardi Voyager.',
    `escrow_account_number` STRING COMMENT 'Escrow account number associated with this line item for items held in escrow (e.g., earnest money, tax reserves, insurance reserves). Links to the escrow agents account for disbursement tracking.',
    `gl_account_code` STRING COMMENT 'General Ledger (GL) account code to which this closing statement line item is mapped for financial posting in Yardi Voyager or SAP S/4HANA. Enables automated GL integration and financial consolidation. Critical for SOX compliance and financial reporting.',
    `gl_account_name` STRING COMMENT 'Human-readable name of the GL account associated with this line item (e.g., Real Estate Commission Expense, Transfer Tax Payable, Prepaid Property Tax). Supports financial reporting and audit review without requiring GL code lookup.',
    `gl_posted_timestamp` TIMESTAMP COMMENT 'Date and time when this closing statement line item was posted to the General Ledger. Null if not yet posted. Used for financial period close tracking and SOX audit trail.',
    `is_1031_exchange_item` BOOLEAN COMMENT 'Indicates whether this closing statement line item is specifically associated with a 1031 like-kind exchange transaction. Flags items requiring special tax treatment and IRS Form 8824 reporting for deferred capital gains.',
    `is_posted_to_gl` BOOLEAN COMMENT 'Indicates whether this closing statement line item has been successfully posted to the General Ledger in Yardi Voyager or SAP S/4HANA. Critical for financial period close reconciliation and SOX controls.',
    `is_taxable` BOOLEAN COMMENT 'Indicates whether this closing statement line item is subject to applicable taxes (e.g., transfer taxes, sales taxes on services). Drives tax calculation and reporting workflows.',
    `line_description` STRING COMMENT 'Detailed description of the charge, credit, proration, or adjustment as it appears on the closing statement (e.g., Real Estate Commission, Property Tax Proration, Title Insurance Premium, Earnest Money Deposit, Loan Origination Fee). Primary narrative field for reconciliation.',
    `line_number` STRING COMMENT 'Externally-visible alphanumeric line number as printed on the ALTA/HUD-1 closing statement (e.g., 100, 200, 700, 1101). Corresponds to standard ALTA settlement statement section numbering for regulatory and audit traceability.',
    `line_sequence` STRING COMMENT 'Sequential ordering number of this line item within the parent closing statement. Used to preserve the original order of charges, credits, prorations, and adjustments as they appear on the settlement document. [TRANSACTION_LINE: LINE_SEQUENCE]',
    `line_status` STRING COMMENT 'Current workflow status of the closing statement line item. Tracks the lifecycle from initial draft through approval and GL posting. Voided lines are retained for audit trail purposes. [TRANSACTION_LINE: lifecycle status]. Valid values are `draft|pending|approved|posted|voided`',
    `line_type` STRING COMMENT 'Classification of the line item indicating whether it represents a charge, credit, proration, adjustment, deposit, or escrow item on the closing statement. Drives debit/credit logic and GL mapping.. Valid values are `charge|credit|proration|adjustment|deposit|escrow`',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value of this line item calculated as debit_amount minus credit_amount. Positive values indicate a net charge; negative values indicate a net credit. Stored for reconciliation efficiency and GL posting accuracy.',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the closing agent, title officer, or accountant regarding this specific line item. Captures exceptions, explanations, or special instructions not covered by structured fields.',
    `payee_name` STRING COMMENT 'Name of the entity or individual to whom payment is directed for this closing statement line item (e.g., title company, escrow agent, real estate broker, county recorder, lender). Required for AP disbursement and 1099 reporting.',
    `payee_type` STRING COMMENT 'Classification of the payee entity type for this line item. Supports 1099 reporting, AP workflow routing, and commission disbursement processing. [ENUM-REF-CANDIDATE: broker|title_company|lender|government|escrow_agent|vendor|other — promote to reference product]',
    `proration_days` STRING COMMENT 'Number of days used in the proration calculation for this line item. Derived from proration_start_date and proration_end_date but stored explicitly for audit transparency and reconciliation verification.',
    `proration_end_date` DATE COMMENT 'End date of the proration period for line items representing prorated charges such as property taxes, HOA dues, rent, or insurance premiums. Null for non-prorated line items.',
    `proration_start_date` DATE COMMENT 'Start date of the proration period for line items representing prorated charges such as property taxes, HOA dues, rent, or insurance premiums. Null for non-prorated line items.',
    `responsible_party` STRING COMMENT 'Identifies which party bears financial responsibility for this line item on the closing statement — buyer, seller, lender, both parties (split), or a third party. Critical for deal economics analysis and settlement reconciliation.. Valid values are `buyer|seller|lender|both|third_party`',
    `section_code` STRING COMMENT 'ALTA/HUD-1 section code grouping this line item (e.g., 100 for Sales Price, 200 for Amounts Paid by Borrower, 700 for Real Estate Broker Fees, 800 for Items Payable in Connection with Loan, 1100 for Title Charges). Enables structured reconciliation by section.',
    `section_name` STRING COMMENT 'Human-readable name of the ALTA/HUD-1 section this line belongs to (e.g., Sales Price and Financing, Real Estate Broker Fees, Title Charges, Government Recording and Transfer Charges). Supports reporting and reconciliation.',
    `seller_credit_amount` DECIMAL(18,2) COMMENT 'Portion of the credit amount allocated specifically to the seller on this closing statement line. Captures seller-side credits such as sale proceeds, deposit releases, or prepaid expense reimbursements.',
    `seller_debit_amount` DECIMAL(18,2) COMMENT 'Portion of the debit amount allocated specifically to the seller on this closing statement line. Captures seller-side charges such as real estate commissions, outstanding liens, or transfer taxes.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this closing statement line item originated (e.g., Yardi Voyager, MRI Software, SAP S/4HANA, or manual entry). Supports data lineage and reconciliation.. Valid values are `yardi|mri|argus|sap|manual|other`',
    `source_system_line_ref` STRING COMMENT 'The native line item identifier or reference number from the originating source system (e.g., Yardi Voyager transaction line ID, MRI line reference). Enables bi-directional traceability between the lakehouse and the system of record.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applicable to this closing statement line item, such as transfer taxes, documentary stamp taxes, or sales taxes on closing services. Null for non-taxable line items.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this closing statement line item record was last modified. Used for change tracking, audit trail, and incremental data pipeline processing in the Databricks Silver Layer.',
    CONSTRAINT pk_closing_statement_line PRIMARY KEY(`closing_statement_line_id`)
) COMMENT 'Individual line-item detail within a closing statement, capturing each charge, credit, proration, or adjustment — including description, debit/credit amount, party responsible (buyer or seller), and GL account mapping. Enables granular reconciliation of closing economics and supports Yardi Voyager GL integration.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`title_search` (
    `title_search_id` BIGINT COMMENT 'Unique system-generated identifier for the title search record. Primary key for the title_search data product within the transaction domain.',
    `asset_id` BIGINT COMMENT 'Reference to the property record for which the title search and title insurance policy applies.',
    `construction_permit_id` BIGINT COMMENT 'Foreign key linking to development.construction_permit. Business justification: Title underwriting for new construction: title examiners verify COO issuance and open permit status before issuing title insurance on newly constructed properties. Mechanics lien exposure and permit c',
    `entitlement_id` BIGINT COMMENT 'Foreign key linking to development.entitlement. Business justification: Title underwriting for development properties: title examiners must verify entitlement conditions of approval are reflected in the title commitment. Entitlement restrictions and covenants appear as ti',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Title searches are legally conducted against a specific parcel (APN). Linking to property.parcel enables title commitment workflows, chain-of-title lookups by parcel, and lien/encumbrance reconciliati',
    `policy_id` BIGINT COMMENT 'Foreign key linking to insurance.policy. Business justification: Title examination workflow: a title search directly results in a title insurance policy (ALTA owners or lenders policy). title_search.insurer_name and alta_policy_number are denormalized from the in',
    `property_sale_id` BIGINT COMMENT 'Reference to the parent property acquisition, disposition, or sale transaction for which this title search was conducted.',
    `purchase_agreement_id` BIGINT COMMENT 'Foreign key linking to transaction.purchase_agreement. Business justification: Title searches are ordered as part of the purchase agreement due diligence process. While title_search already links to property_sale, adding a direct link to purchase_agreement provides clearer trace',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Title search requirements, ALTA policy standards, and mandatory lien search obligations are governed by state title insurance regulations and RESPA. Title companies must track the applicable regulator',
    `tenure_type_id` BIGINT COMMENT 'Foreign key linking to reference.tenure_type. Business justification: Title examination scope, ALTA policy type selection, chain-of-title requirements, and encumbrance review methodology are fundamentally determined by tenure type. Title examiners must classify tenure t',
    `title_record_id` BIGINT COMMENT 'Foreign key linking to property.title_record. Business justification: A transaction-time title search must reconcile against the standing title_record on the asset. This link enables post-closing title record updates, exception tracking, and audit trails required by tit',
    `chain_of_title_years` STRING COMMENT 'Number of years of ownership history examined in the title search, representing the depth of the chain-of-title review (e.g., 40 years, 60 years).',
    `commitment_date` DATE COMMENT 'Date on which the title commitment (binder) was issued by the title company, committing to insure title subject to listed requirements and exceptions.',
    `commitment_expiry_date` DATE COMMENT 'Date on which the title commitment expires if closing has not occurred, after which a new or updated commitment must be issued.',
    `coo_status` STRING COMMENT 'Status of the Certificate of Occupancy (COO) for the property as determined during the title search, confirming whether the building has been legally approved for occupancy.. Valid values are `issued|not_required|pending|not_issued`',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of coverage provided under the title insurance policy, typically equal to the purchase price for an owners policy or the loan amount for a loan policy.',
    `coverage_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the title insurance coverage amount (e.g., USD).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this title search record was first created in the system, used for audit trail and data lineage purposes.',
    `deed_book_reference` STRING COMMENT 'Public records reference for the most recent deed in the chain of title, including deed book/volume number and page number as recorded in the county recorders office.',
    `easement_count` STRING COMMENT 'Number of easements identified on the property, including utility easements, access easements, drainage easements, and conservation easements that affect use or marketability of title.',
    `effective_date` DATE COMMENT 'Date on which the title insurance policy becomes effective, typically the date of closing and recording of the deed.',
    `encumbrance_count` STRING COMMENT 'Total number of encumbrances identified on the property title, including mortgages, deeds of trust, easements, covenants, conditions, and restrictions (CC&Rs).',
    `endorsements` STRING COMMENT 'List of ALTA endorsements attached to the title insurance policy that expand or modify standard coverage (e.g., ALTA 3.1 Zoning, ALTA 9 Restrictions/Encroachments/Minerals, ALTA 22 Location). Stored as a comma-separated list of endorsement codes.',
    `environmental_lien_flag` BOOLEAN COMMENT 'Indicates whether any environmental liens or notices of environmental action were identified against the property during the title search, which may affect marketability of title.',
    `exception_count` STRING COMMENT 'Number of standard and special exceptions listed in Schedule B of the title commitment or policy, representing matters excluded from title insurance coverage.',
    `exception_notes` STRING COMMENT 'Narrative description of material title exceptions and exclusions listed in Schedule B of the title commitment or policy, including specific encumbrances, easements, restrictions, and other matters not covered by the policy.',
    `existing_mortgage_amount` DECIMAL(18,2) COMMENT 'Outstanding principal balance of existing mortgage(s) or deed(s) of trust encumbering the property as identified in the title search, which must be satisfied or assumed at closing.',
    `hoa_lien_flag` BOOLEAN COMMENT 'Indicates whether any Homeowners Association (HOA) or condominium association liens for unpaid assessments were identified against the property during the title search.',
    `judgment_lien_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of judgment liens recorded against the property or current owner, identified during the title search and requiring resolution prior to clear title transfer.',
    `legal_description` STRING COMMENT 'Full legal description of the property as recorded in the deed and public records, including lot, block, subdivision, metes and bounds, or other legal description format.',
    `lien_count` STRING COMMENT 'Total number of outstanding liens identified against the property during the title search, including tax liens, mechanics liens, judgment liens, and HOA liens.',
    `lien_search_result` STRING COMMENT 'Summary result of the lien search conducted as part of the title examination, indicating whether any outstanding liens (tax liens, mechanics liens, judgment liens, HOA liens) were discovered against the property.. Valid values are `clear|liens_found|pending_review`',
    `mechanics_lien_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of mechanics liens or materialmans liens filed against the property by contractors or suppliers for unpaid construction or improvement work.',
    `ordered_timestamp` TIMESTAMP COMMENT 'Date and time when the title search was formally ordered from the title company or abstracting firm, marking the initiation of the title examination process.',
    `policy_type` STRING COMMENT 'Type of ALTA title insurance policy issued: owners policy protecting the buyer, loan policy protecting the lender, leasehold policy for long-term lease interests, or simultaneous issue covering both owner and lender.. Valid values are `owners_policy|loan_policy|leasehold_policy|simultaneous_issue`',
    `premium_amount` DECIMAL(18,2) COMMENT 'One-time premium paid for the title insurance policy, typically a function of the coverage amount and state-filed rate schedules.',
    `recording_jurisdiction` STRING COMMENT 'Name of the county, parish, or municipality where the deed and title documents are recorded in the public land records (e.g., Cook County, IL).',
    `requirements_notes` STRING COMMENT 'Narrative description of Schedule B-I requirements that must be satisfied prior to closing for the title company to issue the final title insurance policy (e.g., payoff of existing mortgages, release of liens, execution of documents).',
    `search_from_date` DATE COMMENT 'Start date of the chain-of-title period examined in the title search, establishing the historical depth of the title examination.',
    `search_order_number` STRING COMMENT 'Externally-known order number assigned by the title company or abstracting firm when the title search was commissioned. Used for cross-referencing with the title companys records.',
    `search_status` STRING COMMENT 'Current lifecycle status of the title search process, from initial order through commitment issuance and final policy delivery.. Valid values are `ordered|in_progress|completed|commitment_issued|policy_issued|cancelled`',
    `search_through_date` DATE COMMENT 'End date (effective date) of the title search examination period, representing the most recent date through which public records were reviewed.',
    `search_type` STRING COMMENT 'Classification of the title search scope: full chain-of-title search, update/bring-down search for a prior search, or targeted lien or judgment search.. Valid values are `full_search|update_search|bring_down|lien_search|judgment_search`',
    `snda_required` BOOLEAN COMMENT 'Indicates whether a Subordination, Non-Disturbance, and Attornment Agreement (SNDA) is required as part of the title commitment requirements, typically when existing tenants leases must be subordinated to a new mortgage.',
    `survey_date` DATE COMMENT 'Date of the most recent ALTA/NSPS land title survey reviewed as part of the title examination.',
    `survey_required` BOOLEAN COMMENT 'Indicates whether an ALTA/NSPS land title survey is required as a condition of the title commitment or as a lender requirement prior to policy issuance.',
    `tax_lien_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of outstanding property tax liens identified during the title search, representing delinquent taxes that must be resolved prior to or at closing.',
    `title_agent_name` STRING COMMENT 'Name of the title agent or title company acting as the issuing agent for the title insurance policy on behalf of the underwriter.',
    `title_examiner_name` STRING COMMENT 'Name of the attorney or title examiner who conducted the title examination and certified the chain of title.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this title search record was last modified, supporting audit trail requirements and change tracking.',
    `vesting_type` STRING COMMENT 'Form of ownership or vesting under which title is held or will be transferred, determining ownership rights and survivorship provisions. [ENUM-REF-CANDIDATE: fee_simple|leasehold|tenancy_in_common|joint_tenancy|community_property|trust|life_estate|condominium — promote to reference product]. Valid values are `fee_simple|leasehold|tenancy_in_common|joint_tenancy|community_property|trust`',
    CONSTRAINT pk_title_search PRIMARY KEY(`title_search_id`)
) COMMENT 'Tracks the title search, title commitment, and title insurance policy for a property transaction. Captures ALTA title policy number, insurer, coverage amount, effective date, exceptions and exclusions, lien search results, encumbrances, easements, and COO status. Serves as the authoritative record of title transfer and chain of title. Integrates with ALTA standards.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`deed_transfer` (
    `deed_transfer_id` BIGINT COMMENT 'Unique surrogate identifier for the deed transfer record in the lakehouse Silver layer. Primary key for this entity.',
    `asset_id` BIGINT COMMENT 'Reference to the property record for which ownership is being conveyed via this deed transfer.',
    `closing_statement_id` BIGINT COMMENT 'Foreign key linking to transaction.closing_statement. Business justification: A deed transfer is recorded at closing and is directly associated with the closing statement that documents the financial settlement. deed_transfer already has property_sale_id → property_sale, but ad',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Deed consideration amount and transfer tax calculation require normalized currency reference for cross-border transactions and multi-currency portfolio reporting. Recording jurisdictions require state',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Chain-of-title reporting, transfer tax compliance, and owner disposition history require linking the deed grantor to a tracked owner entity. Title examiners and compliance officers use this to verify ',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: A deed transfer is recorded against a specific parcel at the county recorder. Linking to property.parcel enables post-closing parcel record updates, chain-of-title maintenance, and transfer tax jurisd',
    `policy_id` BIGINT COMMENT 'Foreign key linking to insurance.policy. Business justification: Deed recordation and title insurance issuance are concurrent closing events. deed_transfer.title_policy_number is denormalized from the insurance policy. Title and conveyancing professionals expect th',
    `property_sale_id` BIGINT COMMENT 'Reference to the parent acquisition or disposition transaction record that initiated this deed transfer event.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Deed transfers trigger Real Estate Transfer Tax (RETT) returns, recording filings, and in some states grantor/grantee disclosure filings. Title officers and compliance managers need to link each deed ',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Deed recording requirements, transfer tax rates, grantor/grantee disclosure obligations, and FIRPTA compliance are governed by jurisdiction-specific regulatory frameworks. Compliance teams must link e',
    `tenure_type_id` BIGINT COMMENT 'Foreign key linking to reference.tenure_type. Business justification: Deed type selection (warranty, quitclaim, grant deed), transfer tax applicability, and recording requirements differ by tenure type. Recording clerks and title companies require tenure type classifica',
    `title_record_id` BIGINT COMMENT 'Foreign key linking to property.title_record. Business justification: After closing, the deed transfer must update the propertys standing title_record (grantor/grantee, vesting, encumbrances). This link drives the post-closing title record update workflow and supports ',
    `arms_length_flag` BOOLEAN COMMENT 'Indicates whether the deed transfer was conducted as an arms-length transaction between unrelated parties acting in their own self-interest. Non-arms-length transfers (e.g., family transfers, related-party transactions) are excluded from comparable sales analysis and CAP rate benchmarking.',
    `book_number` STRING COMMENT 'Official deed book or liber number assigned by the county recorder where the deed instrument is physically or digitally filed. Used in conjunction with page number for precise title search reference.',
    `closing_date` DATE COMMENT 'The date on which the real estate transaction closed, funds were disbursed, and possession transferred. Typically the same as or immediately preceding the recording date. Used for financial period recognition under FASB ASC 606 and for REIT reporting.',
    `consideration_amount` DECIMAL(18,2) COMMENT 'The total monetary consideration (purchase price) stated on the deed instrument, representing the gross sale price paid by the grantee to the grantor. Used as the basis for transfer tax calculation, CAP rate analysis, and PSF pricing benchmarks. May differ from assessed value.',
    `costar_comp_code` STRING COMMENT 'CoStar Suite comparable sale record identifier linked to this deed transfer. Enables integration with CoStars commercial real estate analytics platform for PSF benchmarking, CAP rate analysis, and market trend reporting.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the jurisdiction where the property is located (e.g., USA, CAN, GBR). Supports international portfolio management and FIRPTA foreign seller withholding compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deed transfer record was first created in the lakehouse Silver layer. Used for audit trail, data lineage, and SOX financial controls compliance.',
    `deed_type` STRING COMMENT 'Classification of the deed instrument conveying ownership. Warranty deeds provide full title guarantees; quitclaim deeds convey only the grantors interest without warranty; trustee deeds arise from foreclosure or trust sales; special warranty deeds limit the grantors warranty to the period of their ownership. [ENUM-REF-CANDIDATE: warranty|special_warranty|quitclaim|trustee|grant|bargain_and_sale|sheriff|tax — promote to reference product if additional types required]. Valid values are `warranty|special_warranty|quitclaim|trustee|grant|bargain_and_sale`',
    `document_number` STRING COMMENT 'Official document number assigned by the county recorder or registrar of deeds upon recording. Used as the primary external reference for title searches and ALTA title commitments.',
    `earnest_money_amount` DECIMAL(18,2) COMMENT 'Amount of earnest money deposit paid by the buyer (grantee) at the time of the purchase agreement execution, applied toward the consideration at closing. Tracked for deal economics reconciliation and escrow management.',
    `exchange_1031_flag` BOOLEAN COMMENT 'Indicates whether this deed transfer is part of a tax-deferred like-kind exchange under IRC Section 1031. When true, the transaction is subject to strict identification and exchange period deadlines and requires qualified intermediary documentation.',
    `execution_date` DATE COMMENT 'The date on which the grantor signed and executed the deed instrument, which may precede the recording date. Relevant for determining the effective date of conveyance and for 1031 exchange identification period calculations.',
    `foreclosure_flag` BOOLEAN COMMENT 'Indicates whether this deed transfer resulted from a foreclosure proceeding (e.g., sheriffs deed, trustees deed upon sale). Distinct from REO flag — foreclosure flag marks the transfer event itself, while REO flag marks lender-owned status.',
    `grantee_entity_type` STRING COMMENT 'Legal entity classification of the grantee. Used for ownership structure analysis, REIT compliance reporting, and AML/KYC beneficial ownership tracking. [ENUM-REF-CANDIDATE: individual|corporation|llc|trust|partnership|government|reit|estate|other — promote to reference product]',
    `grantee_name` STRING COMMENT 'Full legal name of the grantee (buyer/transferee) as it appears on the recorded deed instrument. May be an individual, corporation, trust, LLC, REIT, or other legal entity. Used for ownership records and investor reporting.',
    `grantor_entity_type` STRING COMMENT 'Legal entity classification of the grantor. Determines applicable transfer tax exemptions, 1031 exchange eligibility, and FIRPTA withholding requirements for foreign sellers. [ENUM-REF-CANDIDATE: individual|corporation|llc|trust|partnership|government|reit|estate|other — promote to reference product]',
    `instrument_number` STRING COMMENT 'Sequential instrument or reception number assigned by the recorders office at the time of recording, distinct from the document number in jurisdictions that use both. Provides an alternative lookup key for title searches.',
    `legal_description` STRING COMMENT 'Full legal description of the real property as it appears on the recorded deed, including metes and bounds, lot and block, or government survey description. Defines the exact parcel boundaries conveyed and is required for ALTA title insurance commitments.',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'Loan-to-Value (LTV) ratio at the time of the deed transfer, calculated as the mortgage loan amount divided by the consideration amount. Key underwriting metric for CMBS, RMBS, and lender risk assessment. Stored as a decimal (e.g., 0.75 = 75%).',
    `mls_transaction_code` STRING COMMENT 'Transaction identifier from the Multiple Listing Service (MLS) system associated with this deed transfer. Enables cross-referencing with MLS comparable sales data and CoStar Suite for market analytics and CMA reporting.',
    `mortgage_amount` DECIMAL(18,2) COMMENT 'Principal amount of the mortgage or deed of trust loan recorded concurrently with the deed transfer. Used for LTV calculation, DSCR analysis, and CMBS/RMBS portfolio reporting.',
    `notary_commission_expiry` DATE COMMENT 'Expiration date of the notary publics commission at the time of deed execution. Validates that the notarization was performed by a duly commissioned notary, which is required for deed recordability.',
    `notary_name` STRING COMMENT 'Name of the notary public who acknowledged the grantors signature on the deed instrument. Required for deed validity in most US jurisdictions and referenced in ALTA title review.',
    `page_number` STRING COMMENT 'Page number within the deed book where the recorded deed instrument begins. Together with book number, provides the complete recorders reference citation for chain-of-title research.',
    `price_per_sqf` DECIMAL(18,2) COMMENT 'Sale price expressed on a per-square-foot (PSF) basis, calculated as consideration amount divided by the propertys gross leasable area (GLA) or building area. Key metric for comparable sales analysis (CMA), CoStar benchmarking, and investment underwriting.',
    `recording_date` DATE COMMENT 'The date on which the deed was officially recorded with the county recorder or registrar of deeds. This date establishes constructive notice of the ownership transfer and is the legally operative date for title chain-of-title purposes.',
    `recording_fee_amount` DECIMAL(18,2) COMMENT 'Fee paid to the county recorder or registrar of deeds for the official recording of the deed instrument. Included in closing cost reconciliation and CAPEX tracking for acquisition cost basis.',
    `recording_jurisdiction` STRING COMMENT 'Name of the county, parish, or municipality where the deed was recorded (e.g., Los Angeles County, CA). Determines applicable transfer tax rates, recording requirements, and the governing recorders office for title searches.',
    `reo_flag` BOOLEAN COMMENT 'Indicates whether this deed transfer involves a Real Estate Owned (REO) property — real property acquired by a lender through foreclosure. REO transactions require special handling for CMBS reporting and distressed asset analytics.',
    `source_system` STRING COMMENT 'Operational system of record from which this deed transfer record was ingested (e.g., Yardi Voyager, MRI Software, Argus Enterprise, CoStar Suite, or manual entry). Used for data lineage tracking and reconciliation in the lakehouse Silver layer.. Valid values are `yardi|mri|argus|costar|manual|other`',
    `state_code` STRING COMMENT 'Two-letter US state (or equivalent jurisdiction) code where the property is located and the deed was recorded. Used for state-level transfer tax calculation, regulatory compliance, and geographic portfolio segmentation.. Valid values are `^[A-Z]{2}$`',
    `title_company_name` STRING COMMENT 'Name of the title insurance company or title agency that conducted the closing, issued the ALTA title commitment, and facilitated the deed recording. Used for vendor management and title claim tracking.',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the deed transfer. Pending indicates the deed has been executed but not yet submitted for recording; Recorded confirms the county recorder has accepted and stamped the instrument; Rejected indicates the recorder returned the deed for correction; Voided indicates the transfer was rescinded prior to recording.. Valid values are `pending|recorded|rejected|voided|under_review`',
    `transfer_tax_amount` DECIMAL(18,2) COMMENT 'Total real estate transfer tax (also known as deed tax, documentary stamp tax, or conveyance tax) paid at closing, as recorded on the deed or closing statement. Calculated based on consideration amount and applicable state/county tax rates. Required for SOX financial controls and regulatory reporting.',
    `transfer_type` STRING COMMENT 'Classification of the nature of the ownership transfer. Sale indicates a market-rate conveyance; Gift and Inheritance indicate non-monetary transfers; Exchange covers 1031 like-kind exchanges; Intra-entity covers transfers between related legal entities; Court Order covers judicial transfers. [ENUM-REF-CANDIDATE: sale|gift|inheritance|foreclosure|exchange|intra_entity|court_order|partition — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this deed transfer record was last modified in the lakehouse Silver layer. Supports incremental data processing, change data capture, and audit trail requirements under SOX.',
    `vesting_type` STRING COMMENT 'Form of title vesting under which the grantee takes ownership (e.g., sole ownership, joint tenancy with right of survivorship, tenancy in common, community property, trust, or entity ownership). Determines ownership rights, survivorship, and disposition requirements.. Valid values are `sole_ownership|joint_tenancy|tenancy_in_common|community_property|trust|entity`',
    CONSTRAINT pk_deed_transfer PRIMARY KEY(`deed_transfer_id`)
) COMMENT 'Records the legal deed transfer event for a property, capturing deed type (warranty, quitclaim, special warranty, trustee), grantor, grantee, recording date, county recorder document number, legal description, consideration amount, transfer tax paid, and recording jurisdiction. Represents the official conveyance of real property ownership. Linked to ALTA title records.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`financing` (
    `financing_id` BIGINT COMMENT 'Primary key for financing',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: Mortgage and commercial loan underwriting is conditioned on a formal appraisal; the LTV ratio on financing is computed from the appraised value. Lenders require the appraisal record to be traceable fr',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Loan proceeds at closing are funded into a specific bank account. Real estate finance teams track which bank account received loan funding for cash management, bank reconciliation, and lender reportin',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Portfolio-level debt exposure analysis, LTV monitoring across an owners holdings, and lender covenant compliance reporting require linking each financing record to the borrowing owner entity. Investm',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Loan amount, outstanding balance, and annual debt service require normalized currency reference for multi-currency portfolio DSCR calculations, lender reporting, and CMBS securitization analytics.',
    `debt_facility_id` BIGINT COMMENT 'Foreign key linking to investment.debt_facility. Business justification: Transaction-level loan draws are funded from portfolio-level debt facilities (e.g., subscription credit lines, construction facilities). Linking financing to debt_facility enables investment managers ',
    `debt_instrument_id` BIGINT COMMENT 'Reference to the corresponding debt instrument record in the finance domain, enabling linkage to GL entries, debt service schedules, and financial consolidation in SAP S/4HANA.',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: Construction lending: construction loans in transaction.financing fund specific dev_projects. Lenders require draw schedules tied to project milestones. Development teams track loan commitments agains',
    `endorsement_id` BIGINT COMMENT 'Foreign key linking to insurance.endorsement. Business justification: Lender endorsement compliance: mortgage lenders require specific policy endorsements (mortgagee clause, lender loss payee, standard mortgage clause). Linking financing to the endorsement that names th',
    `ground_lease_id` BIGINT COMMENT 'Foreign key linking to lease.ground_lease. Business justification: Leasehold financing uses the ground lease interest as collateral. Lenders underwriting leasehold mortgages must reference the ground lease for remaining term, rent escalation, and reversion rights ana',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to investment.vehicle. Business justification: Loans are borrowed by specific investment vehicles (SPEs). Linking transaction financing to investment_vehicle enables legal-entity-level debt reporting, covenant compliance tracking at the vehicle le',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to maintenance.capex_project. Business justification: Construction loans, renovation financing, and bridge loans are directly tied to specific CAPEX projects. Lenders and borrowers track loan draws against CAPEX project milestones. This link enables cons',
    `policy_id` BIGINT COMMENT 'Foreign key linking to insurance.policy. Business justification: Lender insurance compliance: mortgage lenders require hazard and flood insurance as a loan condition, naming themselves as additional insured or loss payee. Linking financing to the required insurance',
    `property_sale_id` BIGINT COMMENT 'Reference to the parent property acquisition, disposition, or sale transaction that this financing record supports.',
    `purchase_agreement_id` BIGINT COMMENT 'Foreign key linking to transaction.purchase_agreement. Business justification: Financing for a property transaction is arranged under the terms of the purchase agreement, which specifies financing contingency dates, loan amounts, and LTV requirements. financing already has prope',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Loan origination is subject to RESPA, Dodd-Frank, state lending laws, and CFPB regulations. Compliance officers must classify each financing record under its governing regulatory framework for audit t',
    `tenure_type_id` BIGINT COMMENT 'Foreign key linking to reference.tenure_type. Business justification: Leasehold financing has materially different LTV limits, lender requirements, and CMBS eligibility than fee simple financing. Underwriters and loan committees require tenure type classification for lo',
    `amortization_period_months` STRING COMMENT 'Total number of months over which the loan principal is amortized for payment calculation purposes. May differ from the loan term for balloon loans.',
    `amortization_type` STRING COMMENT 'Describes the repayment structure of the loan — fully amortizing (principal and interest), interest-only (IO), partial interest-only period followed by amortization, or balloon payment at maturity.. Valid values are `fully_amortizing|interest_only|partial_io|balloon`',
    `annual_debt_service` DECIMAL(18,2) COMMENT 'Total annual principal and interest payment obligation under the loan. Used as the denominator in DSCR calculations and for NOI/cash flow analysis in Argus Enterprise.',
    `collateral_description` STRING COMMENT 'Narrative description of the collateral pledged to secure the loan, including property address, legal description, or portfolio of properties for cross-collateralized loans.',
    `commitment_date` DATE COMMENT 'Date on which the lender issued a formal loan commitment letter, binding the lender to provide financing subject to conditions precedent. Key milestone in the transaction timeline.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this financing record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `dscr` DECIMAL(18,2) COMMENT 'Ratio of the propertys Net Operating Income (NOI) to annual debt service obligations at origination. A DSCR below 1.0 indicates insufficient income to cover debt payments; critical for CMBS underwriting and covenant compliance.',
    `escrow_required` BOOLEAN COMMENT 'Indicates whether the lender requires the borrower to maintain an escrow account for property taxes, insurance, and/or capital reserves as a condition of the loan.',
    `escrow_reserve_amount` DECIMAL(18,2) COMMENT 'Total amount held in escrow reserve accounts (taxes, insurance, capital reserves) as required by the lender at the time of reporting.',
    `extension_option_count` STRING COMMENT 'Number of extension options available to the borrower to extend the loan maturity beyond the initial term, subject to conditions. Common in bridge and construction loans.',
    `extension_period_months` STRING COMMENT 'Duration in months of each extension option available to the borrower. Multiplied by extension_option_count to determine maximum extended loan term.',
    `financing_status` STRING COMMENT 'Current lifecycle state of the financing arrangement. Tracks progression from initial commitment through funding, assumption of existing debt, full payoff, or cancellation.. Valid values are `pending|committed|funded|assumed|paid_off|cancelled`',
    `first_payment_date` DATE COMMENT 'Date on which the first scheduled debt service payment (principal and/or interest) is due under the loan agreement.',
    `funding_date` DATE COMMENT 'Date on which loan proceeds were disbursed to the borrower or escrow at closing. May differ from origination date for construction loans with draw schedules.',
    `index_rate_type` STRING COMMENT 'Benchmark interest rate index to which the floating rate is pegged for ARM or floating-rate loans (e.g., SOFR, Prime, Treasury). Null for fixed-rate instruments.. Valid values are `SOFR|LIBOR|Prime|Treasury|EURIBOR|SONIA`',
    `interest_only_period_months` STRING COMMENT 'Number of months at the start of the loan term during which only interest payments are required, with no principal amortization. Applicable to IO and partial-IO loan structures.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applicable to the loan at origination, expressed as a decimal (e.g., 0.065 = 6.5%). For ARM loans, this represents the initial rate; see also spread and index fields.',
    `is_assumption` BOOLEAN COMMENT 'Indicates whether this financing record represents the assumption of existing seller debt rather than new origination. True when the buyer assumes the sellers existing loan at closing.',
    `lender_name` STRING COMMENT 'Legal name of the lending institution, bank, insurance company, debt fund, or government agency providing the financing.',
    `lien_position` STRING COMMENT 'Priority position of the lenders lien on the collateral property. First lien has senior claim; mezzanine and subordinate positions carry higher risk and typically higher rates.. Valid values are `first|second|mezzanine|subordinate`',
    `loan_amount` DECIMAL(18,2) COMMENT 'Original principal amount of the loan at origination or assumption, expressed in the transaction currency. Used in LTV, DSCR, and debt service calculations.',
    `loan_number` STRING COMMENT 'Externally assigned loan reference number issued by the lender or servicer, used for cross-referencing with lender systems and CMBS/RMBS reporting.',
    `loan_term_months` STRING COMMENT 'Contractual duration of the loan from origination to maturity date, expressed in months. Distinct from amortization period for balloon and IO structures.',
    `loan_to_cost_ratio` DECIMAL(18,2) COMMENT 'Ratio of the loan amount to the total project cost, used primarily for construction and development financing to assess lender exposure relative to total development spend.',
    `loan_type` STRING COMMENT 'Classification of the financing instrument by structure and purpose (e.g., ARM, FRM, CMBS, bridge, construction, mezzanine, CMBS, RMBS, HUD, SBA 504). [ENUM-REF-CANDIDATE: ARM|FRM|CMBS|RMBS|bridge|construction|mezzanine|HUD|SBA_504|hard_money — promote to reference product]',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'Ratio of the loan amount to the appraised or purchase value of the property at origination, expressed as a decimal (e.g., 0.65 = 65% LTV). Key underwriting metric for lenders and investors.',
    `maturity_date` DATE COMMENT 'Contractual date on which the outstanding loan balance is due in full. Critical for refinancing planning, portfolio management, and WALE/WALT analysis.',
    `origination_date` DATE COMMENT 'Date on which the loan was formally originated and the loan agreement was executed. Serves as the start date for interest accrual and amortization schedules.',
    `origination_fee_amount` DECIMAL(18,2) COMMENT 'Upfront fee charged by the lender at loan origination, expressed as a dollar amount. Included in closing cost analysis and CAPEX tracking.',
    `origination_fee_pct` DECIMAL(18,2) COMMENT 'Origination fee expressed as a percentage of the loan amount (e.g., 0.01 = 1 point). Used alongside the dollar amount for benchmarking and deal economics analysis.',
    `outstanding_balance` DECIMAL(18,2) COMMENT 'Current unpaid principal balance of the loan as of the most recent reporting date. Used for portfolio-level debt tracking and DSCR monitoring.',
    `pmi_monthly_amount` DECIMAL(18,2) COMMENT 'Monthly PMI premium amount payable when PMI is required. Null when pmi_required is False.',
    `pmi_required` BOOLEAN COMMENT 'Indicates whether Private Mortgage Insurance (PMI) is required for this loan, typically triggered when LTV exceeds 80% on residential transactions.',
    `prepayment_penalty_type` STRING COMMENT 'Type of prepayment restriction or penalty applicable to the loan. Defeasance and yield maintenance are common in CMBS structures; step-down schedules are typical in agency loans.. Valid values are `none|step_down|yield_maintenance|defeasance|lockout`',
    `purpose` STRING COMMENT 'Business purpose of the financing — whether it supports a new acquisition, refinancing of existing debt, construction draw facility, assumption of seller debt, bridge to permanent financing, or equity recapture.. Valid values are `acquisition|refinance|construction|assumption|bridge|equity_recapture`',
    `rate_spread` DECIMAL(18,2) COMMENT 'Margin or spread added to the benchmark index rate to determine the all-in floating interest rate, expressed as a decimal (e.g., 0.0225 = 225 basis points). Applicable to ARM and floating-rate loans.',
    `rate_type` STRING COMMENT 'Indicates whether the loan carries a fixed rate (FRM), floating/variable rate (ARM), or hybrid structure (fixed for an initial period then floating).. Valid values are `fixed|floating|hybrid`',
    `recourse_type` STRING COMMENT 'Indicates whether the loan is full recourse (lender can pursue borrower assets beyond the collateral), non-recourse (limited to collateral), or partial recourse with carve-outs. Critical for risk assessment and REIT compliance.. Valid values are `full_recourse|non_recourse|partial_recourse`',
    `servicer_name` STRING COMMENT 'Name of the loan servicer responsible for collecting payments and managing the loan on behalf of the lender or CMBS trust, which may differ from the originating lender.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this financing record, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for incremental data pipeline processing and audit compliance.',
    CONSTRAINT pk_financing PRIMARY KEY(`financing_id`)
) COMMENT 'Captures the financing structure for a property transaction, including loan type (ARM, FRM, CMBS, bridge, construction), lender name, loan amount, LTV ratio, interest rate, DSCR, loan-to-cost ratio, origination fees, PMI indicator, loan commitment date, and funding date. Tracks both acquisition financing and assumption of existing debt. Supports CMBS and RMBS reporting.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`exchange_1031` (
    `exchange_1031_id` BIGINT COMMENT 'Unique system-generated identifier for the IRS Section 1031 like-kind exchange transaction record. Primary key for this entity. Role: TRANSACTION_HEADER.',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: IRS Form 8824 requires consistent currency reporting for realized gain, deferred gain, and boot calculations. Multi-currency 1031 exchanges require normalized currency reference for tax compliance and',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: 1031 exchanges require a dedicated internal coordinator to manage IRS compliance deadlines (45-day identification, 180-day closing). Tracking the responsible employee is mandatory for regulatory audit',
    `owner_id` BIGINT COMMENT 'Reference to the owner or entity (individual, LLC, partnership, REIT) executing the 1031 exchange as the taxpayer/exchangor. Links to the owner or investor party master record.',
    `portfolio_asset_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio_asset. Business justification: 1031 exchange deferred gain and replacement basis carryover must be tracked against the portfolio asset for investment tax accounting and K-1 preparation. Investment teams need this link to update the',
    `asset_id` BIGINT COMMENT 'Reference to the property being sold/transferred as part of the 1031 exchange (the relinquished or down-leg property). Links to the property master record for asset details, address, and valuation history.',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to transaction.property_sale. Business justification: A 1031 like-kind exchange is initiated by the sale of the relinquished property, which is recorded as a property_sale. exchange_1031 currently has no FK to property_sale despite being directly trigger',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: 1031 exchanges require IRS Form 8824 filing and state-level like-kind exchange returns. The exchange_1031 product tracks form_8824_filed flag but has no FK to the actual regulatory_filing record. Tax ',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: 1031 exchanges are governed by IRC Section 1031, IRS Revenue Procedures, and Treasury Regulations — specific named regulatory frameworks. Tax compliance tracking, identification deadline enforcement, ',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: 1031 exchanges are governed by IRC Section 1031, Treasury Regulations, and state equivalents. Linking to the governing regulatory_obligation enables compliance teams to track identification deadlines,',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: IRS Form 8824 and 1031 exchange compliance require documented fair market value of the relinquished property. The appraisal establishes FMV for deferred gain and basis calculations. Role-prefix relin',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: 1031 exchange compliance: replacement property is often a development project. Exchange timeline (45-day ID, 180-day close) must be tracked against dev_project completion schedule. Role-prefixed repl',
    `boot_amount` DECIMAL(18,2) COMMENT 'Total boot received in the exchange — any non-like-kind property or cash received that does not qualify for tax deferral. Includes cash boot (net cash received) and mortgage boot (net debt relief). Boot triggers immediate taxable gain recognition.',
    `boot_type` STRING COMMENT 'Classification of boot received in the exchange: none (fully deferred), cash (net cash received), mortgage_relief (net debt reduction), or mixed (combination of cash and mortgage relief). Determines the nature of taxable gain recognition.. Valid values are `none|cash|mortgage_relief|mixed`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this 1031 exchange record was first created in the system. Used for audit trail, data lineage, and SOX financial controls compliance.',
    `deferred_gain` DECIMAL(18,2) COMMENT 'The portion of realized gain deferred for tax purposes under IRS Section 1031 — calculated as realized gain minus recognized gain. This deferred gain reduces the tax basis of the replacement property and is recognized upon future disposition.',
    `exchange_agreement_date` DATE COMMENT 'The date on which the formal exchange agreement was executed between the taxpayer and the Qualified Intermediary (QI). Must be entered into before the taxpayer transfers the relinquished property to qualify as a valid delayed exchange.',
    `exchange_closing_deadline` DATE COMMENT 'The IRS-mandated deadline by which the taxpayer must close on the replacement property — exactly 180 calendar days from the relinquished property closing date (or the due date of the tax return, whichever is earlier). Failure disqualifies the exchange.',
    `exchange_number` STRING COMMENT 'Externally-known business identifier for the 1031 exchange transaction, typically assigned by the Qualified Intermediary (QI) or internal deal tracking system. Used for cross-referencing with QI documentation and IRS Form 8824 filings.',
    `exchange_status` STRING COMMENT 'Current lifecycle status of the 1031 exchange transaction. Tracks progression from initiation through identification period, replacement property acquisition, and final IRS compliance determination. [ENUM-REF-CANDIDATE: initiated|identification_period|replacement_pending|completed|failed|cancelled — promote to reference product if additional statuses are needed]. Valid values are `initiated|identification_period|replacement_pending|completed|failed|cancelled`',
    `exchange_type` STRING COMMENT 'Classification of the 1031 exchange structure: simultaneous (same-day swap), delayed (Starker exchange with QI), reverse (replacement acquired before relinquishment), or improvement/construction (build-to-suit exchange). Determines applicable IRS deadlines and QI escrow requirements.. Valid values are `simultaneous|delayed|reverse|improvement`',
    `form_8824_filed` BOOLEAN COMMENT 'Indicates whether IRS Form 8824 (Like-Kind Exchanges) has been filed with the IRS for this exchange transaction. Required for all 1031 exchanges in the tax year of the relinquished property transfer.',
    `form_8824_filed_date` DATE COMMENT 'The date on which IRS Form 8824 was filed with the IRS for this exchange. Used for compliance tracking and audit trail purposes.',
    `identification_deadline` DATE COMMENT 'The IRS-mandated deadline by which the taxpayer must identify potential replacement properties — exactly 45 calendar days from the relinquished property closing date. Failure to meet this deadline disqualifies the exchange.',
    `identification_rule` STRING COMMENT 'The IRS identification rule elected by the taxpayer for designating replacement properties: three_property (up to 3 properties regardless of value), two_hundred_percent (any number of properties with combined FMV ≤ 200% of relinquished FMV), or ninety_five_percent (any number if 95% of total FMV is actually acquired).. Valid values are `three_property|two_hundred_percent|ninety_five_percent`',
    `initiated_date` DATE COMMENT 'The date on which the 1031 exchange was formally initiated, typically the closing date of the relinquished property sale. This date anchors the 45-day identification deadline and 180-day closing deadline under IRS rules.',
    `irs_compliance_status` STRING COMMENT 'Current IRS compliance determination for the 1031 exchange: pending (exchange in progress), compliant (all IRS requirements met), non_compliant (deadline missed or disqualifying event), or under_review (IRS audit or inquiry in progress).. Valid values are `pending|compliant|non_compliant|under_review`',
    `like_kind_confirmed` BOOLEAN COMMENT 'Indicates whether both the relinquished and replacement properties have been confirmed as qualifying like-kind real property under IRS Section 1031. Must be True for the exchange to qualify for tax deferral.',
    `notes` STRING COMMENT 'Free-text field for capturing additional context, special circumstances, legal counsel notes, or operational remarks related to the 1031 exchange. Examples include reverse exchange parking arrangements, improvement exchange construction details, or IRS correspondence notes.',
    `qi_account_number` STRING COMMENT 'Bank account or escrow account number held by the Qualified Intermediary (QI) where exchange proceeds from the relinquished property sale are deposited and held pending acquisition of the replacement property.',
    `qi_fund_balance` DECIMAL(18,2) COMMENT 'Current balance of exchange proceeds held by the Qualified Intermediary (QI) in escrow. Tracks available funds for replacement property acquisition. Decreases as replacement property closings occur.',
    `qi_name` STRING COMMENT 'Legal name of the Qualified Intermediary (QI) — the independent third party that holds exchange proceeds and facilitates the transfer to prevent constructive receipt by the taxpayer. Required for delayed, reverse, and improvement exchanges.',
    `realized_gain` DECIMAL(18,2) COMMENT 'Total economic gain realized on the relinquished property sale, calculated as the amount realized (sale price minus selling expenses) less the adjusted tax basis. Represents the total gain before deferral. Reported on IRS Form 8824 Part III.',
    `recognized_gain` DECIMAL(18,2) COMMENT 'Portion of the realized gain that is taxable in the current tax year — equal to the lesser of the realized gain or the boot received. If no boot is received, recognized gain is zero. Reported on IRS Form 8824 Part III.',
    `relinquished_adjusted_basis` DECIMAL(18,2) COMMENT 'The taxpayers adjusted cost basis in the relinquished property at the time of exchange, accounting for original acquisition cost, capital improvements, and accumulated depreciation. Critical input for deferred gain calculation on IRS Form 8824.',
    `relinquished_closing_date` DATE COMMENT 'The actual closing/settlement date on which the relinquished property was transferred to the buyer. This is the trigger date for the 45-day and 180-day IRS exchange deadlines.',
    `relinquished_mortgage_balance` DECIMAL(18,2) COMMENT 'Outstanding mortgage or debt balance on the relinquished property at the time of closing. Mortgage relief received by the taxpayer is treated as boot received and may trigger taxable gain recognition.',
    `relinquished_property_address` STRING COMMENT 'Full street address of the relinquished (down-leg) property being exchanged. Captured directly on the exchange record for IRS Form 8824 reporting and audit trail purposes, independent of the property master record.',
    `relinquished_sale_price` DECIMAL(18,2) COMMENT 'Gross sale price received for the relinquished property at closing, as reported on the settlement statement. Used as the basis for deferred gain calculation and boot determination on IRS Form 8824.',
    `replacement_basis` DECIMAL(18,2) COMMENT 'The carryover tax basis assigned to the replacement property after the exchange, calculated as the replacement propertys cost minus the deferred gain. This basis is used for future depreciation calculations and gain recognition upon eventual sale.',
    `replacement_closing_date` DATE COMMENT 'The actual closing/settlement date on which the replacement property was acquired. Must occur on or before the 180-day exchange closing deadline to qualify for tax deferral.',
    `replacement_mortgage_balance` DECIMAL(18,2) COMMENT 'New mortgage or debt assumed on the replacement property at acquisition. Mortgage assumed by the taxpayer offsets boot received from mortgage relief on the relinquished property in the net boot calculation.',
    `replacement_property_address` STRING COMMENT 'Full street address of the primary replacement (up-leg) property acquired in the exchange. Captured directly on the exchange record for IRS Form 8824 reporting and audit trail purposes.',
    `replacement_property_count` STRING COMMENT 'Number of replacement properties formally identified within the 45-day identification period. Must comply with the elected identification rule (e.g., maximum 3 under the three-property rule). Used for IRS compliance validation.',
    `replacement_purchase_price` DECIMAL(18,2) COMMENT 'Gross purchase price paid for the replacement property at closing. Must equal or exceed the relinquished property sale price for full gain deferral. Used in boot calculation and IRS Form 8824 Part III reporting.',
    `selling_expenses` DECIMAL(18,2) COMMENT 'Total transaction costs incurred in selling the relinquished property, including brokerage commissions, title fees, legal fees, and transfer taxes. Reduces the amount realized for gain calculation purposes on IRS Form 8824.',
    `tax_year` STRING COMMENT 'The IRS tax year in which the 1031 exchange is reported on Form 8824. Typically the year in which the relinquished property was transferred. Used for tax filing and financial period alignment.',
    `taxpayer_ein` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax Identification Number (TIN) of the entity executing the exchange. Required for IRS Form 8824 filing and tax compliance reporting.. Valid values are `^d{2}-d{7}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this 1031 exchange record was most recently modified. Used for change tracking, audit trail, and data synchronization with source systems (Yardi Voyager, MRI Software).',
    CONSTRAINT pk_exchange_1031 PRIMARY KEY(`exchange_1031_id`)
) COMMENT 'Manages IRS Section 1031 like-kind exchange transactions for tax-deferred property dispositions. Captures relinquished property details, replacement property identification (up to 3-property rule or 200% rule), qualified intermediary (QI) name and account, exchange deadlines (45-day identification period, 180-day closing deadline), boot amount, deferred gain calculation, exchange type (simultaneous, delayed, reverse, Improvement/construction), and IRS compliance status. Tracks exchange fund balances held by QI. Critical for tax-deferred disposition strategies and IRS Form 8824 reporting.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`reo_disposition` (
    `reo_disposition_id` BIGINT COMMENT 'Unique surrogate identifier for each REO disposition transaction record in the lakehouse silver layer.',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: OCC and FDIC regulations require formal appraisals on REO assets above threshold values. reo_disposition tracks as_is_appraised_value, which must be traceable to the appraisal record for regulatory ex',
    `asset_id` BIGINT COMMENT 'Reference to the property asset subject to REO disposition. Links to the property master record.',
    `auction_id` BIGINT COMMENT 'Identifier assigned by the auction platform or trustee when the REO disposition method is auction. Used to link to auction results and bidder records.',
    `bpo_id` BIGINT COMMENT 'Foreign key linking to valuation.bpo. Business justification: REO servicers order BPOs as the primary pricing tool before listing distressed assets. reo_disposition stores bpo_value and bpo_date as denormalized BPO fields. Linking to valuation.bpo normalizes thi',
    `bulk_sale_pool_id` BIGINT COMMENT 'Identifier for the bulk sale pool or package when multiple REO assets are sold together in a single transaction. Null for individual asset dispositions.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to marketing.campaign. Business justification: REO disposition marketing: lenders and servicers run dedicated marketing campaigns for REO properties. reo_disposition must reference the specific campaign driving its disposition to track marketing s',
    `claim_id` BIGINT COMMENT 'Foreign key linking to insurance.claim. Business justification: REO properties frequently involve open or settled insurance claims (casualty, fire, environmental) that affect disposition value and strategy. Linking reo_disposition to the associated insurance claim',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: REO disposition financial metrics (BPO value, sale price, loss severity, carrying costs) require normalized currency reference for lender portfolio reporting, OCC/FDIC regulatory submissions, and loss',
    `debt_facility_id` BIGINT COMMENT 'Foreign key linking to investment.debt_facility. Business justification: REO dispositions arise from defaulted loans under specific debt facilities. Linking reo_disposition to debt_facility enables lenders and investment managers to track recovery rates and loss severity a',
    `dev_project_id` BIGINT COMMENT 'Foreign key linking to development.dev_project. Business justification: REO rehabilitation tracking: REO properties require development/renovation projects before disposition. Asset managers track rehab costs (actual_repair_cost) against the dev_project budget to calculat',
    `employee_id` BIGINT COMMENT 'Reference to the internal asset manager responsible for overseeing the REO disposition strategy and execution.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the lender or loan servicer that holds the REO asset and is managing the disposition process.',
    `listing_id` BIGINT COMMENT 'Foreign key linking to brokerage.listing. Business justification: REO assets are listed through brokerage platforms. Linking reo_disposition to listing enables days-on-market tracking, broker assignment, and price reduction history reporting — core REO asset managem',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to maintenance.capex_project. Business justification: REO disposition involves repair/rehab projects tracked as CAPEX. Lenders and servicers link rehab CAPEX projects to the REO disposition record to measure net recovery after repair spend. `repair_cost_',
    `market_segment_id` BIGINT COMMENT 'Foreign key linking to reference.market_segment. Business justification: REO disposition strategy (bulk sale vs retail vs auction) and pricing methodology are driven by market segment classification. Asset managers and lenders use market segment to determine disposition ch',
    `ops_inspection_id` BIGINT COMMENT 'Foreign key linking to maintenance.ops_inspection. Business justification: REO disposition requires formal property condition inspections (BPO inspections, as-is appraisals, code compliance checks) that support `bpo_value`, `as_is_appraised_value`, and `condition_rating` on ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to insurance.policy. Business justification: REO asset insurance management: lenders/servicers maintain force-placed or existing insurance on REO properties throughout the disposition period. Linking reo_disposition to the active insurance polic',
    `portfolio_asset_id` BIGINT COMMENT 'Foreign key linking to investment.portfolio_asset. Business justification: REO disposition loss severity is calculated against the original investment basis tracked in portfolio_asset. Investment and credit teams need this link to compute loss-on-investment metrics and updat',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to property.inspection. Business justification: REO disposition workflows require formal property condition inspections to support BPO values, as-is appraisals, and repair cost estimates. Linking to property.inspection ties the condition_rating and',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to transaction.property_sale. Business justification: An REO disposition results in a property sale transaction. reo_disposition currently has no FK to property_sale despite representing a specific type of property sale event. Adding property_sale_id lin',
    `property_type_id` BIGINT COMMENT 'FK to reference.property_type',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: REO disposition is subject to OCC/FDIC guidelines, state foreclosure laws, CFPB servicing rules, and HUD requirements. Compliance teams must link each REO disposition to its governing regulatory frame',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: REO property preservation (boarding, securing, cleaning, repairs) is tracked via work orders during the disposition process. Lenders and REO servicers require this link to manage property preservation',
    `actual_repair_cost` DECIMAL(18,2) COMMENT 'Actual capital expenditure incurred for repairs and rehabilitation of the REO property prior to or during the disposition process.',
    `as_is_appraised_value` DECIMAL(18,2) COMMENT 'Formal appraised market value of the REO property in its current as-is condition, as determined by a certified appraiser. May differ from BPO value.',
    `carrying_costs` DECIMAL(18,2) COMMENT 'Cumulative costs incurred by the lender/servicer while holding the REO asset, including property taxes, insurance, HOA fees, utilities, and security costs from acquisition to disposition.',
    `closing_date` DATE COMMENT 'Date on which the REO disposition transaction closed, title transferred to the buyer, and net proceeds were received by the lender/servicer.',
    `condition_rating` STRING COMMENT 'Standardized rating of the REO propertys physical condition at the time of acquisition or most recent inspection, used to inform pricing, repair strategy, and disposition method selection.. Valid values are `excellent|good|fair|poor|uninhabitable`',
    `contract_date` DATE COMMENT 'Date on which a purchase and sale agreement was executed between the lender/servicer and the buyer for the REO property.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the REO disposition record was first created in the system, used for audit trail and data lineage tracking.',
    `days_on_market` STRING COMMENT 'Number of calendar days the REO property was actively marketed from list date to contract execution date. Key loss mitigation performance metric.',
    `disposition_costs` DECIMAL(18,2) COMMENT 'Total transaction costs associated with selling the REO asset, including broker commissions, closing costs, title fees, transfer taxes, and legal fees.',
    `disposition_method` STRING COMMENT 'Channel or mechanism used to market and sell the REO asset. MLS listing uses Multiple Listing Service exposure; auction uses competitive bidding; bulk sale packages multiple REO assets; direct sale is negotiated off-market; short sale involves pre-foreclosure negotiation.. Valid values are `mls_listing|auction|bulk_sale|direct_sale|short_sale`',
    `disposition_number` STRING COMMENT 'Externally-known business identifier for the REO disposition transaction, used in lender reporting, loss mitigation tracking, and regulatory filings. Format: REO-YYYY-NNNNNN.. Valid values are `^REO-[0-9]{4}-[0-9]{6}$`',
    `disposition_status` STRING COMMENT 'Current lifecycle state of the REO disposition transaction, tracking progression from active marketing through contract execution to final sale or withdrawal.. Valid values are `active|under_contract|sold|withdrawn|cancelled`',
    `environmental_issue_flag` BOOLEAN COMMENT 'Indicates whether a known environmental issue (e.g., contamination, hazardous materials, wetlands) has been identified on the REO property that may affect marketability or require remediation.',
    `final_sale_price` DECIMAL(18,2) COMMENT 'Actual contracted sale price agreed upon between the lender/servicer and the buyer at the time of contract execution for the REO property.',
    `foreclosure_date` DATE COMMENT 'Date on which the foreclosure process was completed and the lender took legal title to the property, marking the start of the REO lifecycle.',
    `hoa_flag` BOOLEAN COMMENT 'Indicates whether the REO property is subject to a Homeowners Association, which may impose dues, special assessments, or transfer restrictions affecting disposition.',
    `lender_name` STRING COMMENT 'Legal name of the financial institution or loan servicer that holds the REO asset and is responsible for the disposition. Supports reporting and counterparty identification.',
    `list_date` DATE COMMENT 'Date on which the REO property was first listed for sale via the selected disposition method (MLS, auction platform, or direct marketing).',
    `list_price` DECIMAL(18,2) COMMENT 'Initial asking price at which the REO property was listed for sale, typically derived from the BPO value and lender pricing strategy.',
    `loan_number` STRING COMMENT 'The lenders or servicers original loan identifier for the mortgage that resulted in foreclosure and REO acquisition. Used for loan-level traceability in CMBS/RMBS reporting.',
    `loss_severity_amount` DECIMAL(18,2) COMMENT 'Dollar amount of loss realized on the REO disposition, calculated as the outstanding loan balance minus the net recovery amount. Key metric for CMBS and RMBS reporting.',
    `loss_severity_pct` DECIMAL(18,2) COMMENT 'Loss severity expressed as a percentage of the outstanding loan balance (loss_severity_amount / outstanding_loan_balance). Standard metric for CMBS, RMBS, and regulatory loss reporting.',
    `ltv_ratio_at_origination` DECIMAL(18,2) COMMENT 'Loan-to-Value ratio at the time of original mortgage origination, providing context for underwriting quality and loss exposure analysis.',
    `net_recovery_amount` DECIMAL(18,2) COMMENT 'Net proceeds received by the lender after deducting all carrying costs, repair costs, and disposition costs from the final sale price. Primary loss mitigation performance metric.',
    `outstanding_loan_balance` DECIMAL(18,2) COMMENT 'Unpaid principal balance of the mortgage loan at the time of foreclosure, representing the lenders gross exposure before recovery proceeds.',
    `price_reduction_count` STRING COMMENT 'Number of times the list price was reduced during the active marketing period. Indicates market demand and pricing strategy effectiveness for loss mitigation analysis.',
    `reo_acquisition_date` DATE COMMENT 'Date on which the lender formally recorded the property as Real Estate Owned on its balance sheet following foreclosure or deed-in-lieu transfer.',
    `repair_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost of repairs and rehabilitation required to bring the REO property to marketable condition, as assessed during property inspection. Informs pricing and disposition strategy.',
    `sale_price_psf` DECIMAL(18,2) COMMENT 'Final sale price divided by the propertys gross leasable or livable area in square feet. Used for comparable sales analysis and portfolio benchmarking.',
    `title_cleared` BOOLEAN COMMENT 'Indicates whether a clear and marketable title has been confirmed by the title company or attorney prior to listing, a prerequisite for REO disposition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the REO disposition record, supporting audit trail, change tracking, and incremental data pipeline processing.',
    CONSTRAINT pk_reo_disposition PRIMARY KEY(`reo_disposition_id`)
) COMMENT 'Tracks Real Estate Owned (REO) asset disposition transactions, capturing foreclosure date, REO acquisition date, lender/servicer name, BPO value, list price, days on market, as-is condition rating, repair cost estimate, net recovery amount, and disposition method (MLS listing, auction, bulk sale). Supports lender REO portfolio management and loss mitigation reporting.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` (
    `due_diligence_item_id` BIGINT COMMENT 'Unique system-generated identifier for each due diligence task or finding record associated with a property transaction.',
    `appraisal_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal. Business justification: Due diligence items of category appraisal or valuation must reference the specific appraisal ordered. Investment committee go/no-go decisions and price adjustment recommendations depend on linking',
    `asset_id` BIGINT COMMENT 'Reference to the property subject to due diligence review.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Due diligence items are assigned to specific internal employees (transaction managers, environmental analysts) for accountability and deadline tracking. The existing assigned_to_user string is a den',
    `building_asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.building_asset. Business justification: Property Condition Assessments during acquisition due diligence evaluate specific building assets (HVAC, roof, elevator, boiler). Linking DD items to building_asset records allows acquisition teams to',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.assessment. Business justification: Due diligence items are frequently supported by formal compliance assessments (Phase I/II environmental assessments, property condition assessments, ADA compliance audits). Transaction managers need t',
    `permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Due diligence items routinely verify active permits (building permits, COO, environmental permits). Linking to compliance.permit allows transaction teams to directly reference the permit record being ',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Remediation cost estimates and actual costs on due diligence items require normalized currency reference for investment committee reporting, price adjustment recommendations, and cross-border transact',
    `investment_deal_id` BIGINT COMMENT 'Foreign key linking to investment.investment_deal. Business justification: Due diligence findings feed directly into IC recommendations and go/no-go decisions tracked in the investment deal pipeline. Investment teams need this link to aggregate all DD items for a pipeline de',
    `lease_agreement_id` BIGINT COMMENT 'Foreign key linking to lease.agreement. Business justification: Lease review is a mandatory due diligence category in every commercial property acquisition. DD teams must link each lease review item to the specific lease agreement being examined to track findings,',
    `clause_id` BIGINT COMMENT 'Foreign key linking to lease.clause. Business justification: Specific lease clauses (co-tenancy, exclusivity, termination options, ROFO/ROFR) are individually flagged as due diligence items with distinct risk ratings and price adjustment recommendations. Linkin',
    `loss_run_id` BIGINT COMMENT 'Foreign key linking to insurance.loss_run. Business justification: Loss run review is a named, mandatory due diligence step in commercial real estate acquisitions. Buyers request 5-year loss runs to assess claim history and insurability. Linking due_diligence_item to',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to maintenance.capex_project. Business justification: Property acquisition due diligence identifies remediation items (deferred maintenance, code violations) that are handed off to asset management teams as CAPEX projects post-closing. Acquisition teams ',
    `ops_inspection_id` BIGINT COMMENT 'Foreign key linking to maintenance.ops_inspection. Business justification: Due diligence items of category inspection (building, fire, elevator, environmental) reference formal ops_inspection records as supporting evidence. Acquisition teams link DD findings to the actual ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to insurance.policy. Business justification: Acquisition due diligence: insurance review is a standard DD checklist category — reviewing existing policies, coverage adequacy, and required endorsements. Linking due_diligence_item to the policy be',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to property.inspection. Business justification: Due diligence items are frequently triggered by or reference formal property inspections (physical condition, environmental Phase I/II). This link enables the workflow where inspection findings genera',
    `property_sale_id` BIGINT COMMENT 'Reference to the parent property transaction (acquisition, disposition, or sale) to which this due diligence item belongs.',
    `purchase_agreement_id` BIGINT COMMENT 'Foreign key linking to transaction.purchase_agreement. Business justification: Due diligence items are conducted within the contingency period defined by the purchase agreement (due_diligence_start_date, due_diligence_end_date, inspection_contingency_date, environmental_continge',
    `regulatory_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_obligation. Business justification: Due diligence items in property transactions are directly triggered by regulatory obligations (environmental review, ADA, zoning, FIRPTA). Transaction managers and attorneys need to trace which regula',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to insurance.risk_assessment. Business justification: Property risk assessments (PML studies, property condition reports with insurance implications) are standard due diligence deliverables in acquisitions. Linking due_diligence_item to risk_assessment f',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual invoiced and paid cost to complete this due diligence task. Compared against estimated cost for budget variance analysis and CAPEX tracking.',
    `completion_date` DATE COMMENT 'Actual date on which the due diligence task was completed and findings were documented. Null if the item has not yet been completed.',
    `contingency_removal_date` DATE COMMENT 'Date on which the PSA contingency tied to this due diligence item was formally removed or waived by the buyer.',
    `contingency_removed` BOOLEAN COMMENT 'Indicates whether the PSA contingency associated with this due diligence item has been formally removed or waived, allowing the transaction to proceed to closing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this due diligence item record was first created in the system, used for audit trail and compliance reporting.',
    `due_date` DATE COMMENT 'Contractual or internally-set deadline by which this due diligence task must be completed, typically tied to the PSA due diligence period end date or a specific contingency removal date.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated cost to engage the vendor or consultant and complete this due diligence task (e.g., Phase I ESA fee, ALTA survey fee, structural inspection fee). Distinct from remediation cost.',
    `estimated_remediation_cost` DECIMAL(18,2) COMMENT 'Estimated cost in the transaction currency to complete required remediation actions. Used in deal economics modeling, price renegotiation, and Capital Expenditure (CAPEX) planning.',
    `finding_summary` STRING COMMENT 'Concise narrative summary of the key findings, observations, or conclusions from the due diligence task. Used in investment committee reports and PSA contingency resolution documentation.',
    `go_no_go_recommendation` STRING COMMENT 'Investment committee recommendation derived from this due diligence item: go (proceed to closing), no-go (abort transaction), conditional go (proceed subject to remediation or price adjustment), or pending (awaiting further findings).. Valid values are `go|no_go|conditional_go|pending`',
    `investment_committee_flag` BOOLEAN COMMENT 'Indicates whether this due diligence item has been escalated to the investment committee for review and decision, typically triggered by a red risk rating or a no-go or conditional-go recommendation.',
    `item_category` STRING COMMENT 'High-level classification of the due diligence workstream. Covers environmental (Phase I/II), structural/MEP inspection, zoning and entitlement review, ALTA survey, title search, financial audit, rent roll verification, estoppel review, tenant interview, legal/regulatory, and insurance. [ENUM-REF-CANDIDATE: environmental|structural_mep|zoning_entitlement|title_survey|financial_audit|rent_roll|estoppel|tenant_interview|legal_regulatory|insurance — promote to reference product]',
    `item_description` STRING COMMENT 'Detailed narrative describing the scope, objective, and methodology of the due diligence task, including any specific areas of focus or contractual requirements from the Purchase and Sale Agreement (PSA).',
    `item_name` STRING COMMENT 'Short descriptive title of the due diligence task (e.g., Phase I Environmental Site Assessment, ALTA Survey, Rent Roll Verification, Structural and MEP Inspection).',
    `item_number` STRING COMMENT 'Externally-visible alphanumeric identifier for the due diligence item, used in investment committee reports, PSA contingency schedules, and vendor communications (e.g., DD-2024-00123).. Valid values are `^DD-[0-9]{4}-[0-9]{5}$`',
    `item_status` STRING COMMENT 'Current workflow state of the due diligence task within the pre-closing process. Drives investment committee reporting and PSA contingency tracking.. Valid values are `not_started|in_progress|pending_review|completed|waived|escalated`',
    `item_type` STRING COMMENT 'Operational type of the due diligence task — whether it is a physical inspection, document review, financial audit, land survey, stakeholder interview, title/lien search, or risk assessment. [ENUM-REF-CANDIDATE: inspection|review|audit|survey|interview|search|assessment — 7 candidates stripped; promote to reference product]',
    `leed_breeam_status` STRING COMMENT 'Current green building certification status relevant to the due diligence review, including LEED and BREEAM ratings. Supports ESG compliance reporting and investment committee assessment. [ENUM-REF-CANDIDATE: not_applicable|pending|certified|silver|gold|platinum|breeam_pass|breeam_good|breeam_very_good — promote to reference product]',
    `phase_ii_required` BOOLEAN COMMENT 'Indicates whether a Phase II Environmental Site Assessment is required based on findings from the Phase I ESA. Applicable only to environmental due diligence items.',
    `price_adjustment_recommended` BOOLEAN COMMENT 'Indicates whether the findings from this due diligence item support a recommendation to renegotiate the purchase price (e.g., due to environmental remediation costs, deferred maintenance, or title defects).',
    `psa_contingency_type` STRING COMMENT 'Type of PSA contingency that this due diligence item is associated with. Tracks which contractual contingencies must be resolved or waived prior to closing. [ENUM-REF-CANDIDATE: financing|inspection|environmental|title|zoning|appraisal|other — 7 candidates stripped; promote to reference product]',
    `recognized_environmental_condition` STRING COMMENT 'ASTM-standard classification of environmental conditions identified during Phase I ESA: none (no REC), REC (Recognized Environmental Condition), CREC (Controlled REC), or HREC (Historical REC). Drives Phase II ESA decision.. Valid values are `none|rec|crec|hrec`',
    `recommended_price_adjustment` DECIMAL(18,2) COMMENT 'Dollar amount of the recommended purchase price reduction or credit based on findings from this due diligence item. Used in deal economics renegotiation and investment committee reporting.',
    `remediation_description` STRING COMMENT 'Detailed description of the required remediation actions, including scope of work, responsible party, and any regulatory requirements (e.g., EPA cleanup plan, structural repair specification, title defect cure).',
    `remediation_required` BOOLEAN COMMENT 'Indicates whether the findings from this due diligence item require remediation action (environmental cleanup, structural repair, title cure, zoning variance, etc.) prior to or as a condition of closing.',
    `report_date` DATE COMMENT 'Date on which the vendor or consultant issued the formal due diligence report or deliverable. Used to assess report currency and compliance with PSA requirements.',
    `responsible_party_name` STRING COMMENT 'Name of the individual, firm, or vendor responsible for completing this due diligence task (e.g., environmental consultant, structural engineer, title company, legal counsel, internal asset manager).',
    `responsible_party_type` STRING COMMENT 'Classification of the party responsible for the due diligence task — internal team member, external third-party vendor, legal counsel, title company, lender representative, or broker.. Valid values are `internal|external_vendor|legal_counsel|title_company|lender|broker`',
    `risk_rating` STRING COMMENT 'Traffic-light risk classification assigned to the due diligence finding: green (no material issue), yellow (moderate concern requiring monitoring or negotiation), red (material issue that may affect go/no-go decision or require remediation prior to closing).. Valid values are `green|yellow|red|unrated`',
    `source_system_ref` STRING COMMENT 'Reference identifier from the originating system of record (e.g., Salesforce CRM deal ID, Yardi transaction reference, Procore project ID, DocuSign CLM contract ID) that sourced this due diligence item.',
    `title_exception_count` STRING COMMENT 'Number of title exceptions, encumbrances, or defects identified during the title search or ALTA survey. A non-zero count triggers further legal review and potential price adjustment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this due diligence item record, supporting audit trail, change tracking, and incremental data pipeline processing.',
    `vendor_name` STRING COMMENT 'Name of the third-party firm or consultant engaged to perform this due diligence task (e.g., environmental consulting firm, structural engineering firm, title company, law firm).',
    `vendor_report_reference` STRING COMMENT 'External report or document reference number assigned by the vendor (e.g., Phase I ESA report number, ALTA survey job number, structural inspection report ID). Enables cross-referencing with vendor deliverables.',
    `zoning_compliance_confirmed` BOOLEAN COMMENT 'Indicates whether the propertys current use and intended use have been confirmed as compliant with applicable zoning regulations and entitlement approvals.',
    CONSTRAINT pk_due_diligence_item PRIMARY KEY(`due_diligence_item_id`)
) COMMENT 'Tracks individual due diligence tasks, inspections, and findings for a property transaction — environmental Phase I/II, structural/MEP inspection, zoning and entitlement review, ALTA survey, title search, financial audit, rent roll verification, estoppel review, and tenant interview. Captures responsible party, due date, completion date, finding summary, risk rating (red/yellow/green), remediation requirement, cost estimate, and go/no-go recommendation. Enables systematic tracking of all pre-closing diligence obligations and supports investment committee reporting and PSA contingency resolution.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`deal_party` (
    `deal_party_id` BIGINT COMMENT 'Primary key for deal_party',
    `brokerage_broker_id` BIGINT COMMENT 'Foreign key linking to brokerage.broker. Business justification: Deal parties include brokers/agents whose license validity and E&O insurance must be verified before closing. Linking deal_party to broker enables license verification, commission eligibility checks, ',
    `brokerage_deal_id` BIGINT COMMENT 'Reference to the parent property transaction or deal record to which this party is associated. Links the party to the specific acquisition, disposition, or sale event.',
    `closing_statement_id` BIGINT COMMENT 'Foreign key linking to transaction.closing_statement. Business justification: deal_party tracks parties involved in the transaction, and the closing statement records disbursements to these parties (seller proceeds, buyer cash to close, broker commissions, title company fees, e',
    `corporate_entity_id` BIGINT COMMENT 'Reference to the internal owner, tenant, broker, or external contact record that identifies the party. Resolves to the appropriate master party entity (owner, tenant, broker, or external contact) depending on party_entity_type.',
    `country_id` BIGINT COMMENT 'Foreign key linking to reference.country. Business justification: FIRPTA withholding determination, foreign person classification, AML compliance, and OFAC sanctions screening for deal parties require normalized country reference. Tax attorneys and compliance office',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Commission amounts, FIRPTA withholding amounts, and proceeds amounts for deal parties require normalized currency reference for 1099-S reporting, international wire transfers, and multi-currency commi',
    `investor_id` BIGINT COMMENT 'Foreign key linking to investment.investor. Business justification: In JV and co-investment transactions, deal parties include LP investors. Linking deal_party to investor enables capital account updates, FIRPTA withholding calculations, and 1099-S/K-1 reporting for i',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Deal parties (buyers, sellers, borrowers) are legal entities tracked in the finance system for consolidation, tax reporting, and FIRPTA compliance. Real estate accountants require this link for entity',
    `offer_id` BIGINT COMMENT 'Foreign key linking to transaction.offer. Business justification: Offers are submitted by parties (buyer, buyer agent) and received by parties (seller, listing agent). While deal_party links to property_sale, adding offer_id provides direct linkage to the specific o',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Deal parties who are tracked owner entities (buyers, sellers, investors, JV partners) must be linked to owner records for KYC compliance, FIRPTA withholding determination, and owner deal participation',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to transaction.property_sale. Business justification: deal_party is the association entity capturing all parties (buyer, seller, broker, lender, title officer) in a property transaction. It currently only links to brokerage.deal (cross-domain). Adding pr',
    `purchase_agreement_id` BIGINT COMMENT 'Foreign key linking to transaction.purchase_agreement. Business justification: deal_party captures all parties and their roles in a property transaction. While it already links to property_sale, adding purchase_agreement_id provides direct linkage to the PSA where parties are fo',
    `commission_amount` DECIMAL(18,2) COMMENT 'Absolute dollar amount of commission allocated to this party for the transaction. Derived from the commission split percentage applied to the gross commission, stored for audit and 1099 reporting purposes.',
    `commission_split_pct` DECIMAL(18,2) COMMENT 'The percentage of the total transaction commission allocated to this party, expressed as a decimal (e.g., 0.0250 = 2.50%). Applicable for broker and agent roles. Drives commission disbursement and 1099-MISC reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this deal party association record was first created in the system. Supports audit trail, data lineage, and SOX financial controls compliance.',
    `docusign_envelope_code` STRING COMMENT 'Unique envelope identifier from DocuSign CLM for the transaction documents executed by this party. Enables audit trail of digital signature events and document execution status per party.',
    `effective_date` DATE COMMENT 'Date on which this partys role and obligations in the transaction became legally effective. May differ from signature_date for parties added via amendment or assignment.',
    `entity_type` STRING COMMENT 'Legal entity classification of the party. Determines applicable tax treatment, reporting requirements (e.g., FIRPTA, 1099-S), and deal structuring considerations. Values: individual, corporation, REIT (Real Estate Investment Trust), trust, partnership, LLC.. Valid values are `individual|corporation|REIT|trust|partnership|LLC`',
    `escrow_account_number` STRING COMMENT 'Account number assigned by the escrow agent or title company for holding earnest money and closing funds. Applicable when party_role is escrow_agent or title_company. Required for settlement reconciliation.',
    `firpta_withholding_amount` DECIMAL(18,2) COMMENT 'Dollar amount withheld from disposition proceeds under FIRPTA for foreign sellers. Applicable only when is_foreign_person is true. Reported on IRS Form 8288.',
    `is_1099s_reportable` BOOLEAN COMMENT 'Indicates whether this partys proceeds from the real estate transaction must be reported to the IRS on Form 1099-S. Typically true for sellers receiving proceeds above the IRS threshold.',
    `is_foreign_person` BOOLEAN COMMENT 'Indicates whether the party is a foreign person or entity subject to FIRPTA (Foreign Investment in Real Property Tax Act) withholding requirements. When true, triggers mandatory IRS withholding on disposition proceeds.',
    `is_primary_party` BOOLEAN COMMENT 'Indicates whether this party is the primary representative for their role in the transaction (e.g., lead buyer among multiple buyers, primary lender). Used to resolve reporting and notification routing when multiple parties share the same role.',
    `lender_loan_number` STRING COMMENT 'Loan reference number assigned by the lender party for the financing associated with this transaction. Applicable when party_role is lender. Used for CMBS/RMBS tracking and debt instrument reconciliation.',
    `loan_type` STRING COMMENT 'Classification of the financing instrument provided by the lender party. Applicable when party_role is lender. Drives LTV (Loan-to-Value) ratio analysis, DSCR (Debt Service Coverage Ratio) modeling, and regulatory capital treatment. [ENUM-REF-CANDIDATE: conventional|FHA|VA|CMBS|bridge|mezzanine|construction — promote to reference product]',
    `mailing_address` STRING COMMENT 'Full mailing address for the party used for closing document delivery, 1099 tax form mailing, and legal notice service. Includes street, city, state, and ZIP.',
    `notes` STRING COMMENT 'Free-text field for transaction coordinators and asset managers to capture deal-specific context about this partys role, special conditions, or instructions not captured in structured fields (e.g., POA restrictions, trust certification requirements).',
    `participation_status` STRING COMMENT 'Current lifecycle status of this partys involvement in the transaction. Tracks whether the party is actively engaged, has withdrawn, is pending confirmation, has confirmed participation, or has declined.. Valid values are `active|withdrawn|pending|confirmed|declined`',
    `party_email` STRING COMMENT 'Primary email address for the party used for transaction correspondence, DocuSign CLM execution, and closing coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `party_name` STRING COMMENT 'Full legal name of the party as it appears on the purchase agreement, closing statement, or title instrument. Used for 1099-S reporting, ALTA title commitments, and deed preparation.',
    `party_phone` STRING COMMENT 'Primary contact phone number for the party for transaction coordination and closing communications.',
    `party_role` STRING COMMENT 'The functional role this party plays in the transaction. Drives commission allocation, 1099-S reporting obligations, and deal workflow routing. [ENUM-REF-CANDIDATE: buyer|seller|buyers_broker|sellers_broker|lender|title_company|escrow_agent|qualified_intermediary|attorney|appraiser|guarantor — promote to reference product]',
    `proceeds_amount` DECIMAL(18,2) COMMENT 'Gross proceeds allocated to this party from the transaction closing, as reported on IRS Form 1099-S. Applicable to seller parties. Used for tax reporting and settlement reconciliation.',
    `qi_exchange_ref` STRING COMMENT 'Reference number assigned by the Qualified Intermediary (QI) for a 1031 like-kind exchange transaction. Applicable when party_role is qualified_intermediary. Required for IRS Section 1031 compliance tracking and exchange deadline monitoring.',
    `representation_type` STRING COMMENT 'Nature of the agency relationship for broker parties: exclusive buyer/seller representation, non-exclusive, dual agency (representing both sides), or transaction broker (facilitating without fiduciary duty). Governs disclosure obligations under NAR Code of Ethics.. Valid values are `exclusive|non-exclusive|dual_agency|transaction_broker`',
    `salesforce_contact_code` STRING COMMENT 'External reference identifier for this party in Salesforce CRM (Tenant and Prospect Management; Deal Pipeline). Enables cross-system reconciliation between the lakehouse deal_party record and the CRM contact or account record.',
    `signature_date` DATE COMMENT 'Date on which this party executed (signed) the primary transaction document (purchase agreement, closing statement, or deed). Used for contract formation analysis and closing timeline tracking.',
    `signing_authority` STRING COMMENT 'The capacity in which the party is authorized to execute transaction documents. Determines document execution requirements and legal validity of signatures on purchase agreements, deeds, and closing statements.. Valid values are `authorized_signatory|power_of_attorney|trustee|managing_member|officer`',
    `tax_id_type` STRING COMMENT 'Classification of the tax identification number provided: SSN (Social Security Number), EIN (Employer Identification Number), ITIN (Individual Taxpayer Identification Number), or foreign_tin for non-US entities. Determines IRS withholding and reporting rules.. Valid values are `SSN|EIN|ITIN|foreign_tin`',
    `tax_identification_number` STRING COMMENT 'Federal Tax Identification Number (TIN), Employer Identification Number (EIN), or Social Security Number (SSN) for the party. Required for IRS 1099-S and 1099-MISC reporting at closing. Stored in encrypted form.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this deal party association record. Used for incremental data pipeline processing, change data capture, and audit trail maintenance.',
    `withdrawal_date` DATE COMMENT 'Date on which this party formally withdrew from or was removed from the transaction. Populated when participation_status is withdrawn or declined. Used for deal timeline and contingency analysis.',
    CONSTRAINT pk_deal_party PRIMARY KEY(`deal_party_id`)
) COMMENT 'Association entity capturing all parties and their roles in a property transaction — buyer, seller, buyers broker, sellers broker, lender, title company, escrow agent, qualified intermediary (QI), attorney, appraiser, and guarantor. Records role type, entity classification (individual, corporation, REIT, trust, partnership, LLC), contact reference (FK to owner or external party), participation status, and commission split percentage where applicable. Enables multi-party deal tracking, commission allocation, and 1099-S reporting.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`offer` (
    `offer_id` BIGINT COMMENT 'Primary key for offer',
    `asset_id` BIGINT COMMENT 'Reference to the property against which this offer is submitted.',
    `brokerage_deal_id` BIGINT COMMENT 'Reference to the brokerage deal or transaction pipeline record in Salesforce CRM that this offer is associated with.',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Owner acquisition pipeline reporting, proof-of-funds verification against owner accreditation records, and offer-to-close conversion tracking by owner entity require linking offers to the submitting o',
    `buyer_representation_id` BIGINT COMMENT 'Foreign key linking to brokerage.buyer_representation. Business justification: NAR rules (effective Aug 2024) require a signed buyer representation agreement before submitting offers. Linking offer to buyer_representation enables compliance verification, commission structure val',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Multi-currency offer comparison for cross-border property transactions requires normalized currency reference. Listing brokers and sellers need to compare competing offers in a consistent currency for',
    `lead_id` BIGINT COMMENT 'Foreign key linking to marketing.lead. Business justification: Buyer offer-to-lead traceability: real estate CRM processes require linking a submitted offer back to the originating marketing lead to measure lead quality, channel effectiveness, and offer conversio',
    `listing_id` BIGINT COMMENT 'Reference to the active property listing (MLS or internal) against which this offer was submitted.',
    `parent_offer_id` BIGINT COMMENT 'Self-referencing identifier linking a counter-offer or revised offer back to the original offer record. Enables reconstruction of the full negotiation chain for a given property transaction.',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to transaction.property_sale. Business justification: An accepted offer leads to the creation of a property_sale record. offer currently has no FK to property_sale. Adding property_sale_id (nullable) links the accepted offer to the resulting sale transac',
    `unit_id` BIGINT COMMENT 'Foreign key linking to property.unit. Business justification: In condo, multifamily, and mixed-use transactions, offers are made on specific units. Linking offer.unit_id → property.unit enables unit-level offer tracking, absorption analysis, and MLS unit-level r',
    `acceptance_date` DATE COMMENT 'The date on which the seller formally accepted this offer, creating a binding purchase agreement. Triggers the due diligence and inspection contingency period clocks.',
    `appraisal_contingency_flag` BOOLEAN COMMENT 'Indicates whether the offer includes an appraisal contingency, allowing the buyer to renegotiate or withdraw if the property appraises below the offer price. Relevant to Appraisal Institute and IVSC valuation standards.',
    `buyer_agent_license_number` STRING COMMENT 'The state-issued real estate license number of the buyers agent. Required for regulatory compliance and commission disbursement verification.',
    `buyer_agent_name` STRING COMMENT 'The name of the licensed real estate agent or broker representing the buyer in this transaction. Used for commission split calculations and co-broker agreement tracking.',
    `competing_offer_count` STRING COMMENT 'The number of competing offers disclosed by the seller or known to the listing agent at the time this offer was submitted. Used in multi-offer analytics and negotiation strategy reporting.',
    `competing_offer_flag` BOOLEAN COMMENT 'Indicates whether the seller has disclosed the existence of one or more competing offers on the same property at the time this offer was submitted. Supports multi-offer scenario management and deal pipeline analytics.',
    `counter_offer_number` STRING COMMENT 'Sequential counter indicating which round of negotiation this offer record represents (1 = original offer, 2 = first counter, 3 = second counter, etc.). Supports negotiation history tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this offer record was first created in the system. Audit trail field for data lineage and SOX compliance.',
    `docusign_envelope_code` STRING COMMENT 'The unique envelope identifier from DocuSign CLM for the digitally executed offer document. Enables traceability between the offer record and the executed contract lifecycle management system.',
    `due_diligence_period_days` STRING COMMENT 'The number of calendar days requested by the buyer for due diligence activities including title review, environmental assessment, financial analysis, and physical inspection. Particularly relevant for commercial real estate (CRE) transactions.',
    `earnest_money_amount` DECIMAL(18,2) COMMENT 'The good-faith deposit amount offered by the buyer to demonstrate commitment to the transaction. Held in escrow pending closing or offer disposition.',
    `earnest_money_due_date` DATE COMMENT 'The date by which the buyer must deliver the earnest money deposit to the escrow or title company.',
    `escalation_ceiling_price` DECIMAL(18,2) COMMENT 'The maximum purchase price the buyer is willing to pay under the escalation clause. The offer will not escalate beyond this ceiling regardless of competing offers.',
    `escalation_clause_flag` BOOLEAN COMMENT 'Indicates whether the offer contains an escalation clause that automatically increases the offer price above competing offers up to a defined ceiling. Critical for multi-offer scenario management.',
    `escalation_increment_amount` DECIMAL(18,2) COMMENT 'The dollar amount by which the offer price will automatically escalate above a competing offer when an escalation clause is active. Null when escalation_clause_flag is false.',
    `expiry_date` DATE COMMENT 'The date and time by which the seller must respond to the offer before it automatically expires. Critical for multi-offer scenario management.',
    `financing_contingency_amount` DECIMAL(18,2) COMMENT 'The maximum loan amount the buyer is seeking to finance. If the buyer cannot secure financing up to this amount, the contingency allows withdrawal without forfeiting earnest money. Supports LTV (Loan-to-Value) ratio analysis.',
    `financing_type` STRING COMMENT 'The type of financing the buyer intends to use to fund the purchase. Distinguishes all-cash offers from financed offers and identifies loan program type (e.g., FHA, VA, ARM — Adjustable Rate Mortgage, Conventional).. Valid values are `cash|conventional|fha|va|arm|other`',
    `inspection_contingency_days` STRING COMMENT 'The number of calendar days from offer acceptance during which the buyer has the right to conduct property inspections and withdraw without penalty if findings are unsatisfactory.',
    `inspection_contingency_end_date` DATE COMMENT 'The absolute calendar date on which the inspection contingency period expires. Derived from offer acceptance date plus inspection_contingency_days; stored explicitly for operational tracking.',
    `is_1031_exchange` BOOLEAN COMMENT 'Indicates whether the buyer intends to use this acquisition as part of a 1031 like-kind exchange to defer capital gains taxes. Affects transaction timeline and documentation requirements.',
    `ltv_ratio` DECIMAL(18,2) COMMENT 'The Loan-to-Value (LTV) ratio expressed as a percentage, derived from the financing contingency amount relative to the offer price. Key underwriting metric used in investment analysis and lender qualification.',
    `notes` STRING COMMENT 'Free-text field capturing additional terms, special conditions, personal property inclusions/exclusions, or negotiation notes associated with this offer that are not captured in structured fields.',
    `offer_date` DATE COMMENT 'The calendar date on which the buyer formally submitted the purchase offer. Principal business event date for the offer lifecycle.',
    `offer_number` STRING COMMENT 'Externally-visible business identifier for the offer, used in correspondence, Salesforce CRM deal tracking, and closing documentation. Format: OFF-YYYYMMDD-NNNN.. Valid values are `^OFF-[0-9]{8}-[0-9]{4}$`',
    `offer_status` STRING COMMENT 'Current lifecycle state of the purchase offer. Tracks progression from initial submission through counter, acceptance, rejection, or buyer withdrawal. Drives deal pipeline reporting in Salesforce CRM.. Valid values are `submitted|countered|accepted|rejected|withdrawn`',
    `pre_approval_amount` DECIMAL(18,2) COMMENT 'The maximum loan amount for which the buyer has received a lender pre-approval letter. Validates the buyers financial capacity relative to the offer price.',
    `price` DECIMAL(18,2) COMMENT 'The gross purchase price proposed by the buyer in the offer. Base monetary amount before any concessions or adjustments. Used in PSF (Per Square Foot) pricing analytics and comparable sales benchmarking via CoStar.',
    `price_psf` DECIMAL(18,2) COMMENT 'The offered purchase price expressed on a Per Square Foot (PSF) basis, calculated from offer_price divided by the propertys GLA or NLA. Enables direct comparison against CoStar comparable sales benchmarks and market PSF rates.',
    `proof_of_funds_verified` BOOLEAN COMMENT 'Indicates whether the buyer has provided and the listing agent has verified proof of funds or mortgage pre-approval sufficient to support the offer price. Critical qualifier for offer strength assessment.',
    `proposed_closing_date` DATE COMMENT 'The target closing date proposed by the buyer in the offer. Used for deal timeline planning and pipeline forecasting in Salesforce CRM.',
    `rejection_reason` STRING COMMENT 'Categorized reason for offer rejection or withdrawal. Used in deal pipeline analytics and negotiation strategy reporting. [ENUM-REF-CANDIDATE: price_too_low|competing_offer_accepted|contingencies|financing_concerns|buyer_withdrew|other — promote to reference product if additional values are needed]. Valid values are `price_too_low|competing_offer_accepted|contingencies|financing_concerns|buyer_withdrew|other`',
    `sale_contingency_flag` BOOLEAN COMMENT 'Indicates whether the offer is contingent on the buyer successfully selling their existing property before closing. A key risk factor in multi-offer scenario evaluation.',
    `salesforce_opportunity_code` STRING COMMENT 'The Salesforce CRM Opportunity record ID linked to this offer, enabling bidirectional traceability between the lakehouse silver layer and the CRM deal pipeline.',
    `seller_concessions_amount` DECIMAL(18,2) COMMENT 'The dollar value of concessions requested from the seller in this offer, such as closing cost credits, repair allowances, or Tenant Improvement (TI) contributions. Reduces the net effective purchase price.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this offer record was last modified. Supports change data capture (CDC) in the Databricks Lakehouse Silver Layer pipeline and audit trail requirements.',
    CONSTRAINT pk_offer PRIMARY KEY(`offer_id`)
) COMMENT 'Records individual purchase offers submitted on a property, capturing offer price, offer date, financing contingency amount, inspection contingency period, closing date proposed, earnest money offered, escalation clause details, offer status (submitted, countered, accepted, rejected, withdrawn), and competing offer indicator. Supports multi-offer scenario management and deal pipeline tracking in Salesforce CRM.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`escrow_account` (
    `escrow_account_id` BIGINT COMMENT 'Unique surrogate identifier for the escrow account record in the lakehouse Silver layer. Primary key for this entity.',
    `asset_id` BIGINT COMMENT 'Reference to the property asset associated with this escrow account, enabling property-level reconciliation and reporting.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Escrow accounts are held at specific bank accounts tracked in the finance system. This link normalizes the denormalized bank fields on escrow_account and enables escrow bank reconciliation, a required',
    `capital_call_id` BIGINT COMMENT 'Foreign key linking to investment.capital_call. Business justification: Capital call wire proceeds are deposited into the acquisition escrow account. Investment operations teams reconcile capital call funded amounts against escrow deposits to confirm equity is in place be',
    `closing_statement_id` BIGINT COMMENT 'Foreign key linking to transaction.closing_statement. Business justification: An escrow account is reconciled and closed at the same closing event documented by the closing statement. escrow_account already has property_sale_id → property_sale, but adding closing_statement_id c',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Trust account reconciliation, state escrow law compliance, and RESPA reporting require normalized currency reference for escrow accounts. Multi-currency escrow balances require validated currency for ',
    `policy_id` BIGINT COMMENT 'Foreign key linking to insurance.policy. Business justification: Escrow impound management: mortgage escrow accounts collect monthly insurance premium impounds and disburse annual premiums. escrow_account.impound_insurance_amount must reconcile against the actual p',
    `property_sale_id` BIGINT COMMENT 'Reference to the parent property transaction (acquisition, disposition, or sale event) that this escrow account supports.',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Escrow accounts are governed by state-specific escrow laws, RESPA, and DRE regulations that mandate trust account handling, reconciliation frequency, and audit requirements. Compliance officers must l',
    `account_number` STRING COMMENT 'The externally-known escrow account number assigned by the escrow holder or title company (e.g., Yardi Voyager trust account reference). Used for reconciliation with AP/AR trust accounts.',
    `account_status` STRING COMMENT 'Current lifecycle state of the escrow account: open (active and accepting funds), pending_close (disbursements in progress), closed (fully disbursed and reconciled), suspended (temporarily frozen pending resolution), or cancelled (terminated without completion).. Valid values are `open|pending_close|closed|suspended|cancelled`',
    `account_type` STRING COMMENT 'Classification of the escrow account by its business purpose: purchase (earnest money and closing funds), impound (tax and insurance reserves), reserve (capital reserve), 1031_exchange (tax-deferred exchange proceeds), construction (draw-based development funding), or other. [ENUM-REF-CANDIDATE: purchase|impound|reserve|1031_exchange|construction|other — promote to reference product]. Valid values are `purchase|impound|reserve|1031_exchange|construction|other`',
    `actual_closing_date` DATE COMMENT 'The actual date on which the escrow account was closed and all funds were fully disbursed. Null until closure is complete.',
    `commission_amount` DECIMAL(18,2) COMMENT 'Total brokerage commission amount to be disbursed from escrow at closing, covering both listing and buyers agent sides as specified in the commission instructions.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this escrow account record was first created in the system, providing the audit trail start point for SOX compliance and data lineage.',
    `current_balance` DECIMAL(18,2) COMMENT 'The current fund balance in the escrow account reflecting all deposits received and disbursements made to date. Reconciled against Yardi Voyager trust account ledger.',
    `earnest_money_amount` DECIMAL(18,2) COMMENT 'The amount of earnest money deposited by the buyer into escrow as a good-faith deposit per the purchase agreement. Tracked separately for contingency release and forfeiture analysis.',
    `earnest_money_received_date` DATE COMMENT 'The date on which the earnest money deposit was received and confirmed in the escrow account.',
    `earnest_money_status` STRING COMMENT 'Current disposition status of the earnest money deposit: pending (not yet received), received (in escrow), applied (credited toward purchase price at closing), refunded (returned to buyer), or forfeited (retained by seller upon buyer default).. Valid values are `pending|received|applied|refunded|forfeited`',
    `escrow_holder_name` STRING COMMENT 'Legal name of the escrow holder entity (title company, escrow company, or attorney) responsible for managing and disbursing funds. Corresponds to the escrow_company field in property_sale.',
    `escrow_officer_email` STRING COMMENT 'Email address of the escrow officer for communication and document delivery purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escrow_officer_name` STRING COMMENT 'Full name of the individual escrow officer or closing agent at the escrow holder entity who is responsible for managing this account.',
    `escrow_officer_phone` STRING COMMENT 'Direct phone number of the escrow officer for transaction coordination.',
    `exchange_deadline_date` DATE COMMENT 'The IRS-mandated deadline by which replacement property must be identified (45-day rule) or acquired (180-day rule) for a 1031 exchange. Null for non-exchange accounts.',
    `expected_closing_date` DATE COMMENT 'The anticipated date on which all escrow conditions will be satisfied and final disbursements will be made. Used for pipeline tracking and settlement scheduling.',
    `impound_insurance_amount` DECIMAL(18,2) COMMENT 'Amount held in impound/reserve within the escrow account for property insurance premium obligations. Applicable for impound-type escrow accounts.',
    `impound_tax_amount` DECIMAL(18,2) COMMENT 'Amount held in impound/reserve within the escrow account for property tax obligations. Applicable for impound-type escrow accounts associated with mortgage servicing.',
    `is_1031_exchange` BOOLEAN COMMENT 'Indicates whether this escrow account is associated with an IRS Section 1031 tax-deferred exchange transaction, requiring a qualified intermediary and strict timeline compliance.',
    `last_reconciliation_date` DATE COMMENT 'The most recent date on which the escrow account balance was reconciled against the Yardi Voyager trust account ledger and bank statement. Critical for SOX compliance and audit trail.',
    `loan_payoff_amount` DECIMAL(18,2) COMMENT 'The total amount required to satisfy and discharge the sellers existing mortgage or deed of trust from escrow proceeds at closing.',
    `net_proceeds_amount` DECIMAL(18,2) COMMENT 'The net amount to be disbursed to the seller after deducting loan payoffs, commissions, title fees, transfer taxes, and other closing costs from the purchase price.',
    `notes` STRING COMMENT 'Free-text field for escrow officer or transaction coordinator notes regarding special instructions, exceptions, amendments, or conditions not captured in structured fields.',
    `opening_balance` DECIMAL(18,2) COMMENT 'The initial fund balance at the time the escrow account was opened, typically representing the earnest money deposit or initial impound amount.',
    `opening_date` DATE COMMENT 'The date on which the escrow account was formally opened and became active for receiving funds. Marks the start of the escrow lifecycle.',
    `purchase_price` DECIMAL(18,2) COMMENT 'The agreed-upon contract purchase price for the property transaction that this escrow account supports. Used to validate that total funds received are sufficient for closing.',
    `qualified_intermediary_name` STRING COMMENT 'Legal name of the qualified intermediary holding exchange proceeds for a 1031 exchange escrow. Required by IRS regulations to maintain tax-deferred status.',
    `reconciliation_status` STRING COMMENT 'Current reconciliation status of the escrow account against the trust account ledger: reconciled (balances match), unreconciled (discrepancy identified), in_progress (reconciliation underway), or exception (requires manual resolution).. Valid values are `reconciled|unreconciled|in_progress|exception`',
    `release_authorization_status` STRING COMMENT 'Current authorization status for fund release from escrow: pending (awaiting authorization), authorized (all parties have approved disbursement), partially_authorized (some disbursements approved), or rejected (authorization denied).. Valid values are `pending|authorized|partially_authorized|rejected`',
    `release_conditions` STRING COMMENT 'Narrative description of the conditions that must be satisfied before escrow funds can be released or disbursed (e.g., clear title, financing approval, inspection sign-off, COO issuance). Sourced from DocuSign CLM escrow instructions.',
    `title_fee_amount` DECIMAL(18,2) COMMENT 'Total title insurance premium and title-related fees (search, examination, endorsements) to be disbursed from escrow at closing per the ALTA settlement statement.',
    `total_deposits` DECIMAL(18,2) COMMENT 'Cumulative sum of all funds deposited into the escrow account since opening, including earnest money, loan proceeds, and buyer closing funds.',
    `total_disbursements` DECIMAL(18,2) COMMENT 'Cumulative sum of all funds disbursed from the escrow account since opening, including commissions, title fees, transfer taxes, loan payoffs, and net proceeds to seller.',
    `transfer_tax_amount` DECIMAL(18,2) COMMENT 'State and local real estate transfer tax amount to be collected and remitted from escrow at closing. Varies by jurisdiction.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this escrow account record was last modified, supporting change tracking, audit trails, and incremental data pipeline processing.',
    `yardi_trust_account_ref` STRING COMMENT 'The trust account reference number in Yardi Voyager AP/AR module used for reconciliation of escrow fund movements against the general ledger trust account.',
    CONSTRAINT pk_escrow_account PRIMARY KEY(`escrow_account_id`)
) COMMENT 'Manages escrow accounts and the complete ledger of fund movements for property transactions — earnest money deposits, impound holds, disbursements (commissions, title fees, transfer taxes, loan payoffs, net proceeds), and releases. Captures escrow account number, escrow holder, escrow type (purchase, impound, reserve), opening balance, current balance, and account status. Each fund event records date, payee/payor, amount, payment method, reference number, authorization status, and release conditions. Provides a complete audit trail from account opening through final disbursement. Integrates with Yardi Voyager AP/AR for trust account reconciliation.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` (
    `escrow_disbursement_id` BIGINT COMMENT 'Unique system-generated identifier for each escrow disbursement record. Primary key for the escrow_disbursement data product within the transaction domain.',
    `ap_payment_id` BIGINT COMMENT 'Foreign key linking to finance.ap_payment. Business justification: Escrow disbursements for vendor payables (title fees, commissions, repair costs) are recorded as AP payments in the finance system. This link enables escrow-to-AP reconciliation, a standard real estat',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Escrow disbursements require internal employee authorization for financial controls and SOX/audit compliance. The existing authorized_by plain string is a denormalized internal employee reference. R',
    `closing_statement_line_id` BIGINT COMMENT 'Foreign key linking to transaction.closing_statement_line. Business justification: escrow_disbursement has closing_statement_line_ref: STRING — a string reference to the closing statement line item that authorized the disbursement. This should be a proper FK to closing_statement_lin',
    `commission_id` BIGINT COMMENT 'Foreign key linking to brokerage.commission. Business justification: Escrow disbursements include broker commission payments. Linking to the commission record enables commission payment status tracking, 1099-S/1099-MISC reporting compliance, and reconciliation of disbu',
    `currency_code_id` BIGINT COMMENT 'Foreign key linking to reference.currency_code. Business justification: Disbursement records require normalized currency reference for GL posting in multi-currency accounting systems, 1099-S reporting, FIRPTA withholding calculations, and international wire transfer compl',
    `escrow_account_id` BIGINT COMMENT 'Reference to the escrow account from which this disbursement was released. Links the disbursement to the parent escrow account holding the transaction funds.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to maintenance.capex_project. Business justification: Post-closing escrow holdbacks (seller repair escrows, TI escrows, deferred maintenance reserves) are disbursed to fund specific CAPEX projects. Escrow officers and asset managers link disbursements to',
    `owner_id` BIGINT COMMENT 'Foreign key linking to owner.owner. Business justification: Net proceeds disbursements to seller-owners require linking escrow disbursements to owner records for 1099-S reporting, FIRPTA withholding compliance, and owner-level cash flow reconciliation. Complia',
    `premium_id` BIGINT COMMENT 'Foreign key linking to insurance.premium. Business justification: Escrow premium disbursement reconciliation: escrow accounts disburse insurance premiums on behalf of borrowers. Linking escrow_disbursement to the insurance premium invoice enables servicer reconcilia',
    `property_sale_id` BIGINT COMMENT 'Reference to the parent property sale or acquisition transaction associated with this escrow disbursement. Links disbursement to the originating deal event.',
    `authorization_status` STRING COMMENT 'Approval workflow status indicating whether the disbursement has been authorized by the required approving parties (e.g., escrow officer, title company, lender). Supports dual-control authorization requirements and SOX financial controls.. Valid values are `pending|approved|rejected|escalated`',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when the disbursement was formally authorized by the approving party. Provides a precise audit trail event for SOX compliance and escrow reconciliation.',
    `bank_account_number_masked` STRING COMMENT 'Masked bank account number of the payees receiving account, showing only the last four digits (e.g., ****1234). Stored for reconciliation and audit purposes without exposing full PCI-sensitive account data.',
    `bank_routing_number` STRING COMMENT 'ABA routing transit number of the payees receiving financial institution. Required for ACH and wire transfer processing. Nine-digit numeric code identifying the destination bank.. Valid values are `^[0-9]{9}$`',
    `commission_basis_amount` DECIMAL(18,2) COMMENT 'The gross sale price or transaction value upon which the commission rate is applied to calculate the commission disbursement amount. Applicable when disbursement_type is commission. Supports commission audit and RESPA Section 8 compliance.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Brokerage commission rate expressed as a decimal percentage of the sale price (e.g., 0.0300 = 3.00%). Applicable only when disbursement_type is commission. Used for commission reconciliation and broker reporting.',
    `cost_center_code` STRING COMMENT 'Cost center or profit center code associated with this disbursement for internal financial reporting and budget variance analysis. Aligns with SAP S/4HANA and Yardi Voyager cost center structures.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this escrow disbursement record was first created in the data platform. Supports audit trail, data lineage, and SOX record retention requirements.',
    `disbursement_amount` DECIMAL(18,2) COMMENT 'Gross monetary amount released from escrow to the payee in this disbursement event. Represents the base amount before any withholding or adjustments. Expressed in the transaction currency.',
    `disbursement_date` DATE COMMENT 'The actual calendar date on which funds were released from the escrow account to the payee. Represents the principal real-world event date for this disbursement. Aligns with closing date or post-closing settlement schedule.',
    `disbursement_notes` STRING COMMENT 'Free-text field for escrow officer or closing agent notes regarding special circumstances, conditions, or instructions associated with this disbursement. May include holdback conditions, lender instructions, or dispute notations.',
    `disbursement_number` STRING COMMENT 'Externally-visible alphanumeric reference number assigned to this disbursement by the escrow company or title company. Used for reconciliation with closing statements and Yardi Voyager AR/AP records.',
    `disbursement_status` STRING COMMENT 'Current workflow lifecycle state of the disbursement. Tracks progression from pending authorization through final release or voiding. Supports audit trail and reconciliation reporting.. Valid values are `pending|authorized|disbursed|voided|returned|on_hold`',
    `disbursement_type` STRING COMMENT 'Categorical classification of the nature of the disbursement. Identifies whether funds represent a brokerage commission, title/settlement fee, transfer tax, mortgage loan payoff, net sale proceeds to seller, recording fee, prorated property taxes, Tenant Improvement (TI) allowance, or other closing cost. [ENUM-REF-CANDIDATE: commission|title_fee|transfer_tax|loan_payoff|net_proceeds|recording_fee|prorated_taxes|tenant_improvement|other — promote to reference product]',
    `escrow_officer_name` STRING COMMENT 'Full name of the licensed escrow officer or closing agent responsible for processing and releasing this disbursement. Required for audit trail, regulatory compliance, and ALTA closing disclosure documentation.',
    `gl_account_code` STRING COMMENT 'General Ledger (GL) account code to which this disbursement is posted in the accounting system (Yardi Voyager or SAP S/4HANA). Enables financial consolidation, cost center allocation, and GAAP-compliant transaction recording.',
    `holdback_release_flag` BOOLEAN COMMENT 'Indicates whether this disbursement represents the release of a previously held-back escrow amount (True). Holdbacks are common in commercial transactions for repair escrows, environmental remediation reserves, or tenant improvement allowances.',
    `is_1031_exchange_proceeds` BOOLEAN COMMENT 'Indicates whether this disbursement represents proceeds being directed to a Qualified Intermediary (QI) as part of an IRS Section 1031 like-kind exchange. When True, funds must be held by the QI and not constructively received by the seller.',
    `is_post_closing` BOOLEAN COMMENT 'Indicates whether this disbursement was made after the official closing date (True) or at closing (False). Post-closing disbursements may include holdback releases, prorated adjustments, or deferred commission payments.',
    `loan_payoff_lender_name` STRING COMMENT 'Name of the mortgage lender or financial institution receiving a loan payoff disbursement. Applicable when disbursement_type is loan_payoff. Supports Loan-to-Value (LTV) reconciliation and lien release tracking.',
    `loan_payoff_reference` STRING COMMENT 'Lender-assigned loan number or payoff statement reference for the mortgage being satisfied by this disbursement. Used to confirm lien release and coordinate with title company for deed recording.',
    `net_disbursement_amount` DECIMAL(18,2) COMMENT 'Net amount actually paid to the payee after deducting any withholding amounts from the gross disbursement amount. Represents the actual funds transferred. Calculated as disbursement_amount minus withholding_amount.',
    `payee_name` STRING COMMENT 'Full legal name of the individual, company, or institution receiving the disbursed funds. May be a broker, title company, lender, seller, buyer, government entity, or service provider. Required for closing statement reconciliation and 1099 reporting.',
    `payee_tax_identification_number` STRING COMMENT 'Federal Tax Identification Number (TIN), Employer Identification Number (EIN), or Social Security Number (SSN) of the payee. Required for IRS 1099-S real estate proceeds reporting and backup withholding compliance.',
    `payee_type` STRING COMMENT 'Classification of the payee entity receiving the disbursement. Distinguishes between brokers (commission recipients), lenders (loan payoff), sellers (net proceeds), buyers (refunds), title companies, government agencies (transfer tax), and other service providers. [ENUM-REF-CANDIDATE: broker|lender|seller|buyer|title_company|government|service_provider|other — 8 candidates stripped; promote to reference product]',
    `payment_method` STRING COMMENT 'Instrument or mechanism used to transfer the disbursed funds to the payee. Common methods include wire transfer, ACH electronic transfer, cashiers check, or certified check. Critical for bank reconciliation and fraud prevention controls.. Valid values are `wire_transfer|check|ach|cashiers_check|zelle|other`',
    `payment_reference_number` STRING COMMENT 'Bank-assigned or system-generated reference number for the payment instrument used (e.g., wire confirmation number, ACH trace number, check number). Used for bank reconciliation and payment tracing.',
    `qualified_intermediary_name` STRING COMMENT 'Name of the Qualified Intermediary (QI) entity receiving 1031 exchange proceeds on behalf of the seller. Applicable when is_1031_exchange_proceeds is True. Required for IRS Section 1031 compliance documentation.',
    `return_date` DATE COMMENT 'Date on which a disbursed amount was returned to the escrow account due to a failed payment, rejected wire, or stale check. Populated only when disbursement_status is returned. Triggers re-disbursement workflow.',
    `title_company_name` STRING COMMENT 'Name of the title company or settlement agent managing the escrow account from which this disbursement is made. Provides institutional context for the disbursement and links to ALTA title policy records.',
    `transfer_tax_jurisdiction` STRING COMMENT 'Name of the governmental jurisdiction (state, county, or municipality) to which transfer tax disbursements are remitted. Applicable when disbursement_type is transfer_tax. Required for tax compliance and regulatory reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp recording when this escrow disbursement record was last modified. Tracks status changes, authorization updates, and corrections. Supports change data capture (CDC) in the Databricks Lakehouse Silver Layer.',
    `void_reason` STRING COMMENT 'Explanation for why a disbursement was voided or cancelled. Populated only when disbursement_status is voided. Required for audit trail integrity and SOX internal control documentation.',
    `withholding_amount` DECIMAL(18,2) COMMENT 'Amount withheld from the gross disbursement for tax withholding obligations, such as FIRPTA (Foreign Investment in Real Property Tax Act) withholding on foreign sellers or backup withholding. Reduces the net amount actually paid to the payee.',
    `yardi_disbursement_ref` STRING COMMENT 'Source system reference identifier from Yardi Voyager Accounts Payable or Accounts Receivable module corresponding to this disbursement record. Enables bi-directional traceability between the lakehouse silver layer and the operational system of record.',
    CONSTRAINT pk_escrow_disbursement PRIMARY KEY(`escrow_disbursement_id`)
) COMMENT 'Records individual disbursement events from an escrow account, including disbursement date, payee, disbursement amount, disbursement type (commission, title fee, transfer tax, loan payoff, net proceeds), payment method, reference number, and authorization status. Provides a complete audit trail of all funds released from escrow at or after closing.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` (
    `transaction_deal_document_id` BIGINT COMMENT 'Primary key for deal_document',
    `appraisal_report_id` BIGINT COMMENT 'Foreign key linking to valuation.appraisal_report. Business justification: Appraisal reports are formal transaction documents stored in deal document management systems. Linking transaction_deal_document to appraisal_report enables document completeness tracking for closing ',
    `asset_id` BIGINT COMMENT 'Reference to the property record that is the subject of the transaction to which this document pertains.',
    `brokerage_deal_id` BIGINT COMMENT 'Reference to the brokerage deal or investment deal record associated with this document, enabling cross-domain linkage between transaction and brokerage pipelines.',
    `closing_statement_id` BIGINT COMMENT 'Foreign key linking to transaction.closing_statement. Business justification: Closing statements generate critical documents (HUD-1, ALTA settlement statement, disbursement receipts, wire confirmations, recording receipts). Adding closing_statement_id provides direct linkage to',
    `deed_transfer_id` BIGINT COMMENT 'Foreign key linking to transaction.deed_transfer. Business justification: Deed transfers generate legal documents (warranty deed, quitclaim deed, special warranty deed, recording receipt, transfer tax receipts). Adding deed_transfer_id provides direct linkage to the deed tr',
    `document_id` BIGINT COMMENT 'Self-referencing identifier pointing to a parent or predecessor document that this document amends, supersedes, or is related to (e.g., an amendment references the original PSA). Null if no related document exists.',
    `document_type_id` BIGINT COMMENT 'Foreign key linking to reference.document_type. Business justification: Document management workflows, retention schedules, regulatory filing obligations, notarization requirements, and e-signature validity rules are all driven by document type classification. Every trans',
    `due_diligence_item_id` BIGINT COMMENT 'Foreign key linking to transaction.due_diligence_item. Business justification: Due diligence items generate supporting documentation (inspection reports, environmental assessments, Phase I/II reports, survey reports, zoning letters, engineering reports). Adding due_diligence_ite',
    `exchange_1031_id` BIGINT COMMENT 'Foreign key linking to transaction.exchange_1031. Business justification: 1031 exchanges generate extensive documentation (exchange agreement, identification notice, assignment agreement, QI account statements, IRS Form 8824). Adding exchange_1031_id provides direct linkage',
    `financing_id` BIGINT COMMENT 'Foreign key linking to transaction.financing. Business justification: Financing arrangements generate extensive documentation (loan application, commitment letter, promissory note, deed of trust, mortgage, loan closing documents). Adding financing_id provides direct lin',
    `offer_id` BIGINT COMMENT 'Foreign key linking to transaction.offer. Business justification: Offers generate supporting documentation (offer letter, proof of funds, pre-approval letter, earnest money receipt, counter-offer documents). Adding offer_id provides direct linkage to the offer that ',
    `property_sale_id` BIGINT COMMENT 'Reference to the parent property transaction (acquisition, disposition, or sale event) to which this document belongs.',
    `purchase_agreement_id` BIGINT COMMENT 'Foreign key linking to transaction.purchase_agreement. Business justification: Purchase agreements generate extensive documentation (PSA, amendments, addenda, contingency removal notices, extension agreements). While transaction_deal_document already links to property_sale, addi',
    `reo_disposition_id` BIGINT COMMENT 'Foreign key linking to transaction.reo_disposition. Business justification: REO dispositions generate specialized documentation (REO acquisition documents, foreclosure documents, disposition agreements, as-is addenda, REO disclosures). Adding reo_disposition_id provides direc',
    `title_search_id` BIGINT COMMENT 'Foreign key linking to transaction.title_search. Business justification: Title searches generate critical documents (title commitment, preliminary title report, title policy, exception documents, lien releases). Adding title_search_id provides direct linkage to the title s',
    `access_restricted` BOOLEAN COMMENT 'Indicates whether access to this document is restricted to a defined set of authorized users or roles. True if access controls are applied beyond standard permissions; False for broadly accessible documents.',
    `amendment_number` STRING COMMENT 'Sequential amendment number for documents that are amendments to a base agreement (e.g., Amendment No. 1, Amendment No. 2 to a PSA). Null for original documents that are not amendments.',
    `confidentiality_level` STRING COMMENT 'Data classification level assigned to the document based on its sensitivity and access control requirements. Aligns with the enterprise data classification policy (public, internal, confidential, restricted).. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this document record was first created in the Silver Layer data product. Supports audit trail, data lineage, and SOX compliance requirements.',
    `document_description` STRING COMMENT 'Free-text narrative description of the documents purpose, scope, or key provisions. Used by deal teams and asset managers to quickly understand the documents business significance without opening the file.',
    `document_name` STRING COMMENT 'Human-readable title or name of the document as it appears in the document management system or DocuSign CLM (e.g., Purchase and Sale Agreement — 123 Main Street — v2).',
    `document_number` STRING COMMENT 'Externally-known unique business identifier for the document, typically assigned by the document management system or DocuSign CLM (e.g., DOC-2024-00123). Used for cross-system reference and audit trails.',
    `document_status` STRING COMMENT 'Current lifecycle state of the document within the transaction workflow. Tracks progression from draft through execution, and flags superseded or voided versions for compliance and audit purposes.. Valid values are `Draft|Pending Signature|Executed|Superseded|Voided|Expired`',
    `docusign_envelope_code` STRING COMMENT 'Unique envelope identifier assigned by DocuSign CLM for electronically executed documents. Enables direct lookup and audit trail retrieval from the DocuSign platform for executed agreements.',
    `docusign_status` STRING COMMENT 'Current status of the DocuSign envelope associated with this document, reflecting the electronic signature workflow state as reported by DocuSign CLM.. Valid values are `Sent|Delivered|Completed|Declined|Voided|Expired`',
    `effective_date` DATE COMMENT 'The date on which the document becomes legally effective and binding, which may differ from the execution date (e.g., a deed may be executed before the closing date but effective on the closing date).',
    `execution_date` DATE COMMENT 'The date on which all required parties executed (signed) the document, making it legally binding. Null if the document has not yet been fully executed.',
    `expiration_date` DATE COMMENT 'The date on which the document expires or is no longer valid (e.g., a title commitment expiry date or a loan commitment expiry). Null for documents with no defined expiration.',
    `file_format` STRING COMMENT 'File format of the stored document (e.g., PDF, DOCX, TIFF). Used for document management, rendering, and archival compliance.. Valid values are `PDF|DOCX|XLSX|TIFF|MSG|ZIP`',
    `file_size_kb` STRING COMMENT 'Size of the document file in kilobytes. Used for storage management, archival planning, and document integrity verification.',
    `is_current_version` BOOLEAN COMMENT 'Indicates whether this document record represents the most current active version. True if current; False if superseded by a later version. Supports version chain management.',
    `notarized` BOOLEAN COMMENT 'Indicates whether the document has been notarized by a licensed notary public. True if notarized; False otherwise. Required for deeds, affidavits, and certain closing documents.',
    `notary_commission_expiry` DATE COMMENT 'Expiration date of the notary publics commission at the time of notarization. Used to validate the legal standing of the notarization for title and closing compliance.',
    `notary_name` STRING COMMENT 'Full name of the notary public who notarized the document. Null if the document was not notarized.',
    `page_count` STRING COMMENT 'Total number of pages in the document. Used for document completeness verification and review tracking.',
    `prepared_by` STRING COMMENT 'Name or identifier of the individual, firm, or system that prepared or drafted the document (e.g., outside counsel, title company, internal paralegal). Used for accountability and document provenance tracking.',
    `primary_signatory_name` STRING COMMENT 'Full legal name of the primary signatory party on the document (e.g., buyer, seller, borrower, or authorized representative). Classified confidential PII as it identifies an individual.',
    `received_date` DATE COMMENT 'The date on which the document was received by the organization from the counterparty, title company, lender, or other external party. Used for due diligence tracking and compliance timelines.',
    `recorded_date` DATE COMMENT 'The date on which the document was officially recorded with the county recorder, register of deeds, or other recording jurisdiction. Null if recording is not required or not yet completed.',
    `recording_jurisdiction` STRING COMMENT 'Name of the county, municipality, or governmental jurisdiction where the document was or will be recorded (e.g., Cook County, IL). Required for title chain and compliance tracking.',
    `recording_number` STRING COMMENT 'Official instrument or recording number assigned by the county recorder or register of deeds upon recording of the document. Used for title chain verification and ALTA policy referencing.',
    `recording_required` BOOLEAN COMMENT 'Indicates whether this document must be recorded with the county recorder or register of deeds (e.g., deeds, deeds of trust, easements). True if recording is required; False otherwise.',
    `review_date` DATE COMMENT 'Date on which the document was reviewed and approved internally prior to execution. Supports deal workflow tracking and SOX control documentation.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the individual or team that reviewed and approved the document prior to execution (e.g., in-house counsel, asset manager, compliance officer).',
    `secondary_signatory_name` STRING COMMENT 'Full legal name of the secondary signatory party on the document (e.g., co-buyer, co-seller, guarantor, or co-borrower). Null if only one signatory is required.',
    `signatory_party_type` STRING COMMENT 'Classification of the primary signatorys role in the transaction (e.g., Buyer, Seller, Lender, Borrower, Guarantor, Title Agent, Escrow Officer, Broker). [ENUM-REF-CANDIDATE: Buyer|Seller|Lender|Borrower|Guarantor|Title Agent|Escrow Officer|Broker — promote to reference product]',
    `source_system` STRING COMMENT 'Operational system of record from which this document record originated (e.g., DocuSign CLM, Yardi Voyager, Procore). Used for data lineage, reconciliation, and Silver Layer provenance tracking.. Valid values are `DocuSign CLM|Yardi Voyager|MRI Software|Procore|SAP S/4HANA|Manual Upload`',
    `source_system_doc_code` STRING COMMENT 'Native document identifier from the originating operational system (e.g., Yardi document reference, Procore document ID, or MRI document number). Enables back-referencing to the system of record for reconciliation.',
    `storage_path` STRING COMMENT 'Full file system or cloud storage path (e.g., Azure Data Lake, SharePoint, or document management system URI) where the document file is stored. Classified confidential as it reveals internal infrastructure and document access paths.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this document record was last modified in the Silver Layer data product. Used for change tracking, incremental processing, and audit compliance.',
    `version_number` STRING COMMENT 'Sequential integer version number of the document, incremented each time a new version is issued or an amendment is executed. Version 1 represents the original document.',
    CONSTRAINT pk_transaction_deal_document PRIMARY KEY(`transaction_deal_document_id`)
) COMMENT 'Repository of all documents associated with a property transaction, including document type (PSA, amendment, disclosure, inspection report, appraisal, title commitment, deed, closing statement, SNDA, loan commitment), document name, version number, execution date, signatory parties, DocuSign envelope ID, storage path, and document status. Integrates with DocuSign CLM for executed document management.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`sale_type` (
    `sale_type_id` BIGINT COMMENT 'Primary key for sale_type',
    `regulatory_framework_id` BIGINT COMMENT 'Foreign key linking to reference.regulatory_framework. Business justification: Sale type classification drives regulatory reporting requirements — RESPA, HUD, SEC, and state-specific reporting obligations differ by transaction type. Compliance teams require a normalized regulato',
    `appraisal_required` BOOLEAN COMMENT 'Indicates whether a formal property appraisal by a licensed appraiser is required for transactions of this sale type. Mandatory for federally related transactions, REIT acquisitions, and distressed sales per Appraisal Institute and IVSC standards.',
    `argus_transaction_type_code` STRING COMMENT 'Argus Enterprises native transaction type classification code mapped to this sale type. Used for DCF model alignment, investment analysis, and portfolio reporting in Argus Enterprise, ensuring consistent transaction categorization across valuation and cash flow modeling workflows.',
    `cap_rate_applicable` BOOLEAN COMMENT 'Indicates whether CAP Rate (Capitalization Rate) analysis is applicable and meaningful for transactions of this sale type. CAP Rate is not meaningful for land sales, short sales, or foreclosures where income-producing property assumptions do not apply. Drives analytics layer logic in Argus Enterprise and portfolio reporting.',
    `costar_transaction_type_code` STRING COMMENT 'CoStar Suites native transaction type classification code corresponding to this sale type. Used for bi-directional data synchronization between the enterprise data lakehouse and CoStar comparable sales and property analytics modules, enabling market benchmarking and CMA analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sale type record was first created in the enterprise data lakehouse Silver layer. Supports audit trail requirements under SOX financial controls and GDPR data lineage obligations.',
    `deal_direction` STRING COMMENT 'Indicates whether the transaction type represents an inbound acquisition (buy-side), outbound disposition (sell-side), or a neutral/bilateral event (e.g., portfolio sale that may be either). Critical for Investment Advisory and Portfolio Management reporting, Asset Under Management (AUM) tracking, and GL journal entry routing in SAP S/4HANA.. Valid values are `acquisition|disposition|neutral`',
    `deal_workflow_template_code` STRING COMMENT 'Reference code identifying the standard deal workflow template to be applied when a property_sale of this type is initiated. Maps to workflow configurations in Salesforce CRM deal pipeline and DocuSign CLM contract lifecycle management, controlling milestone sequencing, required documents, and approval gates.. Valid values are `^[A-Z0-9_]{2,40}$`',
    `deed_type_default` STRING COMMENT 'Default deed type typically associated with this sale type (e.g., Warranty Deed for standard acquisitions, Sheriffs Deed for foreclosures, Trustees Deed for REO sales, Quitclaim Deed for certain distressed transactions). Serves as a default suggestion in the purchase_agreement and property_sale workflows.. Valid values are `warranty|special_warranty|quitclaim|trustee|sheriff|none`',
    `earnest_money_required` BOOLEAN COMMENT 'Indicates whether earnest money deposit is required for transactions of this sale type. Certain distressed sale types (REO, foreclosure) or auction-based transactions may have non-standard earnest money requirements or may not require earnest money at all.',
    `effective_date` DATE COMMENT 'Date from which this sale type definition became effective and available for use in transaction classification. Supports temporal validity tracking for regulatory compliance and audit purposes.',
    `environmental_review_required` BOOLEAN COMMENT 'Indicates whether an environmental review (Phase I or Phase II Environmental Site Assessment) is required for transactions of this sale type. Triggered for commercial acquisitions, development site purchases, and REO sales per EPA environmental compliance requirements.',
    `esg_disclosure_required` BOOLEAN COMMENT 'Indicates whether ESG (Environmental, Social, and Governance) disclosure documentation is required for transactions of this sale type. Applicable for REIT portfolio transactions, institutional acquisitions, and LEED/BREEAM-certified property sales subject to SEC ESG reporting requirements.',
    `expiry_date` DATE COMMENT 'Date on which this sale type definition expires and is no longer valid for new transaction classification. Null indicates no planned expiry. Supports regulatory compliance and reference data lifecycle management.',
    `financing_eligible` BOOLEAN COMMENT 'Indicates whether transactions of this sale type are eligible for third-party debt financing (mortgage, CMBS, bridge loan). Some sale types (e.g., certain REO or short sales) may be cash-only or have restricted financing options, affecting LTV ratio applicability and loan underwriting workflows.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this sale type is currently active and available for selection when creating new property_sale and purchase_agreement records. Inactive types are retained for historical reporting but suppressed from new transaction entry workflows.',
    `is_distressed_sale` BOOLEAN COMMENT 'Indicates whether this sale type is classified as a distressed transaction (e.g., REO Sale, Short Sale, Foreclosure). Distressed sale types trigger specific due diligence workflows, BPO/CMA requirements, and regulatory reporting obligations under HUD and SEC guidelines for REIT portfolios.',
    `is_exchange_type` BOOLEAN COMMENT 'Indicates whether this sale type qualifies as or involves an IRS Section 1031 like-kind exchange, triggering deferred capital gains tax treatment. When True, the exchange_deadline_date field on property_sale becomes mandatory and specific regulatory reporting obligations apply.',
    `is_ground_lease_assignment` BOOLEAN COMMENT 'Indicates whether this sale type represents the assignment of a ground lease interest rather than a fee-simple title transfer. Ground lease assignments have distinct title, ALTA policy, and SNDA requirements and are tracked separately in Yardi Voyager Lease Administration.',
    `is_leaseback_involved` BOOLEAN COMMENT 'Indicates whether this sale type involves a simultaneous or concurrent leaseback arrangement (Sale-Leaseback). When True, ASC 842 / IFRS 16 lease accounting treatment is required post-closing, and the transaction must be linked to a corresponding lease record.',
    `is_portfolio_transaction` BOOLEAN COMMENT 'Indicates whether this sale type involves the simultaneous transfer of multiple properties as a single portfolio deal. Portfolio transactions require consolidated pricing, blended CAP Rate and NOI analysis, and special handling in Argus Enterprise portfolio reporting and MRI Investment Management.',
    `ltv_tracking_required` BOOLEAN COMMENT 'Indicates whether Loan-to-Value (LTV) ratio must be captured for transactions of this sale type. LTV tracking is required for financed acquisitions and dispositions but not applicable for all-cash transactions, 1031 exchanges with no new debt, or certain distressed sale types.',
    `mls_reportable` BOOLEAN COMMENT 'Indicates whether transactions of this sale type are eligible and required to be reported to the Multiple Listing Service (MLS). Commercial portfolio sales, ground lease assignments, and certain off-market transactions may be excluded from MLS reporting per NAR guidelines.',
    `noi_tracking_required` BOOLEAN COMMENT 'Indicates whether Net Operating Income (NOI) at time of sale must be captured and tracked for transactions of this sale type. Required for income-producing property acquisitions and dispositions to support CAP Rate calculation, DSCR analysis, and REIT FFO/AFFO reporting.',
    `notes` STRING COMMENT 'Free-text field for administrative notes, clarifications, or special handling instructions related to this sale type. Used by data stewards and transaction coordinators to document edge cases, exceptions, or guidance for deal teams when selecting this transaction type.',
    `psf_pricing_applicable` BOOLEAN COMMENT 'Indicates whether Per Square Foot (PSF) pricing metrics are applicable and should be calculated for transactions of this sale type. PSF pricing is standard for commercial and residential sales but may not be meaningful for ground lease assignments or certain portfolio transactions.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether transactions of this type trigger mandatory regulatory reporting obligations (e.g., SEC filings for REIT dispositions, HUD reporting for REO sales, IRS 1031 exchange filings, SOX financial controls documentation). Drives automated compliance workflow initiation in the compliance domain.',
    `required_due_diligence_items` STRING COMMENT 'Comma-delimited list of mandatory due diligence checklist items required for this sale type (e.g., ALTA Survey, Phase I ESG, Title Search, Appraisal, SNDA, Zoning Report). Drives automated checklist generation in Procore and DocuSign CLM when a new transaction of this type is opened.',
    `sort_order` STRING COMMENT 'Numeric value controlling the display sequence of sale types in dropdown menus, reporting filters, and UI selection lists across Yardi Voyager, Salesforce CRM, and enterprise reporting dashboards. Lower values appear first.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this sale type definition originated (e.g., YARDI for Yardi Voyager, MRI for MRI Software, ARGUS for Argus Enterprise, COSTAR for CoStar Suite, MANUAL for manually entered reference data). Supports data lineage and master data management. [ENUM-REF-CANDIDATE: YARDI|MRI|ARGUS|SALESFORCE|COSTAR|SAP|MANUAL — 7 candidates stripped; promote to reference product]',
    `title_policy_type_required` STRING COMMENT 'Specifies the ALTA title insurance policy type required for transactions of this sale type: owners policy, lenders policy, both, or none. Drives title search workflow initiation and ALTA policy procurement in the title_search product.. Valid values are `owner|lender|both|none`',
    `transaction_category` STRING COMMENT 'Broad property category to which this sale type applies, enabling domain-specific filtering of property_sale records. Drives workflow routing and reporting segmentation across Commercial Real Estate (CRE), residential, land, mixed-use, and portfolio transactions.. Valid values are `commercial|residential|land|mixed_use|portfolio`',
    `transfer_tax_applicable` BOOLEAN COMMENT 'Indicates whether real estate transfer tax is applicable to transactions of this sale type. Some transaction types (e.g., 1031 exchanges, certain ground lease assignments, intra-entity portfolio transfers) may be exempt from transfer tax under applicable state and local statutes.',
    `type_code` STRING COMMENT 'Short, system-facing alphanumeric code uniquely identifying the sale type (e.g., ACQ, DISP, EXCH_1031, REO, SHORT_SALE, FORECLOSURE, PORT_SALE, SLB, GLA). Used as the stable business key for integration with Yardi Voyager, MRI Software, Argus Enterprise, and CoStar Suite transaction classification fields.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `type_description` STRING COMMENT 'Full narrative description of the sale type, including its legal and operational characteristics, applicable deal structures, and distinguishing features from other transaction types. Used for business glossary documentation and onboarding materials.',
    `type_name` STRING COMMENT 'Human-readable display name for the sale type as shown in reporting dashboards, deal pipeline views in Salesforce CRM, and CoStar comparable sales exports (e.g., Acquisition, Disposition, 1031 Exchange, REO Sale, Short Sale, Foreclosure Sale, Portfolio Sale, Sale-Leaseback, Ground Lease Assignment).',
    `typical_closing_days` STRING COMMENT 'Standard number of calendar days from contract execution to closing typically associated with this sale type. Used as a default for expected_closing_date calculation in property_sale and purchase_agreement records, and for deal pipeline velocity benchmarking in Salesforce CRM.',
    `typical_due_diligence_days` STRING COMMENT 'Standard number of calendar days for the due diligence period typically associated with this sale type. Used as a default for due_diligence_end_date calculation in purchase_agreement records. Varies significantly by transaction type (e.g., REO sales typically have shorter DD periods than complex portfolio acquisitions).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this sale type record was last modified in the enterprise data lakehouse Silver layer. Supports change data capture, audit trail requirements under SOX, and data lineage tracking.',
    `version_number` STRING COMMENT 'Monotonically incrementing version number for this sale type record, supporting optimistic concurrency control and change history tracking. Incremented each time the record is updated. Supports SOX audit trail and reference data governance requirements.',
    `yardi_transaction_type_code` STRING COMMENT 'Yardi Voyagers native transaction type code mapped to this sale type. Ensures consistent classification when property_sale records are ingested from or exported to Yardi Voyagers property management and accounts receivable modules.',
    CONSTRAINT pk_sale_type PRIMARY KEY(`sale_type_id`)
) COMMENT 'Reference classification table defining standardized transaction type taxonomy — acquisition, disposition, 1031 exchange, REO sale, short sale, foreclosure, portfolio sale, sale-leaseback, and ground lease assignment. Captures type code, display name, transaction category (commercial, residential, land, mixed-use), applicable deal workflow template, and regulatory reporting flag. Used enterprise-wide to classify and filter property_sale records.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`sale_attribution` (
    `sale_attribution_id` BIGINT COMMENT 'Unique surrogate identifier for each property sale to campaign attribution record. Primary key.',
    `campaign_id` BIGINT COMMENT 'Foreign key linking to the marketing campaign receiving attribution credit',
    `lead_id` BIGINT COMMENT 'Reference to the lead record that connected this campaign to the eventual buyer. Enables tracing attribution back to specific lead generation events.',
    `property_sale_id` BIGINT COMMENT 'Foreign key linking to the property sale transaction being attributed to marketing efforts',
    `attributed_revenue_amount` DECIMAL(18,2) COMMENT 'Dollar amount of the property sale revenue credited to this campaign, calculated as purchase_price × attribution_weight. Used for campaign ROI calculation. Explicitly identified in detection phase relationship_data.',
    `attribution_confidence_score` DECIMAL(18,2) COMMENT 'Statistical confidence level (0.00 to 1.00) in the accuracy of this attribution assignment, based on data quality, touchpoint tracking completeness, and model certainty. Lower scores indicate probabilistic attribution.',
    `attribution_model` STRING COMMENT 'The attribution methodology used to calculate attribution_weight for this record. Values: linear (equal credit), time_decay (recency-weighted), position_based (40/20/40), first_touch (100% to first), last_touch (100% to last), custom (proprietary algorithm). Explicitly identified in detection phase relationship_data.',
    `attribution_weight` DECIMAL(18,2) COMMENT 'Proportional credit assigned to this campaign for the property sale, expressed as a decimal between 0 and 1. Sum of all attribution_weight values for a single property_sale_id should equal 1.0 in multi-touch attribution models. Explicitly identified in detection phase relationship_data.',
    `campaign_role` STRING COMMENT 'Classification of the campaigns role in the buyer journey leading to the sale. Values: first_touch (initial awareness), last_touch (final conversion driver), mid_touch (nurture), assist (supporting touchpoint), direct (single-touch attribution). Explicitly identified in detection phase relationship_data.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this attribution record was created in the system, typically after the property sale closed and attribution analysis was performed.',
    `touch_date` DATE COMMENT 'Date on which the buyer interacted with this campaign (ad impression, email open, event attendance, listing view). Used for time-decay attribution models and journey timeline reconstruction.',
    `touch_sequence` STRING COMMENT 'Ordinal position of this campaign touchpoint in the buyer journey leading to the sale (1 = first touch, 2 = second touch, etc.). Used to reconstruct the full marketing journey and apply position-based attribution models. Explicitly identified in detection phase relationship_data.',
    `created_by` STRING COMMENT 'User ID or system process that created this attribution record (e.g., marketing_analytics_etl, user_id_12345).',
    CONSTRAINT pk_sale_attribution PRIMARY KEY(`sale_attribution_id`)
) COMMENT 'This association product represents the multi-touch marketing attribution between property sales and marketing campaigns. It captures the contribution of each campaign to a completed property sale, enabling ROI analysis and marketing effectiveness measurement. Each record links one property_sale to one campaign with attribution metrics that exist only in the context of this relationship.. Existence Justification: In real estate marketing operations, a single property sale is routinely attributed to multiple marketing campaigns through multi-touch attribution models (e.g., awareness campaign, retargeting campaign, open house promotion, MLS syndication). Conversely, a single campaign drives multiple property sales across its lifecycle. Marketing teams actively manage and analyze these attribution relationships to calculate campaign ROI, optimize budget allocation, and measure marketing effectiveness. This is an operational business process, not an analytical correlation.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`auction` (
    `auction_id` BIGINT COMMENT 'Primary key for auction',
    `deal_party_id` BIGINT COMMENT 'Reference to the party who submitted the winning bid.',
    `employee_id` BIGINT COMMENT 'Reference to the licensed auctioneer conducting the auction.',
    `owner_id` BIGINT COMMENT 'Reference to the party selling the property at auction.',
    `property_sale_id` BIGINT COMMENT 'Reference to the property being auctioned.',
    `prior_auction_id` BIGINT COMMENT 'Self-referencing FK on auction (prior_auction_id)',
    `actual_end_time` TIMESTAMP COMMENT 'The actual timestamp when the auction concluded.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual timestamp when the auction commenced.',
    `auction_number` STRING COMMENT 'Externally-known unique business identifier for the auction event, typically formatted as AUC-YYYYMMDD or similar convention.',
    `auction_status` STRING COMMENT 'Current lifecycle status of the auction event.',
    `auction_terms_conditions` STRING COMMENT 'Full text or reference to the legal terms and conditions governing the auction.',
    `auction_type` STRING COMMENT 'Classification of the auction format: absolute (no reserve), reserve (minimum price), sealed bid, online, live, or hybrid.',
    `auction_venue_type` STRING COMMENT 'Classification of the physical or virtual location where the auction is conducted.',
    `bid_increment_amount` DECIMAL(18,2) COMMENT 'The minimum amount by which each successive bid must increase.',
    `buyers_premium_percentage` DECIMAL(18,2) COMMENT 'The percentage fee charged to the winning bidder on top of the winning bid amount.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the auction was cancelled, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this auction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this auction (e.g., USD, EUR, GBP).',
    `deposit_required_amount` DECIMAL(18,2) COMMENT 'The earnest money or deposit amount required from bidders to participate in the auction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this auction record was last updated in the system.',
    `marketing_description` STRING COMMENT 'Promotional description of the auction used in marketing materials and listings.',
    `online_platform_url` STRING COMMENT 'Web address of the online platform hosting the auction, if applicable.',
    `registered_bidders_count` STRING COMMENT 'The number of bidders who registered to participate in the auction.',
    `registration_deadline` TIMESTAMP COMMENT 'The timestamp by which bidders must register to participate in the auction.',
    `reserve_met_flag` BOOLEAN COMMENT 'Indicates whether the reserve price was met during the auction (True if met, False if not met).',
    `reserve_price_amount` DECIMAL(18,2) COMMENT 'The minimum acceptable price set by the seller below which the property will not be sold. Confidential business data.',
    `sale_confirmed_flag` BOOLEAN COMMENT 'Indicates whether the sale was confirmed by the seller after the auction concluded (True if confirmed, False if not confirmed).',
    `scheduled_date` DATE COMMENT 'The date on which the auction is scheduled to occur.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise timestamp when the auction is scheduled to begin.',
    `starting_bid_amount` DECIMAL(18,2) COMMENT 'The opening bid amount at which the auction begins.',
    `total_bids_received` STRING COMMENT 'The total number of bids submitted during the auction.',
    `venue_address_line1` STRING COMMENT 'First line of the street address where the auction is physically conducted.',
    `venue_city` STRING COMMENT 'City where the auction venue is located.',
    `venue_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code where the auction venue is located.',
    `venue_postal_code` STRING COMMENT 'Postal or ZIP code of the auction venue.',
    `venue_state_province` STRING COMMENT 'Two-letter state or province code where the auction venue is located.',
    `winning_bid_amount` DECIMAL(18,2) COMMENT 'The final accepted bid amount that won the auction.',
    CONSTRAINT pk_auction PRIMARY KEY(`auction_id`)
) COMMENT 'Master reference table for auction. Referenced by auction_id.';

CREATE OR REPLACE TABLE `real_estate_ecm`.`transaction`.`bulk_sale_pool` (
    `bulk_sale_pool_id` BIGINT COMMENT 'Primary key for bulk_sale_pool',
    `brokerage_broker_id` BIGINT COMMENT 'Reference to the real estate agent or broker responsible for marketing and selling the bulk sale pool.',
    `employee_id` BIGINT COMMENT 'Reference to the user who created the bulk sale pool record.',
    `modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified the bulk sale pool record.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity or organization selling the bulk sale pool.',
    `parent_bulk_sale_pool_id` BIGINT COMMENT 'Self-referencing FK on bulk_sale_pool (parent_bulk_sale_pool_id)',
    `actual_closing_date` DATE COMMENT 'Actual date when the bulk sale pool transaction was closed and ownership transferred.',
    `aggregate_appraised_value` DECIMAL(18,2) COMMENT 'Total appraised value of all properties in the bulk sale pool based on professional appraisals, in US dollars.',
    `aggregate_list_price` DECIMAL(18,2) COMMENT 'Total asking price for the entire bulk sale pool in US dollars.',
    `annual_gross_income` DECIMAL(18,2) COMMENT 'Total annual gross rental or operating income generated by all properties in the bulk sale pool, in US dollars.',
    `annual_net_operating_income` DECIMAL(18,2) COMMENT 'Total annual net operating income across all properties in the bulk sale pool after operating expenses, in US dollars.',
    `capitalization_rate_percent` DECIMAL(18,2) COMMENT 'Weighted average capitalization rate for the bulk sale pool, calculated as NOI divided by property value, expressed as a percentage.',
    `comparable_sales_source` STRING COMMENT 'Primary data source used for comparable sales analysis of the bulk sale pool properties.',
    `contract_execution_date` DATE COMMENT 'Date when the purchase agreement for the bulk sale pool was executed by all parties.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bulk sale pool record was first created in the system.',
    `data_room_url` STRING COMMENT 'Web address or link to the virtual data room containing due diligence documents for the bulk sale pool.',
    `distressed_asset_indicator` BOOLEAN COMMENT 'Indicates whether the bulk sale pool consists primarily of distressed or non-performing assets.',
    `due_diligence_period_days` STRING COMMENT 'Number of days allocated for the buyer to conduct due diligence on the bulk sale pool properties.',
    `earnest_money_deposit` DECIMAL(18,2) COMMENT 'Amount of earnest money deposit required or received to secure the bulk sale pool transaction, in US dollars.',
    `exchange_type_1031` BOOLEAN COMMENT 'Indicates whether the bulk sale pool transaction qualifies as a Section 1031 like-kind exchange for tax deferral purposes.',
    `expected_closing_date` DATE COMMENT 'Anticipated date for the final closing and transfer of ownership of the bulk sale pool.',
    `geographic_concentration` STRING COMMENT 'Classification indicating the geographic distribution of properties within the bulk sale pool.',
    `loan_to_value_ratio_percent` DECIMAL(18,2) COMMENT 'Average loan-to-value ratio for properties in the bulk sale pool with existing financing, expressed as a percentage.',
    `marketing_start_date` DATE COMMENT 'Date when the bulk sale pool was first actively marketed to potential buyers.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the bulk sale pool record was last modified or updated.',
    `occupancy_rate_percent` DECIMAL(18,2) COMMENT 'Weighted average occupancy rate across all properties in the bulk sale pool, expressed as a percentage.',
    `offer_deadline_date` DATE COMMENT 'Date by which all offers for the bulk sale pool must be submitted.',
    `offering_memorandum_url` STRING COMMENT 'Web address or link to the offering memorandum document describing the bulk sale pool investment opportunity.',
    `pool_description` STRING COMMENT 'Detailed narrative description of the bulk sale pool, including property characteristics, investment highlights, and strategic considerations.',
    `pool_name` STRING COMMENT 'Human-readable name or title assigned to the bulk sale pool for identification and marketing purposes.',
    `pool_number` STRING COMMENT 'Externally-known business identifier for the bulk sale pool, typically used in transaction documents and communications.',
    `pool_status` STRING COMMENT 'Current lifecycle status of the bulk sale pool indicating its stage in the transaction workflow.',
    `pool_type` STRING COMMENT 'Classification of the bulk sale pool based on the predominant property type included in the portfolio.',
    `price_per_square_foot` DECIMAL(18,2) COMMENT 'Average price per square foot calculated across the bulk sale pool, used for comparative market analysis.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Average price per unit calculated across the bulk sale pool for multi-family or commercial properties.',
    `primary_market` STRING COMMENT 'The primary metropolitan statistical area or market where the majority of properties in the pool are located.',
    `property_count` STRING COMMENT 'Total number of individual properties included in the bulk sale pool.',
    `reo_indicator` BOOLEAN COMMENT 'Indicates whether the bulk sale pool consists primarily of bank-owned or REO properties.',
    `total_debt_outstanding` DECIMAL(18,2) COMMENT 'Aggregate outstanding debt across all properties in the bulk sale pool, in US dollars.',
    `total_square_footage` DECIMAL(18,2) COMMENT 'Aggregate square footage across all properties in the bulk sale pool, measured in square feet.',
    `total_units` STRING COMMENT 'Total number of rentable or saleable units across all properties in the bulk sale pool (applicable for multi-family or commercial properties).',
    CONSTRAINT pk_bulk_sale_pool PRIMARY KEY(`bulk_sale_pool_id`)
) COMMENT 'Master reference table for bulk_sale_pool. Referenced by bulk_sale_pool_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ADD CONSTRAINT `fk_transaction_property_sale_sale_type_id` FOREIGN KEY (`sale_type_id`) REFERENCES `real_estate_ecm`.`transaction`.`sale_type`(`sale_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_sale_type_id` FOREIGN KEY (`sale_type_id`) REFERENCES `real_estate_ecm`.`transaction`.`sale_type`(`sale_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ADD CONSTRAINT `fk_transaction_purchase_agreement_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `real_estate_ecm`.`transaction`.`offer`(`offer_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_purchase_agreement_id` FOREIGN KEY (`purchase_agreement_id`) REFERENCES `real_estate_ecm`.`transaction`.`purchase_agreement`(`purchase_agreement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ADD CONSTRAINT `fk_transaction_closing_statement_sale_type_id` FOREIGN KEY (`sale_type_id`) REFERENCES `real_estate_ecm`.`transaction`.`sale_type`(`sale_type_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ADD CONSTRAINT `fk_transaction_closing_statement_line_closing_statement_id` FOREIGN KEY (`closing_statement_id`) REFERENCES `real_estate_ecm`.`transaction`.`closing_statement`(`closing_statement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ADD CONSTRAINT `fk_transaction_closing_statement_line_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ADD CONSTRAINT `fk_transaction_title_search_purchase_agreement_id` FOREIGN KEY (`purchase_agreement_id`) REFERENCES `real_estate_ecm`.`transaction`.`purchase_agreement`(`purchase_agreement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_closing_statement_id` FOREIGN KEY (`closing_statement_id`) REFERENCES `real_estate_ecm`.`transaction`.`closing_statement`(`closing_statement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ADD CONSTRAINT `fk_transaction_deed_transfer_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ADD CONSTRAINT `fk_transaction_financing_purchase_agreement_id` FOREIGN KEY (`purchase_agreement_id`) REFERENCES `real_estate_ecm`.`transaction`.`purchase_agreement`(`purchase_agreement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ADD CONSTRAINT `fk_transaction_exchange_1031_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_auction_id` FOREIGN KEY (`auction_id`) REFERENCES `real_estate_ecm`.`transaction`.`auction`(`auction_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_bulk_sale_pool_id` FOREIGN KEY (`bulk_sale_pool_id`) REFERENCES `real_estate_ecm`.`transaction`.`bulk_sale_pool`(`bulk_sale_pool_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ADD CONSTRAINT `fk_transaction_reo_disposition_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ADD CONSTRAINT `fk_transaction_due_diligence_item_purchase_agreement_id` FOREIGN KEY (`purchase_agreement_id`) REFERENCES `real_estate_ecm`.`transaction`.`purchase_agreement`(`purchase_agreement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_closing_statement_id` FOREIGN KEY (`closing_statement_id`) REFERENCES `real_estate_ecm`.`transaction`.`closing_statement`(`closing_statement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `real_estate_ecm`.`transaction`.`offer`(`offer_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ADD CONSTRAINT `fk_transaction_deal_party_purchase_agreement_id` FOREIGN KEY (`purchase_agreement_id`) REFERENCES `real_estate_ecm`.`transaction`.`purchase_agreement`(`purchase_agreement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_parent_offer_id` FOREIGN KEY (`parent_offer_id`) REFERENCES `real_estate_ecm`.`transaction`.`offer`(`offer_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ADD CONSTRAINT `fk_transaction_offer_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_closing_statement_id` FOREIGN KEY (`closing_statement_id`) REFERENCES `real_estate_ecm`.`transaction`.`closing_statement`(`closing_statement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ADD CONSTRAINT `fk_transaction_escrow_account_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_closing_statement_line_id` FOREIGN KEY (`closing_statement_line_id`) REFERENCES `real_estate_ecm`.`transaction`.`closing_statement_line`(`closing_statement_line_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_escrow_account_id` FOREIGN KEY (`escrow_account_id`) REFERENCES `real_estate_ecm`.`transaction`.`escrow_account`(`escrow_account_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ADD CONSTRAINT `fk_transaction_escrow_disbursement_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_closing_statement_id` FOREIGN KEY (`closing_statement_id`) REFERENCES `real_estate_ecm`.`transaction`.`closing_statement`(`closing_statement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_deed_transfer_id` FOREIGN KEY (`deed_transfer_id`) REFERENCES `real_estate_ecm`.`transaction`.`deed_transfer`(`deed_transfer_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_due_diligence_item_id` FOREIGN KEY (`due_diligence_item_id`) REFERENCES `real_estate_ecm`.`transaction`.`due_diligence_item`(`due_diligence_item_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_exchange_1031_id` FOREIGN KEY (`exchange_1031_id`) REFERENCES `real_estate_ecm`.`transaction`.`exchange_1031`(`exchange_1031_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_financing_id` FOREIGN KEY (`financing_id`) REFERENCES `real_estate_ecm`.`transaction`.`financing`(`financing_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_offer_id` FOREIGN KEY (`offer_id`) REFERENCES `real_estate_ecm`.`transaction`.`offer`(`offer_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_purchase_agreement_id` FOREIGN KEY (`purchase_agreement_id`) REFERENCES `real_estate_ecm`.`transaction`.`purchase_agreement`(`purchase_agreement_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_reo_disposition_id` FOREIGN KEY (`reo_disposition_id`) REFERENCES `real_estate_ecm`.`transaction`.`reo_disposition`(`reo_disposition_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ADD CONSTRAINT `fk_transaction_transaction_deal_document_title_search_id` FOREIGN KEY (`title_search_id`) REFERENCES `real_estate_ecm`.`transaction`.`title_search`(`title_search_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ADD CONSTRAINT `fk_transaction_sale_attribution_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ADD CONSTRAINT `fk_transaction_auction_deal_party_id` FOREIGN KEY (`deal_party_id`) REFERENCES `real_estate_ecm`.`transaction`.`deal_party`(`deal_party_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ADD CONSTRAINT `fk_transaction_auction_property_sale_id` FOREIGN KEY (`property_sale_id`) REFERENCES `real_estate_ecm`.`transaction`.`property_sale`(`property_sale_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ADD CONSTRAINT `fk_transaction_auction_prior_auction_id` FOREIGN KEY (`prior_auction_id`) REFERENCES `real_estate_ecm`.`transaction`.`auction`(`auction_id`);
ALTER TABLE `real_estate_ecm`.`transaction`.`bulk_sale_pool` ADD CONSTRAINT `fk_transaction_bulk_sale_pool_parent_bulk_sale_pool_id` FOREIGN KEY (`parent_bulk_sale_pool_id`) REFERENCES `real_estate_ecm`.`transaction`.`bulk_sale_pool`(`bulk_sale_pool_id`);

-- ========= TAGS =========
ALTER SCHEMA `real_estate_ecm`.`transaction` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `real_estate_ecm`.`transaction` SET TAGS ('dbx_domain' = 'transaction');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` SET TAGS ('dbx_subdomain' = 'sale_execution');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `investment_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Deal Pipeline Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Investment Vehicle Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `noi_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Noi Statement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `ops_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Ops Inspection Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `proforma_id` SET TAGS ('dbx_business_glossary_term' = 'Proforma Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `sale_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `tenure_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tenure Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Manager Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `buyer_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `cap_rate` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Rate (CAP Rate)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `cap_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `contingency_removed` SET TAGS ('dbx_business_glossary_term' = 'Contingency Removed Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `contingency_type` SET TAGS ('dbx_business_glossary_term' = 'Contingency Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `contingency_type` SET TAGS ('dbx_value_regex' = 'financing|inspection|appraisal|title|environmental|none');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `contract_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `costar_comp_code` SET TAGS ('dbx_business_glossary_term' = 'CoStar Comparable Sale ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `deed_recorded_date` SET TAGS ('dbx_business_glossary_term' = 'Deed Recorded Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `deed_type` SET TAGS ('dbx_business_glossary_term' = 'Deed Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `deed_type` SET TAGS ('dbx_value_regex' = 'warranty|special_warranty|quitclaim|grant|bargain_sale');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `due_diligence_end_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence End Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `earnest_money_amount` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `earnest_money_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `earnest_money_due_date` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Due Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `earnest_money_received` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Received Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `escrow_company` SET TAGS ('dbx_business_glossary_term' = 'Escrow Company');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `exchange_deadline_date` SET TAGS ('dbx_business_glossary_term' = '1031 Exchange Deadline Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `expected_closing_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Closing Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `financing_type` SET TAGS ('dbx_business_glossary_term' = 'Financing Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `gla_sqft` SET TAGS ('dbx_business_glossary_term' = 'Gross Leasable Area (GLA) in Square Feet (SQF)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `is_1031_exchange` SET TAGS ('dbx_business_glossary_term' = '1031 Exchange Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `loan_amount` SET TAGS ('dbx_business_glossary_term' = 'Loan Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `loan_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value Ratio (LTV)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `mls_number` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `net_sale_price` SET TAGS ('dbx_business_glossary_term' = 'Net Sale Price');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `net_sale_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `noi_at_sale` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Income (NOI) at Sale');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `noi_at_sale` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `price_psf` SET TAGS ('dbx_business_glossary_term' = 'Price Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `price_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `purchase_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `recording_number` SET TAGS ('dbx_business_glossary_term' = 'Recording Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `seller_concessions_amount` SET TAGS ('dbx_business_glossary_term' = 'Seller Concessions Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `seller_concessions_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `title_company` SET TAGS ('dbx_business_glossary_term' = 'Title Company');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `transaction_notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^TXN-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|under_contract|closed|cancelled|on_hold|terminated');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `transfer_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Tax Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`property_sale` ALTER COLUMN `yardi_transaction_ref` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Transaction Reference');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` SET TAGS ('dbx_subdomain' = 'sale_execution');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `purchase_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Agreement ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `bpo_id` SET TAGS ('dbx_business_glossary_term' = 'Bpo Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `certificate_of_insurance_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Of Insurance Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `investment_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Deal Pipeline Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `sale_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `tenure_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tenure Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Offer Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `actual_closing_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closing Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Agreement Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'loi|under_contract|executed|terminated|expired|closed');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `appraisal_contingency_date` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Contingency Deadline');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `appraisal_contingency_flag` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Contingency Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `contingency_status` SET TAGS ('dbx_business_glossary_term' = 'Contingency Resolution Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `contingency_status` SET TAGS ('dbx_value_regex' = 'pending|waived|satisfied|exercised|expired');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `contract_price` SET TAGS ('dbx_business_glossary_term' = 'Contract Purchase Price');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `contract_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `down_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `down_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `due_diligence_end_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Period End Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `due_diligence_start_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Period Start Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `earnest_money_amount` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Deposit Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `earnest_money_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `earnest_money_due_date` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Due Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `earnest_money_received` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Received Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `environmental_contingency_date` SET TAGS ('dbx_business_glossary_term' = 'Environmental Contingency Deadline');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Execution Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Expiration Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `financing_contingency_date` SET TAGS ('dbx_business_glossary_term' = 'Financing Contingency Deadline');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `financing_contingency_flag` SET TAGS ('dbx_business_glossary_term' = 'Financing Contingency Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `inspection_contingency_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Contingency Deadline');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `inspection_contingency_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Contingency Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `is_1031_exchange` SET TAGS ('dbx_business_glossary_term' = '1031 Exchange Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `latest_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `loan_amount` SET TAGS ('dbx_business_glossary_term' = 'Loan Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `loan_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value Ratio (LTV)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `offer_price` SET TAGS ('dbx_business_glossary_term' = 'Offer Price');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `offer_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `price_psf` SET TAGS ('dbx_business_glossary_term' = 'Price Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `price_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `psa_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase and Sale Agreement (PSA) Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `psa_number` SET TAGS ('dbx_value_regex' = '^PSA-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `sale_of_home_contingency` SET TAGS ('dbx_business_glossary_term' = 'Sale of Existing Home Contingency Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `seller_concessions_amount` SET TAGS ('dbx_business_glossary_term' = 'Seller Concessions Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `seller_concessions_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `target_closing_date` SET TAGS ('dbx_business_glossary_term' = 'Target Closing Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `title_company_name` SET TAGS ('dbx_business_glossary_term' = 'Title Company Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`purchase_agreement` ALTER COLUMN `zoning_contingency_flag` SET TAGS ('dbx_business_glossary_term' = 'Zoning Contingency Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `closing_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `capital_call_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Call Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `financial_period_close_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Close Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `property_type_id` SET TAGS ('dbx_business_glossary_term' = 'Property Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `purchase_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `sale_type_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction Transaction Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `tax_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Tax Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `buyer_broker_commission` SET TAGS ('dbx_business_glossary_term' = 'Buyer Broker Commission');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `buyer_broker_commission` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `buyer_broker_commission` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `buyer_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Buyer Credit Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `buyer_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `buyer_credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `buyer_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Entity Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `buyer_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `cap_rate_at_closing` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Rate (CAP Rate) at Closing');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `cap_rate_at_closing` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `cash_to_close` SET TAGS ('dbx_business_glossary_term' = 'Cash to Close');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `cash_to_close` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `cash_to_close` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `closing_status` SET TAGS ('dbx_business_glossary_term' = 'Closing Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `closing_status` SET TAGS ('dbx_value_regex' = 'DRAFT|PENDING|EXECUTED|FUNDED|RECORDED|VOIDED');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `costar_property_code` SET TAGS ('dbx_business_glossary_term' = 'CoStar Property ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `earnest_money_deposit` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Deposit');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `earnest_money_deposit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `earnest_money_deposit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `escrow_number` SET TAGS ('dbx_business_glossary_term' = 'Escrow Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `gross_sale_price` SET TAGS ('dbx_business_glossary_term' = 'Gross Sale Price');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `gross_sale_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `gross_sale_price` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `is_1031_exchange` SET TAGS ('dbx_business_glossary_term' = '1031 Exchange Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `is_reo_transaction` SET TAGS ('dbx_business_glossary_term' = 'Real Estate Owned (REO) Transaction Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `listing_broker_commission` SET TAGS ('dbx_business_glossary_term' = 'Listing Broker Commission');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `listing_broker_commission` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `listing_broker_commission` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `loan_payoff_amount` SET TAGS ('dbx_business_glossary_term' = 'Loan Payoff Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `loan_payoff_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `loan_payoff_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value (LTV) Ratio');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `mls_number` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `net_proceeds_to_seller` SET TAGS ('dbx_business_glossary_term' = 'Net Proceeds to Seller');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `net_proceeds_to_seller` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `net_proceeds_to_seller` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `new_loan_amount` SET TAGS ('dbx_business_glossary_term' = 'New Loan Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `new_loan_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `new_loan_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement Notes');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `proration_amount` SET TAGS ('dbx_business_glossary_term' = 'Proration Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `proration_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `proration_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Deed Recording Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `recording_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Recording Fee Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `sale_price_psf` SET TAGS ('dbx_business_glossary_term' = 'Sale Price Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `sale_price_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `seller_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Seller Credit Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `seller_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `seller_credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `settlement_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Fee Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `statement_number` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `statement_type` SET TAGS ('dbx_value_regex' = 'HUD-1|ALTA_SETTLEMENT|ALTA_COMBINED|CASH_CLOSING|1031_EXCHANGE');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `title_company_name` SET TAGS ('dbx_business_glossary_term' = 'Title Company Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `title_insurance_premium` SET TAGS ('dbx_business_glossary_term' = 'Title Insurance Premium');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `title_insurance_premium` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `title_insurance_premium` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `total_commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Commission Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `total_commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `total_commission_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `transfer_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Tax Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `transfer_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `transfer_tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `closing_statement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement Line ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `closing_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `security_deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Security Deposit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `premium_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `buyer_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Buyer Credit Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `buyer_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `buyer_credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `buyer_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Buyer Debit Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `buyer_debit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `buyer_debit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `charge_category` SET TAGS ('dbx_business_glossary_term' = 'Charge Category');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `daily_rate` SET TAGS ('dbx_business_glossary_term' = 'Daily Proration Rate');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Debit Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `debit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `debit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `escrow_account_number` SET TAGS ('dbx_business_glossary_term' = 'Escrow Account Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `escrow_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `gl_account_name` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `gl_posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posted Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `is_1031_exchange_item` SET TAGS ('dbx_business_glossary_term' = 'Is 1031 Exchange Item Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `is_posted_to_gl` SET TAGS ('dbx_business_glossary_term' = 'Is Posted to General Ledger (GL) Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Is Taxable Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Line Item Description');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement Line Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|posted|voided');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement Line Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'charge|credit|proration|adjustment|deposit|escrow');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Line Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Item Notes');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `payee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `payee_type` SET TAGS ('dbx_business_glossary_term' = 'Payee Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `proration_days` SET TAGS ('dbx_business_glossary_term' = 'Proration Days');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `proration_end_date` SET TAGS ('dbx_business_glossary_term' = 'Proration End Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `proration_start_date` SET TAGS ('dbx_business_glossary_term' = 'Proration Start Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `responsible_party` SET TAGS ('dbx_value_regex' = 'buyer|seller|lender|both|third_party');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `section_code` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement Section Code');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `section_name` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement Section Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `seller_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Seller Credit Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `seller_credit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `seller_credit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `seller_debit_amount` SET TAGS ('dbx_business_glossary_term' = 'Seller Debit Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `seller_debit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `seller_debit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi|mri|argus|sap|manual|other');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `source_system_line_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Line Reference');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`closing_statement_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `title_search_id` SET TAGS ('dbx_business_glossary_term' = 'Title Search ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `construction_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Construction Permit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Entitlement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `purchase_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `tenure_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tenure Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `title_record_id` SET TAGS ('dbx_business_glossary_term' = 'Title Record Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `chain_of_title_years` SET TAGS ('dbx_business_glossary_term' = 'Chain of Title Search Period (Years)');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Title Commitment Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `commitment_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Title Commitment Expiry Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `coo_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Occupancy (COO) Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `coo_status` SET TAGS ('dbx_value_regex' = 'issued|not_required|pending|not_issued');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Title Insurance Coverage Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `coverage_currency` SET TAGS ('dbx_business_glossary_term' = 'Coverage Currency Code');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `coverage_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `deed_book_reference` SET TAGS ('dbx_business_glossary_term' = 'Deed Book and Page Reference');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `easement_count` SET TAGS ('dbx_business_glossary_term' = 'Easement Count');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Title Policy Effective Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `encumbrance_count` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Count');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `endorsements` SET TAGS ('dbx_business_glossary_term' = 'Title Policy Endorsements');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `environmental_lien_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Lien Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `exception_count` SET TAGS ('dbx_business_glossary_term' = 'Title Exception Count');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Title Exception Notes');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `existing_mortgage_amount` SET TAGS ('dbx_business_glossary_term' = 'Existing Mortgage Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `existing_mortgage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `hoa_lien_flag` SET TAGS ('dbx_business_glossary_term' = 'Homeowners Association (HOA) Lien Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `judgment_lien_amount` SET TAGS ('dbx_business_glossary_term' = 'Judgment Lien Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `judgment_lien_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Property Legal Description');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `lien_count` SET TAGS ('dbx_business_glossary_term' = 'Lien Count');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `lien_search_result` SET TAGS ('dbx_business_glossary_term' = 'Lien Search Result');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `lien_search_result` SET TAGS ('dbx_value_regex' = 'clear|liens_found|pending_review');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `mechanics_lien_amount` SET TAGS ('dbx_business_glossary_term' = 'Mechanics Lien Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `mechanics_lien_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `ordered_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Title Search Ordered Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `policy_type` SET TAGS ('dbx_business_glossary_term' = 'Title Insurance Policy Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `policy_type` SET TAGS ('dbx_value_regex' = 'owners_policy|loan_policy|leasehold_policy|simultaneous_issue');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Title Insurance Premium Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `recording_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Recording Jurisdiction');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `requirements_notes` SET TAGS ('dbx_business_glossary_term' = 'Title Commitment Requirements Notes');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `search_from_date` SET TAGS ('dbx_business_glossary_term' = 'Title Search From Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `search_order_number` SET TAGS ('dbx_business_glossary_term' = 'Title Search Order Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `search_status` SET TAGS ('dbx_business_glossary_term' = 'Title Search Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `search_status` SET TAGS ('dbx_value_regex' = 'ordered|in_progress|completed|commitment_issued|policy_issued|cancelled');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `search_through_date` SET TAGS ('dbx_business_glossary_term' = 'Title Search Through Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `search_type` SET TAGS ('dbx_business_glossary_term' = 'Title Search Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `search_type` SET TAGS ('dbx_value_regex' = 'full_search|update_search|bring_down|lien_search|judgment_search');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `snda_required` SET TAGS ('dbx_business_glossary_term' = 'Subordination Non-Disturbance and Attornment Agreement (SNDA) Required Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `survey_required` SET TAGS ('dbx_business_glossary_term' = 'Survey Required Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `tax_lien_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Lien Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `tax_lien_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `title_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Title Agent Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `title_examiner_name` SET TAGS ('dbx_business_glossary_term' = 'Title Examiner Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `vesting_type` SET TAGS ('dbx_business_glossary_term' = 'Title Vesting Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`title_search` ALTER COLUMN `vesting_type` SET TAGS ('dbx_value_regex' = 'fee_simple|leasehold|tenancy_in_common|joint_tenancy|community_property|trust');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `deed_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Deed Transfer ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `closing_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Grantor Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `tenure_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tenure Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `title_record_id` SET TAGS ('dbx_business_glossary_term' = 'Title Record Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `arms_length_flag` SET TAGS ('dbx_business_glossary_term' = 'Arms-Length Transaction Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `book_number` SET TAGS ('dbx_business_glossary_term' = 'Deed Book Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_business_glossary_term' = 'Consideration Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `consideration_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `costar_comp_code` SET TAGS ('dbx_business_glossary_term' = 'CoStar Comparable Sale ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `deed_type` SET TAGS ('dbx_business_glossary_term' = 'Deed Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `deed_type` SET TAGS ('dbx_value_regex' = 'warranty|special_warranty|quitclaim|trustee|grant|bargain_and_sale');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'County Recorder Document Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `earnest_money_amount` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Deposit Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `earnest_money_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `earnest_money_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `exchange_1031_flag` SET TAGS ('dbx_business_glossary_term' = '1031 Exchange Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Deed Execution Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `foreclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Foreclosure Transfer Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `grantee_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Grantee Entity Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `grantee_name` SET TAGS ('dbx_business_glossary_term' = 'Grantee Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `grantee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `grantee_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `grantor_entity_type` SET TAGS ('dbx_business_glossary_term' = 'Grantor Entity Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `instrument_number` SET TAGS ('dbx_business_glossary_term' = 'Instrument Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value Ratio (LTV)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `mls_transaction_code` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Transaction ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `mortgage_amount` SET TAGS ('dbx_business_glossary_term' = 'Mortgage Loan Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `mortgage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `mortgage_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `notary_commission_expiry` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Expiry Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `notary_name` SET TAGS ('dbx_business_glossary_term' = 'Notary Public Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `page_number` SET TAGS ('dbx_business_glossary_term' = 'Deed Page Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `price_per_sqf` SET TAGS ('dbx_business_glossary_term' = 'Price Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Recording Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `recording_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Recording Fee Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `recording_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Recording Jurisdiction');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `reo_flag` SET TAGS ('dbx_business_glossary_term' = 'Real Estate Owned (REO) Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'yardi|mri|argus|costar|manual|other');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `title_company_name` SET TAGS ('dbx_business_glossary_term' = 'Title Company Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Deed Transfer Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_value_regex' = 'pending|recorded|rejected|voided|under_review');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `transfer_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Tax Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `transfer_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `transfer_tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `vesting_type` SET TAGS ('dbx_business_glossary_term' = 'Vesting Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`deed_transfer` ALTER COLUMN `vesting_type` SET TAGS ('dbx_value_regex' = 'sole_ownership|joint_tenancy|tenancy_in_common|community_property|trust|entity');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `financing_id` SET TAGS ('dbx_business_glossary_term' = 'Financing Identifier');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Borrower Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `debt_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Facility Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `debt_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Instrument ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `endorsement_id` SET TAGS ('dbx_business_glossary_term' = 'Endorsement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `ground_lease_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Lease Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Investment Vehicle Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Capex Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `purchase_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `tenure_type_id` SET TAGS ('dbx_business_glossary_term' = 'Tenure Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `amortization_period_months` SET TAGS ('dbx_business_glossary_term' = 'Amortization Period (Months)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `amortization_type` SET TAGS ('dbx_business_glossary_term' = 'Amortization Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `amortization_type` SET TAGS ('dbx_value_regex' = 'fully_amortizing|interest_only|partial_io|balloon');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `annual_debt_service` SET TAGS ('dbx_business_glossary_term' = 'Annual Debt Service Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `collateral_description` SET TAGS ('dbx_business_glossary_term' = 'Collateral Description');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Commitment Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `dscr` SET TAGS ('dbx_business_glossary_term' = 'Debt Service Coverage Ratio (DSCR)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `escrow_required` SET TAGS ('dbx_business_glossary_term' = 'Escrow Required Indicator');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `escrow_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Escrow Reserve Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `extension_option_count` SET TAGS ('dbx_business_glossary_term' = 'Extension Option Count');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `extension_period_months` SET TAGS ('dbx_business_glossary_term' = 'Extension Period (Months)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `financing_status` SET TAGS ('dbx_business_glossary_term' = 'Financing Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `financing_status` SET TAGS ('dbx_value_regex' = 'pending|committed|funded|assumed|paid_off|cancelled');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `first_payment_date` SET TAGS ('dbx_business_glossary_term' = 'First Payment Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `funding_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Funding Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `index_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Index Rate Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `index_rate_type` SET TAGS ('dbx_value_regex' = 'SOFR|LIBOR|Prime|Treasury|EURIBOR|SONIA');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `interest_only_period_months` SET TAGS ('dbx_business_glossary_term' = 'Interest-Only (IO) Period (Months)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `is_assumption` SET TAGS ('dbx_business_glossary_term' = 'Debt Assumption Indicator');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `lender_name` SET TAGS ('dbx_business_glossary_term' = 'Lender Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `lien_position` SET TAGS ('dbx_business_glossary_term' = 'Lien Position');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `lien_position` SET TAGS ('dbx_value_regex' = 'first|second|mezzanine|subordinate');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `loan_amount` SET TAGS ('dbx_business_glossary_term' = 'Loan Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `loan_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `loan_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `loan_number` SET TAGS ('dbx_business_glossary_term' = 'Loan Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `loan_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `loan_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `loan_term_months` SET TAGS ('dbx_business_glossary_term' = 'Loan Term (Months)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `loan_to_cost_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Cost Ratio (LTC)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `loan_type` SET TAGS ('dbx_business_glossary_term' = 'Loan Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value Ratio (LTV)');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `maturity_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Maturity Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `origination_date` SET TAGS ('dbx_business_glossary_term' = 'Loan Origination Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `origination_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Origination Fee Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `origination_fee_pct` SET TAGS ('dbx_business_glossary_term' = 'Origination Fee Percentage');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Loan Balance');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `outstanding_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `pmi_monthly_amount` SET TAGS ('dbx_business_glossary_term' = 'Private Mortgage Insurance (PMI) Monthly Premium Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `pmi_required` SET TAGS ('dbx_business_glossary_term' = 'Private Mortgage Insurance (PMI) Required Indicator');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `prepayment_penalty_type` SET TAGS ('dbx_business_glossary_term' = 'Prepayment Penalty Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `prepayment_penalty_type` SET TAGS ('dbx_value_regex' = 'none|step_down|yield_maintenance|defeasance|lockout');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Financing Purpose');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `purpose` SET TAGS ('dbx_value_regex' = 'acquisition|refinance|construction|assumption|bridge|equity_recapture');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `rate_spread` SET TAGS ('dbx_business_glossary_term' = 'Rate Spread Over Index');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'fixed|floating|hybrid');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `recourse_type` SET TAGS ('dbx_business_glossary_term' = 'Recourse Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `recourse_type` SET TAGS ('dbx_value_regex' = 'full_recourse|non_recourse|partial_recourse');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `servicer_name` SET TAGS ('dbx_business_glossary_term' = 'Loan Servicer Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`financing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `exchange_1031_id` SET TAGS ('dbx_business_glossary_term' = 'IRS Section 1031 Like-Kind Exchange ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange Coordinator Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Taxpayer / Exchangor Party ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Relinquished Property ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Relinquished Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `boot_amount` SET TAGS ('dbx_business_glossary_term' = 'Boot Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `boot_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `boot_type` SET TAGS ('dbx_business_glossary_term' = 'Boot Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `boot_type` SET TAGS ('dbx_value_regex' = 'none|cash|mortgage_relief|mixed');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `deferred_gain` SET TAGS ('dbx_business_glossary_term' = 'Deferred Gain');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `deferred_gain` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `exchange_agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Agreement Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `exchange_closing_deadline` SET TAGS ('dbx_business_glossary_term' = '180-Day Exchange Closing Deadline');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `exchange_number` SET TAGS ('dbx_business_glossary_term' = 'Exchange Reference Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `exchange_status` SET TAGS ('dbx_business_glossary_term' = 'Exchange Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `exchange_status` SET TAGS ('dbx_value_regex' = 'initiated|identification_period|replacement_pending|completed|failed|cancelled');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `exchange_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `exchange_type` SET TAGS ('dbx_value_regex' = 'simultaneous|delayed|reverse|improvement');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `form_8824_filed` SET TAGS ('dbx_business_glossary_term' = 'IRS Form 8824 Filed Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `form_8824_filed_date` SET TAGS ('dbx_business_glossary_term' = 'IRS Form 8824 Filed Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `identification_deadline` SET TAGS ('dbx_business_glossary_term' = '45-Day Identification Deadline');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `identification_rule` SET TAGS ('dbx_business_glossary_term' = 'Replacement Property Identification Rule');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `identification_rule` SET TAGS ('dbx_value_regex' = 'three_property|two_hundred_percent|ninety_five_percent');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Exchange Initiation Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `irs_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'IRS Compliance Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `irs_compliance_status` SET TAGS ('dbx_value_regex' = 'pending|compliant|non_compliant|under_review');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `like_kind_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Like-Kind Property Confirmation Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Exchange Notes');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `qi_account_number` SET TAGS ('dbx_business_glossary_term' = 'Qualified Intermediary (QI) Escrow Account Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `qi_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `qi_fund_balance` SET TAGS ('dbx_business_glossary_term' = 'Qualified Intermediary (QI) Exchange Fund Balance');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `qi_fund_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `qi_name` SET TAGS ('dbx_business_glossary_term' = 'Qualified Intermediary (QI) Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `realized_gain` SET TAGS ('dbx_business_glossary_term' = 'Realized Gain');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `realized_gain` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `recognized_gain` SET TAGS ('dbx_business_glossary_term' = 'Recognized Gain');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `recognized_gain` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `relinquished_adjusted_basis` SET TAGS ('dbx_business_glossary_term' = 'Relinquished Property Adjusted Tax Basis');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `relinquished_adjusted_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `relinquished_closing_date` SET TAGS ('dbx_business_glossary_term' = 'Relinquished Property Closing Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `relinquished_mortgage_balance` SET TAGS ('dbx_business_glossary_term' = 'Relinquished Property Mortgage Balance');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `relinquished_mortgage_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `relinquished_property_address` SET TAGS ('dbx_business_glossary_term' = 'Relinquished Property Address');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `relinquished_property_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `relinquished_property_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `relinquished_sale_price` SET TAGS ('dbx_business_glossary_term' = 'Relinquished Property Sale Price');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `relinquished_sale_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `replacement_basis` SET TAGS ('dbx_business_glossary_term' = 'Replacement Property Adjusted Tax Basis');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `replacement_basis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `replacement_closing_date` SET TAGS ('dbx_business_glossary_term' = 'Replacement Property Closing Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `replacement_mortgage_balance` SET TAGS ('dbx_business_glossary_term' = 'Replacement Property Mortgage Balance');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `replacement_mortgage_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `replacement_property_address` SET TAGS ('dbx_business_glossary_term' = 'Replacement Property Address');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `replacement_property_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `replacement_property_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `replacement_property_count` SET TAGS ('dbx_business_glossary_term' = 'Replacement Property Count');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `replacement_purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Replacement Property Purchase Price');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `replacement_purchase_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `selling_expenses` SET TAGS ('dbx_business_glossary_term' = 'Relinquished Property Selling Expenses');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `selling_expenses` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `taxpayer_ein` SET TAGS ('dbx_business_glossary_term' = 'Taxpayer Employer Identification Number (EIN)');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `taxpayer_ein` SET TAGS ('dbx_value_regex' = '^d{2}-d{7}$');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `taxpayer_ein` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `taxpayer_ein` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`exchange_1031` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` SET TAGS ('dbx_subdomain' = 'sale_execution');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `reo_disposition_id` SET TAGS ('dbx_business_glossary_term' = 'Real Estate Owned (REO) Disposition ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `auction_id` SET TAGS ('dbx_business_glossary_term' = 'Auction Event ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `bpo_id` SET TAGS ('dbx_business_glossary_term' = 'Bpo Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `bulk_sale_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Bulk Sale Pool ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `claim_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `debt_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Debt Facility Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `dev_project_id` SET TAGS ('dbx_business_glossary_term' = 'Dev Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Manager (AM) ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Lender / Servicer ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Capex Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `market_segment_id` SET TAGS ('dbx_business_glossary_term' = 'Market Segment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `ops_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Ops Inspection Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `portfolio_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Property Inspection Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `property_type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `actual_repair_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Repair Cost');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `actual_repair_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `as_is_appraised_value` SET TAGS ('dbx_business_glossary_term' = 'As-Is Appraised Value');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `as_is_appraised_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `carrying_costs` SET TAGS ('dbx_business_glossary_term' = 'REO Carrying Costs');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `carrying_costs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'REO Closing Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'As-Is Condition Rating');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|uninhabitable');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `contract_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `days_on_market` SET TAGS ('dbx_business_glossary_term' = 'Days on Market (DOM)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `disposition_costs` SET TAGS ('dbx_business_glossary_term' = 'REO Disposition Costs');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `disposition_costs` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `disposition_method` SET TAGS ('dbx_business_glossary_term' = 'REO Disposition Method');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `disposition_method` SET TAGS ('dbx_value_regex' = 'mls_listing|auction|bulk_sale|direct_sale|short_sale');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `disposition_number` SET TAGS ('dbx_business_glossary_term' = 'REO Disposition Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `disposition_number` SET TAGS ('dbx_value_regex' = '^REO-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'REO Disposition Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'active|under_contract|sold|withdrawn|cancelled');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `environmental_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Issue Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `final_sale_price` SET TAGS ('dbx_business_glossary_term' = 'Final Sale Price');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `final_sale_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `foreclosure_date` SET TAGS ('dbx_business_glossary_term' = 'Foreclosure Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `hoa_flag` SET TAGS ('dbx_business_glossary_term' = 'Homeowners Association (HOA) Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `lender_name` SET TAGS ('dbx_business_glossary_term' = 'Lender / Servicer Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `list_date` SET TAGS ('dbx_business_glossary_term' = 'REO List Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'REO List Price');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `list_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `loan_number` SET TAGS ('dbx_business_glossary_term' = 'Original Loan Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `loan_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `loan_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `loss_severity_amount` SET TAGS ('dbx_business_glossary_term' = 'Loss Severity Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `loss_severity_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `loss_severity_pct` SET TAGS ('dbx_business_glossary_term' = 'Loss Severity Percentage');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `loss_severity_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `ltv_ratio_at_origination` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value Ratio (LTV) at Origination');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `ltv_ratio_at_origination` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `net_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Recovery Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `net_recovery_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `outstanding_loan_balance` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Loan Balance (UPB)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `outstanding_loan_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `outstanding_loan_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `price_reduction_count` SET TAGS ('dbx_business_glossary_term' = 'Price Reduction Count');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `reo_acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'REO Acquisition Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `repair_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Repair Cost Estimate (CAPEX)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `repair_cost_estimate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `sale_price_psf` SET TAGS ('dbx_business_glossary_term' = 'Sale Price Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `sale_price_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `title_cleared` SET TAGS ('dbx_business_glossary_term' = 'Title Cleared Indicator');
ALTER TABLE `real_estate_ecm`.`transaction`.`reo_disposition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `due_diligence_item_id` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Item ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `building_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Building Asset Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Permit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `investment_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Investment Deal Pipeline Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `lease_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `clause_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Clause Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `loss_run_id` SET TAGS ('dbx_business_glossary_term' = 'Loss Run Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Capex Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `ops_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Ops Inspection Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Property Inspection Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `purchase_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `regulatory_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Obligation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Due Diligence Cost');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Item Completion Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `contingency_removal_date` SET TAGS ('dbx_business_glossary_term' = 'PSA Contingency Removal Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `contingency_removed` SET TAGS ('dbx_business_glossary_term' = 'PSA Contingency Removed Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Item Due Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Due Diligence Cost');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Remediation Cost');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `finding_summary` SET TAGS ('dbx_business_glossary_term' = 'Finding Summary');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `go_no_go_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Go / No-Go Recommendation');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `go_no_go_recommendation` SET TAGS ('dbx_value_regex' = 'go|no_go|conditional_go|pending');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `investment_committee_flag` SET TAGS ('dbx_business_glossary_term' = 'Investment Committee Escalation Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Item Category');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Item Description');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `item_name` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Item Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `item_number` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Item Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `item_number` SET TAGS ('dbx_value_regex' = '^DD-[0-9]{4}-[0-9]{5}$');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `item_status` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Item Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `item_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|pending_review|completed|waived|escalated');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Item Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `leed_breeam_status` SET TAGS ('dbx_business_glossary_term' = 'Leadership in Energy and Environmental Design (LEED) / Building Research Establishment Environmental Assessment Method (BREEAM) Certification Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `phase_ii_required` SET TAGS ('dbx_business_glossary_term' = 'Phase II Environmental Site Assessment (ESA) Required Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `price_adjustment_recommended` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price Adjustment Recommended Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `psa_contingency_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase and Sale Agreement (PSA) Contingency Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `recognized_environmental_condition` SET TAGS ('dbx_business_glossary_term' = 'Recognized Environmental Condition (REC) Classification');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `recognized_environmental_condition` SET TAGS ('dbx_value_regex' = 'none|rec|crec|hrec');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `recommended_price_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Recommended Purchase Price Adjustment Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `recommended_price_adjustment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `remediation_description` SET TAGS ('dbx_business_glossary_term' = 'Remediation Description');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `remediation_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Report Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `responsible_party_type` SET TAGS ('dbx_value_regex' = 'internal|external_vendor|legal_counsel|title_company|lender|broker');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'green|yellow|red|unrated');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `source_system_ref` SET TAGS ('dbx_business_glossary_term' = 'Source System Reference');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `title_exception_count` SET TAGS ('dbx_business_glossary_term' = 'Title Exception Count');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `vendor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `vendor_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Report Reference Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`due_diligence_item` ALTER COLUMN `zoning_compliance_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Zoning Compliance Confirmed Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `deal_party_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Party Identifier');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `brokerage_broker_id` SET TAGS ('dbx_business_glossary_term' = 'Broker Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `closing_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `corporate_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Party Reference ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `investor_id` SET TAGS ('dbx_business_glossary_term' = 'Investor Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `purchase_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `commission_split_pct` SET TAGS ('dbx_business_glossary_term' = 'Commission Split Percentage');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `commission_split_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `entity_type` SET TAGS ('dbx_business_glossary_term' = 'Entity Classification Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `entity_type` SET TAGS ('dbx_value_regex' = 'individual|corporation|REIT|trust|partnership|LLC');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `escrow_account_number` SET TAGS ('dbx_business_glossary_term' = 'Escrow Account Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `escrow_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `firpta_withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'FIRPTA Withholding Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `firpta_withholding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `is_1099s_reportable` SET TAGS ('dbx_business_glossary_term' = '1099-S Reportable Indicator');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `is_foreign_person` SET TAGS ('dbx_business_glossary_term' = 'Foreign Person Indicator (FIRPTA)');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `is_primary_party` SET TAGS ('dbx_business_glossary_term' = 'Primary Party Indicator');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `lender_loan_number` SET TAGS ('dbx_business_glossary_term' = 'Lender Loan Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `lender_loan_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `loan_type` SET TAGS ('dbx_business_glossary_term' = 'Loan Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `mailing_address` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `mailing_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `mailing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Party Notes');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `participation_status` SET TAGS ('dbx_value_regex' = 'active|withdrawn|pending|confirmed|declined');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `party_email` SET TAGS ('dbx_business_glossary_term' = 'Party Email Address');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `party_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `party_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `party_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `party_name` SET TAGS ('dbx_business_glossary_term' = 'Party Legal Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `party_phone` SET TAGS ('dbx_business_glossary_term' = 'Party Phone Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `party_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `party_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `party_role` SET TAGS ('dbx_business_glossary_term' = 'Party Role');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `proceeds_amount` SET TAGS ('dbx_business_glossary_term' = 'Proceeds Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `proceeds_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `qi_exchange_ref` SET TAGS ('dbx_business_glossary_term' = 'Qualified Intermediary (QI) Exchange Reference');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `representation_type` SET TAGS ('dbx_business_glossary_term' = 'Representation Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `representation_type` SET TAGS ('dbx_value_regex' = 'exclusive|non-exclusive|dual_agency|transaction_broker');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `salesforce_contact_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce CRM Contact ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `signing_authority` SET TAGS ('dbx_business_glossary_term' = 'Signing Authority');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `signing_authority` SET TAGS ('dbx_value_regex' = 'authorized_signatory|power_of_attorney|trustee|managing_member|officer');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_value_regex' = 'SSN|EIN|ITIN|foreign_tin');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `tax_id_type` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`deal_party` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` SET TAGS ('dbx_subdomain' = 'sale_execution');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Identifier');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `buyer_representation_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Representation Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `listing_id` SET TAGS ('dbx_business_glossary_term' = 'Listing ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `parent_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Offer ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Property Sale Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Acceptance Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `appraisal_contingency_flag` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Contingency Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `buyer_agent_license_number` SET TAGS ('dbx_business_glossary_term' = 'Buyer Agent License Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `buyer_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Agent Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `competing_offer_count` SET TAGS ('dbx_business_glossary_term' = 'Competing Offer Count');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `competing_offer_flag` SET TAGS ('dbx_business_glossary_term' = 'Competing Offer Indicator');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `counter_offer_number` SET TAGS ('dbx_business_glossary_term' = 'Counter Offer Round Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `due_diligence_period_days` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Period (Days)');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `earnest_money_amount` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Deposit Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `earnest_money_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `earnest_money_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `earnest_money_due_date` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Due Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `escalation_ceiling_price` SET TAGS ('dbx_business_glossary_term' = 'Escalation Ceiling Price');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `escalation_ceiling_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `escalation_ceiling_price` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `escalation_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Clause Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `escalation_increment_amount` SET TAGS ('dbx_business_glossary_term' = 'Escalation Increment Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `escalation_increment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `escalation_increment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Expiry Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `financing_contingency_amount` SET TAGS ('dbx_business_glossary_term' = 'Financing Contingency Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `financing_contingency_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `financing_contingency_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `financing_type` SET TAGS ('dbx_business_glossary_term' = 'Financing Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `financing_type` SET TAGS ('dbx_value_regex' = 'cash|conventional|fha|va|arm|other');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `inspection_contingency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Contingency Period (Days)');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `inspection_contingency_end_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Contingency End Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `is_1031_exchange` SET TAGS ('dbx_business_glossary_term' = '1031 Exchange Indicator');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `ltv_ratio` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value Ratio (LTV)');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Offer Notes');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `offer_number` SET TAGS ('dbx_business_glossary_term' = 'Offer Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `offer_number` SET TAGS ('dbx_value_regex' = '^OFF-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'submitted|countered|accepted|rejected|withdrawn');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `pre_approval_amount` SET TAGS ('dbx_business_glossary_term' = 'Mortgage Pre-Approval Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `pre_approval_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `pre_approval_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Offer Price');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `price` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `price_psf` SET TAGS ('dbx_business_glossary_term' = 'Offer Price Per Square Foot (PSF)');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `price_psf` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `price_psf` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `proof_of_funds_verified` SET TAGS ('dbx_business_glossary_term' = 'Proof of Funds Verified Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `proposed_closing_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Closing Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Offer Rejection Reason');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_value_regex' = 'price_too_low|competing_offer_accepted|contingencies|financing_concerns|buyer_withdrew|other');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `sale_contingency_flag` SET TAGS ('dbx_business_glossary_term' = 'Sale Contingency Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `salesforce_opportunity_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `seller_concessions_amount` SET TAGS ('dbx_business_glossary_term' = 'Seller Concessions Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `seller_concessions_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `seller_concessions_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`offer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `escrow_account_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Account ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `capital_call_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Call Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `closing_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Escrow Account Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Escrow Account Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'open|pending_close|closed|suspended|cancelled');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Escrow Account Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'purchase|impound|reserve|1031_exchange|construction|other');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `actual_closing_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Escrow Closing Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `commission_amount` SET TAGS ('dbx_business_glossary_term' = 'Brokerage Commission Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `commission_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `commission_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Escrow Current Balance');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `earnest_money_amount` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Deposit Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `earnest_money_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `earnest_money_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `earnest_money_received_date` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Received Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `earnest_money_status` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `earnest_money_status` SET TAGS ('dbx_value_regex' = 'pending|received|applied|refunded|forfeited');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `escrow_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Escrow Holder Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `escrow_officer_email` SET TAGS ('dbx_business_glossary_term' = 'Escrow Officer Email Address');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `escrow_officer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `escrow_officer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `escrow_officer_email` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `escrow_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Escrow Officer Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `escrow_officer_phone` SET TAGS ('dbx_business_glossary_term' = 'Escrow Officer Phone Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `escrow_officer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `escrow_officer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `exchange_deadline_date` SET TAGS ('dbx_business_glossary_term' = '1031 Exchange Deadline Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `expected_closing_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Escrow Closing Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `impound_insurance_amount` SET TAGS ('dbx_business_glossary_term' = 'Impound Insurance Reserve Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `impound_insurance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `impound_insurance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `impound_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Impound Tax Reserve Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `impound_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `impound_tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `is_1031_exchange` SET TAGS ('dbx_business_glossary_term' = '1031 Exchange Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `last_reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reconciliation Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `loan_payoff_amount` SET TAGS ('dbx_business_glossary_term' = 'Loan Payoff Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `loan_payoff_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `loan_payoff_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `net_proceeds_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Proceeds Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `net_proceeds_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `net_proceeds_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Escrow Account Notes');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `opening_balance` SET TAGS ('dbx_business_glossary_term' = 'Escrow Opening Balance');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `opening_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `opening_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Escrow Opening Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `purchase_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `purchase_price` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `qualified_intermediary_name` SET TAGS ('dbx_business_glossary_term' = 'Qualified Intermediary (QI) Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'reconciled|unreconciled|in_progress|exception');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `release_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Release Authorization Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `release_authorization_status` SET TAGS ('dbx_value_regex' = 'pending|authorized|partially_authorized|rejected');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `release_conditions` SET TAGS ('dbx_business_glossary_term' = 'Escrow Release Conditions');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `title_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Title Fee Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `title_fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `title_fee_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `total_deposits` SET TAGS ('dbx_business_glossary_term' = 'Total Escrow Deposits');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `total_deposits` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `total_deposits` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `total_disbursements` SET TAGS ('dbx_business_glossary_term' = 'Total Escrow Disbursements');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `total_disbursements` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `total_disbursements` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `transfer_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Tax Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `transfer_tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `transfer_tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_account` ALTER COLUMN `yardi_trust_account_ref` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Trust Account Reference');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `escrow_disbursement_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Disbursement ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Payment Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Employee Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `closing_statement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement Line Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `commission_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `currency_code_id` SET TAGS ('dbx_business_glossary_term' = 'Currency Code Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `escrow_account_id` SET TAGS ('dbx_business_glossary_term' = 'Escrow Account ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Capex Project Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `owner_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `premium_id` SET TAGS ('dbx_business_glossary_term' = 'Premium Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `bank_account_number_masked` SET TAGS ('dbx_business_glossary_term' = 'Payee Bank Account Number (Masked)');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `bank_account_number_masked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `bank_account_number_masked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Payee Bank Routing Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `commission_basis_amount` SET TAGS ('dbx_business_glossary_term' = 'Commission Basis Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `commission_basis_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `commission_basis_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `commission_rate` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `disbursement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `disbursement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `disbursement_notes` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Notes');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `disbursement_number` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Reference Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `disbursement_status` SET TAGS ('dbx_value_regex' = 'pending|authorized|disbursed|voided|returned|on_hold');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `disbursement_type` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `escrow_officer_name` SET TAGS ('dbx_business_glossary_term' = 'Escrow Officer Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `holdback_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Holdback Release Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `is_1031_exchange_proceeds` SET TAGS ('dbx_business_glossary_term' = '1031 Exchange Proceeds Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `is_post_closing` SET TAGS ('dbx_business_glossary_term' = 'Post-Closing Disbursement Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `loan_payoff_lender_name` SET TAGS ('dbx_business_glossary_term' = 'Loan Payoff Lender Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `loan_payoff_reference` SET TAGS ('dbx_business_glossary_term' = 'Loan Payoff Reference Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Disbursement Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `net_disbursement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `payee_name` SET TAGS ('dbx_business_glossary_term' = 'Payee Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `payee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `payee_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `payee_tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Payee Tax Identification Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `payee_tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `payee_tax_identification_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `payee_type` SET TAGS ('dbx_business_glossary_term' = 'Payee Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|check|ach|cashiers_check|zelle|other');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `qualified_intermediary_name` SET TAGS ('dbx_business_glossary_term' = 'Qualified Intermediary (QI) Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `title_company_name` SET TAGS ('dbx_business_glossary_term' = 'Title Company Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `transfer_tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Transfer Tax Jurisdiction');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `withholding_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`escrow_disbursement` ALTER COLUMN `yardi_disbursement_ref` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Disbursement Reference');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` SET TAGS ('dbx_subdomain' = 'settlement_processing');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `transaction_deal_document_id` SET TAGS ('dbx_business_glossary_term' = 'Deal Document Identifier');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `appraisal_report_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Report Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `brokerage_deal_id` SET TAGS ('dbx_business_glossary_term' = 'Deal ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `closing_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Closing Statement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `deed_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Deed Transfer Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Related Document ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `document_type_id` SET TAGS ('dbx_business_glossary_term' = 'Document Type Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `due_diligence_item_id` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Item Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `exchange_1031_id` SET TAGS ('dbx_business_glossary_term' = 'Exchange 1031 Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `financing_id` SET TAGS ('dbx_business_glossary_term' = 'Financing Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `offer_id` SET TAGS ('dbx_business_glossary_term' = 'Offer Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Transaction ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `purchase_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Agreement Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `reo_disposition_id` SET TAGS ('dbx_business_glossary_term' = 'Reo Disposition Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `title_search_id` SET TAGS ('dbx_business_glossary_term' = 'Title Search Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `access_restricted` SET TAGS ('dbx_business_glossary_term' = 'Access Restricted Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Document Confidentiality Level');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `document_name` SET TAGS ('dbx_business_glossary_term' = 'Document Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'Draft|Pending Signature|Executed|Superseded|Voided|Expired');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `docusign_envelope_code` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `docusign_status` SET TAGS ('dbx_business_glossary_term' = 'DocuSign Envelope Status');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `docusign_status` SET TAGS ('dbx_value_regex' = 'Sent|Delivered|Completed|Declined|Voided|Expired');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Document Effective Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `execution_date` SET TAGS ('dbx_business_glossary_term' = 'Document Execution Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Document Expiration Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'Document File Format');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'PDF|DOCX|XLSX|TIFF|MSG|ZIP');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'Document File Size (KB)');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `notarized` SET TAGS ('dbx_business_glossary_term' = 'Notarized Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `notary_commission_expiry` SET TAGS ('dbx_business_glossary_term' = 'Notary Commission Expiry Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `notary_name` SET TAGS ('dbx_business_glossary_term' = 'Notary Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Document Page Count');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `prepared_by` SET TAGS ('dbx_business_glossary_term' = 'Prepared By');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `primary_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Signatory Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `primary_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `primary_signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Document Received Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `recorded_date` SET TAGS ('dbx_business_glossary_term' = 'Document Recorded Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `recording_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Recording Jurisdiction');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `recording_number` SET TAGS ('dbx_business_glossary_term' = 'Recording Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `recording_required` SET TAGS ('dbx_business_glossary_term' = 'Recording Required Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Document Review Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `secondary_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Secondary Signatory Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `secondary_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `secondary_signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `signatory_party_type` SET TAGS ('dbx_business_glossary_term' = 'Signatory Party Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'DocuSign CLM|Yardi Voyager|MRI Software|Procore|SAP S/4HANA|Manual Upload');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `source_system_doc_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Document ID');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `storage_path` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Path');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `storage_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`transaction_deal_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Document Version Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` SET TAGS ('dbx_subdomain' = 'sale_execution');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `sale_type_id` SET TAGS ('dbx_business_glossary_term' = 'Sale Type Identifier');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `regulatory_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework Id (Foreign Key)');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `appraisal_required` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Required Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `argus_transaction_type_code` SET TAGS ('dbx_business_glossary_term' = 'Argus Enterprise Transaction Type Code');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `cap_rate_applicable` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Rate (CAP Rate) Applicable Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `costar_transaction_type_code` SET TAGS ('dbx_business_glossary_term' = 'CoStar Transaction Type Code');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `deal_direction` SET TAGS ('dbx_business_glossary_term' = 'Deal Direction');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `deal_direction` SET TAGS ('dbx_value_regex' = 'acquisition|disposition|neutral');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `deal_workflow_template_code` SET TAGS ('dbx_business_glossary_term' = 'Deal Workflow Template Code');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `deal_workflow_template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,40}$');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `deed_type_default` SET TAGS ('dbx_business_glossary_term' = 'Default Deed Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `deed_type_default` SET TAGS ('dbx_value_regex' = 'warranty|special_warranty|quitclaim|trustee|sheriff|none');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `earnest_money_required` SET TAGS ('dbx_business_glossary_term' = 'Earnest Money Required Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `environmental_review_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Review Required Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `esg_disclosure_required` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social and Governance (ESG) Disclosure Required Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `financing_eligible` SET TAGS ('dbx_business_glossary_term' = 'Financing Eligible Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `is_distressed_sale` SET TAGS ('dbx_business_glossary_term' = 'Is Distressed Sale Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `is_exchange_type` SET TAGS ('dbx_business_glossary_term' = 'Is 1031 Exchange Type Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `is_ground_lease_assignment` SET TAGS ('dbx_business_glossary_term' = 'Is Ground Lease Assignment Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `is_leaseback_involved` SET TAGS ('dbx_business_glossary_term' = 'Is Sale-Leaseback Involved Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `is_portfolio_transaction` SET TAGS ('dbx_business_glossary_term' = 'Is Portfolio Transaction Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `ltv_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Loan-to-Value (LTV) Ratio Tracking Required Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `mls_reportable` SET TAGS ('dbx_business_glossary_term' = 'Multiple Listing Service (MLS) Reportable Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `noi_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Net Operating Income (NOI) Tracking Required Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Administrative Notes');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `psf_pricing_applicable` SET TAGS ('dbx_business_glossary_term' = 'Per Square Foot (PSF) Pricing Applicable Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `required_due_diligence_items` SET TAGS ('dbx_business_glossary_term' = 'Required Due Diligence Items');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Display Sort Order');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `title_policy_type_required` SET TAGS ('dbx_business_glossary_term' = 'Required Title Policy Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `title_policy_type_required` SET TAGS ('dbx_value_regex' = 'owner|lender|both|none');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `transaction_category` SET TAGS ('dbx_business_glossary_term' = 'Transaction Category');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `transaction_category` SET TAGS ('dbx_value_regex' = 'commercial|residential|land|mixed_use|portfolio');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `transfer_tax_applicable` SET TAGS ('dbx_business_glossary_term' = 'Transfer Tax Applicable Flag');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Sale Type Code');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `type_description` SET TAGS ('dbx_business_glossary_term' = 'Sale Type Description');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `type_name` SET TAGS ('dbx_business_glossary_term' = 'Sale Type Display Name');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `typical_closing_days` SET TAGS ('dbx_business_glossary_term' = 'Typical Closing Period (Days)');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `typical_due_diligence_days` SET TAGS ('dbx_business_glossary_term' = 'Typical Due Diligence Period (Days)');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_type` ALTER COLUMN `yardi_transaction_type_code` SET TAGS ('dbx_business_glossary_term' = 'Yardi Voyager Transaction Type Code');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` SET TAGS ('dbx_subdomain' = 'sale_execution');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` SET TAGS ('dbx_association_edges' = 'transaction.property_sale,marketing.campaign');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ALTER COLUMN `sale_attribution_id` SET TAGS ('dbx_business_glossary_term' = 'Sale Attribution Identifier');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Sale Attribution - Campaign Id');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ALTER COLUMN `lead_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Identifier');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ALTER COLUMN `property_sale_id` SET TAGS ('dbx_business_glossary_term' = 'Sale Attribution - Property Sale Id');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ALTER COLUMN `attributed_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Attributed Revenue Amount');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ALTER COLUMN `attribution_confidence_score` SET TAGS ('dbx_business_glossary_term' = 'Attribution Confidence Score');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ALTER COLUMN `attribution_model` SET TAGS ('dbx_business_glossary_term' = 'Attribution Model Type');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ALTER COLUMN `attribution_weight` SET TAGS ('dbx_business_glossary_term' = 'Attribution Weight Percentage');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ALTER COLUMN `campaign_role` SET TAGS ('dbx_business_glossary_term' = 'Campaign Role in Buyer Journey');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ALTER COLUMN `touch_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Touch Date');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ALTER COLUMN `touch_sequence` SET TAGS ('dbx_business_glossary_term' = 'Touch Sequence Number');
ALTER TABLE `real_estate_ecm`.`transaction`.`sale_attribution` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Creator');
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` SET TAGS ('dbx_subdomain' = 'sale_execution');
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ALTER COLUMN `auction_id` SET TAGS ('dbx_business_glossary_term' = 'Auction Identifier');
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ALTER COLUMN `prior_auction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ALTER COLUMN `reserve_price_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ALTER COLUMN `venue_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ALTER COLUMN `venue_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ALTER COLUMN `venue_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ALTER COLUMN `venue_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ALTER COLUMN `venue_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ALTER COLUMN `venue_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`auction` ALTER COLUMN `venue_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `real_estate_ecm`.`transaction`.`bulk_sale_pool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `real_estate_ecm`.`transaction`.`bulk_sale_pool` SET TAGS ('dbx_subdomain' = 'sale_execution');
ALTER TABLE `real_estate_ecm`.`transaction`.`bulk_sale_pool` ALTER COLUMN `bulk_sale_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Bulk Sale Pool Identifier');
ALTER TABLE `real_estate_ecm`.`transaction`.`bulk_sale_pool` ALTER COLUMN `parent_bulk_sale_pool_id` SET TAGS ('dbx_self_ref_fk' = 'true');
